/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 87
 * Decompile Time: 1283 ms
 * Timestamp: 4/22/2024 2:29:29 AM
*******************************************************************/

//Function Number: 1
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

//Function Number: 2
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

//Function Number: 3
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

//Function Number: 11
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

//Function Number: 12
waittill_notify_func(param_00,param_01,param_02,param_03)
{
	self waittill(param_00);
	if(isdefined(param_03))
	{
		self [[ param_01 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		self [[ param_01 ]](param_02);
		return;
	}

	self [[ param_01 ]]();
}

//Function Number: 13
player_animated_sequence_restrictions(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		level.player waittill("notify_player_animated_sequence_restrictions");
	}

	level.player.disablereload = 1;
	level.player disableweapons();
	level.player disableoffhandweapons();
	level.player disableweaponswitch();
	level.player allowcrouch(0);
	level.player allowjump(0);
	level.player allowmelee(0);
	level.player allowprone(0);
	level.player allowsprint(0);
}

//Function Number: 14
load_mech()
{
	mech_player_anims();
	mech_generic_human();
	mech_script_models();
	mech_fx();
}

//Function Number: 15
mech_player_anims()
{
	level.scr_animtree["mech_viewmodel"] = #animtree;
	level.scr_model["mech_viewmodel"] = "viewhands_player_pmc";
	level.scr_anim["mech_viewmodel"]["mech_enable"] = %cap_playermech_getinto_mech_vm;
	maps\_anim::addnotetrack_notify("mech_viewmodel","enable_mech","notify_mech_enable","mech_enable");
}

//Function Number: 16
mech_generic_human()
{
	level.scr_animtree["mech_player_rig"] = #animtree;
	level.scr_anim["mech_player_rig"]["mech_run_through"] = %cap_playermech_run_through_mech_short;
	level.scr_model["mech_player_rig"] = "worldhands_playermech";
	level.scr_animtree["mech_suit_top"] = #animtree;
	level.scr_model["mech_suit_top"] = "playermech_animated_model_top";
	level.scr_anim["mech_suit_top"]["mech_enable"] = %cap_playermech_getinto_mech_mech;
	level.scr_animtree["mech_suit_bottom"] = #animtree;
	level.scr_model["mech_suit_bottom"] = "playermech_animated_model_btm";
	level.scr_anim["mech_suit_bottom"]["mech_enable"] = %cap_playermech_getinto_mech_mech;
	level.scr_anim["generic"]["explode_death"] = %death_explosion_run_f_v2;
}

//Function Number: 17
mech_script_models()
{
	level.scr_animtree["mb_wall_1"] = #animtree;
	level.scr_anim["mb_wall_1"]["mech_run_through"] = %cap_playermech_run_through_prop_short;
	level.scr_model["mb_wall_1"] = "cap_playermech_breakable_wall";
}

//Function Number: 18
mech_fx()
{
}

//Function Number: 19
mech_setup()
{
	setsaveddvar("mechSpeed",350);
	setsaveddvar("mechAcceleration",3.25);
	setsaveddvar("mechAirAcceleration",0.23);
	setsaveddvar("player_sprintSpeedScale",1.6);
	if(level.player adsbuttonpressed() || getdvar("quickmech") == "1")
	{
		thread mech_enable();
	}
}

//Function Number: 20
mech_enable(param_00,param_01)
{
	level.damage_multiplier_mod = 0.13;
	level.mech_swarm_rocket_max_targets = 6;
	level.mech_swarm_rocket_dud_min_count = 2;
	level.mech_swarm_rocket_dud_max_count = 3;
	level.mech_swarm_skip_line_of_sight_obstruction_test = 0;
	level.player maps\_playermech_code::playermech_start("base",param_01,param_00,"vm_view_arms_mech","vm_view_arms_mech");
	setsaveddvar("mechStandHeight",71);
	setsaveddvar("mechBarrelSpinAnim","s1_playermech_barrel_spin");
}

//Function Number: 21
mech_enable_switch_exhaust_version(param_00,param_01)
{
	level.player notify("kill_think_player_blast_walk_anims");
	level.player.blast_anim_set = undefined;
	level.player takeweapon("playermech_auto_cannon_finale");
	level.player giveweapon("playermech_auto_cannon_finale_exhaust");
	level.player switchtoweaponimmediate("playermech_auto_cannon_finale_exhaust");
	setsaveddvar("mechBarrelSpinAnim","s1_blast_gun_up_playermech_barrel_spin");
	level.player.mechdata.weapon_names["mech_base_weapon"] = "playermech_auto_cannon_finale_exhaust";
	level.player maps\_playermech_code::playermech_start("base",param_00,param_01,"vm_view_arms_mech","vm_view_arms_mech");
}

//Function Number: 22
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

//Function Number: 23
screen_fade_out(param_00)
{
	level notify("new_screen_fade");
	level endon("new_screen_fade");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(level.black_screen))
	{
		create_black_screen();
	}

	setblur(10,param_00);
	if(param_00 > 0)
	{
		level.black_screen.alpha = 0;
		level.black_screen fadeovertime(param_00);
	}

	level.black_screen.alpha = 1;
	wait(param_00);
}

//Function Number: 24
screen_fade_in(param_00)
{
	level notify("new_screen_fade");
	level endon("new_screen_fade");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(level.black_screen))
	{
		create_black_screen();
	}

	setblur(0,param_00);
	if(param_00 > 0)
	{
		level.black_screen.alpha = 1;
		level.black_screen fadeovertime(param_00);
	}

	level.black_screen.alpha = 0;
	wait(param_00);
}

//Function Number: 25
create_black_screen()
{
	level.black_screen = newhudelem();
	level.black_screen.x = 0;
	level.black_screen.y = 0;
	level.black_screen.alpha = 0;
	level.black_screen.horzalign = "fullscreen";
	level.black_screen.vertalign = "fullscreen";
	level.black_screen.foreground = 1;
	level.black_screen setshader("black",640,480);
}

//Function Number: 26
screen_fade(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	thread screen_fade_out(param_00);
	wait(param_02 + param_00);
	thread screen_fade_in(param_01);
}

//Function Number: 27
set_custom_patrol_anim_set(param_00)
{
	set_custom_run_anim(param_00);
	self allowedstances("stand");
	self.oldcombatmode = self.combatmode;
	self.combatmode = "no_cover";
	maps\_utility::disable_cqbwalk();
}

//Function Number: 28
set_custom_run_anim(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(level.scr_anim["generic"]["patrol_walk_" + param_00]))
	{
		var_01 = "patrol_walk_" + param_00;
	}

	if(isdefined(level.scr_anim["generic"]["patrol_walk_weights_" + param_00]))
	{
		var_02 = "patrol_walk_weights_" + param_00;
	}

	maps\_utility::set_generic_run_anim_array(var_01,var_02,1);
	if(isdefined(level.scr_anim["generic"]["patrol_idle_" + param_00]))
	{
		var_03 = "patrol_idle_" + param_00;
		maps\_utility::set_generic_idle_anim(var_03);
	}

	if(isdefined(level.scr_anim["generic"]["patrol_transin_" + param_00]))
	{
		self.customarrivalfunc = ::custom_idle_trans_function;
		self.startidletransitionanim = level.scr_anim["generic"]["patrol_transin_" + param_00];
	}

	if(isdefined(level.scr_anim["generic"]["patrol_transout_" + param_00]))
	{
		self.permanentcustommovetransition = 1;
		self.custommovetransition = ::animscripts\cover_arrival::custommovetransitionfunc;
		self.startmovetransitionanim = level.scr_anim["generic"]["patrol_transout_" + param_00];
	}
}

//Function Number: 29
custom_idle_trans_function()
{
	if(!isdefined(self.startidletransitionanim))
	{
		return;
	}

	var_00 = self.approachnumber;
	var_01 = self.startidletransitionanim;
	if(!isdefined(self.heat))
	{
		thread animscripts\cover_arrival::abortapproachifthreatened();
	}

	self clearanim(%body,0.2);
	self setflaggedanimrestart("coverArrival",var_01,1,0.2,self.movetransitionrate);
	animscripts\face::playfacialanim(var_01,"run");
	animscripts\shared::donotetracks("coverArrival",::animscripts\cover_arrival::handlestartaim);
	var_02 = level.arrivalendstance[self.approachtype];
	if(isdefined(var_02))
	{
		self.a.pose = var_02;
	}

	self.a.movement = "stop";
	self.a.arrivaltype = self.approachtype;
	self clearanim(%root,0.3);
	self.lastapproachaborttime = undefined;
	var_03 = self.origin - self.goalpos;
}

//Function Number: 30
disable_grenades()
{
	if(isdefined(self.grenadeammo) && !isdefined(self.oldgrenadeammo))
	{
		self.oldgrenadeammo = self.grenadeammo;
	}

	self.grenadeammo = 0;
}

//Function Number: 31
enable_grenades()
{
	if(isdefined(self.oldgrenadeammo))
	{
		self.grenadeammo = self.oldgrenadeammo;
		self.oldgrenadeammo = undefined;
	}
}

//Function Number: 32
angles_and_origin(param_00)
{
	if(isdefined(param_00.origin))
	{
		self.origin = param_00.origin;
	}

	if(isdefined(param_00.angles))
	{
		self.angles = param_00.angles;
	}
}

//Function Number: 33
spawn_tag_origin_monitor(param_00)
{
	if(!isdefined(level.monitored_tag_origins))
	{
		level.monitored_tag_origins = [];
	}

	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 angles_and_origin(self);
	if(isdefined(param_00))
	{
		var_01.tag_idx = param_00;
	}

	level.monitored_tag_origins[level.monitored_tag_origins.size] = var_01;
	level.monitored_tag_origins = common_scripts\utility::array_removeundefined(level.monitored_tag_origins);
	iprintln(level.monitored_tag_origins.size);
	return var_01;
}

//Function Number: 34
mech_glass_damage_think(param_00)
{
	level endon(param_00);
	for(;;)
	{
		if(isdefined(self))
		{
			glassradiusdamage(self.origin,72,1000,100);
		}

		wait(0.05);
	}
}

//Function Number: 35
setstencilstate(param_00)
{
	self hudoutlineenable(6,1);
}

//Function Number: 36
clearstencilstate()
{
	if(isdefined(self))
	{
		self hudoutlinedisable();
		self hudoutlineenable(0,0);
		self hudoutlinedisable();
		setsaveddvar("r_hudoutlinewidth",1);
	}
}

//Function Number: 37
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

//Function Number: 38
enable_takedown_hint(param_00,param_01,param_02,param_03,param_04)
{
	self notify("enable_takedown_hint_called");
	self endon("enable_takedown_hint_called");
	var_05 = undefined;
	var_06 = undefined;
	if(isdefined(param_04))
	{
		var_06 = gettime() + param_04 * 1000;
	}

	if(isdefined(param_01))
	{
		var_05 = param_01 * param_01;
	}

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
		if(common_scripts\utility::flag("flag_disable_takedown_hint") || isdefined(var_06) && gettime() > var_06)
		{
			if(level.melee_hint_displayed)
			{
				level.should_display_melee_hint = 0;
			}

			common_scripts\utility::flag_clear("flag_disable_takedown_hint");
			return;
		}

		var_07 = distance2dsquared(param_00.origin,level.player.origin);
		if(level.melee_hint_displayed)
		{
			if(isdefined(var_05) && var_07 > var_05 + 10)
			{
				level.should_display_melee_hint = 0;
			}

			if(isdefined(level._cloaked_stealth_settings) && isdefined(level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1)
			{
				level.should_display_melee_hint = 0;
			}

			if(isdefined(param_02) && param_02)
			{
				var_08 = param_00 geteye();
				var_09 = 0.9;
				if(!level.player player_looking_in_direction_2d(var_08,var_09,1))
				{
					level.should_display_melee_hint = 0;
				}
			}

			continue;
		}

		if(!isdefined(var_05) || var_07 <= var_05)
		{
			var_0A = 1;
			if(isdefined(level._cloaked_stealth_settings) && isdefined(level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1)
			{
				var_0A = 0;
			}

			if(isdefined(param_02) && param_02)
			{
				var_08 = param_00 geteye();
				var_09 = 0.9;
				if(!level.player player_looking_in_direction_2d(var_08,var_09,1))
				{
					var_0A = 0;
				}
			}

			if(var_0A)
			{
				level.should_display_melee_hint = 1;
				level.melee_hint_displayed = 1;
				level.player allowmelee(0);
				level.takedown_button = param_00 maps\_shg_utility::hint_button_tag("melee","J_SpineUpper");
				maps\_utility::hintdisplaymintimehandler("takedown_hint",undefined);
			}
		}

		wait(0.05);
	}

	self notify("player_completed_takedown");
	common_scripts\utility::flag_set(param_03);
}

//Function Number: 39
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
		if(isdefined(level.takedown_button))
		{
			level.takedown_button maps\_shg_utility::hint_button_clear();
		}

		return 1;
	}

	return 0;
}

//Function Number: 40
tackle_handle_hint_display()
{
	if(common_scripts\utility::flag("flag_balcony_tackle_too_late") || common_scripts\utility::flag("flag_balcony_tackle_started"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 41
process_stab_finale_scene(param_00,param_01,param_02,param_03,param_04)
{
	common_scripts\utility::flag_clear("flag_stop_display_melee_hint");
	level.player endon("flag_stop_display_melee_hint");
	common_scripts\utility::flag_clear("flag_button_melee_success");
	if(!common_scripts\utility::flag_exist("flag_final_melee_pressed"))
	{
		common_scripts\utility::flag_init("flag_final_melee_pressed");
	}

	common_scripts\utility::flag_clear("flag_final_melee_pressed");
	var_05 = 0;
	if(isdefined(param_03))
	{
		wait(param_03);
	}

	var_06 = param_00 maps\_shg_utility::hint_button_tag("melee",param_01);
	var_06.fontscale = 2;
	var_06 thread final_scene_handle_melee_hint();
	common_scripts\utility::flag_wait_or_timeout("flag_final_melee_pressed",param_02);
	if(common_scripts\utility::flag("flag_final_melee_pressed"))
	{
		if(param_01 == "J_Wrist_RI")
		{
			soundscripts\_snd::snd_message("finale_ending_qte1_success");
		}
		else
		{
			soundscripts\_snd::snd_message("finale_ending_qte2_success");
		}

		common_scripts\utility::flag_set("flag_button_melee_success");
		if(isdefined(param_04))
		{
			param_00 maps\_utility::anim_stopanimscripted();
			level.irons maps\_utility::anim_stopanimscripted();
			return;
		}

		return;
	}

	if(param_01 == "J_Wrist_RI")
	{
		soundscripts\_snd::snd_message("finale_ending_qte1_timeout");
		return;
	}

	soundscripts\_snd::snd_message("finale_ending_qte2_timeout");
}

//Function Number: 42
final_scene_handle_melee_hint()
{
	var_00 = 0;
	common_scripts\utility::flag_clear("flag_final_melee_pressed");
	while(!common_scripts\utility::flag("flag_stop_display_melee_hint"))
	{
		if(level.player meleebuttonpressed())
		{
			if(!common_scripts\utility::flag("flag_stop_display_melee_hint"))
			{
				common_scripts\utility::flag_set("flag_final_melee_pressed");
			}

			break;
		}

		wait 0.05;
	}

	var_00 = 1;
	level.melee_hint_displayed = 0;
	if(isdefined(self))
	{
		maps\_shg_utility::hint_button_clear();
	}
}

//Function Number: 43
process_buttonmash_finale_scene(param_00,param_01,param_02,param_03)
{
	param_00 endon("end_process_buttonmash");
	common_scripts\utility::flag_clear("flag_xbutton_mash_end");
	level.player.buttonmash_decay_per_frame = 0.1;
	level.player.buttonmash_value = 0;
	level.player.buttonmash_add_per_press = 0.2;
	level.player notifyonplayercommand("x_pressed","+usereload");
	level.player notifyonplayercommand("x_pressed","+activate");
	param_00 thread maps\_shg_utility::hint_button_create_flashing(param_01,"x","end_process_buttonmash",(0,0,0),35,300,2);
	var_04 = 0;
	var_05 = 30;
	while(var_04 < var_05)
	{
		if(level.player usebuttonpressed())
		{
			soundscripts\_snd::snd_message("finale_ending_buttonmash_start");
			break;
		}

		var_04 = var_04 + 1;
		wait 0.05;
	}

	if(var_04 >= var_05)
	{
		param_00 thread process_buttonmash_handle_fail(param_03);
	}

	childthread buttonmash_monitor(param_03,param_00);
	common_scripts\utility::flag_wait("flag_xbutton_mash_end");
	level.player notifyonplayercommandremove("x_pressed","+usereload");
	level.player notifyonplayercommandremove("x_pressed","+activate");
	param_00 notify("end_process_buttonmash");
}

//Function Number: 44
buttonmash_monitor(param_00,param_01)
{
	level notify("notify_buttonmash_monitor_reset");
	level endon("notify_buttonmash_monitor_reset");
	level.player.buttonmash_value = 0;
	while(!common_scripts\utility::flag("flag_xbutton_mash_end"))
	{
		childthread buttonmash_decay(param_00,param_01);
		level.player common_scripts\utility::waittill_any("x_pressed","b_pressed","a_pressed");
		level.player.buttonmash_value = level.player.buttonmash_value + level.player.buttonmash_add_per_press;
		wait 0.05;
	}

	level notify("notify_buttonmash_decay_stop");
}

//Function Number: 45
buttonmash_decay(param_00,param_01)
{
	level notify("notify_buttonmash_decay_stop");
	level endon("notify_buttonmash_decay_stop");
	var_02 = 0;
	var_03 = 30;
	while(var_02 < var_03)
	{
		if(level.player.buttonmash_value > 0)
		{
			level.player.buttonmash_value = level.player.buttonmash_value - level.player.buttonmash_decay_per_frame;
		}

		var_02 = var_02 + 1;
		wait 0.05;
	}

	param_01 thread process_buttonmash_handle_fail(param_00);
}

//Function Number: 46
process_buttonmash_handle_hint()
{
	if(common_scripts\utility::flag("flag_xbutton_mash_end") || common_scripts\utility::flag("missionfailed") || level.player usebuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 47
process_buttonmash_handle_fail(param_00)
{
	soundscripts\_snd::snd_message("finale_ending_buttonmash_fail");
	common_scripts\utility::flag_set("flag_xbutton_mash_end");
	level.player lightsetforplayer("finale_hang_fail");
	self notify("end_process_buttonmash");
	level notify("audio_finale_qte_fail");
	thread maps\finale_fx::vfx_irons_fail_fall();
	var_01 = [self,level.irons];
	param_00 maps\_anim::anim_single(var_01,"balcony_finale_pt3_fail");
	setdvar("ui_deadquote","");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 48
chase_timer_countdown(param_00,param_01)
{
	level notify("chase_timer_countdown_stop");
	level endon("chase_timer_countdown_stop");
	common_scripts\utility::flag_wait_or_timeout("flag_irons_escaped",param_00);
	if(param_01 == &"FINALE_FAILED_MISSILE_LAUNCH")
	{
		level.player showhud();
		level.player setclientomnvar("ui_playermech_hud",0);
		setsaveddvar("cg_drawCrosshair",0);
	}

	setdvar("ui_deadquote",param_01);
	maps\_utility::missionfailedwrapper();
}

//Function Number: 49
chase_timer_cancel()
{
	level notify("chase_timer_countdown_stop");
}

//Function Number: 50
sprint_hint_reminder()
{
	while(!common_scripts\utility::flag("flag_player_passed_door"))
	{
		if(!level.player issprinting())
		{
			thread maps\_utility::hintdisplayhandler("player_input_sprint_hint");
		}

		wait 0.05;
	}
}

//Function Number: 51
player_input_sprint()
{
	if(level.player issprinting() || level.player issprintsliding() || common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
player_chase_speed_control()
{
	level endon("missionfailed");
	var_00 = 1;
	var_01 = 0.8;
	var_02 = 0.5;
	level.too_close_distance = 180;
	var_03 = level.too_close_distance + 80;
	common_scripts\utility::flag_set("flag_player_speed_control_on");
	level.player setmovespeedscale(var_00);
	while(common_scripts\utility::flag("flag_player_speed_control_on"))
	{
		if(distance(level.player.origin,level.irons.origin) < level.too_close_distance)
		{
			while(var_00 >= var_01 && distance(level.player.origin,level.irons.origin) < level.too_close_distance && common_scripts\utility::flag("flag_player_speed_control_on"))
			{
				var_00 = var_00 - 0.05;
				level.player setmovespeedscale(var_00);
				wait(var_02);
			}

			while(distance(level.player.origin,level.irons.origin) < var_03 && common_scripts\utility::flag("flag_player_speed_control_on"))
			{
				wait 0.05;
			}

			while(var_00 < 1 && distance(level.player.origin,level.irons.origin) < level.too_close_distance & common_scripts\utility::flag("flag_player_speed_control_on"))
			{
				var_00 = var_00 + 0.05;
				level.player setmovespeedscale(var_00);
				wait(var_02);
			}

			if(var_00 > 1)
			{
				var_00 = 1;
				level.player setmovespeedscale(var_00);
			}
		}

		wait 0.05;
	}

	level.player setmovespeedscale(1);
}

//Function Number: 53
lowering_door_think(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getent(param_01,"targetname");
	var_07 = getent(param_02,"targetname");
	param_03 = getent(param_03,"targetname");
	thread lowering_door_slide_hint();
	if(isdefined(param_04))
	{
		common_scripts\utility::flag_wait(param_04);
	}

	var_07 linkto(var_06);
	soundscripts\_snd::snd_message("irons_chase_door_close",var_06);
	var_06 move_door_to_position(param_03.origin,param_00,undefined,undefined,param_05);
	if(!common_scripts\utility::flag("flag_player_passed_door"))
	{
		chase_timer_cancel();
		setdvar("ui_deadquote",&"FINALE_FAILED_IRONS_CHASE");
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 54
move_door_to_position(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	if(isdefined(param_04))
	{
		param_04 = getent(param_04,"targetname");
	}

	var_05 = distance(param_00,self.origin);
	var_06 = 0;
	var_07 = self.origin;
	while(var_06 < var_05)
	{
		var_08 = getlerpfraction(self.origin,param_00,param_01,param_02);
		if(var_08 == 0)
		{
			break;
		}

		self.origin = vectorlerp(self.origin,param_00,var_08);
		if(isdefined(param_03))
		{
			self.angles = self.angles + param_03;
		}

		var_06 = distance(self.origin,var_07);
		if(isdefined(param_04))
		{
			var_09 = 0;
			while(level.player istouching(param_04))
			{
				var_09 = var_09 + 1;
				if(var_09 == 30)
				{
					level.player kill();
					break;
				}

				wait 0.05;
			}
		}

		wait(0.05);
	}

	level notify("lerp_complete");
}

//Function Number: 55
getlerpfraction(param_00,param_01,param_02,param_03)
{
	var_04 = distance(param_00,param_01);
	if(param_02 == 0 || var_04 == 0)
	{
		return 0;
	}

	var_05 = param_02 / var_04 * 0.05;
	if(var_05 > 0)
	{
		return var_05;
	}

	return 0;
}

//Function Number: 56
lowering_door_slide_hint()
{
	self notify("slide_hint");
	self endon("slide_hint");
	var_00 = getent("vol_door_slide_reminder","targetname");
	while(!common_scripts\utility::flag("flag_player_passed_door"))
	{
		if(level.player istouching(var_00))
		{
			thread maps\_utility::hintdisplayhandler("player_input_slide_button");
		}

		wait 0.05;
	}
}

//Function Number: 57
player_input_slide_under_door()
{
	if(common_scripts\utility::flag("flag_player_passed_door") || common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 58
build_new_view_matrix(param_00)
{
	var_01 = anglestoright(self.angles);
	var_02 = vectorcross(param_00,var_01);
	var_03 = axistoangles(param_00,var_01,var_02);
	return var_03;
}

//Function Number: 59
get_goal_angles_ramped_given_viewdir(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = anglestoforward(param_00);
	var_06 = 1;
	if(gettime() < param_03)
	{
		var_06 = gettime() - param_02 / param_03 - param_02;
	}

	if(isdefined(param_04) && var_06 > param_04)
	{
		var_06 = param_04;
	}

	var_07 = 1 - var_06;
	param_01 = var_06 * param_01 + var_07 * var_05;
	var_08 = build_new_view_matrix(param_01);
	return var_08;
}

//Function Number: 60
rotate_camera_to_see_ent(param_00,param_01,param_02,param_03)
{
	self.target_entity = param_00;
	var_04 = self.target_entity.origin - self.origin;
	var_05 = vectornormalize(var_04);
	rotate_camera_to_internal(var_05,param_01,param_02,1,param_03);
}

//Function Number: 61
rotate_camera_to_offset_angles(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = (param_00,param_01,param_02);
	var_06 = combineangles(self.angles,var_05);
	var_07 = anglestoforward(var_06);
	var_07 = vectornormalize(var_07);
	rotate_camera_to_internal(var_07,param_03,param_04);
}

//Function Number: 62
rotate_camera_to_match_ent(param_00,param_01,param_02)
{
	var_03 = anglestoforward(param_00.angles);
	var_04 = vectornormalize(var_03);
	rotate_camera_to_internal(var_04,param_01,param_02,1);
}

//Function Number: 63
rotate_camera_to_internal(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self.angles;
	var_06 = gettime();
	var_07 = gettime() + param_02 * 1000;
	var_08 = gettime() + param_01 * 1000;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	while(gettime() <= var_08)
	{
		var_09 = get_goal_angles_ramped_given_viewdir(var_05,param_00,var_06,var_07,param_04);
		iprintln(var_09);
		self unlink();
		self.angles = var_09;
		self linkto(level.player.drivingvehicle);
		thread maps\_shg_debug::draw_axis(self.origin,var_09,10);
		wait 0.05;
		if(param_03)
		{
			var_0A = self.target_entity.origin - self.origin;
			param_00 = vectornormalize(var_0A);
		}
	}
}

//Function Number: 64
camera_sway_tuning()
{
	level.values[0] = 0.2;
	level.values[1] = 4.1;
	level.values[2] = 0.56;
	level.values[3] = 2;
	level.values[4] = 0.95;
	level.values[5] = 0;
	level.values[6] = 0;
	level.values[7] = 0.4;
	level.values[8] = 0.1;
	level.values[9] = 0.1;
	var_00[0] = "scalePitch";
	var_00[1] = "scaleyaw";
	var_00[2] = "scaleroll";
	var_00[3] = "duration";
	var_00[4] = "durationfadeup";
	var_00[5] = "durationfadedown";
	var_00[6] = "radius";
	var_00[7] = "frequencypitch";
	var_00[8] = "frequencyyaw";
	var_00[9] = "frequencyroll";
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		if(level.player buttonpressed("DPAD_LEFT"))
		{
			var_01++;
			if(var_01 >= var_00.size)
			{
				var_01 = 0;
			}

			var_02 = 1;
			wait(0.5);
		}
		else if(level.player buttonpressed("DPAD_RIGHT"))
		{
			var_01--;
			if(var_01 < 0)
			{
				var_01 = var_00.size - 1;
			}

			var_02 = 1;
			wait(0.5);
		}
		else if(level.player buttonpressed("DPAD_UP"))
		{
			level.values[var_01] = level.values[var_01] + 0.05;
			var_02 = 1;
		}
		else if(level.player buttonpressed("DPAD_DOWN"))
		{
			level.values[var_01] = level.values[var_01] - 0.05;
			var_02 = 1;
		}

		if(var_02)
		{
			var_03 = var_00[var_01] + "(" + level.values[var_01] + ") ";
			iprintln(var_03);
			var_02 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 65
boat_bobbing_think(param_00)
{
	level endon("boat_scene_cleanup");
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = common_scripts\utility::get_target_ent();
		param_00 linkto(self);
	}

	maps\_utility::ent_flag_init("flag_big_bobbing");
	for(;;)
	{
		var_01 = boat_scene_small_bob_settings();
		maps\_bobbing_boats::prep_bobbing([self],::maps\_bobbing_boats::bobbingobject,var_01,0);
		thread maps\_bobbing_boats::start_bobbing_single(randomfloatrange(0,1));
		maps\_utility::ent_flag_wait("flag_big_bobbing");
		var_01 = boat_scene_big_bob_settings();
		maps\_bobbing_boats::prep_bobbing([self],::maps\_bobbing_boats::bobbingobject,var_01,0);
		thread maps\_bobbing_boats::start_bobbing_single(randomfloatrange(0,1));
		maps\_utility::ent_flag_waitopen("flag_big_bobbing");
	}
}

//Function Number: 66
boat_scene_small_bob_settings()
{
	var_00 = spawnstruct();
	var_00.max_pitch = 3;
	var_00.min_pitch_period = 3;
	var_00.max_pitch_period = 6;
	var_00.max_yaw = 6;
	var_00.min_yaw_period = 3;
	var_00.max_yaw_period = 6;
	var_00.max_roll = 6;
	var_00.min_roll_period = 3;
	var_00.max_roll_period = 6;
	var_00.max_sink = 4;
	var_00.max_float = 6;
	var_00.min_bob_period = 2;
	var_00.max_bob_period = 4;
	return var_00;
}

//Function Number: 67
boat_scene_big_bob_settings()
{
	var_00 = spawnstruct();
	var_00.max_pitch = 3;
	var_00.min_pitch_period = 3;
	var_00.max_pitch_period = 6;
	var_00.max_yaw = 0;
	var_00.min_yaw_period = 3;
	var_00.max_yaw_period = 6;
	var_00.max_roll = 6;
	var_00.min_roll_period = 3;
	var_00.max_roll_period = 6;
	var_00.max_sink = 36;
	var_00.max_float = 24;
	var_00.min_bob_period = 3;
	var_00.max_bob_period = 6;
	return var_00;
}

//Function Number: 68
postspawn_rpg_vehicle()
{
	self setmodel("projectile_rpg7");
	var_00 = common_scripts\utility::getfx("rpg_trail");
	playfxontag(var_00,self,"tag_origin");
	var_00 = common_scripts\utility::getfx("rpg_muzzle");
	playfxontag(var_00,self,"tag_origin");
	self playsound("weap_rpg_fire_npc");
	if(isdefined(self.script_sound))
	{
		if(isdefined(self.script_wait))
		{
			common_scripts\utility::delaycall(self.script_wait,::playsound,self.script_sound);
		}
		else
		{
			self playsound(self.script_sound);
		}
	}
	else
	{
		self playloopsound("weap_rpg_loop");
	}

	self waittill("reached_end_node");
	self notify("explode",self.origin);
	var_01 = 0;
	if(isdefined(self.currentnode))
	{
		var_02 = undefined;
		var_03 = self.currentnode;
		while(isdefined(var_03))
		{
			var_02 = var_03;
			if(!isdefined(var_03.target))
			{
				break;
			}

			var_03 = getvehiclenode(var_03.target,"targetname");
		}

		if(isdefined(var_02.target))
		{
			var_04 = common_scripts\utility::getstruct(var_02.target,"targetname");
			if(isdefined(var_04))
			{
				level thread rpg_explosion(var_04.origin,var_04.angles);
				var_01 = 1;
			}
		}
	}

	if(!var_01)
	{
		var_04 = spawnstruct();
		var_04.origin = self.origin;
		var_04.angles = (-90,0,0);
		level thread rpg_explosion(var_04.origin,var_04.angles);
	}

	self delete();
}

//Function Number: 69
rpg_explosion(param_00,param_01)
{
	var_02 = common_scripts\utility::getfx("rpg_explode");
	playfx(var_02,param_00,anglestoforward(param_01),anglestoup(param_01));
	radiusdamage(param_00,200,150,50);
	thread common_scripts\utility::play_sound_in_space("null",param_00);
}

//Function Number: 70
combat_silo_seeker_ai()
{
	var_00 = 2;
	var_01 = [];
	for(;;)
	{
		var_02 = getaiarray("axis");
		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(issubstr(var_05.classname,"mech"))
			{
				var_03[var_03.size] = var_05;
			}
		}

		wait 0.05;
		var_01 = [];
		for(var_07 = 0;var_07 < var_00;var_07++)
		{
			if(var_03.size > var_07)
			{
				var_05 = maps\_utility::get_closest_living(level.player.origin,var_03);
				if(isalive(var_05))
				{
					if(isdefined(var_05.magic_bullet_shield))
					{
						var_05 maps\_utility::stop_magic_bullet_shield();
					}

					var_05.playerseeker = 1;
					var_05 cleargoalvolume();
					var_05 thread maps\_utility::player_seek();
					var_05.favoriteenemy = level.player;
					var_01[var_01.size] = var_05;
				}
			}
		}

		if(var_01.size > 0)
		{
			maps\_utility::array_wait(var_01,"death");
		}

		wait(2);
	}

	foreach(var_09 in var_01)
	{
		if(isalive(var_09))
		{
			var_09 notify("goal");
		}
	}
}

//Function Number: 71
murder_player_seek()
{
	self cleargoalvolume();
	self.favoriteenemy = level.player;
	maps\_utility::set_baseaccuracy(999);
	self setgoalentity(level.player);
	self.goalradius = 20;
	self.combatmode = "no_cover";
	self notify("end_patrol");
	level.player enablehealthshield(0);
}

//Function Number: 72
get_follow_volume_array()
{
	var_00 = getent("info_v_silo_top","targetname");
	var_01 = getent("info_v_silo_bottom","targetname");
	var_02 = [var_00,var_01];
	level.player.follow_volume_designated_head_top = var_00;
	level.player.follow_volume_designated_head_bottom = var_01;
	var_03 = var_02;
	foreach(var_05 in var_02)
	{
		for(var_06 = var_05;isdefined(var_06.target) && isdefined(getent(var_06.target,"targetname"));var_06 = var_07)
		{
			var_07 = getent(var_06.target,"targetname");
			var_03[var_03.size] = var_07;
		}
	}

	return var_03;
}

//Function Number: 73
get_opposite_volume(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00.script_linkto))
	{
		var_01 = getent(param_00.script_linkto,"script_linkname");
	}
	else if(isdefined(param_00.script_linkname))
	{
		foreach(var_03 in level.player.follow_volume_array)
		{
			if(isdefined(var_03.script_linkto) && var_03.script_linkto == param_00.script_linkname)
			{
				var_01 = var_03;
				break;
			}
		}
	}

	if(!isdefined(var_01))
	{
		var_01 = "opposite not found";
	}

	return var_01;
}

//Function Number: 74
player_follow_volume_think()
{
	self endon("kill_player_follow_volume_think");
	self endon("death");
	self.match_player_floor_percent = 0.75;
	self.follow_volume_array = get_follow_volume_array();
	level.player.follow_volume_maintain_count = 0;
	var_00 = 0;
	for(;;)
	{
		var_01 = get_non_mech_enemies();
		var_02 = 0;
		var_03 = 0;
		if(var_00 != var_01.size)
		{
			if(var_01.size <= 3)
			{
				var_02 = 1;
			}

			if(var_00 <= 3 && var_01.size > 3)
			{
				var_03 = 1;
			}
		}

		foreach(var_05 in self.follow_volume_array)
		{
			if((!isdefined(self.follow_volume) || var_02 || var_03 || self.follow_volume != var_05) && self istouching(var_05))
			{
				if(var_02)
				{
					self.match_player_floor_percent = 1;
				}
				else if(!isdefined(self.follow_volume))
				{
					self.match_player_floor_percent = 0.75;
				}
				else
				{
					self.match_player_floor_percent = 0.75;
				}

				self.follow_volume = var_05;
				if(!isdefined(var_05.target))
				{
					self.follow_volume_target = self.follow_volume;
				}
				else
				{
					self.follow_volume_target = getent(var_05.target,"targetname");
				}

				self.follow_volume_target_opposite = get_opposite_volume(self.follow_volume_target);
				foreach(var_07 in var_01)
				{
					var_07.follow_volume = undefined;
				}

				level.player.follow_volume_maintain_count = 0;
				if(!isdefined(self.follow_volume_target))
				{
					self.follow_volume_target = self.follow_volume;
				}

				break;
			}
		}

		var_00 = var_01.size;
		wait 0.05;
	}
}

//Function Number: 75
get_non_mech_enemies()
{
	var_00 = getaiarray("axis");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.classname != "actor_enemy_mech")
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 76
is_goal_blocked(param_00)
{
	if(isdefined(param_00.script_flag_true) && !common_scripts\utility::flag(param_00.script_flag_true))
	{
		return 1;
	}

	return 0;
}

//Function Number: 77
move_guy(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = undefined;
		param_00 = level.player.follow_volume_designated_head_top;
		param_01 = level.player.follow_volume_designated_head_bottom;
	}

	var_03 = get_floor_count_array();
	var_04 = var_03[0];
	var_05 = var_03[1];
	var_06 = 0;
	if(var_04 + var_05 > 0)
	{
		var_06 = var_04 / var_04 + var_05;
	}

	var_07 = undefined;
	var_08 = undefined;
	if(var_06 <= level.player.match_player_floor_percent)
	{
		var_07 = param_00;
		var_08 = 1;
	}
	else
	{
		var_07 = param_01;
		var_08 = 2;
	}

	if(is_goal_blocked(var_07))
	{
		if(isstring(var_07) || !isdefined(var_07))
		{
			self.follow_volume = "opposite not found";
			return 0;
		}

		if(var_07 == param_00)
		{
			var_07 = param_02;
			var_08 = 3;
		}
		else
		{
			var_07 = get_opposite_volume(param_02);
			var_08 = 4;
		}
	}

	self cleargoalvolume();
	self.goalradius = 256;
	self setgoalvolumeauto(var_07);
	self.follow_volume = var_07;
	return var_08;
}

//Function Number: 78
follow_volume_think()
{
	self endon("death");
	if(self.classname == "actor_enemy_mech")
	{
		return;
	}

	thread death_watcher();
	self.follow_volume_status = 0;
	if(1)
	{
		self.follow_volume_status = move_guy(level.player.follow_volume_target,level.player.follow_volume_target_opposite,level.player.follow_volume);
	}

	for(;;)
	{
		if(!has_target_volume())
		{
			self.follow_volume_status = move_guy(level.player.follow_volume_target,level.player.follow_volume_target_opposite,level.player.follow_volume);
		}
		else if(1 && level.player.follow_volume_maintain_count > 0 && check_move_me_to_maintain_ratio())
		{
			level.player.follow_volume_maintain_count--;
			self.follow_volume_status = move_guy(level.player.follow_volume_target,level.player.follow_volume_target_opposite,level.player.follow_volume);
		}
		else if(is_guy_follow_status_blocked())
		{
			if(!is_goal_blocked(self.follow_volume))
			{
				var_00 = getent(self.follow_volume.target,"targetname");
				var_01 = get_opposite_volume(var_00);
				self.follow_volume_status = move_guy(var_00,var_01,self.follow_volume);
			}
		}

		wait(randomfloatrange(1,5));
	}
}

//Function Number: 79
death_watcher()
{
	self waittill("death");
	if(isdefined(self.follow_volume) && !isstring(self.follow_volume))
	{
		level.player.follow_volume_maintain_count++;
	}
}

//Function Number: 80
check_move_me_to_maintain_ratio()
{
	if(!1)
	{
		return 0;
	}

	var_00 = get_floor_count_array();
	var_01 = var_00[0];
	var_02 = var_00[1];
	var_03 = 0;
	if(var_01 + var_02 > 0)
	{
		var_03 = var_01 / var_01 + var_02;
	}

	if(var_03 <= level.player.match_player_floor_percent)
	{
		if(self.follow_volume_status != 1 && self.follow_volume_status != 3)
		{
			return 1;
		}
	}
	else if(self.follow_volume_status != 2 && self.follow_volume_status != 4)
	{
		return 1;
	}

	return 0;
}

//Function Number: 81
has_target_volume()
{
	if(isdefined(self.follow_volume))
	{
		return 1;
	}

	return 0;
}

//Function Number: 82
is_guy_follow_status_blocked()
{
	return self.follow_volume_status == 3 || self.follow_volume_status == 4;
}

//Function Number: 83
get_floor_count_array()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = getaiarray("axis");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.follow_volume) && isdefined(var_04.follow_volume_status) && var_04.follow_volume_status == 1 || var_04.follow_volume_status == 3)
		{
			var_00++;
		}

		if(isdefined(var_04.follow_volume) && isdefined(var_04.follow_volume_status) && var_04.follow_volume_status == 2 || var_04.follow_volume_status == 4)
		{
			var_01++;
		}
	}

	return [var_00,var_01];
}

//Function Number: 84
set_level_player_rumble_ent_intensity(param_00)
{
	if(!isdefined(level.rumble_ent))
	{
		level.rumble_ent = maps\_utility::get_rumble_ent("steady_rumble",0);
	}

	if(isdefined(param_00))
	{
		level.rumble_ent.intensity = param_00;
	}
	else
	{
		level.rumble_ent.intensity = 0;
	}

	level.rumble_ent.base_intensity = level.rumble_ent.intensity;
}

//Function Number: 85
set_level_player_rumble_ent_intensity_for_time(param_00,param_01)
{
	if(!isdefined(level.rumble_ent))
	{
		level.rumble_ent = maps\_utility::get_rumble_ent("steady_rumble",0);
	}

	if(!isdefined(level.rumble_ent.base_intensity))
	{
		level.rumble_ent.base_intensity = 0;
	}

	if(isdefined(param_00))
	{
		level.rumble_ent.intensity = param_00;
	}
	else
	{
		level.rumble_ent.intensity = 0;
	}

	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
		wait(0.25);
	}

	level.rumble_ent.intensity = level.rumble_ent.base_intensity;
}

//Function Number: 86
get_closest_point_on_segment(param_00,param_01,param_02)
{
	return get_closest_point_from_segment_to_segment(param_00,param_00,param_01,param_02);
}

//Function Number: 87
get_closest_point_from_segment_to_segment(param_00,param_01,param_02,param_03)
{
	var_04 = 0.001;
	var_05 = undefined;
	var_06 = param_01 - param_00;
	var_07 = param_03 - param_02;
	var_08 = param_00 - param_02;
	var_09 = vectordot(var_06,var_06);
	var_0A = vectordot(var_07,var_07);
	var_0B = vectordot(var_07,var_08);
	var_0C = 0;
	if(var_09 <= var_04 && var_0A <= var_04)
	{
		var_05 = 0;
		var_0D = 0;
		var_0E = param_00;
		var_0F = param_02;
		return [var_05,vectordot(var_0E - var_0F,var_0E - var_0F),var_0E,var_0F];
	}

	if(var_0C <= var_07)
	{
		var_08 = 0;
		var_0D = var_0E / var_0D;
		var_0F = clamp(var_0F,0,1);
	}
	else
	{
		var_10 = vectordot(var_09,var_0B);
		if(var_0C <= var_06)
		{
			var_0F = 0;
			var_07 = clamp(-1 * var_10 / var_0B,0,1);
		}
		else
		{
			var_11 = vectordot(var_08,var_09);
			var_12 = var_0B * var_0C - var_11 * var_11;
			if(var_12 != 0)
			{
				var_07 = clamp(var_11 * var_0D - var_10 * var_0C / var_12,0,1);
			}
			else
			{
				var_07 = 0;
			}

			var_0F = var_11 * var_07 + var_0D / var_0C;
			if(var_0F < 0)
			{
				var_0F = 0;
				var_07 = clamp(-1 * var_10 / var_0B,0,1);
			}
			else if(var_0F > 1)
			{
				var_0F = 1;
				var_07 = clamp(var_11 - var_10 / var_0B,0,1);
			}
		}
	}

	var_0E = param_02 + var_08 * var_07;
	var_0F = param_03 + var_08 * var_0E;
	return [var_0D,vectordot(var_0E - var_0F,var_0E - var_0F),var_0E,var_0F];
}