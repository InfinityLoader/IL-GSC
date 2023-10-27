/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_utility.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 306
 * Decompile Time: 359 ms
 * Timestamp: 10/27/2023 3:06:21 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/animscripts/zm_run;
#include maps/mp/animscripts/zm_utility;
#include maps/mp/gametypes_zm/_hud_message;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_buildables;
#include maps/mp/zombies/_zm_equipment;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_power;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/zombies/_zm_server_throttle;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/zombies/_zm_weapons;

//Function Number: 1
init_utility()
{
}

//Function Number: 2
is_classic()
{
	var = GetDvar(#"6B64B9B4");
	if(var == "zclassic")
	{
		return 1;
	}
}

//Function Number: 3
is_standard()
{
	var = GetDvar(#"41651E");
	if(var == "zstandard")
	{
		return 1;
	}
}

//Function Number: 4
convertsecondstomilliseconds(seconds)
{
	return seconds * 1000;
}

//Function Number: 5
is_player()
{
	return isplayer(self) || IsDefined(self.pers) && IsDefined(self.pers["isBot"]) && self.pers["isBot"];
}

//Function Number: 6
lerp(chunk)
{
	link = spawn("script_origin",self getorigin());
	link.angles = self.first_node.angles;
	self linkto(link);
	link rotateto(self.first_node.angles,level._contextual_grab_lerp_time);
	link moveto(self.attacking_spot,level._contextual_grab_lerp_time);
	link waittill_multiple("rotatedone","movedone");
	self unlink();
	link delete();
}

//Function Number: 7
clear_mature_blood()
{
	blood_patch = getentarray("mature_blood","targetname");
	if(is_mature())
	{
		return;
	}

	if(IsDefined(blood_patch))
	{
		for(i = 0;i < blood_patch.size;i++)
		{
			blood_patch[i] delete();
		}
	}
}

//Function Number: 8
recalc_zombie_array()
{
}

//Function Number: 9
clear_all_corpses()
{
	corpse_array = getcorpsearray();
	for(i = 0;i < corpse_array.size;i++)
	{
		if(IsDefined(corpse_array[i]))
		{
			corpse_array[i] delete();
		}
	}
}

//Function Number: 10
get_current_corpse_count()
{
	corpse_array = getcorpsearray();
	if(IsDefined(corpse_array))
	{
		return corpse_array.size;
	}
}

//Function Number: 11
get_current_actor_count()
{
	count = 0;
	actors = getaispeciesarray(level.zombie_team,"all");
	if(IsDefined(actors))
	{
		count = count + actors.size;
	}

	count = count + get_current_corpse_count();
	return count;
}

//Function Number: 12
get_current_zombie_count()
{
	enemies = get_round_enemy_array();
	return enemies.size;
}

//Function Number: 13
get_round_enemy_array()
{
	enemies = [];
	valid_enemies = [];
	enemies = getaispeciesarray(level.zombie_team,"all");
	for(i = 0;i < enemies.size;i++)
	{
		if(IsDefined(enemies[i].ignore_enemy_count) && enemies[i].ignore_enemy_count)
		{
		}
		else
		{
			valid_enemies[valid_enemies.size] = enemies[i];
		}
	}

	return valid_enemies;
}

//Function Number: 14
init_zombie_run_cycle()
{
	if(IsDefined(level.speed_change_round))
	{
		if(level.round_number >= level.speed_change_round)
		{
			speed_percent = 0.2 + level.round_number - level.speed_change_round * 0.2;
			speed_percent = min(speed_percent,1);
			change_round_max = int(level.speed_change_max * speed_percent);
			change_left = change_round_max - level.speed_change_num;
			if(change_left == 0)
			{
				self set_zombie_run_cycle();
				return;
			}

			change_speed = randomint(100);
			if(change_speed > 80)
			{
				self change_zombie_run_cycle();
				return;
			}

			zombie_count = get_current_zombie_count();
			zombie_left = level.zombie_ai_limit - zombie_count;
			if(zombie_left == change_left)
			{
				self change_zombie_run_cycle();
				return;
			}
		}
	}

	self set_zombie_run_cycle();
}

//Function Number: 15
change_zombie_run_cycle()
{
	level.speed_change_num++;
	if(level.gamedifficulty == 0)
	{
		self set_zombie_run_cycle("sprint");
	}
	else
	{
		self set_zombie_run_cycle("walk");
	}

	self thread speed_change_watcher();
}

//Function Number: 16
speed_change_watcher()
{
	self waittill("death");
	if(level.speed_change_num > 0)
	{
		level.speed_change_num--;
	}
}

//Function Number: 17
set_zombie_run_cycle(new_move_speed)
{
	self.zombie_move_speed_original = self.zombie_move_speed;
	if(IsDefined(new_move_speed))
	{
		self.zombie_move_speed = new_move_speed;
	}
	else if(level.gamedifficulty == 0)
	{
		self set_run_speed_easy();
	}
	else
	{
		self set_run_speed();
	}

	self maps/mp/animscripts/zm_run::needsupdate();
	self.deathanim = self maps/mp/animscripts/zm_utility::append_missing_legs_suffix("zm_death");
}

//Function Number: 18
set_run_speed()
{
	rand = randomintrange(level.zombie_move_speed,level.zombie_move_speed + 35);
	if(rand <= 35)
	{
		self.zombie_move_speed = "walk";
	}
	else if(rand <= 70)
	{
		self.zombie_move_speed = "run";
	}
	else
	{
		self.zombie_move_speed = "sprint";
	}
}

//Function Number: 19
set_run_speed_easy()
{
	rand = randomintrange(level.zombie_move_speed,level.zombie_move_speed + 25);
	if(rand <= 35)
	{
		self.zombie_move_speed = "walk";
	}
	else
	{
		self.zombie_move_speed = "run";
	}
}

//Function Number: 20
spawn_zombie(spawner,target_name,spawn_point,round_number)
{
	if(!(IsDefined(spawner)))
	{
/#
		println("ZM >> spawn_zombie - NO SPAWNER DEFINED");
#/
		return undefined;
	}

	while(getfreeactorcount() < 1)
	{
		wait(0.05);
	}

	spawner.script_moveoverride = 1;
	if(IsDefined(spawner.script_forcespawn) && spawner.script_forcespawn)
	{
		guy = spawner spawnactor();
		if(IsDefined(level.giveextrazombies))
		{
			guy [[ level.giveextrazombies ]]();
		}

		guy enableaimassist();
		if(IsDefined(round_number))
		{
			guy._starting_round_number = round_number;
		}

		guy.aiteam = level.zombie_team;
		guy clearentityowner();
		level.zombiemeleeplayercounter = 0;
		guy thread run_spawn_functions();
		guy forceteleport(spawner.origin);
		guy show();
	}

	spawner.count = 666;
	if(!(spawn_failed(guy)))
	{
		if(IsDefined(target_name))
		{
			guy.targetname = target_name;
		}

		return guy;
	}
}

//Function Number: 21
run_spawn_functions()
{
	self endon("death");
	waittillframeend;
	for(i = 0;i < level.spawn_funcs[self.team].size;i++)
	{
		func = level.spawn_funcs[self.team][i];
		single_thread(self,func["function"],func["param1"],func["param2"],func["param3"],func["param4"],func["param5"]);
	}

	if(IsDefined(self.spawn_funcs))
	{
		for(i = 0;i < self.spawn_funcs.size;i++)
		{
			func = self.spawn_funcs[i];
			single_thread(self,func["function"],func["param1"],func["param2"],func["param3"],func["param4"]);
		}

/#
		self.saved_spawn_functions = self.spawn_funcs;
#/
		self.spawn_funcs = undefined;
/#
		self.spawn_funcs = self.saved_spawn_functions;
		self.saved_spawn_functions = undefined;
#/
		self.spawn_funcs = undefined;
	}
}

//Function Number: 22
create_simple_hud(client,team)
{
	if(IsDefined(team))
	{
		hud = newteamhudelem(team);
		hud.team = team;
	}
	else if(IsDefined(client))
	{
		hud = newclienthudelem(client);
	}
	else
	{
		hud = newhudelem();
	}

	level.hudelem_count++;
	hud.foreground = 1;
	hud.sort = 1;
	hud.hidewheninmenu = 0;
	return hud;
}

//Function Number: 23
destroy_hud()
{
	level.hudelem_count--;
	self destroy();
}

//Function Number: 24
all_chunks_intact(barrier,barrier_chunks)
{
	if(IsDefined(barrier.zbarrier))
	{
		pieces = barrier.zbarrier getzbarrierpieceindicesinstate("closed");
		if(pieces.size != barrier.zbarrier getnumzbarrierpieces())
		{
			return 0;
		}
	}
	else
	{
		for(i = 0;i < barrier_chunks.size;i++)
		{
			if(barrier_chunks[i] get_chunk_state() != "repaired")
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 25
no_valid_repairable_boards(barrier,barrier_chunks)
{
	if(IsDefined(barrier.zbarrier))
	{
		pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");
		if(pieces.size)
		{
			return 0;
		}
	}
	else
	{
		for(i = 0;i < barrier_chunks.size;i++)
		{
			if(barrier_chunks[i] get_chunk_state() == "destroyed")
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 26
is_survival()
{
	var = GetDvar(#"6B64B9B4");
	if(var == "zsurvival")
	{
		return 1;
	}
}

//Function Number: 27
is_encounter()
{
	if(IsDefined(level._is_encounter) && level._is_encounter)
	{
		return 1;
	}

	var = GetDvar(#"6B64B9B4");
	if(var == "zencounter")
	{
		level._is_encounter = 1;
		return 1;
	}
}

//Function Number: 28
all_chunks_destroyed(barrier,barrier_chunks)
{
	if(IsDefined(barrier.zbarrier))
	{
		pieces = arraycombine(barrier.zbarrier getzbarrierpieceindicesinstate("open"),barrier.zbarrier getzbarrierpieceindicesinstate("opening"),1,0);
		if(pieces.size != barrier.zbarrier getnumzbarrierpieces())
		{
			return 0;
		}
	}
	else if(IsDefined(barrier_chunks))
	{
/#
			assert(IsDefined(barrier_chunks),"_zm_utility::all_chunks_destroyed - Barrier chunks undefined");
#/
		for(i = 0;i < barrier_chunks.size;i++)
		{
			if(barrier_chunks[i] get_chunk_state() != "destroyed")
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 29
check_point_in_playable_area(origin)
{
	playable_area = getentarray("player_volume","script_noteworthy");
	check_model = spawn("script_model",40 + VectorScale((0,0,1)));
	valid_point = 0;
	for(i = 0;i < playable_area.size;i++)
	{
		if(check_model istouching(playable_area[i]))
		{
			valid_point = 1;
		}
	}

	check_model delete();
	return valid_point;
}

//Function Number: 30
check_point_in_enabled_zone(origin,zone_is_active,player_zones)
{
	if(!(IsDefined(player_zones)))
	{
		player_zones = getentarray("player_volume","script_noteworthy");
	}

	if(!IsDefined(level.zones) || !IsDefined(player_zones))
	{
		return 1;
	}

	scr_org = spawn("script_origin",40 + VectorScale((0,0,1)));
	one_valid_zone = 0;
	for(i = 0;i < player_zones.size;i++)
	{
		if(scr_org istouching(player_zones[i]))
		{
			zone = level.zones[player_zones[i].targetname];
			if(IsDefined(zone) && IsDefined(zone.is_enabled) && zone.is_enabled)
			{
				if(IsDefined(zone_is_active) && zone_is_active == 1 && !IsDefined(zone.is_active) && zone.is_active)
				{
				}
				else
				{
					one_valid_zone = 1;
					break;
				}
			}
		}
	}

	scr_org delete();
	return one_valid_zone;
}

//Function Number: 31
round_up_to_ten(score)
{
	new_score = score - score % 10;
	if(new_score < score)
	{
		new_score = new_score + 10;
	}

	return new_score;
}

//Function Number: 32
round_up_score(score,value)
{
	score = int(score);
	new_score = score - score % value;
	if(new_score < score)
	{
		new_score = new_score + value;
	}

	return new_score;
}

//Function Number: 33
random_tan()
{
	rand = randomint(100);
	if(IsDefined(level.char_percent_override))
	{
		percentnotcharred = level.char_percent_override;
	}
	else
	{
		percentnotcharred = 65;
	}
}

//Function Number: 34
places_before_decimal(num)
{
	abs_num = Abs(num);
	count = 0;
	while(1)
	{
		abs_num = abs_num * 0.1;
		count = count + 1;
		if(abs_num < 1)
		{
			return count;
		}
	}
}

//Function Number: 35
create_zombie_point_of_interest(attract_dist,num_attractors,added_poi_value,start_turned_on,initial_attract_func,arrival_attract_func,poi_team)
{
	if(!(IsDefined(added_poi_value)))
	{
		self.added_poi_value = 0;
	}
	else
	{
		self.added_poi_value = added_poi_value;
	}

	if(!(IsDefined(start_turned_on)))
	{
		start_turned_on = 1;
	}

	self.script_noteworthy = "zombie_poi";
	self.poi_active = start_turned_on;
	if(IsDefined(attract_dist))
	{
		self.poi_radius = attract_dist * attract_dist;
	}
	else
	{
		self.poi_radius = undefined;
	}

	self.num_poi_attracts = num_attractors;
	self.attract_to_origin = 1;
	self.attractor_array = [];
	self.initial_attract_func = undefined;
	self.arrival_attract_func = undefined;
	if(IsDefined(poi_team))
	{
		self._team = poi_team;
	}

	if(IsDefined(initial_attract_func))
	{
		self.initial_attract_func = initial_attract_func;
	}

	if(IsDefined(arrival_attract_func))
	{
		self.arrival_attract_func = arrival_attract_func;
	}
}

//Function Number: 36
create_zombie_point_of_interest_attractor_positions(num_attract_dists,diff_per_dist,attractor_width)
{
	self endon("death");
	forward = (0,1,0);
	if(!IsDefined(self.num_poi_attracts) || IsDefined(self.script_noteworthy) && self.script_noteworthy != "zombie_poi")
	{
		return;
	}

	if(!(IsDefined(num_attract_dists)))
	{
		num_attract_dists = 4;
	}

	if(!(IsDefined(diff_per_dist)))
	{
		diff_per_dist = 45;
	}

	if(!(IsDefined(attractor_width)))
	{
		attractor_width = 45;
	}

	self.attract_to_origin = 0;
	self.num_attract_dists = num_attract_dists;
	self.last_index = [];
	for(i = 0;i < num_attract_dists;i++)
	{
		self.last_index[i] = -1;
	}

	self.attract_dists = [];
	for(i = 0;i < self.num_attract_dists;i++)
	{
		self.attract_dists[i] = diff_per_dist * i + 1;
	}

	max_positions = [];
	for(i = 0;i < self.num_attract_dists;i++)
	{
		max_positions[i] = int(6.28 * self.attract_dists[i] / attractor_width);
	}

	num_attracts_per_dist = self.num_poi_attracts / self.num_attract_dists;
	self.max_attractor_dist = self.attract_dists[self.attract_dists.size - 1] * 1.1;
	diff = 0;
	actual_num_positions = [];
	for(i = 0;i < self.num_attract_dists;i++)
	{
		if(num_attracts_per_dist > max_positions[i] + diff)
		{
			actual_num_positions[i] = max_positions[i];
			diff = diff + num_attracts_per_dist - max_positions[i];
		}
		else
		{
			actual_num_positions[i] = num_attracts_per_dist + diff;
			diff = 0;
		}
	}

	self.attractor_positions = [];
	failed = 0;
	angle_offset = 0;
	prev_last_index = -1;
	for(j = 0;j < 4;j++)
	{
		if(actual_num_positions[j] + failed < max_positions[j])
		{
			actual_num_positions[j] = actual_num_positions[j] + failed;
			failed = 0;
		}
		else if(actual_num_positions[j] < max_positions[j])
		{
			actual_num_positions[j] = max_positions[j];
			failed = max_positions[j] - actual_num_positions[j];
		}

		failed = failed + self generated_radius_attract_positions(forward,angle_offset,actual_num_positions[j],self.attract_dists[j]);
		angle_offset = angle_offset + 15;
		self.last_index[j] = int(actual_num_positions[j] - failed + prev_last_index);
		prev_last_index = self.last_index[j];
	}

	self notify("attractor_positions_generated");
	level notify("attractor_positions_generated");
}

//Function Number: 37
generated_radius_attract_positions(forward,offset,num_positions,attract_radius)
{
	self endon("death");
	epsilon = 0.1;
	failed = 0;
	degs_per_pos = 360 / num_positions;
	for(i = offset;i < 360 + offset;i = i + degs_per_pos)
	{
		altforward = forward * attract_radius;
		rotated_forward = (cos(i) * altforward[0] - sin(i) * altforward[1],sin(i) * altforward[0] + cos(i) * altforward[1],altforward[2]);
		if(IsDefined(level.poi_positioning_func))
		{
			pos = [[ level.poi_positioning_func ]](self.origin,rotated_forward);
		}
		else if(IsDefined(level.use_alternate_poi_positioning) && level.use_alternate_poi_positioning)
		{
			pos = maps/mp/zombies/_zm_server_throttle::server_safe_ground_trace("poi_trace",10,10 + VectorScale((0,0,1)));
		}
		else
		{
			pos = maps/mp/zombies/_zm_server_throttle::server_safe_ground_trace("poi_trace",10,100 + VectorScale((0,0,1)));
		}

		if(!(IsDefined(pos)))
		{
			failed++;
		}
		else if(IsDefined(level.use_alternate_poi_positioning) && level.use_alternate_poi_positioning)
		{
			if(IsDefined(self) && IsDefined(self.origin))
			{
				if(self.origin[2] >= pos[2] - epsilon && self.origin[2] - pos[2] <= 150)
				{
					pos_array = [];
					pos_array[0] = pos;
					pos_array[1] = self;
					self.attractor_positions[self.attractor_positions.size] = pos_array;
				}

				continue;
			}

			failed++;
		}
		else if(Abs(pos[2] - self.origin[2]) < 60)
		{
			pos_array = [];
			pos_array[0] = pos;
			pos_array[1] = self;
			self.attractor_positions[self.attractor_positions.size] = pos_array;
		}
		else
		{
			failed++;
		}
	}

	return failed;
}

//Function Number: 38
debug_draw_attractor_positions()
{
/#
	for(;;)
	{
		wait(0.05);
		i = 0;
		for(;;)
		{
			line(self.origin,self.attractor_positions[i][0],(1,0,0),1,1);
			i++;
		}
		wait(0.05);
		return;
	}
IsDefined(self)
i < self.attractor_positions.size
IsDefined(self.attractor_positions)
1
#/
}

//Function Number: 39
get_zombie_point_of_interest(origin,poi_array)
{
	if(IsDefined(self.ignore_all_poi) && self.ignore_all_poi)
	{
		return undefined;
	}

	curr_radius = undefined;
	if(IsDefined(poi_array))
	{
		ent_array = poi_array;
	}
	else
	{
		ent_array = getentarray("zombie_poi","script_noteworthy");
	}

	best_poi = undefined;
	position = undefined;
	best_dist = 100000000;
	for(i = 0;i < ent_array.size;i++)
	{
		if(!IsDefined(ent_array[i].poi_active) || !ent_array[i].poi_active)
		{
		}
		else if(IsDefined(self.ignore_poi_targetname) && self.ignore_poi_targetname.size > 0)
		{
			if(IsDefined(ent_array[i].targetname))
			{
				ignore = 0;
				for(j = 0;j < self.ignore_poi_targetname.size;j++)
				{
					if(ent_array[i].targetname == self.ignore_poi_targetname[j])
					{
						ignore = 1;
						break;
					}
				}

				if(ignore)
				{
				}
				else if(IsDefined(self.ignore_poi) && self.ignore_poi.size > 0)
				{
					ignore = 0;
					for(j = 0;j < self.ignore_poi.size;j++)
					{
						if(self.ignore_poi[j] == ent_array[i])
						{
							ignore = 1;
							break;
						}
					}

					if(ignore)
					{
					}
					else
					{
						dist = distancesquared(origin,ent_array[i].origin);
						dist = dist - ent_array[i].added_poi_value;
						if(IsDefined(ent_array[i].poi_radius))
						{
							curr_radius = ent_array[i].poi_radius;
						}

						if((!IsDefined(curr_radius) || dist < curr_radius) && dist < best_dist && ent_array[i] can_attract(self))
						{
							best_poi = ent_array[i];
							best_dist = dist;
						}
					}
				}
			}
		}
	}

	if(IsDefined(best_poi))
	{
		if(IsDefined(best_poi._team))
		{
			if(IsDefined(self._race_team) && self._race_team != best_poi._team)
			{
				return undefined;
			}
		}

		if(IsDefined(best_poi._new_ground_trace) && best_poi._new_ground_trace)
		{
			position = [];
			position[0] = groundpos_ignore_water_new(100 + VectorScale((0,0,1)));
			position[1] = self;
		}
		else if(IsDefined(best_poi.attract_to_origin) && best_poi.attract_to_origin)
		{
			position = [];
			position[0] = groundpos(100 + VectorScale((0,0,1)));
			position[1] = self;
		}
		else
		{
			position = self add_poi_attractor(best_poi);
		}

		if(IsDefined(best_poi.initial_attract_func))
		{
			self thread [[ best_poi.initial_attract_func ]](best_poi);
		}

		if(IsDefined(best_poi.arrival_attract_func))
		{
			self thread [[ best_poi.arrival_attract_func ]](best_poi);
		}
	}

	return position;
}

//Function Number: 40
activate_zombie_point_of_interest()
{
	if(self.script_noteworthy != "zombie_poi")
	{
		return;
	}

	self.poi_active = 1;
}

//Function Number: 41
deactivate_zombie_point_of_interest()
{
	if(self.script_noteworthy != "zombie_poi")
	{
		return;
	}

	for(i = 0;i < self.attractor_array.size;i++)
	{
		self.attractor_array[i] notify("kill_poi");
	}

	self.attractor_array = [];
	self.claimed_attractor_positions = [];
	self.poi_active = 0;
}

//Function Number: 42
assign_zombie_point_of_interest(origin,poi)
{
	position = undefined;
	doremovalthread = 0;
	if(IsDefined(poi) && poi can_attract(self))
	{
		if(!IsDefined(poi.attractor_array) || IsDefined(poi.attractor_array) && array_check_for_dupes(poi.attractor_array,self))
		{
			doremovalthread = 1;
		}

		position = self add_poi_attractor(poi);
		if(IsDefined(position) && doremovalthread && !array_check_for_dupes(poi.attractor_array,self))
		{
			self thread update_on_poi_removal(poi);
		}
	}

	return position;
}

//Function Number: 43
remove_poi_attractor(zombie_poi)
{
	if(!(IsDefined(zombie_poi.attractor_array)))
	{
		return;
	}

	for(i = 0;i < zombie_poi.attractor_array.size;i++)
	{
		if(zombie_poi.attractor_array[i] == self)
		{
			self notify("kill_poi");
			arrayremovevalue(zombie_poi.attractor_array,zombie_poi.attractor_array[i]);
			arrayremovevalue(zombie_poi.claimed_attractor_positions,zombie_poi.claimed_attractor_positions[i]);
		}
	}
}

//Function Number: 44
array_check_for_dupes_using_compare(array,single,is_equal_fn)
{
	for(i = 0;i < array.size;i++)
	{
		if([[ is_equal_fn ]](array[i],single))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 45
poi_locations_equal(loc1,loc2)
{
	return loc1[0] == loc2[0];
}

//Function Number: 46
add_poi_attractor(zombie_poi)
{
	if(!(IsDefined(zombie_poi)))
	{
		return;
	}

	if(!(IsDefined(zombie_poi.attractor_array)))
	{
		zombie_poi.attractor_array = [];
	}

	if(array_check_for_dupes(zombie_poi.attractor_array,self))
	{
		if(!(IsDefined(zombie_poi.claimed_attractor_positions)))
		{
			zombie_poi.claimed_attractor_positions = [];
		}

		if(!IsDefined(zombie_poi.attractor_positions) || zombie_poi.attractor_positions.size <= 0)
		{
			return undefined;
		}

		start = -1;
		end = -1;
		last_index = -1;
		for(i = 0;i < 4;i++)
		{
			if(zombie_poi.claimed_attractor_positions.size < zombie_poi.last_index[i])
			{
				start = last_index + 1;
				end = zombie_poi.last_index[i];
				break;
			}

			last_index = zombie_poi.last_index[i];
		}

		best_dist = 100000000;
		best_pos = undefined;
		if(start < 0)
		{
			start = 0;
		}

		if(end < 0)
		{
			return undefined;
		}

		for(i = int(start);i <= int(end);i++)
		{
			if(!(IsDefined(zombie_poi.attractor_positions[i])))
			{
			}
			else if(array_check_for_dupes_using_compare(zombie_poi.claimed_attractor_positions,zombie_poi.attractor_positions[i],::poi_locations_equal))
			{
				if(IsDefined(zombie_poi.attractor_positions[i][0]) && IsDefined(self.origin))
				{
					dist = distancesquared(zombie_poi.attractor_positions[i][0],self.origin);
					if(dist < best_dist || !IsDefined(best_pos))
					{
						best_dist = dist;
						best_pos = zombie_poi.attractor_positions[i];
					}
				}
			}
		}

		if(!(IsDefined(best_pos)))
		{
			return undefined;
		}

		zombie_poi.attractor_array[zombie_poi.attractor_array.size] = self;
		self thread update_poi_on_death(zombie_poi);
		zombie_poi.claimed_attractor_positions[zombie_poi.claimed_attractor_positions.size] = best_pos;
		return best_pos;
	}
	else
	{
		for(i = 0;i < zombie_poi.attractor_array.size;i++)
		{
			if(zombie_poi.attractor_array[i] == self)
			{
				if(IsDefined(zombie_poi.claimed_attractor_positions) && IsDefined(zombie_poi.claimed_attractor_positions[i]))
				{
					return zombie_poi.claimed_attractor_positions[i];
				}
			}
		}
	}

	return undefined;
}

//Function Number: 47
can_attract(attractor)
{
	if(!(IsDefined(self.attractor_array)))
	{
		self.attractor_array = [];
	}

	if(IsDefined(self.attracted_array) && !isinarray(self.attracted_array,attractor))
	{
		return 0;
	}

	if(!(array_check_for_dupes(self.attractor_array,attractor)))
	{
		return 1;
	}

	if(IsDefined(self.num_poi_attracts) && self.attractor_array.size >= self.num_poi_attracts)
	{
		return 0;
	}
}

//Function Number: 48
update_poi_on_death(zombie_poi)
{
	self endon("kill_poi");
	self waittill("death");
	self remove_poi_attractor(zombie_poi);
}

//Function Number: 49
update_on_poi_removal(zombie_poi)
{
	zombie_poi waittill("death");
	if(!(IsDefined(zombie_poi.attractor_array)))
	{
		return;
	}

	for(i = 0;i < zombie_poi.attractor_array.size;i++)
	{
		if(zombie_poi.attractor_array[i] == self)
		{
			arrayremoveindex(zombie_poi.attractor_array,i);
			arrayremoveindex(zombie_poi.claimed_attractor_positions,i);
		}
	}
}

//Function Number: 50
invalidate_attractor_pos(attractor_pos,zombie)
{
	if(!IsDefined(self) || !IsDefined(attractor_pos))
	{
		wait(0.1);
		return undefined;
	}

	if(IsDefined(self.attractor_positions) && !array_check_for_dupes_using_compare(self.attractor_positions,attractor_pos,::poi_locations_equal))
	{
		index = 0;
		for(i = 0;i < self.attractor_positions.size;i++)
		{
			if(poi_locations_equal(self.attractor_positions[i],attractor_pos))
			{
				index = i;
			}
		}

		for(i = 0;i < self.last_index.size;i++)
		{
			if(index <= self.last_index[i])
			{
				self.last_index[i]--;
			}
		}

		arrayremovevalue(self.attractor_array,zombie);
		arrayremovevalue(self.attractor_positions,attractor_pos);
		for(i = 0;i < self.claimed_attractor_positions.size;i++)
		{
			if(self.claimed_attractor_positions[i][0] == attractor_pos[0])
			{
				arrayremovevalue(self.claimed_attractor_positions,self.claimed_attractor_positions[i]);
			}
		}
	}
	else
	{
		wait(0.1);
	}

	return get_zombie_point_of_interest(zombie.origin);
}

//Function Number: 51
remove_poi_from_ignore_list(poi)
{
	if(IsDefined(self.ignore_poi) && self.ignore_poi.size > 0)
	{
		for(i = 0;i < self.ignore_poi.size;i++)
		{
			if(self.ignore_poi[i] == poi)
			{
				arrayremovevalue(self.ignore_poi,self.ignore_poi[i]);
				return;
			}
		}
	}
}

//Function Number: 52
add_poi_to_ignore_list(poi)
{
	if(!(IsDefined(self.ignore_poi)))
	{
		self.ignore_poi = [];
	}

	add_poi = 1;
	if(self.ignore_poi.size > 0)
	{
		for(i = 0;i < self.ignore_poi.size;i++)
		{
			if(self.ignore_poi[i] == poi)
			{
				add_poi = 0;
				break;
			}
		}
	}

	if(add_poi)
	{
		self.ignore_poi[self.ignore_poi.size] = poi;
	}
}

//Function Number: 53
default_validate_enemy_path_length(player)
{
	max_dist = 1296;
	d = distancesquared(self.origin,player.origin);
	if(d <= max_dist)
	{
		return 1;
	}

	return 0;
}

//Function Number: 54
get_path_length_to_enemy(enemy)
{
	path_length = self calcpathlength(enemy.origin);
	return path_length;
}

//Function Number: 55
get_closest_player_using_paths(origin,players)
{
	min_length_to_player = 9999999;
	n_2d_distance_squared = 9999999;
	player_to_return = undefined;
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		length_to_player = get_path_length_to_enemy(player);
		if(IsDefined(level.validate_enemy_path_length))
		{
			if(length_to_player == 0)
			{
				valid = self thread [[ level.validate_enemy_path_length ]](player);
				if(!(valid))
				{
				}
				else if(length_to_player < min_length_to_player)
				{
					min_length_to_player = length_to_player;
					player_to_return = player;
					n_2d_distance_squared = distance2dsquared(self.origin,player.origin);
				}
				else if(length_to_player == min_length_to_player && length_to_player <= 5)
				{
					n_new_distance = distance2dsquared(self.origin,player.origin);
					if(n_new_distance < n_2d_distance_squared)
					{
						min_length_to_player = length_to_player;
						player_to_return = player;
						n_2d_distance_squared = n_new_distance;
					}
				}
			}
		}
	}

	return player_to_return;
}

//Function Number: 56
get_closest_valid_player(origin,ignore_player)
{
	valid_player_found = 0;
	players = get_players();
	if(IsDefined(level._zombie_using_humangun) && level._zombie_using_humangun)
	{
		players = arraycombine(players,level._zombie_human_array,0,0);
	}

	if(IsDefined(ignore_player))
	{
		for(i = 0;i < ignore_player.size;i++)
		{
			arrayremovevalue(players,ignore_player[i]);
		}
	}

	done = 0;
	while(players.size && !done)
	{
		done = 1;
		for(i = 0;i < players.size;i++)
		{
			player = players[i];
			if(!(is_player_valid(player,1)))
			{
				arrayremovevalue(players,player);
				done = 0;
				break;
			}
		}
	}

	if(players.size == 0)
	{
		return undefined;
	}

	while(!(valid_player_found))
	{
		if(IsDefined(self.closest_player_override))
		{
			player = [[ self.closest_player_override ]](origin,players);
		}
		else if(IsDefined(level.closest_player_override))
		{
			player = [[ level.closest_player_override ]](origin,players);
		}
		else if(IsDefined(level.calc_closest_player_using_paths) && level.calc_closest_player_using_paths)
		{
			player = get_closest_player_using_paths(origin,players);
		}
		else
		{
			player = getclosest(origin,players);
		}

		if(!IsDefined(player) || players.size == 0)
		{
			return undefined;
		}

		if(IsDefined(level._zombie_using_humangun) && level._zombie_using_humangun && isai(player))
		{
			return player;
		}

		if(!(is_player_valid(player,1)))
		{
			arrayremovevalue(players,player);
			if(players.size == 0)
			{
				return undefined;
			}

			continue;
		}

		return player;
	}
}

//Function Number: 57
is_player_valid(player,checkignoremeflag,ignore_laststand_players)
{
	if(!(IsDefined(player)))
	{
		return 0;
	}

	if(!(isalive(player)))
	{
		return 0;
	}

	if(!(isplayer(player)))
	{
		return 0;
	}

	if(IsDefined(player.is_zombie) && player.is_zombie == 1)
	{
		return 0;
	}

	if(player.sessionstate == "spectator")
	{
		return 0;
	}

	if(player.sessionstate == "intermission")
	{
		return 0;
	}

	if(IsDefined(self.intermission) && self.intermission)
	{
		return 0;
	}

	if(!(IsDefined(ignore_laststand_players) && ignore_laststand_players))
	{
		if(player maps/mp/zombies/_zm_laststand::player_is_in_laststand())
		{
			return 0;
		}
	}

	if(IsDefined(checkignoremeflag) && checkignoremeflag && player.ignoreme)
	{
		return 0;
	}

	if(IsDefined(level.is_player_valid_override))
	{
		return [[ level.is_player_valid_override ]](player);
	}
}

//Function Number: 58
get_number_of_valid_players()
{
	players = get_players();
	num_player_valid = 0;
	for(i = 0;i < players.size;i++)
	{
		if(is_player_valid(players[i]))
		{
			num_player_valid = num_player_valid + 1;
		}
	}

	return num_player_valid;
}

//Function Number: 59
in_revive_trigger()
{
	if(IsDefined(self.rt_time) && self.rt_time + 100 >= GetTime())
	{
		return self.in_rt_cached;
	}

	self.rt_time = GetTime();
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		current_player = players[i];
		if(IsDefined(current_player) && IsDefined(current_player.revivetrigger) && isalive(current_player))
		{
			if(self istouching(current_player.revivetrigger))
			{
				self.in_rt_cached = 1;
				return 1;
			}
		}
	}

	self.in_rt_cached = 0;
	return 0;
}

//Function Number: 60
get_closest_node(org,nodes)
{
	return getclosest(org,nodes);
}

//Function Number: 61
non_destroyed_bar_board_order(origin,chunks)
{
	first_bars = [];
	first_bars1 = [];
	first_bars2 = [];
	for(i = 0;i < chunks.size;i++)
	{
		if(IsDefined(chunks[i].script_team) && chunks[i].script_team == "classic_boards")
		{
			if(IsDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "board")
			{
				return get_closest_2d(origin,chunks);
			}
			else if((IsDefined(chunks[i].script_team) && chunks[i].script_team == "bar_board_variant1") || chunks[i].script_team == "bar_board_variant2" || chunks[i].script_team == "bar_board_variant4" || chunks[i].script_team == "bar_board_variant5")
			{
				return undefined;
			}
		}
		else if(IsDefined(chunks[i].script_team) && chunks[i].script_team == "new_barricade")
		{
			if(IsDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "repair_board" || chunks[i].script_parameters == "barricade_vents")
			{
				return get_closest_2d(origin,chunks);
			}
		}
	}

	for(i = 0;i < chunks.size;i++)
	{
		if((IsDefined(chunks[i].script_team) && chunks[i].script_team == "6_bars_bent") || chunks[i].script_team == "6_bars_prestine")
		{
			if(IsDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "bar")
			{
				if(IsDefined(chunks[i].script_noteworthy))
				{
					if(chunks[i].script_noteworthy == "4" || chunks[i].script_noteworthy == "6")
					{
						first_bars[first_bars.size] = chunks[i];
					}
				}
			}
		}
	}

	for(i = 0;i < first_bars.size;i++)
	{
		if((IsDefined(chunks[i].script_team) && chunks[i].script_team == "6_bars_bent") || chunks[i].script_team == "6_bars_prestine")
		{
			if(IsDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "bar")
			{
				if(!(first_bars[i].destroyed))
				{
					return first_bars[i];
				}
			}
		}
	}

	for(i = 0;i < chunks.size;i++)
	{
		if((IsDefined(chunks[i].script_team) && chunks[i].script_team == "6_bars_bent") || chunks[i].script_team == "6_bars_prestine")
		{
			if(IsDefined(chunks[i].script_parameters) && chunks[i].script_parameters == "bar")
			{
				if(!(chunks[i].destroyed))
				{
					return get_closest_2d(origin,chunks);
				}
			}
		}
	}
}

//Function Number: 62
non_destroyed_grate_order(origin,chunks_grate)
{
	grate_order = [];
	grate_order1 = [];
	grate_order2 = [];
	grate_order3 = [];
	grate_order4 = [];
	grate_order5 = [];
	grate_order6 = [];
	if(IsDefined(chunks_grate))
	{
		for(i = 0;i < chunks_grate.size;i++)
		{
			if(IsDefined(chunks_grate[i].script_parameters) && chunks_grate[i].script_parameters == "grate")
			{
				if(IsDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "1")
				{
					grate_order1[grate_order1.size] = chunks_grate[i];
				}

				if(IsDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "2")
				{
					grate_order2[grate_order2.size] = chunks_grate[i];
				}

				if(IsDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "3")
				{
					grate_order3[grate_order3.size] = chunks_grate[i];
				}

				if(IsDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "4")
				{
					grate_order4[grate_order4.size] = chunks_grate[i];
				}

				if(IsDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "5")
				{
					grate_order5[grate_order5.size] = chunks_grate[i];
				}

				if(IsDefined(chunks_grate[i].script_noteworthy) && chunks_grate[i].script_noteworthy == "6")
				{
					grate_order6[grate_order6.size] = chunks_grate[i];
				}
			}
		}

		for(i = 0;i < chunks_grate.size;i++)
		{
			if(IsDefined(chunks_grate[i].script_parameters) && chunks_grate[i].script_parameters == "grate")
			{
				if(IsDefined(grate_order1[i]))
				{
					if(grate_order1[i].state == "repaired")
					{
						grate_order2[i] thread show_grate_pull();
						return grate_order1[i];
					}

					if(grate_order2[i].state == "repaired")
					{
/#
						iprintlnbold(" pull bar2 ");
#/
						grate_order3[i] thread show_grate_pull();
						return grate_order2[i];
					}
					else if(grate_order3[i].state == "repaired")
					{
/#
							iprintlnbold(" pull bar3 ");
#/
						grate_order4[i] thread show_grate_pull();
						return grate_order3[i];
					}
					else if(grate_order4[i].state == "repaired")
					{
/#
								iprintlnbold(" pull bar4 ");
#/
						grate_order5[i] thread show_grate_pull();
						return grate_order4[i];
					}
					else if(grate_order5[i].state == "repaired")
					{
/#
									iprintlnbold(" pull bar5 ");
#/
						grate_order6[i] thread show_grate_pull();
						return grate_order5[i];
					}
					else if(grate_order6[i].state == "repaired")
					{
						return grate_order6[i];
					}
				}
			}
		}
	}
}

//Function Number: 63
non_destroyed_variant1_order(origin,chunks_variant1)
{
	variant1_order = [];
	variant1_order1 = [];
	variant1_order2 = [];
	variant1_order3 = [];
	variant1_order4 = [];
	variant1_order5 = [];
	variant1_order6 = [];
	if(IsDefined(chunks_variant1))
	{
		for(i = 0;i < chunks_variant1.size;i++)
		{
			if(IsDefined(chunks_variant1[i].script_team) && chunks_variant1[i].script_team == "bar_board_variant1")
			{
				if(IsDefined(chunks_variant1[i].script_noteworthy))
				{
					if(chunks_variant1[i].script_noteworthy == "1")
					{
						variant1_order1[variant1_order1.size] = chunks_variant1[i];
					}

					if(chunks_variant1[i].script_noteworthy == "2")
					{
						variant1_order2[variant1_order2.size] = chunks_variant1[i];
					}

					if(chunks_variant1[i].script_noteworthy == "3")
					{
						variant1_order3[variant1_order3.size] = chunks_variant1[i];
					}

					if(chunks_variant1[i].script_noteworthy == "4")
					{
						variant1_order4[variant1_order4.size] = chunks_variant1[i];
					}

					if(chunks_variant1[i].script_noteworthy == "5")
					{
						variant1_order5[variant1_order5.size] = chunks_variant1[i];
					}

					if(chunks_variant1[i].script_noteworthy == "6")
					{
						variant1_order6[variant1_order6.size] = chunks_variant1[i];
					}
				}
			}
		}

		for(i = 0;i < chunks_variant1.size;i++)
		{
			if(IsDefined(chunks_variant1[i].script_team) && chunks_variant1[i].script_team == "bar_board_variant1")
			{
				if(IsDefined(variant1_order2[i]))
				{
					if(variant1_order2[i].state == "repaired")
					{
						return variant1_order2[i];
					}
					else if(variant1_order3[i].state == "repaired")
					{
						return variant1_order3[i];
					}
					else if(variant1_order4[i].state == "repaired")
					{
						return variant1_order4[i];
					}
					else if(variant1_order6[i].state == "repaired")
					{
						return variant1_order6[i];
					}
					else if(variant1_order5[i].state == "repaired")
					{
						return variant1_order5[i];
					}
					else if(variant1_order1[i].state == "repaired")
					{
						return variant1_order1[i];
					}
				}
			}
		}
	}
}

//Function Number: 64
non_destroyed_variant2_order(origin,chunks_variant2)
{
	variant2_order = [];
	variant2_order1 = [];
	variant2_order2 = [];
	variant2_order3 = [];
	variant2_order4 = [];
	variant2_order5 = [];
	variant2_order6 = [];
	if(IsDefined(chunks_variant2))
	{
		for(i = 0;i < chunks_variant2.size;i++)
		{
			if(IsDefined(chunks_variant2[i].script_team) && chunks_variant2[i].script_team == "bar_board_variant2")
			{
				if(IsDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "1")
				{
					variant2_order1[variant2_order1.size] = chunks_variant2[i];
				}

				if(IsDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "2")
				{
					variant2_order2[variant2_order2.size] = chunks_variant2[i];
				}

				if(IsDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "3")
				{
					variant2_order3[variant2_order3.size] = chunks_variant2[i];
				}

				if(IsDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "4")
				{
					variant2_order4[variant2_order4.size] = chunks_variant2[i];
				}

				if(IsDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "5" && IsDefined(chunks_variant2[i].script_location) && chunks_variant2[i].script_location == "5")
				{
					variant2_order5[variant2_order5.size] = chunks_variant2[i];
				}

				if(IsDefined(chunks_variant2[i].script_noteworthy) && chunks_variant2[i].script_noteworthy == "5" && IsDefined(chunks_variant2[i].script_location) && chunks_variant2[i].script_location == "6")
				{
					variant2_order6[variant2_order6.size] = chunks_variant2[i];
				}
			}
		}

		for(i = 0;i < chunks_variant2.size;i++)
		{
			if(IsDefined(chunks_variant2[i].script_team) && chunks_variant2[i].script_team == "bar_board_variant2")
			{
				if(IsDefined(variant2_order1[i]))
				{
					if(variant2_order1[i].state == "repaired")
					{
						return variant2_order1[i];
					}
					else if(variant2_order2[i].state == "repaired")
					{
						return variant2_order2[i];
					}
					else if(variant2_order3[i].state == "repaired")
					{
						return variant2_order3[i];
					}
					else if(variant2_order5[i].state == "repaired")
					{
						return variant2_order5[i];
					}
					else if(variant2_order4[i].state == "repaired")
					{
						return variant2_order4[i];
					}
					else if(variant2_order6[i].state == "repaired")
					{
						return variant2_order6[i];
					}
				}
			}
		}
	}
}

//Function Number: 65
non_destroyed_variant4_order(origin,chunks_variant4)
{
	variant4_order = [];
	variant4_order1 = [];
	variant4_order2 = [];
	variant4_order3 = [];
	variant4_order4 = [];
	variant4_order5 = [];
	variant4_order6 = [];
	if(IsDefined(chunks_variant4))
	{
		for(i = 0;i < chunks_variant4.size;i++)
		{
			if(IsDefined(chunks_variant4[i].script_team) && chunks_variant4[i].script_team == "bar_board_variant4")
			{
				if(IsDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "1" && !IsDefined(chunks_variant4[i].script_location))
				{
					variant4_order1[variant4_order1.size] = chunks_variant4[i];
				}

				if(IsDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "2")
				{
					variant4_order2[variant4_order2.size] = chunks_variant4[i];
				}

				if(IsDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "3")
				{
					variant4_order3[variant4_order3.size] = chunks_variant4[i];
				}

				if(IsDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "1" && IsDefined(chunks_variant4[i].script_location) && chunks_variant4[i].script_location == "3")
				{
					variant4_order4[variant4_order4.size] = chunks_variant4[i];
				}

				if(IsDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "5")
				{
					variant4_order5[variant4_order5.size] = chunks_variant4[i];
				}

				if(IsDefined(chunks_variant4[i].script_noteworthy) && chunks_variant4[i].script_noteworthy == "6")
				{
					variant4_order6[variant4_order6.size] = chunks_variant4[i];
				}
			}
		}

		for(i = 0;i < chunks_variant4.size;i++)
		{
			if(IsDefined(chunks_variant4[i].script_team) && chunks_variant4[i].script_team == "bar_board_variant4")
			{
				if(IsDefined(variant4_order1[i]))
				{
					if(variant4_order1[i].state == "repaired")
					{
						return variant4_order1[i];
					}
					else if(variant4_order6[i].state == "repaired")
					{
						return variant4_order6[i];
					}
					else if(variant4_order3[i].state == "repaired")
					{
						return variant4_order3[i];
					}
					else if(variant4_order4[i].state == "repaired")
					{
						return variant4_order4[i];
					}
					else if(variant4_order2[i].state == "repaired")
					{
						return variant4_order2[i];
					}
					else if(variant4_order5[i].state == "repaired")
					{
						return variant4_order5[i];
					}
				}
			}
		}
	}
}

//Function Number: 66
non_destroyed_variant5_order(origin,chunks_variant5)
{
	variant5_order = [];
	variant5_order1 = [];
	variant5_order2 = [];
	variant5_order3 = [];
	variant5_order4 = [];
	variant5_order5 = [];
	variant5_order6 = [];
	if(IsDefined(chunks_variant5))
	{
		for(i = 0;i < chunks_variant5.size;i++)
		{
			if(IsDefined(chunks_variant5[i].script_team) && chunks_variant5[i].script_team == "bar_board_variant5")
			{
				if(IsDefined(chunks_variant5[i].script_noteworthy))
				{
					if(chunks_variant5[i].script_noteworthy == "1" && !IsDefined(chunks_variant5[i].script_location))
					{
						variant5_order1[variant5_order1.size] = chunks_variant5[i];
					}

					if(chunks_variant5[i].script_noteworthy == "2")
					{
						variant5_order2[variant5_order2.size] = chunks_variant5[i];
					}

					if(IsDefined(chunks_variant5[i].script_noteworthy) && chunks_variant5[i].script_noteworthy == "1" && IsDefined(chunks_variant5[i].script_location) && chunks_variant5[i].script_location == "3")
					{
						variant5_order3[variant5_order3.size] = chunks_variant5[i];
					}

					if(chunks_variant5[i].script_noteworthy == "4")
					{
						variant5_order4[variant5_order4.size] = chunks_variant5[i];
					}

					if(chunks_variant5[i].script_noteworthy == "5")
					{
						variant5_order5[variant5_order5.size] = chunks_variant5[i];
					}

					if(chunks_variant5[i].script_noteworthy == "6")
					{
						variant5_order6[variant5_order6.size] = chunks_variant5[i];
					}
				}
			}
		}

		for(i = 0;i < chunks_variant5.size;i++)
		{
			if(IsDefined(chunks_variant5[i].script_team) && chunks_variant5[i].script_team == "bar_board_variant5")
			{
				if(IsDefined(variant5_order1[i]))
				{
					if(variant5_order1[i].state == "repaired")
					{
						return variant5_order1[i];
					}
					else if(variant5_order6[i].state == "repaired")
					{
						return variant5_order6[i];
					}
					else if(variant5_order3[i].state == "repaired")
					{
						return variant5_order3[i];
					}
					else if(variant5_order2[i].state == "repaired")
					{
						return variant5_order2[i];
					}
					else if(variant5_order5[i].state == "repaired")
					{
						return variant5_order5[i];
					}
					else if(variant5_order4[i].state == "repaired")
					{
						return variant5_order4[i];
					}
				}
			}
		}
	}
}

//Function Number: 67
show_grate_pull()
{
	wait(0.53);
	self show();
	self vibrate(VectorScale((0,1,0)),270,0.2,0.4);
}

//Function Number: 68
get_closest_2d(origin,ents)
{
	if(!(IsDefined(ents)))
	{
		return undefined;
	}

	dist = distance2d(origin,ents[0].origin);
	index = 0;
	temp_array = [];
	for(i = 1;i < ents.size;i++)
	{
		if(IsDefined(ents[i].unbroken) && ents[i].unbroken == 1)
		{
			ents[i].index = i;
			temp_array[temp_array.size] = ents[i];
		}
	}

	if(temp_array.size > 0)
	{
		index = temp_array[randomintrange(0,temp_array.size)].index;
		return ents[index];
	}
	else
	{
		for(i = 1;i < ents.size;i++)
		{
			temp_dist = distance2d(origin,ents[i].origin);
			if(temp_dist < dist)
			{
				dist = temp_dist;
				index = i;
			}
		}

		return ents[index];
	}
}

//Function Number: 69
disable_trigger()
{
	if(!IsDefined(self.disabled) || !self.disabled)
	{
		self.disabled = 1;
		self.origin = 10000 - VectorScale((0,0,1));
	}
}

//Function Number: 70
enable_trigger()
{
	if(!IsDefined(self.disabled) || !self.disabled)
	{
		return;
	}

	self.disabled = 0;
	self.origin = 10000 + VectorScale((0,0,1));
}

//Function Number: 71
in_playable_area()
{
	playable_area = getentarray("player_volume","script_noteworthy");
	if(!(IsDefined(playable_area)))
	{
/#
		println("No playable area playable_area found! Assume EVERYWHERE is PLAYABLE");
#/
		return 1;
	}

	for(i = 0;i < playable_area.size;i++)
	{
		if(self istouching(playable_area[i]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 72
get_closest_non_destroyed_chunk(origin,barrier,barrier_chunks)
{
	chunks = undefined;
	chunks_grate = undefined;
	chunks_grate = get_non_destroyed_chunks_grate(barrier,barrier_chunks);
	chunks = get_non_destroyed_chunks(barrier,barrier_chunks);
	if(IsDefined(barrier.zbarrier))
	{
		if(IsDefined(chunks))
		{
			return array_randomize(chunks)[0];
		}

		if(IsDefined(chunks_grate))
		{
			return array_randomize(chunks_grate)[0];
		}
	}
	else if(IsDefined(chunks))
	{
		return non_destroyed_bar_board_order(origin,chunks);
	}
	else if(IsDefined(chunks_grate))
	{
		return non_destroyed_grate_order(origin,chunks_grate);
	}
}

//Function Number: 73
get_random_destroyed_chunk(barrier,barrier_chunks)
{
	if(IsDefined(barrier.zbarrier))
	{
		ret = undefined;
		pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");
		if(pieces.size)
		{
			ret = array_randomize(pieces)[0];
		}

		return ret;
	}
	else
	{
		chunk = undefined;
		chunks_repair_grate = undefined;
		chunks = get_destroyed_chunks(barrier_chunks);
		chunks_repair_grate = get_destroyed_repair_grates(barrier_chunks);
		if(IsDefined(chunks))
		{
			return chunks[randomint(chunks.size)];
		}
		else if(IsDefined(chunks_repair_grate))
		{
			return grate_order_destroyed(chunks_repair_grate);
		}
	}
}

//Function Number: 74
get_destroyed_repair_grates(barrier_chunks)
{
	array = [];
	for(i = 0;i < barrier_chunks.size;i++)
	{
		if(IsDefined(barrier_chunks[i]))
		{
			if(IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "grate")
			{
				array[array.size] = barrier_chunks[i];
			}
		}
	}

	if(array.size == 0)
	{
		return undefined;
	}
}

//Function Number: 75
get_non_destroyed_chunks(barrier,barrier_chunks)
{
	if(IsDefined(barrier.zbarrier))
	{
		return barrier.zbarrier getzbarrierpieceindicesinstate("closed");
	}
	else
	{
		array = [];
		for(i = 0;i < barrier_chunks.size;i++)
		{
			if(IsDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "classic_boards")
			{
				if(IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "board")
				{
					if(barrier_chunks[i] get_chunk_state() == "repaired")
					{
						if(barrier_chunks[i].origin == barrier_chunks[i].og_origin)
						{
							array[array.size] = barrier_chunks[i];
						}
					}
				}
			}

			if(IsDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "new_barricade")
			{
				if(IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "repair_board" || barrier_chunks[i].script_parameters == "barricade_vents")
				{
					if(barrier_chunks[i] get_chunk_state() == "repaired")
					{
						if(barrier_chunks[i].origin == barrier_chunks[i].og_origin)
						{
							array[array.size] = barrier_chunks[i];
						}
					}
				}
			}
			else if(IsDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "6_bars_bent")
			{
				if(IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "bar")
				{
					if(barrier_chunks[i] get_chunk_state() == "repaired")
					{
						if(barrier_chunks[i].origin == barrier_chunks[i].og_origin)
						{
							array[array.size] = barrier_chunks[i];
						}
					}
				}
			}
			else if(IsDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "6_bars_prestine")
			{
				if(IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "bar")
				{
					if(barrier_chunks[i] get_chunk_state() == "repaired")
					{
						if(barrier_chunks[i].origin == barrier_chunks[i].og_origin)
						{
							array[array.size] = barrier_chunks[i];
						}
					}
				}
			}
		}

		if(array.size == 0)
		{
			return undefined;
		}
	}
}

//Function Number: 76
get_non_destroyed_chunks_grate(barrier,barrier_chunks)
{
	if(IsDefined(barrier.zbarrier))
	{
		return barrier.zbarrier getzbarrierpieceindicesinstate("closed");
	}
	else
	{
		array = [];
		for(i = 0;i < barrier_chunks.size;i++)
		{
			if(IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "grate")
			{
				if(IsDefined(barrier_chunks[i]))
				{
					array[array.size] = barrier_chunks[i];
				}
			}
		}

		if(array.size == 0)
		{
			return undefined;
		}
	}
}

//Function Number: 77
get_non_destroyed_variant1(barrier_chunks)
{
	array = [];
	for(i = 0;i < barrier_chunks.size;i++)
	{
		if(IsDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "bar_board_variant1")
		{
			if(IsDefined(barrier_chunks[i]))
			{
				array[array.size] = barrier_chunks[i];
			}
		}
	}

	if(array.size == 0)
	{
		return undefined;
	}
}

//Function Number: 78
get_non_destroyed_variant2(barrier_chunks)
{
	array = [];
	for(i = 0;i < barrier_chunks.size;i++)
	{
		if(IsDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "bar_board_variant2")
		{
			if(IsDefined(barrier_chunks[i]))
			{
				array[array.size] = barrier_chunks[i];
			}
		}
	}

	if(array.size == 0)
	{
		return undefined;
	}
}

//Function Number: 79
get_non_destroyed_variant4(barrier_chunks)
{
	array = [];
	for(i = 0;i < barrier_chunks.size;i++)
	{
		if(IsDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "bar_board_variant4")
		{
			if(IsDefined(barrier_chunks[i]))
			{
				array[array.size] = barrier_chunks[i];
			}
		}
	}

	if(array.size == 0)
	{
		return undefined;
	}
}

//Function Number: 80
get_non_destroyed_variant5(barrier_chunks)
{
	array = [];
	for(i = 0;i < barrier_chunks.size;i++)
	{
		if(IsDefined(barrier_chunks[i].script_team) && barrier_chunks[i].script_team == "bar_board_variant5")
		{
			if(IsDefined(barrier_chunks[i]))
			{
				array[array.size] = barrier_chunks[i];
			}
		}
	}

	if(array.size == 0)
	{
		return undefined;
	}
}

//Function Number: 81
get_destroyed_chunks(barrier_chunks)
{
	array = [];
	for(i = 0;i < barrier_chunks.size;i++)
	{
		if(barrier_chunks[i] get_chunk_state() == "destroyed")
		{
			if(IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "board")
			{
				array[array.size] = barrier_chunks[i];
			}
			else if((IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "repair_board") || barrier_chunks[i].script_parameters == "barricade_vents")
			{
				array[array.size] = barrier_chunks[i];
			}
			else if(IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "bar")
			{
				array[array.size] = barrier_chunks[i];
			}
			else if(IsDefined(barrier_chunks[i].script_parameters) && barrier_chunks[i].script_parameters == "grate")
			{
				return undefined;
			}
		}
	}

	if(array.size == 0)
	{
		return undefined;
	}
}

//Function Number: 82
grate_order_destroyed(chunks_repair_grate)
{
	grate_repair_order = [];
	grate_repair_order1 = [];
	grate_repair_order2 = [];
	grate_repair_order3 = [];
	grate_repair_order4 = [];
	grate_repair_order5 = [];
	grate_repair_order6 = [];
	for(i = 0;i < chunks_repair_grate.size;i++)
	{
		if(IsDefined(chunks_repair_grate[i].script_parameters) && chunks_repair_grate[i].script_parameters == "grate")
		{
			if(IsDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "1")
			{
				grate_repair_order1[grate_repair_order1.size] = chunks_repair_grate[i];
			}

			if(IsDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "2")
			{
				grate_repair_order2[grate_repair_order2.size] = chunks_repair_grate[i];
			}

			if(IsDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "3")
			{
				grate_repair_order3[grate_repair_order3.size] = chunks_repair_grate[i];
			}

			if(IsDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "4")
			{
				grate_repair_order4[grate_repair_order4.size] = chunks_repair_grate[i];
			}

			if(IsDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "5")
			{
				grate_repair_order5[grate_repair_order5.size] = chunks_repair_grate[i];
			}

			if(IsDefined(chunks_repair_grate[i].script_noteworthy) && chunks_repair_grate[i].script_noteworthy == "6")
			{
				grate_repair_order6[grate_repair_order6.size] = chunks_repair_grate[i];
			}
		}
	}

	for(i = 0;i < chunks_repair_grate.size;i++)
	{
		if(IsDefined(chunks_repair_grate[i].script_parameters) && chunks_repair_grate[i].script_parameters == "grate")
		{
			if(IsDefined(grate_repair_order1[i]))
			{
				if(grate_repair_order6[i].state == "destroyed")
				{
/#
					iprintlnbold(" Fix grate6 ");
#/
					return grate_repair_order6[i];
				}

				if(grate_repair_order5[i].state == "destroyed")
				{
/#
					iprintlnbold(" Fix grate5 ");
#/
					grate_repair_order6[i] thread show_grate_repair();
					return grate_repair_order5[i];
				}
				else if(grate_repair_order4[i].state == "destroyed")
				{
/#
						iprintlnbold(" Fix grate4 ");
#/
					grate_repair_order5[i] thread show_grate_repair();
					return grate_repair_order4[i];
				}
				else if(grate_repair_order3[i].state == "destroyed")
				{
/#
							iprintlnbold(" Fix grate3 ");
#/
					grate_repair_order4[i] thread show_grate_repair();
					return grate_repair_order3[i];
				}
				else if(grate_repair_order2[i].state == "destroyed")
				{
/#
								iprintlnbold(" Fix grate2 ");
#/
					grate_repair_order3[i] thread show_grate_repair();
					return grate_repair_order2[i];
				}
				else if(grate_repair_order1[i].state == "destroyed")
				{
/#
									iprintlnbold(" Fix grate1 ");
#/
					grate_repair_order2[i] thread show_grate_repair();
					return grate_repair_order1[i];
				}
			}
		}
	}
}

//Function Number: 83
show_grate_repair()
{
	wait(0.34);
	self hide();
}

//Function Number: 84
get_chunk_state()
{
/#
	assert(IsDefined(self.state));
#/
	return self.state;
}

//Function Number: 85
is_float(num)
{
	val = num - int(num);
	if(val != 0)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

//Function Number: 86
array_limiter(array,total)
{
	new_array = [];
	for(i = 0;i < array.size;i++)
	{
		if(i < total)
		{
			new_array[new_array.size] = array[i];
		}
	}

	return new_array;
}

//Function Number: 87
array_validate(array)
{
	if(IsDefined(array) && array.size > 0)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

//Function Number: 88
add_spawner(spawner)
{
	if(IsDefined(spawner.script_start) && level.round_number < spawner.script_start)
	{
		return;
	}

	if(IsDefined(spawner.is_enabled) && !spawner.is_enabled)
	{
		return;
	}

	if(IsDefined(spawner.has_been_added) && spawner.has_been_added)
	{
		return;
	}

	spawner.has_been_added = 1;
	level.zombie_spawn_locations[level.zombie_spawn_locations.size] = spawner;
}

//Function Number: 89
fake_physicslaunch(target_pos,power)
{
	start_pos = self.origin;
	gravity = GetDvarInt(#"55F139D3") * -1;
	dist = distance(start_pos,target_pos);
	time = dist / power;
	delta = target_pos - start_pos;
	drop = 0.5 * gravity * time * time;
	velocity = (delta[0] / time,delta[1] / time,delta[2] - drop / time);
	level thread draw_line_ent_to_pos(self,target_pos);
	self movegravity(velocity,time);
	return time;
}

//Function Number: 90
add_zombie_hint(ref,text)
{
	if(!(IsDefined(level.zombie_hints)))
	{
		level.zombie_hints = [];
	}

	precachestring(text);
	level.zombie_hints[ref] = text;
}

//Function Number: 91
get_zombie_hint(ref)
{
	if(IsDefined(level.zombie_hints[ref]))
	{
		return level.zombie_hints[ref];
	}

/#
	println("UNABLE TO FIND HINT STRING " + ref);
#/
	return level.zombie_hints["undefined"];
}

//Function Number: 92
set_hint_string(ent,default_ref,cost)
{
	ref = default_ref;
	if(IsDefined(ent.script_hint))
	{
		ref = ent.script_hint;
	}

	if(IsDefined(level.legacy_hint_system) && level.legacy_hint_system)
	{
		ref = ref + "_" + cost;
		self sethintstring(get_zombie_hint(ref));
	}
	else
	{
		hint = get_zombie_hint(ref);
		if(IsDefined(cost))
		{
			self sethintstring(hint,cost);
		}
		else
		{
			self sethintstring(hint);
		}
	}
}

//Function Number: 93
get_hint_string(ent,default_ref,cost)
{
	ref = default_ref;
	if(IsDefined(ent.script_hint))
	{
		ref = ent.script_hint;
	}

	if(IsDefined(level.legacy_hint_system) && level.legacy_hint_system && IsDefined(cost))
	{
		ref = ref + "_" + cost;
	}

	return get_zombie_hint(ref);
}

//Function Number: 94
unitrigger_set_hint_string(ent,default_ref,cost)
{
	triggers = [];
	if(self.trigger_per_player)
	{
		triggers = self.playertrigger;
	}
	else
	{
		triggers[0] = self.trigger;
	}

	foreach(trigger in triggers)
	{
		ref = default_ref;
		if(IsDefined(ent.script_hint))
		{
			ref = ent.script_hint;
		}

		if(IsDefined(level.legacy_hint_system) && level.legacy_hint_system)
		{
			ref = ref + "_" + cost;
			trigger sethintstring(get_zombie_hint(ref));
		}
		else
		{
			hint = get_zombie_hint(ref);
			if(IsDefined(cost))
			{
				trigger sethintstring(hint,cost);
			}
			else
			{
				trigger sethintstring(hint);
			}
		}
	}
}

//Function Number: 95
add_sound(ref,alias)
{
	if(!(IsDefined(level.zombie_sounds)))
	{
		level.zombie_sounds = [];
	}

	level.zombie_sounds[ref] = alias;
}

//Function Number: 96
play_sound_at_pos(ref,pos,ent)
{
	if(IsDefined(ent))
	{
		if(IsDefined(ent.script_soundalias))
		{
			playsoundatposition(ent.script_soundalias,pos);
			return;
		}

		if(IsDefined(self.script_sound))
		{
			ref = self.script_sound;
		}
	}

	if(ref == "none")
	{
		return;
	}

	if(!(IsDefined(level.zombie_sounds[ref])))
	{
/#
		assertmsg("Sound \" + ref + "\" was not put to the zombie sounds list, please use add_sound( ref, alias ) at the start of your level.");
#/
		return;
	}

	playsoundatposition(level.zombie_sounds[ref],pos);
}

//Function Number: 97
play_sound_on_ent(ref)
{
	if(IsDefined(self.script_soundalias))
	{
		self playsound(self.script_soundalias);
		return;
	}

	if(IsDefined(self.script_sound))
	{
		ref = self.script_sound;
	}

	if(ref == "none")
	{
		return;
	}

	if(!(IsDefined(level.zombie_sounds[ref])))
	{
/#
		assertmsg("Sound \" + ref + "\" was not put to the zombie sounds list, please use add_sound( ref, alias ) at the start of your level.");
#/
		return;
	}

	self playsound(level.zombie_sounds[ref]);
}

//Function Number: 98
play_loopsound_on_ent(ref)
{
	if(IsDefined(self.script_firefxsound))
	{
		ref = self.script_firefxsound;
	}

	if(ref == "none")
	{
		return;
	}

	if(!(IsDefined(level.zombie_sounds[ref])))
	{
/#
		assertmsg("Sound \" + ref + "\" was not put to the zombie sounds list, please use add_sound( ref, alias ) at the start of your level.");
#/
		return;
	}

	self playsound(level.zombie_sounds[ref]);
}

//Function Number: 99
string_to_float(string)
{
	floatparts = strtok(string,".");
	if(floatparts.size == 1)
	{
		return int(floatparts[0]);
	}

	whole = int(floatparts[0]);
	decimal = 0;
	for(i = floatparts[1].size - 1;i >= 0;i--)
	{
		decimal = decimal / 10 + int(floatparts[1][i]) / 10;
	}

	if(whole >= 0)
	{
		return whole + decimal;
	}
	else
	{
		return whole - decimal;
	}
}

//Function Number: 100
onplayerconnect_callback(func)
{
	addcallback("on_player_connect",func);
}

//Function Number: 101
onplayerdisconnect_callback(func)
{
	addcallback("on_player_disconnect",func);
}

//Function Number: 102
set_zombie_var(var,value,is_float,column,is_team_based)
{
	if(!(IsDefined(is_float)))
	{
		is_float = 0;
	}

	if(!(IsDefined(column)))
	{
		column = 1;
	}

	table = "mp/zombiemode.csv";
	table_value = tablelookup(table,0,var,column);
	if(IsDefined(table_value) && table_value != "")
	{
		if(is_float)
		{
			value = float(table_value);
		}
		else
		{
			value = int(table_value);
		}
	}

	if(IsDefined(is_team_based) && is_team_based)
	{
		foreach(team in level.teams)
		{
			level.zombie_vars[team][var] = value;
		}
	}
	else
	{
		level.zombie_vars[var] = value;
	}

	return value;
}

//Function Number: 103
get_table_var(table,var_name,value,is_float,column)
{
	if(!(IsDefined(table)))
	{
		table = "mp/zombiemode.csv";
	}

	if(!(IsDefined(is_float)))
	{
		is_float = 0;
	}

	if(!(IsDefined(column)))
	{
		column = 1;
	}

	table_value = tablelookup(table,0,var_name,column);
	if(IsDefined(table_value) && table_value != "")
	{
		if(is_float)
		{
			value = string_to_float(table_value);
		}
		else
		{
			value = int(table_value);
		}
	}

	return value;
}

//Function Number: 104
hudelem_count()
{
/#
	max = 0;
	curr_total = 0;
	for(;;)
	{
		max = level.hudelem_count;
		println("HudElems: " + level.hudelem_count + "[Peak: " + max + "]");
		wait(0.05);
	}
level.hudelem_count > max
1
#/
}

//Function Number: 105
debug_round_advancer()
{
/#
	for(;;)
	{
		zombs = get_round_enemy_array();
		i = 0;
		for(;;)
		{
			zombs[i] dodamage(zombs[i].health + 666,(0,0,0));
			wait(0.5);
			i++;
		}
	}
i < zombs.size
1
#/
}

//Function Number: 106
print_run_speed(speed)
{
/#
	self endon("death");
	for(;;)
	{
		print3d(64 + VectorScale((0,0,1)),self.origin,speed);
		wait(0.05);
	}
(1,1,1)
1
#/
}

//Function Number: 107
draw_line_ent_to_ent(ent1,ent2)
{
/#
	return;
	ent1 endon("death",GetDvarInt(#"FA91EA91") != 1);
	ent2 endon("death");
	for(;;)
	{
		line(ent1.origin,ent2.origin);
		wait(0.05);
	}
1
#/
}

//Function Number: 108
draw_line_ent_to_pos(ent,pos,end_on)
{
/#
	return;
	ent endon("death",GetDvarInt(#"FA91EA91") != 1);
	ent notify("stop_draw_line_ent_to_pos");
	ent endon("stop_draw_line_ent_to_pos");
	ent endon(end_on,IsDefined(end_on));
	for(;;)
	{
		line(ent.origin,pos);
		wait(0.05);
	}
1
#/
}

//Function Number: 109
debug_print(msg)
{
/#
	println("######### ZOMBIE: " + msg);
GetDvarInt(#"FA91EA91") > 0
#/
}

//Function Number: 110
debug_blocker(pos,rad,height)
{
/#
	self notify("stop_debug_blocker");
	self endon("stop_debug_blocker");
	for(;;)
	{
		return;
		wait(0.05);
		drawcylinder(pos,rad,height);
	}
GetDvarInt(#"FA91EA91") != 1
#/
}

//Function Number: 111
drawcylinder(pos,rad,height)
{
/#
	currad = rad;
	curheight = height;
	r = 0;
	for(;;)
	{
		theta = r / 20 * 360;
		theta2 = r + 1 / 20 * 360;
		line(pos + (cos(theta) * currad,sin(theta) * currad,0),pos + (cos(theta2) * currad,sin(theta2) * currad,0));
		line(pos + (cos(theta) * currad,sin(theta) * currad,curheight),pos + (cos(theta2) * currad,sin(theta2) * currad,curheight));
		line(pos + (cos(theta) * currad,sin(theta) * currad,0),pos + (cos(theta) * currad,sin(theta) * currad,curheight));
		r++;
	}
r < 20
#/
}

//Function Number: 112
print3d_at_pos(msg,pos,thread_endon,offset)
{
/#
	self endon("death");
	self notify(thread_endon,IsDefined(thread_endon));
	self endon(thread_endon);
	offset = (0,0,0);
	for(;;)
	{
		print3d(self.origin + offset,msg);
		wait(0.05);
	}
1
IsDefined(offset)
#/
}

//Function Number: 113
debug_breadcrumbs()
{
/#
	self endon("disconnect");
	self notify("stop_debug_breadcrumbs");
	self endon("stop_debug_breadcrumbs");
	for(;;)
	{
		wait(1);
		i = 0;
		for(;;)
		{
			drawcylinder(self.zombie_breadcrumbs[i],5,5);
			i++;
		}
		wait(0.05);
	}
i < self.zombie_breadcrumbs.size
GetDvarInt(#"FA91EA91") != 1
1
#/
}

//Function Number: 114
debug_attack_spots_taken()
{
/#
	self notify("stop_debug_breadcrumbs");
	self endon("stop_debug_breadcrumbs");
	for(;;)
	{
		wait(1);
		wait(0.05);
		count = 0;
		i = 0;
		for(;;)
		{
			count++;
			circle(self.attack_spots[i],12,(1,0,0),0,1,1);
			circle(self.attack_spots[i],12,(0,1,0),0,1,1);
			i++;
		}
		msg = "" + count + " / " + self.attack_spots_taken.size;
		print3d(self.origin,msg);
	}
(GetDvarInt(#"FA91EA91") != 2) ? i < self.attack_spots_taken.size : self.attack_spots_taken[i]
1
#/
}

//Function Number: 115
float_print3d(msg,time)
{
/#
	self endon("death");
	time = GetTime() + time * 1000;
	offset = VectorScale((0,0,1));
	for(;;)
	{
		offset = 2 + VectorScale((0,0,1));
		print3d(self.origin + offset,msg,(1,1,1));
		wait(0.05);
	}
offset
GetTime() < time
72
#/
}

//Function Number: 116
do_player_vo(snd,variation_count)
{
	index = maps/mp/zombies/_zm_weapons::get_player_index(self);
	sound = "zmb_vox_plr_" + index + "_" + snd;
	if(IsDefined(variation_count))
	{
		sound = sound + "_" + randomintrange(0,variation_count);
	}

	if(!(IsDefined(level.player_is_speaking)))
	{
		level.player_is_speaking = 0;
	}

	if(level.player_is_speaking == 0)
	{
		level.player_is_speaking = 1;
		self playsoundwithnotify(sound,"sound_done");
		self waittill("sound_done");
		wait(2);
		level.player_is_speaking = 0;
	}
}

//Function Number: 117
stop_magic_bullet_shield()
{
	self.attackeraccuracy = 1;
	self notify("stop_magic_bullet_shield");
	self.magic_bullet_shield = undefined;
	self._mbs = undefined;
}

//Function Number: 118
magic_bullet_shield()
{
	if(!(IsDefined(self.magic_bullet_shield) && self.magic_bullet_shield))
	{
		if(isai(self) || isplayer(self))
		{
			self.magic_bullet_shield = 1;
/#
			level thread debug_magic_bullet_shield_death(self);
#/
			if(!(IsDefined(self._mbs)))
			{
				self._mbs = spawnstruct();
			}

			if(isai(self))
			{
/#
				assert(isalive(self),"Tried to do magic_bullet_shield on a dead or undefined guy.");
#/
				self._mbs.last_pain_time = 0;
				self._mbs.ignore_time = 2;
				self._mbs.turret_ignore_time = 5;
			}

			self.attackeraccuracy = 0.1;
		}
		else
		{
/#
			assertmsg("magic_bullet_shield does not support entity of classname \'" + self.classname + "\'.");
#/
		}
	}
}

//Function Number: 119
debug_magic_bullet_shield_death(guy)
{
	targetname = "none";
	if(IsDefined(guy.targetname))
	{
		targetname = guy.targetname;
	}

	guy endon("stop_magic_bullet_shield");
	guy waittill("death");
/#
	assert(!IsDefined(guy),"Guy died with magic bullet shield on with targetname: " + targetname);
#/
}

//Function Number: 120
is_magic_bullet_shield_enabled(ent)
{
	if(!(IsDefined(ent)))
	{
		return 0;
	}

	return IsDefined(ent.magic_bullet_shield) && ent.magic_bullet_shield == 1;
}

//Function Number: 121
really_play_2d_sound(sound)
{
	temp_ent = spawn("script_origin",(0,0,0));
	temp_ent playsoundwithnotify(sound,sound + "wait");
	temp_ent waittill(sound + "wait");
	wait(0.05);
	temp_ent delete();
}

//Function Number: 122
play_sound_2d(sound)
{
	level thread really_play_2d_sound(sound);
}

//Function Number: 123
include_weapon(weapon_name,in_box,collector,weighting_func)
{
/#
	println("ZM >> include_weapon = " + weapon_name);
#/
	if(!(IsDefined(in_box)))
	{
		in_box = 1;
	}

	if(!(IsDefined(collector)))
	{
		collector = 0;
	}

	maps/mp/zombies/_zm_weapons::include_zombie_weapon(weapon_name,in_box,collector,weighting_func);
}

//Function Number: 124
include_buildable(buildable_struct)
{
/#
	println("ZM >> include_buildable = " + buildable_struct.name);
#/
	maps/mp/zombies/_zm_buildables::include_zombie_buildable(buildable_struct);
}

//Function Number: 125
is_buildable_included(name)
{
	if(IsDefined(level.zombie_include_buildables[name]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 126
create_zombie_buildable_piece(modelname,radius,height,hud_icon)
{
/#
	println("ZM >> create_zombie_buildable_piece = " + modelname);
#/
	self maps/mp/zombies/_zm_buildables::create_zombie_buildable_piece(modelname,radius,height,hud_icon);
}

//Function Number: 127
is_buildable()
{
	return self maps/mp/zombies/_zm_buildables::is_buildable();
}

//Function Number: 128
wait_for_buildable(buildable_name)
{
	level waittill(buildable_name + "_built",player);
	return player;
}

//Function Number: 129
include_powered_item(power_on_func,power_off_func,range_func,cost_func,power_sources,start_power,target)
{
	return maps/mp/zombies/_zm_power::add_powered_item(power_on_func,power_off_func,range_func,cost_func,power_sources,start_power,target);
}

//Function Number: 130
include_powerup(powerup_name)
{
	maps/mp/zombies/_zm_powerups::include_zombie_powerup(powerup_name);
}

//Function Number: 131
include_equipment(equipment_name)
{
	maps/mp/zombies/_zm_equipment::include_zombie_equipment(equipment_name);
}

//Function Number: 132
limit_equipment(equipment_name,limited)
{
	maps/mp/zombies/_zm_equipment::limit_zombie_equipment(equipment_name,limited);
}

//Function Number: 133
trigger_invisible(enable)
{
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(IsDefined(players[i]))
		{
			self setinvisibletoplayer(players[i],enable);
		}
	}
}

//Function Number: 134
print3d_ent(text,color,scale,offset,end_msg,overwrite)
{
	self endon("death");
	if(IsDefined(overwrite) && overwrite && IsDefined(self._debug_print3d_msg))
	{
		self notify("end_print3d");
		wait(0.05);
	}

	self endon("end_print3d");
	if(!(IsDefined(color)))
	{
		color = (1,1,1);
	}

	if(!(IsDefined(scale)))
	{
		scale = 1;
	}

	if(!(IsDefined(offset)))
	{
		offset = (0,0,0);
	}

	if(IsDefined(end_msg))
	{
		self endon(end_msg);
	}

	self._debug_print3d_msg = text;
/#
	for(;;)
	{
		print3d(self.origin + offset,self._debug_print3d_msg,color,scale);
		wait(0.05);
	}
1
#/
}

//Function Number: 135
isexplosivedamage(meansofdeath)
{
	explosivedamage = "MOD_GRENADE MOD_GRENADE_SPLASH MOD_PROJECTILE_SPLASH MOD_EXPLOSIVE";
	if(issubstr(explosivedamage,meansofdeath))
	{
		return 1;
	}

	return 0;
}

//Function Number: 136
isprimarydamage(meansofdeath)
{
	if(meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET")
	{
		return 1;
	}

	return 0;
}

//Function Number: 137
isfiredamage(weapon,meansofdeath)
{
	if((issubstr(weapon,"flame") || issubstr(weapon,"molotov_") || issubstr(weapon,"napalmblob_")) && meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH")
	{
		return 1;
	}
}

//Function Number: 138
isplayerexplosiveweapon(weapon,meansofdeath)
{
	if(!(isexplosivedamage(meansofdeath)))
	{
		return 0;
	}

	if(weapon == "artillery_mp")
	{
		return 0;
	}

	if(issubstr(weapon,"turret"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 139
create_counter_hud(x)
{
	if(!(IsDefined(x)))
	{
		x = 0;
	}

	hud = create_simple_hud();
	hud.alignx = "left";
	hud.aligny = "top";
	hud.horzalign = "user_left";
	hud.vertalign = "user_top";
	hud.color = (1,1,1);
	hud.fontscale = 32;
	hud.x = x;
	hud.alpha = 0;
	hud setshader("hud_chalk_1",64,64);
	return hud;
}

//Function Number: 140
get_current_zone(return_zone)
{
	flag_wait("zones_initialized");
	for(z = 0;z < level.zone_keys.size;z++)
	{
		zone_name = level.zone_keys[z];
		zone = level.zones[zone_name];
		for(i = 0;i < zone.volumes.size;i++)
		{
			if(self istouching(zone.volumes[i]))
			{
				if(IsDefined(return_zone) && return_zone)
				{
					return zone;
				}

				return zone_name;
			}
		}
	}

	return undefined;
}

//Function Number: 141
remove_mod_from_methodofdeath(mod)
{
	return mod;
}

//Function Number: 142
clear_fog_threads()
{
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		players[i] notify("stop_fog");
	}
}

//Function Number: 143
display_message(titletext,notifytext,duration)
{
	notifydata = spawnstruct();
	notifydata.titletext = notifytext;
	notifydata.notifytext = titletext;
	notifydata.sound = "mus_level_up";
	notifydata.duration = duration;
	notifydata.glowcolor = (1,0,0);
	notifydata.color = (0,0,0);
	notifydata.iconname = "hud_zombies_meat";
	self thread maps/mp/gametypes_zm/_hud_message::notifymessage(notifydata);
}

//Function Number: 144
is_quad()
{
	return self.animname == "quad_zombie";
}

//Function Number: 145
is_leaper()
{
	return self.animname == "leaper_zombie";
}

//Function Number: 146
shock_onpain()
{
	self endon("death");
	self endon("disconnect");
	self notify("stop_shock_onpain");
	self endon("stop_shock_onpain");
	if(GetDvar(#"7FB1F9A2") == "")
	{
		setdvar("blurpain","on");
	}

	while(1)
	{
		oldhealth = self.health;
		self waittill("damage",damage,attacker,direction_vec,point,mod);
		if(IsDefined(level.shock_onpain) && !level.shock_onpain)
		{
			continue;
		}

		if(IsDefined(self.shock_onpain) && !self.shock_onpain)
		{
			continue;
		}

		if(self.health < 1)
		{
			continue;
		}

		if(mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH")
		{
			continue;
		}
		else
		{
			if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE")
			{
				shocktype = undefined;
				shocklight = undefined;
				if(IsDefined(self.is_burning) && self.is_burning)
				{
					shocktype = "lava";
					shocklight = "lava_small";
				}

				self shock_onexplosion(damage,shocktype,shocklight);
				continue;
			}

			if(GetDvar(#"7FB1F9A2") == "on")
			{
				self shellshock("pain",0.5);
			}
		}
	}
}

//Function Number: 147
shock_onexplosion(damage,shocktype,shocklight)
{
	time = 0;
	scaled_damage = 100 * damage / self.maxhealth;
	if(scaled_damage >= 90)
	{
		time = 4;
	}
	else if(scaled_damage >= 50)
	{
		time = 3;
	}
	else if(scaled_damage >= 25)
	{
		time = 2;
	}
	else if(scaled_damage > 10)
	{
		time = 1;
	}

	if(time)
	{
		if(!(IsDefined(shocktype)))
		{
			shocktype = "explosion";
		}

		self shellshock(shocktype,time);
	}
	else if(IsDefined(shocklight))
	{
		self shellshock(shocklight,time);
	}
}

//Function Number: 148
increment_is_drinking()
{
/#
	self.is_drinking++;
IsDefined(level.devgui_dpad_watch) && level.devgui_dpad_watch
#/
	if(!(IsDefined(self.is_drinking)))
	{
		self.is_drinking = 0;
	}

	if(self.is_drinking == 0)
	{
		self disableoffhandweapons();
		self disableweaponcycling();
	}

	self.is_drinking++;
}

//Function Number: 149
is_multiple_drinking()
{
	return self.is_drinking > 1;
}

//Function Number: 150
decrement_is_drinking()
{
	if(self.is_drinking > 0)
	{
		self.is_drinking--;
	}
	else
	{
/#
		assertmsg("making is_drinking less than 0");
#/
	}

	if(self.is_drinking == 0)
	{
		self enableoffhandweapons();
		self enableweaponcycling();
	}
}

//Function Number: 151
clear_is_drinking()
{
	self.is_drinking = 0;
	self enableoffhandweapons();
	self enableweaponcycling();
}

//Function Number: 152
getweaponclasszm(weapon)
{
/#
	assert(IsDefined(weapon));
#/
	if(!(IsDefined(weapon)))
	{
		return undefined;
	}

	if(!(IsDefined(level.weaponclassarray)))
	{
		level.weaponclassarray = [];
	}

	if(IsDefined(level.weaponclassarray[weapon]))
	{
		return level.weaponclassarray[weapon];
	}

	baseweaponindex = getbaseweaponitemindex(weapon) + 1;
	weaponclass = tablelookupcolumnforrow("zm/zm_statstable.csv",baseweaponindex,2);
	level.weaponclassarray[weapon] = weaponclass;
	return weaponclass;
}

//Function Number: 153
spawn_weapon_model(weapon,model,origin,angles,options)
{
	if(!(IsDefined(model)))
	{
		model = getweaponmodel(weapon);
	}

	weapon_model = spawn("script_model",origin);
	if(IsDefined(angles))
	{
		weapon_model.angles = angles;
	}

	if(IsDefined(options))
	{
		weapon_model useweaponmodel(weapon,model,options);
	}
	else
	{
		weapon_model useweaponmodel(weapon,model);
	}

	return weapon_model;
}

//Function Number: 154
is_limited_weapon(weapname)
{
	if(IsDefined(level.limited_weapons))
	{
		if(IsDefined(level.limited_weapons[weapname]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 155
is_alt_weapon(weapname)
{
	if(getsubstr(weapname,0,3) == "gl_")
	{
		return 1;
	}

	if(getsubstr(weapname,0,3) == "sf_")
	{
		return 1;
	}

	if(getsubstr(weapname,0,10) == "dualoptic_")
	{
		return 1;
	}

	return 0;
}

//Function Number: 156
is_grenade_launcher(weapname)
{
	return weapname == "m32_zm" || weapname == "m32_upgraded_zm";
}

//Function Number: 157
register_lethal_grenade_for_level(weaponname)
{
	if(is_lethal_grenade(weaponname))
	{
		return;
	}

	if(!(IsDefined(level.zombie_lethal_grenade_list)))
	{
		level.zombie_lethal_grenade_list = [];
	}

	level.zombie_lethal_grenade_list[weaponname] = weaponname;
}

//Function Number: 158
is_lethal_grenade(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(level.zombie_lethal_grenade_list))
	{
		return 0;
	}

	return IsDefined(level.zombie_lethal_grenade_list[weaponname]);
}

//Function Number: 159
is_player_lethal_grenade(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(self.current_lethal_grenade))
	{
		return 0;
	}

	return self.current_lethal_grenade == weaponname;
}

//Function Number: 160
get_player_lethal_grenade()
{
	grenade = "";
	if(IsDefined(self.current_lethal_grenade))
	{
		grenade = self.current_lethal_grenade;
	}

	return grenade;
}

//Function Number: 161
set_player_lethal_grenade(weaponname)
{
	self.current_lethal_grenade = weaponname;
}

//Function Number: 162
init_player_lethal_grenade()
{
	self set_player_lethal_grenade(level.zombie_lethal_grenade_player_init);
}

//Function Number: 163
register_tactical_grenade_for_level(weaponname)
{
	if(is_tactical_grenade(weaponname))
	{
		return;
	}

	if(!(IsDefined(level.zombie_tactical_grenade_list)))
	{
		level.zombie_tactical_grenade_list = [];
	}

	level.zombie_tactical_grenade_list[weaponname] = weaponname;
}

//Function Number: 164
is_tactical_grenade(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(level.zombie_tactical_grenade_list))
	{
		return 0;
	}

	return IsDefined(level.zombie_tactical_grenade_list[weaponname]);
}

//Function Number: 165
is_player_tactical_grenade(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(self.current_tactical_grenade))
	{
		return 0;
	}

	return self.current_tactical_grenade == weaponname;
}

//Function Number: 166
get_player_tactical_grenade()
{
	tactical = "";
	if(IsDefined(self.current_tactical_grenade))
	{
		tactical = self.current_tactical_grenade;
	}

	return tactical;
}

//Function Number: 167
set_player_tactical_grenade(weaponname)
{
	self notify("new_tactical_grenade",weaponname);
	self.current_tactical_grenade = weaponname;
}

//Function Number: 168
init_player_tactical_grenade()
{
	self set_player_tactical_grenade(level.zombie_tactical_grenade_player_init);
}

//Function Number: 169
register_placeable_mine_for_level(weaponname)
{
	if(is_placeable_mine(weaponname))
	{
		return;
	}

	if(!(IsDefined(level.zombie_placeable_mine_list)))
	{
		level.zombie_placeable_mine_list = [];
	}

	level.zombie_placeable_mine_list[weaponname] = weaponname;
}

//Function Number: 170
is_placeable_mine(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(level.zombie_placeable_mine_list))
	{
		return 0;
	}

	return IsDefined(level.zombie_placeable_mine_list[weaponname]);
}

//Function Number: 171
is_player_placeable_mine(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(self.current_placeable_mine))
	{
		return 0;
	}

	return self.current_placeable_mine == weaponname;
}

//Function Number: 172
get_player_placeable_mine()
{
	return self.current_placeable_mine;
}

//Function Number: 173
set_player_placeable_mine(weaponname)
{
	self.current_placeable_mine = weaponname;
}

//Function Number: 174
init_player_placeable_mine()
{
	self set_player_placeable_mine(level.zombie_placeable_mine_player_init);
}

//Function Number: 175
register_melee_weapon_for_level(weaponname)
{
	if(is_melee_weapon(weaponname))
	{
		return;
	}

	if(!(IsDefined(level.zombie_melee_weapon_list)))
	{
		level.zombie_melee_weapon_list = [];
	}

	level.zombie_melee_weapon_list[weaponname] = weaponname;
}

//Function Number: 176
is_melee_weapon(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(level.zombie_melee_weapon_list))
	{
		return 0;
	}

	return IsDefined(level.zombie_melee_weapon_list[weaponname]);
}

//Function Number: 177
is_player_melee_weapon(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(self.current_melee_weapon))
	{
		return 0;
	}

	return self.current_melee_weapon == weaponname;
}

//Function Number: 178
get_player_melee_weapon()
{
	return self.current_melee_weapon;
}

//Function Number: 179
set_player_melee_weapon(weaponname)
{
	self.current_melee_weapon = weaponname;
}

//Function Number: 180
init_player_melee_weapon()
{
	self set_player_melee_weapon(level.zombie_melee_weapon_player_init);
}

//Function Number: 181
should_watch_for_emp()
{
	return IsDefined(level.zombie_weapons["emp_grenade_zm"]);
}

//Function Number: 182
register_equipment_for_level(weaponname)
{
	if(is_equipment(weaponname))
	{
		return;
	}

	if(!(IsDefined(level.zombie_equipment_list)))
	{
		level.zombie_equipment_list = [];
	}

	level.zombie_equipment_list[weaponname] = weaponname;
}

//Function Number: 183
is_equipment(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(level.zombie_equipment_list))
	{
		return 0;
	}

	return IsDefined(level.zombie_equipment_list[weaponname]);
}

//Function Number: 184
is_equipment_that_blocks_purchase(weaponname)
{
	return is_equipment(weaponname);
}

//Function Number: 185
is_player_equipment(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(self.current_equipment))
	{
		return 0;
	}

	return self.current_equipment == weaponname;
}

//Function Number: 186
has_deployed_equipment(weaponname)
{
	if(!IsDefined(weaponname) || !IsDefined(self.deployed_equipment) || self.deployed_equipment.size < 1)
	{
		return 0;
	}

	for(i = 0;i < self.deployed_equipment.size;i++)
	{
		if(self.deployed_equipment[i] == weaponname)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 187
has_player_equipment(weaponname)
{
	return self is_player_equipment(weaponname) || self has_deployed_equipment(weaponname);
}

//Function Number: 188
get_player_equipment()
{
	return self.current_equipment;
}

//Function Number: 189
hacker_active()
{
	return self maps/mp/zombies/_zm_equipment::is_equipment_active("equip_hacker_zm");
}

//Function Number: 190
set_player_equipment(weaponname)
{
	if(!(IsDefined(self.current_equipment_active)))
	{
		self.current_equipment_active = [];
	}

	if(IsDefined(weaponname))
	{
		self.current_equipment_active[weaponname] = 0;
	}

	if(!(IsDefined(self.equipment_got_in_round)))
	{
		self.equipment_got_in_round = [];
	}

	if(IsDefined(weaponname))
	{
		self.equipment_got_in_round[weaponname] = level.round_number;
	}

	self.current_equipment = weaponname;
}

//Function Number: 191
init_player_equipment()
{
	self set_player_equipment(level.zombie_equipment_player_init);
}

//Function Number: 192
register_offhand_weapons_for_level_defaults()
{
	if(IsDefined(level.register_offhand_weapons_for_level_defaults_override))
	{
		[[ level.register_offhand_weapons_for_level_defaults_override ]]();
		return;
	}

	register_lethal_grenade_for_level("frag_grenade_zm");
	level.zombie_lethal_grenade_player_init = "frag_grenade_zm";
	register_tactical_grenade_for_level("cymbal_monkey_zm");
	level.zombie_tactical_grenade_player_init = undefined;
	register_placeable_mine_for_level("claymore_zm");
	level.zombie_placeable_mine_player_init = undefined;
	register_melee_weapon_for_level("knife_zm");
	register_melee_weapon_for_level("bowie_knife_zm");
	level.zombie_melee_weapon_player_init = "knife_zm";
	level.zombie_equipment_player_init = undefined;
}

//Function Number: 193
init_player_offhand_weapons()
{
	init_player_lethal_grenade();
	init_player_tactical_grenade();
	init_player_placeable_mine();
	init_player_melee_weapon();
	init_player_equipment();
}

//Function Number: 194
is_offhand_weapon(weaponname)
{
	return is_lethal_grenade(weaponname) || is_tactical_grenade(weaponname) || is_placeable_mine(weaponname) || is_melee_weapon(weaponname) || is_equipment(weaponname);
}

//Function Number: 195
is_player_offhand_weapon(weaponname)
{
	return self is_player_lethal_grenade(weaponname) || self is_player_tactical_grenade(weaponname) || self is_player_placeable_mine(weaponname) || self is_player_melee_weapon(weaponname) || self is_player_equipment(weaponname);
}

//Function Number: 196
has_powerup_weapon()
{
	return IsDefined(self.has_powerup_weapon) && self.has_powerup_weapon;
}

//Function Number: 197
give_start_weapon(switch_to_weapon)
{
	self giveweapon(level.start_weapon);
	self givestartammo(level.start_weapon);
	if(IsDefined(switch_to_weapon) && switch_to_weapon)
	{
		self switchtoweapon(level.start_weapon);
	}
}

//Function Number: 198
array_flag_wait_any(flag_array)
{
	if(!(IsDefined(level._array_flag_wait_any_calls)))
	{
		level._n_array_flag_wait_any_calls = 0;
	}
	else
	{
		level._n_array_flag_wait_any_calls++;
	}

	str_condition = "array_flag_wait_call_" + level._n_array_flag_wait_any_calls;
	for(index = 0;index < flag_array.size;index++)
	{
		level thread array_flag_wait_any_thread(flag_array[index],str_condition);
	}

	level waittill(str_condition);
}

//Function Number: 199
array_flag_wait_any_thread(flag_name,condition)
{
	level endon(condition);
	flag_wait(flag_name);
	level notify(condition);
}

//Function Number: 200
array_removedead(array)
{
	newarray = [];
	if(!(IsDefined(array)))
	{
		return undefined;
	}

	for(i = 0;i < array.size;i++)
	{
		if(!isalive(array[i]) || IsDefined(array[i].isacorpse) && array[i].isacorpse)
		{
		}
		else
		{
			newarray[newarray.size] = array[i];
		}
	}

	return newarray;
}

//Function Number: 201
groundpos(origin)
{
	return bullettrace(origin,100000 + VectorScale((0,0,-1)),origin,0)[self];
}

//Function Number: 202
groundpos_ignore_water(origin)
{
	return bullettrace(origin,100000 + VectorScale((0,0,-1)),origin,0,self)[1];
}

//Function Number: 203
groundpos_ignore_water_new(origin)
{
	return groundtrace(origin,100000 + VectorScale((0,0,-1)),origin,0,self)[1];
}

//Function Number: 204
waittill_notify_or_timeout(msg,timer)
{
	self endon(msg);
	wait(timer);
	return timer;
}

//Function Number: 205
self_delete()
{
	if(IsDefined(self))
	{
		self delete();
	}
}

//Function Number: 206
script_delay()
{
	if(IsDefined(self.script_delay))
	{
		wait(self.script_delay);
		return 1;
	}
	else if(IsDefined(self.script_delay_min) && IsDefined(self.script_delay_max))
	{
		wait(randomfloatrange(self.script_delay_min,self.script_delay_max));
		return 1;
	}
}

//Function Number: 207
button_held_think(which_button)
{
	self endon("disconnect");
	if(!(IsDefined(self._holding_button)))
	{
		self._holding_button = [];
	}

	self._holding_button[which_button] = 0;
	time_started = 0;
	use_time = 250;
	while(1)
	{
		if(self._holding_button[which_button])
		{
			if(!(self [[ level._button_funcs[which_button] ]]()))
			{
				self._holding_button[which_button] = 0;
			}
		}
		else if(self [[ level._button_funcs[which_button] ]]())
		{
			if(time_started == 0)
			{
				time_started = GetTime();
			}

			if(GetTime() - time_started > use_time)
			{
				self._holding_button[which_button] = 1;
			}
		}
		else if(time_started != 0)
		{
			time_started = 0;
		}

		wait(0.05);
	}
}

//Function Number: 208
use_button_held()
{
	init_button_wrappers();
	if(!(IsDefined(self._use_button_think_threaded)))
	{
		self thread button_held_think(level.button_use);
		self._use_button_think_threaded = 1;
	}

	return self._holding_button[level.button_use];
}

//Function Number: 209
ads_button_held()
{
	init_button_wrappers();
	if(!(IsDefined(self._ads_button_think_threaded)))
	{
		self thread button_held_think(level.button_ads);
		self._ads_button_think_threaded = 1;
	}

	return self._holding_button[level.button_ads];
}

//Function Number: 210
attack_button_held()
{
	init_button_wrappers();
	if(!(IsDefined(self._attack_button_think_threaded)))
	{
		self thread button_held_think(level.button_attack);
		self._attack_button_think_threaded = 1;
	}

	return self._holding_button[level.button_attack];
}

//Function Number: 211
use_button_pressed()
{
	return self usebuttonpressed();
}

//Function Number: 212
ads_button_pressed()
{
	return self adsbuttonpressed();
}

//Function Number: 213
attack_button_pressed()
{
	return self attackbuttonpressed();
}

//Function Number: 214
init_button_wrappers()
{
	if(!(IsDefined(level._button_funcs)))
	{
		level.button_use = 0;
		level.button_ads = 1;
		level.button_attack = 2;
		level._button_funcs[level.button_use] = ::use_button_pressed;
		level._button_funcs[level.button_ads] = ::ads_button_pressed;
		level._button_funcs[level.button_attack] = ::attack_button_pressed;
	}
}

//Function Number: 215
wait_network_frame()
{
	if(numremoteclients())
	{
		snapshot_ids = getsnapshotindexarray();
		for(acked = undefined;!(IsDefined(acked));acked = snapshotacknowledged(snapshot_ids))
		{
			level waittill("snapacknowledged");
		}
	}
	else
	{
		wait(0.1);
	}
}

//Function Number: 216
ignore_triggers(timer)
{
	self endon("death");
	self.ignoretriggers = 1;
	if(IsDefined(timer))
	{
		wait(timer);
	}
	else
	{
		wait(0.5);
	}

	self.ignoretriggers = 0;
}

//Function Number: 217
giveachievement_wrapper(achievement,all_players)
{
	if(achievement == "")
	{
		return;
	}

	if(IsDefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats)
	{
		return;
	}

	achievement_lower = tolower(achievement);
	global_counter = 0;
	if(IsDefined(all_players) && all_players)
	{
		players = get_players();
		for(i = 0;i < players.size;i++)
		{
			players[i] giveachievement(achievement);
			has_achievement = players[i] maps/mp/zombies/_zm_stats::get_global_stat(achievement_lower);
			if(!(IsDefined(has_achievement) && has_achievement))
			{
				global_counter++;
			}

			players[i] maps/mp/zombies/_zm_stats::increment_client_stat(achievement_lower,0);
			if((issplitscreen() && i == 0) || !issplitscreen())
			{
				if(IsDefined(level.achievement_sound_func))
				{
					players[i] thread [[ level.achievement_sound_func ]](achievement_lower);
				}
			}
		}
	}
	else
	{
		if(!(isplayer(self)))
		{
/#
			println("^1self needs to be a player for _utility::giveachievement_wrapper()");
#/
			return;
		}

		self giveachievement(achievement);
		has_achievement = self maps/mp/zombies/_zm_stats::get_global_stat(achievement_lower);
		if(!(IsDefined(has_achievement) && has_achievement))
		{
			global_counter++;
		}

		self maps/mp/zombies/_zm_stats::increment_client_stat(achievement_lower,0);
		if(IsDefined(level.achievement_sound_func))
		{
			self thread [[ level.achievement_sound_func ]](achievement_lower);
		}
	}

	if(global_counter)
	{
		incrementcounter("global_" + achievement_lower,global_counter);
	}
}

//Function Number: 218
spawn_failed(spawn)
{
	if(IsDefined(spawn) && isalive(spawn))
	{
		if(isalive(spawn))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 219
getyaw(org)
{
	angles = VectorToAngles(org - self.origin);
	return angles[1];
}

//Function Number: 220
getyawtospot(spot)
{
	pos = spot;
	yaw = self.angles[1] - getyaw(pos);
	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 221
add_spawn_function(function,param1,param2,param3,param4)
{
/#
	assert(!IsDefined(level._loadstarted) || !isalive(self),"Tried to add_spawn_function to a living guy.");
#/
	func = [];
	func["function"] = function;
	func["param1"] = param1;
	func["param2"] = param2;
	func["param3"] = param3;
	func["param4"] = param4;
	if(!(IsDefined(self.spawn_funcs)))
	{
		self.spawn_funcs = [];
	}

	self.spawn_funcs[self.spawn_funcs.size] = func;
}

//Function Number: 222
disable_react()
{
/#
	assert(isalive(self),"Tried to disable react on a non ai");
#/
	self.a.disablereact = 1;
	self.allowreact = 0;
}

//Function Number: 223
enable_react()
{
/#
	assert(isalive(self),"Tried to enable react on a non ai");
#/
	self.a.disablereact = 0;
	self.allowreact = 1;
}

//Function Number: 224
flag_wait_or_timeout(flagname,timer)
{
	start_time = GetTime();
	for(;;)
	{
		if(level.flag[flagname])
		{
			break;
		}

		if(GetTime() >= start_time + timer * 1000)
		{
			break;
		}

		wait_for_flag_or_time_elapses(flagname,timer);
	}
}

//Function Number: 225
wait_for_flag_or_time_elapses(flagname,timer)
{
	level endon(flagname);
	wait(timer);
}

//Function Number: 226
isads(player)
{
	return player playerads() > 0.5;
}

//Function Number: 227
bullet_attack(type)
{
	if(type == "MOD_PISTOL_BULLET")
	{
		return 1;
	}

	return type == "MOD_RIFLE_BULLET";
}

//Function Number: 228
pick_up()
{
	player = self.owner;
	self destroy_ent();
	clip_ammo = player getweaponammoclip(self.name);
	clip_max_ammo = weaponclipsize(self.name);
	if(clip_ammo < clip_max_ammo)
	{
		clip_ammo++;
	}

	player setweaponammoclip(self.name,clip_ammo);
}

//Function Number: 229
destroy_ent()
{
	self delete();
}

//Function Number: 230
waittill_not_moving()
{
	self endon("death");
	self endon("disconnect");
	self endon("detonated");
	level endon("game_ended");
	if(self.classname == "grenade")
	{
		self waittill("stationary");
	}
	else
	{
		prevorigin = self.origin;
		while(1)
		{
			wait(0.15);
			if(self.origin == prevorigin)
			{
				break;
			}

			prevorigin = self.origin;
		}
	}
}

//Function Number: 231
get_closest_player(org)
{
	players = [];
	players = get_players();
	return getclosest(org,players);
}

//Function Number: 232
ent_flag_wait(msg)
{
	self endon("death");
	while(!(self.ent_flag[msg]))
	{
		self waittill(msg);
	}
}

//Function Number: 233
ent_flag_wait_either(flag1,flag2)
{
	self endon("death");
	for(;;)
	{
		if(ent_flag(flag1))
		{
			return;
		}

		if(ent_flag(flag2))
		{
			return;
		}

		self waittill_either(flag1,flag2);
	}
}

//Function Number: 234
ent_wait_for_flag_or_time_elapses(flagname,timer)
{
	self endon(flagname);
	wait(timer);
}

//Function Number: 235
ent_flag_wait_or_timeout(flagname,timer)
{
	self endon("death");
	start_time = GetTime();
	for(;;)
	{
		if(self.ent_flag[flagname])
		{
			break;
		}

		if(GetTime() >= start_time + timer * 1000)
		{
			break;
		}

		self ent_wait_for_flag_or_time_elapses(flagname,timer);
	}
}

//Function Number: 236
ent_flag_waitopen(msg)
{
	self endon("death");
	while(self.ent_flag[msg])
	{
		self waittill(msg);
	}
}

//Function Number: 237
ent_flag_init(message,val)
{
	if(!(IsDefined(self.ent_flag)))
	{
		self.ent_flag = [];
		self.ent_flags_lock = [];
	}

	if(!(IsDefined(level.first_frame)))
	{
/#
		assert(!IsDefined(self.ent_flag[message]),"Attempt to reinitialize existing flag \'" + message + "\' on entity.");
#/
	}

	if(IsDefined(val) && val)
	{
		self.ent_flag[message] = 1;
/#
		self.ent_flags_lock[message] = 1;
#/
	}
	else
	{
		self.ent_flag[message] = 0;
/#
		self.ent_flags_lock[message] = 0;
#/
	}
}

//Function Number: 238
ent_flag_exist(message)
{
	if(IsDefined(self.ent_flag) && IsDefined(self.ent_flag[message]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 239
ent_flag_set_delayed(message,delay)
{
	wait(delay);
	self ent_flag_set(message);
}

//Function Number: 240
ent_flag_set(message)
{
/#
/#
	assert(IsDefined(self),"Attempt to set a flag on entity that is not defined");
#/
/#
	assert(IsDefined(self.ent_flag[message]),"Attempt to set a flag before calling flag_init: \'" + message + "\'.");
#/
/#
	assert(self.ent_flag[message] == self.ent_flags_lock[message]);
#/
	self.ent_flags_lock[message] = 1;
#/
	self.ent_flag[message] = 1;
	self notify(message);
}

//Function Number: 241
ent_flag_toggle(message)
{
	if(self ent_flag(message))
	{
		self ent_flag_clear(message);
	}
	else
	{
		self ent_flag_set(message);
	}
}

//Function Number: 242
ent_flag_clear(message)
{
/#
/#
	assert(IsDefined(self),"Attempt to clear a flag on entity that is not defined");
#/
/#
	assert(IsDefined(self.ent_flag[message]),"Attempt to set a flag before calling flag_init: \'" + message + "\'.");
#/
/#
	assert(self.ent_flag[message] == self.ent_flags_lock[message]);
#/
	self.ent_flags_lock[message] = 0;
#/
	if(self.ent_flag[message])
	{
		self.ent_flag[message] = 0;
		self notify(message);
	}
}

//Function Number: 243
ent_flag_clear_delayed(message,delay)
{
	wait(delay);
	self ent_flag_clear(message);
}

//Function Number: 244
ent_flag(message)
{
/#
	assert(IsDefined(message),"Tried to check flag but the flag was not defined.");
#/
/#
	assert(IsDefined(self.ent_flag[message]),"Tried to check entity flag \'" + message + "\', but the flag was not initialized.");
#/
	if(!(self.ent_flag[message]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 245
ent_flag_init_ai_standards()
{
	message_array = [];
	message_array[message_array.size] = "goal";
	message_array[message_array.size] = "damage";
	for(i = 0;i < message_array.size;i++)
	{
		self ent_flag_init(message_array[i]);
		self thread ent_flag_wait_ai_standards(message_array[i]);
	}
}

//Function Number: 246
ent_flag_wait_ai_standards(message)
{
	self endon("death");
	self waittill(message);
	self.ent_flag[message] = 1;
}

//Function Number: 247
flat_angle(angle)
{
	rangle = (0,angle[1],0);
	return rangle;
}

//Function Number: 248
waittill_any_or_timeout(timer,string1,string2,string3,string4,string5)
{
/#
	assert(IsDefined(string1));
#/
	self endon(string1);
	if(IsDefined(string2))
	{
		self endon(string2);
	}

	if(IsDefined(string3))
	{
		self endon(string3);
	}

	if(IsDefined(string4))
	{
		self endon(string4);
	}

	if(IsDefined(string5))
	{
		self endon(string5);
	}

	wait(timer);
}

//Function Number: 249
clear_run_anim()
{
	self.alwaysrunforward = undefined;
	self.a.combatrunanim = undefined;
	self.run_noncombatanim = undefined;
	self.walk_combatanim = undefined;
	self.walk_noncombatanim = undefined;
	self.precombatrunenabled = 1;
}

//Function Number: 250
track_players_intersection_tracker()
{
	self endon("disconnect");
	self endon("death");
	level endon("end_game");
	wait(5);
	while(1)
	{
		killed_players = 0;
		players = get_players();
		for(i = 0;i < players.size;i++)
		{
			if(players[i] maps/mp/zombies/_zm_laststand::player_is_in_laststand() || "playing" != players[i].sessionstate)
			{
			}
			else
			{
				for(j = 0;j < players.size;j++)
				{
					if(i == j || players[j] maps/mp/zombies/_zm_laststand::player_is_in_laststand() || "playing" != players[j].sessionstate)
					{
					}
					else if(IsDefined(level.player_intersection_tracker_override))
					{
						if(players[i] [[ level.player_intersection_tracker_override ]](players[j]))
						{
						}
						else
						{
							playeri_origin = players[i].origin;
							playerj_origin = players[j].origin;
							if(Abs(playeri_origin[2] - playerj_origin[2]) > 60)
							{
							}
							else
							{
								distance_apart = distance2d(playeri_origin,playerj_origin);
								if(Abs(distance_apart) > 18)
								{
								}
								else
								{
/#
										iprintlnbold("PLAYERS ARE TOO FRIENDLY!!!!!");
#/
									players[i] dodamage(1000,(0,0,0));
									players[j] dodamage(1000,(0,0,0));
									if(!(killed_players))
									{
										players[i] playlocalsound(level.zmb_laugh_alias);
									}

									players[i] maps/mp/zombies/_zm_stats::increment_map_cheat_stat("cheat_too_friendly");
									players[i] maps/mp/zombies/_zm_stats::increment_client_stat("cheat_too_friendly",0);
									players[i] maps/mp/zombies/_zm_stats::increment_client_stat("cheat_total",0);
									players[j] maps/mp/zombies/_zm_stats::increment_map_cheat_stat("cheat_too_friendly");
									players[j] maps/mp/zombies/_zm_stats::increment_client_stat("cheat_too_friendly",0);
									players[j] maps/mp/zombies/_zm_stats::increment_client_stat("cheat_total",0);
									killed_players = 1;
								}
							}
						}
					}
				}
			}
		}

		wait(0.5);
	}
}

//Function Number: 251
get_eye()
{
	if(isplayer(self))
	{
		linked_ent = self getlinkedent();
		if(IsDefined(linked_ent) && GetDvarInt(#"5AEFD7E9") > 0)
		{
			camera = linked_ent gettagorigin("tag_camera");
			if(IsDefined(camera))
			{
				return camera;
			}
		}
	}

	pos = self geteye();
	return pos;
}

//Function Number: 252
is_player_looking_at(origin,dot,do_trace,ignore_ent)
{
/#
	assert(isplayer(self),"player_looking_at must be called on a player.");
#/
	if(!(IsDefined(dot)))
	{
		dot = 0.7;
	}

	if(!(IsDefined(do_trace)))
	{
		do_trace = 1;
	}

	eye = self get_eye();
	delta_vec = AnglesToForward(VectorToAngles(origin - eye));
	view_vec = AnglesToForward(self getplayerangles());
	new_dot = vectordot(delta_vec,view_vec);
	if(new_dot >= dot)
	{
		if(do_trace)
		{
			return bullettracepassed(origin,eye,0,ignore_ent);
		}
		else
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 253
add_gametype(gt,dummy1,name,dummy2)
{
}

//Function Number: 254
add_gameloc(gl,dummy1,name,dummy2)
{
}

//Function Number: 255
get_closest_index(org,array,dist)
{
	if(!(IsDefined(dist)))
	{
		dist = 9999999;
	}

	distsq = dist * dist;
	if(array.size < 1)
	{
		return;
	}

	index = undefined;
	for(i = 0;i < array.size;i++)
	{
		newdistsq = distancesquared(array[i].origin,org);
		if(newdistsq >= distsq)
		{
		}
		else
		{
			distsq = newdistsq;
			index = i;
		}
	}

	return index;
}

//Function Number: 256
is_valid_zombie_spawn_point(point)
{
	liftedorigin = 5 + VectorScale((0,0,1));
	size = 48;
	height = 64;
	mins = (-1 * size,-1 * size,0);
	maxs = (size,size,height);
	absmins = liftedorigin + mins;
	absmaxs = liftedorigin + maxs;
	if(boundswouldtelefrag(absmins,absmaxs))
	{
		return 0;
	}

	return 1;
}

//Function Number: 257
get_closest_index_to_entity(entity,array,dist,extra_check)
{
	org = entity.origin;
	if(!(IsDefined(dist)))
	{
		dist = 9999999;
	}

	distsq = dist * dist;
	if(array.size < 1)
	{
		return;
	}

	index = undefined;
	for(i = 0;i < array.size;i++)
	{
		if(IsDefined(extra_check) && ![[ extra_check ]](entity,array[i]))
		{
		}
		else
		{
			newdistsq = distancesquared(array[i].origin,org);
			if(newdistsq >= distsq)
			{
			}
			else
			{
				distsq = newdistsq;
				index = i;
			}
		}
	}

	return index;
}

//Function Number: 258
set_gamemode_var(var,val)
{
	if(!(IsDefined(game["gamemode_match"])))
	{
		game["gamemode_match"] = [];
	}

	game["gamemode_match"][var] = val;
}

//Function Number: 259
set_gamemode_var_once(var,val)
{
	if(!(IsDefined(game["gamemode_match"])))
	{
		game["gamemode_match"] = [];
	}

	if(!(IsDefined(game["gamemode_match"][var])))
	{
		game["gamemode_match"][var] = val;
	}
}

//Function Number: 260
set_game_var(var,val)
{
	game[var] = val;
}

//Function Number: 261
set_game_var_once(var,val)
{
	if(!(IsDefined(game[var])))
	{
		game[var] = val;
	}
}

//Function Number: 262
get_game_var(var)
{
	if(IsDefined(game[var]))
	{
		return game[var];
	}
}

//Function Number: 263
get_gamemode_var(var)
{
	if(IsDefined(game["gamemode_match"]) && IsDefined(game["gamemode_match"][var]))
	{
		return game["gamemode_match"][var];
	}
}

//Function Number: 264
waittill_subset(min_num,string1,string2,string3,string4,string5)
{
	self endon("death");
	ent = spawnstruct();
	ent.threads = 0;
	returned_threads = 0;
	if(IsDefined(string1))
	{
		self thread waittill_string(string1,ent);
		ent.threads++;
	}

	if(IsDefined(string2))
	{
		self thread waittill_string(string2,ent);
		ent.threads++;
	}

	if(IsDefined(string3))
	{
		self thread waittill_string(string3,ent);
		ent.threads++;
	}

	if(IsDefined(string4))
	{
		self thread waittill_string(string4,ent);
		ent.threads++;
	}

	if(IsDefined(string5))
	{
		self thread waittill_string(string5,ent);
		ent.threads++;
	}

	while(ent.threads)
	{
		ent waittill("returned");
		ent.threads--;
		returned_threads++;
		if(returned_threads >= min_num)
		{
			break;
		}
	}

	ent notify("die");
}

//Function Number: 265
is_headshot(sweapon,shitloc,smeansofdeath)
{
	if(shitloc != "head" && shitloc != "helmet")
	{
		return 0;
	}

	if(smeansofdeath == "MOD_IMPACT" && issubstr(sweapon,"knife_ballistic"))
	{
		return 1;
	}

	return smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_BAYONET" && smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_UNKNOWN";
}

//Function Number: 266
is_jumping()
{
	ground_ent = self getgroundent();
	return !IsDefined(ground_ent);
}

//Function Number: 267
is_explosive_damage(mod)
{
	if(!(IsDefined(mod)))
	{
		return 0;
	}

	if(mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE")
	{
		return 1;
	}
}

//Function Number: 268
sndswitchannouncervox(who)
{
	switch(who)
	{
		case "€GSC\r\n":
			game["zmbdialog"]["prefix"] = "vox_zmba_sam";
			level.zmb_laugh_alias = "zmb_laugh_sam";
			level.sndannouncerisrich = 0;
			break;

		case "€GSC\r\n":
			game["zmbdialog"]["prefix"] = "vox_zmba";
			level.zmb_laugh_alias = "zmb_laugh_richtofen";
			level.sndannouncerisrich = 1;
			break;
	}
}

//Function Number: 269
do_player_general_vox(category,type,timer,chance)
{
	if(IsDefined(timer) && IsDefined(level.votimer[type]) && level.votimer[type] > 0)
	{
		return;
	}

	if(!(IsDefined(chance)))
	{
		chance = maps/mp/zombies/_zm_audio::get_response_chance(type);
	}

	if(chance > randomint(100))
	{
		self thread maps/mp/zombies/_zm_audio::create_and_play_dialog(category,type);
		if(IsDefined(timer))
		{
			level.votimer[type] = timer;
			level thread general_vox_timer(level.votimer[type],type);
		}
	}
}

//Function Number: 270
general_vox_timer(timer,type)
{
	level endon("end_game");
/#
	println("ZM >> VOX TIMER STARTED FOR  " + type + " ( " + timer + ")");
#/
	while(timer > 0)
	{
		wait(1);
		timer--;
	}

	level.votimer[type] = timer;
/#
	println("ZM >> VOX TIMER ENDED FOR  " + type + " ( " + timer + ")");
#/
}

//Function Number: 271
create_vox_timer(type)
{
	level.votimer[type] = 0;
}

//Function Number: 272
play_vox_to_player(category,type,force_variant)
{
	self thread maps/mp/zombies/_zm_audio::playvoxtoplayer(category,type,force_variant);
}

//Function Number: 273
is_favorite_weapon(weapon_to_check)
{
	if(!(IsDefined(self.favorite_wall_weapons_list)))
	{
		return 0;
	}

	foreach(weapon in self.favorite_wall_weapons_list)
	{
		if(weapon_to_check == weapon)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 274
add_vox_response_chance(event,chance)
{
	level.response_chances[event] = chance;
}

//Function Number: 275
set_demo_intermission_point()
{
	spawnpoints = getentarray("mp_global_intermission","classname");
	if(!(spawnpoints.size))
	{
		return;
	}

	spawnpoint = spawnpoints[0];
	match_string = "";
	location = level.scr_zm_map_start_location;
	if((location == "default" || location == "") && IsDefined(level.default_start_location))
	{
		location = level.default_start_location;
	}

	match_string = level.scr_zm_ui_gametype + "_" + location;
	for(i = 0;i < spawnpoints.size;i++)
	{
		if(IsDefined(spawnpoints[i].script_string))
		{
			tokens = strtok(spawnpoints[i].script_string," ");
			foreach(token in tokens)
			{
				if(token == match_string)
				{
					spawnpoint = spawnpoints[i];
					i = spawnpoints.size;
					break;
				}
			}
		}
	}

	setdemointermissionpoint(spawnpoint.origin,spawnpoint.angles);
}

//Function Number: 276
register_map_navcard(navcard_on_map,navcard_needed_for_computer)
{
	level.navcard_needed = navcard_needed_for_computer;
	level.map_navcard = navcard_on_map;
}

//Function Number: 277
does_player_have_map_navcard(player)
{
	return player maps/mp/zombies/_zm_stats::get_global_stat(level.map_navcard);
}

//Function Number: 278
does_player_have_correct_navcard(player)
{
	if(!(IsDefined(level.navcard_needed)))
	{
		return 0;
	}

	return player maps/mp/zombies/_zm_stats::get_global_stat(level.navcard_needed);
}

//Function Number: 279
place_navcard(str_model,str_stat,org,angles)
{
	navcard = spawn("script_model",org);
	navcard setmodel(str_model);
	navcard.angles = angles;
	wait(1);
	navcard_pickup_trig = spawn("trigger_radius_use",org,0,84,72);
	navcard_pickup_trig setcursorhint("HINT_NOICON");
	navcard_pickup_trig sethintstring(&"ZOMBIE_NAVCARD_PICKUP");
	navcard_pickup_trig triggerignoreteam();
	a_navcard_stats = array("navcard_held_zm_transit","navcard_held_zm_highrise","navcard_held_zm_buried");
	is_holding_card = 0;
	str_placing_stat = undefined;
	while(1)
	{
		navcard_pickup_trig waittill("trigger",who);
		if(is_player_valid(who))
		{
			foreach(str_cur_stat in a_navcard_stats)
			{
				if(who maps/mp/zombies/_zm_stats::get_global_stat(str_cur_stat))
				{
					str_placing_stat = str_cur_stat;
					is_holding_card = 1;
					who maps/mp/zombies/_zm_stats::set_global_stat(str_cur_stat,0);
				}
			}

			who playsound("zmb_buildable_piece_add");
			who maps/mp/zombies/_zm_stats::set_global_stat(str_stat,1);
			who.navcard_grabbed = str_stat;
			wait_network_frame();
			is_stat = who maps/mp/zombies/_zm_stats::get_global_stat(str_stat);
			thread sq_refresh_player_navcard_hud();
			break;
		}
	}

	navcard delete();
	navcard_pickup_trig delete();
	if(is_holding_card)
	{
		level thread place_navcard(str_model,str_placing_stat,org,angles);
	}
}

//Function Number: 280
sq_refresh_player_navcard_hud()
{
	if(!(IsDefined(level.navcards)))
	{
		return;
	}

	players = get_players();
	foreach(player in players)
	{
		player thread sq_refresh_player_navcard_hud_internal();
	}
}

//Function Number: 281
sq_refresh_player_navcard_hud_internal()
{
	self endon("disconnect");
	navcard_bits = 0;
	for(i = 0;i < level.navcards.size;i++)
	{
		hasit = self maps/mp/zombies/_zm_stats::get_global_stat(level.navcards[i]);
		if(IsDefined(self.navcard_grabbed) && self.navcard_grabbed == level.navcards[i])
		{
			hasit = 1;
		}

		if(hasit)
		{
			navcard_bits = navcard_bits + 1 << i;
		}
	}

	wait_network_frame();
	self setclientfield("navcard_held",0);
	if(navcard_bits > 0)
	{
		wait_network_frame();
		self setclientfield("navcard_held",navcard_bits);
	}
}

//Function Number: 282
set_player_is_female(onoff)
{
	if(IsDefined(level.use_female_animations) && level.use_female_animations)
	{
		female_perk = "specialty_gpsjammer";
		if(onoff)
		{
			self setperk(female_perk);
		}
		else
		{
			self unsetperk(female_perk);
		}
	}
}

//Function Number: 283
disable_player_move_states(forcestancechange)
{
	self allowcrouch(1);
	self allowlean(0);
	self allowads(0);
	self allowsprint(0);
	self allowprone(0);
	self allowmelee(0);
	if(IsDefined(forcestancechange) && forcestancechange == 1)
	{
		if(self getstance() == "prone")
		{
			self setstance("crouch");
		}
	}
}

//Function Number: 284
enable_player_move_states()
{
	if(!IsDefined(self._allow_lean) || self._allow_lean == 1)
	{
		self allowlean(1);
	}

	if(!IsDefined(self._allow_ads) || self._allow_ads == 1)
	{
		self allowads(1);
	}

	if(!IsDefined(self._allow_sprint) || self._allow_sprint == 1)
	{
		self allowsprint(1);
	}

	if(!IsDefined(self._allow_prone) || self._allow_prone == 1)
	{
		self allowprone(1);
	}

	if(!IsDefined(self._allow_melee) || self._allow_melee == 1)
	{
		self allowmelee(1);
	}
}

//Function Number: 285
check_and_create_node_lists()
{
	if(!(IsDefined(level._link_node_list)))
	{
		level._link_node_list = [];
	}

	if(!(IsDefined(level._unlink_node_list)))
	{
		level._unlink_node_list = [];
	}
}

//Function Number: 286
link_nodes(a,b,bdontunlinkonmigrate)
{
	if(!(IsDefined(bdontunlinkonmigrate)))
	{
		bdontunlinkonmigrate = 0;
	}

	if(nodesarelinked(a,b))
	{
		return;
	}

	check_and_create_node_lists();
	a_index_string = "" + a.origin;
	b_index_string = "" + b.origin;
	if(!(IsDefined(level._link_node_list[a_index_string])))
	{
		level._link_node_list[a_index_string] = spawnstruct();
		level._link_node_list[a_index_string].node = a;
		level._link_node_list[a_index_string].links = [];
		level._link_node_list[a_index_string].ignore_on_migrate = [];
	}

	if(!(IsDefined(level._link_node_list[a_index_string].links[b_index_string])))
	{
		level._link_node_list[a_index_string].links[b_index_string] = b;
		level._link_node_list[a_index_string].ignore_on_migrate[b_index_string] = bdontunlinkonmigrate;
	}

	if(IsDefined(level._unlink_node_list[a_index_string]))
	{
		if(IsDefined(level._unlink_node_list[a_index_string].links[b_index_string]))
		{
			level._unlink_node_list[a_index_string].links[b_index_string] = undefined;
			level._unlink_node_list[a_index_string].ignore_on_migrate[b_index_string] = undefined;
		}
	}

	linknodes(a,b);
}

//Function Number: 287
unlink_nodes(a,b,bdontlinkonmigrate)
{
	if(!(IsDefined(bdontlinkonmigrate)))
	{
		bdontlinkonmigrate = 0;
	}

	if(!(nodesarelinked(a,b)))
	{
		return;
	}

	check_and_create_node_lists();
	a_index_string = "" + a.origin;
	b_index_string = "" + b.origin;
	if(!(IsDefined(level._unlink_node_list[a_index_string])))
	{
		level._unlink_node_list[a_index_string] = spawnstruct();
		level._unlink_node_list[a_index_string].node = a;
		level._unlink_node_list[a_index_string].links = [];
		level._unlink_node_list[a_index_string].ignore_on_migrate = [];
	}

	if(!(IsDefined(level._unlink_node_list[a_index_string].links[b_index_string])))
	{
		level._unlink_node_list[a_index_string].links[b_index_string] = b;
		level._unlink_node_list[a_index_string].ignore_on_migrate[b_index_string] = bdontlinkonmigrate;
	}

	if(IsDefined(level._link_node_list[a_index_string]))
	{
		if(IsDefined(level._link_node_list[a_index_string].links[b_index_string]))
		{
			level._link_node_list[a_index_string].links[b_index_string] = undefined;
			level._link_node_list[a_index_string].ignore_on_migrate[b_index_string] = undefined;
		}
	}

	unlinknodes(a,b);
}

//Function Number: 288
spawn_path_node(origin,angles,k1,v1,k2,v2)
{
	if(!(IsDefined(level._spawned_path_nodes)))
	{
		level._spawned_path_nodes = [];
	}

	node = spawnstruct();
	node.origin = origin;
	node.angles = angles;
	node.k1 = k1;
	node.v1 = v1;
	node.k2 = k2;
	node.v2 = v2;
	node.node = spawn_path_node_internal(origin,angles,k1,v1,k2,v2);
	level._spawned_path_nodes[level._spawned_path_nodes.size] = node;
	return node.node;
}

//Function Number: 289
spawn_path_node_internal(origin,angles,k1,v1,k2,v2)
{
	if(IsDefined(k2))
	{
		return spawnpathnode("node_pathnode",origin,angles,k1,v1,k2,v2);
	}
	else if(IsDefined(k1))
	{
		return spawnpathnode("node_pathnode",origin,angles,k1,v1);
	}
	else
	{
		return spawnpathnode("node_pathnode",origin,angles);
	}
}

//Function Number: 290
delete_spawned_path_nodes()
{
}

//Function Number: 291
respawn_path_nodes()
{
	if(!(IsDefined(level._spawned_path_nodes)))
	{
		return;
	}

	for(i = 0;i < level._spawned_path_nodes.size;i++)
	{
		node_struct = level._spawned_path_nodes[i];
/#
		println("Re-spawning spawned path node @ " + node_struct.origin);
#/
		node_struct.node = spawn_path_node_internal(node_struct.origin,node_struct.angles,node_struct.k1,node_struct.v1,node_struct.k2,node_struct.v2);
	}
}

//Function Number: 292
link_changes_internal_internal(list,func)
{
	keys = getarraykeys(list);
	for(i = 0;i < keys.size;i++)
	{
		node = list[keys[i]].node;
		node_keys = getarraykeys(list[keys[i]].links);
		for(j = 0;j < node_keys.size;j++)
		{
			if(IsDefined(list[keys[i]].links[node_keys[j]]))
			{
				if(IsDefined(list[keys[i]].ignore_on_migrate[node_keys[j]]) && list[keys[i]].ignore_on_migrate[node_keys[j]])
				{
/#
					println("Node at " + keys[i] + " to node at " + node_keys[j] + " - IGNORED");
#/
				}
				else
				{
/#
					println("Node at " + keys[i] + " to node at " + node_keys[j]);
#/
					[[ func ]](node,list[keys[i]].links[node_keys[j]]);
				}
			}
		}
	}
}

//Function Number: 293
link_changes_internal(func_for_link_list,func_for_unlink_list)
{
	if(IsDefined(level._link_node_list))
	{
/#
		println("Link List");
#/
		link_changes_internal_internal(level._link_node_list,func_for_link_list);
	}

	if(IsDefined(level._unlink_node_list))
	{
/#
		println("UnLink List");
#/
		link_changes_internal_internal(level._unlink_node_list,func_for_unlink_list);
	}
}

//Function Number: 294
link_nodes_wrapper(a,b)
{
	if(!(nodesarelinked(a,b)))
	{
		linknodes(a,b);
	}
}

//Function Number: 295
unlink_nodes_wrapper(a,b)
{
	if(nodesarelinked(a,b))
	{
		unlinknodes(a,b);
	}
}

//Function Number: 296
undo_link_changes()
{
/#
	println("***");
	println("***");
	println("*** Undoing link changes");
#/
	link_changes_internal(::unlink_nodes_wrapper,::link_nodes_wrapper);
	delete_spawned_path_nodes();
}

//Function Number: 297
redo_link_changes()
{
/#
	println("***");
	println("***");
	println("*** Redoing link changes");
#/
	respawn_path_nodes();
	link_changes_internal(::link_nodes_wrapper,::unlink_nodes_wrapper);
}

//Function Number: 298
set_player_tombstone_index()
{
	if(!(IsDefined(level.tombstone_index)))
	{
		level.tombstone_index = 0;
	}

	if(!(IsDefined(self.tombstone_index)))
	{
		self.tombstone_index = level.tombstone_index;
		level.tombstone_index++;
	}
}

//Function Number: 299
hotjoin_setup_player(viewmodel)
{
	if(is_true(level.passed_introscreen) && !IsDefined(self.first_spawn) && !IsDefined(self.characterindex))
	{
		self.first_spawn = 1;
		self setviewmodel(viewmodel);
		return 1;
	}
}

//Function Number: 300
is_temporary_zombie_weapon(str_weapon)
{
	return is_zombie_perk_bottle(str_weapon) || str_weapon == level.revive_tool || str_weapon == "zombie_builder_zm" || str_weapon == "chalk_draw_zm" || str_weapon == "no_hands_zm" || str_weapon == level.machine_assets["packapunch"].weapon;
}

//Function Number: 301
is_gametype_active(a_gametypes)
{
	b_is_gametype_active = 0;
	if(!(isarray(a_gametypes)))
	{
		a_gametypes = array(a_gametypes);
	}

	for(i = 0;i < a_gametypes.size;i++)
	{
		if(GetDvar(#"4F118387") == a_gametypes[i])
		{
			b_is_gametype_active = 1;
		}
	}

	return b_is_gametype_active;
}

//Function Number: 302
is_createfx_active()
{
	if(!(IsDefined(level.createfx_enabled)))
	{
		level.createfx_enabled = GetDvar(#"134D5297") != "";
	}

	return level.createfx_enabled;
}

//Function Number: 303
is_zombie_perk_bottle(str_weapon)
{
	switch(str_weapon)
	{
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
			b_is_perk_bottle = 1;
			break;

		default:
			b_is_perk_bottle = 0;
			break;
	}

	return b_is_perk_bottle;
}

//Function Number: 304
register_custom_spawner_entry(spot_noteworthy,func)
{
	if(!(IsDefined(level.custom_spawner_entry)))
	{
		level.custom_spawner_entry = [];
	}

	level.custom_spawner_entry[spot_noteworthy] = func;
}

//Function Number: 305
get_player_weapon_limit(player)
{
	if(IsDefined(level.get_player_weapon_limit))
	{
		return [[ level.get_player_weapon_limit ]](player);
	}

	weapon_limit = 2;
	if(player hasperk("specialty_additionalprimaryweapon"))
	{
		weapon_limit = level.additionalprimaryweapon_limit;
	}

	return weapon_limit;
}

//Function Number: 306
get_player_perk_purchase_limit()
{
	if(IsDefined(level.get_player_perk_purchase_limit))
	{
		return self [[ level.get_player_perk_purchase_limit ]]();
	}

	return level.perk_purchase_limit;
}