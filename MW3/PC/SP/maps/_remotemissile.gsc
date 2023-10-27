/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_remotemissile.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 67
 * Decompile Time: 1130 ms
 * Timestamp: 10/27/2023 2:20:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.no_friendly_fire_splash_damage = 1;
	if(!isdefined(level.min_time_between_uav_launches))
	{
		level.min_time_between_uav_launches = 12000;
	}

	if(!isdefined(level.remote_missile_targets))
	{
		level.remote_missile_targets = [];
	}

	level.last_uav_launch_time = 0 - level.min_time_between_uav_launches;
	level.uav_radio_offline_called = 0;
	precacheitem("remote_missile_detonator");
	if(isdefined(level.uav_missile_override))
	{
		precacheitem(level.uav_missile_override);
	}
	else
	{
		precacheitem("remote_missile");
	}

	precacheshader("veh_hud_target");
	precacheshader("veh_hud_target_offscreen");
	precacheshader("veh_hud_missile_flash");
	precacheshader("ac130_overlay_grain");
	precacheshader("remotemissile_infantry_target");
	precacheshader("remotemissile_infantry_target_2plr");
	precacheshader("hud_fofbox_self_sp");
	precacheshader("dpad_killstreak_hellfire_missile_inactive");
	precachestring(&"HELLFIRE_DRONE_VIEW");
	precachestring(&"HELLFIRE_MISSILE_VIEW");
	precachestring(&"HELLFIRE_FIRE");
	level.remotemissile = spawnstruct();
	level.remotemissile.fov_is_altered = 4;
	common_scripts\utility::flag_init("predator_missile_launch_allowed");
	common_scripts\utility::flag_set("predator_missile_launch_allowed");
	maps\_utility::add_hint_string("hint_predator_drone_destroyed",&"HELLFIRE_DESTROYED",::should_break_destroyed);
	maps\_utility::add_hint_string("hint_predator_drone_4",&"HELLFIRE_USE_DRONE",::should_break_use_drone);
	maps\_utility::add_hint_string("hint_predator_drone_2",&"HELLFIRE_USE_DRONE_2",::should_break_use_drone);
	maps\_utility::add_hint_string("hint_predator_drone_not_available",&"HELLFIRE_DRONE_NOT_AVAILABLE",::should_break_available);
	if(isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
	{
		visionsetmissilecam("missilecam");
	}
	else if(!isdefined(level.var_3BDB))
	{
		visionsetmissilecam("missilecam");
	}
	else
	{
		visionsetmissilecam(level.var_3BDB);
	}

	setsaveddvar("missileRemoteSpeedUp","1000");
	setsaveddvar("missileRemoteSpeedTargetRange","6000 12000");
	var_00 = getdvar("mapname");
	if(var_00 == "zzz")
	{
	}
	else if(var_00 == "raymetest")
	{
		setsaveddvar("missileRemoteSpeedUp","500");
		setsaveddvar("missileRemoteSpeedTargetRange","3000 6000");
	}

	maps\_utility::add_global_spawn_function("axis",::missile_kill_ai);
	common_scripts\utility::flag_init("uav_reloading");
	common_scripts\utility::flag_init("uav_collecting_stats");
	common_scripts\utility::flag_init("uav_enabled");
	common_scripts\utility::flag_set("uav_enabled");
	foreach(var_02 in level.players)
	{
		var_02 maps\_utility::ent_flag_init("controlling_UAV");
	}
}

//Function Number: 2
should_break_use_drone()
{
	var_00 = 0;
	if(isdefined(level.uav_is_destroyed))
	{
		var_00 = 1;
	}

	var_01 = get_uav();
	if(!isalive(var_01))
	{
		var_00 = 1;
	}

	if(isdefined(self.var_3BDE))
	{
		var_00 = 1;
	}

	if(common_scripts\utility::flag_exist("wave_wiped_out") && common_scripts\utility::flag("wave_wiped_out"))
	{
		var_00 = 1;
	}

	if(maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed"))
	{
		var_00 = 1;
	}

	if(self getcurrentweapon() == "remote_missile_detonator")
	{
		var_00 = 1;
	}

	if(common_scripts\utility::flag_exist("no_default_uav_hint") && common_scripts\utility::flag("no_default_uav_hint"))
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 3
init_radio_dialogue()
{
	if(!isdefined(level.scr_radio))
	{
		level.scr_radio = [];
	}

	level.uav_radio_initialized = 1;
	level.scr_radio["uav_reloading"] = "cont_cmt_rearmhellfires";
	level.scr_radio["uav_offline"] = "cont_cmt_hellfiresoffline";
	level.scr_radio["uav_online"] = "cont_cmt_hellfireonline";
	level.scr_radio["uav_online_repeat"] = "cont_cmt_repeatonline";
	level.scr_radio["uav_down"] = "cont_cmt_uavdown";
	level.scr_radio["uav_multi_kill"] = "cont_cmt_mutlipleconfirmed";
	level.scr_radio["uav_multi_kill2"] = "cont_cmt_fivepluskias";
	level.scr_radio["uav_few_kills"] = "cont_cmt_theyredown";
	level.scr_radio["uav_3_kills"] = "cont_cmt_3kills";
	level.scr_radio["uav_1_kill"] = "cont_cmt_hesdown";
	level.scr_radio["uav_btr_kill"] = "cont_cmt_mutlipleconfirmed";
	level.scr_radio["uav_few_kills"] = "cont_cmt_theyredown";
	level.scr_radio["uav_3_kills"] = "cont_cmt_3kills";
	level.scr_radio["uav_1_kill"] = "cont_cmt_hesdown";
	level.scr_radio["uav_multi_vehicle_kill"] = "cont_cmt_goodhitvehicles";
	level.scr_radio["uav_multi_vehicle_kill2"] = "cont_cmt_goodeffectkia";
	level.scr_radio["uav_helo_kill"] = "cont_cmt_directhitshelo";
	level.scr_radio["uav_btr_kill"] = "cont_cmt_btrdestroyed";
	level.scr_radio["uav_truck_kill"] = "cont_cmt_goodkilltruck";
	level.scr_radio["uav_jeep_kill"] = "cont_cmt_directhitjeep";
	level.scr_radio["uav_direct_hit"] = "cont_cmt_directhit";
}

//Function Number: 4
is_radio_defined(param_00)
{
	return isdefined(level.scr_radio[param_00]) || isdefined(level.scr_radio[param_00 + "_variant"]);
}

//Function Number: 5
should_break_available()
{
	if(isdefined(level.uav_is_not_available))
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
should_break_destroyed()
{
	if(isdefined(level.uav_is_destroyed))
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
enable_uav(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!common_scripts\utility::flag("uav_enabled"))
	{
		common_scripts\utility::flag_set("uav_enabled");
		if(!common_scripts\utility::flag("uav_reloading") && param_00)
		{
			thread remotemissile_radio("uav_online");
		}
	}

	if(isdefined(param_01))
	{
		restore_uav_weapon(param_01);
	}
}

//Function Number: 8
disable_uav(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(common_scripts\utility::flag("uav_enabled"))
	{
		common_scripts\utility::flag_clear("uav_enabled");
		if(!common_scripts\utility::flag("uav_reloading") && param_00)
		{
			thread remotemissile_radio("uav_offline");
		}
	}

	if(isdefined(param_01))
	{
		remove_uav_weapon();
	}
}

//Function Number: 9
restore_uav_weapon(param_00)
{
	if(isdefined(level.uav_is_destroyed))
	{
		return;
	}

	if(isstring(param_00))
	{
		var_01 = param_00;
	}
	else if(isdefined(self.uav_weaponname))
	{
		var_01 = self.uav_weaponname;
	}
	else
	{
		return;
	}

	if(!self hasweapon(var_01))
	{
		return;
	}

	self setweaponhudiconoverride("actionslot" + get_remotemissile_actionslot(),"none");
	self setactionslot(get_remotemissile_actionslot(),"weapon",var_01);
}

//Function Number: 10
remove_uav_weapon()
{
	self setweaponhudiconoverride("actionslot" + get_remotemissile_actionslot(),"dpad_killstreak_hellfire_missile_inactive");
	self setactionslot(get_remotemissile_actionslot(),"");
}

//Function Number: 11
is_remote_missile_weapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "remote_missile_detonator")
	{
		return 1;
	}

	if(param_00 == "remote_missile_detonator_finite")
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
give_remotemissile_weapon(param_00)
{
	set_remotemissile_actionslot();
	self setactionslot(get_remotemissile_actionslot(),"weapon",param_00);
	self giveweapon(param_00);
	thread maps\_remotemissile_utility::remotemissile_with_autoreloading();
}

//Function Number: 13
set_remotemissile_actionslot()
{
	if(!self hasweapon("claymore"))
	{
		self.remotemissile_actionslot = 4;
		return;
	}

	self.remotemissile_actionslot = 2;
}

//Function Number: 14
get_remotemissile_actionslot()
{
	return self.remotemissile_actionslot;
}

//Function Number: 15
has_uav_rigs()
{
	if(!isdefined(self.var_3BF0))
	{
		return 0;
	}

	return self.var_3BF0.size > 1;
}

//Function Number: 16
remotemissile_weapon_change(param_00)
{
	self.using_uav = 0;
	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(is_remote_missile_weapon(var_01))
		{
			self.using_uav = 1;
			if(isdefined(level.uav_is_destroyed))
			{
				thread remotemissile_offline(0,"uav_down");
				self switchtoweapon(self.last_weapon);
				self.using_uav = 0;
				continue;
			}

			if(maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed"))
			{
				switchbacktomainweapon();
				self.using_uav = 0;
				continue;
			}

			if(maps\_utility::ent_flag_exist("player_has_red_flashing_overlay") && maps\_utility::ent_flag("player_has_red_flashing_overlay"))
			{
				switchbacktomainweapon();
				self.using_uav = 0;
				continue;
			}

			if(maps\_utility::is_survival() && isdefined(level.uav_user) && level.uav_user != self)
			{
				thread maps\_utility::radio_dialogue("so_hq_uav_busy");
				switchbacktomainweapon();
				self.using_uav = 0;
				continue;
			}

			self.uav_weaponname = var_01;
			thread cancel_on_player_damage();
			if(isdefined(level.remote_missile_hide_stuff_func))
			{
				[[ level.remote_missile_hide_stuff_func ]]();
			}

			maps\_audio::aud_send_msg("player_UAV_use");
			level.uav_user = self;
			level.uav_killstats = [];
			uavremotelaunchersequence(self,var_01);
			level.uav_user = undefined;
			self.using_uav = 0;
			if(isdefined(level.remotemissile_global_post_launch_func))
			{
				[[ level.remotemissile_global_post_launch_func ]]();
			}

			if(isdefined(param_00))
			{
				thread [[ param_00 ]]();
			}
		}
	}
}

//Function Number: 17
remotemissile_track_current_weapon()
{
	self endon("death");
	self.last_weapon = self getcurrentweapon();
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(!is_remote_missile_weapon(var_00))
		{
			self.last_weapon = var_00;
		}
	}
}

//Function Number: 18
remotemissile_player_input(param_00)
{
	self notifyonplayercommand("switch_to_remotemissile","+actionslot " + get_remotemissile_actionslot());
	thread remotemissile_weapon_change(param_00);
	thread remotemissile_track_current_weapon();
	for(;;)
	{
		self waittill("switch_to_remotemissile");
		if(self.using_uav)
		{
			continue;
		}

		if(!is_remote_missile_weapon(self getcurrentweapon()))
		{
			self.last_weapon = self getcurrentweapon();
		}

		if(isdefined(level.uav_is_destroyed))
		{
			thread remotemissile_offline(0,"uav_down");
			continue;
		}

		if(common_scripts\utility::flag("uav_reloading") || !common_scripts\utility::flag("uav_enabled"))
		{
			thread remotemissile_offline(1);
		}
	}
}

//Function Number: 19
remotemissile_offline(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "uav_offline";
	}

	var_02 = gettime();
	if((param_00 && level.last_uav_launch_time + level.min_time_between_uav_launches - var_02 < 2000) || level.min_time_between_uav_launches < 5000)
	{
		if(!isdefined(level.uav_is_destroyed) && isdefined(self.uav_weaponname) && self getweaponammoclip(self.uav_weaponname) > 0)
		{
			return;
		}
	}

	if(common_scripts\utility::flag("uav_reloading"))
	{
		if(isdefined(level.scr_radio["uav_reloading"]))
		{
			param_01 = "uav_reloading";
		}
	}

	if(!common_scripts\utility::flag("uav_collecting_stats") && !level.uav_radio_offline_called)
	{
		level.uav_radio_offline_called = 1;
		remotemissile_radio(param_01);
		level.uav_radio_offline_called = 0;
	}
}

//Function Number: 20
remotemissile_radio_reminder()
{
	level notify("stop_remotemissile_radio_reminder");
	level endon("special_op_terminated");
	level endon("starting_predator_drone_control");
	level endon("stop_remotemissile_radio_reminder");
	for(;;)
	{
		wait 7 + randomint(4);
		if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated"))
		{
			return;
		}

		if(isdefined(level.uav_is_destroyed))
		{
			return;
		}

		if(common_scripts\utility::flag("uav_reloading"))
		{
			return;
		}

		if(!common_scripts\utility::flag("uav_enabled"))
		{
			return;
		}

		remotemissile_radio("uav_online_repeat");
		wait 15 + randomint(10);
		if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated"))
		{
			return;
		}

		if(isdefined(level.uav_is_destroyed))
		{
			return;
		}

		if(isdefined(level.no_remote_missile_reminders))
		{
			return;
		}

		remotemissile_radio("uav_online");
		thread maps\_utility::display_hint_timeout("hint_predator_drone_" + get_remotemissile_actionslot(),6);
	}
}

//Function Number: 21
play_kills_dialogue()
{
	if(isdefined(level.dont_use_global_uav_kill_dialog))
	{
		return;
	}

	if(!isdefined(level.uav_radio_initialized))
	{
		return;
	}

	var_00 = undefined;
	var_01 = 0;
	if(isdefined(level.uav_killstats["ai"]))
	{
		var_01 = level.uav_killstats["ai"];
	}

	if(var_01 > 5)
	{
		var_00 = "uav_multi_kill";
		if(is_radio_defined("uav_multi_kill2") && common_scripts\utility::cointoss())
		{
			var_00 = "uav_multi_kill2";
		}
	}
	else if(var_01 >= 3)
	{
		var_00 = "uav_3_kills";
	}
	else if(var_01 > 1)
	{
		var_00 = "uav_few_kills";
	}
	else if(var_01 > 0)
	{
		var_00 = "uav_1_kill";
	}

	var_02 = undefined;
	var_03 = 0;
	var_04 = 0;
	var_03 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	foreach(var_0A, var_09 in level.uav_killstats)
	{
		if(var_0A == "ai")
		{
			continue;
		}

		if(var_09 > 0)
		{
			var_04 = var_04 + var_09;
			if(var_0A == "btr")
			{
				var_03 = var_09;
				continue;
			}

			if(var_0A == "helo")
			{
				var_05 = var_09;
				continue;
			}

			if(var_0A == "jeep")
			{
				var_06 = var_09;
				continue;
			}

			if(var_0A == "truck")
			{
				var_07 = var_09;
			}
		}
	}

	var_0B = var_00;
	if(var_03 > 0)
	{
		var_0B = "uav_btr_kill";
	}
	else if(var_05 > 0)
	{
		var_0B = "uav_helo_kill";
	}
	else if(var_04 > 1)
	{
		var_0B = "uav_multi_vehicle_kill";
		if(is_radio_defined("uav_multi_vehicle_kill2") && common_scripts\utility::cointoss())
		{
			var_0B = "uav_multi_vehicle_kill2";
		}
	}
	else if(var_06 > 0)
	{
		var_0B = "uav_jeep_kill";
		if(var_01 > 2 && var_01 <= 5 && is_radio_defined("uav_direct_hit") && common_scripts\utility::cointoss())
		{
			var_0B = "uav_direct_hit";
		}
	}
	else if(var_07 > 0)
	{
		var_0B = "uav_truck_kill";
		if(var_01 > 2 && var_01 <= 5 && is_radio_defined("uav_direct_hit") && common_scripts\utility::cointoss())
		{
			var_0B = "uav_direct_hit";
		}
	}

	if(!isdefined(var_0B))
	{
		return;
	}

	if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated"))
	{
		return;
	}

	remotemissile_radio(var_0B);
	level notify("remote_missile_kill_dialogue");
}

//Function Number: 22
set_variant_remotemissile_radio(param_00)
{
	if(isdefined(level.scr_radio[param_00 + "_variant"]) && isarray(level.scr_radio[param_00 + "_variant"]))
	{
		level.scr_radio[param_00] = level.scr_radio[param_00 + "_variant"][randomint(level.scr_radio[param_00 + "_variant"].size)];
	}
}

//Function Number: 23
remotemissile_radio(param_00)
{
	if(!isdefined(level.uav_radio_initialized))
	{
		return;
	}

	if(isdefined(level.uav_radio_disabled) && level.uav_radio_disabled)
	{
		return;
	}

	if(!is_radio_defined(param_00))
	{
		return;
	}

	if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated"))
	{
		return;
	}

	set_variant_remotemissile_radio(param_00);
	maps\_utility::radio_dialogue(param_00);
}

//Function Number: 24
cancel_on_player_damage()
{
	self endon("exiting_uav_control");
	self.took_damage = 0;
	if(maps\_utility::is_survival())
	{
		common_scripts\utility::waittill_any("player_has_red_flashing_overlay","player_downed","dtest","force_out_of_uav");
	}
	else
	{
		common_scripts\utility::waittill_any("damage","dtest","force_out_of_uav");
	}

	self.took_damage = 1;
	maps\_audio::aud_send_msg("abort_UAV_control");
}

//Function Number: 25
text_titlecreate()
{
	level.text1 = maps\_hud_util::createclientfontstring("objective",2);
	var_00 = -175;
	if(maps\_utility::is_survival())
	{
		var_00 = -150;
		if(issplitscreen())
		{
			var_00 = -110;
		}
	}

	level.text1 maps\_hud_util::setpoint("CENTER",undefined,0,var_00);
}

//Function Number: 26
text_titlesettext(param_00)
{
	level.text1 settext(param_00);
}

//Function Number: 27
text_titlefadeout()
{
	level.text1 fadeovertime(0.25);
	level.text1.alpha = 0;
}

//Function Number: 28
text_titledestroy()
{
	if(!isdefined(level.text1))
	{
		return;
	}

	level.text1 destroy();
	level.text1 = undefined;
}

//Function Number: 29
display_wait_to_fire(param_00)
{
	text_noticedestroy();
	text_labelcreate(&"HELLFIRE_RELOADING_WITH_TIME",param_00);
	wait 1;
	text_noticedestroy();
}

//Function Number: 30
text_labelcreate(param_00,param_01)
{
	level.text2 = maps\_hud_util::createclientfontstring("objective",1.85);
	level.text2 maps\_hud_util::setpoint("CENTER",undefined,0,-120);
	level.text2.label = param_00;
	level.text2 setvalue(param_01);
	level.text2.color = (0.85,0.85,0.85);
	level.text2.alpha = 0.75;
}

//Function Number: 31
text_noticecreate(param_00)
{
	level.text2 = maps\_hud_util::createclientfontstring("objective",1.85);
	level.text2 maps\_hud_util::setpoint("CENTER",undefined,0,-120);
	level.text2 settext(param_00);
	level.text2.color = (0.85,0.85,0.85);
	level.text2.alpha = 0.75;
}

//Function Number: 32
text_noticefadeout()
{
	if(!isdefined(level.text2))
	{
		return;
	}

	level.text2 fadeovertime(0.25);
	level.text2.alpha = 0;
}

//Function Number: 33
text_noticedestroy()
{
	if(!isdefined(level.text2))
	{
		return;
	}

	level.text2 destroy();
	level.text2 = undefined;
}

//Function Number: 34
waitwithabortondamage(param_00)
{
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		if(self.took_damage)
		{
			return 0;
		}

		if(isdefined(level.uav_is_destroyed))
		{
			return 0;
		}

		if(self usebuttonpressed())
		{
			return 0;
		}

		if(!common_scripts\utility::flag("uav_enabled"))
		{
			return 0;
		}

		wait 0.05;
	}

	return 1;
}

//Function Number: 35
notifyonmissiledeath(param_00,param_01)
{
	var_02 = gettime();
	level.remotemissilefiretime = var_02;
	if(isdefined(param_00))
	{
		level.var_3C11 = param_00;
		param_00 waittill("death");
	}

	param_01 maps\_utility::delaythread(0.1,::holdstancechange,1);
	param_01.active_uav_missile = undefined;
	if(isdefined(level.remotemissilefiretime) && level.remotemissilefiretime == var_02)
	{
		level notify("remote_missile_exploded");
		param_01 notify("remote_missile_exploded");
		level.var_3C11 = undefined;
	}

	level maps\_utility::delaythread(0.2,::maps\_utility::send_notify,"delayed_remote_missile_exploded");
}

//Function Number: 36
abortlaptopswitch(param_00)
{
	param_00 maps\_utility::ent_flag_clear("controlling_UAV");
	param_00 notify("exiting_uav_control");
	maps\_audio::aud_send_msg("abort_UAV_control");
	param_00 visionsetnakedforplayer(level.var_13EE,0.5);
	if(isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
	{
		param_00 visionsetthermalforplayer(level.visionthermaldefault,0.5);
	}
	else if(isdefined(maps\_utility::get_vision_set_fog(level.var_13EE)))
	{
		param_00 maps\_utility::fog_set_changes(level.var_13EE,0.5);
	}

	param_00 switchbacktomainweapon();
	param_00 freezecontrols(0);
	if(!maps\_utility::is_player_down(param_00))
	{
		param_00 enableoffhandweapons();
	}

	param_00 maps\_utility::delaythread(0.1,::holdstancechange,1);
	level.uavtargetent = undefined;
	wait 0.1;
	huditemsshow();
}

//Function Number: 37
holdstancechange(param_00)
{
	if(!param_00)
	{
		var_01 = self getstance();
		if(var_01 != "prone")
		{
			self allowprone(param_00);
		}

		if(var_01 != "crouch")
		{
			self allowcrouch(param_00);
		}

		if(var_01 != "stand")
		{
			self allowstand(param_00);
			return;
		}

		return;
	}

	self allowprone(param_00);
	self allowcrouch(param_00);
	self allowstand(param_00);
}

//Function Number: 38
uavremotelaunchersequence(param_00,param_01)
{
	if(param_01 == "remote_missile_detonator")
	{
		param_00 givemaxammo(param_01);
	}

	level notify("starting_predator_drone_control");
	param_00 notify("starting_predator_drone_control");
	var_02 = 0;
	var_03 = 0;
	level.vision_black = "black_bw";
	if(!isdefined(level.var_3BDB))
	{
		level.var_3BDB = "ac130";
	}

	level.vision_missile = "missilecam";
	param_00 disableoffhandweapons();
	param_00 freezecontrols(1);
	param_00 holdstancechange(0);
	param_00 maps\_utility::ent_flag_set("controlling_UAV");
	var_04 = param_00 waitwithabortondamage(1);
	if(!var_04)
	{
		abortlaptopswitch(param_00);
		return;
	}

	var_05 = 0.25;
	param_00 visionsetnakedforplayer(level.vision_black,var_05);
	if(isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
	{
		param_00 visionsetthermalforplayer(level.vision_black,var_05);
	}

	huditemshide();
	var_04 = waitwithabortondamage(var_05);
	if(!var_04)
	{
		abortlaptopswitch(param_00);
		return;
	}

	param_00.is_controlling_uav = 1;
	level notify("player_is_controlling_UAV");
	param_00 notify("player_is_controlling_UAV");
	var_06 = param_00 get_uav();
	if(isdefined(var_06))
	{
		if(maps\_utility::is_specialop())
		{
			var_06 hideonclient(self);
		}
		else
		{
			var_06 hide();
		}
	}

	var_07 = maps\_remotemissile_utility::player_uav_rig();
	if(!maps\_remotemissile_utility::remotemissile_move_player())
	{
		param_00 playerlinkweaponviewtodelta(var_07,"tag_player",1,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered);
		var_08 = var_07 gettagangles("tag_origin");
		param_00 setplayerangles(var_08);
	}
	else
	{
		param_00.old_origin = param_00.origin;
		param_00.old_angles = param_00 getplayerangles();
		param_00 playerlinktodelta(maps\_remotemissile_utility::player_uav_rig(),"tag_player",1,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered);
		param_00 playerlinktodelta(maps\_remotemissile_utility::player_uav_rig(),"tag_player",1,0,0,0,0);
		param_00 maps\_utility::delaythread(0.1,::open_view_cone);
	}

	param_00 freezecontrols(0);
	param_00 hideviewmodel();
	wait 0.05;
	if(isdefined(level.var_3C1C))
	{
		param_00 [[ level.var_3C1C ]]();
	}
	else
	{
		param_00 text_titlecreate();
		text_titlesettext(&"HELLFIRE_DRONE_VIEW");
	}

	if(isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
	{
		maps\_load::thermal_effectson();
		param_00 thermalvisionon();
		param_00 visionsetthermalforplayer(level.var_3BDB,0.25);
		param_00 visionsetnakedforplayer(level.var_13EE,0.25);
	}
	else
	{
		if(isdefined(maps\_utility::get_vision_set_fog(level.var_3BDB)))
		{
			param_00 maps\_utility::fog_set_changes(level.var_3BDB,0.25);
		}

		param_00 visionsetnakedforplayer(level.var_3BDB,0.25);
	}

	thread drawtargetsstart();
	wait 0.2;
	var_09 = waitforattackcommand(param_00);
	if(!var_09)
	{
		exitfromcamera_uav(param_00,param_00.took_damage);
		return;
	}

	level.last_uav_launch_time = gettime();
	thread uav_reload();
	level notify("player_fired_remote_missile");
	param_00 notify("player_fired_remote_missile");
	var_0A = firemissilefromuavplayer(param_00);
	var_0A thread do_physics_impact_on_explosion(param_00);
	var_0A thread flash_for_explosion_early(param_00);
	if(var_02)
	{
		param_00 text_noticecreate(&"HELLFIRE_FIRE");
		var_04 = waitwithabortondamage(1.2);
		if(!var_04)
		{
			exitfromcamera_uav(param_00,1);
			return;
		}

		text_noticefadeout();
		drawtargetsend();
		wait 0.25;
	}

	param_00.var_3BDE = 1;
	if(isdefined(level.vision_uav))
	{
		param_00 [[ level.vision_uav ]](0);
	}
	else
	{
		text_titlesettext(&"HELLFIRE_MISSILE_VIEW");
		text_noticedestroy();
	}

	switchbacktomainweaponfast();
	param_00 remotecamerasoundscapeon();
	param_00 unlink();
	param_00 disableweapons();
	if(isdefined(level.var_3C1E))
	{
		param_00 cameralinkto(var_0A,level.var_3C1E);
	}
	else
	{
		param_00 cameralinkto(var_0A,"tag_origin");
	}

	param_00 controlslinkto(var_0A);
	var_04 = waitwithabortondamage(0.2);
	if(!var_04)
	{
		exitfromcamera_missile(param_00,1);
		return;
	}

	if(isdefined(level.remote_missile_detonate_height))
	{
		param_00 [[ level.remote_missile_detonate_height ]](var_0A);
	}

	thread drawtargetsstart();
	while(isdefined(level.var_3C11))
	{
		wait 0.05;
		if(isdefined(level.uav_is_destroyed))
		{
			exitfromcamera_missile(param_00,1);
			return;
		}

		if(param_00.took_damage)
		{
			exitfromcamera_missile(param_00,1);
			return;
		}

		if(!common_scripts\utility::flag("uav_enabled"))
		{
			exitfromcamera_missile(param_00,1);
			return;
		}
	}

	if(!isdefined(var_06))
	{
		exitfromcamera_missile(param_00,0);
		return;
	}

	if(var_03)
	{
		setsaveddvar("cg_fov",26);
		param_00.var_3C20 = 1;
		param_00.var_3BDE = undefined;
		param_00 controlsunlink();
		param_00 cameraunlink();
		param_00 remotecamerasoundscapeoff();
		param_00 playerlinkweaponviewtodelta(maps\_remotemissile_utility::player_uav_rig(),"tag_player",1,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered);
		param_00 setplayerangles(maps\_remotemissile_utility::player_uav_rig() gettagangles("tag_origin"));
		var_04 = waitwithabortondamage(2);
		if(!var_04)
		{
			exitfromcamera_uav(param_00,param_00.took_damage);
			return;
		}

		exitfromcamera_uav(param_00,0);
		return;
	}

	exitfromcamera_missile(param_00,0);
}

//Function Number: 39
uav_reload()
{
	level endon("stop_uav_reload");
	common_scripts\utility::flag_set("uav_reloading");
	wait level.min_time_between_uav_launches * 0.001;
	common_scripts\utility::flag_clear("uav_reloading");
}

//Function Number: 40
flash_for_explosion_early(param_00)
{
	param_00 waittill("predicted_projectile_impact",var_01,var_02);
	param_00 visionsetnakedforplayer("coup_sunblind",0);
}

//Function Number: 41
do_physics_impact_on_explosion(param_00)
{
	param_00.var_3C24 = 1;
	param_00 waittill("projectile_impact",var_01,var_02,var_03);
	level thread missile_kills(param_00);
	level.var_3C25 = var_02;
	var_04 = 1000;
	var_05 = 6;
	earthquake(0.3,1.4,var_02,8000);
	maps\_audio::aud_send_msg("remote_missle_impact",var_02);
	wait 0.1;
	physicsexplosionsphere(var_02,var_04,var_04 / 2,var_05);
	wait 2;
	level.var_3C25 = undefined;
	param_00.var_3C24 = undefined;
}

//Function Number: 42
missile_kills(param_00)
{
	common_scripts\utility::flag_set("uav_collecting_stats");
	var_01 = maps\_utility::getvehiclearray();
	foreach(var_03 in var_01)
	{
		var_03 thread missile_kill_vehicle(param_00);
	}

	wait 1;
	common_scripts\utility::flag_clear("uav_collecting_stats");
}

//Function Number: 43
missile_kill_ai(param_00)
{
	if(!isdefined(level.uav_radio_initialized))
	{
		return;
	}

	self waittill("death",param_00,var_01);
	if(!isdefined(level.uav_user))
	{
		return;
	}

	if(!isdefined(level.uav_killstats["ai"]))
	{
		level.uav_killstats["ai"] = 0;
	}

	if(isdefined(param_00) && isdefined(level.uav_user))
	{
		if(param_00 == level.uav_user || isdefined(param_00.attacker) && param_00.attacker == level.uav_user)
		{
			level.uav_killstats["ai"]++;
		}
	}
}

//Function Number: 44
missile_kill_vehicle(param_00)
{
	if(!isdefined(level.uav_radio_initialized))
	{
		return;
	}

	level endon("delayed_remote_missile_exploded");
	var_01 = undefined;
	switch(self.vehicletype)
	{
		case "btr80_physics":
		case "btr80":
			var_01 = "btr";
			break;

		case "mi17_bulletdamage":
		case "ucav":
		case "mi17_noai":
		case "mi17":
		case "hind":
			var_01 = "helo";
			break;

		case "uaz_physics":
		case "uaz":
			var_01 = "jeep";
			break;

		case "bm21_drivable":
		case "bm21":
		case "bm21_troops":
			var_01 = "truck";
			break;

		default:
			var_01 = "vehicle";
			break;
	}

	if(!isdefined(level.uav_killstats[var_01]))
	{
		level.uav_killstats[var_01] = 0;
	}

	self waittill("death",var_02,var_03);
	if(var_01 == "helo" || var_01 == "btr" || isdefined(self.riders) && self.riders.size > 0)
	{
		if(isdefined(var_02) && var_02 == param_00)
		{
			level.uav_killstats[var_01]++;
		}
	}
}

//Function Number: 45
get_current_uav_rig()
{
	var_00 = self.var_3BF0[self.var_3C2A];
	return var_00;
}

//Function Number: 46
get_uav()
{
	if(!isdefined(self.var_3BF0))
	{
		return level.uav;
	}

	if(!isdefined(self.var_3C2A))
	{
		self.var_3C2A = 0;
	}

	var_00 = get_current_uav_rig();
	return var_00.uav;
}

//Function Number: 47
exitfromcamera_missile(param_00,param_01)
{
	param_00.var_3BDE = undefined;
	if(isdefined(level.vision_uav))
	{
		param_00 [[ level.vision_uav ]](1);
	}
	else
	{
		text_titledestroy();
	}

	drawtargetsend();
	if(isdefined(level.uav_is_destroyed))
	{
		thread staticeffect(0.5);
	}

	param_00 controlsunlink();
	param_00 cameraunlink();
	if(isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
	{
		maps\_load::thermal_effectsoff();
		param_00 thermalvisionoff();
		param_00 visionsetthermalforplayer(level.visionthermaldefault,0);
	}

	param_00 remotecamerasoundscapeoff();
	var_02 = param_00 get_uav();
	if(isdefined(var_02))
	{
		if(maps\_utility::is_specialop())
		{
			var_02 showonclient(self);
		}
		else
		{
			var_02 show();
		}
	}

	if(param_01)
	{
		param_00 visionsetnakedforplayer(level.vision_black,0);
		wait 0.05;
		param_00 visionsetnakedforplayer(level.var_13EE,0.4);
		if(!isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
		{
			if(isdefined(maps\_utility::get_vision_set_fog(level.var_13EE)))
			{
				param_00 maps\_utility::fog_set_changes(level.var_13EE,0.4);
			}
		}

		if(!maps\_utility::is_player_down(param_00))
		{
			param_00 enableweapons();
		}

		param_00 freezecontrols(0);
		param_00 showviewmodel();
		wait 0.2;
		huditemsshow();
		if(!maps\_utility::is_player_down(param_00))
		{
			param_00 enableoffhandweapons();
		}
	}
	else
	{
		param_00 visionsetnakedforplayer("coup_sunblind",0);
		param_00 freezecontrols(1);
		wait 0.05;
		param_00 visionsetnakedforplayer(level.var_13EE,1);
		if(!isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
		{
			if(isdefined(maps\_utility::get_vision_set_fog(level.var_13EE)))
			{
				param_00 maps\_utility::fog_set_changes(level.var_13EE,1);
			}
		}

		if(!maps\_utility::is_player_down(param_00))
		{
			param_00 enableweapons();
		}

		param_00 showviewmodel();
		wait 0.5;
		huditemsshow();
		if(!maps\_utility::is_player_down(param_00))
		{
			param_00 enableoffhandweapons();
		}

		param_00 freezecontrols(0);
	}

	param_00 notify("exiting_uav_control");
	param_00.is_controlling_uav = undefined;
	level.uavtargetent = undefined;
}

//Function Number: 48
exitfromcamera_uav(param_00,param_01)
{
	maps\_audio::aud_send_msg("abort_UAV_control");
	drawtargetsend();
	if(isdefined(level.uav_rigs))
	{
		param_00 [[ level.uav_rigs ]](0);
	}
	else
	{
		text_titlefadeout();
		text_noticefadeout();
	}

	param_00 visionsetnakedforplayer(level.vision_black,0.25);
	if(isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
	{
		param_00 visionsetthermalforplayer(level.vision_black,0.25);
	}

	if(isdefined(level.uav_is_destroyed))
	{
		param_00 thread staticeffect(0.5);
	}

	wait 0.15;
	wait 0.35;
	if(isdefined(level.uav_rigs))
	{
		param_00 [[ level.uav_rigs ]](1);
	}
	else
	{
		text_titledestroy();
		text_noticedestroy();
	}

	param_00 unlink();
	if(isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
	{
		param_00 visionsetthermalforplayer(level.visionthermaldefault,0);
		maps\_load::thermal_effectsoff();
		param_00 thermalvisionoff();
	}

	if(isdefined(param_00.var_3C20))
	{
		setsaveddvar("cg_fov",65);
	}

	var_02 = param_00 get_uav();
	if(isdefined(var_02))
	{
		if(maps\_utility::is_specialop())
		{
			var_02 showonclient(self);
		}
		else
		{
			var_02 show();
		}
	}

	if(param_01)
	{
		param_00 switchbacktomainweaponfast();
		param_00 freezecontrols(1);
		wait 0.15;
		param_00 visionsetnakedforplayer(level.var_13EE,0.4);
		if(!isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
		{
			if(isdefined(maps\_utility::get_vision_set_fog(level.var_13EE)))
			{
				param_00 maps\_utility::fog_set_changes(level.var_13EE,0.4);
			}
		}

		if(!maps\_utility::is_player_down(param_00))
		{
			param_00 enableweapons();
		}

		param_00 showviewmodel();
		wait 0.1;
		huditemsshow();
		if(!maps\_utility::is_player_down(param_00))
		{
			param_00 enableoffhandweapons();
		}

		param_00 freezecontrols(0);
	}
	else
	{
		param_00 freezecontrols(1);
		wait 0.05;
		param_00 visionsetnakedforplayer(level.var_13EE,0.75);
		if(!isdefined(level.remote_missile_grain_overlay) && level.remote_missile_grain_overlay)
		{
			if(isdefined(maps\_utility::get_vision_set_fog(level.var_13EE)))
			{
				param_00 maps\_utility::fog_set_changes(level.var_13EE,0.75);
			}
		}

		if(!maps\_utility::is_player_down(param_00))
		{
			param_00 enableweapons();
		}

		param_00 showviewmodel();
		wait 0.5;
		huditemsshow();
		param_00 switchbacktomainweapon();
		if(!maps\_utility::is_player_down(param_00))
		{
			param_00 enableoffhandweapons();
		}

		param_00 freezecontrols(0);
	}

	param_00 maps\_utility::delaythread(0.1,::holdstancechange,1);
	param_00 notify("exiting_uav_control");
	param_00.is_controlling_uav = undefined;
	level.uavtargetent = undefined;
}

//Function Number: 49
waitforattackcommand(param_00)
{
	param_00 notifyonplayercommand("abort_remote_missile","weapnext");
	param_00 notifyonplayercommand("abort_remote_missile","+stance");
	if(!level.console)
	{
		param_00 notifyonplayercommand("abort_remote_missile","+gostand");
		param_00 notifyonplayercommand("abort_remote_missile","togglecrouch");
		param_00 notifyonplayercommand("abort_remote_missile","toggleprone");
	}

	param_00 notifyonplayercommand("launch_remote_missile","+attack");
	param_00 notifyonplayercommand("launch_remote_missile","+attack_akimbo_accessible");
	param_00 thread wait_for_other();
	param_00 thread wait_for_command_thread("abort_remote_missile","abort");
	if(common_scripts\utility::flag("predator_missile_launch_allowed"))
	{
		param_00 thread wait_for_command_thread("launch_remote_missile","launch");
	}

	param_00 waittill("remote_missile_attack",var_01);
	param_00 maps\_utility::ent_flag_clear("controlling_UAV");
	if(var_01 == "launch")
	{
		return 1;
	}

	return 0;
}

//Function Number: 50
wait_for_command_thread(param_00,param_01)
{
	self endon("remote_missile_attack");
	self waittill(param_00);
	self notify("remote_missile_attack",param_01);
}

//Function Number: 51
wait_for_other()
{
	self endon("remote_missile_attack");
	for(;;)
	{
		wait 0.05;
		if(self.took_damage)
		{
			break;
		}

		if(!common_scripts\utility::flag("uav_enabled"))
		{
			break;
		}

		if(isdefined(level.uav_is_destroyed))
		{
			break;
		}
	}

	self notify("remote_missile_attack","abort");
}

//Function Number: 52
huditemshide()
{
	if(level.players.size > 0)
	{
		for(var_00 = 0;var_00 < level.players.size;var_00++)
		{
			if(isdefined(level.players[var_00].using_uav) && level.players[var_00].using_uav)
			{
				setdvar("ui_remotemissile_playernum",var_00 + 1);
			}
		}

		return;
	}

	setsaveddvar("compass","0");
	setsaveddvar("ammoCounterHide","1");
	setsaveddvar("actionSlotsHide","1");
}

//Function Number: 53
huditemsshow()
{
	if(level.players.size > 0)
	{
		setdvar("ui_remotemissile_playernum",0);
		return;
	}

	setsaveddvar("compass","1");
	setsaveddvar("ammoCounterHide","0");
	setsaveddvar("actionSlotsHide","0");
}

//Function Number: 54
firemissilefromuavplayer(param_00)
{
	earthquake(0.25,0.5,maps\_remotemissile_utility::player_uav_rig().origin,5000);
	var_01 = maps\_remotemissile_utility::player_uav_rig().origin;
	var_02 = param_00 getplayerangles();
	var_03 = anglestoforward(var_02);
	var_04 = anglestoright(var_02);
	if(!isdefined(level.var_3C36))
	{
		level.var_3C36 = -300;
	}

	if(!isdefined(level.var_3C37))
	{
		level.var_3C37 = 700;
	}

	var_05 = var_01 + var_04 * level.var_3C37 + var_03 * level.var_3C36;
	var_06 = var_05 + var_03 * 10;
	if(isdefined(level.uav_missile_override))
	{
		var_07 = magicbullet(level.uav_missile_override,var_05,var_06,param_00);
	}
	else if(isdefined(level.var_3C38))
	{
		var_07 = magicbullet("remote_missile_snow",var_06,var_07,var_01);
	}
	else if(isdefined(level.var_3C39))
	{
		var_07 = magicbullet("remote_missile_invasion",var_06,var_07,var_01);
	}
	else
	{
		var_07 = magicbullet("remote_missile",var_06,var_07,var_01);
	}

	param_00.active_uav_missile = var_07;
	thread notifyonmissiledeath(var_07,param_00);
	return var_07;
}

//Function Number: 55
drawtargetsstart()
{
	level.remotemissile.draw_red_boxes = 1;
	level endon("uav_destroyed");
	level endon("draw_target_end");
	level notify("stop_prv_draw_targets");
	level endon("stop_prv_draw_targets");
	wait 0.05;
	var_00 = 4;
	var_01 = 0;
	var_02 = 0.05;
	foreach(var_04 in level.remote_missile_targets)
	{
		if(!isalive(var_04))
		{
			continue;
		}

		var_04 draw_target();
		var_01++;
		if(var_01 >= var_00)
		{
			var_01 = 0;
			wait var_02;
		}
	}
}

//Function Number: 56
draw_target()
{
	self.has_target_shader = 1;
	if(isdefined(self.var_28A1))
	{
		target_set(self,(0,0,-96));
	}
	else
	{
		target_set(self,(0,0,64));
	}

	if(isai(self))
	{
		if(issplitscreen())
		{
			target_setshader(self,"remotemissile_infantry_target_2plr");
		}
		else
		{
			target_setshader(self,"remotemissile_infantry_target");
		}
	}
	else if(isplayer(self))
	{
		if(isdefined(self.is_controlling_uav) && self.is_controlling_uav)
		{
			target_setshader(self,"hud_fofbox_self_sp");
		}
		else
		{
		}
	}
	else
	{
		target_setshader(self,"veh_hud_target");
	}

	var_00 = undefined;
	var_01 = undefined;
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.is_controlling_uav) && var_03.is_controlling_uav)
		{
			target_showtoplayer(self,var_03);
			continue;
		}

		target_hidefromplayer(self,var_03);
	}
}

//Function Number: 57
drawtargetsend()
{
	level notify("draw_target_end");
	level.remotemissile.draw_red_boxes = undefined;
	waittillframeend;
	foreach(var_01 in level.remote_missile_targets)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(isdefined(var_01.has_target_shader))
		{
			var_01.has_target_shader = undefined;
			target_remove(var_01);
		}
	}
}

//Function Number: 58
switchbacktomainweapon()
{
	return switchbacktomainweapon_internal(::_switcher);
}

//Function Number: 59
switchbacktomainweaponfast()
{
	return switchbacktomainweapon_internal(::_switchernow);
}

//Function Number: 60
_switcher(param_00)
{
	self switchtoweapon(param_00);
}

//Function Number: 61
_switchernow(param_00)
{
	self switchtoweaponimmediate(param_00);
}

//Function Number: 62
switchbacktomainweapon_internal(param_00)
{
	if(maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed"))
	{
		return;
	}

	var_01 = self getweaponslist("primary","altmode");
	foreach(var_03 in var_01)
	{
		if(self.last_weapon == var_03)
		{
			self [[ param_00 ]](self.last_weapon);
			return;
		}
	}

	if(var_01.size > 0)
	{
		self [[ param_00 ]](var_01[0]);
	}
}

//Function Number: 63
staticeffect(param_00)
{
	var_01 = spawn("script_origin",(0,0,1));
	var_01.origin = self.origin;
	var_01 playsound("predator_drone_static","sounddone");
	var_02 = newclienthudelem(self);
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02 setshader("ac130_overlay_grain",640,480);
	wait param_00;
	var_02 destroy();
	wait 3;
	var_01 stopsounds();
	wait 1;
	var_01 delete();
}

//Function Number: 64
player_can_cycle_uav_rigs()
{
	self endon("controlling_UAV");
	var_00 = self attackbuttonpressed();
	for(;;)
	{
		var_01 = self attackbuttonpressed();
		if(!var_00 && var_01)
		{
			self.var_3C2A++;
			self.var_3C2A = self.var_3C2A % self.var_3BF0.size;
			var_02 = maps\_remotemissile_utility::player_uav_rig();
			self unlink();
			var_03 = level.remotemissile.fov_is_altered;
			self playerlinkweaponviewtodelta(var_02,"tag_player",1,var_03,var_03,var_03,var_03,1);
			var_04 = var_02 gettagangles("tag_origin");
			self setplayerangles(var_04);
		}

		var_00 = var_01;
		wait 0.05;
	}
}

//Function Number: 65
cycle_uav_rigs()
{
	if(self.var_3BF0.size <= 1)
	{
		return;
	}

	if(isdefined(self.var_3C46))
	{
		return;
	}

	self.var_3C46 = 1;
	for(;;)
	{
		maps\_utility::ent_flag_wait("controlling_UAV");
		player_can_cycle_uav_rigs();
	}
}

//Function Number: 66
run_rig_function_when_player_uses_uav(param_00,param_01)
{
	var_02 = [];
	var_03 = var_7B[var_02.unique_id];
	for(;;)
	{
		var_02 maps\_utility::ent_flag_wait("controlling_UAV");
		thread [[ param_01 ]](var_02);
		var_02 maps\_utility::ent_flag_waitopen("controlling_UAV");
		setsaveddvar(var_03,1);
	}
}

//Function Number: 67
open_view_cone()
{
	self lerpviewangleclamp(0,0,0,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered,level.remotemissile.fov_is_altered * 0.25,level.remotemissile.fov_is_altered);
}