/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _vehicle_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 209
 * Decompile Time: 3254 ms
 * Timestamp: 4/22/2024 2:24:43 AM
*******************************************************************/

//Function Number: 1
setup_script_gatetrigger(param_00)
{
	var_01 = [];
	if(isdefined(param_00.script_gatetrigger))
	{
		return level.vehicle_gatetrigger[param_00.script_gatetrigger];
	}

	return var_01;
}

//Function Number: 2
setup_vehicle_spawners()
{
	var_00 = _getvehiclespawnerarray();
	foreach(var_02 in var_00)
	{
		var_02 thread vehicle_spawn_think();
	}
}

//Function Number: 3
vehicle_spawn_think()
{
	self endon("entitydeleted");
	if(isdefined(self.script_kill_vehicle_spawner))
	{
		var_00 = self.script_kill_vehicle_spawner;
		if(!isdefined(level.vehicle_killspawn_groups[var_00]))
		{
			level.vehicle_killspawn_groups[var_00] = [];
		}

		level.vehicle_killspawn_groups[var_00][level.vehicle_killspawn_groups[var_00].size] = self;
	}

	if(isdefined(self.script_deathflag))
	{
		thread maps\_spawner::vehicle_spawner_deathflag();
	}

	thread vehicle_linked_entities_think();
	self.count = 1;
	self.spawn_functions = [];
	for(;;)
	{
		var_01 = undefined;
		self waittill("spawned",var_01);
		self.count--;
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01.spawn_funcs = self.spawn_functions;
		var_01.spawner = self;
		var_01 thread maps\_spawner::run_spawn_functions();
	}
}

//Function Number: 4
vehicle_linked_entities_think()
{
	if(!isdefined(self.script_vehiclecargo))
	{
		return;
	}

	if(!isdefined(self.script_linkto))
	{
		return;
	}

	var_00 = getentarray(self.script_linkto,"script_linkname");
	if(var_00.size == 0)
	{
		return;
	}

	var_01 = var_00[0].targetname;
	var_00 = getentarray(var_01,"targetname");
	var_02 = undefined;
	foreach(var_04 in var_00)
	{
		if(var_04.classname == "script_origin")
		{
			var_02 = var_04;
		}

		var_04 hide();
	}

	foreach(var_04 in var_00)
	{
		if(var_04 != var_02)
		{
			var_04 linkto(var_02);
		}
	}

	self waittill("spawned",var_08);
	foreach(var_04 in var_00)
	{
		var_04 show();
		if(var_04 != var_02)
		{
			var_04 linkto(var_08);
		}
	}

	var_08 waittill("death");
	common_scripts\utility::array_call(var_00,::delete);
}

//Function Number: 5
is_trigger_once()
{
	if(!isdefined(self.classname))
	{
		return 0;
	}

	if(self.classname == "trigger_multiple")
	{
		return 1;
	}

	if(self.classname == "trigger_radius")
	{
		return 1;
	}

	if(self.classname == "trigger_lookat")
	{
		return 1;
	}

	return self.classname == "trigger_disk";
}

//Function Number: 6
trigger_process(param_00)
{
	var_01 = param_00 is_trigger_once();
	param_00.processed_trigger = undefined;
	if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "trigger_multiple")
	{
		var_01 = 0;
	}

	var_02 = setup_script_gatetrigger(param_00);
	var_03 = isdefined(param_00.script_vehiclespawngroup);
	var_04 = isdefined(param_00.script_vehicledetour) && is_node_script_origin(param_00) || is_node_script_struct(param_00);
	var_05 = isdefined(param_00.detoured) && !is_node_script_origin(param_00) || is_node_script_struct(param_00);
	var_06 = 1;
	while(var_06)
	{
		param_00 waittill("trigger",var_07);
		if(isdefined(param_00.script_vehicletriggergroup))
		{
			if(!isdefined(var_07.script_vehicletriggergroup))
			{
				continue;
			}

			if(var_07.script_vehicletriggergroup != param_00.script_vehicletriggergroup)
			{
				continue;
			}
		}

		if(isdefined(param_00.enabled) && !param_00.enabled)
		{
			param_00 waittill("enable");
		}

		if(isdefined(param_00.script_flag_set))
		{
			common_scripts\utility::flag_set(param_00.script_flag_set);
		}

		if(isdefined(param_00.script_flag_clear))
		{
			common_scripts\utility::flag_clear(param_00.script_flag_clear);
		}

		if(var_04)
		{
			var_07 thread path_detour_script_origin(param_00);
		}
		else if(var_05 && isdefined(var_07))
		{
			var_07 thread path_detour(param_00);
		}

		param_00 maps\_utility::script_delay();
		if(var_01)
		{
			var_06 = 0;
		}

		if(isdefined(param_00.script_vehiclegroupdelete))
		{
			if(!isdefined(level.vehicle_deletegroup[param_00.script_vehiclegroupdelete]))
			{
				level.vehicle_deletegroup[param_00.script_vehiclegroupdelete] = [];
			}

			common_scripts\utility::array_levelthread(level.vehicle_deletegroup[param_00.script_vehiclegroupdelete],::maps\_utility::deleteent);
		}

		if(var_03)
		{
			_scripted_spawn(param_00.script_vehiclespawngroup);
		}

		if(var_02.size > 0 && var_01)
		{
			common_scripts\utility::array_levelthread(var_02,::path_gate_open);
		}

		if(isdefined(param_00.script_vehiclestartmove))
		{
			if(!isdefined(level.vehicle_startmovegroup[param_00.script_vehiclestartmove]))
			{
				return;
			}

			common_scripts\utility::array_levelthread(level.vehicle_startmovegroup[param_00.script_vehiclestartmove],::_gopath);
		}
	}
}

//Function Number: 7
trigger_process_optimized(param_00,param_01)
{
	var_02 = param_00 is_trigger_once();
	param_00.processed_trigger = undefined;
	if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "trigger_multiple")
	{
		var_02 = 0;
	}

	var_03 = setup_script_gatetrigger(param_00);
	var_04 = isdefined(param_00.script_vehiclespawngroup);
	var_05 = isdefined(param_00.script_vehicledetour) && is_node_script_origin(param_00) || is_node_script_struct(param_00);
	var_06 = isdefined(param_00.detoured) && !is_node_script_origin(param_00) || is_node_script_struct(param_00);
	var_07 = 1;
	if(isdefined(param_00.script_vehicletriggergroup))
	{
		if(!isdefined(param_01.script_vehicletriggergroup))
		{
			return;
		}

		if(param_01.script_vehicletriggergroup != param_00.script_vehicletriggergroup)
		{
			return;
		}
	}

	if(isdefined(param_00.enabled) && !param_00.enabled)
	{
		param_00 waittill("enable");
	}

	if(isdefined(param_00.script_flag_set))
	{
		common_scripts\utility::flag_set(param_00.script_flag_set);
	}

	if(isdefined(param_00.script_flag_clear))
	{
		common_scripts\utility::flag_clear(param_00.script_flag_clear);
	}

	if(var_05)
	{
		param_01 thread path_detour_script_origin(param_00);
	}
	else if(var_06 && isdefined(param_01))
	{
		param_01 thread path_detour(param_00);
	}

	param_00 maps\_utility::script_delay();
	if(var_02)
	{
		var_07 = 0;
	}

	if(isdefined(param_00.script_vehiclegroupdelete))
	{
		if(!isdefined(level.vehicle_deletegroup[param_00.script_vehiclegroupdelete]))
		{
			level.vehicle_deletegroup[param_00.script_vehiclegroupdelete] = [];
		}

		common_scripts\utility::array_levelthread(level.vehicle_deletegroup[param_00.script_vehiclegroupdelete],::maps\_utility::deleteent);
	}

	if(var_04)
	{
		_scripted_spawn(param_00.script_vehiclespawngroup);
	}

	if(var_03.size > 0 && var_02)
	{
		common_scripts\utility::array_levelthread(var_03,::path_gate_open);
	}

	if(isdefined(param_00.script_vehiclestartmove))
	{
		if(!isdefined(level.vehicle_startmovegroup[param_00.script_vehiclestartmove]))
		{
			return;
		}

		common_scripts\utility::array_levelthread(level.vehicle_startmovegroup[param_00.script_vehiclestartmove],::_gopath);
	}
}

//Function Number: 8
path_detour_get_detourpath(param_00)
{
	var_01 = undefined;
	foreach(var_03 in level.vehicle_detourpaths[param_00.script_vehicledetour])
	{
		if(var_03 != param_00)
		{
			if(!islastnode(var_03))
			{
				var_01 = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 9
path_detour_script_origin(param_00)
{
	var_01 = path_detour_get_detourpath(param_00);
	if(isdefined(var_01))
	{
		thread _vehicle_paths(var_01);
	}
}

//Function Number: 10
crash_detour_check(param_00)
{
	return (isdefined(self.deaddriver) || self.health < self.healthbuffer || param_00.script_crashtype == "forced") && !isdefined(param_00.derailed) || param_00.script_crashtype == "plane";
}

//Function Number: 11
crash_derailed_check(param_00)
{
	return isdefined(param_00.derailed) && param_00.derailed;
}

//Function Number: 12
path_detour(param_00)
{
	var_01 = getvehiclenode(param_00.target,"targetname");
	var_02 = path_detour_get_detourpath(var_01);
	if(!isdefined(var_02))
	{
		return;
	}

	if(param_00.detoured && !isdefined(var_02.script_vehicledetourgroup))
	{
		return;
	}

	if(isdefined(var_02.script_crashtype))
	{
		if(!crash_detour_check(var_02))
		{
			return;
		}

		self notify("crashpath",var_02);
		var_02.derailed = 1;
		self notify("newpath");
		_setswitchnode(param_00,var_02);
		return;
	}

	if(crash_derailed_check(var_02))
	{
		return;
	}

	if(isdefined(var_02.script_vehicledetourgroup))
	{
		if(!isdefined(self.script_vehicledetourgroup))
		{
			return;
		}

		if(var_02.script_vehicledetourgroup != self.script_vehicledetourgroup)
		{
			return;
		}
	}

	self notify("newpath");
	_setswitchnode(var_01,var_02);
	thread detour_flag(var_02);
	if(!islastnode(var_01) && !isdefined(param_00.scriptdetour_persist) && param_00.scriptdetour_persist)
	{
		param_00.detoured = 1;
	}

	self.attachedpath = var_02;
	thread _vehicle_paths();
	if(self vehicle_isphysveh() && isdefined(var_01.script_transmission))
	{
		thread reverse_node(var_01);
	}
}

//Function Number: 13
reverse_node(param_00)
{
	self endon("death");
	param_00 waittillmatch(self,"trigger");
	self.veh_transmission = param_00.script_transmission;
	if(self.veh_transmission == "forward")
	{
		wheeldirectionchange(1);
		return;
	}

	wheeldirectionchange(0);
}

//Function Number: 14
_setswitchnode(param_00,param_01)
{
	self setswitchnode(param_00,param_01);
}

//Function Number: 15
detour_flag(param_00)
{
	self endon("death");
	self.detouringpath = param_00;
	param_00 waittillmatch(self,"trigger");
	self.detouringpath = undefined;
}

//Function Number: 16
vehicle_levelstuff(param_00,param_01)
{
	if(isdefined(param_00.script_linkname))
	{
		level.vehicle_link = array_2dadd(level.vehicle_link,param_00.script_linkname,param_00);
	}

	if(isdefined(param_00.script_vehiclestartmove))
	{
		level.vehicle_startmovegroup = array_2dadd(level.vehicle_startmovegroup,param_00.script_vehiclestartmove,param_00);
	}

	if(isdefined(param_00.script_vehiclegroupdelete))
	{
		level.vehicle_deletegroup = array_2dadd(level.vehicle_deletegroup,param_00.script_vehiclegroupdelete,param_00);
	}
}

//Function Number: 17
spawn_array(param_00)
{
	var_01 = [];
	var_02 = maps\_utility::ent_flag_exist("no_riders_until_unload");
	foreach(var_04 in param_00)
	{
		var_04.count = 1;
		var_05 = 0;
		if(isdefined(var_04.script_drone))
		{
			var_05 = 1;
			var_06 = maps\_utility::dronespawn_bodyonly(var_04);
			var_06 maps\_drone_base::drone_give_soul();
		}
		else
		{
			var_07 = isdefined(var_04.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
			var_08 = var_04;
			if(isdefined(var_04.script_spawn_pool))
			{
				var_08 = maps\_spawner::get_spawner_from_pool(var_04,1);
			}

			if(isdefined(var_04.script_forcespawn) || var_02)
			{
				var_06 = var_08 stalingradspawn(var_07);
			}
			else
			{
				var_06 = var_08 dospawn(var_07);
			}

			if(isdefined(var_04.script_spawn_pool))
			{
				if(isdefined(var_04.script_startingposition))
				{
					var_06.script_startingposition = var_04.script_startingposition;
				}
			}
		}

		if(!var_05 && !isalive(var_06))
		{
			continue;
		}

		var_01[var_01.size] = var_06;
	}

	var_01 = remove_non_riders_from_array(var_01);
	return var_01;
}

//Function Number: 18
remove_non_riders_from_array(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!ai_should_be_added(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 19
ai_should_be_added(param_00)
{
	if(isalive(param_00))
	{
		return 1;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.classname))
	{
		return 0;
	}

	return param_00.classname == "script_model";
}

//Function Number: 20
spawn_group()
{
	if(maps\_utility::ent_flag_exist("no_riders_until_unload") && !maps\_utility::ent_flag("no_riders_until_unload"))
	{
		return [];
	}

	var_00 = get_vehicle_ai_spawners();
	if(!var_00.size)
	{
		return [];
	}

	var_01 = [];
	var_02 = spawn_array(var_00);
	var_02 = common_scripts\utility::array_combine(var_02,get_vehicle_ai_riders());
	var_02 = sort_by_startingpos(var_02);
	foreach(var_04 in var_02)
	{
		thread maps\_vehicle_aianim::guy_enter(var_04);
	}

	return var_02;
}

//Function Number: 21
spawn_unload_group(param_00)
{
	if(!isdefined(param_00))
	{
		return spawn_group();
	}

	var_01 = get_vehicle_ai_spawners();
	if(!var_01.size)
	{
		return [];
	}

	var_02 = [];
	var_03 = self.classname;
	if(isdefined(level.vehicle_unloadgroups[var_03]) && isdefined(level.vehicle_unloadgroups[var_03][param_00]))
	{
		var_04 = level.vehicle_unloadgroups[var_03][param_00];
		foreach(var_06 in var_04)
		{
			var_02[var_02.size] = var_01[var_06];
		}

		var_08 = spawn_array(var_02);
		for(var_09 = 0;var_09 < var_04.size;var_09++)
		{
			var_08[var_09].script_startingposition = var_04[var_09];
		}

		var_08 = common_scripts\utility::array_combine(var_08,get_vehicle_ai_riders());
		var_08 = sort_by_startingpos(var_08);
		foreach(var_0B in var_08)
		{
			thread maps\_vehicle_aianim::guy_enter(var_0B);
		}

		return var_08;
	}

	return spawn_group();
}

//Function Number: 22
sort_by_startingpos(param_00)
{
	var_01 = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04.script_startingposition))
		{
			var_01[var_01.size] = var_04;
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return common_scripts\utility::array_combine(var_01,var_02);
}

//Function Number: 23
setup_groundnode_detour(param_00)
{
	var_01 = getvehiclenode(param_00.targetname,"target");
	if(!isdefined(var_01))
	{
		return;
	}

	var_01.detoured = 0;
	add_proccess_trigger(var_01);
}

//Function Number: 24
turn_unloading_drones_to_ai()
{
	var_00 = maps\_vehicle_aianim::get_unload_group();
	foreach(var_03, var_02 in self.riders)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(isdefined(var_00[var_02.vehicle_position]))
		{
			self.riders[var_03] = maps\_vehicle_aianim::guy_becomes_real_ai(var_02,var_02.vehicle_position);
		}
	}
}

//Function Number: 25
add_proccess_trigger(param_00)
{
	if(isdefined(param_00.processed_trigger))
	{
		return;
	}

	level.vehicle_processtriggers[level.vehicle_processtriggers.size] = param_00;
	param_00.processed_trigger = 1;
}

//Function Number: 26
islastnode(param_00)
{
	if(!isdefined(param_00.target))
	{
		return 1;
	}

	if(!isdefined(getvehiclenode(param_00.target,"targetname")) && !isdefined(get_vehiclenode_any_dynamic(param_00.target)))
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
get_path_getfunc(param_00)
{
	var_01 = ::get_from_vehicle_node;
	if(_ishelicopter() && isdefined(param_00.target))
	{
		if(isdefined(get_from_entity(param_00.target)))
		{
			var_01 = ::get_from_entity;
		}

		if(isdefined(get_from_spawnstruct(param_00.target)))
		{
			var_01 = ::get_from_spawnstruct;
		}
	}

	return var_01;
}

//Function Number: 28
node_wait(param_00,param_01,param_02)
{
	if(self.attachedpath == param_00)
	{
		self notify("node_wait_terminated");
		waittillframeend;
		return;
	}

	if(isdefined(self.unique_id))
	{
		var_03 = "node_wait_triggered" + self.unique_id;
	}
	else
	{
		var_03 = "node_wait_triggered";
	}

	if(!isdefined(param_00.triggered_time) || param_00.triggered_time != gettime())
	{
		var_04 = spawnstruct();
		wait_til_node_wait_triggered(var_04,var_03,param_00,param_02);
		var_04 waittill(var_03);
	}

	param_00.triggered_time = undefined;
}

//Function Number: 29
wait_til_node_wait_triggered(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	var_05 = param_02;
	while(isdefined(param_02) && var_04 < 3)
	{
		var_04++;
		thread node_wait_triggered(param_00,param_01,param_02);
		if(!isdefined(param_02.target))
		{
			return;
		}

		param_02 = [[ param_03 ]](param_02.target);
	}
}

//Function Number: 30
node_wait_triggered(param_00,param_01,param_02)
{
	self endon("newpath");
	self endon("death");
	param_00 endon(param_01);
	param_02 waittill("trigger");
	param_02.triggered_time = gettime();
	waittillframeend;
	param_00 notify(param_01);
}

//Function Number: 31
vehicle_paths_non_heli(param_00)
{
	self notify("newpath");
	if(isdefined(param_00))
	{
		self.attachedpath = param_00;
	}

	var_01 = self.attachedpath;
	self.currentnode = self.attachedpath;
	if(!isdefined(var_01))
	{
		return;
	}

	self endon("newpath");
	self endon("death");
	var_02 = var_01;
	var_03 = undefined;
	var_04 = var_01;
	var_05 = get_path_getfunc(var_01);
	while(isdefined(var_04))
	{
		node_wait(var_04,var_03,var_05);
		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(var_04.optimized_process_trigger))
		{
			level thread trigger_process_optimized(var_04,self);
		}

		self.currentnode = var_04;
		if(isdefined(var_04.gateopen) && !var_04.gateopen)
		{
			thread path_gate_wait_till_open(var_04);
		}

		if(isdefined(var_04.script_noteworthy))
		{
			self notify(var_04.script_noteworthy);
			self notify("noteworthy",var_04.script_noteworthy);
		}

		waittillframeend;
		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(var_04.script_prefab_exploder))
		{
			var_04.script_exploder = var_04.script_prefab_exploder;
			var_04.script_prefab_exploder = undefined;
		}

		if(isdefined(var_04.script_exploder))
		{
			var_06 = var_04.script_exploder_delay;
			if(isdefined(var_06))
			{
				level maps\_utility::delaythread(var_06,::common_scripts\_exploder::exploder,var_04.script_exploder);
			}
			else
			{
				level common_scripts\_exploder::exploder(var_04.script_exploder);
			}
		}

		if(isdefined(var_04.script_flag_set))
		{
			common_scripts\utility::flag_set(var_04.script_flag_set);
		}

		if(isdefined(var_04.script_ent_flag_set))
		{
			maps\_utility::ent_flag_set(var_04.script_ent_flag_set);
		}

		if(isdefined(var_04.script_ent_flag_clear))
		{
			maps\_utility::ent_flag_clear(var_04.script_ent_flag_clear);
		}

		if(isdefined(var_04.script_flag_clear))
		{
			common_scripts\utility::flag_clear(var_04.script_flag_clear);
		}

		if(isdefined(var_04.script_noteworthy))
		{
			if(var_04.script_noteworthy == "kill")
			{
				_force_kill();
			}

			if(var_04.script_noteworthy == "godon")
			{
				self.godmode = 1;
			}

			if(var_04.script_noteworthy == "godoff")
			{
				self.godmode = 0;
			}

			if(var_04.script_noteworthy == "deleteme")
			{
				level thread maps\_utility::deleteent(self);
				return;
			}

			if(var_04.script_noteworthy == "engineoff")
			{
				self vehicle_turnengineoff();
			}
		}

		if(isdefined(var_04.script_crashtypeoverride))
		{
			self.script_crashtypeoverride = var_04.script_crashtypeoverride;
		}

		if(isdefined(var_04.script_badplace))
		{
			self.script_badplace = var_04.script_badplace;
		}

		if(isdefined(var_04.script_turretmg))
		{
			if(var_04.script_turretmg)
			{
				_mgon();
			}
			else
			{
				_mgoff();
			}
		}

		if(isdefined(var_04.script_team))
		{
			self.script_team = var_04.script_team;
		}

		if(isdefined(var_04.script_turningdir))
		{
			self notify("turning",var_04.script_turningdir);
		}

		if(isdefined(var_04.script_deathroll))
		{
			if(var_04.script_deathroll == 0)
			{
				thread deathrolloff();
			}
			else
			{
				thread deathrollon();
			}
		}

		if(isdefined(var_04.script_vehicleaianim))
		{
			if(isdefined(var_04.script_parameters) && var_04.script_parameters == "queue")
			{
				self.queueanim = 1;
			}
		}

		if(isdefined(var_04.script_wheeldirection))
		{
			wheeldirectionchange(var_04.script_wheeldirection);
		}

		if(vehicle_should_unload(::node_wait,var_04))
		{
			thread unload_node(var_04);
		}

		if(isdefined(var_04.script_transmission))
		{
			self.veh_transmission = var_04.script_transmission;
			if(self.veh_transmission == "forward")
			{
				wheeldirectionchange(1);
			}
			else
			{
				wheeldirectionchange(0);
			}
		}

		if(isdefined(var_04.script_brake))
		{
			self.veh_brake = var_04.script_brake;
		}

		if(isdefined(var_04.script_pathtype))
		{
			self.veh_pathtype = var_04.script_pathtype;
		}

		if(isdefined(var_04.script_ent_flag_wait))
		{
			var_07 = 35;
			if(isdefined(var_04.script_decel))
			{
				var_07 = var_04.script_decel;
			}

			self vehicle_setspeed(0,var_07);
			maps\_utility::ent_flag_wait(var_04.script_ent_flag_wait);
			if(!isdefined(self))
			{
				return;
			}

			var_08 = 60;
			if(isdefined(var_04.script_accel))
			{
				var_08 = var_04.script_accel;
			}

			self resumespeed(var_08);
		}

		if(isdefined(var_04.script_delay))
		{
			var_07 = 35;
			if(isdefined(var_04.script_decel))
			{
				var_07 = var_04.script_decel;
			}

			self vehicle_setspeed(0,var_07);
			if(isdefined(var_04.target))
			{
				thread overshoot_next_node([[ var_05 ]](var_04.target));
			}

			var_04 maps\_utility::script_delay();
			self notify("delay_passed");
			var_08 = 60;
			if(isdefined(var_04.script_accel))
			{
				var_08 = var_04.script_accel;
			}

			self resumespeed(var_08);
		}

		if(isdefined(var_04.script_flag_wait))
		{
			var_09 = 0;
			if(!common_scripts\utility::flag(var_04.script_flag_wait) || isdefined(var_04.script_delay_post))
			{
				var_09 = 1;
				var_08 = 5;
				var_07 = 35;
				if(isdefined(var_04.script_accel))
				{
					var_08 = var_04.script_accel;
				}

				if(isdefined(var_04.script_decel))
				{
					var_07 = var_04.script_decel;
				}

				_vehicle_stop_named("script_flag_wait_" + var_04.script_flag_wait,var_08,var_07);
				thread overshoot_next_node([[ var_05 ]](var_04.target));
			}

			common_scripts\utility::flag_wait(var_04.script_flag_wait);
			if(!isdefined(self))
			{
				return;
			}

			if(isdefined(var_04.script_delay_post))
			{
				wait(var_04.script_delay_post);
				if(!isdefined(self))
				{
					return;
				}
			}

			var_08 = 10;
			if(isdefined(var_04.script_accel))
			{
				var_08 = var_04.script_accel;
			}

			if(var_09)
			{
				_vehicle_resume_named("script_flag_wait_" + var_04.script_flag_wait);
			}

			self notify("delay_passed");
		}

		if(isdefined(self.set_lookat_point))
		{
			self.set_lookat_point = undefined;
			self clearlookatent();
		}

		if(isdefined(var_04.script_vehicle_lights_off))
		{
			thread lights_off(var_04.script_vehicle_lights_off);
		}

		if(isdefined(var_04.script_vehicle_lights_on))
		{
			thread lights_on(var_04.script_vehicle_lights_on);
		}

		if(isdefined(var_04.script_forcecolor))
		{
			thread vehicle_script_forcecolor_riders(var_04.script_forcecolor);
		}

		var_03 = var_04;
		if(!isdefined(var_04.target))
		{
			break;
		}

		var_04 = [[ var_05 ]](var_04.target);
		if(!isdefined(var_04))
		{
			var_04 = var_03;
			break;
		}
		else if(islastnode(var_04) || isdefined(var_04.script_unload))
		{
			var_0A = max(0.01,length(self vehicle_getvelocity()));
			var_0B = distance(self.origin,var_04.origin);
			var_0C = max(0.01,var_0B / var_0A);
			self notify("about_to_stop",var_0C);
		}
	}

	if(isdefined(var_04.script_land))
	{
		thread _vehicle_landvehicle();
	}

	self notify("reached_dynamic_path_end");
	if(isdefined(self.script_vehicle_selfremove))
	{
		self notify("delete");
		self delete();
	}
}

//Function Number: 32
vehicle_paths_helicopter(param_00,param_01,param_02)
{
	self notify("newpath");
	self endon("newpath");
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(param_00))
	{
		self.attachedpath = param_00;
	}

	var_03 = self.attachedpath;
	self.currentnode = self.attachedpath;
	if(!isdefined(var_03))
	{
		return;
	}

	var_04 = var_03;
	if(param_01)
	{
		self waittill("start_dynamicpath");
	}

	if(isdefined(param_02))
	{
		var_05 = spawnstruct();
		var_05.origin = maps\_utility::add_z(self.origin,param_02);
		heli_wait_node(var_05,undefined);
	}

	var_06 = undefined;
	var_07 = var_03;
	var_08 = get_path_getfunc(var_03);
	while(isdefined(var_07))
	{
		if(isdefined(var_07.script_linkto))
		{
			set_lookat_from_dest(var_07);
		}

		heli_wait_node(var_07,var_06,param_02);
		if(!isdefined(self))
		{
			return;
		}

		self.currentnode = var_07;
		if(isdefined(var_07.gateopen) && !var_07.gateopen)
		{
			thread path_gate_wait_till_open(var_07);
		}

		var_07 notify("trigger",self);
		if(isdefined(var_07.script_helimove))
		{
			self setyawspeedbyname(var_07.script_helimove);
			if(var_07.script_helimove == "faster")
			{
				self setmaxpitchroll(25,50);
			}
		}

		if(isdefined(var_07.script_noteworthy))
		{
			self notify(var_07.script_noteworthy);
			self notify("noteworthy",var_07.script_noteworthy);
		}

		waittillframeend;
		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(var_07.script_prefab_exploder))
		{
			var_07.script_exploder = var_07.script_prefab_exploder;
			var_07.script_prefab_exploder = undefined;
		}

		if(isdefined(var_07.script_exploder))
		{
			var_09 = var_07.script_exploder_delay;
			if(isdefined(var_09))
			{
				level maps\_utility::delaythread(var_09,::common_scripts\_exploder::exploder,var_07.script_exploder);
			}
			else
			{
				level common_scripts\_exploder::exploder(var_07.script_exploder);
			}
		}

		if(isdefined(var_07.script_flag_set))
		{
			common_scripts\utility::flag_set(var_07.script_flag_set);
		}

		if(isdefined(var_07.script_ent_flag_set))
		{
			maps\_utility::ent_flag_set(var_07.script_ent_flag_set);
		}

		if(isdefined(var_07.script_ent_flag_clear))
		{
			maps\_utility::ent_flag_clear(var_07.script_ent_flag_clear);
		}

		if(isdefined(var_07.script_flag_clear))
		{
			common_scripts\utility::flag_clear(var_07.script_flag_clear);
		}

		if(isdefined(var_07.script_noteworthy))
		{
			if(var_07.script_noteworthy == "kill")
			{
				_force_kill();
			}

			if(var_07.script_noteworthy == "godon")
			{
				self.godmode = 1;
			}

			if(var_07.script_noteworthy == "godoff")
			{
				self.godmode = 0;
			}

			if(var_07.script_noteworthy == "deleteme")
			{
				level thread maps\_utility::deleteent(self);
				return;
			}

			if(var_07.script_noteworthy == "engineoff")
			{
				self vehicle_turnengineoff();
			}
		}

		if(isdefined(var_07.script_crashtypeoverride))
		{
			self.script_crashtypeoverride = var_07.script_crashtypeoverride;
		}

		if(isdefined(var_07.script_badplace))
		{
			self.script_badplace = var_07.script_badplace;
		}

		if(isdefined(var_07.script_turretmg))
		{
			if(var_07.script_turretmg)
			{
				_mgon();
			}
			else
			{
				_mgoff();
			}
		}

		if(isdefined(var_07.script_team))
		{
			self.script_team = var_07.script_team;
		}

		if(isdefined(var_07.script_turningdir))
		{
			self notify("turning",var_07.script_turningdir);
		}

		if(isdefined(var_07.script_deathroll))
		{
			if(var_07.script_deathroll == 0)
			{
				thread deathrolloff();
			}
			else
			{
				thread deathrollon();
			}
		}

		if(isdefined(var_07.script_vehicleaianim))
		{
			if(isdefined(var_07.script_parameters) && var_07.script_parameters == "queue")
			{
				self.queueanim = 1;
			}
		}

		if(isdefined(var_07.script_wheeldirection))
		{
			wheeldirectionchange(var_07.script_wheeldirection);
		}

		if(vehicle_should_unload(::heli_wait_node,var_07))
		{
			thread unload_node(var_07);
		}

		if(self vehicle_isphysveh())
		{
			if(isdefined(var_07.script_transmission))
			{
				self.veh_transmission = var_07.script_transmission;
				if(self.veh_transmission == "forward")
				{
					wheeldirectionchange(1);
				}
				else
				{
					wheeldirectionchange(0);
				}
			}

			if(isdefined(var_07.script_pathtype))
			{
				self.veh_pathtype = var_07.script_pathtype;
			}
		}

		if(isdefined(var_07.script_flag_wait))
		{
			common_scripts\utility::flag_wait(var_07.script_flag_wait);
			if(isdefined(var_07.script_delay_post))
			{
				wait(var_07.script_delay_post);
			}

			self notify("delay_passed");
		}

		if(isdefined(self.set_lookat_point))
		{
			self.set_lookat_point = undefined;
			self clearlookatent();
		}

		if(isdefined(var_07.script_vehicle_lights_off))
		{
			thread lights_off(var_07.script_vehicle_lights_off);
		}

		if(isdefined(var_07.script_vehicle_lights_on))
		{
			thread lights_on(var_07.script_vehicle_lights_on);
		}

		if(isdefined(var_07.script_forcecolor))
		{
			thread vehicle_script_forcecolor_riders(var_07.script_forcecolor);
		}

		var_06 = var_07;
		if(!isdefined(var_07.target))
		{
			break;
		}

		var_07 = [[ var_08 ]](var_07.target);
		if(!isdefined(var_07))
		{
			var_07 = var_06;
			break;
		}
	}

	if(isdefined(var_07.script_land))
	{
		thread _vehicle_landvehicle();
	}

	self notify("reached_dynamic_path_end");
	if(isdefined(self.script_vehicle_selfremove))
	{
		self delete();
	}
}

//Function Number: 33
vehicle_should_unload(param_00,param_01)
{
	if(isdefined(param_01.script_unload))
	{
		return 1;
	}

	if(param_00 != ::node_wait)
	{
		return 0;
	}

	if(!islastnode(param_01))
	{
		return 0;
	}

	if(isdefined(self.dontunloadonend))
	{
		return 0;
	}

	if(self.vehicletype == "empty")
	{
		return 0;
	}

	return !is_script_vehicle_selfremove();
}

//Function Number: 34
overshoot_next_node(param_00)
{
}

//Function Number: 35
is_script_vehicle_selfremove()
{
	if(!isdefined(self.script_vehicle_selfremove))
	{
		return 0;
	}

	return self.script_vehicle_selfremove;
}

//Function Number: 36
heli_wait_node(param_00,param_01,param_02)
{
	self endon("newpath");
	if(isdefined(param_00.script_unload) && isdefined(self.fastropeoffset))
	{
		self notify("about_to_unload");
		param_00.radius = 2;
		if(isdefined(param_00.ground_pos))
		{
			param_00.origin = param_00.ground_pos + (0,0,self.fastropeoffset);
		}
		else
		{
			var_03 = maps\_utility::groundpos(param_00.origin) + (0,0,self.fastropeoffset);
			if(var_03[2] > param_00.origin[2] - 2000)
			{
				param_00.origin = maps\_utility::groundpos(param_00.origin) + (0,0,self.fastropeoffset);
			}
		}

		self sethoverparams(0,0,0);
	}

	if(isdefined(param_00.script_unload) && isdefined(self.parachute_unload))
	{
		param_00.radius = 100;
		if(isdefined(param_00.ground_pos))
		{
			param_00.origin = param_00.ground_pos + (0,0,self.dropoff_height);
		}
		else
		{
			param_00.origin = maps\_utility::groundpos(param_00.origin) + (0,0,self.dropoff_height);
		}
	}

	if(isdefined(param_01))
	{
		var_04 = param_01.script_airresistance;
		var_05 = param_01.speed;
		var_06 = param_01.script_accel;
		var_07 = param_01.script_decel;
		var_08 = param_01.script_axial;
	}
	else
	{
		var_04 = undefined;
		var_05 = undefined;
		var_06 = undefined;
		var_07 = undefined;
		var_08 = undefined;
	}

	var_09 = isdefined(param_00.script_stopnode) && param_00.script_stopnode;
	var_0A = isdefined(param_00.script_unload);
	var_0B = isdefined(param_00.script_flag_wait) && !common_scripts\utility::flag(param_00.script_flag_wait);
	var_0C = !isdefined(param_00.target);
	var_0D = isdefined(param_00.script_delay);
	if(isdefined(param_00.angles))
	{
		var_0E = param_00.angles[1];
	}
	else
	{
		var_0E = 0;
	}

	if(self.health <= 0)
	{
		return;
	}

	var_0F = param_00.origin;
	if(isdefined(param_02))
	{
		var_0F = maps\_utility::add_z(var_0F,param_02);
	}

	if(isdefined(self.heliheightoverride))
	{
		var_0F = (var_0F[0],var_0F[1],self.heliheightoverride);
	}

	self vehicle_helisetai(var_0F,var_05,var_06,var_07,param_00.script_goalyaw,param_00.script_anglevehicle,var_0E,var_04,var_0D,var_09,var_0A,var_0B,var_0C,var_08);
	if(isdefined(param_00.radius))
	{
		self setneargoalnotifydist(param_00.radius);
		common_scripts\utility::waittill_any("near_goal","goal");
	}
	else
	{
		self waittill("goal");
	}

	if(isdefined(self.optimized_process_trigger))
	{
		level thread trigger_process_optimized(param_00,self);
	}

	if(isdefined(param_00.script_firelink))
	{
		if(!isdefined(level.helicopter_firelinkfunk))
		{
		}

		thread [[ level.helicopter_firelinkfunk ]](param_00);
	}

	param_00 maps\_utility::script_delay();
	if(isdefined(self.path_gobbler))
	{
		maps\_utility::deletestruct_ref(param_00);
	}
}

//Function Number: 37
path_gate_open(param_00)
{
	param_00.gateopen = 1;
	param_00 notify("gate opened");
}

//Function Number: 38
path_gate_wait_till_open(param_00)
{
	self endon("death");
	self.waitingforgate = 1;
	_vehicle_stop_named("path_gate_wait_till_open",5,15);
	param_00 waittill("gate opened");
	self.waitingforgate = 0;
	if(self.health > 0)
	{
		self endon("death");
		if(isdefined(self.waitingforgate) && self.waitingforgate)
		{
			return;
		}

		_vehicle_resume_named("path_gate_wait_till_open");
	}
}

//Function Number: 39
remove_vehicle_spawned_thisframe()
{
	wait(0.05);
	self.vehicle_spawned_thisframe = undefined;
}

//Function Number: 40
vehicle_init(param_00)
{
	var_01 = param_00.classname;
	if(isdefined(level.vehicle_hide_list[var_01]))
	{
		foreach(var_03 in level.vehicle_hide_list[var_01])
		{
			param_00 hidepart(var_03);
		}
	}

	if(param_00.vehicletype == "empty")
	{
		param_00 thread getonpath();
		return;
	}

	param_00 maps\_utility::set_ai_number();
	if(!isdefined(param_00.modeldummyon))
	{
		param_00.modeldummyon = 0;
	}

	var_05 = param_00.vehicletype;
	param_00 vehicle_life();
	param_00 vehicle_setteam();
	if(!isdefined(level.vehicleinitthread[param_00.vehicletype][param_00.classname]))
	{
	}

	param_00 thread [[ level.vehicleinitthread[param_00.vehicletype][param_00.classname] ]]();
	param_00 thread maingun_fx();
	param_00 thread playtankexhaust();
	if(!isdefined(param_00.script_avoidplayer))
	{
		param_00.script_avoidplayer = 0;
	}

	if(isdefined(level.vehicle_draw_thermal))
	{
		if(level.vehicle_draw_thermal)
		{
			param_00 thermaldrawenable();
		}
	}

	param_00 maps\_utility::ent_flag_init("unloaded");
	param_00 maps\_utility::ent_flag_init("loaded");
	param_00.riders = [];
	param_00.unloadque = [];
	param_00.unload_group = "default";
	param_00.fastroperig = [];
	if(isdefined(level.vehicle_attachedmodels) && isdefined(level.vehicle_attachedmodels[var_01]))
	{
		var_06 = level.vehicle_attachedmodels[var_01];
		var_07 = getarraykeys(var_06);
		foreach(var_09 in var_07)
		{
			param_00.fastroperig[var_09] = undefined;
			param_00.fastroperiganimating[var_09] = 0;
		}
	}

	param_00 thread vehicle_badplace();
	if(isdefined(param_00.script_vehicle_lights_on))
	{
		param_00 thread lights_on(param_00.script_vehicle_lights_on);
	}

	if(isdefined(param_00.script_godmode))
	{
		param_00.godmode = 1;
	}

	param_00.damage_functions = [];
	if(!param_00 ischeap() || param_00 ischeapshieldenabled())
	{
		param_00 thread friendlyfire_shield();
	}

	param_00 thread maps\_vehicle_aianim::handle_attached_guys();
	if(isdefined(param_00.script_friendname))
	{
		param_00 setvehiclelookattext(param_00.script_friendname,&"");
	}

	if(!param_00 ischeap())
	{
		param_00 thread vehicle_handleunloadevent();
	}

	if(isdefined(param_00.script_dontunloadonend))
	{
		param_00.dontunloadonend = 1;
	}

	if(!param_00 ischeap())
	{
		param_00 thread vehicle_shoot_shock();
	}

	param_00 thread vehicle_rumble();
	if(isdefined(param_00.script_physicsjolt) && param_00.script_physicsjolt)
	{
		param_00 thread maps\_utility::physicsjolt_proximity();
	}

	param_00 thread vehicle_treads();
	param_00 thread idle_animations();
	param_00 thread animate_drive_idle();
	if(isdefined(param_00.script_deathflag))
	{
		param_00 thread maps\_spawner::vehicle_deathflag();
	}

	if(!param_00 ischeap())
	{
		param_00 thread mginit();
	}

	if(isdefined(level.vehiclespawncallbackthread))
	{
		level thread [[ level.vehiclespawncallbackthread ]](param_00);
	}

	vehicle_levelstuff(param_00);
	if(isdefined(param_00.script_team))
	{
		param_00 setvehicleteam(param_00.script_team);
	}

	if(!param_00 ischeap())
	{
		param_00 thread disconnect_paths_whenstopped();
	}

	param_00 thread getonpath();
	if(isdefined(level.ignorewash))
	{
		var_0B = level.ignorewash;
	}
	else
	{
		var_0B = 0;
	}

	if(param_00 hashelicopterdustkickup() && !var_0B)
	{
		param_00 thread aircraft_wash_thread();
	}

	if(param_00 vehicle_isphysveh())
	{
		if(isdefined(param_00.script_pathtype))
		{
			param_00.veh_pathtype = param_00.script_pathtype;
		}
	}

	param_00 spawn_group();
	param_00 thread vehicle_kill();
	param_00 apply_truckjunk();
}

//Function Number: 41
ischeapshieldenabled()
{
	return isdefined(level.cheap_vehicles_have_shields) && level.cheap_vehicles_have_shields;
}

//Function Number: 42
kill_damage(param_00)
{
	if(!isdefined(level.vehicle_death_radiusdamage) || !isdefined(level.vehicle_death_radiusdamage[param_00]))
	{
		return;
	}

	if(isdefined(self.deathdamage_max))
	{
		var_01 = self.deathdamage_max;
	}
	else
	{
		var_01 = level.vehicle_death_radiusdamage[var_01].maxdamage;
	}

	if(isdefined(self.deathdamage_min))
	{
		var_02 = self.deathdamage_min;
	}
	else
	{
		var_02 = level.vehicle_death_radiusdamage[var_01].mindamage;
	}

	if(isdefined(level.vehicle_death_radiusdamage[param_00].delay))
	{
		wait(level.vehicle_death_radiusdamage[param_00].delay);
	}

	if(!isdefined(self))
	{
		return;
	}

	if(level.vehicle_death_radiusdamage[param_00].bkillplayer)
	{
		level.player enablehealthshield(0);
	}

	self radiusdamage(self.origin + level.vehicle_death_radiusdamage[param_00].offset,level.vehicle_death_radiusdamage[param_00].range,var_01,var_02,self);
	if(level.vehicle_death_radiusdamage[param_00].bkillplayer)
	{
		level.player enablehealthshield(1);
	}
}

//Function Number: 43
vehicle_kill_common(param_00,param_01)
{
	var_02 = self.vehicletype;
	var_03 = self.classname;
	var_04 = self.model;
	var_05 = self.targetname;
	thread kill_damage(var_03);
	thread kill_badplace(var_03);
	thread kill_lights(var_03);
	maps\_vehicle_aianim::delete_corpses_around_vehicle();
	if(isdefined(level.vehicle_deathmodel[var_03]))
	{
		thread set_death_model(level.vehicle_deathmodel[var_03],level.vehicle_deathmodel_delay[var_03]);
	}
	else if(isdefined(level.vehicle_deathmodel[var_04]))
	{
		thread set_death_model(level.vehicle_deathmodel[var_04],level.vehicle_deathmodel_delay[var_04]);
	}

	var_06 = vehicle_should_do_rocket_death(var_04,param_00,param_01);
	thread kill_death_anim_thread(var_03);
	thread _kill_fx(var_04,var_06);
	if(self.code_classname == "script_vehicle")
	{
		thread kill_jolt(var_03);
	}

	return var_06;
}

//Function Number: 44
vehicle_kill()
{
	self endon("nodeath_thread");
	var_00 = self.vehicletype;
	var_01 = self.classname;
	var_02 = self.model;
	var_03 = self.targetname;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = 0;
	for(;;)
	{
		if(isdefined(self))
		{
			self waittill("death",var_04,var_05,var_06);
		}

		if(isdefined(self.custom_death_script))
		{
			self thread [[ self.custom_death_script ]]();
		}

		if(!var_07)
		{
			var_07 = 1;
			if(isdefined(var_04) && isdefined(var_05))
			{
				var_04 maps\_player_stats::register_kill(self,var_05,var_06);
				if(isdefined(self.damage_type))
				{
					self.damage_type = undefined;
				}
			}

			if(maps\_utility::is_specialop() && !maps\_utility::is_survival() && isdefined(var_04) && isplayer(var_04))
			{
				if(var_04.team != self.script_team)
				{
					var_04 thread maps\_utility::givexp("kill",500);
				}

				if(isdefined(self.riders))
				{
					foreach(var_09 in self.riders)
					{
						if(isalive(var_09) && isai(var_09))
						{
							var_04 thread maps\_utility::givexp("kill");
						}
					}
				}
			}
		}

		self notify("clear_c4");
		if(isdefined(self.rumbletrigger))
		{
			self.rumbletrigger delete();
		}

		if(isdefined(self.mgturret))
		{
			common_scripts\utility::array_levelthread(self.mgturret,::turret_deleteme);
			self.mgturret = undefined;
		}

		if(isdefined(self.script_team))
		{
			level.vehicles[self.script_team] = common_scripts\utility::array_remove(level.vehicles[self.script_team],self);
		}

		if(isdefined(self.script_linkname))
		{
			level.vehicle_link[self.script_linkname] = common_scripts\utility::array_remove(level.vehicle_link[self.script_linkname],self);
		}

		if(isdefined(self.script_vehiclestartmove))
		{
			level.vehicle_startmovegroup[self.script_vehiclestartmove] = common_scripts\utility::array_remove(level.vehicle_startmovegroup[self.script_vehiclestartmove],self);
		}

		if(isdefined(self.script_vehiclegroupdelete))
		{
			level.vehicle_deletegroup[self.script_vehiclegroupdelete] = common_scripts\utility::array_remove(level.vehicle_deletegroup[self.script_vehiclegroupdelete],self);
		}

		if(!isdefined(self) || is_corpse())
		{
			if(isdefined(self.riders))
			{
				foreach(var_09 in self.riders)
				{
					if(isdefined(var_09))
					{
						var_09 delete();
					}
				}
			}

			if(is_corpse())
			{
				self.riders = [];
				continue;
			}

			self notify("delete_destructible");
			return;
		}

		var_0D = undefined;
		if(isdefined(self.vehicle_rumble_unique))
		{
			var_0D = self.vehicle_rumble_unique;
		}
		else if(isdefined(level.vehicle_rumble_override) && isdefined(level.vehicle_rumble_override[var_01]))
		{
			var_0D = level.vehicle_rumble_override;
		}
		else if(isdefined(level.vehicle_rumble[var_01]))
		{
			var_0D = level.vehicle_rumble[var_01];
		}

		if(isdefined(var_0D))
		{
			self stoprumble(var_0D.rumble);
		}

		if(isdefined(level.vehicle_death_thread) && isdefined(var_00) && isdefined(level.vehicle_death_thread[var_00]))
		{
			thread [[ level.vehicle_death_thread[var_00] ]]();
		}

		if(isdefined(var_00) && isdefined(::maps\_vehicle_aianim::guy_vehicle_death))
		{
			common_scripts\utility::array_levelthread(self.riders,::maps\_vehicle_aianim::guy_vehicle_death,var_04,var_00);
		}

		var_0E = vehicle_kill_common(var_04,var_05);
		if(isdefined(self.delete_on_death))
		{
			wait(0.05);
			if(!isdefined(self.dontdisconnectpaths) && !self vehicle_isphysveh())
			{
				self disconnectpaths();
			}

			_freevehicle();
			wait(0.05);
			vehicle_finish_death(var_02);
			self delete();
			continue;
		}

		if(isdefined(self.free_on_death))
		{
			self notify("newpath");
			if(!isdefined(self.dontdisconnectpaths))
			{
				self disconnectpaths();
			}

			vehicle_kill_badplace_forever();
			_freevehicle();
			return;
		}

		vehicle_do_crash(var_02,var_04,var_05,var_0E);
		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(level.vehicle_death_earthquake[var_01]))
		{
			earthquake(level.vehicle_death_earthquake[var_01].scale,level.vehicle_death_earthquake[var_01].duration,self.origin,level.vehicle_death_earthquake[var_01].radius);
		}

		wait(0.5);
		if(is_corpse())
		{
			continue;
		}

		if(isdefined(self))
		{
			while(isdefined(self.dontfreeme) && isdefined(self))
			{
				wait(0.05);
			}

			if(!isdefined(self))
			{
				continue;
			}

			if(self vehicle_isphysveh())
			{
				while(isdefined(self) && self.veh_speed != 0)
				{
					wait(1);
				}

				if(!isdefined(self))
				{
					return;
				}

				self disconnectpaths();
				self notify("kill_badplace_forever");
				self kill();
				self notify("newpath");
				self vehicle_turnengineoff();
				return;
			}
			else
			{
				_freevehicle();
			}

			if(self.modeldummyon)
			{
				self hide();
			}
		}

		if(_vehicle_is_crashing())
		{
			self delete();
			continue;
		}
	}
}

//Function Number: 45
_freevehicle()
{
	self notify("newpath");
	self freevehicle();
	maps\_utility::delaythread(0.05,::extra_vehicle_cleanup);
}

//Function Number: 46
extra_vehicle_cleanup()
{
	self.accuracy = undefined;
	self.attachedguys = undefined;
	self.attackback = undefined;
	self.badshot = undefined;
	self.badshotcount = undefined;
	self.currenthealth = undefined;
	self.currentnode = undefined;
	self.damage_functions = undefined;
	self.delayer = undefined;
	self.fastroperig = undefined;
	self.getinorgs = undefined;
	self.hasstarted = undefined;
	self.healthbuffer = undefined;
	self.offsetone = undefined;
	self.offsetrange = undefined;
	self.rocket_destroyed_for_achievement = undefined;
	self.rumble_basetime = undefined;
	self.rumble_duration = undefined;
	self.rumble_radius = undefined;
	self.script_attackai = undefined;
	self.script_avoidplayer = undefined;
	self.script_attackai = undefined;
	self.script_avoidplayer = undefined;
	self.script_bulletshield = undefined;
	self.script_disconnectpaths = undefined;
	self.script_linkname = undefined;
	self.script_mp_style_helicopter = undefined;
	self.script_team = undefined;
	self.script_turret = undefined;
	self.script_turretmg = undefined;
	self.script_vehicleride = undefined;
	self.script_vehiclespawngroup = undefined;
	self.script_vehiclestartmove = undefined;
	self.shotcount = undefined;
	self.shotsatzerospeed = undefined;
	self.spawn_funcs = undefined;
	self.spawn_functions = undefined;
	self.tank_queue = undefined;
	self.target = undefined;
	self.target_min_range = undefined;
	self.troop_cache = undefined;
	self.troop_cache = undefined;
	self.troop_cache_update_next = undefined;
	self.turret_damage_max = undefined;
	self.turret_damage_min = undefined;
	self.turret_damage_range = undefined;
	self.badplacemodifier = undefined;
	self.attachedpath = undefined;
	self.badplacemodifier = undefined;
	self.rumble_randomaditionaltime = undefined;
	self.rumble_scale = undefined;
	self.rumbleon = undefined;
	self.rumbletrigger = undefined;
	self.runningtovehicle = undefined;
	self.script_nomg = undefined;
	self.script_startinghealth = undefined;
	self.teleported_to_path_section = undefined;
	self.turret_damage_range = undefined;
	self.turretaccmaxs = undefined;
	self.turretaccmins = undefined;
	self.turretfiretimer = undefined;
	self.turretonvistarg = undefined;
	self.turretonvistarg_failed = undefined;
	self.unique_id = undefined;
	self.unload_group = undefined;
	self.unloadque = undefined;
	self.usedpositions = undefined;
	self.vehicle_spawner = undefined;
	self.waitingforgate = undefined;
	self.water_splash_function = undefined;
	self.water_splash_reset_function = undefined;
	self.offsetzero = undefined;
	self.script_accuracy = undefined;
	self.water_splash_reset_function = undefined;
	self.wheeldir = undefined;
	self.dontunloadonend = undefined;
	self.dontdisconnectpaths = undefined;
	self.script_godmode = undefined;
	self.ent_flag = undefined;
	self.export = undefined;
	self.godmode = undefined;
	self.vehicletype = undefined;
	self.vehicle_stop_named = undefined;
	self.enable_rocket_death = undefined;
	self.touching_trigger_ent = undefined;
	self.default_target_vec = undefined;
	self.script_badplace = undefined;
	self.water_splash_info = undefined;
}

//Function Number: 47
_vehicle_is_crashing()
{
	return isdefined(self.crashing) && self.crashing == 1;
}

//Function Number: 48
vehicle_finish_death(param_00)
{
	if(isdefined(self.dont_finish_death) && self.dont_finish_death)
	{
		return;
	}

	self notify("death_finished");
	if(!isdefined(self))
	{
		return;
	}

	self useanimtree(#animtree);
	if(isdefined(level.vehicle_driveidle[param_00]))
	{
		self clearanim(level.vehicle_driveidle[param_00],0);
	}

	if(isdefined(level.vehicle_driveidle_r[param_00]))
	{
		self clearanim(level.vehicle_driveidle_r[param_00],0);
	}
}

//Function Number: 49
vehicle_should_do_rocket_death(param_00,param_01,param_02)
{
	if(!isdefined(self.alwaysrocketdeath) || self.alwaysrocketdeath == 0)
	{
		if(isdefined(self.enablerocketdeath) && self.enablerocketdeath == 0)
		{
			return 0;
		}

		if(!isdefined(param_02))
		{
			return 0;
		}

		if(!param_02 == "MOD_PROJECTILE" || param_02 == "MOD_PROJECTILE_SPLASH")
		{
			return 0;
		}
	}

	if(isdefined(self.is_anim_based_death) && self.is_anim_based_death)
	{
		return 1;
	}

	return vehicle_has_rocket_death(param_00);
}

//Function Number: 50
vehicle_has_rocket_death(param_00)
{
	return isdefined(level.vehicle_death_fx["rocket_death" + self.classname]) && isdefined(self.enablerocketdeath) && self.enablerocketdeath == 1;
}

//Function Number: 51
vehicle_do_crash(param_00,param_01,param_02,param_03)
{
	var_04 = "tank";
	if(isdefined(self.script_crashtypeoverride))
	{
		var_04 = self.script_crashtypeoverride;
	}
	else if(self vehicle_isphysveh())
	{
		var_04 = "physics";
	}
	else if(_ishelicopter())
	{
		var_04 = "helicopter";
	}
	else if(isdefined(self.currentnode) && crash_path_check(self.currentnode))
	{
		var_04 = "none";
	}

	switch(var_04)
	{
		case "helicopter":
			thread helicopter_crash(param_01,param_02,param_03);
			break;

		case "tank":
			if(!isdefined(self.rollingdeath))
			{
				self vehicle_setspeed(0,25);
			}
			else
			{
				self vehicle_setspeed(8,25);
				self waittill("deathrolloff");
				self vehicle_setspeed(0,25);
			}
	
			self notify("deadstop");
			if(!isdefined(self.dontdisconnectpaths))
			{
				self disconnectpaths();
			}
	
			if(isdefined(self.tankgetout) && self.tankgetout > 0)
			{
				self waittill("animsdone");
			}
			break;

		case "diveboat":
			if(!isdefined(self.dontdisconnectpaths))
			{
				self disconnectpaths();
			}
			break;

		case "physics":
			self vehphys_crash();
			self notify("deadstop");
			if(!isdefined(self.dontdisconnectpaths))
			{
				self disconnectpaths();
			}
	
			if(isdefined(self.tankgetout) && self.tankgetout > 0)
			{
				self waittill("animsdone");
			}
			break;
	}

	if(isdefined(level.vehicle_hasmainturret[param_00]) && level.vehicle_hasmainturret[param_00])
	{
		self clearturrettarget();
	}

	if(_ishelicopter())
	{
		if(isdefined(self.crashing) && self.crashing == 1)
		{
			self waittill("crash_done");
		}
	}
	else
	{
		while(!is_corpse() && isdefined(self) && self vehicle_getspeed() > 0)
		{
			wait(0.1);
		}
	}

	self notify("stop_looping_death_fx");
	vehicle_finish_death(param_00);
}

//Function Number: 52
is_corpse()
{
	var_00 = 0;
	if(isdefined(self) && self.classname == "script_vehicle_corpse")
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 53
set_death_model(param_00,param_01)
{
	if(isdefined(self.skipmodelswapdeath) && self.skipmodelswapdeath)
	{
		return;
	}

	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(!isdefined(self))
	{
		return;
	}

	var_02 = _get_dummy();
	if(isdefined(self.clear_anims_on_death))
	{
		var_02 clearanim(%root,0);
	}

	if(isdefined(self))
	{
		var_02 setmodel(param_00);
	}
}

//Function Number: 54
helicopter_crash(param_00,param_01,param_02)
{
	if(isdefined(param_00) && isplayer(param_00))
	{
		self.achievement_attacker = param_00;
	}

	self.crashing = 1;
	if(!isdefined(self))
	{
		return;
	}

	detach_getoutrigs();
	if(!param_02)
	{
		thread helicopter_crash_move(param_00,param_01);
	}
}

//Function Number: 55
kill_riders(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.ridingvehicle) && !isdefined(var_02.drivingvehicle))
		{
			continue;
		}

		if(isdefined(var_02.magic_bullet_shield))
		{
			var_02 maps\_utility::stop_magic_bullet_shield();
		}

		var_02 kill();
	}
}

//Function Number: 56
vehicle_rider_death_detection(param_00,param_01)
{
	if(isdefined(self.vehicle_position) && self.vehicle_position != 0)
	{
		return;
	}

	self.health = 1;
	param_00 endon("death");
	self.baseaccuracy = 0.15;
	self waittill("death");
	param_00 notify("driver_died");
	kill_riders(param_01);
}

//Function Number: 57
vehicle_becomes_crashable()
{
	self endon("death");
	self endon("enable_spline_path");
	self endon("enable_free_path");
	waittillframeend;
	self.riders = maps\_utility::remove_dead_from_array(self.riders);
	if(self.has_riders && self.riders.size)
	{
		common_scripts\utility::array_thread(self.riders,::vehicle_rider_death_detection,self,self.riders);
		common_scripts\utility::waittill_either("veh_collision","driver_died");
		kill_riders(self.riders);
		wait(0.25);
	}
	else
	{
		self waittill("veh_collision");
		wait(0.25);
	}

	self notify("script_crash_vehicle");
	self vehphys_crash();
}

//Function Number: 58
_vehicle_landvehicle(param_00,param_01)
{
	self notify("newpath");
	if(!isdefined(param_00))
	{
		param_00 = 2;
	}

	self setneargoalnotifydist(param_00);
	self sethoverparams(0,0,0);
	self cleargoalyaw();
	self settargetyaw(common_scripts\utility::flat_angle(self.angles)[1]);
	_setvehgoalpos_wrap(maps\_utility::groundpos(self.origin),1);
	self waittill("goal");
}

//Function Number: 59
lights_on(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	common_scripts\utility::array_levelthread(var_02,::lights_on_internal,param_01);
}

//Function Number: 60
group_light(param_00,param_01,param_02)
{
	if(!isdefined(level.vehicle_lights_group))
	{
		level.vehicle_lights_group = [];
	}

	if(!isdefined(level.vehicle_lights_group[param_00]))
	{
		level.vehicle_lights_group[param_00] = [];
	}

	if(!isdefined(level.vehicle_lights_group[param_00][param_02]))
	{
		level.vehicle_lights_group[param_00][param_02] = [];
	}

	foreach(var_04 in level.vehicle_lights_group[param_00][param_02])
	{
		if(param_01 == var_04)
		{
			return;
		}
	}

	level.vehicle_lights_group[param_00][param_02][level.vehicle_lights_group[param_00][param_02].size] = param_01;
}

//Function Number: 61
lights_delayfxforframe()
{
	level notify("new_lights_delayfxforframe");
	level endon("new_lights_delayfxforframe");
	if(!isdefined(level.fxdelay))
	{
		level.fxdelay = 0;
	}

	level.fxdelay = level.fxdelay + randomfloatrange(0.2,0.4);
	if(level.fxdelay > 2)
	{
		level.fxdelay = 0;
	}

	wait(0.05);
	level.fxdelay = undefined;
}

//Function Number: 62
kill_lights(param_00)
{
	lights_off_internal("all",param_00);
}

//Function Number: 63
vehicle_aim_turret_at_angle(param_00)
{
	self endon("death");
	var_01 = anglestoforward(self.angles + (0,param_00,0));
	var_01 = var_01 * 10000;
	var_01 = var_01 + (0,0,70);
	self setturrettargetvec(var_01);
}

//Function Number: 64
vehicle_landvehicle(param_00,param_01)
{
	return _vehicle_landvehicle(param_00,param_01);
}

//Function Number: 65
_mount_snowmobile(param_00,param_01)
{
	self endon("death");
	self endon("long_death");
	if(maps\_utility::doinglongdeath())
	{
		return;
	}

	var_02 = [];
	var_02[0] = "snowmobile_driver";
	var_02[1] = "snowmobile_passenger";
	var_03 = [];
	var_03["snowmobile_driver"] = "tag_driver";
	var_03["snowmobile_passenger"] = "tag_passenger";
	var_04 = var_02[param_01];
	var_05 = var_03[var_04];
	var_06 = param_00 gettagorigin(var_05);
	var_07 = param_00 gettagangles(var_05);
	var_08 = undefined;
	var_09 = undefined;
	var_0A = 9999999;
	foreach(var_10, var_0C in level.snowmobile_mount_anims[var_04])
	{
		var_0D = maps\_utility::getanim_generic(var_10);
		var_0E = getstartorigin(var_06,var_07,var_0D);
		var_0F = distance(self.origin,var_0E);
		if(var_0F < var_0A)
		{
			var_0A = var_0F;
			var_09 = var_0E;
			var_08 = var_10;
		}
	}

	var_09 = common_scripts\utility::drop_to_ground(var_09);
	self.goalradius = 8;
	self.disablearrivals = 1;
	self setgoalpos(var_09);
	self waittill("goal");
	param_00 maps\_anim::anim_generic(self,var_08,var_05);
	param_00 thread maps\_vehicle_aianim::guy_enter(self);
	self.disablearrivals = 0;
}

//Function Number: 66
waittill_stable(param_00)
{
	var_01 = 12;
	var_02 = 400;
	var_03 = gettime() + var_02;
	if(isdefined(self.dropoff_height))
	{
		var_04 = maps\_utility::groundpos(param_00.origin) + (0,0,self.dropoff_height);
		self settargetyaw(param_00.angles[1]);
		self setvehgoalpos(var_04,1);
		self waittill("goal");
	}

	while(isdefined(self))
	{
		if(abs(self.angles[0]) > var_01 || abs(self.angles[2]) > var_01)
		{
			var_03 = gettime() + var_02;
		}

		if(gettime() > var_03)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 67
_vehicle_badplace()
{
	if(!isdefined(self.script_badplace))
	{
		return;
	}

	self endon("kill_badplace_forever");
	if(!self vehicle_isphysveh())
	{
		self endon("death");
	}

	self endon("delete");
	if(isdefined(level.custombadplacethread))
	{
		self thread [[ level.custombadplacethread ]]();
		return;
	}

	var_00 = isdefined(level.vehicle_hasmainturret[self.model]) && level.vehicle_hasmainturret[self.model];
	var_01 = 0.5;
	var_02 = 17;
	var_03 = 17;
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		if(!isdefined(self.script_badplace) || !self.script_badplace)
		{
			while(isdefined(self) && !isdefined(self.script_badplace) || !self.script_badplace)
			{
				wait(0.5);
			}

			if(!isdefined(self))
			{
				return;
			}
		}

		var_04 = self vehicle_getspeed();
		if(var_04 <= 0)
		{
			wait(var_01);
			continue;
		}

		if(var_04 < 5)
		{
			var_05 = 200;
		}
		else if(var_04 > 5 && var_04 < 8)
		{
			var_05 = 350;
		}
		else
		{
			var_05 = 500;
		}

		if(isdefined(self.badplacemodifier))
		{
			var_05 = var_05 * self.badplacemodifier;
		}

		if(var_00)
		{
			var_06 = anglestoforward(self gettagangles("tag_turret"));
		}
		else
		{
			var_06 = anglestoforward(self.angles);
		}

		badplace_arc(self.unique_id + "arc",var_01,self.origin,var_05 * 1.9,300,var_06,var_02,var_03,"axis","team3","allies");
		badplace_cylinder(self.unique_id + "cyl",var_01,self.origin,200,300,"axis","team3","allies");
		wait(var_01 + 0.05);
	}
}

//Function Number: 68
_vehicle_unload(param_00)
{
	self notify("unloading");
	var_01 = [];
	if(maps\_utility::ent_flag_exist("no_riders_until_unload"))
	{
		maps\_utility::ent_flag_set("no_riders_until_unload");
		var_01 = spawn_unload_group(param_00);
		foreach(var_03 in var_01)
		{
			maps\_utility::spawn_failed(var_03);
		}
	}

	if(isdefined(param_00))
	{
		self.unload_group = param_00;
	}

	foreach(var_06 in self.riders)
	{
		if(isalive(var_06))
		{
			var_06 notify("unload");
		}
	}

	var_01 = maps\_vehicle_aianim::animate_guys("unload");
	var_08 = level.vehicle_unloadgroups[self.classname];
	if(isdefined(var_08))
	{
		var_01 = [];
		var_09 = maps\_vehicle_aianim::get_unload_group();
		foreach(var_0B in self.riders)
		{
			if(isdefined(var_0B) && isdefined(var_0B.vehicle_position) && isdefined(var_09[var_0B.vehicle_position]))
			{
				var_01[var_01.size] = var_0B;
			}
		}
	}

	return var_01;
}

//Function Number: 69
lights_off_internal(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		param_01 = param_02;
	}
	else if(!isdefined(param_01))
	{
		param_01 = self.classname;
	}

	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	if(!isdefined(self.lights))
	{
		return;
	}

	if(!isdefined(level.vehicle_lights_group[param_01][param_00]))
	{
		return;
	}

	var_03 = level.vehicle_lights_group[param_01][param_00];
	var_04 = 0;
	var_05 = 2;
	if(isdefined(self.maxlightstopsperframe))
	{
		var_05 = self.maxlightstopsperframe;
	}

	foreach(var_07 in var_03)
	{
		var_08 = level.vehicle_lights[param_01][var_07];
		if(maps\_utility::hastag(self.model,var_08.tag))
		{
			stopfxontag(var_08.effect,self,var_08.tag);
		}

		var_04++;
		if(var_04 >= var_05)
		{
			var_04 = 0;
			wait(0.05);
		}

		if(!isdefined(self))
		{
			return;
		}

		self.lights[var_07] = undefined;
	}
}

//Function Number: 70
lights_on_internal(param_00,param_01)
{
	level.lastlighttime = gettime();
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	if(!isdefined(param_01))
	{
		param_01 = self.classname;
	}

	if(!isdefined(level.vehicle_lights_group))
	{
		return;
	}

	if(!isdefined(level.vehicle_lights_group[param_01]) || !isdefined(level.vehicle_lights_group[param_01][param_00]))
	{
		return;
	}

	thread lights_delayfxforframe();
	if(!isdefined(self.lights))
	{
		self.lights = [];
	}

	var_02 = level.vehicle_lights_group[param_01][param_00];
	var_03 = 0;
	var_04 = [];
	foreach(var_06 in var_02)
	{
		if(isdefined(self.lights[var_06]))
		{
			continue;
		}

		var_07 = level.vehicle_lights[param_01][var_06];
		if(isdefined(var_07.delay))
		{
			var_08 = var_07.delay;
		}
		else
		{
			var_08 = 0;
		}

		var_08 = var_08 + level.fxdelay;
		while(isdefined(var_04["" + var_08]))
		{
			var_08 = var_08 + 0.05;
		}

		var_04["" + var_08] = 1;
		self endon("death");
		childthread common_scripts\utility::noself_delaycall_proc(::playfxontag,var_08,var_07.effect,self,var_07.tag);
		self.lights[var_06] = 1;
		if(!isdefined(self))
		{
			break;
		}
	}

	level.fxdelay = 0;
}

//Function Number: 71
_setvehgoalpos_wrap(param_00,param_01)
{
	if(self.health <= 0)
	{
		return;
	}

	if(isdefined(self.originheightoffset))
	{
		param_00 = param_00 + (0,0,self.originheightoffset);
	}

	self setvehgoalpos(param_00,param_01);
}

//Function Number: 72
helicopter_crash_move(param_00,param_01)
{
	self endon("in_air_explosion");
	if(isdefined(self.perferred_crash_location))
	{
		var_02 = self.perferred_crash_location;
	}
	else
	{
		var_03 = get_unused_crash_locations();
		var_02 = common_scripts\utility::getclosest(self.origin,var_03);
	}

	var_02.claimed = 1;
	self notify("newpath");
	self notify("deathspin");
	var_04 = 0;
	var_05 = 0;
	if(isdefined(var_02.script_parameters) && var_02.script_parameters == "direct")
	{
		var_05 = 1;
	}

	if(isdefined(self.heli_crash_indirect_zoff))
	{
		var_05 = 0;
		var_04 = self.heli_crash_indirect_zoff;
	}

	if(var_05)
	{
		var_06 = 60;
		self vehicle_setspeed(var_06,15,10);
		self setneargoalnotifydist(var_02.radius);
		self setvehgoalpos(var_02.origin,0);
		thread helicopter_crash_flavor(var_02.origin,var_06);
		common_scripts\utility::waittill_any("goal","near_goal");
		helicopter_crash_path(var_02);
	}
	else
	{
		var_07 = (var_02.origin[0],var_02.origin[1],self.origin[2] + var_04);
		if(isdefined(self.heli_crash_lead))
		{
			var_07 = self.origin + self.heli_crash_lead * self vehicle_getvelocity();
			var_07 = (var_07[0],var_07[1],var_07[2] + var_04);
		}

		self vehicle_setspeed(40,10,10);
		self setneargoalnotifydist(300);
		self setvehgoalpos(var_07,1);
		thread helicopter_crash_flavor(var_07,40);
		var_08 = "blank";
		while(var_08 != "death")
		{
			var_08 = common_scripts\utility::waittill_any("goal","near_goal","death");
			if(!isdefined(var_08) && !isdefined(self))
			{
				var_02.claimed = undefined;
				self notify("crash_done");
				return;
			}
			else
			{
				var_08 = "death";
			}
		}

		self setvehgoalpos(var_02.origin,0);
		self waittill("goal");
		helicopter_crash_path(var_02);
	}

	var_02.claimed = undefined;
	self notify("stop_crash_loop_sound");
	self notify("crash_done");
}

//Function Number: 73
helicopter_crash_path(param_00)
{
	self endon("death");
	while(isdefined(param_00.target))
	{
		param_00 = common_scripts\utility::getstruct(param_00.target,"targetname");
		var_01 = 56;
		if(isdefined(param_00.radius))
		{
			var_01 = param_00.radius;
		}

		self setneargoalnotifydist(var_01);
		self setvehgoalpos(param_00.origin,0);
		common_scripts\utility::waittill_any("goal","near_goal");
	}
}

//Function Number: 74
helicopter_crash_flavor(param_00,param_01)
{
	self endon("crash_done");
	self clearlookatent();
	var_02 = 0;
	if(isdefined(self.preferred_crash_style))
	{
		var_02 = self.preferred_crash_style;
		if(self.preferred_crash_style < 0)
		{
			var_03 = [1,2,2];
			var_04 = 5;
			var_05 = randomint(var_04);
			var_06 = 0;
			foreach(var_09, var_08 in var_03)
			{
				var_06 = var_06 + var_08;
				if(var_05 < var_06)
				{
					var_02 = var_09;
					break;
				}
			}
		}
	}

	switch(var_02)
	{
		case 1:
			thread helicopter_crash_zigzag();
			break;

		case 2:
			thread helicopter_crash_directed(param_00,param_01);
			break;

		case 3:
			thread helicopter_in_air_explosion();
			break;

		case 0:
		default:
			thread helicopter_crash_rotate();
			break;
	}
}

//Function Number: 75
helicopter_in_air_explosion()
{
	self notify("in_air_explosion");
	wait(0.05);
	self notify("crash_done");
}

//Function Number: 76
helicopter_crash_directed(param_00,param_01)
{
	self endon("crash_done");
	self clearlookatent();
	self setmaxpitchroll(randomintrange(20,90),randomintrange(5,90));
	self setyawspeed(400,100,100);
	var_02 = 90 * randomintrange(-2,3);
	for(;;)
	{
		var_03 = param_00 - self.origin;
		var_04 = vectortoyaw(var_03);
		var_04 = var_04 + var_02;
		self settargetyaw(var_04);
		wait(0.1);
	}
}

//Function Number: 77
helicopter_crash_zigzag()
{
	self endon("crash_done");
	self clearlookatent();
	self setyawspeed(400,100,100);
	var_00 = randomint(2);
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		var_01 = randomintrange(20,120);
		if(var_00)
		{
			self settargetyaw(self.angles[1] + var_01);
		}
		else
		{
			self settargetyaw(self.angles[1] - var_01);
		}

		var_00 = 1 - var_00;
		var_02 = randomfloatrange(0.5,1);
		wait(var_02);
	}
}

//Function Number: 78
helicopter_crash_rotate()
{
	self endon("crash_done");
	self clearlookatent();
	self setyawspeed(400,100,100);
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		var_00 = randomintrange(90,120);
		self settargetyaw(self.angles[1] + var_00);
		wait(0.5);
	}
}

//Function Number: 79
get_unused_crash_locations()
{
	var_00 = [];
	level.helicopter_crash_locations = common_scripts\utility::array_removeundefined(level.helicopter_crash_locations);
	foreach(var_02 in level.helicopter_crash_locations)
	{
		if(isdefined(var_02.claimed))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 80
detach_getoutrigs()
{
	if(!isdefined(self.fastroperig))
	{
		return;
	}

	if(!self.fastroperig.size)
	{
		return;
	}

	var_00 = getarraykeys(self.fastroperig);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		self.fastroperig[var_00[var_01]] unlink();
	}
}

//Function Number: 81
_get_dummy()
{
	if(isdefined(self.modeldummyon) && self.modeldummyon)
	{
		var_00 = self.modeldummy;
	}
	else
	{
		var_00 = self;
	}

	return var_00;
}

//Function Number: 82
crash_path_check(param_00)
{
	var_01 = param_00;
	var_02 = [];
	while(isdefined(var_01))
	{
		if(isdefined(var_01.detoured) && var_01.detoured == 0)
		{
			var_03 = path_detour_get_detourpath(getvehiclenode(var_01.target,"targetname"));
			if(isdefined(var_03) && isdefined(var_03.script_crashtype))
			{
				return 1;
			}
		}

		var_02[var_02.size] = var_01;
		if(isdefined(var_01.target))
		{
			var_01 = getvehiclenode(var_01.target,"targetname");
			continue;
		}

		var_01 = undefined;
		if(isdefined(var_01) && common_scripts\utility::array_contains(var_02,var_01))
		{
			break;
		}
	}

	return 0;
}

//Function Number: 83
vehicle_kill_badplace_forever()
{
	self notify("kill_badplace_forever");
}

//Function Number: 84
kill_jolt(param_00)
{
	if(isdefined(level.vehicle_death_jolt[param_00]))
	{
		self.dontfreeme = 1;
		wait(level.vehicle_death_jolt[param_00].delay);
	}

	if(!isdefined(self))
	{
		return;
	}

	self joltbody(self.origin + (23,33,64),3);
	wait(2);
	if(!isdefined(self))
	{
		return;
	}

	self.dontfreeme = undefined;
}

//Function Number: 85
_kill_fx(param_00,param_01)
{
	if(common_scripts\utility::isdestructible() || isdefined(self.is_anim_based_death) && self.is_anim_based_death)
	{
		return;
	}

	level notify("vehicle_explosion",self.origin);
	self notify("explode",self.origin);
	if(isdefined(self.ignore_death_fx) && self.ignore_death_fx)
	{
		return;
	}

	var_02 = self.vehicletype;
	var_03 = self.classname;
	if(param_01)
	{
		var_03 = "rocket_death" + var_03;
	}

	foreach(var_05 in level.vehicle_death_fx[var_03])
	{
		thread kill_fx_thread(param_00,var_05,var_02);
	}
}

//Function Number: 86
kill_fx_thread(param_00,param_01,param_02)
{
	if(isdefined(param_01.waitdelay))
	{
		if(param_01.waitdelay >= 0)
		{
			wait(param_01.waitdelay);
		}
		else
		{
			self waittill("death_finished");
		}
	}

	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_01.notifystring))
	{
		self notify(param_01.notifystring);
	}

	var_03 = _get_dummy();
	if(isdefined(param_01.selfdeletedelay))
	{
		common_scripts\utility::delaycall(param_01.selfdeletedelay,::delete);
	}

	if(isdefined(param_01.effect))
	{
		if(param_01.beffectlooping && !isdefined(self.delete_on_death))
		{
			if(isdefined(param_01.tag))
			{
				if(isdefined(param_01.stayontag) && param_01.stayontag == 1)
				{
					thread loop_fx_on_vehicle_tag(param_01.effect,param_01.delay,param_01.tag);
				}
				else
				{
					thread playloopedfxontag(param_01.effect,param_01.delay,param_01.tag);
				}
			}
			else
			{
				var_04 = var_03.origin + (0,0,100) - var_03.origin;
				playfx(param_01.effect,var_03.origin,var_04);
			}
		}
		else if(isdefined(param_01.tag))
		{
			playfxontag(param_01.effect,deathfx_ent(),param_01.tag);
			if(isdefined(param_01.remove_deathfx_entity_delay))
			{
				deathfx_ent() common_scripts\utility::delaycall(param_01.remove_deathfx_entity_delay,::delete);
			}
		}
		else
		{
			var_04 = var_03.origin + (0,0,100) - var_03.origin;
			playfx(param_01.effect,var_03.origin,var_04);
		}
	}

	if(isdefined(param_01.sound) && !isdefined(self.delete_on_death))
	{
		if(param_01.bsoundlooping)
		{
			thread death_firesound(param_01.sound);
			return;
		}

		common_scripts\utility::play_sound_in_space(param_01.sound);
	}
}

//Function Number: 87
loop_fx_on_vehicle_tag(param_00,param_01,param_02)
{
	self endon("stop_looping_death_fx");
	while(isdefined(self))
	{
		playfxontag(param_00,deathfx_ent(),param_02);
		wait(param_01);
	}
}

//Function Number: 88
death_firesound(param_00)
{
	thread maps\_utility::play_loop_sound_on_tag(param_00,undefined,0,1);
	common_scripts\utility::waittill_any("fire_extinguish","stop_crash_loop_sound");
	if(!isdefined(self))
	{
		iprintln("^1DEBUG: Infinite looping sound for a vehicle could be happening right now...");
		return;
	}

	self notify("stop sound" + param_00);
}

//Function Number: 89
deathfx_ent()
{
	if(isdefined(self.death_fx_on_self) && self.death_fx_on_self)
	{
		return self;
	}

	if(!isdefined(self.deathfx_ent))
	{
		var_00 = spawn("script_model",(0,0,0));
		var_01 = _get_dummy();
		var_00 setmodel(self.model);
		var_00.origin = var_01.origin;
		var_00.angles = var_01.angles;
		var_00 notsolid();
		var_00 hide();
		var_00 linkto(var_01);
		self.deathfx_ent = var_00;
	}
	else
	{
		self.deathfx_ent setmodel(self.model);
	}

	return self.deathfx_ent;
}

//Function Number: 90
playloopedfxontag(param_00,param_01,param_02)
{
	var_03 = _get_dummy();
	var_04 = spawn("script_origin",var_03.origin);
	self endon("fire_extinguish");
	thread playloopedfxontag_originupdate(param_02,var_04);
	for(;;)
	{
		playfx(param_00,var_04.origin,var_04.upvec);
		wait(param_01);
	}
}

//Function Number: 91
playloopedfxontag_originupdate(param_00,param_01)
{
	param_01.angles = self gettagangles(param_00);
	param_01.origin = self gettagorigin(param_00);
	param_01.forwardvec = anglestoforward(param_01.angles);
	param_01.upvec = anglestoup(param_01.angles);
	while(isdefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0)
	{
		var_02 = _get_dummy();
		param_01.angles = var_02 gettagangles(param_00);
		param_01.origin = var_02 gettagorigin(param_00);
		param_01.forwardvec = anglestoforward(param_01.angles);
		param_01.upvec = anglestoup(param_01.angles);
		wait(0.05);
	}
}

//Function Number: 92
kill_badplace(param_00)
{
	if(!isdefined(level.vehicle_death_badplace[param_00]))
	{
		return;
	}

	var_01 = level.vehicle_death_badplace[param_00];
	if(isdefined(var_01.delay))
	{
		wait(var_01.delay);
	}

	if(!isdefined(self))
	{
		return;
	}

	badplace_cylinder("vehicle_kill_badplace",var_01.duration,self.origin,var_01.radius,var_01.height,var_01.team1,var_01.team2);
}

//Function Number: 93
turret_deleteme(param_00)
{
	if(isdefined(self))
	{
		if(isdefined(param_00.deletedelay))
		{
			wait(param_00.deletedelay);
		}
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 94
apply_truckjunk()
{
	if(!isdefined(self.truckjunk))
	{
		return;
	}

	var_00 = self.truckjunk;
	self.truckjunk = [];
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.spawner))
		{
			var_03 = common_scripts\utility::spawn_tag_origin();
			var_03.spawner = var_02.spawner;
		}
		else
		{
			var_03 = spawn("script_model",self.origin);
			var_03 setmodel(var_02.model);
		}

		var_04 = "tag_body";
		if(isdefined(var_02.script_ghettotag))
		{
			var_03.script_ghettotag = var_02.script_ghettotag;
			var_03.base_origin = var_02.origin;
			var_03.base_angles = var_02.angles;
			var_04 = var_02.script_ghettotag;
		}

		if(isdefined(var_02.destroyefx))
		{
			var_02 thread truckjunk_dyn(var_03);
		}

		if(isdefined(var_02.script_noteworthy))
		{
			var_03.script_noteworthy = var_02.script_noteworthy;
		}

		if(isdefined(var_02.script_parameters))
		{
			var_03.script_parameters = var_02.script_parameters;
		}

		var_03 linkto(self,var_04,var_02.origin,var_02.angles);
		if(isdefined(var_02.destructible_type))
		{
			var_03.destructible_type = var_02.destructible_type;
			var_03 common_scripts\_destructible::setup_destructibles(1);
		}

		self.truckjunk[self.truckjunk.size] = var_03;
	}
}

//Function Number: 95
truckjunk_dyn(param_00)
{
	param_00 endon("death");
	param_00 setcandamage(1);
	param_00.health = 8000;
	param_00 waittill("damage");
	param_00 hide();
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01 linkto(param_00);
	playfxontag(self.destroyefx,var_01,"tag_origin");
}

//Function Number: 96
truckjunk()
{
	var_00 = getent(self.target,"targetname");
	var_01 = ghetto_tag_create(var_00);
	if(isspawner(self))
	{
		var_01.spawner = self;
	}

	if(isdefined(self.targetname))
	{
		var_02 = getent(self.targetname,"target");
		if(isspawner(var_02))
		{
			var_01.spawner = var_02;
		}
	}

	if(isdefined(self.script_noteworthy))
	{
		var_01.script_noteworthy = self.script_noteworthy;
	}

	if(isdefined(self.script_parameters))
	{
		var_01.script_parameters = self.script_parameters;
	}

	if(isdefined(self.script_fxid))
	{
		var_01.destroyefx = common_scripts\utility::getfx(self.script_fxid);
	}

	if(!isdefined(var_00.truckjunk))
	{
		var_00.truckjunk = [];
	}

	if(isdefined(self.script_startingposition))
	{
		var_01.script_startingposition = self.script_startingposition;
	}

	if(isdefined(self.destructible_type))
	{
		maps\_utility::precache_destructible(self.destructible_type);
		var_01.destructible_type = self.destructible_type;
	}

	var_00.truckjunk[var_00.truckjunk.size] = var_01;
	if(!isdefined(self.classname))
	{
		return;
	}

	if(isspawner(self))
	{
		return;
	}

	self delete();
}

//Function Number: 97
ghetto_tag_create(param_00)
{
	var_01 = spawnstruct();
	var_02 = "tag_body";
	if(isdefined(self.script_ghettotag))
	{
		var_02 = self.script_ghettotag;
		var_01.script_ghettotag = self.script_ghettotag;
	}

	var_01.origin = self.origin - param_00 gettagorigin(var_02);
	if(!isdefined(self.angles))
	{
		var_03 = (0,0,0);
	}
	else
	{
		var_03 = self.angles;
	}

	var_01.angles = var_03 - param_00 gettagangles(var_02);
	var_01.model = self.model;
	if(isdefined(self.script_modelname))
	{
		precachemodel(self.script_modelname);
		var_01.model = self.script_modelname;
	}

	if(isdefined(var_01.targetname))
	{
		level.struct_class_names["targetname"][var_01.targetname] = undefined;
	}

	if(isdefined(var_01.target))
	{
		level.struct_class_names["target"][var_01.target] = undefined;
	}

	return var_01;
}

//Function Number: 98
_getvehiclespawnerarray(param_00)
{
	var_01 = getentarray("script_vehicle","code_classname");
	if(isdefined(param_00))
	{
		var_02 = [];
		foreach(var_04 in var_01)
		{
			if(!isdefined(var_04.targetname))
			{
				continue;
			}

			if(var_04.targetname == param_00)
			{
				var_02 = common_scripts\utility::array_add(var_02,var_04);
			}
		}

		var_01 = var_02;
	}

	var_06 = [];
	foreach(var_04 in var_01)
	{
		if(isspawner(var_04))
		{
			var_06[var_06.size] = var_04;
		}
	}

	return var_06;
}

//Function Number: 99
_getvehiclespawnerarray_by_spawngroup(param_00)
{
	var_01 = _getvehiclespawnerarray();
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04.script_vehiclespawngroup) && var_04.script_vehiclespawngroup == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 100
manual_tag_linkto(param_00,param_01)
{
	for(;;)
	{
		if(!isdefined(self))
		{
			break;
		}

		if(!isdefined(param_00))
		{
			break;
		}

		var_02 = param_00 gettagorigin(param_01);
		var_03 = param_00 gettagangles(param_01);
		self.origin = var_02;
		self.angles = var_03;
		wait(0.05);
	}
}

//Function Number: 101
humvee_antenna_animates(param_00)
{
	self useanimtree(#animtree);
	humvee_antenna_animates_until_death(param_00);
	if(!isdefined(self))
	{
		return;
	}

	self clearanim(param_00["idle"],0);
	self clearanim(param_00["rot_l"],0);
	self clearanim(param_00["rot_r"],0);
}

//Function Number: 102
humvee_antenna_animates_until_death(param_00)
{
	self endon("death");
	for(;;)
	{
		var_01 = self.veh_speed / 18;
		if(var_01 <= 0.0001)
		{
			var_01 = 0.0001;
		}

		var_02 = randomfloatrange(0.3,0.7);
		self setanim(param_00["idle"],var_01,0,var_02);
		var_02 = randomfloatrange(0.1,0.8);
		self setanim(param_00["rot_l"],1,0,var_02);
		var_02 = randomfloatrange(0.1,0.8);
		self setanim(param_00["rot_r"],1,0,var_02);
		wait(0.5);
	}
}

//Function Number: 103
vehicle_script_forcecolor_riders(param_00)
{
	foreach(var_02 in self.riders)
	{
		if(isai(var_02))
		{
			var_02 maps\_utility::set_force_color(param_00);
			continue;
		}

		if(isdefined(var_02.spawner))
		{
			var_02.spawner.script_forcecolor = param_00;
			continue;
		}
	}
}

//Function Number: 104
update_steering(param_00)
{
	if(param_00.update_time == gettime())
	{
		return param_00.steering;
	}

	param_00.update_time = gettime();
	if(param_00.steering_enable)
	{
		var_01 = clamp(0 - param_00.angles[2],0 - param_00.steering_maxroll,param_00.steering_maxroll) / param_00.steering_maxroll;
		if(isdefined(param_00.leanasitturns) && param_00.leanasitturns)
		{
			var_02 = param_00 vehicle_getsteering();
			var_02 = var_02 * -1;
			var_01 = var_01 + var_02;
			if(var_01 != 0)
			{
				var_03 = 1 / abs(var_01);
				if(var_03 < 1)
				{
					var_01 = var_01 * var_03;
				}
			}
		}

		var_04 = var_01 - param_00.steering;
		if(var_04 != 0)
		{
			var_05 = param_00.steering_maxdelta / abs(var_04);
			if(var_05 < 1)
			{
				var_04 = var_04 * var_05;
			}

			param_00.steering = param_00.steering + var_04;
		}
	}
	else
	{
		param_00.steering = 0;
	}

	return param_00.steering;
}

//Function Number: 105
get_from_spawnstruct(param_00)
{
	return common_scripts\utility::getstruct(param_00,"targetname");
}

//Function Number: 106
get_from_entity(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(isdefined(var_01) && var_01.size > 0)
	{
		return var_01[randomint(var_01.size)];
	}

	return undefined;
}

//Function Number: 107
get_from_spawnstruct_target(param_00)
{
	return common_scripts\utility::getstruct(param_00,"target");
}

//Function Number: 108
get_from_entity_target(param_00)
{
	return getent(param_00,"target");
}

//Function Number: 109
get_from_vehicle_node(param_00)
{
	return getvehiclenode(param_00,"targetname");
}

//Function Number: 110
set_lookat_from_dest(param_00)
{
	var_01 = getent(param_00.script_linkto,"script_linkname");
	if(!isdefined(var_01))
	{
		return;
	}

	self setlookatent(var_01);
	self.set_lookat_point = 1;
}

//Function Number: 111
damage_hint_bullet_only()
{
	level.armordamagehints = 0;
	self.displayingdamagehints = 0;
	thread damage_hints_cleanup();
	while(isdefined(self))
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(isdefined(self.has_semtex_on_it))
		{
			continue;
		}

		var_04 = tolower(var_04);
		switch(var_04)
		{
			case "mod_rifle_bullet":
			case "mod_pistol_bullet":
			case "bullet":
				if(!level.armordamagehints)
				{
					if(isdefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0)
					{
						break;
					}
	
					level.armordamagehints = 1;
					self.displayingdamagehints = 1;
					var_01 maps\_utility::display_hint("invulerable_bullets");
					wait(4);
					level.armordamagehints = 0;
					if(isdefined(self))
					{
						self.displayingdamagehints = 0;
					}
	
					break;
				}
	
				break;
		}
	}
}

//Function Number: 112
damage_hints()
{
	level.armordamagehints = 0;
	self.displayingdamagehints = 0;
	thread damage_hints_cleanup();
	while(isdefined(self))
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(isdefined(self.has_semtex_on_it))
		{
			continue;
		}

		var_04 = tolower(var_04);
		switch(var_04)
		{
			case "mod_rifle_bullet":
			case "mod_pistol_bullet":
			case "bullet":
			case "mod_grenade_splash":
			case "mod_grenade":
				if(!level.armordamagehints)
				{
					if(isdefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0)
					{
						break;
					}
	
					level.armordamagehints = 1;
					self.displayingdamagehints = 1;
					if(var_04 == "mod_grenade" || var_04 == "mod_grenade_splash")
					{
						var_01 maps\_utility::display_hint("invulerable_frags");
					}
					else
					{
						var_01 maps\_utility::display_hint("invulerable_bullets");
					}
	
					wait(4);
					level.armordamagehints = 0;
					if(isdefined(self))
					{
						self.displayingdamagehints = 0;
					}
	
					break;
				}
	
				break;
		}
	}
}

//Function Number: 113
damage_hints_cleanup()
{
	self waittill("death");
	if(self.displayingdamagehints)
	{
		level.armordamagehints = 0;
	}
}

//Function Number: 114
copy_attachments(param_00)
{
	var_01 = self getattachsize();
	var_02 = [];
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		var_02[var_03] = tolower(self getattachmodelname(var_03));
	}

	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		param_00 attach(var_02[var_03],tolower(self getattachtagname(var_03)));
	}
}

//Function Number: 115
lights_off(param_00,param_01,param_02)
{
	var_03 = strtok(param_00," ",param_01);
	common_scripts\utility::array_levelthread(var_03,::lights_off_internal,param_01,param_02);
}

//Function Number: 116
aircraft_wash_thread(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		self notify("stop_kicking_up_dust");
		if(isdefined(level._vehicle_effect_custom_param) && isdefined(level._vehicle_effect_custom_param[self.classname]) && isdefined(level._vehicle_effect_custom_param[self.classname].tags))
		{
			foreach(var_03 in level._vehicle_effect_custom_param[self.classname].tags)
			{
				thread aircraft_wash_thread(param_00,var_03);
			}

			return;
		}
	}
	else
	{
		self notify("stop_kicking_up_dust" + var_04);
		self endon("stop_kicking_up_dust" + var_04);
	}

	self endon("death");
	self endon("death_finished");
	self endon("stop_kicking_up_dust");
	var_05 = 350;
	var_06 = 2000;
	if(isdefined(level.treadfx_maxheight))
	{
		var_06 = level.treadfx_maxheight;
	}

	var_07 = 100 / var_06;
	var_08 = 0.15;
	var_09 = 0.05;
	var_0A = 0.5;
	var_0B = 3;
	var_0C = var_0B;
	var_0D = _isairplane();
	if(var_0D)
	{
		var_0A = 0.15;
	}

	var_0E = undefined;
	var_0F = undefined;
	var_10 = self;
	if(isdefined(var_03))
	{
		var_10 = var_03;
	}

	var_11 = 30;
	for(;;)
	{
		wait(var_0A);
		if(isdefined(var_04))
		{
			var_12 = var_10 gettagorigin(var_04);
			var_13 = var_10 gettagangles(var_04);
			var_13 = combineangles(var_13,(-90,0,0));
		}
		else
		{
			var_12 = var_10.origin;
			var_13 = var_10.angles;
		}

		var_14 = anglestoup(var_13) * -1;
		var_0C++;
		if(var_0C > var_0B)
		{
			var_0C = var_0B;
			var_0E = bullettrace(var_12,var_12 + var_14 * var_06,0,var_10);
		}

		if(var_0E["fraction"] == 1 || var_0E["fraction"] < var_07)
		{
			continue;
		}

		var_15 = distance(var_12,var_0E["position"]);
		var_16 = get_wash_fx(self,var_0E,var_14,var_15,var_04);
		if(!isdefined(var_16))
		{
			continue;
		}

		if(!isdefined(var_0E))
		{
			continue;
		}

		if(!isdefined(var_0E["position"]))
		{
			continue;
		}

		var_0A = var_15 - var_05 / var_06 - var_05 * var_08 - var_09 + var_09;
		var_0A = max(var_0A,var_09);
		var_17 = var_0E["position"];
		var_18 = var_0E["normal"];
		var_15 = vectordot(var_17 - var_12,var_18);
		var_19 = var_12 + (0,0,var_15);
		var_1A = var_17 - var_19;
		if(var_18[2] < -0.99)
		{
			continue;
		}

		var_1B = vectortoangles(var_18);
		if(angleclamp180(var_1B[0]) > -90 + var_11)
		{
			var_18 = anglestoforward((-90 + var_11,var_1B[1],0));
		}

		if(length(var_1A) < 1)
		{
			var_1A = anglestoforward(var_13 + (0,180,0));
		}

		if(abs(vectordot(vectornormalize(var_1A),var_18)) > 0.999)
		{
			continue;
		}

		playfx(var_16,var_17,var_18,var_1A);
	}
}

//Function Number: 117
debug_draw_arrow(param_00,param_01,param_02)
{
}

//Function Number: 118
get_wash_fx(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_01["surfacetype"];
	var_06 = undefined;
	var_07 = vectordot((0,0,-1),param_02);
	if(var_07 >= 0.97)
	{
		var_06 = undefined;
	}
	else if(var_07 >= 0.92)
	{
		var_06 = "_bank";
	}
	else
	{
		var_06 = "_bank_lg";
	}

	if(isdefined(level._vehicle_effect_custom_param) && isdefined(level._vehicle_effect_custom_param[param_00.classname]) && isdefined(level._vehicle_effect_custom_param[param_00.classname].get_surface_override_function))
	{
		var_05 = param_00 [[ level._vehicle_effect_custom_param[param_00.classname].get_surface_override_function ]](var_05,param_04);
	}

	return get_wash_effect(param_00.classname,var_05,var_06);
}

//Function Number: 119
get_wash_effect(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = param_01 + param_02;
		if(!isdefined(level._vehicle_effect[param_00][var_03]))
		{
			return get_vehicle_effect(param_00,param_01);
		}
		else
		{
			return level._vehicle_effect[param_00][var_03];
		}
	}

	return get_vehicle_effect(param_00,param_01);
}

//Function Number: 120
get_vehicle_effect(param_00,param_01)
{
	if(!isdefined(level._vehicle_effect[param_00]))
	{
		return undefined;
	}

	if(!isdefined(level._vehicle_effect[param_00][param_01]) && param_01 != "default" && param_01 != "default_script_model")
	{
		return get_vehicle_effect(param_00,"default");
	}
	else
	{
		return level._vehicle_effect[param_00][param_01];
	}

	return undefined;
}

//Function Number: 121
no_treads()
{
	return _ishelicopter() || _isairplane();
}

//Function Number: 122
vehicle_treads()
{
	var_00 = self.classname;
	if(!isdefined(level._vehicle_effect[var_00]))
	{
		return;
	}

	if(no_treads())
	{
		return;
	}

	if(isdefined(level.tread_override_thread))
	{
		self thread [[ level.tread_override_thread ]]("tag_origin","back_left",(160,0,0));
		return;
	}

	if(isdefined(level.vehicle_single_tread_list) && isdefined(level.vehicle_single_tread_list[self.vehicletype]))
	{
		thread do_single_tread();
		return;
	}

	thread do_multiple_treads();
}

//Function Number: 123
do_multiple_treads()
{
	self endon("death");
	self endon("kill_treads_forever");
	for(;;)
	{
		var_00 = tread_wait();
		if(var_00 == -1)
		{
			wait(0.1);
			continue;
		}

		var_01 = _get_dummy();
		tread(var_01,var_00,"tag_wheel_back_left","back_left",0);
		wait(0.05);
		tread(var_01,var_00,"tag_wheel_back_right","back_right",0);
		wait(0.05);
	}
}

//Function Number: 124
tread_wait()
{
	var_00 = self vehicle_getspeed();
	if(!var_00)
	{
		return -1;
	}

	var_00 = var_00 * 17.6;
	var_01 = 1 / var_00;
	var_01 = clamp(var_01 * 35,0.1,0.3);
	if(isdefined(self.treadfx_freq_scale))
	{
		var_01 = var_01 * self.treadfx_freq_scale;
	}

	wait(var_01);
	return var_01;
}

//Function Number: 125
tread(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = get_treadfx(self,param_03);
	if(!isdefined(var_06))
	{
		return;
	}

	var_07 = param_00 gettagangles(param_02);
	var_08 = anglestoforward(var_07);
	var_09 = self gettagorigin(param_02);
	if(param_04)
	{
		var_0A = self gettagorigin(param_05);
		var_09 = var_09 + var_0A / 2;
	}

	playfx(var_06,var_09,anglestoup(var_07),var_08 * param_01);
}

//Function Number: 126
get_treadfx(param_00,param_01)
{
	var_02 = self getwheelsurface(param_01);
	if(!isdefined(param_00.vehicletype))
	{
		var_03 = -1;
		return var_03;
	}

	var_04 = param_01.classname;
	return get_vehicle_effect(var_04,var_03);
}

//Function Number: 127
do_single_tread()
{
	self endon("death");
	self endon("kill_treads_forever");
	for(;;)
	{
		var_00 = tread_wait();
		if(var_00 == -1)
		{
			wait(0.1);
			continue;
		}

		var_01 = _get_dummy();
		var_01 tread(var_01,var_00,"tag_wheel_back_left","back_left",1,"tag_wheel_back_right");
	}
}

//Function Number: 128
_ishelicopter()
{
	return isdefined(level.helicopter_list[self.vehicletype]);
}

//Function Number: 129
_isairplane()
{
	return isdefined(level.airplane_list[self.vehicletype]);
}

//Function Number: 130
ischeap()
{
	if(!isdefined(self.script_cheap))
	{
		return 0;
	}

	if(!self.script_cheap)
	{
		return 0;
	}

	return 1;
}

//Function Number: 131
hashelicopterdustkickup()
{
	if(!_ishelicopter() && !_isairplane())
	{
		return 0;
	}

	if(ischeap())
	{
		return 0;
	}

	return 1;
}

//Function Number: 132
hashelicopterturret()
{
	if(!isdefined(self.vehicletype))
	{
		return 0;
	}

	if(ischeap())
	{
		return 0;
	}

	if(self.vehicletype == "cobra")
	{
		return 1;
	}

	if(self.vehicletype == "cobra_player")
	{
		return 1;
	}

	if(self.vehicletype == "viper")
	{
		return 1;
	}

	return 0;
}

//Function Number: 133
disconnect_paths_whenstopped()
{
	self endon("death");
	var_00 = 0;
	if(isdefined(self.script_disconnectpaths) && !self.script_disconnectpaths)
	{
		var_00 = 1;
	}

	if(var_00)
	{
		self.dontdisconnectpaths = 1;
		return;
	}

	wait(randomfloat(1));
	while(isdefined(self))
	{
		if(self vehicle_getspeed() < 1)
		{
			if(!isdefined(self.dontdisconnectpaths))
			{
				self disconnectpaths();
			}
			else
			{
			}

			self notify("speed_zero_path_disconnect");
			while(self vehicle_getspeed() < 1)
			{
				wait(0.05);
			}
		}

		self connectpaths();
		wait(1);
	}
}

//Function Number: 134
mginit()
{
	var_00 = self.classname;
	if(isdefined(self.script_nomg) && self.script_nomg > 0)
	{
		return;
	}

	if(!isdefined(level.vehicle_mgturret[var_00]))
	{
		return;
	}

	var_01 = 0;
	if(isdefined(self.script_mg_angle))
	{
		var_01 = self.script_mg_angle;
	}

	var_02 = level.vehicle_mgturret[var_00];
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = isdefined(self.script_noteworthy) && self.script_noteworthy == "onemg";
	foreach(var_07, var_05 in var_02)
	{
		var_06 = spawnturret("misc_turret",(0,0,0),var_05.info);
		if(isdefined(var_05.offset_tag))
		{
			var_06 linkto(self,var_05.tag,var_05.offset_tag,(0,-1 * var_01,0));
		}
		else
		{
			var_06 linkto(self,var_05.tag,(0,0,0),(0,-1 * var_01,0));
		}

		var_06 setmodel(var_05.model);
		var_06.angles = self.angles;
		var_06.isvehicleattached = 1;
		var_06.ownervehicle = self;
		var_06.script_team = self.script_team;
		var_06 thread maps\_mgturret::burst_fire_unmanned();
		var_06 makeunusable();
		set_turret_team(var_06);
		level thread maps\_mgturret::mg42_setdifficulty(var_06,maps\_utility::getdifficulty());
		if(isdefined(self.script_fireondrones))
		{
			var_06.script_fireondrones = self.script_fireondrones;
		}

		if(isdefined(var_05.deletedelay))
		{
			var_06.deletedelay = var_05.deletedelay;
		}

		if(isdefined(var_05.maxrange))
		{
			var_06.maxrange = var_05.maxrange;
		}

		if(isdefined(var_05.defaultdroppitch))
		{
			var_06 setdefaultdroppitch(var_05.defaultdroppitch);
		}

		self.mgturret[var_07] = var_06;
		if(var_03)
		{
			break;
		}
	}

	foreach(var_0A, var_06 in self.mgturret)
	{
		var_09 = level.vehicle_mgturret[var_00][var_0A].defaultonmode;
		if(isdefined(var_09))
		{
			var_06 turret_set_default_on_mode(var_09);
		}
	}

	if(!isdefined(self.script_turretmg))
	{
		self.script_turretmg = 1;
	}

	if(self.script_turretmg == 0)
	{
		thread _mgoff();
		return;
	}

	self.script_turretmg = 1;
	thread _mgon();
}

//Function Number: 135
turret_set_default_on_mode(param_00)
{
	self.defaultonmode = param_00;
}

//Function Number: 136
set_turret_team(param_00)
{
	switch(self.script_team)
	{
		case "allies":
		case "friendly":
			param_00 setturretteam("allies");
			break;

		case "axis":
		case "enemy":
			param_00 setturretteam("axis");
			break;

		case "team3":
			param_00 setturretteam("team3");
			break;

		default:
			break;
	}
}

//Function Number: 137
animate_drive_idle()
{
	self endon("suspend_drive_anims");
	if(!isdefined(self.wheeldir))
	{
		self.wheeldir = 1;
	}

	var_00 = self.model;
	var_01 = -1;
	var_02 = undefined;
	self useanimtree(#animtree);
	if(!isdefined(level.vehicle_driveidle[var_00]))
	{
		return;
	}

	if(!isdefined(level.vehicle_driveidle_r[var_00]))
	{
		level.vehicle_driveidle_r[var_00] = level.vehicle_driveidle[var_00];
	}

	self endon("death");
	var_03 = level.vehicle_driveidle_normal_speed[var_00];
	var_04 = 1;
	if(isdefined(level.vehicle_driveidle_animrate) && isdefined(level.vehicle_driveidle_animrate[var_00]))
	{
		var_04 = level.vehicle_driveidle_animrate[var_00];
	}

	var_05 = self.wheeldir;
	var_06 = self;
	var_07 = level.vehicle_driveidle[var_00];
	for(;;)
	{
		if(isdefined(level.animate_drive_idle_on_dummies))
		{
			var_06 = _get_dummy();
		}

		if(!var_03)
		{
			if(isdefined(self.suspend_driveanims))
			{
				wait(0.05);
				continue;
			}

			var_06 setanim(level.vehicle_driveidle[var_00],1,0.2,var_04);
			return;
		}

		var_08 = self vehicle_getspeed();
		if(self.modeldummyon && isdefined(self.dummyspeed))
		{
			var_08 = self.dummyspeed;
		}

		if(var_05 != self.wheeldir)
		{
			var_09 = 0;
			if(self.wheeldir)
			{
				var_07 = level.vehicle_driveidle[var_00];
				var_09 = 1 - var_06 getnormalanimtime(level.vehicle_driveidle_r[var_00]);
				var_06 clearanim(level.vehicle_driveidle_r[var_00],0);
			}
			else
			{
				var_07 = level.vehicle_driveidle_r[var_00];
				var_09 = 1 - var_06 getnormalanimtime(level.vehicle_driveidle[var_00]);
				var_06 clearanim(level.vehicle_driveidle[var_00],0);
			}

			var_02 = 0.01;
			if(var_02 >= 1 || var_02 == 0)
			{
				var_02 = 0.01;
			}

			var_05 = self.wheeldir;
		}

		var_0A = var_08 / var_03;
		if(var_0A != var_01)
		{
			var_06 setanim(var_07,1,0.05,var_0A);
			var_01 = var_0A;
		}

		if(isdefined(var_02))
		{
			var_06 setanimtime(var_07,var_02);
			var_02 = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 138
setup_dynamic_detour(param_00,param_01)
{
	var_02 = [[ param_01 ]](param_00.targetname);
	var_02.detoured = 0;
}

//Function Number: 139
setup_ai()
{
	foreach(var_01 in getaiarray())
	{
		if(isdefined(var_01.script_vehicleride))
		{
			level.vehicle_rideai = array_2dadd(level.vehicle_rideai,var_01.script_vehicleride,var_01);
		}
	}

	foreach(var_01 in getspawnerarray())
	{
		if(isdefined(var_01.script_vehicleride))
		{
			level.vehicle_ridespawners = array_2dadd(level.vehicle_ridespawners,var_01.script_vehicleride,var_01);
		}
	}

	if(isdefined(level.spawn_pool_enabled))
	{
		foreach(var_06 in level.struct)
		{
			if(isdefined(var_06.script_vehicleride) && isdefined(var_06.script_spawn_pool))
			{
				level.vehicle_ridespawners = array_2dadd(level.vehicle_ridespawners,var_06.script_vehicleride,var_06);
			}
		}
	}
}

//Function Number: 140
array_2dadd(param_00,param_01,param_02)
{
	if(!isdefined(param_00[param_01]))
	{
		param_00[param_01] = [];
	}

	param_00[param_01][param_00[param_01].size] = param_02;
	return param_00;
}

//Function Number: 141
is_node_script_origin(param_00)
{
	return isdefined(param_00.classname) && param_00.classname == "script_origin";
}

//Function Number: 142
node_trigger_process()
{
	var_00 = 0;
	if(isdefined(self.spawnflags) && self.spawnflags & 1)
	{
		if(isdefined(self.script_crashtype))
		{
			level.vehicle_crashpaths[level.vehicle_crashpaths.size] = self;
		}

		level.vehicle_startnodes[level.vehicle_startnodes.size] = self;
	}

	if(isdefined(self.script_vehicledetour) && isdefined(self.targetname))
	{
		var_01 = undefined;
		if(isdefined(get_from_entity(self.targetname)))
		{
			var_01 = ::get_from_entity_target;
		}

		if(isdefined(get_from_spawnstruct(self.targetname)))
		{
			var_01 = ::get_from_spawnstruct_target;
		}

		if(isdefined(var_01))
		{
			setup_dynamic_detour(self,var_01);
			var_00 = 1;
		}
		else
		{
			setup_groundnode_detour(self);
		}

		level.vehicle_detourpaths = array_2dadd(level.vehicle_detourpaths,self.script_vehicledetour,self);
		if(level.vehicle_detourpaths[self.script_vehicledetour].size > 2)
		{
		}
	}

	if(isdefined(self.script_gatetrigger))
	{
		level.vehicle_gatetrigger = array_2dadd(level.vehicle_gatetrigger,self.script_gatetrigger,self);
		self.gateopen = 0;
	}

	if(isdefined(self.script_flag_set))
	{
		if(!isdefined(level.flag[self.script_flag_set]))
		{
			common_scripts\utility::flag_init(self.script_flag_set);
		}
	}

	if(isdefined(self.script_flag_clear))
	{
		if(!isdefined(level.flag[self.script_flag_clear]))
		{
			common_scripts\utility::flag_init(self.script_flag_clear);
		}
	}

	if(isdefined(self.script_flag_wait))
	{
		if(!isdefined(level.flag[self.script_flag_wait]))
		{
			common_scripts\utility::flag_init(self.script_flag_wait);
		}
	}

	if(isdefined(self.script_vehiclespawngroup) || isdefined(self.script_vehiclestartmove) || isdefined(self.script_gatetrigger) || isdefined(self.script_vehiclegroupdelete))
	{
		var_00 = 1;
	}

	if(var_00)
	{
		add_proccess_trigger(self);
	}
}

//Function Number: 143
setup_triggers()
{
	level.vehicle_processtriggers = [];
	var_00 = [];
	var_00 = common_scripts\utility::array_combine(getallvehiclenodes(),getentarray("script_origin","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,level.struct);
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_radius","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_disk","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_multiple","code_classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("trigger_lookat","code_classname"));
	common_scripts\utility::array_thread(var_00,::node_trigger_process);
}

//Function Number: 144
is_node_script_struct(param_00)
{
	if(!isdefined(param_00.targetname))
	{
		return 0;
	}

	return isdefined(common_scripts\utility::getstruct(param_00.targetname,"targetname"));
}

//Function Number: 145
setup_vehicles(param_00)
{
	var_01 = [];
	level.failed_spawnvehicles = [];
	foreach(var_03 in param_00)
	{
		if(var_03 check_spawn_group_isspawner())
		{
			continue;
		}
		else
		{
			var_01[var_01.size] = var_03;
		}
	}

	check_failed_spawn_groups();
	foreach(var_06 in var_01)
	{
		thread vehicle_init(var_06);
	}
}

//Function Number: 146
check_failed_spawn_groups()
{
	if(!level.failed_spawnvehicles.size)
	{
		level.failed_spawnvehicles = undefined;
		return;
	}

	foreach(var_01 in level.failed_spawnvehicles)
	{
	}
}

//Function Number: 147
check_spawn_group_isspawner()
{
	if(isdefined(self.script_vehiclespawngroup) && !isspawner(self))
	{
		level.failed_spawnvehicles[level.failed_spawnvehicles.size] = self;
		return 1;
	}

	return isspawner(self);
}

//Function Number: 148
vehicle_life()
{
	var_00 = self.classname;
	if(!isdefined(level.vehicle_life) || !isdefined(level.vehicle_life[var_00]))
	{
		wait(2);
	}

	if(isdefined(self.script_startinghealth))
	{
		self.health = self.script_startinghealth;
	}
	else if(level.vehicle_life[var_00] == -1)
	{
		return;
	}
	else if(isdefined(level.vehicle_life_range_low[var_00]) && isdefined(level.vehicle_life_range_high[var_00]))
	{
		self.health = randomint(level.vehicle_life_range_high[var_00] - level.vehicle_life_range_low[var_00]) + level.vehicle_life_range_low[var_00];
	}
	else
	{
		self.health = level.vehicle_life[var_00];
	}

	if(isdefined(level.destructible_model[self.model]))
	{
		self.health = 2000;
		self.destructible_type = level.destructible_model[self.model];
		common_scripts\_destructible::setup_destructibles(1);
	}
}

//Function Number: 149
setturretfireondrones(param_00)
{
	if(isdefined(self.mgturret) && self.mgturret.size)
	{
		foreach(var_02 in self.mgturret)
		{
			var_02.script_fireondrones = param_00;
		}
	}
}

//Function Number: 150
getnormalanimtime(param_00)
{
	var_01 = self getanimtime(param_00);
	var_02 = getanimlength(param_00);
	if(var_01 == 0)
	{
		return 0;
	}

	return self getanimtime(param_00) / getanimlength(param_00);
}

//Function Number: 151
rotor_anim()
{
	var_00 = getanimlength(maps\_utility::getanim("rotors"));
	for(;;)
	{
		self setanim(maps\_utility::getanim("rotors"),1,0,1);
		wait(var_00);
	}
}

//Function Number: 152
suspend_drive_anims()
{
	self notify("suspend_drive_anims");
	var_00 = self.model;
	self clearanim(level.vehicle_driveidle[var_00],0);
	self clearanim(level.vehicle_driveidle_r[var_00],0);
}

//Function Number: 153
idle_animations()
{
	self useanimtree(#animtree);
	if(!isdefined(level.vehicle_idleanim[self.model]))
	{
		return;
	}

	foreach(var_01 in level.vehicle_idleanim[self.model])
	{
		self setanim(var_01);
	}
}

//Function Number: 154
vehicle_rumble()
{
	self endon("kill_rumble_forever");
	var_00 = self.classname;
	var_01 = undefined;
	if(isdefined(self.vehicle_rumble_unique))
	{
		var_01 = self.vehicle_rumble_unique;
	}
	else if(isdefined(level.vehicle_rumble_override) && isdefined(level.vehicle_rumble_override[var_00]))
	{
		var_01 = level.vehicle_rumble_override;
	}
	else if(isdefined(level.vehicle_rumble[var_00]))
	{
		var_01 = level.vehicle_rumble[var_00];
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01.radius * 2;
	var_03 = -1 * var_01.radius;
	var_04 = spawn("trigger_radius",self.origin + (0,0,var_03),0,var_01.radius,var_02);
	var_04 enablelinkto();
	var_04 linkto(self);
	self.rumbletrigger = var_04;
	self endon("death");
	if(!isdefined(self.rumbleon))
	{
		self.rumbleon = 1;
	}

	if(isdefined(var_01.scale))
	{
		self.rumble_scale = var_01.scale;
	}
	else
	{
		self.rumble_scale = 0.15;
	}

	if(isdefined(var_01.duration))
	{
		self.rumble_duration = var_01.duration;
	}
	else
	{
		self.rumble_duration = 4.5;
	}

	if(isdefined(var_01.radius))
	{
		self.rumble_radius = var_01.radius;
	}
	else
	{
		self.rumble_radius = 600;
	}

	if(isdefined(var_01.basetime))
	{
		self.rumble_basetime = var_01.basetime;
	}
	else
	{
		self.rumble_basetime = 1;
	}

	if(isdefined(var_01.randomaditionaltime))
	{
		self.rumble_randomaditionaltime = var_01.randomaditionaltime;
	}
	else
	{
		self.rumble_randomaditionaltime = 1;
	}

	var_04.radius = self.rumble_radius;
	for(;;)
	{
		var_04 waittill("trigger");
		if(self vehicle_getspeed() == 0 || !self.rumbleon)
		{
			wait(0.1);
			continue;
		}

		self playrumblelooponentity(var_01.rumble);
		while(level.player istouching(var_04) && self.rumbleon && self vehicle_getspeed() > 0)
		{
			earthquake(self.rumble_scale,self.rumble_duration,self.origin,self.rumble_radius);
			wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
		}

		self stoprumble(var_01.rumble);
	}
}

//Function Number: 155
vehicle_kill_treads_forever()
{
	self notify("kill_treads_forever");
}

//Function Number: 156
isstationary()
{
	var_00 = self.vehicletype;
	if(isdefined(level.vehicle_isstationary[var_00]) && level.vehicle_isstationary[var_00])
	{
		return 1;
	}

	return 0;
}

//Function Number: 157
vehicle_shoot_shock()
{
	if(!isdefined(level.vehicle_shoot_shock[self.classname]))
	{
		return;
	}

	if(getdvar("disable_tank_shock_minspec") == "1")
	{
		return;
	}

	self endon("death");
	self endon("stop_vehicle_shoot_shock");
	for(;;)
	{
		self waittill("weapon_fired");
		if(isdefined(self.shock_distance))
		{
			var_00 = self.shock_distance;
		}
		else
		{
			var_00 = 400;
		}

		var_01 = distance(self.origin,level.player.origin);
		if(var_01 > var_00)
		{
			continue;
		}

		if(isdefined(level.player.flashendtime) && level.player.flashendtime - gettime() > 200)
		{
			continue;
		}

		if(isdefined(self.shellshock_audio_disabled) && self.shellshock_audio_disabled)
		{
			continue;
		}

		if(isdefined(self.shellshock_time))
		{
			var_02 = self.shellshock_time;
		}
		else
		{
			var_03 = var_01 / var_00;
			var_02 = 4 - 3 * var_03;
		}

		level.player shellshock(level.vehicle_shoot_shock[self.classname],var_02);
	}
}

//Function Number: 158
vehicle_setteam()
{
	var_00 = self.classname;
	if(!isdefined(self.script_team) && isdefined(level.vehicle_team[var_00]))
	{
		self.script_team = level.vehicle_team[var_00];
	}

	level.vehicles[self.script_team] = common_scripts\utility::array_add(level.vehicles[self.script_team],self);
}

//Function Number: 159
vehicle_handleunloadevent()
{
	self endon("death");
	var_00 = self.vehicletype;
	if(!maps\_utility::ent_flag_exist("unloaded"))
	{
		maps\_utility::ent_flag_init("unloaded");
	}
}

//Function Number: 160
get_vehiclenode_any_dynamic(param_00)
{
	var_01 = getvehiclenode(param_00,"targetname");
	if(!isdefined(var_01))
	{
		var_01 = getent(param_00,"targetname");
	}
	else if(_ishelicopter())
	{
	}

	if(!isdefined(var_01))
	{
		var_02 = common_scripts\utility::getstructarray(param_00,"targetname");
		var_03 = [];
		if(isdefined(var_02))
		{
			foreach(var_05 in var_02)
			{
				if(isdefined(var_05.script_unloadtype))
				{
					continue;
				}

				var_03[var_03.size] = var_05;
			}
		}

		if(var_03.size == 1)
		{
			var_01 = var_03[0];
		}
		else
		{
			var_01 = undefined;
		}
	}

	return var_01;
}

//Function Number: 161
vehicle_resumepathvehicle()
{
	if(!_ishelicopter())
	{
		self resumespeed(35);
		return;
	}

	var_00 = undefined;
	if(isdefined(self.currentnode.target))
	{
		var_00 = get_vehiclenode_any_dynamic(self.currentnode.target);
	}

	if(!isdefined(var_00))
	{
		return;
	}

	_vehicle_paths(var_00);
}

//Function Number: 162
has_frontarmor()
{
	return isdefined(level.vehicle_frontarmor[self.vehicletype]);
}

//Function Number: 163
grenadeshielded(param_00)
{
	if(!isdefined(self.script_grenadeshield))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	if(!isdefined(param_00) || !issubstr(param_00,"grenade"))
	{
		return 0;
	}

	if(self.script_grenadeshield)
	{
		return 1;
	}

	return 0;
}

//Function Number: 164
bulletshielded(param_00)
{
	if(!isdefined(self.script_bulletshield))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	if(!isdefined(param_00) || !issubstr(param_00,"bullet") || issubstr(param_00,"explosive"))
	{
		return 0;
	}

	if(self.script_bulletshield)
	{
		return 1;
	}

	return 0;
}

//Function Number: 165
explosive_bulletshielded(param_00)
{
	if(!isdefined(self.script_explosive_bullet_shield))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	if(!isdefined(param_00) || !issubstr(param_00,"explosive"))
	{
		return 0;
	}

	if(self.script_explosive_bullet_shield)
	{
		return 1;
	}

	return 0;
}

//Function Number: 166
vehicle_should_regenerate(param_00,param_01)
{
	return (!isdefined(param_00) && self.script_team != "neutral") || attacker_isonmyteam(param_00) || attacker_troop_isonmyteam(param_00) || common_scripts\utility::isdestructible() || is_invulnerable_from_ai(param_00) || bulletshielded(param_01) || explosive_bulletshielded(param_01) || grenadeshielded(param_01) || param_01 == "MOD_MELEE" || param_01 == "MOD_MELEE_ALT";
}

//Function Number: 167
friendlyfire_shield()
{
	self endon("death");
	if(!isdefined(level.unstoppable_friendly_fire_shield))
	{
		self endon("stop_friendlyfire_shield");
	}

	var_00 = self.classname;
	if(isdefined(level.vehicle_bulletshield[var_00]) && !isdefined(self.script_bulletshield))
	{
		self.script_bulletshield = level.vehicle_bulletshield[var_00];
	}

	if(isdefined(level.vehicle_grenadeshield[var_00]) && !isdefined(self.script_grenadeshield))
	{
		self.script_grenadeshield = level.vehicle_grenadeshield[var_00];
	}

	if(isdefined(self.script_mp_style_helicopter))
	{
		self.script_mp_style_helicopter = 1;
		self.bullet_armor = 5000;
		self.health = 350;
	}
	else
	{
		self.script_mp_style_helicopter = 0;
	}

	self.healthbuffer = 20000;
	self.health = self.health + self.healthbuffer;
	self.currenthealth = self.health;
	var_01 = undefined;
	var_02 = undefined;
	for(var_03 = undefined;self.health > 0;var_03 = undefined)
	{
		self waittill("damage",var_04,var_01,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
		foreach(var_0C in self.damage_functions)
		{
			thread [[ var_0C ]](var_04,var_01,var_05,var_06,var_02,var_07,var_08);
		}

		if(isdefined(var_01))
		{
			var_01 maps\_player_stats::register_shot_hit();
		}

		if(vehicle_should_regenerate(var_01,var_02) || _is_godmode())
		{
			self.health = self.currenthealth;
		}
		else if(has_frontarmor())
		{
			regen_front_armor(var_01,var_04);
			self.currenthealth = self.health;
		}
		else if(hit_bullet_armor(var_02))
		{
			self.health = self.currenthealth;
			self.bullet_armor = self.bullet_armor - var_04;
		}
		else
		{
			self.currenthealth = self.health;
		}

		if(common_scripts\_destructible::getdamagetype(var_02) == "splash")
		{
			self.rocket_destroyed_for_achievement = 1;
		}
		else
		{
			self.rocket_destroyed_for_achievement = undefined;
		}

		if(self.health < self.healthbuffer && !isdefined(self.vehicle_stays_alive))
		{
			break;
		}

		var_04 = undefined;
		var_01 = undefined;
		var_05 = undefined;
		var_06 = undefined;
		var_02 = undefined;
		var_07 = undefined;
		var_08 = undefined;
		var_09 = undefined;
		var_0A = undefined;
	}

	self notify("death",var_01,var_02,var_03);
}

//Function Number: 168
hit_bullet_armor(param_00)
{
	if(!self.script_mp_style_helicopter)
	{
		return 0;
	}

	if(self.bullet_armor <= 0)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!issubstr(param_00,"BULLET"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 169
regen_front_armor(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(param_00.origin - self.origin);
	if(vectordot(var_02,var_03) > 0.86)
	{
		self.health = self.health + int(param_01 * level.vehicle_frontarmor[self.vehicletype]);
	}
}

//Function Number: 170
_is_godmode()
{
	if(isdefined(self.godmode) && self.godmode)
	{
		return 1;
	}

	return 0;
}

//Function Number: 171
is_invulnerable_from_ai(param_00)
{
	if(!isdefined(self.script_ai_invulnerable))
	{
		return 0;
	}

	if(isdefined(param_00) && isai(param_00) && self.script_ai_invulnerable == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 172
attacker_troop_isonmyteam(param_00)
{
	if(isdefined(self.script_team) && self.script_team == "allies" && isdefined(param_00) && isplayer(param_00))
	{
		return 1;
	}

	if(isai(param_00) && param_00.team == self.script_team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 173
attacker_isonmyteam(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.script_team) && isdefined(self.script_team) && param_00.script_team == self.script_team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 174
vehicle_badplace()
{
	return _vehicle_badplace();
}

//Function Number: 175
wheeldirectionchange(param_00)
{
	self.wheeldir = common_scripts\utility::ter_op(param_00 <= 0,0,1);
}

//Function Number: 176
maingun_fx()
{
	if(isdefined(level.maingun_fx_override))
	{
		thread [[ level.maingun_fx_override ]]();
		return;
	}

	var_00 = self.model;
	if(!isdefined(level.vehicle_deckdust[var_00]))
	{
		return;
	}

	self endon("death");
	for(;;)
	{
		self waittill("weapon_fired");
		playfxontag(level.vehicle_deckdust[var_00],self,"tag_engine_exhaust");
		var_01 = self gettagorigin("tag_flash");
		var_02 = physicstrace(var_01,var_01 + (0,0,-128));
		physicsexplosionsphere(var_02,192,100,1);
	}
}

//Function Number: 177
playtankexhaust()
{
	self endon("death");
	var_00 = self.model;
	if(!isdefined(level.vehicle_exhaust[var_00]))
	{
		return;
	}

	var_01 = 0.1;
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		if(!isalive(self))
		{
			return;
		}

		playfxontag(level.vehicle_exhaust[var_00],_get_dummy(),"tag_engine_exhaust");
		wait(var_01);
	}
}

//Function Number: 178
getonpath(param_00)
{
	var_01 = undefined;
	var_02 = self.vehicletype;
	if(isdefined(self.vehicle_spawner))
	{
		if(isdefined(self.vehicle_spawner.dontgetonpath) && self.dontgetonpath)
		{
			return;
		}
	}

	if(isdefined(self.target))
	{
		var_01 = getvehiclenode(self.target,"targetname");
		if(!isdefined(var_01))
		{
			var_03 = getentarray(self.target,"targetname");
			foreach(var_05 in var_03)
			{
				if(var_05.code_classname == "script_origin")
				{
					var_01 = var_05;
					break;
				}
			}
		}

		if(!isdefined(var_01))
		{
			var_01 = common_scripts\utility::getstruct(self.target,"targetname");
		}
	}

	if(!isdefined(var_01))
	{
		if(_ishelicopter())
		{
			if(isdefined(self.vehicle_heli_default_path_speeds))
			{
				self [[ self.vehicle_heli_default_path_speeds ]]();
			}
			else
			{
				self vehicle_setspeed(60,20,10);
			}
		}

		return;
	}

	self.attachedpath = var_01;
	if(!_ishelicopter())
	{
		self.origin = var_01.origin;
		if(!isdefined(param_00))
		{
			self attachpath(var_01);
		}
	}
	else if(isdefined(self.speed))
	{
		self vehicle_setspeedimmediate(self.speed,20);
	}
	else if(isdefined(var_01.speed))
	{
		if(isdefined(self.vehicle_heli_default_path_speeds))
		{
			self [[ self.vehicle_heli_default_path_speeds ]](var_01.speed,var_01.script_accel,var_01.script_decel);
		}
		else
		{
			var_07 = 20;
			var_08 = 10;
			if(isdefined(var_01.script_accel))
			{
				var_07 = var_01.script_accel;
			}

			if(isdefined(var_01.script_decel))
			{
				var_07 = var_01.script_decel;
			}

			self vehicle_setspeedimmediate(var_01.speed,var_07,var_08);
		}
	}
	else if(isdefined(self.vehicle_heli_default_path_speeds))
	{
		self [[ self.vehicle_heli_default_path_speeds ]]();
	}
	else
	{
		self vehicle_setspeed(60,20,10);
	}

	thread _vehicle_paths(undefined,_ishelicopter());
}

//Function Number: 179
_vehicle_resume_named(param_00)
{
	var_01 = self.vehicle_stop_named[param_00];
	self.vehicle_stop_named[param_00] = undefined;
	if(self.vehicle_stop_named.size)
	{
		return;
	}

	self resumespeed(var_01);
}

//Function Number: 180
_vehicle_stop_named(param_00,param_01,param_02)
{
	if(!isdefined(self.vehicle_stop_named))
	{
		self.vehicle_stop_named = [];
	}

	self vehicle_setspeed(0,param_01,param_02);
	self.vehicle_stop_named[param_00] = param_01;
}

//Function Number: 181
unload_node(param_00)
{
	self endon("death");
	if(isdefined(self.ent_flag["prep_unload"]) && maps\_utility::ent_flag("prep_unload"))
	{
		return;
	}

	if(issubstr(self.classname,"snowmobile"))
	{
		while(self.veh_speed > 15)
		{
			wait(0.05);
		}
	}

	if(!isdefined(param_00.script_flag_wait) && !isdefined(param_00.script_delay))
	{
		self notify("newpath");
	}

	var_01 = getnode(param_00.targetname,"target");
	if(isdefined(var_01) && self.riders.size)
	{
		foreach(var_03 in self.riders)
		{
			if(isai(var_03))
			{
				var_03 thread maps\_spawner::go_to_node(var_01);
			}
		}
	}

	if(_ishelicopter())
	{
		if(isdefined(self.parachute_unload))
		{
			self setmaxpitchroll(0,0);
			waittill_dropoff_height();
			common_scripts\utility::delaycall(5,::setmaxpitchroll,15,15);
		}
		else
		{
			self sethoverparams(0);
			waittill_stable(param_00);
		}
	}
	else if(!isdefined(self.moving_unload) || !self.moving_unload)
	{
		self vehicle_setspeed(0,35);
	}

	if(isdefined(param_00.script_noteworthy))
	{
		if(param_00.script_noteworthy == "wait_for_flag")
		{
			common_scripts\utility::flag_wait(param_00.script_flag);
		}
	}

	_vehicle_unload(param_00.script_unload);
	if(maps\_vehicle_aianim::riders_unloadable(param_00.script_unload))
	{
		if(isdefined(self.parachute_unload))
		{
			if(isdefined(param_00.script_noteworthy))
			{
				if(param_00.script_noteworthy == "para_unload_stop")
				{
					self waittill("unloaded");
				}
			}
		}
		else
		{
			self waittill("unloaded");
		}
	}

	if(isdefined(param_00.script_flag_wait) || isdefined(param_00.script_delay))
	{
		return;
	}

	if(isdefined(self))
	{
		thread vehicle_resumepathvehicle();
	}
}

//Function Number: 182
move_turrets_here(param_00)
{
	var_01 = self.classname;
	if(!isdefined(self.mgturret))
	{
		return;
	}

	if(self.mgturret.size == 0)
	{
		return;
	}

	foreach(var_04, var_03 in self.mgturret)
	{
		var_03 unlink();
		var_03 linkto(param_00,level.vehicle_mgturret[var_01][var_04].tag,(0,0,0),(0,0,0));
	}
}

//Function Number: 183
vehicle_pathdetach()
{
	self.attachedpath = undefined;
	self notify("newpath");
	self setgoalyaw(common_scripts\utility::flat_angle(self.angles)[1]);
	self setvehgoalpos(self.origin + (0,0,4),1);
}

//Function Number: 184
waittill_dropoff_height()
{
	var_00 = 4;
	var_01 = 400;
	var_02 = gettime() + var_01;
	while(isdefined(self))
	{
		var_03 = self.origin[2] - self.currentnode.origin[2];
		if(abs(var_03) <= var_00)
		{
			return;
		}
		else
		{
			var_02 = gettime() + var_01;
		}

		if(gettime() > var_02)
		{
			iprintln("Chopper parachute unload: waittill_dropoff_height timed out!");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 185
deathrollon()
{
	if(self.health > 0)
	{
		self.rollingdeath = 1;
	}
}

//Function Number: 186
deathrolloff()
{
	self.rollingdeath = undefined;
	self notify("deathrolloff");
}

//Function Number: 187
_mgoff()
{
	self.script_turretmg = 0;
	if(_ishelicopter() && hashelicopterturret())
	{
		if(isdefined(level.chopperturretfunc))
		{
			self thread [[ level.chopperturretofffunc ]]();
			return;
		}
	}

	if(!isdefined(self.mgturret))
	{
		return;
	}

	foreach(var_01 in self.mgturret)
	{
		if(isdefined(var_01.script_fireondrones))
		{
			var_01.script_fireondrones = 0;
		}

		var_01 setmode("manual");
	}
}

//Function Number: 188
_mgon()
{
	self.script_turretmg = 1;
	if(_ishelicopter() && hashelicopterturret())
	{
		self thread [[ level.chopperturretonfunc ]]();
		return;
	}

	if(!isdefined(self.mgturret))
	{
		return;
	}

	foreach(var_01 in self.mgturret)
	{
		var_01 show();
		if(isdefined(var_01.script_fireondrones))
		{
			var_01.script_fireondrones = 1;
		}

		if(isdefined(var_01.defaultonmode))
		{
			if(var_01.defaultonmode != "sentry")
			{
				var_01 setmode(var_01.defaultonmode);
			}
		}
		else
		{
			var_01 setmode("auto_nonai");
		}

		set_turret_team(var_01);
	}
}

//Function Number: 189
_force_kill()
{
	if(common_scripts\utility::isdestructible())
	{
		common_scripts\_destructible::force_explosion();
		return;
	}

	self kill();
	self setcandamage(0);
}

//Function Number: 190
get_vehicle_ai_riders()
{
	if(!isdefined(self.script_vehicleride))
	{
		return [];
	}

	if(!isdefined(level.vehicle_rideai[self.script_vehicleride]))
	{
		return [];
	}

	return level.vehicle_rideai[self.script_vehicleride];
}

//Function Number: 191
get_vehicle_ai_spawners()
{
	var_00 = [];
	if(isdefined(self.target))
	{
		var_01 = getentarray(self.target,"targetname");
		foreach(var_03 in var_01)
		{
			if(!issubstr(var_03.code_classname,"actor"))
			{
				continue;
			}

			if(!var_03.spawnflags & 1)
			{
				continue;
			}

			if(isdefined(var_03.dont_auto_ride))
			{
				continue;
			}

			var_00[var_00.size] = var_03;
		}

		if(isdefined(level.spawn_pool_enabled))
		{
			var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
			foreach(var_03 in var_01)
			{
				if(isdefined(var_03.script_spawn_pool))
				{
					var_00[var_00.size] = var_03;
				}
			}
		}
	}

	if(!isdefined(self.script_vehicleride))
	{
		return var_00;
	}

	if(isdefined(level.vehicle_ridespawners[self.script_vehicleride]))
	{
		var_00 = common_scripts\utility::array_combine(var_00,level.vehicle_ridespawners[self.script_vehicleride]);
	}

	return var_00;
}

//Function Number: 192
_vehicle_paths(param_00,param_01,param_02)
{
	if(_ishelicopter())
	{
		vehicle_paths_helicopter(param_00,param_01,param_02);
		return;
	}

	vehicle_paths_non_heli(param_00);
}

//Function Number: 193
_gopath(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	if(isdefined(param_00.script_vehiclestartmove))
	{
		level.vehicle_startmovegroup[param_00.script_vehiclestartmove] = common_scripts\utility::array_remove(level.vehicle_startmovegroup[param_00.script_vehiclestartmove],param_00);
	}

	param_00 endon("death");
	if(isdefined(param_00.hasstarted))
	{
		return;
	}
	else
	{
		param_00.hasstarted = 1;
	}

	param_00 maps\_utility::script_delay();
	param_00 notify("start_vehiclepath");
	if(param_00 _ishelicopter())
	{
		param_00 notify("start_dynamicpath");
		return;
	}

	var_01 = getvehiclenode(param_00.target,"targetname");
	if(isdefined(var_01))
	{
		param_00 thread _vehicle_paths(var_01);
	}

	param_00 startpath();
}

//Function Number: 194
_scripted_spawn(param_00)
{
	var_01 = _getvehiclespawnerarray_by_spawngroup(param_00);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_02[var_02.size] = _vehicle_spawn(var_04);
	}

	return var_02;
}

//Function Number: 195
_vehicle_spawn(param_00)
{
	if(!isspawner(param_00))
	{
		return;
	}

	var_01 = param_00 vehicle_dospawn();
	if(!isdefined(param_00.spawned_count))
	{
		param_00.spawned_count = 0;
	}

	param_00.spawned_count++;
	param_00.vehicle_spawned_thisframe = var_01;
	param_00.last_spawned_vehicle = var_01;
	param_00 thread remove_vehicle_spawned_thisframe();
	var_01.vehicle_spawner = param_00;
	if(isdefined(param_00.truckjunk))
	{
		var_01.truckjunk = param_00.truckjunk;
	}

	thread vehicle_init(var_01);
	param_00 notify("spawned",var_01);
	return var_01;
}

//Function Number: 196
kill_vehicle_spawner(param_00)
{
	param_00 waittill("trigger");
	maps\_utility::array_delete(level.vehicle_killspawn_groups[param_00.script_kill_vehicle_spawner]);
	level.vehicle_killspawn_groups[param_00.script_kill_vehicle_spawner] = [];
}

//Function Number: 197
precache_scripts()
{
	var_00 = [];
	var_01 = getentarray("script_vehicle","code_classname");
	level.needsprecaching = [];
	var_02 = [];
	var_00 = [];
	if(!isdefined(level.vehicleinitthread))
	{
		level.vehicleinitthread = [];
	}

	foreach(var_04 in var_01)
	{
		var_04.vehicletype = tolower(var_04.vehicletype);
		if(var_04.vehicletype == "empty")
		{
			continue;
		}

		if(isdefined(var_04.spawnflags) && var_04.spawnflags & 1)
		{
			var_02[var_02.size] = var_04;
		}

		var_00[var_00.size] = var_04;
		if(!isdefined(level.vehicleinitthread[var_04.vehicletype]))
		{
			level.vehicleinitthread[var_04.vehicletype] = [];
		}

		var_05 = "classname: " + var_04.classname;
		precachesetup(var_05,var_04);
	}

	if(level.needsprecaching.size > 0)
	{
		foreach(var_08 in level.needsprecaching)
		{
		}

		level waittill("never");
	}

	return var_00;
}

//Function Number: 198
precachesetup(param_00,param_01)
{
	if(isdefined(level.vehicleinitthread[param_01.vehicletype][param_01.classname]))
	{
		return;
	}

	if(param_01.classname == "script_vehicle")
	{
		return;
	}

	var_02 = 0;
	foreach(var_04 in level.needsprecaching)
	{
		if(var_04 == param_00)
		{
			var_02 = 1;
		}
	}

	if(!var_02)
	{
		level.needsprecaching[level.needsprecaching.size] = param_00;
	}
}

//Function Number: 199
setup_levelvars()
{
	if(isdefined(level.vehicle_setup_levelvars))
	{
		return;
	}

	level.vehicle_setup_levelvars = 1;
	level.vehicle_deletegroup = [];
	level.vehicle_startmovegroup = [];
	level.vehicle_rideai = [];
	level.vehicle_deathswitch = [];
	level.vehicle_ridespawners = [];
	level.vehicle_gatetrigger = [];
	level.vehicle_crashpaths = [];
	level.vehicle_link = [];
	level.vehicle_detourpaths = [];
	level.vehicle_startnodes = [];
	level.vehicle_killspawn_groups = [];
	level.helicopter_crash_locations = getentarray("helicopter_crash_location","targetname");
	level.helicopter_crash_locations = common_scripts\utility::array_combine(level.helicopter_crash_locations,maps\_utility::getstructarray_delete("helicopter_crash_location","targetname"));
	level.vehicles = [];
	level.vehicles["allies"] = [];
	level.vehicles["axis"] = [];
	level.vehicles["neutral"] = [];
	level.vehicles["team3"] = [];
	if(!isdefined(level.vehicle_team))
	{
		level.vehicle_team = [];
	}

	if(!isdefined(level.vehicle_deathmodel))
	{
		level.vehicle_deathmodel = [];
	}

	if(!isdefined(level.vehicle_death_thread))
	{
		level.vehicle_death_thread = [];
	}

	if(!isdefined(level.vehicle_driveidle))
	{
		level.vehicle_driveidle = [];
	}

	if(!isdefined(level.vehicle_driveidle_r))
	{
		level.vehicle_driveidle_r = [];
	}

	if(!isdefined(level.attack_origin_condition_threadd))
	{
		level.attack_origin_condition_threadd = [];
	}

	if(!isdefined(level.vehiclefireanim))
	{
		level.vehiclefireanim = [];
	}

	if(!isdefined(level.vehiclefireanim_settle))
	{
		level.vehiclefireanim_settle = [];
	}

	if(!isdefined(level.vehicle_hasname))
	{
		level.vehicle_hasname = [];
	}

	if(!isdefined(level.vehicle_turret_requiresrider))
	{
		level.vehicle_turret_requiresrider = [];
	}

	if(!isdefined(level.vehicle_rumble))
	{
		level.vehicle_rumble = [];
	}

	if(!isdefined(level.vehicle_rumble_override))
	{
		level.vehicle_rumble_override = [];
	}

	if(!isdefined(level.vehicle_mgturret))
	{
		level.vehicle_mgturret = [];
	}

	if(!isdefined(level.vehicle_isstationary))
	{
		level.vehicle_isstationary = [];
	}

	if(!isdefined(level.vehicle_death_earthquake))
	{
		level.vehicle_death_earthquake = [];
	}

	if(!isdefined(level._vehicle_effect))
	{
		level._vehicle_effect = [];
	}

	if(!isdefined(level.vehicle_unloadgroups))
	{
		level.vehicle_unloadgroups = [];
	}

	if(!isdefined(level.vehicle_aianims))
	{
		level.vehicle_aianims = [];
	}

	if(!isdefined(level.vehicle_unloadwhenattacked))
	{
		level.vehicle_unloadwhenattacked = [];
	}

	if(!isdefined(level.vehicle_exhaust))
	{
		level.vehicle_exhaust = [];
	}

	if(!isdefined(level.vehicle_deckdust))
	{
		level.vehicle_deckdust = [];
	}

	if(!isdefined(level.vehicle_shoot_shock))
	{
		level.vehicle_shoot_shock = [];
	}

	if(!isdefined(level.vehicle_hide_list))
	{
		level.vehicle_hide_list = [];
	}

	if(!isdefined(level.vehicle_frontarmor))
	{
		level.vehicle_frontarmor = [];
	}

	if(!isdefined(level.destructible_model))
	{
		level.destructible_model = [];
	}

	if(!isdefined(level.vehicle_types))
	{
		level.vehicle_types = [];
	}

	if(!isdefined(level.vehicle_grenadeshield))
	{
		level.vehicle_grenadeshield = [];
	}

	if(!isdefined(level.vehicle_bulletshield))
	{
		level.vehicle_bulletshield = [];
	}

	if(!isdefined(level.vehicle_death_jolt))
	{
		level.vehicle_death_jolt = [];
	}

	if(!isdefined(level.vehicle_death_badplace))
	{
		level.vehicle_death_badplace = [];
	}

	if(!isdefined(level.vehicle_idleanim))
	{
		level.vehicle_idleanim = [];
	}

	if(!isdefined(level.helicopter_list))
	{
		level.helicopter_list = [];
	}

	if(!isdefined(level.airplane_list))
	{
		level.airplane_list = [];
	}

	if(!isdefined(level.vehicle_single_tread_list))
	{
		level.vehicle_single_tread_list = [];
	}

	if(!isdefined(level.vehicle_death_anim))
	{
		level.vehicle_death_anim = [];
	}

	maps\_vehicle_aianim::setup_aianimthreads();
}

//Function Number: 200
setvehgoalpos_wrap(param_00,param_01)
{
	return _setvehgoalpos_wrap(param_00,param_01);
}

//Function Number: 201
vehicle_liftoffvehicle(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 512;
	}

	var_01 = self.origin + (0,0,param_00);
	self setneargoalnotifydist(10);
	setvehgoalpos_wrap(var_01,1);
	self waittill("goal");
}

//Function Number: 202
move_effects_ent_here(param_00)
{
	var_01 = deathfx_ent();
	var_01 unlink();
	var_01 linkto(param_00);
}

//Function Number: 203
model_dummy_death()
{
	var_00 = self.modeldummy;
	var_00 endon("death");
	var_00 endon("stop_model_dummy_death");
	while(isdefined(self))
	{
		self waittill("death");
		waittillframeend;
	}

	var_00 delete();
}

//Function Number: 204
move_lights_here(param_00,param_01)
{
	param_00 lights_on_internal("all",self.classname);
	wait(0.3);
	thread lights_off("all",self.classname);
}

//Function Number: 205
spawn_vehicles_from_targetname_newstyle(param_00)
{
	var_01 = [];
	var_02 = getentarray(param_00,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(!isdefined(var_05.code_classname) || var_05.code_classname != "script_vehicle")
		{
			continue;
		}

		if(isspawner(var_05))
		{
			var_01[var_01.size] = _vehicle_spawn(var_05);
		}
	}

	return var_01;
}

//Function Number: 206
kill_death_anim_thread(param_00)
{
	if(!isdefined(level.vehicle_death_anim[param_00]))
	{
		return;
	}

	if(isdefined(self.skipanimbaseddeath) && self.skipanimbaseddeath)
	{
		return;
	}

	if(isarray(level.vehicle_death_anim[param_00]))
	{
		if(isdefined(self.preferred_death_anim))
		{
			var_01 = self.preferred_death_anim;
		}
		else
		{
			var_01 = common_scripts\utility::random(level.vehicle_death_anim[var_01]);
		}

		return kill_death_anim_thread_picked(var_01);
	}

	return kill_death_anim_thread_picked(level.vehicle_death_anim[var_01]);
}

//Function Number: 207
kill_death_anim_thread_picked(param_00)
{
	self.killdeathanimating = 1;
	var_01 = common_scripts\utility::spawn_tag_origin();
	self vehicle_orientto(var_01.origin,var_01.angles,0,0);
	self vehicle_turnengineoff();
	self notify("kill_death_anim",param_00);
	if(isstring(param_00))
	{
		self setcandamage(0);
		var_01 maps\_anim::anim_single_solo(self,param_00);
	}
	else
	{
		self useanimtree(#animtree);
		self animscripted("vehicle_death_anim",var_01.origin,var_01.angles,param_00);
		self setneargoalnotifydist(30);
		self setvehgoalpos(var_01.origin,1);
		self setgoalyaw(var_01.angles[1]);
		self waittillmatch("end","vehicle_death_anim");
	}

	var_01 delete();
	thread delayed_delete(7);
}

//Function Number: 208
delayed_delete(param_00)
{
	wait(7);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 209
unmatched_death_rig_light_waits_for_lights_off()
{
	if(!isdefined(self.has_unmatching_deathmodel_rig))
	{
		return;
	}

	while(isdefined(self.lights) && self.lights.size)
	{
		wait(0.05);
	}
}