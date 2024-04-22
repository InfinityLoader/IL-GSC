/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 65
 * Decompile Time: 978 ms
 * Timestamp: 4/22/2024 2:27:23 AM
*******************************************************************/

//Function Number: 1
setup_player()
{
	var_00 = level.start_point + "_player_start";
	var_01 = common_scripts\utility::getstruct(var_00,"targetname");
	if(isdefined(var_01))
	{
		level.player setorigin(var_01.origin);
		if(isdefined(var_01.angles))
		{
			level.player setplayerangles(var_01.angles);
			return;
		}

		iprintlnbold("Your script_struct " + level.start_point + "_start has no angles! Set some.");
		return;
	}
}

//Function Number: 2
setup_allies()
{
	level.cormack = spawn_ally("cormack");
	level.cormack.canjumppath = 1;
	if(level.start_point == "skyjack" || level.start_point == "crash_site")
	{
		level.cormack setmodel("body_hero_cormack_sentinel_halo_jetpack");
	}

	if(level.start_point != "skyjack" && level.start_point != "crash_site")
	{
		level.ilana = spawn_ally("ilana");
		level.ilana.canjumppath = 1;
		level.ilana.animname = "ilana";
	}

	if(level.start_point == "vtol_takedown" || level.start_point == "avalanche")
	{
		level.gideon = spawn_ally("gideon");
		level.gideon.canjumppath = 1;
		level.gideon.animname = "gideon";
	}
}

//Function Number: 3
spawn_ally(param_00,param_01)
{
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = level.start_point + "_" + param_01;
	}

	var_03 = spawn_ally_at_struct(param_00,var_02);
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_03 maps\_utility::make_hero();
	if(!isdefined(var_03.magic_bullet_shield))
	{
		var_03 thread maps\_utility::magic_bullet_shield();
	}

	var_03.animname = param_00;
	if(param_00 != "cormack")
	{
		var_03 thread maps\crash_fx::cold_breath();
	}

	return var_03;
}

//Function Number: 4
spawn_ally_at_struct(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = common_scripts\utility::getstruct(param_01,"targetname");
	if(isdefined(var_02) && isdefined(var_03))
	{
		var_02.origin = var_03.origin;
		if(isdefined(var_03.angles))
		{
			var_02.angles = var_03.angles;
		}

		var_04 = var_02 maps\_utility::spawn_ai(1);
		return var_04;
	}

	if(isdefined(var_03))
	{
		var_04 = var_03 maps\_utility::spawn_ai(1);
		iprintlnbold("Add a script struct called: " + param_01 + " to spawn ally in the correct location.");
		var_04 teleport(level.player.origin,level.player.angles);
		return var_04;
	}

	iprintlnbold("Failed to spawn " + param_01 + ".  No spawner exists.");
	return undefined;
}

//Function Number: 5
spawn_enemy_array_at_structs(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	var_03 = common_scripts\utility::getstructarray(param_01,"targetname");
	var_04 = [];
	if(isdefined(var_02[0]) && isdefined(var_03[0]))
	{
		for(var_05 = 0;var_05 < var_02.size;var_05++)
		{
			var_02[var_05].origin = var_03[var_05].origin;
			if(isdefined(var_03[var_05].angles))
			{
				var_02[var_05].angles = var_03[var_05].angles;
			}

			var_04[var_05] = var_02[var_05] maps\_utility::spawn_ai(1);
			common_scripts\utility::add_to_array(var_04,var_04[var_05]);
		}

		return var_04;
	}

	if(isdefined(var_03[0]))
	{
		iprintlnbold("Failed to spawn " + param_01 + ".  A spawner exists but there is no struct.");
		return undefined;
	}

	iprintlnbold("Failed to spawn " + param_01 + ".  No spawners or structs exists.");
	return undefined;
}

//Function Number: 6
_hint_stick_update_string(param_00,param_01)
{
	var_02 = param_01 + param_00;
	var_03 = level.trigger_hint_func[var_02];
	level.hint_breakfunc = var_03;
}

//Function Number: 7
_hint_stick_update_breakfunc(param_00,param_01)
{
	var_02 = param_01 + param_00;
	var_03 = level.trigger_hint_string[var_02];
	level.current_hint settext(var_03);
}

//Function Number: 8
hint_update_config_change(param_00)
{
	level notify("hint_change_config");
	level endon("hint_change_config");
	var_01 = undefined;
	if(level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		var_01 = "_gamepad";
	}
	else
	{
		var_01 = "_keyboard";
	}

	while(isdefined(level.current_hint))
	{
		if(level.player common_scripts\utility::is_player_gamepad_enabled())
		{
			var_02 = "_gamepad";
		}
		else
		{
			var_02 = "_keyboard";
		}

		if(var_02 != var_01)
		{
			var_01 = var_02;
			_hint_stick_update_string(var_01,param_00);
			_hint_stick_update_breakfunc(var_01,param_00);
		}

		wait 0.05;
	}
}

//Function Number: 9
ai_array_killcount_flag_set(param_00,param_01,param_02,param_03)
{
	maps\_utility::waittill_dead_or_dying(param_00,param_01,param_03);
	common_scripts\utility::flag_set(param_02);
}

//Function Number: 10
temp_dialogue(param_00,param_01,param_02)
{
	level notify("temp_dialogue",param_00,param_01,param_02);
	level endon("temp_dialogue");
	if(!isdefined(param_02))
	{
		param_02 = 4;
	}

	if(isdefined(level.tmp_subtitle))
	{
		level.tmp_subtitle destroy();
		level.tmp_subtitle = undefined;
	}

	level.tmp_subtitle = newhudelem();
	level.tmp_subtitle.x = 0;
	level.tmp_subtitle.y = -64;
	level.tmp_subtitle settext("^2" + param_00 + ": ^7" + param_01);
	level.tmp_subtitle.fontscale = 1.46;
	level.tmp_subtitle.alignx = "center";
	level.tmp_subtitle.aligny = "middle";
	level.tmp_subtitle.horzalign = "center";
	level.tmp_subtitle.vertalign = "bottom";
	level.tmp_subtitle.sort = 1;
	wait(param_02);
	thread temp_dialogue_fade();
}

//Function Number: 11
temp_dialogue_fade()
{
	level endon("temp_dialogue");
	var_00 = 1;
	while(var_00 > 0)
	{
		level.tmp_subtitle.alpha = var_00;
		wait(0.05);
		var_00 = var_00 - 0.1;
	}

	level.tmp_subtitle destroy();
}

//Function Number: 12
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

//Function Number: 13
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

//Function Number: 14
equip_microwave_grenade()
{
	self.grenadeweapon = "microwave_grenade";
	self.grenadeammo = 2;
}

//Function Number: 15
cormack_helmet_open(param_00)
{
	param_00 thread set_helmet_open();
	param_00 notify("stop personal effect");
	param_00 thread maps\crash_fx::cold_breath();
}

//Function Number: 16
cormack_helmet_close(param_00)
{
	param_00 thread set_helmet_closed();
	param_00 notify("stop personal effect");
}

//Function Number: 17
set_helmet_open(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.2;
	}

	self setanimknobrestart(%sentinel_halo_helmet_open,1,param_00);
	self.helmet_open = 1;
	wait(0.25);
}

//Function Number: 18
set_helmet_closed(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.2;
	}

	self setanimrestart(%sentinel_halo_helmet_close,1,param_00);
	self.helmet_open = 0;
	wait(0.75);
}

//Function Number: 19
clear_additive_helmet_anim(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	self clearanim(%s1_halo_helmet,0);
}

//Function Number: 20
player_exo_enable()
{
	level.player thread maps\_player_exo::player_exo_activate();
}

//Function Number: 21
player_exo_disable()
{
	level.player thread maps\_player_exo::player_exo_deactivate();
}

//Function Number: 22
exo_temp_high_altitude()
{
	level endon("skyjack_done");
	wait(1);
	var_00 = 19.5;
	var_01 = 10;
	for(;;)
	{
		var_02 = 0;
		level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time(level.exo_reheat,var_00);
		while(var_02 <= var_00)
		{
			wait(0.05);
			var_02 = var_02 + 0.05;
		}

		level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time(level.exo_max,var_01);
		level.player thread maps\crash_exo_temperature::activate_heater();
		var_02 = 0;
		while(var_02 <= var_01)
		{
			wait(0.05);
			var_02 = var_02 + 0.05;
		}

		level.player thread maps\crash_exo_temperature::deactivate_heater();
	}
}

//Function Number: 23
exo_temp_outdoor()
{
	level endon("moved_indoors");
	var_00 = 39;
	var_01 = 10;
	for(;;)
	{
		var_02 = 0;
		level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time(level.exo_reheat,var_00);
		while(var_02 <= var_00)
		{
			wait(0.05);
			var_02 = var_02 + 0.05;
		}

		level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time(level.exo_max,var_01);
		level.player thread maps\crash_exo_temperature::activate_heater();
		var_02 = 0;
		while(var_02 <= var_01)
		{
			wait(0.05);
			var_02 = var_02 + 0.05;
		}

		level.player thread maps\crash_exo_temperature::deactivate_heater();
	}
}

//Function Number: 24
exo_temp_narrow_cave()
{
	level endon("player_starting_uw_breach");
	level endon("combat_cave_done");
	level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(-3.2,90);
	for(;;)
	{
		while(!isdefined(level.player.swimming))
		{
			if(common_scripts\utility::flag("narrow_cave_underwater"))
			{
				level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time(85,2);
				level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time(98.6,2);
				common_scripts\utility::flag_clear("narrow_cave_underwater");
			}

			wait(0.05);
		}

		while(isdefined(level.player.swimming))
		{
			if(level.player.swimming == "underwater")
			{
				if(!common_scripts\utility::flag("narrow_cave_underwater"))
				{
					level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time(65,8);
					level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time(92.5,8);
					common_scripts\utility::flag_set("narrow_cave_underwater");
				}
			}

			wait(0.05);
		}
	}
}

//Function Number: 25
handle_objective_marker_skyjack(param_00,param_01,param_02)
{
	var_03 = 1;
	if(!isdefined(param_02))
	{
		param_02 = 200;
	}

	var_04 = getent("skyjack_charge_trigger","targetname");
	var_05 = param_00 maps\_shg_utility::hint_button_position("x",param_00.origin,undefined,param_02,undefined,var_04);
	common_scripts\utility::flag_wait(param_01);
	var_05 maps\_shg_utility::hint_button_clear();
}

//Function Number: 26
handle_objective_marker(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	if(!isdefined(param_02))
	{
		param_02 = 200;
	}

	if(isdefined(param_03))
	{
		var_05 = getent(param_03,"targetname");
		var_06 = param_00 maps\_shg_utility::hint_button_position("x",param_00.origin,undefined,param_02,undefined,var_05);
	}
	else
	{
		var_06 = param_01 maps\_shg_utility::hint_button_trigger("x",param_03);
	}

	common_scripts\utility::flag_wait(param_01);
	var_06 maps\_shg_utility::hint_button_clear();
}

//Function Number: 27
handle_objective_marker_movable(param_00,param_01,param_02)
{
	var_03 = 1;
	if(!isdefined(param_02))
	{
		param_02 = 200;
	}

	var_04 = getent("end_cargo_trigger","targetname");
	var_05 = param_00 maps\_shg_utility::hint_button_tag("x","tag_origin",undefined,param_02,undefined,var_04);
	common_scripts\utility::flag_wait(param_01);
	if(isdefined(var_05))
	{
		var_05 maps\_shg_utility::hint_button_clear();
	}
}

//Function Number: 28
nag_until_flag(param_00,param_01,param_02,param_03,param_04)
{
	if(common_scripts\utility::flag(param_01))
	{
		return;
	}

	var_05 = -1;
	var_06 = param_02;
	var_07 = param_03;
	while(!common_scripts\utility::flag(param_01))
	{
		var_08 = randomfloatrange(param_02,param_03);
		wait(var_08);
		var_09 = randomint(param_00.size);
		if(var_09 == var_05)
		{
			var_09++;
			if(var_09 >= param_00.size)
			{
				var_09 = 0;
			}
		}

		var_0A = param_00[var_09];
		if(common_scripts\utility::flag(param_01))
		{
			break;
		}

		thread maps\_utility::smart_radio_dialogue(var_0A);
		var_05 = var_09;
		param_02 = param_02 + param_04;
		param_02 = clamp(param_02,var_06,var_06 + param_04 * 3);
		param_03 = param_03 + param_04;
		param_03 = clamp(param_03,var_07,var_07 + param_04 * 3);
	}
}

//Function Number: 29
stop_walk_and_clear_dialogue()
{
	level.cormack maps\_utility::clear_run_anim();
	level.ilana maps\_utility::clear_run_anim();
	level notify("temp_dialogue");
	if(isdefined(level.tmp_subtitle))
	{
		temp_dialogue_fade();
	}
}

//Function Number: 30
temp_friendly_squad_casual_walk()
{
	iprintln("casual walk on");
	level.cormack.animname = "cormack";
	level.ilana.animname = "ilana";
	level.cormack maps\_utility::set_run_anim("casual_walk");
	level.cormack maps\_utility::disable_arrivals();
	level.cormack maps\_utility::disable_exits();
	level.ilana maps\_utility::set_run_anim("casual_walk");
	level.ilana maps\_utility::disable_arrivals();
	level.ilana maps\_utility::disable_exits();
}

//Function Number: 31
set_main_vol_and_retreat_vol(param_00,param_01,param_02,param_03)
{
	move_wave(param_00,param_01);
	thread retreat_volume(param_00,param_02,param_03);
}

//Function Number: 32
retreat_volume(param_00,param_01,param_02)
{
	var_03 = maps\_utility::get_living_ai_array(param_00,"script_noteworthy");
	maps\_utility::waittill_dead_or_dying(var_03,param_02);
	var_03 = maps\_utility::get_living_ai_array(param_00,"script_noteworthy");
	if(isstring(param_01))
	{
		param_01 = getent(param_01,"targetname");
	}

	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_03[var_04] setgoalvolumeauto(param_01);
	}
}

//Function Number: 33
retreat_volume_and_set_flag(param_00,param_01,param_02,param_03)
{
	retreat_volume(param_00,param_01,param_02);
	if(!isdefined(param_03))
	{
		return;
	}

	if(common_scripts\utility::flag_exist(param_03))
	{
		common_scripts\utility::flag_set(param_03);
	}
}

//Function Number: 34
move_wave(param_00,param_01)
{
	var_02 = maps\_utility::get_living_ai_array(param_00,"script_noteworthy");
	var_03 = getent(param_01,"targetname");
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_02[var_04] setgoalvolumeauto(var_03);
	}
}

//Function Number: 35
move_wave_random(param_00,param_01)
{
	var_02 = maps\_utility::get_living_ai_array(param_00,"script_noteworthy");
	var_03 = getent(param_01,"targetname");
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_02[var_04] setgoalvolumeauto(var_03);
		var_02[var_04].pathrandompercent = 100;
	}
}

//Function Number: 36
enemy_drop_traversal(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = var_02 maps\_utility::spawn_ai(1);
	var_04 = common_scripts\utility::getstruct(param_01,"targetname");
	var_03.animname = "enemy_drop";
	var_03.canjumppath = 1;
	var_03.ignoresuppression = 1;
	var_03 maps\_utility::set_allowdeath(1);
	var_04 thread maps\_anim::anim_single_solo(var_03,"drop_512");
	var_03 thread enemy_drop_fx();
	return var_03;
}

//Function Number: 37
enemy_drop_fx()
{
	self endon("death");
	wait(1.16);
	playfxontag(level._effect["crash_goliath_foot"],self,"tag_origin");
}

//Function Number: 38
cleanup_enemies(param_00,param_01)
{
	var_02 = maps\_utility::get_living_ai_array(param_00,"script_noteworthy");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_04 in var_02)
	{
		if(maps\_utility::player_can_see_ai(var_04))
		{
			if(param_01)
			{
				var_04 delete();
			}

			continue;
		}

		var_04 delete();
	}
}

//Function Number: 39
cleanupweaponsonground()
{
	var_00 = getentarray();
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.classname) && issubstr(var_02.classname,"weapon_"))
		{
			var_02 delete();
		}
	}
}

//Function Number: 40
ally_advance_ahead_upon_killing_group(param_00,param_01,param_02,param_03,param_04)
{
	maps\_utility::waittill_dead(param_00,param_01);
	iprintln("dead moving up");
	var_05 = undefined;
	if(isdefined(param_02))
	{
		var_05 = getent(param_02,"targetname");
		if(isdefined(var_05))
		{
			maps\_utility::activate_trigger_with_targetname(param_02);
			return;
		}
		else
		{
			iprintln("trig not available");
		}
	}

	if(isdefined(param_03))
	{
		var_05 = getent(param_02,"targetname");
		if(isdefined(var_05))
		{
			maps\_utility::activate_trigger_with_targetname(param_02);
			return;
		}
	}

	if(isdefined(param_04))
	{
		var_05 = getent(param_02,"targetname");
		if(isdefined(var_05))
		{
			maps\_utility::activate_trigger_with_targetname(param_02);
			return;
		}
	}
}

//Function Number: 41
kill_enemies(param_00)
{
	var_01 = maps\_utility::get_living_ai_array(param_00,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_03 kill();
	}
}

//Function Number: 42
spawn_wave_stagger(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_03 = [];
	var_04 = getentarray(param_00,"targetname");
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_03[var_05] = var_04[var_05] maps\_utility::spawn_ai(1);
		wait(param_01);
	}

	return var_03;
}

//Function Number: 43
warbird_shooting_think(param_00,param_01,param_02,param_03,param_04,param_05)
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
	thread warbird_fire_init_monitor();
	for(;;)
	{
		self waittill("warbird_fire");
		if(!isdefined(param_03))
		{
			thread warbird_fire_init(param_00,param_01,param_02);
			continue;
		}

		if(!isdefined(param_04))
		{
			thread warbird_ground_fire_init(param_00,param_01,param_02);
			continue;
		}

		thread warbird_ground_fire_no_enemy_init(param_00,param_01,param_02,param_05);
	}
}

//Function Number: 44
warbird_fire_init(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = self.mgturret[0];
	var_04 = self.mgturret[1];
	if(!isdefined(param_02))
	{
		param_02 = 1.25;
	}

	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_05 = getaiarray("allies");
		if(!maps\_utility::ent_flag_exist("dont_shoot_player") || !maps\_utility::ent_flag("dont_shoot_player"))
		{
			var_06 = 90;
			if(randomint(100) <= var_06)
			{
				var_05 = common_scripts\utility::array_add(var_05,level.player);
			}
		}

		var_07 = [];
		foreach(var_09 in var_05)
		{
			if(isdefined(var_09.ignoreme) && var_09.ignoreme)
			{
				continue;
			}
			else
			{
				var_07[var_07.size] = var_09;
			}
		}

		var_07 = sortbydistance(var_07,self.origin);
		var_0B = undefined;
		foreach(var_09 in var_07)
		{
			if(!isdefined(var_09))
			{
				continue;
			}

			if(!isalive(var_09))
			{
				continue;
			}

			if(isdefined(param_00) && param_00)
			{
				var_0D = self.mgturret[0] gettagorigin("tag_flash");
				var_0E = var_09 geteye();
				var_0F = vectornormalize(var_0E - var_0D);
				var_10 = var_0E + var_0F * 20;
				if(!sighttracepassed(var_10,var_0E,0,var_09,self.mgturret[0]))
				{
					continue;
				}
			}

			var_0B = var_09;
			break;
		}

		if(isdefined(var_0B))
		{
			var_03 settargetentity(var_0B);
			var_04 settargetentity(var_0B);
			var_03 turretfireenable();
			var_04 turretfireenable();
			var_03 startfiring();
			var_04 startfiring();
			warbird_wait_for_fire_target_done(var_0B,param_00,param_01);
			var_03 cleartargetentity();
			var_04 cleartargetentity();
			var_03 turretfiredisable();
			var_04 turretfiredisable();
		}

		wait(param_02);
	}

	var_03 turretfiredisable();
	var_04 turretfiredisable();
}

//Function Number: 45
warbird_ground_fire_init(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = self.mgturret[0];
	var_04 = self.mgturret[1];
	if(!isdefined(param_02))
	{
		param_02 = 1.25;
	}

	while(maps\_utility::ent_flag("fire_turrets"))
	{
		var_05 = common_scripts\utility::getstructarray("warbird_fire_targets","targetname");
		var_05 = sortbydistance(var_05,self.origin);
		var_06 = getaiarray("allies");
		if(!maps\_utility::ent_flag_exist("dont_shoot_player") || !maps\_utility::ent_flag("dont_shoot_player"))
		{
			var_07 = 90;
			if(randomint(100) <= var_07)
			{
				var_06 = common_scripts\utility::array_add(var_06,level.player);
			}
		}

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
				var_11 = var_0F + var_10 * 20;
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
			var_13 = var_05[0] common_scripts\utility::spawn_tag_origin();
			var_03 settargetentity(var_13);
			var_04 settargetentity(var_13);
			var_03 turretfireenable();
			var_04 turretfireenable();
			var_03 startfiring();
			var_04 startfiring();
			var_14 = distance2d(var_13.origin,var_0C.origin);
			var_15 = var_14 / 275;
			var_15 = maps\_utility::round_float(var_15,2);
			var_16 = 0;
			while(var_16 < var_15)
			{
				var_13 moveto(var_0C.origin + (0,0,16),var_15 - var_16);
				var_16 = var_16 + 0.05;
				wait(0.05);
			}

			var_03 settargetentity(var_0C);
			var_04 settargetentity(var_0C);
			warbird_wait_for_fire_target_done(var_0C,param_00,param_01);
			var_03 cleartargetentity();
			var_04 cleartargetentity();
			var_03 turretfiredisable();
			var_04 turretfiredisable();
			var_13 delete();
		}

		wait(param_02);
	}

	var_03 turretfiredisable();
	var_04 turretfiredisable();
}

//Function Number: 46
warbird_ground_fire_no_enemy_init(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = self.mgturret[0];
	var_05 = self.mgturret[1];
	if(!isdefined(param_02))
	{
		param_02 = 1.25;
	}

	var_06 = common_scripts\utility::getstructarray("warbird_fire_targets","targetname");
	var_06 = sortbydistance(var_06,self.origin);
	var_07 = var_06[0] common_scripts\utility::spawn_tag_origin();
	if(isdefined(var_06[0].target))
	{
		var_08 = common_scripts\utility::getstruct(var_06[0].target,"targetname");
	}
	else
	{
		var_08 = var_07[0] common_scripts\utility::spawn_tag_origin();
		var_09 = anglestoforward(self.angles);
		var_08.origin = var_08.origin + (var_09[0] * 500,var_09[1] * 500,0);
	}

	var_04 settargetentity(var_07);
	var_05 settargetentity(var_07);
	var_04 turretfireenable();
	var_05 turretfireenable();
	var_04 startfiring();
	var_05 startfiring();
	if(!isdefined(param_03))
	{
		param_03 = 275;
	}

	var_0A = distance2d(var_07.origin,var_08.origin);
	var_0B = var_0A / param_03;
	var_0B = maps\_utility::round_float(var_0B,2);
	var_0C = 0;
	while(var_0C < var_0B)
	{
		var_07 moveto(var_08.origin,var_0B - var_0C);
		var_0C = var_0C + 0.05;
		wait(0.05);
	}

	if(!maps\_utility::ent_flag_exist("turret_hit_target"))
	{
		maps\_utility::ent_flag_init("turret_hit_target");
	}

	maps\_utility::ent_flag_set("turret_hit_target");
	var_04 cleartargetentity();
	var_05 cleartargetentity();
	var_04 turretfiredisable();
	var_05 turretfiredisable();
	var_07 delete();
}

//Function Number: 47
warbird_fire_init_monitor()
{
	self endon("death");
	self waittill("warbird_stop_firing");
	maps\_utility::ent_flag_clear("fire_turrets");
}

//Function Number: 48
warbird_wait_for_fire_target_done(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(!maps\_utility::ent_flag("fire_turrets"))
	{
		return;
	}

	self endon("fire_turrets");
	if(!isdefined(param_02))
	{
		if(param_00 == level.player)
		{
			param_02 = 0.6;
		}
		else
		{
			param_02 = 3;
		}
	}

	var_03 = 0;
	while(var_03 < param_02)
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

//Function Number: 49
disable_exo_melee()
{
	maps\_player_exo::player_exo_remove_single("exo_melee");
}

//Function Number: 50
enable_exo_melee()
{
	maps\_player_exo::player_exo_add_single("exo_melee");
}

//Function Number: 51
mech_fire_rockets_special(param_00)
{
	self endon("death");
	var_01 = 48;
	var_02 = 64;
	var_03 = 3;
	var_04 = 6;
	var_05 = 100;
	var_06 = 24;
	var_07 = 0.1;
	var_08 = 0.4;
	var_09 = 12;
	var_0A = "tag_rocket";
	var_0B = 0.2;
	var_0C = randomintrange(var_03 + 1,var_04 + 1);
	var_0D = 20;
	var_0E = 20;
	var_0F = 16;
	for(var_10 = 1;var_10 < var_0C;var_10++)
	{
		var_11 = var_0A + var_10;
		var_12 = self gettagorigin(var_11);
		var_13 = self gettagangles(var_11);
		var_14 = anglestoforward(var_13);
		var_14 = vectornormalize(var_14);
		var_15 = randomintrange(-1 * var_0D,var_0D);
		var_16 = randomintrange(-1 * var_0E,var_0E);
		var_17 = randomintrange(-1 * var_0F,var_0F);
		var_18 = var_12 + var_14 * var_06;
		var_19 = var_12 + var_14 * var_05 + (var_15,var_16,var_17);
		var_1A = magicbullet("mech_rocket_deploy",var_18,var_19);
		playfx(level.mech_fx["rocket_muzzle_flash"],var_12,var_14,(0,0,1));
		if(isdefined(var_1A))
		{
			var_1B = randomfloatrange(var_07,var_08);
			var_1A thread maps\_mech::mech_rocket_deploy_projectile_think(self,param_00,var_1B);
		}

		wait(0.05);
	}

	wait(0.25);
}

//Function Number: 52
fly_in_hud()
{
	setsaveddvar("cg_cinematicfullscreen","1");
	setsaveddvar("cg_cinematicCanPause","1");
	level.player thread fly_in_hud_overlay(undefined,undefined,undefined,1,0,0);
	cinematicingameloopresident("crash_jumpHUD_loop");
	common_scripts\utility::flag_wait("start_hud");
	cinematicingame("crash_jumpHUD",0,1,1);
	wait(1);
	level.player thread thermal_with_nvg();
	level.player setclutforplayer("clut_crash_hud",0);
	level.player lightsetforplayer("crash_skyjack");
	maps\_utility::vision_set_fog_changes("crash_skyjack",0);
	wait 0.05;
	if(level.nextgen)
	{
		level.player notify("sonar_vision");
	}

	wait(29.5);
	level.player notify("sonar_vision");
	killfxontag(level._effect["fx_crash_hud_flare"],level.crashing_plane,"body_animate_jnt");
	level.crashing_plane hudoutlinedisable();
	level.player setclutforplayer("clut_crash_crash_site",0);
	maps\_utility::vision_set_fog_changes("crash_crash_site_cinematic",0);
	level.player lightsetforplayer("crash_crash_site");
	wait 0.05;
	level.player notify("flag_end_sonar_vision");
	wait(1.25);
	setsaveddvar("cg_cinematicfullscreen","0");
	setsaveddvar("cg_cinematicCanPause","0");
}

//Function Number: 53
fly_in_hud_overlay(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = newclienthudelem(self);
	var_06.x = param_04;
	var_06.y = param_05;
	var_06 setshader("jump_hud_vignette",640,480);
	var_06.alignx = "left";
	var_06.aligny = "top";
	var_06.sort = 1;
	var_06.foreground = 0;
	var_06.horzalign = "fullscreen";
	var_06.vertalign = "fullscreen";
	var_06.alpha = 1;
	var_07 = 0;
	level.player waittill("flag_end_sonar_vision");
	var_06.alpha = 0;
	var_06 destroy();
}

//Function Number: 54
mark_enemies()
{
	level.player endon("sonar_vision_off");
	common_scripts\utility::flag_wait("begin_crash_site_lighting");
	wait(3);
	for(;;)
	{
		if(isdefined(level.crashing_plane))
		{
			level.crashing_plane hudoutlineenable(4,0,0);
		}

		wait(0.1);
	}
}

//Function Number: 55
give_night_vision()
{
	level endon("flag_end_sonar_vision");
	level.player setweaponhudiconoverride("actionslot4","dpad_icon_nvg");
	level.player notifyonplayercommand("sonar_vision","+actionslot 4");
	level.player thread thermal_with_nvg();
}

//Function Number: 56
is_sonar_vision_allowed()
{
	var_00 = level.player getcurrentweapon();
	if(weaponhasthermalscope(var_00) && level.player playerads() > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 57
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

//Function Number: 58
thermal_with_nvg()
{
	level endon("flag_end_sonar_vision");
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	if(level.nextgen)
	{
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
}

//Function Number: 59
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

//Function Number: 60
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

//Function Number: 61
sonar_on()
{
	level.overlaysonar = create_hud_sonar_overlay(0,1);
	sonar_save_and_set_dvars();
	thread mark_enemies();
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 0;
	}

	soundscripts\_snd::snd_message("aud_sonar_vision_on");
	level.player.sonar_vision = 1;
	level notify("sonar_update");
}

//Function Number: 62
sonar_off()
{
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 0;
	}

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

//Function Number: 63
create_hud_nvg_overlay(param_00,param_01,param_02)
{
	var_03 = newhudelem();
	var_03.x = 0;
	var_03.y = 0;
	var_03.sort = param_01;
	var_03.horzalign = "fullscreen";
	var_03.vertalign = "fullscreen";
	var_03.alpha = param_02;
	var_03 setshader(param_00,640,480);
	return var_03;
}

//Function Number: 64
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

//Function Number: 65
create_hud_threat_overlay(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = 0;
	var_02.y = 0;
	var_02.color = (1,0.1,0.1);
	var_02.sort = param_00;
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02.alpha = param_01;
	var_02 setradarhighlight(-1);
	return var_02;
}