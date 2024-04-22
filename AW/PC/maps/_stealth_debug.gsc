/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_debug.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 307 ms
 * Timestamp: 4/22/2024 2:23:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread main_thread();
}

//Function Number: 2
main_thread()
{
}

//Function Number: 3
render_detect_ranges()
{
	var_00 = getaiarray("allies");
	foreach(var_02 in var_00)
	{
		var_02 render_detect_ranges_for_entity();
	}

	level.player render_detect_ranges_for_entity();
	var_04 = getaiarray("bad_guys");
	foreach(var_02 in var_04)
	{
		var_02 render_vision_cone_for_entity();
	}
}

//Function Number: 4
render_vision_cone_for_entity()
{
	if(!isdefined(self._stealth))
	{
		return;
	}

	var_00 = self.angles;
	var_01 = self geteye() + (0,0,-70);
	var_02 = acos(self.fovcosine);
	render_vision_cone(var_01,var_00,var_02,(0,1,0));
}

//Function Number: 5
render_vision_cone(param_00,param_01,param_02,param_03)
{
	var_04 = anglestoforward(param_01 + (0,param_02,0));
	var_05 = anglestoforward(param_01 + (0,param_02 * -1,0));
}

//Function Number: 6
render_detect_ranges_for_entity()
{
	if(!isdefined(self._stealth))
	{
		return;
	}

	var_00 = maps\_stealth_visibility_friendly::friendly_get_stance();
	var_01 = level._stealth.logic.detection_level;
	foreach(var_05, var_03 in level._stealth.logic.detect_range[var_01])
	{
		if(self [[ self._stealth.logic.getinshadow_func ]]())
		{
			var_03 = var_03 * 0.5;
		}

		var_04 = get_debug_element_color(var_05);
		maps\_utility::draw_circle_for_time(self.origin,var_03,var_04[0],var_04[1],var_04[2],0.05);
		if(var_05 == var_00)
		{
			maps\_utility::draw_circle_for_time(self.origin,var_03 - 2,0.6,0.6,0,0.05);
			maps\_utility::draw_circle_for_time(self.origin,var_03 + 2,0.6,0.6,0,0.05);
		}

		update_debug_element_data(var_05,var_03);
	}
}

//Function Number: 7
render_ranges_for_the_corpses()
{
	var_00 = getcorpsearray();
	foreach(var_02 in var_00)
	{
		var_02 render_ranges_for_a_corpse();
	}
}

//Function Number: 8
render_ranges_for_a_corpse()
{
	if(!isdefined(level._stealth))
	{
		return;
	}

	var_00 = sqrt(level._stealth.logic.corpse.found_distsqrd);
	var_01 = get_debug_element_color("corpse_found");
	update_debug_element_data("corpse_found",var_00);
	maps\_utility::draw_circle_for_time(self.origin,var_00,var_01[0],var_01[1],var_01[2],0.05);
	var_00 = sqrt(level._stealth.logic.corpse.found_dog_distsqrd);
	var_01 = get_debug_element_color("corpse_dog_found");
	update_debug_element_data("corpse_dog_found",var_00);
	maps\_utility::draw_circle_for_time(self.origin,var_00,var_01[0],var_01[1],var_01[2],0.05);
	var_00 = sqrt(level._stealth.logic.corpse.sight_distsqrd);
	var_01 = get_debug_element_color("corpse_sight");
	update_debug_element_data("corpse_sight",var_00);
	maps\_utility::draw_circle_for_time(self.origin,var_00,var_01[0],var_01[1],var_01[2],0.05);
	var_00 = sqrt(level._stealth.logic.corpse.detect_distsqrd);
	var_01 = get_debug_element_color("corpse_detect");
	update_debug_element_data("corpse_detect",var_00);
	maps\_utility::draw_circle_for_time(self.origin,var_00,var_01[0],var_01[1],var_01[2],0.05);
}

//Function Number: 9
record_enemy_notification(param_00,param_01)
{
	if(!isdefined(level._stealth.debug.last_enemy_notification))
	{
		level._stealth.debug.last_enemy_notification = spawnstruct();
	}

	level._stealth.debug.last_enemy_notification.spotter = param_00;
	level._stealth.debug.last_enemy_notification.spotterviewpoint = param_00 geteye() + (0,0,-70);
	level._stealth.debug.last_enemy_notification.spotterangles = param_00.angles;
	level._stealth.debug.last_enemy_notification.spotterfov = acos(param_00.fovcosine);
	level._stealth.debug.last_enemy_notification.spottedstance = param_01 maps\_stealth_visibility_friendly::friendly_get_stance();
	level._stealth.debug.last_enemy_notification.spottedorigin = param_01.origin;
	level._stealth.debug.last_enemy_notification.spottedvisibledistance = param_01.maxvisibledist;
}

//Function Number: 10
clear_alerted_info()
{
	level._stealth.debug.last_enemy_notification = undefined;
	level._stealth.debug.alertedinfo = undefined;
}

//Function Number: 11
render_alerted_info()
{
	if(!isdefined(level._stealth.debug.last_enemy_notification))
	{
		return;
	}

	var_00 = level._stealth.debug.last_enemy_notification;
	var_01 = (0.9,0,0.2);
	var_02 = "Spotter";
	if(isdefined(level._stealth.debug.alertedinfo))
	{
		var_02 = var_02 + " ai_event: " + level._stealth.debug.alertedinfo.eventtype;
	}

	if(isdefined(var_00.spottedstance))
	{
	}

	render_vision_cone(var_00.spotterviewpoint,var_00.spotterangles,var_00.spotterfov,(0,1,0));
	if(isdefined(var_00.spotter))
	{
	}

	if(isdefined(level._stealth.debug.alertedinfo) && isdefined(level._stealth.logic.ai_event[level._stealth.debug.alertedinfo.eventtype]))
	{
		maps\_utility::draw_circle_for_time(var_00.spottedorigin,level._stealth.logic.ai_event[level._stealth.debug.alertedinfo.eventtype]["hidden"],var_01[0],var_01[1],var_01[2],0.05);
		return;
	}

	maps\_utility::draw_circle_for_time(var_00.spottedorigin,var_00.spottedvisibledistance,var_01[0],var_01[1],var_01[2],0.05);
}

//Function Number: 12
record_stealth_event(param_00,param_01)
{
	if(!isdefined(level._stealth.debug.alertedinfo))
	{
		level._stealth.debug.alertedinfo = spawnstruct();
	}

	level._stealth.debug.alertedinfo.alertedentity = param_00;
	level._stealth.debug.alertedinfo.eventtype = param_01;
}

//Function Number: 13
add_debug_element(param_00,param_01,param_02)
{
	if(!isdefined(level._stealth.debug))
	{
		level._stealth.debug = spawnstruct();
		level._stealth.debug.debug_elements = [];
	}

	var_03 = spawnstruct();
	var_03.text = param_01;
	var_03.color = param_02;
	var_03.data = -1;
	level._stealth.debug.debug_elements[param_00] = var_03;
}

//Function Number: 14
update_debug_element_data(param_00,param_01)
{
	if(!isdefined(level._stealth.debug))
	{
		return;
	}

	level._stealth.debug.debug_elements[param_00].data = param_01;
}

//Function Number: 15
get_debug_element_color(param_00)
{
	if(!isdefined(level._stealth.debug))
	{
		return (0,0,0);
	}

	return level._stealth.debug.debug_elements[param_00].color;
}

//Function Number: 16
disable_stealth_debug_hud()
{
	if(!isdefined(level._stealth.debug.hud))
	{
		return;
	}

	foreach(var_01 in level._stealth.debug.hud)
	{
		var_01 destroy();
	}

	level._stealth.debug.hud = undefined;
}

//Function Number: 17
initialize_stealth_debug_hud()
{
	if(isdefined(level._stealth.debug.hud))
	{
		return;
	}

	level._stealth.debug.hud = [];
	for(var_00 = 0;var_00 < level._stealth.debug.debug_elements.size;var_00++)
	{
		level._stealth.debug.hud[var_00] = newhudelem();
		level._stealth.debug.hud[var_00].x = 0;
		level._stealth.debug.hud[var_00].y = 20 + var_00 * 12;
		level._stealth.debug.hud[var_00].alignx = "left";
		level._stealth.debug.hud[var_00].aligny = "top";
	}
}

//Function Number: 18
update_stealth_debug_hud()
{
	initialize_stealth_debug_hud();
	if(!isdefined(level._stealth.debug.debug_elements))
	{
		return;
	}

	var_00 = 0;
	foreach(var_02 in level._stealth.debug.debug_elements)
	{
		level._stealth.debug.hud[var_00] settext(var_02.text + var_02.data);
		level._stealth.debug.hud[var_00].color = var_02.color;
		var_00++;
	}
}

//Function Number: 19
last_known_position_monitor()
{
	self notify("last_known_position_monitor");
	self endon("last_known_position_monitor");
	self endon("death");
	var_00 = 0.1;
	var_01 = (0.9,0,0.2);
	var_02 = 24;
	for(;;)
	{
		if(isdefined(self._stealth) && isdefined(self.enemy))
		{
			self._stealth.logic.last_known_enemy_pos = self lastknownpos(self.enemy);
			self._stealth.logic.last_known_enemy_reason = self lastknownreason(self.enemy);
		}

		if(isdefined(self._stealth) && isdefined(self._stealth.logic.last_known_enemy_pos))
		{
			maps\_utility::draw_circle_for_time(self._stealth.logic.last_known_enemy_pos,var_02,var_01[0],var_01[1],var_01[2],var_00);
			if(isdefined(self._stealth.logic.last_known_enemy_reason))
			{
			}
		}

		wait(var_00);
	}
}

//Function Number: 20
stealth_enemy_debug_monitor()
{
	self notify("stealth_enemy_debug_monitor");
	self endon("stealth_enemy_debug_monitor");
	self endon("death");
	for(;;)
	{
		if(isdefined(self.alertlevel))
		{
			var_00 = "Alert level: " + self.alertlevel;
		}

		if(isdefined(self._stealth.logic.threat_level))
		{
			var_00 = "Threat level: " + self._stealth.logic.threat_level;
		}

		wait(0.05);
	}
}

//Function Number: 21
stealth_enemy_minimal_debug_monitor()
{
	self notify("stealth_enemy_minimal_debug_monitor");
	self endon("stealth_enemy_minimal_debug_monitor");
	self endon("death");
	for(;;)
	{
		var_00 = ".";
		if(isdefined(self.alertlevel))
		{
			if(self.alertlevel == "noncombat")
			{
			}
			else if(self.alertlevel == "alert")
			{
			}
			else if(self.alertlevel == "combat")
			{
			}
		}

		wait(0.05);
	}
}