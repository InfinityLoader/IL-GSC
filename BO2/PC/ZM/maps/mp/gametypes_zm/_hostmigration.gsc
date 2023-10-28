/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_hostmigration.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 5 ms
 * Timestamp: 10/28/2023 12:11:37 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_hud;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
debug_script_structs()
{
/#
	if(IsDefined(level.struct))
	{
		println("*** Num structs " + level.struct.size);
		println("");
		for(i = 0;i < level.struct.size;i++)
		{
			struct = level.struct[i];
			if(IsDefined(struct.targetname))
			{
				println("---" + i + " : " + struct.targetname);
			}
			else
			{
				println("---" + i + " : " + "NONE");
			}
		}
	}
	else
	{
		println("*** No structs defined.");
	}
#/
}

//Function Number: 2
updatetimerpausedness()
{
	shouldbestopped = IsDefined(level.hostmigrationtimer);
	if(!level.timerstopped && shouldbestopped)
	{
		level.timerstopped = 1;
		level.timerpausetime = GetTime();
	}
	else if(level.timerstopped && !shouldbestopped)
	{
		level.timerstopped = 0;
		level.discardtime = level.discardtime + GetTime() - level.timerpausetime;
	}
}

//Function Number: 3
callback_hostmigrationsave()
{
}

//Function Number: 4
callback_prehostmigrationsave()
{
	undo_link_changes();
	disablezombies(1);
	if(is_true(level._hm_should_pause_spawning))
	{
		flag_set("spawn_zombies");
	}

	for(i = 0;i < level.players.size;i++)
	{
		level.players[i] enableinvulnerability();
	}
}

//Function Number: 5
pausetimer()
{
	level.migrationtimerpausetime = GetTime();
}

//Function Number: 6
resumetimer()
{
	level.discardtime = level.discardtime + GetTime() - level.migrationtimerpausetime;
}

//Function Number: 7
locktimer()
{
	level endon("host_migration_begin");
	level endon("host_migration_end");
	for(;;)
	{
		currtime = GetTime();
		wait(0.05);
		if(!level.timerstopped && IsDefined(level.discardtime))
		{
			level.discardtime = level.discardtime + GetTime() - currtime;
		}
	}
}

//Function Number: 8
callback_hostmigration()
{
	redo_link_changes();
	setslowmotion(1,1,0);
	makedvarserverinfo("ui_guncycle",0);
	level.hostmigrationreturnedplayercount = 0;
	if(level.gameended)
	{
/#
		println("Migration starting at time " + GetTime() + ", but game has ended, so no countdown.");
#/
		return;
	}

	sethostmigrationstatus(1);
	level notify("host_migration_begin");
	for(i = 0;i < level.players.size;i++)
	{
		if(IsDefined(level.hostmigration_link_entity_callback))
		{
			if(!(IsDefined(level.players[i]._host_migration_link_entity)))
			{
				level.players[i]._host_migration_link_entity = level.players[i] [[ level.hostmigration_link_entity_callback ]]();
			}
		}

		level.players[i] thread hostmigrationtimerthink();
	}

	if(IsDefined(level.hostmigration_ai_link_entity_callback))
	{
		zombies = getaiarray(level.zombie_team);
		if(IsDefined(zombies) && zombies.size > 0)
		{
			foreach(zombie in zombies)
			{
				if(!(IsDefined(zombie._host_migration_link_entity)))
				{
					zombie._host_migration_link_entity = zombie [[ level.hostmigration_ai_link_entity_callback ]]();
				}
			}
		}
	}

	if(level.inprematchperiod)
	{
		level waittill(_k133,"prematch_over");
	}

/#
	println("Migration starting at time " + GetTime());
#/
	level.hostmigrationtimer = 1;
	thread locktimer();
	zombies = getaiarray(level.zombie_team);
	if(IsDefined(zombies) && zombies.size > 0)
	{
		foreach(zombie in zombies)
		{
			if(IsDefined(zombie._host_migration_link_entity))
			{
				ent = spawn("script_origin",zombie.origin);
				ent.angles = zombie.angles;
				zombie linkto(ent);
				ent linkto(zombie._host_migration_link_entity,"tag_origin",zombie._host_migration_link_entity worldtolocalcoords(ent.origin),ent.angles + zombie._host_migration_link_entity.angles);
				zombie._host_migration_link_helper = ent;
				zombie linkto(zombie._host_migration_link_helper);
			}
		}
	}

	level endon("host_migration_begin",_k156);
	level._hm_should_pause_spawning = flag("spawn_zombies");
	if(level._hm_should_pause_spawning)
	{
		flag_clear("spawn_zombies");
	}

	hostmigrationwait();
	foreach(player in level.players)
	{
		player thread post_migration_become_vulnerable();
	}

	zombies = getaiarray(level.zombie_team);
	if(IsDefined(zombies) && zombies.size > 0)
	{
		foreach(zombie in zombies)
		{
			if(IsDefined(zombie._host_migration_link_entity))
			{
				zombie unlink();
				zombie._host_migration_link_helper delete();
				zombie._host_migration_link_helper = undefined;
				zombie._host_migration_link_entity = undefined;
			}
		}
	}

	enablezombies(1);
	if(level._hm_should_pause_spawning)
	{
		flag_set("spawn_zombies");
	}

	level.hostmigrationtimer = undefined;
	level._hm_should_pause_spawning = undefined;
	sethostmigrationstatus(0);
/#
	println("Migration finished at time " + GetTime());
#/
	level notify("host_migration_end",_k193,_k185);
}

//Function Number: 9
post_migration_become_vulnerable()
{
	self endon("disconnect");
	wait(3);
	self disableinvulnerability();
}

//Function Number: 10
matchstarttimerconsole_internal(counttime,matchstarttimer)
{
	waittillframeend;
	level endon("match_start_timer_beginning");
	while(counttime > 0 && !level.gameended)
	{
		matchstarttimer thread maps/mp/gametypes_zm/_hud::fontpulse(level);
		wait(matchstarttimer.inframes * 0.05);
		matchstarttimer setvalue(counttime);
		counttime--;
		wait(1 - matchstarttimer.inframes * 0.05);
	}
}

//Function Number: 11
matchstarttimerconsole(type,duration)
{
	level notify("match_start_timer_beginning");
	wait(0.05);
	matchstarttext = createserverfontstring("objective",1.5);
	matchstarttext setpoint("CENTER","CENTER",0,-40);
	matchstarttext.sort = 1001;
	matchstarttext settext(game["strings"]["waiting_for_teams"]);
	matchstarttext.foreground = 0;
	matchstarttext.hidewheninmenu = 1;
	matchstarttext settext(game["strings"][type]);
	matchstarttimer = createserverfontstring("objective",2.2);
	matchstarttimer setpoint("CENTER","CENTER",0,0);
	matchstarttimer.sort = 1001;
	matchstarttimer.color = (1,1,0);
	matchstarttimer.foreground = 0;
	matchstarttimer.hidewheninmenu = 1;
	matchstarttimer maps/mp/gametypes_zm/_hud::fontpulseinit();
	counttime = int(duration);
	if(counttime >= 2)
	{
		matchstarttimerconsole_internal(counttime,matchstarttimer);
	}
	else
	{
	}

	matchstarttimer destroyelem();
	matchstarttext destroyelem();
}

//Function Number: 12
hostmigrationwait()
{
	level endon("game_ended");
	if(level.hostmigrationreturnedplayercount < level.players.size * 2 / 3)
	{
		thread matchstarttimerconsole("waiting_for_teams",20);
		hostmigrationwaitforplayers();
	}

	thread matchstarttimerconsole("match_starting_in",5);
	wait(5);
}

//Function Number: 13
hostmigrationwaitforplayers()
{
	level endon("hostmigration_enoughplayers");
	wait(15);
}

//Function Number: 14
hostmigrationtimerthink_internal()
{
	level endon("host_migration_begin");
	level endon("host_migration_end");
	self.hostmigrationcontrolsfrozen = 0;
	while(!(isalive(self)))
	{
		self waittill("spawned");
	}

	if(IsDefined(self._host_migration_link_entity))
	{
		ent = spawn("script_origin",self.origin);
		ent.angles = self.angles;
		self linkto(ent);
		ent linkto(self._host_migration_link_entity,"tag_origin",self._host_migration_link_entity worldtolocalcoords(ent.origin),ent.angles + self._host_migration_link_entity.angles);
		self._host_migration_link_helper = ent;
/#
		println("Linking player to ent " + self._host_migration_link_entity.targetname);
	}
#/
	self.hostmigrationcontrolsfrozen = 1;
	self freezecontrols(1);
	level waittill("host_migration_end");
}

//Function Number: 15
hostmigrationtimerthink()
{
	self endon("disconnect");
	level endon("host_migration_begin");
	hostmigrationtimerthink_internal();
	if(self.hostmigrationcontrolsfrozen)
	{
		self freezecontrols(0);
		self.hostmigrationcontrolsfrozen = 0;
/#
		println(" Host migration unfreeze controls");
	}
#/
	if(IsDefined(self._host_migration_link_entity))
	{
		self unlink();
		self._host_migration_link_helper delete();
		self._host_migration_link_helper = undefined;
		if(IsDefined(self._host_migration_link_entity._post_host_migration_thread))
		{
			self thread [[ self._host_migration_link_entity._post_host_migration_thread ]](self._host_migration_link_entity);
		}

		self._host_migration_link_entity = undefined;
	}
}

//Function Number: 16
waittillhostmigrationdone()
{
	if(!(IsDefined(level.hostmigrationtimer)))
	{
		return 0;
	}

	starttime = GetTime();
	level waittill("host_migration_end");
	return GetTime() - starttime;
}

//Function Number: 17
waittillhostmigrationstarts(duration)
{
	if(IsDefined(level.hostmigrationtimer))
	{
		return;
	}

	level endon("host_migration_begin");
	wait(duration);
}

//Function Number: 18
waitlongdurationwithhostmigrationpause(duration)
{
	if(duration == 0)
	{
		return;
	}

/#
	assert(duration > 0);
#/
	starttime = GetTime();
	endtime = GetTime() + duration * 1000;
	while(GetTime() < endtime)
	{
		waittillhostmigrationstarts(endtime - GetTime() / 1000);
		if(IsDefined(level.hostmigrationtimer))
		{
			timepassed = waittillhostmigrationdone();
			endtime = endtime + timepassed;
		}
	}

	if(GetTime() != endtime)
	{
/#
		println("SCRIPT WARNING: gettime() = " + GetTime() + " NOT EQUAL TO endtime = " + endtime);
	}
#/
	waittillhostmigrationdone();
	return GetTime() - starttime;
}

//Function Number: 19
waitlongdurationwithgameendtimeupdate(duration)
{
	if(duration == 0)
	{
		return;
	}

/#
	assert(duration > 0);
#/
	starttime = GetTime();
	endtime = GetTime() + duration * 1000;
	while(GetTime() < endtime)
	{
		waittillhostmigrationstarts(endtime - GetTime() / 1000);
		while(IsDefined(level.hostmigrationtimer))
		{
			endtime = endtime + 1000;
			setgameendtime(int(endtime));
			wait(1);
		}
	}

/#
	if(GetTime() != endtime)
	{
		println("SCRIPT WARNING: gettime() = " + GetTime() + " NOT EQUAL TO endtime = " + endtime);
	}

		for(;;)
		{
#/
		if(IsDefined(level.hostmigrationtimer))
		{
			endtime = endtime + 1000;
			setgameendtime(int(endtime));
			wait(1);
		}
	}

	return GetTime() - starttime;
}

//Function Number: 20
find_alternate_player_place(v_origin,min_radius,max_radius,max_height,ignore_targetted_nodes)
{
	found_node = undefined;
	a_nodes = getnodesinradiussorted(v_origin,max_radius,min_radius,max_height,"pathnodes");
	if(IsDefined(a_nodes) && a_nodes.size > 0)
	{
		a_player_volumes = getentarray("player_volume","script_noteworthy");
		index = a_nodes.size - 1;
		for(i = index;i >= 0;i--)
		{
			n_node = a_nodes[i];
			if(ignore_targetted_nodes == 1)
			{
				if(IsDefined(n_node.target))
				{
				}
				else if(!(positionwouldtelefrag(n_node.origin)))
				{
					if(maps/mp/zombies/_zm_utility::check_point_in_enabled_zone(n_node.origin,1,a_player_volumes))
					{
						v_start = (n_node.origin[0],n_node.origin[1],n_node.origin[2] + 30);
						v_end = (n_node.origin[0],n_node.origin[1],n_node.origin[2] - 30);
						trace = bullettrace(v_start,v_end,0,undefined);
						if(trace["fraction"] < 1)
						{
							override_abort = 0;
							if(IsDefined(level._chugabud_reject_node_override_func))
							{
								override_abort = [[ level._chugabud_reject_node_override_func ]](v_origin,n_node);
							}

							if(!(override_abort))
							{
								found_node = n_node;
								break;
							}
						}
					}
				}
			}
		}
	}

	return found_node;
}

//Function Number: 21
hostmigration_put_player_in_better_place()
{
	spawnpoint = undefined;
	spawnpoint = find_alternate_player_place(self.origin,50,150,64,1);
	if(!(IsDefined(spawnpoint)))
	{
		spawnpoint = find_alternate_player_place(self.origin,150,400,64,1);
	}

	if(!(IsDefined(spawnpoint)))
	{
		spawnpoint = find_alternate_player_place(self.origin,50,400,256,0);
	}

	if(!(IsDefined(spawnpoint)))
	{
		spawnpoint = maps/mp/zombies/_zm::check_for_valid_spawn_near_team(self,1);
	}

	if(!(IsDefined(spawnpoint)))
	{
		match_string = "";
		location = level.scr_zm_map_start_location;
		if((location == "default" || location == "") && IsDefined(level.default_start_location))
		{
			location = level.default_start_location;
		}

		match_string = level.scr_zm_ui_gametype + "_" + location;
		spawnpoints = [];
		structs = getstructarray("initial_spawn","script_noteworthy");
		if(IsDefined(structs))
		{
			foreach(struct in structs)
			{
				if(IsDefined(struct.script_string))
				{
					tokens = strtok(struct.script_string," ");
					foreach(token in tokens)
					{
						if(token == match_string)
						{
							spawnpoints[spawnpoints.size] = struct;
						}
					}
				}
			}
		}

		if(!IsDefined(spawnpoints) || spawnpoints.size == 0)
		{
			spawnpoints = getstructarray("initial_spawn_points","targetname");
		}

/#
		assert(IsDefined(spawnpoints),"Could not find initial spawn points!");
#/
		spawnpoint = maps/mp/zombies/_zm::getfreespawnpoint(spawnpoints,self);
	}

	if(IsDefined(spawnpoint))
	{
		self setorigin(spawnpoint.origin);
	}
}