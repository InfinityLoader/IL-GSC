/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\streak_mp_bigben2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 452 ms
 * Timestamp: 10/27/2023 2:07:05 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheitem("iw5_dlcgun12loot5_mp");
	precacherumble("tank_rumble");
	precacherumble("heavygun_fire");
	precacherumble("smg_fire");
	level.killstreakwieldweapons["iw5_dlcgun12loot5_mp"] = "mp_bigben2";
	if(level.console)
	{
		level.skylight_fire_fx = loadfx("vfx/map/mp_bigben/mp_bigb_killstreak_screen_fire");
	}
	else
	{
		level.skylight_fire_fx = loadfx("vfx/map/mp_bigben/mp_bigb_killstreak_screen_fire_pc");
	}

	var_00 = getent("rocket_startorg","targetname");
	var_01 = getent("rocket_endorg","targetname");
	var_02 = getent("camera_startorg","targetname");
	var_03 = getent("camera_endorg","targetname");
	level.rocket_start = var_00.origin;
	level.rocket_start_angles = (270,0,0);
	level.rocket_end = var_01.origin;
	level.camera_start = var_02.origin;
	level.camera_end = var_03.origin;
	level.skylight_actual_rocket = getent("actual_rocket","targetname");
	level.skylight_camera_link = getent("camera_linkto_main","targetname");
	level.skylight_actual_rocket.origin = level.rocket_start;
	level.skylight_actual_rocket.angles = level.rocket_start_angles;
	level.skylight_camera_link.origin = level.camera_start;
	level.skylight_camera_link setmodel("tag_player");
	level.skylight_rocket_fx_tag = spawn("script_model",(0,0,0));
	level.skylight_rocket_fx_tag setmodel("tag_origin");
	level.skylight_rocket_fx_tag linkto(level.skylight_actual_rocket,"tag_origin",(0,0,0),(0,0,0));
	level.missileflighttime = 10;
	level.skylight_real_missile_number = 30;
	level.skylight_fx_missile_chance = 100;
	level.skylight_fx_missile_max = 30;
	level.skylight_missile_min_time = 0.2;
	level.skylight_missile_max_time = 0.4;
	if(level.currentgen)
	{
		level.skylight_fx_missile_chance = 0;
	}

	level.killstreakfuncs["mp_bigben2"] = ::tryuseskylight;
	level.mapkillstreak = "mp_bigben2";
	level.mapkillstreakpickupstring = &"MP_BIGBEN2_MAP_KILLSTREAK_PICKUP";
	level.skylight_available = 1;
}

//Function Number: 2
tryuseskylight(param_00,param_01)
{
	if(!skylight_available())
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	level.skylight_available = 0;
	var_02 = maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(var_02 != "success")
	{
		level.skylight_available = 1;
		return 0;
	}

	maps\mp\_utility::setusingremote("mp_bigben2");
	var_02 = setupskylightrocketstrike();
	maps\mp\_matchdata::logkillstreakevent("dlc_streak4",self.origin);
	return var_02;
}

//Function Number: 3
setupskylightrocketstrike()
{
	level notify("skylight_start");
	thread monitor_player_disconnect();
	thread monitor_player_team_change();
	thread monitor_game_ended();
	playeraddnotifycommands();
	thread skylight_rocket_control();
	thread skylight_monitor_timeout();
	thread skylight_play_rumble();
	thread skylight_cleanup_player();
	thread skylight_cleanup_rocket();
	thread skylight_rocket_animate();
	thread maps\mp\mp_bigben2_fx::stop_vista_vfx();
	thread skylight_monitor_fire();
	thread skylight_monitor_cancel();
	return 1;
}

//Function Number: 4
monitor_player_disconnect()
{
	self endon("skylight_cancel");
	self endon("skylight_payload_complete");
	self waittill("disconnect");
	self notify("skylight_cancel");
}

//Function Number: 5
monitor_player_team_change()
{
	self endon("skylight_cancel");
	self endon("skylight_payload_complete");
	common_scripts\utility::waittill_either("joined_team","joined_spectators");
	self notify("skylight_cancel");
}

//Function Number: 6
monitor_game_ended()
{
	self endon("skylight_cancel");
	self endon("skylight_payload_complete");
	level waittill("game_ended");
	self notify("skylight_cancel");
}

//Function Number: 7
skylight_monitor_cancel()
{
	self endon("skylight_control_over");
	self endon("skylight_cancel");
	wait(0.3);
	var_00 = 5;
	for(;;)
	{
		self waittill("ToggleControlState");
		thread cancel_button_monitor();
		self.holdingleavebutton = 1;
		for(var_01 = 0;var_01 <= var_00;var_01++)
		{
			wait(0.1);
			if(self.holdingleavebutton == 1 && var_01 == var_00)
			{
				self notify("skylight_cancel");
				return;
			}
			else if(self.holdingleavebutton == 0)
			{
				break;
			}
		}
	}
}

//Function Number: 8
cancel_button_monitor()
{
	self endon("skylight_control_over");
	self endon("skylight_cancel");
	self waittill("ToggleControlCancel");
	self.holdingleavebutton = 0;
}

//Function Number: 9
skylight_monitor_timeout()
{
	self endon("skylight_control_over");
	self endon("skylight_cancel");
	wait(level.missileflighttime);
	self notify("skylight_fire_timeout");
}

//Function Number: 10
skylight_monitor_fire()
{
	self endon("skylight_cancel");
	wait(0.3);
	common_scripts\utility::waittill_any("StartFire","skylight_fire_timeout");
	self playlocalsound("bb_missile_launch_pod_midair_exp");
	var_00 = self getplayerangles();
	var_01 = anglestoforward(var_00);
	var_02 = level.skylight_camera_link.origin;
	var_03 = var_02 + var_01 * 12000;
	var_04 = bullettrace(var_02,var_03,0,level.skylight_actual_rocket);
	var_05 = var_04["position"];
	self playrumbleonentity("heavygun_fire");
	earthquake(0.4,1,level.skylight_camera_link.origin,2000,self);
	wait(0.2);
	self notify("skylight_control_over");
	thread fire_missiles(var_05);
}

//Function Number: 11
skylight_cleanup_player()
{
	self endon("disconnect");
	common_scripts\utility::waittill_any("skylight_control_over","skylight_cancel");
	playerremovenotifycommands();
	self enableweaponswitch();
	self unlink();
	self setclientomnvar("fov_scale",1);
	self disableslowaim();
	self setclientomnvar("ui_solar_beam",0);
	self thermalvisionfofoverlayoff();
	level.skylight_fire_fx_ent delete();
	if(maps\mp\_utility::isusingremote())
	{
		maps\mp\_utility::clearusingremote();
	}

	thread removeskylightvisionandlightsetpermap(0.5);
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(1);
	}

	maps\mp\_utility::playerrestoreangles();
}

//Function Number: 12
skylight_cleanup_rocket()
{
	common_scripts\utility::waittill_any("skylight_cancel","skylight_payload_complete");
	wait(0.1);
	playfx(common_scripts\utility::getfx("mp_bigb_killstreak_rocket_explosion"),level.skylight_actual_rocket.origin);
	stopfxontag(common_scripts\utility::getfx("mp_bigb_killstreak_rockettrail"),level.skylight_rocket_fx_tag,"tag_origin");
	level.skylight_actual_rocket scriptmodelclearanim();
	wait(0.1);
	level.skylight_actual_rocket.origin = level.rocket_start;
	level.skylight_actual_rocket.angles = level.rocket_start_angles;
	level.skylight_camera_link.origin = level.camera_start;
	level.skylight_available = 1;
}

//Function Number: 13
skylight_available()
{
	return level.skylight_available;
}

//Function Number: 14
playeraddnotifycommands()
{
	if(!isbot(self))
	{
		self notifyonplayercommand("SwitchVisionMode","+actionslot 1");
		self notifyonplayercommand("ToggleControlState","+activate");
		self notifyonplayercommand("ToggleControlCancel","-activate");
		self notifyonplayercommand("ToggleControlState","+usereload");
		self notifyonplayercommand("ToggleControlCancel","-usereload");
		self notifyonplayercommand("StartFire","+attack");
		self notifyonplayercommand("StartFire","+attack_akimbo_accessible");
	}
}

//Function Number: 15
playerremovenotifycommands()
{
	if(!isbot(self))
	{
		self notifyonplayercommandremove("SwitchVisionMode","+actionslot 1");
		self notifyonplayercommandremove("ToggleControlState","+activate");
		self notifyonplayercommandremove("ToggleControlCancel","-activate");
		self notifyonplayercommandremove("ToggleControlState","+usereload");
		self notifyonplayercommandremove("ToggleControlCancel","-usereload");
		self notifyonplayercommandremove("StartFire","+attack");
		self notifyonplayercommandremove("StartFire","+attack_akimbo_accessible");
	}
}

//Function Number: 16
setskylightvisionandlightsetpermap(param_00)
{
	self endon("skylight_cancel");
	self endon("game_ended");
	self endon("OrbitalStrikeStreakComplete");
	wait(param_00);
	if(isdefined(level.vulcanvisionset))
	{
		self setclienttriggervisionset(level.vulcanvisionset,0);
	}

	if(isdefined(level.vulcanlightset))
	{
		self lightsetforplayer(level.vulcanlightset);
	}

	maps\mp\killstreaks\_aerial_utility::handle_player_starting_aerial_view();
}

//Function Number: 17
removeskylightvisionandlightsetpermap(param_00)
{
	self setclienttriggervisionset("",param_00);
	self lightsetforplayer("");
	maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
}

//Function Number: 18
skylight_play_rumble()
{
	self endon("skylight_cancel");
	self endon("skylight_control_over");
	thread skylight_play_rumble_on_all_players();
	wait(0.1);
	earthquake(0.4,3,level.skylight_camera_link.origin,2000,self);
	wait(0.1);
	earthquake(0.2,15,(4176.5,14000,18000),20000,self);
	wait(0.5);
	self playrumbleonentity("heavygun_fire");
	thread skylight_loop_rumble(20);
}

//Function Number: 19
skylight_play_rumble_on_all_players()
{
	foreach(var_01 in level.players)
	{
		if(var_01 != self)
		{
			earthquake(0.3,3,level.rocket_start,3500,var_01);
			var_01 playrumblelooponentity("tank_rumble");
			var_01 thread skylight_end_rumble_loop(0.8);
			if(distancesquared(level.rocket_start,var_01.origin) < 1000000)
			{
				var_01 playrumbleonentity("heavygun_fire");
				continue;
			}

			if(distancesquared(level.rocket_start,var_01.origin) < 4000000)
			{
				var_01 playrumbleonentity("smg_fire");
			}
		}
	}
}

//Function Number: 20
skylight_loop_rumble(param_00)
{
	self endon("skylight_cancel");
	self endon("skylight_control_over");
	while(param_00 > 0)
	{
		self playrumbleonentity("smg_fire");
		param_00 = param_00 - 0.2;
		wait(0.2);
	}
}

//Function Number: 21
skylight_end_rumble_loop(param_00)
{
	self endon("death");
	level common_scripts\utility::waittill_notify_or_timeout("game_ended",param_00);
	self stoprumble("tank_rumble");
}

//Function Number: 22
skylight_rocket_control()
{
	self disableweaponswitch();
	self setclientomnvar("fov_scale",0.5);
	self enableslowaim(0.5,0.5);
	self thermalvisionfofoverlayon();
	level.skylight_camera_link moveto(level.camera_end,level.missileflighttime,1,0);
	self playerlinkweaponviewtodelta(level.skylight_camera_link,"tag_player",1,60,60,-30,75,1);
	thread setskylightvisionandlightsetpermap(0.5);
	maps\mp\_utility::playersaveangles();
	self setplayerangles((40,270,0));
	self setclientomnvar("ui_solar_beam",1);
	var_00 = gettime() + level.missileflighttime * 1000;
	self setclientomnvar("ui_solar_beam_timer",var_00);
	level.skylight_fire_fx_ent = spawnlinkedfxforclient(level.skylight_fire_fx,level.skylight_camera_link,"tag_player",self);
	setfxkillondelete(level.skylight_fire_fx_ent,1);
	triggerfx(level.skylight_fire_fx_ent);
	thread aud_skylight_launch_sfx();
	thread aud_skylight_launch_sfx_3d();
}

//Function Number: 23
aud_skylight_launch_sfx()
{
	self endon("disconnect");
	wait(0.2);
	self playlocalsound("bb_missile_launch_pod_midair_exp");
	wait(0.2);
	self playlocalsound("paladin_toggle_flir_plr");
	self playlocalsound("bb_missile_jet_pov_effit");
	common_scripts\utility::waittill_any("skylight_control_over","skylight_cancel");
	self stopsounds();
}

//Function Number: 24
aud_skylight_launch_sfx_3d()
{
	wait(0.2);
	self playsound("bb_missile_launch_pod_midair_exp_3d");
	self playsound("bb_missile_low_3d");
	wait(0.2);
	self playsound("bb_missile_jet_pov_effit_3d");
	common_scripts\utility::waittill_any("skylight_control_over","skylight_cancel");
	self stopsounds();
}

//Function Number: 25
skylight_rocket_animate()
{
	self endon("skylight_cancel");
	wait(0.1);
	level.skylight_actual_rocket scriptmodelplayanimdeltamotion("bbn_skylight_rocket_launch");
	foreach(var_01 in level.players)
	{
		if(var_01 != self)
		{
			playfxontagforclients(common_scripts\utility::getfx("mp_bigb_killstreak_rockettrail"),level.skylight_rocket_fx_tag,"tag_origin",var_01);
		}
	}
}

//Function Number: 26
fire_missiles(param_00)
{
	self endon("skylight_cancel");
	var_01 = 0;
	wait(randomfloatrange(level.skylight_missile_min_time,level.skylight_missile_max_time));
	var_02 = magicbullet("iw5_dlcgun12loot5_mp",level.skylight_actual_rocket.origin,param_00,self);
	wait(0.1);
	if(randomint(100) <= level.skylight_fx_missile_chance && var_01 < level.skylight_fx_missile_max)
	{
		var_01++;
		var_03 = vectortoangles(level.skylight_actual_rocket.origin - param_00);
		var_04 = anglestoforward(var_03);
		playfx(common_scripts\utility::getfx("mp_bigb_killstreak_curvy_missile"),level.skylight_actual_rocket.origin,var_04);
	}

	maps\mp\_audio::snd_play_in_space("paladin_cannon_snap",level.skylight_actual_rocket.origin);
	for(var_05 = 1;var_05 < level.skylight_real_missile_number;var_05++)
	{
		wait(randomfloatrange(level.skylight_missile_min_time - 0.1,level.skylight_missile_max_time - 0.1));
		var_06 = randomfloatrange(-400,400);
		var_07 = randomfloatrange(-400,400);
		var_02 = magicbullet("iw5_dlcgun12loot5_mp",level.skylight_actual_rocket.origin,param_00 + (var_06,var_07,0),self);
		wait(0.1);
		if(randomint(100) <= level.skylight_fx_missile_chance && var_01 < level.skylight_fx_missile_max)
		{
			var_01++;
			var_03 = vectortoangles(level.skylight_actual_rocket.origin - param_00 + (var_06,var_07,0));
			var_04 = anglestoforward(var_03);
			playfx(common_scripts\utility::getfx("mp_bigb_killstreak_curvy_missile"),level.skylight_actual_rocket.origin,var_04);
		}

		maps\mp\_audio::snd_play_in_space("paladin_cannon_snap",level.skylight_actual_rocket.origin);
	}

	self notify("skylight_payload_complete");
}