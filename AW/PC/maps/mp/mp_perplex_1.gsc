/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_perplex_1.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 589 ms
 * Timestamp: 4/22/2024 2:18:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::perplex_callbackstartgametype;
	maps\mp\mp_perplex_1_precache::main();
	maps\createart\mp_perplex_1_art::main();
	maps\mp\mp_perplex_1_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_perplex_1_lighting::main();
	maps\mp\mp_perplex_1_aud::main();
	maps\mp\_water::init();
	maps\mp\_water::init();
	maps\mp\_compass::setupminimap("compass_map_mp_perplex_1");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	precachemodel("genericprop");
	if(level.nextgen)
	{
		precachempanim("per_ferry_boat");
		precachempanim("per_sail_boat");
		precachempanim("per_sail_boat_idle_a");
		precachempanim("per_sail_boat_idle_b");
		precachempanim("per_sail_boat_idle_c");
		precachempanim("per_sail_boat_idle_d");
		precachempanim("per_windmill_idle01");
		precachempanim("per_windmill_idle02");
		precachempanim("per_windmill_idle03");
		precachempanim("per_windmill_idle04");
	}

	level.goliath_bad_landing_volumes = [];
	if(level.nextgen)
	{
		thread vignetteferry();
		thread vignettesailboats();
	}

	thread vignetterooftopwindmills();
	thread perplexkillstreakoverrides();
	thread removecentermissilespawn();
	thread gamemodetraversalcheck();
	level dynamicevent_init();
	level thread maps\mp\_dynamic_events::dynamicevent(::dynamiceventsuspendedapartmentshiftanim,undefined,::dynamiceventsuspendedapartmentshiftanimend);
	level.osplightset = "mp_perplex_osp";
	level.warbirdlightset = "mp_perplex_osp";
	level.vulcanlightset = "mp_perplex_osp";
	if(level.currentgen)
	{
		thread cg_overridevulcanheight();
		thread cg_overridewarbirdheight();
	}

	thread clip_fixes();
	thread trigger_fixes();
}

//Function Number: 2
clip_fixes()
{
	thread boardwalkvehicleholefix();
	thread atriumdronepushholefix();
	thread modelapartmentstuckspotfix();
}

//Function Number: 3
boardwalkvehicleholefix()
{
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(-190,1376,-64),(270,180,180));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(66,1376,-64),(270,180,180));
}

//Function Number: 4
atriumdronepushholefix()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(552,473,192),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-488,273,192),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-416,-296,192),(0,90,0));
}

//Function Number: 5
trigger_fixes()
{
	thread goliathoutofmapfix();
}

//Function Number: 6
goliathoutofmapfix()
{
	level endon("game_ended");
	var_00 = spawn("trigger_radius",(0,0,-320),0,72,3072);
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isbot(var_01) || isagent(var_01))
		{
			var_01 dodamage(var_01.health + 999,var_00.origin);
		}
	}
}

//Function Number: 7
modelapartmentstuckspotfix()
{
	var_00 = 0;
	var_01 = 0;
	for(var_02 = 0;var_02 < 6;var_02++)
	{
		var_00 = 12 - var_02 * 10;
		var_01 = 1570 - var_02 * 16;
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(var_01,-1280,var_00),(0,0,0));
	}
}

//Function Number: 8
cg_overridevulcanheight()
{
	wait(1);
	if(!isdefined(level.orbitallaseroverrides))
	{
		level.orbitallaseroverrides = spawnstruct();
	}

	level.orbitallaseroverrides.spawnheight = 2352;
}

//Function Number: 9
cg_overridewarbirdheight()
{
	if(!isdefined(level.helianchor))
	{
		level waittill("reset_warbird_height");
	}

	wait(1);
	if(level.helianchor.origin[2] < 2352)
	{
		level.warbirdzoffset = 1328;
		return;
	}

	level.helianchor.origin[2] = 2352;
}

//Function Number: 10
removecentermissilespawn()
{
	var_00 = getent("auto613","target");
	var_01 = getent("auto613","targetname");
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 11
perplex_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 12
dynamicevent_init()
{
	level endon("game_ended");
	level thread handledynamiceventpathnodesforstate();
	level thread handledynamiceventcarepackagebadvol();
	level thread handledynamiceventobjectresettriggers();
	level.drone_top_origins = [];
	level.dynamiceventdrones = [];
	level.dynamiceventapartments = [];
	level.dynamiceventanimorg = getent("dynamic_event_animorg","targetname");
	level.building04 = dynamiceventsetupsuspendedapartment("dynamic_event_apartment_04","per_drone04_idle");
	level.building03 = dynamiceventsetupsuspendedapartment("dynamic_event_apartment_03","per_drone03_idle");
	level.building02 = dynamiceventsetupsuspendedapartment("dynamic_event_apartment_02","per_drone02_idle");
	level.building01 = dynamiceventsetupsuspendedapartment("dynamic_event_apartment_01","per_drone01_idle");
	level thread do_drone_top_damage();
	if(level.nextgen)
	{
		var_00 = getent("mp_recovery_signage","targetname");
		var_00 common_scripts\utility::hide_notsolid();
	}
}

//Function Number: 13
dynamiceventsetupsuspendedapartment(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		if(var_05.classname == "script_origin")
		{
			var_03 = var_05;
			break;
		}
	}

	foreach(var_05 in var_02)
	{
		if(var_05 != var_03)
		{
			var_05 vehicle_jetbikesethoverforcescale(var_03);
		}
	}

	var_09 = getent(param_00 + "_col","targetname");
	var_0A = getent(param_00 + "_drone","targetname");
	var_0B = getent(param_00 + "_drone_reset_trig","targetname");
	var_0C = getent(param_00 + "_drone_body_col","targetname");
	var_0D = getent(param_00 + "_drone_killorg","targetname");
	if(isdefined(level.drone_top_origins) && isdefined(var_0D))
	{
		level.drone_top_origins[level.drone_top_origins.size] = var_0D;
	}

	thread handleobjectresettrigger(var_0B,var_0D);
	if(!getdvarint("scr_game_grappling_hook",0))
	{
		thread handleragdollwakeup(var_03.origin,500);
	}

	thread playdronevfx(var_0A);
	var_0E = var_0A gettagorigin("TAG_HANDLE");
	var_0F = var_0A gettagangles("TAG_HANDLE");
	var_10 = spawn("script_model",var_0E);
	var_10 setmodel("genericprop");
	var_10.angles = var_0F;
	var_10 vehicle_jetbikesethoverforcescale(var_0A,"TAG_HANDLE");
	var_11 = var_0A gettagorigin("body_main");
	var_12 = var_0A gettagangles("body_main");
	var_13 = spawn("script_model",var_11);
	var_13 setmodel("genericprop");
	var_13.angles = var_12;
	var_13 vehicle_jetbikesethoverforcescale(var_0A,"body_main");
	if(level.nextgen)
	{
		var_14 = getent(param_00 + "_drone_leg_frontright_col","targetname");
		var_15 = getent(param_00 + "_drone_leg_frontleft_col","targetname");
		var_16 = getent(param_00 + "_drone_leg_backright_col","targetname");
		var_17 = getent(param_00 + "_drone_leg_backleft_col","targetname");
		var_18 = var_0A gettagorigin("fx_joint_0");
		var_19 = var_0A gettagangles("fx_joint_0");
		var_1A = spawn("script_model",var_18);
		var_1A setmodel("genericprop");
		var_1A.angles = var_19;
		var_1A vehicle_jetbikesethoverforcescale(var_0A,"fx_joint_0");
		var_1B = var_0A gettagorigin("fx_joint_1");
		var_1C = var_0A gettagangles("fx_joint_1");
		var_1D = spawn("script_model",var_1B);
		var_1D setmodel("genericprop");
		var_1D.angles = var_1C;
		var_1D vehicle_jetbikesethoverforcescale(var_0A,"fx_joint_1");
		var_1E = var_0A gettagorigin("fx_joint_2");
		var_1F = var_0A gettagangles("fx_joint_2");
		var_20 = spawn("script_model",var_1E);
		var_20 setmodel("genericprop");
		var_20.angles = var_1F;
		var_20 vehicle_jetbikesethoverforcescale(var_0A,"fx_joint_2");
		var_21 = var_0A gettagorigin("fx_joint_3");
		var_22 = var_0A gettagangles("fx_joint_3");
		var_23 = spawn("script_model",var_21);
		var_23 setmodel("genericprop");
		var_23.angles = var_19;
		var_23 vehicle_jetbikesethoverforcescale(var_0A,"fx_joint_3");
		var_15 vehicle_jetbikesethoverforcescale(var_1A);
		var_14 vehicle_jetbikesethoverforcescale(var_1D);
		var_17 vehicle_jetbikesethoverforcescale(var_20);
		var_16 vehicle_jetbikesethoverforcescale(var_23);
		var_0A.clipents = [var_15,var_1A,var_14,var_1D,var_17,var_20,var_16,var_23,var_0C,var_13,var_0D,var_0B];
	}
	else
	{
		var_24 = getent(param_00 + "_drone_legs_col","targetname");
		var_24 vehicle_jetbikesethoverforcescale(var_13);
		var_0A.legsclip = var_24;
		var_0A.clipents = [var_0C,var_13,var_0D,var_0B];
	}

	var_25 = getent("dynamic_event_slot_clip","targetname");
	thread dynamiceventcollisionhandling(var_09,var_25);
	var_09 vehicle_jetbikesethoverforcescale(var_03);
	var_03.col = var_09;
	var_03.proxy = var_10;
	var_0C vehicle_jetbikesethoverforcescale(var_13);
	var_0D vehicle_jetbikesethoverforcescale(var_13);
	var_0A.bodyclip = var_0C;
	var_0A.bodyclip.parent = var_13;
	var_03.origin = var_0E;
	var_03.angles = var_0F - (0,180,0);
	var_09.angles = var_03.angles;
	var_03 vehicle_jetbikesethoverforcescale(var_10);
	var_0A scriptmodelplayanimdeltamotionfrompos(param_01,level.dynamiceventanimorg.origin,level.dynamiceventanimorg.angles,"droneIdle");
	level.dynamiceventdrones[level.dynamiceventdrones.size] = var_0A;
	level.dynamiceventapartments[level.dynamiceventapartments.size] = var_03;
	return var_03;
}

//Function Number: 14
dynamiceventsuspendedapartmentshiftanim()
{
	if(!getdvarint("scr_game_grappling_hook",0))
	{
		var_00 = spawn("script_origin",(0,0,0));
		var_00 playsound("anrx_per_dynevent_warn");
		wait(5);
		level notify("dynamic_event_started");
		var_01 = getent("dynamic_event_apartment_01_drone","targetname");
		var_02 = getent("dynamic_event_apartment_02_drone","targetname");
		var_03 = getent("dynamic_event_apartment_03_drone","targetname");
		var_04 = getent("dynamic_event_apartment_04_drone","targetname");
		dynamiceventhandleshiftingapartment(var_01,level.building01,"per_apartment01_drop","per_drone01_drop_apartment",30);
		dynamiceventhandleshiftingapartment(var_02,level.building02,"per_apartment02_drop","per_drone02_drop_apartment",28);
		dynamiceventhandleshiftingapartment(var_03,level.building03,"per_apartment03_drop","per_drone03_drop_apartment",27);
		dynamiceventhandlefinalshiftingapartment(var_04,level.building04,"per_drone04_flight","per_drone04_idle02");
		level notify("dynamic_event_complete");
		var_00 playsound("anrx_per_dynevent_act");
	}
}

//Function Number: 15
dynamiceventhandleshiftingapartment(param_00,param_01,param_02,param_03,param_04)
{
	param_00 waittillmatch("end","droneIdle");
	if(level.currentgen)
	{
		param_00.legsclip delete();
	}

	thread playdroneactivevfx(param_00);
	param_00 scriptmodelclearanim();
	param_01 aud_map_event_start();
	param_01.proxy unlink();
	param_00 scriptmodelplayanimdeltamotionfrompos(param_03,level.dynamiceventanimorg.origin,level.dynamiceventanimorg.angles,"droneDropoff");
	param_01.proxy scriptmodelplayanimdeltamotionfrompos(param_02,level.dynamiceventanimorg.origin,level.dynamiceventanimorg.angles);
	thread dynamiceventplayaccordion(param_01.targetname + "_accordian",5);
	thread notifybuildinginplace(param_01.targetname,15);
	wait(param_04);
	param_00 deletedroneandcollision();
}

//Function Number: 16
deletedroneandcollision()
{
	if(isdefined(self))
	{
		if(isdefined(self.clipents))
		{
			foreach(var_01 in self.clipents)
			{
				var_01 delete();
			}
		}

		self delete();
	}
}

//Function Number: 17
handleobjectresettrigger(param_00,param_01)
{
	level endon("game_ended");
	var_02 = 32;
	if(isdefined(param_00))
	{
		param_00.targetname = "out_of_bounds";
	}

	if(level.gametype == "ball")
	{
		var_02 = 24;
	}

	while(isdefined(param_00) && isdefined(param_01))
	{
		param_00.origin = param_01.origin - (0,0,var_02);
		wait(0.5);
	}
}

//Function Number: 18
handleragdollwakeup(param_00,param_01)
{
	level waittill("dynamic_event_started");
	physicsexplosionsphere(param_00,param_01,0,0);
}

//Function Number: 19
notifybuildinginplace(param_00,param_01)
{
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	level notify(param_00 + "_in_place");
}

//Function Number: 20
dynamiceventhandlefinalshiftingapartment(param_00,param_01,param_02,param_03)
{
	param_00 waittillmatch("end","droneIdle");
	param_00 scriptmodelclearanim();
	param_00 scriptmodelplayanimdeltamotionfrompos(param_02,level.dynamiceventanimorg.origin,level.dynamiceventanimorg.angles,"droneReposition");
	param_00 waittillmatch("end","droneReposition");
	param_00 scriptmodelclearanim();
	param_00 scriptmodelplayanimdeltamotionfrompos(param_03,level.dynamiceventanimorg.origin,level.dynamiceventanimorg.angles);
}

//Function Number: 21
dynamiceventcollisionhandling(param_00,param_01)
{
	wait(1);
	foreach(var_03 in level.dynamiceventdrones)
	{
		if(isdefined(var_03.bodyclip))
		{
			var_03.bodyclip unlink();
		}
	}

	level waittill("dynamic_event_started");
	foreach(var_03 in level.dynamiceventdrones)
	{
		if(isdefined(var_03.bodyclip))
		{
			if(level.nextgen)
			{
				var_03.bodyclip.origin = var_03.bodyclip.parent.origin;
				var_03.bodyclip.angles = var_03.bodyclip.parent.angles;
			}

			var_03.bodyclip vehicle_jetbikesethoverforcescale(var_03.bodyclip.parent);
		}
	}

	param_00.unresolved_collision_kill = 1;
	param_01.unresolved_collision_kill = 1;
}

//Function Number: 22
dynamiceventplayaccordion(param_00,param_01)
{
	var_02 = getscriptablearray(param_00,"targetname");
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	if(isdefined(var_02))
	{
		foreach(var_04 in var_02)
		{
			var_04 setscriptablepartstate("root_part","anim_state");
		}
	}
}

//Function Number: 23
handledynamiceventcarepackagebadvol()
{
	var_00 = getent("carepackage_bad_vol","targetname");
	while(!isdefined(level.orbital_util_covered_volumes))
	{
		wait 0.05;
	}

	level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_00;
	level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_00;
}

//Function Number: 24
handledynamiceventobjectresettriggers()
{
	var_00 = getent("object_reset_trigger_01","targetname");
	var_01 = getent("object_reset_trigger_02","targetname");
	var_02 = getent("uplink_ball_blocker","targetname");
	var_00.targetname = "out_of_bounds";
	var_01.targetname = "out_of_bounds";
	var_00 common_scripts\utility::trigger_off();
	var_01 common_scripts\utility::trigger_off();
	var_02 common_scripts\utility::trigger_off();
	level waittill("dynamic_event_started");
	var_00 common_scripts\utility::trigger_on();
	level waittill("dynamic_event_apartment_01_in_place");
	var_00 delete();
	var_02 common_scripts\utility::trigger_on();
	level waittill("dynamic_event_apartment_02_in_place");
	var_01 common_scripts\utility::trigger_on();
	level waittill("dynamic_event_apartment_03_in_place");
	var_01 delete();
}

//Function Number: 25
dynamiceventsuspendedapartmentshiftanimend()
{
	var_00 = getent("final_position_apartment_01","targetname");
	var_01 = getent("final_position_apartment_02","targetname");
	var_02 = getent("final_position_apartment_03","targetname");
	var_03 = getent("final_position_apartment_04","targetname");
	var_04 = undefined;
	foreach(var_06 in level.dynamiceventdrones)
	{
		if(var_06.targetname == "dynamic_event_apartment_04_drone")
		{
			var_04 = var_06;
			break;
		}
	}

	foreach(var_09 in level.dynamiceventapartments)
	{
		var_09 unlink();
	}

	level.building01.origin = var_00.origin;
	level.building01.angles = var_00.angles;
	level.building02.origin = var_01.origin;
	level.building02.angles = var_01.angles;
	level.building03.origin = var_02.origin;
	level.building03.angles = var_02.angles;
	level.building04.origin = var_03.origin;
	level.building04.angles = var_03.angles;
	foreach(var_09 in level.dynamiceventapartments)
	{
		var_09.col.origin = var_09.origin;
		var_09.col.angles = var_09.angles;
	}

	var_04 scriptmodelclearanim();
	var_04.origin = level.dynamiceventanimorg.origin;
	var_04.angles = level.dynamiceventanimorg.angles;
	level.building04.origin = level.dynamiceventanimorg.origin;
	level.building04.angles = level.dynamiceventanimorg.angles - (0,180,0);
	level.building04.proxy.origin = level.dynamiceventanimorg.origin;
	level.building04.proxy.angles = level.dynamiceventanimorg.angles;
	var_04 scriptmodelplayanimdeltamotion("per_drone04_idle02");
	level.building04 vehicle_jetbikesethoverforcescale(level.building04.proxy);
	foreach(var_06 in level.dynamiceventdrones)
	{
		if(isdefined(var_06) && var_06 != var_04)
		{
			var_06 deletedroneandcollision();
		}
	}

	handledynamiceventpathnodesforstate(1);
}

//Function Number: 26
playdronevfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("mp_plex_drone_hover"),param_00,"TAG_ORIGIN");
	param_00 playloopsound("mp_pp_drone_idle_lo");
}

//Function Number: 27
playdroneactivevfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("mp_plex_drone_active"),param_00,"TAG_ORIGIN");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("mp_plex_drone_leg_glow"),param_00,"fx_joint_0");
	playfxontag(common_scripts\utility::getfx("mp_plex_drone_leg_glow"),param_00,"fx_joint_1");
	playfxontag(common_scripts\utility::getfx("mp_plex_drone_leg_glow"),param_00,"fx_joint_2");
	playfxontag(common_scripts\utility::getfx("mp_plex_drone_leg_glow"),param_00,"fx_joint_3");
}

//Function Number: 28
do_drone_top_damage()
{
	level endon("game_ended");
	var_00 = 198;
	var_01 = 12;
	var_02 = -100;
	var_03 = var_00 * var_00;
	while(!isdefined(level.players))
	{
		wait 0.05;
	}

	var_04 = level.drone_top_origins.size;
	for(;;)
	{
		if(!isdefined(level.drone_top_origins) || var_04 == 0)
		{
			return;
		}

		var_05 = 0;
		foreach(var_07 in level.drone_top_origins)
		{
			if(isdefined(var_07))
			{
				foreach(var_09 in level.players)
				{
					if(!isdefined(var_09) || !isalive(var_09))
					{
						continue;
					}

					if(distance2dsquared(var_07.origin,var_09.origin) < var_03)
					{
						var_0A = var_09.origin[2] - var_07.origin[2];
						if(var_0A > var_02 && var_0A < var_01)
						{
							var_09 dodamage(1000,var_07.origin,undefined,undefined,"MOD_TRIGGER_HURT","none","none");
						}
					}
				}

				if(isdefined(level.ugvs))
				{
					foreach(var_0D in level.ugvs)
					{
						if(distance2dsquared(var_07.origin,var_0D.origin) < var_03)
						{
							var_0E = var_0D.origin[2] - var_07.origin[2];
							if(var_0E > var_02 + 85 && var_0E < var_01)
							{
								var_0D notify("death");
							}
						}
					}
				}

				var_05++;
			}
		}

		var_04 = var_05;
		wait(0.05);
	}
}

//Function Number: 29
handledynamiceventpathnodesforstate(param_00)
{
	level endon("game_ended");
	level notify("override_dynamic_path_handling");
	level endon("override_dynamic_path_handling");
	wait(1);
	var_01 = getent("building_01_dynamic_path_brush","targetname");
	var_02 = getent("building_02_dynamic_path_brush","targetname");
	var_03 = getent("building_03_dynamic_path_brush","targetname");
	var_04 = getent("pre_dynamic_event_dynamic_path_brush","targetname");
	var_05 = getent("both_dynamic_path_brush","targetname");
	var_06 = getentarray("dynamic_event_temp_clip","targetname");
	foreach(var_08 in var_06)
	{
		var_08 delete();
	}

	if(isdefined(param_00) && param_00 == 1)
	{
		disconnectnodesforbrush(var_04);
		connectnodesforbrush(var_01);
		connectnodesforbrush(var_02);
		connectnodesforbrush(var_03);
		connectnodesforbrush(var_05);
		return;
	}

	var_01 disconnectpaths();
	var_01 common_scripts\utility::trigger_off();
	var_02 disconnectpaths();
	var_02 common_scripts\utility::trigger_off();
	var_03 disconnectpaths();
	var_03 common_scripts\utility::trigger_off();
	var_04 connectpaths();
	var_04 common_scripts\utility::trigger_off();
	var_05 connectpaths();
	var_05 common_scripts\utility::trigger_off();
	level waittill("dynamic_event_started");
	disconnectnodesforbrush(var_04);
	disconnectnodesforbrush(var_05);
	level waittill("dynamic_event_apartment_01_in_place");
	connectnodesforbrush(var_01);
	level waittill("dynamic_event_apartment_02_in_place");
	connectnodesforbrush(var_02);
	connectnodesforbrush(var_05);
	level waittill("dynamic_event_apartment_03_in_place");
	connectnodesforbrush(var_03);
}

//Function Number: 30
gamemodetraversalcheck()
{
	wait(2);
	var_00 = getent("uplink_non_goalnode_brush","targetname");
	if(level.gametype == "ball")
	{
		var_00 disconnectpaths();
		var_00 common_scripts\utility::trigger_off();
	}
	else
	{
		var_00 connectpaths();
		var_00 common_scripts\utility::trigger_off();
	}

	var_00 delete();
}

//Function Number: 31
connectnodesforbrush(param_00)
{
	param_00 common_scripts\utility::trigger_on();
	param_00 connectpaths();
	param_00 common_scripts\utility::trigger_off();
}

//Function Number: 32
disconnectnodesforbrush(param_00)
{
	param_00 common_scripts\utility::trigger_on();
	param_00 disconnectpaths();
	param_00 common_scripts\utility::trigger_off();
}

//Function Number: 33
perplexkillstreakoverrides()
{
	while(!isdefined(level.orbitalsupportoverrides))
	{
		wait 0.05;
	}

	level.orbitalsupportoverrides.spawnheight = 6500;
	level.remote_missile_height_override = 18000;
}

//Function Number: 34
vignetteferry()
{
	var_00 = getent("ferry_loop_org","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("per_ferryboat_01");
	var_01.angles = var_00.angles;
	for(;;)
	{
		var_01 scriptmodelplayanim("per_ferry_boat");
		playfxontag(common_scripts\utility::getfx("boat_wake_ferryboat_main_foam"),var_01,"boat_body");
		var_02 = randomintrange(220,340);
		wait(var_02);
		stopfxontag(common_scripts\utility::getfx("boat_wake_ferryboat_main_foam"),var_01,"boat_body");
		wait(2);
		var_01 scriptmodelclearanim();
	}
}

//Function Number: 35
vignetterooftopwindmills()
{
	var_00 = getentarray("rooftop_windmill","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_noteworthy))
		{
			var_02 scriptmodelplayanim(var_02.script_noteworthy);
			continue;
		}

		var_02 scriptmodelplayanim("per_windmill_idle01");
	}
}

//Function Number: 36
vignettesailboats()
{
	for(var_00 = 1;var_00 < 6;var_00 = var_00 + 1)
	{
		switch(var_00)
		{
			case 1:
				var_01 = getent("sailboat_idle_a_org","targetname");
				var_02 = spawn("script_model",var_01.origin);
				var_02 setmodel("per_sailboat_01");
				var_02.angles = var_01.angles;
				playfxontag(common_scripts\utility::getfx("boat_wake_sailboat_main_foam"),var_02,"boat_body");
				var_02 scriptmodelplayanim("per_sail_boat_idle_a");
				break;

			case 2:
				var_01 = getent("sailboat_idle_b_org","targetname");
				var_02 = spawn("script_model",var_01.origin);
				var_02 setmodel("per_sailboat_01");
				var_02.angles = var_01.angles;
				playfxontag(common_scripts\utility::getfx("boat_wake_sailboat_main_foam"),var_02,"boat_body");
				var_02 scriptmodelplayanim("per_sail_boat_idle_b");
				break;

			case 3:
				var_01 = getent("sailboat_idle_c_org","targetname");
				var_02 = spawn("script_model",var_01.origin);
				var_02 setmodel("per_sailboat_01");
				var_02.angles = var_01.angles;
				playfxontag(common_scripts\utility::getfx("boat_wake_sailboat_main_foam"),var_02,"boat_body");
				var_02 scriptmodelplayanim("per_sail_boat_idle_c");
				break;

			case 4:
				var_01 = getent("sailboat_idle_d_org","targetname");
				var_02 = spawn("script_model",var_01.origin);
				var_02 setmodel("per_sailboat_01");
				var_02.angles = var_01.angles;
				playfxontag(common_scripts\utility::getfx("boat_wake_sailboat_main_foam"),var_02,"boat_body");
				var_02 scriptmodelplayanim("per_sail_boat_idle_d");
				break;

			case 5:
				var_01 = getent("ferry_idle_org","targetname");
				var_03 = spawn("script_model",var_01.origin);
				var_03 setmodel("per_ferryboat_01");
				var_03.angles = var_01.angles;
				var_03 scriptmodelplayanim("per_ferry_boat_dock_idle");
				break;
		}
	}

	var_04 = getent("sailboat_loop_org","targetname");
	var_02 = spawn("script_model",var_04.origin);
	var_02 setmodel("per_sailboat_01");
	var_02.angles = var_04.angles;
	for(;;)
	{
		var_02 scriptmodelplayanim("per_sail_boat");
		playfxontag(common_scripts\utility::getfx("boat_wake_sailboat_main_foam"),var_02,"boat_body");
		var_05 = randomintrange(180,300);
		wait(var_05);
		stopfxontag(common_scripts\utility::getfx("boat_wake_sailboat_main_foam"),var_02,"boat_body");
		wait(2);
		var_02 scriptmodelclearanim();
	}
}

//Function Number: 37
aud_map_event_start()
{
	var_00 = self;
	if(var_00 == level.building01)
	{
		maps\mp\_audio::snd_play_linked("mp_pp_bldg_move_01",var_00,60);
	}

	if(var_00 == level.building02)
	{
		maps\mp\_audio::snd_play_linked("mp_pp_bldg_move_02",var_00,60);
	}

	if(var_00 == level.building03)
	{
		maps\mp\_audio::snd_play_linked("mp_pp_bldg_move_03",var_00,60);
	}
}