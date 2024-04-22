/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_levity.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 372 ms
 * Timestamp: 4/22/2024 2:17:54 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_levity_precache::main();
	maps\createart\mp_levity_art::main();
	maps\mp\mp_levity_fx::main();
	maps\mp\_load::main();
	thread set_lighting_values();
	maps\mp\mp_levity_lighting::main();
	thread maps\mp\mp_levity_aud::main();
	level.aerial_pathnode_offset = 600;
	level.aerial_pathnodes_force_connect[0] = spawnstruct();
	level.aerial_pathnodes_force_connect[0].origin = (-977,-1811,2054);
	level.aerial_pathnodes_force_connect[0].radius = 275;
	maps\mp\_compass::setupminimap("compass_map_mp_levity");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	common_scripts\utility::array_thread(getentarray("com_radar_dish","targetname"),::radar_dish_rotate);
	level thread hanger_event();
	level thread init_fans();
	level thread init_antenna();
	level thread levitypatchclip();
	if(level.nextgen)
	{
		level thread init_assembly_line();
		setdvar("sm_polygonOffsetPreset",2);
	}
}

//Function Number: 2
levitypatchclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(766,-3192,1488.5),(352.5,311.3,0.110002));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(963.5,-3033,1488.5),(352.5,306.4,0.109992));
}

//Function Number: 3
init_assembly_line()
{
	var_00 = ["mp_lev_drone_assembly_line_01","mp_lev_drone_assembly_line_02","mp_lev_drone_assembly_line_03","mp_lev_drone_assembly_line_04","mp_lev_drone_assembly_line_05","mp_lev_drone_assembly_line_06","mp_lev_drone_assembly_line_07"];
	foreach(var_02 in var_00)
	{
		precachempanim(var_02);
	}

	var_04 = common_scripts\utility::getstruct("robot_arm_scripted_node","targetname");
	var_05 = getentarray("assembly_line_drone","targetname");
	foreach(var_08, var_07 in var_05)
	{
		var_07 thread run_assembly_line(var_04,var_00[var_08]);
	}
}

//Function Number: 4
run_assembly_line(param_00,param_01)
{
	self endon("death");
	var_02 = "droneNT";
	self scriptmodelplayanimdeltamotionfrompos(param_01,param_00.origin,param_00.angles,var_02);
	for(;;)
	{
		self waittill(var_02,var_03);
		var_04 = self gettagorigin("j_drone");
		switch(var_03)
		{
			case "drone_sound_start":
				playsoundatpos(var_04,"drone_gear_start");
				break;
	
			case "drone_sound_stop":
				playsoundatpos(var_04,"drone_gear_stop");
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 5
init_fans()
{
	var_00 = "mp_lev_ind_thermanl_cell_fan_spin";
	precachempanim(var_00);
	var_01 = getentarray("levity_animated_fan","targetname");
	common_scripts\utility::array_thread(var_01,::run_fan,var_00);
}

//Function Number: 6
run_fan(param_00)
{
	self scriptmodelplayanimdeltamotion(param_00);
}

//Function Number: 7
init_antenna()
{
	var_00 = getentarray("levity_antenna","targetname");
	common_scripts\utility::array_thread(var_00,::radar_dish_rotate,20);
}

//Function Number: 8
radar_dish_rotate(param_00)
{
	var_01 = 40000;
	if(!isdefined(param_00))
	{
		param_00 = 70;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "lockedspeed")
	{
		wait(0);
	}
	else
	{
		wait(randomfloatrange(0,1));
	}

	for(;;)
	{
		self rotatevelocity((0,param_00,0),var_01);
		wait(var_01);
	}
}

//Function Number: 9
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

//Function Number: 10
hanger_event()
{
	level.event_ents = getentarray("hanger_event","targetname");
	common_scripts\utility::array_thread(level.event_ents,::hanger_floor_init);
	common_scripts\utility::array_thread(level.event_ents,::hanger_ent_init);
	common_scripts\utility::array_thread(level.event_ents,::hanger_event_idle_anims);
}

//Function Number: 11
event_start()
{
	common_scripts\utility::array_thread(level.event_ents,::hanger_floor_run);
	thread maps\mp\mp_levity_aud::event_aud();
}

//Function Number: 12
event_reset()
{
	common_scripts\utility::array_thread(level.event_ents,::hanger_ent_reset);
	common_scripts\utility::array_thread(level.event_ents,::hanger_event_idle_anims);
	hanger_event_connect_nodes_drone();
	hanger_event_connect_nodes_floor();
}

//Function Number: 13
hanger_ent_init()
{
	self.start_origin = self.origin;
	self.start_angles = self.angles;
}

//Function Number: 14
hanger_ent_reset()
{
	if(isdefined(self.event_animated) && self.event_animated)
	{
		self scriptmodelclearanim();
		if(isdefined(self.collision_prop))
		{
			self.collision_prop scriptmodelclearanim();
		}
	}

	self.origin = self.start_origin;
	self.angles = self.start_angles;
}

//Function Number: 15
hanger_floor_init()
{
	var_00 = (60,0,0);
	switch(self.script_noteworthy)
	{
		case "hanger_door_left":
			self.origin = self.origin - var_00;
			self disconnectpaths();
			break;

		case "hanger_door_right":
			self.origin = self.origin + var_00;
			self disconnectpaths();
			break;

		case "drone":
			if(isdefined(self.target))
			{
				var_01 = getent(self.target,"targetname");
				var_01.carepackagetouchvalid = 1;
				var_01 linkto(self);
			}
			break;

		default:
			break;
	}
}

//Function Number: 16
drone_fx()
{
	waittillframeend;
	var_00 = spawnlinkedfx(common_scripts\utility::getfx("mp_levity_aircraft_light"),self,"tag_fx_camera");
	triggerfx(var_00);
}

//Function Number: 17
hanger_event_idle_anims()
{
	switch(self.script_noteworthy)
	{
		case "drone":
			self.event_animated = 1;
			var_00 = [];
			var_00["drone"] = "mp_lev_drone_deploy_idle";
			var_01 = common_scripts\utility::getstruct("ref_anim_node","targetname");
			self scriptmodelplayanimdeltamotionfrompos(var_00[self.script_noteworthy],var_01.origin,var_01.angles);
			if(isdefined(self.collision_prop))
			{
				self.collision_prop scriptmodelplayanimdeltamotionfrompos(var_00[self.script_noteworthy + "_collision"],var_01.origin,var_01.angles);
			}
	
			thread drone_fx();
			break;

		default:
			break;
	}
}

//Function Number: 18
hanger_floor_run()
{
	var_00 = 270;
	var_01 = 2;
	var_02 = 110;
	var_03 = 2;
	var_04 = 90;
	var_05 = 1.5;
	var_06 = 2;
	var_07 = -512;
	var_08 = 6000;
	var_09 = 2;
	var_0A = 1;
	var_0B = 1;
	switch(self.script_noteworthy)
	{
		case "hanger_floor_left":
			hanger_event_disconnect_nodes_floor();
			self movex(-1 * var_00,var_01);
			break;

		case "hanger_floor_right":
			self movex(var_00,var_01);
			break;

		case "drone":
			var_0C = [];
			var_0C["drone"] = "mp_lev_drone_deploy";
			var_0D = common_scripts\utility::getstruct("ref_anim_node","targetname");
			wait(var_05);
			self scriptmodelplayanimdeltamotionfrompos(var_0C[self.script_noteworthy],var_0D.origin,var_0D.angles);
			if(isdefined(self.collision_prop))
			{
				self.collision_prop scriptmodelplayanimdeltamotionfrompos(var_0C[self.script_noteworthy + "_collision"],var_0D.origin,var_0D.angles);
			}
			break;

		case "window":
			wait(var_05);
			var_0E = common_scripts\utility::getstruct(self.target,"targetname");
			self moveto(var_0E.origin,var_0A);
			break;

		case "window_step":
			wait(var_05);
			var_0E = common_scripts\utility::getstruct(self.target,"targetname");
			self moveto(var_0E.origin,var_0B);
			break;

		default:
			break;
	}
}

//Function Number: 19
hanger_event_disconnect_nodes(param_00)
{
	var_01 = getent(param_00,"targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_01.origin = var_01.origin + (0,0,1200);
	var_01 disconnectpaths();
	var_01.origin = var_01.origin - (0,0,1200);
}

//Function Number: 20
hanger_event_disconnect_nodes_drone()
{
	hanger_event_disconnect_nodes("path_node_disconnect_drone");
}

//Function Number: 21
hanger_event_disconnect_nodes_floor()
{
	hanger_event_disconnect_nodes("path_node_disconnect_floor");
}

//Function Number: 22
hanger_event_connect_nodes(param_00)
{
	var_01 = getent(param_00,"targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_01 connectpaths();
}

//Function Number: 23
hanger_event_connect_nodes_drone()
{
	hanger_event_connect_nodes("path_node_disconnect_drone");
}

//Function Number: 24
hanger_event_connect_nodes_floor()
{
	hanger_event_connect_nodes("path_node_disconnect_floor");
}