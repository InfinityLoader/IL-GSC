/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_urban.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 41
 * Decompile Time: 634 ms
 * Timestamp: 4/22/2024 2:18:40 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::urbancallbackstartgametype;
	maps\mp\mp_urban_precache::main();
	maps\createart\mp_urban_art::main();
	maps\mp\mp_urban_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_urban_lighting::main();
	maps\mp\mp_urban_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_urban");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.orbitalsupportoverridefunc = ::urbancustomospfunc;
	level.orbitallaseroverridefunc = ::urbanvulcancustomfunc;
	level.remote_missile_height_override = 20000;
	level thread urbanbombingruncustomfunc();
	level thread lockdownevent();
	if(level.nextgen)
	{
		level thread urbansetuphoverbike();
		level thread urbananimateriders();
		level thread urbananimatedrones();
	}

	level thread setuppolicelights();
	level thread urbanruneffectsfloor();
	level thread urbanpatchwarbird();
	level thread urbanpatchclip();
	level thread urbanshiftbombdefusetrigger();
}

//Function Number: 2
urbancallbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 3
urbancustomospfunc()
{
	level.orbitalsupportoverrides.spawnanglemin = 10;
	level.orbitalsupportoverrides.spawnanglemax = 90;
	level.orbitalsupportoverrides.spawnheight = 9275;
	level.orbitalsupportoverrides.spawnradius = 6000;
	level.orbitalsupportoverrides.speed = 246;
	level.orbitalsupportoverrides.leftarc = 20;
	level.orbitalsupportoverrides.rightarc = 20;
	level.orbitalsupportoverrides.toparc = -40;
	level.orbitalsupportoverrides.bottomarc = 60;
}

//Function Number: 4
urbanvulcancustomfunc()
{
	if(level.nextgen)
	{
		level.orbitallaseroverrides.spawnpoint = (300,0,0);
		return;
	}

	level.orbitallaseroverrides.spawnpoint = (300,0,800);
}

//Function Number: 5
urbanbombingruncustomfunc()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 100;
}

//Function Number: 6
lockdownevent()
{
	if(getdvarint("r_reflectionProbeGenerate"))
	{
		return;
	}

	urbandoorssetup();
	urbansetupshutters();
	if(level.gametype == "ball" || level.gametype == "twar" || level.gametype == "hp" || level.gametype == "infect" || level.gametype == "sr" || level.gametype == "sd")
	{
		urbanreleaselockdown();
		return;
	}

	level.dynamicspawns = ::urbandynamicspawns;
	level thread maps\mp\_dynamic_events::dynamicevent(::event_start,::event_reset);
	level thread urbanlevelstart();
}

//Function Number: 7
event_start()
{
	thread maps\mp\mp_urban_aud::aud_lockdown_siren();
	level thread playannouncementreleasevo();
	wait(5);
	urbanreleaselockdown();
}

//Function Number: 8
playannouncementreleasevo()
{
	wait(0.5);
	playsoundatpos((-142,6,2550),"mp_anr_urb_dyn_off_r");
	wait(3);
	playsoundatpos((-142,6,2550),"mp_anr_urb_dyn_off_spn_r");
}

//Function Number: 9
playannouncementlockdownvo()
{
	if(level.currentgen)
	{
		wait(8);
		playsoundatpos((-142,6,2550),"mp_anr_urb_dyn_on_r");
		wait(2);
		playsoundatpos((-142,6,2550),"mp_anr_urb_dyn_on_spn_r");
		return;
	}

	wait(0.5);
	playsoundatpos((-142,6,2550),"mp_anr_urb_dyn_on_r");
	wait(3);
	playsoundatpos((-142,6,2550),"mp_anr_urb_dyn_on_spn_r");
}

//Function Number: 10
event_reset()
{
	urbanlockdown();
}

//Function Number: 11
urbanlevelstart()
{
	level endon("urbanReleaseLockdown");
	urbanblockerssolid();
	urbananimateopenloop();
	urbandoorsswingshut();
	while(!isdefined(level.prematchperiod))
	{
		wait 0.05;
	}

	var_00 = 5;
	if(level.prematchperiod > 0)
	{
		if(level.prematchperiodend > 0 && !isdefined(level.hostmigrationtimer))
		{
			if(level.prematchperiodend == 5)
			{
				wait(2);
			}
			else if(level.prematchperiodend > 5)
			{
				wait(3.5);
			}
		}
	}
	else
	{
		var_00 = 2;
	}

	thread maps\mp\mp_urban_aud::aud_lockdown_siren();
	level thread playannouncementlockdownvo();
	wait(var_00);
	urbanlockdown();
}

//Function Number: 12
urbandoorssetup()
{
	var_00 = getent("lockdown_doors","targetname");
	if(isdefined(var_00))
	{
		var_00.lockdown = 1;
	}

	var_00 = getentarray("door_swing_left","targetname");
	if(isdefined(var_00) && var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			var_02.open = 1;
		}
	}

	var_00 = getentarray("door_swing_right","targetname");
	if(isdefined(var_00) && var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			var_02.open = 1;
		}
	}
}

//Function Number: 13
urbandoorsclose()
{
	var_00 = getent("lockdown_doors","targetname");
	if(!isdefined(var_00) || var_00.lockdown)
	{
		return;
	}

	var_00.lockdown = 0;
	var_00 moveto(var_00.startorg,3,1,0.2);
	wait(3.1);
	var_00 disconnectpaths();
	urbandoorsswingshut();
}

//Function Number: 14
urbandoorsswingshut()
{
	var_00 = getentarray("door_swing_left","targetname");
	if(isdefined(var_00) && var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			if(!var_02.open)
			{
				continue;
			}

			var_02 rotateyaw(-90,1.5,0.5,0.1);
			var_02.open = 0;
		}
	}

	var_04 = getentarray("door_swing_right","targetname");
	if(isdefined(var_04) && var_04.size > 0)
	{
		foreach(var_02 in var_04)
		{
			if(!var_02.open)
			{
				continue;
			}

			var_02 rotateyaw(90,1.5,0.5,0.1);
			var_02.open = 0;
		}
	}
}

//Function Number: 15
urbandoorsopen()
{
	var_00 = getent("lockdown_doors","targetname");
	if(!isdefined(var_00) || !var_00.lockdown)
	{
		return;
	}

	var_00.lockdown = 1;
	if(!isdefined(var_00.startorg))
	{
		var_00.startorg = var_00.origin;
	}

	var_01 = var_00.startorg + (0,0,-98);
	var_00 moveto(var_01,3,1,0.2);
	wait(3.1);
	var_00 disconnectpaths();
	urbandoorsswingopen();
}

//Function Number: 16
urbandoorsswingopen()
{
	var_00 = getentarray("door_swing_left","targetname");
	if(isdefined(var_00) && var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			if(var_02.open)
			{
				continue;
			}

			var_02 rotateyaw(90,1.5,0.5,0.1);
			var_02.open = 1;
		}
	}

	var_04 = getentarray("door_swing_right","targetname");
	if(isdefined(var_04) && var_04.size > 0)
	{
		foreach(var_02 in var_04)
		{
			if(var_02.open)
			{
				continue;
			}

			var_02 rotateyaw(-90,1.5,0.5,0.1);
			var_02.open = 1;
		}
	}
}

//Function Number: 17
urbanlockdown()
{
	level notify("urbanLockdown");
	urbanblockerssolid();
	common_scripts\_exploder::activate_exploder(50);
	level thread urbandoorsclose();
	urbananimatelockdown();
}

//Function Number: 18
urbanblockerssolid()
{
	var_00 = getent("lockdown_blocker","targetname");
	var_00 show();
	var_00 disconnectpaths();
	var_00 solid();
	level.dynamicspawns = ::urbandynamicspawns;
}

//Function Number: 19
urbanreleaselockdown()
{
	level notify("urbanReleaseLockdown");
	urbanblockersnonsolid();
	level thread urbandoorsopen();
	urbananimatereleaselockdown();
	common_scripts\_exploder::activate_exploder(20);
}

//Function Number: 20
urbanblockersnonsolid()
{
	var_00 = getent("lockdown_blocker","targetname");
	var_00 hide();
	var_00 connectpaths();
	var_00 notsolid();
	level.dynamicspawns = undefined;
}

//Function Number: 21
urbandynamicspawns(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.script_noteworthy) || var_03.script_noteworthy != "lockdown_spawn")
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 22
urbansetupshutters()
{
	level.urbanshutters = [];
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_side_bottom_right_01","urban_front_bottom_shutter_1","urban_front_bottom_shutter_close_1","urban_front_bottom_shutter_loop_1");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_side_top_right_01","urban_side_top_shutter_1","urban_side_top_shutter_close_1","urban_side_top_shutter_loop_1");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_side_top_right_02","urban_side_top_shutter_1","urban_side_top_shutter_close_1","urban_side_top_shutter_loop_1");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_top_right_01","urban_front_top_shutter_1","urban_front_top_shutter_close_1","urban_front_top_shutter_loop_1");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_top_right_02","urban_front_top_shutter_2","urban_front_top_shutter_close_2","urban_front_top_shutter_loop_2");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_top_right_03","urban_front_top_shutter_3","urban_front_top_shutter_close_3","urban_front_top_shutter_loop_3");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_top_right_04","urban_front_top_shutter_4","urban_front_top_shutter_close_4","urban_front_top_shutter_loop_4");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_bottom_right_01","urban_side_bottom_shutter_1","urban_side_bottom_shutter_close_1","urban_side_bottom_shutter_loop_1");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_side_bottom_left_01","urban_front_bottom_shutter_1","urban_front_bottom_shutter_close_1","urban_front_bottom_shutter_loop_1");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_side_top_left_01","urban_side_top_shutter_1","urban_side_top_shutter_close_1","urban_side_top_shutter_loop_1");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_side_top_left_02","urban_side_top_shutter_1","urban_side_top_shutter_close_1","urban_side_top_shutter_loop_1");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_top_left_01","urban_front_top_shutter_1","urban_front_top_shutter_close_1","urban_front_top_shutter_loop_1");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_top_left_02","urban_front_top_shutter_2","urban_front_top_shutter_close_2","urban_front_top_shutter_loop_2");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_top_left_03","urban_front_top_shutter_3","urban_front_top_shutter_close_3","urban_front_top_shutter_loop_3");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_top_left_04","urban_front_top_shutter_4","urban_front_top_shutter_close_4","urban_front_top_shutter_loop_4");
	level.urbanshutters[level.urbanshutters.size] = urbansetupshutter("shutter_front_bottom_left_01","urban_side_bottom_shutter_1","urban_side_bottom_shutter_close_1","urban_side_bottom_shutter_loop_1");
}

//Function Number: 23
urbansetupshutter(param_00,param_01,param_02,param_03)
{
	var_04 = getent(param_00,"targetname");
	var_05 = spawnstruct();
	var_05.name = param_00;
	var_05.closeanim = param_01;
	var_05.openanim = param_02;
	var_05.loopingopenanim = param_03;
	var_05.ent = var_04;
	return var_05;
}

//Function Number: 24
urbananimateopenloop()
{
	foreach(var_01 in level.urbanshutters)
	{
		if(!isdefined(var_01.ent))
		{
			continue;
		}

		if(var_01.closeanim != "")
		{
			var_01.ent scriptmodelplayanimdeltamotion(var_01.loopingopenanim);
		}
	}
}

//Function Number: 25
urbananimatelockdown()
{
	foreach(var_01 in level.urbanshutters)
	{
		if(!isdefined(var_01.ent))
		{
			continue;
		}

		var_01.ent scriptmodelclearanim();
		if(var_01.closeanim == "")
		{
			var_01.ent show();
			continue;
		}

		var_01.ent scriptmodelplayanimdeltamotion(var_01.closeanim);
	}
}

//Function Number: 26
urbananimatereleaselockdown()
{
	foreach(var_01 in level.urbanshutters)
	{
		if(!isdefined(var_01.ent))
		{
			continue;
		}

		var_01.ent scriptmodelclearanim();
		if(var_01.openanim == "")
		{
			var_01.ent hide();
			continue;
		}

		var_01.ent scriptmodelplayanimdeltamotion(var_01.openanim);
	}
}

//Function Number: 27
urbansetuphoverbike()
{
	var_00 = getentarray("hoverbike","targetname");
	if(!isdefined(var_00) || var_00.size == 0)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		var_02 scriptmodelplayanim("urban_hoverbike_idle","nothing");
	}
}

//Function Number: 28
urbananimateriders()
{
	var_00 = 380;
	var_01 = 30;
	var_02 = var_00 / var_01;
	var_03 = 20000;
	var_04 = common_scripts\utility::getstruct("urban_event_scripted_node","targetname");
	if(!isdefined(var_04))
	{
		return;
	}

	if(!isdefined(var_04.angles))
	{
		var_04.angles = (0,0,0);
	}

	var_05 = spawn("script_model",(0,0,0));
	var_05 setmodel("vehicle_urb_police_hoverbike_ai");
	var_06 = spawn("script_model",(0,0,0));
	var_06 setmodel("vehicle_urb_police_hoverbike_ai");
	var_07 = spawn("script_model",(0,0,0));
	var_07 setmodel("urb_hoverbike_rider");
	var_08 = spawn("script_model",(0,0,0));
	var_08 setmodel("urb_hoverbike_rider");
	var_05 playloopsound("jtbk_engine");
	wait 0.05;
	var_07 vehicle_jetbikesethoverforcescale(var_05,"tag_driver",(0,0,0),(0,90,0));
	var_08 vehicle_jetbikesethoverforcescale(var_06,"tag_driver",(0,0,0),(0,90,0));
	wait(1);
	level thread urbancalculatebikeunitspersecond(var_05);
	level thread urbancalculatebikeunitspersecond(var_06);
	for(;;)
	{
		var_05 scriptmodelplayanimdeltamotionfrompos("urban_hoverbike_racer_1",var_04.origin,var_04.angles);
		var_06 scriptmodelplayanimdeltamotionfrompos("urban_hoverbike_racer_2",var_04.origin,var_04.angles);
		wait(var_02);
		var_09 = max(var_05.unitspersecond,var_06.unitspersecond);
		var_0A = var_03 / var_09 * 3;
		var_0B = urbanmovebikeforward(var_05,var_03,var_0A);
		var_0C = urbanmovebikeforward(var_06,var_03,var_0A);
		var_0D = max(var_0B,var_0C);
		wait(var_0D + 0.1);
	}
}

//Function Number: 29
urbanmovebikeforward(param_00,param_01,param_02)
{
	param_00 scriptmodelclearanim();
	var_03 = anglestoforward(param_00.angles);
	var_04 = param_00.origin + var_03 * param_01;
	param_00 moveto(var_04,param_02,1,0);
	return param_02;
}

//Function Number: 30
urbancalculatebikeunitspersecond(param_00)
{
	var_01 = 2;
	param_00.unitspersecond = 0;
	for(;;)
	{
		var_02 = param_00.origin;
		wait(var_01);
		var_03 = param_00.origin;
		param_00.unitspersecond = distance(var_02,var_03) / var_01;
	}
}

//Function Number: 31
urbananimatedrones()
{
	var_00 = common_scripts\utility::getstruct("urban_event_scripted_node","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.angles))
	{
		var_00.angles = (0,0,0);
	}

	level thread urbanspawnautoloopingdrone(var_00,"urban_drone_patrol_1");
	level thread urbanspawnmanualloopingdrone(var_00,"urban_drone_patrol_2");
	level thread urbanspawnmanualloopingdrone(var_00,"urban_drone_patrol_3");
}

//Function Number: 32
urbanspawnautoloopingdrone(param_00,param_01)
{
	var_02 = spawn("script_model",(0,0,0));
	var_02 setmodel("vehicle_urb_police_drone_01_group_anim");
	wait(1);
	var_02 playloopsound("drone_group_flyby");
	var_02 scriptmodelplayanimdeltamotionfrompos(param_01,param_00.origin,param_00.angles);
}

//Function Number: 33
urbanspawnmanualloopingdrone(param_00,param_01)
{
	var_02 = 1000;
	var_03 = 30;
	var_04 = var_02 / var_03;
	var_05 = spawn("script_model",(0,0,0));
	var_05 setmodel("vehicle_urb_police_drone_01_group_anim");
	wait(1);
	var_05 playloopsound("drone_group_flyby");
	for(;;)
	{
		var_05 scriptmodelplayanimdeltamotionfrompos(param_01,param_00.origin,param_00.angles);
		wait(var_04);
		wait(randomintrange(0,10));
	}
}

//Function Number: 34
setuppolicelights()
{
	if(getdvarint("r_reflectionProbeGenerate"))
	{
		return;
	}

	var_00 = getscriptablearray("police_light","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate(0,1);
	}
}

//Function Number: 35
urbanruneffectsfloor()
{
	var_00 = getent("urban_fx_floor","targetname");
	level.urbflooreffectsents = getentarray("urban_fx_step","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(isdefined(level.players))
	{
		foreach(var_02 in level.players)
		{
			var_02 playerassigneffectsent();
			var_02 thread playerruneffectsfloor(var_00);
		}
	}

	level thread onplayerconnectedeffectsfloor(var_00);
}

//Function Number: 36
onplayerconnectedeffectsfloor(param_00)
{
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 playerassigneffectsent();
		var_01 thread playerruneffectsfloor(param_00);
	}
}

//Function Number: 37
playerassigneffectsent()
{
	foreach(var_01 in level.urbflooreffectsents)
	{
		if(!isdefined(var_01.assigned))
		{
			var_01.assigned = self;
			var_01.angles = (-90,0,0);
			self.urbflooreffectsent = var_01;
			return;
		}
	}

	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("tag_origin");
	var_01.angles = (-90,0,0);
	level.urbflooreffectsents[level.urbflooreffectsents.size] = var_01;
	var_01.assigned = self;
	self.urbflooreffectsent = var_01;
}

//Function Number: 38
playerruneffectsfloor(param_00)
{
	self endon("disconnect");
	var_01 = 0.5;
	var_02 = 1;
	var_03 = 1;
	for(;;)
	{
		var_02 = var_03;
		if(!isalive(self))
		{
			var_03 = 0;
			wait 0.05;
			continue;
		}

		var_03 = self isonground();
		if(!var_03)
		{
			wait 0.05;
			continue;
		}

		var_04 = length(self getvelocity());
		if(var_04 == 0 && var_02 && var_03)
		{
			wait 0.05;
			continue;
		}

		var_05 = self istouching(param_00);
		if(!var_05)
		{
			wait 0.05;
			continue;
		}

		self.urbflooreffectsent dontinterpolate();
		self.urbflooreffectsent.origin = (self.origin[0],self.origin[1],2043.5);
		self.urbflooreffectsent.angles = (-90,self.angles[1],0);
		playfxontag(common_scripts\utility::getfx("mp_ub_foot_digital"),self.urbflooreffectsent,"tag_origin");
		wait(var_01);
	}
}

//Function Number: 39
urbanpatchwarbird()
{
	level.warbirdaiattackbasespeed = 20;
	level.warbirdaiattackneargoal = 300;
	maps\mp\killstreaks\_aerial_utility::patchheliloopnode((147,1524,4400),(467,1524,4400));
	maps\mp\killstreaks\_aerial_utility::patchheliloopnode((129,-11,4372),(449,-11,4372));
	maps\mp\killstreaks\_aerial_utility::patchheliloopnode((772,1692,4400),(1028,1692,4400));
	maps\mp\killstreaks\_aerial_utility::patchheliloopnode((1252,1156,4404),(1508,1156,4404));
	maps\mp\killstreaks\_aerial_utility::patchheliloopnode((1424,-1368,4360),(1508,-1368,4360));
	maps\mp\killstreaks\_aerial_utility::patchheliloopnode((428,-1992,4400),(748,-1992,4400));
	maps\mp\killstreaks\_aerial_utility::patchheliloopnode((148,-1556,4392),(468,-1556,4392));
	maps\mp\killstreaks\_aerial_utility::patchheliloopnode((544.5,-1392,4384),(864.5,-1392,4384));
}

//Function Number: 40
urbanpatchclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-354,-1280,2688),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-354,-1024,2688),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-354,-768,2688),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-354,768,2688),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-354,1024,2688),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-354,1280,2688),(0,0,0));
}

//Function Number: 41
urbanshiftbombdefusetrigger()
{
	if(level.gametype != "sd" && level.gametype != "sr")
	{
		return;
	}

	var_00 = getentarray("bombzone","targetname");
	var_01 = var_00[0];
	if(var_00[1].origin[0] < 0)
	{
		var_01 = var_00[1];
	}

	var_02 = getentarray(var_01.target,"targetname");
	var_03 = getent(var_02[0].target,"targetname");
	for(;;)
	{
		level waittill("bomb_planted",var_04);
		if(isdefined(var_04) && isdefined(var_04.bombdefusetrig) && var_04.bombdefusetrig == var_03 && var_03.origin[0] < -555)
		{
			var_03.origin = (-555,var_03.origin[1],var_03.origin[2]);
		}
	}
}