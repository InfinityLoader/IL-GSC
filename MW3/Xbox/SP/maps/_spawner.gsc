/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_spawner.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 204
 * Decompile Time: 3740 ms
 * Timestamp: 10/27/2023 2:32:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachemodel("grenade_bag");
	createthreatbiasgroup("allies");
	createthreatbiasgroup("axis");
	createthreatbiasgroup("team3");
	createthreatbiasgroup("civilian");
	maps\_anim::addnotetrack_customfunction("generic","rappel_pushoff_initial_npc",::maps\_utility::func_1C7D);
	maps\_anim::addnotetrack_customfunction("generic","ps_rappel_pushoff_initial_npc",::maps\_utility::func_1C7D);
	maps\_anim::addnotetrack_customfunction("generic","feet_on_ground",::maps\_utility::disable_achievement_harder_they_fall_guy);
	maps\_anim::addnotetrack_customfunction("generic","ps_rappel_clipout_npc",::maps\_utility::disable_achievement_harder_they_fall_guy);
	foreach(var_01 in level.players)
	{
		var_01 setthreatbiasgroup("allies");
	}

	level.var_1C7F = 0;
	level.var_1C80 = [];
	level.var_1C81 = 0;
	level.ffpoints = 0;
	level.var_1291 = 0;
	level.var_1C83 = [];
	level.smoke_thrown = [];
	if(!isdefined(level.deathflags))
	{
		level.deathflags = [];
	}

	level.spawner_number = 0;
	level.go_to_node_arrays = [];
	if(!isdefined(level.var_1C88))
	{
		level.var_1C88 = [];
	}

	level.var_1C88["regular"] = ::func_1CEC;
	level.var_1C88["elite"] = ::subclass_elite;
	level.team_specific_spawn_functions = [];
	level.team_specific_spawn_functions["axis"] = ::func_1CE3;
	level.team_specific_spawn_functions["allies"] = ::func_1CE0;
	level.team_specific_spawn_functions["team3"] = ::spawn_team_team3;
	level.team_specific_spawn_functions["neutral"] = ::spawn_team_neutral;
	level.next_health_drop_time = 0;
	level.guys_to_die_before_next_health_drop = randomintrange(1,4);
	if(!isdefined(level.default_goalradius))
	{
		level.default_goalradius = 2048;
	}

	if(!isdefined(level.var_1C8C))
	{
		level.var_1C8C = 512;
	}

	level.var_1C8D = "J_Shoulder_RI";
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
	common_scripts\utility::run_thread_on_noteworthy("hiding_door_spawner",::maps\_hiding_door::hiding_door_spawner);
}

//Function Number: 2
func_1C93(param_00)
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
		if(!param_00[var_03] func_1C94())
		{
			continue;
		}

		var_02++;
	}
}

//Function Number: 3
func_1C94()
{
	if(isdefined(self.var_1A02))
	{
		return 1;
	}

	return isdefined(self.script_char_index);
}

//Function Number: 4
process_deathflags()
{
	foreach(var_02, var_01 in level.deathflags)
	{
		if(!isdefined(level.flag[var_02]))
		{
			common_scripts\utility::flag_init(var_02);
		}
	}
}

//Function Number: 5
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

//Function Number: 6
ai_deathflag()
{
	level.deathflags[self.var_1C98]["ai"][self.unique_id] = self;
	var_00 = self.unique_id;
	var_01 = self.var_1C98;
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

//Function Number: 7
func_1C9A()
{
	var_00 = self.unique_id;
	var_01 = self.var_1C98;
	if(!isdefined(level.deathflags) || !isdefined(level.deathflags[self.var_1C98]))
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

//Function Number: 8
spawner_deathflag()
{
	level.deathflags[self.var_1C98] = [];
	waittillframeend;
	if(!isdefined(self) || self.count == 0)
	{
		return;
	}

	self.spawner_number = level.spawner_number;
	level.spawner_number++;
	level.deathflags[self.var_1C98]["spawners"][self.spawner_number] = self;
	var_00 = self.var_1C98;
	var_01 = self.spawner_number;
	spawn_guys_until_death_or_no_count();
	level.deathflags[var_00]["spawners"][var_01] = undefined;
	update_deathflag(var_00);
}

//Function Number: 9
func_1C9C()
{
	level.deathflags[self.var_1C98] = [];
	waittillframeend;
	if(!isdefined(self))
	{
		return;
	}

	self.spawner_number = level.spawner_number;
	level.spawner_number++;
	level.deathflags[self.var_1C98]["vehicle_spawners"][self.spawner_number] = self;
	var_00 = self.var_1C98;
	var_01 = self.spawner_number;
	spawn_guys_until_death_or_no_count();
	level.deathflags[var_00]["vehicle_spawners"][var_01] = undefined;
	update_deathflag(var_00);
}

//Function Number: 10
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

//Function Number: 11
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

		var_01 thread maps\_utility::func_1C9E(0.15);
		var_01 maps\_utility::disable_cqbwalk();
		var_01.wantshotgun = 0;
	}
}

//Function Number: 12
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

		var_01 thread maps\_utility::func_1C9E(0.15);
		var_01 maps\_utility::enable_cqbwalk();
		var_01.wantshotgun = 1;
	}
}

//Function Number: 13
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
		if(maps\_utility::func_F77(var_01))
		{
			param_00 notify("spawn_failed");
		}

		if(isdefined(self.wait) && self.wait > 0)
		{
			wait self.wait;
		}
	}
}

//Function Number: 14
func_1A40(param_00)
{
	var_01 = param_00.var_1A5B;
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
				var_05 thread maps\_vehicle::func_1B3C();
			}

			continue;
		}

		var_05 thread trigger_spawner_spawns_guys();
	}

	if(isdefined(level.spawn_pool_enabled))
	{
		trigger_pool_spawners(var_02);
	}
}

//Function Number: 15
trigger_pool_spawners(param_00)
{
	var_01 = common_scripts\utility::getstructarray(param_00,"targetname");
	if(getentarray(param_00,"target").size <= 1)
	{
		maps\_utility::deletestructarray_ref(var_01);
	}

	var_02 = func_1CA5(var_01);
	common_scripts\utility::array_thread(var_02,::trigger_spawner_spawns_guys);
}

//Function Number: 16
func_1CA5(param_00)
{
	var_01 = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.var_1CA6))
		{
			continue;
		}

		if(!isdefined(var_02[var_04.var_1CA6]))
		{
			var_02[var_04.var_1CA6] = [];
		}

		var_02[var_04.var_1CA6][var_02[var_04.var_1CA6].size] = var_04;
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

//Function Number: 17
get_spawner_from_pool(param_00,param_01)
{
	if(!isdefined(level.spawner_pool))
	{
		level.spawner_pool = [];
	}

	if(!isdefined(level.spawner_pool[param_00.var_1CA6]))
	{
		level.spawner_pool[param_00.var_1CA6] = create_new_spawner_pool(param_00.var_1CA6);
	}

	var_02 = level.spawner_pool[param_00.var_1CA6];
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

//Function Number: 18
create_new_spawner_pool(param_00)
{
	var_01 = getspawnerarray();
	var_02 = spawnstruct();
	var_03 = [];
	foreach(var_05 in var_01)
	{
		if(!isdefined(var_05.var_1CA6))
		{
			continue;
		}

		if(var_05.var_1CA6 != param_00)
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	var_02.poolindex = 0;
	var_02.pool = var_03;
	return var_02;
}

//Function Number: 19
trigger_spawner_spawns_guys()
{
	self endon("death");
	maps\_utility::script_delay();
	if(!isdefined(self))
	{
		return undefined;
	}

	if(isdefined(self.var_1CAE))
	{
		var_00 = maps\_utility::dronespawn(self);
		return undefined;
	}
	else if(!issubstr(self.classname,"actor"))
	{
		return undefined;
	}

	var_01 = isdefined(self.var_1CB0) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
	if(isdefined(self.script_forcespawn))
	{
		var_00 = self stalingradspawn(var_01);
	}
	else
	{
		var_00 = self dospawn(var_01);
	}

	if(!maps\_utility::func_F77(var_01))
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
	}

	return var_01;
}

//Function Number: 20
func_1A41(param_00)
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
		var_05 thread func_1CB4();
	}
}

//Function Number: 21
func_1CB4()
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

		if(!maps\_utility::func_1CB5())
		{
			wait randomfloatrange(1,3);
		}
	}

	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 22
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

//Function Number: 23
func_1CB7(param_00)
{
	common_scripts\utility::array_thread(param_00,::flood_spawner_init);
	common_scripts\utility::array_thread(param_00,::func_1DBF);
}

//Function Number: 24
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

//Function Number: 25
delete_start(param_00)
{
	for(var_01 = 0;var_01 < 2;var_01++)
	{
		switch(var_01)
		{
			case 0:
				var_02 = "axis";
				break;

			default:
				var_02 = "allies";
				break;
		}

		var_03 = getentarray(var_02,"team");
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(isdefined(var_03[var_04].script_start))
			{
				if(var_03[var_04].script_start == param_00)
				{
					var_03[var_04] thread delete_me();
				}
			}
		}
	}
}

//Function Number: 26
func_1CBC(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_00.targetname) && param_00.targetname != "flood_spawner")
	{
		return;
	}

	if(level.script == "sniperescape")
	{
		return;
	}

	param_00 delete();
}

//Function Number: 27
func_1A5B(param_00)
{
	param_00 endon("death");
	var_01 = param_00.script_random_killspawner;
	waittillframeend;
	if(!isdefined(level.killspawn_groups[var_01]))
	{
		return;
	}

	param_00 waittill("trigger");
	func_1CBD(var_01);
}

//Function Number: 28
func_1CBD(param_00)
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

//Function Number: 29
func_1CBE(param_00)
{
	var_01 = getspawnerarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02].var_13F6) && param_00 == var_01[var_02].var_13F6)
		{
			var_01[var_02] delete();
		}
	}
}

//Function Number: 30
kill_spawner(param_00)
{
	var_01 = param_00.var_13F6;
	param_00 waittill("trigger");
	waittillframeend;
	waittillframeend;
	func_1CBE(var_01);
	func_1CBC(param_00);
}

//Function Number: 31
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

//Function Number: 32
kill_spawnernum(param_00)
{
	var_01 = getspawnerarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(var_01[var_02].var_13F6))
		{
			continue;
		}

		if(param_00 != var_01[var_02].var_13F6)
		{
			continue;
		}

		var_01[var_02] delete();
	}
}

//Function Number: 33
trigger_spawn(param_00)
{
}

//Function Number: 34
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

	var_03 = spawn("weapon_fraggrenade",param_00);
	level.grenade_cache[param_01][var_02] = var_03;
	level.grenade_cache_index[param_01] = var_02 + 1 % 16;
	return var_03;
}

//Function Number: 35
waittilldeathorpaindeath()
{
	self endon("death");
	self waittill("pain_death");
}

//Function Number: 36
func_1CC6()
{
	var_00 = self.team;
	waittilldeathorpaindeath();
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_1CC7))
	{
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

	level.nextgrenadedrop = 2 + randomint(2);
	var_01 = 25;
	var_02 = 12;
	var_03 = self.origin + (randomint(var_01) - var_02,randomint(var_01) - var_02,2) + (0,0,42);
	var_04 = (0,randomint(360),90);
	thread func_1CC8(var_03,var_04,self.team);
}

//Function Number: 37
func_1CC8(param_00,param_01,param_02)
{
	var_03 = spawn_grenade(param_00,param_02);
	var_03 setmodel("grenade_bag");
	var_03.angles = param_01;
	var_03 hide();
	wait 0.7;
	if(!isdefined(var_03))
	{
		return;
	}

	var_03 show();
}

//Function Number: 38
dronespawner_init()
{
	maps\_drone::func_1BBF();
}

//Function Number: 39
empty()
{
}

//Function Number: 40
spawn_prethink()
{
	level.ai_classname_in_level[self.classname] = 1;
	if(isdefined(self.script_difficulty))
	{
		switch(self.script_difficulty)
		{
			case "easy":
				if(level.gameskill > 1)
				{
					maps\_utility::set_count(0);
				}
				break;

			case "hard":
				if(level.gameskill < 2)
				{
					maps\_utility::set_count(0);
				}
				break;
		}
	}

	if(isdefined(self.var_1CAE))
	{
		thread dronespawner_init();
	}

	if(isdefined(self.script_aigroup))
	{
		var_00 = self.script_aigroup;
		if(!isdefined(level.var_1C80[var_00]))
		{
			aigroup_create(var_00);
		}

		thread aigroup_spawnerthink(level.var_1C80[var_00]);
	}

	if(isdefined(self.script_delete))
	{
		var_01 = 0;
		if(isdefined(level._ai_delete))
		{
			if(isdefined(level._ai_delete[self.script_delete]))
			{
				var_01 = level._ai_delete[self.script_delete].size;
			}
		}

		level._ai_delete[self.script_delete][var_01] = self;
	}

	if(isdefined(self.script_health))
	{
		if(self.script_health > level._max_script_health)
		{
			level._max_script_health = self.script_health;
		}

		var_01 = 0;
		if(isdefined(level._ai_health))
		{
			if(isdefined(level._ai_health[self.script_health]))
			{
				var_01 = level._ai_health[self.script_health].size;
			}
		}

		level._ai_health[self.script_health][var_01] = self;
	}

	if(isdefined(self.var_1C98))
	{
		thread spawner_deathflag();
	}

	if(isdefined(self.target))
	{
		func_1CDF();
	}

	if(isdefined(self.var_1B33))
	{
		func_1DEC();
	}

	if(isdefined(self.script_random_killspawner))
	{
		add_random_killspawner_to_spawngroup();
	}

	if(!isdefined(self.spawn_functions))
	{
		self.spawn_functions = [];
	}

	for(;;)
	{
		var_02 = undefined;
		self waittill("spawned",var_02);
		if(!isalive(var_02))
		{
			continue;
		}

		if(isdefined(level.spawnercallbackthread))
		{
			self thread [[ level.spawnercallbackthread ]](var_02);
		}

		if(isdefined(self.script_delete))
		{
			for(var_03 = 0;var_03 < level._ai_delete[self.script_delete].size;var_03++)
			{
				if(level._ai_delete[self.script_delete][var_03] != self)
				{
					level._ai_delete[self.script_delete][var_03] delete();
				}
			}
		}

		var_02.var_1A35 = self.spawn_functions;
		var_02.spawner = self;
		if(isdefined(self.targetname))
		{
			var_02 thread spawn_think(self.targetname);
			continue;
		}

		var_02 thread spawn_think();
	}
}

//Function Number: 41
spawn_think(param_00)
{
	level.ai_classname_in_level[self.classname] = 1;
	func_1D0D(param_00);
	self endon("death");
	if(shouldnt_spawn_because_of_script_difficulty())
	{
		self delete();
	}

	thread func_1CD4();
	self.var_1929 = 1;
	self notify("finished spawning");
	if(self.team == "allies" && !isdefined(self.var_1CD2))
	{
		thread friendlydeath_thread();
	}
}

//Function Number: 42
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
			if(level.gameskill > 1)
			{
				var_00 = 1;
			}
			break;

		case "hard":
			if(level.gameskill < 2)
			{
				var_00 = 1;
			}
			break;
	}

	return var_00;
}

//Function Number: 43
func_1CD4()
{
	if(!isdefined(self.var_1A35))
	{
		self.spawner = undefined;
		return;
	}

	for(var_00 = 0;var_00 < self.var_1A35.size;var_00++)
	{
		var_01 = self.var_1A35[var_00];
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

	if(isdefined(self.team))
	{
		for(var_00 = 0;var_00 < level.var_1A35[self.team].size;var_00++)
		{
			var_01 = level.var_1A35[self.team][var_00];
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

	self.var_1A35 = undefined;
	self.spawner = undefined;
}

//Function Number: 44
specops_think()
{
	if(!maps\_utility::is_specialop())
	{
		return;
	}

	maps\_utility::add_damage_function(::specops_dmg);
	thread multikill_monitor();
}

//Function Number: 45
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

//Function Number: 46
specops_dmg(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		self.last_dmg_player = param_01;
		self.var_1CD9 = param_04;
	}
}

//Function Number: 47
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

			var_04 = 0;
			if(isplayer(var_00))
			{
				var_04 = 1;
			}

			if(isdefined(level.pmc_match) && level.pmc_match)
			{
				var_04 = 1;
			}

			if(var_04)
			{
				var_00 maps\_player_stats::register_kill(self,var_01,var_02,var_03);
			}
		}
	}

	for(var_05 = 0;var_05 < self.deathfuncs.size;var_05++)
	{
		var_06 = self.deathfuncs[var_05];
		switch(var_06["params"])
		{
			case 0:
				[[ var_06["func"] ]](var_00);
				break;

			case 1:
				[[ var_06["func"] ]](var_00,var_06["param1"]);
				break;

			case 2:
				[[ var_06["func"] ]](var_00,var_06["param1"],var_06["param2"]);
				break;

			case 3:
				[[ var_06["func"] ]](var_00,var_06["param1"],var_06["param2"],var_06["param3"]);
				break;
		}
	}
}

//Function Number: 48
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

//Function Number: 49
living_ai_prethink()
{
	if(isdefined(self.var_1C98))
	{
		level.deathflags[self.var_1C98] = 1;
	}

	if(isdefined(self.target))
	{
		func_1CDF();
	}
}

//Function Number: 50
func_1CDF()
{
	var_00 = func_1D32();
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

//Function Number: 51
func_1CE0()
{
	self.usechokepoints = 0;
	if(isdefined(self.script_followmin))
	{
		self.followmin = self.script_followmin;
	}

	if(isdefined(self.script_followmax))
	{
		self.followmax = self.script_followmax;
	}
}

//Function Number: 52
func_1CE3()
{
	if(isdefined(level.xp_enable) && level.xp_enable)
	{
		thread maps\_rank::ai_xp_init();
	}

	if(self.type == "human")
	{
		thread func_1CC6();
	}

	maps\_utility::add_damage_function(::maps\_gameskill::auto_adjust_enemy_death_detection);
	if(isdefined(self.script_combatmode))
	{
		self.combatmode = self.script_combatmode;
	}
}

//Function Number: 53
spawn_team_team3()
{
	func_1CE3();
}

//Function Number: 54
spawn_team_neutral()
{
}

//Function Number: 55
subclass_elite()
{
	self endon("death");
	self.var_1CE9 = 1;
	self.var_C8E = 0.5;
	if(!isdefined(self.var_1CEA))
	{
		self.baseaccuracy = 5;
	}

	self.aggressivemode = 1;
	if(maps\_utility::func_1CEB())
	{
		var_00 = undefined;
		switch(level.gameskill)
		{
			case 0:
				var_00 = 0;
				break;

			case 1:
				var_00 = 2;
				break;

			case 2:
				var_00 = 3;
				break;

			case 3:
				var_00 = 4;
				break;
		}

		if(level.gameskill > 0)
		{
			self.grenadeweapon = "flash_grenade";
			self.grenadeammo = var_00;
		}
	}
}

//Function Number: 56
func_1CEC()
{
}

//Function Number: 57
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
		wait 5;
		self.minpaindamage = var_07;
	}
}

//Function Number: 58
func_15CB(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
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

	var_07 = self.var_15CB;
	if(param_00 < self.var_15CB)
	{
		var_07 = param_00;
	}

	self.health = self.health + var_07;
}

//Function Number: 59
func_1CEE()
{
	maps\_gameskill::func_1CEF();
	maps\_gameskill::grenadeawareness();
}

//Function Number: 60
func_1CF0()
{
	if(!isalive(self))
	{
		return;
	}

	if(self.health <= 1)
	{
		return;
	}

	self laserforceon();
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self laserforceoff();
}

//Function Number: 61
func_1CF1()
{
	if(isdefined(self.script_dontshootwhilemoving))
	{
		self.dontshootwhilemoving = 1;
	}

	if(isdefined(self.var_1C98))
	{
		thread ai_deathflag();
	}

	if(isdefined(self.script_attackeraccuracy))
	{
		self.attackeraccuracy = self.script_attackeraccuracy;
	}

	if(isdefined(self.script_startrunning))
	{
		thread func_1DEE();
	}

	if(isdefined(self.var_1CF5))
	{
		thread deathtime();
	}

	if(isdefined(self.script_nosurprise))
	{
		maps\_utility::disable_surprise();
	}

	if(isdefined(self.script_nobloodpool))
	{
		self.var_AB6 = 1;
	}

	if(isdefined(self.var_1CF8))
	{
		thread func_1CF0();
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
		self.maxfaceenemydist = 512;
	}

	if(isdefined(self.script_forcecolor))
	{
		maps\_utility::set_force_color(self.script_forcecolor);
	}

	if(isdefined(self.var_1CFC))
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

	if(isdefined(self.script_goalvolume) && !(isdefined(self.script_moveoverride) && self.script_moveoverride == 1) || isdefined(self.var_1CB0))
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

	if(isdefined(self.var_1CFF))
	{
		maps\_utility::func_95D(self.var_1CFF);
	}

	if(isdefined(self.var_1CEA))
	{
		self.baseaccuracy = self.var_1CEA;
	}

	if(isdefined(self.var_1D00))
	{
		self.ignoreme = 1;
	}

	if(isdefined(self.var_1D01))
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

	if(isdefined(self.var_1D05))
	{
		self.pathenemyfightdist = self.var_1D05;
	}

	if(isdefined(self.script_maxdist))
	{
		self.pathenemylookahead = self.script_maxdist;
	}

	if(isdefined(self.script_longdeath))
	{
		self.a.disablelongdeath = 1;
	}

	if(isdefined(self.var_1D08))
	{
		self.diequietly = 1;
	}

	if(isdefined(self.var_1D09))
	{
		self.grenadeweapon = "flash_grenade";
		self.grenadeammo = self.var_1D09;
	}

	if(isdefined(self.script_pacifist))
	{
		self.pacifist = 1;
	}

	if(isdefined(self.var_1D0B))
	{
		self.health = self.var_1D0B;
	}

	if(isdefined(self.script_nodrop))
	{
		self.var_1CC7 = self.script_nodrop;
	}
}

//Function Number: 62
func_1D0D(param_00)
{
	thread ai_damage_think();
	thread func_1D6B();
	thread func_1DD7();
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
	func_1D19();
	func_1CEE();
	func_1CF1();
	[[ level.team_specific_spawn_functions[self.team] ]]();
	thread [[ level.var_1C88[self.var_1D0F] ]]();
	thread maps\_damagefeedback::monitordamage();
	common_scripts\_dynamic_world::func_18B9();
	func_1D33();
	if(isdefined(self.script_playerseek))
	{
		self setgoalentity(level.player);
		return;
	}

	if(isdefined(self.var_1CB0))
	{
		if(isdefined(self.var_1D11))
		{
			var_01 = level.var_1D12[self.var_1D11];
			self thread [[ var_01 ]]();
		}
		else
		{
			self thread [[ level.global_callbacks["_spawner_stealth_default"] ]]();
		}
	}

	if(isdefined(self.var_1D13))
	{
		self thread [[ level.global_callbacks["_idle_call_idle_func"] ]]();
		return;
	}

	if(isdefined(self.var_1D14) && !isdefined(self.script_moveoverride))
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
		maps\_utility::func_1D16();
	}

	if(isdefined(self.var_1D17))
	{
		if(!isdefined(self.script_radius))
		{
			self.goalradius = 800;
		}

		self setgoalentity(level.player);
		level thread func_1A96(self);
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

	if(!isdefined(self.var_1CB0))
	{
	}

	set_goal_from_settings();
	if(isdefined(self.target))
	{
		thread func_1D26();
	}
}

//Function Number: 63
func_1D19()
{
	self eqoff();
	maps\_utility::func_1D1A();
	if(isdefined(self.var_1D1B))
	{
		self.grenadeammo = self.var_1D1B;
	}
	else
	{
		self.grenadeammo = 3;
	}

	if(isdefined(self.primaryweapon))
	{
		self.noattackeraccuracymod = animscripts/combat_utility::issniper();
	}

	if(!maps\_utility::is_specialop())
	{
		self.neversprintforvariation = 1;
	}
}

//Function Number: 64
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

	func_1D19();
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
	self.chainfallback = 0;
	self.dontavoidplayer = 0;
	self.drawoncompass = 1;
	self.dropweapon = 1;
	self.goalradius = level.default_goalradius;
	self.goalheight = level.var_1C8C;
	self.ignoresuppression = 0;
	self pushplayer(0);
	if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	maps\_utility::func_1D1E();
	self.maxsightdistsqrd = 67108864;
	self.script_forcegrenade = 0;
	self.walkdist = 16;
	maps\_utility::func_1D1F();
	self.pushable = 1;
	self.script_pushable = 1;
	animscripts/init::func_1C40();
	self.fixednode = self.team == "allies";
}

//Function Number: 65
func_1A96(param_00)
{
	param_00 endon("death");
	while(isalive(param_00))
	{
		if(param_00.goalradius > 200)
		{
			param_00.goalradius = param_00.goalradius - 200;
		}

		wait 6;
	}
}

//Function Number: 66
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

//Function Number: 67
set_goal_volume()
{
	self endon("death");
	waittillframeend;
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
			self setgoalnode(var_04);
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

//Function Number: 68
get_target_ents(param_00)
{
	return getentarray(param_00,"targetname");
}

//Function Number: 69
get_target_nodes(param_00)
{
	return getnodearray(param_00,"targetname");
}

//Function Number: 70
func_0FD7(param_00)
{
	return common_scripts\utility::getstructarray(param_00,"targetname");
}

//Function Number: 71
func_1D23(param_00)
{
	return isdefined(param_00.radius) && param_00.radius != 0;
}

//Function Number: 72
go_to_origin(param_00,param_01)
{
	func_1D26(param_00,"origin",param_01);
}

//Function Number: 73
func_1D25(param_00,param_01)
{
	func_1D26(param_00,"struct",param_01);
}

//Function Number: 74
func_1D26(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.used_an_mg42))
	{
		return;
	}

	var_04 = func_1D32(param_00,param_01);
	if(!isdefined(var_04))
	{
		self notify("reached_path_end");
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = ::empty_arrived_func;
	}

	func_1D29(var_04["destination"],var_04["get_target_func"],var_04["set_goal_func_quits"],param_02,param_03);
}

//Function Number: 75
empty_arrived_func(param_00)
{
}

//Function Number: 76
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

//Function Number: 77
func_1D29(param_00,param_01,param_02,param_03,param_04)
{
	self notify("stop_going_to_node");
	self endon("stop_going_to_node");
	self endon("death");
	for(;;)
	{
		param_00 = get_least_used_from_array(param_00);
		var_05 = param_04;
		if(isdefined(param_00.var_1D2A))
		{
			if(param_00.var_1D2A > 1)
			{
				var_05 = param_00.var_1D2A;
			}

			param_00.var_1D2A = 0;
		}

		if(func_1D23(param_00))
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
			self.goalheight = level.var_1C8C;
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

				maps\_utility::func_FA3("_stealth_override_goalpos");
			}
		}
		else
		{
			self waittill("goal");
		}

		param_00 notify("trigger",self);
		[[ param_03 ]](param_00);
		if(isdefined(param_00.script_flag_set))
		{
			common_scripts\utility::flag_set(param_00.script_flag_set);
		}

		if(isdefined(param_00.script_ent_flag_set))
		{
			maps\_utility::func_FA4(param_00.script_ent_flag_set);
		}

		if(isdefined(param_00.script_flag_clear))
		{
			common_scripts\utility::flag_clear(param_00.script_flag_clear);
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

		param_00 maps\_utility::func_1CB5();
		if(isdefined(param_00.var_1A7F))
		{
			wait param_00.var_1A7F;
		}

		while(isdefined(param_00.var_1D2A))
		{
			param_00.var_1D2A = 0;
			if(go_to_node_wait_for_player(param_00,param_01,var_05))
			{
				param_00.var_1D2A = 1;
				param_00 notify("script_requires_player");
				break;
			}

			wait 0.1;
		}

		if(!isdefined(param_00.target))
		{
			break;
		}

		var_06 = [[ param_01 ]](param_00.target);
		if(!var_06.size)
		{
			break;
		}

		param_00 = var_06;
	}

	self notify("reached_path_end");
	if(isdefined(self.script_forcegoal))
	{
		return;
	}

	if(isdefined(self getgoalvolume()))
	{
		self setgoalvolumeauto(self getgoalvolume());
		return;
	}

	self.goalradius = level.default_goalradius;
}

//Function Number: 78
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

//Function Number: 79
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

//Function Number: 80
go_to_node_set_goal_pos(param_00)
{
	maps\_utility::set_goal_ent(param_00);
	self notify("go_to_node_new_goal");
}

//Function Number: 81
go_to_node_set_goal_node(param_00)
{
	maps\_utility::set_goal_node(param_00);
	self notify("go_to_node_new_goal");
}

//Function Number: 82
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

//Function Number: 83
remove_crawled(param_00)
{
	waittillframeend;
	if(isdefined(param_00))
	{
		param_00.crawled = undefined;
	}
}

//Function Number: 84
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

//Function Number: 85
func_1D32(param_00,param_01)
{
	var_02["entity"] = ::get_target_ents;
	param_00["entity"] = ::go_to_node_set_goal_ent;
	if(!isdefined(param_01))
	{
		param_01 = "node";
	}

	var_04 = [];
	if(isdefined(param_00))
	{
		var_29["destination"] = 0;
	}
	else
	{
		param_01 = getentarray(self.target,"targetname");
		if(param_01.size > 0)
		{
			var_02 = "entity";
		}

		if(var_02 == "node")
		{
			param_01 = getnodearray(self.target,"targetname");
			if(!param_01.size)
			{
				param_01 = common_scripts\utility::getstructarray(self.target,"targetname");
				if(!param_01.size)
				{
					return;
				}

				var_02 = "struct";
			}
		}
	}

	return var_29;
}

//Function Number: 86
func_1D33()
{
	if(isdefined(self.script_goalheight))
	{
		self.goalheight = self.script_goalheight;
		return;
	}

	self.goalheight = level.var_1C8C;
}

//Function Number: 87
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

//Function Number: 88
func_1D36(param_00)
{
	for(;;)
	{
		var_01 = self getturretowner();
		if(!isalive(var_01))
		{
			wait 1.5;
			continue;
		}

		if(!isdefined(var_01.enemy))
		{
			self settargetentity(common_scripts\utility::random(param_00));
			self notify("startfiring");
			self startfiring();
		}

		wait 2 + randomfloat(1);
	}
}

//Function Number: 89
manualtarget(param_00)
{
	for(;;)
	{
		self settargetentity(common_scripts\utility::random(param_00));
		self notify("startfiring");
		self startfiring();
		wait 2 + randomfloat(1);
	}
}

//Function Number: 90
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
			param_00 thread func_1D36(var_02);
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
				param_00 thread maps\_mgturret::func_1D3D(var_02);
			}
		}
	}

	thread maps\_mgturret::mg42_firing(param_00);
	param_00 notify("startfiring");
}

//Function Number: 91
func_1D3F(param_00,param_01)
{
	self endon("death");
	level.var_1D40[param_00] = level.var_1D40[param_00] + self.count;
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

		common_scripts\utility::waitframe();
		if(maps\_utility::func_F77(var_03))
		{
			level notify("fallbacker_died" + param_00);
			level.var_1D40[param_00]--;
			continue;
		}

		var_03 thread func_1D42(param_00,param_01,"is spawner");
	}
}

//Function Number: 92
fallback_ai_think_death(param_00,param_01)
{
	param_00 waittill("death");
	level.var_1D40[param_01]--;
	level notify("fallbacker_died" + param_01);
}

//Function Number: 93
func_1D42(param_00,param_01,param_02)
{
	if(!isdefined(self.var_1D43) || !isdefined(self.var_1D43[param_00]))
	{
		self.var_1D43[param_00] = 1;
	}
	else
	{
		return;
	}

	self.script_fallback = param_00;
	if(!isdefined(param_02))
	{
		level.var_1D40[param_00]++;
	}

	if(isdefined(param_01) && level.fallback_initiated[param_00])
	{
		thread fallback_ai(param_00,param_01);
	}

	level thread fallback_ai_think_death(self,param_00);
}

//Function Number: 94
fallback_death(param_00,param_01)
{
	param_00 waittill("death");
	level notify("fallback_reached_goal" + param_01);
}

//Function Number: 95
fallback_goal()
{
	self waittill("goal");
	self.ignoresuppression = 0;
	self notify("fallback_notify");
	self notify("stop_coverprint");
}

//Function Number: 96
fallback_ai(param_00,param_01)
{
	self notify("stop_going_to_node");
	self stopuseturret();
	self.ignoresuppression = 1;
	self setgoalnode(param_01);
	if(param_01.radius != 0)
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

//Function Number: 97
coverprint(param_00)
{
	self endon("fallback_notify");
	self endon("stop_coverprint");
	common_scripts\utility::waitframe();
}

//Function Number: 98
newfallback_overmind(param_00,param_01)
{
	var_02 = undefined;
	var_03 = getallnodes();
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(isdefined(var_03[var_04].script_fallback) && var_03[var_04].script_fallback == param_00)
		{
			var_02 = common_scripts\utility::add_to_array(var_02,var_03[var_04]);
		}
	}

	if(!isdefined(var_02))
	{
		return;
	}

	level.var_1D40[param_00] = 0;
	level.spawner_fallbackers[param_00] = 0;
	level.fallback_initiated[param_00] = 0;
	var_05 = getspawnerarray();
	for(var_04 = 0;var_04 < var_05.size;var_04++)
	{
		if(isdefined(var_05[var_04].script_fallback) && var_05[var_04].script_fallback == param_00)
		{
			if(var_05[var_04].count > 0)
			{
				var_05[var_04] thread func_1D3F(param_00,var_02[randomint(var_02.size)]);
				level.spawner_fallbackers[param_00]++;
			}
		}
	}

	var_06 = getaiarray();
	for(var_04 = 0;var_04 < var_06.size;var_04++)
	{
		if(isdefined(var_06[var_04].script_fallback) && var_06[var_04].script_fallback == param_00)
		{
			var_06[var_04] thread func_1D42(param_00);
		}
	}

	if(!level.var_1D40[param_00] && !level.spawner_fallbackers[param_00])
	{
		return;
	}

	var_05 = undefined;
	var_06 = undefined;
	thread fallback_wait(param_00,param_01);
	level waittill("fallbacker_trigger" + param_00);
	if(getdvar("fallback","0") == "1")
	{
	}

	level.fallback_initiated[param_00] = 1;
	var_07 = undefined;
	var_06 = getaiarray();
	for(var_04 = 0;var_04 < var_06.size;var_04++)
	{
		if((isdefined(var_06[var_04].script_fallback) && var_06[var_04].script_fallback == param_00) || isdefined(var_06[var_04].var_1D4B) && isdefined(param_01) && var_06[var_04].var_1D4B == param_01)
		{
			var_07 = common_scripts\utility::add_to_array(var_07,var_06[var_04]);
		}
	}

	var_06 = undefined;
	if(!isdefined(var_07))
	{
		return;
	}

	var_08 = var_07.size * 0.4;
	var_08 = int(var_08);
	level notify("fallback initiated " + param_00);
	fallback_text(var_07,0,var_08);
	for(var_04 = 0;var_04 < var_08;var_04++)
	{
		var_07[var_04] thread fallback_ai(param_00,var_02[randomint(var_02.size)]);
	}

	for(var_04 = 0;var_04 < var_08;var_04++)
	{
		level waittill("fallback_reached_goal" + param_00);
	}

	fallback_text(var_07,var_08,var_07.size);
	for(var_04 = var_08;var_04 < var_07.size;var_04++)
	{
		if(isalive(var_07[var_04]))
		{
			var_07[var_04] thread fallback_ai(param_00,var_02[randomint(var_02.size)]);
		}
	}
}

//Function Number: 99
fallback_text(param_00,param_01,param_02)
{
	if(gettime() <= level.var_1C7F)
	{
		return;
	}

	var_03 = param_01;
	while(var_03 < param_02)
	{
		if(!isalive(param_00[var_03]))
		{
			continue;
		}

		level.var_1C7F = gettime() + 2500 + randomint(2000);
		var_04 = param_00.size;
		var_05 = int(var_04 * 0.4);
		if(randomint(100) > 50)
		{
			if(var_04 - var_05 > 1)
			{
				if(randomint(100) > 66)
				{
					var_06 = "dawnville_defensive_german_1";
				}
				else if(randomint(100) > 66)
				{
					var_06 = "dawnville_defensive_german_2";
				}
				else
				{
					var_06 = "dawnville_defensive_german_3";
				}
			}
			else if(randomint(100) > 66)
			{
				var_06 = "dawnville_defensive_german_4";
			}
			else if(randomint(100) > 66)
			{
				var_06 = "dawnville_defensive_german_5";
			}
			else
			{
				var_06 = "dawnville_defensive_german_1";
			}
		}
		else if(var_06 > 1)
		{
			if(randomint(100) > 66)
			{
				var_06 = "dawnville_defensive_german_2";
			}
			else if(randomint(100) > 66)
			{
				var_06 = "dawnville_defensive_german_3";
			}
			else
			{
				var_06 = "dawnville_defensive_german_4";
			}
		}
		else if(randomint(100) > 66)
		{
			var_06 = "dawnville_defensive_german_5";
		}
		else if(randomint(100) > 66)
		{
			var_06 = "dawnville_defensive_german_1";
		}
		else
		{
			var_06 = "dawnville_defensive_german_2";
		}

		param_00[var_03] animscripts/face::sayspecificdialogue(undefined,var_06,1);
		return;
		var_06++;
	}
}

//Function Number: 100
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
		if((isdefined(var_03[var_02].script_fallback) && var_03[var_02].script_fallback == param_00) || isdefined(var_03[var_02].var_1D4B) && isdefined(param_01) && var_03[var_02].var_1D4B == param_01)
		{
			var_03[var_02] thread func_1D42(param_00);
		}
	}

	var_03 = undefined;
	var_04 = level.var_1D40[param_00];
	for(var_05 = 0;level.var_1D40[param_00] > var_04 * 0.5;var_05++)
	{
		if(getdvar("fallback","0") == "1")
		{
		}

		level waittill("fallbacker_died" + param_00);
	}

	level notify("fallbacker_trigger" + param_00);
}

//Function Number: 101
fallback_think(param_00)
{
	if(!isdefined(level.var_1D43) || !isdefined(level.var_1D43[param_00.script_fallback]))
	{
		level thread newfallback_overmind(param_00.script_fallback,param_00.var_1D4B);
	}

	param_00 waittill("trigger");
	level notify("fallbacker_trigger" + param_00.script_fallback);
	func_1CBC(param_00);
}

//Function Number: 102
func_1D4E(param_00)
{
	self waittill("goal");
	if(param_00.radius != 0)
	{
		self.goalradius = param_00.radius;
		return;
	}

	self.goalradius = level.default_goalradius;
}

//Function Number: 103
fallback_coverprint()
{
	self endon("fallback");
	self endon("fallback_clear_goal");
	self endon("fallback_clear_death");
	for(;;)
	{
		if(isdefined(self.var_1D50))
		{
		}

		common_scripts\utility::waitframe();
	}
}

//Function Number: 104
func_1D51()
{
	self endon("fallback_clear_goal");
	self endon("fallback_clear_death");
	for(;;)
	{
		if(isdefined(self.var_1D50))
		{
		}

		common_scripts\utility::waitframe();
	}
}

//Function Number: 105
func_1D43()
{
	var_00 = getnode(self.target,"targetname");
	self.var_1D50 = var_00;
	self setgoalnode(var_00);
	if(isdefined(self.var_1D52))
	{
		thread func_1D4E(var_00);
	}
	else if(var_00.radius != 0)
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
			thread func_1D51();
		}

		if(isdefined(var_00.target))
		{
			var_00 = getnode(var_00.target,"targetname");
			self.var_1D50 = var_00;
			self setgoalnode(var_00);
			thread fallback_goal();
			if(var_00.radius != 0)
			{
				self.goalradius = var_00.radius;
			}

			continue;
		}

		level notify("fallback_arrived" + self.script_fallback);
	}
}

//Function Number: 106
delete_me()
{
	common_scripts\utility::waitframe();
	self delete();
}

//Function Number: 107
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

//Function Number: 108
specialcheck(param_00)
{
	wait 0.05;
}

//Function Number: 109
friendly_wave(param_00)
{
	if(!isdefined(level.var_1D56))
	{
		thread func_1D5B();
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

		wait 1;
	}
}

//Function Number: 110
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

//Function Number: 111
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

//Function Number: 112
func_1D5B()
{
	level.var_1D56 = 1;
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
				var_06 = isdefined(var_03[var_04].var_1CB0) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
				if(isdefined(var_03[var_04].script_forcespawn))
				{
					var_07 = var_03[var_04] stalingradspawn(var_06);
				}
				else
				{
					var_07 = var_03[var_04] dospawn(var_06);
				}

				var_03[var_04] maps\_utility::set_count(0);
				if(maps\_utility::func_F77(var_07))
				{
					wait 0.2;
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
						wait level.friendly_wave_trigger.script_delay;
					}

					var_04++;
					continue;
				}

				wait randomfloat(5);
			}
		}

		level waittill("friendly_died");
	}
}

//Function Number: 113
func_1A44(param_00)
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

		if(var_04 thread func_1D62(var_02,var_01))
		{
			var_04 thread func_1D68(var_02,var_01);
			var_02 waittill("friendly_finished_using_mg42");
			if(isalive(var_04))
			{
				var_04.turret_use_time = gettime() + 10000;
			}
		}

		wait 1;
	}
}

//Function Number: 114
friendly_mg42_death_notify(param_00,param_01)
{
	param_01 endon("friendly_finished_using_mg42");
	param_00 waittill("death");
	param_01 notify("friendly_finished_using_mg42");
}

//Function Number: 115
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

//Function Number: 116
func_1D62(param_00,param_01)
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

	if(isdefined(self.chainnode))
	{
		if(distance(level.player.origin,self.chainnode.origin) > 1100)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 117
func_1D63(param_00,param_01)
{
	param_00 endon("friendly_finished_using_mg42");
	self waittill("trigger");
	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 118
func_1D64()
{
	if(!isdefined(self.friendly_mg42))
	{
		return;
	}

	self.friendly_mg42 notify("friendly_finished_using_mg42");
}

//Function Number: 119
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

//Function Number: 120
func_1D68(param_00,param_01)
{
	self endon("death");
	param_00 endon("friendly_finished_using_mg42");
	level thread friendly_mg42_death_notify(self,param_00);
	self.oldradius = self.goalradius;
	self.goalradius = 28;
	thread nofour();
	self setgoalnode(param_01);
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
	thread func_1D69(param_00);
	self useturret(param_00);
	if(isdefined(param_00.target))
	{
		var_02 = getent(param_00.target,"targetname");
		if(isdefined(var_02))
		{
			var_02 thread func_1D63(param_00,self);
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

		if(isdefined(self.chainnode))
		{
			if(distance(self.origin,self.chainnode.origin) > 1100)
			{
				break;
			}
		}

		wait 1;
	}

	param_00 notify("friendly_finished_using_mg42");
}

//Function Number: 121
func_1D69(param_00)
{
	self endon("death");
	param_00 waittill("friendly_finished_using_mg42");
	friendly_mg42_doneusingturret();
}

//Function Number: 122
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
	self setgoalnode(var_01);
	wait 2;
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
			self setgoalnode(var_01);
		}
	}

	self.goalradius = var_02;
}

//Function Number: 123
func_1D6B()
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

//Function Number: 124
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

	if(param_01 maps\_vehicle::func_1D6F())
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

//Function Number: 125
func_1D70(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_00.var_1D71 = param_01;
	if(isdefined(param_01.script_delay))
	{
		param_00.var_1D72 = param_01.script_delay;
	}

	if(isdefined(param_03) && isdefined(param_04))
	{
		param_00.var_1D73 = param_03;
		param_00.panzer_ent_offset = param_04;
	}
	else
	{
		param_00.panzer_pos = param_02;
	}

	param_00 setgoalpos(param_00.origin);
	param_00 setgoalnode(param_01);
	param_00.goalradius = 12;
	param_00 waittill("goal");
	param_00.goalradius = 28;
	param_00 waittill("shot_at_target");
	param_00.var_1D73 = undefined;
	param_00.panzer_pos = undefined;
	param_00.var_1D72 = undefined;
}

//Function Number: 126
showstart(param_00,param_01,param_02)
{
	var_03 = getstartorigin(param_00,param_01,param_02);
	wait 0.05;
}

//Function Number: 127
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

	if(maps\_utility::func_F77(var_00))
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

	var_00.var_1D78 = 1;
}

//Function Number: 128
waittilldeathorleavesquad()
{
	self endon("death");
	self waittill("leaveSquad");
}

//Function Number: 129
friendlyspawnwave()
{
	common_scripts\utility::array_thread(getentarray(self.target,"targetname"),::friendlyspawnwave_triggerthink,self);
	for(;;)
	{
		self waittill("trigger",var_02);
		if(activefriendlyspawn() && getfriendlyspawntrigger() == self)
		{
			func_1DA2();
		}

		self waittill("friendly_wave_start",var_03);
		func_1DA6(var_03,self);
		if(!isdefined(var_03.target))
		{
			continue;
		}

		var_04 = getent(var_03.target,"targetname");
		var_04 thread func_1DA8(self);
	}
}

//Function Number: 130
func_1A3A(param_00)
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
	common_scripts\utility::array_thread(var_01,::func_1D7F,param_00);
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
				func_1CBD(var_01[0].script_randomspawn);
			}
		}

		var_01 = getentarray(self.target,"targetname");
		for(var_05 = 0;var_05 < var_01.size;var_05++)
		{
			var_01[var_05].var_1D7D = var_02;
			var_01[var_05] notify("flood_begin");
		}

		if(var_02)
		{
			wait 5;
			continue;
		}

		wait 0.1;
	}
}

//Function Number: 131
func_1D7E(param_00)
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

//Function Number: 132
func_1D7F(param_00)
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
		var_04[var_05] thread func_1D7F(param_00);
		var_04[var_05].var_1D7D = 1;
		var_04[var_05] notify("flood_begin");
	}
}

//Function Number: 133
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
		if(self.var_1D7D)
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
		self.var_1577 = var_03;
		maps\_utility::set_count(2);
		wait var_04;
		var_06 = isdefined(self.var_1CB0) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
		if(isdefined(self.script_forcespawn))
		{
			var_07 = self stalingradspawn(var_06);
		}
		else
		{
			var_07 = self dospawn(var_06);
		}

		if(maps\_utility::func_F77(var_07))
		{
			var_08 = 0;
			if(var_04 < 2)
			{
				wait 2;
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
			if(isdefined(self.var_1CEA))
			{
				var_07.baseaccuracy = self.var_1CEA;
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
			func_1D88();
		}
	}

	self delete();
}

//Function Number: 134
func_1D83(param_00)
{
	self endon("death");
	param_00 waittill("death");
}

//Function Number: 135
addtowavespawner(param_00)
{
	var_01 = self.targetname;
	if(!isdefined(level.spawnerwave[var_01]))
	{
		level.spawnerwave[var_01] = spawnstruct();
		level.spawnerwave[var_01] maps\_utility::set_count(0);
		level.spawnerwave[var_01].var_1D85 = 0;
	}

	if(!isdefined(self.addedtowave))
	{
		self.addedtowave = 1;
		level.spawnerwave[var_01].var_1D85++;
	}

	level.spawnerwave[var_01].count++;
	func_1D83(param_00);
	level.spawnerwave[var_01].count--;
	if(!isdefined(self))
	{
		level.spawnerwave[var_01].var_1D85--;
	}

	if(level.spawnerwave[var_01].var_1D85)
	{
		if(level.spawnerwave[var_01].count / level.spawnerwave[var_01].var_1D85 < 0.32)
		{
			level.spawnerwave[var_01] notify("waveReady");
		}
	}
}

//Function Number: 136
func_1D87(param_00)
{
	self endon("debug_stop");
	self endon("death");
	wait 0.05;
}

//Function Number: 137
func_1D88()
{
	var_00 = self.targetname;
	if(level.spawnerwave[var_00].count)
	{
		level.spawnerwave[var_00] waittill("waveReady");
	}
}

//Function Number: 138
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

//Function Number: 139
waittillrestartordistance(param_00)
{
	self endon("flood_begin");
	param_00 = param_00 * 0.75;
	while(distance(level.player.origin,self.origin) > param_00)
	{
		wait 1;
	}
}

//Function Number: 140
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

//Function Number: 141
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
		self setgoalnode(var_00);
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

		self setgoalnode(var_00);
		if(var_00.radius)
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
			self setgoalnode(var_00);
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
				thread func_1D8F();
			}
		}

		if(self.script_noteworthy == "hide")
		{
			thread maps\_utility::func_95D(0);
			return;
		}
	}

	if(!isdefined(self.script_forcegoal) && !isdefined(self getgoalvolume()))
	{
		self.goalradius = level.default_goalradius;
	}
}

//Function Number: 142
func_1D8F()
{
	var_00 = getent(self.target,"targetname").origin;
	common_scripts\utility::play_sound_in_space("furniture_slide",var_00);
	wait 0.9;
	if(isdefined(level.whisper))
	{
		common_scripts\utility::play_sound_in_space(common_scripts\utility::random(level.whisper),var_00);
	}
}

//Function Number: 143
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
				wait 0.5;
				continue;
			}

			if(!objectiveisallowed())
			{
				wait 0.5;
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
			wait 0.05;
		}

		if(!objectiveisallowed())
		{
			wait 0.05;
			continue;
		}

		if(isdefined(level.lastfriendlytrigger) && level.lastfriendlytrigger == self)
		{
			continue;
		}

		level notify("new_friendly_trigger");
		level.lastfriendlytrigger = self;
		common_scripts\utility::array_thread(var_00,::func_1D99);
		wait 0.5;
	}
}

//Function Number: 144
objectiveisallowed()
{
	var_00 = 1;
	if(isdefined(self.var_1D95))
	{
		var_00 = 0;
		for(var_01 = 0;var_01 < level.active_objective.size;var_01++)
		{
			if(!issubstr(self.var_1D95,level.active_objective[var_01]))
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

	if(!isdefined(self.var_1D97))
	{
		return var_00;
	}

	var_02 = 0;
	for(var_01 = 0;var_01 < level.inactive_objective.size;var_01++)
	{
		if(!issubstr(self.var_1D97,level.inactive_objective[var_01]))
		{
			continue;
		}

		var_02++;
	}

	var_03 = strtok(self.var_1D97," ");
	return var_02 == var_03.size;
}

//Function Number: 145
func_1D99(param_00)
{
	level endon("new_friendly_trigger");
	self waittill("trigger");
	param_00 = getnode(self.target,"targetname");
	var_01 = !isdefined(self.script_baseoffire) || self.script_baseoffire == 0;
	setnewplayerchain(param_00,var_01);
}

//Function Number: 146
func_1D9A()
{
	self endon("death");
	var_00 = self.script_deathchain;
	while(self.count)
	{
		self waittill("spawned",var_01);
		var_01 thread deathchainainotify(var_00);
	}
}

//Function Number: 147
deathchainainotify(param_00)
{
	level.deathspawner[param_00]++;
	self waittill("death");
	level.deathspawner[param_00]--;
	level notify("spawner_expired" + param_00);
}

//Function Number: 148
deathchainspawnerlogic()
{
	var_00 = self.script_deathchain;
	level.deathspawner[var_00]++;
	var_01 = self.origin;
	func_1D9A();
	level notify("spawner dot" + var_01);
	level.deathspawner[var_00]--;
	level notify("spawner_expired" + var_00);
}

//Function Number: 149
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

//Function Number: 150
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
		wait 5;
	}
}

//Function Number: 151
setnewplayerchain(param_00,param_01)
{
	level.player maps\_utility::set_friendly_chain_wrapper(param_00);
	level notify("new_escort_trigger");
	level notify("new_escort_debug");
	level notify("start_chain",param_01);
}

//Function Number: 152
func_1A37()
{
	level.friendlyspawnorg = [];
	level.friendlyspawntrigger = [];
	common_scripts\utility::array_thread(getentarray("friendlychain","targetname"),::friendlychain);
}

//Function Number: 153
func_1DA2()
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

//Function Number: 154
getfriendlyspawnstart()
{
	return level.friendlyspawnorg[level.friendlyspawnorg.size - 1];
}

//Function Number: 155
activefriendlyspawn()
{
	return level.friendlyspawnorg.size > 0;
}

//Function Number: 156
getfriendlyspawntrigger()
{
	return level.friendlyspawntrigger[level.friendlyspawntrigger.size - 1];
}

//Function Number: 157
func_1DA6(param_00,param_01)
{
	level.friendlyspawnorg[level.friendlyspawnorg.size] = param_00.origin;
	level.friendlyspawntrigger[level.friendlyspawntrigger.size] = param_01;
	common_scripts\utility::flag_set("spawning_friendlies");
}

//Function Number: 158
func_1DA7()
{
	self endon("death");
	self endon("leaveSquad");
	wait 0.5;
	self setgoalentity(level.player);
}

//Function Number: 159
func_1DA8(param_00)
{
	self notify("stopTrigger");
	self endon("stopTrigger");
	self waittill("trigger");
	if(getfriendlyspawntrigger() != param_00)
	{
		return;
	}

	func_1DA2();
}

//Function Number: 160
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

//Function Number: 161
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

//Function Number: 162
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
		wait 0.05;
	}
}

//Function Number: 163
aigroup_create(param_00)
{
	level.var_1C80[param_00] = spawnstruct();
	level.var_1C80[param_00].aicount = 0;
	level.var_1C80[param_00].var_1DAE = 0;
	level.var_1C80[param_00].ai = [];
	level.var_1C80[param_00].spawners = [];
}

//Function Number: 164
aigroup_spawnerthink(param_00)
{
	self endon("death");
	self.decremented = 0;
	param_00.var_1DAE++;
	thread func_1DB2(param_00);
	thread func_1DB3(param_00);
	while(self.count)
	{
		self waittill("spawned",var_01);
		if(maps\_utility::func_F77(var_01))
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
	param_00.var_1DAE--;
}

//Function Number: 165
func_1DB2(param_00)
{
	self waittill("death");
	if(self.decremented)
	{
		return;
	}

	param_00.var_1DAE--;
}

//Function Number: 166
func_1DB3(param_00)
{
	self endon("death");
	self waittill("emptied spawner");
	waittillframeend;
	if(self.decremented)
	{
		return;
	}

	self.decremented = 1;
	param_00.var_1DAE--;
}

//Function Number: 167
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

//Function Number: 168
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
	var_03 = maps\_utility::array_randomize(var_03);
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

//Function Number: 169
camper_guy()
{
	self.goalradius = 8;
	self.fixednode = 1;
}

//Function Number: 170
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
					wait 1;
				}

				return;
			}
		}

		if(var_01)
		{
			if(self cansee(self.enemy))
			{
				wait 0.05;
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

			wait 0.05;
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

//Function Number: 171
claim_a_node(param_00,param_01)
{
	self setgoalnode(param_00);
	self.claimed_node = param_00;
	param_00.claimed = 1;
	if(isdefined(param_01))
	{
		param_01.claimed = 0;
	}
}

//Function Number: 172
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

//Function Number: 173
flood_trigger_think(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	common_scripts\utility::array_thread(var_01,::flood_spawner_init);
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	common_scripts\utility::array_thread(var_01,::func_1DBF,param_00);
}

//Function Number: 174
flood_spawner_init(param_00)
{
}

//Function Number: 175
trigger_requires_player(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return isdefined(param_00.var_1D2A);
}

//Function Number: 176
two_stage_spawner_think(param_00)
{
	var_01 = getent(param_00.target,"targetname");
	waittillframeend;
	var_02 = getentarray(var_01.target,"targetname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03].script_moveoverride = 1;
		var_02[var_03] maps\_utility::add_spawn_function(::func_1DBE,var_01);
	}

	param_00 waittill("trigger");
	var_02 = getentarray(var_01.target,"targetname");
	common_scripts\utility::array_thread(var_02,::maps\_utility::spawn_ai);
}

//Function Number: 177
func_1DBE(param_00)
{
	param_00 endon("death");
	self endon("death");
	self.goalradius = 8;
	param_00 waittill("trigger");
	thread func_1D26();
}

//Function Number: 178
func_1DBF(param_00)
{
	self endon("death");
	self notify("stop current floodspawner");
	self endon("stop current floodspawner");
	if(func_1DC2())
	{
		pyramid_spawn(param_00);
		return;
	}

	var_01 = trigger_requires_player(param_00);
	maps\_utility::script_delay();
	while(self.count > 0)
	{
		while(var_01 && !level.player istouching(param_00))
		{
			wait 0.5;
		}

		var_02 = isdefined(self.var_1CB0) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
		if(isdefined(self.script_forcespawn))
		{
			var_03 = self stalingradspawn(var_02);
		}
		else
		{
			var_03 = self dospawn(var_02);
		}

		if(maps\_utility::func_F77(var_03))
		{
			wait 2;
			continue;
		}

		if(isdefined(self.script_combatbehavior))
		{
			if(self.script_combatbehavior == "heat")
			{
				var_03 maps\_utility::enable_heat_behavior();
			}

			if(self.script_combatbehavior == "cqb")
			{
				var_03 maps\_utility::enable_cqbwalk();
			}
		}

		var_03 thread reincrement_count_if_deleted(self);
		var_03 thread expand_goalradius(param_00);
		var_03 waittill("death",var_04);
		if(!player_saw_kill(var_03,var_04))
		{
			self.count++;
		}
		else if(isdefined(level.var_1DC0))
		{
			if(isdefined(level.ac130gunner) && var_04 == level.ac130gunner)
			{
				if(randomint(2) == 0)
				{
					self.count++;
				}
			}
		}

		if(!isdefined(var_03))
		{
			continue;
		}

		if(!maps\_utility::func_1CB5())
		{
			wait randomfloatrange(5,9);
		}
	}
}

//Function Number: 179
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

//Function Number: 180
func_1DC2()
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

//Function Number: 181
pyramid_death_report(param_00)
{
	param_00.spawn waittill("death");
	self notify("death_report");
}

//Function Number: 182
pyramid_spawn(param_00)
{
	self endon("death");
	var_01 = trigger_requires_player(param_00);
	maps\_utility::script_delay();
	if(var_01)
	{
		while(!level.player istouching(param_00))
		{
			wait 0.5;
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
		var_05 maps\_utility::set_count(1);
		var_06 = var_05 maps\_utility::spawn_ai();
		if(maps\_utility::func_F77(var_06))
		{
			wait 2;
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
		maps\_utility::func_1CB5();
		wait var_07;
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
			if(maps\_utility::func_F77(var_06))
			{
				wait 2;
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

//Function Number: 183
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

//Function Number: 184
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

//Function Number: 185
drop_health_timeout_thread()
{
	self endon("death");
	wait 95;
	self notify("timeout");
}

//Function Number: 186
func_1DC9()
{
	self endon("timeout");
	thread drop_health_timeout_thread();
	self waittill("trigger");
	maps\_utility::func_1DCA(1);
}

//Function Number: 187
traceshow(param_00)
{
	wait 0.05;
}

//Function Number: 188
show_bad_path()
{
}

//Function Number: 189
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
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::func_1DCD);
	common_scripts\utility::array_thread(var_01,::maps\_utility::spawn_ai);
}

//Function Number: 190
func_1DCD()
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

//Function Number: 191
objective_event_init(param_00)
{
	var_01 = param_00 maps\_utility::func_F89();
	common_scripts\utility::flag_init(var_01);
	while(level.deathspawner[param_00.script_deathchain] > 0)
	{
		level waittill("spawner_expired" + param_00.script_deathchain);
	}

	common_scripts\utility::flag_set(var_01);
}

//Function Number: 192
func_1DCE()
{
	self endon("death");
	waittillframeend;
	self.is_the_player = isplayer(self);
	self.eq_table = [];
	self.eq_touching = [];
	for(var_00 = 0;var_00 < level.var_1DD0;var_00++)
	{
		self.eq_table[var_00] = 0;
	}
}

//Function Number: 193
ai_array()
{
	level.ai_array[level.unique_id] = self;
	self waittill("death");
	waittillframeend;
	level.ai_array[level.unique_id] = undefined;
}

//Function Number: 194
func_16E7(param_00)
{
	var_01 = param_00 spawndrone();
	var_01 useanimtree(#animtree);
	if(var_01.weapon != "one")
	{
		var_02 = getweaponmodel(var_01.weapon);
		var_01 attach(var_02,"tag_weapon_right");
		var_03 = getweaponhidetags(var_01.weapon);
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_01 hidepart(var_03[var_04],var_02);
		}
	}

	var_01.spawner = param_00;
	var_01.drone_delete_on_unload = isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "drone_delete_on_unload";
	param_00 notify("drone_spawned",var_01);
	return var_01;
}

//Function Number: 195
spawner_makerealai(param_00)
{
	if(!isdefined(param_00.spawner))
	{
	}

	var_01 = param_00.spawner.origin;
	var_02 = param_00.spawner.angles;
	param_00.spawner.origin = param_00.origin;
	param_00.spawner.angles = param_00.angles;
	var_03 = param_00.spawner stalingradspawn();
	var_04 = maps\_utility::func_F77(var_03);
	if(var_04)
	{
	}

	var_03.vehicle_idling = param_00.vehicle_idling;
	var_03.var_1DD4 = param_00.var_1DD4;
	var_03.var_1DD5 = param_00.var_1DD5;
	var_03.var_1DD6 = param_00.var_1DD6;
	param_00.spawner.origin = var_01;
	param_00.spawner.angles = var_02;
	param_00 delete();
	return var_03;
}

//Function Number: 196
func_1DD7()
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

	thread achieve_strike(var_00,var_01,var_02);
	thread achieve_jack_the_ripper(var_00,var_01,var_02);
	thread func_80D7(var_00,var_01,var_02);
	if(isdefined(self.var_1CD9))
	{
		var_01 = self.var_1CD9;
	}
}

//Function Number: 197
achieve_strike(param_00,param_01,param_02)
{
	if(param_01 != "MOD_GRENADE_SPLASH")
	{
		param_00.achieve_strike = undefined;
		return;
	}

	if(!isdefined(param_02))
	{
		param_00.achieve_strike = undefined;
		return;
	}

	if(weaponinventorytype(param_02) != "offhand")
	{
		param_00.achieve_strike = undefined;
		return;
	}

	if(!isdefined(param_00.achieve_strike))
	{
		param_00.achieve_strike = 1;
	}
	else
	{
		param_00.achieve_strike++;
	}

	if(param_00.achieve_strike == 5)
	{
		param_00 maps\_utility::player_giveachievement_wrapper("STRIKE");
	}

	waittillframeend;
	param_00.achieve_strike = undefined;
}

//Function Number: 198
achieve_jack_the_ripper(param_00,param_01,param_02)
{
	if(param_01 == "MOD_MELEE")
	{
		if(!isdefined(param_00.achieve_jack_the_ripper))
		{
			param_00.achieve_jack_the_ripper = 1;
		}
		else
		{
			param_00.achieve_jack_the_ripper++;
		}

		if(param_00.achieve_jack_the_ripper == 5)
		{
			param_00 maps\_utility::player_giveachievement_wrapper("JACK_THE_RIPPER");
			return;
		}

		return;
	}

	param_00.achieve_jack_the_ripper = undefined;
}

//Function Number: 199
func_80D7(param_00,param_01,param_02)
{
	if(isdefined(self.juggernaut) && self.juggernaut && param_01 == "MOD_MELEE" && !isdefined(param_02) || !issubstr(param_02,"riotshield") && !issubstr(param_02,"riot_shield"))
	{
		param_00 maps\_utility::player_giveachievement_wrapper("SERRATED_EDGE");
	}
}

//Function Number: 200
func_1DD8(param_00)
{
}

//Function Number: 201
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

	level.killspawn_groups[var_00][var_01][self.var_1DEB] = self;
}

//Function Number: 202
func_1DEC()
{
	var_00 = self.var_1B33;
	var_01 = self.var_1DED;
	if(!isdefined(level.spawn_groups[var_00]))
	{
		level.spawn_groups[var_00] = [];
	}

	if(!isdefined(level.spawn_groups[var_00][var_01]))
	{
		level.spawn_groups[var_00][var_01] = [];
	}

	level.spawn_groups[var_00][var_01][self.var_1DEB] = self;
}

//Function Number: 203
func_1DEE()
{
	self endon("death");
	self.disableexits = 1;
	wait 3;
	self.disableexits = 0;
}

//Function Number: 204
deathtime()
{
	self endon("death");
	wait self.var_1CF5;
	wait randomfloat(10);
	self kill();
}