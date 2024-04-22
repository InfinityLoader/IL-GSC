/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_bigben2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 853 ms
 * Timestamp: 4/22/2024 2:17:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::bigben2_callbackstartgametype;
	maps\mp\mp_bigben2_precache::main();
	maps\createart\mp_bigben2_art::main();
	maps\mp\mp_bigben2_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_bigben2_lighting::main();
	maps\mp\mp_bigben2_aud::main();
	maps\mp\_water::init();
	maps\mp\_compass::setupminimap("compass_map_mp_bigben2");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.ospvisionset = "mp_bigben2_osp";
	level.osplightset = "mp_bigben2_osp";
	level.dronevisionset = "mp_bigben2_drone";
	level.dronelightset = "mp_bigben2_drone";
	level.warbirdvisionset = "mp_bigben2_warbird";
	level.warbirdlightset = "mp_bigben2_warbird";
	level.vulcanvisionset = "mp_bigben2_osp";
	level.vulcanlightset = "mp_bigben2_osp";
	level.allow_swimming = 0;
	thread flickeringlights();
	level thread resetuplinkballoutofbounds();
	level.orbitallaseroverridefunc = ::bigben2vulcanoverrides;
	level.orbitalsupportoverridefunc = ::bigben2paladinoverrides;
	level.mapcustomkillstreakfunc = ::bigben2customkillstreakfunc;
	if(level.nextgen)
	{
		thread start_radar_animations();
	}

	thread fixdroppedbomb();
	if(level.nextgen)
	{
		thread patch_clip_fixes();
	}
	else
	{
		thread resetuplinkballcg();
	}

	if(isdefined(level.gametype) && level.gametype == "sd" || level.gametype == "sr")
	{
		level thread fix_b_bomb_site_killcam();
	}
}

//Function Number: 2
fix_b_bomb_site_killcam()
{
	while(!isdefined(level.bombzones))
	{
		wait 0.05;
	}

	var_00 = getentarray("bombzone","targetname");
	var_01 = getentarray(var_00[1].target,"targetname");
	var_01[0].killcament.origin = (4236,2260,468);
}

//Function Number: 3
resetuplinkballcg()
{
	var_00 = spawn("trigger_radius",(1878,2636,224),0,70,50);
	var_00.targetname = "out_of_bounds_at_rest";
	var_01 = spawn("trigger_radius",(1856,3926,224),0,70,50);
	var_01.targetname = "out_of_bounds_at_rest";
}

//Function Number: 4
bigben2customkillstreakfunc()
{
	level thread maps\mp\killstreaks\streak_mp_bigben2::init();
}

//Function Number: 5
bigben2vulcanoverrides()
{
	level.orbitallaseroverrides.spawnpoint = (4000,4000,0);
	level.orbitallaseroverrides.spawnheight = 3024;
}

//Function Number: 6
bigben2paladinoverrides()
{
	level.orbitalsupportoverrides.spawnheight = 9279;
	level.orbitalsupportoverrides.spawnradius = 8000;
	level.orbitalsupportoverrides.spawnangle = 312;
}

//Function Number: 7
bigben2_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 8
flickeringlights()
{
	var_00 = getscriptablearray("damaged","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate(0,1);
	}

	var_04 = getscriptablearray("destroyed","targetname");
	foreach(var_06 in var_04)
	{
		var_06 setscriptablepartstate(0,4);
	}
}

//Function Number: 9
brokensigns()
{
	var_00 = getscriptablearray("sign_damaged","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate(0,1);
	}
}

//Function Number: 10
start_radar_animations()
{
	var_00 = getent("radar_dish","targetname");
	var_01 = getent("large_radar_stick_1","targetname");
	var_02 = getent("radar_stick_1","targetname");
	var_03 = getent("radar_stick_2","targetname");
	var_04 = getent("radar_stick_3","targetname");
	var_05 = getent("radar_stick_4","targetname");
	var_06 = getent("radar_stick_5","targetname");
	var_00 scriptmodelplayanimdeltamotion("bbn_radar_dish_01_idle");
	var_01 scriptmodelplayanimdeltamotion("bbn_radar_stick_02_idle");
	var_02 scriptmodelplayanimdeltamotion("bbn_radar_stick_02_idle");
	wait(0.3);
	var_03 scriptmodelplayanimdeltamotion("bbn_radar_stick_02_idle");
	wait(1);
	var_04 scriptmodelplayanimdeltamotion("bbn_radar_stick_02_idle");
	wait(0.25);
	var_05 scriptmodelplayanimdeltamotion("bbn_radar_stick_02_idle");
	wait(0.45);
	var_06 scriptmodelplayanimdeltamotion("bbn_radar_stick_02_idle");
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
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_00[var_01]))
		{
			continue;
		}

		return 1;
	}

	if(self.visuals[0].origin[2] <= 176)
	{
		return 1;
	}

	return 0;
}

//Function Number: 15
fixdroppedbomb()
{
	if(level.gametype == "sd")
	{
		while(!isdefined(level.sdbomb))
		{
			wait(0.05);
		}

		level.sdbomb thread watchcarryobjects();
		return;
	}

	if(level.gametype == "sr")
	{
		while(!isdefined(level.sdbomb))
		{
			wait(0.05);
		}

		level.sdbomb thread watchcarryobjects();
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

//Function Number: 16
patch_clip_fixes()
{
	thread issue_17896();
	thread issue_17935();
	thread issue_17999();
	thread issue_18482();
	thread issue_18855();
	thread issue_17154();
	thread issue_18770();
	thread issue_18797();
	thread issue_18457();
	thread issue_17696();
	thread issue_18772();
	thread issue_13645();
	thread issue_18752();
	thread issue_13590();
	thread issue_18582();
	thread issue_16533();
	thread issue_19907();
	thread issue_20694();
	thread issue_20908();
	thread issue_20914();
	thread issue_16646();
	thread issue_22753();
	thread issue_23525();
	thread issue_23548();
	thread issue_23543();
	thread issue_23543_b();
	thread issue_23522();
	thread issue_23551();
	thread issue_14030();
	thread issue_23552();
	thread issue_25514();
	thread waterlanding_deathtriggertoohigh();
	thread anotherattempttofixmiddleledgeaft();
	thread anotherattempttofixmiddleledgeforward();
	thread radarantennagrappletotop();
	thread ticketinglampost();
	thread hoverintobow();
	thread sterngrappleoutmap();
}

//Function Number: 17
sterngrappleoutmap()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,2592,272),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,2592,528),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,2592,784),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,2848,272),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,2848,528),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,2848,784),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3104,272),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3104,528),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3104,784),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3360,272),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3360,528),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3360,784),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3616,272),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3616,528),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3616,784),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3872,272),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3872,528),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,3872,784),(0,0,0));
}

//Function Number: 18
hoverintobow()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5979,3801,219),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5979,3929,219),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5979,3945,219),(0,0,0));
}

//Function Number: 19
ticketinglampost()
{
	var_00 = 773;
	for(var_01 = 0;var_01 < 12;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3108,5321,var_00),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3108,5320,var_00),(0,0,0));
		var_00 = var_00 + 128;
	}
}

//Function Number: 20
radarantennagrappletotop()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3768,2420,986),(15.9999,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3803,2420,1109),(15.9999,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3838,2420,1232),(15.9999,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3873,2420,1355),(15.9999,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3908,2420,1478),(15.9999,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3943,2420,1601),(15.9999,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3978,2420,1724),(15.9999,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4013,2420,1847),(15.9999,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3733,2420,863),(15.9999,0,0));
}

//Function Number: 21
anotherattempttofixmiddleledgeforward()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3778.5,2625,1080),(0,16.9995,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3778.5,2625,1336),(0,16.9995,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3778.5,2625,1592),(0,16.9995,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3747,2728,1080),(0,16.9995,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3747,2728,1336),(0,16.9995,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3747,2728,1592),(0,16.9995,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,2976,1080),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,2976,1336),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,2976,1592),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,3232,1080),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,3232,1336),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,3232,1592),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,3488,1080),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,3488,1336),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,3488,1592),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,3744,1080),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,3744,1336),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,3744,1592),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,4000,1080),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,4000,1336),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3710,4000,1592),(0,0,0));
}

//Function Number: 22
anotherattempttofixmiddleledgeaft()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,2464,1136),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,2464,1392),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,2464,1648),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,2720,1136),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,2720,1392),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,2720,1648),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,2976,1136),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,2976,1392),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,2976,1648),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,3232,1136),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,3232,1392),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,3232,1648),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,3488,1136),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,3488,1392),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,3488,1648),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,3744,1136),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,3744,1392),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,3744,1648),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,4000,1136),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,4000,1392),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4256,4000,1648),(0,0,0));
}

//Function Number: 23
waterlanding_deathtriggertoohigh()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4379,4740,132),(0,326.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3685,4735,132),(0,302.3,0));
}

//Function Number: 24
issue_17935()
{
	maps\mp\_utility::spawnpatchclip("patchclip_grapple_16_256_256",(6663,5566.5,335),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_grapple_16_256_256",(6919.5,5566.5,335),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_grapple_16_256_256",(7175.5,5566.5,335),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_grapple_16_256_256",(6663,5566.5,586),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_grapple_16_256_256",(6919.5,5566.5,586),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_grapple_16_256_256",(7175.5,5566.5,586),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6656.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6912.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7168.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6656.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6912.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7168.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6656.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6912.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7168.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7424.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7424.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7424.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7680.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7680.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7680.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7936.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7936.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(7936.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8192.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8192.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8192.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8448.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8448.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8448.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8704.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8704.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8704.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8960.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8960.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(8960.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9216.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9216.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9216.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9472.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9472.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9472.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9728.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9728.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9728.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9984.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9984.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(9984.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(10240.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(10240.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(10240.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(10496.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(10496.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(10496.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(10752.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(10752.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(10752.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(11008.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(11008.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(11008.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(11264.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(11264.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(11264.5,5581,849.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(11520.5,5581,337.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(11520.5,5581,593),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(11520.5,5581,849.5),(0,270,0));
}

//Function Number: 25
issue_17999()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5094.5,4159,878),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4966.5,4159,878),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4838.5,4159,878),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5094.5,4159,1005.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4966.5,4159,1005.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4838.5,4159,1005.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5094.5,4159,1133.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4966.5,4159,1133.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4838.5,4159,1133.5),(0,0,0));
}

//Function Number: 26
issue_17896()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(696,3084,604),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(696,3212,604),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(696,3340,604),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(696,3084,732),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(696,3212,732),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(696,3340,732),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(696,3084,860),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(696,3212,860),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(696,3340,860),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(440,3084,604),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(568,3084,604),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(440,3084,732),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(568,3084,732),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(440,3084,860),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(568,3084,860),(0,0,0));
}

//Function Number: 27
issue_18482()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3863.5,4380.5,804.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3847.5,4380.5,804.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3863.5,4380.5,932.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3847.5,4380.5,932.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3863.5,4380.5,1060.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3847.5,4380.5,1060.5),(0,0,0));
}

//Function Number: 28
issue_18855()
{
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(6661,5586.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(6661,5602.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(6661,5618.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(6917,5586.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(6917,5602.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(6917,5618.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7173,5586.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7173,5602.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7173,5618.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7429,5586.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7429,5602.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7429,5618.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7685,5586.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7685,5602.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7685,5618.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7941,5586.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7941,5602.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(7941,5618.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(8197,5586.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(8197,5602.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(8197,5618.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(8453,5586.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(8453,5602.5,450),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(8453,5618.5,450),(0,270,0));
}

//Function Number: 29
issue_17154()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4293,3912,1212),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4293,3912,1340),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4293,3912,1468),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4293,3912,1596),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4293,3912,1724),(0,0,0));
}

//Function Number: 30
issue_18770()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2025,3845,558),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2025,3836,558),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2025,3845,526),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2025,3836,526),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2025,3845,494),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2025,3836,494),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2057,3845,590),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2057,3836,590),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2025,3845,590),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(2025,3836,590),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3845,590),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3836,590),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3845,558),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3836,558),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3845,526),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3836,526),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3845,494),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3836,494),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3836,462),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1998,3845,462),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1973.7,3845,587.3),(343.4,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1973.7,3836,587.3),(343.4,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1982.9,3845,556.7),(343.4,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1982.9,3836,556.7),(343.3,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1992,3845,526),(343.3,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(1992,3836,526),(343.3,0,0));
}

//Function Number: 31
issue_18797()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2464,4178,327.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2464,4218,327.5),(0,0,0));
}

//Function Number: 32
issue_18457()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2168,5236,352),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2168,5236,480),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2168,5236,608),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2168,5236,736),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2168,5236,864),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2168,5236,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2168,5236,1120),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2168,5236,1248),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2726,5236,352),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2726,5236,480),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2726,5236,608),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2726,5236,736),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2726,5236,864),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2726,5236,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2726,5236,1120),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2726,5236,1248),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5416,5236,352),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5416,5236,480),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5416,5236,608),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5416,5236,736),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5416,5236,864),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5416,5236,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5416,5236,1120),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5416,5236,1248),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5976,5236,352),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5976,5236,480),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5976,5236,608),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5976,5236,736),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5976,5236,864),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5976,5236,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5976,5236,1120),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5976,5236,1248),(0,0,0));
}

//Function Number: 33
issue_17696()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5116,5528,1072),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5116,5528,816),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5116,5528,560),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5116,5528,304),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5328,5528,1072),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5328,5528,816),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5328,5528,560),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5328,5528,304),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5584,5528,1072),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5584,5528,816),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5584,5528,560),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5584,5528,304),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5840,5528,1072),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5840,5528,816),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5840,5528,560),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(5840,5528,304),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6096,5528,1072),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6096,5528,816),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6096,5528,560),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6096,5528,304),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6228,5448,1072),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6228,5448,816),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6228,5448,560),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6228,5448,304),(0,180,0));
}

//Function Number: 34
issue_18772()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(4844,2518,462),(0,10.9998,0));
}

//Function Number: 35
issue_13645()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3686,5387,470),(360,270,9.89992));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3798,5387,480),(0,89.9999,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4306,5388,480),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4418,5388,470),(360,89.9999,9.9996));
}

//Function Number: 36
issue_18752()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,392),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,456),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,520),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,584),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,648),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,712),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,776),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,840),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,904),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,968),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,1032),(0,0,0));
}

//Function Number: 37
issue_13590()
{
	var_00 = spawn("trigger_radius",(5872,2688,556),0,73,50);
	var_00.targetname = "out_of_bounds";
	var_01 = spawn("trigger_radius",(5876,3873,556),0,73,50);
	var_01.targetname = "out_of_bounds";
}

//Function Number: 38
issue_18628()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3742,2456,990),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3742,2456,1118),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3742,2456,1246),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3788,2816,1036),(0,20,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3788,2816,1164),(0,20,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3788,2816,1292),(0,20,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3788,2816,1420),(0,20,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3788,2816,1548),(0,20,0));
}

//Function Number: 39
issue_18582()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2704,4432,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2832,4432,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2960,4432,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2704,4304,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2832,4304,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2960,4304,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5392,4432,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5264,4432,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5136,4432,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5136,4304,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5264,4304,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(5392,4304,288),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4953.21,4608.72,286.304),(5.86831,282.064,1.25168));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4926.6,4733.23,299.391),(5.86831,282.064,1.25168));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4801.4,4706.77,296.609),(5.86831,282.064,1.25168));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4828.01,4582.25,283.522),(5.86831,282.064,1.25168));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3275.02,4692.6,303.4),(5.86833,258.064,1.25167));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3248.68,4568.05,290.3),(5.86833,258.064,1.25167));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3149.91,4719.41,300.6),(5.86833,258.064,1.25167));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3123.53,4594.76,287.5),(5.86833,258.064,1.25167));
}

//Function Number: 40
issue_16533()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(4464,4296,796),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(4464,4283,827),(0,0,45.9991));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(4464,4237,871),(0,0,45.9991));
	var_00 = maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3857,4413,692),(0,0,0));
	var_01 = maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3857,4349,692),(0,0,0));
	var_02 = maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3857,4285,692),(0,0,0));
	var_03 = maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3857,4413,756),(0,0,0));
	var_04 = maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3857,4349,756),(0,0,0));
	var_05 = maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3857,4285,756),(0,0,0));
	var_00 method_8568(0);
	var_00 method_856C(0);
	var_01 method_8568(0);
	var_01 method_856C(0);
	var_02 method_8568(0);
	var_02 method_856C(0);
	var_03 method_8568(0);
	var_03 method_856C(0);
	var_04 method_8568(0);
	var_04 method_856C(0);
	var_05 method_8568(0);
	var_05 method_856C(0);
}

//Function Number: 41
issue_19907()
{
	var_00 = maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(6040,2720,284),(0,0,0));
	var_00 = maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(6040,2720,156),(0,0,0));
	var_00 = maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(6040,2592,284),(0,0,0));
	var_00 = maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(6040,2592,156),(0,0,0));
	var_00 = maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(5968.14,2513.89,284),(0,290,0));
	var_00 = maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(5968.14,2513.89,156),(0,290,0));
	var_00 = maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(5847.86,2470.11,284),(0,290,0));
	var_00 = maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(5847.86,2470.11,156),(0,290,0));
}

//Function Number: 42
issue_20694()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2448,4208,328),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2448,4180,328),(0,0,0));
}

//Function Number: 43
issue_20908()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3648,5960,1512),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3776,5960,1512),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3904,5960,1512),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4032,5960,1512),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4160,5960,1512),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4288,5960,1512),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4416,5960,1512),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4544,5960,1512),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3648,5920,1640),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3776,5920,1640),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3904,5920,1640),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4032,5920,1640),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4160,5920,1640),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4288,5920,1640),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4416,5920,1640),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4544,5920,1640),(0,0,0));
}

//Function Number: 44
issue_20914()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3844,3804,912),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3844,3740,912),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3844,3676,912),(0,0,0));
}

//Function Number: 45
issue_18972()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3024,1139.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3024,1267.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3024,1395.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3024,1523.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3152,1139.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3152,1267.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3152,1395.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3152,1523.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3280,1139.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3280,1267.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3280,1395.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3280,1523.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3408,1139.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3408,1267.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3408,1395.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3408,1523.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3536,1139.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3536,1267.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3536,1395.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(4261,3536,1523.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3536,1031.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3536,1159.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3536,1287.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3536,1415.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3408,1031.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3408,1159.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3408,1287.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3408,1415.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3280,1031.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3280,1159.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3280,1287.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3280,1415.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3152,1031.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3152,1159.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3152,1287.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3152,1415.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3024,1031.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3024,1159.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3024,1287.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(3761,3024,1415.5),(0,0,0));
}

//Function Number: 46
issue_16646()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,350),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,414),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,478),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,542),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,606),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,670),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,734),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(976,2496,798),(0,0,0));
}

//Function Number: 47
issue_17170()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3724,2450,976),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3724,2450,1040),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3724,2450,1104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3724,2450,1168),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3724,2450,1232),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3724,2450,1296),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3724,2450,1360),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(3724,2450,1424),(0,0,0));
}

//Function Number: 48
issue_22753()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4688,4232,272),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4644,4232,272),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4516,4232,272),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4388,4232,272),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4260,4232,272),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4132,4232,272),(0,270,0));
}

//Function Number: 49
issue_23525()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6042,2656,224),(0,0,0));
}

//Function Number: 50
issue_23545()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(6042,3898,224),(0,0,0));
}

//Function Number: 51
issue_23548()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1338,3853,224),(0,286.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1583.5,3925.5,224),(0,286.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1829,3997.5,224),(0,286.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(2074.5,4070,224),(0,286.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(2320,4142.5,224),(0,286.3,0));
}

//Function Number: 52
issue_23543()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(4749.5,4486.5,522.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(4749.5,4422.5,522.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(4749.5,4358.5,522.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(4749.5,4294.5,522.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(4749.5,4230.5,522.5),(0,0,0));
}

//Function Number: 53
issue_23522()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(4749.5,4230.5,522.5),(0,0,0));
}

//Function Number: 54
issue_23551()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4576,2130,628),(-10,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4200,2130,628),(-10,270,0));
}

//Function Number: 55
issue_14030()
{
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(4234,4174,1006),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(4170,4174,1006),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(4034,4173,1006),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3970,4173,1006),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3818,4173,1006),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3754,4173,1006),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3684,4144,1025),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3687,4052,1003),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3687,3988,1003),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3687,3895,1024),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3687,3895,1024),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3728,3572,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(4229,3376,1104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3728,3378,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(4229,3185,1104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3728,3192,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(4230,2992,1104),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3728,2998,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3758,2805,992),(0,18.4995,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3820,2617,992),(0,18.4995,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3813,2549,1160),(0,320.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3816,2356,1160),(0,226.2,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(4085,2356,1160),(0,320.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(4090,2546,1160),(0,226.2,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_64_64_64",(3819,2618,1004),(0,199.1,0));
}

//Function Number: 56
issue_23543_b()
{
	var_00 = 864;
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3888,4332,var_00),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3872,4332,var_00),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3856,4332,var_00),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3840,4332,var_00),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3824,4332,var_00),(0,0,0));
		var_00 = var_00 + 256;
	}

	var_00 = 911;
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4469,4163,var_00),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4453,4163,var_00),(0,0,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(4437,4163,var_00),(0,0,0));
		var_00 = var_00 + 256;
	}

	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4718.5,4307,420),(11.2,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4718.5,4381,420),(11.2,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(4718.5,4455,420),(11.2,0,0));
}

//Function Number: 57
issue_23552()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4111.5,3737,931.5),(350.3,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4115.5,3697,906),(350.3,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4111.5,3697,931.5),(350.3,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4115.5,3737,906),(350.3,0,0));
}

//Function Number: 58
issue_25514()
{
	var_00 = 429;
	for(var_01 = 0;var_01 < 20;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4689,4253.5,var_00),(0,270,0));
		var_00 = var_00 + 64;
	}
}