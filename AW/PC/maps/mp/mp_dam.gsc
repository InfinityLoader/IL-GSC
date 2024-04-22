/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_dam.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 440 ms
 * Timestamp: 4/22/2024 2:17:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachemodel("mp_dam_large_caliber_turret");
	maps\mp\mp_dam_precache::main();
	maps\createart\mp_dam_art::main();
	maps\mp\mp_dam_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_dam_lighting::main();
	maps\mp\_compass::setupminimap("compass_map_mp_dam");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.aerial_pathnode_offset = 600;
	level.mapcustomkillstreakfunc = ::damcustomkillstreakfunc;
	level.orbitalsupportoverridefunc = ::damcustomospfunc;
	setdvar("r_mpRimColor","1 1 1");
	setdvar("r_mpRimStrength","1");
	setdvar("r_mpRimDiffuseTint","1 1 1");
	thread rotategenerators();
	thread crane1movement();
	thread crane2movement();
	thread setupkillstreakturrets();
	thread handle_glass_pathing();
	thread damcustomairstrike();
	thread dampatchclip();
	thread removebadtriggerhurtthatguyplacedwrong();
}

//Function Number: 2
removebadtriggerhurtthatguyplacedwrong()
{
	var_00 = (-467,1256,510);
	var_01 = getentarray("trigger_hurt","classname");
	foreach(var_03 in var_01)
	{
		var_04 = distance(var_00,var_03.origin);
		if(var_04 < 32)
		{
			var_03 dontinterpolate();
			var_03.origin = var_03.origin + (0,0,-10000);
		}
	}
}

//Function Number: 3
dampatchclip()
{
	thread uppertreeclip();
	thread constructionclip();
	thread droneexteriorclip();
	thread loungeclip();
}

//Function Number: 4
loungeclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-732,524,207),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-675,528,207),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-676,482,207),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-737,452,212),(0,0,0));
}

//Function Number: 5
droneexteriorclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2455,-223,194),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2495.3,-344.9,194),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2534.91,-466.64,194),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2574.46,-588.38,194),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2455.8,-223.2,66),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2495.4,-344.9,66),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2534.9,-466.6,66),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2574.5,-588.4,66),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2455.8,-223.2,-62),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2495.4,-344.9,-62),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2534.9,-466.6,-62),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2574.5,-588.4,-62),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2577.54,-183.62,194),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2617.09,-305.35,194),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2656.64,-427.09,194),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2696.2,-548.82,194),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2577.5,-183.6,66),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2617.1,-305.4,66),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2656.6,-427.1,66),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2696.2,-548.8,66),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2577.5,-183.6,-62),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2617.1,-305.4,-62),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2656.6,-427.1,-62),(0,18,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_128_128_128",(2696.2,-548.8,-62),(0,18,0));
}

//Function Number: 6
uppertreeclip()
{
	var_00 = (0,344,0);
	var_01 = (-20,-2700,302);
	var_02 = 0;
	for(var_03 = 0;var_03 < 8;var_03++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",var_01 + (0,0,var_02),var_00);
		var_02 = var_02 + 128;
	}
}

//Function Number: 7
constructionclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(894,-704,766),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1150,-704,766),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1406,-704,766),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1662,-704,766),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(774,-840,766),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(774,-1096,766),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(802,-840,766),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(802,-1096,766),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(894,-704,1022),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1252,-908,766),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1150,-704,1022),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1406,-704,1022),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(894,-790,766),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1150,-790,766),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1406,-790,766),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1662,-790,766),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1662,-704,1022),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(774,-840,1022),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(774,-1096,1022),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(802,-840,1022),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(802,-1096,1022),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1252,-908,1022),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(894,-790,1022),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1150,-790,1022),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1406,-790,1022),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1662,-790,1022),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(894,-704,1278),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1150,-704,1278),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1406,-704,1278),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1662,-704,1278),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(774,-840,1278),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(774,-1096,1278),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(802,-840,1278),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(802,-1096,1278),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1252,-908,1278),(0,180,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(894,-790,1278),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1150,-790,1278),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1406,-790,1278),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1662,-790,1278),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1544,-726,572),(0,262,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1292,-708,572),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1156,-708,572),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(904,-726,572),(0,278,0));
}

//Function Number: 8
damcustomairstrike()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 1750;
}

//Function Number: 9
damcustomkillstreakfunc()
{
	level.killstreakweildweapons["mp_dam_railgun"] = 1;
	level.killstreakweildweapons["dam_turret_mp"] = 1;
	level thread maps\mp\killstreaks\streak_mp_dam::init();
}

//Function Number: 10
damcustomospfunc()
{
	level.orbitalsupportoverrides.spawnorigin = (1544,1016,200);
	level.orbitalsupportoverrides.spawnangle = 120;
	level.orbitalsupportoverrides.spawnradius = undefined;
	level.orbitalsupportoverrides.spawnheight = undefined;
}

//Function Number: 11
setupkillstreakturrets()
{
	var_00 = [];
	var_01 = getent("railgun_attachpoint0","targetname");
	var_02 = var_01 spawndamturret("dam_turret_mp","mp_dam_large_caliber_turret","tag_player_mp");
	var_00 = common_scripts\utility::array_add(var_00,var_02);
	var_01 = getent("railgun_attachpoint1","targetname");
	var_02 = var_01 spawndamturret("dam_turret_mp","mp_dam_large_caliber_turret","tag_player_mp");
	var_00 = common_scripts\utility::array_add(var_00,var_02);
	level.damturrets = var_00;
}

//Function Number: 12
spawndamturret(param_00,param_01,param_02)
{
	var_03 = spawnturret("misc_turret",self.origin,param_00,0);
	var_03.attachpoint = self;
	var_03.angles = common_scripts\utility::flat_angle(self.angles);
	var_03 setmodel(param_01);
	var_03 setdefaultdroppitch(45);
	var_03.health = 99999;
	var_03.maxhealth = 1000;
	var_03.damagetaken = 0;
	var_03.stunned = 0;
	var_03.stunnedtime = 0;
	var_03 setcandamage(0);
	var_03 setcanradiusdamage(0);
	var_03 setmode("manual");
	level.damdefaultaiment = getent("DamTurretDefaultTarget","targetname");
	var_03 settargetentity(level.damdefaultaiment);
	return var_03;
}

//Function Number: 13
setupcraneanimations()
{
	precachempanim("dam_crane01_idle_l");
	precachempanim("dam_crane01_idle_r");
	precachempanim("dam_crane01_l_2_r");
	precachempanim("dam_crane01_r_2_l");
	precachempanim("dam_crane02_idle_l");
	precachempanim("dam_crane02_idle_r");
	precachempanim("dam_crane02_l_2_r");
	precachempanim("dam_crane02_r_2_l");
	precachempanim("dam_crane01_tag_idle_l");
	precachempanim("dam_crane01_tag_idle_r");
	precachempanim("dam_crane01_tag_l_2_r");
	precachempanim("dam_crane01_tag_r_2_l");
	precachempanim("dam_crane02_tag_idle_l");
	precachempanim("dam_crane02_tag_idle_r");
	precachempanim("dam_crane02_tag_l_2_r");
	precachempanim("dam_crane02_tag_r_2_l");
	precachempanim("dam_crane01_collisiontest");
}

//Function Number: 14
cranecollisiontest()
{
	var_00 = getent("Crane_02","targetname");
	var_01 = getent("crane2PipeCollision","targetname");
	var_01 linkto(var_00,"j_tube_01_c");
	for(;;)
	{
		var_00 scriptmodelplayanimdeltamotion("dam_crane01_collisiontest");
		wait(20);
	}
}

//Function Number: 15
tempcraneidlesetup()
{
	var_00 = getent("Crane_01","targetname");
	var_01 = getent("crane1PipeCollision","targetname");
	var_01 linkto(var_00,"j_tube_01_c");
	var_02 = getent("Crane_02","targetname");
	var_03 = getent("crane2PipeCollision","targetname");
	var_03 linkto(var_02,"j_tube_01_c");
	var_00 scriptmodelplayanimdeltamotion("dam_crane02_idle_l");
	var_02 scriptmodelplayanimdeltamotion("dam_crane01_idle_l");
}

//Function Number: 16
crane1movement()
{
	var_00 = getent("Crane_01_TagProxy","targetname");
	var_01 = getent("Crane_01","targetname");
	var_02 = getent("crane1PipeCollision","targetname");
	var_03 = getent("crane_01_bcs_trigger","targetname");
	var_04 = getent("Crane_01_TagBaseProxy","targetname");
	var_05 = getent("crane1Collision","targetname");
	var_02 vehicle_jetbikesethoverforcescale(var_00,"tag_origin");
	var_03 handle_trigger_updateto(var_02);
	var_05.angles = var_05.angles + (0,-249.215,0);
	var_05 vehicle_jetbikesethoverforcescale(var_04,"tag_origin");
	var_06 = 20;
	var_07 = (2181,-1069,1407);
	thread aud_play_crane_sfx(var_07,var_06,"crane_01");
	for(;;)
	{
		var_00 scriptmodelclearanim();
		var_00.origin = var_01.origin;
		var_00.angles = var_01.angles;
		var_04 scriptmodelclearanim();
		var_01 scriptmodelplayanimdeltamotion("dam_crane01_l_2_r");
		var_00 scriptmodelplayanimdeltamotion("dam_crane01_tag_l_2_r");
		var_04 scriptmodelplayanimdeltamotion("dam_crane01_tag_base_l_2_r");
		wait(var_06);
		var_00 scriptmodelclearanim();
		var_00.origin = var_01.origin;
		var_00.angles = var_01.angles;
		var_04 scriptmodelclearanim();
		var_01 scriptmodelplayanimdeltamotion("dam_crane01_r_2_l");
		var_00 scriptmodelplayanimdeltamotion("dam_crane01_tag_r_2_l");
		var_04 scriptmodelplayanimdeltamotion("dam_crane01_tag_base_r_2_l");
		wait(var_06);
	}
}

//Function Number: 17
crane2movement()
{
	var_00 = getent("Crane_02_TagProxy","targetname");
	var_01 = getent("Crane_02","targetname");
	var_02 = getent("crane2PipeCollision","targetname");
	var_03 = getent("crane_02_bcs_trigger","targetname");
	var_04 = getent("Crane_02_TagBaseProxy","targetname");
	var_05 = getent("crane2Collision","targetname");
	var_06 = 20;
	var_07 = (849,2315,1455);
	thread aud_play_crane_sfx(var_07,var_06,"crane_02");
	var_02 vehicle_jetbikesethoverforcescale(var_00,"tag_origin");
	var_03 handle_trigger_updateto(var_02);
	var_05.angles = var_05.angles + (0,-117.312,0);
	var_05 vehicle_jetbikesethoverforcescale(var_04,"tag_origin");
	for(;;)
	{
		var_00 scriptmodelclearanim();
		var_00.origin = var_01.origin;
		var_00.angles = var_01.angles;
		var_04 scriptmodelclearanim();
		var_01 scriptmodelplayanimdeltamotion("dam_crane02_l_2_r");
		var_00 scriptmodelplayanimdeltamotion("dam_crane02_tag_l_2_r");
		var_04 scriptmodelplayanimdeltamotion("dam_crane02_tag_base_l_2_r");
		wait(var_06);
		var_00 scriptmodelclearanim();
		var_00.origin = var_01.origin;
		var_00.angles = var_01.angles;
		var_04 scriptmodelclearanim();
		var_01 scriptmodelplayanimdeltamotion("dam_crane02_r_2_l");
		var_00 scriptmodelplayanimdeltamotion("dam_crane02_tag_r_2_l");
		var_04 scriptmodelplayanimdeltamotion("dam_crane02_tag_base_r_2_l");
		wait(var_06);
	}
}

//Function Number: 18
handle_trigger_updateto(param_00)
{
	level endon("game_ended");
	var_01 = self.origin - param_00.origin;
	var_02 = self.angles - param_00.angles;
	childthread movetrig(param_00,var_01,var_02);
}

//Function Number: 19
movetrig(param_00,param_01,param_02)
{
	for(;;)
	{
		self.origin = param_00.origin + param_01;
		self.angles = param_00.angles - param_02;
		wait(0.05);
	}
}

//Function Number: 20
aud_play_crane_sfx(param_00,param_01,param_02)
{
	var_03 = param_00;
	var_04 = spawn("script_origin",var_03);
}

//Function Number: 21
rotategenerators()
{
	var_00 = getentarray("generator_fan","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread rotatefan();
	}
}

//Function Number: 22
rotatefan()
{
	if(!isdefined(level.genrotatespeed))
	{
		level.genrotatespeed = -180;
	}

	var_00 = 0;
	for(;;)
	{
		if(var_00 != level.genrotatespeed)
		{
			self rotatevelocity((0,level.genrotatespeed,0),3600);
			var_00 = level.genrotatespeed;
		}

		wait(0.5);
	}
}

//Function Number: 23
rotatecrane()
{
	level endon("game_ended");
	for(;;)
	{
		self.cab rotateto((0,getdvarint(self.end_angle_dvar,180),0),getdvarint(self.time_dvar,10),1,1);
		self.platform rotateto((0,getdvarint(self.end_angle_dvar,180),0),getdvarint(self.time_dvar,10),1,1);
		self.pipe rotateto((0,getdvarint(self.end_angle_dvar,180),0),getdvarint(self.time_dvar,10),1,1);
		self.pulley rotateto((0,getdvarint(self.end_angle_dvar,180),0),getdvarint(self.time_dvar,10),1,1);
		self.hook rotateto((0,getdvarint(self.end_angle_dvar,180),0),getdvarint(self.time_dvar,10),1,1);
		self.heightoscillator moveto((0,0,getdvarint(self.pipe_end_height_dvar,0)),getdvarint(self.time_dvar,10),1,1);
		self.radiusoscillator moveto((0,0,getdvarint(self.pipe_end_radius_dvar,0)),getdvarint(self.time_dvar,10),1,1);
		wait(getdvarint(self.time_dvar,10) + 5);
		self.cab rotateto((0,getdvarint(self.start_angle_dvar,130),0),getdvarint(self.time_dvar,10),1,1);
		self.platform rotateto((0,getdvarint(self.start_angle_dvar,130),0),getdvarint(self.time_dvar,10),1,1);
		self.pipe rotateto((0,getdvarint(self.start_angle_dvar,130),0),getdvarint(self.time_dvar,10),1,1);
		self.pulley rotateto((0,getdvarint(self.start_angle_dvar,130),0),getdvarint(self.time_dvar,10),1,1);
		self.hook rotateto((0,getdvarint(self.start_angle_dvar,130),0),getdvarint(self.time_dvar,10),1,1);
		self.heightoscillator moveto((0,0,getdvarint(self.pipe_start_height_dvar,0)),getdvarint(self.time_dvar,10),1,1);
		self.radiusoscillator moveto((0,0,getdvarint(self.pipe_start_radius_dvar,0)),getdvarint(self.time_dvar,10),1,1);
		wait(getdvarint(self.time_dvar,10) + 5);
	}
}

//Function Number: 24
movecranepipe()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = (cos(self.platform.angles[1] + 90) * self.radiusoscillator.origin[2] + self.cab.origin[0],sin(self.platform.angles[1] + 90) * self.radiusoscillator.origin[2] + self.cab.origin[1],self.heightoscillator.origin[2]);
		self.pipe moveto(var_00,0.05,0.025,0.025);
		self.pulley moveto((var_00[0],var_00[1],self.pulley.origin[2]),0.05,0.025,0.025);
		self.hook moveto(var_00 + (0,0,270),0.05,0.025,0.025);
		wait(0.05);
	}
}

//Function Number: 25
handlepowersurge()
{
	for(;;)
	{
		wait(getdvarint("mp_dam_surge_interval",50));
		foreach(var_01 in level.spark_origin_tags)
		{
			playfxontag(level.mp_dam_fx["dam_surge_sparks"],var_01,"tag_origin");
		}

		foreach(var_04 in level.surge_vo_origin_tags)
		{
			var_04 thread maps\mp\_utility::play_sound_on_tag(level.pa_warning0,"tag_origin");
		}

		wait(getdvarint("mp_dam_surge_delay",7));
		level.power_surge_active = 1;
		level.genrotatespeed = level.genrotatespeed * 2;
		foreach(var_01 in level.spark_origin_tags)
		{
			playfxontag(level.mp_dam_fx["dam_surge_arcs"],var_01,"tag_origin");
		}

		foreach(var_09 in level.smoke_origin_tags)
		{
		}

		foreach(var_0C in level.elec_sparks_origin_tags)
		{
			var_0C thread common_scripts\utility::play_loop_sound_on_entity(level.surge_sparks_noise);
		}

		foreach(var_04 in level.surge_vo_origin_tags)
		{
			var_04 thread maps\mp\_utility::play_sound_on_tag(level.pa_warning1,"tag_origin");
		}

		wait(getdvarint("mp_dam_surge_duration",30));
		level.power_surge_active = 0;
		level.genrotatespeed = level.genrotatespeed / 2;
		foreach(var_01 in level.spark_origin_tags)
		{
			stopfxontag(level.mp_dam_fx["dam_surge_sparks"],var_01,"tag_origin");
			stopfxontag(level.mp_dam_fx["dam_surge_arcs"],var_01,"tag_origin");
		}

		foreach(var_09 in level.smoke_origin_tags)
		{
		}

		foreach(var_0C in level.elec_sparks_origin_tags)
		{
			var_0C thread common_scripts\utility::stop_loop_sound_on_entity(level.surge_sparks_noise);
		}

		wait(0.05);
	}
}

//Function Number: 26
handlepowersurgedamage()
{
	for(;;)
	{
		if(level.power_surge_active == 1)
		{
			foreach(var_01 in level.players)
			{
				foreach(var_03 in level.dam_surge_triggers)
				{
					if(var_01 istouching(var_03))
					{
						var_01 playrumbleonentity("damage_heavy");
						var_01 shellshock("orbital_laser_mp",1);
						var_01 dodamage(5,var_01.origin);
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 27
handle_glass_pathing()
{
	var_00 = getglassarray("skylights");
	var_01 = getentarray("skylights","targetname");
	var_02 = getentarray("glass_pathing","targetname");
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_03 = 8;
	foreach(var_05 in var_00)
	{
		var_06 = getglassorigin(var_05);
		foreach(var_08 in var_01)
		{
			if(distance(var_06,var_08.origin) <= var_03)
			{
				var_08.glass_id = var_05;
				break;
			}
		}
	}

	common_scripts\utility::array_thread(var_01,::handle_pathing_on_glass);
}

//Function Number: 28
handle_pathing_on_glass()
{
	level endon("game_ended");
	var_00 = getent(self.target,"targetname");
	if(!isdefined(var_00))
	{
		return 0;
	}

	var_00 common_scripts\utility::trigger_off();
	var_00 connectpaths();
	waittill_glass_break(self.glass_id);
	var_00 common_scripts\utility::trigger_on();
	var_00 disconnectpaths();
	var_00 common_scripts\utility::trigger_off();
}

//Function Number: 29
waittill_glass_break(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		if(isglassdestroyed(param_00))
		{
			return 1;
		}

		wait(0.05);
	}
}