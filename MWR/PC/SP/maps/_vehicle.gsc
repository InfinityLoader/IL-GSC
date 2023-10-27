/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_vehicle.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 133
 * Decompile Time: 2468 ms
 * Timestamp: 10/27/2023 2:49:54 AM
*******************************************************************/

//Function Number: 1
init_vehicles()
{
	if(isdefined(level.disablevehiclescripts) && level.disablevehiclescripts)
	{
		return;
	}

	maps\_vehicle_code::setup_levelvars();
	level.helicopter_crash_locations = common_scripts\utility::array_combine(level.helicopter_crash_locations,maps\_utility::getstructarray_delete("helicopter_crash_location","targetname"));
	common_scripts\utility::array_levelthread(getentarray("colmap_vehicle","targetname"),::maps\_utility::deleteent);
	maps\_vehicle_code::setup_vehicle_spawners();
	common_scripts\utility::array_thread(getentarray("truckjunk","targetname"),::maps\_vehicle_code::truckjunk);
	common_scripts\utility::array_thread(getentarray("truckjunk","script_noteworthy"),::maps\_vehicle_code::truckjunk);
	common_scripts\utility::array_thread(common_scripts\utility::getstructarray("truckjunk","targetname"),::maps\_vehicle_code::truckjunk);
	common_scripts\utility::array_thread(common_scripts\utility::getstructarray("truckjunk","script_noteworthy"),::maps\_vehicle_code::truckjunk);
	maps\_vehicle_code::setup_ai();
	maps\_vehicle_code::setup_triggers();
	var_00 = maps\_vehicle_code::precache_scripts();
	maps\_vehicle_code::setup_vehicles(var_00);
	if(isdefined(level.optimizedvehicletriggerprocess))
	{
		common_scripts\utility::array_levelthread(level.vehicle_processtriggers,::trigger_process_set);
	}
	else
	{
		common_scripts\utility::array_levelthread(level.vehicle_processtriggers,::maps\_vehicle_code::trigger_process);
	}

	level.vehicle_processtriggers = undefined;
	level.levelhasvehicles = getentarray("script_vehicle","code_classname").size > 0;
	maps\_utility::add_hint_string("invulerable_frags",&"SCRIPT_INVULERABLE_FRAGS",undefined);
	maps\_utility::add_hint_string("invulerable_bullets",&"SCRIPT_INVULERABLE_BULLETS",undefined);
	common_scripts\utility::create_lock("aircraft_wash_math");
	if(isdefined(level.helicopter_landed_fx_override))
	{
		foreach(var_03, var_02 in level.helicopter_landed_fx_override)
		{
			level._heli_landed_fx[loadfx(var_03)] = loadfx(var_02);
		}
	}

	set_crush_vehicle_clips(undefined,"postcrushed",0);
}

//Function Number: 2
trigger_process_set(param_00)
{
	param_00.optimized_process_trigger = 1;
}

//Function Number: 3
vehicle_paths(param_00,param_01,param_02)
{
	return maps\_vehicle_code::_vehicle_paths(param_00,param_01,param_02);
}

//Function Number: 4
create_vehicle_from_spawngroup_and_gopath(param_00)
{
	var_01 = scripted_spawn(param_00);
	foreach(var_03 in var_01)
	{
		level thread gopath(var_03);
	}

	return var_01;
}

//Function Number: 5
gopath(param_00)
{
	return maps\_vehicle_code::_gopath(param_00);
}

//Function Number: 6
scripted_spawn(param_00)
{
	return maps\_vehicle_code::_scripted_spawn(param_00);
}

//Function Number: 7
vehicle_spawn(param_00)
{
	return maps\_vehicle_code::_vehicle_spawn(param_00);
}

//Function Number: 8
waittill_vehiclespawn(param_00)
{
	var_01 = getent(param_00,"targetname");
	if(isspawner(var_01))
	{
		var_01 waittill("spawned",var_01);
	}

	return var_01;
}

//Function Number: 9
waittill_vehiclespawn_noteworthy(param_00)
{
	level waittill("new_vehicle_spawned" + param_00,var_01);
	return var_01;
}

//Function Number: 10
kill_fx(param_00,param_01)
{
	return maps\_vehicle_code::_kill_fx(param_00,param_01);
}

//Function Number: 11
vehicle_flag_arrived(param_00)
{
	if(!isdefined(self.vehicle_flags))
	{
		self.vehicle_flags = [];
	}

	while(!isdefined(self.vehicle_flags[param_00]))
	{
		self waittill("vehicle_flag_arrived",var_01);
		if(param_00 == var_01)
		{
			return;
		}
	}
}

//Function Number: 12
build_radiusdamage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.vehicle_death_radiusdamage))
	{
		level.vehicle_death_radiusdamage = [];
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = (0,0,0);
	}

	var_06 = spawnstruct();
	var_06.offset = param_00;
	var_06.range = param_01;
	var_06.maxdamage = param_02;
	var_06.mindamage = param_03;
	var_06.bkillplayer = param_04;
	var_06.delay = param_05;
	level.vehicle_death_radiusdamage[level.vtclassname] = var_06;
}

//Function Number: 13
build_rumble(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.vehicle_rumble))
	{
		level.vehicle_rumble = [];
	}

	var_06 = build_quake(param_01,param_02,param_03,param_04,param_05);
	precacherumble(param_00);
	var_06.rumble = param_00;
	level.vehicle_rumble[level.vtclassname] = var_06;
}

//Function Number: 14
build_rumble_override(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(level.vehicle_rumble_override))
	{
		level.vehicle_rumble_override = [];
	}

	var_07 = build_quake(param_02,param_03,param_04,param_05,param_06);
	precacherumble(param_01);
	var_07.rumble = param_01;
	level.vehicle_rumble_override[param_00] = var_07;
}

//Function Number: 15
build_rumble_unique(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = build_quake(param_01,param_02,param_03,param_04,param_05);
	var_06.rumble = param_00;
	self.vehicle_rumble_unique = var_06;
	vehicle_kill_rumble_forever();
	thread maps\_vehicle_code::vehicle_rumble();
}

//Function Number: 16
build_deathquake(param_00,param_01,param_02)
{
	var_03 = level.vtclassname;
	if(!isdefined(level.vehicle_death_earthquake))
	{
		level.vehicle_death_earthquake = [];
	}

	level.vehicle_death_earthquake[var_03] = build_quake(param_00,param_01,param_02);
}

//Function Number: 17
build_deathquake_with_classname(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.vehicle_death_earthquake))
	{
		level.vehicle_death_earthquake = [];
	}

	level.vehicle_death_earthquake[param_00] = build_quake(param_01,param_02,param_03);
}

//Function Number: 18
build_quake(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.scale = param_00;
	var_05.duration = param_01;
	var_05.radius = param_02;
	if(isdefined(param_03))
	{
		var_05.basetime = param_03;
	}

	if(isdefined(param_04))
	{
		var_05.randomaditionaltime = param_04;
	}

	return var_05;
}

//Function Number: 19
build_fx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_0B = spawnstruct();
	var_0B.effect = loadfx(param_00);
	var_0B.tag = param_01;
	var_0B.sound = param_02;
	var_0B.bsoundlooping = param_05;
	var_0B.delay = param_04;
	var_0B.waitdelay = param_06;
	var_0B.stayontag = param_07;
	var_0B.notifystring = param_08;
	var_0B.beffectlooping = param_03;
	var_0B.selfdeletedelay = param_09;
	var_0B.remove_deathfx_entity_delay = param_0A;
	return var_0B;
}

//Function Number: 20
build_deathfx_override(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	level.vttype = param_01;
	level.vtmodel = param_02;
	level.vtoverride = 1;
	level.vtclassname = param_00;
	if(!isdefined(level.vehicle_death_fx))
	{
		level.vehicle_death_fx = [];
	}

	if(!is_overrode(param_00))
	{
		level.vehicle_death_fx[param_00] = [];
	}

	level.vehicle_death_fx_override[param_00] = 1;
	if(!isdefined(level.vehicle_death_fx[param_00]))
	{
		level.vehicle_death_fx[param_00] = [];
	}

	level.vehicle_death_fx[param_00][level.vehicle_death_fx[param_00].size] = build_fx(param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
	level.vtoverride = undefined;
}

//Function Number: 21
swap_deathfx_effect_only(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.vehicle_death_fx))
	{
		return;
	}

	var_04 = 0;
	foreach(var_06 in level.vehicle_death_fx[param_00])
	{
		if(isdefined(var_06.effect) && !isdefined(param_01))
		{
			continue;
		}

		if(!isdefined(var_06.effect) && isdefined(param_01))
		{
			continue;
		}

		if(isdefined(var_06.effect) && isdefined(param_01) && var_06.effect != loadfx(param_01))
		{
			continue;
		}

		if(var_06.tag != param_02)
		{
			continue;
		}

		if(isdefined(param_03))
		{
			var_06.effect = loadfx(param_03);
		}
		else
		{
			var_06.effect = undefined;
		}

		var_04 = 1;
	}

	if(!var_04)
	{
	}
}

//Function Number: 22
build_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = level.vtclassname;
	if(is_overrode(var_0B))
	{
		return;
	}

	if(!isdefined(level.vehicle_death_fx[var_0B]))
	{
		level.vehicle_death_fx[var_0B] = [];
	}

	level.vehicle_death_fx[var_0B][level.vehicle_death_fx[var_0B].size] = build_fx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 23
build_deathfx_generic_script_model(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = level.vtclassname;
	level.vtclassname = "script_model";
	build_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	level.vtclassname = var_0B;
}

//Function Number: 24
build_deathanim(param_00,param_01)
{
	override_deathanim(level.vtclassname,param_01,param_00);
}

//Function Number: 25
override_deathanim(param_00,param_01,param_02)
{
	if(!isdefined(level.vehicle_deathanim))
	{
		level.vehicle_deathanim = [];
	}

	var_03 = param_00;
	if(isdefined(param_01))
	{
		var_03 = var_03 + "_" + param_01;
	}

	if(!isdefined(param_02))
	{
		level.vehicle_deathanim[var_03] = undefined;
		return;
	}

	level.vehicle_deathanim[var_03] = process_deathanim(param_00,param_02);
}

//Function Number: 26
custom_deathanim(param_00)
{
	if(!isdefined(param_00))
	{
		self.vehicle_deathanim = undefined;
		return;
	}

	self.vehicle_deathanim = process_deathanim(self.classname,param_00);
}

//Function Number: 27
process_deathanim(param_00,param_01)
{
	if(!isdefined(param_01.is_directional))
	{
		param_01.is_directional = 0;
	}

	if(param_01.is_directional)
	{
	}

	if(!isdefined(param_01.clear_anims))
	{
		param_01.clear_anims = 0;
	}

	if(!isdefined(param_01.clear_anims_time))
	{
		param_01.clear_anims_time = 0;
	}

	if(!isdefined(param_01.alter_velocity))
	{
		param_01.alter_velocity = 0;
	}

	if(!isdefined(param_01.alter_velocity_speed))
	{
		param_01.alter_velocity_speed = 0;
	}

	if(!isdefined(param_01.alter_velocity_accel))
	{
		param_01.alter_velocity_accel = 40;
	}

	if(!isdefined(param_01.alter_velocity_decel))
	{
		param_01.alter_velocity_decel = 20;
	}

	if(!isdefined(param_01.delay_crash))
	{
		param_01.delay_crash = 0;
	}

	if(!isdefined(param_01.delay_crash_time))
	{
		param_01.delay_crash_time = -1;
	}

	if(!isdefined(param_01.delay_crash_force_end))
	{
		param_01.delay_crash_force_end = 0;
	}

	if(!isdefined(param_01.turn_off_engine))
	{
		param_01.turn_off_engine = 1;
	}

	if(!isdefined(param_01.can_damage))
	{
		param_01.can_damage = 0;
	}

	if(!isdefined(param_01.delete_time))
	{
		param_01.delete_time = -1;
	}

	if(!isdefined(param_01.notetrack_notifies))
	{
		param_01.notetrack_notifies = [];
	}

	if(!isdefined(param_01.death_fx_on_self))
	{
		param_01.death_fx_on_self = 1;
	}

	return param_01;
}

//Function Number: 28
validate_deathanim_directional(param_00)
{
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = param_00;
	var_07 = getfirstarraykey(var_05);
	if(isdefined(var_07))
	{
		var_06 = var_05[var_07];
		switch(var_07)
		{
			case "front":
				break;

			case "rear":
				break;

			case "left":
				break;

			case "right":
				break;
		}
	}
}

//Function Number: 29
is_overrode(param_00)
{
	if(!isdefined(level.vehicle_death_fx_override))
	{
		return 0;
	}

	if(!isdefined(level.vehicle_death_fx_override[param_00]))
	{
		return 0;
	}

	if(isdefined(level.vtoverride))
	{
		return 1;
	}

	return level.vehicle_death_fx_override[param_00];
}

//Function Number: 30
build_rocket_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = level.vtclassname;
	level.vtclassname = "rocket_death" + var_0B;
	build_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	level.vtclassname = var_0B;
}

//Function Number: 31
force_kill()
{
	return maps\_vehicle_code::_force_kill();
}

//Function Number: 32
godon()
{
	self.godmode = 1;
}

//Function Number: 33
godoff()
{
	self.godmode = 0;
}

//Function Number: 34
mgoff()
{
	return maps\_vehicle_code::_mgoff();
}

//Function Number: 35
mgon()
{
	return maps\_vehicle_code::_mgon();
}

//Function Number: 36
isvehicle()
{
	return isdefined(self.vehicletype);
}

//Function Number: 37
build_missile_launcher(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(level.vehicle_missile_launcher))
	{
		level.vehicle_missile_launcher = [];
	}

	var_0C = level.vtclassname;
	if(!isdefined(level.vehicle_missile_launcher[var_0C]))
	{
		level.vehicle_missile_launcher[var_0C] = [];
	}

	precachemodel(param_02);
	precacheitem(param_03);
	var_0D = spawnstruct();
	var_0D.tag = param_01;
	var_0D.missile_model = param_02;
	var_0D.missile_object = param_03;
	var_0D.pre_fire_function = param_04;
	var_0D.post_fire_function = param_05;
	var_0D.inter_salvo_delay = param_06;
	var_0D.homing_delay_min = param_07;
	var_0D.homing_delay_max = param_08;
	var_0D.salvo_cooldown_min = param_09;
	var_0D.salvo_cooldown_max = param_0A;
	var_0D.missile_abort_if_owner_destroyed = param_0B;
	level.vehicle_missile_launcher[var_0C][level.vehicle_missile_launcher[var_0C].size] = var_0D;
}

//Function Number: 38
build_turret(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.vehicle_mgturret))
	{
		level.vehicle_mgturret = [];
	}

	var_09 = level.vtclassname;
	if(!isdefined(level.vehicle_mgturret[var_09]))
	{
		level.vehicle_mgturret[var_09] = [];
	}

	precachemodel(param_02);
	precacheturret(param_00);
	var_0A = spawnstruct();
	var_0A.info = param_00;
	var_0A.tag = param_01;
	var_0A.model = param_02;
	var_0A.maxrange = param_03;
	var_0A.defaultonmode = param_04;
	var_0A.deletedelay = param_05;
	var_0A.defaultdroppitch = param_06;
	var_0A.defaultdropyaw = param_07;
	if(isdefined(param_08))
	{
		var_0A.offset_tag = param_08;
	}

	level.vehicle_mgturret[var_09][level.vehicle_mgturret[var_09].size] = var_0A;
}

//Function Number: 39
vehicle_is_crashing()
{
	return maps\_vehicle_code::_vehicle_is_crashing();
}

//Function Number: 40
is_godmode()
{
	return maps\_vehicle_code::_is_godmode();
}

//Function Number: 41
vehicle_kill_rumble_forever()
{
	self notify("kill_rumble_forever");
}

//Function Number: 42
move_truck_junk_here(param_00,param_01)
{
	if(!isdefined(self.truckjunk))
	{
		return;
	}

	foreach(var_03 in self.truckjunk)
	{
		if(var_03 == param_00)
		{
			continue;
		}

		var_03 unlink();
		if(isdefined(var_03.script_ghettotag))
		{
			var_03 linkto(param_00,var_03.script_ghettotag,var_03.base_origin,var_03.base_angles);
			continue;
		}

		if(isdefined(param_01))
		{
			var_03 linkto(param_00,param_01);
			continue;
		}

		var_03 linkto(param_00);
	}
}

//Function Number: 43
dummy_to_vehicle()
{
	if(ishelicopter())
	{
		self.modeldummy.origin = self gettagorigin("tag_ground");
	}
	else
	{
		self.modeldummy.origin = self.origin;
		self.modeldummy.angles = self.angles;
	}

	self show();
	move_riders_here(self);
	maps\_vehicle_code::move_turrets_here(self);
	thread maps\_vehicle_code::move_lights_here(self);
	maps\_vehicle_code::move_effects_ent_here(self);
	self.modeldummyon = 0;
	self.modeldummy delete();
	self.modeldummy = undefined;
	if(maps\_vehicle_code::hashelicopterdustkickup())
	{
		self notify("stop_kicking_up_dust");
		thread maps\_vehicle_code::aircraft_wash_thread();
	}

	return self.modeldummy;
}

//Function Number: 44
move_riders_here(param_00)
{
	if(!isdefined(self.riders))
	{
		return;
	}

	var_01 = self.riders;
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = maps\_vehicle_aianim::anim_pos(self,var_03.vehicle_position);
		if(isdefined(var_04.passenger_2_turret_func))
		{
			continue;
		}

		var_03 unlink();
		var_03 linkto(param_00,var_04.sittag,(0,0,0),(0,0,0));
		if(isai(var_03))
		{
			var_03 forceteleport(param_00 gettagorigin(var_04.sittag));
			continue;
		}

		var_03.origin = param_00 gettagorigin(var_04.sittag);
	}
}

//Function Number: 45
get_script_vehicles()
{
	var_00 = [];
	var_01 = getentarray("script_vehicle","code_classname");
	foreach(var_03 in var_01)
	{
		if(!isspawner(var_03))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 46
spawn_vehicles_from_targetname(param_00)
{
	var_01 = [];
	var_01 = maps\_vehicle_code::spawn_vehicles_from_targetname_newstyle(param_00);
	return var_01;
}

//Function Number: 47
get_vehicles_from_targetname(param_00)
{
	var_01 = [];
	var_02 = getentarray(param_00,"targetname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.last_spawned_vehicle))
		{
			var_01[var_01.size] = var_04.last_spawned_vehicle;
		}
	}

	return var_01;
}

//Function Number: 48
spawn_vehicle_from_targetname(param_00)
{
	var_01 = spawn_vehicles_from_targetname(param_00);
	return var_01[0];
}

//Function Number: 49
get_vehicle_from_targetname(param_00)
{
	var_01 = get_vehicles_from_targetname(param_00);
	return var_01[0];
}

//Function Number: 50
vehicle_spawner_has_targetname(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	var_02 = param_00.vehicle_spawner;
	if(!isdefined(var_02))
	{
		return 0;
	}

	if(!isdefined(var_02.targetname))
	{
		return 0;
	}

	if(var_02.targetname != param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 51
spawn_vehicle_from_targetname_and_drive(param_00)
{
	var_01 = spawn_vehicles_from_targetname(param_00);
	thread gopath(var_01[0]);
	return var_01[0];
}

//Function Number: 52
spawn_vehicles_from_targetname_and_drive(param_00)
{
	var_01 = spawn_vehicles_from_targetname(param_00);
	foreach(var_03 in var_01)
	{
		thread gopath(var_03);
	}

	return var_01;
}

//Function Number: 53
aircraft_wash(param_00)
{
	thread maps\_vehicle_code::aircraft_wash_thread(param_00);
}

//Function Number: 54
vehicle_wheels_forward()
{
	maps\_vehicle_code::wheeldirectionchange(1);
}

//Function Number: 55
vehicle_wheels_backward()
{
	maps\_vehicle_code::wheeldirectionchange(0);
}

//Function Number: 56
build_light(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.vehicle_lights))
	{
		level.vehicle_lights = [];
	}

	if(!isdefined(level.vehicle_lights_group_override))
	{
		level.vehicle_lights_group_override = [];
	}

	if(isdefined(level.vehicle_lights_group_override[param_04]) && !level.vtoverride)
	{
		return;
	}

	var_06 = spawnstruct();
	var_06.name = param_01;
	var_06.tag = param_02;
	var_06.delay = param_05;
	var_06.effect = loadfx(param_03);
	level.vehicle_lights[param_00][param_01] = var_06;
	maps\_vehicle_code::group_light(param_00,param_01,"all");
	if(isdefined(param_04))
	{
		maps\_vehicle_code::group_light(param_00,param_01,param_04);
	}
}

//Function Number: 57
build_light_override(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	level.vtclassname = param_00;
	build_light(param_00,param_01,param_02,param_03,param_04,param_05);
	level.vtoverride = 0;
	level.vehicle_lights_group_override[param_04] = 1;
}

//Function Number: 58
build_hideparts(param_00,param_01)
{
	if(!isdefined(level.vehicle_hide_list))
	{
		level.vehicle_hide_list = [];
	}

	level.vehicle_hide_list[param_00] = param_01;
}

//Function Number: 59
build_deathmodel(param_00,param_01,param_02,param_03)
{
	if(param_00 != level.vtmodel && level.vtmodel != "script_model")
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	precachemodel(param_00);
	precachemodel(param_01);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		level.vehicle_deathmodel[param_00] = param_01;
		level.vehicle_deathmodel_delay[param_00] = param_02;
		return;
	}

	level.vehicle_deathmodel[param_03] = param_01;
	level.vehicle_deathmodel_delay[param_03] = param_02;
}

//Function Number: 60
build_shoot_shock(param_00)
{
	precacheshellshock(param_00);
	level.vehicle_shoot_shock[level.vtclassname] = param_00;
}

//Function Number: 61
build_idle(param_00)
{
	if(!isdefined(level.vehicle_idleanim))
	{
		level.vehicle_idleanim = [];
	}

	if(!isdefined(level.vehicle_idleanim[level.vtmodel]))
	{
		level.vehicle_idleanim[level.vtmodel] = [];
	}

	level.vehicle_idleanim[level.vtmodel][level.vehicle_idleanim[level.vtmodel].size] = param_00;
}

//Function Number: 62
build_drive(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 10;
	}

	level.vehicle_driveidle[level.vtmodel] = param_00;
	if(isdefined(param_01))
	{
		level.vehicle_driveidle_r[level.vtmodel] = param_01;
	}

	level.vehicle_driveidle_normal_speed[level.vtmodel] = param_02;
	if(isdefined(param_03))
	{
		level.vehicle_driveidle_animrate[level.vtmodel] = param_03;
	}
}

//Function Number: 63
build_template(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	if(isdefined(param_02))
	{
		param_00 = param_02;
	}

	if(param_00 != "script_model")
	{
		precachevehicle(param_00);
	}

	if(!isdefined(level.vehicle_death_fx))
	{
		level.vehicle_death_fx = [];
	}

	if(!isdefined(level.vehicle_deathanim))
	{
		level.vehicle_deathanim = [];
	}

	if(!isdefined(level.vehicle_death_fx[param_03]))
	{
		level.vehicle_death_fx[param_03] = [];
	}

	level.vehicle_team[param_03] = "axis";
	level.vehicle_life[param_03] = 999;
	level.vehicle_hasmainturret[param_01] = 0;
	level.vehicle_mainturrets[param_01] = [];
	level.vtmodel = param_01;
	level.vttype = param_00;
	level.vtclassname = param_03;
}

//Function Number: 64
build_exhaust(param_00)
{
	level.vehicle_exhaust[level.vtmodel] = loadfx(param_00);
}

//Function Number: 65
build_treadfx(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00))
	{
		set_vehicle_effect(param_00,param_01,param_02,undefined,param_04);
		if(isdefined(param_03) && param_03)
		{
			set_vehicle_effect(param_00,param_01,param_02,"_bank",param_04);
			set_vehicle_effect(param_00,param_01,param_02,"_bank_lg",param_04);
			return;
		}

		return;
	}

	param_00 = level.vtclassname;
	maps\_treadfx::main(param_00);
}

//Function Number: 66
build_treadfx_script_model(param_00,param_01,param_02,param_03,param_04)
{
	build_treadfx(param_00,param_01 + "_script_model",param_02,param_03,param_04);
}

//Function Number: 67
build_treadfx_override_tags(param_00,param_01)
{
	if(!isdefined(level._vehicle_effect_custom_param))
	{
		level._vehicle_effect_custom_param = [];
	}

	if(!isdefined(level._vehicle_effect_custom_param[param_00]))
	{
		level._vehicle_effect_custom_param[param_00] = spawnstruct();
	}

	level._vehicle_effect_custom_param[param_00].tags = param_01;
}

//Function Number: 68
build_treadfx_override_get_surface_function(param_00,param_01)
{
	if(!isdefined(level._vehicle_effect_custom_param))
	{
		level._vehicle_effect_custom_param = [];
	}

	if(!isdefined(level._vehicle_effect_custom_param[param_00]))
	{
		level._vehicle_effect_custom_param[param_00] = spawnstruct();
	}

	level._vehicle_effect_custom_param[param_00].get_surface_override_function = param_01;
}

//Function Number: 69
build_all_treadfx(param_00,param_01)
{
	var_02 = get_surface_types();
	foreach(var_04 in var_02)
	{
		set_vehicle_effect(param_00,var_04);
	}
}

//Function Number: 70
set_vehicle_effect(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level._vehicle_effect))
	{
		level._vehicle_effect = [];
	}

	if(!isdefined(level._vehicle_effect_name))
	{
		level._vehicle_effect_name = [];
	}

	if(!isdefined(level._vehicle_sound_effect))
	{
		level._vehicle_sound_effect = [];
	}

	if(isdefined(param_03))
	{
		param_01 = param_01 + param_03;
		param_02 = param_02 + param_03;
		if(isdefined(param_04))
		{
			param_04 = param_04 + param_03;
		}
	}

	if(isdefined(param_02))
	{
		update_vehicle_effect(param_00,param_01,param_02,param_04);
		return;
	}

	if(isdefined(level._vehicle_effect[param_00]) && isdefined(level._vehicle_effect[param_00][param_01]))
	{
		level._vehicle_effect[param_00][param_01] = undefined;
		level._vehicle_sound_effect[param_00][param_01] = param_04;
	}
}

//Function Number: 71
get_surface_types()
{
	var_00 = [];
	var_00[var_00.size] = "brick";
	var_00[var_00.size] = "bark";
	var_00[var_00.size] = "carpet";
	var_00[var_00.size] = "cloth";
	var_00[var_00.size] = "concrete";
	var_00[var_00.size] = "dirt";
	var_00[var_00.size] = "flesh";
	var_00[var_00.size] = "foliage";
	var_00[var_00.size] = "glass";
	var_00[var_00.size] = "grass";
	var_00[var_00.size] = "gravel";
	var_00[var_00.size] = "ice";
	var_00[var_00.size] = "metal";
	var_00[var_00.size] = "mud";
	var_00[var_00.size] = "paper";
	var_00[var_00.size] = "plaster";
	var_00[var_00.size] = "rock";
	var_00[var_00.size] = "sand";
	var_00[var_00.size] = "snow";
	var_00[var_00.size] = "water";
	var_00[var_00.size] = "wood";
	var_00[var_00.size] = "asphalt";
	var_00[var_00.size] = "ceramic";
	var_00[var_00.size] = "plastic";
	var_00[var_00.size] = "rubber";
	var_00[var_00.size] = "cushion";
	var_00[var_00.size] = "fruit";
	var_00[var_00.size] = "paintedmetal";
	var_00[var_00.size] = "riotshield";
	var_00[var_00.size] = "slush";
	var_00[var_00.size] = "default";
	return var_00;
}

//Function Number: 72
update_vehicle_effect(param_00,param_01,param_02,param_03)
{
	level._vehicle_effect[param_00][param_01] = loadfx(param_02);
	level._vehicle_effect_name[param_00][param_01] = param_02;
	level._vehicle_sound_effect[param_00][param_01] = param_03;
	var_04 = maps\_treadfx::get_surface_types_variation(param_01);
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		level._vehicle_effect[param_00][var_04[var_05]] = loadfx(param_02);
		level._vehicle_effect_name[param_00][var_04[var_05]] = param_02;
		level._vehicle_sound_effect[param_00][var_04[var_05]] = param_03;
	}
}

//Function Number: 73
add_vehicle_fx_to_bank(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(level._vehicle_effect_bank))
	{
		level._vehicle_effect_bank = [];
	}

	var_01 = get_surface_types();
	var_02 = [];
	foreach(var_04 in var_01)
	{
		level._vehicle_effect_bank[param_00][var_04] = loadfx(param_00);
		var_02 = maps\_treadfx::get_surface_types_variation(var_04);
		foreach(var_06 in var_02)
		{
			level._vehicle_effect_bank[param_00][var_06] = loadfx(param_00);
		}
	}
}

//Function Number: 74
switch_vehicle_fx(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return;
	}

	if(!isdefined(level._vehicle_effect_bank[param_01]))
	{
		return;
	}

	var_02 = get_surface_types();
	var_03 = 0;
	var_04 = 0;
	var_05 = "";
	var_06 = [];
	foreach(var_08 in var_02)
	{
		var_04 = level._vehicle_effect[param_00][var_08];
		var_05 = level._vehicle_effect_name[param_00][var_08];
		var_03 = level._vehicle_effect_bank[param_01][var_08];
		override_vehicle_effect(param_00,var_08,var_05,var_04,var_03,param_01);
		var_06 = maps\_treadfx::get_surface_types_variation(var_08);
		foreach(var_0A in var_06)
		{
			override_vehicle_effect(param_00,var_0A,var_05,var_04,var_03,param_01);
		}
	}
}

//Function Number: 75
override_vehicle_effect(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level._vehicle_effect[param_00][param_01] = param_04;
	level._vehicle_effect_name[param_00][param_01] = param_05;
	level._vehicle_effect_bank[param_02][param_01] = param_03;
}

//Function Number: 76
build_team(param_00)
{
	level.vehicle_team[level.vtclassname] = param_00;
}

//Function Number: 77
build_mainturret(param_00,param_01,param_02,param_03)
{
	level.vehicle_hasmainturret[level.vtmodel] = 1;
	if(isdefined(param_00))
	{
		level.vehicle_mainturrets[level.vtmodel][param_00] = 1;
	}

	if(isdefined(param_01))
	{
		level.vehicle_mainturrets[level.vtmodel][param_01] = 1;
	}

	if(isdefined(param_02))
	{
		level.vehicle_mainturrets[level.vtmodel][param_02] = 1;
	}

	if(isdefined(param_03))
	{
		level.vehicle_mainturrets[level.vtmodel][param_03] = 1;
	}
}

//Function Number: 78
build_bulletshield(param_00)
{
	level.vehicle_bulletshield[level.vtclassname] = param_00;
}

//Function Number: 79
build_grenadeshield(param_00)
{
	level.vehicle_grenadeshield[level.vtclassname] = param_00;
}

//Function Number: 80
build_aianims(param_00,param_01)
{
	var_02 = level.vtclassname;
	level.vehicle_aianims[var_02] = [[ param_00 ]]();
	if(isdefined(param_01))
	{
		level.vehicle_aianims[var_02] = [[ param_01 ]](level.vehicle_aianims[var_02]);
	}
}

//Function Number: 81
build_aianims_with_classname(param_00,param_01,param_02)
{
	level.vehicle_aianims[param_00] = [[ param_01 ]]();
	if(isdefined(param_02))
	{
		level.vehicle_aianims[param_00] = [[ param_02 ]](level.vehicle_aianims[param_00]);
	}
}

//Function Number: 82
build_frontarmor(param_00)
{
	level.vehicle_frontarmor[level.vtclassname] = param_00;
}

//Function Number: 83
build_attach_models(param_00)
{
	level.vehicle_attachedmodels[level.vtclassname] = [[ param_00 ]]();
}

//Function Number: 84
build_unload_groups(param_00)
{
	level.vehicle_unloadgroups[level.vtclassname] = [[ param_00 ]]();
}

//Function Number: 85
build_life(param_00,param_01,param_02)
{
	var_03 = level.vtclassname;
	level.vehicle_life[var_03] = param_00;
	level.vehicle_life_range_low[var_03] = param_01;
	level.vehicle_life_range_high[var_03] = param_02;
}

//Function Number: 86
build_deckdust(param_00)
{
	level.vehicle_deckdust[level.vtmodel] = loadfx(param_00);
}

//Function Number: 87
build_destructible(param_00,param_01)
{
	if(isdefined(level.vehicle_csv_export))
	{
		return;
	}

	if(param_00 != level.vtmodel)
	{
		return;
	}

	var_02 = spawnstruct();
	var_02.model = param_00;
	var_02 maps\_utility::precache_destructible(param_01);
	level.destructible_model[level.vtmodel] = param_01;
}

//Function Number: 88
build_localinit(param_00)
{
	level.vehicleinitthread[level.vttype][level.vtclassname] = param_00;
}

//Function Number: 89
is_dummy()
{
	return self.modeldummyon;
}

//Function Number: 90
vehicle_load_ai(param_00,param_01,param_02)
{
	maps\_vehicle_aianim::load_ai(param_00,undefined,param_02);
}

//Function Number: 91
vehicle_load_ai_single(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	maps\_vehicle_aianim::load_ai(var_03,param_01,param_02);
}

//Function Number: 92
build_death_badplace(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.vehicle_death_badplace))
	{
		level.vehicle_death_badplace = [];
	}

	var_06 = spawnstruct();
	var_06.delay = param_00;
	var_06.duration = param_01;
	var_06.height = param_02;
	var_06.radius = param_03;
	var_06.team1 = param_04;
	var_06.team2 = param_05;
	level.vehicle_death_badplace[level.vtclassname] = var_06;
}

//Function Number: 93
mount_snowmobile(param_00,param_01)
{
	return maps\_vehicle_code::_mount_snowmobile(param_00,param_01);
}

//Function Number: 94
spawn_vehicle_and_gopath()
{
	var_00 = maps\_utility::spawn_vehicle();
	if(isdefined(self.script_speed))
	{
		if(!ishelicopter())
		{
			var_00 vehphys_setspeed(self.script_speed);
		}
	}

	var_00 thread gopath(var_00);
	return var_00;
}

//Function Number: 95
vehicle_get_riders_by_group(param_00)
{
	var_01 = [];
	var_02 = self.classname;
	if(!isdefined(level.vehicle_unloadgroups[var_02]))
	{
		return var_01;
	}

	var_03 = level.vehicle_unloadgroups[var_02];
	if(!isdefined(param_00))
	{
		return var_01;
	}

	foreach(var_05 in self.riders)
	{
		foreach(var_07 in var_03[param_00])
		{
			if(var_05.vehicle_position == var_07)
			{
				var_01[var_01.size] = var_05;
			}
		}
	}

	return var_01;
}

//Function Number: 96
vehicle_ai_event(param_00)
{
	return maps\_vehicle_aianim::animate_guys(param_00);
}

//Function Number: 97
vehicle_unload(param_00)
{
	return maps\_vehicle_code::_vehicle_unload(param_00);
}

//Function Number: 98
vehicle_turret_scan_on()
{
	self endon("death");
	self endon("stop_scanning_turret");
	var_00 = randomint(2);
	while(isdefined(self))
	{
		if(common_scripts\utility::cointoss())
		{
			maps\_vehicle_code::vehicle_aim_turret_at_angle(0);
			wait(randomfloatrange(2,10));
		}

		if(var_00 == 0)
		{
			var_01 = randomintrange(10,30);
			var_00 = 1;
		}
		else
		{
			var_01 = randomintrange(-30,-10);
			var_00 = 0;
		}

		maps\_vehicle_code::vehicle_aim_turret_at_angle(var_01);
		wait(randomfloatrange(2,10));
	}
}

//Function Number: 99
vehicle_turret_scan_off()
{
	self notify("stop_scanning_turret");
}

//Function Number: 100
vehicle_get_path_array()
{
	self endon("death");
	var_00 = [];
	var_01 = self.attachedpath;
	if(!isdefined(self.attachedpath))
	{
		return var_00;
	}

	var_02 = var_01;
	var_02.counted = 0;
	while(isdefined(var_02))
	{
		if(isdefined(var_02.counted) && var_02.counted == 1)
		{
			break;
		}

		var_00 = common_scripts\utility::array_add(var_00,var_02);
		var_02.counted = 1;
		if(!isdefined(var_02.target))
		{
			break;
		}

		if(!ishelicopter())
		{
			var_02 = getvehiclenode(var_02.target,"targetname");
			continue;
		}

		var_02 = maps\_utility::getent_or_struct(var_02.target,"targetname");
	}

	return var_00;
}

//Function Number: 101
vehicle_lights_on(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	maps\_vehicle_code::lights_on(param_00,param_01);
}

//Function Number: 102
vehicle_lights_off(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	maps\_vehicle_code::lights_off(param_00,param_01);
}

//Function Number: 103
vehicle_single_light_on(param_00)
{
	if(!isdefined(self) || !isdefined(self.classname) || !isdefined(param_00))
	{
		return;
	}

	if(!isdefined(level.vehicle_lights[self.classname]))
	{
		return;
	}

	var_01 = level.vehicle_lights[self.classname][param_00];
	if(!isdefined(var_01))
	{
		return;
	}

	if(isdefined(var_01.delay))
	{
		var_02 = var_01.delay;
	}
	else
	{
		var_02 = 0;
	}

	self endon("death");
	childthread common_scripts\utility::noself_delaycall_proc(::playfxontag,var_02,var_01.effect,self,var_01.tag);
	self.lights[param_00] = 1;
}

//Function Number: 104
vehicle_single_light_off(param_00)
{
	if(!isdefined(self.lights))
	{
		return;
	}

	if(!isdefined(self.lights[param_00]))
	{
		return;
	}

	var_01 = level.vehicle_lights[self.classname][param_00];
	if(!isdefined(var_01))
	{
		return;
	}

	stopfxontag(var_01.effect,self,var_01.tag);
	self.lights[param_00] = undefined;
}

//Function Number: 105
vehicle_switch_paths(param_00,param_01)
{
	self setswitchnode(param_00,param_01);
	self.attachedpath = param_01;
	thread vehicle_paths();
}

//Function Number: 106
vehicle_stop_named(param_00,param_01,param_02)
{
	return maps\_vehicle_code::_vehicle_stop_named(param_00,param_01,param_02);
}

//Function Number: 107
vehicle_resume_named(param_00)
{
	return maps\_vehicle_code::_vehicle_resume_named(param_00);
}

//Function Number: 108
build_is_helicopter(param_00)
{
	if(!isdefined(level.helicopter_list))
	{
		level.helicopter_list = [];
	}

	if(!isdefined(param_00))
	{
		param_00 = level.vttype;
	}

	level.helicopter_list[param_00] = 1;
}

//Function Number: 109
build_is_airplane(param_00)
{
	if(!isdefined(level.airplane_list))
	{
		level.airplane_list = [];
	}

	if(!isdefined(param_00))
	{
		param_00 = level.vttype;
	}

	level.airplane_list[param_00] = 1;
}

//Function Number: 110
build_single_tread(param_00)
{
	if(!isdefined(level.vehicle_single_tread_list))
	{
		level.vehicle_single_tread_list = [];
	}

	if(!isdefined(param_00))
	{
		param_00 = level.vttype;
	}

	level.vehicle_single_tread_list[param_00] = 1;
}

//Function Number: 111
vehicle_set_health(param_00)
{
	if(isdefined(self.healthbuffer))
	{
		self.health = param_00 + self.healthbuffer;
	}
	else
	{
		self.health = param_00;
	}

	self.currenthealth = self.health;
}

//Function Number: 112
build_rider_death_func(param_00)
{
	if(!isdefined(level.vehicle_rider_death_func))
	{
		level.vehicle_rider_death_func = [];
	}

	level.vehicle_rider_death_func[level.vtclassname] = param_00;
}

//Function Number: 113
ishelicopter()
{
	return maps\_vehicle_code::_ishelicopter();
}

//Function Number: 114
isairplane()
{
	return maps\_vehicle_code::_isairplane();
}

//Function Number: 115
get_dummy()
{
	return maps\_vehicle_code::_get_dummy();
}

//Function Number: 116
vehicle_to_dummy(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!param_01)
	{
		self.modeldummy = spawn("script_model",self.origin);
		self.modeldummy setmodel(self.model);
		self.modeldummy.origin = self.origin;
		self.modeldummy.angles = self.angles;
		self.modeldummy useanimtree(#animtree);
	}
	else
	{
		self.modeldummy show();
		self.modeldummy unlink();
		self.modeldummy.origin = self.origin;
		self.modeldummy.angles = self.angles;
	}

	self transfermarkstonewscriptmodel(self.modeldummy);
	self hide();
	thread maps\_vehicle_code::model_dummy_death();
	move_riders_here(self.modeldummy);
	maps\_vehicle_code::move_turrets_here(self.modeldummy);
	move_truck_junk_here(self.modeldummy,param_00);
	thread maps\_vehicle_code::move_lights_here(self.modeldummy);
	maps\_vehicle_code::move_effects_ent_here(self.modeldummy,param_00);
	maps\_vehicle_code::copy_attachments(self.modeldummy);
	if(isdefined(self.customvehicletodummytransferfunc))
	{
		self thread [[ self.customvehicletodummytransferfunc ]](self.modeldummy,param_00);
	}

	self.modeldummyon = 1;
	if(maps\_vehicle_code::hashelicopterdustkickup())
	{
		self notify("stop_kicking_up_dust");
		thread maps\_vehicle_code::aircraft_wash_thread(self.modeldummy);
	}

	return self.modeldummy;
}

//Function Number: 117
build_death_jolt_delay(param_00)
{
	if(!isdefined(level.vehicle_death_jolt))
	{
		level.vehicle_death_jolt = [];
	}

	var_01 = spawnstruct();
	var_01.delay = param_00;
	level.vehicle_death_jolt[level.vtclassname] = var_01;
}

//Function Number: 118
enable_global_vehicle_spawn_functions()
{
	level.vehicle_spawn_functions_enable = 1;
}

//Function Number: 119
tank_crush(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = vehicle_to_dummy();
	var_09 = 7;
	var_0A = 5;
	var_0B = 5;
	self vehicle_setspeed(var_09,var_0A,var_0B);
	var_0C = getanimlength(param_02);
	var_0D = var_0C / 3;
	var_0E = var_0C / 3;
	var_0F = param_00.origin;
	var_10 = param_00.angles;
	var_11 = anglestoforward(var_10);
	var_12 = anglestoup(var_10);
	var_13 = anglestoright(var_10);
	var_14 = getstartorigin(var_0F,var_10,param_02);
	var_15 = getstartangles(var_0F,var_10,param_02);
	var_16 = anglestoforward(var_15);
	var_17 = anglestoup(var_15);
	var_18 = anglestoright(var_15);
	var_19 = anglestoforward(var_08.angles);
	var_1A = anglestoup(var_08.angles);
	var_1B = anglestoright(var_08.angles);
	var_1C = var_0F - var_14;
	var_1D = vectordot(var_1C,var_16);
	var_1E = vectordot(var_1C,var_17);
	var_1F = vectordot(var_1C,var_18);
	var_20 = spawn("script_origin",var_08.origin);
	var_20.origin = var_20.origin + maps\_utility::vector_multiply(var_19,var_1D);
	var_20.origin = var_20.origin + maps\_utility::vector_multiply(var_1A,var_1E);
	var_20.origin = var_20.origin + maps\_utility::vector_multiply(var_1B,var_1F);
	var_1C = anglestoforward(var_10);
	var_1D = vectordot(var_1C,var_16);
	var_1E = vectordot(var_1C,var_17);
	var_1F = vectordot(var_1C,var_18);
	var_21 = maps\_utility::vector_multiply(var_19,var_1D);
	var_21 = var_21 + maps\_utility::vector_multiply(var_1A,var_1E);
	var_21 = var_21 + maps\_utility::vector_multiply(var_1B,var_1F);
	var_20.angles = vectortoangles(var_21);
	if(isdefined(param_05))
	{
		level thread common_scripts\utility::play_sound_in_space(param_05,var_0F);
	}

	var_08 linkto(var_20);
	param_00 useanimtree(param_04);
	var_08 useanimtree(param_04);
	var_22 = tank_crush_fx_validation(level._vehicle_effect["tankcrush"]["window_med_left"],level._vehicle_effect["tankcrush"]["window_med"]);
	var_23 = tank_crush_fx_validation(level._vehicle_effect["tankcrush"]["window_med_right"],level._vehicle_effect["tankcrush"]["window_med"]);
	var_24 = tank_crush_fx_validation(level._vehicle_effect["tankcrush"]["window_large_back"],level._vehicle_effect["tankcrush"]["window_large"]);
	var_25 = tank_crush_fx_validation(level._vehicle_effect["tankcrush"]["window_large_front"],level._vehicle_effect["tankcrush"]["window_large"]);
	if(tank_crush_has_notetracks(param_03))
	{
		param_00 thread notetrack_tank_crush_fx_on_tag("tag_window_left_glass_fx",var_22,"veh_glass_break_small","left_glass_fx",param_03);
		param_00 thread notetrack_tank_crush_fx_on_tag("tag_window_right_glass_fx",var_23,"veh_glass_break_small","right_glass_fx",param_03);
		param_00 thread notetrack_tank_crush_fx_on_tag("tag_windshield_back_glass_fx",var_24,"veh_glass_break_large","back_glass_fx",param_03);
		param_00 thread notetrack_tank_crush_fx_on_tag("tag_windshield_front_glass_fx",var_25,"veh_glass_break_large","front_glass_fx",param_03);
	}
	else
	{
		param_00 thread tank_crush_fx_on_tag("tag_window_left_glass_fx",var_22,"veh_glass_break_small",0.2);
		param_00 thread tank_crush_fx_on_tag("tag_window_right_glass_fx",var_23,"veh_glass_break_small",0.4);
		param_00 thread tank_crush_fx_on_tag("tag_windshield_back_glass_fx",var_24,"veh_glass_break_large",0.7);
		param_00 thread tank_crush_fx_on_tag("tag_windshield_front_glass_fx",var_25,"veh_glass_break_large",1.5);
	}

	param_00 animscripted("tank_crush_anim",var_0F,var_10,param_03);
	var_08 animscripted("tank_crush_anim",var_20.origin,var_20.angles,param_02);
	if(isdefined(param_07))
	{
		thread [[ param_07 ]](param_00);
	}

	var_20 moveto(var_0F,var_0D,var_0D / 2,var_0D / 2);
	var_20 rotateto(var_10,var_0D,var_0D / 2,var_0D / 2);
	wait(var_0D);
	var_0C = var_0C - var_0D;
	var_0C = var_0C - var_0E;
	set_crush_vehicle_clips(param_00,"precrushed",0);
	set_crush_vehicle_clips(param_00,"postcrushed",1);
	wait(var_0C);
	var_26 = spawn("script_model",var_14);
	var_26.angles = var_15;
	var_27 = var_26 localtoworldcoords(getmovedelta(param_02,0,1));
	var_28 = var_15 + (0,getangledelta(param_02,0,1),0);
	var_26 delete();
	var_29 = anglestoforward(var_28);
	var_2A = anglestoup(var_28);
	var_2B = anglestoright(var_28);
	var_2C = self getattachpos(param_01);
	var_19 = anglestoforward(var_2C[1]);
	var_1A = anglestoup(var_2C[1]);
	var_1B = anglestoright(var_2C[1]);
	var_1C = var_0F - var_27;
	var_1D = vectordot(var_1C,var_29);
	var_1E = vectordot(var_1C,var_2A);
	var_1F = vectordot(var_1C,var_2B);
	var_20.final_origin = var_2C[0];
	var_20.final_origin = var_20.final_origin + maps\_utility::vector_multiply(var_19,var_1D);
	var_20.final_origin = var_20.final_origin + maps\_utility::vector_multiply(var_1A,var_1E);
	var_20.final_origin = var_20.final_origin + maps\_utility::vector_multiply(var_1B,var_1F);
	var_1C = anglestoforward(var_10);
	var_1D = vectordot(var_1C,var_29);
	var_1E = vectordot(var_1C,var_2A);
	var_1F = vectordot(var_1C,var_2B);
	var_21 = maps\_utility::vector_multiply(var_19,var_1D);
	var_21 = var_21 + maps\_utility::vector_multiply(var_1A,var_1E);
	var_21 = var_21 + maps\_utility::vector_multiply(var_1B,var_1F);
	var_20.final_angles = vectortoangles(var_21);
	if(getdvar("debug_tankcrush") == "1")
	{
		thread maps\_utility::draw_line_from_ent_for_time(level.player,self.origin,1,0,0,var_0C / 2);
		thread maps\_utility::draw_line_from_ent_for_time(level.player,var_27,0,1,0,var_0C / 2);
		thread maps\_utility::draw_line_from_ent_to_ent_for_time(level.player,var_20,0,0,1,var_0C / 2);
	}

	if(isdefined(param_06) && param_06)
	{
		var_2D = 1;
		var_2E = distance(self.origin,param_01.origin);
		var_2F = var_2E / var_0E;
		self vehicle_setspeed(var_2F,var_2F * 0.05);
	}

	var_20 moveto(var_20.final_origin,var_0E,var_0E / 2,var_0E / 2);
	var_20 rotateto(var_20.final_angles,var_0E,var_0E / 2,var_0E / 2);
	wait(var_0E);
	self attachpath(param_01);
	if(isdefined(param_06) && param_06)
	{
		self vehicle_setspeed(var_09,var_0A,var_0B);
	}

	dummy_to_vehicle();
}

//Function Number: 120
set_crush_vehicle_clips(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(param_01 != "precrushed" && param_01 != "postcrushed")
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = [];
	if(isdefined(param_00) && isdefined(param_00.targetname))
	{
		var_03 = getentarray(param_00.targetname + "_" + param_01 + "_clip","targetname");
	}
	else
	{
		var_04 = getentarray("script_brushmodel","classname");
		foreach(var_06 in var_04)
		{
			if(isdefined(var_06.targetname) && issubstr(var_06.targetname,param_01))
			{
				var_03 = common_scripts\utility::array_add(var_03,var_06);
			}
		}
	}

	foreach(var_09 in var_03)
	{
		if(param_02)
		{
			var_09 solid();
			continue;
		}

		var_09 notsolid();
	}
}

//Function Number: 121
tank_crush_fx_on_tag(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		wait(param_03);
	}

	playfxontag(param_01,self,param_00);
	if(isdefined(param_02))
	{
		thread maps\_utility::play_sound_on_tag(param_02,param_00);
	}
}

//Function Number: 122
notetrack_tank_crush_fx_on_tag(param_00,param_01,param_02,param_03,param_04)
{
	if(!animhasnotetrack(param_04,param_03))
	{
		return;
	}

	var_05 = getanimlength(param_04);
	var_06 = getnotetracktimes(param_04,param_03);
	var_05 = var_05 * var_06[0];
	wait(var_05);
	playfxontag(param_01,self,param_00);
	if(isdefined(param_02))
	{
		thread maps\_utility::play_sound_on_tag(param_02,param_00);
	}
}

//Function Number: 123
tank_crush_fx_validation(param_00,param_01)
{
	if(isdefined(param_00))
	{
		return param_00;
	}

	if(isdefined(param_01))
	{
		return param_01;
	}
}

//Function Number: 124
tank_crush_has_notetracks(param_00)
{
	if(animhasnotetrack(param_00,"left_glass_fx"))
	{
		return 1;
	}

	if(animhasnotetrack(param_00,"right_glass_fx"))
	{
		return 1;
	}

	if(animhasnotetrack(param_00,"back_glass_fx"))
	{
		return 1;
	}

	if(animhasnotetrack(param_00,"front_glass_fx"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 125
heli_squashes_stuff(param_00)
{
	self endon("death");
	level endon(param_00);
	for(;;)
	{
		self waittill("trigger",var_01);
		if(isalive(var_01))
		{
			if(var_01.team == "allies" && var_01 != level.player)
			{
				continue;
			}

			var_01 dodamage(var_01.health + 150,(0,0,0));
		}
	}
}

//Function Number: 126
show_rigs(param_00)
{
	wait(0.01);
	thread maps\_vehicle_aianim::getout_rigspawn(self,param_00);
	if(!self.riders.size)
	{
		return;
	}

	for(var_01 = 0;var_01 < self.riders.size;var_01++)
	{
		thread maps\_vehicle_aianim::getout_rigspawn(self,self.riders[var_01].vehicle_position);
	}
}

//Function Number: 127
build_exploder_event_with_targetname(param_00,param_01,param_02,param_03)
{
	thread build_exploder_event_with_targetname_internal(param_00,param_01,param_02,param_03);
}

//Function Number: 128
build_exploder_event_with_targetname_internal(param_00,param_01,param_02,param_03)
{
	var_04 = maps\_utility::getvehiclespawner(param_00);
	var_04 waittill("spawned",var_05);
	build_exploder_event_internal(var_05,param_01,param_02,param_03);
}

//Function Number: 129
build_exploder_event(param_00,param_01,param_02,param_03)
{
	thread build_exploder_event_internal(param_00,param_01,param_02,param_03);
}

//Function Number: 130
build_exploder_event_internal(param_00,param_01,param_02,param_03)
{
	param_00 waittill(param_01);
	if(isdefined(param_03))
	{
		wait(param_03);
	}

	common_scripts\_exploder::exploder(param_02);
}

//Function Number: 131
volume_up(param_00)
{
	self notify("new_volume_command");
	self endon("new_volume_command");
	self endon("death");
	self scalevolume(0,0);
	if(isdefined(self.snd_disable_vehicle_system))
	{
		self.snd_disable_vehicle_system = 0;
	}
	else
	{
		self vehicle_turnengineon();
	}

	self scalevolume(1,param_00);
	wait(param_00);
}

//Function Number: 132
volume_down(param_00)
{
	self notify("new_volume_command");
	self endon("new_volume_command");
	self endon("death");
	self scalevolume(0,param_00);
	wait(param_00);
	if(isdefined(self.snd_disable_vehicle_system))
	{
		self.snd_disable_vehicle_system = 1;
		return;
	}

	self vehicle_turnengineoff();
}

//Function Number: 133
lerp_enginesound(param_00,param_01,param_02)
{
}