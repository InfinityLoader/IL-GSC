/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_lab2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 74
 * Decompile Time: 1147 ms
 * Timestamp: 4/22/2024 2:17:43 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_lab2_precache::main();
	maps\createart\mp_lab2_art::main();
	maps\mp\mp_lab2_fx::main();
	common_scripts\utility::setlightingstate(1);
	maps\mp\_load::main();
	thread setup_audio();
	thread set_lighting_values();
	thread set_umbra_values();
	level.ospvisionset = "mp_lab2_osp";
	level.osplightset = "mp_lab2_osp";
	level.warbirdvisionset = "mp_lab2_osp";
	level.warbirdlightset = "mp_lab2_osp";
	level.vulcanvisionset = "mp_lab2_osp";
	level.vulcanlightset = "mp_lab2_osp";
	maps\mp\_compass::setupminimap("compass_map_mp_lab2");
	setdvar("sm_minSpotLightScore",0.0007);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	if(level.nextgen)
	{
		level.aerial_pathnode_group_connect_dist = 350;
	}

	precachemodel("lab2_cannister_holder_01");
	precachemodel("lab2_industrial_crane_01");
	precachempanim("lab2_dynamic_event_helicopter_anim");
	precachempanim("lab2_dynamic_event_harness_anim");
	precachempanim("lab2_dynamic_event_building_anim");
	precachempanim("lab2_industrial_crane_anim");
	precachempanim("lab2_dynamic_event_harness_invis_anim");
	precacheshellshock("mp_lab_gas");
	precacheshader("lab_gas_overlay");
	level.missileparticles = spawnstruct();
	level.missileparticles.spraymachine = loadfx("vfx/water/industrial_hot_water_sprayer");
	level.missileparticles.spraymachinedrips = loadfx("vfx/water/industrial_hot_water_sprayer_drips");
	level.missileparticles.canisterdrips = loadfx("vfx/map/mp_lab/canister_drips");
	level.missileparticles.canistersteam = loadfx("vfx/map/mp_lab/canister_steam");
	level.missileparticles.drymachine = loadfx("vfx/map/mp_lab/industrial_dryer_fan");
	level.missileparticles.sparkgreenloop = loadfx("vfx/map/mp_lab/flare_sparks_ambient_green");
	level.missileparticles.greencrazylightloop = loadfx("vfx/smoke/smoke_flare_marker_green_windy");
	level.missileparticles.greensmokeloop = loadfx("vfx/map/mp_lab/chem_smoke_green");
	level.missileparticles.missileexplosion = loadfx("vfx/explosion/poison_gas_canister_explosion");
	level.missileparticles.cranesparks = loadfx("vfx/sparks/crane_scrape_sparks_small_looping");
	level.alarmfx01 = loadfx("vfx/lights/mp_lab2/lab2_crane_red_alarm");
	if(isdefined(level.createfx_enabled) && level.createfx_enabled)
	{
		return;
	}

	thread setupcranechem();
	thread onplayerconnectfucntions();
	thread setupdynamicevent();
	thread setuprobotarmnotetracks();
	thread maps\mp\_utility::findandplayanims("animated_prop",1);
	thread specialgametypescript();
	setdvar("r_reactivemotionfrequencyscale",0.5);
	setdvar("r_reactivemotionamplitudescale",0.5);
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
	level.labtemptuner1 = 9;
	level.labtemptuner2 = 4;
	level.labtemptuner3 = -2;
	level.orbitalsupportoverridefunc = ::labpaladinoverrides;
	level.orbitallaseroverridefunc = ::lab2customlaserstreakfunc;
	thread lab2customairstrike();
	thread lab2botkilltrigger();
	thread lab2playerkilltrigger();
}

//Function Number: 2
set_umbra_values()
{
	setdvar("r_umbraAccurateOcclusionThreshold",128);
}

//Function Number: 3
specialgametypescript()
{
	thread waitcarryobjects();
}

//Function Number: 4
waitcarryobjects()
{
	level endon("game_ended");
	if(level.gametype == "sd")
	{
		while(!isdefined(level.sdbomb))
		{
			wait(0.05);
		}

		level.sdbomb thread watchcarryobjects();
		return;
	}

	if(level.gametype == "sab")
	{
		while(!isdefined(level.sabbomb))
		{
			wait(0.05);
		}

		level.sabbomb thread watchcarryobjects();
		return;
	}

	if(level.gametype == "tdef")
	{
		while(!isdefined(level.gameflag))
		{
			wait(0.05);
		}

		level.gameflag thread watchcarryobjects();
		return;
	}

	if(level.gametype == "ball")
	{
		while(!isdefined(level.balls))
		{
			wait(0.05);
		}

		foreach(var_01 in level.balls)
		{
			var_01 thread watchcarryobjects();
		}

		return;
	}

	if(level.gametype == "ctf")
	{
		while(!isdefined(level.teamflags) || !isdefined(level.teamflags[game["defenders"]]) || !isdefined(level.teamflags[game["attackers"]]))
		{
			wait(0.05);
		}

		level.teamflags[game["defenders"]] thread watchcarryobjects();
		level.teamflags[game["attackers"]] thread watchcarryobjects();
		return;
	}
}

//Function Number: 5
watchcarryobjects()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("dropped");
		wait(0.1);
		if(isoutofbounds())
		{
			maps\mp\gametypes\_gameobjects::returnhome();
			continue;
		}

		if(isdefined(level.flyingbuildingent) && level.flyingbuildingent.flying == 1 && isdefined(level.flyingbuildingent.triggerhurtlower) && isdefined(level.flyingbuildingent.triggerhurtupper))
		{
			while(level.flyingbuildingent.flying == 1)
			{
				if(self.visuals[0] istouching(level.flyingbuildingent.triggerhurtlower) || self.visuals[0] istouching(level.flyingbuildingent.triggerhurtupper))
				{
					maps\mp\gametypes\_gameobjects::returnhome();
					break;
				}

				wait(0.05);
			}
		}
	}
}

//Function Number: 6
isoutofbounds()
{
	var_00 = getentarray("radiation","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_00[var_01]))
		{
			continue;
		}

		return 1;
	}

	var_02 = getentarray("minefield","targetname");
	for(var_01 = 0;var_01 < var_02.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_02[var_01]))
		{
			continue;
		}

		return 1;
	}

	var_03 = getentarray("trigger_hurt","classname");
	for(var_01 = 0;var_01 < var_03.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_03[var_01]))
		{
			continue;
		}

		return 1;
	}

	var_04 = getentarray("boost_jump_border_trig","targetname");
	for(var_01 = 0;var_01 < var_04.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_04[var_01]))
		{
			continue;
		}

		return 1;
	}

	var_05 = getentarray("object_out_of_bounds","targetname");
	for(var_01 = 0;var_01 < var_05.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_05[var_01]))
		{
			continue;
		}

		return 1;
	}

	return 0;
}

//Function Number: 7
setupdynamicevent()
{
	var_00 = getentarray("ground_shadow_patch_before","targetname");
	var_01 = getentarray("ground_shadow_patch_after","targetname");
	var_02 = getent("teleport_from","targetname");
	var_03 = getent("teleport_to","targetname");
	foreach(var_05 in var_00)
	{
		var_05.origin = var_05.origin + var_03.origin - var_02.origin;
	}

	foreach(var_05 in var_01)
	{
		var_05 hide();
	}

	common_scripts\utility::setlightingstate(2);
	var_09 = getentarray("dynamic_building_master_prefab","targetname");
	var_0A = undefined;
	var_0B = [];
	foreach(var_0D in var_09)
	{
		if(isdefined(var_0D.script_noteworthy) && var_0D.script_noteworthy == "origin")
		{
			var_0A = spawn("script_origin",var_0D.origin);
			continue;
		}

		var_0B[var_0B.size] = var_0D;
	}

	if(!isdefined(var_0A))
	{
		var_0A = spawn("script_origin",var_09[0].origin);
	}

	var_0A.radiant_pos = var_0A.origin;
	var_0A.flying = 0;
	var_0A.parts = var_0B;
	var_0A.triggerhurtlower = getent("building_hurt_01","targetname");
	var_0A.triggerhurtupper = getent("building_hurt_02","targetname");
	var_0A.triggerkillvehiclesheli = getent("vehicle_kill_heli","targetname");
	var_0A.triggerkillvehicleshelioffset = (525,36,635);
	var_0A.triggerkillvehiclesheli.origin = var_0A.triggerkillvehiclesheli.origin + (0,0,-10000);
	var_0A.triggerkillvehiclesbuilding = getent("vehicle_kill_building","targetname");
	var_0A.triggerkillvehiclesbuildingoffset = var_0A.triggerkillvehiclesbuilding.origin - var_0A.origin;
	var_0A.triggerkillvehiclesbuilding.origin = var_0A.triggerkillvehiclesbuilding.origin + (0,0,-10000);
	foreach(var_0D in var_0A.parts)
	{
		if(var_0D.classname == "info_null_meter")
		{
			continue;
		}
		else if(isdefined(var_0D.script_noteworthy) && var_0D.script_noteworthy == "trigger_origin_01")
		{
			var_0A.triggerlowerorigin = var_0D;
		}
		else if(isdefined(var_0D.script_noteworthy) && var_0D.script_noteworthy == "trigger_origin_02")
		{
			var_0A.triggerupperorigin = var_0D;
		}

		var_0D vehicle_jetbikesethoverforcescale(var_0A);
	}

	var_0A.dynamicpathblock = getent("flying_building_paths_unblock","targetname");
	var_0A.dynamicpathrampswitch = getent("flying_building_path_ramp_switch","targetname");
	var_0A.dynamicpathblock vehicle_jetbikesethoverforcescale(var_0A);
	var_0A.og_spawn = (15959.85,-24712.88,5209.891);
	var_0A.og_heli_spawn = (15940.68,-24711.62,5888.014);
	var_0A.origin = var_0A.og_spawn;
	wait(0.05);
	var_0A.triggerhurtlower.origin = var_0A.triggerlowerorigin.origin;
	var_0A.triggerhurtlower.angles = var_0A.triggerlowerorigin.angles;
	var_0A.triggerhurtupper.origin = var_0A.triggerupperorigin.origin;
	var_0A.triggerhurtupper.angles = var_0A.triggerupperorigin.angles;
	opendynamicbuildingplatformpath(var_0A);
	foreach(var_0D in var_0A.parts)
	{
		if(var_0D.classname == "info_null_meter")
		{
			continue;
		}

		var_0D hide();
	}

	var_0A hide();
	level.flyingbuildingent = var_0A;
	level thread maps\mp\_dynamic_events::dynamicevent(::dynamiceventstartfunc,undefined,::dynamiceventendfunc);
}

//Function Number: 8
opendynamicbuildingplatformpath(param_00)
{
	param_00.dynamicpathrampswitch.origin = param_00.dynamicpathrampswitch.origin + (0,0,-10000);
	param_00.dynamicpathblock connectpaths();
	foreach(var_02 in param_00.parts)
	{
		if(isdefined(var_02.script_noteworthy))
		{
			if(var_02.script_noteworthy == "flying_building_collision_shell" || var_02.script_noteworthy == "collision" || var_02.script_noteworthy == "building_brush_geo")
			{
				var_02 connectpaths();
				if(var_02.script_noteworthy == "flying_building_collision_shell")
				{
					var_02 setaisightlinevisible(0);
				}
			}
		}
	}

	if(level.gametype == "dom")
	{
		wait(0.05);
		maps\mp\gametypes\dom::flagsetup();
	}
}

//Function Number: 9
dynamiceventstartfunc()
{
	if(isdefined(level.flyingbuildingent) && !isdefined(level.ishorde))
	{
		level.flyingbuildingent moveflyingbuilding();
	}
}

//Function Number: 10
dynamiceventendfunc()
{
	var_00 = getentarray("ground_shadow_patch_before","targetname");
	var_01 = getentarray("ground_shadow_patch_after","targetname");
	var_01[0] show();
	var_00[0] hide();
	if(isdefined(level.flyingbuildingent))
	{
		level.flyingbuildingent.dynamicpathblock unlink();
		level.flyingbuildingent.dynamicpathblock.origin = level.flyingbuildingent.dynamicpathblock.origin + (0,0,-10000);
		level.flyingbuildingent dontinterpolate();
		level.flyingbuildingent.origin = level.flyingbuildingent.radiant_pos;
		wait(0.05);
		level.flyingbuildingent.triggerhurtlower dontinterpolate();
		level.flyingbuildingent.triggerhurtupper dontinterpolate();
		level.flyingbuildingent.triggerhurtlower.origin = level.flyingbuildingent.triggerhurtlower.origin + (0,0,-10000);
		level.flyingbuildingent.triggerhurtupper.origin = level.flyingbuildingent.triggerhurtupper.origin + (0,0,-10000);
		foreach(var_03 in level.flyingbuildingent.parts)
		{
			var_03 unlink();
			var_03 show();
			var_03.unresolved_collision_kill = 0;
			if(isdefined(var_03.script_noteworthy))
			{
				if(var_03.script_noteworthy == "flying_building_collision_shell")
				{
					var_03 disconnectpaths();
					var_03 setaisightlinevisible(1);
					continue;
				}

				if(var_03.script_noteworthy == "collision")
				{
					var_03 delete();
				}
			}
		}

		level.flyingbuildingent.dynamicpathrampswitch connectpaths();
		level thread common_scripts\_exploder::activate_clientside_exploder(100);
	}

	if(level.gametype == "dom")
	{
		dom_b_move();
	}
}

//Function Number: 11
getnetquantizedangle(param_00)
{
	var_01 = param_00 / 360;
	var_02 = var_01 - floor(var_01) * 360;
	var_03 = var_02 - 360;
	if(var_03 >= 0)
	{
		var_02 = var_03;
	}

	var_04 = int(floor(var_02 * 4095 / 360 + 0.5));
	param_00 = var_04 * 360 / 4095;
	return param_00;
}

//Function Number: 12
dom_b_move()
{
	wait(0.05);
	var_00 = common_scripts\utility::getstruct("dom_point_b_location","targetname");
	foreach(var_02 in level.flags)
	{
		if(var_02.script_label == "_b")
		{
			var_02.origin = var_00.origin;
			var_02.useobj.visuals[0].origin = var_00.origin + (0,0,1.125);
			var_02.useobj.visuals[0].baseorigin = var_00.origin + (0,0,1.125);
			var_02.useobj.curorigin = var_00.origin + (0,0,1.125);
			var_02.useobj.baseeffectpos = var_00.origin + (0,0,1.125);
			var_02.useobj maps\mp\gametypes\dom::updatevisuals();
			if(isdefined(var_02.useobj.objidallies))
			{
				objective_position(var_02.useobj.objidallies,var_00.origin);
			}

			if(isdefined(var_02.useobj.objidaxis))
			{
				objective_position(var_02.useobj.objidaxis,var_00.origin);
			}

			var_03 = var_00.origin + (0,0,100);
			foreach(var_05 in level.teamnamelist)
			{
				var_06 = "objpoint_" + var_05 + "_" + var_02.useobj.entnum;
				var_07 = maps\mp\gametypes\_objpoints::getobjpointbyname(var_06);
				var_07.x = var_03[0];
				var_07.y = var_03[1];
				var_07.z = var_03[2];
			}
		}
	}

	level notify("dom_flags_moved");
	maps\mp\gametypes\dom::flagsetup();
}

//Function Number: 13
moveflyingbuilding()
{
	var_00 = level.labtemptuner1;
	var_01 = level.labtemptuner2;
	var_02 = level.labtemptuner3;
	self.heavy_lifter = spawn("script_model",self.og_heli_spawn + (var_02,var_01,var_00));
	var_03 = getnetquantizedangle(36.078);
	self.heavy_lifter.angles = (0,36.044,0);
	self.heavy_lifter setmodel("vehicle_heavy_lift_helicopter_01");
	self.harness = spawn("script_model",self.heavy_lifter gettagorigin("tag_crane"));
	self.harness.angles = self.heavy_lifter gettagangles("tag_crane") + (0,0,0);
	self.harness setmodel("heavy_lift_wires");
	self.building_bone = spawn("script_model",self.og_spawn + (0,0,var_00));
	self.building_bone.angles = self.harness gettagangles("tag_cargo") + (0,180,0);
	self.building_bone setmodel("tag_origin_animate");
	self.flying = 1;
	wait(0.05);
	self.triggerkillvehiclesheli thread maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig();
	self.triggerkillvehiclesbuilding thread maps\mp\killstreaks\_aerial_utility::setup_kill_drone_trig();
	thread killwarbirds(self.triggerkillvehiclesbuilding);
	thread killwarbirds(self.triggerkillvehiclesheli);
	foreach(var_05 in self.parts)
	{
		var_05 show();
	}

	wait(0.05);
	foreach(var_08 in self.parts)
	{
		var_08.unresolved_collision_kill = 1;
	}

	self.origin = self.og_spawn + (0,0,var_00);
	self.angles = self.harness gettagangles("tag_cargo") + (0,180,0);
	self vehicle_jetbikesethoverforcescale(self.harness,"tag_cargo");
	wait(0.05);
	self.heavy_lifter scriptmodelplayanimdeltamotion("lab2_dynamic_event_helicopter_anim","building_unlink_notify");
	self.harness scriptmodelplayanimdeltamotion("lab2_dynamic_event_harness_anim");
	self.heavy_lifter thread aud_transport_chopper();
	thread movebuildingdeathtriggers();
	self.heavy_lifter thread maps\mp\mp_lab2_fx::startheavylifterfx();
	self.heavy_lifter waittillmatch("vfx_heligroundfx_start","building_unlink_notify");
	self.heavy_lifter thread maps\mp\mp_lab2_fx::startheligroundfx();
	self.heavy_lifter waittillmatch("vfx_crane_sparks_start","building_unlink_notify");
	playfxontag(common_scripts\utility::getfx("crane_sparks"),self.heavy_lifter,"TAG_CRANE");
	self.heavy_lifter waittillmatch("helicopter_descend","building_unlink_notify");
	var_0A = [];
	foreach(var_05 in self.parts)
	{
		if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "collision")
		{
			var_05 unlink();
			var_05 delete();
			continue;
		}

		var_0A[var_0A.size] = var_05;
	}

	self.parts = var_0A;
	self.dynamicpathblock unlink();
	self.dynamicpathblock delete();
	self.heavy_lifter thread aud_building_pre_drop();
	self.heavy_lifter waittillmatch("vfx_crane_sparks_stop","building_unlink_notify");
	stopfxontag(common_scripts\utility::getfx("crane_sparks"),self.heavy_lifter,"TAG_CRANE");
	self.heavy_lifter waittillmatch("vfx_building_land","building_unlink_notify");
	common_scripts\_exploder::activate_clientside_exploder(99);
	self.heavy_lifter waittillmatch("drop_building","building_unlink_notify");
	self.harness thread maps\mp\mp_lab2_fx::clampreleasefx();
	self.heavy_lifter thread aud_building_drop();
	var_0D = getentarray("ground_shadow_patch_before","targetname");
	var_0E = getentarray("ground_shadow_patch_after","targetname");
	var_0E[0] show();
	var_0D[0] hide();
	self unlink();
	self.flying = 0;
	foreach(var_05 in self.parts)
	{
		if(isdefined(var_05))
		{
			var_05 unlink();
			var_05.unresolved_collision_kill = 0;
			if(isdefined(var_05.script_noteworthy))
			{
				if(var_05.script_noteworthy == "flying_building_collision_shell")
				{
					var_05 disconnectpaths();
					var_05 setaisightlinevisible(1);
				}
			}
		}
	}

	self.dynamicpathrampswitch connectpaths();
	if(level.gametype == "dom")
	{
		dom_b_move();
	}

	common_scripts\_exploder::activate_clientside_exploder(100);
	self.heavy_lifter waittillmatch("vfx_heligroundfx_stop","building_unlink_notify");
	self.heavy_lifter thread maps\mp\mp_lab2_fx::stopheligroundfx();
	self.heavy_lifter waittillmatch("helicopter_end","building_unlink_notify");
	self.heavy_lifter delete();
	self.harness delete();
}

//Function Number: 14
killwarbirds(param_00)
{
	if(isdefined(param_00))
	{
		while(self.flying == 1)
		{
			if(isdefined(level.spawnedwarbirds))
			{
				foreach(var_02 in level.spawnedwarbirds)
				{
					if(isdefined(var_02))
					{
						if(var_02 istouching(param_00))
						{
							var_02 thread maps\mp\killstreaks\_aerial_utility::heli_explode(1);
						}
					}
				}
			}

			wait(0.05);
		}
	}
}

//Function Number: 15
movebuildingdeathtriggers()
{
	while(self.flying == 1)
	{
		self.triggerhurtlower.origin = self.triggerlowerorigin.origin;
		self.triggerhurtlower.angles = self.triggerlowerorigin.angles;
		self.triggerhurtupper.origin = self.triggerupperorigin.origin;
		self.triggerhurtupper.angles = self.triggerupperorigin.angles;
		var_00 = self.heavy_lifter gettagangles("body_animate_jnt");
		var_01 = 360 - var_00[0];
		var_02 = var_00[1] + 180;
		var_03 = 360 - var_00[2];
		self.triggerkillvehiclesheli.angles = (var_01,var_02,var_03);
		self.triggerkillvehiclesheli.origin = self.heavy_lifter.origin + self.triggerkillvehicleshelioffset;
		self.triggerkillvehiclesbuilding.origin = self.origin + self.triggerkillvehiclesbuildingoffset;
		self.triggerkillvehiclesbuilding.angles = self.angles;
		wait(0.05);
	}

	self.triggerhurtlower dontinterpolate();
	self.triggerhurtupper dontinterpolate();
	self.triggerkillvehiclesheli dontinterpolate();
	self.triggerkillvehiclesbuilding dontinterpolate();
	self.triggerhurtlower.origin = self.triggerhurtlower.origin + (0,0,-10000);
	self.triggerhurtupper.origin = self.triggerhurtupper.origin + (0,0,-10000);
	self.triggerkillvehiclesheli.origin = self.triggerkillvehiclesheli.origin + (0,0,-10000);
	self.triggerkillvehiclesbuilding.origin = self.triggerkillvehiclesbuilding.origin + (0,0,-10000);
}

//Function Number: 16
labpaladinoverrides()
{
	level.orbitalsupportoverrides.spawnanglemin = 70;
	level.orbitalsupportoverrides.spawnanglemax = 150;
	level.orbitalsupportoverrides.spawnheight = 7500;
	level.orbitalsupportoverrides.spawnradius = 5000;
	level.orbitalsupportoverrides.leftarc = 30;
	level.orbitalsupportoverrides.rightarc = 30;
	level.orbitalsupportoverrides.toparc = -42;
	level.orbitalsupportoverrides.bottomarc = 67;
}

//Function Number: 17
lab2customlaserstreakfunc()
{
	var_00 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
	level.orbitallaseroverrides.spawnheight = var_00.origin[2] + 2724;
}

//Function Number: 18
lab2customairstrike()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 1700;
}

//Function Number: 19
lab2botkilltrigger()
{
	level endon("game_ended");
	var_00 = spawn("trigger_radius",(-584,1728,176),0,300,128);
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isbot(var_01) || isagent(var_01))
		{
			var_01 dodamage(var_01.health + 999,var_00.origin);
		}
	}
}

//Function Number: 20
lab2playerkilltrigger()
{
	level endon("game_ended");
	var_00 = spawn("trigger_radius",(-566,1636,220),0,64,64);
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		var_01 dodamage(var_01.health + 999,var_00.origin);
	}
}

//Function Number: 21
onplayerconnectfucntions()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.gastime = 0;
		var_00 thread creategastrackingoverlay();
	}
}

//Function Number: 22
set_lighting_values()
{
	if(isusinghdr())
	{
		for(;;)
		{
			level waittill("connected",var_00);
			var_00 setclientdvars("r_tonemap","1");
		}
	}
}

//Function Number: 23
rotatemeshes(param_00)
{
	for(;;)
	{
		self rotateyaw(360,param_00);
		wait(param_00);
	}
}

//Function Number: 24
setupcranechem()
{
	level.alarmsystem = spawnstruct();
	level.alarmsystem.spinnerarray = getentarray("horizontal_spinner","targetname");
	level.alarmsystem.alarmsoundent = getent("alarm_missile_sound01","targetname");
	level.gasmachine = spawnstruct();
	level.gasmachine.totalspawned = [];
	level.gasmachine.cranecollisiontotal = [];
	level.gasmachine.cranechemcollisiontotal = [];
	level.gasmachine.explosionoffset = 72;
	level.gasmachine.explosionangleoffset = (-90,0,0);
	level.gasmachine.machinesparkarray = getentarray("sparkgroup","targetname");
	level.gasmachine.sprayerdriparray = getentarray("dripgroup","targetname");
	level.gasmachine.partciledrylocation = common_scripts\utility::getstruct("particle_dryer","targetname");
	level.gasmachine.chemical_rackpausetime = 0;
	level.gasmachine.chemical_racksactive = 1;
	level.gasmachine.chemical_rackgotosarray = common_scripts\utility::getstructarray("missile_rack_start01","targetname");
	level.gasmachine.damageradius = 375;
	level.gasmachine.maxdamageamount = 300;
	level.gasmachine.mindamageamount = 75;
	level.gasmachine.spraysheetstate = 1;
	level.gasmachine.totalchemcanhealth = 100;
	level.gasmachine.particlespawnoriginoffset = (0,0,0);
	level.gasmachine.dryerfan = getent("dryer_fan","targetname");
	level.gasmachine.dryerfanrotatevelocity = (0,1400,0);
	level.gasmachine.gasrange = 170;
	var_00 = level.gasmachine.chemical_rackgotosarray[0];
	for(;;)
	{
		if(isdefined(var_00.target))
		{
			var_01 = common_scripts\utility::getstruct(var_00.target,"targetname");
			level.gasmachine.chemical_rackgotosarray = common_scripts\utility::add_to_array(level.gasmachine.chemical_rackgotosarray,var_01);
			var_00 = var_01;
			continue;
		}
		else
		{
			break;
		}

		wait(0.05);
	}

	level.gasmachine.cranecollisiontotal = getentarray("crane_collision01","targetname");
	level.gasmachine.cranecollision = level.gasmachine.cranecollisiontotal;
	foreach(var_03 in level.gasmachine.cranecollisiontotal)
	{
		var_03.unresolved_collision_kill = 1;
	}

	level.gasmachine.cranechemcollisiontotal = getentarray("rack_collision01","targetname");
	level.gasmachine.cranechemcollision = level.gasmachine.cranechemcollisiontotal;
	foreach(var_03 in level.gasmachine.cranechemcollisiontotal)
	{
		var_03.unresolved_collision_kill = 1;
	}

	cranethink(level.gasmachine.chemical_rackgotosarray);
}

//Function Number: 25
addtototalspawned()
{
	level.gasmachine.totalspawned = common_scripts\utility::add_to_array(level.gasmachine.totalspawned,self);
}

//Function Number: 26
removefromtotalspawned()
{
	wait(0.05);
	level.gasmachine.totalspawned = common_scripts\utility::array_removeundefined(level.gasmachine.totalspawned);
}

//Function Number: 27
cranethink(param_00)
{
	var_01 = 5;
	var_02 = 5;
	for(;;)
	{
		if(level.gasmachine.chemical_racksactive == 1)
		{
			if(level.gasmachine.cranecollision.size > 0)
			{
				var_03 = randomint(100);
				if(var_03 > 40)
				{
					var_04 = spawncrane(param_00,1);
					if(isdefined(var_04))
					{
						var_04 thread startnotelisten(var_02,var_01);
					}
				}
			}

			wait(var_01 + var_02 + randomfloatrange(3,7));
			continue;
		}

		wait(1);
	}
}

//Function Number: 28
startnotelisten(param_00,param_01)
{
	thread watchcranenotetrack(param_00,param_01);
}

//Function Number: 29
watchcranenotetrack(param_00,param_01)
{
	self endon("death");
	self endon("deleted");
	for(;;)
	{
		self waittill("crane_note_track",var_02);
		if(var_02 == "crane_move_start")
		{
			if(level.gasmachine.chemical_racksactive == 0)
			{
				if(isdefined(self) && self.paused == 0)
				{
					self scriptmodelpauseanim(1);
					self.paused = 1;
					checkforunpause();
				}
			}
			else
			{
				thread maps\mp\_audio::snd_play_linked("emt_conveyor_belt_gears",self);
				thread maps\mp\_audio::snd_play_linked("emt_conveyor_belt_sparks",self);
				playfxontag(level.missileparticles.cranesparks,self,"TAG_ORIGIN");
			}

			continue;
		}

		if(var_02 == "crane_move_stop")
		{
			thread stopcranesound();
			stopfxontag(level.missileparticles.cranesparks,self,"TAG_ORIGIN");
			continue;
		}

		if(var_02 == "crane_wiggle_stop")
		{
			continue;
		}

		if(var_02 == "crane_particle_01" || var_02 == "crane_particle_02" || var_02 == "crane_particle_03")
		{
			thread spraycans(param_00,var_02);
			continue;
		}

		if(var_02 == "rotate_start")
		{
			thread rotatethink(param_00);
			continue;
		}

		if(var_02 == "rotate_stop")
		{
			thread stopcranesound();
			continue;
		}

		if(var_02 == "crane_finish")
		{
			thread removerack();
		}
	}
}

//Function Number: 30
checkforunpause()
{
	self endon("death");
	self endon("deleted");
	for(;;)
	{
		if(isdefined(self))
		{
			if(level.gasmachine.chemical_racksactive == 1)
			{
				if(self.paused == 1)
				{
					self scriptmodelpauseanim(0);
					self.paused = 0;
					thread maps\mp\_audio::snd_play_linked("emt_conveyor_belt_gears",self);
					thread maps\mp\_audio::snd_play_linked("emt_conveyor_belt_sparks",self);
					playfxontag(level.missileparticles.cranesparks,self,"TAG_ORIGIN");
					break;
				}
			}
		}
		else
		{
			break;
		}

		wait(0.5);
	}
}

//Function Number: 31
setuprobotarmnotetracks()
{
	var_00 = getentarray("lab2_robot_arm","targetname");
	foreach(var_02 in var_00)
	{
		wait(randomfloatrange(0,1));
		var_02 scriptmodelplayanimdeltamotion("lab2_robot_arm_01_idle_anim","emt_servo_sparks");
		var_02 thread watchrobotarmnotetrack();
	}
}

//Function Number: 32
watchrobotarmnotetrack()
{
	self endon("death");
	self endon("deleted");
	for(;;)
	{
		self waittill("emt_servo_sparks",var_00);
		if(isdefined(var_00) && var_00 == "robot_arm_sparks_on")
		{
			playfxontag(common_scripts\utility::getfx("welding_sparks"),self,"wristSwivel");
			continue;
		}

		if(isdefined(var_00) && var_00 == "emt_servo_sparks")
		{
			thread maps\mp\_audio::snd_play_linked("emt_servo_sparks",self);
		}
	}
}

//Function Number: 33
stopcranesound()
{
	self stopsounds();
	wait(0.05);
	thread maps\mp\_audio::snd_play_linked("mp_lab_missilerack_stop01",self);
}

//Function Number: 34
rotatethink(param_00)
{
	if(self.has_chemicals == 1)
	{
		if(level.gasmachine.chemical_racksactive == 1)
		{
			thread maps\mp\_audio::snd_play_in_space("emt_air_blast_turn",level.gasmachine.partciledrylocation.origin);
			thread maps\mp\_audio::snd_play_in_space("emt_air_blast_clean",level.gasmachine.partciledrylocation.origin);
			level.gasmachine.partciledrylocation thread particlespray(level.missileparticles.drymachine,level.gasmachine.partciledrylocation.angles,3);
			thread startcanisterfx(level.missileparticles.canistersteam,param_00);
			thread rotatedryerfan();
		}
	}
}

//Function Number: 35
rotatedryerfan()
{
	level.gasmachine.dryerfan rotatevelocity(level.gasmachine.dryerfanrotatevelocity,7,1,5);
}

//Function Number: 36
spraycans(param_00,param_01)
{
	if(self.has_chemicals == 1)
	{
		if(level.gasmachine.chemical_racksactive == 1)
		{
			thread particlespraymultiplenode(param_01,param_00);
			thread startcanisterfx(level.missileparticles.canisterdrips,param_00);
		}
	}
}

//Function Number: 37
spawncrane(param_00,param_01)
{
	var_02 = -210;
	var_03 = spawn("script_model",param_00[0].origin + (0,0,var_02));
	var_03 playcranespawnvfx();
	var_04 = getcollision(level.gasmachine.cranecollision);
	if(isdefined(var_04) && isdefined(var_04.collision))
	{
		var_03 setmodel("lab2_industrial_crane_01");
		var_03.paused = 0;
		var_03.cranecollision = var_04.collision;
		level.gasmachine.cranecollision = var_04.pool;
		var_03.cranecollision.origin = var_03.origin;
		var_03.cranecollision.angles = var_03.angles;
		var_03.cranecollision vehicle_jetbikesethoverforcescale(var_03);
		var_03 solid();
	}
	else
	{
		if(isdefined(var_03))
		{
			var_03 delete();
		}

		return undefined;
	}

	var_03 addtototalspawned();
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("lab_crane_arm_01_lights"),var_03,"TAG_ORIGIN");
	playfxontag(level.missileparticles.cranesparks,var_03,"TAG_ORIGIN");
	if(param_01 == 1)
	{
		var_04 = getcollision(level.gasmachine.cranechemcollision);
		if(isdefined(var_04) && isdefined(var_04.collision))
		{
			var_03.chemical_rack = spawn("script_model",var_03 gettagorigin("tag_cargo"));
			var_03.exploding = 0;
			var_03.chemical_rack setmodel("lab2_cannister_holder_01");
			var_03.chemical_rack linkto(var_03,"tag_cargo");
			var_03.chemical_rack addtototalspawned();
			var_03.has_chemicals = 1;
			var_03.chemical_rack solid();
			thread playorangegoo(var_03.chemical_rack);
			var_03.chemical_rack.damageradius = level.gasmachine.damageradius;
			var_03.chemical_rack.maxdamageamount = level.gasmachine.maxdamageamount;
			var_03.chemical_rack.mindamageamount = level.gasmachine.mindamageamount;
			var_03.chemical_rack thread watchdamagechemical(var_03);
			var_03.chemical_rack.cranechemcollision = var_04.collision;
			level.gasmachine.cranechemcollision = var_04.pool;
			var_03.chemical_rack.cranechemcollision thread common_scripts\utility::entity_path_disconnect_thread(1);
			var_03.chemical_rack.cranechemcollision.origin = var_03.chemical_rack.origin;
			var_03.chemical_rack.cranechemcollision.angles = var_03.chemical_rack.angles;
			var_03.chemical_rack.cranechemcollision vehicle_jetbikesethoverforcescale(var_03.chemical_rack);
		}
		else
		{
			var_03.has_chemicals = 0;
		}
	}
	else
	{
		var_03.has_chemicals = 0;
	}

	var_03 scriptmodelplayanimdeltamotion("lab2_industrial_crane_anim","crane_note_track");
	return var_03;
}

//Function Number: 38
playorangegoo(param_00)
{
	var_01 = 3;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		wait(0.05);
		if(isdefined(param_00) && !isremovedentity(param_00))
		{
			param_00 show();
			if(var_02 == 2)
			{
				var_03 = playfxontag(common_scripts\utility::getfx("lab_canister_liquid_orange"),param_00,"tag_origin");
				param_00 show();
			}

			continue;
		}

		return;
	}
}

//Function Number: 39
playcranespawnvfx()
{
	var_00 = 0.05;
	var_01 = level.gasmachine.particlespawnoriginoffset;
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	var_02 = self.origin + var_01;
	wait(var_00);
}

//Function Number: 40
getcollision(param_00)
{
	if(param_00.size > 0)
	{
		var_01 = spawnstruct();
		var_01.collision = param_00[param_00.size - 1];
		param_00 = common_scripts\utility::array_remove(param_00,var_01.collision);
		param_00 = common_scripts\utility::array_remove_duplicates(param_00);
		var_01.pool = param_00;
		return var_01;
	}
}

//Function Number: 41
addcollisiontopool(param_00)
{
	self notify("entity_path_disconnect_thread");
	self unlink();
	self.origin = (0,0,-5000);
	param_00 = common_scripts\utility::add_to_array(param_00,self);
	return param_00;
}

//Function Number: 42
watchdamagechemical(param_00)
{
	self endon("deleted");
	self endon("death");
	self.health = 10000000;
	self.fakehealth = level.gasmachine.totalchemcanhealth;
	self setcandamage(1);
	self setcanradiusdamage(1);
	self.leaking = 0;
	for(;;)
	{
		if(isdefined(self))
		{
			self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
			if(isdefined(var_0A))
			{
				var_0B = maps\mp\_utility::strip_suffix(var_0A,"_lefthand");
				switch(var_0B)
				{
					case "paint_grenade_mp":
					case "mp_lab_gas_explosion":
					case "smoke_grenade_mp":
					case "flash_grenade_mp":
					case "concussion_grenade_mp":
					case "mp_lab_gas":
						break;
				}

				if(issubstr(var_0A,"m990"))
				{
					if(var_05 == "MOD_PISTOL_BULLET")
					{
						var_01 = 50;
					}
					else if(var_05 == "MOD_EXPLOSIVE")
					{
						var_01 = 100;
					}
				}
			}

			if(isdefined(var_05))
			{
				if(maps\mp\_utility::ismeleemod(var_05) || var_05 == "MOD_TRIGGER_HURT")
				{
					continue;
				}
			}

			if(isdefined(var_02))
			{
				var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard");
			}

			if(param_00.exploding == 0)
			{
				self.fakehealth = self.fakehealth + var_01 * -1;
				if(self.fakehealth <= 0)
				{
					thread pauseracksystem();
					thread blowitup(param_00,var_02);
					level notify("Chemical_Exploded");
					break;
				}
			}
			else if(param_00.exploding == 1)
			{
				break;
			}

			continue;
		}

		if(!isdefined(self))
		{
			break;
		}
	}
}

//Function Number: 43
timebomb(param_00)
{
	self endon("deleted");
	self endon("death");
	thread timebombparticle(level.missileparticles.sparkgreenloop);
	var_01 = level.gasmachine.totalchemcanhealth * 0.05;
	var_01 = int(var_01);
	while(isdefined(self))
	{
		wait(1);
		self notify("damage",var_01,param_00);
	}
}

//Function Number: 44
timebombparticle(param_00)
{
	thread common_scripts\utility::play_loop_sound_on_entity("mp_lab_gas_leak_loop01",(0,0,64));
	playfxontag(param_00,self,"tag_origin");
}

//Function Number: 45
blowitup(param_00,param_01)
{
	param_00 endon("death");
	var_02 = 0.1;
	param_00.exploding = 1;
	var_03 = self.origin;
	if(isdefined(self) && !isremovedentity(self))
	{
		if(isdefined(self.cranechemcollision))
		{
			self notify("entity_path_disconnect_thread");
			self.cranechemcollision connectpaths();
		}
	}

	var_04 = level.gasmachine.explosionoffset;
	var_05 = level.gasmachine.explosionangleoffset;
	var_06 = thread common_scripts\utility::spawn_tag_origin();
	var_06 show();
	var_06 dontinterpolate();
	var_06.origin = param_00.origin + (0,0,var_04);
	var_06.angles = var_05;
	var_06 vehicle_jetbikesethoverforcescale(param_00,"tag_origin");
	playfxontag(level.missileparticles.missileexplosion,var_06,"tag_origin");
	var_06 thread deleteexplosiontag(param_00,self,0.05);
	var_07 = param_00.origin + (0,0,var_04);
	thread aud_play_tank_explosion(var_07);
	wait(0.05);
	if(isdefined(self) && !isremovedentity(self))
	{
		if(isdefined(self.cranechemcollision))
		{
			level.gasmachine.cranechemcollision = self.cranechemcollision addcollisiontopool(level.gasmachine.cranechemcollision);
		}

		killfxontag(common_scripts\utility::getfx("lab_canister_liquid_orange"),self,"tag_origin");
		maps\mp\_utility::delaythread(var_02,::unlinkanddelete);
	}

	if(isdefined(param_00) && !isremovedentity(param_00))
	{
		param_00.has_chemicals = 0;
	}

	wait(var_02 + 0.05);
	thread missileexplosion(param_01,var_03);
	thread missilechem(level.missileparticles.greensmokeloop,var_03 + (0,0,-70),param_01);
}

//Function Number: 46
deleteexplosiontag(param_00,param_01,param_02)
{
	param_01 common_scripts\utility::waittill_any("death","deleted");
	wait(param_02);
	if(isdefined(self) && !isremovedentity(self))
	{
		self delete();
	}
}

//Function Number: 47
killchemrackvfx()
{
	self endon("death");
	wait(0.05);
	if(isdefined(self) && !isremovedentity(self))
	{
		killfxontag(common_scripts\utility::getfx("lab_canister_liquid_orange"),self,"tag_origin");
		wait(0.05);
		if(isdefined(self) && !isremovedentity(self))
		{
			self delete();
		}
	}
}

//Function Number: 48
unlinkanddelete()
{
	if(isdefined(self) && !isremovedentity(self))
	{
		self unlink();
		self delete();
	}
}

//Function Number: 49
missileexplosion(param_00,param_01)
{
	if(isdefined(param_00))
	{
		radiusdamage(param_01 + (0,0,-44),level.gasmachine.damageradius,level.gasmachine.maxdamageamount,level.gasmachine.mindamageamount,param_00,"MOD_EXPLOSIVE","mp_lab_gas_explosion");
		return;
	}

	radiusdamage(param_01 + (0,0,-44),level.gasmachine.damageradius,level.gasmachine.maxdamageamount,level.gasmachine.mindamageamount,undefined,"MOD_EXPLOSIVE","mp_lab_gas_explosion");
}

//Function Number: 50
missilechem(param_00,param_01,param_02)
{
	level.gasparticletime = level.pausetime * 0.15;
	var_03 = spawnfx(param_00,param_01 + (0,0,0));
	var_04 = spawn("script_origin",param_01);
	thread chemdamagethink(var_04,param_01,param_02);
	wait(level.gasparticletime);
	wait(5);
	var_04 notify("Gas_Particle_Gone");
	wait(1);
	var_04 deletedefined();
	var_03 deletedefined();
}

//Function Number: 51
deletedefined()
{
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 52
chemdamagethink(param_00,param_01,param_02)
{
	param_00 endon("Gas_Particle_Gone");
	for(;;)
	{
		if(isdefined(param_02))
		{
			param_02 radiusdamage(param_01,level.gasmachine.gasrange,10,10,param_02,"MOD_TRIGGER_HURT","mp_lab_gas");
		}
		else
		{
			radiusdamage(param_01,level.gasmachine.gasrange,10,10,undefined,"MOD_TRIGGER_HURT","mp_lab_gas");
		}

		thread findshockvictims(param_01);
		wait(1);
	}
}

//Function Number: 53
findshockvictims(param_00)
{
	var_01 = level.gasmachine.gasrange * level.gasmachine.gasrange;
	foreach(var_03 in level.players)
	{
		if(!var_03 maps\mp\_utility::isusingremote())
		{
			var_04 = distancesquared(var_03.origin,param_00);
			if(var_04 < var_01 && !var_03 maps\mp\_utility::_hasperk("specialty_stun_resistance"))
			{
				var_03 thread shockthink();
			}
		}
	}
}

//Function Number: 54
shockthink()
{
	if(self.gastime <= 0)
	{
		thread fadeinoutgastrackingoverlay();
		thread rempveoverlaydeath();
	}

	self.gastime = 2;
	self shellshock("mp_lab_gas",1);
	while(self.gastime > 0)
	{
		self.gastime--;
		wait(1);
	}

	self notify("gas_end");
	endgastrackingoverlay();
}

//Function Number: 55
rempveoverlaydeath()
{
	self endon("gas_end");
	self waittill("death");
	thread endgastrackingoverlaydeath();
}

//Function Number: 56
particlespraymultiplenode(param_00,param_01)
{
	foreach(var_03 in level.gasmachine.machinesparkarray)
	{
		if(var_03.script_noteworthy == param_00)
		{
			self playsound("emt_water_spray_hard");
			var_03 thread particlespray(level.missileparticles.spraymachine,var_03.angles,param_01);
		}
	}

	foreach(var_03 in level.gasmachine.sprayerdriparray)
	{
		if(var_03.script_noteworthy == param_00)
		{
			var_03 thread sprayerdrip(level.missileparticles.spraymachinedrips,var_03.angles,param_01);
		}
	}
}

//Function Number: 57
startcanisterfx(param_00,param_01)
{
	wait(param_01);
	var_02 = 0;
	var_03 = 0.1;
	while(var_02 < 4.25)
	{
		if(isdefined(self) && self.has_chemicals == 1)
		{
			var_04 = self.origin + (0,0,-8);
			var_05 = self.angles + (270,0,0);
			playfx(param_00,var_04,anglestoforward(var_05),anglestoup(var_05));
			wait(var_03);
			var_02 = var_02 + var_03;
			continue;
		}

		return;
	}
}

//Function Number: 58
particlespray(param_00,param_01,param_02)
{
	var_03 = spawnfx(param_00,self.origin,anglestoforward(param_01),anglestoup(param_01));
	triggerfx(var_03);
	if(isdefined(param_02))
	{
		wait(param_02);
	}

	if(isdefined(var_03))
	{
		var_03 delete();
	}
}

//Function Number: 59
sprayerdrip(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		wait(param_02);
	}

	playfx(param_00,self.origin,anglestoforward(param_01),anglestoup(param_01));
}

//Function Number: 60
removerack()
{
	if(isdefined(self) && !isremovedentity(self))
	{
		if(isdefined(self.chemical_rack) && !isremovedentity(self.chemical_rack))
		{
			killfxontag(common_scripts\utility::getfx("lab_canister_liquid_orange"),self.chemical_rack,"tag_origin");
		}

		wait(0.05);
		if(isdefined(self) && !isremovedentity(self))
		{
			if(isdefined(self.chemical_rack) && !isremovedentity(self.chemical_rack))
			{
				if(isdefined(self.chemical_rack.cranechemcollision))
				{
					level.gasmachine.cranechemcollision = self.chemical_rack.cranechemcollision addcollisiontopool(level.gasmachine.cranechemcollision);
				}

				self.chemical_rack unlink();
				self.chemical_rack delete();
			}

			level.gasmachine.cranecollision = self.cranecollision addcollisiontopool(level.gasmachine.cranecollision);
			self notify("deleted");
			self delete();
		}
	}

	thread removefromtotalspawned();
}

//Function Number: 61
pauseracksystem()
{
	if(!isdefined(level.pausetime))
	{
		level.pausetime = 20;
	}

	level.gasmachine.chemical_rackpausetime = level.pausetime;
	if(level.gasmachine.chemical_racksactive == 1)
	{
		common_scripts\utility::array_thread(level.alarmsystem.spinnerarray,::spinalarmsstart);
	}

	if(level.gasmachine.chemical_racksactive == 1)
	{
		thread playalarmloop();
	}
	else
	{
		return;
	}

	level.gasmachine.chemical_racksactive = 0;
	while(level.gasmachine.chemical_rackpausetime > 0)
	{
		wait(1);
		level.gasmachine.chemical_rackpausetime--;
	}

	common_scripts\utility::array_thread(level.alarmsystem.spinnerarray,::spinalarmsstop);
	level.gasmachine.chemical_racksactive = 1;
	level notify("Restarting_System");
}

//Function Number: 62
spinalarmsstart()
{
	self hide();
	level thread common_scripts\_exploder::activate_clientside_exploder(200);
}

//Function Number: 63
spinalarmsstop()
{
	self show();
	stopclientexploder(200);
}

//Function Number: 64
playalarmloop()
{
	var_00 = spawn("script_origin",level.alarmsystem.alarmsoundent.origin);
	var_00 playloopsound("mp_lab_alarm_shutdown01");
	wait(5);
	var_00 stopsounds();
	wait(0.05);
	var_00 delete();
}

//Function Number: 65
creategastrackingoverlay()
{
	if(!isdefined(self.gastrackingoverlay))
	{
		self.gastrackingoverlay = newclienthudelem(self);
		self.gastrackingoverlay.x = 0;
		self.gastrackingoverlay.y = 0;
		self.gastrackingoverlay setshader("lab_gas_overlay",640,480);
		self.gastrackingoverlay.alignx = "left";
		self.gastrackingoverlay.aligny = "top";
		self.gastrackingoverlay.horzalign = "fullscreen";
		self.gastrackingoverlay.vertalign = "fullscreen";
		self.gastrackingoverlay.alpha = 0;
	}
}

//Function Number: 66
fadeinoutgastrackingoverlay()
{
	level endon("game_ended");
	self endon("gas_end");
	self endon("death");
	if(isdefined(self.gastrackingoverlay))
	{
		for(;;)
		{
			self.gastrackingoverlay fadeovertime(0.4);
			self.gastrackingoverlay.alpha = 1;
			wait(0.5);
			self.gastrackingoverlay fadeovertime(0.4);
			self.gastrackingoverlay.alpha = 0.5;
			wait(0.5);
		}
	}
}

//Function Number: 67
endgastrackingoverlay()
{
	if(isdefined(self.gastrackingoverlay))
	{
		self.gastrackingoverlay fadeovertime(0.2);
		self.gastrackingoverlay.alpha = 0;
	}
}

//Function Number: 68
endgastrackingoverlaydeath()
{
	if(isdefined(self.gastrackingoverlay))
	{
		self.gastrackingoverlay.alpha = 0;
	}
}

//Function Number: 69
setup_audio()
{
}

//Function Number: 70
aud_play_tank_explosion(param_00)
{
	thread maps\mp\_audio::snd_play_in_space("lab2_tank_exp",param_00);
}

//Function Number: 71
aud_transport_chopper()
{
	var_00 = self;
	var_01 = "veh_drone_heavy_lifter_lp";
	thread maps\mp\_audio::snd_play_linked_loop(var_01,var_00);
	var_00 thread aud_warning_vo();
}

//Function Number: 72
aud_warning_vo()
{
	wait(32);
	thread maps\mp\_audio::snd_play_linked("vo_heli_warn_ext",self);
	wait(6.5);
	thread maps\mp\_audio::snd_play_linked("vo_heli_warn_ext",self);
}

//Function Number: 73
aud_building_pre_drop()
{
	thread maps\mp\_audio::snd_play_linked("lab2_building_sway",self);
}

//Function Number: 74
aud_building_drop()
{
	thread maps\mp\_audio::snd_play_linked("lab2_building_drop",self);
}