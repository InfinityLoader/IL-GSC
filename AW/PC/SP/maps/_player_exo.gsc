/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_player_exo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 124
 * Decompile Time: 2008 ms
 * Timestamp: 10/27/2023 2:00:12 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		param_00 = tolower(param_00);
		if(param_00 != "assault" && param_00 != "specialist")
		{
			param_00 = undefined;
		}
	}

	player_exo_init(param_00,param_01);
	level thread maps\_upgrade_system::init();
	if(!isdefined(param_02) || param_02 == 1)
	{
		player_exo_activate();
	}
}

//Function Number: 2
player_exo_init(param_00,param_01)
{
	precacheshader("objective_onscreen");
	precacheshader("ui_circle");
	precacheshader("dpad_icon_overdrive");
	precacheshader("dpad_icon_overdrive_off");
	level._effect["grenade_indicator_danger"] = loadfx("vfx/ui/grenade_indicator_danger");
	precacheshader("dpad_icon_stim");
	precacheshader("dpad_icon_stim_off");
	level._effect["exo_stim"] = loadfx("vfx/ui/ui_exo_health_overlay_sp");
	precacheshellshock("wb_player_boost");
	precacheshader("ugv_vignette_overlay");
	precachestring(&"update_overdrive");
	level.player maps\_utility::playerallowalternatemelee(0);
	thread handle_weaponhud_visibility();
	maps\_sonicaoe::initsonicaoe();
	setsaveddvar("high_jump_double_tap","1");
	thread maps\_player_high_jump::main();
	if(!isdefined(level.player.exclusive))
	{
		level.player.exclusive = [];
	}

	if(!isdefined(level.player.exo_old_values))
	{
		level.player.exo_old_values = [];
	}

	level.exosetfuncs = [];
	level.exounsetfuncs = [];
	level.player.exclusive["show_grenades"] = 0;
	level.exosetfuncs["show_grenades"] = ::setshowgrenades;
	level.exounsetfuncs["show_grenades"] = ::unsetshowgrenades;
	level.player.exclusive["friendly_detection"] = 1;
	level.exosetfuncs["friendly_detection"] = ::setfriendlydetection;
	level.exounsetfuncs["friendly_detection"] = ::unsetfriendlydetection;
	level.player.exclusive["enemy_detection"] = 0;
	level.exosetfuncs["enemy_detection"] = ::setenemydetection;
	level.exounsetfuncs["enemy_detection"] = ::unsetenemydetection;
	level.player.exclusive["move_speed_increase"] = 0;
	level.exosetfuncs["move_speed_increase"] = ::setmovespeedincrease;
	level.exounsetfuncs["move_speed_increase"] = ::unsetmovespeedincrease;
	level.player.exclusive["jump_increase"] = 0;
	level.exosetfuncs["jump_increase"] = ::setjumpincrease;
	level.exounsetfuncs["jump_increase"] = ::unsetjumpincrease;
	level.player.exclusive["boost_dash"] = 1;
	level.exosetfuncs["boost_dash"] = ::setboostdash;
	level.exounsetfuncs["boost_dash"] = ::unsetboostdash;
	level.player.exclusive["overdrive"] = 0;
	overdrive_initialize_params();
	level.exosetfuncs["overdrive"] = ::setoverdrive;
	level.exounsetfuncs["overdrive"] = ::unsetoverdrive;
	level.player.exclusive["intel_mode"] = 1;
	level.exosetfuncs["intel_mode"] = ::setintelmode;
	level.exounsetfuncs["intel_mode"] = ::unsetintelmode;
	level.player.exclusive["exo_melee"] = 1;
	level.exosetfuncs["exo_melee"] = ::setexomelee;
	level.exounsetfuncs["exo_melee"] = ::unsetexomelee;
	level.player.exclusive["exo_slide"] = 1;
	level.exosetfuncs["exo_slide"] = ::setexoslide;
	level.exounsetfuncs["exo_slide"] = ::unsetexoslide;
	level.player.exclusive["exo_slam"] = 0;
	init_ground_slam();
	level.exosetfuncs["exo_slam"] = ::setexoslam;
	level.exounsetfuncs["exo_slam"] = ::unsetexoslam;
	level.player.exclusive["sonic_blast"] = 0;
	level.exosetfuncs["sonic_blast"] = ::setsonicblast;
	level.exounsetfuncs["sonic_blast"] = ::unsetsonicblast;
	level.player.exclusive["high_jump"] = 0;
	level.exosetfuncs["high_jump"] = ::sethighjump;
	level.exounsetfuncs["high_jump"] = ::unsethighjump;
	level.player.exclusive["exo_stim"] = 0;
	level.exosetfuncs["exo_stim"] = ::setstim;
	level.exounsetfuncs["exo_stim"] = ::unsetstim;
	level.player.exclusive["shield"] = 0;
	maps\_exo_shield_sp::init();
	level.exosetfuncs["shield"] = ::setshield;
	level.exounsetfuncs["shield"] = ::unsetshield;
	level.player.exobatteryabilities = ["overdrive","sonic_blast"];
	level.player.exospeedscalars = [];
	batteryinit();
	level.player.exo_active = 0;
	level.player.exoactivated = [];
	if(isdefined(param_00))
	{
		if(param_00 == "assault")
		{
			level.player.exclusive["high_jump"] = 1;
			level.player.exclusive["exo_slam"] = 1;
			level.player.exclusive["sonic_blast"] = 1;
		}
		else if(param_00 == "specialist")
		{
			level.player.exclusive["overdrive"] = 1;
			level.player.exclusive["shield"] = 1;
		}
	}

	if(isdefined(param_01) && param_01)
	{
		level.player.exclusive["exo_stim"] = 1;
	}
}

//Function Number: 3
player_exo_activate_single_internal(param_00)
{
	if(!isdefined(level.player.exoactivated[param_00]) && isdefined(level.exosetfuncs[param_00]))
	{
		if(common_scripts\utility::array_contains(level.player.exobatteryabilities,param_00))
		{
			batterymetervisible(param_00,1);
		}

		level.player thread [[ level.exosetfuncs[param_00] ]]();
		level.player.exoactivated[param_00] = 1;
	}
}

//Function Number: 4
player_exo_deactivate_single_internal(param_00)
{
	if(isdefined(level.player.exoactivated[param_00]) && isdefined(level.exosetfuncs[param_00]))
	{
		if(common_scripts\utility::array_contains(level.player.exobatteryabilities,param_00))
		{
			batterymetervisible(param_00,0);
		}

		level.player thread [[ level.exounsetfuncs[param_00] ]]();
		level.player.exoactivated[param_00] = undefined;
	}
}

//Function Number: 5
player_exo_is_active_single(param_00)
{
	return level.player.exclusive[param_00] == 1;
}

//Function Number: 6
player_exo_is_active_single_internal(param_00)
{
	return isdefined(level.player.exoactivated[param_00]);
}

//Function Number: 7
player_exo_is_active()
{
	return level.player.exo_active;
}

//Function Number: 8
player_exo_activate()
{
	level.player.exo_active = 1;
	var_00 = getarraykeys(level.player.exclusive);
	foreach(var_02 in var_00)
	{
		if(level.player.exclusive[var_02])
		{
			player_exo_activate_single_internal(var_02);
		}
	}
}

//Function Number: 9
player_exo_deactivate()
{
	level.player.exo_active = 0;
	var_00 = getarraykeys(level.player.exclusive);
	foreach(var_02 in var_00)
	{
		player_exo_deactivate_single_internal(var_02);
	}
}

//Function Number: 10
player_exo_add_single(param_00)
{
	level.player.exclusive[param_00] = 1;
	if(level.player.exo_active)
	{
		player_exo_activate_single_internal(param_00);
	}
}

//Function Number: 11
player_exo_remove_single(param_00)
{
	if(player_exo_is_active_single(param_00))
	{
		level.player.exclusive[param_00] = 0;
		player_exo_deactivate_single_internal(param_00);
	}
}

//Function Number: 12
player_exo_get_owned_array(param_00)
{
	var_01 = getarraykeys(level.player.exclusive);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(level.player.exclusive[var_04] && !isdefined(param_00) || common_scripts\utility::array_contains(param_00,var_04))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 13
player_exo_get_unowned_array(param_00)
{
	var_01 = getarraykeys(level.player.exclusive);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!level.player.exclusive[var_04] && !isdefined(param_00) || common_scripts\utility::array_contains(param_00,var_04))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 14
player_exo_set_owned_array(param_00)
{
	var_01 = getarraykeys(level.player.exclusive);
	foreach(var_03 in var_01)
	{
		if(common_scripts\utility::array_contains(param_00,var_03))
		{
			player_exo_add_single(var_03);
			continue;
		}

		player_exo_remove_single(var_03);
	}
}

//Function Number: 15
player_exo_add_array(param_00)
{
	foreach(var_02 in param_00)
	{
		player_exo_add_single(var_02);
	}
}

//Function Number: 16
player_exo_remove_array(param_00)
{
	foreach(var_02 in param_00)
	{
		player_exo_remove_single(var_02);
	}
}

//Function Number: 17
setshowgrenades()
{
	maps\_utility::add_global_spawn_function("axis",::monitor_grenades);
	common_scripts\utility::array_thread(getaiarray("axis"),::monitor_grenades);
	maps\_utility::add_global_spawn_function("allies",::monitor_grenades);
	common_scripts\utility::array_thread(getaiarray("allies"),::monitor_grenades);
	foreach(var_01 in level.players)
	{
		var_01 thread monitor_grenades();
	}
}

//Function Number: 18
unsetshowgrenades()
{
	level notify("stop_monitoring_grenades");
	maps\_utility::remove_global_spawn_function("axis",::monitor_grenades);
	maps\_utility::remove_global_spawn_function("allies",::monitor_grenades);
}

//Function Number: 19
monitor_grenades()
{
	self endon("death");
	level endon("stop_monitoring_grenades");
	for(;;)
	{
		var_00 = undefined;
		var_01 = 0;
		if(isplayer(self))
		{
			self waittill("grenade_pullback",var_02);
			if(var_02 == "fraggrenade")
			{
				var_01 = gettime();
			}
			else
			{
				var_01 = undefined;
			}

			self waittill("grenade_fire",var_00,var_02);
			if(!isdefined(var_01))
			{
				var_01 = gettime();
			}

			var_00.spawn_time = var_01;
			var_00 thread grenade_tracking(1,var_02);
			continue;
		}

		self waittill("grenade_fire",var_00,var_02);
		var_00.spawn_time = gettime();
		var_00 thread grenade_tracking(0,var_02);
	}
}

//Function Number: 20
grenade_tracking(param_00,param_01)
{
	thread grenade_display_time_remaining(param_00,param_01);
}

//Function Number: 21
grenade_display_time_remaining(param_00,param_01)
{
	self endon("death");
	level endon("stop_monitoring_grenades");
	thread grenade_indicator_fx();
}

//Function Number: 22
grenade_indicator_fx()
{
	level endon("stop_monitoring_grenades");
	wait(0.5);
	if(!isdefined(self))
	{
		return;
	}

	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.origin = self.origin;
	var_00.angles = (-90,0,0);
	playfxontag(common_scripts\utility::getfx("grenade_indicator_danger"),var_00,"tag_origin");
	while(isdefined(self))
	{
		var_01 = bullettrace(self.origin,self.origin - (0,0,1000),0,self,0,0);
		var_00.origin = var_01["position"] + (0,0,2);
		wait(0.05);
	}

	killfxontag(common_scripts\utility::getfx("grenade_indicator_danger"),var_00,"tag_origin");
	wait(0.05);
	var_00 delete();
}

//Function Number: 23
setdefaulthudoutlinestyle()
{
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",1);
	setsaveddvar("r_hudoutlinepostmode",2);
	setsaveddvar("r_hudoutlinehalolumscale",1.5);
	setsaveddvar("r_hudoutlinehaloblurradius",0.35);
}

//Function Number: 24
setharmonicbreachhudoutlinestyle()
{
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinecurvywidth",1);
	setsaveddvar("r_hudoutlinecurvywhen",1);
	setsaveddvar("r_hudoutlinepostmode",3);
	setsaveddvar("r_hudoutlinecurvylumscale",2);
	setsaveddvar("r_hudoutlinecurvydarkenscale",0.25);
	setsaveddvar("r_hudoutlinecurvyblurradius",0.5);
	setsaveddvar("r_hudoutlinecurvydepth",0.8);
}

//Function Number: 25
setfriendlydetection()
{
	var_00 = 3;
	common_scripts\utility::array_thread(getaiarray("allies"),::ai_detection,var_00);
	maps\_utility::add_global_spawn_function("allies",::ai_detection,var_00);
	setdefaulthudoutlinestyle();
	thread monitor_ai_detection();
}

//Function Number: 26
unsetfriendlydetection()
{
	level notify("stop_ai_detection");
	maps\_utility::remove_global_spawn_function("allies",::ai_detection);
}

//Function Number: 27
setenemydetection()
{
	var_00 = 1;
	common_scripts\utility::array_thread(getaiarray("axis"),::ai_detection,var_00);
	maps\_utility::add_global_spawn_function("axis",::ai_detection,var_00);
	setdefaulthudoutlinestyle();
	thread monitor_ai_detection();
}

//Function Number: 28
unsetenemydetection()
{
	level notify("stop_ai_detection");
	maps\_utility::remove_global_spawn_function("axis",::ai_detection);
}

//Function Number: 29
ai_detection(param_00)
{
	level endon("stop_ai_detection");
	self endon("death");
	self.highlight_on = 0;
	var_01 = 0;
	thread clear_ai_detection_on_death();
	for(;;)
	{
		if((!isdefined(self.cloak) || self.cloak == "off") && !isdefined(self.subclass) || self.subclass != "mech")
		{
			if(!isdefined(level.player.sonar_vision) || !level.player.sonar_vision)
			{
				if(self.highlight_on != var_01)
				{
					if(self.highlight_on)
					{
						self hudoutlineenable(param_00,1);
					}
					else
					{
						self hudoutlinedisable();
					}

					var_01 = self.highlight_on;
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 30
clear_ai_detection_on_death()
{
	common_scripts\utility::waittill_any_ents(self,"death",level,"stop_ai_detection");
	if(isdefined(self))
	{
		if((!isdefined(self.cloak) || self.cloak == "off") && !isdefined(self.subclass) || self.subclass != "mech")
		{
			self.highlight_on = 0;
			self hudoutlinedisable();
		}
	}
}

//Function Number: 31
monitor_ai_detection()
{
	level endon("stop_ai_detection");
	var_00 = 1024;
	for(;;)
	{
		if(self playerads() > 0.1)
		{
			var_01 = bullettrace(self geteye(),self geteye() + anglestoforward(self getgunangles()) * var_00,1,self);
			var_02 = var_01["entity"];
			if(isdefined(var_02) && isai(var_02))
			{
				var_02.highlight_on = 1;
				var_02 thread ai_detection_timeout();
			}
		}

		wait(0.05);
	}
}

//Function Number: 32
ai_detection_timeout()
{
	self notify("new_highlight");
	self endon("new_highlight");
	self endon("death");
	wait(0.1);
	self.highlight_on = 0;
}

//Function Number: 33
setmovespeedincrease()
{
	level.player.exospeedscalars["move_speed_increase"] = 1.25;
	exo_move_speed_update();
}

//Function Number: 34
unsetmovespeedincrease()
{
	level.player.exospeedscalars["move_speed_increase"] = undefined;
	exo_move_speed_update();
}

//Function Number: 35
setjumpincrease()
{
	self.exo_old_values["jump_height"] = getdvarint("jump_height");
	setsaveddvar("jump_height","60");
}

//Function Number: 36
unsetjumpincrease()
{
	setsaveddvar("jump_height",self.exo_old_values["jump_height"]);
}

//Function Number: 37
setboostdash()
{
	level.player allowdodge(1);
}

//Function Number: 38
unsetboostdash()
{
	level.player allowdodge(0);
}

//Function Number: 39
boost_dash_track_player_movement()
{
	self endon("death");
	self endon("disable_boost_dash");
	if(!isdefined(self.boost["stick_input"]))
	{
		self.boost["stick_input"] = (0,0,0);
	}

	if(!isdefined(self.boost["stick_global"]))
	{
		self.boost["stick_global"] = (0,0,0);
	}

	for(;;)
	{
		var_00 = self getnormalizedmovement();
		var_00 = (var_00[0],var_00[1] * -1,0);
		var_01 = self.angles;
		var_02 = vectortoangles(var_00);
		var_03 = common_scripts\utility::flat_angle(combineangles(var_01,var_02));
		var_04 = anglestoforward(var_03) * length(var_00);
		self.boost["stick_input"] = var_02;
		self.boost["stick_global"] = var_04;
		wait(0.05);
	}
}

//Function Number: 40
boost_dash_track_player_velocity()
{
	self endon("death");
	self endon("disable_boost_dash");
	if(!isdefined(self.boost["player_vel"]))
	{
		self.boost["player_vel"] = (0,0,0);
	}

	for(;;)
	{
		self.boost["player_vel"] = self getvelocity();
		wait(0.05);
	}
}

//Function Number: 41
boost_dash_think()
{
	self endon("death");
	self endon("disable_boost_dash");
	var_00 = 400;
	var_01 = (0,0,250);
	var_02 = 10;
	var_03 = 500;
	var_04 = 1;
	for(;;)
	{
		waittill_dash_button_pressed();
		var_05 = 0;
		if(self isonground() && !self adsbuttonpressed() && level.player getstance() != "prone")
		{
			if(self.boost["stick_input"][0] > 0)
			{
			}
			else if(self.boost["stick_input"][1] > 315 || self.boost["stick_input"][1] < 45)
			{
			}
			else
			{
				thread boost_dash(var_00,var_01,var_02,var_04,var_03);
				var_05 = 1;
			}
		}

		waittill_dash_button_released(var_05);
	}
}

//Function Number: 42
enable_boost_attack()
{
	self endon("mode_switch");
	self endon("death");
	var_00 = 300;
	var_01 = 1000;
	var_02 = (0,0,350);
	var_03 = 0.5;
	var_04 = 1;
	var_05 = 1;
	for(;;)
	{
		if(self sprintbuttonpressed() && self meleebuttonpressed())
		{
			if(self.boost["stick_input"][1] > 315 || self.boost["stick_input"][1] < 45)
			{
				boost_attack(var_00,var_02,var_03,var_04,var_01);
				wait(1);
			}
		}

		wait(0.05);
	}
}

//Function Number: 43
boost_dash(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("mode_switch");
	self endon("death");
	level.player soundscripts\_snd::snd_message("boost_dodge_activate_plr");
	self.boost["inboost"] = 1;
	var_06 = self.boost["stick_global"];
	var_07 = self.boost["player_vel"] * param_02;
	if(var_07[2] > 0)
	{
		var_07 = (var_07[0],var_07[1],0);
	}

	var_08 = var_07 + var_06 * param_00 + param_01;
	if(isdefined(param_03) && param_03)
	{
		if(!isdefined(param_04))
		{
			var_09 = param_01[2];
		}

		var_0A = var_08;
		var_08 = vectornormalize(var_08) * param_04;
		var_08 = (var_08[0],var_08[1],var_0A[2]);
		if(var_06[2] == 0)
		{
			var_0B = 0.7;
			var_08 = (var_08[0],var_08[1],var_08[2] * var_0B);
		}
	}

	var_0C = 2;
	if(isdefined(param_05) && param_05)
	{
		var_0D = 0;
		var_0E = self.boost["player_vel"];
		var_0F = var_08;
		var_10 = var_0F - var_0E;
		var_11 = var_10 / var_0C;
		while(var_0D <= var_0C)
		{
			self setvelocity(var_0E + var_11);
			wait(0.05);
			var_0D++;
		}
	}

	self setvelocity(var_08);
}

//Function Number: 44
boost_attack(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("mode_switch");
	self endon("death");
	thread boost_attack_deal_damage();
	self.boost["inboost"] = 1;
	var_06 = self.boost["stick_global"];
	var_07 = self.boost["player_vel"] * param_02;
	if(var_07[2] > 0)
	{
		var_07 = (var_07[0],var_07[1],0);
	}

	var_08 = var_07 + var_06 * param_00 + param_01;
	if(isdefined(param_03) && param_03)
	{
		if(!isdefined(param_04))
		{
			var_09 = param_01[2];
		}

		var_0A = var_08;
		var_08 = vectornormalize(var_08) * param_04;
		var_08 = (var_08[0],var_08[1],var_0A[2]);
		if(var_06[2] == 0)
		{
			var_0B = 0.7;
			var_08 = (var_08[0],var_08[1],var_08[2] * var_0B);
		}
	}

	var_0C = 2;
	if(isdefined(param_05) && param_05)
	{
		var_0D = 0;
		var_0E = self.boost["player_vel"];
		var_0F = var_08;
		var_10 = var_0F - var_0E;
		var_11 = var_10 / var_0C;
		while(var_0D <= var_0C)
		{
			self setvelocity(var_0E + var_11);
			wait(0.05);
			var_0D++;
		}
	}

	self setvelocity(var_08);
}

//Function Number: 45
boost_attack_deal_damage()
{
	while(self isonground())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		var_00 = getaiarray("axis");
		foreach(var_02 in var_00)
		{
			if(isalive(var_02))
			{
				if(distance2d(self.origin,var_02.origin) < 40)
				{
					var_02 dodamage(var_02.health + 1,self.origin,self,self,"MOD_MELEE");
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 46
waittill_dash_button_pressed()
{
	self endon("death");
	while(!self sprintbuttonpressed())
	{
		wait(0.05);
	}

	return 1;
}

//Function Number: 47
waittill_dash_button_released(param_00)
{
	var_01 = gettime();
	self endon("death");
	while(self sprintbuttonpressed())
	{
		wait(0.05);
	}

	if(isdefined(param_00))
	{
		if(gettime() - var_01 < param_00 * 1000)
		{
			wait(param_00 - gettime() - var_01 / 1000);
		}
	}

	return 1;
}

//Function Number: 48
getdefaultoverdrivespeedscale()
{
	return 1.2;
}

//Function Number: 49
setoverdrive()
{
	update_overdrive_icon();
	childthread overdrive_think();
	setomnvar("ui_overdrive_effects",1);
}

//Function Number: 50
unsetoverdrive()
{
	overdrive_disable();
	level.player setweaponhudiconoverride("actionslot1","dpad_icon_overdrive_off");
	setomnvar("ui_overdrive_effects",0);
}

//Function Number: 51
overdrive_updatebar(param_00)
{
	setomnvar("ui_overdrive_value",int(param_00 * 100));
}

//Function Number: 52
overdrive_initialize_params()
{
	if(!isdefined(level.player.exoparams))
	{
		level.player.exoparams = [];
	}

	if(!isdefined(level.player.exoparams["overdrive"]))
	{
		level.player.exoparams["overdrive"] = spawnstruct();
	}

	var_00 = level.player.exoparams["overdrive"];
	var_00.duration = 5;
	var_00.kick_in_duration = 0.5;
	var_00.kick_out_duration = 1;
	var_00.fail_duration = 0.5;
	var_00.cool_down_duration = 1;
	var_00.speed_scale = 1.2;
	var_00.action_slot_num = 1;
	var_00.battery_cost = 1;
	var_00.cooldownstate = spawnstruct();
	var_00.cooldownstate.currenttime = 1;
	var_00.cooldownstate.totaltime = 1;
	var_00.cooldownstate.state = "none";
}

//Function Number: 53
overdrive_think()
{
	var_00 = self.exoparams["overdrive"];
	self endon("death");
	self endon("overdrive_disabled");
	var_00 = level.player.exoparams["overdrive"];
	if(!maps\_utility::ent_flag_exist("overdrive_enabled"))
	{
		maps\_utility::ent_flag_init("overdrive_enabled");
	}

	if(!maps\_utility::ent_flag_exist("overdrive_hot"))
	{
		maps\_utility::ent_flag_init("overdrive_hot");
	}

	if(!maps\_utility::ent_flag_exist("overdrive_on"))
	{
		maps\_utility::ent_flag_init("overdrive_on");
	}

	overdrive_enable();
	overdrive_updatebar(1);
	for(;;)
	{
		self waittill("overdrive_button_pressed");
		if(maps\_utility::ent_flag("overdrive_enabled"))
		{
			if(maps\_utility::ent_flag("overdrive_hot"))
			{
			}
			else if(maps\_utility::ent_flag("overdrive_on"))
			{
				childthread overdrive_force_stop(0.1);
				wait(var_00.kick_out_duration);
			}
			else if(batteryspend(var_00.battery_cost))
			{
				childthread overdrive_start();
				wait(var_00.kick_in_duration);
			}
			else
			{
				wait(var_00.fail_duration);
			}

			continue;
		}
	}
}

//Function Number: 54
overdrive_enable()
{
	var_00 = self.exoparams["overdrive"];
	if(!maps\_utility::ent_flag("overdrive_enabled"))
	{
		maps\_utility::ent_flag_set("overdrive_enabled");
		self notifyonplayercommand("overdrive_button_pressed","+actionslot " + var_00.action_slot_num);
	}
}

//Function Number: 55
overdrive_disable()
{
	var_00 = self.exoparams["overdrive"];
	if(maps\_utility::ent_flag_exist("overdrive_enabled") && maps\_utility::ent_flag("overdrive_enabled"))
	{
		self notify("overdrive_disabled");
		if(overdrive_is_on())
		{
			thread overdrive_effects_stop();
		}

		maps\_utility::ent_flag_clear("overdrive_on");
		maps\_utility::ent_flag_clear("overdrive_hot");
		maps\_utility::ent_flag_clear("overdrive_enabled");
		if(!isdefined(self.exohuditem))
		{
			self.exohuditem = [];
		}
		else
		{
			self.exohuditem = common_scripts\utility::array_removeundefined(self.exohuditem);
		}

		maps\_utility::deep_array_thread(self.exohuditem,::maps\_hud_util::destroyelem);
		self notifyonplayercommandremove("overdrive_button_pressed","+actionslot " + var_00.action_slot_num);
	}
}

//Function Number: 56
overdrive_is_enabled()
{
	return maps\_utility::ent_flag("overdrive_enabled");
}

//Function Number: 57
overdrive_is_on()
{
	return maps\_utility::ent_flag("overdrive_on");
}

//Function Number: 58
overdrive_force_start()
{
	self notify("overdrive_button_pressed");
}

//Function Number: 59
overdrive_start()
{
	self endon("death");
	if(maps\_utility::ent_flag("overdrive_on"))
	{
		return;
	}

	maps\_utility::ent_flag_set("overdrive_on");
	childthread overdrive_effects_start();
	overdrive_heatup();
	childthread overdrive_effects_stop();
	maps\_utility::ent_flag_clear("overdrive_on");
	overdrive_cooldown();
}

//Function Number: 60
overdrive_manage_fov(param_00,param_01)
{
	level.player lerpfovscale(param_01,param_00);
	level.player notifyonplayercommand("ads_start","+speed_throw");
	level.player notifyonplayercommand("ads_stop","-speed_throw");
	var_02 = 0.2;
	for(;;)
	{
		if(!level.player playerads() > 0.2)
		{
			level.player waittill("ads_start");
		}

		level.player lerpfovscale(1,var_02);
		level.player waittill("ads_stop");
		level.player lerpfovscale(param_01,var_02);
	}
}

//Function Number: 61
overdrive_effects_start()
{
	self endon("overdrive_effects_stop");
	var_00 = self.exoparams["overdrive"];
	level.player.exospeedscalars["overdrive"] = var_00.speed_scale;
	exo_move_speed_update();
	player_regen_scale(4);
	level.vision_default = getdvar("vision_set_current");
	level.specular_default = getdvarfloat("r_specularcolorscale");
	visionsetoverdrive("wb_player_boost",var_00.kick_in_duration);
	soundscripts\_snd::snd_message("overdrive_on");
	maps\_utility::lerp_saveddvar("r_specularcolorscale",4.5,var_00.kick_in_duration);
	childthread overdrive_manage_fov(var_00.kick_in_duration,1.15);
	setomnvar("ui_overdrive_effects_time",var_00.kick_in_duration);
	setomnvar("ui_overdrive_effects_toggle",1);
	settimescale(0.5);
	childthread player_heartbeat();
	self playerrecoilscaleon(60);
	setsaveddvar("player_sprintUnlimited",1);
	self setviewkickscale(0.5);
}

//Function Number: 62
overdrive_effects_stop()
{
	var_00 = self.exoparams["overdrive"];
	self notify("overdrive_effects_stop");
	level.player.exospeedscalars["overdrive"] = undefined;
	exo_move_speed_update();
	player_regen_restore();
	visionsetoverdrive("",1);
	soundscripts\_snd::snd_message("overdrive_off");
	level.player lerpfovscale(1,var_00.kick_out_duration);
	setomnvar("ui_overdrive_effects_time",var_00.kick_out_duration);
	setomnvar("ui_overdrive_effects_toggle",0);
	settimescale(1);
	self playerrecoilscaleoff();
	setsaveddvar("player_sprintUnlimited",0);
	self setviewkickscale(1);
	maps\_utility::lerp_saveddvar("r_specularcolorscale",level.specular_default,2.5);
}

//Function Number: 63
overdrive_force_cooldown(param_00)
{
	var_01 = self.exoparams["overdrive"];
	var_02 = var_01.cooldownstate;
	if(var_02.state == "cooling" && var_02.totaltime - var_02.currenttime > param_00)
	{
		var_02.currenttime = var_02.totaltime - param_00;
	}
}

//Function Number: 64
overdrive_force_stop(param_00)
{
	var_01 = self.exoparams["overdrive"];
	var_02 = var_01.cooldownstate;
	if(var_02.state == "heating" && var_02.totaltime - var_02.currenttime > param_00)
	{
		var_02.currenttime = var_02.totaltime - param_00;
	}
}

//Function Number: 65
overdrive_cooldown()
{
	var_00 = self.exoparams["overdrive"];
	overdrive_cooldown_internal(var_00.cool_down_duration);
	maps\_utility::ent_flag_clear("overdrive_hot");
}

//Function Number: 66
overdrive_heatup()
{
	var_00 = self.exoparams["overdrive"];
	var_01 = var_00.duration + var_00.kick_in_duration + var_00.kick_out_duration;
	overdrive_heatup_internal(var_01);
	maps\_utility::ent_flag_set("overdrive_hot");
}

//Function Number: 67
overdrive_heatup_internal(param_00)
{
	var_01 = self.exoparams["overdrive"];
	var_02 = var_01.cooldownstate;
	var_02.state = "heating";
	var_02.currenttime = 0;
	var_02.totaltime = param_00;
	var_03 = 0.05;
	while(var_02.currenttime < var_02.totaltime)
	{
		var_04 = 1 - var_02.currenttime / var_02.totaltime;
		overdrive_updatebar(var_04);
		var_02.currenttime = var_02.currenttime + var_03;
		wait(var_03);
	}

	overdrive_updatebar(0);
}

//Function Number: 68
overdrive_cooldown_internal(param_00)
{
	var_01 = self.exoparams["overdrive"];
	var_02 = var_01.cooldownstate;
	var_02.state = "cooling";
	var_02.currenttime = 0;
	var_02.totaltime = param_00;
	var_03 = 0.05;
	while(var_02.currenttime < var_02.totaltime)
	{
		var_04 = var_02.currenttime / var_02.totaltime;
		overdrive_updatebar(var_04);
		var_02.currenttime = var_02.currenttime + var_03;
		wait(var_03);
	}

	overdrive_updatebar(1);
}

//Function Number: 69
player_heartbeat()
{
	var_00 = 0.8;
	var_01 = 0.1;
	var_02 = 8;
	self endon("death");
	wait(0.25);
	var_03 = gettime();
	while(maps\_utility::ent_flag("overdrive_on"))
	{
		wait(0.05);
		self playrumbleonentity("damage_light");
		wait(maps\_shg_utility::linear_map_clamp(gettime() - var_03 * 0.001,0,var_02,var_00,var_01));
		wait(0 + randomfloat(0.1));
	}
}

//Function Number: 70
player_regen_scale(param_00)
{
	self.old_health_regen_delay = self.gs.playerhealth_regularregendelay;
	self.old_health_long_regen_delay = self.gs.longregentime;
	self.gs.playerhealth_regularregendelay = self.gs.playerhealth_regularregendelay / param_00;
	self.gs.longregentime = self.gs.longregentime / param_00;
}

//Function Number: 71
player_regen_restore()
{
	self.gs.playerhealth_regularregendelay = self.old_health_regen_delay;
	self.gs.longregentime = self.old_health_long_regen_delay;
	self.old_health_regen_delay = undefined;
	self.old_health_long_regen_delay = undefined;
}

//Function Number: 72
setstim()
{
	self endon("stim_disabled");
	self endon("death");
	if(isdefined(self.exo_stim_used))
	{
		return;
	}

	self notifyonplayercommand("stim_button_pressed","+actionslot 4");
	self setweaponhudiconoverride("actionslot4","dpad_icon_stim");
	self waittill("stim_button_pressed");
	self.exo_stim_used = 1;
	self.health = self.maxhealth;
	thread exo_stim_activate();
	self setweaponhudiconoverride("actionslot4","dpad_icon_stim_off");
}

//Function Number: 73
unsetstim()
{
	self notify("stim_disabled");
	self notifyonplayercommandremove("stim_button_pressed","+actionslot 4");
	self setweaponhudiconoverride("actionslot4","dpad_icon_stim_off");
}

//Function Number: 74
exo_stim_activate()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.origin = self geteye();
	var_00 linkto(level.player);
	playfxontag(common_scripts\utility::getfx("exo_stim"),var_00,"tag_origin");
	soundscripts\_snd::snd_message("exo_stim_on");
	self.exo_stim_active = 1;
	wait(0.1);
	self.exo_stim_active = undefined;
}

//Function Number: 75
setintelmode()
{
	thread player_intel_mode_think();
}

//Function Number: 76
unsetintelmode()
{
	player_intel_mode_disable();
}

//Function Number: 77
player_intel_mode_think()
{
	self endon("death");
	self endon("player_intel_mode_disabled");
	var_00 = 2;
	for(;;)
	{
		var_01 = level.player getweaponslistoffhands();
		var_02 = 0;
		foreach(var_04 in var_01)
		{
			if(issubstr(var_04,"_grenade_var"))
			{
				var_02 = 1;
				break;
			}
		}

		var_06 = 0;
		if(var_02)
		{
			var_06 = var_06 + level.player setweaponammostock("flash_grenade_var");
			var_06 = var_06 + level.player setweaponammostock("emp_grenade_var");
			var_06 = var_06 + level.player setweaponammostock("paint_grenade_var");
			var_06 = var_06 / 3;
		}

		if(var_06 != 4)
		{
			thread player_intel_display_object_array(getentarray("weapon_flash_grenade_var","classname"),var_00,"player_exo_intel_mode_flash_stop");
		}
		else
		{
			level notify("player_exo_intel_mode_flash_stop");
		}

		var_07 = 0;
		if(var_02)
		{
			var_07 = var_07 + level.player setweaponammostock("frag_grenade_var");
			var_07 = var_07 + level.player setweaponammostock("contact_grenade_var");
			var_07 = var_07 + level.player setweaponammostock("tracking_grenade_var");
			var_07 = var_07 / 3;
		}

		if(var_07 != 4)
		{
			thread player_intel_display_object_array(getentarray("weapon_frag_grenade_var","classname"),var_00,"player_exo_intel_mode_frag_stop");
		}
		else
		{
			level notify("player_exo_intel_mode_frag_stop");
		}

		wait(1);
	}
}

//Function Number: 78
player_intel_mode_disable()
{
	self notify("player_intel_mode_disabled");
}

//Function Number: 79
player_intel_display_objects()
{
	self endon("death");
	self endon("player_intel_mode_disabled");
	self endon("player_intel_mode_deactivated");
	var_00 = 2;
	var_01 = 1;
	var_02 = getentarray("script_model","classname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05.destructible_type) && var_05.destructible_type == "explodable_barrel")
		{
			var_03[var_03.size] = var_05;
		}
	}

	var_03 = common_scripts\utility::array_removeundefined(var_03);
	thread player_intel_display_object_array(var_03,var_01,"player_exo_intel_mode_barrel_stop");
	for(;;)
	{
		var_07 = getweaponarray();
		thread player_intel_display_object_array(var_07,var_00,"player_exo_intel_mode_barrel_stop");
		wait(0.05);
	}
}

//Function Number: 80
player_intel_display_object_array(param_00,param_01,param_02)
{
	var_03 = 1024;
	var_04 = var_03 * var_03;
	foreach(var_06 in param_00)
	{
		if(!isdefined(var_06.highlight_on))
		{
			if(distancesquared(var_06.origin,self.origin) < var_04)
			{
				var_06 thread player_intel_display_object(param_01,param_02);
			}
		}
	}
}

//Function Number: 81
player_intel_display_object(param_00,param_01)
{
	if(!common_scripts\utility::isdestructible())
	{
		self endon("death");
	}

	self.highlight_on = 1;
	self hudoutlineenable(param_00,1);
	common_scripts\utility::waittill_any_ents(level,param_01,self,"stop_highlight",self,"exploded");
	if(isdefined(self))
	{
		self.highlight_on = undefined;
		self hudoutlinedisable();
	}
}

//Function Number: 82
setexomelee()
{
	level.player maps\_utility::playerallowalternatemelee(1);
}

//Function Number: 83
unsetexomelee()
{
	level.player maps\_utility::playerallowalternatemelee(0);
}

//Function Number: 84
setexoslide()
{
	level.player allowpowerslide(1);
}

//Function Number: 85
unsetexoslide()
{
	level.player allowpowerslide(0);
}

//Function Number: 86
setexoslam()
{
	level.player allowhighjumpdrop(1);
	level.player thread monitorgroundslam();
	level.player thread monitorgroundslamhitplayer();
}

//Function Number: 87
unsetexoslam()
{
	level.player allowhighjumpdrop(0);
	level.player notify("disallow_ground_slam");
}

//Function Number: 88
getgroundslamminheight()
{
	return 120;
}

//Function Number: 89
getgroundslammaxheight()
{
	return 380;
}

//Function Number: 90
getgroundslammindamage()
{
	return 200;
}

//Function Number: 91
getgroundslammaxdamage()
{
	return 300;
}

//Function Number: 92
getgroundslamminradius()
{
	return 75;
}

//Function Number: 93
getgroundslammaxradius()
{
	return 150;
}

//Function Number: 94
getgroundslamhitlateralvimpart()
{
	return 0.1;
}

//Function Number: 95
getgroundslamhitverticalvimpart()
{
	return 1;
}

//Function Number: 96
getgroundslamcrushdamage()
{
	return 250;
}

//Function Number: 97
getgroundslamragdolldirscale()
{
	return 0;
}

//Function Number: 98
init_ground_slam()
{
	level._effect["exo_slam_kneeslide_fx"] = loadfx("vfx/code/slam_jetpack_kneeslide");
	precacheitem("boost_slam_sp");
}

//Function Number: 99
monitorgroundslamhitplayer()
{
	self endon("death");
	self endon("disallow_ground_slam");
	for(;;)
	{
		self waittill("ground_slam_hit_player",var_00,var_01);
		if(var_00 getoldslam(var_01))
		{
			continue;
		}

		var_02 = maps\_shg_utility::get_differentiated_velocity();
		var_03 = getdvarfloat("high_jump_drop_lateral_v_impart",getgroundslamhitlateralvimpart());
		var_04 = getdvarfloat("high_jump_drop_vertical_v_impart",getgroundslamhitverticalvimpart());
		var_05 = getdvarint("high_jump_drop_crush_damage",getgroundslamcrushdamage());
		var_06 = isalive(var_00);
		var_00.slam_ragdoll_vel = (var_02[0] * var_03,var_02[1] * var_03,var_02[2] * var_04);
		var_00 dodamage(var_05,self.origin,self,self,"MOD_CRUSH","boost_slam_sp","none");
		if(var_06 && !isalive(var_00) && var_00 getstompbreakthrough())
		{
			var_00.deathfunction = ::groundslamcrushdeathfunction;
		}

		var_00 setoldslam(var_01);
	}
}

//Function Number: 100
setoldslam(param_00)
{
	if(!isdefined(self.boost_slam_history))
	{
		self.boost_slam_history = [];
	}

	self.boost_slam_history[self.boost_slam_history.size] = param_00;
}

//Function Number: 101
getoldslam(param_00)
{
	if(!isdefined(self.boost_slam_history))
	{
		return 0;
	}

	foreach(var_02 in self.boost_slam_history)
	{
		if(param_00 == var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 102
groundslamcrushdeathfunction()
{
	self.ragdoll_start_vel = self.slam_ragdoll_vel;
	self.ragdoll_immediate = 1;
	self.ragdoll_directionscale = getdvarfloat("high_jump_drop_ragdoll_dir_scale",getgroundslamragdolldirscale());
	self notify("end_ground_slam_death_function");
	return 0;
}

//Function Number: 103
monitorgroundslam()
{
	self endon("death");
	self endon("disallow_ground_slam");
	var_00 = 10;
	var_01 = 4;
	var_02 = (1,0,0);
	var_03 = (0,1,0);
	var_04 = (0,0,1);
	var_05 = 16;
	for(;;)
	{
		self waittill("ground_slam",var_06,var_07);
		var_08 = getdvarfloat("high_jump_drop_min_height",getgroundslamminheight());
		var_09 = getdvarfloat("high_jump_drop_max_height",getgroundslammaxheight());
		var_0A = getdvarfloat("high_jump_drop_min_damage",getgroundslammindamage());
		var_0B = getdvarfloat("high_jump_drop_max_damage",getgroundslammaxdamage());
		var_0C = getdvarfloat("high_jump_drop_min_radius",getgroundslamminradius());
		var_0D = getdvarfloat("high_jump_drop_max_radius",getgroundslammaxradius());
		if(var_06 < var_08)
		{
			continue;
		}

		var_0E = var_06 - var_08 / var_09 - var_08;
		var_0E = clamp(var_0E,0,1);
		var_0F = var_0D - var_0C * var_0E + var_0C;
		self radiusdamage(self.origin,var_0F,var_0B,var_0A,self,"MOD_PROJECTILE_SPLASH","boost_slam_sp");
		maps\_sp_matchdata::register_boost_slam();
		physicsexplosionsphere(self.origin,var_0F,20,0.9);
	}
}

//Function Number: 104
setsonicblast()
{
	thread maps\_sonicaoe::enablesonicaoe();
}

//Function Number: 105
unsetsonicblast()
{
	thread maps\_sonicaoe::disablesonicaoe();
}

//Function Number: 106
sethighjump()
{
	level.player maps\_player_high_jump::enable_high_jump();
}

//Function Number: 107
unsethighjump()
{
	level.player maps\_player_high_jump::disable_high_jump();
}

//Function Number: 108
setshield()
{
	level.player maps\_exo_shield_sp::enable_shield_ability();
}

//Function Number: 109
unsetshield()
{
	level.player maps\_exo_shield_sp::disable_shield_ability();
}

//Function Number: 110
exo_shield_is_on()
{
	return maps\_utility::ent_flag("exo_shield_on");
}

//Function Number: 111
batteryinit(param_00)
{
	var_01 = 3;
	if(isdefined(param_00))
	{
		var_01 = 3 + param_00;
	}

	level.player.exobatterymax = var_01;
	level.player.exobatterylevel = level.player.exobatterymax;
	batteryupdatemeter();
}

//Function Number: 112
batterysetlevel(param_00)
{
	level.player.exobatterylevel = int(clamp(param_00,0,level.player.exobatterymax));
	batteryupdatemeter();
}

//Function Number: 113
batteryfillmax()
{
	level.player.exobatterylevel = level.player.exobatterymax;
	batteryupdatemeter();
}

//Function Number: 114
batteryupdatemeter()
{
	var_00 = int(level.player.exobatterylevel / level.player.exobatterymax * 100);
	setomnvar("ui_exobattery_value",var_00);
	level.player notify("exo_battery_update");
	update_battery_ability_icons(var_00);
}

//Function Number: 115
batterymetervisible(param_00,param_01)
{
	if(!isdefined(level.player.exo_battery_ability_flags))
	{
		level.player.exo_battery_ability_flags = [];
	}

	level.player.exo_battery_ability_flags[param_00] = param_01;
	foreach(var_03 in level.player.exo_battery_ability_flags)
	{
		if(isdefined(var_03) && var_03)
		{
			setomnvar("ui_exobattery",1);
			batteryupdatemeter();
			return;
		}
	}

	setomnvar("ui_exobattery",0);
}

//Function Number: 116
batteryspend(param_00)
{
	var_01 = level.player.exobatterylevel;
	if(param_00 > var_01)
	{
		exofailfx();
		return 0;
	}

	batterysetlevel(var_01 - param_00);
	return 1;
}

//Function Number: 117
get_exo_battery_percent()
{
	return int(level.player.exobatterylevel / level.player.exobatterymax * 100);
}

//Function Number: 118
exofailfx()
{
	var_00 = level.player geteye();
	level.player playsound("exo_power_not_ready");
}

//Function Number: 119
waittill_weaponhud_canshow()
{
	level.player endon("begin_firing");
	level.player endon("reload");
	level.player endon("x_pressed");
	level.player endon("offhand_end");
	level.player endon("weaponchange");
	level.player endon("dpad_up");
	level.player endon("dpad_down");
	level.player endon("dpad_left");
	level.player endon("dpad_right");
	level.player endon("exo_battery_update");
	level.player waittill("weapon_switch_started");
}

//Function Number: 120
show_weaponhud()
{
	level.player notify("show_weaponhud_stop");
	level.player endon("show_weaponhud_stop");
	setomnvar("ui_exobattery",1);
	setsaveddvar("actionSlotsHide",0);
	wait(3);
	setomnvar("ui_exobattery",0);
	setsaveddvar("actionSlotsHide",1);
}

//Function Number: 121
handle_weaponhud_visibility()
{
	level.player endon("death");
	level.player notifyonplayercommand("dpad_down","+actionslot 2");
	level.player notifyonplayercommand("dpad_left","+actionslot 3");
	level.player notifyonplayercommand("dpad_right","+actionslot 4");
	level.player notifyonplayercommand("dpad_up","+actionslot 1");
	level.player notifyonplayercommand("x_pressed","+usereload");
	level.player notifyonplayercommand("x_pressed","+reload");
	for(;;)
	{
		thread show_weaponhud();
		wait 0.05;
		waittill_weaponhud_canshow();
	}
}

//Function Number: 122
exo_move_speed_update()
{
	var_00 = 1;
	foreach(var_02 in level.player.exospeedscalars)
	{
		if(isdefined(var_02))
		{
			var_00 = var_00 * var_02;
		}
	}

	maps\_utility::player_speed_percent(int(100 * var_00));
}

//Function Number: 123
update_battery_ability_icons(param_00)
{
	var_01 = [];
	var_01[var_01.size] = "overdrive";
	var_01[var_01.size] = "sonic_blast";
	var_01[var_01.size] = "shield";
	var_02 = var_01;
	var_04 = getfirstarraykey(var_02);
	if(isdefined(var_04))
	{
		var_03 = var_02[var_04];
		if(!isdefined(level.player.exclusive[var_03]))
		{
			continue;
		}

		if(player_exo_is_active_single(var_03))
		{
			switch(var_03)
			{
				case "overdrive":
					break;

				case "sonic_blast":
					break;

				case "shield":
					break;

				default:
					break;
			}
		}
	}
}

//Function Number: 124
update_overdrive_icon(param_00)
{
	if(isdefined(param_00) && !param_00)
	{
		level.player setweaponhudiconoverride("actionslot1","none");
		return;
	}

	if(!player_exo_is_active())
	{
		level.player setweaponhudiconoverride("actionslot1","none");
		return;
	}

	if(get_exo_battery_percent() > 0)
	{
		level.player setweaponhudiconoverride("actionslot1","dpad_icon_overdrive");
		return;
	}

	level.player setweaponhudiconoverride("actionslot1","dpad_icon_overdrive_off");
}