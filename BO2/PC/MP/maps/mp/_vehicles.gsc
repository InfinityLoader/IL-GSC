/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_vehicles.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 86
 * Decompile Time: 29 ms
 * Timestamp: 10/28/2023 12:11:05 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_spawning;
#include maps/mp/killstreaks/_qrdrone;
#include maps/mp/killstreaks/_rcbomb;

#using_animtree( "mp_vehicles" );

//Function Number: 1
init()
{
	precachevehicle(get_default_vehicle_name());
	setdvar("scr_veh_cleanupdebugprint","0");
	setdvar("scr_veh_driversarehidden","1");
	setdvar("scr_veh_driversareinvulnerable","1");
	setdvar("scr_veh_alive_cleanuptimemin","119");
	setdvar("scr_veh_alive_cleanuptimemax","120");
	setdvar("scr_veh_dead_cleanuptimemin","20");
	setdvar("scr_veh_dead_cleanuptimemax","30");
	setdvar("scr_veh_cleanuptime_dmgfactor_min","0.33");
	setdvar("scr_veh_cleanuptime_dmgfactor_max","1.0");
	setdvar("scr_veh_cleanuptime_dmgfactor_deadtread","0.25");
	setdvar("scr_veh_cleanuptime_dmgfraction_curve_begin","0.0");
	setdvar("scr_veh_cleanuptime_dmgfraction_curve_end","1.0");
	setdvar("scr_veh_cleanupabandoned","1");
	setdvar("scr_veh_cleanupdrifted","1");
	setdvar("scr_veh_cleanupmaxspeedmph","1");
	setdvar("scr_veh_cleanupmindistancefeet","75");
	setdvar("scr_veh_waittillstoppedandmindist_maxtime","10");
	setdvar("scr_veh_waittillstoppedandmindist_maxtimeenabledistfeet","5");
	setdvar("scr_veh_respawnafterhuskcleanup","1");
	setdvar("scr_veh_respawntimemin","50");
	setdvar("scr_veh_respawntimemax","90");
	setdvar("scr_veh_respawnwait_maxiterations","30");
	setdvar("scr_veh_respawnwait_iterationwaitseconds","1");
	setdvar("scr_veh_disablerespawn","0");
	setdvar("scr_veh_disableoverturndamage","0");
	setdvar("scr_veh_explosion_spawnfx","1");
	setdvar("scr_veh_explosion_doradiusdamage","1");
	setdvar("scr_veh_explosion_radius","256");
	setdvar("scr_veh_explosion_mindamage","20");
	setdvar("scr_veh_explosion_maxdamage","200");
	setdvar("scr_veh_ondeath_createhusk","1");
	setdvar("scr_veh_ondeath_usevehicleashusk","1");
	setdvar("scr_veh_explosion_husk_forcepointvariance","30");
	setdvar("scr_veh_explosion_husk_horzvelocityvariance","25");
	setdvar("scr_veh_explosion_husk_vertvelocitymin","100");
	setdvar("scr_veh_explosion_husk_vertvelocitymax","200");
	setdvar("scr_veh_explode_on_cleanup","1");
	setdvar("scr_veh_disappear_maxwaittime","60");
	setdvar("scr_veh_disappear_maxpreventdistancefeet","30");
	setdvar("scr_veh_disappear_maxpreventvisibilityfeet","150");
	setdvar("scr_veh_health_tank","1350");
	level.vehicle_drivers_are_invulnerable = GetDvarInt(#"27D6F6C");
	level.onejectoccupants = ::vehicle_eject_all_occupants;
	level.vehiclehealths["panzer4_mp"] = 2600;
	level.vehiclehealths["t34_mp"] = 2600;
	setdvar("scr_veh_health_jeep","700");
	if(init_vehicle_entities())
	{
		level.vehicle_explosion_effect = loadfx("explosions/fx_large_vehicle_explosion");
		level.veh_husk_models = [];
		if(IsDefined(level.use_new_veh_husks))
		{
			level.veh_husk_models["t34_mp"] = "veh_t34_destroyed_mp";
		}

		if(IsDefined(level.onaddvehiclehusks))
		{
			[[ level.onaddvehiclehusks ]]();
		}

		keys = getarraykeys(level.veh_husk_models);
		for(i = 0;i < keys.size;i++)
		{
			precachemodel(level.veh_husk_models[keys[i]]);
		}

		precacherumble("tank_damage_light_mp");
		precacherumble("tank_damage_heavy_mp");
		level._effect["tanksquish"] = loadfx("maps/see2/fx_body_blood_splat");
	}

	chopper_player_get_on_gun = %int_huey_gunner_on;
	chopper_door_open = %v_huey_door_open;
	chopper_door_open_state = %v_huey_door_open_state;
	chopper_door_closed_state = %v_huey_door_close_state;
	killbrushes = getentarray("water_killbrush","targetname");
	foreach(brush in killbrushes)
	{
		brush thread water_killbrush_think();
	}
}

//Function Number: 2
water_killbrush_think()
{
	for(;;)
	{
		self waittill("trigger",entity);
		if(IsDefined(entity))
		{
			if(IsDefined(entity.targetname))
			{
				if(entity.targetname == "rcbomb")
				{
					entity maps/mp/killstreaks/_rcbomb::rcbomb_force_explode();
				}
				else if(entity.targetname == "talon" && !is_true(entity.dead))
				{
					entity notify("death");
				}
			}

			if(IsDefined(entity.helitype) && entity.helitype == "qrdrone")
			{
				entity maps/mp/killstreaks/_qrdrone::qrdrone_force_destroy();
			}
		}
	}
}

//Function Number: 3
initialize_vehicle_damage_effects_for_level()
{
	k_mild_damage_index = 0;
	k_moderate_damage_index = 1;
	k_severe_damage_index = 2;
	k_total_damage_index = 3;
	k_mild_damage_health_percentage = 0.85;
	k_moderate_damage_health_percentage = 0.55;
	k_severe_damage_health_percentage = 0.35;
	k_total_damage_health_percentage = 0;
	level.k_mild_damage_health_percentage = k_mild_damage_health_percentage;
	level.k_moderate_damage_health_percentage = k_moderate_damage_health_percentage;
	level.k_severe_damage_health_percentage = k_severe_damage_health_percentage;
	level.k_total_damage_health_percentage = k_total_damage_health_percentage;
	level.vehicles_damage_states = [];
	level.vehicles_husk_effects = [];
	level.vehicles_damage_treadfx = [];
	vehicle_name = get_default_vehicle_name();
	level.vehicles_damage_states[vehicle_name] = [];
	level.vehicles_damage_treadfx[vehicle_name] = [];
	level.vehicles_damage_states[vehicle_name][k_mild_damage_index] = spawnstruct();
	level.vehicles_damage_states[vehicle_name][k_mild_damage_index].health_percentage = k_mild_damage_health_percentage;
	level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array = [];
	level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array[0] = spawnstruct();
	level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array[0].damage_effect = loadfx("vehicle/vfire/fx_tank_sherman_smldr");
	level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array[0].sound_effect = undefined;
	level.vehicles_damage_states[vehicle_name][k_mild_damage_index].effect_array[0].vehicle_tag = "tag_origin";
	level.vehicles_damage_states[vehicle_name][k_moderate_damage_index] = spawnstruct();
	level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].health_percentage = k_moderate_damage_health_percentage;
	level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array = [];
	level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array[0] = spawnstruct();
	level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array[0].damage_effect = loadfx("vehicle/vfire/fx_vfire_med_12");
	level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array[0].sound_effect = undefined;
	level.vehicles_damage_states[vehicle_name][k_moderate_damage_index].effect_array[0].vehicle_tag = "tag_origin";
	level.vehicles_damage_states[vehicle_name][k_severe_damage_index] = spawnstruct();
	level.vehicles_damage_states[vehicle_name][k_severe_damage_index].health_percentage = k_severe_damage_health_percentage;
	level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array = [];
	level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array[0] = spawnstruct();
	level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array[0].damage_effect = loadfx("vehicle/vfire/fx_vfire_sherman");
	level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array[0].sound_effect = undefined;
	level.vehicles_damage_states[vehicle_name][k_severe_damage_index].effect_array[0].vehicle_tag = "tag_origin";
	level.vehicles_damage_states[vehicle_name][k_total_damage_index] = spawnstruct();
	level.vehicles_damage_states[vehicle_name][k_total_damage_index].health_percentage = k_total_damage_health_percentage;
	level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array = [];
	level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[0] = spawnstruct();
	level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[0].damage_effect = loadfx("explosions/fx_large_vehicle_explosion");
	level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[0].sound_effect = "vehicle_explo";
	level.vehicles_damage_states[vehicle_name][k_total_damage_index].effect_array[0].vehicle_tag = "tag_origin";
	default_husk_effects = spawnstruct();
	default_husk_effects.damage_effect = undefined;
	default_husk_effects.sound_effect = undefined;
	default_husk_effects.vehicle_tag = "tag_origin";
	level.vehicles_husk_effects[vehicle_name] = default_husk_effects;
}

//Function Number: 4
get_vehicle_name(vehicle)
{
	name = "";
	if(IsDefined(vehicle))
	{
		if(IsDefined(vehicle.vehicletype))
		{
			name = vehicle.vehicletype;
		}
	}

	return name;
}

//Function Number: 5
get_default_vehicle_name()
{
	return "defaultvehicle_mp";
}

//Function Number: 6
get_vehicle_name_key_for_damage_states(vehicle)
{
	vehicle_name = get_vehicle_name(vehicle);
	if(!(IsDefined(level.vehicles_damage_states[vehicle_name])))
	{
		vehicle_name = get_default_vehicle_name();
	}

	return vehicle_name;
}

//Function Number: 7
get_vehicle_damage_state_index_from_health_percentage(vehicle)
{
	damage_state_index = -1;
	vehicle_name = get_vehicle_name_key_for_damage_states();
	for(test_index = 0;test_index < level.vehicles_damage_states[vehicle_name].size;test_index++)
	{
		if(vehicle.current_health_percentage <= level.vehicles_damage_states[vehicle_name][test_index].health_percentage)
		{
			damage_state_index = test_index;
		}
		else
		{
			break;
		}
	}

	return damage_state_index;
}

//Function Number: 8
update_damage_effects(vehicle,attacker)
{
	if(vehicle.initial_state.health > 0)
	{
		previous_damage_state_index = get_vehicle_damage_state_index_from_health_percentage(vehicle);
		vehicle.current_health_percentage = vehicle.health / vehicle.initial_state.health;
		current_damage_state_index = get_vehicle_damage_state_index_from_health_percentage(vehicle);
		if(previous_damage_state_index != current_damage_state_index)
		{
			vehicle notify("damage_state_changed");
			if(previous_damage_state_index < 0)
			{
				start_damage_state_index = 0;
			}
			else
			{
				start_damage_state_index = previous_damage_state_index + 1;
			}

			play_damage_state_effects(vehicle,start_damage_state_index,current_damage_state_index);
			if(vehicle.health <= 0)
			{
				vehicle kill_vehicle(attacker);
			}
		}
	}
}

//Function Number: 9
play_damage_state_effects(vehicle,start_damage_state_index,end_damage_state_index)
{
	vehicle_name = get_vehicle_name_key_for_damage_states(vehicle);
	for(damage_state_index = start_damage_state_index;damage_state_index <= end_damage_state_index;damage_state_index++)
	{
		for(effect_index = 0;effect_index < level.vehicles_damage_states[vehicle_name][damage_state_index].effect_array.size;effect_index++)
		{
			effects = level.vehicles_damage_states[vehicle_name][damage_state_index].effect_array[effect_index];
			vehicle thread play_vehicle_effects(effects);
		}
	}
}

//Function Number: 10
play_vehicle_effects(effects,isdamagedtread)
{
	self endon("delete");
	self endon("removed");
	if(!IsDefined(isdamagedtread) || isdamagedtread == 0)
	{
		self endon("damage_state_changed");
	}

	if(IsDefined(effects.sound_effect))
	{
		self playsound(effects.sound_effect);
	}

	waittime = 0;
	if(IsDefined(effects.damage_effect_loop_time))
	{
		waittime = effects.damage_effect_loop_time;
	}

	while(waittime > 0)
	{
		if(IsDefined(effects.damage_effect))
		{
			playfxontag(effects.damage_effect,self,effects.vehicle_tag);
		}

		wait(waittime);
	}
}

//Function Number: 11
init_vehicle_entities()
{
	vehicles = getentarray("script_vehicle","classname");
	array_thread(vehicles,::init_original_vehicle);
	if(IsDefined(vehicles))
	{
		return vehicles.size;
	}
}

//Function Number: 12
precache_vehicles()
{
}

//Function Number: 13
register_vehicle()
{
	if(!(IsDefined(level.vehicles_list)))
	{
		level.vehicles_list = [];
	}

	level.vehicles_list[level.vehicles_list.size] = self;
}

//Function Number: 14
manage_vehicles()
{
	if(!(IsDefined(level.vehicles_list)))
	{
		return 1;
	}
	else
	{
		max_vehicles = getmaxvehicles();
		newarray = [];
		for(i = 0;i < level.vehicles_list.size;i++)
		{
			if(IsDefined(level.vehicles_list[i]))
			{
				newarray[newarray.size] = level.vehicles_list[i];
			}
		}

		level.vehicles_list = newarray;
		vehiclestodelete = level.vehicles_list.size + 1 - max_vehicles;
		if(vehiclestodelete > 0)
		{
			newarray = [];
			for(i = 0;i < level.vehicles_list.size;i++)
			{
				vehicle = level.vehicles_list[i];
				if(vehiclestodelete > 0)
				{
					if(IsDefined(vehicle.is_husk) && !IsDefined(vehicle.permanentlyremoved))
					{
						deleted = vehicle husk_do_cleanup();
						if(deleted)
						{
							vehiclestodelete--;
						}
						else
						{
							newarray[newarray.size] = vehicle;
						}
					}
				}
			}

			level.vehicles_list = newarray;
		}

		return level.vehicles_list.size < max_vehicles;
	}
}

//Function Number: 15
init_vehicle()
{
	self register_vehicle();
	if(IsDefined(level.vehiclehealths) && IsDefined(level.vehiclehealths[self.vehicletype]))
	{
		self.maxhealth = level.vehiclehealths[self.vehicletype];
	}
	else
	{
		self.maxhealth = GetDvarInt(#"20E17551");
/#
		println("No health specified for vehicle type " + self.vehicletype + "! Using default...");
	}
#/
	self.health = self.maxhealth;
	self vehicle_record_initial_values();
	self init_vehicle_threads();
	self maps/mp/gametypes/_spawning::create_vehicle_influencers();
}

//Function Number: 16
initialize_vehicle_damage_state_data()
{
	if(self.initial_state.health > 0)
	{
		self.current_health_percentage = self.health / self.initial_state.health;
		self.previous_health_percentage = self.health / self.initial_state.health;
	}
	else
	{
		self.current_health_percentage = 1;
		self.previous_health_percentage = 1;
	}
}

//Function Number: 17
init_original_vehicle()
{
	self.original_vehicle = 1;
	self init_vehicle();
}

//Function Number: 18
vehicle_wait_player_enter_t()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	while(1)
	{
		self waittill("enter_vehicle",player);
		player thread player_wait_exit_vehicle_t();
		player player_update_vehicle_hud(1,self);
	}
}

//Function Number: 19
player_wait_exit_vehicle_t()
{
	self endon("disconnect");
	self waittill("exit_vehicle",vehicle);
	self player_update_vehicle_hud(0,vehicle);
}

//Function Number: 20
vehicle_wait_damage_t()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	while(1)
	{
		self waittill("damage");
		occupants = self getvehoccupants();
		if(IsDefined(occupants))
		{
			for(i = 0;i < occupants.size;i++)
			{
				occupants[i] player_update_vehicle_hud(1,self);
			}
		}
	}
}

//Function Number: 21
player_update_vehicle_hud(show,vehicle)
{
	if(show)
	{
		if(!(IsDefined(self.vehiclehud)))
		{
			self.vehiclehud = createbar((1,1,1),64,16);
			self.vehiclehud setpoint("CENTER","BOTTOM",0,-40);
			self.vehiclehud.alpha = 0.75;
		}

		self.vehiclehud updatebar(vehicle.health / vehicle.initial_state.health);
	}
	else if(IsDefined(self.vehiclehud))
	{
		self.vehiclehud destroyelem();
	}

	if(GetDvar(#"480B1A1D") != "")
	{
		if(GetDvarInt(#"480B1A1D") != 0)
		{
			if(show)
			{
				if(!(IsDefined(self.vehiclehudhealthnumbers)))
				{
					self.vehiclehudhealthnumbers = createfontstring("default",2);
					self.vehiclehudhealthnumbers setparent(self.vehiclehud);
					self.vehiclehudhealthnumbers setpoint("LEFT","RIGHT",8,0);
					self.vehiclehudhealthnumbers.alpha = 0.75;
					self.vehiclehudhealthnumbers.hidewheninmenu = 0;
					self.vehiclehudhealthnumbers.archived = 0;
				}

				self.vehiclehudhealthnumbers setvalue(vehicle.health);
			}
			else if(IsDefined(self.vehiclehudhealthnumbers))
			{
				self.vehiclehudhealthnumbers destroyelem();
			}
		}
	}
}

//Function Number: 22
init_vehicle_threads()
{
	self thread vehicle_fireweapon_t();
	self thread vehicle_abandoned_by_drift_t();
	self thread vehicle_abandoned_by_occupants_t();
	self thread vehicle_damage_t();
	self thread vehicle_ghost_entering_occupants_t();
	self thread vehicle_recycle_spawner_t();
	self thread vehicle_disconnect_paths();
	if(IsDefined(level.enablevehiclehealthbar) && level.enablevehiclehealthbar)
	{
		self thread vehicle_wait_player_enter_t();
		self thread vehicle_wait_damage_t();
	}

	self thread vehicle_wait_tread_damage();
	self thread vehicle_overturn_eject_occupants();
	if(GetDvarInt(#"63AF17E6") == 0)
	{
		self thread vehicle_overturn_suicide();
	}

/#
	self thread cleanup_debug_print_t();
	self thread cleanup_debug_print_clearmsg_t();
#/
}

//Function Number: 23
build_template(type,model,typeoverride)
{
	if(IsDefined(typeoverride))
	{
		type = typeoverride;
	}

	if(!(IsDefined(level.vehicle_death_fx)))
	{
		level.vehicle_death_fx = [];
	}

	if(!(IsDefined(level.vehicle_death_fx[type])))
	{
		level.vehicle_death_fx[type] = [];
	}

	level.vehicle_compassicon[type] = 0;
	level.vehicle_team[type] = "axis";
	level.vehicle_life[type] = 999;
	level.vehicle_hasmainturret[model] = 0;
	level.vehicle_mainturrets[model] = [];
	level.vtmodel = model;
	level.vttype = type;
}

//Function Number: 24
build_rumble(rumble,scale,duration,radius,basetime,randomaditionaltime)
{
	if(!(IsDefined(level.vehicle_rumble)))
	{
		level.vehicle_rumble = [];
	}

	struct = build_quake(scale,duration,radius,basetime,randomaditionaltime);
/#
	assert(IsDefined(rumble));
#/
	precacherumble(rumble);
	struct.rumble = rumble;
	level.vehicle_rumble[level.vttype] = struct;
	precacherumble("tank_damaged_rumble_mp");
}

//Function Number: 25
build_quake(scale,duration,radius,basetime,randomaditionaltime)
{
	struct = spawnstruct();
	struct.scale = scale;
	struct.duration = duration;
	struct.radius = radius;
	if(IsDefined(basetime))
	{
		struct.basetime = basetime;
	}

	if(IsDefined(randomaditionaltime))
	{
		struct.randomaditionaltime = randomaditionaltime;
	}

	return struct;
}

//Function Number: 26
build_exhaust(effect)
{
	level.vehicle_exhaust[level.vtmodel] = loadfx(effect);
}

//Function Number: 27
cleanup_debug_print_t()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
/#
	while(1)
	{
		if(IsDefined(self.debug_message) && GetDvarInt(#"AAD1512A") != 0)
		{
			print3d(150 + VectorScale((0,0,1)),self.origin,self.debug_message,(0,1,0),1,1);
		}

		wait(0.01);
	}
#/
}

//Function Number: 28
cleanup_debug_print_clearmsg_t()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
/#
	while(1)
	{
		self waittill("enter_vehicle");
		self.debug_message = undefined;
	}
#/
}

//Function Number: 29
cleanup_debug_print(message)
{
/#
	self.debug_message = message;
#/
}

//Function Number: 30
vehicle_abandoned_by_drift_t()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	self wait_then_cleanup_vehicle("Drift Test","scr_veh_cleanupdrifted");
}

//Function Number: 31
vehicle_abandoned_by_occupants_timeout_t()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	self wait_then_cleanup_vehicle("Abandon Test","scr_veh_cleanupabandoned");
}

//Function Number: 32
wait_then_cleanup_vehicle(test_name,cleanup_dvar_name)
{
	self endon("enter_vehicle");
	self wait_until_severely_damaged();
	self do_alive_cleanup_wait(test_name);
	self wait_for_vehicle_to_stop_outside_min_radius();
	self cleanup(test_name,cleanup_dvar_name,::vehicle_recycle);
}

//Function Number: 33
wait_until_severely_damaged()
{
	while(1)
	{
		health_percentage = self.health / self.initial_state.health;
		if(IsDefined(level.k_severe_damage_health_percentage))
		{
			self cleanup_debug_print("Damage Test: Still healthy - (" + health_percentage + " >= " + level.k_severe_damage_health_percentage + ") and working treads");
		}
		else
		{
			self cleanup_debug_print("Damage Test: Still healthy and working treads");
		}

		self waittill("damage");
		health_percentage = self.health / self.initial_state.health;
		if(health_percentage < level.k_severe_damage_health_percentage)
		{
			break;
		}
	}
}

//Function Number: 34
get_random_cleanup_wait_time(state)
{
	varnameprefix = "scr_veh_" + state + "_cleanuptime";
	mintime = GetDvarFloat(varnameprefix + "min");
	maxtime = GetDvarFloat(varnameprefix + "max");
	if(maxtime > mintime)
	{
		return randomfloatrange(mintime,maxtime);
	}
	else
	{
		return maxtime;
	}
}

//Function Number: 35
do_alive_cleanup_wait(test_name)
{
	initialrandomwaitseconds = get_random_cleanup_wait_time("alive");
	secondswaited = 0;
	seconds_per_iteration = 1;
	while(1)
	{
		curve_begin = GetDvarFloat(#"EF99099A");
		curve_end = GetDvarFloat(#"7CCFC4CC");
		factor_min = GetDvarFloat(#"D921389E");
		factor_max = GetDvarFloat(#"D92137A0");
		treaddeaddamagefactor = GetDvarFloat(#"ED378BD8");
		damagefraction = 0;
		if(self is_vehicle())
		{
			damagefraction = self.initial_state.health - self.health / self.initial_state.health;
		}
		else
		{
			damagefraction = 1;
		}

		damagefactor = 0;
		if(damagefraction <= curve_begin)
		{
			damagefactor = factor_max;
		}
		else if(damagefraction >= curve_end)
		{
			damagefactor = factor_min;
		}
		else
		{
			dydx = factor_min - factor_max / curve_end - curve_begin;
			damagefactor = factor_max + damagefraction - curve_begin * dydx;
		}

		totalsecstowait = initialrandomwaitseconds * damagefactor;
		if(secondswaited >= totalsecstowait)
		{
			break;
		}

		self cleanup_debug_print(test_name + ": Waiting " + totalsecstowait - secondswaited + "s");
		wait(seconds_per_iteration);
		secondswaited = secondswaited + seconds_per_iteration;
	}
}

//Function Number: 36
do_dead_cleanup_wait(test_name)
{
	total_secs_to_wait = get_random_cleanup_wait_time("dead");
	seconds_waited = 0;
	seconds_per_iteration = 1;
	while(seconds_waited < total_secs_to_wait)
	{
		self cleanup_debug_print(test_name + ": Waiting " + total_secs_to_wait - seconds_waited + "s");
		wait(seconds_per_iteration);
		seconds_waited = seconds_waited + seconds_per_iteration;
	}
}

//Function Number: 37
cleanup(test_name,cleanup_dvar_name,cleanup_func)
{
	keep_waiting = 1;
	while(keep_waiting)
	{
		cleanupenabled = !IsDefined(cleanup_dvar_name) || GetDvarInt(cleanup_dvar_name) != 0;
		if(cleanupenabled != 0)
		{
			self [[ cleanup_func ]]();
			break;
		}

		keep_waiting = 0;
/#
		self cleanup_debug_print("Cleanup disabled for " + test_name + " ( dvar = " + cleanup_dvar_name + " )");
		wait(5);
		keep_waiting = 1;
#/
	}
}

//Function Number: 38
vehicle_wait_tread_damage()
{
	self endon("death");
	self endon("delete");
	vehicle_name = get_vehicle_name(self);
	while(1)
	{
		self waittill("broken",brokennotify);
		if(brokennotify == "left_tread_destroyed")
		{
			if(IsDefined(level.vehicles_damage_treadfx[vehicle_name]) && IsDefined(level.vehicles_damage_treadfx[vehicle_name][0]))
			{
				self thread play_vehicle_effects(level.vehicles_damage_treadfx[vehicle_name][0],1);
			}

			continue;
		}

		if(brokennotify == "right_tread_destroyed")
		{
			if(IsDefined(level.vehicles_damage_treadfx[vehicle_name]) && IsDefined(level.vehicles_damage_treadfx[vehicle_name][1]))
			{
				self thread play_vehicle_effects(level.vehicles_damage_treadfx[vehicle_name][1],1);
			}
		}
	}
}

//Function Number: 39
wait_for_vehicle_to_stop_outside_min_radius()
{
	maxwaittime = GetDvarFloat(#"49F6FDB6");
	iterationwaitseconds = 1;
	maxwaittimeenabledistinches = 12 * GetDvarFloat(#"DC2C41B5");
	initialorigin = self.initial_state.origin;
	for(totalsecondswaited = 0;totalsecondswaited < maxwaittime;totalsecondswaited = totalsecondswaited + iterationwaitseconds)
	{
		speedmph = self getspeedmph();
		cutoffmph = GetDvarFloat(#"69770092");
		if(speedmph > cutoffmph)
		{
			cleanup_debug_print("(" + maxwaittime - totalsecondswaited + "s) Speed: " + speedmph + ">" + cutoffmph);
		}
		else
		{
			break;
		}

		wait(iterationwaitseconds);
	}
}

//Function Number: 40
vehicle_abandoned_by_occupants_t()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	while(1)
	{
		self waittill("exit_vehicle");
		occupants = self getvehoccupants();
		if(occupants.size == 0)
		{
			self play_start_stop_sound("tank_shutdown_sfx");
			self thread vehicle_abandoned_by_occupants_timeout_t();
		}
	}
}

//Function Number: 41
play_start_stop_sound(sound_alias,modulation)
{
	if(IsDefined(self.start_stop_sfxid))
	{
	}

	self.start_stop_sfxid = self playsound(sound_alias);
}

//Function Number: 42
vehicle_ghost_entering_occupants_t()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	while(1)
	{
		self waittill("enter_vehicle",player,seat);
		isdriver = seat == 0;
		if(GetDvarInt(#"8AB44691") != 0 && isdriver)
		{
			player ghost();
		}

		occupants = self getvehoccupants();
		if(occupants.size == 1)
		{
			self play_start_stop_sound("tank_startup_sfx");
		}

		player thread player_change_seat_handler_t(self);
		player thread player_leave_vehicle_cleanup_t(self);
	}
}

//Function Number: 43
player_is_occupant_invulnerable(smeansofdeath)
{
	if(self isremotecontrolling())
	{
		return 0;
	}

	if(!(IsDefined(level.vehicle_drivers_are_invulnerable)))
	{
		level.vehicle_drivers_are_invulnerable = 0;
	}

	invulnerable = level.vehicle_drivers_are_invulnerable && self player_is_driver();
	return invulnerable;
}

//Function Number: 44
player_is_driver()
{
	if(!(isalive(self)))
	{
		return 0;
	}

	vehicle = self getvehicleoccupied();
	if(IsDefined(vehicle))
	{
		seat = vehicle getoccupantseat(self);
		if(IsDefined(seat) && seat == 0)
		{
			return 1;
		}
	}
}

//Function Number: 45
player_change_seat_handler_t(vehicle)
{
	self endon("disconnect");
	self endon("exit_vehicle");
	while(1)
	{
		self waittill("change_seat",vehicle,oldseat,newseat);
		isdriver = newseat == 0;
		if(isdriver)
		{
			if(GetDvarInt(#"8AB44691") != 0)
			{
				self ghost();
			}

			continue;
		}

		self show();
	}
}

//Function Number: 46
player_leave_vehicle_cleanup_t(vehicle)
{
	self endon("disconnect");
	self waittill("exit_vehicle");
	currentweapon = self getcurrentweapon();
	if(self.lastweapon != currentweapon && self.lastweapon != "none")
	{
		self switchtoweapon(self.lastweapon);
	}

	self show();
}

//Function Number: 47
vehicle_is_tank()
{
	return self.vehicletype == "sherman_mp" || self.vehicletype == "panzer4_mp" || self.vehicletype == "type97_mp" || self.vehicletype == "t34_mp";
}

//Function Number: 48
vehicle_record_initial_values()
{
	if(!(IsDefined(self.initial_state)))
	{
		self.initial_state = spawnstruct();
	}

	if(IsDefined(self.origin))
	{
		self.initial_state.origin = self.origin;
	}

	if(IsDefined(self.angles))
	{
		self.initial_state.angles = self.angles;
	}

	if(IsDefined(self.health))
	{
		self.initial_state.health = self.health;
	}

	self initialize_vehicle_damage_state_data();
}

//Function Number: 49
vehicle_fireweapon_t()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	for(;;)
	{
		self waittill("turret_fire",player);
		if(IsDefined(player) && isalive(player) && player isinvehicle())
		{
			self fireweapon();
		}
	}
}

//Function Number: 50
vehicle_should_explode_on_cleanup()
{
	return GetDvarInt(#"A0CE2AC2") != 0;
}

//Function Number: 51
vehicle_recycle()
{
	self wait_for_unnoticeable_cleanup_opportunity();
	self.recycling = 1;
	self suicide();
}

//Function Number: 52
wait_for_vehicle_overturn()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	worldup = AnglesToUp(VectorScale((0,1,0)));
	overturned = 0;
	while(!(overturned))
	{
		if(IsDefined(self.angles))
		{
			up = AnglesToUp(self.angles);
			dot = vectordot(up,worldup);
			if(dot <= 0)
			{
				overturned = 1;
			}
		}

		if(!(overturned))
		{
			wait(1);
		}
	}
}

//Function Number: 53
vehicle_overturn_eject_occupants()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	for(;;)
	{
		self waittill("veh_ejectoccupants");
		if(IsDefined(level.onejectoccupants))
		{
			[[ level.onejectoccupants ]]();
		}

		wait(0.25);
	}
}

//Function Number: 54
vehicle_eject_all_occupants()
{
	occupants = self getvehoccupants();
	if(IsDefined(occupants))
	{
		for(i = 0;i < occupants.size;i++)
		{
			if(IsDefined(occupants[i]))
			{
				occupants[i] unlink();
			}
		}
	}
}

//Function Number: 55
vehicle_overturn_suicide()
{
	self endon("transmute");
	self endon("death");
	self endon("delete");
	self wait_for_vehicle_overturn();
	seconds = randomfloatrange(5,7);
	wait(seconds);
	damageorigin = 25 + VectorScale((0,0,1));
	self finishvehicleradiusdamage(self,self,32000,32000,32000,0,"MOD_EXPLOSIVE","defaultweapon_mp",damageorigin,400,-1,(0,0,1),0);
}

//Function Number: 56
suicide()
{
	self kill_vehicle(self);
}

//Function Number: 57
kill_vehicle(attacker)
{
	damageorigin = self.origin + (0,0,1);
	self finishvehicleradiusdamage(attacker,attacker,32000,32000,10,0,"MOD_EXPLOSIVE","defaultweapon_mp",damageorigin,400,-1,(0,0,1),0);
}

//Function Number: 58
value_with_default(preferred_value,default_value)
{
	if(IsDefined(preferred_value))
	{
		return preferred_value;
	}

	return default_value;
}

//Function Number: 59
vehicle_transmute(attacker)
{
	deathorigin = self.origin;
	deathangles = self.angles;
	modelname = self vehgetmodel();
	vehicle_name = get_vehicle_name_key_for_damage_states(self);
	respawn_parameters = spawnstruct();
	respawn_parameters.origin = self.initial_state.origin;
	respawn_parameters.angles = self.initial_state.angles;
	respawn_parameters.health = self.initial_state.health;
	respawn_parameters.modelname = modelname;
	respawn_parameters.targetname = value_with_default(self.targetname,"");
	respawn_parameters.vehicletype = value_with_default(self.vehicletype,"");
	respawn_parameters.destructibledef = self.destructibledef;
	vehiclewasdestroyed = !IsDefined(self.recycling);
	if(vehiclewasdestroyed || vehicle_should_explode_on_cleanup())
	{
		_spawn_explosion(deathorigin);
		if(vehiclewasdestroyed && GetDvarInt(#"1A397FE8") != 0)
		{
			explosionradius = GetDvarInt(#"2CC23AB6");
			explosionmindamage = GetDvarInt(#"3E054351");
			explosionmaxdamage = GetDvarInt(#"DDBCFBD3");
			self kill_vehicle(attacker);
			self radiusdamage(deathorigin,explosionradius,explosionmaxdamage,explosionmindamage,attacker,"MOD_EXPLOSIVE",self.vehicletype + "_explosion_mp");
		}
	}

	self notify("transmute");
	respawn_vehicle_now = 1;
	if(vehiclewasdestroyed && GetDvarInt(#"16B521FF") != 0)
	{
		if(GetDvarInt(#"A770BB2C") != 0)
		{
			husk = self;
			self.is_husk = 1;
		}
		else
		{
			husk = _spawn_husk(deathorigin,deathangles,modelname);
		}

		husk _init_husk(vehicle_name,respawn_parameters);
		if(GetDvarInt(#"A85448C3") != 0)
		{
			respawn_vehicle_now = 0;
		}
	}

	if(!(IsDefined(self.is_husk)))
	{
		self remove_vehicle_from_world();
	}

	if(GetDvarInt(#"4AAF6102") != 0)
	{
		respawn_vehicle_now = 0;
	}

	if(respawn_vehicle_now)
	{
		respawn_vehicle(respawn_parameters);
	}
}

//Function Number: 60
respawn_vehicle(respawn_parameters)
{
	mintime = GetDvarInt(#"99A7881");
	maxtime = GetDvarInt(#"99A7783");
	seconds = randomfloatrange(mintime,maxtime);
	wait(seconds);
	wait_until_vehicle_position_wont_telefrag(respawn_parameters.origin);
	if(!(manage_vehicles()))
	{
/#
		iprintln("Vehicle can\'t respawn because MAX_VEHICLES has been reached and none of the vehicles could be cleaned up.");
#/
	}
	else
	{
		if(IsDefined(respawn_parameters.destructibledef))
		{
			vehicle = spawnvehicle(respawn_parameters.modelname,respawn_parameters.targetname,respawn_parameters.vehicletype,respawn_parameters.origin,respawn_parameters.angles,respawn_parameters.destructibledef);
		}
		else
		{
			vehicle = spawnvehicle(respawn_parameters.modelname,respawn_parameters.targetname,respawn_parameters.vehicletype,respawn_parameters.origin,respawn_parameters.angles);
		}

		vehicle.vehicletype = respawn_parameters.vehicletype;
		vehicle.destructibledef = respawn_parameters.destructibledef;
		vehicle.health = respawn_parameters.health;
		vehicle init_vehicle();
		vehicle vehicle_telefrag_griefers_at_position(respawn_parameters.origin);
	}
}

//Function Number: 61
remove_vehicle_from_world()
{
	self notify("removed");
	if(IsDefined(self.original_vehicle))
	{
		if(!(IsDefined(self.permanentlyremoved)))
		{
			self.permanentlyremoved = 1;
			self thread hide_vehicle();
		}

		return 0;
	}
	else
	{
		self _delete_entity();
		return 1;
	}
}

//Function Number: 62
_delete_entity()
{
/#
#/
	self delete();
}

//Function Number: 63
hide_vehicle()
{
	under_the_world = (self.origin[0],self.origin[1],self.origin[2] - 10000);
	self.origin = under_the_world;
	wait(0.1);
	self hide();
	self notify("hidden_permanently");
}

//Function Number: 64
wait_for_unnoticeable_cleanup_opportunity()
{
	maxpreventdistancefeet = GetDvarInt(#"EB58349F");
	maxpreventvisibilityfeet = GetDvarInt(#"F3A863DC");
	maxpreventdistanceinchessq = 144 * maxpreventdistancefeet * maxpreventdistancefeet;
	maxpreventvisibilityinchessq = 144 * maxpreventvisibilityfeet * maxpreventvisibilityfeet;
	maxsecondstowait = GetDvarFloat(#"33313A70");
	iterationwaitseconds = 1;
	for(secondswaited = 0;secondswaited < maxsecondstowait;secondswaited = secondswaited + iterationwaitseconds)
	{
		players_s = get_all_alive_players_s();
		oktocleanup = 1;
		for(j = 0;j < players_s.a.size && oktocleanup;j++)
		{
			player = players_s.a[j];
			distinchessq = distancesquared(self.origin,player.origin);
			if(distinchessq < maxpreventdistanceinchessq)
			{
				self cleanup_debug_print("(" + maxsecondstowait - secondswaited + "s) Player too close: " + distinchessq + "<" + maxpreventdistanceinchessq);
				oktocleanup = 0;
			}
			else if(distinchessq < maxpreventvisibilityinchessq)
			{
				vehiclevisibilityfromplayer = self sightconetrace(player.origin,player,AnglesToForward(player.angles));
				if(vehiclevisibilityfromplayer > 0)
				{
					self cleanup_debug_print("(" + maxsecondstowait - secondswaited + "s) Player can see");
					oktocleanup = 0;
				}
			}
		}

		if(oktocleanup)
		{
			return;
		}

		wait(iterationwaitseconds);
	}
}

//Function Number: 65
wait_until_vehicle_position_wont_telefrag(position)
{
	maxiterations = GetDvarInt(#"C775AA8A");
	iterationwaitseconds = GetDvarInt(#"B75883F5");
	for(i = 0;i < maxiterations;i++)
	{
		if(!(vehicle_position_will_telefrag(position)))
		{
			return;
		}

		wait(iterationwaitseconds);
	}
}

//Function Number: 66
vehicle_position_will_telefrag(position)
{
	players_s = get_all_alive_players_s();
	for(i = 0;i < players_s.a.size;i++)
	{
		if(players_s.a[i] player_vehicle_position_will_telefrag(position))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 67
vehicle_telefrag_griefers_at_position(position)
{
	attacker = self;
	inflictor = self;
	players_s = get_all_alive_players_s();
	for(i = 0;i < players_s.a.size;i++)
	{
		player = players_s.a[i];
		if(player player_vehicle_position_will_telefrag(position))
		{
			player dodamage(20000,player.origin + (0,0,1),attacker,inflictor,"none");
		}
	}
}

//Function Number: 68
player_vehicle_position_will_telefrag(position)
{
	distanceinches = 240;
	mindistinchessq = distanceinches * distanceinches;
	distinchessq = distancesquared(self.origin,position);
	return distinchessq < mindistinchessq;
}

//Function Number: 69
vehicle_recycle_spawner_t()
{
	self endon("delete");
	self waittill("death",attacker);
	if(IsDefined(self))
	{
		self vehicle_transmute(attacker);
	}
}

//Function Number: 70
vehicle_play_explosion_sound()
{
	self playsound("car_explo_large");
}

//Function Number: 71
vehicle_damage_t()
{
	self endon("delete");
	self endon("removed");
	for(;;)
	{
		self waittill("damage",damage,attacker);
		players = get_players();
		for(i = 0;i < players.size;i++)
		{
			if(!(isalive(players[i])))
			{
			}
			else
			{
				vehicle = players[i] getvehicleoccupied();
				if(IsDefined(vehicle) && self == vehicle && players[i] player_is_driver())
				{
					if(damage > 0)
					{
						earthquake(damage / 400,1,players[i].origin,512,players[i]);
					}

					if(damage > 100)
					{
/#
						println("Playing heavy rumble.");
#/
						players[i] playrumbleonentity("tank_damage_heavy_mp");
					}
					else if(damage > 10)
					{
/#
						println("Playing light rumble.");
#/
						players[i] playrumbleonentity("tank_damage_light_mp");
					}
				}
			}
		}

		update_damage_effects(self,attacker);
		if(self.health <= 0)
		{
			return;
		}
	}
}

//Function Number: 72
_spawn_husk(origin,angles,modelname)
{
	husk = spawn("script_model",origin);
	husk.angles = angles;
	husk setmodel(modelname);
	husk.health = 1;
	husk setcandamage(0);
	return husk;
}

//Function Number: 73
is_vehicle()
{
	return IsDefined(self.vehicletype);
}

//Function Number: 74
swap_to_husk_model()
{
	if(IsDefined(self.vehicletype))
	{
		husk_model = level.veh_husk_models[self.vehicletype];
		if(IsDefined(husk_model))
		{
			self setmodel(husk_model);
		}
	}
}

//Function Number: 75
_init_husk(vehicle_name,respawn_parameters)
{
	self swap_to_husk_model();
	effects = level.vehicles_husk_effects[vehicle_name];
	self play_vehicle_effects(effects);
	self.respawn_parameters = respawn_parameters;
	forcepointvariance = GetDvarInt(#"F0E3D76A");
	horzvelocityvariance = GetDvarInt(#"F7AEC6C3");
	vertvelocitymin = GetDvarInt(#"B8C044DC");
	vertvelocitymax = GetDvarInt(#"B8C043DE");
	forcepointx = randomfloatrange(0 - forcepointvariance,forcepointvariance);
	forcepointy = randomfloatrange(0 - forcepointvariance,forcepointvariance);
	forcepoint = (forcepointx,forcepointy,0);
	forcepoint = forcepoint + self.origin;
	initialvelocityx = randomfloatrange(0 - horzvelocityvariance,horzvelocityvariance);
	initialvelocityy = randomfloatrange(0 - horzvelocityvariance,horzvelocityvariance);
	initialvelocityz = randomfloatrange(vertvelocitymin,vertvelocitymax);
	initialvelocity = (initialvelocityx,initialvelocityy,initialvelocityz);
	if(self is_vehicle())
	{
		self launchvehicle(initialvelocity,forcepoint);
	}
	else
	{
		self physicslaunch(forcepoint,initialvelocity);
	}

	self thread husk_cleanup_t();
/#
	self thread cleanup_debug_print_t();
#/
}

//Function Number: 76
husk_cleanup_t()
{
	self endon("death");
	self endon("delete");
	self endon("hidden_permanently");
	respawn_parameters = self.respawn_parameters;
	self do_dead_cleanup_wait("Husk Cleanup Test");
	self wait_for_unnoticeable_cleanup_opportunity();
	self thread final_husk_cleanup_t(respawn_parameters);
}

//Function Number: 77
final_husk_cleanup_t(respawn_parameters)
{
	self husk_do_cleanup();
	if(GetDvarInt(#"A85448C3") != 0)
	{
		if(GetDvarInt(#"4AAF6102") == 0)
		{
			respawn_vehicle(respawn_parameters);
		}
	}
}

//Function Number: 78
husk_do_cleanup()
{
	self _spawn_explosion(self.origin);
	if(self is_vehicle())
	{
		return self remove_vehicle_from_world();
	}
	else
	{
		self _delete_entity();
		return 1;
	}
}

//Function Number: 79
_spawn_explosion(origin)
{
	if(GetDvarInt(#"34D27475") == 0)
	{
		return;
	}

	if(IsDefined(level.vehicle_explosion_effect))
	{
		forward = (0,0,1);
		rot = randomfloat(360);
		up = (cos(rot),sin(rot),0);
		playfx(level.vehicle_explosion_effect,origin,forward,up);
	}

	thread _play_sound_in_space("vehicle_explo",origin);
}

//Function Number: 80
_play_sound_in_space(soundeffectname,origin)
{
	org = spawn("script_origin",origin);
	org.origin = origin;
	org playsound(soundeffectname);
	wait(10);
	org delete();
}

//Function Number: 81
vehicle_get_occupant_team()
{
	occupants = self getvehoccupants();
	if(occupants.size != 0)
	{
		occupant = occupants[0];
		if(isplayer(occupant))
		{
			return occupant.team;
		}
	}

	return "free";
}

//Function Number: 82
vehicledeathwaiter()
{
	self notify("vehicleDeathWaiter");
	self endon("vehicleDeathWaiter");
	self endon("disconnect");
	while(1)
	{
		self waittill("vehicle_death",vehicle_died);
		if(vehicle_died)
		{
			self.diedonvehicle = 1;
			continue;
		}

		self.diedonturret = 1;
	}
}

//Function Number: 83
turretdeathwaiter()
{
}

//Function Number: 84
vehicle_kill_disconnect_paths_forever()
{
	self notify("kill_disconnect_paths_forever");
}

//Function Number: 85
vehicle_disconnect_paths()
{
	self endon("death");
	self endon("kill_disconnect_paths_forever");
	if(IsDefined(self.script_disconnectpaths) && !self.script_disconnectpaths)
	{
		self.dontdisconnectpaths = 1;
		return;
	}

	wait(randomfloat(1));
	while(IsDefined(self))
	{
		if(self getspeed() < 1)
		{
			if(!(IsDefined(self.dontdisconnectpaths)))
			{
				self disconnectpaths();
			}

			self notify("speed_zero_path_disconnect");
			while(self getspeed() < 1)
			{
				wait(0.05);
			}
		}

		self connectpaths();
		wait(1);
	}
}

//Function Number: 86
follow_path(node)
{
	self endon("death");
/#
	assert(IsDefined(node),"vehicle_path() called without a path");
#/
	self notify("newpath");
	if(IsDefined(node))
	{
		self.attachedpath = node;
	}

	pathstart = self.attachedpath;
	self.currentnode = self.attachedpath;
	if(!(IsDefined(pathstart)))
	{
		return;
	}

	self attachpath(pathstart);
	self startpath();
	self endon("newpath");
	nextpoint = pathstart;
	while(IsDefined(nextpoint))
	{
		self waittill("reached_node",nextpoint);
		self.currentnode = nextpoint;
		nextpoint notify("trigger",self);
		if(IsDefined(nextpoint.script_noteworthy))
		{
			self notify(nextpoint.script_noteworthy);
			self notify("noteworthy",nextpoint.script_noteworthy,nextpoint);
		}

		waittillframeend;
	}
}