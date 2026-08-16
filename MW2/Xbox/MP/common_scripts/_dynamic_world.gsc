/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_dynamic_world.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate", "targetname"), ::fan_blade_rotate, "slow");
	common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate_fast", "targetname"), ::fan_blade_rotate, "fast");
	trigger_classes = [];
	trigger_classes["trigger_multiple_dyn_metal_detector"] = ::metal_detector;
	trigger_classes["trigger_multiple_dyn_creaky_board"] = ::creaky_board;
	trigger_classes["trigger_multiple_dyn_photo_copier"] = ::photo_copier;
	trigger_classes["trigger_multiple_dyn_copier_no_light"] = ::photo_copier_no_light;
	trigger_classes["trigger_radius_motion_light"] = ::motion_light;
	trigger_classes["trigger_radius_dyn_motion_dlight"] = ::outdoor_motion_dlight;
	trigger_classes["trigger_multiple_dog_bark"] = ::dog_bark;
	trigger_classes["trigger_radius_bird_startle"] = ::bird_startle;
	trigger_classes["trigger_multiple_dyn_motion_light"] = ::motion_light;
	trigger_classes["trigger_multiple_dyn_door"] = ::trigger_door;
	player_init();
	foreach(classname, function in trigger_classes)
	{
		triggers = getentarray(classname, "classname");
		common_scripts\utility::array_thread(triggers, ::triggertouchthink);
		common_scripts\utility::array_thread(triggers, function);
	}

	common_scripts\utility::array_thread(getentarray("vending_machine", "targetname"), ::vending_machine);
	common_scripts\utility::array_thread(getentarray("toggle", "targetname"), ::use_toggle);
	level thread onplayerconnect();
	civilian_jet = getent("civilian_jet_origin", "targetname");
	if(isdefined(civilian_jet))
	{
		civilian_jet thread civilian_jet_flyby();
		return;
	}
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player thread movementtracker();
	}
}

player_init()
{
	if(common_scripts\utility::issp())
	{
		foreach(player in level.players)
		{
			player.touchtriggers = [];
			player thread movementtracker();
		}

		return;
	}
}

ai_init()
{
	self.touchtriggers = [];
	thread movementtracker();
}

civilian_jet_flyby()
{
	level endon("game_ended");
	jet_init();
	level waittill("prematch_over");
	for(;;)
	{
		thread jet_timer();
		self waittill("start_flyby");
		thread jet_flyby();
		self waittill("flyby_done");
		jet_reset();
	}
}

jet_init()
{
	self.jet_parts = getentarray(self.target, "targetname");
	self.jet_flyto = getent("civilian_jet_flyto", "targetname");
	self.engine_fxs = getentarray("engine_fx", "targetname");
	self.flash_fxs = getentarray("flash_fx", "targetname");
	self.jet_engine_fx = loadfx("fire/jet_afterburner");
	self.jet_flash_fx_red = loadfx("misc/aircraft_light_wingtip_red");
	self.jet_flash_fx_green = loadfx("misc/aircraft_light_wingtip_green");
	self.jet_flash_fx_blink = loadfx("misc/aircraft_light_red_blink");
	level.civilianjetflyby = undefined;
	negative_vec = common_scripts\utility::vector_multiply(vectornormalize(self.origin - self.jet_flyto.origin), 20000);
	self.jet_flyto.origin = self.jet_flyto.origin - negative_vec;
	self.origin = self.origin + negative_vec;
	foreach(part in self.jet_parts)
	{
		part.origin = part.origin + negative_vec;
		part.old_origin = part.origin;
		part hide();
	}

	foreach(engine_fx in self.engine_fxs)
	{
		engine_fx.origin = engine_fx.origin + negative_vec;
	}

	foreach(flash_fx in self.flash_fxs)
	{
		flash_fx.origin = flash_fx.origin + negative_vec;
	}

	jet_origin = self.origin;
	jet_flyto_pos = self.jet_flyto.origin;
	self.jet_fly_vec = jet_flyto_pos - jet_origin;
	jet_speed = 2000;
	jet_flight_dist = abs(distance(jet_origin, jet_flyto_pos));
	self.jet_flight_time = jet_flight_dist / jet_speed;
}

jet_reset()
{
	foreach(part in self.jet_parts)
	{
		part.origin = part.old_origin;
		part hide();
	}
}

jet_timer()
{
	level endon("game_ended");
	match_timelimit = gettimeinterval();
	timelimit = max(10, match_timelimit);
	timelimit = min(timelimit, 100);
	if(getdvar("jet_flyby_timer") != "")
	{
		level.civilianjetflyby_timer = 5 + getdvarint("jet_flyby_timer");
	}
	else
	{
		level.civilianjetflyby_timer = 0.25 + randomfloatrange(0.3, 0.7) * 60 * timelimit;
	}

	wait level.civilianjetflyby_timer;
	while(isdefined(level.airstrikeinprogress) || isdefined(level.ac130player) || isdefined(level.chopper) || isdefined(level.remotemissileinprogress))
	{
		wait 0.05;
	}

	self notify("start_flyby");
	level.civilianjetflyby = 1;
	self waittill("flyby_done");
	level.civilianjetflyby = undefined;
}

gettimeinterval()
{
	if(common_scripts\utility::issp())
	{
		return 10;
	}

	if(isdefined(game["status"]) && game["status"] == "overtime")
	{
		return 1;
	}

	return getwatcheddvar("timelimit");
}

getwatcheddvar(dvarstring)
{
	dvarstring = "scr_" + level.gametype + "_" + dvarstring;
	return level.watchdvars[dvarstring].value;
}

jet_flyby()
{
	foreach(part in self.jet_parts)
	{
		part show();
	}

	engine_fx_array = [];
	flash_fx_array = [];
	foreach(engine_fx in self.engine_fxs)
	{
		engine_fx_ent = spawn("script_model", engine_fx.origin);
		engine_fx_ent setmodel("tag_origin");
		engine_fx_ent.angles = engine_fx.angles;
		engine_fx_array[engine_fx_array.size] = engine_fx_ent;
	}

	foreach(flash_fx in self.flash_fxs)
	{
		flash_fx_ent = spawn("script_model", flash_fx.origin);
		flash_fx_ent setmodel("tag_origin");
		flash_fx_ent.color = flash_fx.script_noteworthy;
		flash_fx_ent.angles = flash_fx.angles;
		flash_fx_array[flash_fx_array.size] = flash_fx_ent;
	}

	thread jet_planesound(self.jet_parts[0], level.mapcenter);
	wait 0.05;
	foreach(engine_fx_ent in engine_fx_array)
	{
		playfxontag(self.jet_engine_fx, engine_fx_ent, "tag_origin");
	}

	foreach(flash_fx_ent in flash_fx_array)
	{
		if(isdefined(flash_fx_ent.color) && flash_fx_ent.color == "blink")
		{
			playfxontag(self.jet_flash_fx_blink, flash_fx_ent, "tag_origin");
			continue;
		}

		if(isdefined(flash_fx_ent.color) && flash_fx_ent.color == "red")
		{
			playfxontag(self.jet_flash_fx_red, flash_fx_ent, "tag_origin");
			continue;
		}

		playfxontag(self.jet_flash_fx_green, flash_fx_ent, "tag_origin");
	}

	foreach(part in self.jet_parts)
	{
		part moveto(part.origin + self.jet_fly_vec, self.jet_flight_time);
	}

	foreach(engine_fx_ent in engine_fx_array)
	{
		engine_fx_ent moveto(engine_fx_ent.origin + self.jet_fly_vec, self.jet_flight_time);
	}

	foreach(flash_fx_ent in flash_fx_array)
	{
		flash_fx_ent moveto(flash_fx_ent.origin + self.jet_fly_vec, self.jet_flight_time);
	}

	wait self.jet_flight_time + 1;
	foreach(engine_fx_ent in engine_fx_array)
	{
		engine_fx_ent delete();
	}

	foreach(flash_fx_ent in flash_fx_array)
	{
		flash_fx_ent delete();
	}

	self notify("flyby_done");
}

jet_planesound(plane, bombsite)
{
	plane thread playsound_loop_on_ent("veh_mig29_dist_loop");
	while(!targetisclose(plane, bombsite))
	{
		wait 0.05;
	}

	plane thread playsound_loop_on_ent("veh_mig29_close_loop");
	while(targetisinfront(plane, bombsite))
	{
		wait 0.05;
	}

	wait 0.5;
	plane thread playsound_float("veh_mig29_sonic_boom");
	while(targetisclose(plane, bombsite))
	{
		wait 0.05;
	}

	plane notify("stop soundveh_mig29_close_loop");
	self waittill("flyby_done");
	plane notify("stop soundveh_mig29_dist_loop");
}

playsound_float(alias, origin, master)
{
	org = spawn("script_origin", (0,0,1));
	org hide();
	if(!isdefined(origin))
	{
		origin = self.origin;
	}

	org.origin = origin;
	if(isdefined(master) && master)
	{
		org playsoundasmaster(alias);
	}
	else
	{
		org playsound(alias);
	}

	wait 10;
	org delete();
}

playsound_loop_on_ent(alias, offset)
{
	org = spawn("script_origin", (0,0,0));
	org hide();
	org endon("death");
	thread common_scripts\utility::delete_on_death(org);
	if(isdefined(offset))
	{
		org.origin = self.origin + offset;
		org.angles = self.angles;
		org linkto(self);
	}
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto(self);
	}

	org playloopsound(alias);
	self waittill("stop sound" + alias);
	org stoploopsound(alias);
	org delete();
}

targetisinfront(other, target)
{
	forwardvec = anglestoforward(common_scripts\utility::flat_angle(other.angles));
	normalvec = vectornormalize(common_scripts\utility::flat_origin(target) - other.origin);
	dot = vectordot(forwardvec, normalvec);
	if(dot > 0)
	{
		return 1;
	}

	return 0;
}

targetisclose(other, target)
{
	infront = targetisinfront(other, target);
	if(infront)
	{
		dir = 1;
	}
	else
	{
		dir = -1;
	}

	a = common_scripts\utility::flat_origin(other.origin);
	b = a + common_scripts\utility::vector_multiply(anglestoforward(common_scripts\utility::flat_angle(other.angles)), dir * 100000);
	point = pointonsegmentnearesttopoint(a, b, target);
	dist = distance(a, point);
	if(dist < 3000)
	{
		return 1;
	}

	return 0;
}

vending_machine()
{
	level endon("game_ended");
	self endon("death");
	self setcursorhint("HINT_ACTIVATE");
	self.vm_normal = getent(self.target, "targetname");
	vm_soda_start = getent(self.vm_normal.target, "targetname");
	vm_soda_stop = getent(vm_soda_start.target, "targetname");
	self.vm_launch_from = getent(vm_soda_stop.target, "targetname");
	self.vm_launch_to = getent(self.vm_launch_from.target, "targetname");
	if(isdefined(self.vm_launch_to.target))
	{
		self.vm_fx_loc = getent(self.vm_launch_to.target, "targetname");
	}

	self.vm_normal setcandamage(1);
	self.vm_normal_model = self.vm_normal.model;
	self.vm_damaged_model = self.vm_normal.script_noteworthy;
	self.vm_soda_model = vm_soda_start.model;
	self.vm_soda_start_pos = vm_soda_start.origin;
	self.vm_soda_start_angle = vm_soda_start.angles;
	self.vm_soda_stop_pos = vm_soda_stop.origin;
	self.vm_soda_stop_angle = vm_soda_stop.angles;
	precachemodel(self.vm_damaged_model);
	vm_soda_start delete();
	vm_soda_stop delete();
	self.soda_array = [];
	self.soda_count = 12;
	self.soda_slot = undefined;
	self.hp = 400;
	thread vending_machine_damage_monitor(self.vm_normal);
	self playloopsound("vending_machine_hum");
	for(;;)
	{
		self waittill("trigger", player);
		self playsound("vending_machine_button_press");
		if(!self.soda_count)
		{
			continue;
		}

		if(isdefined(self.soda_slot))
		{
			soda_can_eject();
		}

		soda_can_drop(spawn_soda());
		wait 0.05;
	}
}

vending_machine_damage_monitor(vending_machine)
{
	level endon("game_ended");
	exp_dmg = "mod_grenade mod_projectile mod_explosive mod_grenade_splash mod_projectile_splash splash";
	sparks_fx = loadfx("explosions/tv_explosion");
	for(;;)
	{
		vending_machine waittill("damage", damage, other, direction_vec, p, type);
		if(isdefined(type))
		{
			if(issubstr(exp_dmg, tolower(type)))
			{
				damage = damage * 3;
			}

			self.hp = self.hp - damage;
			if(self.hp > 0)
			{
				continue;
			}

			self notify("death");
			self.origin = self.origin + (0,0,10000);
			if(!isdefined(self.vm_fx_loc))
			{
				playfx_loc = self.vm_normal.origin + (37,-31,52);
			}
			else
			{
				playfx_loc = self.vm_fx_loc.origin;
			}

			playfx(sparks_fx, playfx_loc);
			self.vm_normal setmodel(self.vm_damaged_model);
			while(self.soda_count > 0)
			{
				if(isdefined(self.soda_slot))
				{
					soda_can_eject();
				}

				soda_can_drop(spawn_soda());
				wait 0.05;
			}

			self stoploopsound("vending_machine_hum");
			return;
		}
	}
}

spawn_soda()
{
	soda = spawn("script_model", self.vm_soda_start_pos);
	soda setmodel(self.vm_soda_model);
	soda.origin = self.vm_soda_start_pos;
	soda.angles = self.vm_soda_start_angle;
	return soda;
}

soda_can_drop(soda)
{
	soda moveto(self.vm_soda_stop_pos, 0.1);
	soda playsound("vending_machine_soda_drop");
	wait 0.1;
	self.soda_slot = soda;
	self.soda_count--;
}

soda_can_eject()
{
	self endon("death");
	if(isdefined(self.soda_slot.ejected) && self.soda_slot.ejected == 1)
	{
		return;
	}

	force_max = 1150;
	force_min = force_max * 0.75 * 1.15;
	launch_vec = vectornormalize(self.vm_launch_to.origin - self.vm_launch_from.origin);
	force_vec = common_scripts\utility::vector_multiply(launch_vec, randomfloatrange(force_min, force_max));
	launch_force_vec = (force_vec[0] * randomfloatrange(1, 1.15),force_vec[1] * randomfloatrange(1, 1.15),force_vec[2] * randomfloatrange(1, 1.15));
	self.soda_slot physicslaunchclient(self.vm_launch_from.origin, launch_force_vec);
	self.soda_slot.ejected = 1;
}

freefall()
{
	level endon("game_ended");
	freefall_weapon = "briefcase_bomb_mp";
	precacheitem(freefall_weapon);
	for(;;)
	{
		self waittill("trigger_enter", player);
		if(!player hasweapon(freefall_weapon))
		{
			player playsound("freefall_death");
			player giveweapon(freefall_weapon);
			player setweaponammostock(freefall_weapon, 0);
			player setweaponammoclip(freefall_weapon, 0);
			player switchtoweapon(freefall_weapon);
		}
	}
}

metal_detector()
{
	level endon("game_ended");
	damage_trig = getent(self.target, "targetname");
	damage_trig enablegrenadetouchdamage();
	bound_org_1 = getent(damage_trig.target, "targetname");
	bound_org_2 = getent(bound_org_1.target, "targetname");
	detector_1 = getent(bound_org_2.target, "targetname");
	detector_2 = getent(detector_1.target, "targetname");
	bounds = [];
	bound_x_min = min(bound_org_1.origin[0], bound_org_2.origin[0]);
	bounds[0] = bound_x_min;
	bound_x_max = max(bound_org_1.origin[0], bound_org_2.origin[0]);
	bounds[1] = bound_x_max;
	bound_y_min = min(bound_org_1.origin[1], bound_org_2.origin[1]);
	bounds[2] = bound_y_min;
	bound_y_max = max(bound_org_1.origin[1], bound_org_2.origin[1]);
	bounds[3] = bound_y_max;
	bound_z_min = min(bound_org_1.origin[2], bound_org_2.origin[2]);
	bounds[4] = bound_z_min;
	bound_z_max = max(bound_org_1.origin[2], bound_org_2.origin[2]);
	bounds[5] = bound_z_max;
	bound_org_1 delete();
	bound_org_2 delete();
	if(!common_scripts\utility::issp())
	{
		self.alarm_interval = 7;
	}
	else
	{
		self.alarm_interval = 2;
	}

	self.alarm_playing = 0;
	self.alarm_annoyance = 0;
	self.tolerance = 0;
	thread metal_detector_dmg_monitor(damage_trig);
	thread metal_detector_touch_monitor();
	thread metal_detector_weapons(bounds, "weapon_claymore", "weapon_c4");
	light_pos1 = (detector_1.origin[0],detector_1.origin[1],bound_z_max);
	light_pos2 = (detector_2.origin[0],detector_2.origin[1],bound_z_max);
	md_light = loadfx("props/metal_detector_light");
	for(;;)
	{
		common_scripts\utility::waittill_any("dmg_triggered", "touch_triggered", "weapon_triggered");
		thread playsound_and_light("alarm_metal_detector", md_light, light_pos1, light_pos2);
	}
}

playsound_and_light(sound, light, light_pos1, light_pos2)
{
	level endon("game_ended");
	if(!self.alarm_playing)
	{
		self.alarm_playing = 1;
		thread annoyance_tracker();
		if(!self.alarm_annoyance)
		{
			self playsound(sound);
		}

		playfx(light, light_pos1);
		playfx(light, light_pos2);
		wait self.alarm_interval;
		self.alarm_playing = 0;
		return;
	}
}

annoyance_tracker()
{
	level endon("game_ended");
	if(!self.tolerance)
	{
		return;
	}

	interval = self.alarm_interval + 0.15;
	if(self.tolerance)
	{
		self.tolerance--;
	}
	else
	{
		self.alarm_annoyance = 1;
	}

	current_time = gettime();
	alarm_timeout = 7;
	if(common_scripts\utility::issp())
	{
		alarm_timeout = 2;
	}

	waittill_any_or_timeout("dmg_triggered", "touch_triggered", "weapon_triggered", alarm_timeout + 2);
	time_delta = gettime() - current_time;
	if(time_delta > alarm_timeout * 1000 + 1150)
	{
		self.alarm_annoyance = 0;
		self.tolerance = 0;
		return;
	}
}

waittill_any_or_timeout(msg1, msg2, msg3, timer)
{
	level endon("game_ended");
	self endon(msg1);
	self endon(msg2);
	self endon(msg3);
	wait timer;
}

metal_detector_weapons(bounds, weapon_1, weapon_2)
{
	level endon("game_ended");
	for(;;)
	{
		waittill_weapon_placed();
		all_grenades = getentarray("grenade", "classname");
		foreach(grenade in all_grenades)
		{
			if(isdefined(grenade.model) && grenade.model == weapon_1 || grenade.model == weapon_2)
			{
				if(isinbound(grenade, bounds))
				{
					thread weapon_notify_loop(grenade, bounds);
				}
			}
		}
	}
}

waittill_weapon_placed()
{
	level endon("game_ended");
	self endon("dmg_triggered");
	self waittill("touch_triggered");
}

weapon_notify_loop(grenade, bounds)
{
	grenade endon("death");
	while(isinbound(grenade, bounds))
	{
		self notify("weapon_triggered");
		wait self.alarm_interval;
	}
}

isinbound(ent, bounds)
{
	bound_x_min = bounds[0];
	bound_x_max = bounds[1];
	bound_y_min = bounds[2];
	bound_y_max = bounds[3];
	bound_z_min = bounds[4];
	bound_z_max = bounds[5];
	ent_x = ent.origin[0];
	ent_y = ent.origin[1];
	ent_z = ent.origin[2];
	if(isinbound_single(ent_x, bound_x_min, bound_x_max))
	{
		if(isinbound_single(ent_y, bound_y_min, bound_y_max))
		{
			if(isinbound_single(ent_z, bound_z_min, bound_z_max))
			{
				return 1;
			}
		}
	}

	return 0;
}

isinbound_single(var, v_min, v_max)
{
	if(var > v_min && var < v_max)
	{
		return 1;
	}

	return 0;
}

metal_detector_dmg_monitor(damage_trig)
{
	level endon("game_ended");
	for(;;)
	{
		damage_trig waittill("damage", damage, other, direction_vec, p, type);
		if(isdefined(type) && alarm_validate_damage(type))
		{
			self notify("dmg_triggered");
		}
	}
}

metal_detector_touch_monitor()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger_enter");
		while(anythingtouchingtrigger(self))
		{
			self notify("touch_triggered");
			wait self.alarm_interval;
		}
	}
}

alarm_validate_damage(damagetype)
{
	allowed_dmg = "mod_melee melee mod_grenade mod_projectile mod_explosive mod_impact";
	allowed_dmg_array = strtok(allowed_dmg, " ");
	foreach(dmg in allowed_dmg_array)
	{
		if(tolower(dmg) == tolower(damagetype))
		{
			return 1;
		}
	}

	return 0;
}

creaky_board()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger_enter", player);
		player thread do_creak(self);
	}
}

do_creak(trigger)
{
	self endon("disconnect");
	self endon("death");
	self playsound("step_walk_plr_woodcreak_on");
	for(;;)
	{
		self waittill("trigger_leave", lefttrigger);
		if(trigger != lefttrigger)
		{
			continue;
		}

		self playsound("step_walk_plr_woodcreak_off");
		return;
	}
}

motion_light()
{
	level endon("game_ended");
	self.movetracker = 1;
	self.lightson = 0;
	lights = getentarray(self.target, "targetname");
	precachemodel("com_two_light_fixture_off");
	precachemodel("com_two_light_fixture_on");
	foreach(light in lights)
	{
		light.lightrigs = [];
		infonull = getent(light.target, "targetname");
		if(!isdefined(infonull.target))
		{
			continue;
		}

		light.lightrigs = getentarray(infonull.target, "targetname");
	}

	for(;;)
	{
		self waittill("trigger_enter");
		while(anythingtouchingtrigger(self))
		{
			objectmoved = 0;
			foreach(object in self.touchlist)
			{
				if(isdefined(object.distmoved) && object.distmoved > 5)
				{
					objectmoved = 1;
				}
			}

			if(objectmoved)
			{
				if(!self.lightson)
				{
					self.lightson = 1;
					lights[0] playsound("switch_auto_lights_on");
					foreach(light in lights)
					{
						light setlightintensity(1);
						if(isdefined(light.lightrigs))
						{
							foreach(rig in light.lightrigs)
							{
								rig setmodel("com_two_light_fixture_on");
							}
						}
					}
				}

				thread motion_light_timeout(lights, 10);
			}

			wait 0.05;
		}
	}
}

motion_light_timeout(lights, timeout)
{
	self notify("motion_light_timeout");
	self endon("motion_light_timeout");
	wait timeout;
	foreach(light in lights)
	{
		light setlightintensity(0);
		if(isdefined(light.lightrigs))
		{
			foreach(rig in light.lightrigs)
			{
				rig setmodel("com_two_light_fixture_off");
			}
		}
	}

	lights[0] playsound("switch_auto_lights_off");
	self.lightson = 0;
}

outdoor_motion_dlight()
{
	if(!isdefined(level.outdoor_motion_light))
	{
		level.outdoor_motion_light = loadfx("misc/outdoor_motion_light");
	}

	level endon("game_ended");
	self.movetracker = 1;
	self.lightson = 0;
	lightrig = getent(self.target, "targetname");
	lights = getentarray(lightrig.target, "targetname");
	precachemodel("com_two_light_fixture_off");
	precachemodel("com_two_light_fixture_on");
	for(;;)
	{
		self waittill("trigger_enter");
		while(anythingtouchingtrigger(self))
		{
			objectmoved = 0;
			foreach(object in self.touchlist)
			{
				if(isdefined(object.distmoved) && object.distmoved > 5)
				{
					objectmoved = 1;
				}
			}

			if(objectmoved)
			{
				if(!self.lightson)
				{
					self.lightson = 1;
					lightrig playsound("switch_auto_lights_on");
					lightrig setmodel("com_two_light_fixture_on");
					foreach(light in lights)
					{
						light.lightent = spawn("script_model", light.origin);
						light.lightent setmodel("tag_origin");
						playfxontag(level.outdoor_motion_light, light.lightent, "tag_origin");
					}
				}

				thread outdoor_motion_dlight_timeout(lightrig, lights, 10);
			}

			wait 0.05;
		}
	}
}

outdoor_motion_dlight_timeout(lightrig, lights, timeout)
{
	self notify("motion_light_timeout");
	self endon("motion_light_timeout");
	wait timeout;
	foreach(light in lights)
	{
		light.lightent delete();
	}

	lightrig playsound("switch_auto_lights_off");
	lightrig setmodel("com_two_light_fixture_off");
	self.lightson = 0;
}

dog_bark()
{
	level endon("game_ended");
	self.movetracker = 1;
	dogorigin = getent(self.target, "targetname");
	for(;;)
	{
		self waittill("trigger_enter", player);
		while(anythingtouchingtrigger(self))
		{
			maxdistmoved = 0;
			foreach(object in self.touchlist)
			{
				if(isdefined(object.distmoved) && object.distmoved > maxdistmoved)
				{
					maxdistmoved = object.distmoved;
				}
			}

			if(maxdistmoved > 6)
			{
				dogorigin playsound("dyn_anml_dog_bark");
				wait randomfloatrange(16 / maxdistmoved, 16 / maxdistmoved + randomfloat(1));
				continue;
			}

			wait 0.05;
		}
	}
}

trigger_door()
{
	doorent = getent(self.target, "targetname");
	self.doorent = doorent;
	self.doorangle = getvectorrightangle(vectornormalize(self getorigin() - doorent getorigin()));
	doorent.baseyaw = doorent.angles[1];
	opentime = 1;
	for(;;)
	{
		self waittill("trigger_enter", player);
		doorent thread dooropen(opentime, getdoorside(player));
		if(anythingtouchingtrigger(self))
		{
			self waittill("trigger_empty");
		}

		wait 3;
		if(anythingtouchingtrigger(self))
		{
			self waittill("trigger_empty");
		}

		doorent thread doorclose(opentime);
	}
}

dooropen(opentime, doorside)
{
	if(doorside)
	{
		self rotateto((0,self.baseyaw + 90,1), opentime, 0.1, 0.75);
	}
	else
	{
		self rotateto((0,self.baseyaw - 90,1), opentime, 0.1, 0.75);
	}

	self playsound("door_generic_house_open");
	wait opentime + 0.05;
}

doorclose(opentime)
{
	self rotateto((0,self.baseyaw,1), opentime);
	self playsound("door_generic_house_close");
	wait opentime + 0.05;
}

getdoorside(player)
{
	return vectordot(self.doorangle, vectornormalize(player.origin - self.doorent getorigin())) > 0;
}

getvectorrightangle(vdir)
{
	return (vdir[1],0 - vdir[0],vdir[2]);
}

use_toggle()
{
	if(self.classname != "trigger_use_touch")
	{
		return;
	}

	lights = getentarray(self.target, "targetname");
	self.lightson = 1;
	foreach(light in lights)
	{
		light setlightintensity(1.5 * self.lightson);
	}

	for(;;)
	{
		self waittill("trigger");
		self.lightson = !self.lightson;
		if(self.lightson)
		{
			foreach(light in lights)
			{
				light setlightintensity(1.5);
			}

			self playsound("switch_auto_lights_on");
			continue;
		}

		foreach(light in lights)
		{
			light setlightintensity(0);
		}

		self playsound("switch_auto_lights_off");
	}
}

bird_startle()
{
}

photo_copier_init(trigger)
{
	self.copier = get_photo_copier(trigger);
	copy_bar = getent(self.copier.target, "targetname");
	light = getent(copy_bar.target, "targetname");
	light.intensity = light getlightintensity();
	light setlightintensity(0);
	trigger.copy_bar = copy_bar;
	trigger.start_pos = copy_bar.origin;
	trigger.light = light;
	angles = self.copier.angles + (0,90,0);
	forward = anglestoforward(angles);
	trigger.end_pos = trigger.start_pos + common_scripts\utility::vector_multiply(forward, 30);
}

get_photo_copier(trigger)
{
	if(!isdefined(trigger.target))
	{
		toys = getentarray("destructible_toy", "targetname");
		copier = toys[0];
		foreach(toy in toys)
		{
			if(isdefined(toy.destructible_type) && toy.destructible_type == "toy_copier")
			{
				if(distance(trigger.origin, copier.origin) > distance(trigger.origin, toy.origin))
				{
					copier = toy;
				}
			}
		}
	}
	else
	{
		copier = getent(trigger.target, "targetname");
		copier setcandamage(1);
	}

	return copier;
}

waittill_copier_copies()
{
	self.copier endon("FX_State_Change0");
	self.copier endon("death");
	self waittill("trigger_enter");
}

photo_copier()
{
	level endon("game_ended");
	photo_copier_init(self);
	self.copier endon("FX_State_Change0");
	thread photo_copier_stop();
	for(;;)
	{
		waittill_copier_copies();
		self playsound("mach_copier_run");
		if(isdefined(self.copy_bar))
		{
			reset_copier(self);
			thread photo_copier_copy_bar_goes();
			thread photo_copier_light_on();
		}

		wait 3;
	}
}

photo_copier_no_light()
{
	level endon("game_ended");
	self.copier = get_photo_copier(self);
	self.copier endon("FX_State_Change0");
	for(;;)
	{
		waittill_copier_copies();
		self playsound("mach_copier_run");
		wait 3;
	}
}

reset_copier(trigger)
{
	trigger.copy_bar moveto(trigger.start_pos, 0.2);
	trigger.light setlightintensity(0);
}

photo_copier_copy_bar_goes()
{
	self.copier notify("bar_goes");
	self.copier endon("bar_goes");
	self.copier endon("FX_State_Change0");
	self.copier endon("death");
	copy_bar = self.copy_bar;
	wait 2;
	copy_bar moveto(self.end_pos, 1.6);
	wait 1.8;
	copy_bar moveto(self.start_pos, 1.6);
	wait 1.6;
	light = self.light;
	timer = 0.2;
	steps = timer / 0.05;
	for(i = 0;i < steps;i++)
	{
		intensity = i * 0.05;
		intensity = intensity / timer;
		intensity = 1 - intensity * light.intensity;
		if(intensity > 0)
		{
			light setlightintensity(intensity);
		}

		wait 0.05;
	}
}

photo_copier_light_on()
{
	self.copier notify("light_on");
	self.copier endon("light_on");
	self.copier endon("FX_State_Change0");
	self.copier endon("death");
	light = self.light;
	timer = 0.2;
	steps = timer / 0.05;
	for(i = 0;i < steps;i++)
	{
		intensity = i * 0.05;
		intensity = intensity / timer;
		light setlightintensity(intensity * light.intensity);
		wait 0.05;
	}

	photo_light_flicker(light);
}

photo_copier_stop()
{
	self.copier waittill("FX_State_Change0");
	self.copier endon("death");
	reset_copier(self);
}

photo_light_flicker(light)
{
	light setlightintensity(1);
	wait 0.05;
	light setlightintensity(0);
	wait 0.1;
	light setlightintensity(1);
	wait 0.05;
	light setlightintensity(0);
	wait 0.1;
	light setlightintensity(1);
}

fan_blade_rotate(type)
{
	speed = 0;
	time = 20000;
	speed_multiplier = 1;
	if(isdefined(self.speed))
	{
		speed_multiplier = self.speed;
	}

	if(type == "slow")
	{
		speed = randomfloatrange(100 * speed_multiplier, 360 * speed_multiplier);
	}
	else if(type == "fast")
	{
		speed = randomfloatrange(720 * speed_multiplier, 1000 * speed_multiplier);
	}
	else
	{
	}

	wait randomfloatrange(0, 1);
	fan_angles = self.angles;
	fan_vec = common_scripts\utility::vector_multiply(anglestoright(self.angles), 100);
	fan_vec = vectornormalize(fan_vec);
	for(;;)
	{
		dot_x = abs(vectordot(fan_vec, (1,0,0)));
		dot_y = abs(vectordot(fan_vec, (0,1,0)));
		dot_z = abs(vectordot(fan_vec, (0,0,1)));
		if(dot_x > 0.9)
		{
			self rotatevelocity((speed,0,0), time);
		}
		else if(dot_y > 0.9)
		{
			self rotatevelocity((speed,0,0), time);
		}
		else if(dot_z > 0.9)
		{
			self rotatevelocity((0,speed,0), time);
		}
		else
		{
			self rotatevelocity((0,speed,0), time);
		}

		wait time;
	}
}

triggertouchthink(enterfunc, exitfunc)
{
	level endon("game_ended");
	self.entnum = self getentitynumber();
	for(;;)
	{
		self waittill("trigger", player);
		if(!isplayer(player) && !isdefined(player.finished_spawning))
		{
			continue;
		}

		if(!isalive(player))
		{
			continue;
		}

		if(!isdefined(player.touchtriggers[self.entnum]))
		{
			player thread playertouchtriggerthink(self, enterfunc, exitfunc);
		}
	}
}

playertouchtriggerthink(trigger, enterfunc, exitfunc)
{
	if(!isplayer(self))
	{
		self endon("death");
	}

	if(!common_scripts\utility::issp())
	{
		touchname = self.guid;
	}
	else
	{
		touchname = "player" + gettime();
	}

	trigger.touchlist[touchname] = self;
	if(isdefined(trigger.movetracker))
	{
		self.movetrackers++;
	}

	trigger notify("trigger_enter", self);
	self notify("trigger_enter", trigger);
	if(isdefined(enterfunc))
	{
		self thread [[ enterfunc ]](trigger);
	}

	self.touchtriggers[trigger.entnum] = trigger;
	while(isalive(self) && self istouching(trigger) && common_scripts\utility::issp() || !level.gameended)
	{
		wait 0.05;
	}

	if(isdefined(self))
	{
		self.touchtriggers[trigger.entnum] = undefined;
		if(isdefined(trigger.movetracker))
		{
			self.movetrackers--;
		}

		self notify("trigger_leave", trigger);
		if(isdefined(exitfunc))
		{
			self thread [[ exitfunc ]](trigger);
		}
	}

	if(!common_scripts\utility::issp() && level.gameended)
	{
		return;
	}

	trigger.touchlist[touchname] = undefined;
	trigger notify("trigger_leave", self);
	if(!anythingtouchingtrigger(trigger))
	{
		trigger notify("trigger_empty");
		return;
	}
}

movementtracker()
{
	self endon("disconnect");
	if(!isplayer(self))
	{
		self endon("death");
	}

	self.movetrackers = 0;
	self.distmoved = 0;
	for(;;)
	{
		self waittill("trigger_enter");
		lastorigin = self.origin;
		while(self.movetrackers)
		{
			self.distmoved = distance(lastorigin, self.origin);
			lastorigin = self.origin;
			wait 0.05;
		}

		self.distmoved = 0;
	}
}

anythingtouchingtrigger(trigger)
{
	return trigger.touchlist.size;
}

playertouchingtrigger(player, trigger)
{
	return isdefined(player.touchtriggers[trigger.entnum]);
}