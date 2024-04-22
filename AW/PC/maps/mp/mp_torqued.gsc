/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_torqued.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 74
 * Decompile Time: 1419 ms
 * Timestamp: 4/22/2024 2:18:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::torqued_callbackstartgametype;
	maps\mp\mp_torqued_precache::main();
	maps\createart\mp_torqued_art::main();
	maps\mp\mp_torqued_fx::main();
	torqued_set_lighting_state_patched(1,0);
	maps\mp\_load::main();
	maps\mp\mp_torqued_lighting::main();
	maps\mp\mp_torqued_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_torqued");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	if(level.nextgen || isdedicatedserver() && getdvar("g_gametype") != "ball")
	{
		thread torqued_avalanche_setup();
	}
	else
	{
		thread torqued_avalanche_disable();
	}

	maps\mp\_water::init();
	level.ospvisionset = "mp_torqued_osp";
	level.osplightset = "mp_torqued_osp";
	level.warbirdvisionset = "mp_torqued_osp";
	level.warbirdlightset = "mp_torqued_osp";
	level.vulcanvisionset = "mp_torqued_osp";
	level.vulcanlightset = "mp_torqued_osp";
	level.skip_bot_node_checks = 1;
	common_scripts\utility::flag_init("event_fatal_damage");
	precacherumble("tank_rumble");
	precacherumble("damage_light");
	precacheshellshock("default");
	if(level.nextgen)
	{
		precachempanim("trq_gondola_car_swing_01");
		precachempanim("trq_gondola_car_swing_02");
		precachempanim("trq_gondola_car_swing_03");
		precachempanim("trq_gondola_car_swinghard_01");
		precachempanim("trq_avalanche_pine_tree01");
		precachempanim("trq_avalanche_pine_tree02");
	}

	precachempanim("trq_hanglights_02_swing_calm_light00");
	precachempanim("trq_hanglights_02_swing_calm_light01");
	precachempanim("trq_hanglights_02_swing_calm_light02");
	precachempanim("trq_hanglights_02_swing_calm_light03");
	precachempanim("trq_hanglights_02_swing_calm_light04");
	precachempanim("trq_hanglights_02_swing_calm_light05");
	precachempanim("trq_hanglights_02_swing_calm_light06");
	precachempanim("trq_hanglights_02_swing_hard_light00");
	precachempanim("trq_hanglights_02_swing_hard_light01");
	precachempanim("trq_hanglights_02_swing_hard_light02");
	precachempanim("trq_hanglights_02_swing_hard_light03");
	precachempanim("trq_hanglights_02_swing_hard_light04");
	precachempanim("trq_hanglights_02_swing_hard_light05");
	precachempanim("trq_hanglights_02_swing_hard_light06");
	precachempanim("trq_hanglights_03_swing_calm_light00");
	precachempanim("trq_hanglights_03_swing_calm_light01");
	precachempanim("trq_hanglights_03_swing_calm_light02");
	precachempanim("trq_hanglights_03_swing_calm_light03");
	precachempanim("trq_hanglights_03_swing_hard_light00");
	precachempanim("trq_hanglights_03_swing_hard_light01");
	precachempanim("trq_hanglights_03_swing_hard_light02");
	precachempanim("trq_hanglights_03_swing_hard_light03");
	precachempanim("trq_hanglights_04_swing_calm_light00");
	precachempanim("trq_hanglights_04_swing_calm_light01");
	precachempanim("trq_hanglights_04_swing_calm_light02");
	precachempanim("trq_hanglights_04_swing_calm_light03");
	precachempanim("trq_hanglights_04_swing_calm_light04");
	precachempanim("trq_hanglights_04_swing_calm_light05");
	precachempanim("trq_hanglights_04_swing_hard_light00");
	precachempanim("trq_hanglights_04_swing_hard_light01");
	precachempanim("trq_hanglights_04_swing_hard_light02");
	precachempanim("trq_hanglights_04_swing_hard_light03");
	precachempanim("trq_hanglights_04_swing_hard_light04");
	precachempanim("trq_hanglights_04_swing_hard_light05");
	level.orbitalsupportoverridefunc = ::torquedpaladinoverrides;
	thread torquedairstrieoverrides();
	thread scriptpatchclip();
	thread scriptkilltrigger();
	thread movewarbirdspawn();
	if(level.nextgen)
	{
		thread merry_go_round_setup();
		thread gondola_anims();
		thread tree_anims();
	}
	else
	{
		if(isdedicatedserver())
		{
			thread merry_go_round_setup();
		}
		else
		{
			thread merry_go_round_disable();
		}

		thread gondola_anims_disable();
		thread tree_anims_disable();
	}

	thread christmas_light_anims();
	thread event_path_swap();
	thread event_bcs_trigger_swap();
	thread scorestreak_blockers();
	if(level.currentgen)
	{
		level.prevragdollstartvalue = getdvar("r_ragdollStartHeight");
		setdvar("r_ragdollStartHeight",600);
		thread setcgragdolldvar(level.prevragdollstartvalue);
	}
}

//Function Number: 2
scriptkilltrigger()
{
	thread spawnkilltriggerthink((-876,-2008,641.379),128,128);
}

//Function Number: 3
spawnkilltriggerthink(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = spawn("trigger_radius",param_00,0,param_01,param_02);
	if(!isdefined(var_03))
	{
		return;
	}

	for(;;)
	{
		var_03 waittill("trigger",var_04);
		if(isdefined(var_04) && isdefined(var_04.health))
		{
			if(isplayer(var_04) || isbot(var_04))
			{
				var_04 dodamage(var_04.health + 999,var_03.origin);
			}
		}
	}
}

//Function Number: 4
movewarbirdspawn()
{
	var_00 = (2372,612,2164);
	var_01 = (2152,634,2164);
	var_02 = getentarray("script_origin","classname");
	foreach(var_04 in var_02)
	{
		var_05 = distance(var_04.origin,var_00);
		if(var_05 <= 5)
		{
			var_04.origin = var_01;
			break;
		}
	}
}

//Function Number: 5
torqued_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 6
scorestreak_blockers()
{
	wait 0.05;
	if(!isdefined(level.goliath_bad_landing_volumes))
	{
		level.goliath_bad_landing_volumes = [];
	}

	level.goliath_bad_landing_volumes = getentarray("no_streak_goliath","targetname");
	level.drop_pod_bad_places = getentarray("drop_pod_bad_place","targetname");
	foreach(var_01 in level.drop_pod_bad_places)
	{
		level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_01;
	}
}

//Function Number: 7
christmas_light_anims()
{
	var_00 = getent("anim_node_christmas_lights","targetname");
	var_01 = getentarray("lights_02","targetname");
	var_02 = getentarray("lights_03","targetname");
	var_03 = getentarray("lights_04","targetname");
	var_04 = [];
	var_04 = common_scripts\utility::array_combine(var_04,var_01);
	var_04 = common_scripts\utility::array_combine(var_04,var_02);
	var_04 = common_scripts\utility::array_combine(var_04,var_03);
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	foreach(var_09 in var_01)
	{
		var_0A = "trq_hanglights_02_swing_calm_light0" + var_05;
		var_09 scriptmodelplayanimdeltamotionfrompos(var_0A,var_00.origin,var_00.angles);
		var_05++;
		wait(0.15);
	}

	foreach(var_09 in var_02)
	{
		var_0A = "trq_hanglights_03_swing_calm_light0" + var_06;
		var_09 scriptmodelplayanimdeltamotionfrompos(var_0A,var_00.origin,var_00.angles);
		var_06++;
		wait(0.15);
	}

	foreach(var_09 in var_03)
	{
		var_0A = "trq_hanglights_04_swing_calm_light0" + var_07;
		var_09 scriptmodelplayanimdeltamotionfrompos(var_0A,var_00.origin,var_00.angles);
		var_07++;
		wait(0.15);
	}

	level waittill("avalanche_start");
	foreach(var_09 in var_04)
	{
		var_09 scriptmodelclearanim();
		wait 0.05;
	}

	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	foreach(var_09 in var_01)
	{
		var_0A = "trq_hanglights_02_swing_hard_light0" + var_05;
		var_09 scriptmodelplayanimdeltamotionfrompos(var_0A,var_00.origin,var_00.angles);
		var_05++;
		wait(0.15);
	}

	foreach(var_09 in var_02)
	{
		var_0A = "trq_hanglights_03_swing_hard_light0" + var_06;
		var_09 scriptmodelplayanimdeltamotionfrompos(var_0A,var_00.origin,var_00.angles);
		var_06++;
		wait(0.15);
	}

	foreach(var_09 in var_03)
	{
		var_0A = "trq_hanglights_04_swing_hard_light0" + var_07;
		var_09 scriptmodelplayanimdeltamotionfrompos(var_0A,var_00.origin,var_00.angles);
		var_07++;
		wait(0.15);
	}

	level waittill("avalanche_stop");
	foreach(var_09 in var_04)
	{
		var_09 scriptmodelclearanim();
		wait 0.05;
		var_09 delete();
	}
}

//Function Number: 8
tree_anims_disable()
{
	var_00 = getentarray("tree_ent_01","targetname");
	var_01 = getentarray("tree_ent_02","targetname");
	foreach(var_03 in var_00)
	{
		var_03 setstatic();
	}

	foreach(var_03 in var_01)
	{
		var_03 setstatic();
	}
}

//Function Number: 9
tree_anims()
{
	var_00 = getentarray("tree_ent_01","targetname");
	var_01 = getentarray("tree_ent_02","targetname");
	var_02 = [];
	foreach(var_04 in var_00)
	{
		var_04.anim_event = "trq_avalanche_pine_tree01";
	}

	foreach(var_04 in var_01)
	{
		var_04.anim_event = "trq_avalanche_pine_tree02";
	}

	var_02 = common_scripts\utility::array_combine(var_02,var_00);
	var_02 = common_scripts\utility::array_combine(var_02,var_01);
	level waittill("avalanche_start");
	foreach(var_04 in var_02)
	{
		wait(0.15);
		var_04 scriptmodelplayanim(var_04.anim_event);
	}
}

//Function Number: 10
gondola_anims_disable()
{
	var_00 = getentarray("gondola_swing","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setstatic();
	}
}

//Function Number: 11
gondola_anims()
{
	var_00 = getentarray("gondola_swing","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread swinggondola();
	}
}

//Function Number: 12
swinggondola()
{
	var_00 = ["trq_gondola_car_swing_01","trq_gondola_car_swing_02","trq_gondola_car_swing_03"];
	wait(randomfloat(2.5));
	var_01 = randomint(3);
	self scriptmodelplayanim(var_00[var_01]);
}

//Function Number: 13
setup_audio()
{
}

//Function Number: 14
torqued_avalanche_setup()
{
	precacherumble("tank_rumble");
	precacherumble("damage_light");
	precacheshellshock("default");
	level.snowparticle01 = loadfx("fx/snow/snow_light_outdoor");
	level.snowexplosiondebris01 = loadfx("vfx/test/test_snow_impact_large01_runner");
	level.snowgustdebris01 = loadfx("fx/snow/snow_clifftop_jet_blow_runner");
	level.snowpuffmedium01 = loadfx("vfx/test/test_snow_puff_medium01_runner");
	level.snowflakesswirl01 = loadfx("fx/snow/radar_windy_snow");
	level.snowmistlarge01 = loadfx("fx/snow/snow_blizzard_radar");
	level.dynamicspawns = ::getlistofgoodspawnpoints;
	if(!isdefined(level.dyneventavalanche))
	{
		level.dyneventavalanche = spawnstruct();
	}

	level.dyneventavalanche.debugmode = 0;
	level.dyneventavalanche.avalanchephase1time = 4;
	level.dyneventavalanche.avalanchephase2time = 3;
	level.dyneventavalanche.avalanchephase3time = 4;
	level.dyneventavalanche.meshmovetime = undefined;
	level.dyneventavalanche.mesh1moveunits = 184;
	level.dyneventavalanche.mesh2moveunits = 128;
	level.dyneventavalanche.killgraceperiod = 5;
	level.dyneventavalanche.status = "pre_avalanche";
	level.dyneventavalanche.snowexplosionarray = common_scripts\utility::getstructarray("avalanche_explosion01","targetname");
	level.dyneventavalanche.snowdebrisarray = common_scripts\utility::getstructarray("avalanche_debris_gust01","targetname");
	level.dyneventavalanche.snowpuffmediumarray = common_scripts\utility::getstructarray("avalanche_street_medium_puff01","targetname");
	level.dyneventavalanche.snowflakesswirlarray = common_scripts\utility::getstructarray("avalanche_flakes01","targetname");
	level.dyneventavalanche.snowmistlargearray = common_scripts\utility::getstructarray("avalanche_mist_large01","targetname");
	level.dyneventavalanche.quakearray = common_scripts\utility::getstructarray("rumble_quake01","targetname");
	level.dyneventavalanche.killvolumearray = getentarray("quake_kill_volume01","targetname");
	level.dyneventavalanche.quakesmallarray = common_scripts\utility::getstructarray("rumble_quake_small01","targetname");
	level.dyneventavalanche.snowmesh01 = getent("snow_ground01","targetname");
	level.dyneventavalanche.snowmesh02 = getent("snow_ground02","targetname");
	level.dyneventavalanche.preeventscriptables = getscriptablearray("pre_event_scriptable","targetname");
	level.dyneventavalanche.posteventscriptables = getscriptablearray("post_event_scriptable","targetname");
	level.dyneventavalanche.preeventdynents = getentarray("pre_event_dynent","targetname");
	level.dyneventavalanche.posteventdynents = getentarray("post_event_dynent","targetname");
	level.dyneventavalanche.soundlocations = common_scripts\utility::getstructarray("avalanche_sound01","targetname");
	level thread maps\mp\_dynamic_events::dynamicevent(::torqued_avalanche_start,::torqued_avalanche_reset,::torqued_avalanche_end);
	thread hidepostdestructibles();
}

//Function Number: 15
torqued_avalanche_disable()
{
	var_00 = getentarray("quake_kill_volume01","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_02 = getent("snow_ground01","targetname");
	if(isdefined(var_02))
	{
		var_02 setstatic();
	}

	var_02 = getent("snow_ground02","targetname");
	if(isdefined(var_02))
	{
		var_02 setstatic();
	}

	var_00 = getscriptablearray("pre_event_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setstatic();
	}

	var_00 = getentarray("pre_event_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.model != "trq_giant_holiday_tree_01" && var_02.model != "trq_giant_holiday_tree_02" && var_02.model != "trq_wooden_door_01" && var_02.model != "rec_safehouse_door_wood_cgdlc1" && var_02.model != "greece_cafepastrydisplay_01")
		{
			var_02 setstatic();
		}
	}

	var_00 = getentarray("pre_event_dynent","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setstatic();
	}

	var_00 = getscriptablearray("post_event_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_00 = getentarray("post_event_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_00 = getentarray("post_event_dynent","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 16
getlistofgoodspawnpoints(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.targetname) || var_03.targetname == "" || var_03.targetname == "none")
		{
			var_01 = common_scripts\utility::add_to_array(var_01,var_03);
			continue;
		}

		if(var_03 getavalanchespawns() == 1)
		{
			var_01 = common_scripts\utility::add_to_array(var_01,var_03);
		}
	}

	return var_01;
}

//Function Number: 17
getavalanchespawns()
{
	if(level.dyneventavalanche.status == "pre_avalanche")
	{
		if(self.targetname != "spawner_post_avalanche")
		{
			return 1;
		}
	}
	else if(level.dyneventavalanche.status == "post_avalanche")
	{
		if(self.targetname != "spawner_pre_avalanche")
		{
			return 1;
		}
	}
	else if(level.dyneventavalanche.status == "during_avalanche")
	{
	}

	return 0;
}

//Function Number: 18
hidepostdestructibles()
{
	foreach(var_01 in level.dyneventavalanche.posteventscriptables)
	{
		var_01 setscriptablepartstate("root_part","hidden_state");
	}

	foreach(var_04 in level.dyneventavalanche.posteventdynents)
	{
		var_04 hide();
	}
}

//Function Number: 19
swapdestructibles()
{
	foreach(var_01 in level.dyneventavalanche.preeventscriptables)
	{
		var_01 setscriptablepartstate("root_part","hidden_state");
	}

	foreach(var_04 in level.dyneventavalanche.preeventdynents)
	{
		var_04 hide();
	}

	foreach(var_01 in level.dyneventavalanche.posteventscriptables)
	{
		var_01 setscriptablepartstate("root_part","intact_state_01");
	}

	foreach(var_04 in level.dyneventavalanche.posteventdynents)
	{
		var_04 show();
	}
}

//Function Number: 20
scriptablelightstatechange()
{
	var_00 = getscriptablearray("destroy_light","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate(0,1);
		wait(5);
		var_02 setscriptablepartstate(0,3);
	}

	var_04 = getscriptablearray("damaged_light","targetname");
	foreach(var_06 in var_04)
	{
		var_06 setscriptablepartstate(0,1);
	}

	var_08 = getscriptablearray("damaged_light_2","targetname");
	foreach(var_0A in var_08)
	{
		var_0A setscriptablepartstate(0,1);
	}

	var_0C = getscriptablearray("light_fixture_damaged","targetname");
	foreach(var_0E in var_0C)
	{
		var_0E setscriptablepartstate(0,1);
	}
}

//Function Number: 21
dropavalanchespawnpointstonewground()
{
	if(isdefined(level.spawnpoints))
	{
		foreach(var_01 in level.spawnpoints)
		{
			if(isdefined(var_01.targetname))
			{
				var_01.droptoground = 1;
			}
		}
	}
}

//Function Number: 22
movemeshafterstart(param_00)
{
	self.origin = self.origin + (0,0,param_00 * -1);
}

//Function Number: 23
torqued_show_solid()
{
	if(isdefined(self.oldcontents))
	{
		self setcontents(self.oldcontents);
	}

	if(isdefined(self.lightingstate) && self.lightingstate == 2)
	{
		if(isdefined(self.original_origin))
		{
			self dontinterpolate();
			self.origin = self.original_origin;
		}
	}

	self show();
}

//Function Number: 24
torqued_hide_notsolid()
{
	if(!isdefined(self.oldcontents))
	{
		self.oldcontents = self setcontents(0);
		self dontinterpolate();
		self.original_origin = self.origin;
		self.origin = self.origin + (0,0,-2000);
	}

	self hide();
}

//Function Number: 25
torqued_set_lighting_state_patched(param_00,param_01)
{
	var_02 = getentarray();
	setomnvar("lighting_state",param_00);
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		foreach(var_04 in var_02)
		{
			if(isdefined(var_04.lightingstate) && var_04.classname == "script_brushmodel" || var_04.classname == "script_model")
			{
				if(var_04.lightingstate == 0)
				{
					continue;
				}

				if(var_04.lightingstate == param_00)
				{
					var_04 torqued_show_solid();
					var_04 allowriotshieldplant();
					continue;
				}

				if(isdefined(param_01) && param_01)
				{
					var_04 hide();
					var_04 thread delaydelete(0.1);
					continue;
				}

				var_04 torqued_hide_notsolid();
			}
		}
	}
}

//Function Number: 26
delaydelete(param_00)
{
	wait(param_00);
	self delete();
}

//Function Number: 27
torqued_avalanche_start()
{
	level.dyneventavalanche.status = "during_avalanche";
	level notify("avalanche_start");
	thread aud_avalanche_setup();
	thread startquakerumble(level.dyneventavalanche.quakearray,level.dyneventavalanche.quakesmallarray);
	thread avalanchesound(level.dyneventavalanche.soundlocations);
	thread maps\mp\mp_torqued_fx::window_swap_fx();
	thread maps\mp\mp_torqued_fx::avalanche_fx();
	thread maps\mp\mp_torqued_fx::avalanche_impact_fx();
	thread maps\mp\mp_torqued_fx::coffee_window_back_shatter();
	thread maps\mp\mp_torqued_fx::coffee_window_front_shatter();
	thread maps\mp\mp_torqued_fx::trq_window_front_shatter();
	thread maps\mp\mp_torqued_fx::boardstore_window_back_shatter();
	thread maps\mp\mp_torqued_fx::boardstore_window_front_shatter();
	thread maps\mp\mp_torqued_fx::lodge_window_front_shatter();
	thread scriptablelightstatechange();
	thread maps\mp\mp_torqued_fx::roof_falling_snow_chunk_fx();
	thread maps\mp\mp_torqued_fx::snow_edge_runoff_fx();
	thread maps\mp\mp_torqued_fx::snow_edge_runoff_stop_fx();
	wait(level.dyneventavalanche.avalanchephase1time);
	level notify("rumble_stop");
	wait(0.05);
	thread rumbleoutro(level.dyneventavalanche.quakearray);
	wait(level.dyneventavalanche.killgraceperiod);
	thread killvolumethink(level.dyneventavalanche.killvolumearray);
	thread maps\mp\mp_torqued_fx::avalanche_treeline_impact_fx();
	thread maps\mp\mp_torqued_fx::alley_snow_fx();
	level.dyneventavalanche.meshmovetime = level.dyneventavalanche.avalanchephase2time;
	wait(level.dyneventavalanche.avalanchephase2time + 2);
	foreach(var_01 in level.dyneventavalanche.killvolumearray)
	{
		var_01 thread killobjectsundersnow();
		var_01 thread resetspectatorsundersnow();
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		level.hordeavalanche = 1;
		level hordeavalanchekilleverything(level.dyneventavalanche.killvolumearray);
	}

	common_scripts\utility::flag_set("event_fatal_damage");
	if(level.currentgen)
	{
		thread avalanchescreenfade();
	}

	wait(1);
	level notify("avalanche_stop");
	level notify("rumble_stop");
	wait(0.05);
	thread maps\mp\mp_torqued_fx::avalanche_hide_geo_fx();
	torqued_set_lighting_state_patched(2,1);
	swapdestructibles();
	thread rumbleoutro(level.dyneventavalanche.quakearray);
	thread avalanchesound(level.dyneventavalanche.soundlocations);
	thread maps\mp\mp_torqued_fx::electrical_spark_fx();
	thread maps\mp\mp_torqued_fx::avalanche_snow_linger_fx();
	wait(level.dyneventavalanche.avalanchephase3time);
	foreach(var_01 in level.dyneventavalanche.killvolumearray)
	{
		var_01 thread killobjectsundersnow();
		var_01 thread resetspectatorsundersnow();
	}

	level notify("avalanche_stop");
	level notify("rumble_stop");
	level.dyneventavalanche.status = "post_avalanche";
	dropavalanchespawnpointstonewground();
	level notify("avalanche_over");
}

//Function Number: 28
avalanchescreenfade()
{
	var_00 = getentarray("avalanche_screen_fade_zone","targetname");
	var_01 = common_scripts\utility::getstructarray("avalanche_screen_fade_lospoint","targetname");
	foreach(var_03 in level.players)
	{
		var_04 = 0;
		foreach(var_06 in var_00)
		{
			if(var_03 istouching(var_06))
			{
				var_04 = 1;
				break;
			}
		}

		if(var_04)
		{
			var_08 = 0;
			var_09 = var_03 getvieworigin();
			var_0A = anglestoforward(var_03 getplayerangles());
			foreach(var_0C in var_01)
			{
				var_0D = var_0C.origin - var_09;
				if(vectordot(var_0D,var_0A) >= 0.5 && bullettracepassed(var_09,var_0C.origin,0,undefined))
				{
					var_08 = 1;
					break;
				}
			}

			if(var_08)
			{
				var_03 playersetexpfog(0,350,0.363177,0.458081,0.54287,9,0.8,1);
				var_03 thread avalanchescreenfade_shellshock(0.75);
			}
		}
	}

	wait(2.25);
	clearfog(1.5);
}

//Function Number: 29
avalanchescreenfade_shellshock(param_00)
{
	self endon("death");
	wait(param_00);
	self shellshock("stun_grenade_mp",2,1,0,0);
}

//Function Number: 30
avalanchesound(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 thread playavalanchesound();
	}
}

//Function Number: 31
playavalanchesound()
{
	level endon("avalanche_stop");
	wait(randomfloatrange(0.1,0.3));
	for(;;)
	{
		maps\mp\_utility::playsoundinspace("mp_torqued_avalanche01",self.origin);
		wait(randomfloatrange(1.5,2.5));
	}
}

//Function Number: 32
movesnowmesh(param_00,param_01)
{
	self movez(param_01 * 0.5,param_00 * 0.25);
	self waittill("movedone");
	self movez(param_01 * 0.5,param_00 * 0.75);
	self waittill("movedone");
}

//Function Number: 33
hordeavalanchekilleverything(param_00)
{
	var_01 = getentarray("trigger_hurt","classname");
	var_02 = var_01[0];
	foreach(var_04 in param_00)
	{
		foreach(var_06 in level.players)
		{
			if(isdefined(var_06.turret) && !var_06.iscarrying && isdefined(var_06.turret.damagetaken) && var_06.turret.damagetaken < var_06.turret.maxhealth)
			{
				if(var_06.turret istouching(var_04))
				{
					hordeavalanchekillobject(var_06.turret,var_02);
				}
			}

			if(isdefined(var_06.aerialassaultdrone))
			{
				if(var_06.aerialassaultdrone istouching(var_04))
				{
					var_06.aerialassaultdrone dodamage(10000,var_06.aerialassaultdrone.origin,var_06,var_06,"MOD_EXPLOSIVE","killstreak_emp_mp");
				}
			}
		}

		foreach(var_09 in level.participants)
		{
			if(var_09 istouching(var_04))
			{
				hordeavalanchekillobject(var_09,var_02);
			}
		}

		foreach(var_0C in level.flying_attack_drones)
		{
			if(var_0C istouching(var_04))
			{
				hordeavalanchekillobject(var_0C,var_02);
			}
		}

		foreach(var_0F in level.hordesentryarray)
		{
			if(var_0F istouching(var_04))
			{
				hordeavalanchekillobject(var_0F,var_02);
			}
		}

		if(isdefined(level.carepackages))
		{
			foreach(var_12 in level.carepackages)
			{
				if(ispointinvolume(var_12.origin,var_04))
				{
					if(var_12.cratetype == "juggernaut")
					{
						var_12 maps\mp\killstreaks\_juggernaut::deletegoliathpod();
					}
					else if(!isdefined(var_12.en_route_in_air) || !var_12.en_route_in_air)
					{
						var_12 maps\mp\killstreaks\_airdrop::deletecrate();
					}

					level.carepackages = common_scripts\utility::array_remove(level.carepackages,var_12);
				}
			}
		}
	}
}

//Function Number: 34
hordeavalanchekillobject(param_00,param_01)
{
	param_00 dodamage(10000,param_00.origin,param_01,param_01,"MOD_TRIGGER_HURT","none");
}

//Function Number: 35
killvolumethink(param_00)
{
	level endon("avalanche_stop");
	for(;;)
	{
		if(!isdefined(level.players))
		{
			wait(1);
			continue;
		}

		foreach(var_02 in param_00)
		{
			var_02 thread volumekill();
		}

		break;
	}
}

//Function Number: 36
volumekill()
{
	level endon("avalanche_stop");
	var_00 = 5;
	var_01 = 0;
	for(;;)
	{
		if(var_01 >= 4)
		{
			var_00 = 10;
		}

		foreach(var_03 in level.participants)
		{
			if(var_03 istouching(self))
			{
				var_03 dodamage(var_00,var_03.origin);
				if(isplayer(var_03))
				{
					var_03 shellshock("default",2);
				}

				if(common_scripts\utility::flag("event_fatal_damage"))
				{
					var_03 dodamage(10000,var_03.origin);
				}
			}
		}

		var_01++;
		wait(0.6);
	}
}

//Function Number: 37
phaseoneavalancheparticles(param_00,param_01,param_02)
{
	foreach(var_04 in param_01)
	{
		var_04 thread particlethink(level.snowgustdebris01);
	}

	if(isdefined(param_00))
	{
		foreach(var_04 in param_00)
		{
			var_04 thread particlethink(level.snowexplosiondebris01);
		}
	}

	foreach(var_04 in param_02)
	{
		var_04 thread particlethink(level.snowflakesswirl01);
	}
}

//Function Number: 38
phasetwoavalancheparticles(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		var_03 thread particlethink(level.snowmistlarge01);
	}

	wait(3);
	foreach(var_03 in param_01)
	{
		var_03 thread particlethink(level.snowpuffmedium01);
	}
}

//Function Number: 39
particlethink(param_00)
{
	var_01 = spawnfx(param_00,self.origin);
	var_01.angles = self.angles;
	triggerfx(var_01);
	level waittill("avalanche_stop");
	var_01 delete();
}

//Function Number: 40
rumbleoutro(param_00)
{
	var_01 = 768;
	var_02 = "tank_rumble";
	var_03 = 0.2;
	foreach(var_05 in level.players)
	{
		var_05 thread quake_outro_for_player(param_00);
	}

	thread onplayerconnect(var_02);
	thread rumblewatch();
}

//Function Number: 41
startquakerumble(param_00,param_01)
{
	var_02 = "tank_rumble";
	var_03 = "damage_light";
	foreach(var_05 in level.players)
	{
		var_05 thread quake_for_player(param_00,param_01);
		var_05 playrumblelooponentity(var_03);
		var_05 thread onplayerspawned(var_03);
	}

	thread onplayerconnect(var_02);
	thread rumblewatch();
}

//Function Number: 42
quake_outro_for_player(param_00)
{
	level endon("avalanche_stop");
	self endon("disconnect");
	var_01 = 1100;
	var_02 = "tank_rumble";
	var_03 = 0.2;
	for(;;)
	{
		while(!isalive(self))
		{
			wait(0.2);
		}

		var_04 = randomfloatrange(1,1.7);
		play_closest_quake(param_00,var_03,var_04,var_01,var_02);
		wait(var_04 - 0.2);
	}
}

//Function Number: 43
quake_for_player(param_00,param_01)
{
	level endon("avalanche_stop");
	self endon("disconnect");
	var_02 = 1100;
	var_03 = 1100;
	var_04 = "tank_rumble";
	var_05 = 0.5;
	var_06 = 0.2;
	for(;;)
	{
		while(!isalive(self))
		{
			wait(0.2);
		}

		var_07 = 0;
		var_08 = randomfloatrange(1,1.7);
		var_07 = play_closest_quake(param_00,var_05,var_08,var_02,var_04);
		if(!var_07)
		{
			play_closest_quake(param_01,var_06,var_08,var_03,undefined);
		}

		wait(var_08 - 0.2);
	}
}

//Function Number: 44
play_closest_quake(param_00,param_01,param_02,param_03,param_04)
{
	foreach(var_06 in param_00)
	{
		if(distancesquared(var_06.origin,self.origin) < param_03 * param_03)
		{
			earthquake(param_01,param_02,var_06.origin,param_03,self);
			if(isdefined(param_04))
			{
				playrumblelooponposition(param_04,var_06.origin);
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 45
rumblewatch()
{
	level notify("RumbleWatchEnd");
	level endon("RumbleWatchEnd");
	level waittill("rumble_stop");
	stopallrumbles();
}

//Function Number: 46
onplayerconnect(param_00)
{
	level notify("onPlayerConnectEnd");
	level endon("onPlayerConnectEnd");
	level endon("rumble_stop");
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread onplayerspawned(param_00);
	}
}

//Function Number: 47
onplayerspawned(param_00)
{
	level endon("rumble_stop");
	for(;;)
	{
		self waittill("spawned_player");
		self playrumblelooponentity(param_00);
		wait(0.05);
	}
}

//Function Number: 48
torqued_avalanche_reset()
{
}

//Function Number: 49
torqued_avalanche_end()
{
	thread scriptablelightstatechange();
	torqued_set_lighting_state_patched(2,1);
	swapdestructibles();
	level notify("avalanche_stop");
	level.dyneventavalanche.status = "post_avalanche";
	dropavalanchespawnpointstonewground();
	level notify("avalanche_over");
}

//Function Number: 50
torqued_playfxontag(param_00)
{
	if(isdefined(level.players))
	{
		foreach(var_02 in level.players)
		{
			playfxontagforclients(level._effect[param_00],self,"TAG_FX_1",var_02);
		}
	}
}

//Function Number: 51
torqued_floor()
{
	var_00 = getent("trq_rockslide_floor","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = 0.2;
	var_02 = 40;
	var_00 rotateroll(var_02,var_01);
	wait(var_01);
	var_00 notsolid();
	var_00 hide();
	level waittill("rocks_reset");
	var_00 solid();
	var_00 show();
	var_00 rotateroll(-1 * var_02,0.1);
}

//Function Number: 52
torquedpaladinoverrides()
{
	level.orbitalsupportoverrides.spawnanglemin = 30;
	level.orbitalsupportoverrides.spawnanglemax = 120;
	level.orbitalsupportoverrides.spawnheight = 7000;
	level.orbitalsupportoverrides.spawnradius = 5000;
	level.orbitalsupportoverrides.leftarc = 30;
	level.orbitalsupportoverrides.rightarc = 30;
	level.orbitalsupportoverrides.toparc = -32;
	level.orbitalsupportoverrides.bottomarc = 67;
}

//Function Number: 53
torquedairstrieoverrides()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 2000;
}

//Function Number: 54
merry_go_round_disable()
{
	var_00 = getent("merry_go_round_platform","targetname");
	var_01 = getent("merry_go_round_model","targetname");
	var_02 = getentarray("merry_go_round_cover","targetname");
	var_03 = getentarray("merry_go_round_reindeer","targetname");
	foreach(var_05 in var_02)
	{
	}

	foreach(var_05 in var_03)
	{
	}
}

//Function Number: 55
merry_go_round_setup()
{
	level endon("game_ended");
	var_00 = getent("merry_go_round_platform","targetname");
	var_01 = getentarray("merry_go_round_cover","targetname");
	var_02 = getentarray("merry_go_round_reindeer","targetname");
	var_03 = getent("merry_go_round_model","targetname");
	var_04 = 10;
	foreach(var_06 in var_01)
	{
		var_06 linkto(var_00);
	}

	foreach(var_06 in var_02)
	{
		var_06 linkto(var_00);
	}

	var_03 linkto(var_00);
	for(;;)
	{
		var_00 rotatevelocity((0,-10,0),var_04);
		wait(var_04);
	}
}

//Function Number: 56
event_path_swap()
{
	wait 0.05;
	var_00 = getnodearray("path_event_before","targetname");
	var_01 = getnodearray("path_event_after","targetname");
	foreach(var_03 in var_01)
	{
		var_03 disconnectnode();
		wait 0.05;
	}

	foreach(var_03 in var_00)
	{
		var_03 connectnode();
		wait 0.05;
	}

	level waittill("avalanche_stop");
	foreach(var_03 in var_01)
	{
		var_03 connectnode();
		wait 0.05;
	}
}

//Function Number: 57
event_bcs_trigger_swap()
{
	var_00 = getentarray("before_event_bcs","targetname");
	var_01 = getentarray("after_event_bcs","targetname");
	foreach(var_03 in var_01)
	{
		var_03 common_scripts\utility::trigger_off();
	}

	level waittill("avalanche_stop");
	foreach(var_03 in var_00)
	{
		var_03 common_scripts\utility::trigger_off();
	}

	foreach(var_03 in var_01)
	{
		var_03 common_scripts\utility::trigger_on();
	}
}

//Function Number: 58
killobjectsundersnow()
{
	level endon("game_ended");
	level endon("avalanche_stop");
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
				if(isdefined(var_04) && !isremovedentity(var_04) && ispointinvolume(var_04.origin,self))
				{
					if(isdefined(var_04.cratetype) && var_04.cratetype != "juggernaut")
					{
						if(!isdefined(var_04.en_route_in_air) || !var_04.en_route_in_air)
						{
							var_04 maps\mp\killstreaks\_airdrop::deletecrate(1,1);
						}

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

//Function Number: 59
resetspectatorsundersnow()
{
	level endon("game_ended");
	level endon("avalanche_stop");
	var_00 = getent("mp_global_intermission","classname");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02.team) && var_02.team == "spectator" && ispointinvolume(var_02.origin,self))
			{
				var_02 spawn(var_00.origin,var_00.angles);
			}
		}

		wait(0.05);
	}
}

//Function Number: 60
aud_avalanche_setup()
{
	thread aud_avalance_alarm();
	thread maps\mp\_audio::snd_play_in_space("mp_torqued_ty_initial_hit",(532,2030,1881));
	var_00 = thread maps\mp\_audio::snd_play_loop_in_space("mp_torqued_rumble_lp",(532,2030,1881),"aud_avalanche_stop");
	var_01 = thread maps\mp\_audio::snd_play_in_space("mp_torqued_avalance_main",(532,2030,1881));
	var_02 = thread maps\mp\_audio::snd_play_in_space("mp_torqued_avalanche_bg",(532,2030,1881));
	var_00 scalevolume(0,0.05);
	var_01 scalevolume(0,0.05);
	var_02 scalevolume(0,0.05);
	wait(0.05);
	var_00 scalevolume(0.8,10);
	var_01 scalevolume(0.8,5);
	var_02 scalevolume(0.8,5);
	level waittill("avalanche_stop");
	thread maps\mp\_audio::snd_play_in_space("mp_torqued_avalanche_wall_crash_01",(532,2030,1881));
	thread maps\mp\_audio::snd_play_in_space("mp_torqued_avalanche_rockslide_02",(532,2030,1881));
	level notify("aud_avalanche_stop");
}

//Function Number: 61
aud_avalance_alarm()
{
	var_00 = 2;
	thread maps\mp\_audio::snd_play_in_space("mp_torqued_avalance_alarm",(0,0,0));
	wait(var_00);
	thread maps\mp\_audio::snd_play_in_space("mp_torqued_avalance_alarm",(0,0,0));
	wait(var_00);
	thread maps\mp\_audio::snd_play_in_space("mp_torqued_avalance_alarm",(0,0,0));
	wait(var_00);
	thread maps\mp\_audio::snd_play_in_space("mp_torqued_avalance_alarm",(0,0,0));
	wait(var_00);
	thread maps\mp\_audio::snd_play_in_space("mp_torqued_avalance_alarm",(0,0,0));
}

//Function Number: 62
scriptpatchclip()
{
	thread nosightclipwall();
	thread vehicleclipdoors();
	thread addpropforbadtreeclip();
	thread playerclipoverhang();
	thread playerclipsnowguard();
	thread playerweirdjitteravalanchearea();
	thread recondronepushplayersthroughwall();
	thread cornercollisionspawngifts();
	thread tourismofficejumpthroughwall();
	if(level.nextgen)
	{
		thread treetipstuck_makeskypillar();
	}
}

//Function Number: 63
treetipstuck_makeskypillar()
{
	var_00 = 1231;
	for(var_01 = 0;var_01 < 128;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-987,1495,var_00),(0,0,0));
		var_00 = var_00 + 32;
	}
}

//Function Number: 64
tourismofficejumpthroughwall()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1311,-1075,1016),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1311,-1203,1016),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-1319,-1038,968),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-1319,-1070,968),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-1319,-1102,968),(0,0,0));
}

//Function Number: 65
cornercollisionspawngifts()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-1449.26,-527.981,908),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-1449.26,-527.981,868),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-1436.74,-518.019,868),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-1436.74,-518.019,908),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(-1449.26,-527.981,908),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(-1449.26,-527.981,868),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(-1436.74,-518.019,868),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(-1436.74,-518.019,908),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_64_64",(-1449.26,-527.981,908),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_64_64",(-1449.26,-527.981,868),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_64_64",(-1436.74,-518.019,868),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_64_64",(-1436.74,-518.019,908),(0,38.4979,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-1444.13,-534.904,956.81),(0,38.4979,26.2994));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-1431.03,-524.403,956.814),(0,38.4979,26.2994));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-1432.14,-549.74,1021.44),(0,38.4979,26.2994));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-1419.04,-539.239,1021.43),(0,38.4979,26.2994));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(-1444.13,-534.904,956.81),(0,38.4979,26.2994));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(-1431.03,-524.403,956.814),(0,38.4979,26.2994));
	spawngift("trq_holiday_gift_boxes_01_snow_red",(-1452,-512,834),(0,37.9999,0));
	spawngift("trq_holiday_gift_boxes_01_snow",(-1449,-515,870),(360,37.9998,-3.80005));
	spawngift("trq_holiday_gift_boxes_01_snow_red",(-1449,-515,905),(360,37.9998,-3.80005));
	if(level.nextgen)
	{
		spawngift("trq_holiday_gift_boxes_sm_02_red_snow",(-1449.43,-526.952,942.026),(0,37,0));
		spawngift("trq_holiday_gift_boxes_sm_02_red_snow",(-1449.4,-527,956),(0,37,0));
		spawngift("trq_holiday_gift_boxes_sm_02_blue_snow",(-1447.4,-507,942),(0,217.3,0));
		return;
	}

	spawngift("trq_holiday_gift_boxes_sm_02",(-1449.43,-526.952,942.026),(0,37,0));
	spawngift("trq_holiday_gift_boxes_sm_02",(-1449.4,-527,956),(0,37,0));
	spawngift("trq_holiday_gift_boxes_sm_02",(-1447.4,-507,942),(0,217.3,0));
}

//Function Number: 66
spawngift(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_01);
	var_03.angles = param_02;
	var_03 setmodel(param_00);
}

//Function Number: 67
recondronepushplayersthroughwall()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1051,-1496,724),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1051,-1591,724),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-931,-1567,746),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-931,-1520,746),(0,180,0));
}

//Function Number: 68
playerweirdjitteravalanchearea()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-336,742,1014),(90,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-336,998,1014),(90,0,0));
}

//Function Number: 69
nosightclipwall()
{
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(-1082,-534,932),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(-1210,-534,932),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(-1338,-534,932),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_128_128",(-1082,-534,932),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_128_128",(-1210,-534,932),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_128_128",(-1338,-534,932),(0,270,0));
}

//Function Number: 70
vehicleclipdoors()
{
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(963,482,986),(0,299.2,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(-2078,572,960),(0,351,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(-2118,319,960),(0,351,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_128_128",(980,498,1044),(0,300,0));
}

//Function Number: 71
addpropforbadtreeclip()
{
	var_00 = spawn("script_model",(-594,547,1061));
	var_00 setmodel("trq_holiday_gift_boxes_01_snow_red");
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_32_32_32",(-594,549,1077),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_64_64",(-604,533,1064),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_64_64",(-585,533,1064),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_item_16_64_64",(-595,533,1064),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-594,549,1077),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_32_32_32",(-594,549,1077),(0,0,0));
}

//Function Number: 72
playerclipoverhang()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1460,-658,1312),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1460,-882,1312),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1288,-520,1308),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1092,-518,1308),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1348,-518,1308),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1468,-638,1308),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1468,-894,1308),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-560,440,1400),(0,45,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-640,440,1400),(0,135,0));
}

//Function Number: 73
playerclipsnowguard()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(112,-901,1316),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(132,-820,1348),(0,315.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(132,-820,1284),(0,315.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(181,-799,1348),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(181,-799,1284),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1056,-520,1388),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1056,-520,1644),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1312,-520,1388),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1312,-520,1644),(0,270,0));
}

//Function Number: 74
setcgragdolldvar(param_00)
{
	level waittill("game_ended");
	setdvar("r_ragdollStartHeight",param_00);
}