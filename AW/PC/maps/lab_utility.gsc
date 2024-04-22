/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lab_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 166
 * Decompile Time: 2457 ms
 * Timestamp: 4/22/2024 2:33:08 AM
*******************************************************************/

//Function Number: 1
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

//Function Number: 2
ally_move_dynamic_speed()
{
	self notify("start_dynamic_run_speed");
	self endon("death");
	self endon("stop_dynamic_run_speed");
	self endon("start_dynamic_run_speed");
	if(maps\_utility::ent_flag_exist("_stealth_custom_anim"))
	{
		maps\_utility::ent_flag_waitopen("_stealth_custom_anim");
	}

	self.run_speed_state = "";
	ally_reset_dynamic_speed();
	var_00 = 144;
	var_01 = ["sprint","run"];
	var_02 = [];
	var_02["player_sprint"]["sprint"][0] = 225 * var_00;
	var_02["player_sprint"]["sprint"][1] = 900 * var_00;
	var_02["player_sprint"]["run"][0] = 900 * var_00;
	var_02["player_sprint"]["run"][1] = 900 * var_00;
	var_02["player_run"]["sprint"][0] = 225 * var_00;
	var_02["player_run"]["sprint"][1] = 400 * var_00;
	var_02["player_run"]["run"][0] = 400 * var_00;
	var_02["player_run"]["run"][1] = 625 * var_00;
	var_02["player_crouch"]["run"][0] = 4 * var_00;
	var_02["player_crouch"]["run"][1] = 100 * var_00;
	var_03 = 123;
	var_04 = 189;
	var_05 = 283;
	for(;;)
	{
		wait(0.2);
		if(isdefined(self.force_run_speed_state))
		{
			ally_dynamic_run_set(self.force_run_speed_state);
			continue;
		}

		var_06 = vectornormalize(anglestoforward(self.angles));
		var_07 = vectornormalize(self.origin - level.player.origin);
		var_08 = vectordot(var_06,var_07);
		var_09 = distancesquared(self.origin,level.player.origin);
		if(isdefined(self.cqbwalking) && self.cqbwalking)
		{
			self.moveplaybackrate = 1;
		}

		if(common_scripts\utility::flag_exist("_stealth_spotted") && common_scripts\utility::flag("_stealth_spotted"))
		{
			ally_dynamic_run_set("run");
			continue;
		}

		if(var_08 < -0.25 && var_09 > 225 * var_00)
		{
			ally_dynamic_run_set("sprint");
			continue;
		}

		var_0A = level.player getvelocity();
		var_0B = length(var_0A);
		var_0C = "";
		if(var_0B < var_03)
		{
			var_0C = "player_crouch";
		}
		else if(var_0B < var_04)
		{
			var_0C = "player_run";
		}
		else
		{
			var_0C = "player_sprint";
		}

		var_0D = var_02[var_0C];
		var_0E = 0;
		foreach(var_10 in var_01)
		{
			if(isdefined(var_0D[var_10]))
			{
				if(var_09 < var_0D[var_10][0] || self.run_speed_state == var_10 && var_09 < var_0D[var_10][1])
				{
					ally_dynamic_run_set(var_10);
					var_0E = 1;
					break;
				}
			}
		}

		if(var_0E)
		{
			continue;
		}

		ally_dynamic_run_set("jog_slow");
	}
}

//Function Number: 3
ally_stop_dynamic_speed()
{
	self endon("death");
	self notify("stop_dynamic_run_speed");
	ally_reset_dynamic_speed();
}

//Function Number: 4
ally_reset_dynamic_speed()
{
	self endon("death");
	maps\_utility::disable_cqbwalk();
	self.moveplaybackrate = 1;
	maps\_utility::clear_run_anim();
	self notify("stop_loop");
}

//Function Number: 5
ally_dynamic_run_set(param_00)
{
	if(self.run_speed_state == param_00)
	{
		return;
	}

	self.run_speed_state = param_00;
	switch(param_00)
	{
		case "sprint":
			if(isdefined(self.cqbwalking) && self.cqbwalking)
			{
				self.moveplaybackrate = 1;
			}
			else
			{
				self.moveplaybackrate = 1;
			}
	
			maps\_utility::set_generic_run_anim("DRS_sprint");
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;

		case "run":
			self.moveplaybackrate = 1.1;
			maps\_utility::clear_run_anim();
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;

		case "jog":
			self.moveplaybackrate = 1;
			maps\_utility::set_generic_run_anim("DRS_combat_jog");
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;

		case "jog_slow":
			self.moveplaybackrate = 0.9;
			maps\_utility::disable_cqbwalk();
			self notify("stop_loop");
			break;
	}
}

//Function Number: 6
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

//Function Number: 7
cleanup_ai_with_script_noteworthy(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 512;
	}

	var_02 = [];
	foreach(var_04 in getentarray(param_00,"script_noteworthy"))
	{
		if(isspawner(var_04))
		{
			var_04 delete();
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	thread maps\_utility::ai_delete_when_out_of_sight(var_02,param_01);
}

//Function Number: 8
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

//Function Number: 9
warbird_shooting_think(param_00)
{
	level.player endon("death");
	self endon("death");
	self.mgturret[0] setmode("manual");
	self.mgturret[1] setmode("manual");
	if(!maps\_utility::ent_flag_exist("fire_turrets"))
	{
		maps\_utility::ent_flag_init("fire_turrets");
	}

	maps\_utility::ent_flag_set("fire_turrets");
	thread warbird_fire_monitor();
	for(;;)
	{
		self waittill("warbird_fire");
		thread warbird_fire(param_00);
	}
}

//Function Number: 10
warbird_fire(param_00)
{
	self endon("death");
	var_01 = self.mgturret[0];
	var_02 = self.mgturret[1];
	var_03 = 3;
	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_04 = getaiarray("allies");
		if(!maps\_utility::ent_flag_exist("dont_shoot_player") || !maps\_utility::ent_flag("dont_shoot_player"))
		{
			var_05 = 33;
			if(randomint(100) <= var_05)
			{
				var_04 = common_scripts\utility::array_add(var_04,level.player);
			}
		}

		var_06 = [];
		foreach(var_08 in var_04)
		{
			if(isdefined(var_08.ignoreme) && var_08.ignoreme)
			{
				continue;
			}
			else
			{
				var_06[var_06.size] = var_08;
			}
		}

		var_06 = sortbydistance(var_06,self.origin);
		var_0A = undefined;
		foreach(var_08 in var_06)
		{
			if(!isdefined(var_08))
			{
				continue;
			}

			if(!isalive(var_08))
			{
				continue;
			}

			if(isdefined(param_00) && param_00)
			{
				var_0C = self.mgturret[0] gettagorigin("tag_flash");
				var_0D = var_08 geteye();
				var_0E = vectornormalize(var_0D - var_0C);
				var_0F = var_0D + var_0E * 20;
				if(!sighttracepassed(var_0F,var_0D,0,var_08,self.mgturret[0]))
				{
					continue;
				}
			}

			var_0A = var_08;
			break;
		}

		if(isdefined(var_0A))
		{
			var_01 settargetentity(var_0A);
			var_02 settargetentity(var_0A);
			var_01 turretfireenable();
			var_02 turretfireenable();
			var_01 startfiring();
			var_02 startfiring();
			wait_for_warbird_fire_target_done(var_0A,param_00);
			var_01 cleartargetentity();
			var_02 cleartargetentity();
			var_01 turretfiredisable();
			var_02 turretfiredisable();
		}

		wait(var_03);
	}

	var_01 turretfiredisable();
	var_02 turretfiredisable();
}

//Function Number: 11
wait_for_warbird_fire_target_done(param_00,param_01)
{
	param_00 endon("death");
	if(!maps\_utility::ent_flag("fire_turrets"))
	{
		return;
	}

	self endon("fire_turrets");
	if(param_00 == level.player)
	{
		var_02 = 0.6;
	}
	else
	{
		var_02 = 3;
	}

	var_03 = 0;
	while(var_03 < var_02)
	{
		if(isdefined(param_01) && param_01)
		{
			var_04 = self.mgturret[0] gettagorigin("tag_flash");
			var_05 = param_00 geteye();
			var_06 = vectornormalize(var_05 - var_04);
			var_07 = var_04 + var_06 * 20;
			if(!sighttracepassed(var_07,var_05,0,param_00,self.mgturret[0]))
			{
				return;
			}
		}

		var_03 = var_03 + 0.3;
		wait(0.3);
	}
}

//Function Number: 12
warbird_fire_monitor()
{
	self endon("death");
	self waittill("warbird_stop_firing");
	maps\_utility::ent_flag_clear("fire_turrets");
}

//Function Number: 13
add_enemy_flashlight()
{
	playfxontag(common_scripts\utility::getfx("flashlight_ai"),self,"tag_flash");
	self.have_flashlight = 1;
}

//Function Number: 14
assign_cloak_model(param_00)
{
	self.cloakedmodel = param_00;
	self.defaultmodel = self.model;
}

//Function Number: 15
cloak_on(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0.75;
	}

	var_02 = 0;
	self setmodel(self.cloakedmodel);
	if(issubstr(self.model,"burke") || issubstr(self.model,"knox"))
	{
		wait(0.05);
		self overridematerial("mtl_burke_sentinel_covert_headgear_a","mc/mtl_burke_sentinel_covert_headgear_a_cloak");
	}

	if(issubstr(self.model,"cormack"))
	{
		wait(0.05);
		self overridematerial("mtl_cormack_sentinel_covert_headgear_a","mc/mtl_cormack_sentinel_covert_headgear_a_cloak");
	}

	self drawpostresolve();
	self setmaterialscriptparam(0,param_01);
	soundscripts\_snd::snd_message("npc_cloak_enable");
	if(param_00)
	{
		cloak_stencil_on();
	}

	self.cloak = "on";
	wait(0.1);
	maps\_cloak::set_cloak_material_for_npc_weapon();
}

//Function Number: 16
turn_on_the_cloak_effect_wallclimb()
{
	level._cloaked_stealth_settings.cloak_on = 1;
	soundscripts\_snd::snd_message("exo_cloak_enable");
	if(level._cloaked_stealth_settings.visibility_range_version == 1)
	{
		maps\_stealth_utility::stealth_detect_ranges_set(level._cloaked_stealth_settings.ranges["cloak_on_hidden"],level._cloaked_stealth_settings.ranges["cloak_on_spotted"]);
	}

	thread maps\_cloak::cloak_vm_weapon_blend();
	if(isdefined(level.scr_model["player_rig"]))
	{
		level.scr_model["player_rig"] = "viewbody_sentinel_covert_cloak";
	}

	if(isdefined(level.player_rig))
	{
		level.player_rig setmaterialscriptparam(1,0);
		level.player_rig setmodel(level.scr_model["player_rig"]);
		wait(0.05);
		level.player_rig drawpostresolve();
		level.player_rig setmaterialscriptparam(1,0);
		wait(0.05);
		level.player_rig setmaterialscriptparam(0,0.75);
		level.player_rig hudoutlineenable(0);
	}
}

//Function Number: 17
cloak_stencil_on(param_00)
{
	thread maps\_cloak::setalertstencilstate(param_00);
}

//Function Number: 18
cloak_off(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = 0;
	soundscripts\_snd::snd_message("npc_cloak_disable");
	self setmaterialscriptparam(1,param_00);
	wait(param_00);
	self overridematerialreset();
	self drawpostresolveoff();
	if(issubstr(self.name,"Knox"))
	{
		if(isdefined(level.rope_knox) && isdefined(level.carabiner_knox))
		{
			level.rope_knox cloak_off_rope();
			level.carabiner_knox cloak_off_rope(0.2);
		}
	}

	self setmodel(self.defaultmodel);
	thread maps\_cloak::clearalertstencilstate();
	self.cloak = "off";
}

//Function Number: 19
cloak_off_rope(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self setmaterialscriptparam(1,param_00);
	self overridematerialreset();
	self drawpostresolveoff();
}

//Function Number: 20
am_i_moving()
{
	wait(0.1);
	var_00 = maps\_shg_utility::get_differentiated_velocity();
	if(length(var_00) != 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 21
any_enemy_is_able_to_attack()
{
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		foreach(var_01 in getaispeciesarray("bad_guys","all"))
		{
			if(var_01.alertlevel == "combat" && isdefined(var_01.enemy) && var_01 cansee(var_01.enemy))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 22
prevent_friendly_from_shooting_during_stealth()
{
	var_00 = 0.3;
	for(;;)
	{
		if(common_scripts\utility::flag("flag_obj_bio_weapons_04") || common_scripts\utility::flag("flag_post_breach_patrol_alerted"))
		{
			self.dontevershoot = undefined;
			maps\_utility::set_ignoreall(0);
			return;
		}

		if(!common_scripts\utility::flag("_stealth_enabled") || any_enemy_is_able_to_attack())
		{
			self.dontevershoot = undefined;
			maps\_utility::set_ignoreall(0);
		}
		else
		{
			self.dontevershoot = 1;
			maps\_utility::set_ignoreall(1);
		}

		wait(var_00);
	}
}

//Function Number: 23
do_scanner_sounds()
{
	self endon("death");
	for(;;)
	{
		var_00 = line_segment_end_point(self.scanner_origin,self.scanner_yaw,self.scanner_tilt,self.cone_length);
		var_01 = bullettrace(self.scanner_origin,var_00,1);
		var_02 = var_01["position"];
		self notify("update_seeker_audio",var_02);
		wait(0.05);
	}
}

//Function Number: 24
do_scanner_fx()
{
	self endon("death");
	var_00 = 0;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_05 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx(self.fx_target_none),var_05,"tag_origin");
	thread do_scanner_death(var_05);
	for(;;)
	{
		update_vfx_tags(self.scanner_origin,self.scanner_yaw,self.scanner_tilt,self.vertical_cone_range,self.horizontal_cone_range,var_01,var_02,var_03,var_04,var_05);
		if(var_00)
		{
			if((isdefined(self.scanner_cone_inside_ents) && self.scanner_cone_inside_ents.size == 0) || !isdefined(self.scanner_cone_inside_ents) && !level.player_is_in_scanner_cone)
			{
				var_00 = 0;
				playfxontag(common_scripts\utility::getfx(self.fx_target_none),var_05,"tag_origin");
				stopfxontag(common_scripts\utility::getfx(self.fx_target_locked),var_05,"tag_origin");
				self notify("update_fixed_scanner_audio",0);
			}
		}
		else if((isdefined(self.scanner_cone_inside_ents) && self.scanner_cone_inside_ents.size > 0) || !isdefined(self.scanner_cone_inside_ents) && level.player_is_in_scanner_cone)
		{
			var_00 = 1;
			playfxontag(common_scripts\utility::getfx(self.fx_target_locked),var_05,"tag_origin");
			stopfxontag(common_scripts\utility::getfx(self.fx_target_none),var_05,"tag_origin");
			self notify("update_fixed_scanner_audio",1);
		}

		wait(0.05);
	}
}

//Function Number: 25
attach_fixed_scanner(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.scanner_cone_inside_ents = [];
	stopfxontag(common_scripts\utility::getfx(param_05),self,"tag_fx");
	self endon("death");
	if(self.health < 0)
	{
		return;
	}

	self.scanner_origin = self gettagorigin("tag_fx");
	self.scanner_yaw = param_02;
	self.scanner_tilt = param_03;
	self.cone_length = param_00;
	self.horizontal_cone_range = param_01;
	self.vertical_cone_range = param_01;
	self.fx_target_locked = param_04;
	self.fx_target_none = param_05;
	thread do_scanner_fx();
	if(0)
	{
		thread do_tuning();
	}

	thread draw_scanner_cone_loop();
	thread maps\_shg_utility::make_emp_vulnerable();
	self.emp_death_function = ::scanner_monitor_emp_damage;
	self makeentitysentient("axis");
	var_06 = getaiarray("allies");
	var_06[var_06.size] = level.player;
	for(;;)
	{
		foreach(var_08 in var_06)
		{
			if(!isalive(var_08))
			{
				var_06 = maps\_utility::array_removedead(var_06);
				remove_dead_bodies_from_cone(var_06);
				continue;
			}

			var_09 = var_08 getentitynumber();
			var_0A = var_08 getpointinbounds(0,0,0);
			var_0B = in_scanner_cone(var_0A,self.scanner_origin,self.scanner_yaw,self.scanner_tilt,self.cone_length,self.horizontal_cone_range);
			if(var_0B)
			{
				if(!isdefined(self.scanner_cone_inside_ents[var_09]))
				{
					self.scanner_cone_inside_ents[var_09] = 1;
					handle_actor_enter_scanner(var_08);
				}
			}
			else if(isdefined(self.scanner_cone_inside_ents[var_09]))
			{
				self.scanner_cone_inside_ents[var_09] = undefined;
			}

			if(var_09 == level.player getentitynumber())
			{
				level.player_is_in_scanner_cone = var_0B;
			}
		}

		wait(0.25);
	}
}

//Function Number: 26
scanner_monitor_emp_damage()
{
	self notify("damage",9999999,self,(0,0,0),self.origin,"MOD_EXPLOSIVE","","");
	self notify("death");
}

//Function Number: 27
handle_actor_enter_scanner(param_00)
{
	if(param_00 getentitynumber() == level.player getentitynumber())
	{
		maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
		param_00 shellshock("flashbang",3);
		return;
	}

	param_00 cloak_off();
	param_00 maps\_utility::flashbangstart(2);
}

//Function Number: 28
do_scanner_death(param_00)
{
	self waittill("death");
	if(issentient(self))
	{
		self freeentitysentient();
	}

	stopfxontag(common_scripts\utility::getfx(self.fx_target_none),param_00,"tag_origin");
	stopfxontag(common_scripts\utility::getfx(self.fx_target_locked),param_00,"tag_origin");
}

//Function Number: 29
remove_dead_bodies_from_cone(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(isdefined(self.scanner_cone_inside_ents[var_03 getentitynumber()]))
		{
			var_01[var_03 getentitynumber()] = 1;
		}
	}

	self.scanner_cone_inside_ents = var_01;
}

//Function Number: 30
draw_scanner_cone_loop()
{
	self endon("death");
	for(;;)
	{
		draw_scanner_cone(self.scanner_cone_inside_ents.size,self.scanner_origin,self.scanner_yaw,self.scanner_tilt,self.scanner_origin,self.scanner_origin,self.cone_length,self.horizontal_cone_range,self.horizontal_cone_range);
		wait(0.05);
	}
}

//Function Number: 31
do_tuning()
{
	for(;;)
	{
		if(level.player buttonpressed("DPAD_UP"))
		{
			self.scanner_tilt = self.scanner_tilt - 1;
		}

		if(level.player buttonpressed("DPAD_DOWN"))
		{
			self.scanner_tilt = self.scanner_tilt + 1;
		}

		if(level.player buttonpressed("DPAD_LEFT"))
		{
			self.scanner_yaw = self.scanner_yaw - 1;
		}

		if(level.player buttonpressed("DPAD_RIGHT"))
		{
			self.scanner_yaw = self.scanner_yaw + 1;
		}

		if(level.player buttonpressed("BUTTON_X"))
		{
			self.horizontal_cone_range = self.horizontal_cone_range - 0.1;
			self.vertical_cone_range = self.vertical_cone_range - 0.1;
		}

		if(level.player buttonpressed("BUTTON_Y"))
		{
			self.horizontal_cone_range = self.horizontal_cone_range + 0.1;
			self.vertical_cone_range = self.vertical_cone_range + 0.1;
		}

		if(level.player buttonpressed("BUTTON_LSTICK"))
		{
			self.cone_length = self.cone_length - 10;
		}

		if(level.player buttonpressed("BUTTON_RSTICK"))
		{
			self.cone_length = self.cone_length + 10;
		}

		var_00 = " tilt:" + self.scanner_tilt + " yaw:" + self.scanner_yaw + " range:" + self.horizontal_cone_range + " length:" + self.cone_length;
		if(level.player buttonpressed("DPAD_UP") || level.player buttonpressed("DPAD_DOWN") || level.player buttonpressed("DPAD_LEFT") || level.player buttonpressed("DPAD_RIGHT") || level.player buttonpressed("BUTTON_X") || level.player buttonpressed("BUTTON_Y") || level.player buttonpressed("BUTTON_LSTICK") || level.player buttonpressed("BUTTON_RSTICK"))
		{
		}

		wait 0.05;
	}
}

//Function Number: 32
enable_all_fixed_scanners()
{
	level.camera_array = getentarray("camera_breach","script_noteworthy");
	var_00 = getentarray("camera_scanner_interior","script_noteworthy");
	level.camera_array = common_scripts\utility::array_combine(level.camera_array,var_00);
	var_00 = undefined;
	common_scripts\utility::array_thread(level.camera_array,::camera_scanner_think);
}

//Function Number: 33
camera_scanner_think()
{
	var_00 = undefined;
	if(isdefined(self.target))
	{
		var_00 = getent(self.target,"targetname");
		var_00 enableaimassist();
		var_00.maxhealth = 1;
		var_00 setnormalhealth(var_00.maxhealth);
		target_set(var_00,(0,0,-80));
		target_setjavelinonly(var_00,1);
	}

	if(!isdefined(self.scanner_cone_inside_ents))
	{
		thread attach_fixed_scanner(300,60,angleclamp(180 + self.angles[1]),self.angles[0],"camera_fixed_scanner","camera_fixed_scanner_search");
	}

	soundscripts\_snd::snd_message("start_fixed_scanner_audio");
	self waittill("death");
	if(common_scripts\utility::flag("flag_facility_breach_complete"))
	{
		thread maps\lab_vo::camera_scanner_interior_killed();
	}

	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 34
disable_all_fixed_scanners()
{
	if(isdefined(level.camera_array))
	{
		foreach(var_01 in level.camera_array)
		{
			if(isdefined(var_01.scanner_cone_inside_ents))
			{
				self notify("death");
			}

			var_01 notify("stop_fixed_scanner_audio");
		}
	}
}

//Function Number: 35
do_vehicle_scanner_tuning()
{
	for(;;)
	{
		if(level.player buttonpressed("DPAD_UP"))
		{
			self.scanner_tilt = self.scanner_tilt - 1;
		}

		if(level.player buttonpressed("DPAD_DOWN"))
		{
			self.scanner_tilt = self.scanner_tilt + 1;
		}

		if(level.player buttonpressed("BUTTON_LSTICK"))
		{
			self.cone_length = self.cone_length - 10;
		}

		if(level.player buttonpressed("BUTTON_RSTICK"))
		{
			self.cone_length = self.cone_length + 10;
		}

		if(level.player buttonpressed("DPAD_LEFT"))
		{
			self.scanner_offset_from_vehicle_facing = self.scanner_offset_from_vehicle_facing - 1;
		}

		if(level.player buttonpressed("DPAD_RIGHT"))
		{
			self.scanner_offset_from_vehicle_facing = self.scanner_offset_from_vehicle_facing + 1;
		}

		if(level.player buttonpressed("BUTTON_X"))
		{
			self.sweep_range = self.sweep_range - 0.1;
		}

		if(level.player buttonpressed("BUTTON_Y"))
		{
			self.sweep_range = self.sweep_range + 0.1;
		}

		var_00 = " tilt:" + self.scanner_tilt + " offset:" + self.scanner_offset_from_vehicle_facing + " range:" + self.sweep_range + " length:" + self.cone_length;
		wait(0.05);
	}
}

//Function Number: 36
attach_scanner(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(!isdefined(level.player_is_in_scanner_cone))
	{
		level.player_is_in_scanner_cone = 0;
	}

	var_0D = 120;
	var_0E = 1;
	var_0F = var_0E * anglestoforward(self.angles);
	self.scanner_origin = self.origin + (0,0,var_0D) + var_0F;
	self.scanner_tilt = param_09;
	self.sweep_range = param_04;
	self.vertical_cone_range = param_01;
	self.horizontal_cone_range = param_02;
	self.cone_length = param_00;
	self.scanner_offset_from_vehicle_facing = param_03;
	self.fx_target_locked = param_0B;
	self.fx_target_none = param_0C;
	init_scanner_yaw(self.sweep_range);
	thread do_scanner_fx();
	thread do_scanner_sounds();
	var_10 = 0;
	var_11 = 166;
	var_12 = 0;
	var_13 = 102;
	start_sweep_mode_func();
	for(;;)
	{
		var_0F = var_0E * anglestoforward(self.angles);
		self.scanner_origin = self.origin + (0,0,var_0D) + var_0F;
		var_14 = level.player getpointinbounds(0,0,0);
		if(self.scanner_mode == 0)
		{
			update_scanner_yaw_in_sweep_mode(self.scanner_offset_from_vehicle_facing,self.sweep_range,param_05,param_06,param_07,param_08);
			level.player_is_in_scanner_cone = in_scanner_cone(var_14,self.scanner_origin,self.scanner_yaw,self.scanner_tilt,param_00,param_02);
			if(level.player_is_in_scanner_cone)
			{
				common_scripts\utility::flag_set("_stealth_spotted");
				maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
				exit_sweep_mode_func();
				enter_track_player_mode_func();
			}
		}
		else if(self.scanner_mode == 1)
		{
			level.player_is_in_scanner_cone = in_scanner_cone(var_14,self.scanner_origin,self.scanner_yaw,self.scanner_tilt,param_00,param_02);
			if(level.player_is_in_scanner_cone)
			{
				update_scanner_direction_in_track_player_mode(var_14,self.scanner_origin);
			}
			else
			{
				enter_lost_player_mode_func();
			}
		}
		else if(self.scanner_mode == 2)
		{
			if(self.state_timer > 0)
			{
				self.state_timer = self.state_timer - 0.05;
			}
			else
			{
				enter_return_to_sweep_mode_func();
			}
		}
		else if(self.scanner_mode == 3)
		{
			level.player_is_in_scanner_cone = in_scanner_cone(var_14,self.scanner_origin,self.scanner_yaw,self.scanner_tilt,param_00,param_02);
			if(level.player_is_in_scanner_cone)
			{
				maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
				exit_return_to_sweep_mode_func();
				enter_track_player_mode_func();
			}
			else
			{
				var_15 = update_scanner_yaw_returning_to_sweep_mode(self.scanner_offset_from_vehicle_facing,self.sweep_range,param_05,param_09,param_0A);
				if(var_15)
				{
					exit_return_to_sweep_mode_func();
					enter_sweep_mode_func();
				}
			}
		}

		var_10 = var_10 + var_11;
		if(var_10 > 360)
		{
			var_10 = var_10 - 360;
		}

		var_12 = var_12 + var_13;
		if(var_12 > 360)
		{
			var_12 = var_12 - 360;
		}

		if(0)
		{
			draw_scanner_cone(level.player_is_in_scanner_cone,self.scanner_origin,self.scanner_yaw,self.scanner_tilt,var_10,var_12,self.cone_length,self.vertical_cone_range,self.horizontal_cone_range);
		}

		wait(0.05);
	}
}

//Function Number: 37
precache_scanner_turret()
{
	var_00 = "scanner_vrap_turret";
	var_01 = "weapon_pitbull_turret";
	precachemodel(var_01);
	precacheturret(var_00);
}

//Function Number: 38
attach_scanner_turret()
{
	if(!isdefined(level.player_is_in_scanner_cone))
	{
		level.player_is_in_scanner_cone = 0;
	}

	var_00 = "scanner_vrap_turret";
	var_01 = "tag_turret";
	var_02 = "weapon_pitbull_turret";
	var_03 = undefined;
	var_04 = "auto_ai";
	var_05 = 0.2;
	var_06 = 0;
	var_07 = 0;
	var_08 = 0;
	var_09 = spawnturret("misc_turret",(0,0,0),var_00);
	var_09 linkto(self,var_01,(0,0,0),(0,-1 * var_07,0));
	var_09 setmodel(var_02);
	var_09.angles = self.angles;
	var_09.isvehicleattached = 1;
	var_09.ownervehicle = self;
	var_09.script_team = self.script_team;
	var_09 thread maps\_mgturret::burst_fire_unmanned();
	var_09 makeunusable();
	maps\_vehicle_code::set_turret_team(var_09);
	maps\_mgturret::mg42_setdifficulty(var_09,maps\_utility::getdifficulty());
	var_09.script_fireondrones = var_08;
	var_09.deletedelay = var_05;
	var_09.maxrange = var_03;
	var_09 setdefaultdroppitch(var_06);
	var_09 maps\_vehicle_code::turret_set_default_on_mode(var_04);
	var_09 setmode(var_09.defaultonmode);
	var_09 startbarrelspin();
	var_0A = 1.5;
	var_0B = 0.1;
	var_0C = 2;
	for(;;)
	{
		var_0D = var_09 getmode();
		if(level.player_is_in_scanner_cone == 1)
		{
			if(var_0D != "manual")
			{
				self playloopsound("seeker_alarm_lp");
				wait(var_0C);
				self stoploopsound("seeker_alarm_lp");
				var_09 setmode("manual");
				var_09 settargetentity(level.player);
			}

			var_09 waittill("turret_on_target");
			for(var_0E = var_0A;var_0E > 0;var_0E = var_0E - var_0B)
			{
				var_09 shootturret();
				wait(var_0B);
			}
		}
		else if(var_0D != "auto_ai")
		{
			var_09 setmode("auto_ai");
			var_09 cleartargetentity(level.player);
		}

		wait(0.1);
	}
}

//Function Number: 39
start_sweep_mode_func()
{
	self.scanner_mode = 0;
	soundscripts\_snd::snd_message("start_seeker_audio");
	init_scanner_yaw(self.sweep_range);
}

//Function Number: 40
enter_sweep_mode_func()
{
	self.scanner_mode = 0;
	init_scanner_yaw(self.sweep_range);
}

//Function Number: 41
exit_sweep_mode_func()
{
}

//Function Number: 42
enter_track_player_mode_func()
{
	self notify("stop_seeker_audio");
	self.scanner_mode = 1;
	var_00 = level.player.origin;
	if(isdefined(self.script_stealthgroup) && isdefined(level._stealth.group.groups[maps\_utility::string(self.script_stealthgroup)]))
	{
		var_01 = maps\_stealth_shared_utilities::group_get_ai_in_group(maps\_utility::string(self.script_stealthgroup));
		foreach(var_03 in var_01)
		{
			if(var_03 == self)
			{
				continue;
			}

			if(isdefined(var_03.enemy) || isdefined(var_03.favoriteenemy))
			{
				continue;
			}

			var_03 notify("heard_alarm",var_00);
		}
	}
}

//Function Number: 43
enter_lost_player_mode_func()
{
	self.scanner_mode = 2;
	self.state_timer = 2.4;
}

//Function Number: 44
enter_return_to_sweep_mode_func()
{
	soundscripts\_snd::snd_message("start_seeker_audio");
	self.scanner_mode = 3;
}

//Function Number: 45
exit_return_to_sweep_mode_func()
{
}

//Function Number: 46
init_scanner_yaw(param_00)
{
	self.scanner_yaw = -41;
	self.scanner_local_yaw = -0.5 * param_00;
	self.scanner_local_velocity = 0;
	self.scanner_pause_timer = 0;
	self.scanner_sweep_direction = 1;
}

//Function Number: 47
update_scanner_yaw_in_sweep_mode(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0.65;
	if(self.scanner_pause_timer > 0)
	{
		self.scanner_pause_timer = self.scanner_pause_timer - 0.05;
	}
	else if(self.scanner_sweep_direction > 0)
	{
		var_07 = 0.5 * self.scanner_local_velocity * self.scanner_local_velocity / param_04;
		if(self.scanner_local_yaw + var_07 > 0.5 * param_01)
		{
			self.scanner_local_velocity = self.scanner_local_velocity - 0.05 * param_04;
			if(self.scanner_local_velocity < 0)
			{
				self.scanner_local_velocity = 0;
			}
		}
		else
		{
			self.scanner_local_velocity = self.scanner_local_velocity + 0.05 * param_03;
			if(self.scanner_local_velocity > param_02)
			{
				self.scanner_local_velocity = param_02;
			}
		}

		self.scanner_local_yaw = self.scanner_local_yaw + 0.05 * self.scanner_local_velocity;
		if(self.scanner_local_yaw > param_01 * var_06 - 0.5)
		{
			if(!common_scripts\utility::flag("flag_seeker_cone_safe_right"))
			{
				common_scripts\utility::flag_set("flag_seeker_cone_safe_right");
			}
		}

		if(self.scanner_local_velocity <= 0)
		{
			self.scanner_pause_timer = param_05;
			self.scanner_sweep_direction = -1;
			common_scripts\utility::flag_clear("flag_seeker_cone_safe_right");
		}
	}
	else
	{
		var_07 = 0.5 * self.scanner_local_velocity * self.scanner_local_velocity / param_05;
		if(self.scanner_local_yaw - var_07 < -0.5 * param_01)
		{
			self.scanner_local_velocity = self.scanner_local_velocity + 0.05 * param_04;
			if(self.scanner_local_velocity > 0)
			{
				self.scanner_local_velocity = 0;
			}
		}
		else
		{
			self.scanner_local_velocity = self.scanner_local_velocity - 0.05 * param_03;
			if(self.scanner_local_velocity < -1 * param_02)
			{
				self.scanner_local_velocity = -1 * param_02;
			}
		}

		self.scanner_local_yaw = self.scanner_local_yaw + 0.05 * self.scanner_local_velocity;
		if(self.scanner_local_yaw < param_01 * 0.5 - var_06)
		{
			if(!common_scripts\utility::flag("flag_seeker_cone_safe_left"))
			{
				common_scripts\utility::flag_set("flag_seeker_cone_safe_left");
			}
		}

		if(self.scanner_local_velocity >= 0)
		{
			self.scanner_pause_timer = param_05;
			self.scanner_sweep_direction = 1;
			common_scripts\utility::flag_clear("flag_seeker_cone_safe_left");
		}
	}

	var_08 = self.angles[1];
	self.scanner_yaw = var_08 - param_00 + self.scanner_local_yaw;
}

//Function Number: 48
update_scanner_direction_in_track_player_mode(param_00,param_01)
{
	var_02 = param_00 - param_01;
	var_03 = angleclamp360(var_02[1],var_02[0]);
	var_04 = length2d(var_02);
	var_05 = angleclamp360(var_02[2],var_04);
	self.scanner_tilt = var_05;
	self.scanner_yaw = var_03;
}

//Function Number: 49
update_scanner_yaw_returning_to_sweep_mode(param_00,param_01,param_02,param_03,param_04)
{
	self.scanner_pause_timer = 0;
	var_05 = self.angles[1];
	var_06 = var_05 - param_00 - 0.5 * param_01;
	var_07 = var_06 - self.scanner_yaw;
	var_08 = 0;
	if(var_07 > 1)
	{
		self.scanner_yaw = self.scanner_yaw + 0.05 * param_02;
	}
	else if(var_07 < -1)
	{
		self.scanner_yaw = self.scanner_yaw - 0.05 * param_02;
	}
	else
	{
		var_08 = 1;
		self.scanner_yaw = var_06;
	}

	self.scanner_local_yaw = self.scanner_yaw - var_05 + param_00;
	var_09 = param_03 - self.scanner_tilt;
	var_0A = 0;
	if(var_09 > 1)
	{
		self.scanner_tilt = self.scanner_tilt + 0.05 * param_04;
	}
	else if(var_09 < -1)
	{
		self.scanner_tilt = self.scanner_tilt - 0.05 * param_04;
	}
	else
	{
		var_0A = 1;
		self.scanner_tilt = param_03;
	}

	return var_08 && var_0A;
}

//Function Number: 50
yaw_tilt_to_direction_vector(param_00,param_01)
{
	var_02 = cos(param_01);
	return (cos(param_00) * var_02,sin(param_00) * var_02,sin(param_01));
}

//Function Number: 51
line_segment_end_point(param_00,param_01,param_02,param_03)
{
	return param_00 + param_03 * yaw_tilt_to_direction_vector(param_01,param_02);
}

//Function Number: 52
update_vfx_tags(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	param_05.origin = param_00;
	param_06.origin = param_00;
	param_07.origin = param_00;
	param_08.origin = param_00;
	param_09.origin = param_00;
	param_05.angles = vectortoangles(yaw_tilt_to_direction_vector(param_01 - param_04 / 2,param_02 + param_03 / 2));
	param_06.angles = vectortoangles(yaw_tilt_to_direction_vector(param_01 + param_04 / 2,param_02 - param_03 / 2));
	param_07.angles = vectortoangles(yaw_tilt_to_direction_vector(param_01 - param_04 / 2,param_02 - param_03 / 2));
	param_08.angles = vectortoangles(yaw_tilt_to_direction_vector(param_01 + param_04 / 2,param_02 + param_03 / 2));
	param_09.angles = vectortoangles(yaw_tilt_to_direction_vector(param_01,param_02));
}

//Function Number: 53
draw_scanner_cone(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
}

//Function Number: 54
in_scanner_cone(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 - param_01;
	if(lengthsquared(var_06) > param_04 * param_04)
	{
		return 0;
	}

	var_07 = line_segment_end_point(param_01,param_02,param_03,param_04);
	var_08 = var_07 - param_01;
	var_09 = cos(0.5 * param_05);
	if(vectordot(vectornormalize(var_06),vectornormalize(var_08)) <= var_09)
	{
		return 0;
	}

	var_0A = 0;
	var_0B = bullettrace(param_01,param_00,var_0A,self);
	if(var_0B["fraction"] < 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 55
player_looking_in_direction_2d(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.8;
	}

	var_04 = maps\_utility::get_player_from_self();
	var_05 = var_04 geteye();
	var_06 = vectortoangles(param_00 - var_05);
	var_07 = anglestoforward(var_06);
	var_08 = var_04 getplayerangles();
	var_09 = anglestoforward(var_08);
	var_07 = vectornormalize((var_07[0],var_07[1],0));
	var_09 = vectornormalize((var_09[0],var_09[1],0));
	var_0A = vectordot(var_07,var_09);
	if(var_0A < param_01)
	{
		return 0;
	}

	if(isdefined(param_02))
	{
		return 1;
	}

	var_0B = bullettrace(param_00,var_05,0,param_03);
	return var_0B["fraction"] == 1;
}

//Function Number: 56
enable_takedown_hint(param_00,param_01,param_02)
{
	self notify("enable_takedown_hint_called");
	self endon("enable_takedown_hint_called");
	level endon("flag_se_vehicle_takedown_01_failed");
	self endon("takedown_failed");
	var_03 = param_01 * param_01;
	if(!isdefined(level.melee_hint_displayed))
	{
		level.melee_hint_displayed = 0;
	}

	if(!common_scripts\utility::flag_exist("flag_disable_takedown_hint"))
	{
		common_scripts\utility::flag_init("flag_disable_takedown_hint");
	}
	else
	{
		common_scripts\utility::flag_clear("flag_disable_takedown_hint");
	}

	level.melee_pressed = 0;
	level.should_display_melee_hint = 0;
	while(!level.melee_pressed)
	{
		if(common_scripts\utility::flag("flag_disable_takedown_hint"))
		{
			if(level.melee_hint_displayed)
			{
				level.should_display_melee_hint = 0;
			}

			common_scripts\utility::flag_clear("flag_disable_takedown_hint");
			return;
		}

		var_04 = distance2dsquared(param_00.origin,level.player.origin);
		if(level.melee_hint_displayed)
		{
			if(var_04 > var_03 + 10)
			{
				level.should_display_melee_hint = 0;
			}

			if(isdefined(level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1)
			{
				level.should_display_melee_hint = 0;
			}

			if(isdefined(param_02) && param_02)
			{
				var_05 = param_00 geteye();
				var_06 = 0.9;
				if(!level.player player_looking_in_direction_2d(var_05,var_06,1))
				{
					level.should_display_melee_hint = 0;
				}
			}

			continue;
		}

		if(var_04 <= var_03)
		{
			var_07 = 1;
			if(isdefined(level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1)
			{
				var_07 = 0;
			}

			if(isdefined(param_02) && param_02)
			{
				var_05 = param_00 geteye();
				var_06 = 0.9;
				if(!level.player player_looking_in_direction_2d(var_05,var_06,1))
				{
					var_07 = 0;
				}
			}

			if(var_07)
			{
				level.should_display_melee_hint = 1;
				level.melee_hint_displayed = 1;
				level.player allowmelee(0);
				maps\_utility::display_hint_timeout("takedown_hint",undefined);
			}
		}

		wait(0.05);
	}

	self notify("player_completed_takedown");
}

//Function Number: 57
display_takedown_world_prompt_on_enemy(param_00)
{
	level endon("se_takedown_01_failed");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.origin = (-8039,5301,-179);
	while(distance(self.origin,var_01.origin) > 200)
	{
		wait(0.5);
	}

	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02.origin = self.origin + (0,0,52);
	var_02 linkto(self,"tag_origin");
	var_02 thread activate_takedown_world_prompt_on_enemy(param_00);
}

//Function Number: 58
activate_takedown_world_prompt_on_enemy(param_00)
{
	var_01 = maps\_shg_utility::hint_button_tag("melee","tag_origin",100,200);
	common_scripts\utility::waittill_any_ents(param_00,"player_completed_takedown",level,"flag_disable_takedown_hint");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 59
activate_takedown_world_prompt_on_truck_enemy(param_00)
{
	var_01 = maps\_shg_utility::hint_button_tag("melee","j_neck",100,200);
	common_scripts\utility::waittill_any_ents(param_00,"player_completed_takedown",level,"flag_disable_takedown_hint",self,"takedown_failed",level,"flag_se_vehicle_takedown_01_failed");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 60
takedown_hint_off()
{
	var_00 = 0;
	if(level.player meleebuttonpressed())
	{
		level.melee_pressed = 1;
		var_00 = 1;
	}

	if(!level.should_display_melee_hint)
	{
		if(!isdefined(level.player.disable_melee))
		{
			level.player allowmelee(1);
		}

		var_00 = 1;
	}

	if(var_00)
	{
		level.melee_hint_displayed = 0;
		return 1;
	}

	return 0;
}

//Function Number: 61
disable_trigger_while_player_animating(param_00)
{
	level endon(param_00);
	for(;;)
	{
		if(isdefined(level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1)
		{
			if(!isdefined(self.trigger_off))
			{
				common_scripts\utility::trigger_off();
			}
		}
		else if(isdefined(self.trigger_off))
		{
			common_scripts\utility::trigger_on();
		}

		wait(0.05);
	}
}

//Function Number: 62
bloody_death(param_00,param_01)
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

	var_02 = [];
	var_02[0] = "j_hip_le";
	var_02[1] = "j_hip_ri";
	var_02[2] = "j_head";
	var_02[3] = "j_spine4";
	var_02[4] = "j_elbow_le";
	var_02[5] = "j_elbow_ri";
	var_02[6] = "j_clavicle_le";
	var_02[7] = "j_clavicle_ri";
	var_03 = getdvarint("cg_fov");
	for(var_04 = 0;var_04 < 3 + randomint(5);var_04++)
	{
		var_05 = randomintrange(0,var_02.size);
		thread bloody_death_fx(var_02[var_05],undefined);
		wait(randomfloat(0.1));
		if(isdefined(param_01) && isai(param_01) && isalive(param_01))
		{
			if(!level.player worldpointinreticle_circle(param_01.origin,var_03,500))
			{
				param_01 shootblank();
			}
		}
	}

	self dodamage(self.health + 50,self.origin);
}

//Function Number: 63
bloody_death_fx(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level._effect["flesh_hit"];
	}

	playfxontag(param_01,self,param_00);
}

//Function Number: 64
spawn_player_rig(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "player_rig";
	}

	if(!isdefined(param_01))
	{
		param_01 = level.player.origin;
	}

	var_02 = maps\_utility::spawn_anim_model(param_00);
	if(maps\_cloak::is_player_cloaked())
	{
		var_02 maps\_cloak::set_cloak_on_model();
	}

	return var_02;
}

//Function Number: 65
ai_toggle_cloak_animate(param_00,param_01,param_02)
{
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	if(!isdefined(param_02))
	{
		param_02 = self.approachtype;
	}

	var_03 = "";
	if(issubstr(param_02,"right"))
	{
		var_03 = "cornercrouch_right_cloak_toggle";
	}
	else if(issubstr(param_02,"left"))
	{
		var_03 = "cornercrouch_left_cloak_toggle";
	}
	else
	{
		var_03 = "crouch_exposed_cloak_toggle";
	}

	thread maps\lab_vo::ai_toggle_cloak_start_vo(param_00);
	maps\_anim::anim_single_solo(self,var_03);
	wait(1.5);
	maps\_anim::anim_single_solo(self,var_03);
	thread maps\lab_vo::ai_toggle_cloak_complete_vo(param_01);
}

//Function Number: 66
ai_toggle_cloak(param_00)
{
	if(!isdefined(param_00.cloak) || param_00.cloak == "off")
	{
		param_00 thread cloak_on();
		return;
	}

	param_00 cloak_off();
}

//Function Number: 67
activate_trigger_when_player_jumps()
{
	self endon("trigger");
	self endon("death");
	for(;;)
	{
		if(level.player istouching(self) && !level.player isonground())
		{
			self notify("trigger");
		}

		wait(0.05);
	}
}

//Function Number: 68
spawn_metrics_init()
{
	level.spawn_metrics_spawn_count = [];
	level.spawn_metrics_death_count = [];
	maps\_utility::add_global_spawn_function("axis",::spawn_metrics_spawn_func);
	foreach(var_01 in getaiarray("axis"))
	{
		if(!isspawner(var_01) && isalive(var_01))
		{
			var_01 spawn_metrics_spawn_func();
		}
	}
}

//Function Number: 69
spawn_metrics_spawn_func()
{
	if(!isai(self))
	{
		return;
	}

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

//Function Number: 70
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

//Function Number: 71
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

//Function Number: 72
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

//Function Number: 73
spawn_metrics_number_alive(param_00)
{
	return spawn_metrics_number_spawned(param_00) - spawn_metrics_number_died(param_00);
}

//Function Number: 74
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

//Function Number: 75
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

//Function Number: 76
move_hovertank_to_start(param_00)
{
	var_01 = getent("hovertank","targetname");
	var_02 = common_scripts\utility::getstruct(param_00,"script_noteworthy");
	var_01.origin = var_02.origin;
	if(isdefined(var_02.angles))
	{
		var_01.angles = var_02.angles;
	}
}

//Function Number: 77
kill_when_player_not_looking()
{
	self endon("death");
	for(;;)
	{
		if(!maps\_utility::player_looking_at(self.origin))
		{
			bloody_death();
			break;
		}

		wait(1);
	}
}

//Function Number: 78
can_tip_think()
{
	self endon("death");
	var_00 = 200;
	var_01 = 135;
	var_02 = spawn("trigger_radius",self.origin,0,var_00,196);
	var_03 = level.player;
	var_04 = 1;
	var_05 = 0.05;
	var_06 = 1;
	var_07 = 3;
	var_08 = 200;
	var_09 = 300;
	for(;;)
	{
		var_02 waittill("trigger",var_0A);
		if(var_0A != var_03)
		{
			continue;
		}

		var_0B = spawn("script_origin",self.origin);
		var_0B.angles = vectortoangles(self.origin - level.player.origin);
		var_0C = 0;
		if(isdefined(level.player.driving_hovertank))
		{
			var_0C = level.player.driving_hovertank vehicle_getvelocity();
		}
		else
		{
			var_0C = level.player getvelocity();
		}

		var_04 = var_06 + var_07 - var_06 * 1 - length(var_0C) / var_08;
		if(var_04 < var_06)
		{
			var_04 = var_06;
		}
		else if(var_04 > var_07)
		{
			var_04 = var_07;
		}

		self linkto(var_0B);
		var_0B rotateto((var_01,var_0B.angles[1],var_0B.angles[2]),var_04);
		var_0B movez(-1 * var_09,var_04);
		earthquake(0.25,var_04,self.origin,300);
		level.player playrumbleonentity("damage_heavy");
		wait(var_04);
		var_0B delete();
		var_02 delete();
		self delete();
	}
}

//Function Number: 79
script_destructible_tree_think()
{
	var_00 = self;
	self endon("stop_thinking");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(var_02 == level.player)
		{
			break;
		}
	}

	var_00 = spawn("script_model",self.origin);
	if(isdefined(self.angles))
	{
		var_00.angles = self.angles;
	}

	var_00 setmodel("lab_tank_battle_sequoia_02_1b");
	var_06 = spawn("script_model",self.origin + (0,0,96));
	if(isdefined(self.angles))
	{
		var_06.angles = self.angles;
	}

	var_06 setmodel("lab_tank_battle_sequoia_02_1t");
	var_07 = angleclamp360(var_04[1] - var_06.origin[1],var_04[0] - var_06.origin[0]) + 180;
	if(var_07 > 360)
	{
		var_07 = var_07 - 360;
	}

	var_08 = (var_04[0] - var_06.origin[0],var_04[1] - var_06.origin[1],0);
	var_09 = vectortoangles(var_08);
	var_0A = anglestoforward(var_03);
	var_0B = anglestoup(var_03);
	playfx(common_scripts\utility::getfx("tree_explosion"),var_04,var_0A,var_0B);
	var_0C = cos(45);
	var_0D = sin(45);
	var_0E = 10;
	var_0F = 1.5;
	var_10 = 3.5;
	var_11 = randomintrange(var_0E * -1,var_0E);
	var_12 = randomintrange(var_0E * -1,var_0E);
	var_13 = abs(var_11) + abs(var_12);
	var_14 = var_13 / var_0E * 2 * var_10 - var_0F + var_0F;
	var_06 rotateby((var_11,0,var_12),var_14,0,var_14);
}

//Function Number: 80
log_pile_scripted_think()
{
	self setcandamage(1);
	var_00 = 0;
	while(!var_00)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(var_02 != level.player)
		{
			continue;
		}

		common_scripts\utility::flag_set("flag_log_pile_scripted_destroyed");
		soundscripts\_snd::snd_message("log_pile_collapse",self);
		var_00 = 1;
		var_0A = common_scripts\utility::get_target_ent();
		foreach(var_0C in getaiarray("axis"))
		{
			var_0C kill();
			var_0C startragdoll();
		}

		physicsexplosionsphere(self.origin,200,199,50);
		wakeupphysicssphere(self.origin,900);
	}

	self delete();
}

//Function Number: 81
destructible_trailer_collision_think()
{
	self setcandamage(1);
	thread destructible_trailer_collision_destroy_when_player_close();
	var_00 = 0;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(var_05 == "MOD_RIFLE_BULLET" || var_05 == "MOD_ENERGY" || var_01 < 10)
		{
			continue;
		}
		else
		{
			break;
		}
	}

	wakeupphysicssphere(var_04,80);
	physicsexplosionsphere(var_04,80,79,10);
	soundscripts\_snd::snd_message("tank_shack_destruct",var_04);
	self delete();
}

//Function Number: 82
destructible_trailer_collision_destroy_when_player_close()
{
	self endon("death");
	var_00 = 200;
	var_01 = var_00 * var_00;
	var_02 = spawn("trigger_radius",self.origin + (0,0,-100),0,250,300);
	var_02 waittill("trigger",var_03);
	self notify("damage",50,var_03,var_03.origin - self.origin,self.origin,"MOD_EXPLOSIVE");
	earthquake(0.25,0.25,var_03.origin,300);
	var_03 playrumbleonentity("damage_heavy");
}

//Function Number: 83
large_propane_tank_think()
{
	var_00 = self.origin;
	self waittill("death");
	physicsexplosionsphere(var_00,900,850,60);
	wakeupphysicssphere(var_00,900);
}

//Function Number: 84
hovertank_enemy_outline(param_00)
{
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 4;
	}

	thread clear_enemy_outline_on_death();
	self.highlight = 0;
	self.highlight_forced = 0;
	thread manage_highlight(param_00);
	thread highlight_when_weapon_fired(param_00);
	var_01 = (0,0,32);
	if(isai(self))
	{
		hovertank_enemy_outline_ai();
		return;
	}

	hovertank_enemy_outline_vehicle();
}

//Function Number: 85
hovertank_enemy_outline_ai()
{
	self endon("death");
	while(!target_istarget(self))
	{
		wait(0.05);
	}

	for(;;)
	{
		if(target_isincircle(self,level.hovertank_player,75,60))
		{
			self.highlight = 1;
			self notify("highlight_change");
		}
		else
		{
			self.highlight = 0;
			self notify("highlight_change");
		}

		wait(0.05);
	}
}

//Function Number: 86
hovertank_enemy_outline_offset()
{
	var_00 = (0,0,0);
	switch(self.classname)
	{
		case "script_vehicle_xh9_warbird_low_heavy_turret":
		case "script_vehicle_vrap_physics":
		case "script_vehicle_ft101_tank_physics":
			var_00 = (0,0,64);
			break;

		case "script_vehicle_littlebird_atlas_bench":
			var_00 = (0,0,-64);
			break;

		default:
			break;
	}

	return var_00;
}

//Function Number: 87
hovertank_enemy_outline_vehicle()
{
	var_00 = hovertank_enemy_outline_offset();
	for(;;)
	{
		if(level.player worldpointinreticle_circle(self.origin + var_00,75,60))
		{
			self.highlight = 1;
			self notify("highlight_change");
		}
		else
		{
			self.highlight = 0;
			self notify("highlight_change");
		}

		wait(0.05);
	}
}

//Function Number: 88
hovertank_setup_hint_data()
{
	var_00 = gettime();
	var_01 = spawnstruct();
	level.player.hovertank_weapon_hint_data = var_01;
	var_01.kill_counts = [];
	var_01.kill_goals = [];
	var_01.last_hint_times_ms = [];
	var_01.last_kill_times_ms = [];
	var_01.minimum_in_sights_needed = [];
	var_01.amount_in_sights = [];
	var_01.in_sights_timestamp = [];
	var_01.required_aiming_time_s = 2;
	var_01.delay_from_any_hint_s = 5;
	var_01.delay_from_same_hint_s = 15;
	var_01.delay_from_kill_s = 30;
	var_01.higher_priority_expiration_time_s = 2;
	var_01.hint_duration_s = 5;
	var_01.vehicle_sights_radius = 60;
	var_01.kill_goals["emp"] = 2;
	var_01.kill_goals["cannon"] = 2;
	var_01.kill_goals["missile"] = 15;
	var_01.minimum_in_sights_needed["missile"] = 4;
	var_01.amount_in_sights["missile"] = 0;
	var_01.in_sights_timestamp["missile"] = 0;
	var_01.thread_delay_s = 0.1;
	var_01.last_aim_type = "";
	var_01.last_aim_priority = 0;
	var_01.last_aim_time_ms = var_00;
	var_01.current_target_aim_begin_time_ms = var_00;
	var_01.last_hint_time_any_ms = var_00 - var_01.delay_from_any_hint_s * 1000;
	var_02 = [];
	var_02[var_02.size] = "missile";
	var_02[var_02.size] = "cannon";
	var_02[var_02.size] = "emp";
	for(var_03 = 0;var_03 < var_02.size;var_03 = var_03 + 1)
	{
		var_04 = var_02[var_03];
		var_01.kill_counts[var_04] = 0;
		var_01.last_hint_times_ms[var_04] = var_00 - var_01.delay_from_same_hint_s * 1000;
		var_01.last_kill_times_ms[var_04] = var_00 - var_01.delay_from_kill_s * 1000;
		common_scripts\utility::flag_init("hint_proficient_" + var_04);
	}

	level maps\_utility::waittillthread("hovertank_end",::hovertank_destroy_hint_data);
}

//Function Number: 89
hovertank_destroy_hint_data()
{
	level.player.hovertank_weapon_hint_data = undefined;
}

//Function Number: 90
hovertank_hint_enemy_kill_tracking(param_00)
{
	level endon("hovertank_end");
	level endon("hint_proficient_" + param_00);
	if(common_scripts\utility::flag("hint_proficient_" + param_00))
	{
		return;
	}

	self waittill("death",var_01,var_02,var_03);
	if(!isdefined(var_01) || var_01 != level.player)
	{
		return;
	}

	var_04 = 0;
	if(!isdefined(var_03))
	{
		var_04 = 1;
	}
	else
	{
		switch(param_00)
		{
			case "cannon":
				var_04 = issubstr(var_03,"cannon");
				break;

			case "emp":
				var_04 = issubstr(var_03,"antiair");
				break;

			case "missile":
				var_04 = issubstr(var_03,"missile");
				break;

			default:
				var_04 = 0;
				break;
		}
	}

	hovertank_hint_stop(param_00);
	if(var_04)
	{
		var_05 = level.player.hovertank_weapon_hint_data;
		var_05.kill_counts[param_00] = var_05.kill_counts[param_00] + 1;
		var_05.last_kill_times_ms[param_00] = gettime();
		if(var_05.kill_counts[param_00] >= var_05.kill_goals[param_00])
		{
			common_scripts\utility::flag_set("hint_proficient_" + param_00);
		}
	}
}

//Function Number: 91
hovertank_aimed_enemy_vehicle_weapon_hint(param_00,param_01)
{
	hovertank_aimed_enemy_weapon_hint(param_00,param_01,::hovertank_hint_vehicle_in_sights);
}

//Function Number: 92
hovertank_aimed_enemy_ai_weapon_hint(param_00,param_01)
{
	hovertank_aimed_enemy_weapon_hint(param_00,param_01,::hovertank_hint_ai_in_sights);
}

//Function Number: 93
hovertank_aimed_enemy_weapon_hint(param_00,param_01,param_02)
{
	self endon("death");
	level endon("hovertank_end");
	level endon("hint_proficient_" + param_01);
	if(!isdefined(level.player.hovertank_weapon_hint_data))
	{
		return;
	}

	var_03 = level.player.hovertank_weapon_hint_data;
	thread hovertank_hint_enemy_kill_tracking(param_01);
	if(common_scripts\utility::flag("hint_proficient_" + param_01))
	{
		return;
	}

	for(;;)
	{
		var_04 = gettime();
		var_05 = var_03.last_aim_priority > param_00;
		var_06 = var_04 - var_03.last_aim_time_ms > var_03.higher_priority_expiration_time_s * 1000;
		var_07 = param_01 == var_03.last_aim_type && var_04 - var_03.last_aim_time_ms <= var_03.thread_delay_s * 1000 && !isdefined(var_03.minimum_in_sights_needed[param_01]);
		if(!var_07 && !var_05 || var_06 && [[ param_02 ]]())
		{
			var_03.last_aim_time_ms = var_04;
			var_03.last_aim_priority = param_00;
			var_08 = 1;
			if(isdefined(var_03.minimum_in_sights_needed[param_01]))
			{
				if(var_04 - var_03.in_sights_timestamp[param_01] < var_03.thread_delay_s * 1000)
				{
					var_03.amount_in_sights[param_01] = var_03.amount_in_sights[param_01] + 1;
				}
				else
				{
					var_03.in_sights_timestamp[param_01] = var_04;
					var_03.amount_in_sights[param_01] = 1;
				}

				var_08 = var_03.amount_in_sights[param_01] == var_03.minimum_in_sights_needed[param_01];
			}

			if(param_01 == var_03.last_aim_type)
			{
				if(var_08)
				{
					if(var_06)
					{
						var_03.current_target_aim_begin_time_ms = var_04;
					}

					var_09 = var_04 - var_03.current_target_aim_begin_time_ms > var_03.required_aiming_time_s * 1000;
					var_0A = var_04 - var_03.last_kill_times_ms[param_01] < var_03.delay_from_kill_s * 1000;
					var_0B = var_04 - var_03.last_hint_times_ms[param_01] < var_03.delay_from_same_hint_s * 1000 || var_04 - var_03.last_hint_time_any_ms < var_03.delay_from_any_hint_s * 1000;
					if(var_09 && !var_0B && !var_0A)
					{
						hovertank_weapon_hint(param_01);
					}
				}
			}
			else
			{
				var_03.last_aim_type = param_01;
				var_03.current_target_aim_begin_time_ms = var_04;
			}
		}

		wait(var_03.thread_delay_s);
	}
}

//Function Number: 94
hovertank_hint_vehicle_in_sights()
{
	var_00 = hovertank_enemy_outline_offset();
	if(!level.player worldpointinreticle_circle(self.origin + var_00,75,level.player.hovertank_weapon_hint_data.vehicle_sights_radius))
	{
		return 0;
	}

	var_01 = level.player geteye();
	var_02 = sighttracepassed(self.origin + var_00,var_01,0,self,level.player);
	return var_02;
}

//Function Number: 95
hovertank_hint_ai_in_sights()
{
	return self.highlight;
}

//Function Number: 96
manage_highlight(param_00)
{
	self endon("death");
	self endon("end_highlight");
	level endon("hovertank_end");
	thread manage_highlight_end();
	for(;;)
	{
		self waittill("highlight_change");
		if(self.highlight || self.highlight_forced)
		{
			self hudoutlineenable(param_00,1);
			continue;
		}

		if(!self.highlight_forced)
		{
			self hudoutlinedisable();
			self hudoutlineenable(0,0);
		}
	}
}

//Function Number: 97
manage_highlight_end()
{
	self endon("death");
	self endon("hovertank_end");
	self waittill("end_highlight");
	turn_off_highlight();
}

//Function Number: 98
highlight_when_weapon_fired(param_00)
{
	self endon("death");
	level endon("hovertank_end");
	var_01 = 3;
	for(;;)
	{
		common_scripts\utility::waittill_any("shooting","weapon_fired");
		thread force_highlight(param_00,var_01);
	}
}

//Function Number: 99
force_highlight(param_00,param_01)
{
	self endon("death");
	level endon("hovertank_end");
	self endon("end_highlight");
	self notify("force_highlight");
	self endon("force_highlight");
	self.highlight_forced = 1;
	wait(param_01);
	self.highlight_forced = 0;
}

//Function Number: 100
turn_on_highlight(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self.highlight_forced = 1;
		var_02 = 0;
		var_03 = 0.05;
		while(var_02 < param_01)
		{
			self hudoutlineenable(param_00,1);
			self.highlight = 1;
			var_02 = var_02 + var_03;
			wait(var_03);
		}

		self hudoutlinedisable();
		self hudoutlineenable(0,0);
		self.highlight = 0;
		self.highlight_forced = 0;
		return;
	}

	if(!self.highlight)
	{
		self hudoutlineenable(param_00,1);
		self.highlight = 1;
	}
}

//Function Number: 101
turn_off_highlight()
{
	if(self.highlight || self.highlight_forced)
	{
		self hudoutlinedisable();
		self hudoutlineenable(0,0);
	}
}

//Function Number: 102
clear_enemy_outline_on_death()
{
	common_scripts\utility::waittill_any_ents(self,"death",level,"hovertank_end");
	if(isdefined(self))
	{
		self hudoutlinedisable();
		self hudoutlineenable(0,0);
	}
}

//Function Number: 103
warbird_heavy_shooting_think(param_00)
{
	level.player endon("death");
	self endon("death");
	self.mgturret[0] setmode("manual");
	self.mgturret[1] setmode("manual");
	if(!maps\_utility::ent_flag_exist("fire_turrets"))
	{
		maps\_utility::ent_flag_init("fire_turrets");
	}

	maps\_utility::ent_flag_set("fire_turrets");
	thread warbird_heavy_fire_monitor();
	for(;;)
	{
		self waittill("warbird_fire");
		maps\_utility::ent_flag_set("fire_turrets");
		thread warbird_heavy_fire(param_00);
		self waittill("warbird_stop_firing");
		maps\_utility::ent_flag_clear("fire_turrets");
	}
}

//Function Number: 104
warbird_heavy_fire(param_00)
{
	self endon("death");
	var_01 = self.mgturret[0];
	var_02 = self.mgturret[1];
	var_01 notify("stop_burst_fire_unmanned");
	var_02 notify("stop_burst_fire_unmanned");
	var_03 = 0.4;
	var_04 = var_03 / 2;
	var_01 thread burst_fire_warbird(var_03,0);
	var_02 thread burst_fire_warbird(var_03,var_04);
	var_05 = common_scripts\utility::get_enemy_team(self.script_team);
	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_06 = getaiarray(var_05);
		if(isdefined(level.flying_attack_drones))
		{
			var_07 = level.flying_attack_drones;
		}
		else
		{
			var_07 = [];
		}

		if(isdefined(level.drones) && isdefined(level.drones[var_05].array))
		{
			var_06 = common_scripts\utility::array_combine(var_06,level.drones[var_05].array);
		}

		if(var_05 == level.player.team)
		{
			var_06 = common_scripts\utility::array_add(var_06,level.player);
		}

		var_06 = common_scripts\utility::array_combine(var_06,var_07);
		var_08 = [];
		foreach(var_0A in var_06)
		{
			if(isdefined(var_0A.ignoreme) && var_0A.ignoreme)
			{
				continue;
			}
			else
			{
				var_08[var_08.size] = var_0A;
			}
		}

		var_08 = sortbydistance(var_08,self.origin);
		var_0C = undefined;
		foreach(var_0A in var_08)
		{
			if(!isdefined(var_0A))
			{
				continue;
			}

			if(!isalive(var_0A))
			{
				continue;
			}

			if(isdefined(param_00) && param_00)
			{
				var_0E = self.mgturret[0] gettagorigin("tag_flash");
				var_0F = var_0A geteye();
				var_10 = vectornormalize(var_0F - var_0E);
				var_11 = var_0E + var_10 * 20;
				if(!sighttracepassed(var_11,var_0F,0,var_0A,self.mgturret[0]))
				{
					continue;
				}
			}

			var_0C = var_0A;
			break;
		}

		if(isdefined(var_0C))
		{
			var_01 settargetentity(var_0C);
			var_02 settargetentity(var_0C);
			var_01 turretfireenable();
			var_02 turretfireenable();
			var_01 startfiring();
			var_02 startfiring();
			wait_for_warbird_fire_target_done(var_0C,param_00);
			var_01 notify("stop_firing");
			var_02 notify("stop_firing");
			var_01 cleartargetentity();
			var_02 cleartargetentity();
			var_01 turretfiredisable();
			var_02 turretfiredisable();
		}

		wait(0.05);
	}

	var_01 turretfiredisable();
	var_02 turretfiredisable();
}

//Function Number: 105
warbird_heavy_fire_monitor()
{
	self endon("death");
	self waittill("warbird_stop_firing");
	maps\_utility::ent_flag_clear("fire_turrets");
}

//Function Number: 106
burst_fire_warbird(param_00,param_01)
{
	self endon("death");
	self endon("stop_burst_fire_warbird");
	var_02 = 1;
	var_03 = 1;
	var_04 = 1;
	var_05 = 1;
	var_06 = gettime();
	var_07 = "start";
	for(;;)
	{
		var_08 = var_06 - gettime() * 0.001;
		if(self isfiringturret() && var_08 <= 0)
		{
			if(var_07 != "fire")
			{
				var_07 = "fire";
				thread doshoottuned(param_00,param_01);
			}

			var_08 = var_04 + randomfloat(var_05);
			thread turrettimer(var_08);
			self waittill("turretstatechange");
			var_08 = var_02 + randomfloat(var_03);
			var_06 = gettime() + int(var_08 * 1000);
			continue;
		}

		if(var_07 != "aim")
		{
			var_07 = "aim";
		}

		thread turrettimer(var_08);
		self waittill("turretstatechange");
	}
}

//Function Number: 107
doshoottuned(param_00,param_01)
{
	self endon("death");
	self endon("turretstatechange");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	for(;;)
	{
		self shootturret();
		wait(param_00);
	}
}

//Function Number: 108
turrettimer(param_00)
{
	if(param_00 <= 0)
	{
		return;
	}

	self endon("turretstatechange");
	wait(param_00);
	if(isdefined(self))
	{
		self notify("turretstatechange");
	}
}

//Function Number: 109
destroy_self_when_nuked()
{
	self endon("death");
	for(;;)
	{
		if(getdvar("debug_nuke") == "on")
		{
			self dodamage(self.health + 99999,(0,0,-500),level.player);
		}

		wait(0.05);
	}
}

//Function Number: 110
delete_on_notify(param_00,param_01)
{
	param_00 waittill(param_01);
	self delete();
}

//Function Number: 111
trigger_spawn_and_set_flag_think()
{
	var_00 = undefined;
	if(isdefined(self.script_flag))
	{
		var_00 = self.script_flag;
		if(!isdefined(level.flag[var_00]))
		{
			common_scripts\utility::flag_init(var_00);
		}
	}

	self waittill("trigger",var_01);
	if(isdefined(self.script_delay))
	{
		maps\_utility::script_delay();
	}

	if(isdefined(var_00))
	{
		common_scripts\utility::flag_set(var_00,var_01);
	}

	var_02 = getentarray(self.target,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(var_05.code_classname == "script_vehicle")
		{
			if((isdefined(var_05.script_moveoverride) && var_05.script_moveoverride == 1) || !isdefined(var_05.target))
			{
				var_03[var_03.size] = maps\_vehicle::vehicle_spawn(var_05);
			}
			else
			{
				var_03[var_03.size] = var_05 maps\_vehicle::spawn_vehicle_and_gopath();
			}

			continue;
		}

		var_05 thread maps\_spawner::trigger_spawner_spawns_guys();
	}

	if(var_03.size > 0)
	{
		thread tank_section_vehicles_spawned(var_03,var_00);
	}
}

//Function Number: 112
trigger_set_and_clear_flag_think()
{
	var_00 = undefined;
	if(isdefined(self.script_flag))
	{
		var_00 = self.script_flag;
		if(!isdefined(level.flag[var_00]))
		{
			common_scripts\utility::flag_init(var_00);
		}
	}

	var_01 = undefined;
	if(isdefined(self.script_flag_clear))
	{
		var_01 = self.script_flag_clear;
		if(!isdefined(level.flag[var_01]))
		{
			common_scripts\utility::flag_init(var_01);
		}
	}

	for(;;)
	{
		self waittill("trigger",var_02);
		if(isdefined(self.script_delay))
		{
			maps\_utility::script_delay();
		}

		if(isdefined(var_00))
		{
			common_scripts\utility::flag_set(var_00,var_02);
		}

		if(isdefined(var_01))
		{
			common_scripts\utility::flag_clear(var_01);
		}

		wait(0.05);
	}
}

//Function Number: 113
tank_section_vehicles_spawned(param_00,param_01)
{
	soundscripts\_snd::snd_message("aud_tank_section_vehicles_spawned",param_00,param_01);
	if(isdefined(param_01))
	{
		switch(param_01)
		{
			case "flag_tank_road_enemy_tank":
				thread maps\lab_vo::tank_road_enemy_tank_dialogue(param_00[0]);
				break;

			case "flag_tank_field_warbird_and_littlebird":
				var_02 = [];
				foreach(var_04 in param_00)
				{
					if(!issubstr(var_04.classname,"vrap"))
					{
						var_02[var_02.size] = var_04;
					}
				}
	
				thread maps\lab_vo::tank_field_choppers_dialogue(var_02);
				break;

			default:
				break;
		}
	}
}

//Function Number: 114
right_swing_pressed()
{
	var_00 = "BUTTON_RTRIG";
	if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		return level.player adsbuttonpressed(1);
	}

	return level.player buttonpressed(var_00);
}

//Function Number: 115
left_swing_pressed()
{
	var_00 = "BUTTON_LTRIG";
	if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		return level.player attackbuttonpressed();
	}

	return level.player buttonpressed(var_00);
}

//Function Number: 116
break_left_climb_hint()
{
	if(common_scripts\utility::flag("flag_cloak_fail_kill_player"))
	{
		return 1;
	}

	if(isdefined(level.player.waiting_on_left_swing) && level.player.waiting_on_left_swing == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 117
break_right_climb_hint()
{
	if(common_scripts\utility::flag("flag_cloak_fail_kill_player"))
	{
		return 1;
	}

	if(isdefined(level.player.waiting_on_right_swing) && level.player.waiting_on_right_swing == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 118
break_both_climb_hint()
{
	if(isdefined(level.player.waiting_on_left_swing) && level.player.waiting_on_left_swing == 0 && isdefined(level.player.waiting_on_right_swing) && level.player.waiting_on_right_swing == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 119
get_rt_button_info()
{
	if(!level.player usinggamepad())
	{
		return "ads";
	}

	var_00 = getbuttonsconfig();
	if(issubstr(getbuttonsconfig(),"lefty"))
	{
		if(level.ps3 || issubstr(var_00,"alt"))
		{
			return "smoke";
		}

		return "ads";
	}

	if(issubstr(var_00,"nomad"))
	{
		if(level.ps3 || issubstr(var_00,"alt"))
		{
			return "ads";
		}

		return "rt";
	}

	if(level.ps3 || issubstr(var_00,"alt"))
	{
		return "rb";
	}

	return "rt";
}

//Function Number: 120
get_lt_button_info()
{
	var_00 = getbuttonsconfig();
	if(!level.player usinggamepad())
	{
		return "attack";
	}

	if(issubstr(var_00,"lefty"))
	{
		if(level.ps3 || issubstr(var_00,"alt"))
		{
			return "frag";
		}

		return "attack";
	}

	if(issubstr(var_00,"nomad"))
	{
		if(level.ps3 || issubstr(var_00,"alt"))
		{
			return "lb";
		}

		return "frag";
	}

	if(level.ps3 || issubstr(var_00,"alt"))
	{
		return "lb";
	}

	return "lt";
}

//Function Number: 121
wait_until_right_swing_pressed(param_00)
{
	level.player.waiting_on_right_swing = 1;
	var_01 = maps\_shg_utility::hint_button_position(get_rt_button_info(),param_00,0);
	for(;;)
	{
		if(right_swing_pressed())
		{
			level.player.waiting_on_right_swing = 0;
			var_01 maps\_shg_utility::hint_button_clear();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 122
wait_until_left_swing_pressed(param_00)
{
	level.player.waiting_on_left_swing = 1;
	var_01 = maps\_shg_utility::hint_button_position(get_lt_button_info(),param_00,0);
	for(;;)
	{
		if(left_swing_pressed())
		{
			level.player.waiting_on_left_swing = 0;
			var_01 maps\_shg_utility::hint_button_clear();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 123
wait_until_next_right_swing(param_00)
{
	level.player.waiting_on_right_swing = 1;
	var_01 = maps\_shg_utility::hint_button_position(get_rt_button_info(),param_00,0);
	for(;;)
	{
		if(isdefined(level.player.right_swing_released) && level.player.right_swing_released == 1 && right_swing_pressed())
		{
			level.player.waiting_on_right_swing = 0;
			var_01 maps\_shg_utility::hint_button_clear();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 124
wait_until_next_left_swing(param_00)
{
	level.player.waiting_on_left_swing = 1;
	var_01 = maps\_shg_utility::hint_button_position(get_lt_button_info(),param_00,0);
	for(;;)
	{
		if(isdefined(level.player.left_swing_released) && level.player.left_swing_released == 1 && left_swing_pressed())
		{
			level.player.waiting_on_left_swing = 0;
			var_01 maps\_shg_utility::hint_button_clear();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 125
monitor_right_swing_released()
{
	level.player.right_swing_released = 0;
	for(;;)
	{
		if(!right_swing_pressed())
		{
			level.player.right_swing_released = 1;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 126
monitor_left_swing_released()
{
	level.player.left_swing_released = 0;
	for(;;)
	{
		if(!left_swing_pressed())
		{
			level.player.left_swing_released = 1;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 127
wait_until_both_swings_pressed()
{
	level.player.waiting_on_left_swing = 1;
	level.player.waiting_on_right_swing = 1;
	maps\_utility::hintdisplayhandler("both_climb_hint");
	level.current_hint.font = "buttonprompt";
	for(;;)
	{
		if(left_swing_pressed() && right_swing_pressed())
		{
			level.player.waiting_on_left_swing = 0;
			level.player.waiting_on_right_swing = 0;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 128
set_helmet_open(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	self setanimknobrestart(%sentinel_covert_helmet_open_idle,1,param_00);
}

//Function Number: 129
set_helmet_closed(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	self setanimknobrestart(%sentinel_covert_helmet_closed_idle,1,param_00);
}

//Function Number: 130
clear_additive_helmet_anim(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	self clearanim(%s1_helmet,0);
}

//Function Number: 131
prep_cinematic(param_00)
{
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame(param_00,1);
	level.current_cinematic = param_00;
}

//Function Number: 132
play_cinematic(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		soundscripts\_audio::deprecated_aud_send_msg("begin_cinematic",param_00);
	}

	if(isdefined(level.current_cinematic))
	{
		pausecinematicingame(0);
		setsaveddvar("cg_cinematicFullScreen","1");
		level.current_cinematic = undefined;
	}
	else
	{
		cinematicingame(param_00);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","1");
	}

	wait(1);
	while(iscinematicplaying())
	{
		wait(0.05);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","0");
	}

	if(!isdefined(param_01))
	{
		soundscripts\_audio::deprecated_aud_send_msg("end_cinematic",param_00);
	}
}

//Function Number: 133
ending_fade_out(param_00)
{
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01.sort = -10;
	var_01 setshader("black",640,480);
	if(isdefined(param_00) && param_00 > 0)
	{
		var_01.alpha = 0;
		var_01 fadeovertime(param_00);
		var_01.alpha = 1;
		wait(param_00);
	}

	waittillframeend;
}

//Function Number: 134
destructible_boxtruck_think()
{
	self setcandamage(1);
	self.health = 500;
	while(self.health > 0)
	{
		self waittill("damage",var_00,var_01);
		if(var_01 != level.player)
		{
			self.health = self.health + var_00;
		}
	}

	self setmodel("vehicle_civ_boxtruck_destroyed");
	soundscripts\_snd::snd_message("boxtruck_explode");
	playfx(common_scripts\utility::getfx("boxcar_explosion"),self.origin);
}

//Function Number: 135
hovertank_weapon_hint(param_00)
{
	var_01 = undefined;
	var_02 = "";
	switch(param_00)
	{
		case "missile":
			var_01 = ::hovertank_missile_hint_off;
			var_02 = "hovertank_missile_hint";
			break;

		case "cannon":
			var_01 = ::hovertank_cannon_hint_off;
			var_02 = "hovertank_cannon_hint";
			break;

		case "emp":
			var_01 = ::hovertank_emp_hint_off;
			var_02 = "hovertank_emp_hint";
			break;

		default:
			break;
	}

	if([[ var_01 ]]())
	{
		return;
	}

	var_03 = gettime();
	maps\_utility::hintdisplayhandler(var_02,level.player.hovertank_weapon_hint_data.hint_duration_s);
	level.player.hovertank_weapon_hint_data.last_hint_times_ms[param_00] = var_03;
	level.player.hovertank_weapon_hint_data.last_hint_time_any_ms = var_03;
}

//Function Number: 136
hovertank_hint_stop(param_00)
{
	common_scripts\utility::flag_set("flag_stop_hint_" + param_00);
	thread hovertank_hint_reset_flag(param_00);
}

//Function Number: 137
hovertank_hint_reset_flag(param_00)
{
	wait(0.5);
	common_scripts\utility::flag_clear("flag_stop_hint_" + param_00);
}

//Function Number: 138
hovertank_missile_hint_off()
{
	var_00 = common_scripts\utility::flag("flag_stop_hint_missile");
	return issubstr(vehicle_scripts\_hovertank::get_current_weapon_name(),"missile") || common_scripts\utility::flag("flag_se_hovertank_exit") || var_00;
}

//Function Number: 139
hovertank_cannon_hint_off()
{
	var_00 = common_scripts\utility::flag("flag_stop_hint_cannon");
	return issubstr(vehicle_scripts\_hovertank::get_current_weapon_name(),"cannon") || common_scripts\utility::flag("flag_se_hovertank_exit") || var_00;
}

//Function Number: 140
hovertank_emp_hint_off()
{
	var_00 = common_scripts\utility::flag("flag_stop_hint_emp");
	return issubstr(vehicle_scripts\_hovertank::get_current_weapon_name(),"antiair") || common_scripts\utility::flag("flag_se_hovertank_exit") || var_00;
}

//Function Number: 141
ai_kill_when_out_of_sight(param_00,param_01)
{
	param_00 endon("death");
	var_02 = 0.75;
	for(;;)
	{
		wait(1);
		if(maps\_utility::players_within_distance(param_01,param_00.origin))
		{
			continue;
		}

		if(maps\_utility::either_player_looking_at(param_00.origin + (0,0,48),var_02,1))
		{
			continue;
		}

		param_00 kill();
	}
}

//Function Number: 142
detection_highlight_hud_effect(param_00,param_01,param_02)
{
	var_03 = newhudelem();
	if(isdefined(param_02) && param_02)
	{
		var_03.color = (0.1,0,0);
	}
	else
	{
		var_03.color = (1,0,0);
	}

	var_03.alpha = 0.05;
	var_03 setradarhighlight(param_01);
	wait(param_01);
	if(isdefined(var_03))
	{
		var_03 destroy();
	}
}

//Function Number: 143
notify_on_flag(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_00);
	self notify(param_01);
}

//Function Number: 144
disable_grenades()
{
	if(isdefined(self.grenadeammo) && !isdefined(self.oldgrenadeammo))
	{
		self.oldgrenadeammo = self.grenadeammo;
	}

	self.grenadeammo = 0;
}

//Function Number: 145
enable_grenades()
{
	if(isdefined(self.oldgrenadeammo))
	{
		self.grenadeammo = self.oldgrenadeammo;
		self.oldgrenadeammo = undefined;
	}
}

//Function Number: 146
equip_microwave_grenade()
{
	self.grenadeweapon = "microwave_grenade";
	self.grenadeammo = 2;
}

//Function Number: 147
random_move_rate_blend()
{
	self endon("death");
	var_00 = randomfloatrange(0.5,1);
	var_01 = randomfloatrange(0,3);
	var_02 = 0;
	while(var_02 <= var_01)
	{
		var_03 = maps\_utility::linear_interpolate(var_02 / var_01,var_00,1);
		self.moveplaybackrate = var_03;
		var_02 = var_02 + 0.05;
		wait(0.05);
	}
}

//Function Number: 148
monitor_out_of_bounds_areas(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	level.player_out_of_bounds_warning = 0;
	thread maps\lab_vo::player_out_of_bounds_warning_vo();
	var_01 = 0.1;
	var_02 = getentarray("out_of_bounds_warning","targetname");
	var_03 = getentarray("out_of_bounds_mission_fail","targetname");
	if(param_00)
	{
		thread debug_out_of_bounds_areas();
	}

	for(;;)
	{
		level.player_out_of_bounds_warning = 0;
		foreach(var_05 in var_02)
		{
			if(level.player istouching(var_05))
			{
				level.player_out_of_bounds_warning = 1;
			}

			if(param_00)
			{
				common_scripts\utility::draw_trigger(var_05,var_01,(1,0.5,0));
			}
		}

		level.player_out_of_bounds_mission_fail = 0;
		foreach(var_05 in var_03)
		{
			if(level.player istouching(var_05))
			{
				level.player_out_of_bounds_mission_fail = 1;
				setdvar("ui_deadquote",&"LAB_DEADQUOTE_ABANDONED_BURKE");
				level.player freezecontrols(1);
				thread maps\_utility::missionfailedwrapper();
			}

			if(param_00)
			{
				common_scripts\utility::draw_trigger(var_05,var_01,(1,0,0));
			}
		}

		wait(var_01);
	}
}

//Function Number: 149
debug_out_of_bounds_areas()
{
	var_00 = newhudelem();
	var_00.x = 250;
	var_00.y = 200;
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.fontscale = 2;
	var_00 settext("");
	var_01 = 0.1;
	for(;;)
	{
		if(isdefined(level.player_out_of_bounds_mission_fail) && level.player_out_of_bounds_mission_fail)
		{
			var_00 settext("Mission failed.");
		}
		else if(isdefined(level.player_out_of_bounds_warning) && level.player_out_of_bounds_warning)
		{
			var_00 settext("Warning!  You are out of bounds!");
		}
		else
		{
			var_00 settext("");
		}

		wait(var_01);
	}
}

//Function Number: 150
flag_wait_any_or_timeout(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 * 1000;
	var_07 = gettime();
	var_08 = [];
	if(isdefined(param_01))
	{
		var_08[var_08.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_08[var_08.size] = param_02;
	}

	if(isdefined(param_03))
	{
		var_08[var_08.size] = param_03;
	}

	if(isdefined(param_04))
	{
		var_08[var_08.size] = param_04;
	}

	if(isdefined(param_05))
	{
		var_08[var_08.size] = param_05;
	}

	for(;;)
	{
		foreach(var_0A in var_08)
		{
			if(common_scripts\utility::flag_exist(var_0A) && common_scripts\utility::flag(var_0A))
			{
				break;
			}
		}

		if(gettime() >= var_07 + var_06)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 151
player_stance_monitor()
{
	var_00 = 0;
	var_01 = "";
	var_02 = "";
	var_03 = 0;
	for(;;)
	{
		var_02 = level.player getstance();
		if(var_02 == "prone" && var_02 != var_01)
		{
			var_01 = var_02;
			iprintln("player prone");
			var_00 = var_00 + 15;
		}

		if(var_02 == "crouch" && var_02 != var_01)
		{
			var_01 = var_02;
			iprintln("player crouch");
			var_00 = var_00 + 30;
		}

		if(var_02 == "stand" && var_02 != var_01)
		{
			var_01 = var_02;
			iprintln("player stand");
			var_00 = var_00 + 40;
		}

		while(level.player isjumping())
		{
			if(!var_03)
			{
				iprintln("player jumping");
				var_00 = var_00 + 75;
			}

			var_03 = 1;
			wait(0.05);
		}

		var_03 = 0;
		wait(0.05);
	}
}

//Function Number: 152
player_exo_monitor()
{
	if(isdefined(level.start_point))
	{
		switch(level.start_point)
		{
			case "tank_ascent":
			case "tank_field_right_fork":
			case "tank_field_left_fork":
			case "tank_field":
			case "tank_road":
				break;

			default:
				break;
		}
	}

	common_scripts\utility::flag_wait("flag_player_exo_enabled");
	maps\_player_exo::player_exo_activate();
}

//Function Number: 153
player_falling_to_death()
{
	level endon("flag_rappel_start");
	common_scripts\utility::flag_wait("player_falling_to_death");
	setdvar("ui_deadquote","");
	level.player takeallweapons();
	var_00 = gettime() + 1000;
	while(!level.player isonground() && gettime() < var_00)
	{
		wait(0.05);
	}

	if(level.player isonground())
	{
		level.player kill();
		return;
	}

	maps\_utility::missionfailedwrapper();
}

//Function Number: 154
magic_bullet_strafe(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = 0;
	var_0B = param_02 - param_00;
	var_0C = param_03 - param_01;
	var_0D = 0;
	var_0E = 1 / param_05;
	var_0F = param_05 / param_04;
	var_10 = 0;
	for(var_11 = param_07;var_0D < param_04;var_11 = min(var_18 + param_07,param_05 - var_0A))
	{
		if(var_10 != var_11)
		{
			var_12 = randomfloatrange(var_10,var_11);
		}
		else
		{
			var_12 = var_10;
		}

		if(var_12 > 0)
		{
			wait(var_12);
			var_0A = var_0A + var_12;
		}

		var_13 = param_01 + var_0C * var_0E * var_0A;
		var_14 = param_00 + var_0B * var_0D / param_04 - 1;
		if(param_06 > 0)
		{
			var_15 = randomfloat(param_06);
			var_16 = (0,randomfloat(360),0);
			var_14 = var_14 + anglestoforward(var_16) * var_15;
		}

		if(isdefined(param_09))
		{
			magicbullet(param_08,var_13,var_14,param_09);
		}
		else
		{
			var_17 = magicbullet(param_08,var_13,var_14);
			var_17 soundscripts\_snd::snd_message("lab_exfil_missile_strike");
		}

		var_0D++;
		var_18 = var_0D * var_0F - var_0A;
		var_10 = max(0,var_18 - param_07);
	}
}

//Function Number: 155
named_magic_bullet_strafe(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = maps\_utility::getent_or_struct(param_00 + "_source_start","targetname");
	var_08 = maps\_utility::getent_or_struct(param_00 + "_source_end","targetname");
	var_09 = maps\_utility::getent_or_struct(param_00 + "_target_start","targetname");
	var_0A = maps\_utility::getent_or_struct(param_00 + "_target_end","targetname");
	if(!isdefined(var_07) || !isdefined(var_08) || !isdefined(var_09) || !isdefined(var_0A))
	{
		return;
	}

	magic_bullet_strafe(var_09.origin,var_07.origin,var_0A.origin,var_08.origin,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 156
rumble_light()
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 157
rumble_light_1()
{
	level.player playrumbleonentity("light_1s");
}

//Function Number: 158
rumble_light_2()
{
	level.player playrumbleonentity("light_2s");
}

//Function Number: 159
rumble_light_3()
{
	level.player playrumbleonentity("light_3s");
}

//Function Number: 160
rumble_heavy()
{
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 161
rumble_heavy_1()
{
	level.player playrumbleonentity("heavy_1s");
}

//Function Number: 162
rumble_heavy_2()
{
	level.player playrumbleonentity("heavy_2s");
}

//Function Number: 163
rumble_heavy_3()
{
	level.player playrumbleonentity("heavy_3s");
}

//Function Number: 164
setup_level_rumble_ent()
{
	if(!isdefined(level.rumble_ent))
	{
		level.rumble_ent = maps\_utility::get_rumble_ent("steady_rumble",0);
	}

	level.rumble_ent.intensity = 0;
}

//Function Number: 165
rumble_set_ent_rumble_intensity_for_time(param_00,param_01,param_02)
{
	param_00.intensity = param_01;
	wait(param_02);
	param_00.intensity = 0;
}

//Function Number: 166
play_rumble_on_entity(param_00,param_01)
{
	param_00 playrumbleonentity(param_01);
}