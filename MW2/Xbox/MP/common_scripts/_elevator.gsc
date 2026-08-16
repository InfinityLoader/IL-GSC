/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_elevator.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	if(getdvar("scr_elevator_disabled") == "1")
	{
		return;
	}

	elevator_groups = getentarray("elevator_group", "targetname");
	if(!isdefined(elevator_groups))
	{
		return;
	}

	if(!elevator_groups.size)
	{
		return;
	}

	precachestring(&"ELEVATOR_CALL_HINT");
	precachestring(&"ELEVATOR_USE_HINT");
	precachestring(&"ELEVATOR_FLOOR_SELECT_HINT");
	precachemenu("elevator_floor_selector");
	thread elevator_update_global_dvars();
	level.elevators = [];
	level.elevator_callbutton_link_v = elevator_get_dvar_int("scr_elevator_callbutton_link_v", "96");
	level.elevator_callbutton_link_h = elevator_get_dvar_int("scr_elevator_callbutton_link_h", "256");
	build_elevators();
	position_elevators();
	elevator_call();
	if(!level.elevators.size)
	{
		return;
	}

	foreach(elevator in level.elevators)
	{
		elevator thread elevator_think();
		elevator thread elevator_sound_think();
	}

	thread elevator_debug();
}

elevator_update_global_dvars()
{
	for(;;)
	{
		level.elevator_accel = elevator_get_dvar("scr_elevator_accel", "0.2");
		level.elevator_decel = elevator_get_dvar("scr_elevator_decel", "0.2");
		level.elevator_music = elevator_get_dvar_int("scr_elevator_music", "1");
		level.elevator_speed = elevator_get_dvar_int("scr_elevator_speed", "96");
		level.elevator_innerdoorspeed = elevator_get_dvar_int("scr_elevator_innerdoorspeed", "14");
		level.elevator_outterdoorspeed = elevator_get_dvar_int("scr_elevator_outterdoorspeed", "16");
		level.elevator_return = elevator_get_dvar_int("scr_elevator_return", "0");
		level.elevator_waittime = elevator_get_dvar_int("scr_elevator_waittime", "6");
		level.elevator_aggressive_call = elevator_get_dvar_int("scr_elevator_aggressive_call", "0");
		level.elevator_debug = elevator_get_dvar_int("debug_elevator", "0");
		if(common_scripts\utility::issp())
		{
			level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "0");
		}
		else
		{
			level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "1");
		}

		wait 1;
	}
}

elevator_think()
{
	elevator_fsm("[A]");
}

elevator_call()
{
	foreach(callbutton in level.elevator_callbuttons)
	{
		callbutton thread monitor_callbutton();
	}
}

floor_override(inside_trig)
{
	self endon("elevator_moving");
	self.floor_override = 0;
	self.overrider = undefined;
	for(;;)
	{
		inside_trig waittill("trigger", player);
		self.floor_override = 1;
		self.overrider = player;
		break;
	}

	self notify("floor_override");
}

elevator_fsm(param_821)
{
	self.estate = param_821;
	door_trig = get_housing_door_trigger();
	inside_trig = get_housing_inside_trigger();
	for(;;)
	{
		if(self.estate == "[A]")
		{
			if(level.elevator_return && get_curfloor() != get_initfloor())
			{
				self.moveto_floor = get_initfloor();
				thread floor_override(inside_trig);
				waittill_or_timeout("floor_override", level.elevator_waittime);
				if(self.floor_override && isdefined(self.overrider) && isplayer(self.overrider))
				{
					get_floor(self.overrider);
				}

				self.estate = "[B]";
				continue;
			}

			for(;;)
			{
				if(self.moveto_floor == get_curfloor())
				{
					param = inside_trig discrete_waittill("trigger");
				}
				else
				{
					param = "elevator_called";
				}

				if(isstring(param) && param == "elevator_called" && self.moveto_floor != get_curfloor())
				{
					self.estate = "[B]";
					break;
				}

				if(isdefined(param) && isplayer(param) && isalive(param))
				{
					istouching_trigger = param istouching(inside_trig);
					istouching_motion_trigger = isdefined(inside_trig.motion_trigger) && param istouching(inside_trig.motion_trigger);
					player_istouching_trigger = istouching_trigger || istouching_motion_trigger;
					if(player_istouching_trigger)
					{
						player = param;
						get_floor(player);
						if(self.moveto_floor == get_curfloor())
						{
							continue;
						}

						self.estate = "[B]";
						break;
					}
				}
			}
		}

		if(self.estate == "[B]")
		{
			thread elevator_interrupt(door_trig);
			floor_num = get_curfloor();
			thread close_inner_doors();
			thread close_outer_doors(floor_num);
			common_scripts\utility::waittill_any("closed_inner_doors", "interrupted");
			if(self.elevator_interrupted)
			{
				self.estate = "[C]";
				continue;
			}

			self.estate = "[D]";
			continue;
		}

		if(self.estate == "[C]")
		{
			floor_num = get_curfloor();
			thread open_inner_doors();
			thread open_outer_doors(floor_num);
			self waittill("opened_floor_" + floor_num + "_outer_doors");
			if(self.elevator_interrupted)
			{
				self.estate = "[B]";
				continue;
			}

			self.estate = "[A]";
			continue;
		}

		if(self.estate == "[D]")
		{
			if(self.moveto_floor != get_curfloor())
			{
				thread elevator_move(self.moveto_floor);
				self waittill("elevator_moved");
			}

			self.estate = "[C]";
			continue;
		}
	}
}

monitor_callbutton()
{
	for(;;)
	{
		player = discrete_waittill("trigger");
		call_floor = undefined;
		call_elevators = [];
		foreach(idx, linked_elevators in self.e)
		{
			call_floor = idx;
			call_elevators = linked_elevators;
		}

		elevator_called = 0;
		foreach(elevator in call_elevators)
		{
			moving = elevator elevator_floor_update();
			if(!level.elevator_aggressive_call && !moving)
			{
				if(elevator get_curfloor() == call_floor)
				{
					elevator_called = 1;
					call_elevators = [];
					break;
				}
			}
		}

		foreach(elevator in call_elevators)
		{
			if(elevator.estate == "[A]")
			{
				elevator call_elevator(call_floor);
				elevator_called = 1;
				if(!level.elevator_aggressive_call)
				{
					break;
				}
			}
		}

		if(elevator_called)
		{
			self playsound("elev_bell_ding");
		}
	}
}

call_elevator(call_floor)
{
	self.moveto_floor = call_floor;
	inside_trigger = get_housing_inside_trigger();
	inside_trigger notify("trigger", "elevator_called");
	if(level.elevator_motion_detection)
	{
		inside_trigger.motion_trigger notify("trigger", "elevator_called");
		return;
	}
}

get_floor(player)
{
	bifloor = get_outer_doorsets();
	if(bifloor.size == 2)
	{
		curfloor = get_curfloor();
		self.moveto_floor = !curfloor;
		return;
	}

	player openpopupmenu("elevator_floor_selector");
	player setclientdvar("player_current_floor", get_curfloor());
	for(;;)
	{
		player waittill("menuresponse", menu, response);
		if(menu == "elevator_floor_selector")
		{
			if(response != "none")
			{
				self.moveto_floor = int(response);
			}

			break;
		}
	}
}

elevator_interrupt(door_trig)
{
	self notify("interrupt_watch");
	level notify("elevator_interior_button_pressed");
	self endon("interrupt_watch");
	self endon("elevator_moving");
	self.elevator_interrupted = 0;
	wait 0.5;
	door_trig waittill("trigger", player);
	self notify("interrupted");
	self.elevator_interrupted = 1;
}

elevator_floor_update()
{
	mainframe = get_housing_mainframe();
	cur_pos = mainframe.origin;
	moving = 1;
	foreach(idx, efloor in get_outer_doorsets())
	{
		floor_pos = self.e["floor" + idx + "_pos"];
		if(cur_pos == floor_pos)
		{
			self.e["current_floor"] = idx;
			moving = 0;
		}
	}

	return moving;
}

elevator_sound_think()
{
	musak_model = get_housing_musak_model();
	if(level.elevator_music && isdefined(musak_model))
	{
		musak_model playloopsound("elev_musak_loop");
	}

	thread listen_for ("closing_inner_doors");
	thread listen_for ("opening_inner_doors");
	thread listen_for ("closed_inner_doors");
	thread listen_for ("opened_inner_doors");
	foreach(idx, efloor in get_outer_doorsets())
	{
		thread listen_for ("closing_floor_" + idx + "_outer_doors");
		thread listen_for ("opening_floor_" + idx + "_outer_doors");
		thread listen_for ("closed_floor_" + idx + "_outer_doors");
		thread listen_for ("opened_floor_" + idx + "_outer_doors");
	}

	thread listen_for ("interrupted");
	thread listen_for ("elevator_moving");
	thread listen_for ("elevator_moved");
}

listen_for (msg)
{
	for(;;)
	{
		self waittill(msg);
		mainframe = get_housing_mainframe();
		if(issubstr(msg, "closing_"))
		{
			mainframe playsound("elev_door_close");
		}

		if(issubstr(msg, "opening_"))
		{
			mainframe playsound("elev_door_open");
		}

		if(msg == "elevator_moving")
		{
			mainframe playsound("elev_run_start");
			mainframe playloopsound("elev_run_loop");
		}

		if(msg == "interrupted")
		{
			mainframe playsound("elev_door_interupt");
		}

		if(msg == "elevator_moved")
		{
			mainframe stoploopsound("elev_run_loop");
			mainframe playsound("elev_run_end");
			mainframe playsound("elev_bell_ding");
		}
	}
}

position_elevators()
{
	foreach(e, elevator in level.elevators)
	{
		elevator.moveto_floor = elevator get_curfloor();
		foreach(floor_num, outer_doorset in elevator get_outer_doorsets())
		{
			if(elevator get_curfloor() != floor_num)
			{
				elevator thread close_outer_doors(floor_num);
			}
		}
	}
}

elevator_move(floor_num)
{
	self notify("elevator_moving");
	self endon("elevator_moving");
	mainframe = get_housing_mainframe();
	delta_vec = self.e["floor" + floor_num + "_pos"] - mainframe.origin;
	speed = level.elevator_speed;
	dist = abs(distance(self.e["floor" + floor_num + "_pos"], mainframe.origin));
	movetime = dist / speed;
	mainframe moveto(mainframe.origin + delta_vec, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel);
	foreach(part in get_housing_children())
	{
		moveto_pos = part.origin + delta_vec;
		if(!issubstr(part.classname, "trigger_"))
		{
			part moveto(moveto_pos, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel);
			continue;
		}

		part.origin = moveto_pos;
	}

	waittill_finish_moving(mainframe, self.e["floor" + floor_num + "_pos"]);
	self notify("elevator_moved");
}

close_inner_doors()
{
	self notify("closing_inner_doors");
	self endon("closing_inner_doors");
	self endon("opening_inner_doors");
	left_door = get_housing_leftdoor();
	right_door = get_housing_rightdoor();
	mainframe = get_housing_mainframe();
	old_closed_pos = get_housing_closedpos();
	closed_pos = (old_closed_pos[0],old_closed_pos[1],mainframe.origin[2]);
	speed = level.elevator_innerdoorspeed;
	dist = abs(distance(left_door.origin, closed_pos));
	movetime = dist / speed;
	left_door moveto(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
	right_door moveto(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
	waittill_finish_moving(left_door, closed_pos, right_door, closed_pos);
	self notify("closed_inner_doors");
}

open_inner_doors()
{
	self notify("opening_inner_doors");
	self endon("opening_inner_doors");
	left_door = get_housing_leftdoor();
	right_door = get_housing_rightdoor();
	mainframe = get_housing_mainframe();
	old_left_opened_pos = get_housing_leftdoor_opened_pos();
	old_right_opened_pos = get_housing_rightdoor_opened_pos();
	left_opened_pos = (old_left_opened_pos[0],old_left_opened_pos[1],mainframe.origin[2]);
	right_opened_pos = (old_right_opened_pos[0],old_right_opened_pos[1],mainframe.origin[2]);
	speed = level.elevator_innerdoorspeed;
	dist = abs(distance(left_opened_pos, right_opened_pos) * 0.5);
	movetime = dist / speed * 0.5;
	left_door moveto(left_opened_pos, movetime, movetime * 0.1, movetime * 0.25);
	right_door moveto(right_opened_pos, movetime, movetime * 0.1, movetime * 0.25);
	waittill_finish_moving(left_door, left_opened_pos, right_door, right_opened_pos);
	self notify("opened_inner_doors");
}

close_outer_doors(floor_num)
{
	self notify("closing_floor_" + floor_num + "_outer_doors");
	self endon("closing_floor_" + floor_num + "_outer_doors");
	self endon("opening_floor_" + floor_num + "_outer_doors");
	left_door = get_outer_leftdoor(floor_num);
	right_door = get_outer_rightdoor(floor_num);
	left_opened_pos = get_outer_leftdoor_openedpos(floor_num);
	closed_pos = get_outer_closedpos(floor_num);
	speed = level.elevator_outterdoorspeed;
	dist = abs(distance(left_opened_pos, closed_pos));
	movetime = dist / speed;
	left_door moveto(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
	right_door moveto(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
	waittill_finish_moving(left_door, closed_pos, right_door, closed_pos);
	self notify("closed_floor_" + floor_num + "_outer_doors");
}

open_outer_doors(floor_num)
{
	level notify("elevator_doors_opening");
	self notify("opening_floor_" + floor_num + "_outer_doors");
	self endon("opening_floor_" + floor_num + "_outer_doors");
	left_door = get_outer_leftdoor(floor_num);
	right_door = get_outer_rightdoor(floor_num);
	left_opened_pos = get_outer_leftdoor_openedpos(floor_num);
	right_opened_pos = get_outer_rightdoor_openedpos(floor_num);
	closed_pos = get_outer_closedpos(floor_num);
	speed = level.elevator_outterdoorspeed;
	dist = abs(distance(left_opened_pos, closed_pos));
	movetime = dist / speed * 0.5;
	left_door moveto(left_opened_pos, movetime, movetime * 0.1, movetime * 0.25);
	right_door moveto(right_opened_pos, movetime, movetime * 0.1, movetime * 0.25);
	waittill_finish_moving(left_door, left_opened_pos, right_door, right_opened_pos);
	self notify("opened_floor_" + floor_num + "_outer_doors");
}

build_elevators()
{
	elevator_groups = getentarray("elevator_group", "targetname");
	elevator_housings = getentarray("elevator_housing", "targetname");
	elevator_doorsets = getentarray("elevator_doorset", "targetname");
	foreach(elevator_bound in elevator_groups)
	{
		elevator_bound_end = getent(elevator_bound.target, "targetname");
		min_max_xy = [];
		min_max_xy[0] = min(elevator_bound.origin[0], elevator_bound_end.origin[0]);
		min_max_xy[1] = max(elevator_bound.origin[0], elevator_bound_end.origin[0]);
		min_max_xy[2] = min(elevator_bound.origin[1], elevator_bound_end.origin[1]);
		min_max_xy[3] = max(elevator_bound.origin[1], elevator_bound_end.origin[1]);
		parts = spawnstruct();
		parts.e["id"] = level.elevators.size;
		parts.e["housing"] = [];
		parts.e["housing"]["mainframe"] = [];
		foreach(elevator_housing in elevator_housings)
		{
			if(elevator_housing isinbound(min_max_xy))
			{
				parts.e["housing"]["mainframe"][parts.e["housing"]["mainframe"].size] = elevator_housing;
				if(elevator_housing.classname == "script_model")
				{
					continue;
				}

				if(elevator_housing.code_classname == "light")
				{
					continue;
				}

				inner_leftdoor = getent(elevator_housing.target, "targetname");
				parts.e["housing"]["left_door"] = inner_leftdoor;
				parts.e["housing"]["left_door_opened_pos"] = inner_leftdoor.origin;
				inner_rightdoor = getent(inner_leftdoor.target, "targetname");
				parts.e["housing"]["right_door"] = inner_rightdoor;
				parts.e["housing"]["right_door_opened_pos"] = inner_rightdoor.origin;
				inner_door_closed_pos = inner_leftdoor.origin - inner_rightdoor.origin * (0.5,0.5,0.5) + inner_rightdoor.origin;
				parts.e["housing"]["door_closed_pos"] = inner_door_closed_pos;
				door_trigger = getent(inner_rightdoor.target, "targetname");
				parts.e["housing"]["door_trigger"] = door_trigger;
				inside_trigger = getent(door_trigger.target, "targetname");
				parts.e["housing"]["inside_trigger"] = inside_trigger;
				inside_trigger make_discrete_trigger();
				inside_trigger.motion_trigger = spawn("trigger_radius", elevator_housing.origin, 0, 64, 128);
			}
		}

		parts.e["outer_doorset"] = [];
		foreach(elevator_doorset in elevator_doorsets)
		{
			if(elevator_doorset isinbound(min_max_xy))
			{
				door_starts_closed = isdefined(elevator_doorset.script_noteworthy) && elevator_doorset.script_noteworthy == "closed_for_lighting";
				door_set_id = parts.e["outer_doorset"].size;
				parts.e["outer_doorset"][door_set_id] = [];
				parts.e["outer_doorset"][door_set_id]["door_closed_pos"] = elevator_doorset.origin;
				leftdoor = getent(elevator_doorset.target, "targetname");
				parts.e["outer_doorset"][door_set_id]["left_door"] = leftdoor;
				parts.e["outer_doorset"][door_set_id]["left_door_opened_pos"] = leftdoor.origin;
				rightdoor = getent(leftdoor.target, "targetname");
				parts.e["outer_doorset"][door_set_id]["right_door"] = rightdoor;
				parts.e["outer_doorset"][door_set_id]["right_door_opened_pos"] = rightdoor.origin;
				if(door_starts_closed)
				{
					left_door_vec = elevator_doorset.origin - leftdoor.origin;
					elevator_doorset.origin = leftdoor.origin;
					leftdoor.origin = leftdoor.origin + left_door_vec;
					rightdoor.origin = rightdoor.origin - left_door_vec;
					parts.e["outer_doorset"][door_set_id]["door_closed_pos"] = elevator_doorset.origin;
					parts.e["outer_doorset"][door_set_id]["left_door_opened_pos"] = leftdoor.origin;
					parts.e["outer_doorset"][door_set_id]["right_door_opened_pos"] = rightdoor.origin;
				}
			}
		}

		for(i = 0;i < parts.e["outer_doorset"].size - 1;i++)
		{
			for(j = 0;j < parts.e["outer_doorset"].size - 1 - i;j++)
			{
				if(parts.e["outer_doorset"][j + 1]["door_closed_pos"][2] < parts.e["outer_doorset"][j]["door_closed_pos"][2])
				{
					temp_left_door = parts.e["outer_doorset"][j]["left_door"];
					temp_left_door_opened_pos = parts.e["outer_doorset"][j]["left_door_opened_pos"];
					temp_right_door = parts.e["outer_doorset"][j]["right_door"];
					temp_right_door_opened_pos = parts.e["outer_doorset"][j]["right_door_opened_pos"];
					temp_closed_pos = parts.e["outer_doorset"][j]["door_closed_pos"];
					parts.e["outer_doorset"][j]["left_door"] = parts.e["outer_doorset"][j + 1]["left_door"];
					parts.e["outer_doorset"][j]["left_door_opened_pos"] = parts.e["outer_doorset"][j + 1]["left_door_opened_pos"];
					parts.e["outer_doorset"][j]["right_door"] = parts.e["outer_doorset"][j + 1]["right_door"];
					parts.e["outer_doorset"][j]["right_door_opened_pos"] = parts.e["outer_doorset"][j + 1]["right_door_opened_pos"];
					parts.e["outer_doorset"][j]["door_closed_pos"] = parts.e["outer_doorset"][j + 1]["door_closed_pos"];
					parts.e["outer_doorset"][j + 1]["left_door"] = temp_left_door;
					parts.e["outer_doorset"][j + 1]["left_door_opened_pos"] = temp_left_door_opened_pos;
					parts.e["outer_doorset"][j + 1]["right_door"] = temp_right_door;
					parts.e["outer_doorset"][j + 1]["right_door_opened_pos"] = temp_right_door_opened_pos;
					parts.e["outer_doorset"][j + 1]["door_closed_pos"] = temp_closed_pos;
				}
			}
		}

		floor_pos = [];
		foreach(i, doorset in parts.e["outer_doorset"])
		{
			mainframe = parts get_housing_mainframe();
			floor_pos = (mainframe.origin[0],mainframe.origin[1],doorset["door_closed_pos"][2]);
			parts.e["floor" + i + "_pos"] = floor_pos;
			if(mainframe.origin == floor_pos)
			{
				parts.e["initial_floor"] = i;
				parts.e["current_floor"] = i;
			}
		}

		level.elevators[level.elevators.size] = parts;
		elevator_bound delete();
		elevator_bound_end delete();
	}

	foreach(elevator_doorset in elevator_doorsets)
	{
		elevator_doorset delete();
	}

	build_call_buttons();
	if(!level.elevator_motion_detection)
	{
		setup_hints();
	}

	foreach(elevator in level.elevators)
	{
		plights = elevator get_housing_primarylight();
		if(isdefined(plights) && plights.size)
		{
			foreach(plight in plights)
			{
				plight setlightintensity(0.75);
			}
		}
	}
}

build_call_buttons()
{
	level.elevator_callbuttons = getentarray("elevator_call", "targetname");
	foreach(callbutton in level.elevator_callbuttons)
	{
		callbutton.e = [];
		callbutton_v_vec = (0,0,callbutton.origin[2]);
		callbutton_h_vec = (callbutton.origin[0],callbutton.origin[1],0);
		temp_elevator_list = [];
		foreach(elevator in level.elevators)
		{
			foreach(f_idx, efloor in elevator get_outer_doorsets())
			{
				v_vec = (0,0,elevator.e["floor" + f_idx + "_pos"][2]);
				h_vec = (elevator.e["floor" + f_idx + "_pos"][0],elevator.e["floor" + f_idx + "_pos"][1],0);
				if(abs(distance(callbutton_v_vec, v_vec)) <= level.elevator_callbutton_link_v)
				{
					if(abs(distance(callbutton_h_vec, h_vec)) <= level.elevator_callbutton_link_h)
					{
						temp_elevator_list[temp_elevator_list.size] = elevator;
						callbutton.e[f_idx] = temp_elevator_list;
					}
				}
			}
		}

		callbutton make_discrete_trigger();
		callbutton.motion_trigger = spawn("trigger_radius", callbutton.origin + (0,0,-32), 0, 32, 64);
	}
}

setup_hints()
{
	foreach(elevator in level.elevators)
	{
		use_trig = elevator get_housing_inside_trigger();
		floors = elevator get_outer_doorsets();
		num_of_floors = floors.size;
		use_trig setcursorhint("HINT_NOICON");
		if(num_of_floors > 2)
		{
			use_trig sethintstring(&"ELEVATOR_FLOOR_SELECT_HINT");
			continue;
		}

		use_trig sethintstring(&"ELEVATOR_USE_HINT");
	}

	foreach(callbutton in level.elevator_callbuttons)
	{
		callbutton setcursorhint("HINT_NOICON");
		callbutton sethintstring(&"ELEVATOR_CALL_HINT");
	}
}

make_discrete_trigger()
{
	self.enabled = 1;
	disable_trigger();
}

discrete_waittill(msg)
{
	enable_trigger();
	if(level.elevator_motion_detection)
	{
		self.motion_trigger waittill(msg, param);
	}
	else
	{
		self waittill(msg, param);
	}

	disable_trigger();
	return param;
}

enable_trigger()
{
	if(!self.enabled)
	{
		self.enabled = 1;
		self.origin = self.origin + (0,0,10000);
		if(isdefined(self.motion_trigger))
		{
			self.motion_trigger.origin = self.motion_trigger.origin + (0,0,10000);
			return;
		}

		return;
	}
}

disable_trigger()
{
	self notify("disable_trigger");
	if(self.enabled)
	{
		thread disable_trigger_helper();
		return;
	}
}

disable_trigger_helper()
{
	self endon("disable_trigger");
	self.enabled = 0;
	wait 1.5;
	self.origin = self.origin + (0,0,-10000);
	if(isdefined(self.motion_trigger))
	{
		self.motion_trigger.origin = self.motion_trigger.origin + (0,0,-10000);
		return;
	}
}

get_outer_doorset(floor_num)
{
	return self.e["outer_doorset"][floor_num];
}

get_outer_doorsets()
{
	return self.e["outer_doorset"];
}

get_outer_closedpos(floor_num)
{
	return self.e["outer_doorset"][floor_num]["door_closed_pos"];
}

get_outer_leftdoor(floor_num)
{
	return self.e["outer_doorset"][floor_num]["left_door"];
}

get_outer_rightdoor(floor_num)
{
	return self.e["outer_doorset"][floor_num]["right_door"];
}

get_outer_leftdoor_openedpos(floor_num)
{
	return self.e["outer_doorset"][floor_num]["left_door_opened_pos"];
}

get_outer_rightdoor_openedpos(floor_num)
{
	return self.e["outer_doorset"][floor_num]["right_door_opened_pos"];
}

get_housing_children()
{
	children = [];
	door_trig = get_housing_door_trigger();
	use_trig = get_housing_inside_trigger();
	motion_trig = use_trig.motion_trigger;
	left_door = get_housing_leftdoor();
	right_door = get_housing_rightdoor();
	children[children.size] = door_trig;
	children[children.size] = use_trig;
	children[children.size] = left_door;
	children[children.size] = right_door;
	if(isdefined(motion_trig))
	{
		children[children.size] = motion_trig;
	}

	script_models = get_housing_models();
	foreach(emodel in script_models)
	{
		children[children.size] = emodel;
	}

	primarylights = get_housing_primarylight();
	foreach(plight in primarylights)
	{
		children[children.size] = plight;
	}

	return children;
}

get_housing_mainframe()
{
	parts = self.e["housing"]["mainframe"];
	housing_model = undefined;
	foreach(part in parts)
	{
		if(part.classname != "script_model" && part.code_classname != "light")
		{
			housing_model = part;
		}
	}

	return housing_model;
}

get_housing_models()
{
	parts = self.e["housing"]["mainframe"];
	temp_model_array = [];
	foreach(part in parts)
	{
		if(part.classname == "script_model")
		{
			temp_model_array[temp_model_array.size] = part;
		}
	}

	return temp_model_array;
}

get_housing_primarylight()
{
	parts = self.e["housing"]["mainframe"];
	temp_primarylights = [];
	foreach(part in parts)
	{
		if(part.code_classname == "light")
		{
			temp_primarylights[temp_primarylights.size] = part;
		}
	}

	return temp_primarylights;
}

get_housing_musak_model()
{
	models = get_housing_models();
	musak_model = undefined;
	foreach(emodel in models)
	{
		if(isdefined(emodel.script_noteworthy) && emodel.script_noteworthy == "play_musak")
		{
			musak_model = emodel;
		}
	}

	return musak_model;
}

get_housing_door_trigger()
{
	return self.e["housing"]["door_trigger"];
}

get_housing_inside_trigger()
{
	return self.e["housing"]["inside_trigger"];
}

get_housing_closedpos()
{
	return self.e["housing"]["door_closed_pos"];
}

get_housing_leftdoor()
{
	return self.e["housing"]["left_door"];
}

get_housing_rightdoor()
{
	return self.e["housing"]["right_door"];
}

get_housing_leftdoor_opened_pos()
{
	return self.e["housing"]["left_door_opened_pos"];
}

get_housing_rightdoor_opened_pos()
{
	return self.e["housing"]["right_door_opened_pos"];
}

get_curfloor()
{
	moving = elevator_floor_update();
	return self.e["current_floor"];
}

get_initfloor()
{
	return self.e["initial_floor"];
}

waittill_finish_moving(ent1, ent1_moveto_pos, ent2, ent2_moveto_pos)
{
	if(!isdefined(ent2) && !isdefined(ent2_moveto_pos))
	{
		ent2 = ent1;
		ent2_moveto_pos = ent1_moveto_pos;
	}

	for(;;)
	{
		ent1_current_pos = ent1.origin;
		etn2_current_pos = ent2.origin;
		if(ent1_current_pos == ent1_moveto_pos && etn2_current_pos == ent2_moveto_pos)
		{
			break;
		}

		wait 0.05;
	}
}

isinbound(bounding_box)
{
	if(level.script == "plaza" || level.script == "highrise_test")
	{
		return isinboundingspere(bounding_box);
	}

	v_x = self.origin[0];
	v_y = self.origin[1];
	min_x = bounding_box[0];
	max_x = bounding_box[1];
	min_y = bounding_box[2];
	max_y = bounding_box[3];
	return v_x >= min_x && v_x <= max_x && v_y >= min_y && v_y <= max_y;
}

isinboundingspere(bounding_box)
{
	v_x = self.origin[0];
	v_y = self.origin[1];
	min_x = bounding_box[0];
	max_x = bounding_box[1];
	min_y = bounding_box[2];
	max_y = bounding_box[3];
	mid_x = min_x + max_x / 2;
	mid_y = min_y + max_y / 2;
	radius = abs(distance((min_x,min_y,0), (mid_x,mid_y,0)));
	return abs(distance((v_x,v_y,0), (mid_x,mid_y,0))) < radius;
}

waittill_or_timeout(msg, timer)
{
	self endon(msg);
	wait timer;
}

elevator_get_dvar_int(dvar, def)
{
	return int(elevator_get_dvar(dvar, def));
}

elevator_get_dvar(dvar, def)
{
	if(getdvar(dvar) != "")
	{
		return getdvarfloat(dvar);
	}

	setdvar(dvar, def);
	return def;
}

elevator_debug()
{
	if(!level.elevator_debug)
	{
		return;
	}

	for(;;)
	{
		if(level.elevator_debug != 2)
		{
			continue;
		}

		foreach(i, elevator in level.elevators)
		{
			mainframe = elevator get_housing_mainframe();
			musak_model = elevator get_housing_musak_model();
			foreach(efloor in elevator.e["outer_doorset"])
			{
			}
		}

		foreach(callbutton in level.elevator_callbuttons)
		{
			foreach(efloor in callbutton.e)
			{
				printoffset = 0;
				foreach(elinked in efloor)
				{
					printoffset++;
					print_pos = callbutton.origin + (0,0,printoffset * -4);
				}
			}
		}

		wait 0.05;
	}
}