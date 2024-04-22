/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _warzone_tactics.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 381 ms
 * Timestamp: 4/22/2024 2:24:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachemodel("weapon_javelin_tactics_friendly");
	precachemodel("weapon_smaw_tactics_friendly");
	precachemodel("vehicle_gaz_tigr_base_tactics_enemy");
	precachemodel("vehicle_x4walker_wheels_tactics_friendly");
	precachemodel("weapon_dshk_turret_tactics_enemy");
	precachemodel("vehicle_pdrone_tactics_friendly");
	precachemodel("vehicle_walker_tank_tactics_enemy");
	precachemodel("weapon_rpg7_tactics_friendly");
	common_scripts\utility::flag_init("tactics_mode_on");
	level.tactics_objects = [];
	level.tactics_objectives = [];
	level.tactics_tools = [];
	maps\_utility::add_global_spawn_function("axis",::monitor_rpg_drop);
}

//Function Number: 2
add_object_to_tactics_system(param_00)
{
	if(!isdefined(level.tactics_objects))
	{
		return;
	}

	if(issubstr(param_00.classname,"vehicle"))
	{
		param_00 thread remove_vehicle_from_tactics_array_on_death();
	}

	if(issubstr(param_00.classname,"x4walker"))
	{
		param_00 thread remove_turret_on_mount();
	}

	level.tactics_objects[level.tactics_objects.size] = param_00;
}

//Function Number: 3
remove_object_from_tactics_system(param_00)
{
	param_00 remove_from_arrays();
}

//Function Number: 4
monitor_tactics_mode()
{
	level.player endon("death");
	level.player endon("end_tactics_mode");
	level.player thread monitor_player_rpg_drop();
	for(;;)
	{
		if(level.player buttonpressed("DPAD_UP"))
		{
			foreach(var_01 in level.tactics_objects)
			{
				if(!isdefined(var_01))
				{
					continue;
				}

				if(var_01.tactics_type == "objective" && !maps\_utility::is_in_array(level.tactics_objectives,var_01))
				{
					level.tactics_objectives[level.tactics_objectives.size] = var_01;
					continue;
				}

				if(var_01.tactics_type == "tool" && !maps\_utility::is_in_array(level.tactics_tools,var_01))
				{
					level.tactics_tools[level.tactics_tools.size] = var_01;
				}
			}

			if(!common_scripts\utility::flag("tactics_mode_on"))
			{
				level.player notify("start_tactics_mode");
				thread change_to_tactics_models();
				thread draw_text_hud(level.player,level.tactics_objectives,level.tactics_tools);
			}

			common_scripts\utility::flag_set("tactics_mode_on");
		}
		else
		{
			if(common_scripts\utility::flag("tactics_mode_on"))
			{
				level.player notify("stop_tactics_mode");
				thread change_to_original_models();
			}

			common_scripts\utility::flag_clear("tactics_mode_on");
		}

		wait(0.05);
	}
}

//Function Number: 5
change_to_tactics_models()
{
	foreach(var_01 in level.tactics_objects)
	{
		if(isdefined(var_01))
		{
			var_01 setmodel(var_01.tactics_model);
		}
	}
}

//Function Number: 6
change_to_original_models()
{
	foreach(var_01 in level.tactics_objects)
	{
		if(isdefined(var_01))
		{
			var_01 setmodel(var_01.original_model);
		}
	}
}

//Function Number: 7
draw_tactics_lines(param_00,param_01)
{
	level.player endon("stop_tactics_mode");
	level.player endon("death");
	for(;;)
	{
		foreach(var_03 in param_00)
		{
			foreach(var_05 in param_01)
			{
				if(!isdefined(var_05) || isdefined(var_05.no_line) && var_05.no_line)
				{
					continue;
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 8
draw_text_hud(param_00,param_01,param_02)
{
	foreach(var_04 in param_01)
	{
		var_04 thread draw_text_hud_objective(param_00);
	}

	foreach(var_07 in param_02)
	{
		var_07 thread draw_text_hud_tool(param_00);
	}
}

//Function Number: 9
draw_text_hud_objective(param_00)
{
	if(!isdefined(self.description))
	{
		return;
	}

	self.drawing_warzone_hud = 1;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto_with_world_offset(self,undefined,(0,0,72));
	var_02 = newclienthudelem(param_00);
	var_02 settargetent(var_01);
	var_02.positioninworld = 1;
	var_02 settext(self.description);
	var_02.color = (1,0.44,0.39);
	var_02.alpha = 1;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02 thread scale_3d_hud_elem(var_01,param_00);
	var_02 setpulsefx(60,999999,0);
	wait_till_should_stop_drawing(param_00);
	var_02 destroy();
	var_01 delete();
	if(isdefined(self))
	{
		self.drawing_warzone_hud = undefined;
	}
}

//Function Number: 10
draw_text_hud_tool(param_00)
{
	if(!isdefined(self.description))
	{
		return;
	}

	self.drawing_warzone_hud = 1;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto_with_world_offset(self,undefined,(0,0,72));
	var_02 = newclienthudelem(param_00);
	var_02 settargetent(var_01);
	var_02.positioninworld = 1;
	var_02 settext(self.description);
	var_02.color = (0.3,1,0.6);
	var_02.alpha = 0.5;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.z = -0.5;
	var_02 thread scale_3d_hud_elem(var_01,param_00);
	var_02 setpulsefx(60,999999,0);
	var_03 = newclienthudelem(param_00);
	var_03 settargetent(var_01);
	var_03.positioninworld = 1;
	var_03.color = (0.3,1,0.6);
	var_03.alpha = 0.5;
	var_03.alignx = "center";
	var_03.aligny = "middle";
	var_03.z = 0.5;
	var_03 thread scale_3d_hud_elem(var_01,param_00);
	var_03 thread hud_elem_update_distance(var_01,param_00);
	wait_till_should_stop_drawing(param_00);
	var_02 destroy();
	var_03 destroy();
	var_01 delete();
	if(isdefined(self))
	{
		self.drawing_warzone_hud = undefined;
	}
}

//Function Number: 11
wait_till_should_stop_drawing(param_00)
{
	self endon("death");
	param_00 endon("stop_tactics_mode");
	param_00 endon("death");
	level waittill("forever");
}

//Function Number: 12
scale_3d_hud_elem(param_00,param_01)
{
	self endon("death");
	for(;;)
	{
		self.fontscale = maps\_shg_utility::linear_map_clamp(distance(param_00.origin,param_01 geteye()),16,1024,2.5,1.5);
		wait 0.05;
	}
}

//Function Number: 13
hud_elem_update_distance(param_00,param_01)
{
	self endon("death");
	wait(0.8);
	for(;;)
	{
		var_02 = distance(param_00.origin,param_01 geteye()) / 39.37008;
		self settext(int(var_02 + 0.5));
		wait 0.05;
	}
}

//Function Number: 14
linkto_with_world_offset(param_00,param_01,param_02)
{
	thread linkto_with_world_offset_internal(param_00,param_01,param_02);
}

//Function Number: 15
unlinkto_with_world_offset()
{
	self notify("stop_link_with_world_offset");
}

//Function Number: 16
linkto_with_world_offset_internal(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	self endon("stop_link_with_world_offset");
	for(;;)
	{
		waittillframeend;
		if(isdefined(param_01))
		{
			self.origin = param_00 gettagorigin(param_01) + param_02;
		}
		else
		{
			self.origin = param_00.origin + param_02;
		}

		wait 0.05;
	}
}

//Function Number: 17
monitor_rpg_drop()
{
	level.player endon("death");
	if(!issubstr(self.classname,"rpg"))
	{
		return;
	}

	self waittill("weapon_dropped",var_00);
	if(isdefined(var_00) && issubstr(var_00.classname,"rpg"))
	{
		var_00 add_rpg_to_tactics_system();
	}
}

//Function Number: 18
add_rpg_to_tactics_system()
{
	self.description = "SMAW";
	self.original_model = self.model;
	self.tactics_model = "weapon_smaw_tactics_friendly";
	self.tactics_type = "tool";
	level.tactics_objects = common_scripts\utility::array_add(level.tactics_objects,self);
	thread remove_from_tactics_array_on_pickup();
	thread remove_from_tactics_array_on_delete();
}

//Function Number: 19
remove_from_tactics_array_on_pickup()
{
	level.player endon("death");
	level.player endon("end_tactics_mode");
	for(;;)
	{
		level.player waittill("pickup",var_00);
		if(var_00 == self)
		{
			remove_from_arrays();
		}
	}
}

//Function Number: 20
remove_from_tactics_array_on_delete()
{
	level.player endon("death");
	level.player endon("end_tactics_mode");
	while(isdefined(self))
	{
		wait(0.05);
	}

	remove_from_arrays();
}

//Function Number: 21
monitor_player_rpg_drop()
{
	level.player endon("death");
	level.player endon("end_tactics_mode");
	for(;;)
	{
		level.player waittill("pickup",var_00,var_01);
		if(isdefined(var_01) && issubstr(var_01.classname,"smaw_nolock_fusion"))
		{
			var_01 add_rpg_to_tactics_system();
		}
	}
}

//Function Number: 22
remove_vehicle_from_tactics_array_on_death()
{
	level.player endon("death");
	level.player endon("end_tactics_mode");
	self waittill("death");
	level.tactics_objects = common_scripts\utility::array_remove(level.tactics_objects,self);
	level.tactics_tools = common_scripts\utility::array_remove(level.tactics_tools,self);
	level.tactics_objectives = common_scripts\utility::array_remove(level.tactics_objectives,self);
	if(isdefined(self) && isdefined(self.mgturret) && isdefined(self.mgturret[0]))
	{
		level.tactics_objects = common_scripts\utility::array_remove(level.tactics_objects,self.mgturret[0]);
		level.tactics_tools = common_scripts\utility::array_remove(level.tactics_tools,self.mgturret[0]);
		level.tactics_objectives = common_scripts\utility::array_remove(level.tactics_objectives,self.mgturret[0]);
	}
}

//Function Number: 23
remove_turret_on_mount()
{
	level.player endon("death");
	self endon("death");
	level.player endon("end_tactics_mode");
	self waittill("vehicle_mount");
	thread add_turret_on_dismount();
	remove_from_arrays();
}

//Function Number: 24
add_turret_on_dismount()
{
	level.player endon("death");
	self endon("death");
	level.player endon("end_tactics_mode");
	self waittill("vehicle_dismount");
	add_object_to_tactics_system(self);
}

//Function Number: 25
remove_from_arrays()
{
	if(!isdefined(level.tactics_objects))
	{
		return;
	}

	if(maps\_utility::is_in_array(level.tactics_objects,self))
	{
		level.tactics_objects = common_scripts\utility::array_remove(level.tactics_objects,self);
	}

	if(maps\_utility::is_in_array(level.tactics_tools,self))
	{
		level.tactics_tools = common_scripts\utility::array_remove(level.tactics_tools,self);
		return;
	}

	if(maps\_utility::is_in_array(level.tactics_objectives,self))
	{
		level.tactics_objectives = common_scripts\utility::array_remove(level.tactics_objectives,self);
	}
}