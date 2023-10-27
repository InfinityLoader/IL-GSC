/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_littlebird_landing.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 253 ms
 * Timestamp: 10/27/2023 2:51:09 AM
*******************************************************************/

//Function Number: 1
init_littlebird_landing()
{
	if(isdefined(level.little_bird_landing_init))
	{
		return;
	}

	level.little_bird_landing_init = 1;
	thread init_littlebird_landing_thread();
}

//Function Number: 2
init_littlebird_landing_thread()
{
	waittillframeend;
	common_scripts\utility::array_thread(common_scripts\utility::getstructarray("gag_stage_littlebird_unload","script_noteworthy"),::setup_gag_stage_littlebird_unload);
	common_scripts\utility::array_thread(common_scripts\utility::getstructarray("gag_stage_littlebird_load","script_noteworthy"),::setup_gag_stage_littlebird_load);
}

//Function Number: 3
littlebird_landing()
{
	self endon("death");
	maps\_utility::ent_flag_init("prep_unload");
	maps\_utility::ent_flag_wait("prep_unload");
	maps\_vehicle_code::turn_unloading_drones_to_ai();
	var_00 = get_landing_node();
	var_00 littlebird_lands_and_unloads(self);
	maps\_vehicle::vehicle_paths(var_00);
}

//Function Number: 4
stage_guy(param_00,param_01,param_02,param_03)
{
	var_04 = "stage_littlebird_" + param_01;
	var_05 = [];
	var_05[0] = param_00;
	param_03 maps\_anim::anim_generic_reach(var_05[0],var_04,"tag_detach_" + param_01);
	param_03 maps\_anim::anim_generic(var_05[0],var_04,"tag_detach_" + param_01);
	maps\_utility::ent_flag_set("staged_guy_" + param_01);
	param_00 setgoalpos(common_scripts\utility::drop_to_ground(param_00.origin));
	param_00.goalradius = 16;
	maps\_utility::ent_flag_wait("guy2_in_" + param_01);
	thread maps\_vehicle_aianim::load_ai([param_00],undefined,param_01);
}

//Function Number: 5
setup_gag_stage_littlebird_unload()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		littlebird_lands_and_unloads(var_00);
	}
}

//Function Number: 6
setup_gag_stage_littlebird_load()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		var_00 setdeceleration(6);
		var_00 setacceleration(4);
		var_00 settargetyaw(self.angles[1]);
		var_00 vehicle_setspeed(20,7,7);
		while(distance(common_scripts\utility::flat_origin(var_00.origin),common_scripts\utility::flat_origin(self.origin)) > 256)
		{
			wait(0.05);
		}

		var_00 endon("death");
		var_00 thread vehicle_land_beneath_node(220,self);
		var_00 waittill("near_goal");
		var_00 vehicle_setspeed(20,22,7);
		var_00 thread vehicle_land_beneath_node(16,self);
		var_00 waittill("near_goal");
		var_00 maps\_vehicle_code::waittill_stable();
		var_00 notify("touch_down",self);
		var_00 vehicle_setspeed(20,8,7);
	}
}

//Function Number: 7
littlebird_lands_and_unloads(param_00)
{
	param_00 setdeceleration(6);
	param_00 setacceleration(4);
	param_00 settargetyaw(self.angles[1]);
	param_00 vehicle_setspeed(20,7,7);
	while(distance(common_scripts\utility::flat_origin(param_00.origin),common_scripts\utility::flat_origin(self.origin)) > 512)
	{
		wait(0.05);
	}

	param_00 endon("death");
	var_01 = "landing" + randomint(99999);
	badplace_cylinder(var_01,30,self.origin,200,300,"axis","allies","neutral","team3");
	param_00 thread vehicle_land_beneath_node(424,self);
	param_00 waittill("near_goal");
	badplace_delete(var_01);
	badplace_cylinder(var_01,30,self.origin,200,300,"axis","allies","neutral","team3");
	param_00 notify("groupedanimevent","pre_unload");
	param_00 thread maps\_vehicle_aianim::animate_guys("pre_unload");
	param_00 vehicle_setspeed(20,22,7);
	param_00 notify("nearing_landing");
	if(isdefined(param_00.custom_landing))
	{
		switch(param_00.custom_landing)
		{
			case "hover_then_land":
				break;

			default:
				break;
		}
	}
}

//Function Number: 8
set_stage(param_00,param_01,param_02)
{
	if(!maps\_utility::ent_flag_exist("staged_guy_" + param_02))
	{
		maps\_utility::ent_flag_init("staged_guy_" + param_02);
	}
	else
	{
		maps\_utility::ent_flag_clear("staged_guy_" + param_02);
	}

	if(!maps\_utility::ent_flag_exist("guy2_in_" + param_02))
	{
		maps\_utility::ent_flag_init("guy2_in_" + param_02);
	}
	else
	{
		maps\_utility::ent_flag_clear("guy2_in_" + param_02);
	}

	var_03 = get_stage_nodes(param_00,param_02);
	var_04 = common_scripts\utility::getstruct(param_00.target,"targetname");
	var_05 = spawn("script_model",(0,0,0));
	var_05 setmodel(self.model);
	if(isdefined(self.new_stage_heli_spawn))
	{
		var_05.origin = self.origin;
	}
	else
	{
		var_05.origin = common_scripts\utility::drop_to_ground(var_04.origin) + (0,0,self.originheightoffset);
	}

	var_05.angles = var_04.angles;
	var_05 hide();
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	foreach(var_0A in var_03)
	{
		var_0B = undefined;
		foreach(var_0D in param_01)
		{
			if(isdefined(var_0D.script_startingposition) && var_0D.script_startingposition == var_0A.script_startingposition)
			{
				var_0B = var_0D;
				break;
			}
		}

		if(!isdefined(var_0B))
		{
			var_0B = common_scripts\utility::getclosest(var_0A.origin,param_01);
		}

		var_0B.script_startingposition = var_0A.script_startingposition;
		if(var_0B.script_startingposition == 2 || var_0B.script_startingposition == 5)
		{
			var_06 = var_0B;
			var_0B maps\_spawner::go_to_node_set_goal_node(var_0A);
		}
		else if(var_0B.script_startingposition == 3 || var_0B.script_startingposition == 6)
		{
			var_08 = var_0B;
		}
		else if(var_0B.script_startingposition == 4 || var_0B.script_startingposition == 7)
		{
			var_07 = var_0B;
			var_0B maps\_spawner::go_to_node_set_goal_node(var_0A);
		}

		param_01 = common_scripts\utility::array_remove(param_01,var_0B);
	}

	thread stage_guy(var_08,param_02,var_07,var_05);
	thread common_scripts\utility::delete_on_death(var_05);
}

//Function Number: 9
get_stage_nodes(param_00,param_01)
{
	var_02 = getnodearray(param_00.target,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(var_05.script_noteworthy == "stage_" + param_01)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 10
get_landing_node()
{
	var_00 = self.currentnode;
	for(;;)
	{
		var_01 = maps\_utility::getent_or_struct(var_00.target,"targetname");
		if(isdefined(var_01.script_unload))
		{
			return var_01;
		}

		var_00 = var_01;
	}
}

//Function Number: 11
load_side(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	foreach(var_06 in param_01)
	{
		if(var_06.script_startingposition == 2 || var_06.script_startingposition == 5)
		{
			var_02 = var_06;
			continue;
		}

		if(var_06.script_startingposition == 3 || var_06.script_startingposition == 6)
		{
			var_04 = var_06;
			continue;
		}

		if(var_06.script_startingposition == 4 || var_06.script_startingposition == 7)
		{
			var_03 = var_06;
		}
	}

	maps\_utility::ent_flag_wait("staged_guy_" + param_00);
	thread maps\_vehicle::vehicle_load_ai_single(var_02,undefined,param_00);
	var_02 waittill("boarding_vehicle");
	thread maps\_vehicle::vehicle_load_ai_single(var_03,undefined,param_00);
	var_03 waittill("boarding_vehicle");
	maps\_utility::ent_flag_set("guy2_in_" + param_00);
}

//Function Number: 12
vehicle_land_beneath_node(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self notify("newpath");
	if(!isdefined(param_00))
	{
		param_00 = 2;
	}

	self neargoalnotifydist(param_00);
	self sethoverparams(0,0,0);
	self cleargoalyaw();
	self settargetyaw(common_scripts\utility::flat_angle(param_01.angles)[1]);
	maps\_vehicle_code::_setvehgoalpos_wrap(maps\_utility::groundpos(param_01.origin) + (0,0,param_02),1);
	self waittill("goal");
}