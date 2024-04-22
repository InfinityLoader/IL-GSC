/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_climate_3.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 51
 * Decompile Time: 777 ms
 * Timestamp: 4/22/2024 2:17:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::climate_callbackstartgametype;
	maps\mp\mp_climate_3_precache::main();
	maps\createart\mp_climate_3_art::main();
	maps\mp\mp_climate_3_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_climate_3_lighting::main();
	maps\mp\mp_climate_3_aud::main();
	precacherumble("tank_rumble");
	precacherumble("heavygun_fire");
	precacherumble("smg_fire");
	precacheshellshock("mp_climate_acid");
	if(level.nextgen)
	{
		precachempanim("cli_elevator_tower02_car01");
		precachempanim("cli_elevator_tower02_car02");
		precachempanim("cli_elevator_tower02_car03");
		precachempanim("cli_elevator_tower02_car04");
		precachempanim("cli_elevator_tower03_car01");
		precachempanim("cli_elevator_tower03_car02");
		precachempanim("cli_elevator_tower03_car03");
		precachempanim("cli_elevator_tower03_car04");
		precachempanim("cli_elevator_tower04_car01");
		precachempanim("cli_elevator_tower04_car02");
		precachempanim("cli_elevator_tower04_car03");
		precachempanim("cli_elevator_tower04_car04");
		precachempanim("cli_elevator_tower05_car01");
		precachempanim("cli_elevator_tower05_car02");
		precachempanim("cli_elevator_tower05_car03");
		precachempanim("cli_elevator_tower05_car04");
	}

	level.bots_ignore_water = 1;
	maps\mp\_water::setshallowwaterweapon("iw5_combatknife_mp");
	maps\mp\_water::setdeepwaterweapon("iw5_combatknife_mp");
	maps\mp\_water::init();
	setdvar("scr_ball_water_drop_delay",20);
	maps\mp\_compass::setupminimap("compass_map_mp_climate_3");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.watermovescale = 0.8;
	if(level.nextgen)
	{
		thread setupelevatoranims();
	}

	level dynamicevent_init();
	level thread maps\mp\_dynamic_events::dynamicevent(::startdynamicevent,undefined,::enddynamicevent);
	level.orbitalsupportoverridefunc = ::climatepaladinoverrides;
	level.ospvisionset = "mp_climate_3_osp";
	level.osplightset = "mp_climate_3_osp";
	level.warbirdvisionset = "mp_climate_3_osp";
	level.warbirdlightset = "mp_climate_3_osp";
	level.vulcanvisionset = "mp_climate_3_osp";
	level.vulcanlightset = "mp_climate_3_osp";
	spawnsetup();
	level thread onplayerconnect();
	if(!isdefined(level.wateristoxic) && level.wateristoxic)
	{
		thread preparetoxicwater();
	}

	var_00 = getent("waterfall_model_small","targetname");
	var_01 = getent("waterfall_model_large","targetname");
	if(isdefined(var_01))
	{
		var_01 notsolid();
	}

	if(isdefined(var_00))
	{
		var_00 notsolid();
	}

	thread trigger_fixes();
	thread clip_fixes();
}

//Function Number: 2
trigger_fixes()
{
	var_00 = 1024;
	var_01 = getentarray("ball_out_of_bounds_triggers","targetname");
	foreach(var_03 in var_01)
	{
		if(distancesquared(var_03.origin,(-216,-372,20)) <= var_00)
		{
			var_03.origin = var_03.origin - (0,0,5000);
		}
	}
}

//Function Number: 3
clip_fixes()
{
	thread greenhouseroofclip01();
	thread greenhouseroofclip02();
	thread greenhouseroofclip03();
	thread canyonrockclip01();
	thread eagleheadclip01();
	thread archrockclip01();
	thread archrockclip02();
	thread lionheadrockclip01();
	thread waterfallrockclip01();
	thread climatronclip01();
	thread grapplenorthernbridge();
	thread swcanopygrappleoutbounds();
	thread sewerclip01();
	thread sewerclip02();
}

//Function Number: 4
sewerclip01()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(594,-200,104),(270,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(604,-136,104),(270,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(608,-72,104),(270,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(568,-72,80),(0,180,-180));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(568,-72,16),(0,180,-180));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(608,-32,16),(0,270,-180));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(608,-32,80),(0,270,-180));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(608,-70,91),(60,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(608,-45,69),(30,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(604.5,-157,104),(270,0,85.6));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(594.5,-217,104),(270,360,76.2));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(573.5,-266.5,104),(270,0,60));
}

//Function Number: 5
sewerclip02()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-56,568,104),(270,270,-90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-120,568,104),(270,270,-90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-184,568,104),(270,270,-90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-248,568,104),(270,270,-90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-251,560,91),(60,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-276,560,69),(30,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-289,560,16),(0,0,180));
}

//Function Number: 6
swcanopygrappleoutbounds()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-703,1321,785),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-877,1496,717),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1051,1671,647),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-691,1332,785),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-866,1508,717),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1040,1683,647),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-680,1344,785),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-854,1519,717),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1028,1694,647),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-668,1355,785),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-842,1530,717),(0,44.8996,-15.4004));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1016,1705,647),(0,44.8996,-15.4004));
}

//Function Number: 7
greenhouseroofclip01()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(998,461,913),(0,27.0962,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(998,461,1169),(0,27.0962,0));
}

//Function Number: 8
greenhouseroofclip02()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1018.5,0,879.8),(0,27.8994,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1018.5,0,1135.8),(0,27.8994,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1166,-203,879.8),(0,44.0983,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1166,-203,1135.8),(0,44.0983,0));
	var_00 = 814;
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(1308,-243.5,var_00),(0,42.1972,0));
		var_00 = var_00 + 128;
	}
}

//Function Number: 9
greenhouseroofclip03()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1013.5,1638,786),(0,24.8,-32.6));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-925,1444.5,925),(0,24.8,-32.6));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-793,1233,883.5),(0,36.9,30.7));
}

//Function Number: 10
canyonrockclip01()
{
	var_00 = -102;
	for(var_01 = 0;var_01 < 12;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(1455.5,-27,var_00),(0,305.4,0));
		var_00 = var_00 + 128;
	}
}

//Function Number: 11
eagleheadclip01()
{
	var_00 = 432;
	for(var_01 = 0;var_01 < 6;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1476,364.5,var_00),(0,64.1,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1483,350,var_00),(0,64.1,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1469,379,var_00),(0,64.1,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1490,335.5,var_00),(0,64.1,0));
		var_00 = var_00 + 256;
	}
}

//Function Number: 12
archrockclip01()
{
	var_00 = 455;
	for(var_01 = 0;var_01 < 12;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-767,341.5,var_00),(0,24.8989,0));
		var_00 = var_00 + 128;
	}

	var_00 = 300;
	for(var_01 = 0;var_01 < 7;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-786,290.5,var_00),(0,355.4,0));
		var_00 = var_00 + 256;
	}
}

//Function Number: 13
archrockclip02()
{
	var_00 = 354;
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(-904,-12,var_00),(0,0,0));
		var_00 = var_00 + 128;
	}
}

//Function Number: 14
lionheadrockclip01()
{
	var_00 = 640;
	for(var_01 = 0;var_01 < 7;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(504,704,var_00),(0,315,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(552,648,var_00),(0,315,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(483,635,var_00),(0,270,0));
		var_00 = var_00 + 128;
	}
}

//Function Number: 15
waterfallrockclip01()
{
	var_00 = 64;
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_item_16_128_128",(-1408,-1304,var_00),(0,0,0));
		var_00 = var_00 + 128;
	}

	maps\mp\_utility::spawnpatchclip("patchclip_item_16_128_128",(-1480,-1284.5,512),(270,0,0));
}

//Function Number: 16
climatronclip01()
{
	var_00 = 1176;
	for(var_01 = 0;var_01 < 8;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-476.7,-800.5,var_00),(0,1.7,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-728.2,-1131.6,var_00),(0,293.5,0));
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-847.75,-1159.5,var_00),(0,271.1,0));
		var_00 = var_00 + 128;
	}

	var_00 = 1240;
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-534.14,-945.92,var_00),(0,329.3,0));
		var_00 = var_00 + 256;
	}
}

//Function Number: 17
grapplenorthernbridge()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1328,518,751),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1328,518,1007),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1328,518,1263),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1138,518,751),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1138,518,1007),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1138,518,1263),(0,270,0));
}

//Function Number: 18
climate_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 19
preparetoxicwater()
{
	var_00 = getentarray("water_bad","targetname");
	var_01 = getent("waterfall_01_bad","targetname");
	linkallbadwater(var_00,var_01);
	moveallbadwater((0,0,-12000));
}

//Function Number: 20
linkallbadwater(param_00,param_01)
{
	level.water_bad_link = param_00[0];
	for(var_02 = 1;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02].origin - level.water_bad_link.origin;
		var_04 = param_00[var_02].angles - level.water_bad_link.angles;
		param_00[var_02] linkto(level.water_bad_link,"",var_03,var_04);
	}

	var_03 = param_01.origin - level.water_bad_link.origin;
	var_04 = param_01.angles - level.water_bad_link.angles;
	param_01 linkto(level.water_bad_link,"",var_03,var_04);
}

//Function Number: 21
moveallbadwater(param_00)
{
	level.water_bad_link.origin = level.water_bad_link.origin + param_00;
}

//Function Number: 22
setupelevatoranims()
{
	var_00 = common_scripts\utility::getstructarray("tower_2_anim_node_01","targetname");
	var_01 = common_scripts\utility::getstructarray("tower_2_anim_node_02","targetname");
	var_02 = common_scripts\utility::getstructarray("tower_2_anim_node_03","targetname");
	var_03 = common_scripts\utility::getstructarray("tower_2_anim_node_04","targetname");
	var_04 = common_scripts\utility::getstructarray("tower_3_anim_node_01","targetname");
	var_05 = common_scripts\utility::getstructarray("tower_3_anim_node_02","targetname");
	var_06 = common_scripts\utility::getstructarray("tower_3_anim_node_03","targetname");
	var_07 = common_scripts\utility::getstructarray("tower_3_anim_node_04","targetname");
	var_08 = common_scripts\utility::getstructarray("tower_4_anim_node_01","targetname");
	var_09 = common_scripts\utility::getstructarray("tower_4_anim_node_02","targetname");
	var_0A = common_scripts\utility::getstructarray("tower_4_anim_node_03","targetname");
	var_0B = common_scripts\utility::getstructarray("tower_4_anim_node_04","targetname");
	var_0C = common_scripts\utility::getstructarray("tower_5_anim_node_01","targetname");
	var_0D = common_scripts\utility::getstructarray("tower_5_anim_node_02","targetname");
	var_0E = common_scripts\utility::getstructarray("tower_5_anim_node_03","targetname");
	var_0F = common_scripts\utility::getstructarray("tower_5_anim_node_04","targetname");
	foreach(var_11 in var_00)
	{
		var_12 = spawn("script_model",var_11.origin);
		var_12 setmodel("cli_vista_tower_elevator_02");
		var_12.angles = var_11.angles;
		thread startelevatoranims(var_12,"tower02","car01",5.56);
		wait 0.05;
	}

	foreach(var_11 in var_01)
	{
		var_15 = spawn("script_model",var_11.origin);
		var_15 setmodel("cli_vista_tower_elevator_02");
		var_15.angles = var_11.angles;
		thread startelevatoranims(var_15,"tower02","car02",16.73);
		wait 0.05;
	}

	foreach(var_11 in var_02)
	{
		var_18 = spawn("script_model",var_11.origin);
		var_18 setmodel("cli_vista_tower_elevator_02");
		var_18.angles = var_11.angles;
		thread startelevatoranims(var_18,"tower02","car03",12.23);
		wait 0.05;
	}

	foreach(var_11 in var_03)
	{
		var_1B = spawn("script_model",var_11.origin);
		var_1B setmodel("cli_vista_tower_elevator_02");
		var_1B.angles = var_11.angles;
		thread startelevatoranims(var_1B,"tower02","car04",0);
		wait 0.05;
	}

	foreach(var_11 in var_04)
	{
		var_12 = spawn("script_model",var_11.origin);
		var_12 setmodel("cli_vista_tower_elevator_02");
		var_12.angles = var_11.angles;
		thread startelevatoranims(var_12,"tower03","car01",5.56);
		wait 0.05;
	}

	foreach(var_11 in var_05)
	{
		var_15 = spawn("script_model",var_11.origin);
		var_15 setmodel("cli_vista_tower_elevator_02");
		var_15.angles = var_11.angles;
		thread startelevatoranims(var_15,"tower03","car02",16.73);
		wait 0.05;
	}

	foreach(var_11 in var_06)
	{
		var_18 = spawn("script_model",var_11.origin);
		var_18 setmodel("cli_vista_tower_elevator_02");
		var_18.angles = var_11.angles;
		thread startelevatoranims(var_18,"tower03","car03",12.23);
		wait 0.05;
	}

	foreach(var_11 in var_07)
	{
		var_1B = spawn("script_model",var_11.origin);
		var_1B setmodel("cli_vista_tower_elevator_02");
		var_1B.angles = var_11.angles;
		thread startelevatoranims(var_1B,"tower03","car04",0);
		wait 0.05;
	}

	foreach(var_11 in var_08)
	{
		var_12 = spawn("script_model",var_11.origin);
		var_12 setmodel("cli_vista_tower_elevator_02");
		var_12.angles = var_11.angles;
		thread startelevatoranims(var_12,"tower04","car01",5.56);
		wait 0.05;
	}

	foreach(var_11 in var_09)
	{
		var_15 = spawn("script_model",var_11.origin);
		var_15 setmodel("cli_vista_tower_elevator_02");
		var_15.angles = var_11.angles;
		thread startelevatoranims(var_15,"tower04","car02",16.73);
		wait 0.05;
	}

	foreach(var_11 in var_0A)
	{
		var_18 = spawn("script_model",var_11.origin);
		var_18 setmodel("cli_vista_tower_elevator_02");
		var_18.angles = var_11.angles;
		thread startelevatoranims(var_18,"tower04","car03",12.23);
		wait 0.05;
	}

	foreach(var_11 in var_0B)
	{
		var_1B = spawn("script_model",var_11.origin);
		var_1B setmodel("cli_vista_tower_elevator_02");
		var_1B.angles = var_11.angles;
		thread startelevatoranims(var_1B,"tower04","car04",0);
		wait 0.05;
	}

	foreach(var_11 in var_0C)
	{
		var_12 = spawn("script_model",var_11.origin);
		var_12 setmodel("cli_vista_tower_elevator_02");
		var_12.angles = var_11.angles;
		thread startelevatoranims(var_12,"tower05","car01",5.56);
		wait 0.05;
	}

	foreach(var_11 in var_0D)
	{
		var_15 = spawn("script_model",var_11.origin);
		var_15 setmodel("cli_vista_tower_elevator_02");
		var_15.angles = var_11.angles;
		thread startelevatoranims(var_15,"tower05","car02",16.73);
		wait 0.05;
	}

	foreach(var_11 in var_0E)
	{
		var_18 = spawn("script_model",var_11.origin);
		var_18 setmodel("cli_vista_tower_elevator_02");
		var_18.angles = var_11.angles;
		thread startelevatoranims(var_18,"tower05","car03",12.23);
		wait 0.05;
	}

	foreach(var_11 in var_0F)
	{
		var_1B = spawn("script_model",var_11.origin);
		var_1B setmodel("cli_vista_tower_elevator_02");
		var_1B.angles = var_11.angles;
		thread startelevatoranims(var_1B,"tower05","car04",0);
		wait 0.05;
	}
}

//Function Number: 23
startelevatoranims(param_00,param_01,param_02,param_03)
{
	wait(param_03);
	param_00 scriptmodelplayanim("cli_elevator_" + param_01 + "_" + param_02);
}

//Function Number: 24
dynamicevent_init()
{
	level endon("game_ended");
	maps\mp\_dynamic_events::setdynamiceventstartpercent(0.5);
	setdvar("scr_dynamic_event_start_perc",level.dynamicevent["start_percent"]);
	var_00 = getent("toxic_water_trigger","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_01 = getentarray("out_of_bounds","targetname");
	var_02 = "nil";
	foreach(var_04 in var_01)
	{
		if(var_04.script_noteworthy == "toxic_water_objective_trigger")
		{
			var_02 = var_04;
		}
	}

	if(isdefined(var_02))
	{
		var_02 common_scripts\utility::trigger_off();
	}

	level.cancelbadwaterspawns = 0;
	level.wateristoxic = 0;
	level.ventishot = 0;
	level.toxiceventstarted = 0;
	level.toxiceventcomplete = 0;
	level.toxicquake = common_scripts\utility::getstruct("toxic_quake","targetname");
}

//Function Number: 25
startdynamicevent()
{
	level endon("game_ended");
	level.toxiceventstarted = 1;
	var_00 = spawn("script_origin",(0,0,0));
	var_00 playsound("climate_event_warn");
	level.cancelbadwaterspawns = 1;
	wait(4.9);
	thread starttoxicquake(0.3,1);
	wait(0.1);
	level.toxicstage1finished = 1;
	thread disconnectnodesslowly();
	aud_event_explosion_warning();
	aud_event_explosion(1);
	thread maps\mp\mp_climate_3_fx::top_vent_damage_fx();
	wait(0.1);
	level.toxicstage2finished = 1;
	if(level.nextgen)
	{
		thread maps\mp\mp_climate_3_fx::clear_water_transition_fx();
		thread maps\mp\mp_climate_3_fx::clear_water_transition_looping_fx();
	}

	thread maps\mp\mp_climate_3_fx::electrical_arcs_fx();
	thread maps\mp\mp_climate_3_fx::electrical_arc_coils_fx();
	wait(0.1);
	level.toxicstage3finished = 1;
	thread maps\mp\mp_climate_3_fx::toxic_vent_steam_fx();
	thread maps\mp\mp_climate_3_fx::small_toxic_vent_steam_fx();
	thread maps\mp\mp_climate_3_fx::machine_toxic_window_fx();
	wait(0.7);
	thread starttoxicquake(0.3,1);
	wait(0.1);
	level.toxicstage4finished = 1;
	thread maps\mp\mp_climate_3_fx::vent_metal_shards_fx();
	thread maps\mp\mp_climate_3_fx::vent_firecrawl_fx();
	foreach(var_02 in level.players)
	{
		var_02 thread dyneventflash();
	}

	thread aud_event_explosion(2);
	wait(0.1);
	thread setuptoxicwater(1);
	wait(0.85);
	level.toxicstage5finished = 1;
	thread maps\mp\mp_climate_3_fx::machine_toxic_pipes_fx();
	wait(1.25);
	thread starttoxicquake(0.6,2);
	wait(0.1);
	thread aud_toxic_water_boil_activate();
	var_04 = getent("machine_vent_pristine","targetname");
	var_04 setmodel("cli_climate_control_machine_vent_dstry2");
	aud_event_explosion(3);
	level.ventishot = 1;
	if(isdefined(level.players))
	{
		foreach(var_02 in level.players)
		{
			var_02 thread check_vent_damage();
		}
	}

	if(level.nextgen)
	{
		thread maps\mp\mp_climate_3_fx::water_transition_fx();
	}

	wait(0.1);
	level.toxicstage6finished = 1;
	thread maps\mp\mp_climate_3_fx::dead_fish_fx();
	if(level.nextgen)
	{
		thread maps\mp\mp_climate_3_fx::toxic_waterfall_start();
	}

	wait(1.9);
	level.toxicstage7finished = 1;
	thread maps\mp\mp_climate_3_fx::vent_smoke_damage_fx();
	wait(1);
	wait(1);
	wait(1);
	wait(1);
	var_00 playsound("climate_event_finished");
	wait(1);
	wait(1);
	wait(0.3);
	thread maps\mp\mp_climate_3_fx::less_freq_electrical_sparks_fx();
	thread maps\mp\mp_climate_3_fx::water_surface_steam_fx();
	level.toxiceventcomplete = 1;
}

//Function Number: 26
check_vent_damage()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = getent("hot_vent","targetname");
	for(;;)
	{
		if(self istouching(var_00))
		{
			while(isalive(self) && self istouching(var_00))
			{
				self dodamage(5,self.origin,undefined,undefined,"MOD_TRIGGER_HURT","none","none");
				wait(0.1);
				maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
			}
		}

		wait 0.05;
	}
}

//Function Number: 27
enddynamicevent()
{
	var_00 = getent("machine_vent_pristine","targetname");
	var_00 setmodel("cli_climate_control_machine_vent_dstry2");
	level.toxiceventcomplete = 1;
	level.cancelbadwaterspawns = 1;
	thread disconnectnodesslowly();
	thread setuptoxicwater(0);
}

//Function Number: 28
setuptoxicwater(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	level.wateristoxic = 1;
	var_01 = getent("toxic_water_trigger","targetname");
	var_01 common_scripts\utility::trigger_on();
	var_02 = getentarray("out_of_bounds","targetname");
	var_03 = "nil";
	foreach(var_05 in var_02)
	{
		if(var_05.script_noteworthy == "toxic_water_objective_trigger")
		{
			var_03 = var_05;
		}
	}

	if(isdefined(var_03))
	{
		var_03 common_scripts\utility::trigger_on();
		var_03 childthread handle_ball_water_return();
	}

	var_07 = getentarray("water_good","targetname");
	foreach(var_09 in var_07)
	{
		var_09 delete();
	}

	if(param_00)
	{
		moveallbadwater((0,0,12000));
	}

	if(isdefined(level.players))
	{
		foreach(var_0C in level.players)
		{
			var_0C thread handle_toxic_water_damage();
		}
	}

	thread setupsupportdropvolumes(var_01);
}

//Function Number: 29
disconnectnodesslowly()
{
	var_00 = getnodearray("water_node","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] disconnectnode();
		if(var_01 % 50 == 0)
		{
			wait 0.05;
		}
	}

	wait 0.05;
	var_02 = getnodearray("water_node","script_noteworthy");
	for(var_01 = 0;var_01 < var_02.size;var_01++)
	{
		var_02[var_01] disconnectnode();
		if(var_01 % 50 == 0)
		{
			wait 0.05;
		}
	}

	wait 0.05;
	disconnectnodepairs(var_00);
}

//Function Number: 30
disconnectnodepairs(param_00)
{
	foreach(var_02 in param_00)
	{
		var_03 = [];
		var_03 = getlinkednodes(var_02,1);
		if(var_03.size > 0)
		{
			foreach(var_05 in var_03)
			{
				disconnectnodepair(var_02,var_05);
			}
		}
	}
}

//Function Number: 31
setupsupportdropvolumes(param_00)
{
	while(!isdefined(level.orbital_util_covered_volumes))
	{
		wait 0.05;
	}

	level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = param_00;
	while(!isdefined(level.goliath_bad_landing_volumes))
	{
		wait 0.05;
	}

	level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = param_00;
}

//Function Number: 32
handle_ball_water_return()
{
	var_00 = self;
	if(isdefined(level.balls) && level.balls.size != 0)
	{
		for(;;)
		{
			foreach(var_02 in level.balls)
			{
				if(isdefined(var_02.visuals[0]) && var_02.visuals[0] istouching(var_00))
				{
					var_02 thread maps\mp\gametypes\_gameobjects::returnhome();
				}
			}

			wait(2);
		}
	}
}

//Function Number: 33
starttoxicquake(param_00,param_01)
{
	earthquake(param_00,param_01,level.toxicquake.origin,3500);
	toxic_quake_rumble(param_01);
}

//Function Number: 34
toxic_quake_rumble(param_00)
{
	level notify("Toxic_Quake_End");
	waittillframeend;
	foreach(var_02 in level.players)
	{
		if(isalive(var_02))
		{
			var_02 thread toxic_quake_rumble_player(param_00);
		}
	}
}

//Function Number: 35
toxic_quake_rumble_player(param_00)
{
	level endon("Toxic_Quake_End");
	var_01 = "tank_rumble";
	var_02 = "heavygun_fire";
	var_03 = "smg_fire";
	self playrumblelooponentity(var_01);
	thread watch_toxic_rumble_end(var_01,param_00);
	var_04 = 0;
	if(distancesquared(level.toxicquake.origin,self.origin) < 1210000)
	{
		self playrumbleonentity(var_02);
		var_04 = 1;
	}

	if(!var_04 && distancesquared(level.toxicquake.origin,self.origin) < 6250000)
	{
		self playrumbleonentity(var_03);
	}
}

//Function Number: 36
watch_toxic_rumble_end(param_00,param_01)
{
	level endon("Toxic_Quake_End");
	self endon("disconnect");
	thread watch_toxic_rumble_end_early(param_00);
	while(param_01 > 0)
	{
		param_01 = param_01 - 0.05;
		wait(0.05);
	}

	self stoprumble(param_00);
	self notify("Toxic_Quake_Rumble_End");
}

//Function Number: 37
watch_toxic_rumble_end_early(param_00)
{
	self endon("Toxic_Quake_Rumble_End");
	self endon("disconnect");
	level waittill("Toxic_Quake_End");
	self stoprumble(param_00);
}

//Function Number: 38
handle_toxic_water_damage()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = getent("toxic_water_trigger","targetname");
	for(;;)
	{
		if(self istouching(var_00))
		{
			var_01 = 0;
			while(isalive(self) && self istouching(var_00))
			{
				if(var_01 == 0)
				{
					self shellshock("mp_climate_acid",5,0,0,0);
					var_01 = 1;
				}

				self dodamage(5,self.origin,undefined,undefined,"MOD_TRIGGER_HURT","none","none");
				wait(0.1);
				maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
			}

			self fadeoutshellshock();
		}

		wait 0.05;
	}
}

//Function Number: 39
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
		if(level.wateristoxic)
		{
			var_00 thread handle_toxic_water_damage();
		}

		if(level.ventishot)
		{
			var_00 thread check_vent_damage();
		}
	}
}

//Function Number: 40
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread aud_toxic_water_boil_setup();
	}
}

//Function Number: 41
spawnsetup()
{
	level.dynamicspawns = ::getlistofgoodspawnpoints;
}

//Function Number: 42
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

//Function Number: 43
isvalidspawn()
{
	if((level.cancelbadwaterspawns == 1 || level.wateristoxic == 1) && self.targetname == "water_spawn")
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
climatepaladinoverrides()
{
	level.orbitalsupportoverrides.spawnheight = 9279;
	level.orbitalsupportoverrides.spawnradius = 8000;
	level.orbitalsupportoverrides.spawnangle = 312;
}

//Function Number: 45
aud_event_explosion_warning()
{
	var_00 = 30;
	maps\mp\_audio::snd_play_loop_in_space("climate3_event_alarm_lp",(-1150,-1030,1065),"aud_stop_alarm_loops",var_00);
}

//Function Number: 46
aud_event_explosion(param_00)
{
	var_01 = 20;
	var_02 = 5;
	if(param_00 == 1)
	{
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_01",(-1150,-1030,1065));
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_deep",(-1150,-1030,1065));
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_metal",(-1150,-1030,1065));
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_machine",(-1150,-1030,1065));
		level.aud_event_started = 1;
		wait(2);
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_metal_2",(-1150,-1030,1065));
	}

	if(param_00 == 2)
	{
		thread aud_event_start_loops();
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_02",(-630,-580,897),var_01,var_02);
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_02_debris",(-630,-580,897),var_01,var_02);
		wait(0.2);
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_01",(-1150,-1030,1065),var_01,var_02);
		wait(0.3);
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_01",(-1150,-1030,1065),var_01,var_02);
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_02",(-630,-580,897),var_01,var_02);
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_03",(-684,-617,1267),var_01,var_02);
		wait(0.5);
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_01",(-630,-580,897),var_01,var_02);
		wait(0.3);
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_02",(-630,-580,897),var_01,var_02);
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_03",(-684,-617,1267),var_01,var_02);
	}

	if(param_00 == 3)
	{
		maps\mp\_audio::snd_play_in_space("climate3_event_explo_final",(-630,-580,897),var_01,var_02);
		level notify("aud_stop_alarm_loops");
	}
}

//Function Number: 47
aud_event_start_loops()
{
	if(level.aud_event_started == 1)
	{
		var_00 = [(-723,-496,969),(-573,-643,840),(-639,-592,777),(-595,-668,538),(-730,-497,775),(-652,-590,546),(-699,-496,939),(-692,-510,778),(-568,-662,646),(-702,-521,577),(-1184,-1047,959)];
		wait(0.1);
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			maps\mp\_audio::snd_play_loop_in_space("climate3_event_fire_lp",var_00[var_01],"aud_stop_fire_loops");
			if(var_01 % 3 == 2)
			{
				wait(0.1);
			}
		}
	}
}

//Function Number: 48
aud_toxic_water_boil_setup()
{
	if(!level.wateristoxic)
	{
		self clientaddsoundsubmix("mp_pre_event_mix",1);
		return;
	}

	self clientaddsoundsubmix("mp_post_event_mix",1);
}

//Function Number: 49
aud_toxic_water_boil_activate()
{
	foreach(var_01 in level.players)
	{
		var_01 clientclearsoundsubmix("mp_pre_event_mix",1);
		var_01 clientaddsoundsubmix("mp_post_event_mix",1);
		wait(0.05);
	}
}

//Function Number: 50
dyneventflash()
{
	self visionsetnakedforplayer("mp_climate_3_dynEventFlash",0.6);
	thread endvisionondeath();
	wait(0.25);
	level notify("end_flash");
	thread maps\mp\_utility::revertvisionsetforplayer(1.25);
}

//Function Number: 51
endvisionondeath()
{
	level endon("end_flash");
	self waittill("death");
	thread maps\mp\_utility::revertvisionsetforplayer(0);
}