/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_variable_grenade.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 56
 * Decompile Time: 947 ms
 * Timestamp: 10/27/2023 2:02:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	init_variable_grenade();
	give_player_variable_grenade();
}

//Function Number: 2
init_variable_grenade()
{
	if(isdefined(level.player.variable_grenade))
	{
		return;
	}

	var_00["normal"][0] = "tracking_grenade_var";
	var_00["normal"][1] = "contact_grenade_var";
	var_00["normal"][2] = "frag_grenade_var";
	var_00["special"][0] = "paint_grenade_var";
	var_00["special"][1] = "flash_grenade_var";
	var_00["special"][2] = "emp_grenade_var";
	level.player.variable_grenade = var_00;
	var_01 = [];
	var_01["frag_grenade_var"] = 1;
	var_01["contact_grenade_var"] = 2;
	var_01["tracking_grenade_var"] = 3;
	var_01["paint_grenade_var"] = 4;
	var_01["flash_grenade_var"] = 5;
	var_01["emp_grenade_var"] = 6;
	level.player.variable_grenade_ui_type = var_01;
	common_scripts\utility::flag_init("variable_grenade_switch");
	level.player.detection_grenade_range = 1000;
	level.player.detection_grenade_sweep_time = 1.75;
	level.player.detection_grenade_duration = 15;
	level.player.threat_detection_style = "enhanceable";
	foreach(var_03 in ["normal","special"])
	{
		foreach(var_05 in var_00[var_03])
		{
			precacheitem(var_05);
		}
	}

	precacheitem("smart_grenade");
	precachemodel("npc_variable_grenade_lethal");
	var_08 = getspawnerteamarray("axis");
	if(var_08.size > 0)
	{
		maps\_utility::array_spawn_function(var_08,::handle_detection);
	}

	handle_detection_spawners();
	init_grenade_hints();
	precache_var_grenade_fx();
	level.player thread target_enhancer_think();
}

//Function Number: 3
handle_detection_spawners()
{
	var_00 = vehicle_getspawnerarray();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.script_team) && var_03.script_team == "axis")
		{
			if(isdefined(var_03.script_parameters) && issubstr(var_03.script_parameters,"threat_detectable"))
			{
				var_01 = common_scripts\utility::add_to_array(var_01,var_03);
				continue;
			}

			if(issubstr(var_03.classname,"pdrone"))
			{
				var_01 = common_scripts\utility::add_to_array(var_01,var_03);
			}
		}
	}

	if(var_01.size > 0)
	{
		maps\_utility::array_spawn_function(var_01,::handle_detection);
	}

	var_05 = getentarray("script_vehicle_pdrone_kva","classname");
	if(var_05.size > 0)
	{
		maps\_utility::array_spawn_function(var_05,::handle_detection);
	}

	var_06 = getentarray("enemy_walker","targetname");
	if(var_06.size > 0)
	{
		maps\_utility::array_spawn_function_targetname("enemy_walker",::handle_detection);
	}

	foreach(var_08 in getentarray("actor_enemy_dog","classname"))
	{
		if(isspawner(var_08))
		{
			var_08 maps\_utility::add_spawn_function(::handle_detection);
			continue;
		}

		var_08 thread handle_detection();
	}
}

//Function Number: 4
give_player_variable_grenade()
{
	init_variable_grenade();
	var_00 = 0;
	var_01 = level.player getweaponslistoffhands();
	if(!isdefined(var_01) || var_01.size == 0)
	{
		var_00 = 1;
	}
	else
	{
		foreach(var_03 in var_01)
		{
			if(!isdefined(level.player get_index_for_weapon_name(var_03)))
			{
				var_00 = 1;
				break;
			}
		}
	}

	if(var_00)
	{
		foreach(var_03 in level.player getweaponslistoffhands())
		{
			level.player takeweapon(var_03);
		}

		level.player setlethalweapon(level.player.variable_grenade["normal"][0]);
		level.player giveweapon(level.player.variable_grenade["normal"][0]);
		level.player settacticalweapon(level.player.variable_grenade["special"][0]);
		level.player giveweapon(level.player.variable_grenade["special"][0]);
	}

	common_scripts\utility::flag_set("variable_grenade_switch");
	level.player thread monitor_grenade_fire();
	level.player thread monitor_offhand_cycle();
}

//Function Number: 5
set_variable_grenades_with_no_switch(param_00,param_01)
{
	foreach(var_03 in level.player getweaponslistoffhands())
	{
		level.player takeweapon(var_03);
	}

	level.player setlethalweapon(param_00);
	level.player giveweapon(param_00);
	level.player settacticalweapon(param_01);
	level.player giveweapon(param_01);
	common_scripts\utility::flag_clear("variable_grenade_switch");
}

//Function Number: 6
get_mode_for_weapon_name(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = undefined;
	foreach(var_03 in ["normal","special"])
	{
		if(common_scripts\utility::array_contains(self.variable_grenade[var_03],param_00))
		{
			var_01 = var_03;
			break;
		}
	}

	return var_01;
}

//Function Number: 7
get_index_for_weapon_name(param_00)
{
	var_01 = get_mode_for_weapon_name(param_00);
	if(!isdefined(var_01))
	{
		return undefined;
	}

	foreach(var_04, var_03 in self.variable_grenade[var_01])
	{
		if(var_03 == param_00)
		{
			return var_04;
		}
	}
}

//Function Number: 8
monitor_grenade_fire()
{
	self endon("death");
	self notify("new_monitor_grenade_fire");
	self endon("new_monitor_grenade_fire");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = get_mode_for_weapon_name(var_01);
		if(!isdefined(var_02))
		{
			wait 0.05;
			continue;
		}

		foreach(var_04 in ["normal","special"])
		{
			if(common_scripts\utility::array_contains(self.variable_grenade[var_04],var_01))
			{
				thread hide_grenade_hints();
			}
		}

		if(issubstr(var_01,"emp_grenade_var"))
		{
			var_00 thread emp_grenade_think(self);
			continue;
		}

		if(issubstr(var_01,"paint_grenade_var"))
		{
			var_00 thread detection_grenade_think(self);
			continue;
		}

		if(issubstr(var_01,"tracking_grenade_var"))
		{
			var_00 thread tracking_grenade_think(self);
		}
	}
}

//Function Number: 9
grenade_ui_on(param_00)
{
	if(isdefined(level.player.variable_grenade_ui_enabled))
	{
		return;
	}

	level.player.variable_grenade_ui_enabled = 1;
	setomnvar("ui_grenade_screen",1);
	if(common_scripts\utility::flag("variable_grenade_switch"))
	{
		thread show_grenade_hint(param_00);
	}
}

//Function Number: 10
grenade_ui_off()
{
	if(!isdefined(level.player.variable_grenade_ui_enabled))
	{
		return;
	}

	level.player.variable_grenade_ui_enabled = undefined;
	setomnvar("ui_grenade_screen",0);
	if(common_scripts\utility::flag("variable_grenade_switch"))
	{
		thread hide_grenade_hints();
	}
}

//Function Number: 11
monitor_offhand_cycle()
{
	self endon("death");
	self notify("new_monitor_offhand_cycle");
	self endon("new_monitor_offhand_cycle");
	var_00 = ["current","previous"];
	var_00["previous"] = spawnstruct();
	var_00["current"] = spawnstruct();
	var_00["current"].is_switching = 0;
	var_00["current"].is_holding = 0;
	var_00["current"].is_prepping = 0;
	childthread monitor_cycle_direction();
	childthread monitor_speech_action();
	for(;;)
	{
		var_01 = var_00["previous"];
		var_00["previous"] = var_00["current"];
		var_00["current"] = var_01;
		var_02 = self getcurrentoffhand();
		var_03 = get_mode_for_weapon_name(var_02);
		if(!isdefined(var_03))
		{
			grenade_ui_off();
			wait 0.05;
			continue;
		}

		var_00["current"].is_prepping = self ispreparinggrenade();
		var_00["current"].is_holding = self isholdinggrenade() || self ispreparinggrenade() || self isswitchinggrenade();
		var_00["current"].is_switching = var_00["current"].is_holding && self usebuttonpressed() || self.grenade_cycle_next;
		var_04 = var_00["current"].is_prepping && !var_00["previous"].is_prepping;
		var_05 = var_00["current"].is_switching && !var_00["previous"].is_switching;
		var_06 = var_00["current"].is_holding && !var_00["previous"].is_holding;
		var_07 = !var_00["current"].is_holding && var_00["previous"].is_holding;
		if(common_scripts\utility::flag("variable_grenade_switch") && var_00["current"].is_holding && var_05)
		{
			cycle_offhand_grenade();
		}

		self.grenade_cycle_next = 0;
		if(var_04)
		{
			grenade_ui_on(var_03);
		}
		else if(var_07)
		{
			grenade_ui_off();
		}

		if(var_04 || var_06 || var_05)
		{
			var_02 = self getcurrentoffhand();
			var_08 = level.player.variable_grenade_ui_type[var_02];
			setomnvar("ui_grenade_type",var_08);
		}

		wait 0.05;
	}
}

//Function Number: 12
monitor_cycle_direction()
{
	self.grenade_cycle_next = 0;
	if(isdefined(level.ps4) && level.ps4)
	{
		for(;;)
		{
			var_00 = self getnormalizedflick();
			if(lengthsquared(var_00) > 0)
			{
				if(abs(var_00[0]) > abs(var_00[1]))
				{
					if(var_00[0] < 0)
					{
						self.grenade_cycle_next = 1;
					}
					else
					{
						self.grenade_cycle_next = 4;
					}
				}
				else if(var_00[1] < 0)
				{
					self.grenade_cycle_next = 3;
				}
				else
				{
					self.grenade_cycle_next = 2;
				}

				wait 0.05;
			}

			wait 0.05;
		}
	}
}

//Function Number: 13
monitor_speech_action()
{
	if(isdefined(level.xb3) && level.xb3)
	{
		self waittill("speechCommand",var_00,var_01);
		if(var_00 > 0.7 && self isholdinggrenade() || self ispreparinggrenade() || self isswitchinggrenade())
		{
			var_02 = undefined;
			var_03 = undefined;
			var_04 = undefined;
			var_05 = self getcurrentoffhand();
			if(!isdefined(var_05))
			{
				continue;
			}

			var_06 = get_mode_for_weapon_name(var_05);
			if(!isdefined(var_06))
			{
				continue;
			}

			switch(var_01)
			{
				case "next_var":
					break;

				case "previous_var":
					break;

				case "frag_var":
					break;

				case "smart_var":
					break;

				case "emp_var":
					break;

				case "contact_var":
					break;

				case "flash_var":
					break;

				case "threat_var":
					break;
			}
		}
	}
}

//Function Number: 14
cycle_offhand_grenade()
{
	var_00 = self getcurrentoffhand();
	if(isdefined(var_00))
	{
		var_01 = get_mode_for_weapon_name(var_00);
		var_02 = get_index_for_weapon_name(var_00);
		if(isdefined(var_01) && isdefined(var_02))
		{
			var_03 = var_02;
			if(self.grenade_cycle_next > 0 && self.grenade_cycle_next - 1 < self.variable_grenade[var_01].size)
			{
				var_03 = self.grenade_cycle_next - 1;
			}
			else if(self.grenade_cycle_next == 0)
			{
				var_03 = var_02 + 1 % self.variable_grenade[var_01].size;
			}

			if(var_03 != var_02)
			{
				handle_weapon_switch(var_01,var_03);
				soundscripts\_snd::snd_message("variable_grenade_type_switch",var_03);
				return;
			}

			return;
		}

		return;
	}
}

//Function Number: 15
handle_weapon_switch(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in self getweaponslistoffhands())
	{
		if(common_scripts\utility::array_contains(self.variable_grenade[param_00],var_04))
		{
			var_02 = int(max(var_02,self setweaponammostock(var_04)));
			self takeweapon(var_04);
		}
	}

	if(param_00 == "special")
	{
		self settacticalweapon(self.variable_grenade[param_00][param_01]);
	}
	else
	{
		self setlethalweapon(self.variable_grenade[param_00][param_01]);
	}

	self giveweapon(self.variable_grenade[param_00][param_01]);
	self setweaponammostock(self.variable_grenade[param_00][param_01],var_02);
}

//Function Number: 16
init_grenade_hints()
{
	precachestring(&"VARIABLE_GRENADE_HINT_CYCLE_LETHAL");
	precachestring(&"VARIABLE_GRENADE_HINT_CYCLE_TACTICAL");
}

//Function Number: 17
show_grenade_hint(param_00)
{
	level.player notify("show_grenade_hint_stop");
	if(isdefined(level.player.grenadecyclehint))
	{
		level.player.grenadecyclehint destroy();
	}

	level.player endon("show_grenade_hint_stop");
	level.player endon("death");
	var_01 = 1;
	var_02 = 0.75;
	var_03 = 0.95;
	var_04 = 0.4;
	var_05 = maps\_hud_util::createclientfontstring("objective",2);
	level.player.grenadecyclehint = var_05;
	level.player.grenadecyclehint endon("stop_hint");
	var_05.alpha = 0.9;
	var_05.x = 225;
	var_05.y = 150;
	var_05.alignx = "center";
	var_05.aligny = "middle";
	var_05.horzalign = "center";
	var_05.vertalign = "middle";
	var_05.foreground = 0;
	var_05.hidewhendead = 1;
	var_06 = &"VARIABLE_GRENADE_HINT_CYCLE_LETHAL";
	if(param_00 == "special")
	{
		var_06 = &"VARIABLE_GRENADE_HINT_CYCLE_TACTICAL";
	}

	var_05 settext(var_06);
	var_05.alpha = 0;
	var_05 fadeovertime(var_01);
	var_05.alpha = var_03;
	wait(var_01);
	for(;;)
	{
		var_05 fadeovertime(var_02);
		var_05.alpha = var_04;
		wait(var_02);
		var_05 fadeovertime(var_02);
		var_05.alpha = var_03;
		wait(var_02);
	}
}

//Function Number: 18
hide_grenade_hints()
{
	level.player notify("show_grenade_hint_stop");
	if(!isdefined(level.player.grenadecyclehint) || isremovedentity(level.player.grenadecyclehint))
	{
		return;
	}

	level.player.grenadecyclehint destroy();
}

//Function Number: 19
precache_var_grenade_fx()
{
	level._effect["paint_grenade"] = loadfx("vfx/explosion/paint_grenade");
	level._effect["emp_grenade"] = loadfx("vfx/explosion/emp_grenade_explosion");
	level._effect["tracking_grenade_spray_large"] = loadfx("vfx/trail/tracking_grenade_hovering");
	level._effect["tracking_grenade_spray_small"] = loadfx("vfx/trail/tracking_grenade_spay_small");
	level._effect["tracking_grenade_spray_large_homing"] = loadfx("vfx/trail/tracking_grenade_trail");
	level._effect["tracking_grenade_homing"] = loadfx("vfx/trail/tracking_grenade_geotrail");
	level._effect["tracking_grenade_impact"] = loadfx("vfx/explosion/smart_grenade_explosion");
	level._effect["tracking_grenade_water_impact_0"] = loadfx("vfx/explosion/smart_grenade_water_impact_01");
	level._effect["tracking_grenade_water_impact_1"] = loadfx("vfx/explosion/smart_grenade_water_impact_02");
	level._effect["tracking_grenade_water_impact_2"] = loadfx("vfx/explosion/smart_grenade_water_impact_03");
	level._effect["tracking_grenade_default_impact_0"] = loadfx("vfx/explosion/smart_grenade_default_impact_01");
	level._effect["tracking_grenade_default_impact_1"] = loadfx("vfx/explosion/smart_grenade_default_impact_02");
	level._effect["tracking_grenade_default_impact_2"] = loadfx("vfx/explosion/smart_grenade_default_impact_03");
}

//Function Number: 20
emp_notify_on_target_hit(param_00,param_01)
{
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(var_06 == "MOD_IMPACT" && isplayer(var_03) && var_0B == "emp_grenade_var")
		{
			param_00 notify(param_01);
			break;
		}
	}
}

//Function Number: 21
emp_wait_till_contact_or_timeout(param_00)
{
	var_01 = "wait_till_contact_or_timeout_stop";
	self endon(var_01);
	self endon("death");
	var_02 = level.emp_vulnerable_list;
	if(isdefined(var_02) && var_02.size > 0)
	{
		foreach(var_04 in level.emp_vulnerable_list)
		{
			if(isdefined(var_04))
			{
				var_04 childthread emp_notify_on_target_hit(self,var_01);
			}
		}
	}

	wait(param_00);
	self notify(var_01);
}

//Function Number: 22
emp_grenade_think(param_00)
{
	self endon("death");
	emp_wait_till_contact_or_timeout(1);
	var_01 = 500;
	var_02 = self.origin;
	var_03 = 500;
	playfx(common_scripts\utility::getfx("emp_grenade"),var_02);
	soundscripts\_snd::snd_message("emp_grenade_detonate");
	if(isdefined(param_00.team))
	{
		maps\_dds::dds_notify("react_emp",param_00.team != "allies");
	}

	if(!isdefined(level.emp_vulnerable_list))
	{
		self delete();
		return;
	}

	var_04 = level.emp_vulnerable_list;
	foreach(var_06 in var_04)
	{
		if(!isdefined(var_06))
		{
			continue;
		}

		if(var_06 damageconetrace(var_02,self))
		{
			if(distancesquared(var_06.origin,var_02) < var_01 * var_01)
			{
				if(isdefined(var_06.mech) && var_06.mech)
				{
					maps\_utility::giveachievement_wrapper("EMP_AST");
				}

				if(isdefined(var_06.emp_death_function) && !isdefined(var_06.processing_emp_death_function))
				{
					if(isdefined(var_06.vehicletype) && var_06.vehicletype == "pdrone")
					{
						if(isplayer(param_00))
						{
							param_00 maps\_player_stats::register_kill(self,"emp_grenade","emp_grenade_var");
						}

						var_07 = level.player getlocalplayerprofiledata("ach_flySwatter") + 1;
						level.player setlocalplayerprofiledata("ach_flySwatter",var_07);
						if(var_07 == 25)
						{
							maps\_utility::giveachievement_wrapper("EMP_DRONE");
						}
					}

					var_06.processing_emp_death_function = 1;
					var_06 thread [[ var_06.emp_death_function ]]();
					continue;
				}

				var_06 dodamage(var_03,var_02,param_00);
			}
		}
	}

	self delete();
}

//Function Number: 23
detection_grenade_think(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = level.player.detection_grenade_range;
	}

	if(!isdefined(param_02))
	{
		param_02 = level.player.detection_grenade_sweep_time;
	}

	if(!isdefined(param_03))
	{
		if(isdefined(level.player.detection_grenade_duration_bonus))
		{
			param_03 = level.player.detection_grenade_duration + level.player.detection_grenade_duration_bonus;
		}
		else
		{
			param_03 = level.player.detection_grenade_duration;
		}
	}

	wait(1);
	if(isdefined(param_00))
	{
		thread detection_grenade_hud_effect(param_00,param_01,param_02);
		thread detection_highlight_hud_effect(param_00,param_03);
	}

	playfx(common_scripts\utility::getfx("paint_grenade"),self.origin);
	soundscripts\_snd::snd_message("paint_grenade_detonate");
	self.enemies = getaiarray("axis");
	self.enemies = common_scripts\utility::array_combine(self.enemies,get_threat_detectables());
	var_04 = "grenade";
	var_05 = 0;
	foreach(var_07 in self.enemies)
	{
		if(!isdefined(var_07))
		{
			continue;
		}
		else if(!isalive(var_07))
		{
			if(!var_07 is_valid_non_human_paint_target())
			{
				continue;
			}
		}

		if(distance(var_07.origin,self.origin) < param_01)
		{
			var_05++;
			self.detected[var_04] = 0;
			var_08 = distance(var_07.origin,self.origin) * param_02 / param_01;
			var_07 maps\_utility::delaythread(var_08,::handle_marking_guy,var_04,param_03 - var_08);
		}
	}

	if(var_05 >= 10)
	{
		maps\_utility::giveachievement_wrapper("THREAT_GRENADE_KILL");
	}

	level.player notify("threat_grenade_marking_started",self);
	wait 0.05;
	self delete();
}

//Function Number: 24
get_threat_detectables()
{
	var_00 = [];
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("script_vehicle_pdrone_kva","classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("script_vehicle_walker_tank","classname"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("actor_enemy_dog","classname"));
	var_01 = maps\_utility::getvehiclearray();
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.script_team) && var_03.script_team == "axis")
		{
			if(isdefined(var_03.script_parameters) && issubstr(var_03.script_parameters,"threat_detectable"))
			{
				var_00 = common_scripts\utility::add_to_array(var_00,var_03);
			}
			else if(issubstr(var_03.classname,"pdrone"))
			{
				var_00 = common_scripts\utility::add_to_array(var_00,var_03);
			}

			if(isdefined(var_03.mgturret))
			{
				foreach(var_05 in var_03.mgturret)
				{
					var_00 = common_scripts\utility::add_to_array(var_00,var_05);
				}
			}
		}
	}

	return var_00;
}

//Function Number: 25
detection_highlight_hud_effect_apply(param_00,param_01)
{
	if(!isdefined(param_00.detection_highlight_hud_effect))
	{
		param_00.detection_highlight_hud_effect = newclienthudelem(param_00);
		param_00.detection_highlight_hud_effect.color = (0.2,0.01,0.01);
		param_00.detection_highlight_hud_effect.alpha = 1;
	}

	param_00.detection_highlight_hud_effect setradarhighlight(param_01);
}

//Function Number: 26
detection_highlight_hud_effect_remove(param_00)
{
	if(isdefined(param_00.detection_highlight_hud_effect))
	{
		param_00.detection_highlight_hud_effect destroy();
		param_00.detection_highlight_hud_effect = undefined;
	}
}

//Function Number: 27
change_threat_detection_style(param_00)
{
	level.player.threat_detection_style = param_00;
	var_01 = getaiarray("axis");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.pdrone_marked_state) && !isdefined(var_03.pretending_to_be_dead))
		{
			var_03 setthreatdetection(param_00);
		}
	}
}

//Function Number: 28
detection_highlight_hud_effect(param_00,param_01)
{
	param_00 notify("detection_highlight_hud_effect");
	param_00 endon("detection_highlight_hud_effect");
	detection_highlight_hud_effect_apply(param_00,param_01);
	wait(param_01);
	detection_highlight_hud_effect_remove(param_00);
}

//Function Number: 29
detection_grenade_hud_effect(param_00,param_01,param_02)
{
	var_03 = newclienthudelem(param_00);
	var_03.x = self.origin[0];
	var_03.y = self.origin[1];
	var_03.z = self.origin[2];
	var_03.color = (0.2,0.01,0.01);
	var_03.alpha = 0.1;
	var_04 = 500;
	var_03 setradarping(int(param_01 + var_04 / 2),int(var_04),param_02 + 0.05);
	wait(param_02);
	var_03 destroy();
}

//Function Number: 30
handle_detection()
{
	self notify("handle_detection");
	self endon("handle_detection");
	self endon("death");
	if(maps\_vehicle::isvehicle() && isdefined(self.mgturret))
	{
		foreach(var_01 in self.mgturret)
		{
			var_01 thread handle_detection();
		}
	}

	thread handle_detection_death();
	self.detected = [];
	var_03 = self.noragdoll;
	unmark_guy_fx();
	for(;;)
	{
		self waittill("detected");
		var_04 = 0;
		foreach(var_06 in self.detected)
		{
			if(var_06)
			{
				var_04++;
			}
		}

		if(var_04 == 1)
		{
			var_03 = self.noragdoll;
			self.noragdoll = 1;
			mark_guy_fx();
		}

		for(var_08 = 1;var_08;var_08 = 1)
		{
			self waittill("no_longer_detected");
			var_08 = 0;
			if(self.detected.size == 0)
			{
				unmark_guy_fx();
				self.mark_fx = undefined;
				self.noragdoll = var_03;
				continue;
			}
		}
	}
}

//Function Number: 31
handle_marking_guy(param_00,param_01)
{
	self endon("death");
	self notify("marking_" + param_00);
	self endon("marking_" + param_00);
	self.detected[param_00] = 1;
	self notify("detected");
	if(isdefined(param_01))
	{
		wait(param_01);
		unmark_guy(param_00);
	}
}

//Function Number: 32
unmark_guy(param_00)
{
	self.detected[param_00] = undefined;
	self notify("no_longer_detected");
}

//Function Number: 33
mark_guy_fx()
{
	if(isdefined(self.pretending_to_be_dead))
	{
		return;
	}

	self.pdrone_marked_state = "marked";
	self setthreatdetection("detected");
}

//Function Number: 34
unmark_guy_fx()
{
	if(isdefined(self))
	{
		if(isalive(self))
		{
			self.pdrone_marked_state = undefined;
			self setthreatdetection(level.player.threat_detection_style);
			return;
		}

		self setthreatdetection("disabled");
	}
}

//Function Number: 35
clear_guy_fx()
{
	if(isdefined(self))
	{
		self setthreatdetection("disable");
	}
}

//Function Number: 36
handle_detection_death()
{
	common_scripts\utility::waittill_any("death","emp_death");
	var_00 = undefined;
	clear_guy_fx();
}

//Function Number: 37
is_valid_non_human_paint_target()
{
	return self.code_classname == "script_vehicle";
}

//Function Number: 38
tracking_grenade_think(param_00)
{
	var_01 = 35;
	var_02 = 20;
	var_03 = 195;
	var_04 = 0.5;
	var_05 = 1;
	var_06 = 2.5;
	var_07 = param_00 get_smart_grenade_timer();
	var_08 = var_07 * 0.5;
	var_09 = 0.35;
	var_0A = 88;
	var_0B = 7;
	var_0C = 2112;
	var_0D = 2;
	var_0E = 0.05;
	var_0F = (0,0,-300 * var_0E);
	var_10 = 3000 * var_0E;
	var_11 = 600 * var_0E;
	var_12 = 0.2;
	var_13 = 0.6;
	var_14 = 2;
	var_15 = sin(2);
	var_16 = 0.05;
	var_17 = make_tracking_grenade(self);
	var_17 thread tracking_grenade_handle_damage(param_00);
	var_17 thread tracking_grenade_handle_autosave(param_00);
	var_18 = common_scripts\utility::spawn_tag_origin();
	var_18 linkto(var_17,"",(0,0,0),(-90,0,0));
	var_19 = level.player geteye();
	var_1A = anglestoforward(level.player getgunangles());
	var_1B = bullettrace(var_19,var_19 + var_1A * 7000,0,var_17);
	var_1C = var_1B["position"];
	var_1D = var_1A + (0,0,0.2) * 50 * 17.6;
	var_1E = (0,0,0);
	var_1F = undefined;
	var_20 = (0,0,0);
	var_21 = (0,0,0);
	var_22 = 0;
	var_23 = 0;
	var_24 = 0;
	var_25 = 0;
	soundscripts\_snd::snd_message("tracking_grenade_hover",var_17);
	var_26 = 0;
	while(var_26 < var_0B)
	{
		if(!isdefined(var_1F) || !isalive(var_1F) || var_26 <= var_08)
		{
			var_1F = var_17 tracking_grenade_get_target(param_00);
			if(isdefined(var_1F) && isdefined(var_1F.team))
			{
				var_1F maps\_dds::dds_notify("react_smart",var_1F.team == "allies");
			}
		}

		if(var_26 > var_07 && isdefined(var_1F) && !var_22)
		{
			var_22 = 1;
			tracking_grenade_scare_enemies(var_1F.origin);
		}

		if(var_26 > var_08 && isdefined(var_1F) && !var_23)
		{
			var_23 = 1;
			soundscripts\_snd::snd_message("tracking_grenade_beep",var_17);
		}

		if(var_26 > var_07)
		{
			if(isdefined(var_1F))
			{
				var_1C = var_1F.origin + var_1F get_npc_center_offset();
			}
		}
		else
		{
			var_19 = level.player geteye();
			var_1A = anglestoforward(level.player getgunangles());
			var_1B = bullettrace(var_19,var_19 + var_1A * 7000,0,var_17);
			var_27 = var_1B["position"];
			if(distancesquared(var_27,param_00.origin) > distancesquared(var_17.origin,param_00.origin))
			{
				var_1C = var_27;
			}
		}

		if(var_26 > var_07)
		{
			if(vectordot(var_1C - var_17.origin,var_1C - param_00.origin) < 0)
			{
				break;
			}

			if(!var_24)
			{
				var_24 = 1;
				playfxontag(common_scripts\utility::getfx("tracking_grenade_homing"),var_18,"tag_origin");
				soundscripts\_snd::snd_message("tracking_grenade_jump",var_17);
			}

			var_28 = maps\_shg_utility::linear_map_clamp(var_26 - var_07 - var_09,0,var_0D,0,var_0C);
			var_1E = vectornormalize(var_1C - var_17.origin) * var_28;
			if(var_26 < var_07 + var_09 && bullettracepassed(var_17.origin,var_17.origin + (0,0,var_0A * var_09),0,undefined))
			{
				var_1E = (0,0,var_0A);
			}
			else if(!var_25)
			{
				var_25 = 1;
				soundscripts\_snd::snd_message("tracking_grenade_strike",var_17);
			}
		}
		else
		{
			var_19 = param_00 geteye();
			if(var_26 < var_08 || !isdefined(var_1F))
			{
				var_29 = param_00 getgunangles();
			}
			else
			{
				var_29 = (0,vectortoyaw(var_18.origin - var_1A),0);
			}

			var_1A = anglestoforward(var_29);
			var_1A = (var_1A[0],var_1A[1],var_1A[2] * var_04);
			var_2A = anglestoright(var_29);
			var_2B = -1 * common_scripts\utility::sign(vectordot(var_19 - var_17.origin,var_2A));
			var_2C = var_19 + var_1A * var_03 + (0,0,var_01) + var_2A * var_2B * var_02;
			var_2D = var_2C - var_17.origin;
			if(isplayer(param_00) && param_00 fragbuttonpressed())
			{
				var_2E = var_06;
			}
			else
			{
				var_2E = var_06;
			}

			var_1E = var_2D * var_2E;
		}

		var_1E = var_1E + getsmoothrandomvector(52.8,1);
		var_2F = vectorclamp(var_1E - var_1D * var_13 - var_0F,var_10);
		var_2F = vectorlerp(var_2F,var_20,var_12);
		var_21 = var_21 + var_2F;
		var_21 = var_21 + common_scripts\utility::randomvector(var_16 * length(var_21));
		var_30 = length(var_21);
		if(var_30 > 0)
		{
			var_31 = anglestoup(var_17.angles);
			var_17.angles = combineangles(vectortoangles(var_21),(90,0,0));
			var_32 = vectornormalize(var_21);
			var_33 = vectorcross(var_32,var_31);
			var_34 = vectorcross(var_32,var_33);
			var_35 = length(var_34);
			if(var_35 > var_15)
			{
				var_17 tracking_grenade_thrust_effect(var_34,"tracking_grenade_spray_small",var_32 * var_14);
				if(var_35 > 2 * var_15)
				{
					var_17 tracking_grenade_thrust_effect(-1 * var_34,"tracking_grenade_spray_small",var_32 * var_14 * -1);
				}
			}

			if(var_30 > var_11)
			{
				if(var_26 > var_07)
				{
					var_36 = "tracking_grenade_spray_large_homing";
				}
				else
				{
					var_36 = "tracking_grenade_spray_large";
				}

				playfxontag(common_scripts\utility::getfx(var_36),var_18,"tag_origin");
				var_21 = (0,0,0);
				var_1D = var_1D + vectorclamp(var_2F,var_10,var_11);
			}

			var_1D = var_1D + var_0F;
		}

		var_21 = (0,0,0);
		var_37 = var_17.origin + var_1D * 0.05;
		var_38 = bullettrace(var_17.origin,var_37,1,param_00,0,1,0,0,1);
		if(isdefined(var_38["glass"]))
		{
			destroyglass(var_38["glass"],vectornormalize(var_1D));
			var_38 = bullettrace(var_17.origin,var_37,1,param_00,0,1,0,0,1);
		}

		if(isdefined(var_38["entity"]) && isdefined(var_38["entity"].linked_player) && var_38["entity"].linked_player == param_00)
		{
		}
		else if(var_38["fraction"] < 1)
		{
			break;
		}

		var_17.origin = var_37;
		var_20 = var_2F;
		wait(0.05);
		var_26 = var_26 + 0.05;
	}

	var_17 tracking_grenade_detonate(param_00,var_1D,var_18);
}

//Function Number: 39
get_smart_grenade_timer()
{
	if(isplayer(self))
	{
		var_00 = self getcurrentweapon();
		if(isdefined(var_00) && issubstr(var_00,"microdronelaunchersmartgrenade"))
		{
			return 0.1;
		}
	}

	return 1;
}

//Function Number: 40
safe_str(param_00)
{
	if(isdefined(param_00))
	{
		if(isarray(param_00))
		{
			var_01 = "(array ";
			foreach(var_04, var_03 in param_00)
			{
				var_01 = var_01 + var_04 + " -> " + safe_str(var_03) + "\n";
			}

			var_01 = var_01 + ")";
			return var_01;
		}

		if(isremovedentity(var_04))
		{
			return "" + var_04;
		}

		if(isdefined(var_04.code_classname))
		{
			var_01 = "(entity $e" + var_04 getentitynumber() + " code_classname: \" + var_04.code_classname + "\";
			if(isspawner(var_03))
			{
				var_04 = var_04 + " (spawner)";
			}
		}
		else
		{
			var_01 = "(object";
		}

		if(isdefined(var_03.targetname))
		{
			var_04 = var_04 + " targetname: \" + var_03.targetname + "\";
		}

		if(isdefined(var_03.script_noteworthy))
		{
			var_04 = var_04 + " script_noteworthy: \" + var_03.script_noteworthy + "\";
		}

		if(isdefined(var_03.classname))
		{
			var_04 = var_04 + " classname: \" + var_03.classname + "\";
		}

		var_04 = var_04 + ")";
		return var_04;
	}

	if(isremovedentity(var_04))
	{
		return "(removed entity)";
	}

	if(var_04 == undefined)
	{
		return "(undefined)";
	}
}

//Function Number: 41
tracking_grenade_detonate(param_00,param_01,param_02)
{
	var_03 = 150;
	var_04 = 128;
	var_05 = 1000;
	var_06 = 50;
	self notify("tracking_grenade_deactivate");
	if(distance(param_00.origin,self.origin) > var_03)
	{
		radiusdamage(self.origin,var_04,var_05,var_06,param_00,"MOD_GRENADE","tracking_grenade_var",1);
		playfx(common_scripts\utility::getfx("tracking_grenade_impact"),self.origin);
		soundscripts\_snd::snd_message("smart_grenade_detonate");
		thread play_tracking_grenade_impacts(300,self.origin);
		param_02 delete();
		self delete();
		return;
	}

	self physicslaunchserver(self.origin + common_scripts\utility::randomvector(10),param_01 * 0.1 * 0.25);
	soundscripts\_snd::snd_message("tracking_grenade_dud",self);
	for(var_07 = 0;var_07 < 5;var_07++)
	{
		playfxontag(common_scripts\utility::getfx("tracking_grenade_spray_large"),param_02,"tag_origin");
		wait(randomfloatrange(0.05,0.3));
	}

	param_02 delete();
	thread tracking_grenade_pickup(param_00);
	wait(30);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 42
tracking_grenade_pickup(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	self endon("death");
	var_01 = spawn("trigger_radius",self.origin,0,15,5);
	var_01 enablelinkto();
	var_01 linkto(self);
	thread common_scripts\utility::delete_on_death(var_01);
	for(;;)
	{
		var_01 waittill("trigger",var_02);
		if(var_02 == param_00 && var_02 setweaponammostock("tracking_grenade_var") < weaponmaxammo("tracking_grenade_var"))
		{
			break;
		}
	}

	param_00 setweaponammostock("tracking_grenade_var",param_00 setweaponammostock("tracking_grenade_var") + 1);
	self delete();
}

//Function Number: 43
play_tracking_grenade_impacts(param_00,param_01)
{
	for(var_02 = 0;var_02 < 20;var_02++)
	{
		wait(0.01);
		var_03 = "tracking_grenade_water_impact_" + randomintrange(0,2);
		var_04 = "tracking_grenade_default_impact_" + randomintrange(0,2);
		var_05 = (randomfloat(2) - 1,randomfloat(2) - 1,randomfloat(-1));
		var_06 = 32 * var_05 + param_01;
		var_07 = param_00 * var_05 + param_01;
		var_08 = bullettrace(var_06,var_07,0,undefined,0,0,1,0,0);
		if(isdefined(var_08) && var_08["surfacetype"] != "none")
		{
			if(distance(var_06,var_08["position"]) > 5)
			{
				if(iswatersurface(var_08["surfacetype"]))
				{
					playfx(common_scripts\utility::getfx(var_03),var_08["position"],var_08["normal"]);
					continue;
				}

				playfx(common_scripts\utility::getfx(var_04),var_08["position"],var_08["normal"]);
			}
		}
	}
}

//Function Number: 44
tracking_grenade_handle_damage(param_00)
{
	self endon("death");
	self makeentitysentient(param_00.team,1);
	self waittill("damage");
	tracking_grenade_detonate();
}

//Function Number: 45
tracking_grenade_handle_autosave(param_00)
{
	if(!isplayer(param_00))
	{
		return;
	}

	if(!isdefined(param_00.num_active_tracking_grenades))
	{
		param_00.num_active_tracking_grenades = 0;
	}

	param_00.num_active_tracking_grenades++;
	maps\_utility::add_extra_autosave_check("no_tracking_grenades_active",::no_tracking_grenades_active,"tracking grenades are active");
	common_scripts\utility::waittill_either("death","tracking_grenade_deactivate");
	wait(1);
	param_00.num_active_tracking_grenades--;
}

//Function Number: 46
no_tracking_grenades_active()
{
	return !isdefined(level.player.num_active_tracking_grenades) || level.player.num_active_tracking_grenades == 0;
}

//Function Number: 47
tracking_grenade_scare_enemies(param_00)
{
	badplace_cylinder("",4,param_00 + (0,0,-64),117,128,"all");
}

//Function Number: 48
tracking_grenade_get_target(param_00)
{
	var_01 = param_00 geteye();
	var_02 = anglestoforward(param_00 getgunangles());
	var_03 = cos(20);
	var_04 = undefined;
	var_05 = getaispeciesarray(common_scripts\utility::get_enemy_team(param_00.team),"all");
	var_05 = common_scripts\utility::array_combine(var_05,getentarray("tracking_grenade_target","script_noteworthy"));
	var_05 = common_scripts\utility::array_combine(var_05,vehicle_getarray());
	foreach(var_07 in var_05)
	{
		if(var_07.code_classname == "script_vehicle" && !issentient(var_07))
		{
			continue;
		}

		if(isdefined(var_07.pretending_to_be_dead))
		{
			continue;
		}

		var_08 = undefined;
		if(isai(var_07))
		{
			var_08 = var_07 geteye();
		}
		else
		{
			var_08 = var_07.origin;
		}

		var_09 = vectordot(vectornormalize(var_08 - var_01),var_02);
		if(var_09 <= var_03)
		{
			continue;
		}

		if(distancesquared(var_08,var_01) < distancesquared(self.origin,var_01))
		{
			continue;
		}

		if(!sighttracepassed(self.origin,var_08,0,self,var_07))
		{
			continue;
		}

		if(isdefined(var_04) && !sighttracepassed(self.origin,var_08,0,self,var_07))
		{
			continue;
		}

		var_03 = var_09;
		var_04 = var_07;
	}

	return var_04;
}

//Function Number: 49
tracking_grenade_thrust_effect(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::spawn_tag_origin();
	if(isdefined(param_02))
	{
		var_03.origin = var_03.origin + param_02;
	}

	var_03.angles = vectortoangles(param_00);
	var_03 linkto(self);
	playfxontag(common_scripts\utility::getfx(param_01),var_03,"tag_origin");
	var_03 common_scripts\utility::delaycall(0.3,::delete);
}

//Function Number: 50
getsmoothrandomvector(param_00,param_01)
{
	var_02 = gettime() * 0.001 * param_01;
	return (perlinnoise2d(var_02,10,1,1,1) * param_00,perlinnoise2d(var_02,20,1,1,1) * param_00,perlinnoise2d(var_02,30,1,1,1) * param_00);
}

//Function Number: 51
make_tracking_grenade(param_00)
{
	var_01 = param_00.origin;
	param_00 delete();
	var_02 = spawn("script_model",var_01);
	var_02 setmodel("npc_variable_grenade_lethal");
	return var_02;
}

//Function Number: 52
target_valid_targets()
{
	var_00 = getaiarray("axis");
	var_01 = [];
	var_02 = common_scripts\utility::spawn_tag_origin();
	target_set(var_02);
	target_setjavelinonly(var_02,1);
	foreach(var_04 in var_00)
	{
		var_02.origin = var_04 geteye();
		if(target_isincircle(var_02,self,65,100))
		{
			var_01[var_01.size] = var_04;
		}
	}

	var_02 delete();
	return var_01;
}

//Function Number: 53
get_npc_center_offset()
{
	if(isai(self) && isalive(self))
	{
		var_00 = self geteye()[2];
		var_01 = self.origin[2];
		var_02 = var_00 - var_01;
		return (0,0,var_02);
	}

	return (0,0,0);
}

//Function Number: 54
iswatersurface(param_00)
{
	var_01 = ["water_waist","water_ankle","water_knee"];
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 55
target_enhancer_think()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = 10;
	var_01 = cos(var_00);
	var_02 = 0.5;
	var_03 = undefined;
	for(;;)
	{
		var_04 = 0;
		var_05 = getweaponattachments(self getcurrentweapon());
		if(isdefined(var_05))
		{
			foreach(var_07 in var_05)
			{
				if(var_07 == "opticstargetenhancer")
				{
					var_04 = 1;
					break;
				}
			}
		}

		while(var_04 && self playerads() < var_02)
		{
			if(isdefined(var_03))
			{
				var_03 destroy();
				var_03 = undefined;
			}

			wait(0.05);
		}

		if(!var_04)
		{
			if(isdefined(var_03))
			{
				var_03 destroy();
				var_03 = undefined;
			}

			wait(0.05);
			continue;
		}

		if(self isusingturret())
		{
			if(isdefined(var_03))
			{
				var_03 destroy();
				var_03 = undefined;
			}

			wait(0.05);
			continue;
		}

		if(!isdefined(var_03))
		{
			var_03 = player_enable_highlight();
		}

		wait(0.05);
	}
}

//Function Number: 56
player_enable_highlight()
{
	var_00 = newclienthudelem(self);
	var_00.color = (0.2,0.01,0.01);
	var_00.alpha = 1;
	var_00 setradarhighlight(-1);
	return var_00;
}