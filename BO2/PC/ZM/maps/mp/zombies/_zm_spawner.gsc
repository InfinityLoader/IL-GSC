/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_spawner.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 93
 * Decompile Time: 65 ms
 * Timestamp: 10/28/2023 12:11:55 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/animscripts/zm_death;
#include maps/mp/animscripts/zm_run;
#include maps/mp/animscripts/zm_shared;
#include maps/mp/animscripts/zm_utility;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_ai_basic;
#include maps/mp/zombies/_zm_ai_faller;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_blockers;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_net;
#include maps/mp/zombies/_zm_pers_upgrades;
#include maps/mp/zombies/_zm_pers_upgrades_functions;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/zombies/_zm_score;
#include maps/mp/zombies/_zm_spawner;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;

//Function Number: 1
init()
{
	level._contextual_grab_lerp_time = 0.3;
	level.zombie_spawners = getentarray("zombie_spawner","script_noteworthy");
	if(IsDefined(level.use_multiple_spawns) && level.use_multiple_spawns)
	{
		level.zombie_spawn = [];
		for(i = 0;i < level.zombie_spawners.size;i++)
		{
			if(IsDefined(level.zombie_spawners[i].script_int))
			{
				int = level.zombie_spawners[i].script_int;
				if(!(IsDefined(level.zombie_spawn[int])))
				{
					level.zombie_spawn[int] = [];
				}

				level.zombie_spawn[int][level.zombie_spawn[int].size] = level.zombie_spawners[i];
			}
		}
	}

	precachemodel("p6_anim_zm_barricade_board_01_upgrade");
	precachemodel("p6_anim_zm_barricade_board_02_upgrade");
	precachemodel("p6_anim_zm_barricade_board_03_upgrade");
	precachemodel("p6_anim_zm_barricade_board_04_upgrade");
	precachemodel("p6_anim_zm_barricade_board_05_upgrade");
	precachemodel("p6_anim_zm_barricade_board_06_upgrade");
	if(IsDefined(level.ignore_spawner_func))
	{
		for(i = 0;i < level.zombie_spawners.size;i++)
		{
			ignore = [[ level.ignore_spawner_func ]](level.zombie_spawners[i]);
			if(ignore)
			{
				arrayremovevalue(level.zombie_spawners,level.zombie_spawners[i]);
			}
		}
	}

	gametype = GetDvar(#"41651E");
	if(!(IsDefined(level.attack_player_thru_boards_range)))
	{
		level.attack_player_thru_boards_range = 109.8;
	}

	if(IsDefined(level._game_module_custom_spawn_init_func))
	{
		[[ level._game_module_custom_spawn_init_func ]]();
	}

	registerclientfield("actor","zombie_has_eyes",1,1,"int");
	registerclientfield("actor","zombie_ragdoll_explode",1,1,"int");
	registerclientfield("actor","zombie_gut_explosion",9000,1,"int");
}

//Function Number: 2
add_cusom_zombie_spawn_logic(func)
{
	if(!(IsDefined(level._zombie_custom_spawn_logic)))
	{
		level._zombie_custom_spawn_logic = [];
	}

	level._zombie_custom_spawn_logic[level._zombie_custom_spawn_logic.size] = func;
}

//Function Number: 3
player_attacks_enemy(player,amount,type,point)
{
	team = undefined;
	if(IsDefined(self._race_team))
	{
		team = self._race_team;
	}

	if(!(isads(player)))
	{
		[[ level.global_damage_func ]](type,self.damagelocation,point,player,amount,team);
		return 0;
	}

	if(!(bullet_attack(type)))
	{
		[[ level.global_damage_func ]](type,self.damagelocation,point,player,amount,team);
		return 0;
	}

	[[ level.global_damage_func_ads ]](type,self.damagelocation,point,player,amount,team);
	return 1;
}

//Function Number: 4
player_attacker(attacker)
{
	if(isplayer(attacker))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
enemy_death_detection()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",amount,attacker,direction_vec,point,type);
		if(!(IsDefined(amount)))
		{
			continue;
		}

		if(!isalive(self) || self.delayeddeath)
		{
			return;
		}

		if(!(player_attacker(attacker)))
		{
			continue;
		}

		self.has_been_damaged_by_player = 1;
		self player_attacks_enemy(attacker,amount,type,point);
	}
}

//Function Number: 6
is_spawner_targeted_by_blocker(ent)
{
	if(IsDefined(ent.targetname))
	{
		targeters = getentarray(ent.targetname,"target");
		for(i = 0;i < targeters.size;i++)
		{
			if(targeters[i].targetname == "zombie_door" || targeters[i].targetname == "zombie_debris")
			{
				return 1;
			}

			result = is_spawner_targeted_by_blocker(targeters[i]);
			if(result)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 7
add_custom_zombie_spawn_logic(func)
{
	if(!(IsDefined(level._zombie_custom_spawn_logic)))
	{
		level._zombie_custom_spawn_logic = [];
	}

	level._zombie_custom_spawn_logic[level._zombie_custom_spawn_logic.size] = func;
}

//Function Number: 8
zombie_spawn_init(animname_set)
{
	if(!(IsDefined(animname_set)))
	{
		animname_set = 0;
	}

	self.targetname = "zombie";
	self.script_noteworthy = undefined;
	recalc_zombie_array();
	if(!(animname_set))
	{
		self.animname = "zombie";
	}

	if(IsDefined(get_gamemode_var("pre_init_zombie_spawn_func")))
	{
		self [[ get_gamemode_var("pre_init_zombie_spawn_func") ]]();
	}

	self thread play_ambient_zombie_vocals();
	self.zmb_vocals_attack = "zmb_vocals_zombie_attack";
	self.ignoreall = 1;
	self.ignoreme = 1;
	self.allowdeath = 1;
	self.force_gib = 1;
	self.is_zombie = 1;
	self.has_legs = 1;
	self allowedstances("stand");
	self.zombie_damaged_by_bar_knockdown = 0;
	self.gibbed = 0;
	self.head_gibbed = 0;
	self setphysparams(15,0,72);
	self.disablearrivals = 1;
	self.disableexits = 1;
	self.grenadeawareness = 0;
	self.badplaceawareness = 0;
	self.ignoresuppression = 1;
	self.suppressionthreshold = 1;
	self.nododgemove = 1;
	self.dontshootwhilemoving = 1;
	self.pathenemylookahead = 0;
	self.badplaceawareness = 0;
	self.chatinitialized = 0;
	self.a.disablepain = 1;
	self disable_react();
	if(IsDefined(level.zombie_health))
	{
		self.maxhealth = level.zombie_health;
		if(IsDefined(level.zombie_respawned_health) && level.zombie_respawned_health.size > 0)
		{
			self.health = level.zombie_respawned_health[0];
			arrayremovevalue(level.zombie_respawned_health,level.zombie_respawned_health[0]);
		}
		else
		{
			self.health = level.zombie_health;
		}
	}
	else
	{
		self.maxhealth = level.zombie_vars["zombie_health_start"];
		self.health = self.maxhealth;
	}

	self.freezegun_damage = 0;
	self.dropweapon = 0;
	level thread zombie_death_event(self);
	self init_zombie_run_cycle();
	self thread zombie_think();
	self thread zombie_gib_on_damage();
	self thread zombie_damage_failsafe();
	self thread enemy_death_detection();
	if(IsDefined(level._zombie_custom_spawn_logic))
	{
		if(isarray(level._zombie_custom_spawn_logic))
		{
			for(i = 0;i < level._zombie_custom_spawn_logic.size;i++)
			{
				self thread [[ level._zombie_custom_spawn_logic[i] ]]();
			}
		}
		else
		{
			self thread [[ level._zombie_custom_spawn_logic ]]();
		}
	}

	if(!IsDefined(self.no_eye_glow) || !self.no_eye_glow)
	{
		if(!(IsDefined(self.is_inert) && self.is_inert))
		{
			self thread delayed_zombie_eye_glow();
		}
	}

	self.deathfunction = ::zombie_death_animscript;
	self.flame_damage_time = 0;
	self.meleedamage = 60;
	self.no_powerups = 1;
	self zombie_history("zombie_spawn_init -> Spawned = " + self.origin);
	self.thundergun_knockdown_func = level.basic_zombie_thundergun_knockdown;
	self.tesla_head_gib_func = ::zombie_tesla_head_gib;
	self.team = level.zombie_team;
	if(IsDefined(level.achievement_monitor_func))
	{
		self [[ level.achievement_monitor_func ]]();
	}

	if(IsDefined(get_gamemode_var("post_init_zombie_spawn_func")))
	{
		self [[ get_gamemode_var("post_init_zombie_spawn_func") ]]();
	}

	if(IsDefined(level.zombie_init_done))
	{
		self [[ level.zombie_init_done ]]();
	}

	self.zombie_init_done = 1;
	self notify("zombie_init_done");
}

//Function Number: 9
delayed_zombie_eye_glow()
{
	self endon("zombie_delete");
	if((IsDefined(self.in_the_ground) && self.in_the_ground) || IsDefined(self.in_the_ceiling) && self.in_the_ceiling)
	{
		while(!(IsDefined(self.create_eyes)))
		{
			wait(0.1);
		}
	}
	else
	{
		wait(0.5);
	}

	self zombie_eye_glow();
}

//Function Number: 10
zombie_damage_failsafe()
{
	self endon("death");
	for(continue_failsafe_damage = 0;1;continue_failsafe_damage = 0)
	{
		wait(0.5);
		if(!IsDefined(self.enemy) || !isplayer(self.enemy))
		{
			continue;
		}

		if(self istouching(self.enemy))
		{
			old_org = self.origin;
			if(!(continue_failsafe_damage))
			{
				wait(5);
			}

			if(!IsDefined(self.enemy) || !isplayer(self.enemy) || self.enemy hasperk("specialty_armorvest"))
			{
				continue;
			}

			if(self istouching(self.enemy) && !self.enemy maps/mp/zombies/_zm_laststand::player_is_in_laststand() && isalive(self.enemy))
			{
				if(distancesquared(old_org,self.origin) < 3600)
				{
					self.enemy dodamage(self.enemy.health + 1000,self.enemy.origin,self,self,"none","MOD_RIFLE_BULLET");
					continue_failsafe_damage = 1;
				}
			}

			continue;
		}
	}
}

//Function Number: 11
should_skip_teardown(find_flesh_struct_string)
{
	if(IsDefined(find_flesh_struct_string) && find_flesh_struct_string == "find_flesh")
	{
		return 1;
	}

	if(IsDefined(self.script_string) && self.script_string == "zombie_chaser")
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
zombie_think()
{
	self endon("death");
/#
	assert(!self.isdog);
#/
	self.ai_state = "zombie_think";
	find_flesh_struct_string = undefined;
	if(IsDefined(level.zombie_custom_think_logic))
	{
		shouldwait = self [[ level.zombie_custom_think_logic ]]();
		if(shouldwait)
		{
			self waittill("zombie_custom_think_done",find_flesh_struct_string);
		}
	}
	else if(IsDefined(self.start_inert) && self.start_inert)
	{
		find_flesh_struct_string = "find_flesh";
	}
	else
	{
		if(IsDefined(self.custom_location))
		{
			self thread [[ self.custom_location ]]();
		}
		else
		{
			self thread do_zombie_spawn();
		}

		self waittill("risen",find_flesh_struct_string);
	}

	node = undefined;
	desired_nodes = [];
	self.entrance_nodes = [];
	if(IsDefined(level.max_barrier_search_dist_override))
	{
		max_dist = level.max_barrier_search_dist_override;
	}
	else
	{
		max_dist = 500;
	}

	if(!IsDefined(find_flesh_struct_string) && IsDefined(self.target) && self.target != "")
	{
		desired_origin = get_desired_origin();
/#
		assert(IsDefined(desired_origin),"Spawner @ " + self.origin + " has a .target but did not find a target");
#/
		origin = desired_origin;
		node = getclosest(origin,level.exterior_goals);
		self.entrance_nodes[self.entrance_nodes.size] = node;
		self zombie_history("zombie_think -> #1 entrance (script_forcegoal) origin = " + self.entrance_nodes[0].origin);
	}
	else if(self should_skip_teardown(find_flesh_struct_string))
	{
		self zombie_setup_attack_properties();
		if(IsDefined(self.target))
		{
			end_at_node = getnode(self.target,"targetname");
			if(IsDefined(end_at_node))
			{
				self setgoalnode(end_at_node);
				self waittill("goal");
			}
		}

		if(IsDefined(self.start_inert) && self.start_inert)
		{
			self thread maps/mp/zombies/_zm_ai_basic::start_inert(1);
			self zombie_complete_emerging_into_playable_area();
		}
		else
		{
			self thread maps/mp/zombies/_zm_ai_basic::find_flesh();
			self thread zombie_entered_playable();
		}

		return;
	}
	else if(IsDefined(find_flesh_struct_string))
	{
/#
/#
		assert(IsDefined(find_flesh_struct_string));
#/
#/
		for(i = 0;i < level.exterior_goals.size;i++)
		{
			if(IsDefined(level.exterior_goals[i].script_string) && level.exterior_goals[i].script_string == find_flesh_struct_string)
			{
				node = level.exterior_goals[i];
				break;
			}
		}

		self.entrance_nodes[self.entrance_nodes.size] = node;
		self zombie_history("zombie_think -> #1 entrance origin = " + node.origin);
		self thread zombie_assure_node();
	}
	else
	{
		origin = self.origin;
		desired_origin = get_desired_origin();
		if(IsDefined(desired_origin))
		{
			origin = desired_origin;
		}

		nodes = get_array_of_closest(origin,level.exterior_goals,undefined,3);
		desired_nodes[0] = nodes[0];
		prev_dist = distance(self.origin,nodes[0].origin);
		for(i = 1;i < nodes.size;i++)
		{
			dist = distance(self.origin,nodes[i].origin);
			if(dist - prev_dist > max_dist)
			{
				break;
			}

			prev_dist = dist;
			desired_nodes[i] = nodes[i];
		}

		node = desired_nodes[0];
		if(desired_nodes.size > 1)
		{
			node = desired_nodes[randomint(desired_nodes.size)];
		}

		self.entrance_nodes = desired_nodes;
		self zombie_history("zombie_think -> #1 entrance origin = " + node.origin);
		self thread zombie_assure_node();
	}

/#
	assert(IsDefined(node),"Did not find a node!!! [Should not see this!]");
#/
	level thread draw_line_ent_to_pos(self,node.origin,"goal");
	self.first_node = node;
	self thread zombie_goto_entrance(node);
}

//Function Number: 13
zombie_entered_playable()
{
	self endon("death");
	if(!(IsDefined(level.playable_areas)))
	{
		level.playable_areas = getentarray("player_volume","script_noteworthy");
	}

	while(1)
	{
		foreach(area in level.playable_areas)
		{
			if(self istouching(area))
			{
				self zombie_complete_emerging_into_playable_area();
				return;
			}
		}

		wait(1);
	}
}

//Function Number: 14
get_desired_origin()
{
	if(IsDefined(self.target))
	{
		ent = getent(self.target,"targetname");
		if(!(IsDefined(ent)))
		{
			ent = getstruct(self.target,"targetname");
		}

		if(!(IsDefined(ent)))
		{
			ent = getnode(self.target,"targetname");
		}

/#
		assert(IsDefined(ent),"Cannot find the targeted ent/node/struct, \" + self.target + "\" at " + self.origin);
#/
		return ent.origin;
	}
}

//Function Number: 15
zombie_goto_entrance(node,endon_bad_path)
{
/#
	assert(!self.isdog);
#/
	self endon("death");
	self endon("stop_zombie_goto_entrance");
	level endon("intermission");
	self.ai_state = "zombie_goto_entrance";
	if(IsDefined(endon_bad_path) && endon_bad_path)
	{
		self endon("bad_path");
	}

	self zombie_history("zombie_goto_entrance -> start goto entrance " + node.origin);
	self.got_to_entrance = 0;
	self.goalradius = 128;
	self setgoalpos(node.origin);
	self waittill("goal");
	self.got_to_entrance = 1;
	self zombie_history("zombie_goto_entrance -> reached goto entrance " + node.origin);
	self tear_into_building();
	if(IsDefined(level.pre_aggro_pathfinding_func))
	{
		self [[ level.pre_aggro_pathfinding_func ]]();
	}

	barrier_pos = [];
	barrier_pos[0] = "m";
	barrier_pos[1] = "r";
	barrier_pos[2] = "l";
	self.barricade_enter = 1;
	animstate = maps/mp/animscripts/zm_utility::append_missing_legs_suffix("zm_barricade_enter");
	substate = "barrier_" + self.zombie_move_speed + "_" + barrier_pos[self.attacking_spot_index];
	self animscripted(self.first_node.zbarrier.origin,self.first_node.zbarrier.angles,animstate,substate);
	maps/mp/animscripts/zm_shared::donotetracks("barricade_enter_anim");
	self zombie_setup_attack_properties();
	self thread maps/mp/zombies/_zm_ai_basic::find_flesh();
	self.pathenemyfightdist = 4;
	self zombie_complete_emerging_into_playable_area();
	self.pathenemyfightdist = 64;
	self.barricade_enter = 0;
}

//Function Number: 16
zombie_assure_node()
{
	self endon("death");
	self endon("goal");
	level endon("intermission");
	start_pos = self.origin;
	if(IsDefined(self.entrance_nodes))
	{
		for(i = 0;i < self.entrance_nodes.size;i++)
		{
			if(self zombie_bad_path())
			{
				self zombie_history("zombie_assure_node -> assigned assured node = " + self.entrance_nodes[i].origin);
/#
				println("^1Zombie @ " + self.origin + " did not move for 1 second. Going to next closest node @ " + self.entrance_nodes[i].origin);
#/
				level thread draw_line_ent_to_pos(self,self.entrance_nodes[i].origin,"goal");
				self.first_node = self.entrance_nodes[i];
				self setgoalpos(self.entrance_nodes[i].origin);
			}
			else
			{
				return;
			}
		}
	}

	wait(2);
	nodes = get_array_of_closest(self.origin,level.exterior_goals,undefined,20);
	if(IsDefined(nodes))
	{
		self.entrance_nodes = nodes;
		for(i = 0;i < self.entrance_nodes.size;i++)
		{
			if(self zombie_bad_path())
			{
				self zombie_history("zombie_assure_node -> assigned assured node = " + self.entrance_nodes[i].origin);
/#
				println("^1Zombie @ " + self.origin + " did not move for 1 second. Going to next closest node @ " + self.entrance_nodes[i].origin);
#/
				level thread draw_line_ent_to_pos(self,self.entrance_nodes[i].origin,"goal");
				self.first_node = self.entrance_nodes[i];
				self setgoalpos(self.entrance_nodes[i].origin);
			}
			else
			{
				return;
			}
		}
	}

	self zombie_history("zombie_assure_node -> failed to find a good entrance point");
	wait(20);
	self dodamage(self.health + 10,self.origin);
	level.zombies_timeout_spawn++;
}

//Function Number: 17
zombie_bad_path()
{
	self endon("death");
	self endon("goal");
	self thread zombie_bad_path_notify();
	self thread zombie_bad_path_timeout();
	self.zombie_bad_path = undefined;
	while(!(IsDefined(self.zombie_bad_path)))
	{
		wait(0.05);
	}

	self notify("stop_zombie_bad_path");
	return self.zombie_bad_path;
}

//Function Number: 18
zombie_bad_path_notify()
{
	self endon("death");
	self endon("stop_zombie_bad_path");
	self waittill("bad_path");
	self.zombie_bad_path = 1;
}

//Function Number: 19
zombie_bad_path_timeout()
{
	self endon("death");
	self endon("stop_zombie_bad_path");
	wait(2);
	self.zombie_bad_path = 0;
}

//Function Number: 20
tear_into_building()
{
	self endon("death");
	self endon("teleporting");
	self zombie_history("tear_into_building -> start");
	while(1)
	{
		if(IsDefined(self.first_node.script_noteworthy))
		{
			if(self.first_node.script_noteworthy == "no_blocker")
			{
				return;
			}
		}

		if(!(IsDefined(self.first_node.target)))
		{
			return;
		}

		if(all_chunks_destroyed(self.first_node,self.first_node.barrier_chunks))
		{
			self zombie_history("tear_into_building -> all chunks destroyed");
		}

		if(!(get_attack_spot(self.first_node)))
		{
			self zombie_history("tear_into_building -> Could not find an attack spot");
			self thread do_a_taunt();
			wait(0.5);
			continue;
		}

		self.goalradius = 2;
		if(IsDefined(level.tear_into_position))
		{
			self [[ level.tear_into_position ]]();
		}
		else
		{
			angles = self.first_node.zbarrier.angles;
			self setgoalpos(self.attacking_spot,angles);
		}

		self waittill("goal");
		if(IsDefined(level.tear_into_wait))
		{
			self [[ level.tear_into_wait ]]();
		}
		else
		{
			self waittill_notify_or_timeout("orientdone",1);
		}

		self zombie_history("tear_into_building -> Reach position and orientated");
		if(all_chunks_destroyed(self.first_node,self.first_node.barrier_chunks))
		{
			self zombie_history("tear_into_building -> all chunks destroyed");
			for(i = 0;i < self.first_node.attack_spots_taken.size;i++)
			{
				self.first_node.attack_spots_taken[i] = 0;
			}

			return;
		}

		while(1)
		{
			if(IsDefined(self.zombie_board_tear_down_callback))
			{
				self [[ self.zombie_board_tear_down_callback ]]();
			}

			chunk = get_closest_non_destroyed_chunk(self.origin,self.first_node,self.first_node.barrier_chunks);
			if(!(IsDefined(chunk)))
			{
				if(!(all_chunks_destroyed(self.first_node,self.first_node.barrier_chunks)))
				{
					attack = self should_attack_player_thru_boards();
					if(IsDefined(attack) && !attack && self.has_legs)
					{
						self do_a_taunt();
						continue;
					}

					wait(0.1);
					continue;
				}

				for(i = 0;i < self.first_node.attack_spots_taken.size;i++)
				{
					self.first_node.attack_spots_taken[i] = 0;
				}

				return;
			}

			self zombie_history("tear_into_building -> animating");
			self.first_node.zbarrier setzbarrierpiecestate(chunk,"targetted_by_zombie");
			self.first_node thread check_zbarrier_piece_for_zombie_inert(chunk,self.first_node.zbarrier,self);
			self.first_node thread check_zbarrier_piece_for_zombie_death(chunk,self.first_node.zbarrier,self);
			self thread maps/mp/zombies/_zm_audio::do_zombies_playvocals("teardown",self.animname);
			if(IsDefined(level.zbarrier_override_tear_in))
			{
				animstatebase = self [[ level.zbarrier_override_tear_in ]](chunk);
			}
			else
			{
				animstatebase = self.first_node.zbarrier getzbarrierpieceanimstate(chunk);
			}

			animsubstate = "spot_" + self.attacking_spot_index + "_piece_" + self.first_node.zbarrier getzbarrierpieceanimsubstate(chunk);
			anim_sub_index = self getanimsubstatefromasd(animstatebase + "_in",animsubstate);
			self animscripted(self.first_node.zbarrier.origin,self.first_node.zbarrier.angles,maps/mp/animscripts/zm_utility::append_missing_legs_suffix(animstatebase + "_in"),anim_sub_index);
			self zombie_tear_notetracks("tear_anim",chunk,self.first_node);
			while(0 < self.first_node.zbarrier.chunk_health[chunk])
			{
				self animscripted(self.first_node.zbarrier.origin,self.first_node.zbarrier.angles,maps/mp/animscripts/zm_utility::append_missing_legs_suffix(animstatebase + "_loop"),anim_sub_index);
				self zombie_tear_notetracks("tear_anim",chunk,self.first_node);
				self.first_node.zbarrier.chunk_health[chunk]--;
			}

			self animscripted(self.first_node.zbarrier.origin,self.first_node.zbarrier.angles,maps/mp/animscripts/zm_utility::append_missing_legs_suffix(animstatebase + "_out"),anim_sub_index);
			self zombie_tear_notetracks("tear_anim",chunk,self.first_node);
			self.lastchunk_destroy_time = GetTime();
			attack = self should_attack_player_thru_boards();
			if(IsDefined(attack) && !attack && self.has_legs)
			{
				self do_a_taunt();
			}

			if(all_chunks_destroyed(self.first_node,self.first_node.barrier_chunks))
			{
				for(i = 0;i < self.first_node.attack_spots_taken.size;i++)
				{
					self.first_node.attack_spots_taken[i] = 0;
				}

				level notify("last_board_torn",self.first_node.zbarrier.origin);
				return;
			}
		}

		self reset_attack_spot();
	}
}

//Function Number: 21
do_a_taunt()
{
	self endon("death");
	if(!(self.has_legs))
	{
		return 0;
	}

	if(!(self.first_node.zbarrier zbarriersupportszombietaunts()))
	{
		return;
	}

	self.old_origin = self.origin;
	if(GetDvar(#"6896A7C3") == "")
	{
		setdvar("zombie_taunt_freq","5");
	}

	freq = GetDvarInt(#"6896A7C3");
	if(freq >= randomint(100))
	{
		self thread maps/mp/zombies/_zm_audio::do_zombies_playvocals("taunt",self.animname);
		tauntstate = "zm_taunt";
		if(IsDefined(self.first_node.zbarrier) && self.first_node.zbarrier getzbarriertauntanimstate() != "")
		{
			tauntstate = self.first_node.zbarrier getzbarriertauntanimstate();
		}

		self animscripted(self.origin,self.angles,tauntstate);
		self taunt_notetracks("taunt_anim");
	}
}

//Function Number: 22
taunt_notetracks(msg)
{
	self endon("death");
	while(1)
	{
		self waittill(msg,notetrack);
		if(notetrack == "end")
		{
			self forceteleport(self.old_origin);
			return;
		}
	}
}

//Function Number: 23
should_attack_player_thru_boards()
{
	if(!(self.has_legs))
	{
		return 0;
	}

	if(IsDefined(self.first_node.zbarrier))
	{
		if(!(self.first_node.zbarrier zbarriersupportszombiereachthroughattacks()))
		{
			return 0;
		}
	}

	if(GetDvar(#"4A4203B1") == "")
	{
		setdvar("zombie_reachin_freq","50");
	}

	freq = GetDvarInt(#"4A4203B1");
	players = get_players();
	attack = 0;
	self.player_targets = [];
	for(i = 0;i < players.size;i++)
	{
		if(isalive(players[i]) && !IsDefined(players[i].revivetrigger) && distance2d(self.origin,players[i].origin) <= level.attack_player_thru_boards_range && !IsDefined(players[i].zombie_vars["zombie_powerup_zombie_blood_on"]) && players[i].zombie_vars["zombie_powerup_zombie_blood_on"])
		{
			self.player_targets[self.player_targets.size] = players[i];
			attack = 1;
		}
	}

	if(!attack || freq < randomint(100))
	{
		return 0;
	}

	self.old_origin = self.origin;
	attackanimstate = "zm_window_melee";
	if(IsDefined(self.first_node.zbarrier) && self.first_node.zbarrier getzbarrierreachthroughattackanimstate() != "")
	{
		attackanimstate = self.first_node.zbarrier getzbarrierreachthroughattackanimstate();
	}

	self thread maps/mp/zombies/_zm_audio::do_zombies_playvocals("attack",self.animname);
	self animscripted(self.origin,self.angles,attackanimstate,self.attacking_spot_index - 1);
	self window_notetracks("window_melee_anim");
	return 1;
}

//Function Number: 24
window_notetracks(msg)
{
	self endon("death");
	while(1)
	{
		self waittill(msg,notetrack);
		if(notetrack == "end")
		{
			self teleport(self.old_origin);
			return;
		}

		if(notetrack == "fire")
		{
			if(self.ignoreall)
			{
				self.ignoreall = 0;
			}

			if(IsDefined(self.first_node))
			{
				_melee_dist_sq = 8100;
				if(IsDefined(level.attack_player_thru_boards_range))
				{
					_melee_dist_sq = level.attack_player_thru_boards_range * level.attack_player_thru_boards_range;
				}

				_trigger_dist_sq = 2601;
				for(i = 0;i < self.player_targets.size;i++)
				{
					playerdistsq = distance2dsquared(self.player_targets[i].origin,self.origin);
					heightdiff = Abs(self.player_targets[i].origin[2] - self.origin[2]);
					if(playerdistsq < _melee_dist_sq && heightdiff * heightdiff < _melee_dist_sq)
					{
						triggerdistsq = distance2dsquared(self.player_targets[i].origin,self.first_node.trigger_location.origin);
						heightdiff = Abs(self.player_targets[i].origin[2] - self.first_node.trigger_location.origin[2]);
						if(triggerdistsq < _trigger_dist_sq && heightdiff * heightdiff < _trigger_dist_sq)
						{
							self.player_targets[i] dodamage(self.meleedamage,self.origin,self,self,"none","MOD_MELEE");
							break;
						}
					}
				}

				continue;
			}

			self melee();
		}
	}
}

//Function Number: 25
reset_attack_spot()
{
	if(IsDefined(self.attacking_node))
	{
		node = self.attacking_node;
		index = self.attacking_spot_index;
		node.attack_spots_taken[index] = 0;
		self.attacking_node = undefined;
		self.attacking_spot_index = undefined;
	}
}

//Function Number: 26
get_attack_spot(node)
{
	index = get_attack_spot_index(node);
	if(!(IsDefined(index)))
	{
		return 0;
	}

	self.attacking_node = node;
	self.attacking_spot_index = index;
	node.attack_spots_taken[index] = 1;
	self.attacking_spot = node.attack_spots[index];
	return 1;
}

//Function Number: 27
get_attack_spot_index(node)
{
	indexes = [];
	for(i = 0;i < node.attack_spots.size;i++)
	{
		if(!(node.attack_spots_taken[i]))
		{
			indexes[indexes.size] = i;
		}
	}

	if(indexes.size == 0)
	{
		return undefined;
	}

	return indexes[randomint(indexes.size)];
}

//Function Number: 28
zombie_tear_notetracks(msg,chunk,node)
{
	self endon("death");
	while(1)
	{
		self waittill(msg,notetrack);
		if(notetrack == "end")
		{
			return;
		}

		if(notetrack == "board" || notetrack == "destroy_piece" || notetrack == "bar")
		{
			if(IsDefined(level.zbarrier_zombie_tear_notetrack_override))
			{
				self thread [[ level.zbarrier_zombie_tear_notetrack_override ]](node,chunk);
			}

			node.zbarrier setzbarrierpiecestate(chunk,"opening");
		}
	}
}

//Function Number: 29
zombie_boardtear_offset_fx_horizontle(chunk,node)
{
	if(IsDefined(chunk.script_parameters) && chunk.script_parameters == "repair_board" || chunk.script_parameters == "board")
	{
		if(IsDefined(chunk.unbroken) && chunk.unbroken == 1)
		{
			if(IsDefined(chunk.material) && chunk.material == "glass")
			{
				playfx(level._effect["glass_break"],chunk.origin,node.angles);
				chunk.unbroken = 0;
			}
			else if(IsDefined(chunk.material) && chunk.material == "metal")
			{
				playfx(level._effect["fx_zombie_bar_break"],chunk.origin);
				chunk.unbroken = 0;
			}
			else if(IsDefined(chunk.material) && chunk.material == "rock")
			{
				if(IsDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
				{
					chunk setclientflag(level._zombie_scriptmover_flag_rock_fx);
				}
				else
				{
					playfx(level._effect["wall_break"],chunk.origin);
				}

				chunk.unbroken = 0;
			}
		}
	}

	if(IsDefined(chunk.script_parameters) && chunk.script_parameters == "barricade_vents")
	{
		if(IsDefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)
		{
			chunk setclientflag(level._zombie_scriptmover_flag_board_horizontal_fx);
		}
		else
		{
			playfx(level._effect["fx_zombie_bar_break"],chunk.origin);
		}
	}
	else if(IsDefined(chunk.material) && chunk.material == "rock")
	{
		if(IsDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
		{
			chunk setclientflag(level._zombie_scriptmover_flag_rock_fx);
		}
	}
	else if(IsDefined(level.use_clientside_board_fx))
	{
		chunk setclientflag(level._zombie_scriptmover_flag_board_horizontal_fx);
	}
	else
	{
		playfx(level._effect["wood_chunk_destory"],30 + VectorScale((0,0,1)));
		wait(randomfloatrange(0.2,0.4));
		playfx(level._effect["wood_chunk_destory"],30 + VectorScale((0,0,-1)));
	}
}

//Function Number: 30
zombie_boardtear_offset_fx_verticle(chunk,node)
{
	if(IsDefined(chunk.script_parameters) && chunk.script_parameters == "repair_board" || chunk.script_parameters == "board")
	{
		if(IsDefined(chunk.unbroken) && chunk.unbroken == 1)
		{
			if(IsDefined(chunk.material) && chunk.material == "glass")
			{
				playfx(level._effect["glass_break"],chunk.origin,node.angles);
				chunk.unbroken = 0;
			}
			else if(IsDefined(chunk.material) && chunk.material == "metal")
			{
				playfx(level._effect["fx_zombie_bar_break"],chunk.origin);
				chunk.unbroken = 0;
			}
			else if(IsDefined(chunk.material) && chunk.material == "rock")
			{
				if(IsDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
				{
					chunk setclientflag(level._zombie_scriptmover_flag_rock_fx);
				}
				else
				{
					playfx(level._effect["wall_break"],chunk.origin);
				}

				chunk.unbroken = 0;
			}
		}
	}

	if(IsDefined(chunk.script_parameters) && chunk.script_parameters == "barricade_vents")
	{
		if(IsDefined(level.use_clientside_board_fx))
		{
			chunk setclientflag(level._zombie_scriptmover_flag_board_vertical_fx);
		}
		else
		{
			playfx(level._effect["fx_zombie_bar_break"],chunk.origin);
		}
	}
	else if(IsDefined(chunk.material) && chunk.material == "rock")
	{
		if(IsDefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
		{
			chunk setclientflag(level._zombie_scriptmover_flag_rock_fx);
		}
	}
	else if(IsDefined(level.use_clientside_board_fx))
	{
		chunk setclientflag(level._zombie_scriptmover_flag_board_vertical_fx);
	}
	else
	{
		playfx(level._effect["wood_chunk_destory"],30 + VectorScale((1,0,0)));
		wait(randomfloatrange(0.2,0.4));
		playfx(level._effect["wood_chunk_destory"],30 + VectorScale((-1,0,0)));
	}
}

//Function Number: 31
zombie_bartear_offset_fx_verticle(chunk)
{
	if((IsDefined(chunk.script_parameters) && chunk.script_parameters == "bar") || chunk.script_noteworthy == "board")
	{
		possible_tag_array_1 = [];
		possible_tag_array_1[0] = "Tag_fx_top";
		possible_tag_array_1[1] = "";
		possible_tag_array_1[2] = "Tag_fx_top";
		possible_tag_array_1[3] = "";
		possible_tag_array_2 = [];
		possible_tag_array_2[0] = "";
		possible_tag_array_2[1] = "Tag_fx_bottom";
		possible_tag_array_2[2] = "";
		possible_tag_array_2[3] = "Tag_fx_bottom";
		possible_tag_array_2 = array_randomize(possible_tag_array_2);
		random_fx = [];
		random_fx[0] = level._effect["fx_zombie_bar_break"];
		random_fx[1] = level._effect["fx_zombie_bar_break_lite"];
		random_fx[2] = level._effect["fx_zombie_bar_break"];
		random_fx[3] = level._effect["fx_zombie_bar_break_lite"];
		random_fx = array_randomize(random_fx);
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
}

//Function Number: 32
zombie_bartear_offset_fx_horizontle(chunk)
{
	if((IsDefined(chunk.script_parameters) && chunk.script_parameters == "bar") || chunk.script_noteworthy == "board")
	{
		switch(randomint(10))
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
				playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_right");
				break;

			case "8":
				playfxontag(level._effect["fx_zombie_bar_break"],chunk,"Tag_fx_right");
				break;
		}
	}
}

//Function Number: 33
check_zbarrier_piece_for_zombie_inert(chunk_index,zbarrier,zombie)
{
	zombie endon("completed_emerging_into_playable_area");
	zombie waittill("stop_zombie_goto_entrance");
	if(zbarrier getzbarrierpiecestate(chunk_index) == "targetted_by_zombie")
	{
		zbarrier setzbarrierpiecestate(chunk_index,"closed");
	}
}

//Function Number: 34
check_zbarrier_piece_for_zombie_death(chunk_index,zbarrier,zombie)
{
	while(1)
	{
		if(zbarrier getzbarrierpiecestate(chunk_index) != "targetted_by_zombie")
		{
			return;
		}

		if(!IsDefined(zombie) || !isalive(zombie))
		{
			zbarrier setzbarrierpiecestate(chunk_index,"closed");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 35
check_for_zombie_death(zombie)
{
	self endon("destroyed");
	wait(2.5);
	self maps/mp/zombies/_zm_blockers::update_states("repaired");
}

//Function Number: 36
zombie_hat_gib(attacker,means_of_death)
{
	self endon("death");
	if(!(is_mature()))
	{
		return 0;
	}

	if(IsDefined(self.hat_gibbed) && self.hat_gibbed)
	{
		return;
	}

	if(!IsDefined(self.gibspawn5) || !IsDefined(self.gibspawntag5))
	{
		return;
	}

	self.hat_gibbed = 1;
	if(IsDefined(self.hatmodel))
	{
		self detach(self.hatmodel,"");
	}

	temp_array = [];
	temp_array[0] = level._zombie_gib_piece_index_hat;
	self gib("normal",temp_array);
	if(IsDefined(level.track_gibs))
	{
		level [[ level.track_gibs ]](self,temp_array);
	}
}

//Function Number: 37
zombie_head_gib(attacker,means_of_death)
{
	self endon("death");
	if(!(is_mature()))
	{
		return 0;
	}

	if(IsDefined(self.head_gibbed) && self.head_gibbed)
	{
		return;
	}

	self.head_gibbed = 1;
	self zombie_eye_glow_stop();
	size = self getattachsize();
	for(i = 0;i < size;i++)
	{
		model = self getattachmodelname(i);
		if(issubstr(model,"head"))
		{
			if(IsDefined(self.hatmodel))
			{
				self detach(self.hatmodel,"");
			}

			self detach(model,"");
			if(IsDefined(self.torsodmg5))
			{
				self attach(self.torsodmg5,"",1);
			}

			break;
		}
	}

	temp_array = [];
	temp_array[0] = level._zombie_gib_piece_index_head;
	if(!IsDefined(self.hat_gibbed) && self.hat_gibbed && IsDefined(self.gibspawn5) && IsDefined(self.gibspawntag5))
	{
		temp_array[1] = level._zombie_gib_piece_index_hat;
	}

	self.hat_gibbed = 1;
	self gib("normal",temp_array);
	if(IsDefined(level.track_gibs))
	{
		level [[ level.track_gibs ]](self,temp_array);
	}

	self thread damage_over_time(ceil(self.health * 0.2),1,attacker,means_of_death);
}

//Function Number: 38
damage_over_time(dmg,delay,attacker,means_of_death)
{
	self endon("death");
	self endon("exploding");
	if(!(isalive(self)))
	{
		return;
	}

	if(!(isplayer(attacker)))
	{
		attacker = self;
	}

	if(!(IsDefined(means_of_death)))
	{
		means_of_death = "MOD_UNKNOWN";
	}

	while(1)
	{
		if(IsDefined(delay))
		{
			wait(delay);
		}

		if(IsDefined(self))
		{
			self dodamage(dmg,self gettagorigin("j_neck"),attacker,self,self.damagelocation,means_of_death,0,self.damageweapon);
		}
	}
}

//Function Number: 39
head_should_gib(attacker,type,point)
{
	if(!(is_mature()))
	{
		return 0;
	}

	if(self.head_gibbed)
	{
		return 0;
	}

	if(!IsDefined(attacker) || !isplayer(attacker))
	{
		return 0;
	}

	weapon = attacker getcurrentweapon();
	if(type != "MOD_RIFLE_BULLET" && type != "MOD_PISTOL_BULLET")
	{
		if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH")
		{
			if(distance(point,self gettagorigin("j_head")) > 55)
			{
				return 0;
			}
			else
			{
				return 1;
			}
		}
		else if(type == "MOD_PROJECTILE")
		{
			if(distance(point,self gettagorigin("j_head")) > 10)
			{
				return 0;
			}
			else
			{
				return 1;
			}
		}
		else if(weaponclass(weapon) != "spread")
		{
			return 0;
		}
	}

	if(!(self maps/mp/animscripts/zm_utility::damagelocationisany("head","helmet","neck")))
	{
		return 0;
	}

	if(weapon == "none" || weapon == level.start_weapon || weaponisgasweapon(self.weapon))
	{
		return 0;
	}

	low_health_percent = self.health / self.maxhealth * 100;
	if(low_health_percent > 10)
	{
		self zombie_hat_gib(attacker,type);
		return 0;
	}

	return 1;
}

//Function Number: 40
headshot_blood_fx()
{
	if(!(IsDefined(self)))
	{
		return;
	}

	if(!(is_mature()))
	{
		return;
	}

	fxtag = "j_neck";
	fxorigin = self gettagorigin(fxtag);
	upvec = AnglesToUp(self gettagangles(fxtag));
	forwardvec = AnglesToForward(self gettagangles(fxtag));
	playfx(level._effect["headshot"],fxorigin,forwardvec,upvec);
	playfx(level._effect["headshot_nochunks"],fxorigin,forwardvec,upvec);
	wait(0.3);
	if(IsDefined(self))
	{
		playfxontag(level._effect["bloodspurt"],self,fxtag);
	}
}

//Function Number: 41
zombie_gib_on_damage()
{
	while(1)
	{
		self waittill("damage",amount,attacker,direction_vec,point,type,tagname,modelname,partname,weaponname);
		if(!(IsDefined(self)))
		{
			return;
		}

		if(!(self zombie_should_gib(amount,attacker,type)))
		{
			continue;
		}

		if(self head_should_gib(attacker,type,point) && type != "MOD_BURNED")
		{
			self zombie_head_gib(attacker,type);
			continue;
		}

		if(!(self.gibbed))
		{
			if(self maps/mp/animscripts/zm_utility::damagelocationisany("head","helmet","neck"))
			{
				continue;
			}

			refs = [];
			switch(self.damagelocation)
			{
				case "torso_lower":
				case "torso_upper":
					refs[refs.size] = "guts";
					refs[refs.size] = "right_arm";
					break;

				case "right_arm_lower":
				case "right_arm_upper":
				case "right_hand":
					refs[refs.size] = "right_arm";
					break;

				case "left_arm_lower":
				case "left_arm_upper":
				case "left_hand":
					refs[refs.size] = "left_arm";
					break;

				case "right_foot":
				case "right_leg_lower":
				case "right_leg_upper":
					refs[refs.size] = "right_leg";
					refs[refs.size] = "right_leg";
					refs[refs.size] = "right_leg";
					refs[refs.size] = "no_legs";
					break;
	self.health <= 0
					break;

				case "left_foot":
				case "left_leg_lower":
				case "left_leg_upper":
					refs[refs.size] = "left_leg";
					refs[refs.size] = "left_leg";
					refs[refs.size] = "left_leg";
					refs[refs.size] = "no_legs";
					break;
	self.health <= 0
					break;

				default:
					refs = self derive_damage_refs(point);
					break;
					refs[refs.size] = "guts";
					refs[refs.size] = "right_arm";
					refs[refs.size] = "left_arm";
					refs[refs.size] = "right_leg";
					refs[refs.size] = "left_leg";
					refs[refs.size] = "no_legs";
					break;
	type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH"
	self.damagelocation == "none"
					break;
			}

			if(IsDefined(level.custom_derive_damage_refs))
			{
				refs = self [[ level.custom_derive_damage_refs ]](refs,point,weaponname);
			}

			if(refs.size)
			{
				self.a.gib_ref = maps/mp/animscripts/zm_death::get_random(refs);
				if((self.a.gib_ref == "no_legs" || self.a.gib_ref == "right_leg" || self.a.gib_ref == "left_leg") && self.health > 0)
				{
					self.has_legs = 0;
					self allowedstances("crouch");
					self setphysparams(15,0,24);
					self allowpitchangle(1);
					self setpitchorient();
					health = self.health;
					health = health * 0.1;
					self thread maps/mp/animscripts/zm_run::needsdelayedupdate();
					if(IsDefined(self.crawl_anim_override))
					{
						self [[ self.crawl_anim_override ]]();
					}
				}
			}

			if(self.health > 0)
			{
				self thread maps/mp/animscripts/zm_death::do_gib();
				if(IsDefined(level.gib_on_damage))
				{
					self thread [[ level.gib_on_damage ]]();
				}
			}
		}
	}
}

//Function Number: 42
zombie_should_gib(amount,attacker,type)
{
	if(!(is_mature()))
	{
		return 0;
	}

	if(!(IsDefined(type)))
	{
		return 0;
	}

	if(IsDefined(self.is_on_fire) && self.is_on_fire)
	{
		return 0;
	}

	if(IsDefined(self.no_gib) && self.no_gib == 1)
	{
		return 0;
	}

	switch(type)
	{
		case "MOD_BURNED":
		case "MOD_CRUSH":
		case "MOD_FALLING":
		case "MOD_SUICIDE":
		case "MOD_TELEFRAG":
		case "MOD_TRIGGER_HURT":
		case "MOD_UNKNOWN":
			return 0;

		case "MOD_MELEE":
			return 0;
	}

	if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET")
	{
		if(!IsDefined(attacker) || !isplayer(attacker))
		{
			return 0;
		}

		weapon = attacker getcurrentweapon();
		if(weapon == "none" || weapon == level.start_weapon)
		{
			return 0;
		}

		if(weaponisgasweapon(self.weapon))
		{
			return 0;
		}
	}
	else if(type == "MOD_PROJECTILE")
	{
		if(IsDefined(attacker) && isplayer(attacker))
		{
			weapon = attacker getcurrentweapon();
			if(weapon == "slipgun_zm" || weapon == "slipgun_upgraded_zm")
			{
				return 0;
			}
		}
	}

	prev_health = amount + self.health;
	if(prev_health <= 0)
	{
		prev_health = 1;
	}

	damage_percent = amount / prev_health * 100;
	if(damage_percent < 10)
	{
		return 0;
	}
}

//Function Number: 43
derive_damage_refs(point)
{
	if(!(IsDefined(level.gib_tags)))
	{
		init_gib_tags();
	}

	closesttag = undefined;
	for(i = 0;i < level.gib_tags.size;i++)
	{
		if(!(IsDefined(closesttag)))
		{
			closesttag = level.gib_tags[i];
		}
		else if(distancesquared(point,self gettagorigin(level.gib_tags[i])) < distancesquared(point,self gettagorigin(closesttag)))
		{
			closesttag = level.gib_tags[i];
		}
	}

	refs = [];
	if(closesttag == "J_SpineLower" || closesttag == "J_SpineUpper" || closesttag == "J_Spine4")
	{
		refs[refs.size] = "guts";
		refs[refs.size] = "right_arm";
	}
	else if(closesttag == "J_Shoulder_LE" || closesttag == "J_Elbow_LE" || closesttag == "J_Wrist_LE")
	{
		refs[refs.size] = "left_arm";
	}
	else if(closesttag == "J_Shoulder_RI" || closesttag == "J_Elbow_RI" || closesttag == "J_Wrist_RI")
	{
		refs[refs.size] = "right_arm";
	}
	else if(closesttag == "J_Hip_LE" || closesttag == "J_Knee_LE" || closesttag == "J_Ankle_LE")
	{
		refs[refs.size] = "left_leg";
		refs[refs.size] = "no_legs";
	}
	else if(closesttag == "J_Hip_RI" || closesttag == "J_Knee_RI" || closesttag == "J_Ankle_RI")
	{
		refs[refs.size] = "right_leg";
		refs[refs.size] = "no_legs";
	}

/#
	assert(array_validate(refs),"get_closest_damage_refs(): couldn\'t derive refs from closestTag " + closesttag);
#/
	return refs;
}

//Function Number: 44
init_gib_tags()
{
	tags = [];
	tags[tags.size] = "J_SpineLower";
	tags[tags.size] = "J_SpineUpper";
	tags[tags.size] = "J_Spine4";
	tags[tags.size] = "J_Shoulder_LE";
	tags[tags.size] = "J_Elbow_LE";
	tags[tags.size] = "J_Wrist_LE";
	tags[tags.size] = "J_Shoulder_RI";
	tags[tags.size] = "J_Elbow_RI";
	tags[tags.size] = "J_Wrist_RI";
	tags[tags.size] = "J_Hip_LE";
	tags[tags.size] = "J_Knee_LE";
	tags[tags.size] = "J_Ankle_LE";
	tags[tags.size] = "J_Hip_RI";
	tags[tags.size] = "J_Knee_RI";
	tags[tags.size] = "J_Ankle_RI";
	level.gib_tags = tags;
}

//Function Number: 45
zombie_can_drop_powerups(zombie)
{
	if(is_tactical_grenade(zombie.damageweapon) || !flag("zombie_drop_powerups"))
	{
		return 0;
	}

	if(IsDefined(zombie.no_powerups) && zombie.no_powerups)
	{
		return 0;
	}
}

//Function Number: 46
zombie_delay_powerup_drop(origin)
{
	wait_network_frame();
	level thread maps/mp/zombies/_zm_powerups::powerup_drop(origin);
}

//Function Number: 47
zombie_death_points(origin,mod,hit_location,attacker,zombie,team)
{
	if(!IsDefined(attacker) || !isplayer(attacker))
	{
		return;
	}

	if(zombie_can_drop_powerups(zombie))
	{
		if(IsDefined(zombie.in_the_ground) && zombie.in_the_ground == 1)
		{
			trace = bullettrace(100 + VectorScale((0,0,1)),zombie.origin,100 + VectorScale((0,0,-1)),zombie.origin);
			origin = trace["position"];
			level thread zombie_delay_powerup_drop(origin);
		}
		else
		{
			trace = groundtrace(5 + VectorScale((0,0,1)),zombie.origin,300 + VectorScale((0,0,-1)),zombie.origin);
			origin = trace["position"];
			level thread zombie_delay_powerup_drop(origin);
		}
	}

	level thread maps/mp/zombies/_zm_audio::player_zombie_kill_vox(hit_location,attacker,mod,zombie);
	event = "death";
	if(IsDefined(zombie.damageweapon) && issubstr(zombie.damageweapon,"knife_ballistic_") && mod == "MOD_MELEE" || mod == "MOD_IMPACT")
	{
		event = "ballistic_knife_death";
	}

	if(IsDefined(zombie.deathpoints_already_given) && zombie.deathpoints_already_given)
	{
		return;
	}

	zombie.deathpoints_already_given = 1;
	if(IsDefined(zombie.damageweapon) && is_equipment(zombie.damageweapon))
	{
		return;
	}

	attacker maps/mp/zombies/_zm_score::player_add_points(event,mod,hit_location,undefined,team,attacker.currentweapon);
}

//Function Number: 48
get_number_variants(aliasprefix)
{
	for(i = 0;i < 100;i++)
	{
		if(!(soundexists(aliasprefix + "_" + i)))
		{
			return i;
		}
	}
}

//Function Number: 49
dragons_breath_flame_death_fx()
{
	if(self.isdog)
	{
		return;
	}

	if(!IsDefined(level._effect) || !IsDefined(level._effect["character_fire_death_sm"]))
	{
/#
		println("^3ANIMSCRIPT WARNING: You are missing level._effect[\"character_fire_death_sm\"], please set it in your levelname_fx.gsc. Use \"env/fire/fx_fire_zombie_md\");
#/
		return;
	}

	playfxontag(level._effect["character_fire_death_sm"],self,"J_SpineLower");
	tagarray = [];
	if(!IsDefined(self.a.gib_ref) || self.a.gib_ref != "left_arm")
	{
		tagarray[tagarray.size] = "J_Elbow_LE";
		tagarray[tagarray.size] = "J_Wrist_LE";
	}

	if(!IsDefined(self.a.gib_ref) || self.a.gib_ref != "right_arm")
	{
		tagarray[tagarray.size] = "J_Elbow_RI";
		tagarray[tagarray.size] = "J_Wrist_RI";
	}

	if(!IsDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs" && self.a.gib_ref != "left_leg")
	{
		tagarray[tagarray.size] = "J_Knee_LE";
		tagarray[tagarray.size] = "J_Ankle_LE";
	}

	if(!IsDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs" && self.a.gib_ref != "right_leg")
	{
		tagarray[tagarray.size] = "J_Knee_RI";
		tagarray[tagarray.size] = "J_Ankle_RI";
	}

	tagarray = array_randomize(tagarray);
	playfxontag(level._effect["character_fire_death_sm"],self,tagarray[0]);
}

//Function Number: 50
zombie_ragdoll_then_explode(launchvector,attacker)
{
	if(!(IsDefined(self)))
	{
		return;
	}

	self zombie_eye_glow_stop();
	self setclientfield("zombie_ragdoll_explode",1);
	self notify("exploding");
	self notify("end_melee");
	self notify("death",attacker);
	self.dont_die_on_me = 1;
	self.exploding = 1;
	self.a.nodeath = 1;
	self.dont_throw_gib = 1;
	self startragdoll();
	self setplayercollision(0);
	self reset_attack_spot();
	if(IsDefined(launchvector))
	{
		self launchragdoll(launchvector);
	}

	wait(2.1);
	if(IsDefined(self))
	{
		self ghost();
		self delay_thread(0.25,::self_delete);
	}
}

//Function Number: 51
zombie_death_animscript()
{
	team = undefined;
	recalc_zombie_array();
	if(IsDefined(self._race_team))
	{
		team = self._race_team;
	}

	self reset_attack_spot();
	if(self check_zombie_death_animscript_callbacks())
	{
		return 0;
	}

	if(IsDefined(level.zombie_death_animscript_override))
	{
		self [[ level.zombie_death_animscript_override ]]();
	}

	if(self.has_legs && IsDefined(self.a.gib_ref) && self.a.gib_ref == "no_legs")
	{
		self.deathanim = "zm_death";
	}

	self.grenadeammo = 0;
	if(IsDefined(self.nuked))
	{
		if(zombie_can_drop_powerups(self))
		{
			if(IsDefined(self.in_the_ground) && self.in_the_ground == 1)
			{
				trace = bullettrace(100 + VectorScale((0,0,1)),self.origin,100 + VectorScale((0,0,-1)),self.origin);
				origin = trace["position"];
				level thread zombie_delay_powerup_drop(origin);
			}
			else
			{
				trace = groundtrace(5 + VectorScale((0,0,1)),self.origin,300 + VectorScale((0,0,-1)),self.origin);
				origin = trace["position"];
				level thread zombie_delay_powerup_drop(self.origin);
			}
		}
	}
	else
	{
		level zombie_death_points(self.origin,self.damagemod,self.damagelocation,self.attacker,self,team);
	}

	if(IsDefined(self.attacker) && isai(self.attacker))
	{
		self.attacker notify("killed",self,0,undefined,0,undefined);
	}

	if("rottweil72_upgraded_zm" == self.damageweapon && "MOD_RIFLE_BULLET" == self.damagemod)
	{
		self thread dragons_breath_flame_death_fx();
	}

	if("tazer_knuckles_zm" == self.damageweapon && "MOD_MELEE" == self.damagemod)
	{
		self.is_on_fire = 0;
		self notify("stop_flame_damage");
	}

	if(self.damagemod == "MOD_BURNED")
	{
		self thread maps/mp/animscripts/zm_death::flame_death_fx();
	}

	if(self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH")
	{
		level notify("zombie_grenade_death",self.origin);
	}

	return 0;
}

//Function Number: 52
check_zombie_death_animscript_callbacks()
{
	if(!(IsDefined(level.zombie_death_animscript_callbacks)))
	{
		return 0;
	}

	for(i = 0;i < level.zombie_death_animscript_callbacks.size;i++)
	{
		if(self [[ level.zombie_death_animscript_callbacks[i] ]]())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 53
register_zombie_death_animscript_callback(func)
{
	if(!(IsDefined(level.zombie_death_animscript_callbacks)))
	{
		level.zombie_death_animscript_callbacks = [];
	}

	level.zombie_death_animscript_callbacks[level.zombie_death_animscript_callbacks.size] = func;
}

//Function Number: 54
damage_on_fire(player)
{
	self endon("death");
	self endon("stop_flame_damage");
	wait(2);
	while(IsDefined(self.is_on_fire) && self.is_on_fire)
	{
		if(level.round_number < 6)
		{
			dmg = level.zombie_health * randomfloatrange(0.2,0.3);
		}
		else if(level.round_number < 9)
		{
			dmg = level.zombie_health * randomfloatrange(0.15,0.25);
		}
		else if(level.round_number < 11)
		{
			dmg = level.zombie_health * randomfloatrange(0.1,0.2);
		}
		else
		{
			dmg = level.zombie_health * randomfloatrange(0.1,0.15);
		}

		if(IsDefined(player) && isalive(player))
		{
			self dodamage(dmg,self.origin,player);
		}
		else
		{
			self dodamage(dmg,self.origin,level);
		}

		wait(randomfloatrange(1,3));
	}
}

//Function Number: 55
player_using_hi_score_weapon(player)
{
	weapon = player getcurrentweapon();
	if(weapon == "none" || weaponissemiauto(weapon))
	{
		return 1;
	}

	return 0;
}

//Function Number: 56
zombie_damage(mod,hit_location,hit_origin,player,amount,team)
{
	if(is_magic_bullet_shield_enabled(self))
	{
		return;
	}

	player.use_weapon_type = mod;
	if(IsDefined(self.marked_for_death))
	{
		return;
	}

	if(!(IsDefined(player)))
	{
		return;
	}

	if(IsDefined(hit_origin))
	{
		self.damagehit_origin = hit_origin;
	}
	else
	{
		self.damagehit_origin = player getweaponmuzzlepoint();
	}

	if(self check_zombie_damage_callbacks(mod,hit_location,hit_origin,player,amount))
	{
		return;
	}
	else if(self zombie_flame_damage(mod,player))
	{
		if(self zombie_give_flame_damage_points())
		{
			player maps/mp/zombies/_zm_score::player_add_points("damage",mod,hit_location,self.isdog,team);
		}
	}
	else
	{
		if(player_using_hi_score_weapon(player))
		{
			damage_type = "damage";
		}
		else
		{
			damage_type = "damage_light";
		}

		if(!(IsDefined(self.no_damage_points) && self.no_damage_points))
		{
			player maps/mp/zombies/_zm_score::player_add_points(damage_type,mod,hit_location,self.isdog,team,self.damageweapon);
		}
	}

	if(IsDefined(self.zombie_damage_fx_func))
	{
		self [[ self.zombie_damage_fx_func ]](mod,hit_location,hit_origin,player);
	}

	modname = remove_mod_from_methodofdeath(mod);
	if(is_placeable_mine(self.damageweapon))
	{
		if(IsDefined(self.zombie_damage_claymore_func))
		{
			self [[ self.zombie_damage_claymore_func ]](mod,hit_location,hit_origin,player);
		}
		else if(IsDefined(player) && isalive(player))
		{
			self dodamage(level.round_number * randomintrange(100,200),self.origin,player,self,hit_location,mod);
		}
		else
		{
			self dodamage(level.round_number * randomintrange(100,200),self.origin,undefined,self,hit_location,mod);
		}
	}
	else if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH")
	{
		if(IsDefined(player) && isalive(player))
		{
			player.grenade_multiattack_count++;
			player.grenade_multiattack_ent = self;
			self dodamage(level.round_number + randomintrange(100,200),self.origin,player,self,hit_location,modname);
		}
		else
		{
			self dodamage(level.round_number + randomintrange(100,200),self.origin,undefined,self,hit_location,modname);
		}
	}
	else if(mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH")
	{
		if(IsDefined(player) && isalive(player))
		{
			self dodamage(level.round_number * randomintrange(0,100),self.origin,player,self,hit_location,modname);
		}
		else
		{
			self dodamage(level.round_number * randomintrange(0,100),self.origin,undefined,self,hit_location,modname);
		}
	}

	if(IsDefined(self.a.gib_ref) && self.a.gib_ref == "no_legs" && isalive(self))
	{
		if(IsDefined(player))
		{
			rand = randomintrange(0,100);
			if(rand < 10)
			{
				player create_and_play_dialog("general","crawl_spawn");
			}
		}
	}
	else if(IsDefined(self.a.gib_ref) && self.a.gib_ref == "right_arm" || self.a.gib_ref == "left_arm")
	{
		if(self.has_legs && isalive(self))
		{
			if(IsDefined(player))
			{
				rand = randomintrange(0,100);
				if(rand < 7)
				{
					player create_and_play_dialog("general","shoot_arm");
				}
			}
		}
	}

	self thread maps/mp/zombies/_zm_powerups::check_for_instakill(player,mod,hit_location);
}

//Function Number: 57
zombie_damage_ads(mod,hit_location,hit_origin,player,amount,team)
{
	if(is_magic_bullet_shield_enabled(self))
	{
		return;
	}

	player.use_weapon_type = mod;
	if(!(IsDefined(player)))
	{
		return;
	}

	if(IsDefined(hit_origin))
	{
		self.damagehit_origin = hit_origin;
	}
	else
	{
		self.damagehit_origin = player getweaponmuzzlepoint();
	}

	if(self check_zombie_damage_callbacks(mod,hit_location,hit_origin,player,amount))
	{
		return;
	}
	else if(self zombie_flame_damage(mod,player))
	{
		if(self zombie_give_flame_damage_points())
		{
			player maps/mp/zombies/_zm_score::player_add_points("damage_ads",mod,hit_location,undefined,team);
		}
	}
	else
	{
		if(player_using_hi_score_weapon(player))
		{
			damage_type = "damage";
		}
		else
		{
			damage_type = "damage_light";
		}

		if(!(IsDefined(self.no_damage_points) && self.no_damage_points))
		{
			player maps/mp/zombies/_zm_score::player_add_points(damage_type,mod,hit_location,undefined,team,self.damageweapon);
		}
	}

	self thread maps/mp/zombies/_zm_powerups::check_for_instakill(player,mod,hit_location);
}

//Function Number: 58
check_zombie_damage_callbacks(mod,hit_location,hit_origin,player,amount)
{
	if(!(IsDefined(level.zombie_damage_callbacks)))
	{
		return 0;
	}

	for(i = 0;i < level.zombie_damage_callbacks.size;i++)
	{
		if(self [[ level.zombie_damage_callbacks[i] ]](mod,hit_location,hit_origin,player,amount))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 59
register_zombie_damage_callback(func)
{
	if(!(IsDefined(level.zombie_damage_callbacks)))
	{
		level.zombie_damage_callbacks = [];
	}

	level.zombie_damage_callbacks[level.zombie_damage_callbacks.size] = func;
}

//Function Number: 60
zombie_give_flame_damage_points()
{
	if(GetTime() > self.flame_damage_time)
	{
		self.flame_damage_time = GetTime() + level.zombie_vars["zombie_flame_dmg_point_delay"];
		return 1;
	}
}

//Function Number: 61
zombie_flame_damage(mod,player)
{
	if(mod == "MOD_BURNED")
	{
		if(!IsDefined(self.is_on_fire) || IsDefined(self.is_on_fire) && !self.is_on_fire)
		{
			self thread damage_on_fire(player);
		}

		do_flame_death = 1;
		dist = 10000;
		ai = getaiarray(level.zombie_team);
		for(i = 0;i < ai.size;i++)
		{
			if(IsDefined(ai[i].is_on_fire) && ai[i].is_on_fire)
			{
				if(distancesquared(ai[i].origin,self.origin) < dist)
				{
					do_flame_death = 0;
					break;
				}
			}
		}

		if(do_flame_death)
		{
			self thread maps/mp/animscripts/zm_death::flame_death_fx();
		}

		return 1;
	}
}

//Function Number: 62
is_weapon_shotgun(sweapon)
{
	if(IsDefined(sweapon) && weaponclass(sweapon) == "spread")
	{
		return 1;
	}

	return 0;
}

//Function Number: 63
zombie_death_event(zombie)
{
	zombie.marked_for_recycle = 0;
	force_explode = 0;
	force_head_gib = 0;
	zombie waittill("death",attacker);
	time_of_death = GetTime();
	if(IsDefined(zombie))
	{
		zombie stopsounds();
	}

	if(IsDefined(zombie) && IsDefined(zombie.marked_for_insta_upgraded_death))
	{
		force_head_gib = 1;
	}

	if(!IsDefined(zombie.damagehit_origin) && IsDefined(attacker))
	{
		zombie.damagehit_origin = attacker getweaponmuzzlepoint();
	}

	if(IsDefined(attacker) && isplayer(attacker))
	{
		if(IsDefined(level.pers_upgrade_carpenter) && level.pers_upgrade_carpenter)
		{
			maps/mp/zombies/_zm_pers_upgrades::pers_zombie_death_location_check(attacker,zombie.origin);
		}

		if(IsDefined(level.pers_upgrade_sniper) && level.pers_upgrade_sniper)
		{
			attacker pers_upgrade_sniper_kill_check(zombie,attacker);
		}

		if(IsDefined(zombie) && IsDefined(zombie.damagelocation))
		{
			if(is_headshot(zombie.damageweapon,zombie.damagelocation,zombie.damagemod))
			{
				attacker.headshots++;
				attacker maps/mp/zombies/_zm_stats::increment_client_stat("headshots");
				attacker addweaponstat(zombie.damageweapon,"headshots",1);
				attacker maps/mp/zombies/_zm_stats::increment_player_stat("headshots");
				if(is_classic())
				{
					attacker maps/mp/zombies/_zm_pers_upgrades_functions::pers_check_for_pers_headshot(time_of_death,zombie);
				}
			}
			else
			{
				attacker notify("zombie_death_no_headshot");
			}
		}

		if(IsDefined(zombie) && IsDefined(zombie.damagemod) && zombie.damagemod == "MOD_MELEE")
		{
			attacker maps/mp/zombies/_zm_stats::increment_client_stat("melee_kills");
			attacker maps/mp/zombies/_zm_stats::increment_player_stat("melee_kills");
			attacker notify("melee_kill");
			if(attacker maps/mp/zombies/_zm_pers_upgrades::is_insta_kill_upgraded_and_active())
			{
				force_explode = 1;
			}
		}

		attacker maps/mp/zombies/_zm::add_rampage_bookmark_kill_time();
		attacker.kills++;
		attacker maps/mp/zombies/_zm_stats::increment_client_stat("kills");
		attacker maps/mp/zombies/_zm_stats::increment_player_stat("kills");
		if(IsDefined(level.pers_upgrade_pistol_points) && level.pers_upgrade_pistol_points)
		{
			attacker maps/mp/zombies/_zm_pers_upgrades_functions::pers_upgrade_pistol_points_kill();
		}

		dmgweapon = zombie.damageweapon;
		if(is_alt_weapon(dmgweapon))
		{
			dmgweapon = weaponaltweaponname(dmgweapon);
		}

		attacker addweaponstat(dmgweapon,"kills",1);
		if(attacker maps/mp/zombies/_zm_pers_upgrades_functions::pers_mulit_kill_headshot_active() || force_head_gib)
		{
			zombie maps/mp/zombies/_zm_spawner::zombie_head_gib();
		}

		if(IsDefined(level.pers_upgrade_nube) && level.pers_upgrade_nube)
		{
			attacker notify("pers_player_zombie_kill");
		}
	}

	zombie_death_achievement_sliquifier_check(attacker,zombie);
	recalc_zombie_array();
	if(!(IsDefined(zombie)))
	{
		return;
	}

	level.global_zombies_killed++;
	if(IsDefined(zombie.marked_for_death) && !IsDefined(zombie.nuked))
	{
		level.zombie_trap_killed_count++;
	}

	zombie check_zombie_death_event_callbacks();
	name = zombie.animname;
	if(IsDefined(zombie.sndname))
	{
		name = zombie.sndname;
	}

	zombie thread maps/mp/zombies/_zm_audio::do_zombies_playvocals("death",name);
	zombie thread zombie_eye_glow_stop();
	if((IsDefined(zombie.damageweapon) && is_weapon_shotgun(zombie.damageweapon) && maps/mp/zombies/_zm_weapons::is_weapon_upgraded(zombie.damageweapon)) || (IsDefined(zombie.damageweapon) && is_placeable_mine(zombie.damageweapon)) || zombie.damagemod == "MOD_GRENADE" || zombie.damagemod == "MOD_GRENADE_SPLASH" || zombie.damagemod == "MOD_EXPLOSIVE" || force_explode == 1)
	{
		splode_dist = 180;
		if(IsDefined(zombie.damagehit_origin) && distancesquared(zombie.origin,zombie.damagehit_origin) < splode_dist * splode_dist)
		{
			tag = "J_SpineLower";
			if(IsDefined(zombie.isdog) && zombie.isdog)
			{
				tag = "tag_origin";
			}

			if(!IsDefined(zombie.is_on_fire) && zombie.is_on_fire && !IsDefined(zombie.guts_explosion) && zombie.guts_explosion)
			{
				zombie thread zombie_gut_explosion();
			}
		}
	}

	if(zombie.damagemod == "MOD_GRENADE" || zombie.damagemod == "MOD_GRENADE_SPLASH")
	{
		if(IsDefined(attacker) && isalive(attacker))
		{
			attacker.grenade_multiattack_count++;
			attacker.grenade_multiattack_ent = zombie;
		}
	}

	if(!IsDefined(zombie.has_been_damaged_by_player) && zombie.has_been_damaged_by_player && IsDefined(zombie.marked_for_recycle) && zombie.marked_for_recycle)
	{
		level.zombie_total++;
		level.zombie_total_subtract++;
	}
	else if(IsDefined(zombie.attacker) && isplayer(zombie.attacker))
	{
		level.zombie_player_killed_count++;
		if(IsDefined(zombie.sound_damage_player) && zombie.sound_damage_player == zombie.attacker)
		{
			chance = get_response_chance("damage");
			if(chance != 0)
			{
				if(chance > randomintrange(1,100))
				{
					zombie.attacker maps/mp/zombies/_zm_audio::create_and_play_dialog("kill","damage");
				}
			}
			else
			{
				zombie.attacker maps/mp/zombies/_zm_audio::create_and_play_dialog("kill","damage");
			}
		}

		zombie.attacker notify("zom_kill",zombie);
		damageloc = zombie.damagelocation;
		damagemod = zombie.damagemod;
		attacker = zombie.attacker;
		weapon = zombie.damageweapon;
		bbprint("zombie_kills","round %d zombietype %s damagetype %s damagelocation %s playername %s playerweapon %s playerx %f playery %f playerz %f zombiex %f zombiey %f zombiez %f",level.round_number,zombie.animname,damagemod,damageloc,attacker.name,weapon,attacker.origin,zombie.origin);
	}
	else if(zombie.ignoreall && !IsDefined(zombie.marked_for_death) && zombie.marked_for_death)
	{
		level.zombies_timeout_spawn++;
	}

	level notify("zom_kill");
	level.total_zombies_killed++;
}

//Function Number: 64
zombie_gut_explosion()
{
	self.guts_explosion = 1;
	if(is_mature())
	{
		self setclientfield("zombie_gut_explosion",1);
	}

	if(!(IsDefined(self.isdog) && self.isdog))
	{
		wait(0.1);
	}

	if(IsDefined(self))
	{
		self ghost();
	}
}

//Function Number: 65
zombie_death_achievement_sliquifier_check(e_player,e_zombie)
{
	if(!(isplayer(e_player)))
	{
		return;
	}

	if(IsDefined(e_zombie))
	{
		if(IsDefined(e_zombie.damageweapon) && e_zombie.damageweapon == "slipgun_zm")
		{
			if(!(IsDefined(e_player.num_sliquifier_kills)))
			{
				e_player.num_sliquifier_kills = 0;
			}

			e_player.num_sliquifier_kills++;
			e_player notify("sliquifier_kill");
		}
	}
}

//Function Number: 66
check_zombie_death_event_callbacks()
{
	if(!(IsDefined(level.zombie_death_event_callbacks)))
	{
		return;
	}

	for(i = 0;i < level.zombie_death_event_callbacks.size;i++)
	{
		self [[ level.zombie_death_event_callbacks[i] ]]();
	}
}

//Function Number: 67
register_zombie_death_event_callback(func)
{
	if(!(IsDefined(level.zombie_death_event_callbacks)))
	{
		level.zombie_death_event_callbacks = [];
	}

	level.zombie_death_event_callbacks[level.zombie_death_event_callbacks.size] = func;
}

//Function Number: 68
deregister_zombie_death_event_callback(func)
{
	if(IsDefined(level.zombie_death_event_callbacks))
	{
		arrayremovevalue(level.zombie_death_event_callbacks,func);
	}
}

//Function Number: 69
zombie_setup_attack_properties()
{
	self zombie_history("zombie_setup_attack_properties()");
	self.ignoreall = 0;
	self.pathenemyfightdist = 64;
	self.meleeattackdist = 64;
	self.maxsightdistsqrd = 16384;
	self.disablearrivals = 1;
	self.disableexits = 1;
}

//Function Number: 70
attractors_generated_listener()
{
	self endon("death");
	level endon("intermission");
	self endon("stop_find_flesh");
	self endon("path_timer_done");
	level waittill("attractor_positions_generated");
	self.zombie_path_timer = 0;
}

//Function Number: 71
zombie_pathing()
{
	self endon("death");
	self endon("zombie_acquire_enemy");
	level endon("intermission");
/#
	assert(IsDefined(self.favoriteenemy) || IsDefined(self.enemyoverride));
#/
	self._skip_pathing_first_delay = 1;
	self thread zombie_follow_enemy();
	self waittill("bad_path");
	level.zombie_pathing_failed++;
	if(IsDefined(self.enemyoverride))
	{
		debug_print("Zombie couldn\'t path to point of interest at origin: " + self.enemyoverride[0] + " Falling back to breadcrumb system");
		if(IsDefined(self.enemyoverride[1]))
		{
			self.enemyoverride = self.enemyoverride[1] invalidate_attractor_pos(self.enemyoverride,self);
			self.zombie_path_timer = 0;
			return;
		}
	}
	else if(IsDefined(self.favoriteenemy))
	{
		debug_print("Zombie couldn\'t path to player at origin: " + self.favoriteenemy.origin + " Falling back to breadcrumb system");
	}
	else
	{
		debug_print("Zombie couldn\'t path to a player ( the other \'prefered\' player might be ignored for encounters mode ). Falling back to breadcrumb system");
	}

	if(!(IsDefined(self.favoriteenemy)))
	{
		self.zombie_path_timer = 0;
		return;
	}
	else
	{
		self.favoriteenemy endon("disconnect");
	}

	players = get_players();
	valid_player_num = 0;
	for(i = 0;i < players.size;i++)
	{
		if(is_player_valid(players[i],1))
		{
			valid_player_num = valid_player_num + 1;
		}
	}

	if(players.size > 1)
	{
		if(IsDefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]())
		{
			self.zombie_path_timer = 0;
			return;
		}

		if(array_check_for_dupes(self.ignore_player,self.favoriteenemy))
		{
			self.ignore_player[self.ignore_player.size] = self.favoriteenemy;
		}

		if(self.ignore_player.size < valid_player_num)
		{
			self.zombie_path_timer = 0;
			return;
		}
	}

	crumb_list = self.favoriteenemy.zombie_breadcrumbs;
	bad_crumbs = [];
	while(1)
	{
		if(!(is_player_valid(self.favoriteenemy,1)))
		{
			self.zombie_path_timer = 0;
			return;
		}

		goal = zombie_pathing_get_breadcrumb(self.favoriteenemy.origin,crumb_list,bad_crumbs,randomint(100) < 20);
		if(!(IsDefined(goal)))
		{
			debug_print("Zombie exhausted breadcrumb search");
			level.zombie_breadcrumb_failed++;
			goal = self.favoriteenemy.spectator_respawn.origin;
		}

		debug_print("Setting current breadcrumb to " + goal);
		self.zombie_path_timer = self.zombie_path_timer + 100;
		self setgoalpos(goal);
		self waittill("bad_path");
		debug_print("Zombie couldn\'t path to breadcrumb at " + goal + " Finding next breadcrumb");
		for(i = 0;i < crumb_list.size;i++)
		{
			if(goal == crumb_list[i])
			{
				bad_crumbs[bad_crumbs.size] = i;
				break;
			}
		}
	}
}

//Function Number: 72
zombie_pathing_get_breadcrumb(origin,breadcrumbs,bad_crumbs,pick_random)
{
/#
	assert(IsDefined(origin));
#/
/#
	assert(IsDefined(breadcrumbs));
#/
/#
	assert(isarray(breadcrumbs));
#/
/#
	if(pick_random)
	{
		debug_print("Finding random breadcrumb");
	}
#/
	for(i = 0;i < breadcrumbs.size;i++)
	{
		if(pick_random)
		{
			crumb_index = randomint(breadcrumbs.size);
		}
		else
		{
			crumb_index = i;
		}

		if(crumb_is_bad(crumb_index,bad_crumbs))
		{
		}
		else
		{
			return breadcrumbs[crumb_index];
		}
	}

	return undefined;
}

//Function Number: 73
crumb_is_bad(crumb,bad_crumbs)
{
	for(i = 0;i < bad_crumbs.size;i++)
	{
		if(bad_crumbs[i] == crumb)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 74
jitter_enemies_bad_breadcrumbs(start_crumb)
{
	trace_distance = 35;
	jitter_distance = 2;
	for(index = start_crumb;IsDefined(self.favoriteenemy.zombie_breadcrumbs[index + 1]);index++)
	{
		current_crumb = self.favoriteenemy.zombie_breadcrumbs[index];
		next_crumb = self.favoriteenemy.zombie_breadcrumbs[index + 1];
		angles = VectorToAngles(current_crumb - next_crumb);
		right = AnglesToRight(angles);
		left = AnglesToRight(180 + VectorScale((0,1,0)));
		dist_pos = trace_distance + VectorScale(right);
		trace = bullettrace(current_crumb,dist_pos,1,undefined);
		vector = trace["position"];
		if(distance(vector,current_crumb) < 17)
		{
			self.favoriteenemy.zombie_breadcrumbs[index] = jitter_distance + VectorScale(left);
			continue;
		}

		dist_pos = trace_distance + VectorScale(left);
		trace = bullettrace(current_crumb,dist_pos,1,undefined);
		vector = trace["position"];
		if(distance(vector,current_crumb) < 17)
		{
			self.favoriteenemy.zombie_breadcrumbs[index] = jitter_distance + VectorScale(right);
			continue;
		}
	}
}

//Function Number: 75
zombie_repath_notifier()
{
	note = 0;
	notes = [];
	for(i = 0;i < 4;i++)
	{
		notes[notes.size] = "zombie_repath_notify_" + i;
	}

	while(1)
	{
		level notify(notes[note]);
		note = note + 1 % 4;
		wait(0.05);
	}
}

//Function Number: 76
zombie_follow_enemy()
{
	self endon("death");
	self endon("zombie_acquire_enemy");
	self endon("bad_path");
	level endon("intermission");
	if(!(IsDefined(level.repathnotifierstarted)))
	{
		level.repathnotifierstarted = 1;
		level thread zombie_repath_notifier();
	}

	if(!(IsDefined(self.zombie_repath_notify)))
	{
		self.zombie_repath_notify = "zombie_repath_notify_" + self getentitynumber() % 4;
	}

	while(1)
	{
		if(!(IsDefined(self._skip_pathing_first_delay)))
		{
			level waittill(self.zombie_repath_notify);
		}
		else
		{
			self._skip_pathing_first_delay = undefined;
		}

		if(!IsDefined(self.ignore_enemyoverride) && self.ignore_enemyoverride && IsDefined(self.enemyoverride) && IsDefined(self.enemyoverride[1]))
		{
			if(distancesquared(self.origin,self.enemyoverride[0]) > 1)
			{
				self orientmode("face motion");
			}
			else
			{
				self orientmode("face point",self.enemyoverride[1].origin);
			}

			self.ignoreall = 1;
			goalpos = self.enemyoverride[0];
			if(IsDefined(level.adjust_enemyoverride_func))
			{
				goalpos = self [[ level.adjust_enemyoverride_func ]]();
			}

			self setgoalpos(goalpos);
		}
		else if(IsDefined(self.favoriteenemy))
		{
			self.ignoreall = 0;
			self orientmode("face default");
			goalpos = self.favoriteenemy.origin;
			if(IsDefined(level.enemy_location_override_func))
			{
				goalpos = [[ level.enemy_location_override_func ]](self,self.favoriteenemy);
			}

			self setgoalpos(goalpos);
			if(!(IsDefined(level.ignore_path_delays)))
			{
				distsq = distancesquared(self.origin,self.favoriteenemy.origin);
				if(distsq > 10240000)
				{
					wait(2 + randomfloat(1));
				}
				else if(distsq > 4840000)
				{
					wait(1 + randomfloat(0.5));
				}
				else if(distsq > 1440000)
				{
					wait(0.5 + randomfloat(0.5));
				}
			}
		}

		if(IsDefined(level.inaccesible_player_func))
		{
			self [[ level.inaccessible_player_func ]]();
		}
	}
}

//Function Number: 77
zombie_eye_glow()
{
	if(!(IsDefined(self)))
	{
		return;
	}

	if(!IsDefined(self.no_eye_glow) || !self.no_eye_glow)
	{
		self setclientfield("zombie_has_eyes",1);
	}
}

//Function Number: 78
zombie_eye_glow_stop()
{
	if(!(IsDefined(self)))
	{
		return;
	}

	if(!IsDefined(self.no_eye_glow) || !self.no_eye_glow)
	{
		self setclientfield("zombie_has_eyes",0);
	}
}

//Function Number: 79
zombie_history(msg)
{
/#
	if(!IsDefined(self.zombie_history) || 32 <= self.zombie_history.size)
	{
		self.zombie_history = [];
	}

	self.zombie_history[self.zombie_history.size] = msg;
#/
}

//Function Number: 80
do_zombie_spawn()
{
	self endon("death");
	spots = [];
	if(IsDefined(self._rise_spot))
	{
		spot = self._rise_spot;
		self thread do_zombie_rise(spot);
		return;
	}

	if(IsDefined(level.zombie_spawn_locations))
	{
		for(i = 0;i < level.zombie_spawn_locations.size;i++)
		{
			if(IsDefined(level.use_multiple_spawns) && level.use_multiple_spawns && IsDefined(self.script_int))
			{
				if(!IsDefined(level.spawner_int) && level.spawner_int == self.script_int && !IsDefined(level.zombie_spawn_locations[i].script_int) || IsDefined(level.zones[level.zombie_spawn_locations[i].zone_name].script_int))
				{
				}
				else if(IsDefined(level.zombie_spawn_locations[i].script_int) && level.zombie_spawn_locations[i].script_int != self.script_int)
				{
				}
				else if(IsDefined(level.zones[level.zombie_spawn_locations[i].zone_name].script_int) && level.zones[level.zombie_spawn_locations[i].zone_name].script_int != self.script_int)
				{
				}
				else
				{
					spots[spots.size] = level.zombie_spawn_locations[i];
				}
			}
		}
	}

/#
	if(GetDvarInt(#"A8C231AA"))
	{
		if(IsDefined(level.zombie_spawn_locations))
		{
			player = get_players()[0];
			spots = [];
			for(i = 0;i < level.zombie_spawn_locations.size;i++)
			{
				player_vec = vectornormalize(AnglesToForward(player.angles));
				player_spawn = vectornormalize(level.zombie_spawn_locations[i].origin - player.origin);
				dot = vectordot(player_vec,player_spawn);
				if(dot > 0.707)
				{
					spots[spots.size] = level.zombie_spawn_locations[i];
					debugstar(level.zombie_spawn_locations[i].origin,1000,(1,1,1));
				}
			}

			if(spots.size <= 0)
			{
				spots[spots.size] = level.zombie_spawn_locations[0];
				iprintln("no spawner in view");
			}
		}
	}
#/
/#
	assert(spots.size > 0,"No spawn locations found");
#/
	spot = random(spots);
	self.spawn_point = spot;
/#
	if(IsDefined(level.toggle_show_spawn_locations) && level.toggle_show_spawn_locations)
	{
		debugstar(spot.origin,GetDvarInt(#"BB9101B2"),(0,1,0));
		host_player = gethostplayer();
		distance = distance(spot.origin,host_player.origin);
		iprintln("Distance to player: " + distance / 12 + "feet");
	}
#/
	if(IsDefined(spot.target))
	{
		self.target = spot.target;
	}

	if(IsDefined(spot.zone_name))
	{
		self.zone_name = spot.zone_name;
	}

	if(IsDefined(spot.script_parameters))
	{
		self.script_parameters = spot.script_parameters;
	}

	tokens = strtok(spot.script_noteworthy," ");
	foreach(index, token in tokens)
	{
		if(IsDefined(self.spawn_point_override))
		{
			spot = self.spawn_point_override;
			token = spot.script_noteworthy;
		}

		if(token == "custom_spawner_entry")
		{
			next_token = index + 1;
			if(IsDefined(tokens[next_token]))
			{
				str_spawn_entry = tokens[next_token];
				if(IsDefined(level.custom_spawner_entry) && IsDefined(level.custom_spawner_entry[str_spawn_entry]))
				{
					self thread [[ level.custom_spawner_entry[str_spawn_entry] ]](spot);
				}
				else if(token == "riser_location")
				{
					self thread do_zombie_rise(spot);
				}
				else if(token == "faller_location")
				{
					self thread maps/mp/zombies/_zm_ai_faller::do_zombie_fall(spot);
				}
				else if(token == "dog_location")
				{
				}
				else if(token == "screecher_location")
				{
				}
				else if(token == "leaper_location")
				{
				}
				else
				{
					if(IsDefined(self.anchor))
					{
						return;
					}

					self.anchor = spawn("script_origin",self.origin);
					self.anchor.angles = self.angles;
					self linkto(self.anchor);
					if(!(IsDefined(spot.angles)))
					{
						spot.angles = (0,0,0);
					}

					self ghost();
					self.anchor moveto(spot.origin,0.05);
					self.anchor waittill("movedone");
					target_org = get_desired_origin();
					if(IsDefined(target_org))
					{
						anim_ang = VectorToAngles(target_org - self.origin);
						self.anchor rotateto((0,anim_ang[1],0),0.05);
						self.anchor waittill("rotatedone");
					}

					if(IsDefined(level.zombie_spawn_fx))
					{
						playfx(level.zombie_spawn_fx,spot.origin);
					}

					self unlink();
					if(IsDefined(self.anchor))
					{
						self.anchor delete();
					}

					self show();
					self notify("risen",spot.script_string);
				}
			}
		}
	}
}

//Function Number: 81
do_zombie_rise(spot)
{
	self endon("death");
	self.in_the_ground = 1;
	if(IsDefined(self.anchor))
	{
		self.anchor delete();
	}

	self.anchor = spawn("script_origin",self.origin);
	self.anchor.angles = self.angles;
	self linkto(self.anchor);
	if(!(IsDefined(spot.angles)))
	{
		spot.angles = (0,0,0);
	}

	anim_org = spot.origin;
	anim_ang = spot.angles;
	anim_org = anim_org + (0,0,0);
	self ghost();
	self.anchor moveto(anim_org,0.05);
	self.anchor waittill("movedone");
	target_org = get_desired_origin();
	if(IsDefined(target_org))
	{
		anim_ang = VectorToAngles(target_org - self.origin);
		self.anchor rotateto((0,anim_ang[1],0),0.05);
		self.anchor waittill("rotatedone");
	}

	self unlink();
	if(IsDefined(self.anchor))
	{
		self.anchor delete();
	}

	self thread hide_pop();
	level thread zombie_rise_death(self,spot);
	spot thread zombie_rise_fx(self);
	substate = 0;
	if(self.zombie_move_speed == "walk")
	{
		substate = randomint(2);
	}
	else if(self.zombie_move_speed == "run")
	{
		substate = 2;
	}
	else if(self.zombie_move_speed == "sprint")
	{
		substate = 3;
	}

	self orientmode("face default");
	self animscripted(self.origin,spot.angles,"zm_rise",substate);
	self maps/mp/animscripts/zm_shared::donotetracks("rise_anim",::handle_rise_notetracks,spot);
	self notify("rise_anim_finished");
	spot notify("stop_zombie_rise_fx");
	self.in_the_ground = 0;
	self notify("risen",spot.script_string);
}

//Function Number: 82
hide_pop()
{
	self endon("death");
	wait(0.5);
	if(IsDefined(self))
	{
		self show();
		wait_network_frame();
		if(IsDefined(self))
		{
			self.create_eyes = 1;
		}
	}
}

//Function Number: 83
handle_rise_notetracks(note,spot)
{
	if(note == "deathout" || note == "deathhigh")
	{
		self.zombie_rise_death_out = 1;
		self notify("zombie_rise_death_out");
		wait(2);
		spot notify("stop_zombie_rise_fx");
	}
}

//Function Number: 84
zombie_rise_death(zombie,spot)
{
	zombie.zombie_rise_death_out = 0;
	zombie endon("rise_anim_finished");
	while(IsDefined(zombie) && IsDefined(zombie.health) && zombie.health > 1)
	{
		zombie waittill("damage",amount);
	}

	spot notify("stop_zombie_rise_fx");
	if(IsDefined(zombie))
	{
		zombie.deathanim = zombie get_rise_death_anim();
		zombie stopanimscripted();
	}
}

//Function Number: 85
zombie_rise_fx(zombie)
{
	if(!(IsDefined(level.riser_fx_on_client) && level.riser_fx_on_client))
	{
		self thread zombie_rise_dust_fx(zombie);
		self thread zombie_rise_burst_fx(zombie);
	}
	else
	{
		self thread zombie_rise_burst_fx(zombie);
	}

	zombie endon("death");
	self endon("stop_zombie_rise_fx");
	wait(1);
	if(zombie.zombie_move_speed != "sprint")
	{
		wait(1);
	}
}

//Function Number: 86
zombie_rise_burst_fx(zombie)
{
	self endon("stop_zombie_rise_fx");
	self endon("rise_anim_finished");
	if(IsDefined(self.script_parameters) && self.script_parameters == "in_water" && !IsDefined(level._no_water_risers) && level._no_water_risers)
	{
		zombie setclientfield("zombie_riser_fx_water",1);
	}
	else if(IsDefined(self.script_parameters) && self.script_parameters == "in_foliage" && IsDefined(level._foliage_risers) && level._foliage_risers)
	{
		zombie setclientfield("zombie_riser_fx_foliage",1);
	}
	else if(IsDefined(self.script_parameters) && self.script_parameters == "in_snow")
	{
		zombie setclientfield("zombie_riser_fx",1);
	}
	else if(IsDefined(zombie.zone_name) && IsDefined(level.zones[zombie.zone_name]))
	{
		low_g_zones = getentarray(zombie.zone_name,"targetname");
		if(IsDefined(low_g_zones[0].script_string) && low_g_zones[0].script_string == "lowgravity")
		{
			zombie setclientfield("zombie_riser_fx_lowg",1);
		}
		else
		{
			zombie setclientfield("zombie_riser_fx",1);
		}
	}
	else
	{
		zombie setclientfield("zombie_riser_fx",1);
	}
}

//Function Number: 87
zombie_rise_dust_fx(zombie)
{
	dust_tag = "J_SpineUpper";
	self endon("stop_zombie_rise_dust_fx");
	self thread stop_zombie_rise_dust_fx(zombie);
	wait(2);
	dust_time = 5.5;
	dust_interval = 0.3;
	if(IsDefined(self.script_string) && self.script_string == "in_water")
	{
		for(t = 0;t < dust_time;t = t + dust_interval)
		{
			playfxontag(level._effect["rise_dust_water"],zombie,dust_tag);
			wait(dust_interval);
		}
	}
	else if(IsDefined(self.script_string) && self.script_string == "in_snow")
	{
		for(t = 0;t < dust_time;t = t + dust_interval)
		{
			playfxontag(level._effect["rise_dust_snow"],zombie,dust_tag);
			wait(dust_interval);
		}
	}
	else if(IsDefined(self.script_string) && self.script_string == "in_foliage")
	{
		for(t = 0;t < dust_time;t = t + dust_interval)
		{
			playfxontag(level._effect["rise_dust_foliage"],zombie,dust_tag);
			wait(dust_interval);
		}
	}
	else
	{
		for(t = 0;t < dust_time;t = t + dust_interval)
		{
			playfxontag(level._effect["rise_dust"],zombie,dust_tag);
			wait(dust_interval);
		}
	}
}

//Function Number: 88
stop_zombie_rise_dust_fx(zombie)
{
	zombie waittill("death");
	self notify("stop_zombie_rise_dust_fx");
}

//Function Number: 89
get_rise_death_anim()
{
	if(self.zombie_rise_death_out)
	{
		return "zm_rise_death_out";
	}

	self.noragdoll = 1;
	self.nodeathragdoll = 1;
	return "zm_rise_death_in";
}

//Function Number: 90
zombie_tesla_head_gib()
{
	self endon("death");
	if(self.animname == "quad_zombie")
	{
		return;
	}

	if(randomint(100) < level.zombie_vars["tesla_head_gib_chance"])
	{
		wait(randomfloatrange(0.53,1));
		self zombie_head_gib();
	}
	else
	{
		network_safe_play_fx_on_tag("tesla_death_fx",2,level._effect["tesla_shock_eyes"],self,"J_Eyeball_LE");
	}
}

//Function Number: 91
play_ambient_zombie_vocals()
{
	self endon("death");
	if(self.animname == "monkey_zombie" || IsDefined(self.is_avogadro) && self.is_avogadro)
	{
		return;
	}

	while(1)
	{
		type = "ambient";
		float = 2;
		if(!(IsDefined(self.zombie_move_speed)))
		{
			wait(0.5);
			continue;
		}

		switch(self.zombie_move_speed)
		{
			case "walk":
				type = "ambient";
				float = 4;
				break;

			case "run":
				type = "sprint";
				float = 4;
				break;

			case "sprint":
				type = "sprint";
				float = 4;
				break;
		}

		if(self.animname == "zombie" && !self.has_legs)
		{
			type = "crawler";
		}
		else if(self.animname == "thief_zombie" || self.animname == "leaper_zombie")
		{
			float = 1.2;
		}

		name = self.animname;
		if(IsDefined(self.sndname))
		{
			name = self.sndname;
		}

		self thread maps/mp/zombies/_zm_audio::do_zombies_playvocals(type,name);
		wait(randomfloatrange(1,float));
	}
}

//Function Number: 92
zombie_complete_emerging_into_playable_area()
{
	self.completed_emerging_into_playable_area = 1;
	self notify("completed_emerging_into_playable_area");
	self.no_powerups = 0;
	self thread zombie_free_cam_allowed();
}

//Function Number: 93
zombie_free_cam_allowed()
{
	self endon("death");
	wait(1.5);
	self setfreecameralockonallowed(1);
}