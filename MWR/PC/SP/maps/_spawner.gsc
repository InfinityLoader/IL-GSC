/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_spawner.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 211
 * Decompile Time: 3281 ms
 * Timestamp: 10/27/2023 2:48:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachemodel("grenade_bag");
	createthreatbiasgroup("allies");
	createthreatbiasgroup("axis");
	createthreatbiasgroup("team3");
	createthreatbiasgroup("civilian");
	maps\_anim::addnotetrack_customfunction("generic","rappel_pushoff_initial_npc",::maps\_utility::enable_achievement_harder_they_fall_guy);
	maps\_anim::addnotetrack_customfunction("generic","ps_rappel_pushoff_initial_npc",::maps\_utility::enable_achievement_harder_they_fall_guy);
	maps\_anim::addnotetrack_customfunction("generic","feet_on_ground",::maps\_utility::disable_achievement_harder_they_fall_guy);
	maps\_anim::addnotetrack_customfunction("generic","ps_rappel_clipout_npc",::maps\_utility::disable_achievement_harder_they_fall_guy);
	foreach(var_01 in level.players)
	{
		var_01 setthreatbiasgroup("allies");
	}

	level._nextcoverprint = 0;
	level._ai_group = [];
	level.killedaxis = 0;
	level.ffpoints = 0;
	level.missionfailed = 0;
	level.gather_delay = [];
	level.smoke_thrown = [];
	if(!isdefined(level.deathflags))
	{
		level.deathflags = [];
	}

	level.spawner_number = 0;
	level.go_to_node_arrays = [];
	if(!isdefined(level.subclass_spawn_functions))
	{
		level.subclass_spawn_functions = [];
	}

	level.subclass_spawn_functions["regular"] = ::subclass_regular;
	level.subclass_spawn_functions["elite"] = ::subclass_elite;
	level.team_specific_spawn_functions = [];
	level.team_specific_spawn_functions["axis"] = ::spawn_team_axis;
	level.team_specific_spawn_functions["allies"] = ::spawn_team_allies;
	level.team_specific_spawn_functions["team3"] = ::spawn_team_team3;
	level.team_specific_spawn_functions["neutral"] = ::spawn_team_neutral;
	level.next_health_drop_time = 0;
	level.guys_to_die_before_next_health_drop = randomintrange(1,4);
	if(!isdefined(level.default_goalradius))
	{
		level.default_goalradius = 2048;
	}

	if(!isdefined(level.default_goalheight))
	{
		level.default_goalheight = 80;
	}

	level.portable_mg_gun_tag = "J_Shoulder_RI";
	level.mg42_hide_distance = 1024;
	if(!isdefined(level.maxfriendlies))
	{
		level.maxfriendlies = 11;
	}

	level._max_script_health = 0;
	var_03 = getaispeciesarray();
	common_scripts\utility::array_thread(var_03,::living_ai_prethink);
	level.ai_classname_in_level = [];
	level.drone_paths = [];
	var_04 = getspawnerarray();
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_04[var_05] thread spawn_prethink();
	}

	level.drone_paths = undefined;
	thread process_deathflags();
	common_scripts\utility::array_thread(var_03,::spawn_think);
	level.ai_classname_in_level_keys = getarraykeys(level.ai_classname_in_level);
	for(var_05 = 0;var_05 < level.ai_classname_in_level_keys.size;var_05++)
	{
		if(!issubstr(tolower(level.ai_classname_in_level_keys[var_05]),"rpg"))
		{
			continue;
		}

		precacheitem("rpg_player");
		break;
	}

	level.ai_classname_in_level_keys = undefined;
}

//Function Number: 2
aitype_check()
{
}

//Function Number: 3
check_script_char_group_ratio(param_00)
{
	if(param_00.size <= 16)
	{
		return;
	}

	var_01 = 0;
	var_02 = 0;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(!param_00[var_03].team != "axis")
		{
			continue;
		}

		var_01++;
		if(!param_00[var_03] has_char_group())
		{
			continue;
		}

		var_02++;
	}
}

//Function Number: 4
has_char_group()
{
	if(isdefined(self.script_char_group))
	{
		return 1;
	}

	return isdefined(self.script_char_index);
}

//Function Number: 5
process_deathflags()
{
	foreach(var_02, var_01 in level.deathflags)
	{
		level.deathflags[var_02] = [];
		level.deathflags[var_02]["spawners"] = [];
		level.deathflags[var_02]["ai"] = [];
		if(!isdefined(level.flag[var_02]))
		{
			common_scripts\utility::flag_init(var_02);
		}
	}
}

//Function Number: 6
spawn_guys_until_death_or_no_count()
{
	self endon("death");
	for(;;)
	{
		if(self.count > 0)
		{
			self waittill("spawned");
		}

		waittillframeend;
		if(!self.count)
		{
			return;
		}
	}
}

//Function Number: 7
ai_deathflag()
{
	level.deathflags[self.script_deathflag]["ai"][self.unique_id] = self;
	var_00 = self.unique_id;
	var_01 = self.script_deathflag;
	if(isdefined(self.script_deathflag_longdeath))
	{
		waittilldeathorpaindeath();
	}
	else
	{
		self waittill("death");
	}

	level.deathflags[var_01]["ai"][var_00] = undefined;
	update_deathflag(var_01);
}

//Function Number: 8
vehicle_deathflag()
{
	var_00 = self.unique_id;
	var_01 = self.script_deathflag;
	if(!isdefined(level.deathflags) || !isdefined(level.deathflags[self.script_deathflag]))
	{
		waittillframeend;
		if(!isdefined(self))
		{
			return;
		}
	}

	level.deathflags[var_01]["vehicles"][var_00] = self;
	self waittill("death");
	level.deathflags[var_01]["vehicles"][var_00] = undefined;
	update_deathflag(var_01);
}

//Function Number: 9
spawner_deathflag()
{
	level.deathflags[self.script_deathflag] = [];
	waittillframeend;
	if(!isdefined(self) || self.count == 0)
	{
		return;
	}

	self.spawner_number = level.spawner_number;
	level.spawner_number++;
	level.deathflags[self.script_deathflag]["spawners"][self.spawner_number] = self;
	var_00 = self.script_deathflag;
	var_01 = self.spawner_number;
	spawn_guys_until_death_or_no_count();
	level.deathflags[var_00]["spawners"][var_01] = undefined;
	update_deathflag(var_00);
}

//Function Number: 10
vehicle_spawner_deathflag()
{
	level.deathflags[self.script_deathflag] = [];
	waittillframeend;
	if(!isdefined(self))
	{
		return;
	}

	self.spawner_number = level.spawner_number;
	level.spawner_number++;
	level.deathflags[self.script_deathflag]["vehicle_spawners"][self.spawner_number] = self;
	var_00 = self.script_deathflag;
	var_01 = self.spawner_number;
	spawn_guys_until_death_or_no_count();
	level.deathflags[var_00]["vehicle_spawners"][var_01] = undefined;
	update_deathflag(var_00);
}

//Function Number: 11
update_deathflag(param_00)
{
	level notify("updating_deathflag_" + param_00);
	level endon("updating_deathflag_" + param_00);
	waittillframeend;
	foreach(var_02 in level.deathflags[param_00])
	{
		if(getarraykeys(var_02).size > 0)
		{
			return;
		}
	}

	common_scripts\utility::flag_set(param_00);
}

//Function Number: 12
outdoor_think(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isai(var_01))
		{
			continue;
		}

		var_01 thread maps\_utility::ignore_triggers(0.15);
		var_01 maps\_utility::disable_cqbwalk();
		var_01.wantshotgun = 0;
	}
}

//Function Number: 13
indoor_think(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isai(var_01))
		{
			continue;
		}

		var_01 thread maps\_utility::ignore_triggers(0.15);
		var_01 maps\_utility::enable_cqbwalk();
		var_01.wantshotgun = 1;
	}
}

//Function Number: 14
doautospawn(param_00)
{
	param_00 endon("death");
	self endon("death");
	for(;;)
	{
		self waittill("trigger");
		if(!param_00.count)
		{
			return;
		}

		if(self.target != param_00.targetname)
		{
			return;
		}

		if(isdefined(param_00.triggerunlocked))
		{
			return;
		}

		var_01 = param_00 maps\_utility::spawn_ai();
		if(maps\_utility::spawn_failed(var_01))
		{
			param_00 notify("spawn_failed");
		}

		if(isdefined(self.wait) && self.wait > 0)
		{
			wait(self.wait);
		}
	}
}

//Function Number: 15
trigger_spawner(param_00)
{
	var_01 = param_00.random_killspawner;
	var_02 = param_00.target;
	param_00 waittill("trigger");
	param_00 maps\_utility::script_delay();
	if(isdefined(var_01))
	{
		waittillframeend;
	}

	var_03 = getentarray(var_02,"targetname");
	foreach(var_05 in var_03)
	{
		if(var_05.code_classname == "script_vehicle")
		{
			if((isdefined(var_05.script_moveoverride) && var_05.script_moveoverride == 1) || !isdefined(var_05.target))
			{
				thread maps\_vehicle::vehicle_spawn(var_05);
			}
			else
			{
				var_05 thread maps\_vehicle::spawn_vehicle_and_gopath();
			}

			continue;
		}

		var_05 thread trigger_spawner_spawns_guys();
		if(level.currentgen)
		{
			wait(0.1);
		}
	}

	if(isdefined(level.spawn_pool_enabled))
	{
		trigger_pool_spawners(var_02);
	}
}

//Function Number: 16
trigger_pool_spawners(param_00)
{
	var_01 = common_scripts\utility::getstructarray(param_00,"targetname");
	if(getentarray(param_00,"target").size <= 1)
	{
		maps\_utility::deletestructarray_ref(var_01);
	}

	var_02 = get_pool_spawners_from_structarray(var_01);
	common_scripts\utility::array_thread(var_02,::trigger_spawner_spawns_guys);
}

//Function Number: 17
get_pool_spawners_from_structarray(param_00)
{
	var_01 = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.script_spawn_pool))
		{
			continue;
		}

		if(!isdefined(var_02[var_04.script_spawn_pool]))
		{
			var_02[var_04.script_spawn_pool] = [];
		}

		var_02[var_04.script_spawn_pool][var_02[var_04.script_spawn_pool].size] = var_04;
	}

	foreach(var_07 in var_02)
	{
		foreach(var_04 in var_07)
		{
			var_09 = get_spawner_from_pool(var_04,var_07.size);
			var_01[var_01.size] = var_09;
		}
	}

	return var_01;
}

//Function Number: 18
get_spawner_from_pool(param_00,param_01)
{
	if(!isdefined(level.spawner_pool))
	{
		level.spawner_pool = [];
	}

	if(!isdefined(level.spawner_pool[param_00.script_spawn_pool]))
	{
		level.spawner_pool[param_00.script_spawn_pool] = create_new_spawner_pool(param_00.script_spawn_pool);
	}

	var_02 = level.spawner_pool[param_00.script_spawn_pool];
	var_03 = var_02.pool[var_02.poolindex];
	var_02.poolindex++;
	var_02.poolindex = var_02.poolindex % var_02.pool.size;
	var_03.origin = param_00.origin;
	if(isdefined(param_00.angles))
	{
		var_03.angles = param_00.angles;
	}
	else if(isdefined(param_00.target))
	{
		var_04 = getnode(param_00.target,"targetname");
		if(isdefined(var_04))
		{
			var_03.angles = vectortoangles(var_04.origin - var_03.origin);
		}
	}

	if(isdefined(level.spawn_pool_copy_function))
	{
		var_03 [[ level.spawn_pool_copy_function ]](param_00);
	}

	if(isdefined(param_00.target))
	{
		var_03.target = param_00.target;
	}

	var_03.count = 1;
	return var_03;
}

//Function Number: 19
create_new_spawner_pool(param_00)
{
	var_01 = getspawnerarray();
	var_02 = spawnstruct();
	var_03 = [];
	foreach(var_05 in var_01)
	{
		if(!isdefined(var_05.script_spawn_pool))
		{
			continue;
		}

		if(var_05.script_spawn_pool != param_00)
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	var_02.poolindex = 0;
	var_02.pool = var_03;
	return var_02;
}

//Function Number: 20
trigger_spawner_spawns_guys()
{
	self endon("death");
	maps\_utility::script_delay();
	if(!isdefined(self))
	{
		return undefined;
	}

	if(isdefined(self.script_drone))
	{
		var_00 = maps\_utility::dronespawn(self,1);
		return undefined;
	}
	else if(!issubstr(self.classname,"actor"))
	{
		return undefined;
	}

	var_01 = isdefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
	if(isdefined(self.script_forcespawn))
	{
		var_00 = self stalingradspawn(var_01);
	}
	else
	{
		var_00 = self dospawn(var_01);
	}

	if(!maps\_utility::spawn_failed(var_01))
	{
		if(isdefined(self.script_combatbehavior))
		{
			if(self.script_combatbehavior == "heat")
			{
				var_01 maps\_utility::enable_heat_behavior();
			}

			if(self.script_combatbehavior == "cqb")
			{
				var_01 maps\_utility::enable_cqbwalk();
			}
		}

		var_01 maps\_colors::setup_nodes_intelligently_from_team();
	}

	return var_01;
}

//Function Number: 21
trigger_spawner_reinforcement(param_00)
{
	var_01 = param_00.target;
	var_02 = 0;
	var_03 = getentarray(var_01,"targetname");
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.target))
		{
			continue;
		}

		var_06 = getent(var_05.target,"targetname");
		if(!isdefined(var_06))
		{
			if(!isdefined(var_05.script_linkto))
			{
				continue;
			}

			var_06 = var_05 common_scripts\utility::get_linked_ent();
			if(!isdefined(var_06))
			{
				continue;
			}

			if(!isspawner(var_06))
			{
				continue;
			}
		}

		var_02 = 1;
		break;
	}

	param_00 waittill("trigger");
	param_00 maps\_utility::script_delay();
	var_03 = getentarray(var_01,"targetname");
	foreach(var_05 in var_03)
	{
		var_05 thread trigger_reinforcement_spawn_guys();
	}
}

//Function Number: 22
trigger_reinforcement_spawn_guys()
{
	var_00 = trigger_reinforcement_get_reinforcement_spawner();
	var_01 = trigger_spawner_spawns_guys();
	if(!isdefined(var_01))
	{
		self delete();
		if(isdefined(var_00))
		{
			var_01 = var_00 trigger_spawner_spawns_guys();
			var_00 delete();
			if(!isdefined(var_01))
			{
				return;
			}
		}
		else
		{
			return;
		}
	}

	if(!isdefined(var_00))
	{
		return;
	}

	var_01 waittill("death");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.count))
	{
		var_00.count = 1;
	}

	for(;;)
	{
		if(!isdefined(var_00))
		{
			break;
		}

		var_02 = var_00 thread trigger_spawner_spawns_guys();
		if(!isdefined(var_02))
		{
			var_00 delete();
			break;
		}

		var_02 thread reincrement_count_if_deleted(var_00);
		var_02 waittill("death",var_03);
		if(!player_saw_kill(var_02,var_03))
		{
			if(!isdefined(var_00))
			{
				break;
			}

			var_00.count++;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(!isdefined(var_00))
		{
			break;
		}

		if(!isdefined(var_00.count))
		{
			break;
		}

		if(var_00.count <= 0)
		{
			break;
		}

		if(!maps\_utility::script_wait())
		{
			wait(randomfloatrange(1,3));
		}
	}

	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 23
trigger_reinforcement_get_reinforcement_spawner()
{
	if(isdefined(self.target))
	{
		var_00 = getent(self.target,"targetname");
		if(isdefined(var_00) && isspawner(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.script_linkto))
	{
		var_00 = common_scripts\utility::get_linked_ent();
		if(isdefined(var_00) && isspawner(var_00))
		{
			return var_00;
		}
	}

	return undefined;
}

//Function Number: 24
flood_spawner_scripted(param_00)
{
	common_scripts\utility::array_thread(param_00,::flood_spawner_init);
	common_scripts\utility::array_thread(param_00,::flood_spawner_think);
}

//Function Number: 25
reincrement_count_if_deleted(param_00)
{
	param_00 endon("death");
	if(isdefined(self.script_force_count))
	{
		if(self.script_force_count)
		{
			return;
		}
	}

	self waittill("death");
	if(!isdefined(self))
	{
		param_00.count++;
	}
}

//Function Number: 26
delete_start(param_00)
{
	var_01 = 0;
	if(var_01 < 2)
	{
		switch(var_01)
		{
			case 0:
				break;

			default:
				break;
		}
	}
}

//Function Number: 27
kill_trigger(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_00.targetname) && param_00.targetname != "flood_spawner")
	{
		return;
	}

	param_00 delete();
}

//Function Number: 28
random_killspawner(param_00)
{
	param_00 endon("death");
	var_01 = param_00.script_random_killspawner;
	waittillframeend;
	if(!isdefined(level.killspawn_groups[var_01]))
	{
		return;
	}

	param_00 waittill("trigger");
	cull_spawners_from_killspawner(var_01);
}

//Function Number: 29
cull_spawners_from_killspawner(param_00)
{
	if(!isdefined(level.killspawn_groups[param_00]))
	{
		return;
	}

	var_01 = level.killspawn_groups[param_00];
	var_02 = getarraykeys(var_01);
	if(var_02.size <= 1)
	{
		return;
	}

	var_03 = common_scripts\utility::random(var_02);
	var_01[var_03] = undefined;
	foreach(var_09, var_05 in var_01)
	{
		foreach(var_07 in var_05)
		{
			if(isdefined(var_07))
			{
				var_07 delete();
			}
		}

		level.killspawn_groups[param_00][var_09] = undefined;
	}
}

//Function Number: 30
killspawner(param_00)
{
	var_01 = getspawnerarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02].script_killspawner) && param_00 == var_01[var_02].script_killspawner)
		{
			var_01[var_02] delete();
		}
	}
}

//Function Number: 31
kill_spawner(param_00)
{
	var_01 = param_00.script_killspawner;
	param_00 waittill("trigger");
	waittillframeend;
	waittillframeend;
	killspawner(var_01);
	kill_trigger(param_00);
}

//Function Number: 32
empty_spawner(param_00)
{
	var_01 = param_00.script_emptyspawner;
	param_00 waittill("trigger");
	var_02 = getspawnerarray();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!isdefined(var_02[var_03].script_emptyspawner))
		{
			continue;
		}

		if(var_01 != var_02[var_03].script_emptyspawner)
		{
			continue;
		}

		if(isdefined(var_02[var_03].script_flanker))
		{
			level notify("stop_flanker_behavior" + var_02[var_03].script_flanker);
		}

		var_02[var_03] maps\_utility::set_count(0);
		var_02[var_03] notify("emptied spawner");
	}

	param_00 notify("deleted spawners");
}

//Function Number: 33
kill_spawnernum(param_00)
{
	var_01 = getspawnerarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(var_01[var_02].script_killspawner))
		{
			continue;
		}

		if(param_00 != var_01[var_02].script_killspawner)
		{
			continue;
		}

		var_01[var_02] delete();
	}
}

//Function Number: 34
trigger_spawn(param_00)
{
}

//Function Number: 35
spawn_grenade(param_00,param_01)
{
	if(!isdefined(level.grenade_cache) || !isdefined(level.grenade_cache[param_01]))
	{
		level.grenade_cache_index[param_01] = 0;
		level.grenade_cache[param_01] = [];
	}

	var_02 = level.grenade_cache_index[param_01];
	var_03 = level.grenade_cache[param_01][var_02];
	if(isdefined(var_03))
	{
		var_03 delete();
	}

	var_04 = "weapon_fraggrenade";
	if(isdefined(level.player) && isdefined(level.player.variable_grenade))
	{
		if(common_scripts\utility::cointoss())
		{
			var_04 = "weapon_frag_grenade_var";
		}
		else
		{
			var_04 = "weapon_flash_grenade_var";
		}
	}

	var_03 = spawn(var_04,param_00);
	level.grenade_cache[param_01][var_02] = var_03;
	level.grenade_cache_index[param_01] = var_02 + 1 % 16;
	return var_03;
}

//Function Number: 36
waittilldeathorpaindeath()
{
	self endon("death");
	self waittill("pain_death");
}

//Function Number: 37
drop_gear()
{
	var_00 = self.team;
	waittilldeathorpaindeath();
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.nodrop))
	{
		return;
	}

	if(level.tire_explosion)
	{
		var_01 = self.origin;
		var_02 = self geteye();
		waittillframeend;
		for(var_03 = 0;var_03 < 15;var_03++)
		{
			thread random_tire(var_01,var_02);
		}

		if(isdefined(self))
		{
			animscripts\shared::dropallaiweapons();
			wait(0.1);
			if(isdefined(self) && !isremovedentity(self))
			{
				self delete();
			}
		}

		return;
	}

	self.ignoreforfixednodesafecheck = 1;
	if(self.grenadeammo <= 0)
	{
		return;
	}

	level.nextgrenadedrop--;
	if(level.nextgrenadedrop > 0)
	{
		return;
	}

	level.nextgrenadedrop = 3 + randomint(2);
	var_04 = 25;
	var_05 = 12;
	var_01 = self.origin + (randomint(var_04) - var_05,randomint(var_04) - var_05,2) + (0,0,42);
	var_06 = (0,randomint(360),90);
	thread spawn_grenade_bag(var_05,var_06,self.team);
}

//Function Number: 38
random_tire(param_00,param_01)
{
	if(level.cheattires.size == level.cheattires_max)
	{
		level.cheattires[0] delete();
		level.cheattires = maps\_utility::array_remove_index(level.cheattires,0);
	}

	var_02 = spawn("script_model",(0,0,0));
	var_02.angles = (0,randomint(360),0);
	var_03 = randomfloat(1);
	var_02.origin = param_00 * var_03 + param_01 * 1 - var_03;
	var_02 setmodel(level.random_tire_model);
	var_04 = common_scripts\utility::randomvector(15000);
	var_04 = (var_04[0],var_04[1],abs(var_04[2]));
	var_02 physicslaunchclient(var_02.origin,var_04);
	level.cheattires[level.cheattires.size] = var_02;
	var_02 endon("death");
	wait(randomfloatrange(5,10));
	if(isdefined(var_02))
	{
		level.cheattires = common_scripts\utility::array_remove(level.cheattires,var_02);
		var_02 delete();
	}
}

//Function Number: 39
override_random_tire(param_00)
{
	precachemodel(param_00);
	level.random_tire_model = param_00;
}

//Function Number: 40
spawn_grenade_bag(param_00,param_01,param_02)
{
	var_03 = spawn_grenade(param_00,param_02);
	var_03 setmodel("grenade_bag");
	var_03.angles = param_01;
	var_03 hide();
	wait(0.7);
	if(!isdefined(var_03))
	{
		return;
	}

	var_03 show();
}

//Function Number: 41
dronespawner_init()
{
	maps\_drone_base::drone_init_path();
}

//Function Number: 42
empty()
{
}

//Function Number: 43
spawn_prethink()
{
	level.ai_classname_in_level[self.classname] = 1;
	if(isdefined(self.script_difficulty))
	{
		switch(self.script_difficulty)
		{
			case "easy":
				break;

			case "hard":
				break;
		}
	}
}

//Function Number: 44
spawn_think(param_00)
{
	level.ai_classname_in_level[self.classname] = 1;
	spawn_think_action(param_00);
	self endon("death");
	if(shouldnt_spawn_because_of_script_difficulty())
	{
		self delete();
	}

	thread run_spawn_functions();
	self.finished_spawning = 1;
	self notify("finished spawning");
	if(self.team == "allies" && !isdefined(self.script_nofriendlywave))
	{
		thread friendlydeath_thread();
	}
}

//Function Number: 45
shouldnt_spawn_because_of_script_difficulty()
{
	if(!isdefined(self.script_difficulty))
	{
		return 0;
	}

	var_00 = 0;
	switch(self.script_difficulty)
	{
		case "easy":
			break;

		case "hard":
			break;
	}
}

//Function Number: 46
run_spawn_functions()
{
	self endon("death");
	if(!isdefined(self.spawn_funcs))
	{
		self.spawner = undefined;
		return;
	}

	for(var_00 = 0;var_00 < self.spawn_funcs.size;var_00++)
	{
		var_01 = self.spawn_funcs[var_00];
		if(isdefined(var_01["param5"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"],var_01["param5"]);
			continue;
		}

		if(isdefined(var_01["param4"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"]);
			continue;
		}

		if(isdefined(var_01["param3"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"]);
			continue;
		}

		if(isdefined(var_01["param2"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"]);
			continue;
		}

		if(isdefined(var_01["param1"]))
		{
			thread [[ var_01["function"] ]](var_01["param1"]);
			continue;
		}

		thread [[ var_01["function"] ]]();
	}

	var_02 = common_scripts\utility::ter_op(isdefined(level.vehicle_spawn_functions_enable) && level.vehicle_spawn_functions_enable && self.code_classname == "script_vehicle",self.script_team,self.team);
	if(isdefined(var_02))
	{
		for(var_00 = 0;var_00 < level.spawn_funcs[var_02].size;var_00++)
		{
			var_01 = level.spawn_funcs[var_02][var_00];
			if(isdefined(var_01["param5"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"],var_01["param5"]);
				continue;
			}

			if(isdefined(var_01["param4"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"],var_01["param4"]);
				continue;
			}

			if(isdefined(var_01["param3"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"],var_01["param3"]);
				continue;
			}

			if(isdefined(var_01["param2"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"],var_01["param2"]);
				continue;
			}

			if(isdefined(var_01["param1"]))
			{
				thread [[ var_01["function"] ]](var_01["param1"]);
				continue;
			}

			thread [[ var_01["function"] ]]();
		}
	}

	self.spawn_funcs = undefined;
	self.spawner = undefined;
}

//Function Number: 47
specops_think()
{
	if(!maps\_utility::is_specialop())
	{
		return;
	}

	maps\_utility::add_damage_function(::specops_dmg);
	thread multikill_monitor();
}

//Function Number: 48
multikill_monitor()
{
	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(self))
	{
		return;
	}

	if(!self isbadguy())
	{
		return;
	}

	if(!isdefined(var_00))
	{
		return;
	}

	if(!isplayer(var_00))
	{
		return;
	}

	if(!isdefined(var_02))
	{
		var_00.multikill_count = undefined;
		return;
	}

	if(!isdefined(var_00.multikill_count))
	{
		var_00.multikill_count = 1;
	}
	else
	{
		var_00.multikill_count++;
	}

	if(maps\_utility::is_survival() && var_00.multikill_count >= 4)
	{
		var_00 notify("sur_ch_quadkill");
	}

	waittillframeend;
	var_00.multikill_count = undefined;
}

//Function Number: 49
specops_dmg(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		self.last_dmg_player = param_01;
		self.last_dmg_type = param_04;
	}
}

//Function Number: 50
check_explosion_man_achievement(param_00,param_01,param_02)
{
	var_03 = 0;
	if(!isplayer(param_00) && !isdefined(param_01) || param_01 != "seaknight_mark19")
	{
		return;
	}

	if(isdefined(param_01))
	{
		switch(param_01)
		{
			case "c4":
			case "seaknight_mark19":
			case "javelin":
			case "rpg":
			case "claymore":
			case "fraggrenade":
				break;
		}
	}
}

//Function Number: 51
deathfunctions()
{
	self waittill("death",var_00,var_01,var_02);
	level notify("ai_killed",self);
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(var_00))
	{
		if(self.team == "axis" || self.team == "team3")
		{
			var_03 = undefined;
			if(isdefined(var_00.attacker))
			{
				if(isdefined(var_00.issentrygun) && var_00.issentrygun)
				{
					var_03 = "sentry";
				}

				if(isdefined(var_00.destructible_type))
				{
					var_03 = "destructible";
				}

				var_00 = var_00.attacker;
			}
			else if(isdefined(var_00.owner))
			{
				if(isai(var_00) && isplayer(var_00.owner))
				{
					var_03 = "friendly";
				}

				var_00 = var_00.owner;
			}
			else if(isdefined(var_00.damageowner))
			{
				if(isdefined(var_00.destructible_type))
				{
					var_03 = "destructible";
				}

				var_00 = var_00.damageowner;
			}

			check_explosion_man_achievement(var_00,var_02,var_01);
			var_04 = 0;
			if(isplayer(var_00))
			{
				var_04 = 1;
			}

			if(isdefined(level.pmc_match) && level.pmc_match)
			{
				var_04 = 1;
			}

			if(isdefined(var_01) && var_01 == "MOD_CRUSH")
			{
				if(isdefined(level.hovertank_player) || isdefined(level.player.drivingvehicleandturret))
				{
					level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
				}
			}

			if(var_04)
			{
				var_00 maps\_player_stats::register_kill(self,var_01,var_02,var_03);
			}
		}
	}

	var_05 = 0;
	if(var_05 < self.deathfuncs.size)
	{
		var_06 = self.deathfuncs[var_05];
		switch(var_06["params"])
		{
			case 0:
				break;

			case 1:
				break;

			case 2:
				break;

			case 3:
				break;
		}
	}
}

//Function Number: 52
ai_damage_think()
{
	self.damage_functions = [];
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		if(isdefined(var_01) && isplayer(var_01))
		{
			var_07 = var_01 getcurrentweapon();
			if(isdefined(var_07) && maps\_utility::isprimaryweapon(var_07) && isdefined(var_04) && var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_RIFLE_BULLET")
			{
				var_01 thread maps\_player_stats::register_shot_hit();
			}
		}

		foreach(var_09 in self.damage_functions)
		{
			thread [[ var_09 ]](var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		}

		if(!isalive(self) || self.delayeddeath)
		{
			break;
		}
	}
}

//Function Number: 53
living_ai_prethink()
{
	if(isdefined(self.script_deathflag))
	{
		level.deathflags[self.script_deathflag] = 1;
	}

	if(isdefined(self.target))
	{
		crawl_through_targets_to_init_flags();
	}
}

//Function Number: 54
crawl_through_targets_to_init_flags()
{
	var_00 = get_node_funcs_based_on_target();
	if(isdefined(var_00))
	{
		var_01 = var_00["destination"];
		var_02 = var_00["get_target_func"];
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			crawl_target_and_init_flags(var_01[var_03],var_02);
		}
	}
}

//Function Number: 55
spawn_team_allies()
{
	self.usechokepoints = 0;
}

//Function Number: 56
spawn_team_axis()
{
	if(isdefined(level.xp_enable) && level.xp_enable && isdefined(level.xp_ai_func))
	{
		self thread [[ level.xp_ai_func ]]();
	}

	if(self.type == "human" && !isdefined(level.disablegeardrop))
	{
		thread drop_gear();
	}

	maps\_utility::add_damage_function(::maps\_gameskill::auto_adjust_enemy_death_detection);
	if(isdefined(self.script_combatmode))
	{
		self.combatmode = self.script_combatmode;
	}
}

//Function Number: 57
spawn_team_team3()
{
	spawn_team_axis();
}

//Function Number: 58
spawn_team_neutral()
{
}

//Function Number: 59
subclass_elite()
{
	self endon("death");
	self.elite = 1;
	self.doorflashchance = 0.5;
	if(!isdefined(self.script_accuracy))
	{
		self.baseaccuracy = 2;
	}

	self.aggressivemode = 1;
	self.minpaindamage = 100;
	maps\_utility::add_damage_function(::animscripts\pain::additive_pain);
	maps\_utility::add_damage_function(::pain_resistance);
	self.custom_laser_function = ::spawner_force_laser_on;
	if(isdefined(self.weapon) && weaponclass(self.weapon) != "rocketlauncher")
	{
		self laseron();
	}
}

//Function Number: 60
spawner_force_laser_on()
{
	var_00 = undefined;
	if(isdefined(self.weapon))
	{
		var_00 = self.weapon;
	}
	else
	{
		return;
	}

	if(isdefined(var_00) && weaponclass(var_00) != "rocketlauncher")
	{
		self laseron();
	}
}

//Function Number: 61
subclass_regular()
{
	if(!isdefined(self.script_accuracy))
	{
		self.baseaccuracy = 1.05;
	}
}

//Function Number: 62
pain_resistance(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(self.health <= 0)
	{
		return;
	}

	if(param_00 >= self.minpaindamage)
	{
		var_07 = self.minpaindamage;
		self.minpaindamage = var_07 * 3;
		wait(5);
		self.minpaindamage = var_07;
	}
}

//Function Number: 63
bullet_resistance(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self) || self.health <= 0)
	{
		return;
	}

	if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
	{
		return;
	}

	if(!issubstr(param_04,"BULLET"))
	{
		return;
	}

	var_07 = self.bullet_resistance;
	if(param_00 < self.bullet_resistance)
	{
		var_07 = param_00;
	}

	self.health = self.health + var_07;
}

//Function Number: 64
spawn_think_game_skill_related()
{
	maps\_gameskill::grenadeawareness();
}

//Function Number: 65
ai_lasers()
{
	if(!isalive(self))
	{
		return;
	}

	if(self.health <= 1)
	{
		return;
	}

	self laseron();
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self laseroff();
}

//Function Number: 66
spawn_think_script_inits()
{
	if(isdefined(self.script_dontshootwhilemoving))
	{
		self.dontshootwhilemoving = 1;
	}

	if(isdefined(self.script_deathflag))
	{
		thread ai_deathflag();
	}

	if(isdefined(self.script_attackeraccuracy))
	{
		self.attackeraccuracy = self.script_attackeraccuracy;
	}

	if(isdefined(self.script_startrunning))
	{
		thread start_off_running();
	}

	if(isdefined(self.script_deathtime))
	{
		thread deathtime();
	}

	if(isdefined(self.script_nosurprise))
	{
		maps\_utility::disable_surprise();
	}

	if(isdefined(self.script_nobloodpool))
	{
		self.skipbloodpool = 1;
	}

	if(isdefined(self.script_laser))
	{
		thread ai_lasers();
	}

	if(isdefined(self.script_danger_react))
	{
		var_00 = self.script_danger_react;
		if(var_00 == 1)
		{
			var_00 = 8;
		}

		maps\_utility::enable_danger_react(var_00);
	}

	if(isdefined(self.script_faceenemydist))
	{
		self.maxfaceenemydist = self.script_faceenemydist;
	}
	else
	{
		self.maxfaceenemydist = getdefaultmaxfaceenemydistance();
	}

	if(isdefined(self.script_forcecolor))
	{
		maps\_utility::set_force_color(self.script_forcecolor);
	}

	if(isdefined(self.dontdropweapon))
	{
		self.dropweapon = 0;
	}

	if(isdefined(self.script_fixednode))
	{
		self.fixednode = self.script_fixednode == 1;
	}
	else
	{
		self.fixednode = self.team == "allies";
	}

	self.providecoveringfire = self.team == "allies" && self.fixednode;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "mgpair")
	{
		thread maps\_mg_penetration::create_mg_team();
	}

	if(isdefined(self.script_goalvolume) && !(isdefined(self.script_moveoverride) && self.script_moveoverride == 1) || isdefined(self.script_stealth))
	{
		thread set_goal_volume();
	}

	if(isdefined(self.script_threatbiasgroup))
	{
		self setthreatbiasgroup(self.script_threatbiasgroup);
	}
	else if(self.team == "neutral")
	{
		self setthreatbiasgroup("civilian");
	}
	else
	{
		self setthreatbiasgroup(self.team);
	}

	if(isdefined(self.script_bcdialog))
	{
		maps\_utility::set_battlechatter(self.script_bcdialog);
	}

	if(isdefined(self.script_accuracy))
	{
		self.baseaccuracy = self.script_accuracy;
	}

	if(isdefined(self.script_ignoreme))
	{
		self.ignoreme = 1;
	}

	if(isdefined(self.script_ignore_suppression))
	{
		self.ignoresuppression = 1;
	}

	if(isdefined(self.script_ignoreall))
	{
		self.ignoreall = 1;
		self clearenemy();
	}

	if(isdefined(self.script_sightrange))
	{
		self.maxsightdistsqrd = self.script_sightrange;
	}

	if(isdefined(self.script_favoriteenemy))
	{
		if(self.script_favoriteenemy == "player")
		{
			self.favoriteenemy = level.player;
			level.player.targetname = "player";
		}
	}

	if(isdefined(self.script_fightdist))
	{
		self.pathenemyfightdist = self.script_fightdist;
	}

	if(isdefined(self.script_maxdist))
	{
		self.pathenemylookahead = self.script_maxdist;
	}

	if(isdefined(self.script_longdeath))
	{
		self.a.disablelongdeath = 1;
	}

	if(isdefined(self.script_diequietly))
	{
		self.diequietly = 1;
	}

	if(isdefined(self.script_flashbangs))
	{
		self.grenadeweapon = "flash_grenade";
		self.grenadeammo = self.script_flashbangs;
	}

	if(isdefined(self.script_pacifist))
	{
		self.pacifist = 1;
	}

	if(isdefined(self.script_startinghealth))
	{
		self.health = self.script_startinghealth;
	}

	if(isdefined(self.script_nodrop))
	{
		self.nodrop = self.script_nodrop;
	}
}

//Function Number: 67
spawn_think_action(param_00)
{
	thread ai_damage_think();
	thread tanksquish();
	thread death_achievements();
	thread specops_think();
	if(!isdefined(level.ai_dont_glow_in_thermal))
	{
		self thermaldrawenable();
	}

	self.spawner_number = undefined;
	if(!isdefined(self.unique_id))
	{
		maps\_utility::set_ai_number();
	}

	if(!isdefined(self.deathfuncs))
	{
		self.deathfuncs = [];
	}

	thread deathfunctions();
	level thread maps\_friendlyfire::friendly_fire_think(self);
	self.walkdist = 16;
	init_reset_ai();
	spawn_think_game_skill_related();
	spawn_think_script_inits();
	[[ level.team_specific_spawn_functions[self.team] ]]();
	thread [[ level.subclass_spawn_functions[self.subclass] ]]();
	thread maps\_damagefeedback::monitordamage();
	set_goal_height_from_settings();
	if(isdefined(self.script_playerseek))
	{
		self setgoalentity(level.player);
		return;
	}

	if(isdefined(self.script_stealth))
	{
		if(isdefined(self.script_stealth_function))
		{
			var_01 = level.stealth_default_func[self.script_stealth_function];
			self thread [[ var_01 ]]();
		}
		else
		{
			self thread [[ level.global_callbacks["_spawner_stealth_default"] ]]();
		}
	}

	if(isdefined(self.script_idleanim))
	{
		self thread [[ level.global_callbacks["_idle_call_idle_func"] ]]();
		return;
	}

	if(isdefined(self.script_idlereach) && !isdefined(self.script_moveoverride))
	{
		self thread [[ level.global_callbacks["_idle_call_idle_func"] ]]();
	}

	if(isdefined(self.script_patroller) && !isdefined(self.script_moveoverride))
	{
		thread maps\_patrol::patrol();
		return;
	}

	if(isdefined(self.script_readystand) && self.script_readystand == 1)
	{
		maps\_utility::enable_readystand();
	}

	if(isdefined(self.script_delayed_playerseek))
	{
		if(!isdefined(self.script_radius))
		{
			self.goalradius = 800;
		}

		self setgoalentity(level.player);
		level thread delayed_player_seek_think(self);
		return;
	}

	if(isdefined(self.used_an_mg42))
	{
		return;
	}

	if(isdefined(self.script_moveoverride) && self.script_moveoverride == 1)
	{
		set_goal_from_settings();
		self setgoalpos(self.origin);
		return;
	}

	if(!isdefined(self.script_stealth))
	{
	}

	set_goal_from_settings();
	if(isdefined(self.target))
	{
		thread go_to_node();
	}
}

//Function Number: 68
init_reset_ai()
{
	maps\_utility::set_default_pathenemy_settings();
	if(isdefined(self.script_grenades))
	{
		self.grenadeammo = self.script_grenades;
	}
	else
	{
		self.grenadeammo = 3;
	}

	if(isdefined(self.primaryweapon))
	{
		self.noattackeraccuracymod = animscripts\combat_utility::issniper();
	}

	if(!maps\_utility::is_specialop())
	{
		self.neversprintforvariation = 1;
	}
}

//Function Number: 69
scrub_guy()
{
	if(self.team == "neutral")
	{
		self setthreatbiasgroup("civilian");
	}
	else
	{
		self setthreatbiasgroup(self.team);
	}

	init_reset_ai();
	self.baseaccuracy = 1;
	maps\_gameskill::grenadeawareness();
	maps\_utility::clear_force_color();
	self.interval = 96;
	self.disablearrivals = undefined;
	self.ignoreme = 0;
	self.threatbias = 0;
	self.pacifist = 0;
	self.pacifistwait = 20;
	self.ignorerandombulletdamage = 0;
	self.pushable = 1;
	self.script_pushable = 1;
	self.allowdeath = 0;
	self.anglelerprate = 540;
	self.badplaceawareness = 0.75;
	self.dontavoidplayer = 0;
	self.drawoncompass = 1;
	self.dropweapon = 1;
	self.goalradius = level.default_goalradius;
	self.goalheight = level.default_goalheight;
	self.ignoresuppression = 0;
	self pushplayer(0);
	if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	maps\_utility::disable_replace_on_death();
	self.maxsightdistsqrd = 67108864;
	self.script_forcegrenade = 0;
	self.walkdist = 16;
	maps\_utility::unmake_hero();
	self.pushable = 1;
	self.script_pushable = 1;
	animscripts\init::set_anim_playback_rate();
	self.fixednode = self.team == "allies";
}

//Function Number: 70
delayed_player_seek_think(param_00)
{
	param_00 endon("death");
	while(isalive(param_00))
	{
		if(param_00.goalradius > 200)
		{
			param_00.goalradius = param_00.goalradius - 200;
		}

		wait(6);
	}
}

//Function Number: 71
flag_turret_for_use(param_00)
{
	self endon("death");
	if(!self.flagged_for_use)
	{
		param_00.used_an_mg42 = 1;
		self.flagged_for_use = 1;
		param_00 waittill("death");
		self.flagged_for_use = 0;
		self notify("get new user");
	}
}

//Function Number: 72
set_goal_volume()
{
	self endon("death");
	waittillframeend;
	if(isdefined(self.team) && self.team == "allies")
	{
		self.fixednode = 0;
	}

	var_00 = level.goalvolumes[self.script_goalvolume];
	if(!isdefined(var_00))
	{
		return;
	}

	if(isdefined(var_00.target))
	{
		var_01 = getnode(var_00.target,"targetname");
		var_02 = getent(var_00.target,"targetname");
		var_03 = common_scripts\utility::getstruct(var_00.target,"targetname");
		var_04 = undefined;
		if(isdefined(var_01))
		{
			var_04 = var_01;
			self getgoalvolume(var_04);
		}
		else if(isdefined(var_02))
		{
			var_04 = var_02;
			self setgoalpos(var_04.origin);
		}
		else if(isdefined(var_03))
		{
			var_04 = var_03;
			self setgoalpos(var_04.origin);
		}

		if(isdefined(var_04.radius) && var_04.radius != 0)
		{
			self.goalradius = var_04.radius;
		}

		if(isdefined(var_04.goalheight) && var_04.goalheight != 0)
		{
			self.goalheight = var_04.goalheight;
		}
	}

	if(isdefined(self.target))
	{
		self setgoalvolume(var_00);
		return;
	}

	self setgoalvolumeauto(var_00);
}

//Function Number: 73
get_target_ents(param_00)
{
	return getentarray(param_00,"targetname");
}

//Function Number: 74
get_target_nodes(param_00)
{
	return getnodearray(param_00,"targetname");
}

//Function Number: 75
get_target_vehicle_nodes(param_00)
{
	return getvehiclenodearray(param_00,"targetname");
}

//Function Number: 76
get_target_structs(param_00)
{
	return common_scripts\utility::getstructarray(param_00,"targetname");
}

//Function Number: 77
node_has_radius(param_00)
{
	return isdefined(param_00.radius) && param_00.radius != 0;
}

//Function Number: 78
go_to_origin(param_00,param_01)
{
	go_to_node(param_00,"origin",param_01);
}

//Function Number: 79
go_to_struct(param_00,param_01)
{
	go_to_node(param_00,"struct",param_01);
}

//Function Number: 80
go_to_node(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.used_an_mg42))
	{
		return;
	}

	var_05 = get_node_funcs_based_on_target(param_00,param_01);
	if(!isdefined(var_05))
	{
		self notify("reached_path_end");
		return;
	}

	go_to_node_using_funcs(var_05["destination"],var_05["get_target_func"],var_05["set_goal_func_quits"],param_02,param_03,param_04);
}

//Function Number: 81
get_least_used_from_array(param_00)
{
	if(param_00.size == 1)
	{
		return param_00[0];
	}

	var_01 = param_00[0].targetname;
	if(!isdefined(level.go_to_node_arrays[var_01]))
	{
		level.go_to_node_arrays[var_01] = param_00;
	}

	param_00 = level.go_to_node_arrays[var_01];
	var_02 = param_00[0];
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size - 1;var_04++)
	{
		var_03[var_04] = param_00[var_04 + 1];
	}

	var_03[param_00.size - 1] = param_00[0];
	level.go_to_node_arrays[var_01] = var_03;
	return var_02;
}

//Function Number: 82
go_to_node_using_funcs(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self notify("stop_going_to_node");
	self endon("stop_going_to_node");
	self endon("death");
	for(;;)
	{
		param_00 = get_least_used_from_array(param_00);
		var_06 = param_04;
		if(isdefined(param_00.script_requires_player))
		{
			if(param_00.script_requires_player > 1)
			{
				var_06 = param_00.script_requires_player;
			}

			param_00.script_requires_player = 0;
		}

		if(node_has_radius(param_00))
		{
			self.goalradius = param_00.radius;
		}
		else
		{
			self.goalradius = level.default_goalradius;
		}

		if(isdefined(param_00.height))
		{
			self.goalheight = param_00.height;
		}
		else
		{
			self.goalheight = level.default_goalheight;
		}

		[[ param_02 ]](param_00);
		if(maps\_utility::ent_flag_exist("_stealth_override_goalpos"))
		{
			for(;;)
			{
				self waittill("goal");
				if(!maps\_utility::ent_flag("_stealth_override_goalpos"))
				{
					break;
				}

				maps\_utility::ent_flag_waitopen("_stealth_override_goalpos");
			}
		}
		else
		{
			self waittill("goal");
		}

		param_00 notify("trigger",self);
		if(isdefined(param_03))
		{
			[[ param_03 ]](param_00);
		}

		if(isdefined(param_00.script_flag_set))
		{
			common_scripts\utility::flag_set(param_00.script_flag_set);
		}

		if(isdefined(param_00.script_ent_flag_set))
		{
			maps\_utility::ent_flag_set(param_00.script_ent_flag_set);
		}

		if(isdefined(param_00.script_flag_clear))
		{
			common_scripts\utility::flag_clear(param_00.script_flag_clear);
		}

		if(isdefined(param_00.script_noteworthy))
		{
			self notify(param_00.script_noteworthy);
		}

		if(targets_and_uses_turret(param_00))
		{
			return 1;
		}

		param_00 maps\_utility::script_delay();
		if(isdefined(param_00.script_flag_wait))
		{
			common_scripts\utility::flag_wait(param_00.script_flag_wait);
		}

		param_00 maps\_utility::script_wait();
		if(isdefined(param_00.script_delay_post))
		{
			wait(param_00.script_delay_post);
		}

		while(isdefined(param_00.script_requires_player))
		{
			param_00.script_requires_player = 0;
			if(go_to_node_wait_for_player(param_00,param_01,var_06))
			{
				param_00.script_requires_player = 1;
				param_00 notify("script_requires_player");
				break;
			}

			wait(0.1);
		}

		if(isdefined(param_05))
		{
			[[ param_05 ]](param_00);
		}

		if(!isdefined(param_00.target))
		{
			break;
		}

		var_07 = [[ param_01 ]](param_00.target);
		if(!var_07.size)
		{
			break;
		}

		param_00 = var_07;
	}

	self notify("reached_path_end");
	if(isdefined(self.script_forcegoal))
	{
		return;
	}

	self.goalradius = level.default_goalradius;
}

//Function Number: 83
go_to_node_wait_for_player(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		if(distancesquared(var_04.origin,param_00.origin) < distancesquared(self.origin,param_00.origin))
		{
			return 1;
		}
	}

	var_06 = anglestoforward(self.angles);
	if(isdefined(param_00.target))
	{
		var_07 = [[ param_01 ]](param_00.target);
		if(var_07.size == 1)
		{
			var_06 = vectornormalize(var_07[0].origin - param_00.origin);
		}
		else if(isdefined(param_00.angles))
		{
			var_06 = anglestoforward(param_00.angles);
		}
	}
	else if(isdefined(param_00.angles))
	{
		var_06 = anglestoforward(param_00.angles);
	}

	var_08 = [];
	foreach(var_04 in level.players)
	{
		var_08[var_08.size] = vectornormalize(var_04.origin - self.origin);
	}

	foreach(var_0C in var_08)
	{
		if(vectordot(var_06,var_0C) > 0)
		{
			return 1;
		}
	}

	var_0E = param_02 * param_02;
	foreach(var_04 in level.players)
	{
		if(distancesquared(var_04.origin,self.origin) < var_0E)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 84
go_to_node_set_goal_ent(param_00)
{
	if(param_00.classname == "info_volume")
	{
		self setgoalvolumeauto(param_00);
		self notify("go_to_node_new_goal");
		return;
	}

	go_to_node_set_goal_pos(param_00);
}

//Function Number: 85
go_to_node_set_goal_pos(param_00)
{
	maps\_utility::set_goal_ent(param_00);
	self notify("go_to_node_new_goal");
}

//Function Number: 86
go_to_node_set_goal_node(param_00)
{
	maps\_utility::set_goal_node(param_00);
	self notify("go_to_node_new_goal");
}

//Function Number: 87
targets_and_uses_turret(param_00)
{
	if(!isdefined(param_00.target))
	{
		return 0;
	}

	var_01 = getentarray(param_00.target,"targetname");
	if(!var_01.size)
	{
		return 0;
	}

	var_02 = var_01[0];
	if(var_02.classname != "misc_turret")
	{
		return 0;
	}

	thread use_a_turret(var_02);
	return 1;
}

//Function Number: 88
remove_crawled(param_00)
{
	waittillframeend;
	if(isdefined(param_00))
	{
		param_00.crawled = undefined;
	}
}

//Function Number: 89
crawl_target_and_init_flags(param_00,param_01)
{
	var_02 = 0;
	var_03 = [];
	var_04 = 0;
	for(;;)
	{
		if(!isdefined(param_00.crawled))
		{
			param_00.crawled = 1;
			level thread remove_crawled(param_00);
			if(isdefined(param_00.script_flag_set))
			{
				if(!isdefined(level.flag[param_00.script_flag_set]))
				{
					common_scripts\utility::flag_init(param_00.script_flag_set);
				}
			}

			if(isdefined(param_00.script_flag_wait))
			{
				if(!isdefined(level.flag[param_00.script_flag_wait]))
				{
					common_scripts\utility::flag_init(param_00.script_flag_wait);
				}
			}

			if(isdefined(param_00.script_flag_clear))
			{
				if(!isdefined(level.flag[param_00.script_flag_clear]))
				{
					common_scripts\utility::flag_init(param_00.script_flag_clear);
				}
			}

			if(isdefined(param_00.target))
			{
				var_05 = [[ param_01 ]](param_00.target);
				var_03 = common_scripts\utility::add_to_array(var_03,var_05);
			}
		}

		var_04++;
		if(var_04 >= var_03.size)
		{
			break;
		}

		param_00 = var_03[var_04];
	}
}

//Function Number: 90
get_node_funcs_based_on_target(param_00,param_01)
{
	var_02["entity"] = ::get_target_ents;
	var_02["origin"] = ::get_target_ents;
	var_02["node"] = ::get_target_nodes;
	var_02["struct"] = ::get_target_structs;
	var_03["entity"] = ::go_to_node_set_goal_ent;
	var_03["origin"] = ::go_to_node_set_goal_ent;
	var_03["struct"] = ::go_to_node_set_goal_pos;
	var_03["node"] = ::go_to_node_set_goal_node;
	if(!isdefined(param_01))
	{
		param_01 = "node";
	}

	var_04 = [];
	if(isdefined(param_00))
	{
		var_04["destination"][0] = param_00;
	}
	else
	{
		param_00 = getentarray(self.target,"targetname");
		if(param_00.size > 0)
		{
			param_01 = "entity";
		}

		if(param_01 == "node")
		{
			param_00 = getnodearray(self.target,"targetname");
			if(!param_00.size)
			{
				param_00 = common_scripts\utility::getstructarray(self.target,"targetname");
				if(!param_00.size)
				{
					return;
				}

				param_01 = "struct";
			}
		}

		var_04["destination"] = param_00;
	}

	var_04["get_target_func"] = var_02[param_01];
	var_04["set_goal_func_quits"] = var_03[param_01];
	return var_04;
}

//Function Number: 91
set_goal_height_from_settings()
{
	if(isdefined(self.script_goalheight))
	{
		self.goalheight = self.script_goalheight;
		return;
	}

	self.goalheight = level.default_goalheight;
}

//Function Number: 92
set_goal_from_settings(param_00)
{
	if(isdefined(self.script_radius))
	{
		self.goalradius = self.script_radius;
		return;
	}

	if(isdefined(self.script_forcegoal))
	{
		if(isdefined(param_00) && isdefined(param_00.radius))
		{
			self.goalradius = param_00.radius;
			return;
		}
	}

	if(!isdefined(self getgoalvolume()))
	{
		if(self.type == "civilian")
		{
			self.goalradius = 128;
			return;
		}

		self.goalradius = level.default_goalradius;
	}
}

//Function Number: 93
autotarget(param_00)
{
	for(;;)
	{
		var_01 = self getturretowner();
		if(!isalive(var_01))
		{
			wait(1.5);
			continue;
		}

		if(!isdefined(var_01.enemy))
		{
			self settargetentity(common_scripts\utility::random(param_00));
			self notify("startfiring");
			self startfiring();
		}

		wait(2 + randomfloat(1));
	}
}

//Function Number: 94
manualtarget(param_00)
{
	for(;;)
	{
		self settargetentity(common_scripts\utility::random(param_00));
		self notify("startfiring");
		self startfiring();
		wait(2 + randomfloat(1));
	}
}

//Function Number: 95
use_a_turret(param_00)
{
	if(self isbadguy() && self.health == 150)
	{
		self.health = 100;
		self.a.disablelongdeath = 1;
	}

	self useturret(param_00);
	if(isdefined(param_00.target) && param_00.target != param_00.targetname)
	{
		var_01 = getentarray(param_00.target,"targetname");
		var_02 = [];
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			if(var_01[var_03].classname == "script_origin")
			{
				var_02[var_02.size] = var_01[var_03];
			}
		}

		if(isdefined(param_00.script_autotarget))
		{
			param_00 thread autotarget(var_02);
		}
		else if(isdefined(param_00.script_manualtarget))
		{
			param_00 setmode("manual_ai");
			param_00 thread manualtarget(var_02);
		}
		else if(var_02.size > 0)
		{
			if(var_02.size == 1)
			{
				param_00.manual_target = var_02[0];
				param_00 settargetentity(var_02[0]);
				thread maps\_mgturret::manual_think(param_00);
			}
			else
			{
				param_00 thread maps\_mgturret::mg42_suppressionfire(var_02);
			}
		}
	}

	thread maps\_mgturret::mg42_firing(param_00);
	param_00 notify("startfiring");
}

//Function Number: 96
fallback_spawner_think(param_00,param_01)
{
	self endon("death");
	level.current_fallbackers[param_00] = level.current_fallbackers[param_00] + self.count;
	var_02 = 1;
	while(self.count > 0)
	{
		self waittill("spawned",var_03);
		if(var_02)
		{
			if(getdvar("fallback","0") == "1")
			{
			}

			level notify("fallback_firstspawn" + param_00);
			var_02 = 0;
		}

		wait(0.05);
		if(maps\_utility::spawn_failed(var_03))
		{
			level notify("fallbacker_died" + param_00);
			level.current_fallbackers[param_00]--;
			continue;
		}

		var_03 thread fallback_ai_think(param_00,param_01,"is spawner");
	}
}

//Function Number: 97
fallback_ai_think_death(param_00,param_01)
{
	param_00 waittill("death");
	level.current_fallbackers[param_01]--;
	level notify("fallbacker_died" + param_01);
}

//Function Number: 98
fallback_ai_think(param_00,param_01,param_02)
{
	if(!isdefined(self.fallback) || !isdefined(self.fallback[param_00]))
	{
		self.fallback[param_00] = 1;
	}
	else
	{
		return;
	}

	self.script_fallback = param_00;
	if(!isdefined(param_02))
	{
		level.current_fallbackers[param_00]++;
	}

	if(isdefined(param_01) && level.fallback_initiated[param_00])
	{
		thread fallback_ai(param_00,param_01);
	}

	level thread fallback_ai_think_death(self,param_00);
}

//Function Number: 99
fallback_death(param_00,param_01)
{
	param_00 waittill("death");
	level notify("fallback_reached_goal" + param_01);
}

//Function Number: 100
fallback_goal()
{
	self waittill("goal");
	self.ignoresuppression = 0;
	self notify("fallback_notify");
	self notify("stop_coverprint");
}

//Function Number: 101
fallback_ai(param_00,param_01)
{
	self notify("stop_going_to_node");
	self stopuseturret();
	self.ignoresuppression = 1;
	self getgoalvolume(param_01);
	if(node_has_radius(param_01))
	{
		self.goalradius = param_01.radius;
	}

	self endon("death");
	level thread fallback_death(self,param_00);
	thread fallback_goal();
	if(getdvar("fallback","0") == "1")
	{
		thread coverprint(param_01.origin);
	}

	self waittill("fallback_notify");
	level notify("fallback_reached_goal" + param_00);
}

//Function Number: 102
coverprint(param_00)
{
	self endon("fallback_notify");
	self endon("stop_coverprint");
	wait(0.05);
}

//Function Number: 103
newfallback_overmind(param_00,param_01)
{
	var_02 = undefined;
	foreach(var_04 in getallnodes())
	{
		if(isdefined(var_04.script_fallback) && var_04.script_fallback == param_00)
		{
			var_02 = common_scripts\utility::add_to_array(var_02,var_04);
		}
	}

	if(!isdefined(var_02))
	{
		return;
	}

	level.current_fallbackers[param_00] = 0;
	level.spawner_fallbackers[param_00] = 0;
	level.fallback_initiated[param_00] = 0;
	var_06 = getspawnerarray();
	for(var_07 = 0;var_07 < var_06.size;var_07++)
	{
		if(isdefined(var_06[var_07].script_fallback) && var_06[var_07].script_fallback == param_00)
		{
			if(var_06[var_07].count > 0)
			{
				var_06[var_07] thread fallback_spawner_think(param_00,var_02[randomint(var_02.size)]);
				level.spawner_fallbackers[param_00]++;
			}
		}
	}

	var_08 = getaiarray();
	for(var_07 = 0;var_07 < var_08.size;var_07++)
	{
		if(isdefined(var_08[var_07].script_fallback) && var_08[var_07].script_fallback == param_00)
		{
			var_08[var_07] thread fallback_ai_think(param_00);
		}
	}

	if(!level.current_fallbackers[param_00] && !level.spawner_fallbackers[param_00])
	{
		return;
	}

	var_06 = undefined;
	var_08 = undefined;
	thread fallback_wait(param_00,param_01);
	level waittill("fallbacker_trigger" + param_00);
	if(getdvar("fallback","0") == "1")
	{
	}

	level.fallback_initiated[param_00] = 1;
	var_09 = undefined;
	var_08 = getaiarray();
	for(var_07 = 0;var_07 < var_08.size;var_07++)
	{
		if((isdefined(var_08[var_07].script_fallback) && var_08[var_07].script_fallback == param_00) || isdefined(var_08[var_07].script_fallback_group) && isdefined(param_01) && var_08[var_07].script_fallback_group == param_01)
		{
			var_09 = common_scripts\utility::add_to_array(var_09,var_08[var_07]);
		}
	}

	var_08 = undefined;
	if(!isdefined(var_09))
	{
		return;
	}

	var_0A = var_09.size * 0.4;
	var_0A = int(var_0A);
	level notify("fallback initiated " + param_00);
	for(var_07 = 0;var_07 < var_0A;var_07++)
	{
		var_09[var_07] thread fallback_ai(param_00,var_02[randomint(var_02.size)]);
	}

	for(var_07 = 0;var_07 < var_0A;var_07++)
	{
		level waittill("fallback_reached_goal" + param_00);
	}

	for(var_07 = var_0A;var_07 < var_09.size;var_07++)
	{
		if(isalive(var_09[var_07]))
		{
			var_09[var_07] thread fallback_ai(param_00,var_02[randomint(var_02.size)]);
		}
	}
}

//Function Number: 104
fallback_wait(param_00,param_01)
{
	level endon("fallbacker_trigger" + param_00);
	if(getdvar("fallback","0") == "1")
	{
	}

	for(var_02 = 0;var_02 < level.spawner_fallbackers[param_00];var_02++)
	{
		if(getdvar("fallback","0") == "1")
		{
		}

		level waittill("fallback_firstspawn" + param_00);
	}

	if(getdvar("fallback","0") == "1")
	{
	}

	var_03 = getaiarray();
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		if((isdefined(var_03[var_02].script_fallback) && var_03[var_02].script_fallback == param_00) || isdefined(var_03[var_02].script_fallback_group) && isdefined(param_01) && var_03[var_02].script_fallback_group == param_01)
		{
			var_03[var_02] thread fallback_ai_think(param_00);
		}
	}

	var_03 = undefined;
	var_04 = level.current_fallbackers[param_00];
	for(var_05 = 0;level.current_fallbackers[param_00] > var_04 * 0.5;var_05++)
	{
		if(getdvar("fallback","0") == "1")
		{
		}

		level waittill("fallbacker_died" + param_00);
	}

	level notify("fallbacker_trigger" + param_00);
}

//Function Number: 105
fallback_think(param_00)
{
	if(!isdefined(level.fallback) || !isdefined(level.fallback[param_00.script_fallback]))
	{
		level thread newfallback_overmind(param_00.script_fallback,param_00.script_fallback_group);
	}

	param_00 waittill("trigger");
	level notify("fallbacker_trigger" + param_00.script_fallback);
	kill_trigger(param_00);
}

//Function Number: 106
arrive(param_00)
{
	self waittill("goal");
	if(node_has_radius(param_00))
	{
		self.goalradius = param_00.radius;
		return;
	}

	self.goalradius = level.default_goalradius;
}

//Function Number: 107
fallback_coverprint()
{
	self endon("fallback");
	self endon("fallback_clear_goal");
	self endon("fallback_clear_death");
	for(;;)
	{
		if(isdefined(self.coverpoint))
		{
		}

		wait(0.05);
	}
}

//Function Number: 108
fallback_print()
{
	self endon("fallback_clear_goal");
	self endon("fallback_clear_death");
	for(;;)
	{
		if(isdefined(self.coverpoint))
		{
		}

		wait(0.05);
	}
}

//Function Number: 109
fallback()
{
	var_00 = getnode(self.target,"targetname");
	self.coverpoint = var_00;
	self getgoalvolume(var_00);
	if(isdefined(self.script_seekgoal))
	{
		thread arrive(var_00);
	}
	else if(node_has_radius(var_00))
	{
		self.goalradius = var_00.radius;
	}
	else
	{
		self.goalradius = level.default_goalradius;
	}

	for(;;)
	{
		self waittill("fallback");
		self.interval = 20;
		level thread fallback_death(self);
		if(getdvar("fallback","0") == "1")
		{
			thread fallback_print();
		}

		if(isdefined(var_00.target))
		{
			var_00 = getnode(var_00.target,"targetname");
			self.coverpoint = var_00;
			self getgoalvolume(var_00);
			thread fallback_goal();
			if(node_has_radius(var_00))
			{
				self.goalradius = var_00.radius;
			}

			continue;
		}

		level notify("fallback_arrived" + self.script_fallback);
	}
}

//Function Number: 110
delete_me()
{
	wait(0.05);
	self delete();
}

//Function Number: 111
vlength(param_00,param_01)
{
	var_02 = param_00[0] - param_01[0];
	var_03 = param_00[1] - param_01[1];
	var_04 = param_00[2] - param_01[2];
	var_02 = var_02 * var_02;
	var_03 = var_03 * var_03;
	var_04 = var_04 * var_04;
	var_05 = var_02 + var_03 + var_04;
	return var_05;
}

//Function Number: 112
specialcheck(param_00)
{
	wait(0.05);
}

//Function Number: 113
friendly_wave(param_00)
{
	if(!isdefined(level.friendly_wave_active))
	{
		thread friendly_wave_masterthread();
	}

	for(;;)
	{
		param_00 waittill("trigger");
		level notify("friendly_died");
		if(param_00.targetname == "friendly_wave")
		{
			level.friendly_wave_trigger = param_00;
		}
		else
		{
			level.friendly_wave_trigger = undefined;
		}

		wait(1);
	}
}

//Function Number: 114
set_spawncount(param_00)
{
	if(!isdefined(self.target))
	{
		return;
	}

	var_01 = getentarray(self.target,"targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] maps\_utility::set_count(param_00);
	}
}

//Function Number: 115
friendlydeath_thread()
{
	if(!isdefined(level.totalfriends))
	{
		level.totalfriends = 0;
	}

	level.totalfriends++;
	self waittill("death");
	level notify("friendly_died");
	level.totalfriends--;
}

//Function Number: 116
friendly_wave_masterthread()
{
	level.friendly_wave_active = 1;
	var_00 = getentarray("friendly_wave","targetname");
	common_scripts\utility::array_thread(var_00,::set_spawncount,0);
	if(!isdefined(level.maxfriendlies))
	{
		level.maxfriendlies = 7;
	}

	var_01 = 1;
	for(;;)
	{
		if(isdefined(level.friendly_wave_trigger) && isdefined(level.friendly_wave_trigger.target))
		{
			var_02 = level.friendly_wave_trigger;
			var_03 = getentarray(level.friendly_wave_trigger.target,"targetname");
			if(!var_03.size)
			{
				level waittill("friendly_died");
				continue;
			}

			var_04 = 0;
			var_05 = isdefined(level.friendly_wave_trigger.script_delay);
			while(isdefined(level.friendly_wave_trigger) && level.totalfriends < level.maxfriendlies)
			{
				if(var_02 != level.friendly_wave_trigger)
				{
					var_05 = isdefined(level.friendly_wave_trigger.script_delay);
					var_02 = level.friendly_wave_trigger;
					var_03 = getentarray(level.friendly_wave_trigger.target,"targetname");
				}
				else if(!var_05)
				{
					var_04 = randomint(var_03.size);
				}
				else if(var_04 == var_03.size)
				{
					var_04 = 0;
				}

				var_03[var_04] maps\_utility::set_count(1);
				var_06 = isdefined(var_03[var_04].script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
				if(isdefined(var_03[var_04].script_forcespawn))
				{
					var_07 = var_03[var_04] stalingradspawn(var_06);
				}
				else
				{
					var_07 = var_03[var_04] dospawn(var_06);
				}

				var_03[var_04] maps\_utility::set_count(0);
				if(maps\_utility::spawn_failed(var_07))
				{
					wait(0.2);
					continue;
				}

				if(isdefined(var_03[var_04].script_combatbehavior))
				{
					if(var_03[var_04].combatbehavior == "heat")
					{
						var_07 maps\_utility::enable_heat_behavior();
					}

					if(var_03[var_04].combatbehavior == "cqb")
					{
						var_07 maps\_utility::enable_cqbwalk();
					}
				}

				if(isdefined(level.friendlywave_thread))
				{
					level thread [[ level.friendlywave_thread ]](var_07);
				}
				else
				{
					var_07 setgoalentity(level.player);
				}

				if(var_05)
				{
					if(level.friendly_wave_trigger.script_delay == 0)
					{
						waittillframeend;
					}
					else
					{
						wait(level.friendly_wave_trigger.script_delay);
					}

					var_04++;
					continue;
				}

				wait(randomfloat(5));
			}
		}

		level waittill("friendly_died");
	}
}

//Function Number: 117
friendly_mgturret(param_00)
{
	var_01 = getnode(param_00.target,"targetname");
	var_02 = getent(var_01.target,"targetname");
	var_02 setmode("auto_ai");
	var_02 cleartargetentity();
	var_03 = 0;
	for(;;)
	{
		param_00 waittill("trigger",var_04);
		if(!isai(var_04))
		{
			continue;
		}

		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(var_04.team != "allies")
		{
			continue;
		}

		if(isdefined(var_04.script_usemg42) && var_04.script_usemg42 == 0)
		{
			continue;
		}

		if(var_04 thread friendly_mg42_useable(var_02,var_01))
		{
			var_04 thread friendly_mg42_think(var_02,var_01);
			var_02 waittill("friendly_finished_using_mg42");
			if(isalive(var_04))
			{
				var_04.turret_use_time = gettime() + 10000;
			}
		}

		wait(1);
	}
}

//Function Number: 118
friendly_mg42_death_notify(param_00,param_01)
{
	param_01 endon("friendly_finished_using_mg42");
	param_00 waittill("death");
	param_01 notify("friendly_finished_using_mg42");
}

//Function Number: 119
friendly_mg42_wait_for_use(param_00)
{
	param_00 endon("friendly_finished_using_mg42");
	self.useable = 1;
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"PLATFORM_USEAIONMG42");
	self waittill("trigger");
	self.useable = 0;
	self sethintstring("");
	self stopuseturret();
	self notify("stopped_use_turret");
	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 120
friendly_mg42_useable(param_00,param_01)
{
	if(self.useable)
	{
		return 0;
	}

	if(isdefined(self.turret_use_time) && gettime() < self.turret_use_time)
	{
		return 0;
	}

	if(distance(level.player.origin,param_01.origin) < 100)
	{
		return 0;
	}

	return 1;
}

//Function Number: 121
friendly_mg42_endtrigger(param_00,param_01)
{
	param_00 endon("friendly_finished_using_mg42");
	self waittill("trigger");
	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 122
friendly_mg42_stop_use()
{
	if(!isdefined(self.friendly_mg42))
	{
		return;
	}

	self.friendly_mg42 notify("friendly_finished_using_mg42");
}

//Function Number: 123
nofour()
{
	self endon("death");
	self waittill("goal");
	self.goalradius = self.oldradius;
	if(self.goalradius < 32)
	{
		self.goalradius = 400;
	}
}

//Function Number: 124
friendly_mg42_think(param_00,param_01)
{
	self endon("death");
	param_00 endon("friendly_finished_using_mg42");
	level thread friendly_mg42_death_notify(self,param_00);
	self.oldradius = self.goalradius;
	self.goalradius = 28;
	thread nofour();
	self getgoalvolume(param_01);
	self.ignoresuppression = 1;
	self waittill("goal");
	self.goalradius = self.oldradius;
	if(self.goalradius < 32)
	{
		self.goalradius = 400;
	}

	self.ignoresuppression = 0;
	self.goalradius = self.oldradius;
	if(distance(level.player.origin,param_01.origin) < 32)
	{
		param_00 notify("friendly_finished_using_mg42");
		return;
	}

	self.friendly_mg42 = param_00;
	thread friendly_mg42_wait_for_use(param_00);
	thread friendly_mg42_cleanup(param_00);
	self useturret(param_00);
	if(isdefined(param_00.target))
	{
		var_02 = getent(param_00.target,"targetname");
		if(isdefined(var_02))
		{
			var_02 thread friendly_mg42_endtrigger(param_00,self);
		}
	}

	for(;;)
	{
		if(distance(self.origin,param_01.origin) < 32)
		{
			self useturret(param_00);
		}
		else
		{
			break;
		}

		wait(1);
	}

	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 125
friendly_mg42_cleanup(param_00)
{
	self endon("death");
	param_00 waittill("friendly_finished_using_mg42");
	friendly_mg42_doneusingturret();
}

//Function Number: 126
friendly_mg42_doneusingturret()
{
	self endon("death");
	var_00 = self.friendly_mg42;
	self.friendly_mg42 = undefined;
	self stopuseturret();
	self notify("stopped_use_turret");
	self.useable = 0;
	self.goalradius = self.oldradius;
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.target))
	{
		return;
	}

	var_01 = getnode(var_00.target,"targetname");
	var_02 = self.goalradius;
	self.goalradius = 8;
	self getgoalvolume(var_01);
	wait(2);
	self.goalradius = 384;
	self waittill("goal");
	if(isdefined(self.target))
	{
		var_01 = getnode(self.target,"targetname");
		if(isdefined(var_01.target))
		{
			var_01 = getnode(var_01.target,"targetname");
		}

		if(isdefined(var_01))
		{
			self getgoalvolume(var_01);
		}
	}

	self.goalradius = var_02;
}

//Function Number: 127
tanksquish()
{
	if(isdefined(level.notanksquish))
	{
		return;
	}

	if(isdefined(level.levelhasvehicles) && !level.levelhasvehicles)
	{
		return;
	}

	maps\_utility::add_damage_function(::tanksquish_damage_check);
}

//Function Number: 128
tanksquish_damage_check(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isalive(self))
	{
		return;
	}

	if(!isalive(param_01))
	{
		return;
	}

	if(!isdefined(param_01.vehicletype))
	{
		return;
	}

	if(param_01 maps\_vehicle::ishelicopter())
	{
		return;
	}

	if(!isdefined(self.noragdoll))
	{
		self startragdoll();
	}

	if(!isdefined(self))
	{
		return;
	}

	maps\_utility::remove_damage_function(::tanksquish_damage_check);
}

//Function Number: 129
panzer_target(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_00.panzer_node = param_01;
	if(isdefined(param_01.script_delay))
	{
		param_00.panzer_delay = param_01.script_delay;
	}

	if(isdefined(param_03) && isdefined(param_04))
	{
		param_00.panzer_ent = param_03;
		param_00.panzer_ent_offset = param_04;
	}
	else
	{
		param_00.panzer_pos = param_02;
	}

	param_00 setgoalpos(param_00.origin);
	param_00 getgoalvolume(param_01);
	param_00.goalradius = 12;
	param_00 waittill("goal");
	param_00.goalradius = 28;
	param_00 waittill("shot_at_target");
	param_00.panzer_ent = undefined;
	param_00.panzer_pos = undefined;
	param_00.panzer_delay = undefined;
}

//Function Number: 130
showstart(param_00,param_01,param_02)
{
	var_03 = getstartorigin(param_00,param_01,param_02);
	wait(0.05);
}

//Function Number: 131
spawnwaypointfriendlies()
{
	maps\_utility::set_count(1);
	if(isdefined(self.script_forcespawn))
	{
		var_00 = self stalingradspawn();
	}
	else
	{
		var_00 = self dospawn();
	}

	if(maps\_utility::spawn_failed(var_00))
	{
		return;
	}

	if(isdefined(self.script_combatbehavior))
	{
		if(self.script_combatbehavior == "heat")
		{
			var_00 maps\_utility::enable_heat_behavior();
		}

		if(self.script_combatbehavior == "cqb")
		{
			var_00 maps\_utility::enable_cqbwalk();
		}
	}

	var_00.friendlywaypoint = 1;
}

//Function Number: 132
waittilldeathorleavesquad()
{
	self endon("death");
	self waittill("leaveSquad");
}

//Function Number: 133
friendlyspawnwave()
{
	common_scripts\utility::array_thread(getentarray(self.target,"targetname"),::friendlyspawnwave_triggerthink,self);
	for(;;)
	{
		self waittill("trigger",var_02);
		if(activefriendlyspawn() && getfriendlyspawntrigger() == self)
		{
			unsetfriendlyspawn();
		}

		self waittill("friendly_wave_start",var_03);
		setfriendlyspawn(var_03,self);
		if(!isdefined(var_03.target))
		{
			continue;
		}

		var_04 = getent(var_03.target,"targetname");
		var_04 thread spawnwavestoptrigger(self);
	}
}

//Function Number: 134
flood_and_secure(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn")
	{
		param_00 = 1;
	}

	level.spawnerwave = [];
	var_01 = getentarray(self.target,"targetname");
	common_scripts\utility::array_thread(var_01,::flood_and_secure_spawner,param_00);
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		self waittill("trigger",var_04);
		if(!objectiveisallowed())
		{
			continue;
		}

		if(!var_03)
		{
			var_03 = 1;
			maps\_utility::script_delay();
		}

		if(self istouching(level.player))
		{
			var_02 = 1;
		}
		else
		{
			if(!isalive(var_04))
			{
				continue;
			}

			if(isplayer(var_04))
			{
				var_02 = 1;
			}
			else if(!isdefined(var_04.issquad) || !var_04.issquad)
			{
				continue;
			}
		}

		var_01 = getentarray(self.target,"targetname");
		if(isdefined(var_01[0]))
		{
			if(isdefined(var_01[0].script_randomspawn))
			{
				cull_spawners_from_killspawner(var_01[0].script_randomspawn);
			}
		}

		var_01 = getentarray(self.target,"targetname");
		for(var_05 = 0;var_05 < var_01.size;var_05++)
		{
			var_01[var_05].playertriggered = var_02;
			var_01[var_05] notify("flood_begin");
		}

		if(var_02)
		{
			wait(5);
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 135
cull_spawners_leaving_one_set(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01[param_00[var_02].script_randomspawn] = 1;
	}

	var_03 = getarraykeys(var_01);
	var_04 = common_scripts\utility::random(var_03);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02].script_randomspawn != var_04)
		{
			param_00[var_02] delete();
		}
	}
}

//Function Number: 136
flood_and_secure_spawner(param_00)
{
	if(isdefined(self.securestarted))
	{
		return;
	}

	self.securestarted = 1;
	self.triggerunlocked = 1;
	var_01 = self.target;
	var_02 = self.targetname;
	if(!isdefined(var_01) && !isdefined(self.script_moveoverride))
	{
		waittillframeend;
	}

	var_03 = [];
	if(isdefined(var_01))
	{
		var_04 = getentarray(var_01,"targetname");
		for(var_05 = 0;var_05 < var_04.size;var_05++)
		{
			if(!issubstr(var_04[var_05].classname,"actor"))
			{
				continue;
			}

			var_03[var_03.size] = var_04[var_05];
		}
	}

	var_06 = spawnstruct();
	var_07 = self.origin;
	flood_and_secure_spawner_think(var_06,var_03.size > 0,param_00);
	if(isalive(var_06.ai))
	{
		var_06.ai waittill("death");
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_04 = getentarray(var_01,"targetname");
	if(!var_04.size)
	{
		return;
	}

	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(!issubstr(var_04[var_05].classname,"actor"))
		{
			continue;
		}

		var_04[var_05].targetname = var_02;
		var_08 = var_01;
		if(isdefined(var_04[var_05].target))
		{
			var_09 = getent(var_04[var_05].target,"targetname");
			if(!isdefined(var_09) || !issubstr(var_09.classname,"actor"))
			{
				var_08 = var_04[var_05].target;
			}
		}

		var_04[var_05].target = var_08;
		var_04[var_05] thread flood_and_secure_spawner(param_00);
		var_04[var_05].playertriggered = 1;
		var_04[var_05] notify("flood_begin");
	}
}

//Function Number: 137
flood_and_secure_spawner_think(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = self.count;
	if(!param_01)
	{
		param_01 = isdefined(self.script_noteworthy) && self.script_noteworthy == "delete";
	}

	maps\_utility::set_count(2);
	if(isdefined(self.script_delay))
	{
		var_04 = self.script_delay;
	}
	else
	{
		var_04 = 0;
	}

	for(;;)
	{
		self waittill("flood_begin");
		if(self.playertriggered)
		{
			break;
		}

		if(var_04)
		{
			continue;
		}

		break;
	}

	var_05 = distance(level.player.origin,self.origin);
	while(var_03)
	{
		self.truecount = var_03;
		maps\_utility::set_count(2);
		wait(var_04);
		var_06 = isdefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
		if(isdefined(self.script_forcespawn))
		{
			var_07 = self stalingradspawn(var_06);
		}
		else
		{
			var_07 = self dospawn(var_06);
		}

		if(maps\_utility::spawn_failed(var_07))
		{
			var_08 = 0;
			if(var_04 < 2)
			{
				wait(2);
			}

			continue;
		}
		else
		{
			if(isdefined(self.script_combatbehavior))
			{
				if(self.script_combatbehavior == "heat")
				{
					var_07 maps\_utility::enable_heat_behavior();
				}

				if(self.script_combatbehavior == "cqb")
				{
					var_07 maps\_utility::enable_cqbwalk();
				}
			}

			thread addtowavespawner(var_07);
			var_07 thread flood_and_secure_spawn(self);
			if(isdefined(self.script_accuracy))
			{
				var_07.baseaccuracy = self.script_accuracy;
			}

			param_00.ai = var_07;
			param_00 notify("got_ai");
			self waittill("spawn_died",var_09,var_08);
			if(var_04 > 2)
			{
				var_04 = randomint(4) + 2;
			}
			else
			{
				var_04 = 0.5 + randomfloat(0.5);
			}
		}

		if(var_09)
		{
			waittillrestartordistance(var_05);
			continue;
		}

		if(playerwasnearby(var_08 || param_01,param_00.ai))
		{
			var_03--;
		}

		if(!param_02)
		{
			waituntilwaverelease();
		}
	}

	self delete();
}

//Function Number: 138
waittilldeletedordeath(param_00)
{
	self endon("death");
	param_00 waittill("death");
}

//Function Number: 139
addtowavespawner(param_00)
{
	var_01 = self.targetname;
	if(!isdefined(level.spawnerwave[var_01]))
	{
		level.spawnerwave[var_01] = spawnstruct();
		level.spawnerwave[var_01] maps\_utility::set_count(0);
		level.spawnerwave[var_01].total = 0;
	}

	if(!isdefined(self.addedtowave))
	{
		self.addedtowave = 1;
		level.spawnerwave[var_01].total++;
	}

	level.spawnerwave[var_01].count++;
	waittilldeletedordeath(param_00);
	level.spawnerwave[var_01].count--;
	if(!isdefined(self))
	{
		level.spawnerwave[var_01].total--;
	}

	if(level.spawnerwave[var_01].total)
	{
		if(level.spawnerwave[var_01].count / level.spawnerwave[var_01].total < 0.32)
		{
			level.spawnerwave[var_01] notify("waveReady");
		}
	}
}

//Function Number: 140
debugwavecount(param_00)
{
	self endon("debug_stop");
	self endon("death");
	wait(0.05);
}

//Function Number: 141
waituntilwaverelease()
{
	var_00 = self.targetname;
	if(level.spawnerwave[var_00].count)
	{
		level.spawnerwave[var_00] waittill("waveReady");
	}
}

//Function Number: 142
playerwasnearby(param_00,param_01)
{
	if(param_00)
	{
		return 1;
	}

	if(isdefined(param_01) && isdefined(param_01.origin))
	{
		var_02 = param_01.origin;
	}
	else
	{
		var_02 = self.origin;
	}

	if(distance(level.player.origin,var_02) < 700)
	{
		return 1;
	}

	return bullettracepassed(level.player geteye(),param_01 geteye(),0,undefined);
}

//Function Number: 143
waittillrestartordistance(param_00)
{
	self endon("flood_begin");
	param_00 = param_00 * 0.75;
	while(distance(level.player.origin,self.origin) > param_00)
	{
		wait(1);
	}
}

//Function Number: 144
flood_and_secure_spawn(param_00)
{
	thread flood_and_secure_spawn_goal();
	self waittill("death",var_01);
	var_02 = isalive(var_01) && isplayer(var_01);
	if(!var_02 && isdefined(var_01) && var_01.classname == "worldspawn")
	{
		var_02 = 1;
	}

	var_03 = !isdefined(self);
	param_00 notify("spawn_died",var_03,var_02);
}

//Function Number: 145
flood_and_secure_spawn_goal()
{
	if(isdefined(self.script_moveoverride))
	{
		return;
	}

	self endon("death");
	var_00 = getnode(self.target,"targetname");
	if(isdefined(var_00))
	{
		self getgoalvolume(var_00);
	}
	else
	{
		var_00 = getent(self.target,"targetname");
		if(isdefined(var_00))
		{
			self setgoalpos(var_00.origin);
		}
	}

	if(isdefined(level.fightdist))
	{
		self.pathenemyfightdist = level.fightdist;
		self.pathenemylookahead = level.maxdist;
	}

	if(isdefined(var_00.radius) && var_00.radius >= 0)
	{
		self.goalradius = var_00.radius;
	}
	else
	{
		self.goalradius = 256;
	}

	self waittill("goal");
	while(isdefined(var_00.target))
	{
		var_01 = getnode(var_00.target,"targetname");
		if(isdefined(var_01))
		{
			var_00 = var_01;
		}
		else
		{
			break;
		}

		self getgoalvolume(var_00);
		if(node_has_radius(var_00))
		{
			self.goalradius = var_00.radius;
		}
		else
		{
			self.goalradius = 256;
		}

		self waittill("goal");
	}

	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "delete")
		{
			self kill();
			return;
		}
	}

	if(isdefined(var_00.target))
	{
		var_02 = getent(var_00.target,"targetname");
		if(isdefined(var_02) && var_02.code_classname == "misc_mgturret" || var_02.code_classname == "misc_turret")
		{
			self getgoalvolume(var_00);
			self.goalradius = 4;
			self waittill("goal");
			if(!isdefined(self.script_forcegoal))
			{
				self.goalradius = level.default_goalradius;
			}

			use_a_turret(var_02);
		}
	}

	if(isdefined(self.script_noteworthy))
	{
		if(isdefined(self.script_noteworthy2))
		{
			if(self.script_noteworthy2 == "furniture_push")
			{
				thread furniturepushsound();
			}
		}

		if(self.script_noteworthy == "hide")
		{
			thread maps\_utility::set_battlechatter(0);
			return;
		}
	}

	if(!isdefined(self.script_forcegoal) && !isdefined(self getgoalvolume()))
	{
		self.goalradius = level.default_goalradius;
	}
}

//Function Number: 146
furniturepushsound()
{
	var_00 = getent(self.target,"targetname").origin;
	common_scripts\utility::play_sound_in_space("furniture_slide",var_00);
	wait(0.9);
	if(isdefined(level.whisper))
	{
		common_scripts\utility::play_sound_in_space(common_scripts\utility::random(level.whisper),var_00);
	}
}

//Function Number: 147
friendlychain()
{
	waittillframeend;
	var_00 = getentarray(self.target,"targetname");
	if(!var_00.size)
	{
		var_01 = getnode(self.target,"targetname");
		for(;;)
		{
			self waittill("trigger");
			if(isdefined(level.lastfriendlytrigger) && level.lastfriendlytrigger == self)
			{
				wait(0.5);
				continue;
			}

			if(!objectiveisallowed())
			{
				wait(0.5);
				continue;
			}

			level notify("new_friendly_trigger");
			level.lastfriendlytrigger = self;
			var_02 = !isdefined(self.script_baseoffire) || self.script_baseoffire == 0;
			setnewplayerchain(var_01,var_02);
		}
	}

	for(;;)
	{
		self waittill("trigger");
		while(level.player istouching(self))
		{
			wait(0.05);
		}

		if(!objectiveisallowed())
		{
			wait(0.05);
			continue;
		}

		if(isdefined(level.lastfriendlytrigger) && level.lastfriendlytrigger == self)
		{
			continue;
		}

		level notify("new_friendly_trigger");
		level.lastfriendlytrigger = self;
		common_scripts\utility::array_thread(var_00,::friendlytrigger);
		wait(0.5);
	}
}

//Function Number: 148
objectiveisallowed()
{
	var_00 = 1;
	if(isdefined(self.script_objective_active))
	{
		var_00 = 0;
		for(var_01 = 0;var_01 < level.active_objective.size;var_01++)
		{
			if(!issubstr(self.script_objective_active,level.active_objective[var_01]))
			{
				continue;
			}

			var_00 = 1;
			break;
		}

		if(!var_00)
		{
			return 0;
		}
	}

	if(!isdefined(self.script_objective_inactive))
	{
		return var_00;
	}

	var_02 = 0;
	for(var_01 = 0;var_01 < level.inactive_objective.size;var_01++)
	{
		if(!issubstr(self.script_objective_inactive,level.inactive_objective[var_01]))
		{
			continue;
		}

		var_02++;
	}

	var_03 = strtok(self.script_objective_inactive," ");
	return var_02 == var_03.size;
}

//Function Number: 149
friendlytrigger(param_00)
{
	level endon("new_friendly_trigger");
	self waittill("trigger");
	param_00 = getnode(self.target,"targetname");
	var_01 = !isdefined(self.script_baseoffire) || self.script_baseoffire == 0;
	setnewplayerchain(param_00,var_01);
}

//Function Number: 150
waittilldeathorempty()
{
	self endon("death");
	var_00 = self.script_deathchain;
	while(self.count)
	{
		self waittill("spawned",var_01);
		var_01 thread deathchainainotify(var_00);
	}
}

//Function Number: 151
deathchainainotify(param_00)
{
	level.deathspawner[param_00]++;
	self waittill("death");
	level.deathspawner[param_00]--;
	level notify("spawner_expired" + param_00);
}

//Function Number: 152
deathchainspawnerlogic()
{
	var_00 = self.script_deathchain;
	level.deathspawner[var_00]++;
	var_01 = self.origin;
	waittilldeathorempty();
	level notify("spawner dot" + var_01);
	level.deathspawner[var_00]--;
	level notify("spawner_expired" + var_00);
}

//Function Number: 153
friendlychain_ondeath()
{
	var_00 = getentarray("friendly_chain_on_death","targetname");
	var_01 = getspawnerarray();
	level.deathspawner = [];
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(var_01[var_02].script_deathchain))
		{
			continue;
		}

		var_03 = var_01[var_02].script_deathchain;
		if(!isdefined(level.deathspawner[var_03]))
		{
			level.deathspawner[var_03] = 0;
		}

		var_01[var_02] thread deathchainspawnerlogic();
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(!isdefined(var_00[var_02].script_deathchain))
		{
			return;
		}

		var_00[var_02] thread friendlychain_ondeaththink();
	}
}

//Function Number: 154
friendlychain_ondeaththink()
{
	while(level.deathspawner[self.script_deathchain] > 0)
	{
		level waittill("spawner_expired" + self.script_deathchain);
	}

	level endon("start_chain");
	var_00 = getnode(self.target,"targetname");
	for(;;)
	{
		self waittill("trigger");
		setnewplayerchain(var_00,1);
		iprintlnbold("Area secured, move up!");
		wait(5);
	}
}

//Function Number: 155
setnewplayerchain(param_00,param_01)
{
	level notify("new_escort_trigger");
	level notify("new_escort_debug");
	level notify("start_chain",param_01);
}

//Function Number: 156
friendlychains()
{
	level.friendlyspawnorg = [];
	level.friendlyspawntrigger = [];
	common_scripts\utility::array_thread(getentarray("friendlychain","targetname"),::friendlychain);
}

//Function Number: 157
unsetfriendlyspawn()
{
	var_00 = [];
	var_01 = [];
	for(var_02 = 0;var_02 < level.friendlyspawnorg.size;var_02++)
	{
		var_00[var_00.size] = level.friendlyspawnorg[var_02];
		var_01[var_01.size] = level.friendlyspawntrigger[var_02];
	}

	level.friendlyspawnorg = var_00;
	level.friendlyspawntrigger = var_01;
	if(activefriendlyspawn())
	{
		return;
	}

	common_scripts\utility::flag_clear("spawning_friendlies");
}

//Function Number: 158
getfriendlyspawnstart()
{
	return level.friendlyspawnorg[level.friendlyspawnorg.size - 1];
}

//Function Number: 159
activefriendlyspawn()
{
	return level.friendlyspawnorg.size > 0;
}

//Function Number: 160
getfriendlyspawntrigger()
{
	return level.friendlyspawntrigger[level.friendlyspawntrigger.size - 1];
}

//Function Number: 161
setfriendlyspawn(param_00,param_01)
{
	level.friendlyspawnorg[level.friendlyspawnorg.size] = param_00.origin;
	level.friendlyspawntrigger[level.friendlyspawntrigger.size] = param_01;
	common_scripts\utility::flag_set("spawning_friendlies");
}

//Function Number: 162
delayedplayergoal()
{
	self endon("death");
	self endon("leaveSquad");
	wait(0.5);
	self setgoalentity(level.player);
}

//Function Number: 163
spawnwavestoptrigger(param_00)
{
	self notify("stopTrigger");
	self endon("stopTrigger");
	self waittill("trigger");
	if(getfriendlyspawntrigger() != param_00)
	{
		return;
	}

	unsetfriendlyspawn();
}

//Function Number: 164
friendlyspawnwave_triggerthink(param_00)
{
	var_01 = getent(self.target,"targetname");
	for(;;)
	{
		self waittill("trigger");
		param_00 notify("friendly_wave_start",var_01);
		if(!isdefined(var_01.target))
		{
			continue;
		}
	}
}

//Function Number: 165
goalvolumes()
{
	var_00 = getentarray("info_volume","classname");
	level.deathchain_goalvolume = [];
	level.goalvolumes = [];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(isdefined(var_02.script_deathchain))
		{
			level.deathchain_goalvolume[var_02.script_deathchain] = var_02;
		}

		if(isdefined(var_02.script_goalvolume))
		{
			level.goalvolumes[var_02.script_goalvolume] = var_02;
		}
	}
}

//Function Number: 166
debugprint(param_00,param_01,param_02)
{
	if(1)
	{
		return;
	}

	var_03 = self getorigin();
	var_04 = 40 * sin(var_03[0] + var_03[1]) - 40;
	var_03 = (var_03[0],var_03[1],var_03[2] + var_04);
	level endon(param_01);
	self endon("new_color");
	if(!isdefined(param_02))
	{
		param_02 = (0,0.8,0.6);
	}

	var_05 = 0;
	for(;;)
	{
		var_05 = var_05 + 12;
		var_06 = sin(var_05) * 0.4;
		if(var_06 < 0)
		{
			var_06 = var_06 * -1;
		}

		var_06 = var_06 + 1;
		wait(0.05);
	}
}

//Function Number: 167
aigroup_create(param_00)
{
	level._ai_group[param_00] = spawnstruct();
	level._ai_group[param_00].aicount = 0;
	level._ai_group[param_00].spawnercount = 0;
	level._ai_group[param_00].ai = [];
	level._ai_group[param_00].spawners = [];
}

//Function Number: 168
aigroup_spawnerthink(param_00)
{
	self endon("death");
	self.decremented = 0;
	param_00.spawnercount++;
	thread aigroup_spawnerdeath(param_00);
	thread aigroup_spawnerempty(param_00);
	while(self.count)
	{
		self waittill("spawned",var_01);
		if(maps\_utility::spawn_failed(var_01))
		{
			continue;
		}

		var_01 thread aigroup_soldierthink(param_00);
	}

	waittillframeend;
	if(self.decremented)
	{
		return;
	}

	self.decremented = 1;
	param_00.spawnercount--;
}

//Function Number: 169
aigroup_spawnerdeath(param_00)
{
	self waittill("death");
	if(self.decremented)
	{
		return;
	}

	param_00.spawnercount--;
}

//Function Number: 170
aigroup_spawnerempty(param_00)
{
	self endon("death");
	self waittill("emptied spawner");
	waittillframeend;
	if(self.decremented)
	{
		return;
	}

	self.decremented = 1;
	param_00.spawnercount--;
}

//Function Number: 171
aigroup_soldierthink(param_00)
{
	param_00.aicount++;
	param_00.ai[param_00.ai.size] = self;
	if(isdefined(self.script_deathflag_longdeath))
	{
		waittilldeathorpaindeath();
	}
	else
	{
		self waittill("death");
	}

	param_00.aicount--;
}

//Function Number: 172
camper_trigger_think(param_00)
{
	var_01 = strtok(param_00.script_linkto," ");
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		var_05 = var_01[var_04];
		var_06 = getent(var_05,"script_linkname");
		if(isdefined(var_06))
		{
			var_02 = common_scripts\utility::add_to_array(var_02,var_06);
			continue;
		}

		var_07 = getnode(var_05,"script_linkname");
		if(!isdefined(var_07))
		{
			continue;
		}

		var_03 = common_scripts\utility::add_to_array(var_03,var_07);
	}

	param_00 waittill("trigger");
	var_03 = common_scripts\utility::array_randomize(var_03);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_03[var_04].claimed = 0;
	}

	var_08 = 0;
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_09 = var_02[var_04];
		if(!isdefined(var_09))
		{
			continue;
		}

		if(isdefined(var_09.script_spawn_here))
		{
			continue;
		}

		while(isdefined(var_03[var_08].script_noteworthy) && var_03[var_08].script_noteworthy == "dont_spawn")
		{
			var_08++;
		}

		var_09.origin = var_03[var_08].origin;
		var_09.angles = var_03[var_08].angles;
		var_09 maps\_utility::add_spawn_function(::claim_a_node,var_03[var_08]);
		var_08++;
	}

	common_scripts\utility::array_thread(var_02,::maps\_utility::add_spawn_function,::camper_guy);
	common_scripts\utility::array_thread(var_02,::maps\_utility::add_spawn_function,::move_when_enemy_hides,var_03);
	common_scripts\utility::array_thread(var_02,::maps\_utility::spawn_ai);
}

//Function Number: 173
camper_guy()
{
	self.goalradius = 8;
	self.fixednode = 1;
}

//Function Number: 174
move_when_enemy_hides(param_00)
{
	self endon("death");
	var_01 = 0;
	for(;;)
	{
		if(!isalive(self.enemy))
		{
			self waittill("enemy");
			var_01 = 0;
			continue;
		}

		if(isplayer(self.enemy))
		{
			if(self.enemy maps\_utility::ent_flag("player_has_red_flashing_overlay") || common_scripts\utility::flag("player_flashed"))
			{
				self.fixednode = 0;
				for(;;)
				{
					self.goalradius = 180;
					self setgoalpos(level.player.origin);
					wait(1);
				}

				return;
			}
		}

		if(var_01)
		{
			if(self cansee(self.enemy))
			{
				wait(0.05);
				continue;
			}

			var_01 = 0;
		}
		else
		{
			if(self cansee(self.enemy))
			{
				var_01 = 1;
			}

			wait(0.05);
			continue;
		}

		if(randomint(3) > 0)
		{
			var_02 = find_unclaimed_node(param_00);
			if(isdefined(var_02))
			{
				claim_a_node(var_02,self.claimed_node);
				self waittill("goal");
			}
		}
	}
}

//Function Number: 175
claim_a_node(param_00,param_01)
{
	self getgoalvolume(param_00);
	self.claimed_node = param_00;
	param_00.claimed = 1;
	if(isdefined(param_01))
	{
		param_01.claimed = 0;
	}
}

//Function Number: 176
find_unclaimed_node(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(param_00[var_01].claimed)
		{
			continue;
		}
		else
		{
			return param_00[var_01];
		}
	}

	return undefined;
}

//Function Number: 177
flood_trigger_think(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	common_scripts\utility::array_thread(var_01,::flood_spawner_init);
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	common_scripts\utility::array_thread(var_01,::flood_spawner_think,param_00);
}

//Function Number: 178
flood_spawner_init(param_00)
{
}

//Function Number: 179
trigger_requires_player(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return isdefined(param_00.script_requires_player);
}

//Function Number: 180
two_stage_spawner_think(param_00)
{
	var_01 = getent(param_00.target,"targetname");
	waittillframeend;
	var_02 = getentarray(var_01.target,"targetname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03].script_moveoverride = 1;
		var_02[var_03] maps\_utility::add_spawn_function(::wait_to_go,var_01);
	}

	param_00 waittill("trigger");
	var_02 = getentarray(var_01.target,"targetname");
	common_scripts\utility::array_thread(var_02,::maps\_utility::spawn_ai);
}

//Function Number: 181
wait_to_go(param_00)
{
	param_00 endon("death");
	self endon("death");
	self.goalradius = 8;
	param_00 waittill("trigger");
	thread go_to_node();
}

//Function Number: 182
flood_spawner_think(param_00)
{
	if(!isdefined(level.spawn_pool_enabled) || isspawner(self))
	{
		self endon("death");
	}

	self notify("stop current floodspawner");
	self endon("stop current floodspawner");
	if(is_pyramid_spawner())
	{
		pyramid_spawn(param_00);
		return;
	}

	var_01 = trigger_requires_player(param_00);
	maps\_utility::script_delay();
	if(isdefined(level.spawn_pool_enabled))
	{
		if(!isspawner(self))
		{
			self.count = 1;
		}
	}

	while(self.count > 0)
	{
		while(var_01 && !level.player istouching(param_00))
		{
			wait(0.5);
		}

		var_02 = isdefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
		var_03 = self;
		if(isdefined(level.spawn_pool_enabled))
		{
			if(!isspawner(self))
			{
				var_03 = get_spawner_from_pool(self,1);
			}
		}

		if(isdefined(self.script_forcespawn))
		{
			var_04 = var_03 stalingradspawn(var_02);
		}
		else
		{
			var_04 = var_03 dospawn(var_02);
		}

		if(maps\_utility::spawn_failed(var_04))
		{
			wait(2);
			continue;
		}

		if(isdefined(self.script_combatbehavior))
		{
			if(self.script_combatbehavior == "heat")
			{
				var_04 maps\_utility::enable_heat_behavior();
			}

			if(self.script_combatbehavior == "cqb")
			{
				var_04 maps\_utility::enable_cqbwalk();
			}
		}

		var_04 thread reincrement_count_if_deleted(self);
		var_04 thread expand_goalradius(param_00);
		if(isdefined(var_04) && !isdefined(var_04.targetname))
		{
			if(isdefined(self.targetname))
			{
				var_04.targetname = self.targetname + "_AI";
			}
		}

		var_04 waittill("death",var_05);
		if(!player_saw_kill(var_04,var_05))
		{
			self.count++;
		}
		else if(isdefined(level.ac130_flood_respawn))
		{
			if(isdefined(level.ac130gunner) && var_05 == level.ac130gunner)
			{
				if(randomint(2) == 0)
				{
					self.count++;
				}
			}
		}

		if(!isdefined(var_04))
		{
			continue;
		}

		if(!maps\_utility::script_wait())
		{
			wait(randomfloatrange(5,9));
		}
	}
}

//Function Number: 183
flood_spawner_stop()
{
	self notify("stop current floodspawner");
}

//Function Number: 184
player_saw_kill(param_00,param_01)
{
	if(isdefined(self.script_force_count))
	{
		if(self.script_force_count)
		{
			return 1;
		}
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isalive(param_01))
	{
		if(isplayer(param_01))
		{
			return 1;
		}

		if(distance(param_01.origin,level.player.origin) < 200)
		{
			return 1;
		}
	}
	else if(isdefined(param_01))
	{
		if(param_01.classname == "worldspawn")
		{
			return 0;
		}

		if(distance(param_01.origin,level.player.origin) < 200)
		{
			return 1;
		}
	}

	if(distance(param_00.origin,level.player.origin) < 200)
	{
		return 1;
	}

	return bullettracepassed(level.player geteye(),param_00 geteye(),0,undefined);
}

//Function Number: 185
is_pyramid_spawner()
{
	if(!isdefined(self.target))
	{
		return 0;
	}

	var_00 = getentarray(self.target,"targetname");
	if(!var_00.size)
	{
		return 0;
	}

	return issubstr(var_00[0].classname,"actor");
}

//Function Number: 186
pyramid_death_report(param_00)
{
	param_00.spawn waittill("death");
	self notify("death_report");
}

//Function Number: 187
pyramid_spawn(param_00)
{
	self endon("death");
	var_01 = trigger_requires_player(param_00);
	maps\_utility::script_delay();
	if(var_01)
	{
		while(!level.player istouching(param_00))
		{
			wait(0.5);
		}
	}

	var_02 = getentarray(self.target,"targetname");
	self.spawners = 0;
	common_scripts\utility::array_thread(var_02,::pyramid_spawner_reports_death,self);
	var_04 = randomint(var_02.size);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(self.count <= 0)
		{
			return;
		}

		var_04++;
		if(var_04 >= var_02.size)
		{
			var_04 = 0;
		}

		var_05 = var_02[var_04];
		var_05.count = 1;
		var_06 = var_05 maps\_utility::spawn_ai();
		if(maps\_utility::spawn_failed(var_06))
		{
			wait(2);
			continue;
		}

		self.count--;
		var_05.spawn = var_06;
		var_06 thread reincrement_count_if_deleted(self);
		var_06 thread expand_goalradius(param_00);
		thread pyramid_death_report(var_05);
	}

	var_07 = 0.01;
	while(self.count > 0)
	{
		self waittill("death_report");
		maps\_utility::script_wait();
		wait(var_07);
		var_07 = var_07 + 2.5;
		var_04 = randomint(var_02.size);
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02 = common_scripts\utility::array_removeundefined(var_02);
			if(!var_02.size)
			{
				if(isdefined(self))
				{
					self delete();
				}

				return;
			}

			var_04++;
			if(var_04 >= var_02.size)
			{
				var_04 = 0;
			}

			var_05 = var_02[var_04];
			if(isalive(var_05.spawn))
			{
				continue;
			}

			if(isdefined(var_05.target))
			{
				self.target = var_05.target;
			}
			else
			{
				self.target = undefined;
			}

			var_06 = maps\_utility::spawn_ai();
			if(maps\_utility::spawn_failed(var_06))
			{
				wait(2);
				continue;
			}

			var_06 thread reincrement_count_if_deleted(self);
			var_06 thread expand_goalradius(param_00);
			var_05.spawn = var_06;
			thread pyramid_death_report(var_05);
			if(self.count <= 0)
			{
				return;
			}
		}
	}
}

//Function Number: 188
pyramid_spawner_reports_death(param_00)
{
	param_00 endon("death");
	param_00.spawners++;
	self waittill("death");
	param_00.spawners--;
	if(!param_00.spawners)
	{
		param_00 delete();
	}
}

//Function Number: 189
expand_goalradius(param_00)
{
	if(isdefined(self.script_forcegoal))
	{
		return;
	}

	var_01 = level.default_goalradius;
	if(isdefined(param_00))
	{
		if(isdefined(param_00.script_radius))
		{
			if(param_00.script_radius == -1)
			{
				return;
			}

			var_01 = param_00.script_radius;
		}
	}

	if(isdefined(self.script_forcegoal))
	{
		return;
	}

	self endon("death");
	self waittill("goal");
	self.goalradius = var_01;
}

//Function Number: 190
drop_health_timeout_thread()
{
	self endon("death");
	wait(95);
	self notify("timeout");
}

//Function Number: 191
drop_health_trigger_think()
{
	self endon("timeout");
	thread drop_health_timeout_thread();
	self waittill("trigger");
	maps\_utility::change_player_health_packets(1);
}

//Function Number: 192
traceshow(param_00)
{
	wait(0.05);
}

//Function Number: 193
show_bad_path()
{
}

//Function Number: 194
random_spawn(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	if(!var_01.size)
	{
		return;
	}

	var_02 = common_scripts\utility::random(var_01);
	var_01 = [];
	var_01[var_01.size] = var_02;
	if(isdefined(var_02.script_linkto))
	{
		var_03 = strtok(var_02.script_linkto," ");
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_01[var_01.size] = getent(var_03[var_04],"script_linkname");
		}
	}

	waittillframeend;
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::blowout_goalradius_on_pathend);
	common_scripts\utility::array_thread(var_01,::maps\_utility::spawn_ai);
}

//Function Number: 195
blowout_goalradius_on_pathend()
{
	if(isdefined(self.script_forcegoal))
	{
		return;
	}

	self endon("death");
	self waittill("reached_path_end");
	if(!isdefined(self getgoalvolume()))
	{
		self.goalradius = level.default_goalradius;
	}
}

//Function Number: 196
objective_event_init(param_00)
{
	var_01 = param_00 maps\_utility::get_trigger_flag();
	common_scripts\utility::flag_init(var_01);
	while(level.deathspawner[param_00.script_deathchain] > 0)
	{
		level waittill("spawner_expired" + param_00.script_deathchain);
	}

	common_scripts\utility::flag_set(var_01);
}

//Function Number: 197
setup_ai_eq_triggers()
{
	self endon("death");
	waittillframeend;
	self.is_the_player = isplayer(self);
	self.eq_table = [];
	self.eq_touching = [];
	for(var_00 = 0;var_00 < level.eq_trigger_num;var_00++)
	{
		self.eq_table[var_00] = 0;
	}
}

//Function Number: 198
ai_array()
{
	level.ai_array[level.unique_id] = self;
	self waittill("death");
	waittillframeend;
	level.ai_array[level.unique_id] = undefined;
}

//Function Number: 199
spawner_dronespawn(param_00)
{
	var_01 = param_00 spawndrone();
	var_01 useanimtree(#animtree);
	if(var_01.weapon != "none")
	{
		var_02 = getweaponmodel(var_01.weapon);
		var_01 attach(var_02,"tag_weapon_right");
		var_01 maps\_utility::update_weapon_tag_visibility(var_01.weapon);
	}

	var_01.spawner = param_00;
	var_01.drone_delete_on_unload = isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "drone_delete_on_unload";
	param_00 notify("drone_spawned",var_01);
	return var_01;
}

//Function Number: 200
spawner_swap_drone_to_ai(param_00)
{
	if(!isdefined(param_00.spawner))
	{
	}

	param_00.spawner.count = param_00.spawner.count + 1;
	var_01 = param_00.spawner;
	var_01.count++;
	var_02 = var_01.origin;
	var_03 = var_01.angles;
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_04 = var_01 stalingradspawn();
	var_05 = maps\_utility::spawn_failed(var_04);
	if(var_05)
	{
		wait(0.05);
		var_04 = var_01 stalingradspawn();
	}

	var_04.spawner = var_01;
	var_04 setmodel(param_00.model);
	var_04 codescripts\character::setheadmodel(param_00.headmodel);
	var_04.vehicle_idling = param_00.vehicle_idling;
	var_04.vehicle_position = param_00.vehicle_position;
	var_04.standing = param_00.standing;
	var_04.forcecolor = param_00.forcecolor;
	var_04 copyanimtreestate(param_00);
	var_01.origin = var_02;
	var_01.angles = var_03;
	param_00 delete();
	var_06 = var_04.pathgoalpos;
	return var_04;
}

//Function Number: 201
spawner_swap_ai_to_drone(param_00)
{
	var_01 = param_00.spawner;
	var_02 = var_01.origin;
	var_03 = var_01.angles;
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_04 = var_01 maps\_utility::dronespawn();
	if(!isdefined(var_04))
	{
	}

	var_04 setmodel(param_00.model);
	var_04 codescripts\character::setheadmodel(param_00.headmodel);
	var_04.vehicle_idling = param_00.vehicle_idling;
	var_04.vehicle_position = param_00.vehicle_position;
	var_04.standing = param_00.standing;
	var_04.forcecolor = param_00.forcecolor;
	var_04 copyanimtreestate(param_00);
	var_01.origin = var_02;
	var_01.angles = var_03;
	param_00 delete();
	var_04 notify("drone_stop");
	return var_04;
}

//Function Number: 202
death_achievements()
{
	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(self))
	{
		return;
	}

	achieve_enemy_killed_by_flash_banged(var_00);
	thread achieve_carkilled_by_player(var_00);
	thread achieve_three_of_kind(var_00,var_01);
	thread achieve_four_of_kind(var_00,var_01);
}

//Function Number: 203
achieve_three_of_kind(param_00,param_01)
{
	if(self.team != "axis")
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 != level.player)
	{
		return;
	}

	if(param_01 != "MOD_MELEE")
	{
		return;
	}

	if(!isdefined(level.achieve_three_of_kind))
	{
		level.achieve_three_of_kind = 1;
	}
	else
	{
		level.achieve_three_of_kind++;
	}

	if(level.achieve_three_of_kind == 3)
	{
		maps\_utility::giveachievement_wrapper("THREE_OF_A_KIND");
	}

	level notify("achieve_three_of_kind");
	level endon("achieve_three_of_kind");
	wait(4);
	level.achieve_three_of_kind = undefined;
}

//Function Number: 204
achieve_four_of_kind(param_00,param_01)
{
	if(self.team != "axis")
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 != level.player)
	{
		return;
	}

	if(param_01 == "MOD_MELEE" || !animscripts\utility::damagelocationisany("head","neck","helmet"))
	{
		level.achieve_four_of_kind = undefined;
		return;
	}

	if(!isdefined(level.achieve_four_of_kind))
	{
		level.achieve_four_of_kind = 1;
	}
	else
	{
		level.achieve_four_of_kind++;
	}

	if(level.achieve_four_of_kind == 4)
	{
		maps\_utility::giveachievement_wrapper("FOUR_OF_A_KIND");
	}

	level notify("achieve_four_of_kind");
	level endon("achieve_four_of_kind");
	wait(12);
	level.achieve_four_of_kind = undefined;
}

//Function Number: 205
achieve_enemy_killed_by_flash_banged(param_00)
{
	if(self.team != "axis")
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(level.flag["player_flashed"] && param_00 == level.player)
	{
		maps\_utility::giveachievement_wrapper("DAREDEVIL");
	}
}

//Function Number: 206
achieve_carkilled_by_player(param_00)
{
	if(self.team != "axis")
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.destuctableinfo))
	{
		return;
	}

	if(!isdefined(param_00.attacker))
	{
		return;
	}

	if(param_00.attacker != level.player)
	{
		return;
	}

	if(isdefined(level.achieve_car_killed_one))
	{
		maps\_utility::giveachievement_wrapper("ROADKILL");
		level.achieve_car_killed_one = undefined;
		return;
	}

	level.achieve_car_killed_one = 1;
	wait(0.05);
}

//Function Number: 207
death_achievements_rappel(param_00)
{
}

//Function Number: 208
add_random_killspawner_to_spawngroup()
{
	var_00 = self.script_random_killspawner;
	var_01 = self.script_randomspawn;
	if(!isdefined(level.killspawn_groups[var_00]))
	{
		level.killspawn_groups[var_00] = [];
	}

	if(!isdefined(level.killspawn_groups[var_00][var_01]))
	{
		level.killspawn_groups[var_00][var_01] = [];
	}

	level.killspawn_groups[var_00][var_01][self.export] = self;
}

//Function Number: 209
add_to_spawngroup()
{
	var_00 = self.script_spawngroup;
	var_01 = self.script_spawnsubgroup;
	if(!isdefined(level.spawn_groups[var_00]))
	{
		level.spawn_groups[var_00] = [];
	}

	if(!isdefined(level.spawn_groups[var_00][var_01]))
	{
		level.spawn_groups[var_00][var_01] = [];
	}

	level.spawn_groups[var_00][var_01][self.export] = self;
}

//Function Number: 210
start_off_running()
{
	self endon("death");
	self.disableexits = 1;
	wait(3);
	self.disableexits = 0;
}

//Function Number: 211
deathtime()
{
	self endon("death");
	wait(self.script_deathtime);
	wait(randomfloat(10));
	self kill();
}