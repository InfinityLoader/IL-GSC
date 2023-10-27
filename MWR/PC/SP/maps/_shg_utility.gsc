/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_shg_utility.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 57
 * Decompile Time: 877 ms
 * Timestamp: 10/27/2023 2:48:37 AM
*******************************************************************/

//Function Number: 1
move_player_to_start(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.start_point + "_playerstart";
	}

	var_01 = common_scripts\utility::getstruct(param_00,"targetname");
	if(isdefined(var_01))
	{
		maps\_utility::teleport_player(var_01);
	}
}

//Function Number: 2
spawn_friendlies(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_04 = getentarray(param_01,"script_noteworthy");
	var_05 = [];
	var_06 = 0;
	var_07 = [];
	foreach(var_09 in var_04)
	{
		if(isspawner(var_09))
		{
			var_05[var_05.size] = var_09;
		}
	}

	var_0B = common_scripts\utility::getstruct(param_00,"targetname");
	var_0C = 0;
	foreach(var_0E in var_05)
	{
		var_0F = var_0E maps\_utility::spawn_ai(1);
		if(param_02)
		{
			var_0F thread maps\_utility::replace_on_death();
		}

		var_0F forceteleport(var_0B.origin,var_0B.angles);
		var_0F setgoalpos(var_0F.origin);
		var_07 = common_scripts\utility::array_add(var_07,var_0F);
		var_0C++;
		if(isdefined(param_03) && var_0C >= param_03)
		{
			return var_07;
		}
	}

	return var_07;
}

//Function Number: 3
setup_player_for_scene(param_00,param_01)
{
	self allowmelee(0);
	self disableweapons();
	self disableoffhandweapons();
	self allowstand(1);
	self allowcrouch(0);
	self allowprone(0);
	self allowsprint(0);
	setsaveddvar("ammoCounterHide",1);
	if(isdefined(param_00) && param_00)
	{
		var_02 = 0;
		var_03 = 0;
		while(self getstance() != "stand")
		{
			self setstance("stand");
			wait 0.05;
			var_03 = var_03 + 0.05;
		}

		while(self isthrowinggrenade() || self isswitchingweapon() || self getcurrentweapon(0) != "none")
		{
			wait 0.05;
			var_03 = var_03 + 0.05;
		}

		if(isdefined(param_01) && param_01 > var_03)
		{
			wait(param_01 - var_03);
		}
	}
}

//Function Number: 4
setup_player_for_gameplay()
{
	setsaveddvar("ammoCounterHide",0);
	self allowsprint(1);
	self allowprone(1);
	self allowcrouch(1);
	self allowstand(1);
	self enableoffhandweapons();
	self enableweapons();
	self allowmelee(1);
}

//Function Number: 5
monitorscopechange()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.sniper_zoom_hint_hud))
		{
			var_01.sniper_zoom_hint_hud = var_01 maps\_hud_util::createclientfontstring("default",1.75);
			var_01.sniper_zoom_hint_hud.horzalign = "center";
			var_01.sniper_zoom_hint_hud.vertalign = "top";
			var_01.sniper_zoom_hint_hud.alignx = "center";
			var_01.sniper_zoom_hint_hud.aligny = "top";
			var_01.sniper_zoom_hint_hud.x = 0;
			var_01.sniper_zoom_hint_hud.y = 20;
			var_01.sniper_zoom_hint_hud settext(&"VARIABLE_SCOPE_SNIPER_ZOOM");
			var_01.sniper_zoom_hint_hud.alpha = 0;
			var_01.sniper_zoom_hint_hud.sort = 0.5;
			var_01.sniper_zoom_hint_hud.foreground = 1;
		}

		var_01.fov_snipe = 1;
	}

	var_03 = 0;
	level.players[0].sniper_dvar = "cg_playerFovScale0";
	if(level.players.size == 2)
	{
		level.players[1].sniper_dvar = "cg_playerFovScale1";
	}

	foreach(var_01 in level.players)
	{
		var_01 thread monitormagcycle();
		var_01 thread disablevariablescopehudondeath();
	}

	if(!isdefined(level.variable_scope_weapons))
	{
		level.variable_scope_weapons = [];
	}

	var_06 = undefined;
	var_07 = undefined;
	for(;;)
	{
		var_08 = 0;
		var_07 = var_06;
		var_06 = undefined;
		foreach(var_0A in level.variable_scope_weapons)
		{
			foreach(var_01 in level.players)
			{
				if(var_01 getcurrentweapon() == var_0A && isalive(var_01))
				{
					var_08 = 1;
					var_06 = var_01;
					break;
				}
			}

			if(var_08)
			{
				break;
			}
		}

		if(var_08 && !var_06 isreloading() && !var_06 isswitchingweapon())
		{
			if(var_06 maps\_utility::isads() && var_06 adsbuttonpressed())
			{
				var_06 turnonvariablescopehud(var_03);
				var_03 = 1;
				if(isdefined(level.variable_scope_shadow_center))
				{
					var_0E = undefined;
					var_0F = undefined;
					var_10 = anglestoforward(var_06 getplayerangles());
					var_11 = var_06.origin;
					foreach(var_13 in level.variable_scope_shadow_center)
					{
						var_14 = anglestoforward(vectortoangles(var_13 - var_11));
						var_15 = vectordot(var_10,var_14);
						if(!isdefined(var_0E) || var_15 > var_0F)
						{
							var_0E = var_13;
							var_0F = var_15;
						}
					}

					if(isdefined(var_0E))
					{
						setsaveddvar("sm_sunShadowCenter",var_0E);
					}
				}
			}
			else if(var_03)
			{
				var_03 = 0;
				if(isdefined(var_06))
				{
					var_06 turnoffvariablescopehud();
				}

				setsaveddvar("sm_sunShadowCenter","0 0 0");
			}
		}
		else if(var_03)
		{
			var_03 = 0;
			if(isdefined(var_07))
			{
				var_07 turnoffvariablescopehud();
			}

			setsaveddvar("sm_sunShadowCenter","0 0 0");
		}

		wait(0.05);
	}
}

//Function Number: 6
turnonvariablescopehud(param_00)
{
	self disableoffhandweapons();
	setsaveddvar(self.sniper_dvar,self.fov_snipe);
	self.sniper_zoom_hint_hud.alpha = 1;
	if(!param_00)
	{
		level notify("variable_sniper_hud_enter");
	}
}

//Function Number: 7
turnoffvariablescopehud()
{
	level notify("variable_sniper_hud_exit");
	self enableoffhandweapons();
	setsaveddvar(self.sniper_dvar,1);
	self.sniper_zoom_hint_hud.alpha = 0;
}

//Function Number: 8
monitormagcycle()
{
	notifyoncommand("mag_cycle","+melee_zoom");
	notifyoncommand("mag_cycle","+sprint_zoom");
	for(;;)
	{
		self waittill("mag_cycle");
		if(self.sniper_zoom_hint_hud.alpha)
		{
			if(self.fov_snipe == 0.5)
			{
				self.fov_snipe = 1;
				continue;
			}

			self.fov_snipe = 0.5;
		}
	}
}

//Function Number: 9
disablevariablescopehudondeath()
{
	self waittill("death");
	turnoffvariablescopehud();
}

//Function Number: 10
dialogue_reminder(param_00,param_01,param_02,param_03,param_04)
{
	level endon("stop_reminders");
	level endon("missionfailed");
	var_05 = undefined;
	if(!isdefined(param_03))
	{
		param_03 = 10;
	}

	if(!isdefined(param_04))
	{
		param_04 = 20;
	}

	while(!common_scripts\utility::flag(param_01))
	{
		var_06 = randomfloatrange(param_03,param_04);
		var_07 = common_scripts\utility::random(param_02);
		if(isdefined(var_05) && var_07 == var_05)
		{
			continue;
		}
		else
		{
			var_05 = var_07;
			wait(var_06);
			if(!common_scripts\utility::flag(param_01))
			{
				if(isstring(param_00) && param_00 == "radio")
				{
					conversation_start();
					maps\_utility::radio_dialogue(var_07);
					conversation_stop();
					continue;
				}

				conversation_start();
				param_00 maps\_utility::dialogue_queue(var_07);
				conversation_stop();
			}
		}
	}
}

//Function Number: 11
conversation_start()
{
	if(!common_scripts\utility::flag_exist("flag_conversation_in_progress"))
	{
		common_scripts\utility::flag_init("flag_conversation_in_progress");
	}

	common_scripts\utility::flag_waitopen("flag_conversation_in_progress");
	common_scripts\utility::flag_set("flag_conversation_in_progress");
}

//Function Number: 12
conversation_stop()
{
	common_scripts\utility::flag_clear("flag_conversation_in_progress");
}

//Function Number: 13
array_combine_unique(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(common_scripts\utility::array_find(var_02,var_04)))
		{
			var_02[var_02.size] = var_04;
		}
	}

	foreach(var_04 in param_01)
	{
		if(!isdefined(common_scripts\utility::array_find(var_02,var_04)))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 14
laser_targeting_device(param_00)
{
	param_00 endon("remove_laser_targeting_device");
	param_00.lastusedweapon = undefined;
	param_00.laserforceon = 0;
	param_00 setweaponhudiconoverride("actionslot4","dpad_laser_designator");
	param_00 thread cleanuplasertargetingdevice();
	param_00 notifyonplayercommand("use_laser","+actionslot 4");
	param_00 notifyonplayercommand("fired_laser","+attack");
	param_00 notifyonplayercommand("fired_laser","+attack_akimbo_accessible");
	param_00.laserallowed = 1;
	param_00.lasercooldownafterhit = 20;
	param_00 childthread monitorlaseroff();
	for(;;)
	{
		param_00 waittill("use_laser");
		if(param_00.laserforceon || !param_00.laserallowed || param_00 shouldforcedisablelaser())
		{
			param_00 notify("cancel_laser");
			param_00 laseroff();
			param_00.laserforceon = 0;
			param_00 allowads(1);
			wait(0.2);
			param_00 allowfire(1);
			continue;
		}

		param_00 laseron();
		param_00 allowfire(0);
		param_00.laserforceon = 1;
		param_00 allowads(0);
		param_00 thread laser_designate_target();
	}
}

//Function Number: 15
shouldforcedisablelaser()
{
	var_00 = self getcurrentweapon();
	if(var_00 == "rpg")
	{
		return 1;
	}

	if(common_scripts\utility::string_starts_with(var_00,"gl"))
	{
		return 1;
	}

	if(isdefined(level.laser_designator_disable_list) && isarray(level.laser_designator_disable_list))
	{
		foreach(var_02 in level.laser_designator_disable_list)
		{
			if(var_00 == var_02)
			{
				return 1;
			}
		}
	}

	if(self isreloading())
	{
		return 1;
	}

	if(self isthrowinggrenade())
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
cleanuplasertargetingdevice()
{
	self waittill("remove_laser_targeting_device");
	self setweaponhudiconoverride("actionslot4","none");
	self notify("cancel_laser");
	self laseroff();
	self.laserforceon = undefined;
	self allowfire(1);
	self allowads(1);
}

//Function Number: 17
monitorlaseroff()
{
	for(;;)
	{
		if(shouldforcedisablelaser() && isdefined(self.laserforceon) && self.laserforceon)
		{
			self notify("use_laser");
			wait(2);
		}

		wait(0.05);
	}
}

//Function Number: 18
laser_designate_target()
{
	self endon("cancel_laser");
	for(;;)
	{
		self waittill("fired_laser");
		var_00 = get_laser_designated_trace();
		var_01 = var_00["position"];
		var_02 = var_00["entity"];
		level notify("laser_coordinates_received");
		var_03 = undefined;
		if(isdefined(level.laser_targets) && isdefined(var_02) && common_scripts\utility::array_contains(level.laser_targets,var_02))
		{
			var_03 = var_02;
			level.laser_targets = common_scripts\utility::array_remove(level.laser_targets,var_02);
		}
		else
		{
			var_03 = gettargettriggerhit(var_01);
		}

		if(isdefined(var_03))
		{
			thread laser_artillery(var_03);
			level notify("laser_target_painted");
			wait(0.5);
			self notify("use_laser");
		}
	}
}

//Function Number: 19
gettargettriggerhit(param_00)
{
	if(!isdefined(level.laser_triggers) || level.laser_triggers.size == 0)
	{
		return undefined;
	}

	foreach(var_02 in level.laser_triggers)
	{
		var_03 = distance2d(param_00,var_02.origin);
		var_04 = param_00[2] - var_02.origin[2];
		if(!isdefined(var_02.radius))
		{
			continue;
		}

		if(!isdefined(var_02.height))
		{
			continue;
		}

		if(var_03 <= var_02.radius && var_04 <= var_02.height && var_04 >= 0)
		{
			level.laser_triggers = common_scripts\utility::array_remove(level.laser_triggers,var_02);
			return getent(var_02.target,"script_noteworthy");
		}
	}

	return undefined;
}

//Function Number: 20
get_laser_designated_trace()
{
	var_00 = self geteye();
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = var_00 + var_02 * 7000;
	var_04 = bullettrace(var_00,var_03,1,self);
	var_05 = var_04["entity"];
	if(isdefined(var_05))
	{
		var_04["position"] = var_05.origin;
	}

	return var_04;
}

//Function Number: 21
laser_artillery(param_00)
{
	level.player endon("remove_laser_targeting_device");
	level.player.laserallowed = 0;
	self setweaponhudiconoverride("actionslot4","dpad_killstreak_hellfire_missile_inactive");
	maps\_utility::flavorbursts_off("allies");
	var_01 = level.player;
	wait(2.5);
	if(!isdefined(param_00.script_index))
	{
		param_00.script_index = 99;
	}

	wait(1);
	if(isdefined(param_00.script_group))
	{
		var_02 = get_geo_group("geo_before",param_00.script_group);
		if(var_02.size > 0)
		{
			common_scripts\utility::array_call(var_02,::hide);
		}

		var_03 = get_geo_group("geo_after",param_00.script_group);
		if(var_03.size > 0)
		{
			common_scripts\utility::array_call(var_03,::show);
		}
	}

	wait(level.player.lasercooldownafterhit);
	level.player.laserallowed = 1;
	self setweaponhudiconoverride("actionslot4","dpad_laser_designator");
}

//Function Number: 22
get_geo_group(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05.script_group) && var_05.script_group == param_01)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 23
linear_map(param_00,param_01,param_02,param_03,param_04)
{
	return param_03 + param_00 - param_01 * param_04 - param_03 / param_02 - param_01;
}

//Function Number: 24
linear_map_clamp(param_00,param_01,param_02,param_03,param_04)
{
	return clamp(linear_map(param_00,param_01,param_02,param_03,param_04),min(param_03,param_04),max(param_03,param_04));
}

//Function Number: 25
differentiate_motion()
{
	var_00 = gettime() * 0.001;
	if(!isdefined(self.differentiated_last_update))
	{
		self.differentiated_last_update = var_00;
		self.differentiated_last_origin = self.origin;
		self.differentiated_last_velocity = (0,0,0);
		self.differentiated_last_acceleration = (0,0,0);
		self.differentiated_jerk = (0,0,0);
		self.differentiated_acceleration = (0,0,0);
		self.differentiated_velocity = (0,0,0);
		self.differentiated_speed = 0;
		return;
	}

	if(self.differentiated_last_update != var_00)
	{
		var_01 = var_00 - self.differentiated_last_update;
		self.differentiated_last_update = var_00;
		self.differentiated_jerk = self.differentiated_acceleration - self.differentiated_last_acceleration / var_01;
		self.differentiated_last_acceleration = self.differentiated_acceleration;
		self.differentiated_acceleration = self.differentiated_velocity - self.differentiated_last_velocity / var_01;
		self.differentiated_last_velocity = self.differentiated_velocity;
		self.differentiated_velocity = self.origin - self.differentiated_last_origin / var_01;
		self.differentiated_last_origin = self.origin;
		self.differentiated_speed = length(self.differentiated_velocity);
	}
}

//Function Number: 26
get_differentiated_speed()
{
	differentiate_motion();
	return self.differentiated_speed;
}

//Function Number: 27
get_differentiated_velocity()
{
	differentiate_motion();
	return self.differentiated_velocity;
}

//Function Number: 28
get_differentiated_acceleration()
{
	differentiate_motion();
	return self.differentiated_acceleration;
}

//Function Number: 29
get_differentiated_jerk()
{
	differentiate_motion();
	return self.differentiated_jerk;
}

//Function Number: 30
show_player_hud(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00))
	{
		setsaveddvar("g_friendlyNameDist",param_00);
	}
	else
	{
		setsaveddvar("g_friendlyNameDist",15000);
	}

	if(isdefined(param_01))
	{
		setsaveddvar("compass",param_01);
	}
	else
	{
		setsaveddvar("compass","1");
	}

	if(isdefined(param_02))
	{
		setsaveddvar("ammoCounterHide",param_02);
	}
	else
	{
		setsaveddvar("ammoCounterHide","0");
	}

	if(isdefined(param_03))
	{
		setsaveddvar("actionSlotsHide",param_03);
	}
	else
	{
		setsaveddvar("actionSlotsHide","0");
	}

	if(isdefined(param_04))
	{
		setsaveddvar("hud_showStance",param_04);
		return;
	}

	setsaveddvar("hud_showStance","1");
}

//Function Number: 31
hide_player_hud(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00))
	{
		setsaveddvar("g_friendlyNameDist",param_00);
	}
	else
	{
		setsaveddvar("g_friendlyNameDist",0);
	}

	if(isdefined(param_01))
	{
		setsaveddvar("compass",param_01);
	}
	else
	{
		setsaveddvar("compass","0");
	}

	if(isdefined(param_02))
	{
		setsaveddvar("ammoCounterHide",param_02);
	}
	else
	{
		setsaveddvar("ammoCounterHide","1");
	}

	if(isdefined(param_03))
	{
		setsaveddvar("actionSlotsHide",param_03);
	}
	else
	{
		setsaveddvar("actionSlotsHide","1");
	}

	if(isdefined(param_04))
	{
		setsaveddvar("hud_showStance",param_04);
		return;
	}

	setsaveddvar("hud_showStance","0");
}

//Function Number: 32
disable_features_entering_cinema(param_00)
{
	hide_player_hud();
}

//Function Number: 33
enable_features_exiting_cinema(param_00)
{
	show_player_hud();
}

//Function Number: 34
handle_portal_group(param_00,param_01,param_02)
{
	level.player endon("death");
	level endon("missionfailed");
	if(isdefined(param_02) && isstring(param_02))
	{
		level endon(param_02);
	}

	if(!isdefined(param_00) || !isstring(param_00))
	{
		return;
	}

	if(!isdefined(param_01) || !isstring(param_01) || !common_scripts\utility::flag_exist(param_00))
	{
		return;
	}

	var_03 = getent(param_01,"targetname");
	if(!isdefined(var_03))
	{
		var_03 = getent(param_01,"script_noteworthy");
	}

	if(!isdefined(var_03))
	{
		return;
	}

	var_03 enableportalgroup(0);
	for(;;)
	{
		common_scripts\utility::flag_wait(param_00);
		var_03 enableportalgroup(1);
		common_scripts\utility::flag_waitopen(param_00);
		var_03 enableportalgroup(0);
		wait(0.05);
	}
}

//Function Number: 35
portal_group_on(param_00,param_01)
{
	level.player endon("death");
	level endon("missionfailed");
	if(!isdefined(param_00) || !isstring(param_00))
	{
		return;
	}

	if(!isdefined(param_01) || !isstring(param_01) || !common_scripts\utility::flag_exist(param_00))
	{
		return;
	}

	var_02 = getent(param_01,"targetname");
	if(!isdefined(var_02))
	{
		var_02 = getent(param_01,"script_noteworthy");
	}

	if(!isdefined(var_02))
	{
		return;
	}

	var_02 enableportalgroup(0);
	common_scripts\utility::flag_wait(param_00);
	var_02 enableportalgroup(1);
}

//Function Number: 36
portal_group_off(param_00,param_01)
{
	level.player endon("death");
	level endon("missionfailed");
	if(!isdefined(param_00) || !isstring(param_00))
	{
		return;
	}

	if(!isdefined(param_01) || !isstring(param_01) || !common_scripts\utility::flag_exist(param_00))
	{
		return;
	}

	var_02 = getent(param_01,"targetname");
	if(!isdefined(var_02))
	{
		var_02 = getent(param_01,"script_noteworthy");
	}

	if(!isdefined(var_02))
	{
		return;
	}

	common_scripts\utility::flag_wait(param_00);
	var_02 enableportalgroup(0);
}

//Function Number: 37
make_emp_vulnerable()
{
	if(!isdefined(level.emp_vulnerable_list))
	{
		level.emp_vulnerable_list = [];
	}

	level.emp_vulnerable_list = common_scripts\utility::array_add(level.emp_vulnerable_list,self);
	self waittill("death");
	level.emp_vulnerable_list = common_scripts\utility::array_remove(level.emp_vulnerable_list,self);
}

//Function Number: 38
play_fx_with_handle(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.fx_id = common_scripts\utility::getfx(param_00);
	var_04.entity = param_01;
	var_04.tag = param_02;
	if(isdefined(param_03) && param_03)
	{
		var_04.tag_origin = common_scripts\utility::spawn_tag_origin();
		var_04.tag_origin linkto(param_01,var_04.tag,(0,0,0),(0,0,0));
		playfxontag(var_04.fx_id,var_04.tag_origin,"tag_origin");
		kill_fx_with_handle_on_death(var_04);
	}
	else
	{
		playfxontag(var_04.fx_id,var_04.entity,var_04.tag);
	}

	return var_04;
}

//Function Number: 39
kill_fx_with_handle_on_death(param_00)
{
	thread kill_fx_with_handle_on_death_internal(param_00);
}

//Function Number: 40
kill_fx_with_handle_on_death_internal(param_00)
{
	param_00.entity waittill("death");
	kill_fx_with_handle(param_00);
}

//Function Number: 41
kill_fx_with_handle(param_00)
{
	if(isdefined(param_00.tag_origin))
	{
		killfxontag(param_00.fx_id,param_00.tag_origin,"tag_origin");
		param_00.tag_origin common_scripts\utility::delaycall(0.05,::delete);
		param_00.tag_origin = undefined;
		param_00.entity = undefined;
		return;
	}

	if(isdefined(param_00.entity))
	{
		killfxontag(param_00.fx_id,param_00.entity,param_00.tag);
		param_00.entity = undefined;
	}
}

//Function Number: 42
hint_button_trigger(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 200;
	}

	return hint_button_position(param_00,self.origin,undefined,param_01,undefined,self);
}

//Function Number: 43
hint_button_tag(param_00,param_01,param_02,param_03,param_04,param_05)
{
	return hint_button_create(param_00,param_01,param_02,param_03,0,param_04,param_05);
}

//Function Number: 44
hint_button_position(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = common_scripts\utility::spawn_tag_origin();
	if(!isdefined(param_01))
	{
		if(isdefined(param_05))
		{
			param_01 = param_05.origin;
		}
		else
		{
			param_01 = self.origin;
		}
	}

	var_06.origin = param_01;
	return var_06 hint_button_create(param_00,"tag_origin",param_02,param_03,1,param_04,param_05);
}

//Function Number: 45
hint_button_create(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = newclienthudelem(level.player);
	var_07.alignx = "center";
	var_07.aligny = "middle";
	var_07.fontscale = 3;
	var_07.font = "buttonprompt";
	var_07.positioninworld = 1;
	if(isdefined(self))
	{
		if(isdefined(param_01))
		{
			var_07 settargetent(self,param_01);
		}
		else
		{
			var_07 settargetent(self);
		}
	}

	var_08 = hint_button_string_lookup(param_00);
	var_07 settext(var_08);
	var_07.hidewheninmenu = 1;
	var_07.sort = -1;
	var_07.alpha = 1;
	if(!isdefined(param_05) || !param_05)
	{
		var_07 thread scale_3d_hint_button(self,param_01,level.player,param_02,param_03,param_06);
	}

	var_07.object = self;
	if(isdefined(param_04) && param_04)
	{
		var_07.deleteobjectwhendone = 1;
	}

	return var_07;
}

//Function Number: 46
scale_3d_hint_button(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	param_00 endon("death");
	if(!isdefined(param_03))
	{
		param_03 = getdvarint("player_useradius");
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_06 = 0;
	self.fontscale = 2;
	self.font = "buttonprompt";
	for(;;)
	{
		if(isdefined(param_01))
		{
			var_06 = distance(param_00 gettagorigin(param_01),param_02 geteye());
		}
		else
		{
			var_06 = distance(param_00,param_02 geteye());
		}

		if(param_04 != 0 && var_06 > param_04)
		{
			self.alpha = 0;
		}
		else if(param_03 != 0 && var_06 > param_03)
		{
			if(param_04 - param_03 > 0)
			{
				self.alpha = 1 - var_06 - param_03 / param_04 - param_03 * 0.3;
			}
			else
			{
				self.alpha = 0.3;
			}
		}
		else if(isdefined(param_05) && isdefined(param_05.classname) && issubstr(param_05.classname,"trigger"))
		{
			var_07 = param_02 method_8516();
			if(isdefined(var_07) && var_07 == param_05)
			{
				self.alpha = 1;
			}
			else
			{
				self.alpha = 0.3;
			}
		}
		else
		{
			self.alpha = 1;
		}

		wait 0.05;
	}
}

//Function Number: 47
hint_button_string_lookup(param_00)
{
	switch(param_00)
	{
		case "activate":
		case "usereload":
		case "use":
		case "x":
		case "reload":
			break;

		case "gostand":
		case "jump":
		case "a":
			break;

		case "weapnext":
		case "y":
			break;

		case "stance":
		case "b":
		case "crouch":
			break;

		case "rs":
		case "melee":
			break;

		case "breath":
		case "ls":
		case "sprint":
			break;

		case "attack":
		case "r1":
		case "rt":
			break;

		case "frag":
		case "r2":
		case "rb":
		case "grenade":
			break;

		case "ads":
		case "l1":
		case "lt":
			break;

		case "flash":
		case "smoke":
		case "l2":
		case "lb":
		case "flashbang":
			break;

		case "pause":
		case "start":
			break;

		case "up":
			break;

		case "down":
			break;

		case "left":
			break;

		case "right":
			break;

		default:
			break;
	}
}

//Function Number: 48
hint_button_clear()
{
	if(isdefined(self.deleteobjectwhendone) && self.deleteobjectwhendone)
	{
		self.object delete();
	}

	if(isdefined(self))
	{
		self destroy();
	}
}

//Function Number: 49
hint_button_flash(param_00,param_01)
{
	while(isdefined(self))
	{
		var_02 = self.alpha;
		self fadeovertime(param_00 / 3);
		self.alpha = param_01;
		wait(param_00);
		if(!isdefined(self))
		{
			return;
		}

		self fadeovertime(param_00 / 3);
		self.alpha = var_02;
		wait(param_00);
	}
}

//Function Number: 50
button_mash_dynamic_hint(param_00,param_01,param_02,param_03)
{
	self endon(param_02);
	level.player endon(param_02);
	self endon("death");
	thread maps\_utility::hint(param_00);
	var_04 = param_01 + "_button_mash_dynamic_hint";
	thread buttonmash_hint_cleanup(param_02,var_04,param_01,param_03);
	level.player notifyonplayercommand(var_04,param_01);
	if(isdefined(param_03))
	{
		level.player notifyonplayercommand(var_04,param_03);
	}

	for(;;)
	{
		self waittill(var_04);
		level.hintelement.alpha = 0.2;
		level.hintelement fadeovertime(0.3);
		level.hintelement.alpha = 1;
		wait 0.05;
	}
}

//Function Number: 51
buttonmash_hint_cleanup(param_00,param_01,param_02,param_03)
{
	self endon("death");
	common_scripts\utility::waittill_any_ents(self,param_00,level.player,param_00);
	thread maps\_utility::hint_fade();
	level.player method_8498(param_01,param_02);
	if(isdefined(param_03))
	{
		level.player method_8498(param_01,param_03);
	}
}

//Function Number: 52
hint_button_create_flashing(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	self endon("death");
	var_07 = common_scripts\utility::spawn_tag_origin();
	var_07.origin = self gettagorigin(param_00);
	var_07.origin = var_07.origin + param_03;
	var_07 linkto(self,param_00);
	param_01 = var_07 hint_button_create(param_01,"TAG_ORIGIN",param_04,param_05,1,1);
	if(isdefined(param_06))
	{
		param_01.fontscale = param_06;
	}

	param_01 thread hint_button_flash(0.15,0.1);
	common_scripts\utility::waittill_any_ents(self,param_02,level.player,param_02);
	param_01 hint_button_clear();
}

//Function Number: 53
play_videolog(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_06))
	{
		param_06 = 1;
	}

	var_08 = undefined;
	if(isdefined(param_02) || isdefined(param_03) || isdefined(param_04) || isdefined(param_05))
	{
		var_08 = [];
		var_08["top"] = param_02;
		var_08["left"] = param_03;
		var_08["bottom"] = param_04;
		var_08["right"] = param_05;
	}

	var_09 = [];
	var_09["add"] = 0;
	var_09["blend"] = 1;
	var_09["blend_add"] = 2;
	var_09["screen_add"] = 3;
	var_09["multiply"] = 4;
	var_09["replace"] = 5;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_0A = var_09[param_01];
	var_0B = getdvarint("cg_cinematicfullscreen");
	setsaveddvar("cg_cinematicfullscreen",0);
	var_0C = [];
	if(isdefined(var_08))
	{
		var_0C["top"] = getomnvar("ui_videolog_pos_top");
		var_0C["left"] = getomnvar("ui_videolog_pos_left");
		var_0C["bottom"] = getomnvar("ui_videolog_pos_bottom");
		var_0C["right"] = getomnvar("ui_videolog_pos_right");
		setomnvar("ui_videolog_pos_top",var_08["top"]);
		setomnvar("ui_videolog_pos_left",var_08["left"]);
		setomnvar("ui_videolog_pos_bottom",var_08["bottom"]);
		setomnvar("ui_videolog_pos_right",var_08["right"]);
	}

	setomnvar("ui_videolog",1);
	var_0D = getomnvar("ui_videolog_blendfunc");
	setomnvar("ui_videolog_blendfunc",var_0A);
	setomnvar("ui_videolog_blur_bkgrnd",param_06);
	if(!isdefined(param_07))
	{
		param_07 = level._snd.default_vid_log_vol;
	}

	cinematicingame(param_00,0,param_07,1);
	while(!iscinematicplaying())
	{
		wait 0.05;
	}

	while(iscinematicplaying())
	{
		wait 0.05;
	}

	setomnvar("ui_videolog",0);
	setomnvar("ui_videolog_blendfunc",var_0D);
	setsaveddvar("cg_cinematicfullscreen",var_0B);
	if(isdefined(var_08))
	{
		setomnvar("ui_videolog_pos_top",var_0C["top"]);
		setomnvar("ui_videolog_pos_left",var_0C["left"]);
		setomnvar("ui_videolog_pos_bottom",var_0C["bottom"]);
		setomnvar("ui_videolog_pos_right",var_0C["right"]);
	}
}

//Function Number: 54
stop_videolog()
{
	if(iscinematicplaying())
	{
		stopcinematicingame();
	}
}

//Function Number: 55
play_chyron_video(param_00,param_01,param_02)
{
	common_scripts\utility::flag_init("chyron_video_done");
	var_03 = newclienthudelem(level.player);
	var_03 setshader("black",1280,720);
	var_03.horzalign = "fullscreen";
	var_03.vertalign = "fullscreen";
	var_03.alpha = 1;
	var_03.foreground = 0;
	cinematicingame(param_00);
	var_04 = getdvarint("cg_cinematicCanPause",0);
	setsaveddvar("cg_cinematicCanPause",1);
	while(!iscinematicplaying())
	{
		wait 0.05;
	}

	while(iscinematicplaying())
	{
		wait 0.05;
	}

	common_scripts\utility::flag_set("chyron_video_done");
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	if(isdefined(param_02))
	{
		var_03 fadeovertime(param_02);
		var_03.alpha = 0;
		wait(param_02);
	}

	setsaveddvar("cg_cinematicCanPause",var_04);
	var_03 destroy();
}

//Function Number: 56
point_in_angle_of_crosshairs(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = level.player;
	}

	return vectordot(vectornormalize(param_00 - param_02 geteye()),anglestoforward(param_02 getplayerangles())) > cos(param_01);
}

//Function Number: 57
entity_is_in_circle(param_00,param_01,param_02,param_03)
{
	return point_in_angle_of_crosshairs(param_00.origin,atan(tan(0.5 * param_02) * param_03 / 320),param_01);
}