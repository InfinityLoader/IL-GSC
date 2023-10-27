/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_ai_basic.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 3:02:54 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/animscripts/zm_run;
#include maps/mp/animscripts/zm_shared;
#include maps/mp/zombies/_zm_ai_basic;
#include maps/mp/zombies/_zm_spawner;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
find_flesh()
{
	self endon("death");
	level endon("intermission");
	self endon("stop_find_flesh");
	if(level.intermission)
	{
		return;
	}

	self.ai_state = "find_flesh";
	self.helitarget = 1;
	self.ignoreme = 0;
	self.nododgemove = 1;
	self.ignore_player = [];
	self maps/mp/zombies/_zm_spawner::zombie_history("find flesh -> start");
	self.goalradius = 32;
	if(IsDefined(self.custom_goalradius_override))
	{
		self.goalradius = self.custom_goalradius_override;
	}

	while(1)
	{
		zombie_poi = undefined;
		if(IsDefined(level.zombietheaterteleporterseeklogicfunc))
		{
			self [[ level.zombietheaterteleporterseeklogicfunc ]]();
		}

		if(IsDefined(level._poi_override))
		{
			zombie_poi = self [[ level._poi_override ]]();
		}

		if(!(IsDefined(zombie_poi)))
		{
			zombie_poi = self get_zombie_point_of_interest(self.origin);
		}

		players = get_players();
		if(!IsDefined(self.ignore_player) || players.size == 1)
		{
			self.ignore_player = [];
		}
		else if(!IsDefined(level._should_skip_ignore_player_logic) || ![[ level._should_skip_ignore_player_logic ]]())
		{
			for(i = 0;i < self.ignore_player.size;i++)
			{
				if(IsDefined(self.ignore_player[i]) && IsDefined(self.ignore_player[i].ignore_counter) && self.ignore_player[i].ignore_counter > 3)
				{
					self.ignore_player[i].ignore_counter = 0;
					self.ignore_player = arrayremovevalue(self.ignore_player,self.ignore_player[i]);
					if(!(IsDefined(self.ignore_player)))
					{
						self.ignore_player = [];
					}

					i = 0;
					continue;
				}
			}
		}

		player = get_closest_valid_player(self.origin,self.ignore_player);
		if(!IsDefined(player) && !IsDefined(zombie_poi))
		{
			self maps/mp/zombies/_zm_spawner::zombie_history("find flesh -> can\'t find player, continue");
			if(IsDefined(self.ignore_player))
			{
				if(IsDefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]())
				{
					wait(1);
					continue;
				}

				self.ignore_player = [];
			}

			wait(1);
			continue;
		}

		if(!IsDefined(level.check_for_alternate_poi) || ![[ level.check_for_alternate_poi ]]())
		{
			self.enemyoverride = zombie_poi;
			self.favoriteenemy = player;
		}

		self thread zombie_pathing();
		if(players.size > 1)
		{
			for(i = 0;i < self.ignore_player.size;i++)
			{
				if(IsDefined(self.ignore_player[i]))
				{
					if(!(IsDefined(self.ignore_player[i].ignore_counter)))
					{
						self.ignore_player[i].ignore_counter = 0;
					}
					else
					{
						self.ignore_player[i].ignore_counter = self.ignore_player[i].ignore_counter + 1;
					}
				}
			}
		}

		self thread attractors_generated_listener();
		if(IsDefined(level._zombie_path_timer_override))
		{
			self.zombie_path_timer = [[ level._zombie_path_timer_override ]]();
		}
		else
		{
			self.zombie_path_timer = GetTime() + randomfloatrange(1,3) * 1000;
		}

		while(GetTime() < self.zombie_path_timer)
		{
			wait(0.1);
		}

		self notify("path_timer_done");
		self maps/mp/zombies/_zm_spawner::zombie_history("find flesh -> bottom of loop");
		debug_print("Zombie is re-acquiring enemy, ending breadcrumb search");
		self notify("zombie_acquire_enemy");
	}
}

//Function Number: 2
init_inert_zombies()
{
	level init_inert_substates();
}

//Function Number: 3
init_inert_substates()
{
	level.inert_substates = [];
	level.inert_substates[level.inert_substates.size] = "inert1";
	level.inert_substates[level.inert_substates.size] = "inert2";
	level.inert_substates[level.inert_substates.size] = "inert3";
	level.inert_substates[level.inert_substates.size] = "inert4";
	level.inert_substates[level.inert_substates.size] = "inert5";
	level.inert_substates[level.inert_substates.size] = "inert6";
	level.inert_substates[level.inert_substates.size] = "inert7";
	level.inert_substates = array_randomize(level.inert_substates);
	level.inert_substate_index = 0;
	level.inert_trans_walk = [];
	level.inert_trans_walk[level.inert_trans_walk.size] = "inert_2_walk_1";
	level.inert_trans_walk[level.inert_trans_walk.size] = "inert_2_walk_2";
	level.inert_trans_walk[level.inert_trans_walk.size] = "inert_2_walk_3";
	level.inert_trans_walk[level.inert_trans_walk.size] = "inert_2_walk_4";
	level.inert_trans_run = [];
	level.inert_trans_run[level.inert_trans_run.size] = "inert_2_run_1";
	level.inert_trans_run[level.inert_trans_run.size] = "inert_2_run_2";
	level.inert_trans_sprint = [];
	level.inert_trans_sprint[level.inert_trans_sprint.size] = "inert_2_sprint_1";
	level.inert_trans_sprint[level.inert_trans_sprint.size] = "inert_2_sprint_2";
	level.inert_crawl_substates = [];
	level.inert_crawl_substates[level.inert_crawl_substates.size] = "inert1";
	level.inert_crawl_substates[level.inert_crawl_substates.size] = "inert2";
	level.inert_crawl_substates[level.inert_crawl_substates.size] = "inert3";
	level.inert_crawl_substates[level.inert_crawl_substates.size] = "inert4";
	level.inert_crawl_substates[level.inert_crawl_substates.size] = "inert5";
	level.inert_crawl_substates[level.inert_crawl_substates.size] = "inert6";
	level.inert_crawl_substates[level.inert_crawl_substates.size] = "inert7";
	level.inert_crawl_trans_walk = [];
	level.inert_crawl_trans_walk[level.inert_crawl_trans_walk.size] = "inert_2_walk_1";
	level.inert_crawl_trans_run = [];
	level.inert_crawl_trans_run[level.inert_crawl_trans_run.size] = "inert_2_run_1";
	level.inert_crawl_trans_run[level.inert_crawl_trans_run.size] = "inert_2_run_2";
	level.inert_crawl_trans_sprint = [];
	level.inert_crawl_trans_sprint[level.inert_crawl_trans_sprint.size] = "inert_2_sprint_1";
	level.inert_crawl_trans_sprint[level.inert_crawl_trans_sprint.size] = "inert_2_sprint_2";
	level.inert_crawl_substates = array_randomize(level.inert_crawl_substates);
	level.inert_crawl_substate_index = 0;
}

//Function Number: 4
get_inert_substate()
{
	substate = level.inert_substates[level.inert_substate_index];
	level.inert_substate_index++;
	if(level.inert_substate_index >= level.inert_substates.size)
	{
		level.inert_substates = array_randomize(level.inert_substates);
		level.inert_substate_index = 0;
	}

	return substate;
}

//Function Number: 5
get_inert_crawl_substate()
{
	substate = level.inert_crawl_substates[level.inert_crawl_substate_index];
	level.inert_crawl_substate_index++;
	if(level.inert_crawl_substate_index >= level.inert_crawl_substates.size)
	{
		level.inert_crawl_substates = array_randomize(level.inert_crawl_substates);
		level.inert_crawl_substate_index = 0;
	}

	return substate;
}

//Function Number: 6
start_inert(in_place)
{
	self endon("death");
	if(IsDefined(self.is_inert) && self.is_inert)
	{
		self maps/mp/zombies/_zm_spawner::zombie_history("is_inert already set " + GetTime());
		return;
	}

	self.is_inert = 1;
	self notify("start_inert");
	self maps/mp/zombies/_zm_spawner::zombie_eye_glow_stop();
	self maps/mp/zombies/_zm_spawner::zombie_history("is_inert set " + GetTime());
	self playsound("zmb_zombie_go_inert");
	if(IsDefined(self.barricade_enter) && self.barricade_enter)
	{
		while(IsDefined(self.barricade_enter) && self.barricade_enter)
		{
			wait(0.1);
		}
	}
	else if(IsDefined(self.ai_state) && self.ai_state == "zombie_goto_entrance")
	{
		self notify("stop_zombie_goto_entrance");
		self maps/mp/zombies/_zm_spawner::reset_attack_spot();
	}

	if(IsDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)
	{
		self notify("stop_find_flesh");
		self notify("zombie_acquire_enemy");
	}
	else
	{
		in_place = 1;
	}

	if(IsDefined(self.in_the_ground) && self.in_the_ground)
	{
		self waittill("risen",find_flesh_struct_string);
		if(self maps/mp/zombies/_zm_spawner::should_skip_teardown(find_flesh_struct_string))
		{
			if(!(IsDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area))
			{
				self waittill("completed_emerging_into_playable_area");
			}

			self notify("stop_find_flesh");
			self notify("zombie_acquire_enemy");
		}
	}

	if(IsDefined(self.is_traversing) && self.is_traversing)
	{
		while(self isinscriptedstate())
		{
			wait(0.1);
		}
	}

	if(IsDefined(self.doing_equipment_attack) && self.doing_equipment_attack)
	{
		self stopanimscripted();
	}

	if(IsDefined(self.inert_delay))
	{
		self [[ self.inert_delay ]]();
		self maps/mp/zombies/_zm_spawner::zombie_history("inert_delay done " + GetTime());
	}

	self inert_think(in_place);
}

//Function Number: 7
inert_think(in_place)
{
	self endon("death");
	self.ignoreall = 1;
	self animmode("normal");
	if(self.has_legs)
	{
		if(IsDefined(in_place) && in_place)
		{
			self setgoalpos(self.origin);
			if(randomint(100) > 50)
			{
				self maps/mp/zombies/_zm_spawner::zombie_history("inert 1 " + GetTime());
				self setanimstatefromasd("zm_inert","inert1");
			}
			else
			{
				self maps/mp/zombies/_zm_spawner::zombie_history("inert 2 " + GetTime());
				self setanimstatefromasd("zm_inert","inert2");
			}

			self.in_place = 1;
		}
		else
		{
			substate = get_inert_substate();
			if(IsDefined(level.inert_substate_override))
			{
				substate = self [[ level.inert_substate_override ]](substate);
			}

			self setanimstatefromasd("zm_inert",substate);
			self maps/mp/zombies/_zm_spawner::zombie_history("zm_inert ASD " + GetTime());
			if(substate == "inert3" || substate == "inert4" || substate == "inert5" || substate == "inert6")
			{
				self thread inert_watch_goal();
			}
			else
			{
				self.in_place = 1;
			}
		}
	}
	else
	{
		self setanimstatefromasd("zm_inert_crawl",get_inert_crawl_substate());
		self maps/mp/zombies/_zm_spawner::zombie_history("zm_inert_crawl ASD " + GetTime());
	}

	self thread inert_wakeup();
	self waittill("stop_zombie_inert");
	self maps/mp/zombies/_zm_spawner::zombie_history("stop_zombie_inert " + GetTime());
	self playsound("zmb_zombie_end_inert");
	self inert_transition();
	self maps/mp/zombies/_zm_spawner::zombie_history("inert transition done");
	if(IsDefined(self.ai_state) && self.ai_state == "zombie_goto_entrance")
	{
		self thread maps/mp/zombies/_zm_spawner::zombie_goto_entrance(self.first_node);
	}

	if(IsDefined(self.inert_wakeup_override))
	{
		self [[ self.inert_wakeup_override ]]();
	}
	else if(IsDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)
	{
		self.ignoreall = 0;
		if(IsDefined(level.ignore_find_flesh) && !self [[ level.ignore_find_flesh ]]())
		{
			self thread maps/mp/zombies/_zm_ai_basic::find_flesh();
		}
	}

	self.becoming_inert = undefined;
	self.is_inert = undefined;
	self.in_place = undefined;
	self maps/mp/animscripts/zm_run::needsupdate();
	self maps/mp/zombies/_zm_spawner::zombie_history("is_inert cleared " + GetTime());
}

//Function Number: 8
inert_watch_goal()
{
	self endon("death");
	self endon("stop_zombie_inert");
	while(1)
	{
		self waittill("goal");
		locs = array_randomize(level.enemy_dog_locations);
		foreach(loc in locs)
		{
			dist_sq = distancesquared(self.origin,loc.origin);
			if(dist_sq > 90000)
			{
				self setgoalpos(loc.origin);
			}
			else
			{
			}
		}

		if(locs.size > 0)
		{
			self setgoalpos(locs[0].origin);
		}
	}
}

//Function Number: 9
inert_wakeup()
{
	self endon("death");
	self endon("stop_zombie_inert");
	wait(0.1);
	self thread inert_damage();
	self thread inert_bump();
	while(1)
	{
		current_time = GetTime();
		players = get_players();
		foreach(player in players)
		{
			dist_sq = distancesquared(self.origin,player.origin);
			if(dist_sq < 4096)
			{
				self stop_inert();
				return;
			}

			if(dist_sq < 360000)
			{
				if(player issprinting())
				{
					self stop_inert();
					return;
				}
			}

			if(dist_sq < 5760000)
			{
				if(current_time - player.lastfiretime < 100)
				{
					self stop_inert();
					return;
				}
			}
		}

		wait(0.1);
	}
}

//Function Number: 10
inert_bump()
{
	self endon("death");
	self endon("stop_zombie_inert");
	while(1)
	{
		zombies = getaiarray(level.zombie_team);
		foreach(zombie in zombies)
		{
			if(zombie == self)
			{
			}
			else if(IsDefined(zombie.is_inert) && zombie.is_inert)
			{
			}
			else if(IsDefined(zombie.becoming_inert) && zombie.becoming_inert)
			{
			}
			else
			{
				dist_sq = distancesquared(self.origin,zombie.origin);
				if(dist_sq < 1296)
				{
					self stop_inert();
					return;
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 11
inert_damage()
{
	self endon("death");
	self endon("stop_zombie_inert");
	while(1)
	{
		self waittill("damage",amount,inflictor,direction,point,type,tagname,modelname,partname,weaponname,idflags);
		if(weaponname == "emp_grenade_zm")
		{
			continue;
		}

		if(IsDefined(inflictor))
		{
			if(IsDefined(inflictor._trap_type) && inflictor._trap_type == "fire")
			{
				continue;
			}
		}
	}

	self stop_inert();
}

//Function Number: 12
grenade_watcher(grenade)
{
	grenade waittill("explode",grenade_origin);
	zombies = get_array_of_closest(grenade_origin,get_round_enemy_array(),undefined,undefined,2400);
	if(!(IsDefined(zombies)))
	{
		return;
	}

	foreach(zombie in zombies)
	{
		zombie stop_inert();
	}
}

//Function Number: 13
stop_inert()
{
	self notify("stop_zombie_inert");
}

//Function Number: 14
inert_transition()
{
	self endon("death");
	self endon("stop_zombie_inert_transition");
	trans_num = 4;
	trans_set = level.inert_trans_walk;
	animstate = "zm_inert_trans";
	if(!(self.has_legs))
	{
		trans_num = 1;
		trans_set = level.inert_crawl_trans_walk;
		animstate = "zm_inert_crawl_trans";
	}

	if(self.zombie_move_speed == "run")
	{
		if(self.has_legs)
		{
			trans_set = level.inert_trans_run;
		}
		else
		{
			trans_set = level.inert_crawl_trans_run;
		}

		trans_num = 2;
	}
	else if(self.zombie_move_speed == "sprint")
	{
		if(self.has_legs)
		{
			trans_set = level.inert_trans_sprint;
		}
		else
		{
			trans_set = level.inert_crawl_trans_sprint;
		}

		trans_num = 2;
	}

	self thread inert_eye_glow();
	self setanimstatefromasd(animstate,trans_set[randomint(trans_num)]);
	self maps/mp/zombies/_zm_spawner::zombie_history("inert_trans_anim " + GetTime());
	maps/mp/animscripts/zm_shared::donotetracks("inert_trans_anim");
}

//Function Number: 15
inert_eye_glow()
{
	self endon("death");
	if(1)
	{
		self waittill("inert_trans_anim",note);
		if(note == "end")
		{
			return;
		}
		else if(note == "zmb_awaken")
		{
			self maps/mp/zombies/_zm_spawner::zombie_eye_glow();
		}
	}
}