/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_blockers.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 31 ms
 * Timestamp: 10/28/2023 12:11:43 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_demo;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_net;
#include maps/mp/zombies/_zm_pers_upgrades_functions;
#include maps/mp/zombies/_zm_score;
#include maps/mp/zombies/_zm_spawner;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_zonemgr;

//Function Number: 1
init()
{
	init_blockers();
	if(IsDefined(level.quantum_bomb_register_result_func))
	{
		[[ level.quantum_bomb_register_result_func ]]("open_nearest_door",::quantum_bomb_open_nearest_door_result,35,::quantum_bomb_open_nearest_door_validation);
	}
}

//Function Number: 2
init_blockers()
{
	level.exterior_goals = getstructarray("exterior_goal","targetname");
	array_thread(level.exterior_goals,::blocker_init);
	zombie_doors = getentarray("zombie_door","targetname");
	if(IsDefined(zombie_doors))
	{
		flag_init("door_can_close");
		array_thread(zombie_doors,::door_init);
	}

	zombie_debris = getentarray("zombie_debris","targetname");
	array_thread(zombie_debris,::debris_init);
	flag_blockers = getentarray("flag_blocker","targetname");
	array_thread(flag_blockers,::flag_blocker);
}

//Function Number: 3
door_init()
{
	self.type = undefined;
	self.purchaser = undefined;
	self._door_open = 0;
	targets = getentarray(self.target,"targetname");
	if(IsDefined(self.script_flag) && !IsDefined(level.flag[self.script_flag]))
	{
		if(IsDefined(self.script_flag))
		{
			tokens = strtok(self.script_flag,",");
			for(i = 0;i < tokens.size;i++)
			{
				flag_init(self.script_flag);
			}
		}
	}

	if(!(IsDefined(self.script_noteworthy)))
	{
		self.script_noteworthy = "default";
	}

	self.doors = [];
	for(i = 0;i < targets.size;i++)
	{
		targets[i] door_classify(self);
		if(!(IsDefined(targets[i].og_origin)))
		{
			targets[i].og_origin = targets[i].origin;
			targets[i].og_angles = targets[i].angles;
		}
	}

	cost = 1000;
	if(IsDefined(self.zombie_cost))
	{
		cost = self.zombie_cost;
	}

	self setcursorhint("HINT_NOICON");
	self thread door_think();
	if(IsDefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "electric_door" || self.script_noteworthy == "electric_buyable_door")
		{
			if(GetDvar(#"41651E") == "zgrief")
			{
				self setinvisibletoall();
				return;
			}

			self sethintstring(&"ZOMBIE_NEED_POWER");
			if(IsDefined(level.door_dialog_function))
			{
				self thread [[ level.door_dialog_function ]]();
			}

			return;
		}
		else if(self.script_noteworthy == "local_electric_door")
		{
			if(GetDvar(#"41651E") == "zgrief")
			{
				self setinvisibletoall();
				return;
			}

			self sethintstring(&"ZOMBIE_NEED_LOCAL_POWER");
			if(IsDefined(level.door_dialog_function))
			{
				self thread [[ level.door_dialog_function ]]();
			}

			return;
		}
		else if(self.script_noteworthy == "kill_counter_door")
		{
			self sethintstring(&"ZOMBIE_DOOR_ACTIVATE_COUNTER",cost);
			return;
		}
	}

	self set_hint_string(self,"default_buy_door",cost);
}

//Function Number: 4
door_classify(parent_trig)
{
	if(IsDefined(self.script_noteworthy) && self.script_noteworthy == "clip")
	{
		parent_trig.clip = self;
		parent_trig.script_string = "clip";
	}
	else if(!(IsDefined(self.script_string)))
	{
		if(IsDefined(self.script_angles))
		{
			self.script_string = "rotate";
		}
		else if(IsDefined(self.script_vector))
		{
			self.script_string = "move";
		}
	}
	else
	{
		if(!(IsDefined(self.script_string)))
		{
			self.script_string = "";
		}

		switch(self.script_string)
		{
			case "anim":
/#
				assert(IsDefined(self.script_animname),"Blocker_init: You must specify a script_animname for " + self.targetname);
#/
/#
				assert(IsDefined(level.scr_anim[self.script_animname]),"Blocker_init: You must define a level.scr_anim for script_anim -> " + self.script_animname);
#/
/#
				assert(IsDefined(level.blocker_anim_func),"Blocker_init: You must define a level.blocker_anim_func");
#/
				break;

			case "counter_1s":
				parent_trig.counter_1s = self;
				break;

			case "counter_10s":
				parent_trig.counter_10s = self;
				break;

			case "counter_100s":
				parent_trig.counter_100s = self;
				break;

			case "explosives":
				parent_trig.explosives = [];
				parent_trig.explosives[parent_trig.explosives.size] = self;
IsDefined(parent_trig.explosives)
				break;
		}
	}

	if(self.classname == "script_brushmodel")
	{
		self disconnectpaths();
	}

	parent_trig.doors[parent_trig.doors.size] = self;
}

//Function Number: 5
door_buy()
{
	self waittill("trigger",who,force);
	if(IsDefined(level.custom_door_buy_check))
	{
		if(!(who [[ level.custom_door_buy_check ]](self)))
		{
			return 0;
		}
	}

	if(GetDvarInt(#"2ECA0C0E") > 0 || IsDefined(force) && force)
	{
		return 1;
	}

	if(!(who usebuttonpressed()))
	{
		return 0;
	}

	if(who in_revive_trigger())
	{
		return 0;
	}

	if(is_player_valid(who))
	{
		players = get_players();
		cost = self.zombie_cost;
		if(who maps/mp/zombies/_zm_pers_upgrades_functions::is_pers_double_points_active())
		{
			cost = who maps/mp/zombies/_zm_pers_upgrades_functions::pers_upgrade_double_points_cost(cost);
		}

		if(self._door_open == 1)
		{
			self.purchaser = undefined;
		}
		else if(who.score >= cost)
		{
			who maps/mp/zombies/_zm_score::minus_to_player_score(cost,1);
			maps/mp/_demo::bookmark("zm_player_door",GetTime(),who);
			who maps/mp/zombies/_zm_stats::increment_client_stat("doors_purchased");
			who maps/mp/zombies/_zm_stats::increment_player_stat("doors_purchased");
			self.purchaser = who;
		}
		else
		{
			play_sound_at_pos("no_purchase",self.doors[0].origin);
			if(IsDefined(level.custom_generic_deny_vo_func))
			{
				who thread [[ level.custom_generic_deny_vo_func ]](1);
			}
			else
			{
				who maps/mp/zombies/_zm_audio::create_and_play_dialog("general","door_deny");
			}

			return 0;
		}
	}

	if(IsDefined(level._door_open_rumble_func))
	{
		who thread [[ level._door_open_rumble_func ]]();
	}

	return 1;
}

//Function Number: 6
door_delay()
{
	if(IsDefined(self.explosives))
	{
		for(i = 0;i < self.explosives.size;i++)
		{
			self.explosives[i] show();
		}
	}

	if(!(IsDefined(self.script_int)))
	{
		self.script_int = 5;
	}

	all_trigs = getentarray(self.target,"target");
	for(i = 0;i < all_trigs.size;i++)
	{
		all_trigs[i] trigger_off();
	}

	wait(self.script_int);
	for(i = 0;i < self.script_int;i++)
	{
/#
		iprintln(self.script_int - i);
#/
		wait(1);
	}

	if(IsDefined(self.explosives))
	{
		for(i = 0;i < self.explosives.size;i++)
		{
			playfx(level._effect["def_explosion"],self.explosives[i].origin,AnglesToForward(self.explosives[i].angles));
			self.explosives[i] hide();
		}
	}
}

//Function Number: 7
door_activate(time,open,quick,use_blocker_clip_for_pathing)
{
	if(!(IsDefined(open)))
	{
		open = 1;
	}

	if(!(IsDefined(time)))
	{
		time = 1;
		if(IsDefined(self.script_transition_time))
		{
			time = self.script_transition_time;
		}
	}

	if(IsDefined(self.door_moving))
	{
		if((IsDefined(self.script_noteworthy) && self.script_noteworthy == "clip") || IsDefined(self.script_string) && self.script_string == "clip")
		{
			if(!(is_true(use_blocker_clip_for_pathing)))
			{
				if(!(open))
				{
					return;
				}
			}
		}
		else
		{
			return;
		}
	}

	self.door_moving = 1;
	if(open || !IsDefined(quick) && quick)
	{
		self notsolid();
	}

	if(self.classname == "script_brushmodel")
	{
		if(open)
		{
			self connectpaths();
		}
	}

	if((IsDefined(self.script_noteworthy) && self.script_noteworthy == "clip") || IsDefined(self.script_string) && self.script_string == "clip")
	{
		if(!(open))
		{
			self delay_thread(time,::self_disconnectpaths);
			wait(0.1);
			self solid();
		}

		return;
	}

	if(IsDefined(self.script_sound))
	{
		if(open)
		{
			playsoundatposition(self.script_sound,self.origin);
		}
		else
		{
			playsoundatposition(self.script_sound + "_close",self.origin);
		}
	}
	else
	{
		play_sound_at_pos("door_slide_open",self.origin);
	}

	scale = 1;
	if(!(open))
	{
		scale = -1;
	}

	switch(self.script_string)
	{
		case "rotate":
			rot_angle = self.script_angles;
			rot_angle = self.og_angles;
			self rotateto(rot_angle,time,0,0);
			self thread door_solid_thread();
			self thread disconnect_paths_when_done();
			wait(randomfloat(0.15));
			break;
	open
	open
	IsDefined(self.script_angles)
			break;

		case "move":
		case "slide_apart":
			vector = VectorScale(self.script_vector);
			self moveto(self.origin + vector,time,time * 0.25,time * 0.25);
			self moveto(self.origin + vector,time);
			self thread door_solid_thread();
			self thread disconnect_paths_when_done();
			wait(randomfloat(0.15));
			break;
	open
	time >= 0.5
	scale
	IsDefined(self.script_vector)
			break;

		case "anim":
			self [[ level.blocker_anim_func ]](self.script_animname);
			self thread door_solid_thread_anim();
			wait(randomfloat(0.15));
			break;

		case "physics":
			self thread physics_launch_door(self);
			wait(0.1);
			break;
	}

	if(IsDefined(self.script_firefx))
	{
		playfx(level._effect[self.script_firefx],self.origin);
	}
}

//Function Number: 8
kill_trapped_zombies(trigger)
{
	zombies = getaiarray(level.zombie_team);
	if(!(IsDefined(zombies)))
	{
		return;
	}

	for(i = 0;i < zombies.size;i++)
	{
		if(!(IsDefined(zombies[i])))
		{
		}
		else if(zombies[i] istouching(trigger))
		{
			zombies[i].marked_for_recycle = 1;
			zombies[i] dodamage(zombies[i].health + 666,trigger.origin,self);
			wait(randomfloat(0.15));
		}
		else if(IsDefined(level.custom_trapped_zombies))
		{
			zombies[i] thread [[ level.custom_trapped_zombies ]]();
			wait(randomfloat(0.15));
		}
	}
}

//Function Number: 9
any_player_touching(trigger)
{
	foreach(player in get_players())
	{
		if(player istouching(trigger))
		{
			return 1;
		}

		wait(0.01);
	}

	return 0;
}

//Function Number: 10
any_player_touching_any(trigger,more_triggers)
{
	foreach(player in get_players())
	{
		if(is_player_valid(player,0,1))
		{
			if(IsDefined(trigger) && player istouching(trigger))
			{
				return 1;
			}

			if(IsDefined(more_triggers) && more_triggers.size > 0)
			{
				foreach(trig in more_triggers)
				{
					if(IsDefined(trig) && player istouching(trig))
					{
						return 1;
					}
				}
			}
		}
	}

	return 0;
}

//Function Number: 11
any_zombie_touching_any(trigger,more_triggers)
{
	zombies = getaiarray(level.zombie_team);
	foreach(zombie in zombies)
	{
		if(IsDefined(trigger) && zombie istouching(trigger))
		{
			return 1;
		}

		if(IsDefined(more_triggers) && more_triggers.size > 0)
		{
			foreach(trig in more_triggers)
			{
				if(IsDefined(trig) && zombie istouching(trig))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 12
wait_trigger_clear(trigger,more_triggers,end_on)
{
	self endon(end_on);
	while(any_player_touching_any(trigger,more_triggers) || any_zombie_touching_any(trigger,more_triggers))
	{
		wait(1);
	}

/#
	println("ZM BLOCKER local door trigger clear\n");
#/
	self notify("trigger_clear");
}

//Function Number: 13
waittill_door_trigger_clear_local_power_off(trigger,all_trigs)
{
	self endon("trigger_clear");
	while(1)
	{
		if(IsDefined(self.local_power_on) && self.local_power_on)
		{
			self waittill("local_power_off");
		}

/#
		println("ZM BLOCKER local door power off\n");
#/
		self wait_trigger_clear(trigger,all_trigs,"local_power_on");
	}
}

//Function Number: 14
waittill_door_trigger_clear_global_power_off(trigger,all_trigs)
{
	self endon("trigger_clear");
	while(1)
	{
		if(IsDefined(self.power_on) && self.power_on)
		{
			self waittill("power_off");
		}

/#
		println("ZM BLOCKER global door power off\n");
#/
		self wait_trigger_clear(trigger,all_trigs,"power_on");
	}
}

//Function Number: 15
waittill_door_can_close()
{
	trigger = undefined;
	if(IsDefined(self.door_hold_trigger))
	{
		trigger = getent(self.door_hold_trigger,"targetname");
	}

	all_trigs = getentarray(self.target,"target");
	switch(self.script_noteworthy)
	{
		case "local_electric_door":
			self waittill_door_trigger_clear_local_power_off(trigger,all_trigs);
			self thread kill_trapped_zombies(trigger);
			self waittill(IsDefined(trigger) || IsDefined(all_trigs),IsDefined(self.local_power_on) && self.local_power_on,"local_power_off");
			break;

		case "electric_door":
			self waittill_door_trigger_clear_global_power_off(trigger,all_trigs);
			self thread kill_trapped_zombies(trigger);
			self waittill(IsDefined(trigger) || IsDefined(all_trigs),IsDefined(trigger),IsDefined(self.power_on) && self.power_on,"power_off");
			break;
	}
}

//Function Number: 16
door_think()
{
	self endon("kill_door_think");
	cost = 1000;
	if(IsDefined(self.zombie_cost))
	{
		cost = self.zombie_cost;
	}

	self sethintlowpriority(1);
	while(1)
	{
		switch(self.script_noteworthy)
		{
			case "local_electric_door":
				self waittill(IsDefined(self.local_power_on) && self.local_power_on,"local_power_on");
	/#
				println("ZM BLOCKER local door opened\n");
	#/
				self door_opened(cost,1);
				self.power_cost = 0;
				self.power_cost = self.power_cost + 200;
				self sethintstring("");
				for(;;)
				{
					return;
					wait(3);
					self waittill_door_can_close();
					self door_block();
	/#
					println("ZM BLOCKER local door closed\n");
	#/
					self door_opened(cost,1);
					self sethintstring(&"ZOMBIE_NEED_LOCAL_POWER");
					wait(3);
				}
	
	IsDefined(self._door_open) && self._door_open
	IsDefined(level.local_doors_stay_open) && level.local_doors_stay_open
	IsDefined(self.power_cost)
	IsDefined(self._door_open) && self._door_open
				break;

			case "electric_door":
				self waittill(IsDefined(self.power_on) && self.power_on,"power_on");
	/#
				println("ZM BLOCKER global door opened\n");
	#/
				self door_opened(cost,1);
				self.power_cost = 0;
				self.power_cost = self.power_cost + 200;
				self sethintstring("");
				for(;;)
				{
					return;
					wait(3);
					self waittill_door_can_close();
					self door_block();
	/#
					println("ZM BLOCKER global door closed\n");
	#/
					self door_opened(cost,1);
					self sethintstring(&"ZOMBIE_NEED_POWER");
					wait(3);
				}
	
	IsDefined(self._door_open) && self._door_open
	IsDefined(level.local_doors_stay_open) && level.local_doors_stay_open
	IsDefined(self.power_cost)
	IsDefined(self._door_open) && self._door_open
				break;

			case "electric_buyable_door":
				flag_wait("power_on");
				self set_hint_string(self,"default_buy_door",cost);
				break;
	self door_buy()
				break;

			case "delay_door":
				self door_delay();
				break;
	self door_buy()
				break;

			default:
				self [[ level._default_door_custom_logic ]]();
				break;
	self door_buy()
	IsDefined(level._default_door_custom_logic)
				break;
		}

		self door_opened(cost);
		if(!(flag("door_can_close")))
		{
			break;
		}
	}
}

//Function Number: 17
self_and_flag_wait(msg)
{
	self endon(msg);
	if(IsDefined(self.power_door_ignore_flag_wait) && self.power_door_ignore_flag_wait)
	{
		level waittill("forever");
	}
	else
	{
		flag_wait(msg);
	}
}

//Function Number: 18
door_block()
{
	if(IsDefined(self.doors))
	{
		for(i = 0;i < self.doors.size;i++)
		{
			if((IsDefined(self.doors[i].script_noteworthy) && self.doors[i].script_noteworthy == "clip") || IsDefined(self.doors[i].script_string) && self.doors[i].script_string == "clip")
			{
				self.doors[i] solid();
			}
		}
	}
}

//Function Number: 19
door_opened(cost,quick_close)
{
	if(IsDefined(self.door_is_moving) && self.door_is_moving)
	{
		return;
	}

	self.has_been_opened = 1;
	all_trigs = getentarray(self.target,"target");
	self.door_is_moving = 1;
	foreach(trig in all_trigs)
	{
		trig.door_is_moving = 1;
		trig trigger_off();
		trig.has_been_opened = 1;
		if(!IsDefined(trig._door_open) || trig._door_open == 0)
		{
			trig._door_open = 1;
			trig notify("door_opened");
			level thread maps/mp/zombies/_zm_audio::sndmusicstingerevent("door_open");
		}
		else
		{
			trig._door_open = 0;
		}

		if(IsDefined(trig.script_flag) && trig._door_open == 1)
		{
			tokens = strtok(trig.script_flag,",");
			for(i = 0;i < tokens.size;i++)
			{
				flag_set(tokens[i]);
			}
		}
		else if(IsDefined(trig.script_flag) && trig._door_open == 0)
		{
			tokens = strtok(trig.script_flag,",");
			for(i = 0;i < tokens.size;i++)
			{
				flag_clear(tokens[i]);
			}
		}

		if(IsDefined(quick_close) && quick_close)
		{
			trig set_hint_string(trig,"");
		}
		else if(trig._door_open == 1 && flag("door_can_close"))
		{
			trig set_hint_string(trig,"default_buy_door_close");
		}
		else if(trig._door_open == 0)
		{
			trig set_hint_string(trig,"default_buy_door",cost);
		}
	}

	level notify("door_opened",_k848);
	if(IsDefined(self.doors))
	{
		is_script_model_door = 0;
		have_moving_clip_for_door = 0;
		use_blocker_clip_for_pathing = 0;
		foreach(door in self.doors)
		{
			if(is_true(door.ignore_use_blocker_clip_for_pathing_check))
			{
			}
			else if(door.classname == "script_model")
			{
				is_script_model_door = 1;
			}
			else if(door.classname == "script_brushmodel" && (!IsDefined(door.script_noteworthy) || door.script_noteworthy != "clip") && !IsDefined(door.script_string) || door.script_string != "clip")
			{
				have_moving_clip_for_door = 1;
			}
		}

		use_blocker_clip_for_pathing = is_script_model_door && !have_moving_clip_for_door;
		for(i = 0;i < self.doors.size;i++)
		{
			self.doors[i] thread door_activate(self.doors[i].script_transition_time,self._door_open,quick_close,use_blocker_clip_for_pathing);
		}

		if(self.doors.size)
		{
			play_sound_at_pos("purchase",self.doors[0].origin);
		}
	}

	level.active_zone_names = maps/mp/zombies/_zm_zonemgr::get_active_zone_names();
	wait(1);
	self.door_is_moving = 0;
	foreach(trig in all_trigs)
	{
		trig.door_is_moving = 0;
	}

	if(IsDefined(quick_close) && quick_close)
	{
		for(i = 0;i < all_trigs.size;i++)
		{
			all_trigs[i] trigger_on();
		}

		return;
	}

	if(flag("door_can_close"))
	{
		wait(2);
		for(i = 0;i < all_trigs.size;i++)
		{
			all_trigs[i] trigger_on();
		}
	}
}

//Function Number: 20
physics_launch_door(door_trig)
{
	vec = VectorScale(vectornormalize(self.script_vector));
	self rotateroll(5,0.05);
	wait(0.05);
	self moveto(self.origin + vec,0.1);
	self waittill(10,"movedone");
	self physicslaunch(self.origin,self.script_vector * 300);
	wait(60);
	self delete();
}

//Function Number: 21
door_solid_thread()
{
	self waittill_either("rotatedone","movedone");
	self.door_moving = undefined;
	while(1)
	{
		players = get_players();
		player_touching = 0;
		for(i = 0;i < players.size;i++)
		{
			if(players[i] istouching(self))
			{
				player_touching = 1;
				break;
			}
		}

		if(!(player_touching))
		{
			self solid();
			return;
		}

		wait(1);
	}
}

//Function Number: 22
door_solid_thread_anim()
{
	self waittillmatch
	return "door_anim";
	("end");
	self.door_moving = undefined;
	while(1)
	{
		players = get_players();
		player_touching = 0;
		for(i = 0;i < players.size;i++)
		{
			if(players[i] istouching(self))
			{
				player_touching = 1;
				break;
			}
		}

		if(!(player_touching))
		{
			self solid();
			return;
		}

		wait(1);
	}
}

//Function Number: 23
disconnect_paths_when_done()
{
	self waittill_either("rotatedone","movedone");
	self disconnectpaths();
}

//Function Number: 24
self_disconnectpaths()
{
	self disconnectpaths();
}

//Function Number: 25
debris_init()
{
	cost = 1000;
	if(IsDefined(self.zombie_cost))
	{
		cost = self.zombie_cost;
	}

	self set_hint_string(self,"default_buy_debris",cost);
	self setcursorhint("HINT_NOICON");
	if(IsDefined(self.script_flag) && !IsDefined(level.flag[self.script_flag]))
	{
		flag_init(self.script_flag);
	}

	self thread debris_think();
}

//Function Number: 26
debris_think()
{
	if(IsDefined(level.custom_debris_function))
	{
		self [[ level.custom_debris_function ]]();
	}

	while(1)
	{
		self waittill("trigger",who,force);
		if(GetDvarInt(#"2ECA0C0E") > 0 || IsDefined(force) && force)
		{
			break;
		}

		if(!(who usebuttonpressed()))
		{
			continue;
		}

		if(who in_revive_trigger())
		{
			continue;
		}

		if(is_player_valid(who))
		{
			players = get_players();
			if(GetDvarInt(#"2ECA0C0E") > 0)
			{
				break;
			}

			if(who.score >= self.zombie_cost)
			{
				who maps/mp/zombies/_zm_score::minus_to_player_score(self.zombie_cost);
				maps/mp/_demo::bookmark("zm_player_door",GetTime(),who);
				who maps/mp/zombies/_zm_stats::increment_client_stat("doors_purchased");
				who maps/mp/zombies/_zm_stats::increment_player_stat("doors_purchased");
				break;
			}

			play_sound_at_pos("no_purchase",self.origin);
			who maps/mp/zombies/_zm_audio::create_and_play_dialog("general","door_deny");
			continue;
			bbprint("zombie_uses","playername %s playerscore %d round %d cost %d name %s x %f y %f z %f type %s",who.name,who.score,level.round_number,self.zombie_cost,self.script_flag,self.origin,"door");
			junk = getentarray(self.target,"targetname");
			if(IsDefined(self.script_flag))
			{
				tokens = strtok(self.script_flag,",");
				for(i = 0;i < tokens.size;i++)
				{
					flag_set(tokens[i]);
				}
			}

			play_sound_at_pos("purchase",self.origin);
			level notify("junk purchased");
			move_ent = undefined;
			clip = undefined;
			for(i = 0;i < junk.size;i++)
			{
				junk[i] connectpaths();
				if(IsDefined(junk[i].script_noteworthy))
				{
					if(junk[i].script_noteworthy == "clip")
					{
						clip = junk[i];
					}
					else
					{
						struct = undefined;
						if(IsDefined(junk[i].script_linkto))
						{
							struct = getstruct(junk[i].script_linkto,"script_linkname");
							if(IsDefined(struct))
							{
								move_ent = junk[i];
								junk[i] thread debris_move(struct);
								continue;
							}

							junk[i] delete();
						}
						else
						{
							junk[i] delete();
						}
					}
				}
			}

			all_trigs = getentarray(self.target,"target");
			for(i = 0;i < all_trigs.size;i++)
			{
				all_trigs[i] delete();
			}

			if(IsDefined(clip))
			{
				if(IsDefined(move_ent))
				{
					move_ent waittill("movedone");
				}

				clip delete();
			}

			break;
		}
	}
}

//Function Number: 27
debris_move(struct)
{
	self script_delay();
	self notsolid();
	self play_sound_on_ent("debris_move");
	playsoundatposition("zmb_lightning_l",self.origin);
	if(IsDefined(self.script_firefx))
	{
		playfx(level._effect[self.script_firefx],self.origin);
	}

	if(IsDefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "jiggle")
		{
			num = randomintrange(3,5);
			og_angles = self.angles;
			for(i = 0;i < num;i++)
			{
				angles = og_angles + (-5 + randomfloat(10),-5 + randomfloat(10),-5 + randomfloat(10));
				time = randomfloatrange(0.1,0.4);
				self rotateto(angles,time);
				wait(time - 0.05);
			}
		}
	}

	time = 0.5;
	if(IsDefined(self.script_transition_time))
	{
		time = self.script_transition_time;
	}

	self moveto(struct.origin,time,time * 0.5);
	self rotateto(struct.angles,time * 0.75);
	self waittill("movedone");
	if(IsDefined(self.script_fxid))
	{
		playfx(level._effect[self.script_fxid],self.origin);
		playsoundatposition("zmb_zombie_spawn",self.origin);
	}

	self delete();
}

//Function Number: 28
blocker_disconnect_paths(start_node,end_node,two_way)
{
}

//Function Number: 29
blocker_connect_paths(start_node,end_node,two_way)
{
}

//Function Number: 30
blocker_init()
{
	if(!(IsDefined(self.target)))
	{
		return;
	}

	targets = getentarray(self.target,"targetname");
	self.barrier_chunks = [];
	for(j = 0;j < targets.size;j++)
	{
		if(targets[j] iszbarrier())
		{
			if(IsDefined(level.zbarrier_override))
			{
				self thread [[ level.zbarrier_override ]](targets[j]);
			}
			else
			{
				self.zbarrier = targets[j];
				if(IsDefined(level.zbarrier_script_string_sets_collision) && level.zbarrier_script_string_sets_collision)
				{
					if(IsDefined(self.zbarrier.script_string))
					{
					}
					else
					{
					}

					m_collision = "p6_anim_zm_barricade_board_collision";
				}
				else
				{
					m_collision = "p6_anim_zm_barricade_board_collision";
				}

				precachemodel(m_collision);
				self.zbarrier setzbarriercolmodel(m_collision);
				self.zbarrier.chunk_health = [];
				for(i = 0;i < self.zbarrier getnumzbarrierpieces();i++)
				{
					self.zbarrier.chunk_health[i] = 0;
				}

				if(IsDefined(targets[j].script_string) && targets[j].script_string == "rock")
				{
					targets[j].material = "rock";
				}

				if(IsDefined(targets[j].script_parameters))
				{
					if(targets[j].script_parameters == "grate")
					{
						if(IsDefined(targets[j].script_noteworthy))
						{
							if(targets[j].script_noteworthy == "2" || targets[j].script_noteworthy == "3" || targets[j].script_noteworthy == "4" || targets[j].script_noteworthy == "5" || targets[j].script_noteworthy == "6")
							{
								targets[j] hide();
/#
								iprintlnbold(" Hide ");
							}
						}
#/
					}
					else if(targets[j].script_parameters == "repair_board")
					{
						targets[j].unbroken_section = getent(targets[j].target,"targetname");
						if(IsDefined(targets[j].unbroken_section))
						{
							targets[j].unbroken_section linkto(targets[j]);
							targets[j] hide();
							targets[j] notsolid();
							targets[j].unbroken = 1;
							if(IsDefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "glass")
							{
								targets[j].material = "glass";
								targets[j] thread destructible_glass_barricade(targets[j].unbroken_section,self);
								continue;
							}

							if(IsDefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "metal")
							{
								targets[j].material = "metal";
							}
						}
					}
					else if(targets[j].script_parameters == "barricade_vents")
					{
						targets[j].material = "metal_vent";
					}
				}

				if(IsDefined(targets[j].targetname))
				{
					if(targets[j].targetname == "auto2")
					{
					}
				}

				targets[j] update_states("repaired");
				targets[j].destroyed = 0;
				targets[j] show();
				targets[j].claimed = 0;
				targets[j].anim_grate_index = 0;
				targets[j].og_origin = targets[j].origin;
				targets[j].og_angles = targets[j].angles;
				self.barrier_chunks[self.barrier_chunks.size] = targets[j];
			}
		}
	}

	target_nodes = getnodearray(self.target,"targetname");
	for(j = 0;j < target_nodes.size;j++)
	{
		if(target_nodes[j].type == "Begin")
		{
			self.neg_start = target_nodes[j];
			if(IsDefined(self.neg_start.target))
			{
				self.neg_end = getnode(self.neg_start.target,"targetname");
			}

			blocker_disconnect_paths(self.neg_start,self.neg_end);
		}
	}

	if(IsDefined(self.zbarrier))
	{
		if(IsDefined(self.barrier_chunks))
		{
			for(i = 0;i < self.barrier_chunks.size;i++)
			{
				self.barrier_chunks[i] delete();
			}

			self.barrier_chunks = [];
		}
	}

	if(IsDefined(self.zbarrier) && should_delete_zbarriers())
	{
		self.zbarrier delete();
		self.zbarrier = undefined;
		return;
	}

	self blocker_attack_spots();
	self.trigger_location = getstruct(self.target,"targetname");
	self thread blocker_think();
}

//Function Number: 31
should_delete_zbarriers()
{
	gametype = GetDvar(#"41651E");
	if(!is_classic() && !is_standard() && gametype != "zgrief")
	{
		return 1;
	}
}

//Function Number: 32
destructible_glass_barricade(unbroken_section,node)
{
	unbroken_section setcandamage(1);
	unbroken_section.health = 99999;
	unbroken_section waittill("damage",amount,who);
	if(is_player_valid(who) || who maps/mp/zombies/_zm_laststand::player_is_in_laststand())
	{
		self thread maps/mp/zombies/_zm_spawner::zombie_boardtear_offset_fx_horizontle(self,node);
		level thread remove_chunk(self,node,1);
		self update_states("destroyed");
		self notify("destroyed");
		self.unbroken = 0;
	}
}

//Function Number: 33
blocker_attack_spots()
{
	spots = [];
	numslots = self.zbarrier getzbarriernumattackslots();
	numslots = int(max(numslots,1));
	if(numslots % 2)
	{
		spots[spots.size] = groundpos_ignore_water_new(60 + VectorScale((0,0,1)));
	}

	if(numslots > 1)
	{
		reps = floor(numslots / 2);
		slot = 1;
		for(i = 0;i < reps;i++)
		{
			offset = self.zbarrier getzbarrierattackslothorzoffset() * i + 1;
			spots[spots.size] = groundpos_ignore_water_new(60 + VectorScale((0,0,1)));
			slot++;
			if(slot < numslots)
			{
				spots[spots.size] = groundpos_ignore_water_new(60 + VectorScale((0,0,1)));
				slot++;
			}
		}
	}

	taken = [];
	for(i = 0;i < spots.size;i++)
	{
		taken[i] = 0;
	}

	self.attack_spots_taken = taken;
	self.attack_spots = spots;
/#
	self thread debug_attack_spots_taken();
#/
}

//Function Number: 34
blocker_choke()
{
	level._blocker_choke = 0;
	level endon("stop_blocker_think");
	while(1)
	{
		wait(0.05);
		level._blocker_choke = 0;
	}
}

//Function Number: 35
blocker_think()
{
	level endon("stop_blocker_think");
	if(!(IsDefined(level._blocker_choke)))
	{
		level thread blocker_choke();
	}

	use_choke = 0;
	if(IsDefined(level._use_choke_blockers) && level._use_choke_blockers == 1)
	{
		use_choke = 1;
	}

	while(1)
	{
		wait(0.5);
		if(use_choke)
		{
			if(level._blocker_choke > 3)
			{
				wait(0.05);
			}
		}

		level._blocker_choke++;
		if(all_chunks_intact(self,self.barrier_chunks))
		{
			continue;
		}

		if(no_valid_repairable_boards(self,self.barrier_chunks))
		{
			continue;
		}

		self blocker_trigger_think();
	}
}

//Function Number: 36
player_fails_blocker_repair_trigger_preamble(player,players,trigger,hold_required)
{
	if(!(IsDefined(trigger)))
	{
		return 1;
	}

	if(!(is_player_valid(player)))
	{
		return 1;
	}

	if(players.size == 1 && IsDefined(players[0].intermission) && players[0].intermission == 1)
	{
		return 1;
	}

	if(hold_required && !player usebuttonpressed())
	{
		return 1;
	}

	if(!hold_required && !player use_button_held())
	{
		return 1;
	}

	if(player in_revive_trigger())
	{
		return 1;
	}

	return 0;
}

//Function Number: 37
has_blocker_affecting_perk()
{
	has_perk = undefined;
	if(self hasperk("specialty_fastreload"))
	{
		has_perk = "specialty_fastreload";
	}

	return has_perk;
}

//Function Number: 38
do_post_chunk_repair_delay(has_perk)
{
	if(!(self script_delay()))
	{
		wait(1);
	}
}

//Function Number: 39
handle_post_board_repair_rewards(cost,zbarrier)
{
	self maps/mp/zombies/_zm_stats::increment_client_stat("boards");
	self maps/mp/zombies/_zm_stats::increment_player_stat("boards");
	if(IsDefined(self.pers["boards"]) && self.pers["boards"] % 10 == 0)
	{
		self thread do_player_general_vox("general","reboard",90);
	}

	self maps/mp/zombies/_zm_pers_upgrades_functions::pers_boards_updated(zbarrier);
	self.rebuild_barrier_reward = self.rebuild_barrier_reward + cost;
	if(self.rebuild_barrier_reward < level.zombie_vars["rebuild_barrier_cap_per_round"])
	{
		self maps/mp/zombies/_zm_score::player_add_points("rebuild_board",cost);
		self play_sound_on_ent("purchase");
	}

	if(IsDefined(self.board_repair))
	{
		self.board_repair = self.board_repair + 1;
	}
}

//Function Number: 40
blocker_unitrigger_think()
{
	self endon("kill_trigger");
	while(1)
	{
		self waittill("trigger",player);
		self.stub.trigger_target notify("trigger",player);
	}
}

//Function Number: 41
blocker_trigger_think()
{
	self endon("blocker_hacked");
	if(IsDefined(level.no_board_repair) && level.no_board_repair)
	{
		return;
	}

/#
	println("ZM >> TRIGGER blocker_trigger_think ");
#/
	level endon("stop_blocker_think");
	cost = 10;
	if(IsDefined(self.zombie_cost))
	{
		cost = self.zombie_cost;
	}

	original_cost = cost;
	if(!(IsDefined(self.unitrigger_stub)))
	{
		radius = 94.21;
		height = 94.21;
		if(IsDefined(self.trigger_location))
		{
			trigger_location = self.trigger_location;
		}
		else
		{
			trigger_location = self;
		}

		if(IsDefined(trigger_location.radius))
		{
			radius = trigger_location.radius;
		}

		if(IsDefined(trigger_location.height))
		{
			height = trigger_location.height;
		}

		trigger_pos = 4 + VectorScale((0,0,1));
		self.unitrigger_stub = spawnstruct();
		self.unitrigger_stub.origin = trigger_pos;
		self.unitrigger_stub.radius = radius;
		self.unitrigger_stub.height = height;
		self.unitrigger_stub.script_unitrigger_type = "unitrigger_radius";
		self.unitrigger_stub.hint_string = get_hint_string(self,"default_reward_barrier_piece");
		self.unitrigger_stub.cursor_hint = "HINT_NOICON";
		self.unitrigger_stub.trigger_target = self;
		maps/mp/zombies/_zm_unitrigger::register_static_unitrigger(self.unitrigger_stub,::blocker_unitrigger_think);
		maps/mp/zombies/_zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
		if(!(IsDefined(trigger_location.angles)))
		{
			trigger_location.angles = (0,0,0);
		}

		self.unitrigger_stub.origin = 4 + VectorScale((0,0,1)) + AnglesToForward(trigger_location.angles) * -11;
	}

	self thread trigger_delete_on_repair();
	thread maps/mp/zombies/_zm_unitrigger::register_static_unitrigger(self.unitrigger_stub,::blocker_unitrigger_think);
/#
	if(GetDvarInt(#"FA91EA91") > 0)
	{
		thread debug_blocker(trigger_pos,radius,height);
	}

		for(;;)
		{
#/
		if(1)
		{
			self waittill(groundpos(trigger_location.origin),groundpos(trigger_location.origin),"trigger",player);
			has_perk = player has_blocker_affecting_perk();
			if(all_chunks_intact(self,self.barrier_chunks))
			{
				self notify("all_boards_repaired");
				return;
			}

			if(no_valid_repairable_boards(self,self.barrier_chunks))
			{
				self notify("no valid boards");
				return;
			}

			if(IsDefined(level._zm_blocker_trigger_think_return_override))
			{
				if(self [[ level._zm_blocker_trigger_think_return_override ]](player))
				{
					return;
				}
			}

			while(1)
			{
				players = get_players();
				if(player_fails_blocker_repair_trigger_preamble(player,players,self.unitrigger_stub.trigger,0))
				{
					break;
				}

				if(IsDefined(self.zbarrier))
				{
					chunk = get_random_destroyed_chunk(self,self.barrier_chunks);
					self thread replace_chunk(self,chunk,has_perk,IsDefined(player.pers_upgrades_awarded["board"]) && player.pers_upgrades_awarded["board"]);
				}
				else
				{
					chunk = get_random_destroyed_chunk(self,self.barrier_chunks);
					if((IsDefined(chunk.script_parameter) && chunk.script_parameters == "repair_board") || chunk.script_parameters == "barricade_vents")
					{
						if(IsDefined(chunk.unbroken_section))
						{
							chunk show();
							chunk solid();
							chunk.unbroken_section self_delete();
						}
					}
					else
					{
						chunk show();
					}

					if(!IsDefined(chunk.script_parameters) || chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents")
					{
						if(!(IsDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx))
						{
							if(!IsDefined(chunk.material) || IsDefined(chunk.material) && chunk.material != "rock")
							{
								chunk play_sound_on_ent("rebuild_barrier_piece");
							}

							playsoundatposition("zmb_cha_ching",(0,0,0));
						}
					}

					if(chunk.script_parameters == "bar")
					{
						chunk play_sound_on_ent("rebuild_barrier_piece");
						playsoundatposition("zmb_cha_ching",(0,0,0));
					}

					if(IsDefined(chunk.script_parameters))
					{
						if(chunk.script_parameters == "bar")
						{
							if(IsDefined(chunk.script_noteworthy))
							{
								if(chunk.script_noteworthy == "5")
								{
									chunk hide();
								}
								else if(chunk.script_noteworthy == "3")
								{
									chunk hide();
								}
							}
						}
					}

					self thread replace_chunk(self,chunk,has_perk,IsDefined(player.pers_upgrades_awarded["board"]) && player.pers_upgrades_awarded["board"]);
				}

				if(IsDefined(self.clip))
				{
					self.clip enable_trigger();
					self.clip disconnectpaths();
				}
				else
				{
					blocker_disconnect_paths(self.neg_start,self.neg_end);
				}

				bbprint("zombie_uses","playername %s playerscore %d round %d cost %d name %s x %f y %f z %f type %s",player.name,player.score,level.round_number,original_cost,self.target,self.origin,"repair");
				self do_post_chunk_repair_delay(has_perk);
				if(!(is_player_valid(player)))
				{
					break;
				}

				player handle_post_board_repair_rewards(cost,self);
				if(all_chunks_intact(self,self.barrier_chunks))
				{
					self notify("all_boards_repaired");
					return;
				}

				if(no_valid_repairable_boards(self,self.barrier_chunks))
				{
					self notify("no valid boards");
					return;
				}
			}
		}
	}
}

//Function Number: 42
random_destroyed_chunk_show()
{
	wait(0.5);
	self show();
}

//Function Number: 43
door_repaired_rumble_n_sound()
{
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(distance(players[i].origin,self.origin) < 150)
		{
			if(isalive(players[i]))
			{
				players[i] thread board_completion();
			}
		}
	}
}

//Function Number: 44
board_completion()
{
	self endon("disconnect");
}

//Function Number: 45
trigger_delete_on_repair()
{
	while(1)
	{
		self waittill_either("all_boards_repaired","no valid boards");
		maps/mp/zombies/_zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
		break;
	}
}

//Function Number: 46
rebuild_barrier_reward_reset()
{
	self.rebuild_barrier_reward = 0;
}

//Function Number: 47
remove_chunk(chunk,node,destroy_immediately,zomb)
{
	chunk update_states("mid_tear");
	if(IsDefined(chunk.script_parameters))
	{
		if(chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents")
		{
			chunk thread zombie_boardtear_audio_offset(chunk);
		}
	}

	if(IsDefined(chunk.script_parameters))
	{
		if(chunk.script_parameters == "bar")
		{
			chunk thread zombie_bartear_audio_offset(chunk);
		}
	}

	chunk notsolid();
	fx = "wood_chunk_destory";
	if(IsDefined(self.script_fxid))
	{
		fx = self.script_fxid;
	}

	if(IsDefined(chunk.script_moveoverride) && chunk.script_moveoverride)
	{
		chunk hide();
	}

	if(IsDefined(chunk.script_parameters) && chunk.script_parameters == "bar")
	{
		if(IsDefined(chunk.script_noteworthy) && chunk.script_noteworthy == "4")
		{
			ent = spawn("script_origin",chunk.origin);
			ent.angles = 180 + VectorScale((0,1,0));
			dist = 100;
			if(IsDefined(chunk.script_move_dist))
			{
				dist_max = chunk.script_move_dist - 100;
				dist = 100 + randomint(dist_max);
			}
			else
			{
				dist = 100 + randomint(100);
			}

			dest = ent.origin + AnglesToForward(ent.angles) * dist;
			trace = bullettrace(16 + VectorScale((0,0,1)),dest,200 + VectorScale((0,0,-1)),dest);
			if(trace["fraction"] == 1)
			{
				dest = 200 + VectorScale((0,0,-1));
			}
			else
			{
				dest = trace["position"];
			}

			chunk linkto(ent);
			time = ent fake_physicslaunch(dest,300 + randomint(100));
			if(randomint(100) > 40)
			{
				ent rotatepitch(180,time * 0.5);
			}
			else
			{
				ent rotatepitch(90,time,time * 0.5);
			}

			wait(time);
			chunk hide();
			wait(0.1);
			ent delete();
		}
		else
		{
			ent = spawn("script_origin",chunk.origin);
			ent.angles = 180 + VectorScale((0,1,0));
			dist = 100;
			if(IsDefined(chunk.script_move_dist))
			{
				dist_max = chunk.script_move_dist - 100;
				dist = 100 + randomint(dist_max);
			}
			else
			{
				dist = 100 + randomint(100);
			}

			dest = ent.origin + AnglesToForward(ent.angles) * dist;
			trace = bullettrace(16 + VectorScale((0,0,1)),dest,200 + VectorScale((0,0,-1)),dest);
			if(trace["fraction"] == 1)
			{
				dest = 200 + VectorScale((0,0,-1));
			}
			else
			{
				dest = trace["position"];
			}

			chunk linkto(ent);
			time = ent fake_physicslaunch(dest,260 + randomint(100));
			if(randomint(100) > 40)
			{
				ent rotatepitch(180,time * 0.5);
			}
			else
			{
				ent rotatepitch(90,time,time * 0.5);
			}

			wait(time);
			chunk hide();
			wait(0.1);
			ent delete();
		}

		chunk update_states("destroyed");
		chunk notify("destroyed",dest,0,undefined,node.angles,dest,0,undefined,node.angles);
	}

	if((IsDefined(chunk.script_parameters) && chunk.script_parameters == "board") || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents")
	{
		ent = spawn("script_origin",chunk.origin);
		ent.angles = 180 + VectorScale((0,1,0));
		dist = 100;
		if(IsDefined(chunk.script_move_dist))
		{
			dist_max = chunk.script_move_dist - 100;
			dist = 100 + randomint(dist_max);
		}
		else
		{
			dist = 100 + randomint(100);
		}

		dest = ent.origin + AnglesToForward(ent.angles) * dist;
		trace = bullettrace(16 + VectorScale((0,0,1)),dest,200 + VectorScale((0,0,-1)),dest);
		if(trace["fraction"] == 1)
		{
			dest = 200 + VectorScale((0,0,-1));
		}
		else
		{
			dest = trace["position"];
		}

		chunk linkto(ent);
		time = ent fake_physicslaunch(dest,200 + randomint(100));
		if(IsDefined(chunk.unbroken_section))
		{
			if(!IsDefined(chunk.material) || chunk.material != "metal")
			{
				chunk.unbroken_section self_delete();
			}
		}

		if(randomint(100) > 40)
		{
			ent rotatepitch(180,time * 0.5);
		}
		else
		{
			ent rotatepitch(90,time,time * 0.5);
		}

		wait(time);
		if(IsDefined(chunk.unbroken_section))
		{
			if(IsDefined(chunk.material) && chunk.material == "metal")
			{
				chunk.unbroken_section self_delete();
			}
		}

		chunk hide();
		wait(0.1);
		ent delete();
		chunk update_states("destroyed");
		chunk notify("destroyed",dest,0,undefined,node.angles);
	}

	if(IsDefined(chunk.script_parameters) && chunk.script_parameters == "grate")
	{
		if(IsDefined(chunk.script_noteworthy) && chunk.script_noteworthy == "6")
		{
			ent = spawn("script_origin",chunk.origin);
			ent.angles = 180 + VectorScale((0,1,0));
			dist = 100 + randomint(100);
			dest = ent.origin + AnglesToForward(ent.angles) * dist;
			trace = bullettrace(16 + VectorScale((0,0,1)),dest,200 + VectorScale((0,0,-1)),dest);
			if(trace["fraction"] == 1)
			{
				dest = 200 + VectorScale((0,0,-1));
			}
			else
			{
				dest = trace["position"];
			}

			chunk linkto(ent);
			time = ent fake_physicslaunch(dest,200 + randomint(100));
			if(randomint(100) > 40)
			{
				ent rotatepitch(180,time * 0.5);
			}
			else
			{
				ent rotatepitch(90,time,time * 0.5);
			}

			wait(time);
			chunk hide();
			ent delete();
			chunk update_states("destroyed");
			chunk notify("destroyed",dest,0,undefined,node.angles);
		}
		else
		{
			chunk hide();
			chunk update_states("destroyed");
			chunk notify("destroyed");
		}
	}
}

//Function Number: 48
remove_chunk_rotate_grate(chunk)
{
	if(IsDefined(chunk.script_parameters) && chunk.script_parameters == "grate")
	{
		chunk vibrate(VectorScale((0,1,0)),270,0.2,0.4);
	}
}

//Function Number: 49
zombie_boardtear_audio_offset(chunk)
{
	if(IsDefined(chunk.material) && !IsDefined(chunk.already_broken))
	{
		chunk.already_broken = 0;
	}

	if(IsDefined(chunk.material) && chunk.material == "glass" && chunk.already_broken == 0)
	{
		chunk playsound("zmb_break_glass_barrier");
		wait(randomfloatrange(0.3,0.6));
		chunk playsound("zmb_break_glass_barrier");
		chunk.already_broken = 1;
	}
	else if(IsDefined(chunk.material) && chunk.material == "metal" && chunk.already_broken == 0)
	{
		chunk playsound("grab_metal_bar");
		wait(randomfloatrange(0.3,0.6));
		chunk playsound("break_metal_bar");
		chunk.already_broken = 1;
	}
	else if(IsDefined(chunk.material) && chunk.material == "rock")
	{
		if(!(IsDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx))
		{
			chunk playsound("zmb_break_rock_barrier");
			wait(randomfloatrange(0.3,0.6));
			chunk playsound("zmb_break_rock_barrier");
		}

		chunk.already_broken = 1;
	}
	else if(IsDefined(chunk.material) && chunk.material == "metal_vent")
	{
		if(!(IsDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx))
		{
			chunk playsound("evt_vent_slat_remove");
		}
	}
	else
	{
		if(!(IsDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx))
		{
			chunk play_sound_on_ent("break_barrier_piece");
			wait(randomfloatrange(0.3,0.6));
			chunk play_sound_on_ent("break_barrier_piece");
		}

		chunk.already_broken = 1;
	}
}

//Function Number: 50
zombie_bartear_audio_offset(chunk)
{
	chunk play_sound_on_ent("grab_metal_bar");
	wait(randomfloatrange(0.3,0.6));
	chunk play_sound_on_ent("break_metal_bar");
	wait(randomfloatrange(1,1.3));
	chunk play_sound_on_ent("drop_metal_bar");
}

//Function Number: 51
ensure_chunk_is_back_to_origin(chunk)
{
	if(chunk.origin != chunk.og_origin)
	{
		chunk notsolid();
		chunk waittill("movedone");
	}
}

//Function Number: 52
replace_chunk(barrier,chunk,perk,upgrade,via_powerup)
{
	if(!(IsDefined(barrier.zbarrier)))
	{
		chunk update_states("mid_repair");
/#
		assert(IsDefined(chunk.og_origin));
#/
/#
		assert(IsDefined(chunk.og_angles));
#/
		sound = "rebuild_barrier_hover";
		if(IsDefined(chunk.script_presound))
		{
			sound = chunk.script_presound;
		}
	}

	has_perk = 0;
	if(IsDefined(perk))
	{
		has_perk = 1;
	}

	if(!IsDefined(via_powerup) && IsDefined(sound))
	{
		play_sound_at_pos(sound,chunk.origin);
	}

	if(upgrade)
	{
		barrier.zbarrier zbarrierpieceuseupgradedmodel(chunk);
		barrier.zbarrier.chunk_health[chunk] = barrier.zbarrier getupgradedpiecenumlives(chunk);
	}
	else
	{
		barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
		barrier.zbarrier.chunk_health[chunk] = 0;
	}

	scalar = 1;
	if(has_perk)
	{
		if("speciality_fastreload" == perk)
		{
			scalar = 0.31;
		}
		else if("speciality_fastreload_upgrade" == perk)
		{
			scalar = 0.2112;
		}
	}

	barrier.zbarrier showzbarrierpiece(chunk);
	barrier.zbarrier setzbarrierpiecestate(chunk,"closing",scalar);
	waitduration = barrier.zbarrier getzbarrierpieceanimlengthforstate(chunk,"closing",scalar);
	wait(waitduration);
}

//Function Number: 53
open_all_zbarriers()
{
	foreach(barrier in level.exterior_goals)
	{
		if(IsDefined(barrier.zbarrier))
		{
			for(x = 0;x < barrier.zbarrier getnumzbarrierpieces();x++)
			{
				barrier.zbarrier setzbarrierpiecestate(x,"opening");
			}
		}

		if(IsDefined(barrier.clip))
		{
			barrier.clip disable_trigger();
			barrier.clip connectpaths();
		}
		else
		{
			blocker_connect_paths(barrier.neg_start,barrier.neg_end);
		}
	}
}

//Function Number: 54
zombie_boardtear_audio_plus_fx_offset_repair_horizontal(chunk)
{
	if(IsDefined(chunk.material) && chunk.material == "rock")
	{
		if(IsDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
		{
			chunk clearclientflag(level._zombie_scriptmover_flag_rock_fx);
		}
		else
		{
			earthquake(randomfloatrange(0.3,0.4),randomfloatrange(0.2,0.4),chunk.origin,150);
			playfx(level._effect["wood_chunk_destory"],30 + VectorScale((0,0,1)));
			wait(randomfloatrange(0.3,0.6));
			chunk play_sound_on_ent("break_barrier_piece");
			playfx(level._effect["wood_chunk_destory"],30 + VectorScale((0,0,-1)));
		}
	}
	else if(IsDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)
	{
		chunk clearclientflag(level._zombie_scriptmover_flag_board_horizontal_fx);
	}
	else
	{
		earthquake(randomfloatrange(0.3,0.4),randomfloatrange(0.2,0.4),chunk.origin,150);
		playfx(level._effect["wood_chunk_destory"],30 + VectorScale((0,0,1)));
		wait(randomfloatrange(0.3,0.6));
		chunk play_sound_on_ent("break_barrier_piece");
		playfx(level._effect["wood_chunk_destory"],30 + VectorScale((0,0,-1)));
	}
}

//Function Number: 55
zombie_boardtear_audio_plus_fx_offset_repair_verticle(chunk)
{
	if(IsDefined(chunk.material) && chunk.material == "rock")
	{
		if(IsDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
		{
			chunk clearclientflag(level._zombie_scriptmover_flag_rock_fx);
		}
		else
		{
			earthquake(randomfloatrange(0.3,0.4),randomfloatrange(0.2,0.4),chunk.origin,150);
			playfx(level._effect["wood_chunk_destory"],30 + VectorScale((1,0,0)));
			wait(randomfloatrange(0.3,0.6));
			chunk play_sound_on_ent("break_barrier_piece");
			playfx(level._effect["wood_chunk_destory"],30 + VectorScale((-1,0,0)));
		}
	}
	else if(IsDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)
	{
		chunk clearclientflag(level._zombie_scriptmover_flag_board_vertical_fx);
	}
	else
	{
		earthquake(randomfloatrange(0.3,0.4),randomfloatrange(0.2,0.4),chunk.origin,150);
		playfx(level._effect["wood_chunk_destory"],30 + VectorScale((1,0,0)));
		wait(randomfloatrange(0.3,0.6));
		chunk play_sound_on_ent("break_barrier_piece");
		playfx(level._effect["wood_chunk_destory"],30 + VectorScale((-1,0,0)));
	}
}

//Function Number: 56
zombie_gratetear_audio_plus_fx_offset_repair_horizontal(chunk)
{
	earthquake(randomfloatrange(0.3,0.4),randomfloatrange(0.2,0.4),chunk.origin,150);
	chunk play_sound_on_ent("bar_rebuild_slam");
	switch(randomint(9))
	{
		case "0":
			playfx(level._effect["fx_zombie_bar_break"],30 + VectorScale((-1,0,0)));
			wait(randomfloatrange(0,0.3));
			playfx(level._effect["fx_zombie_bar_break_lite"],30 + VectorScale((-1,0,0)));
			break;
	chunk.origin
	chunk.origin
			break;

		case "1":
			playfx(level._effect["fx_zombie_bar_break"],30 + VectorScale((-1,0,0)));
			wait(randomfloatrange(0,0.3));
			playfx(level._effect["fx_zombie_bar_break"],30 + VectorScale((-1,0,0)));
			break;
	chunk.origin
	chunk.origin
			break;

		case "2":
			playfx(level._effect["fx_zombie_bar_break_lite"],30 + VectorScale((-1,0,0)));
			wait(randomfloatrange(0,0.3));
			playfx(level._effect["fx_zombie_bar_break"],30 + VectorScale((-1,0,0)));
			break;
	chunk.origin
	chunk.origin
			break;

		case "3":
			playfx(level._effect["fx_zombie_bar_break"],30 + VectorScale((-1,0,0)));
			wait(randomfloatrange(0,0.3));
			playfx(level._effect["fx_zombie_bar_break_lite"],30 + VectorScale((-1,0,0)));
			break;
	chunk.origin
	chunk.origin
			break;

		case "4":
			playfx(level._effect["fx_zombie_bar_break_lite"],30 + VectorScale((-1,0,0)));
			wait(randomfloatrange(0,0.3));
			playfx(level._effect["fx_zombie_bar_break_lite"],30 + VectorScale((-1,0,0)));
			break;
	chunk.origin
	chunk.origin
			break;

		case "5":
			playfx(level._effect["fx_zombie_bar_break_lite"],30 + VectorScale((-1,0,0)));
			break;
	chunk.origin
			break;

		case "6":
			playfx(level._effect["fx_zombie_bar_break_lite"],30 + VectorScale((-1,0,0)));
			break;
	chunk.origin
			break;

		case "7":
			playfx(level._effect["fx_zombie_bar_break"],30 + VectorScale((-1,0,0)));
			break;
	chunk.origin
			break;

		case "8":
			playfx(level._effect["fx_zombie_bar_break"],30 + VectorScale((-1,0,0)));
			break;
	chunk.origin
			break;
	}
}

//Function Number: 57
zombie_bartear_audio_plus_fx_offset_repair_horizontal(chunk)
{
	earthquake(randomfloatrange(0.3,0.4),randomfloatrange(0.2,0.4),chunk.origin,150);
	chunk play_sound_on_ent("bar_rebuild_slam");
	switch(randomint(9))
	{
		case "0":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_left");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_right");
			break;

		case "1":
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_left");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_right");
			break;

		case "2":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_left");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_right");
			break;

		case "3":
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_left");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_right");
			break;

		case "4":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_left");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_right");
			break;

		case "5":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_left");
			break;

		case "6":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_right");
			break;

		case "7":
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_left");
			break;

		case "8":
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_right");
			break;
	}
}

//Function Number: 58
zombie_bartear_audio_plus_fx_offset_repair_verticle(chunk)
{
	earthquake(randomfloatrange(0.3,0.4),randomfloatrange(0.2,0.4),chunk.origin,150);
	chunk play_sound_on_ent("bar_rebuild_slam");
	switch(randomint(9))
	{
		case "0":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_top");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_bottom");
			break;

		case "1":
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_top");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_bottom");
			break;

		case "2":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_top");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_bottom");
			break;

		case "3":
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_top");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_bottom");
			break;

		case "4":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_top");
			wait(randomfloatrange(0,0.3));
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_bottom");
			break;

		case "5":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_top");
			break;

		case "6":
			playfxontag(level._effect["fx_zombie_bar_break_lite"],chunk,"Tag_fx_bottom");
			break;

		case "7":
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_top");
			break;

		case "8":
			playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_bottom");
			break;
	}
}

//Function Number: 59
add_new_zombie_spawners()
{
	if(IsDefined(self.target))
	{
		self.possible_spawners = getentarray(self.target,"targetname");
	}

	if(IsDefined(self.script_string))
	{
		spawners = getentarray(self.script_string,"targetname");
		self.possible_spawners = arraycombine(self.possible_spawners,spawners,1,0);
	}

	if(!(IsDefined(self.possible_spawners)))
	{
		return;
	}

	zombies_to_add = self.possible_spawners;
	for(i = 0;i < self.possible_spawners.size;i++)
	{
		self.possible_spawners[i].is_enabled = 1;
		add_spawner(self.possible_spawners[i]);
	}
}

//Function Number: 60
flag_blocker()
{
	if(!(IsDefined(self.script_flag_wait)))
	{
/#
		assertmsg("Flag Blocker at " + self.origin + " does not have a script_flag_wait key value pair");
#/
		return;
	}

	if(!(IsDefined(level.flag[self.script_flag_wait])))
	{
		flag_init(self.script_flag_wait);
	}

	type = "connectpaths";
	if(IsDefined(self.script_noteworthy))
	{
		type = self.script_noteworthy;
	}

	flag_wait(self.script_flag_wait);
	self script_delay();
	if(type == "connectpaths")
	{
		self connectpaths();
		self disable_trigger();
		return;
	}

	if(type == "disconnectpaths")
	{
		self disconnectpaths();
		self disable_trigger();
		return;
	}

/#
	assertmsg("flag blocker at " + self.origin + ", the type \" + type + "\" is not recognized");
#/
}

//Function Number: 61
update_states(states)
{
/#
	assert(IsDefined(states));
#/
	self.state = states;
}

//Function Number: 62
quantum_bomb_open_nearest_door_validation(position)
{
	range_squared = 32400;
	zombie_doors = getentarray("zombie_door","targetname");
	for(i = 0;i < zombie_doors.size;i++)
	{
		if(distancesquared(zombie_doors[i].origin,position) < range_squared)
		{
			return 1;
		}
	}

	zombie_airlock_doors = getentarray("zombie_airlock_buy","targetname");
	for(i = 0;i < zombie_airlock_doors.size;i++)
	{
		if(distancesquared(zombie_airlock_doors[i].origin,position) < range_squared)
		{
			return 1;
		}
	}

	zombie_debris = getentarray("zombie_debris","targetname");
	for(i = 0;i < zombie_debris.size;i++)
	{
		if(distancesquared(zombie_debris[i].origin,position) < range_squared)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 63
quantum_bomb_open_nearest_door_result(position)
{
	range_squared = 32400;
	zombie_doors = getentarray("zombie_door","targetname");
	for(i = 0;i < zombie_doors.size;i++)
	{
		if(distancesquared(zombie_doors[i].origin,position) < range_squared)
		{
			self thread maps/mp/zombies/_zm_audio::create_and_play_dialog("kill","quant_good");
			zombie_doors[i] notify("trigger",self,1);
			[[ level.quantum_bomb_play_area_effect_func ]](position);
			return;
		}
	}

	zombie_airlock_doors = getentarray("zombie_airlock_buy","targetname");
	for(i = 0;i < zombie_airlock_doors.size;i++)
	{
		if(distancesquared(zombie_airlock_doors[i].origin,position) < range_squared)
		{
			self thread maps/mp/zombies/_zm_audio::create_and_play_dialog("kill","quant_good");
			zombie_airlock_doors[i] notify("trigger",self,1);
			[[ level.quantum_bomb_play_area_effect_func ]](position);
			return;
		}
	}

	zombie_debris = getentarray("zombie_debris","targetname");
	for(i = 0;i < zombie_debris.size;i++)
	{
		if(distancesquared(zombie_debris[i].origin,position) < range_squared)
		{
			self thread maps/mp/zombies/_zm_audio::create_and_play_dialog("kill","quant_good");
			zombie_debris[i] notify("trigger",self,1);
			[[ level.quantum_bomb_play_area_effect_func ]](position);
			return;
		}
	}
}