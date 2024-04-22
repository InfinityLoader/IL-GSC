/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: fusion_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 736 ms
 * Timestamp: 4/22/2024 2:30:14 AM
*******************************************************************/

//Function Number: 1
delete_spawners(param_00)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00];
	}

	foreach(var_02 in param_00)
	{
		foreach(var_04 in getentarray(var_02,"script_noteworthy"))
		{
			if(isspawner(var_04))
			{
				var_04 delete();
			}
		}
	}
}

//Function Number: 2
spawn_metrics_init_for_noteworthy(param_00)
{
	if(!isdefined(level.spawn_metrics_spawn_count))
	{
		level.spawn_metrics_spawn_count = [];
	}

	if(!isdefined(level.spawn_metrics_death_count))
	{
		level.spawn_metrics_death_count = [];
	}

	maps\_utility::array_spawn_function_noteworthy(param_00,::spawn_metrics_spawn_func);
	foreach(var_02 in getentarray(param_00,"script_noteworthy"))
	{
		if(!isspawner(var_02) && isalive(var_02))
		{
			var_02 spawn_metrics_spawn_func();
		}
	}
}

//Function Number: 3
spawn_metrics_spawn_func()
{
	if(isdefined(self.script_noteworthy))
	{
		if(isdefined(level.spawn_metrics_spawn_count[self.script_noteworthy]))
		{
			level.spawn_metrics_spawn_count[self.script_noteworthy] = level.spawn_metrics_spawn_count[self.script_noteworthy] + 1;
		}
		else
		{
			level.spawn_metrics_spawn_count[self.script_noteworthy] = 1;
		}

		thread spawn_metrics_death_watcher();
	}
}

//Function Number: 4
spawn_metrics_death_watcher()
{
	var_00 = self.script_noteworthy;
	self waittill("death");
	if(isdefined(level.spawn_metrics_death_count[var_00]))
	{
		level.spawn_metrics_death_count[var_00] = level.spawn_metrics_death_count[var_00] + 1;
		return;
	}

	level.spawn_metrics_death_count[var_00] = 1;
}

//Function Number: 5
spawn_metrics_number_spawned(param_00)
{
	if(isarray(param_00))
	{
		var_01 = 0;
		foreach(var_03 in param_00)
		{
			var_01 = var_01 + spawn_metrics_number_spawned(var_03);
		}

		return var_01;
	}

	if(isdefined(level.spawn_metrics_spawn_count[var_04]))
	{
		return level.spawn_metrics_spawn_count[var_04];
	}

	return 0;
}

//Function Number: 6
spawn_metrics_number_died(param_00)
{
	if(isarray(param_00))
	{
		var_01 = 0;
		foreach(var_03 in param_00)
		{
			var_01 = var_01 + spawn_metrics_number_died(var_03);
		}

		return var_01;
	}

	if(isdefined(level.spawn_metrics_death_count[var_04]))
	{
		return level.spawn_metrics_death_count[var_04];
	}

	return 0;
}

//Function Number: 7
spawn_metrics_number_alive(param_00)
{
	return spawn_metrics_number_spawned(param_00) - spawn_metrics_number_died(param_00);
}

//Function Number: 8
spawn_metrics_waittill_count_reaches(param_00,param_01,param_02)
{
	if(!isarray(param_01))
	{
		param_01 = [param_01];
	}

	waittillframeend;
	for(;;)
	{
		var_03 = 0;
		foreach(var_05 in param_01)
		{
			var_03 = var_03 + spawn_metrics_number_alive(var_05);
		}

		if(var_03 <= param_00)
		{
			break;
		}

		wait(1);
	}
}

//Function Number: 9
spawn_metrics_waittill_deaths_reach(param_00,param_01,param_02)
{
	if(!isarray(param_01))
	{
		param_01 = [param_01];
	}

	for(;;)
	{
		var_03 = 0;
		foreach(var_05 in param_01)
		{
			var_03 = var_03 + spawn_metrics_number_died(var_05);
		}

		if(var_03 >= param_00)
		{
			break;
		}

		wait(1);
	}
}

//Function Number: 10
goto_node(param_00,param_01,param_02)
{
	self endon("stop_goto_node");
	if(!isdefined(param_02))
	{
		param_02 = 16;
	}

	maps\_utility::set_goal_radius(param_02);
	if(isstring(param_00))
	{
		var_03 = getnode(param_00,"script_noteworthy");
	}
	else
	{
		var_03 = param_01;
	}

	if(isdefined(var_03))
	{
		maps\_utility::set_goal_node(var_03);
	}
	else
	{
		var_03 = common_scripts\utility::getstruct(param_00,"script_noteworthy");
		maps\_utility::set_goal_pos(var_03.origin);
	}

	if(param_01)
	{
		self waittill("goal");
	}
}

//Function Number: 11
disable_grenades()
{
	if(isdefined(self.grenadeammo) && !isdefined(self.oldgrenadeammo))
	{
		self.oldgrenadeammo = self.grenadeammo;
	}

	self.grenadeammo = 0;
}

//Function Number: 12
enable_grenades()
{
	if(isdefined(self.oldgrenadeammo))
	{
		self.grenadeammo = self.oldgrenadeammo;
		self.oldgrenadeammo = undefined;
	}
}

//Function Number: 13
equip_microwave_grenade()
{
	self.grenadeweapon = "microwave_grenade";
	self.grenadeammo = 2;
}

//Function Number: 14
bloody_death(param_00)
{
	self endon("death");
	if(!issentient(self) || !isalive(self))
	{
		return;
	}

	if(isdefined(self.bloody_death) && self.bloody_death)
	{
		return;
	}

	self.bloody_death = 1;
	if(isdefined(param_00))
	{
		wait(randomfloat(param_00));
	}

	var_01 = [];
	var_01[0] = "j_hip_le";
	var_01[1] = "j_hip_ri";
	var_01[2] = "j_head";
	var_01[3] = "j_spine4";
	var_01[4] = "j_elbow_le";
	var_01[5] = "j_elbow_ri";
	var_01[6] = "j_clavicle_le";
	var_01[7] = "j_clavicle_ri";
	for(var_02 = 0;var_02 < 3 + randomint(5);var_02++)
	{
		var_03 = randomintrange(0,var_01.size);
		thread bloody_death_fx(var_01[var_03],undefined);
		wait(randomfloat(0.1));
	}

	self dodamage(self.health + 50,self.origin);
}

//Function Number: 15
bloody_death_fx(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level._effect["flesh_hit"];
	}

	playfxontag(param_01,self,param_00);
}

//Function Number: 16
teleport_to_scriptstruct(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00,"script_noteworthy");
	level.player setorigin(var_01.origin);
	if(isdefined(var_01.angles))
	{
		level.player setplayerangles(var_01.angles);
	}

	var_02 = getentarray("hero","script_noteworthy");
	foreach(var_04 in var_02)
	{
		if(isspawner(var_04))
		{
			var_02 = common_scripts\utility::array_remove(var_02,var_04);
		}
	}

	var_06 = common_scripts\utility::getstructarray(var_01.target,"targetname");
	for(var_07 = 0;var_07 < var_02.size;var_07++)
	{
		if(var_07 < var_06.size)
		{
			var_02[var_07] forceteleport(var_06[var_07].origin,var_06[var_07].angles);
			var_02[var_07] setgoalpos(var_06[var_07].origin);
			continue;
		}

		var_02[var_07] forceteleport(level.player.origin,level.player.angles);
		var_02[var_07] setgoalpos(level.player.origin);
	}
}

//Function Number: 17
kill_path_on_death()
{
	wait_to_kill_path();
	self notify("newpath");
}

//Function Number: 18
wait_to_kill_path()
{
	self endon("death");
	self endon("driver dead");
	level waittill("eternity");
}

//Function Number: 19
disable_awareness()
{
	self.ignoreall = 1;
	self.dontmelee = 1;
	self.ignoresuppression = 1;
	self.suppressionwait_old = self.suppressionwait;
	self.suppressionwait = 0;
	maps\_utility::disable_surprise();
	self.ignorerandombulletdamage = 1;
	maps\_utility::disable_bulletwhizbyreaction();
	maps\_utility::disable_pain();
	self.grenadeawareness = 0;
	self.ignoreme = 1;
	maps\_utility::enable_dontevershoot();
	self.disablefriendlyfirereaction = 1;
	self.dodangerreact = 0;
}

//Function Number: 20
enable_awareness()
{
	self.ignoreall = 0;
	self.dontmelee = undefined;
	self.ignoresuppression = 0;
	self.suppressionwait = self.suppressionwait_old;
	self.suppressionwait_old = undefined;
	maps\_utility::enable_surprise();
	self.ignorerandombulletdamage = 0;
	maps\_utility::enable_bulletwhizbyreaction();
	maps\_utility::enable_pain();
	self.grenadeawareness = 1;
	self.ignoreme = 0;
	maps\_utility::disable_dontevershoot();
	self.disablefriendlyfirereaction = undefined;
	self.dodangerreact = 1;
}

//Function Number: 21
hide_friendname_until_flag_or_notify(param_00)
{
	if(!isdefined(self.name))
	{
		return;
	}

	level.player endon("death");
	self endon("death");
	self.old_name = self.name;
	self.name = " ";
	level waittill(param_00);
	self.name = self.old_name;
}

//Function Number: 22
ignore_badplace(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_wait(param_00);
	}

	self.old_bp_awareness = self.badplaceawareness;
	self.badplaceawareness = 0;
	if(isdefined(param_01))
	{
		common_scripts\utility::flag_wait(param_01);
		self.badplaceawareness = self.old_bp_awareness;
	}
}

//Function Number: 23
print3duntilnotify(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon(param_05);
	wait(0.05);
}

//Function Number: 24
printorigin3duntilnotify(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_04);
	wait(0.05);
}

//Function Number: 25
delete_on_notify(param_00)
{
	level waittill(param_00);
	self delete();
}

//Function Number: 26
run_thread_on_notify(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	self waittill(param_01);
	self thread [[ param_00 ]]();
}

//Function Number: 27
hint_button_string_lookup_fus(param_00)
{
	switch(param_00)
	{
		case "activate":
		case "usereload":
		case "use":
		case "reload":
		case "x":
			return "^3[{+activate}]^7";

		case "gostand":
		case "jump":
		case "a":
			return "^3[{+gostand}]^7";

		case "weapnext":
		case "y":
			return "^3[{weapnext}]^7";

		case "stance":
		case "crouch":
		case "b":
			return "^3[{+stance}]^7";

		case "melee":
			return "^3[{+melee}]^7";

		case "pause":
		case "start":
			return "^3[{pause}]^7";

		default:
			break;
	}
}

//Function Number: 28
hint_button_clear_fus()
{
	if(isdefined(self.deleteobjectwhendone) && self.deleteobjectwhendone)
	{
		self.object delete();
	}

	self destroy();
}

//Function Number: 29
point_is_in_screen_circle(param_00,param_01,param_02)
{
	return vectordot(vectornormalize(param_00 - param_01 geteye()),anglestoforward(param_01 getplayerangles())) > cos(param_02);
}

//Function Number: 30
player_in_mt()
{
	return isdefined(level.player.drivingvehicleandturret);
}

//Function Number: 31
is_sonar_vision_allowed()
{
	var_00 = level.player getcurrentweapon();
	if(weaponhasthermalscope(var_00) && level.player playerads() > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
disable_sonar_when_not_allowed()
{
	level.player endon("sonar_vision_off");
	for(;;)
	{
		if(!is_sonar_vision_allowed())
		{
			break;
		}

		wait 0.05;
	}

	sonar_off();
}

//Function Number: 33
thermal_with_nvg()
{
	level endon("flag_end_sonar_vision");
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	for(;;)
	{
		self waittill("sonar_vision");
		if(!is_sonar_vision_allowed())
		{
			continue;
		}

		if(!isdefined(level.player.sonar_vision) || !level.player.sonar_vision)
		{
			sonar_on();
			childthread disable_sonar_when_not_allowed();
			continue;
		}

		sonar_off();
	}
}

//Function Number: 34
sonar_save_and_set_dvars()
{
	if(!isdefined(level.player.sonarvisionsaveddvars))
	{
		level.player.sonarvisionsaveddvars = [];
	}

	level.player.sonarvisionsaveddvars["r_hudoutlineenable"] = getdvarint("r_hudoutlineenable",1);
	level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"] = getdvar("r_hudoutlinepostmode",0);
	level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"] = getdvarfloat("r_hudoutlinehaloblurradius",1);
	level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"] = getdvarfloat("r_hudoutlinehalolumscale",1);
	level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"] = getdvar("r_hudoutlinehalowhen",1);
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinepostmode",2);
	setsaveddvar("r_hudoutlinehaloblurradius",0.7);
	setsaveddvar("r_hudoutlinehalolumscale",2);
	setsaveddvar("r_hudoutlinehalowhen",0);
	level.player.sonarvisionsaveddvars["r_ssrBlendScale"] = getdvarfloat("r_ssrBlendScale",1);
	setsaveddvar("r_ssrBlendScale",0);
}

//Function Number: 35
sonar_reset_dvars()
{
	if(isdefined(level.player.sonarvisionsaveddvars))
	{
		setsaveddvar("r_hudoutlineenable",level.player.sonarvisionsaveddvars["r_hudoutlineenable"]);
		setsaveddvar("r_hudoutlinepostmode",level.player.sonarvisionsaveddvars["r_hudoutlinepostmode"]);
		setsaveddvar("r_hudoutlinehaloblurradius",level.player.sonarvisionsaveddvars["r_hudoutlinehaloblurradius"]);
		setsaveddvar("r_hudoutlinehalolumscale",level.player.sonarvisionsaveddvars["r_hudoutlinehalolumscale"]);
		setsaveddvar("r_hudoutlinehalowhen",level.player.sonarvisionsaveddvars["r_hudoutlinehalowhen"]);
		setsaveddvar("r_ssrBlendScale",level.player.sonarvisionsaveddvars["r_ssrBlendScale"]);
	}
}

//Function Number: 36
sonar_on()
{
	level.overlaysonar = create_hud_sonar_overlay(0,1);
	sonar_save_and_set_dvars();
	thread mark_enemies();
	var_00 = 0.05;
	level.player lightsetoverrideenableforplayer("sanfran_b_sonar_vision",var_00);
	level.player setclutoverrideenableforplayer("clut_sonar",var_00);
	soundscripts\_snd::snd_message("aud_sonar_vision_on");
	level.player.sonar_vision = 1;
	level notify("sonar_update");
}

//Function Number: 37
sonar_off()
{
	var_00 = 0.05;
	level.player lightsetoverrideenableforplayer(var_00);
	level.player setclutoverridedisableforplayer(var_00);
	soundscripts\_snd::snd_message("aud_sonar_vision_off");
	level.player.sonar_vision = 0;
	level notify("sonar_update");
	if(isdefined(level.overlay))
	{
		level.overlay destroy();
	}

	if(isdefined(level.overlaythreat))
	{
		level.overlaythreat destroy();
	}

	if(isdefined(level.overlaysonar))
	{
		level.overlaysonar destroy();
	}

	sonar_reset_dvars();
	foreach(var_02 in getaiarray("axis","allies"))
	{
		if(isdefined(var_02.hudoutlineenabledbysonarvision))
		{
			var_02 hudoutlinedisable();
			var_02.hudoutlineenabledbysonarvision = undefined;
		}
	}

	level.player notify("sonar_vision_off");
}

//Function Number: 38
mark_enemies()
{
	level.player endon("sonar_vision_off");
	for(;;)
	{
		foreach(var_01 in getaiarray("axis"))
		{
			var_01 hudoutlineenable(1,1,0);
			var_01.hudoutlineenabledbysonarvision = 1;
		}

		foreach(var_04 in getaiarray("allies"))
		{
			var_04 hudoutlineenable(2,1,0);
			var_04.hudoutlineenabledbysonarvision = 1;
		}

		wait(0.1);
	}
}

//Function Number: 39
create_hud_sonar_overlay(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = 0;
	var_02.y = 0;
	if(level.currentgen)
	{
		var_02.color = (1,0.6,0.2);
	}
	else
	{
		var_02.color = (0.1,0.1,1);
	}

	var_02.sort = param_00;
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02.alpha = param_01;
	var_02 setsonarvision(10);
	return var_02;
}

//Function Number: 40
should_end_sonar_hint()
{
	return isdefined(level.player.sonar_vision) && level.player.sonar_vision;
}

//Function Number: 41
should_end_pdrone_hint()
{
	if(common_scripts\utility::flag("turbine_room_stop_combat") || common_scripts\utility::flag("flag_player_using_drone"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
should_end_pdrone_fail_hint()
{
	if(common_scripts\utility::flag("turbine_room_stop_combat") || common_scripts\utility::flag("flag_player_using_drone"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 43
spawn_player_drone_think()
{
	level endon("turbine_room_stop_combat");
	for(;;)
	{
		level.player waittill("use_drone");
		while(level.player isjumping())
		{
			wait 0.05;
		}

		if(deploy_check_player_in_elevator_think())
		{
			break;
		}
		else
		{
			wait(0.25);
			maps\_utility::hintdisplaymintimehandler("drone_deploy_fail_prompt",2);
			wait(1);
			if(common_scripts\utility::flag("drone_deploy_prompt_displayed"))
			{
				maps\_utility::hintdisplaymintimehandler("drone_deploy_prompt",8);
			}
		}
	}

	if(common_scripts\utility::flag("player_drone_attack_done") == 0)
	{
		common_scripts\utility::flag_set("player_drone_start");
		level notify("player_drone_start");
		thread spawn_turbine_enemies_tidal_wave();
		thread force_exit_turbine_combat_complete();
		common_scripts\utility::flag_set("flag_player_using_drone");
		thread player_drone_manager();
	}
}

//Function Number: 44
deploy_check_player_in_elevator_think()
{
	var_00 = undefined;
	if(common_scripts\utility::flag("player_is_in_turbine_room"))
	{
		return vehicle_scripts\_pdrone_player::pdrone_deploy_check(70,undefined,10);
	}

	return vehicle_scripts\_pdrone_player::pdrone_deploy_check(180,undefined,40);
}

//Function Number: 45
spawn_turbine_enemies_tidal_wave()
{
	maps\_utility::activate_trigger("turbine_room_combat_spawn_trigger","script_noteworthy");
	common_scripts\utility::flag_set("turbine_room_all_enemies");
}

//Function Number: 46
player_drone_manager()
{
	common_scripts\utility::flag_set("player_drone_start");
	level notify("player_drone_start");
	level.player setweaponhudiconoverride("actionslot1","dpad_icon_drone_off");
	maps\_player_exo::player_exo_deactivate();
	player_drone_control();
	maps\_player_exo::player_exo_activate();
	common_scripts\utility::flag_clear("flag_player_using_drone");
	common_scripts\utility::flag_set("player_drone_attack_done");
}

//Function Number: 47
player_drone_control()
{
	var_00 = getent("pdrone_player_spawner","targetname");
	var_01 = common_scripts\utility::getstruct("pdrone_turbine_in_elevator_safe_spawn","targetname");
	if(common_scripts\utility::flag("player_is_in_turbine_room"))
	{
		var_02 = vehicle_scripts\_pdrone_player::pdrone_deploy(var_00,0,var_01);
	}
	else
	{
		var_02 = vehicle_scripts\_pdrone_player::pdrone_deploy(var_01,0);
	}

	vehicle_scripts\_pdrone_player::pdrone_player_use(var_02,"player_drone_airspace_turbine",undefined,undefined);
	var_02 vehicle_scripts\_pdrone_player::pdrone_player_add_vehicle_target("script_noteworthy","training_s2_patio_vehicles");
	thread maps\fusion_lighting::setup_lighting_fly_drone_turbine();
	level.player.drone = var_02;
	var_02 vehicle_scripts\_pdrone_player::pdrone_player_enter(1);
	soundscripts\_snd::snd_message("rec_player_drone_start",var_02);
	var_02 vehicle_scripts\_pdrone_player::pdrone_player_loop();
	soundscripts\_snd::snd_message("rec_player_drone_end");
	thread maps\fusion_lighting::setup_lighting_fly_drone_off_turbine();
	var_02 vehicle_scripts\_pdrone_player::pdrone_player_exit(1);
	var_02 delete();
}

//Function Number: 48
force_exit_turbine_combat_complete()
{
	waittillframeend;
	var_00 = getaiarray("axis");
	maps\_utility::waittill_dead_or_dying(var_00);
	common_scripts\utility::flag_set("flag_turbine_pdrone_combat_complete");
	wait(2);
	level.player.drone vehicle_scripts\_pdrone_player::pdrone_player_force_exit();
}