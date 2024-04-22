/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_highrise2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 316 ms
 * Timestamp: 4/22/2024 2:17:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::highrise2_callbackstartgametype;
	common_scripts\_mp_pipes::main();
	maps\mp\mp_highrise2_precache::main();
	maps\createart\mp_highrise2_art::main();
	maps\mp\mp_highrise2_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_highrise2_lighting::main();
	maps\mp\mp_highrise2_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_highrise2");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.ospvisionset = "mp_highrise2_osp";
	level.osplightset = "mp_highrise2_osp";
	level.dronevisionset = "mp_highrise2_drone";
	level.dronelightset = "mp_highrise2_drone";
	level.warbirdvisionset = "mp_highrise2_warbird";
	level.warbirdlightset = "mp_highrise2_warbird";
	setdvar("sm_minSpotLightScore",0.0005);
	level thread droneanims();
	level thread resetuplinkballoutofbounds();
	level thread customairstrikeheight();
	level.orbitalsupportoverridefunc = ::custompaladinoverrides;
	level.orbitallaseroverridefunc = ::customlaserstreakfunc;
	level.pipes_use_simple_normal = 1;
	thread scriptinvalidcarepackagearea();
	if(level.nextgen)
	{
		thread scriptpatchclip();
	}

	thread scriptpatchkilltrigger();
}

//Function Number: 2
scriptpatchkilltrigger()
{
	thread spawnkilltriggerthink((346,6398,3097),108,128);
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
		if(isdefined(var_04) && isplayer(var_04) && isdefined(var_04.health))
		{
			var_04 dodamage(var_04.health + 999,var_03.origin);
		}
	}
}

//Function Number: 4
highrise2_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 5
customairstrikeheight()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 4700;
}

//Function Number: 6
custompaladinoverrides()
{
	var_00 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
	level.orbitalsupportoverrides.spawnorigin = var_00.origin;
	level.orbitalsupportoverrides.spawnheight = 10000;
	level.orbitalsupportoverrides.bottomarc = 60;
	level.orbitalsupportoverrides.leftarc = 35;
	level.orbitalsupportoverrides.rightarc = 35;
	level.orbitalsupportoverrides.toparc = -30;
	level.orbitalsupportoverrides.spawnradius = 6000;
}

//Function Number: 7
customlaserstreakfunc()
{
	var_00 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
	level.orbitallaseroverrides.spawnpoint = var_00.origin;
	level.orbitallaseroverrides.spawnheight = var_00.origin[2] - 3550;
}

//Function Number: 8
droneanims()
{
	var_00 = getentarray("drone_lift_animated","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = "hr_drone_idle_01";
		if(isdefined(var_02.script_parameters))
		{
			var_03 = var_02.script_parameters;
		}

		var_02 thread animatedrone(var_03);
	}

	if(level.nextgen)
	{
		thread spawmdroneandanimate("hr2_drone_lift_nocable_rig_01","hr_drone_flight_01",(364,16624,2000),(0,0,0));
		thread spawmdroneandanimate("hr2_drone_lift_nocable_rig_01","hr_drone_flight_01",(-3124,-12888,4434),(0,0,0));
	}
}

//Function Number: 9
animatedrone(param_00)
{
	wait(0.05);
	self scriptmodelplayanim(param_00);
	playfxontag(common_scripts\utility::getfx("mp_hr2_drone_lightbeam"),self,"tag_light");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("mp_hr2_drone_prop_wind"),self,"tag_light");
	wait 0.05;
}

//Function Number: 10
spawmdroneandanimate(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_02);
	var_04 setmodel(param_00);
	var_04.angles = param_03;
	wait(0.05);
	var_04 scriptmodelplayanim(param_01);
	playfxontag(common_scripts\utility::getfx("mp_hr2_drone_lightbeam"),var_04,"tag_light");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("mp_hr2_drone_prop_wind"),var_04,"tag_light");
	wait 0.05;
}

//Function Number: 11
resetuplinkballoutofbounds()
{
	level endon("game_ended");
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
	}
}

//Function Number: 12
watchcarryobjects()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("dropped");
		wait(0.1);
		thread monitorballstate();
		var_00 = common_scripts\utility::waittill_any_return("pickup_object","reset");
	}
}

//Function Number: 13
monitorballstate()
{
	self endon("pickup_object");
	self endon("reset");
	for(;;)
	{
		if(isoutofbounds())
		{
			thread maps\mp\gametypes\_gameobjects::returnhome();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 14
isoutofbounds()
{
	var_00 = getentarray("object_out_of_bounds","targetname");
	if(isdefined(var_00))
	{
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			if(!self.visuals[0] istouching(var_00[var_01]))
			{
				continue;
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 15
scriptinvalidcarepackagearea()
{
	var_00 = getentarray("orbital_node_covered","targetname");
	foreach(var_02 in var_00)
	{
		if(!isdefined(level.goliath_bad_landing_volumes))
		{
			level.goliath_bad_landing_volumes = [];
		}

		level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_02;
		var_03 = getnodesintrigger(var_02);
		if(!isdefined(level.goliath_bad_landing_nodes))
		{
			level.goliath_bad_landing_nodes = [];
		}

		if(var_03.size > 0)
		{
			foreach(var_05 in var_03)
			{
				level.goliath_bad_landing_nodes[level.goliath_bad_landing_nodes.size] = var_05;
			}
		}
	}

	var_08 = [];
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-448,6620,2888),250,0,22));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-964,6620,2888),250,0,45));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-964,7140,2888),250,0,45));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-448,7140,2888),250,0,45));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-1404,7140,2888),250,0,45));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-1404,6620,2888),250,0,45));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-1620,6498,2888),250,0,45));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-1984,6620,2888),250,0,45));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-2240,6620,2888),250,0,45));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-2240,7140,2888),250,0,45));
	var_08 = common_scripts\utility::array_combine(var_08,getnodesinradius((-1876,7140,2888),250,0,45));
	var_08 = common_scripts\utility::array_remove_duplicates(var_08);
	level.goliath_bad_landing_nodes = common_scripts\utility::array_combine(var_08,level.goliath_bad_landing_nodes);
	if(level.goliath_bad_landing_nodes.size > 0)
	{
		foreach(var_05 in level.goliath_bad_landing_nodes)
		{
			nodesetremotemissilename(var_05,"none");
		}
	}
}

//Function Number: 16
scriptpatchclip()
{
	thread outsideexecutiveofficeledgestuck();
	thread insideexecutiveofficethroughvent();
	thread cratejumpthroughceiling();
}

//Function Number: 17
cratejumpthroughceiling()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1427,6198,2776),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1301,6198,2776),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1427,6132,2776),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1301,6132,2776),(270,0,0));
}

//Function Number: 18
insideexecutiveofficethroughvent()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(438,6072,3104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(438,6136,3104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(438,6200,3104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(438,6264,3104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(438,6328,3104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(438,6392,3104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(438,6456,3104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(438,6520,3104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(438,6584,3104),(0,0,0));
}

//Function Number: 19
outsideexecutiveofficeledgestuck()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-2810,5136,2999),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-2810,5158,2999),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-2778,5136,2999),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-2778,5158,2999),(0,0,0));
}