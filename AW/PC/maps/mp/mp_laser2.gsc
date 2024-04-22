/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_laser2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 70
 * Decompile Time: 1121 ms
 * Timestamp: 4/22/2024 2:17:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_laser2_precache::main();
	maps\createart\mp_laser2_art::main();
	maps\mp\mp_laser2_fx::main();
	thread aud_init();
	maps\mp\_load::main();
	maps\mp\mp_laser2_lighting::main();
	maps\mp\mp_laser2_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_laser2");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.aerial_pathnode_offset = 450;
	thread set_lighting_values();
	thread set_umbra_values();
	level.ospvisionset = "mp_laser2_osp";
	if(level.nextgen == 1)
	{
		level thread rotateradar();
	}

	level.ospvisionset = "mp_laser2_osp";
	level.osplightset = "mp_laser2_streak";
	level.mapcustomkillstreakfunc = ::laser2customkillstreakfunc;
	level.orbitalsupportoverridefunc = ::laser2customospfunc;
	level.orbitallaseroverridefunc = ::laser2customorbitallaserfunc;
	thread laser2customairstrike();
	level.anim_laserbuoy = "laser_buoy_loop";
	level.waterline_offset = 2;
	maps\mp\_water::setshallowwaterweapon("iw5_underwater_mp");
	level thread maps\mp\_water::init();
	precacherumble("damage_light");
	level dynamicevent_init_sound();
	level dynamicevent_init();
	level thread maps\mp\_dynamic_events::dynamicevent(::handlemovingwater,undefined,::handleendwater);
	level.alarmsystem = spawnstruct();
	level.alarmsystem.spinnerarray = getentarray("horizonal_spinner","targetname");
	foreach(var_01 in level.alarmsystem.spinnerarray)
	{
		var_01 hide();
	}

	level thread handleclouds();
	thread spawnsetup();
}

//Function Number: 2
dynamicevent_init_sound()
{
	level.tsunami_alarm = "mp_laser2_typhoon_alarm";
	level.tsunami_vo_int = "mp_laser2_vo_tsunami_warning_int";
	level.tsunami_vo_ext = "mp_laser2_vo_tsunami_warning_ext";
}

//Function Number: 3
laser2customkillstreakfunc()
{
	level.killstreakweildweapons["mp_laser2_core"] = 1;
	level thread maps\mp\killstreaks\streak_mp_laser2::init();
}

//Function Number: 4
laser2customospfunc()
{
	level.orbitalsupportoverrides.spawnanglemin = 30;
	level.orbitalsupportoverrides.spawnanglemax = 90;
	level.orbitalsupportoverrides.spawnheight = 9541;
	if(level.currentgen)
	{
		level.orbitalsupportoverrides.leftarc = 20;
		level.orbitalsupportoverrides.rightarc = 20;
		level.orbitalsupportoverrides.toparc = -30;
		level.orbitalsupportoverrides.bottomarc = 60;
	}
}

//Function Number: 5
laser2customorbitallaserfunc()
{
	level.orbitallaseroverrides.spawnheight = 3300;
}

//Function Number: 6
laser2customairstrike()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 1750;
}

//Function Number: 7
set_lighting_values()
{
	if(isusinghdr())
	{
		for(;;)
		{
			level waittill("connected",var_00);
			var_00 setclientdvars("r_tonemap","2");
		}
	}
}

//Function Number: 8
set_umbra_values()
{
	setdvar("r_umbraAccurateOcclusionThreshold",256);
}

//Function Number: 9
handleclouds()
{
	var_00 = 122;
	activatepersistentclientexploder(var_00);
	level thread handlecloudsaerialjoin();
	level thread handlecloudsaerialleave();
}

//Function Number: 10
enablecloudsexploder(param_00)
{
	var_01 = 122;
	var_02 = 0;
	var_03 = [];
	if(isdefined(param_00))
	{
		var_02 = 1;
		var_03[var_03.size] = param_00;
		if(isdefined(param_00.disablecloudscount))
		{
			param_00.disablecloudscount--;
			if(param_00.disablecloudscount <= 0)
			{
				param_00.disablecloudscount = 0;
			}
		}
	}
	else
	{
		foreach(var_05 in level.players)
		{
			if(isdefined(var_05.disablecloudscount))
			{
				var_05.disablecloudscount--;
				if(var_05.disablecloudscount > 0)
				{
					var_02 = 1;
				}
				else
				{
					var_05.disablecloudscount = 0;
				}

				var_03[var_03.size] = var_05;
			}
		}
	}

	if(var_02)
	{
		activatepersistentclientexploder(var_01,var_03);
		return;
	}

	activatepersistentclientexploder(var_01);
}

//Function Number: 11
disablecloudsexploder(param_00,param_01)
{
	var_02 = 122;
	var_03 = [];
	level thread common_scripts\_exploder::deactivate_clientside_exploder(var_02,param_00,param_01);
	if(isdefined(param_00))
	{
		var_03[var_03.size] = param_00;
	}
	else
	{
		var_03 = level.players;
	}

	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.disablecloudscount))
		{
			var_05.disablecloudscount++;
			continue;
		}

		var_05.disablecloudscount = 1;
	}
}

//Function Number: 12
handlecloudsaerialjoin()
{
	for(;;)
	{
		level waittill("player_start_aerial_view",var_00);
		level disablecloudsexploder(var_00,1);
	}
}

//Function Number: 13
handlecloudsaerialleave()
{
	for(;;)
	{
		level waittill("player_stop_aerial_view",var_00);
		level enablecloudsexploder(var_00);
	}
}

//Function Number: 14
rotateradar()
{
	wait(0.05);
	var_00 = getent("radar_dish01_rotate","targetname");
	maps\mp\_audio::scriptmodelplayanimwithnotify(var_00,"lsr_radar_dish_loop","ps_emt_satellite_dish_rotate","emt_satellite_dish_rotate","laser2_custom_end_notify","laser2_custom_ent_end_notify","laser2_custom_ent2_end_notify");
}

//Function Number: 15
handlepropattachments(param_00)
{
	if(isdefined(self.target))
	{
		var_01 = getentarray(self.target,"targetname");
		foreach(var_03 in var_01)
		{
			if(isdefined(param_00))
			{
				var_03 vehicle_jetbikesethoverforcescale(param_00);
				continue;
			}

			var_03 vehicle_jetbikesethoverforcescale(self);
		}
	}
}

//Function Number: 16
dynamicevent_init()
{
	level endon("game_ended");
	level.water_warning = undefined;
	level.ocean = undefined;
	var_00 = getentarray("ocean_water","targetname");
	if(isdefined(var_00))
	{
		level.ocean = var_00[0];
		if(var_00.size > 0)
		{
			level.ocean_pieces = common_scripts\utility::array_remove(var_00,level.ocean);
			common_scripts\utility::array_thread(level.ocean_pieces,::linktoent,level.ocean);
		}
	}

	level.ocean.warning_time = 30;
	level.ocean.origin = level.ocean.origin - (0,0,132);
	var_01 = getent("ocean_water_underside","targetname");
	var_02 = getentarray("trigger_underwater","targetname");
	var_03 = getentarray("ocean_moving_prop","targetname");
	var_04 = getentarray("buoy","targetname");
	var_05 = [];
	level.moving_buoys = [];
	var_06 = getentarray("water_clip","targetname");
	level.post_event_geo = getentarray("post_event_geo","targetname");
	level.end_state_geo = getentarray("end_state_geo","targetname");
	level.post_event_nodes = getnodearray("post_event_node","targetname");
	level.pre_event_nodes = getnodearray("pre_event_node","targetname");
	level.goliath_bad_landing_volumes = getentarray("goliath_bad_landing_volume","targetname");
	level.drop_pod_bad_places = getentarray("drop_pod_bad_place","targetname");
	level.post_event_pathing_blockers = getentarray("post_event_pathing_blocker","targetname");
	level.pre_event_pathing_blockers = getentarray("pre_event_pathing_blocker","targetname");
	level handle_event_geo_off();
	level thread handle_pathing_pre_event();
	foreach(var_08 in var_03)
	{
		if(isdefined(var_08.script_noteworthy) && var_08.script_noteworthy == "has_collision")
		{
			var_05[var_05.size] = var_08;
		}
	}

	foreach(var_0B in var_04)
	{
		if(isdefined(var_0B.script_noteworthy) && var_0B.script_noteworthy == "moving")
		{
			level.moving_buoys[level.moving_buoys.size] = var_0B;
		}
	}

	var_0D = common_scripts\utility::array_combine(var_03,level.moving_buoys);
	thread maps\mp\mp_laser2_fx::setupwaves(level.ocean);
	thread maps\mp\mp_laser2_fx::setupoceanfoam(level.ocean);
	if(isdefined(level.waterline_ents))
	{
		common_scripts\utility::array_thread(level.waterline_ents,::linktoent,level.ocean);
	}

	if(level.nextgen)
	{
		var_01 linktoent(level.ocean);
	}

	if(isdefined(var_06) && var_06.size > 0)
	{
		common_scripts\utility::array_thread(var_06,::linktoent,level.ocean);
	}

	if(isdefined(var_0D) && var_0D.size > 0)
	{
		common_scripts\utility::array_thread(var_0D,::linktoent,level.ocean);
	}

	if(isdefined(var_02) && var_02.size > 0 && isdefined(level.ocean))
	{
		foreach(var_0F in var_02)
		{
			var_0F thread handlewatertriggermovement(level.ocean);
		}
	}

	if(isdefined(level.goliath_bad_landing_volumes) && level.goliath_bad_landing_volumes.size > 0 && isdefined(level.ocean))
	{
		foreach(var_0F in level.goliath_bad_landing_volumes)
		{
			if(isdefined(var_0F.script_noteworthy) && var_0F.script_noteworthy == "dont_move_me")
			{
				continue;
			}
			else
			{
				var_0F thread handlewatertriggermovement(level.ocean);
			}
		}
	}

	if(isdefined(var_05) && var_05.size > 0)
	{
		common_scripts\utility::array_thread(var_05,::handlepropattachments,level.ocean);
	}

	if(isdefined(var_04) && var_04.size > 0)
	{
		common_scripts\utility::array_thread(var_04,::playbuoylights);
	}

	if(isdefined(level.moving_buoys) && level.moving_buoys.size > 0)
	{
		common_scripts\utility::array_thread(level.moving_buoys,::playpropanim,level.anim_laserbuoy);
		common_scripts\utility::array_thread(level.moving_buoys,::handlepropattachments,level.ocean);
	}

	var_13 = getent("tidal_wave","targetname");
	var_13 hide();
	common_scripts\utility::trigger_off("trig_kill_00","targetname");
	common_scripts\utility::trigger_off("trig_kill_01","targetname");
	common_scripts\utility::trigger_off("trig_kill_02","targetname");
	common_scripts\utility::trigger_off("trig_kill_03","targetname");
	common_scripts\utility::trigger_off("trig_kill_04","targetname");
	common_scripts\utility::trigger_off("trig_kill_drone_vista","targetname");
	maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_00","targetname");
	maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_01","targetname");
	maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_02","targetname");
	maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_03","targetname");
	maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_04","targetname");
	maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig("trig_kill_drone_vista","targetname");
	thread maps\mp\mp_laser2_fx::playwaves("end_initial_waves",4,6,"breaking_wave_01");
	level setoceansinvalueslowtide();
}

//Function Number: 17
connect_paths()
{
	if(isdefined(self))
	{
		self connectpaths();
	}
}

//Function Number: 18
disconnect_paths()
{
	if(isdefined(self))
	{
		self disconnectpaths();
	}
}

//Function Number: 19
connect_nodes()
{
	if(isdefined(self))
	{
		self connectnode();
	}
}

//Function Number: 20
disconnect_nodes()
{
	if(isdefined(self))
	{
		self disconnectnode();
	}
}

//Function Number: 21
hidegeo()
{
	if(isdefined(self) && !isdefined(self.ishidden))
	{
		self.ishidden = 1;
		common_scripts\utility::trigger_off();
	}
}

//Function Number: 22
showgeo()
{
	if(isdefined(self) && isdefined(self.ishidden))
	{
		self.ishidden = undefined;
		common_scripts\utility::trigger_on();
	}
}

//Function Number: 23
oceansinmovement(param_00)
{
	level endon("game_ended");
	level endon("end_initial_waves");
	self notify("ocean_sin_movement");
	self endon("ocean_sin_movement");
	for(;;)
	{
		self moveto((0,level.oceansinamplitude,level.oceansinamplitude) + param_00,level.oceansinperiod / 2,level.oceansinperiod * 0.25,level.oceansinperiod * 0.25);
		wait(level.oceansinperiod / 2);
		self moveto(-1 * (0,level.oceansinamplitude,level.oceansinamplitude) + param_00,level.oceansinperiod / 2,level.oceansinperiod * 0.25,level.oceansinperiod * 0.25);
		wait(level.oceansinperiod / 2);
	}
}

//Function Number: 24
setoceansinvalueslowtide()
{
	if(level.nextgen)
	{
		level.oceansinamplitude = 12;
		level.oceansinperiod = 10;
		return;
	}

	level.oceansinamplitude = 16;
	level.oceansinperiod = 20;
}

//Function Number: 25
setoceansinvalueshightide()
{
	level.oceansinamplitude = 6;
	level.oceansinperiod = 10;
}

//Function Number: 26
linktoent(param_00)
{
	var_01 = self;
	var_01 vehicle_jetbikesethoverforcescale(param_00);
}

//Function Number: 27
handlebuoydings(param_00,param_01)
{
	level endon("game_ended");
	for(;;)
	{
		wait(randomfloatrange(0.05,0.5));
		while(!isdefined(level.water_warning) || level.water_warning != 1)
		{
			maps\mp\_utility::play_sound_on_tag(param_01,"tag_origin");
			wait(randomfloatrange(3,7));
		}

		while(level.water_warning == 1)
		{
			maps\mp\_utility::play_sound_on_tag(param_00,"tag_origin");
			wait(randomfloatrange(1.5,4.5));
		}
	}
}

//Function Number: 28
playbuoylights()
{
	self notify("stop_buoy_lights");
	self endon("stop_buoy_lights");
	playfxontag(common_scripts\utility::getfx("light_buoy_red"),self,"fx_joint_0");
	wait(randomfloat(4));
	stopfxontag(common_scripts\utility::getfx("light_buoy_red"),self,"fx_joint_0");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("light_buoy_red"),self,"fx_joint_0");
}

//Function Number: 29
playpropanim(param_00)
{
	wait(randomfloatrange(0.1,1));
	self scriptmodelplayanim(param_00);
}

//Function Number: 30
oceanmover_init(param_00)
{
	level endon("game_ended");
	var_01 = getent(param_00,"targetname");
	if(!isdefined(var_01))
	{
		return undefined;
	}

	var_01.warning_time = 30;
	return var_01;
}

//Function Number: 31
oceanobjectmover_init(param_00)
{
	var_01 = spawn("script_origin",(0,0,0));
	var_01.targetname = "OceanObjectMover";
	var_01.dist_prop = (0,352,0);
	return var_01;
}

//Function Number: 32
moving_water_init()
{
	level endon("game_ended");
	thread maps\mp\mp_laser2_fx::playwaves("end_initial_waves",4,6,"breaking_wave_01");
}

//Function Number: 33
handleendwater()
{
	level.ocean.origin = level.ocean.origin + (0,0,72);
	level notify("end_initial_waves");
	thread maps\mp\mp_laser2_fx::playwaves(undefined,6,8,"breaking_wave_01");
	level thread common_scripts\_exploder::activate_clientside_exploder(201);
	level thread common_scripts\_exploder::activate_clientside_exploder(202);
	level thread common_scripts\_exploder::activate_clientside_exploder(203);
	level thread common_scripts\_exploder::activate_clientside_exploder(204);
	level thread common_scripts\_exploder::activate_clientside_exploder(205);
	level thread common_scripts\_exploder::activate_clientside_exploder(206);
	level thread common_scripts\_exploder::activate_clientside_exploder(207);
	level thread common_scripts\_exploder::activate_clientside_exploder(208);
	level thread common_scripts\_exploder::activate_clientside_exploder(209);
	level thread common_scripts\_exploder::activate_clientside_exploder(121);
	if(isdefined(level.end_state_geo))
	{
		common_scripts\utility::array_thread(level.end_state_geo,::showgeo);
	}

	level handle_event_geo_on();
	level maps\mp\_utility::delaythread(0.05,::handle_pathing_post_event);
}

//Function Number: 34
handlemovingwater()
{
	level endon("game_ended");
	level disablecloudsexploder(undefined,0);
	level.skipoceanspawns = 1;
	var_00 = level.ocean;
	var_01 = getent("tidal_wave","targetname");
	var_01 show();
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02.targetname = "ocean_tag_origin";
	var_02 show();
	var_03 = getent("lsr_tidal_wave_car","targetname");
	var_04 = getent("lsr_tidal_wave_shipping_container_closed","targetname");
	var_05 = getent("lsr_tidal_wave_shipping_container_open","targetname");
	create_bot_badplaces();
	foreach(var_07 in level.water_triggers)
	{
		var_07 thread killobjectsunderwater();
	}

	level thread addposteventgeotocratebadplacearray();
	level thread killplayersusingremotestreaks();
	wait(0.05);
	level.water_warning = 1;
	level notify("end_initial_waves");
	thread maps\mp\mp_laser2_aud::start_rough_tide();
	var_09 = 2;
	earthquake(0.3,var_09,(0,0,0),5000);
	thread aud_dynamic_event_startup(var_09);
	thread play_earthquake_rumble_for_all_players(0.75);
	level maps\mp\_utility::delaythread(3,::handletsunamiwarningsounds);
	var_0A = 26.667;
	var_0B = 36.7;
	var_0C = var_0B;
	if(var_0A > var_0B)
	{
		var_0C = var_0A;
	}

	if(var_00.warning_time > var_0C)
	{
		wait(var_00.warning_time - var_0C);
	}
	else
	{
		wait(2);
	}

	var_01 thread tidal_wave_notetracks();
	var_01 scriptmodelplayanimdeltamotion("lsr_tidal_wave_mesh_anim","tidal_wave_notetrack");
	var_00 linkto(var_02);
	var_02 scriptmodelplayanimdeltamotion("lsr_tidal_wave_ocean_anim");
	if(isdefined(var_03))
	{
		var_03 scriptmodelplayanimdeltamotion("lsr_tidal_wave_car");
	}

	var_04 scriptmodelplayanimdeltamotion("lsr_tidal_wave_shipping_container_closed");
	var_05 scriptmodelplayanimdeltamotion("lsr_tidal_wave_shipping_container_open");
	foreach(var_0E in level.moving_buoys)
	{
		if(isdefined(var_0E.animation))
		{
			var_0E scriptmodelclearanim();
			var_0E unlink();
			var_0E scriptmodelplayanimdeltamotion(var_0E.animation);
			var_0E thread playbuoylights();
			var_0E maps\mp\_utility::delaythread(var_0B,::buoys_return_to_bobbing);
		}
	}

	level maps\mp\_utility::delaythread(var_0A - 3,::stop_water_warning);
	level maps\mp\_utility::delaythread(var_0A - 2.9,::play_earthquake_rumble_for_all_players,0.75);
	var_01 common_scripts\utility::delaycall(var_0A,::hide);
	var_02 common_scripts\utility::delaycall(var_0B,::hide);
	var_00 common_scripts\utility::delaycall(var_0B,::unlink);
	wait(var_0C);
	var_10 = getnodearray("water_nodes","targetname");
	foreach(var_12 in var_10)
	{
		nodesetnotusable(var_12,1);
	}

	delete_bot_badplaces();
	level.skipoceanspawns = 0;
	wait(2);
	thread maps\mp\mp_laser2_fx::playwaves(undefined,6,8,"breaking_wave_01");
	level notify("dynamic_event_complete");
}

//Function Number: 35
create_bot_badplaces()
{
	badplace_cylinder("badplace_1",-1,(-1096,-688,229.5),300,200);
	badplace_cylinder("badplace_2",-1,(-544,-1104,158),500,200);
	badplace_cylinder("badplace_3",-1,(0,-1024,154.286),500,200);
	badplace_cylinder("badplace_4",-1,(608,-1152,153.195),500,200);
	badplace_cylinder("badplace_5",-1,(1360,-832,203.4),500,200);
	badplace_cylinder("badplace_6",-1,(2128,-416,159.325),500,200);
	badplace_cylinder("badplace_7",-1,(2464,176,128),500,200);
}

//Function Number: 36
delete_bot_badplaces()
{
	badplace_delete("badplace_1");
	badplace_delete("badplace_2");
	badplace_delete("badplace_3");
	badplace_delete("badplace_4");
	badplace_delete("badplace_5");
	badplace_delete("badplace_6");
	badplace_delete("badplace_7");
}

//Function Number: 37
killobjectsunderwater()
{
	level endon("game_ended");
	level endon("dynamic_event_complete");
	for(;;)
	{
		if(isdefined(level.turrets))
		{
			foreach(var_01 in level.turrets)
			{
				if(var_01 istouching(self))
				{
					var_01 notify("death");
				}
			}
		}

		if(isdefined(level.carepackages))
		{
			foreach(var_04 in level.carepackages)
			{
				if(isdefined(var_04) && !isremovedentity(var_04) && var_04 iscarepackageinposteventgeo())
				{
					if(isdefined(var_04.cratetype) && var_04.cratetype != "juggernaut")
					{
						var_04 maps\mp\killstreaks\_airdrop::deletecrate(1,1);
						continue;
					}

					if(isdefined(var_04.cratetype) && var_04.cratetype == "juggernaut")
					{
						var_04 maps\mp\killstreaks\_juggernaut::deletegoliathpod(1,1);
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 38
iscarepackageinposteventgeo()
{
	if(isdefined(level.drop_pod_bad_places))
	{
		foreach(var_01 in level.drop_pod_bad_places)
		{
			if(ispointinvolume(self.origin,var_01))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 39
addposteventgeotocratebadplacearray()
{
	level waittill("post_event_geo_on");
	foreach(var_01 in level.drop_pod_bad_places)
	{
		level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_01;
	}
}

//Function Number: 40
killplayersusingremotestreaks()
{
	level endon("game_ended");
	level endon("dynamic_event_complete");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(isdefined(var_01) && isdefined(var_01.inwater) && var_01 maps\mp\_utility::isusingremote())
			{
				var_01 maps\mp\_utility::_suicide();
			}
		}

		wait(0.05);
	}
}

//Function Number: 41
buoys_return_to_bobbing()
{
	linktoent(level.ocean);
	self scriptmodelclearanim();
	wait(randomfloatrange(0.1,1));
	self scriptmodelplayanim(level.anim_laserbuoy);
	thread playbuoylights();
}

//Function Number: 42
play_earthquake_rumble_for_all_players(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 thread play_earthquake_rumble(param_00);
	}
}

//Function Number: 43
play_earthquake_rumble(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(var_01 = param_00 * 20;var_01 >= 0;var_01 = var_01 - 2)
	{
		self playrumbleonentity("damage_light");
		wait(0.1);
	}
}

//Function Number: 44
stop_water_warning()
{
	level.water_warning = 0;
	common_scripts\utility::array_thread(level.alarmsystem.spinnerarray,::spinalarmsstop);
}

//Function Number: 45
tidal_wave_notetracks()
{
	thread event_fx();
	thread event_killtriggers();
	thread event_geo();
}

//Function Number: 46
event_fx()
{
	self waittillmatch("vfx_wave_mist_start","tidal_wave_notetrack");
	thread maps\mp\mp_laser2_fx::start_wave_mist_fx();
	self waittillmatch("vfx_receding_foam_start","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(120);
	level thread common_scripts\_exploder::activate_clientside_exploder(100);
	self waittillmatch("vfx_rocks1_splash","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(101);
	level thread common_scripts\_exploder::activate_clientside_exploder(201);
	thread maps\mp\mp_laser2_fx::playoceanfoam("tidal_wave_lingering_foam1",0);
	self waittillmatch("vfx_tower_splash","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(102);
	level thread common_scripts\_exploder::activate_clientside_exploder(202);
	thread maps\mp\mp_laser2_fx::playoceanfoam("tidal_wave_lingering_foam1",1);
	self waittillmatch("vfx_concrete_chunk1_splash","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(103);
	level thread common_scripts\_exploder::activate_clientside_exploder(203);
	thread maps\mp\mp_laser2_fx::playoceanfoam("tidal_wave_lingering_foam1",2);
	thread maps\mp\mp_laser2_fx::stop_wave_mist_fx();
	self waittillmatch("vfx_wave_collapse1_splash","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(104);
	level thread common_scripts\_exploder::activate_clientside_exploder(204);
	thread maps\mp\mp_laser2_fx::playoceanfoam("tidal_wave_lingering_foam1",3);
	self waittillmatch("vfx_wave_collapse2_splash","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(105);
	level thread common_scripts\_exploder::activate_clientside_exploder(205);
	thread maps\mp\mp_laser2_fx::playoceanfoam("tidal_wave_lingering_foam1",4);
	self waittillmatch("vfx_wave_collapse3_splash","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(106);
	level thread common_scripts\_exploder::activate_clientside_exploder(206);
	thread maps\mp\mp_laser2_fx::playoceanfoam("tidal_wave_lingering_foam1",5);
	self waittillmatch("vfx_midbeach_splash","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(107);
	level thread common_scripts\_exploder::activate_clientside_exploder(207);
	thread maps\mp\mp_laser2_fx::playoceanfoam("tidal_wave_lingering_foam1",6);
	self waittillmatch("vfx_helipad_splash","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(108);
	level thread common_scripts\_exploder::activate_clientside_exploder(208);
	thread maps\mp\mp_laser2_fx::playoceanfoam("tidal_wave_lingering_foam1",7);
	self waittillmatch("vfx_helipad_splash2","tidal_wave_notetrack");
	level thread common_scripts\_exploder::activate_clientside_exploder(109);
	level thread common_scripts\_exploder::activate_clientside_exploder(209);
	thread maps\mp\mp_laser2_fx::playoceanfoam("tidal_wave_lingering_foam1",8);
	wait(1);
	level thread common_scripts\_exploder::activate_clientside_exploder(121);
	level enablecloudsexploder();
}

//Function Number: 47
event_killtriggers()
{
	common_scripts\utility::trigger_on("trig_kill_drone_vista","targetname");
	self waittillmatch("kill_trig_00","tidal_wave_notetrack");
	common_scripts\utility::trigger_off("trig_kill_drone_vista","targetname");
	common_scripts\utility::trigger_on("trig_kill_00","targetname");
	self waittillmatch("kill_trig_01","tidal_wave_notetrack");
	common_scripts\utility::trigger_off("trig_kill_00","targetname");
	common_scripts\utility::trigger_on("trig_kill_01","targetname");
	self waittillmatch("kill_trig_02","tidal_wave_notetrack");
	common_scripts\utility::trigger_off("trig_kill_01","targetname");
	common_scripts\utility::trigger_on("trig_kill_02","targetname");
	self waittillmatch("kill_trig_03","tidal_wave_notetrack");
	common_scripts\utility::trigger_off("trig_kill_02","targetname");
	common_scripts\utility::trigger_on("trig_kill_03","targetname");
	self waittillmatch("kill_trig_04","tidal_wave_notetrack");
	common_scripts\utility::trigger_off("trig_kill_03","targetname");
	common_scripts\utility::trigger_on("trig_kill_04","targetname");
	maps\mp\_utility::delaythread(1,::common_scripts\utility::trigger_off,"trig_kill_04","targetname");
}

//Function Number: 48
event_geo()
{
	self waittillmatch("kill_trig_04","tidal_wave_notetrack");
	level handle_event_geo_on();
	level handle_pathing_post_event();
}

//Function Number: 49
handle_event_geo_on()
{
	if(isdefined(level.post_event_geo))
	{
		foreach(var_01 in level.post_event_geo)
		{
			var_01 showgeo();
		}

		level notify("post_event_geo_on");
	}

	if(isdefined(level.drop_pod_bad_places))
	{
		foreach(var_04 in level.drop_pod_bad_places)
		{
			var_04 showgeo();
		}
	}
}

//Function Number: 50
handle_event_geo_off()
{
	if(isdefined(level.post_event_geo))
	{
		foreach(var_01 in level.post_event_geo)
		{
			var_01 hidegeo();
		}

		level notify("post_event_geo_off");
	}

	if(isdefined(level.drop_pod_bad_places))
	{
		foreach(var_04 in level.drop_pod_bad_places)
		{
			var_04 hidegeo();
		}
	}

	if(isdefined(level.end_state_geo))
	{
		common_scripts\utility::array_thread(level.end_state_geo,::hidegeo);
	}
}

//Function Number: 51
handle_pathing_pre_event()
{
	if(getdvar("scr_dynamic_event_state","on") != "endstate" && !isdefined(level.dynamiceventstype) || level.dynamiceventstype != 2)
	{
		wait(0.05);
	}

	foreach(var_01 in level.pre_event_pathing_blockers)
	{
		var_01 disconnect_paths();
		var_01 hidegeo();
	}

	foreach(var_01 in level.post_event_pathing_blockers)
	{
		var_01 hidegeo();
		var_01 connect_paths();
	}
}

//Function Number: 52
handle_pathing_post_event()
{
	if(isdefined(level.post_event_pathing_blockers))
	{
		foreach(var_01 in level.post_event_pathing_blockers)
		{
			var_01 showgeo();
			var_01 disconnect_paths();
			var_01 hidegeo();
		}
	}

	if(isdefined(level.pre_event_pathing_blockers))
	{
		common_scripts\utility::array_thread(level.pre_event_pathing_blockers,::connect_paths);
	}
}

//Function Number: 53
oceanobjectmover_set_goal(param_00)
{
	if(param_00.direction == "up" && 0)
	{
		self.goal = self.loc_start;
		return;
	}

	if(param_00.direction == "down" && 1)
	{
		self.goal = self.loc_start;
		return;
	}

	self.goal = self.loc_end;
}

//Function Number: 54
activate_splashes(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	if(isdefined(param_01))
	{
		level notify(param_01);
		level endon(param_01);
	}

	if(!isdefined(param_02))
	{
		param_02 = 3;
	}

	if(!isdefined(param_03))
	{
		param_03 = 5;
	}

	for(;;)
	{
		level thread common_scripts\_exploder::activate_clientside_exploder(param_00);
		wait(randomfloatrange(param_02,param_03));
	}
}

//Function Number: 55
handlewatertriggermovement(param_00)
{
	level endon("game_ended");
	var_01 = undefined;
	if(isdefined(self.target))
	{
		var_01 = common_scripts\utility::getstruct(self.target,"targetname");
	}

	var_02 = self.origin - param_00.origin;
	childthread movetrig(param_00,var_02);
	if(isdefined(var_01))
	{
		var_03 = var_01.origin[2] - self.origin[2];
		var_04 = var_02 + (0,0,var_03);
		var_01 childthread movetrig(param_00,var_04);
	}
}

//Function Number: 56
movetrig(param_00,param_01)
{
	for(;;)
	{
		self.origin = param_00.origin + param_01;
		wait(0.05);
	}
}

//Function Number: 57
spawnsetup()
{
	level.skipoceanspawns = 0;
	level.dynamicspawns = ::getlistofgoodspawnpoints;
}

//Function Number: 58
getlistofgoodspawnpoints(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.targetname) || var_03.targetname == "" || var_03 isvalidspawn() == 1)
		{
			var_01 = common_scripts\utility::add_to_array(var_01,var_03);
		}
	}

	return var_01;
}

//Function Number: 59
isvalidspawn()
{
	if(level.skipoceanspawns == 1 && self.targetname == "ocean_spawn")
	{
		return 0;
	}

	return 1;
}

//Function Number: 60
spinalarmsstart()
{
	self show();
	self rotatevelocity((0,600,0),12);
	var_00 = getscriptablearray("tsunami_alarm","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("static_part","siren_on");
	}
}

//Function Number: 61
spinalarmsstop()
{
	self hide();
	var_00 = getscriptablearray("tsunami_alarm","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("static_part","siren_off");
	}
}

//Function Number: 62
aud_init()
{
}

//Function Number: 63
aud_dynamic_event_startup(param_00)
{
	thread aud_handle_earthquake(param_00);
	thread aud_handle_warning_vo();
	thread aud_handle_wave_incoming();
	thread aud_handle_buoy_sfx();
}

//Function Number: 64
aud_handle_warning_vo()
{
	wait(2);
	thread maps\mp\_audio::snd_play_in_space("mp_laser2_vo_tsunami_warn_tide",(0,0,0));
	wait(5);
	thread maps\mp\_audio::snd_play_in_space("mp_laser2_vo_tsunami_warn_high_ground",(0,0,0));
}

//Function Number: 65
aud_handle_earthquake(param_00)
{
	thread maps\mp\_audio::snd_play_in_space("mp_laser2_ty_initial_hit",(0,0,0));
}

//Function Number: 66
aud_handle_buoy_sfx()
{
	level endon("aud_kill_dings");
	for(;;)
	{
		thread maps\mp\_audio::snd_play_in_space("mp_laser_buoy_ding_event",(150,-2295,403));
		wait(0.5);
		thread maps\mp\_audio::snd_play_in_space("mp_laser_buoy_ding_event",(1026,-2381,403));
		wait(6);
	}
}

//Function Number: 67
aud_handle_wave_incoming()
{
	var_00 = thread maps\mp\_audio::snd_play_loop_in_space("mp_laser2_ty_quake_lp",(79,-1591,455),"aud_dynamic_event_end");
	thread aud_handle_waves_crash();
	var_00 scalevolume(0,0.05);
	wait(16.5);
	thread aud_handle_incoming();
	var_00 scalevolume(0.8,8);
}

//Function Number: 68
aud_handle_incoming()
{
	thread maps\mp\_audio::snd_play_in_space("mp_laser2_ty_incoming",(79,-1591,455));
	wait(4);
	level notify("aud_kill_dings");
	earthquake(0.1,4,(79,-1591,455),2500);
	wait(1.2);
	earthquake(0.2,4,(79,-1591,455),2500);
	wait(2);
	earthquake(0.3,5.5,(79,-1591,455),2500);
}

//Function Number: 69
aud_handle_waves_crash()
{
	wait(27);
	level notify("aud_dynamic_event_end");
	level._snd.dynamic_event_happened = 1;
	foreach(var_01 in level.players)
	{
		var_01 clientclearsoundsubmix("mp_pre_event_mix");
		wait(0.05);
	}

	wait(0.05);
	foreach(var_01 in level.players)
	{
		var_01 clientaddsoundsubmix("mp_post_event_mix",1);
		wait(0.05);
	}
}

//Function Number: 70
handletsunamiwarningsounds()
{
	level endon("game_ended");
	var_00 = getentarray("tsunami_speaker","targetname");
	while(level.water_warning == 1)
	{
		if(isdefined(var_00))
		{
			foreach(var_02 in var_00)
			{
				playsoundatpos(var_02.origin,level.tsunami_alarm);
			}

			playsoundatpos((0,0,0),level.tsunami_alarm);
		}

		common_scripts\utility::array_thread(level.alarmsystem.spinnerarray,::spinalarmsstart);
		wait(2);
		if(!isdefined(level.water_warning) || level.water_warning != 1)
		{
			return;
		}

		foreach(var_02 in var_00)
		{
		}

		wait(3);
	}
}