/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_vehicle.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 100
 * Decompile Time: 1572 ms
 * Timestamp: 10/27/2023 2:02:12 AM
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
	var_01 = maps\_vehicle_code::_getvehiclespawnerarray_by_spawngroup(param_00);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_02[var_02.size] = vehicle_spawn(var_04);
	}

	return var_02;
}

//Function Number: 7
vehicle_spawn(param_00)
{
	return maps\_vehicle_code::_vehicle_spawn(param_00);
}

//Function Number: 8
kill_fx(param_00,param_01)
{
	return maps\_vehicle_code::_kill_fx(param_00,param_01);
}

//Function Number: 9
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

//Function Number: 10
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

//Function Number: 11
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

//Function Number: 12
build_rumble_unique(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = build_quake(param_01,param_02,param_03,param_04,param_05);
	var_06.rumble = param_00;
	self.vehicle_rumble_unique = var_06;
	vehicle_kill_rumble_forever();
	thread maps\_vehicle_code::vehicle_rumble();
}

//Function Number: 13
build_deathquake(param_00,param_01,param_02)
{
	var_03 = level.vtclassname;
	if(!isdefined(level.vehicle_death_earthquake))
	{
		level.vehicle_death_earthquake = [];
	}

	level.vehicle_death_earthquake[var_03] = build_quake(param_00,param_01,param_02);
}

//Function Number: 14
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

//Function Number: 15
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

//Function Number: 16
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

//Function Number: 17
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

//Function Number: 18
build_deathfx_generic_script_model(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = level.vtclassname;
	level.vtclassname = "script_model";
	build_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	level.vtclassname = var_0B;
}

//Function Number: 19
build_deathanim(param_00)
{
	var_01 = level.vtclassname;
	if(!isdefined(level.vehicle_death_anim[var_01]))
	{
		level.vehicle_death_anim[var_01] = [];
	}

	level.vehicle_death_anim[var_01] = param_00;
}

//Function Number: 20
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

//Function Number: 21
build_rocket_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = level.vtclassname;
	level.vtclassname = "rocket_death" + var_0B;
	build_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	level.vtclassname = var_0B;
}

//Function Number: 22
force_kill()
{
	return maps\_vehicle_code::_force_kill();
}

//Function Number: 23
godon()
{
	self.godmode = 1;
}

//Function Number: 24
godoff()
{
	self.godmode = 0;
}

//Function Number: 25
mgoff()
{
	return maps\_vehicle_code::_mgoff();
}

//Function Number: 26
mgon()
{
	return maps\_vehicle_code::_mgon();
}

//Function Number: 27
isvehicle()
{
	return isdefined(self.vehicletype);
}

//Function Number: 28
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

//Function Number: 29
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

//Function Number: 30
vehicle_is_crashing()
{
	return maps\_vehicle_code::_vehicle_is_crashing();
}

//Function Number: 31
is_godmode()
{
	return maps\_vehicle_code::_is_godmode();
}

//Function Number: 32
vehicle_kill_rumble_forever()
{
	self notify("kill_rumble_forever");
}

//Function Number: 33
move_truck_junk_here(param_00)
{
	if(!isdefined(self.truckjunk))
	{
		return;
	}

	foreach(var_02 in self.truckjunk)
	{
		if(var_02 == param_00)
		{
			continue;
		}

		var_02 unlink();
		if(isdefined(var_02.script_ghettotag))
		{
			var_02 linkto(param_00,var_02.script_ghettotag,var_02.base_origin,var_02.base_angles);
			continue;
		}

		var_02 linkto(param_00);
	}
}

//Function Number: 34
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

//Function Number: 35
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

//Function Number: 36
spawn_vehicles_from_targetname(param_00)
{
	var_01 = [];
	var_01 = maps\_vehicle_code::spawn_vehicles_from_targetname_newstyle(param_00);
	return var_01;
}

//Function Number: 37
spawn_vehicle_from_targetname(param_00)
{
	var_01 = spawn_vehicles_from_targetname(param_00);
	return var_01[0];
}

//Function Number: 38
spawn_vehicle_from_targetname_and_drive(param_00)
{
	var_01 = spawn_vehicles_from_targetname(param_00);
	thread gopath(var_01[0]);
	return var_01[0];
}

//Function Number: 39
spawn_vehicles_from_targetname_and_drive(param_00)
{
	var_01 = spawn_vehicles_from_targetname(param_00);
	foreach(var_03 in var_01)
	{
		thread gopath(var_03);
	}

	return var_01;
}

//Function Number: 40
aircraft_wash(param_00)
{
	thread maps\_vehicle_code::aircraft_wash_thread(param_00);
}

//Function Number: 41
vehicle_wheels_forward()
{
	maps\_vehicle_code::wheeldirectionchange(1);
}

//Function Number: 42
vehicle_wheels_backward()
{
	maps\_vehicle_code::wheeldirectionchange(0);
}

//Function Number: 43
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

//Function Number: 44
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

//Function Number: 45
build_hideparts(param_00,param_01)
{
	if(!isdefined(level.vehicle_hide_list))
	{
		level.vehicle_hide_list = [];
	}

	level.vehicle_hide_list[param_00] = param_01;
}

//Function Number: 46
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

//Function Number: 47
build_shoot_shock(param_00)
{
	precacheshellshock(param_00);
	level.vehicle_shoot_shock[level.vtclassname] = param_00;
}

//Function Number: 48
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

//Function Number: 49
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

//Function Number: 50
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

	if(!isdefined(level.vehicle_death_anim))
	{
		level.vehicle_death_anim = [];
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

//Function Number: 51
build_exhaust(param_00)
{
	level.vehicle_exhaust[level.vtmodel] = loadfx(param_00);
}

//Function Number: 52
build_treadfx(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		set_vehicle_effect(param_00,param_01,param_02);
		if(isdefined(param_03) && param_03)
		{
			set_vehicle_effect(param_00,param_01,param_02,"_bank");
			set_vehicle_effect(param_00,param_01,param_02,"_bank_lg");
			return;
		}

		return;
	}

	param_00 = level.vtclassname;
	maps\_treadfx::main(param_00);
}

//Function Number: 53
build_treadfx_script_model(param_00,param_01,param_02,param_03)
{
	build_treadfx(param_00,param_01 + "_script_model",param_02,param_03);
}

//Function Number: 54
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

//Function Number: 55
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

//Function Number: 56
build_all_treadfx(param_00,param_01)
{
	var_02 = get_surface_types();
	foreach(var_04 in var_02)
	{
		set_vehicle_effect(param_00,var_04);
	}
}

//Function Number: 57
set_vehicle_effect(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level._vehicle_effect))
	{
		level._vehicle_effect = [];
	}

	if(isdefined(param_03))
	{
		param_01 = param_01 + param_03;
		param_02 = param_02 + param_03;
	}

	if(isdefined(param_02))
	{
		level._vehicle_effect[param_00][param_01] = loadfx(param_02);
		return;
	}

	if(isdefined(level._vehicle_effect[param_00]) && isdefined(level._vehicle_effect[param_00][param_01]))
	{
		level._vehicle_effect[param_00][param_01] = undefined;
	}
}

//Function Number: 58
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

//Function Number: 59
build_team(param_00)
{
	level.vehicle_team[level.vtclassname] = param_00;
}

//Function Number: 60
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

//Function Number: 61
build_bulletshield(param_00)
{
	level.vehicle_bulletshield[level.vtclassname] = param_00;
}

//Function Number: 62
build_grenadeshield(param_00)
{
	level.vehicle_grenadeshield[level.vtclassname] = param_00;
}

//Function Number: 63
build_aianims(param_00,param_01)
{
	var_02 = level.vtclassname;
	level.vehicle_aianims[var_02] = [[ param_00 ]]();
	if(isdefined(param_01))
	{
		level.vehicle_aianims[var_02] = [[ param_01 ]](level.vehicle_aianims[var_02]);
	}
}

//Function Number: 64
build_frontarmor(param_00)
{
	level.vehicle_frontarmor[level.vtclassname] = param_00;
}

//Function Number: 65
build_attach_models(param_00)
{
	level.vehicle_attachedmodels[level.vtclassname] = [[ param_00 ]]();
}

//Function Number: 66
build_unload_groups(param_00)
{
	level.vehicle_unloadgroups[level.vtclassname] = [[ param_00 ]]();
}

//Function Number: 67
build_life(param_00,param_01,param_02)
{
	var_03 = level.vtclassname;
	level.vehicle_life[var_03] = param_00;
	level.vehicle_life_range_low[var_03] = param_01;
	level.vehicle_life_range_high[var_03] = param_02;
}

//Function Number: 68
build_deckdust(param_00)
{
	level.vehicle_deckdust[level.vtmodel] = loadfx(param_00);
}

//Function Number: 69
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

//Function Number: 70
build_localinit(param_00)
{
	level.vehicleinitthread[level.vttype][level.vtclassname] = param_00;
}

//Function Number: 71
is_dummy()
{
	return self.modeldummyon;
}

//Function Number: 72
vehicle_load_ai(param_00,param_01,param_02)
{
	maps\_vehicle_aianim::load_ai(param_00,undefined,param_02);
}

//Function Number: 73
vehicle_load_ai_single(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	maps\_vehicle_aianim::load_ai(var_03,param_01,param_02);
}

//Function Number: 74
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

//Function Number: 75
mount_snowmobile(param_00,param_01)
{
	return maps\_vehicle_code::_mount_snowmobile(param_00,param_01);
}

//Function Number: 76
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

//Function Number: 77
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

//Function Number: 78
vehicle_ai_event(param_00)
{
	return maps\_vehicle_aianim::animate_guys(param_00);
}

//Function Number: 79
vehicle_unload(param_00)
{
	return maps\_vehicle_code::_vehicle_unload(param_00);
}

//Function Number: 80
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

//Function Number: 81
vehicle_turret_scan_off()
{
	self notify("stop_scanning_turret");
}

//Function Number: 82
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

//Function Number: 83
vehicle_lights_on(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	maps\_vehicle_code::lights_on(param_00,param_01);
}

//Function Number: 84
vehicle_lights_off(param_00,param_01)
{
	maps\_vehicle_code::lights_off(param_00,param_01);
}

//Function Number: 85
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

//Function Number: 86
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

//Function Number: 87
vehicle_switch_paths(param_00,param_01)
{
	self setswitchnode(param_00,param_01);
	self.attachedpath = param_01;
	thread vehicle_paths();
}

//Function Number: 88
vehicle_stop_named(param_00,param_01,param_02)
{
	return maps\_vehicle_code::_vehicle_stop_named(param_00,param_01,param_02);
}

//Function Number: 89
vehicle_resume_named(param_00)
{
	return maps\_vehicle_code::_vehicle_resume_named(param_00);
}

//Function Number: 90
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

//Function Number: 91
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

//Function Number: 92
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

//Function Number: 93
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

//Function Number: 94
build_rider_death_func(param_00)
{
	if(!isdefined(level.vehicle_rider_death_func))
	{
		level.vehicle_rider_death_func = [];
	}

	level.vehicle_rider_death_func[level.vtclassname] = param_00;
}

//Function Number: 95
ishelicopter()
{
	return maps\_vehicle_code::_ishelicopter();
}

//Function Number: 96
isairplane()
{
	return maps\_vehicle_code::_isairplane();
}

//Function Number: 97
get_dummy()
{
	return maps\_vehicle_code::_get_dummy();
}

//Function Number: 98
vehicle_to_dummy()
{
	self.modeldummy = spawn("script_model",self.origin);
	self.modeldummy setmodel(self.model);
	self.modeldummy.origin = self.origin;
	self.modeldummy.angles = self.angles;
	self.modeldummy useanimtree(#animtree);
	self hide();
	thread maps\_vehicle_code::model_dummy_death();
	move_riders_here(self.modeldummy);
	maps\_vehicle_code::move_turrets_here(self.modeldummy);
	move_truck_junk_here(self.modeldummy);
	thread maps\_vehicle_code::move_lights_here(self.modeldummy);
	maps\_vehicle_code::move_effects_ent_here(self.modeldummy);
	maps\_vehicle_code::copy_attachments(self.modeldummy);
	self.modeldummyon = 1;
	if(maps\_vehicle_code::hashelicopterdustkickup())
	{
		self notify("stop_kicking_up_dust");
		thread maps\_vehicle_code::aircraft_wash_thread(self.modeldummy);
	}

	return self.modeldummy;
}

//Function Number: 99
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

//Function Number: 100
enable_global_vehicle_spawn_functions()
{
	level.vehicle_spawn_functions_enable = 1;
}