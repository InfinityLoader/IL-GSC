/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_spark.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 263 ms
 * Timestamp: 4/22/2024 2:18:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::spark_callbackstartgametype;
	maps\mp\mp_spark_precache::main();
	maps\createart\mp_spark_art::main();
	maps\mp\mp_spark_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_spark_lighting::main();
	maps\mp\mp_spark_aud::main();
	level.mapcustomkillstreakfunc = ::customkillstreakfunc;
	maps\mp\_compass::setupminimap("compass_map_mp_spark");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level thread animatefusioncore();
	level thread animateassemblyarms();
	level thread animaterobotline();
	level thread animatehangingexos();
	level thread fixcarepackagelinkingtofans();
	if(level.nextgen)
	{
		level thread vistadroppods();
		level thread spinfans();
		if(level.gametype == "ball")
		{
			level thread uplinkballvisionset();
		}
	}

	level.missileitemclipdelay = 0;
	level thread patchclip();
}

//Function Number: 2
spark_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 3
customkillstreakfunc()
{
	maps\mp\killstreaks\streak_mp_spark::init();
}

//Function Number: 4
animatefusioncore()
{
	var_00 = ["fusion_core_spin"];
	var_01 = ["fusion_core_spin"];
	var_02 = getent("fusion_core","targetname");
	if(isdefined(var_02))
	{
		maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename(var_02,"mp_spark_fusion_core_spin","aud_fusion_core_notify",var_00,var_01,"fusionCore_end_01","fusionCore_end_02","fusionCore_end_03");
	}
}

//Function Number: 5
animateassemblyarms()
{
	var_00 = common_scripts\utility::getstruct("robot_anim_node","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.angles))
	{
		var_00.angles = (0,0,0);
	}

	var_01 = getentarray("lab_assembly_robot_arm_02_scaled_anim","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] scriptmodelplayanimdeltamotionfrompos("mp_spark_assembly_arm_0" + var_02 + 1,var_00.origin,var_00.angles,"nothing");
	}

	var_03 = getentarray("spk_exolab_track_exo_hanger2","targetname");
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		var_03[var_02] scriptmodelplayanimdeltamotionfrompos("mp_spark_assembly_exo_0" + var_02 + 1,var_00.origin,var_00.angles,"nothing");
	}
}

//Function Number: 6
animaterobotline()
{
	var_00 = common_scripts\utility::getstruct("assembly_line_node","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.angles))
	{
		var_00.angles = (0,0,0);
	}

	var_01 = getentarray("spk_exolab_track_robot_hanger","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] scriptmodelplayanimdeltamotionfrompos("mp_spark_robot_line_0" + var_02 + 1,var_00.origin,var_00.angles,"nothing");
	}
}

//Function Number: 7
animatehangingexos()
{
	var_00 = common_scripts\utility::getstruct("assembly_line_node","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.angles))
	{
		var_00.angles = (0,0,0);
	}

	var_01 = getentarray("spk_exolab_track_exo_hanger","targetname");
	if(var_01.size < 3)
	{
		return;
	}

	var_01[0] scriptmodelplayanimdeltamotionfrompos("mp_spark_exo_line_01",var_00.origin,var_00.angles,"nothing");
	var_01[1] scriptmodelplayanimdeltamotionfrompos("mp_spark_exo_line_03",var_00.origin,var_00.angles,"nothing");
	var_01[2] scriptmodelplayanimdeltamotionfrompos("mp_spark_exo_line_05",var_00.origin,var_00.angles,"nothing");
	var_01 = getentarray("spk_exolab_track_hanger","targetname");
	if(var_01.size < 2)
	{
		return;
	}

	var_01[0] scriptmodelplayanimdeltamotionfrompos("mp_spark_exo_line_02",var_00.origin,var_00.angles,"nothing");
	var_01[1] scriptmodelplayanimdeltamotionfrompos("mp_spark_exo_line_04",var_00.origin,var_00.angles,"nothing");
}

//Function Number: 8
vistadroppods()
{
	var_00 = 24000;
	var_01 = 1;
	var_02 = 4;
	var_03 = 15;
	level.sparkdroppods = getentarray("vistaMissilePods","targetname");
	level.sparkdroplocations = common_scripts\utility::getstructarray("vistaMissileSpawn","targetname");
	level.sparkdroplocationindex = 0;
	if(level.sparkdroplocations.size == 0)
	{
		return;
	}

	if(level.sparkdroppods.size == 0)
	{
		for(var_04 = 0;var_04 < 4;var_04++)
		{
			var_05 = spawn("script_model",(0,0,-10000));
			var_05 setmodel("spk_vehicle_mil_drop_pod");
			level.sparkdroppods[level.sparkdroppods.size] = var_05;
		}
	}

	foreach(var_07 in level.sparkdroplocations)
	{
		var_08 = common_scripts\utility::getstruct(var_07.target,"targetname");
		var_07.end = var_08.origin;
		var_09 = vectornormalize(var_07.origin - var_08.origin);
		var_07.start = var_08.origin + var_09 * var_00;
		var_07.startangles = vectortoangles(var_09) + (270,0,0);
	}

	wait(1);
	level.sparkdroplocations = common_scripts\utility::array_randomize(level.sparkdroplocations);
	for(var_04 = 0;var_04 < level.sparkdroppods.size;var_04++)
	{
		var_0B = level.sparkdroppods[var_04];
		level thread firepod(var_0B);
		var_0C = randomfloatrange(var_01,var_02);
		wait(var_0C);
	}

	for(;;)
	{
		level waittill("podComplete",var_0B);
		var_0D = var_03 + var_01;
		var_0E = var_03 + var_02;
		var_0C = randomfloatrange(var_0D,var_0E);
		level thread firepod(var_0B,var_0C);
	}
}

//Function Number: 9
firepod(param_00,param_01)
{
	var_02 = 8;
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	playfxontag(common_scripts\utility::getfx("mp_spark_drop_pod"),param_00,"tag_fx");
	param_00 playloopsound("incoming_ambient_pods_lp");
	if(level.sparkdroplocationindex >= level.sparkdroplocations.size)
	{
		level.sparkdroplocations = common_scripts\utility::array_randomize(level.sparkdroplocations);
		level.sparkdroplocationindex = 0;
	}

	var_03 = level.sparkdroplocations[level.sparkdroplocationindex];
	level.sparkdroplocationindex++;
	param_00 dontinterpolate();
	param_00.origin = var_03.start;
	param_00.angles = var_03.startangles;
	param_00 moveto(var_03.end,var_02,var_02,0);
	wait(var_02);
	killfxontag(common_scripts\utility::getfx("mp_spark_drop_pod"),param_00,"tag_fx");
	param_00 stoploopsound();
	playfx(common_scripts\utility::getfx("mp_spark_drop_pod_impact"),var_03.end);
	level notify("podComplete",param_00);
}

//Function Number: 10
spinfans()
{
	var_00 = getentarray("spk_wall_fan_blade_rotate_fast_01","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread fan1spin();
	}
}

//Function Number: 11
fan1spin()
{
	if(!isdefined(self))
	{
		return;
	}

	var_00 = 500;
	var_01 = 20000;
	for(;;)
	{
		self rotatevelocity((var_00,0,0),var_01);
		wait(var_01);
	}
}

//Function Number: 12
fixcarepackagelinkingtofans()
{
	common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate_slow","targetname"),::fannocontents);
	common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate","targetname"),::fannocontents);
	common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate_fast","targetname"),::fannocontents);
	common_scripts\utility::array_thread(getentarray("spk_wall_fan_blade_rotate_fast_01","targetname"),::fannocontents);
}

//Function Number: 13
fannocontents()
{
	self setcontents(0);
}

//Function Number: 14
uplinkballvisionset()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread playerhandleuplinkvisionset();
	}
}

//Function Number: 15
playerhandleuplinkvisionset()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getcurrentprimaryweapon();
		if(isdefined(var_00))
		{
			if(issubstr(var_00,"iw5_carrydrone"))
			{
				self setclienttriggervisionset("mp_spark_uplink_inview",0.3);
				self lightsetoverrideenableforplayer("mp_spark_uplink_inview",0.3);
			}
			else
			{
				self setclienttriggervisionset("",0.5);
				self lightsetoverrideenableforplayer(0.5);
			}
		}

		wait 0.05;
	}
}

//Function Number: 16
patchclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(-63,165,896),(90,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(212,129,896),(90,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(493,125,896),(90,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(819,216,896),(90,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(819,1082,896),(90,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(496,1170,896),(90,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(209,1168,896),(90,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_64_64",(-57,1128,896),(90,0,0));
}