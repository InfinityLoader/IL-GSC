/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _tagging.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 615 ms
 * Timestamp: 4/22/2024 2:23:27 AM
*******************************************************************/

//Function Number: 1
main()
{
	level thread tracking_init();
}

//Function Number: 2
tagging_set_enabled(param_00,param_01)
{
	if(!isdefined(self.tagging))
	{
		tagging_init_player();
	}

	if(!isdefined(param_01))
	{
		param_01 = 4;
	}

	self.tagging["enabled"] = param_00;
	self.tagging["action_slot"] = param_01;
	tagging_set_marking_enabled(param_00);
	if(!self.tagging["enabled"])
	{
		self notify("unsync");
		tagging_highlight_hud_effect_remove(self);
	}
	else
	{
		tagging_highlight_hud_effect_apply(self,-1);
	}

	thread tagging_set_binocs_enabled(self.tagging["enabled"]);
}

//Function Number: 3
tagging_set_binocs_enabled(param_00)
{
}

//Function Number: 4
tagging_set_marking_enabled(param_00)
{
	if(!isdefined(self.tagging))
	{
		tagging_init_player();
	}

	self.tagging["marking_enabled"] = param_00;
	var_01 = tagging_enemy_list();
	if(!self.tagging["marking_enabled"])
	{
		foreach(var_03 in var_01)
		{
			var_03 tag_trace_update("none",self);
			var_03 notify("tagged_enemy_death_cleanup");
			var_03 tagged_status_hide();
		}

		return;
	}

	foreach(var_03 in var_03)
	{
		if(isdefined(var_03.tagged) && isdefined(var_03.tagged[self getentitynumber()]))
		{
			var_03 tag_enemy(self);
		}
	}
}

//Function Number: 5
tagging_set_forced_mode(param_00,param_01)
{
	if(!isdefined(self.tagging))
	{
		tagging_init_player();
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self.tagging["forced_mode_fov"] = param_00;
	self.tagging["forced_mode_weap"] = param_01;
	self notify("tagging_mode");
}

//Function Number: 6
tracking_init()
{
	precacheshader("dpad_ar_visor");
	precacheshader("dpad_ar_visor_inactive");
	precacheshader("hud_ar_visor_arc");
	precacheshader("hud_ar_visor_large_focus_ring");
	precacheshader("hud_ar_visor_overlay");
	precacheshader("hud_ar_visor_sentinel_logo");
	precacheshader("hud_ar_visor_small_focus_ring");
	precacheshader("hud_ar_visor_spinner");
	precacheshader("hud_ar_visor_zoom_gauge");
	setdvarifuninitialized("tagging_ads_cone_range",3000);
	setdvarifuninitialized("tagging_ads_cone_angle",10);
	setdvarifuninitialized("tagging_normal_pulse_rate",50);
	setdvarifuninitialized("tagging_normal_prep_time",250);
	setdvarifuninitialized("tagging_normal_track_time",500);
	setdvarifuninitialized("tagging_slow_pulse_rate",100);
	setdvarifuninitialized("tagging_slow_prep_time",500);
	setdvarifuninitialized("tagging_slow_track_time",1000);
	setdvarifuninitialized("tagging_scan_fov_min",55);
	setdvarifuninitialized("tagging_scan_fov_max",25);
	setdvarifuninitialized("tagging_scan_range_min",1500);
	setdvarifuninitialized("tagging_scan_range_max",3000);
	setdvarifuninitialized("tagging_foliage",0);
	setdvarifuninitialized("tagging_vehicle_ride",0);
	tagging_set_hud_outline_style();
	foreach(var_01 in level.players)
	{
		var_01 tagging_init_player();
	}
}

//Function Number: 7
tagging_set_hud_outline_style()
{
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",1);
	setsaveddvar("r_hudoutlinealpha0",0.75);
	setsaveddvar("r_hudoutlinepostmode",2);
	setsaveddvar("r_hudoutlinewhen","after_colorize");
}

//Function Number: 8
tagging_init_player()
{
	self.tagging = [];
	self.tagging["enabled"] = 1;
	self.tagging["marking_enabled"] = 1;
	self.tagging["outline_enabled"] = 1;
	self.tagging["tagging_mode"] = 0;
	self.tagging["hint"] = undefined;
	self.tagging["hintText"] = undefined;
	self.tagging["last_tag_start"] = 0;
	self.tagging["action_slot"] = 4;
	self.tagging["tagging_fade_min"] = 500;
	self.tagging["tagging_fade_max"] = 3000;
	thread tagging_think();
	thread tagging_mode_watcher();
	tagging_set_enabled(1);
}

//Function Number: 9
tagging_shutdown_player()
{
	self notify("tagging_shutdown");
	tagging_set_enabled(0);
	if(isdefined(self.tagging) && isdefined(self.tagging["camera"]))
	{
		self.tagging["camera"] delete();
	}

	self.tagging = undefined;
}

//Function Number: 10
tagging_set_hint(param_00)
{
	if(isdefined(self.tagging["hintText"]) && isdefined(param_00) && self.tagging["hintText"] == param_00)
	{
		return;
	}

	if(isdefined(self.tagging["hint"]))
	{
		self.tagging["hint"] maps\_utility::hint_delete();
		self.tagging["hint"] = undefined;
		self.tagging["hintText"] = undefined;
	}

	if(isdefined(param_00))
	{
		self.tagging["hint"] = maps\_utility::hint_create(param_00);
		self.tagging["hintText"] = param_00;
		if(isdefined(self.tagging["hint"]))
		{
			self.tagging["hint"].elm.aligny = "bottom";
			self.tagging["hint"].elm.vertalign = "bottom";
			if(isdefined(self.tagging["hint"].bg))
			{
				self.tagging["hint"].bg.aligny = "bottom";
				self.tagging["hint"].bg.vertalign = "bottom";
			}
		}

		return self.tagging["hint"];
	}
}

//Function Number: 11
tagging_highlight_hud_effect_apply(param_00,param_01)
{
	if(!isdefined(param_00.detection_highlight_hud_effect))
	{
		param_00.detection_highlight_hud_effect = newclienthudelem(param_00);
		param_00.detection_highlight_hud_effect.color = (0.012,0.0025,0);
		param_00.detection_highlight_hud_effect.alpha = 0.005;
	}

	param_00.detection_highlight_hud_effect setradarhighlight(param_01);
}

//Function Number: 12
tagging_highlight_hud_effect_remove(param_00)
{
	if(isdefined(param_00.detection_highlight_hud_effect))
	{
		param_00.detection_highlight_hud_effect destroy();
		param_00.detection_highlight_hud_effect = undefined;
	}
}

//Function Number: 13
tagging_enemy_list()
{
	var_00 = getaiarray("axis","neutral");
	if(isdefined(level.active_drones))
	{
		var_00 = common_scripts\utility::array_combine(var_00,level.active_drones);
	}

	return var_00;
}

//Function Number: 14
tagging_think()
{
	self notify("tagging_think");
	self endon("tagging_think");
	for(;;)
	{
		tag_update_enemy_in_sights();
		wait(0.05);
	}
}

//Function Number: 15
tagging_mode_watcher()
{
	self notify("tagging_mode_watcher");
	self endon("tagging_mode_watcher");
	for(;;)
	{
		self waittill("tagging_mode");
		if(isdefined(self.grapple) && isdefined(self.grapple["grappling"]) && self.grapple["grappling"])
		{
			continue;
		}

		if(isdefined(self.tagging["forced_mode_fov"]))
		{
			if(!self.tagging["tagging_mode"])
			{
				tagging_mode_begin();
			}

			tagging_set_hint(undefined);
			continue;
		}

		if(self.tagging["tagging_mode"])
		{
			tagging_mode_end();
			continue;
		}

		tagging_mode_begin();
	}
}

//Function Number: 16
tagging_mode_begin()
{
	self notify("tagging_on");
	self endon("tagging_off");
	self endon("tagging_on");
	self.tagging["tagging_mode"] = 1;
	self playsound("drone_tag_start");
	if(!isdefined(self.tagging["forced_mode_weap"]) || !self.tagging["forced_mode_weap"])
	{
		common_scripts\utility::_disableoffhandweapons();
		common_scripts\utility::_disableweapon();
		common_scripts\utility::_disableweaponswitch();
	}

	self.tagging["forced_mode_weap"] = undefined;
	setsaveddvar("cg_drawMantleHint","0");
	wait(0.5);
	tagging_hud_show_all();
	if(!isdefined(self.tagging["forced_mode_fov"]))
	{
		tagging_set_hint(&"GRAPPLE_ZOOM_HINT");
	}

	thread tagging_zoom_monitor();
	thread tag_monitor();
}

//Function Number: 17
tagging_mode_end()
{
	self notify("tagging_off");
	self notify("zoom_monitor");
	self endon("tagging_off");
	self endon("tagging_on");
	self.tagging["tagging_mode"] = 0;
	if(isdefined(self.tagging["zoom"]))
	{
		self.tagging["zoom"] = 0;
	}

	self playsound("drone_tag_stop");
	thread tagging_hud_show_none();
	tagging_set_hint(undefined);
	if(!isdefined(self.tagging["forced_mode_weap"]) || self.tagging["forced_mode_weap"])
	{
		common_scripts\utility::_enableoffhandweapons();
		common_scripts\utility::_enableweapon();
		common_scripts\utility::_enableweaponswitch();
	}

	self.tagging["forced_mode_weap"] = undefined;
	self lerpfov(65,0.25);
	wait(0.5);
	setsaveddvar("cg_drawMantleHint","1");
	var_00 = tagging_enemy_list();
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.tagged) && isdefined(var_02.tagged[self getentitynumber()]))
		{
			continue;
		}

		var_02 tag_trace_update("none",self);
	}
}

//Function Number: 18
tagging_create_hud()
{
	if(!isdefined(self.tagging["hud"]))
	{
		self.tagging["hud"] = [];
		self.tagging["hud"]["overlay"] = maps\_hud_util::create_client_overlay("hud_ar_visor_overlay",1);
		self.tagging["hud"]["overlay"].hidewheninmenu = 1;
		self.tagging["hud"]["top_arc"] = maps\_hud_util::createicon("hud_ar_visor_arc",576,18);
		self.tagging["hud"]["top_arc"].hidewheninmenu = 1;
		self.tagging["hud"]["top_arc"].x = 0;
		self.tagging["hud"]["top_arc"].y = 13;
		self.tagging["hud"]["top_arc"].alignx = "center";
		self.tagging["hud"]["top_arc"].aligny = "top";
		self.tagging["hud"]["top_arc"].horzalign = "center";
		self.tagging["hud"]["top_arc"].vertalign = "top";
		self.tagging["hud"]["top_arc"].color = (1,1,1);
		self.tagging["hud"]["top_arc"].alpha = 1;
		self.tagging["hud"]["bottom_arc"] = maps\_hud_util::createicon("hud_ar_visor_arc",576,18);
		self.tagging["hud"]["bottom_arc"].hidewheninmenu = 1;
		self.tagging["hud"]["bottom_arc"].x = 0;
		self.tagging["hud"]["bottom_arc"].y = -23;
		self.tagging["hud"]["bottom_arc"].alignx = "center";
		self.tagging["hud"]["bottom_arc"].aligny = "bottom";
		self.tagging["hud"]["bottom_arc"].horzalign = "center";
		self.tagging["hud"]["bottom_arc"].vertalign = "bottom";
		self.tagging["hud"]["bottom_arc"].color = (1,1,1);
		self.tagging["hud"]["bottom_arc"].alpha = 1;
		self.tagging["hud"]["bottom_arc"].rotation = 180;
		self.tagging["hud"]["small_ring"] = maps\_hud_util::createicon("hud_ar_visor_small_focus_ring",160,160);
		self.tagging["hud"]["small_ring"].hidewheninmenu = 1;
		self.tagging["hud"]["small_ring"].x = 0;
		self.tagging["hud"]["small_ring"].y = 0;
		self.tagging["hud"]["small_ring"].alignx = "center";
		self.tagging["hud"]["small_ring"].aligny = "middle";
		self.tagging["hud"]["small_ring"].horzalign = "center";
		self.tagging["hud"]["small_ring"].vertalign = "middle";
		self.tagging["hud"]["small_ring"].color = (1,1,1);
		self.tagging["hud"]["small_ring"].alpha = 1;
		self.tagging["hud"]["small_spinner"] = maps\_hud_util::createicon("hud_ar_visor_spinner",160,160);
		self.tagging["hud"]["small_spinner"].hidewheninmenu = 1;
		self.tagging["hud"]["small_spinner"].x = 0;
		self.tagging["hud"]["small_spinner"].y = 0;
		self.tagging["hud"]["small_spinner"].alignx = "center";
		self.tagging["hud"]["small_spinner"].aligny = "middle";
		self.tagging["hud"]["small_spinner"].horzalign = "center";
		self.tagging["hud"]["small_spinner"].vertalign = "middle";
		self.tagging["hud"]["small_spinner"].color = (1,1,1);
		self.tagging["hud"]["small_spinner"].alpha = 1;
		self.tagging["hud"]["small_spinner"].rotation = 90;
		self.tagging["hud"]["large_ring"] = maps\_hud_util::createicon("hud_ar_visor_large_focus_ring",300,300);
		self.tagging["hud"]["large_ring"].hidewheninmenu = 1;
		self.tagging["hud"]["large_ring"].x = 0;
		self.tagging["hud"]["large_ring"].y = 0;
		self.tagging["hud"]["large_ring"].alignx = "center";
		self.tagging["hud"]["large_ring"].aligny = "middle";
		self.tagging["hud"]["large_ring"].horzalign = "center";
		self.tagging["hud"]["large_ring"].vertalign = "middle";
		self.tagging["hud"]["large_ring"].color = (1,1,1);
		self.tagging["hud"]["large_ring"].alpha = 1;
		self.tagging["hud"]["large_spinner"] = maps\_hud_util::createicon("hud_ar_visor_spinner",300,300);
		self.tagging["hud"]["large_spinner"].hidewheninmenu = 1;
		self.tagging["hud"]["large_spinner"].x = 0;
		self.tagging["hud"]["large_spinner"].y = 0;
		self.tagging["hud"]["large_spinner"].alignx = "center";
		self.tagging["hud"]["large_spinner"].aligny = "middle";
		self.tagging["hud"]["large_spinner"].horzalign = "center";
		self.tagging["hud"]["large_spinner"].vertalign = "middle";
		self.tagging["hud"]["large_spinner"].color = (1,1,1);
		self.tagging["hud"]["large_spinner"].alpha = 1;
		self.tagging["hud"]["large_spinner"] rotateovertime(0.5);
		self.tagging["hud"]["large_spinner"].rotation = -360;
		self.tagging["hud"]["logo"] = maps\_hud_util::createicon("hud_ar_visor_sentinel_logo",116,29);
		self.tagging["hud"]["logo"].hidewheninmenu = 1;
		self.tagging["hud"]["logo"].x = -20;
		self.tagging["hud"]["logo"].y = 35;
		self.tagging["hud"]["logo"].alignx = "right";
		self.tagging["hud"]["logo"].aligny = "top";
		self.tagging["hud"]["logo"].horzalign = "right";
		self.tagging["hud"]["logo"].vertalign = "top";
		self.tagging["hud"]["logo"].color = (1,1,1);
		self.tagging["hud"]["logo"].alpha = 1;
		self.tagging["hud"]["zoom_guage"] = maps\_hud_util::createicon("hud_ar_visor_zoom_gauge",112,448);
		self.tagging["hud"]["zoom_guage"].hidewheninmenu = 1;
		self.tagging["hud"]["zoom_guage"].x = -307;
		self.tagging["hud"]["zoom_guage"].y = 0;
		self.tagging["hud"]["zoom_guage"].alignx = "left";
		self.tagging["hud"]["zoom_guage"].aligny = "middle";
		self.tagging["hud"]["zoom_guage"].horzalign = "center";
		self.tagging["hud"]["zoom_guage"].vertalign = "middle";
		self.tagging["hud"]["zoom_guage"].color = (1,1,1);
		self.tagging["hud"]["zoom_guage"].alpha = 1;
		self.tagging["hud"]["zoom_guage_indicator"] = maps\_hud_util::createicon("white",4,4);
		self.tagging["hud"]["zoom_guage_indicator"].hidewheninmenu = 1;
		self.tagging["hud"]["zoom_guage_indicator"].x = -249;
		self.tagging["hud"]["zoom_guage_indicator"].y = 154;
		self.tagging["hud"]["zoom_guage_indicator"].alignx = "left";
		self.tagging["hud"]["zoom_guage_indicator"].aligny = "middle";
		self.tagging["hud"]["zoom_guage_indicator"].horzalign = "center";
		self.tagging["hud"]["zoom_guage_indicator"].vertalign = "middle";
		self.tagging["hud"]["zoom_guage_indicator"].color = (1,1,1);
		self.tagging["hud"]["zoom_guage_indicator"].alpha = 1;
		self.tagging["hud"]["zoom_guage_indicator"].rotation = -25;
		self.tagging["hud"]["zoom_guage_indicator"].bottom = 154;
		self.tagging["hud"]["zoom_guage_indicator"].top = -154;
		self.tagging["hud"]["zoom_guage_indicator"].left = -289;
		self.tagging["hud"]["zoom_guage_indicator"].right = -249;
		self.tagging["hud"]["zoom_guage_indicator"].rot_bot = -25;
		self.tagging["hud"]["zoom_guage_indicator"].rot_top = 25;
		self.tagging["hud"]["zoom_guage_text"] = maps\_hud_util::createfontstring("default",0.75);
		self.tagging["hud"]["zoom_guage_text"].hidewheninmenu = 1;
		self.tagging["hud"]["zoom_guage_text"].x = -246;
		self.tagging["hud"]["zoom_guage_text"].y = 0;
		self.tagging["hud"]["zoom_guage_text"].alignx = "center";
		self.tagging["hud"]["zoom_guage_text"].aligny = "middle";
		self.tagging["hud"]["zoom_guage_text"].horzalign = "center";
		self.tagging["hud"]["zoom_guage_text"].vertalign = "middle";
		self.tagging["hud"]["zoom_guage_text"].color = (1,1,1);
		self.tagging["hud"]["zoom_guage_text"].alpha = 1;
	}
}

//Function Number: 19
tagging_hud_show_all()
{
	tagging_create_hud();
	self.tagging["hud"]["overlay"].alpha = 1;
	self.tagging["hud"]["large_ring"].alpha = 1;
	self.tagging["hud"]["small_ring"].alpha = 1;
	self.tagging["hud"]["large_spinner"].alpha = 1;
	self.tagging["hud"]["small_spinner"].alpha = 1;
	self.tagging["hud"]["zoom_guage"].alpha = 1;
	self.tagging["hud"]["zoom_guage_indicator"].alpha = 1;
	self.tagging["hud"]["zoom_guage_text"].alpha = 1;
	self.tagging["hud"]["top_arc"].alpha = 1;
	self.tagging["hud"]["bottom_arc"].alpha = 1;
	self.tagging["hud"]["logo"].alpha = 1;
}

//Function Number: 20
tagging_hud_show_minimal()
{
	tagging_create_hud();
	self.tagging["hud"]["overlay"].alpha = 0;
	self.tagging["hud"]["large_ring"].alpha = 0;
	self.tagging["hud"]["small_ring"].alpha = 0;
	self.tagging["hud"]["large_spinner"].alpha = 0;
	self.tagging["hud"]["small_spinner"].alpha = 0;
	self.tagging["hud"]["zoom_guage"].alpha = 0;
	self.tagging["hud"]["zoom_guage_indicator"].alpha = 0;
	self.tagging["hud"]["zoom_guage_text"].alpha = 0;
}

//Function Number: 21
tagging_hud_show_none()
{
	tagging_hud_show_minimal();
	self.tagging["hud"]["top_arc"].alpha = 0;
	self.tagging["hud"]["bottom_arc"].alpha = 0;
	self.tagging["hud"]["logo"].alpha = 0;
}

//Function Number: 22
tagging_hud_shutdown()
{
	if(!isdefined(self.tagging))
	{
		return;
	}

	if(!isdefined(self.tagging["hud"]))
	{
		return;
	}

	foreach(var_01 in self.tagging["hud"])
	{
		var_01 destroy();
	}

	self.tagging["hud"] = undefined;
}

//Function Number: 23
tagging_create_hud_crosshair()
{
	var_00 = newhudelem();
	var_00.x = 320;
	var_00.y = 240;
	var_00.sort = 997;
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00 setshader("hud_ar_visor_arc",920,480);
	return var_00;
}

//Function Number: 24
tagging_zoom_monitor()
{
	self notify("zoom_monitor");
	self endon("death");
	self endon("zoom_monitor");
	var_00 = [getdvarint("tagging_scan_fov_min"),getdvarint("tagging_scan_fov_max")];
	var_01 = [getdvarint("tagging_scan_range_min"),getdvarint("tagging_scan_range_max")];
	if(!isdefined(self.tagging["zoom"]))
	{
		self.tagging["zoom"] = 0;
		self.tagging["fov"] = var_00[self.tagging["zoom"]];
		self.tagging["range"] = var_01[self.tagging["zoom"]];
	}

	if(isdefined(self.tagging["forced_mode_fov"]))
	{
		self.tagging["fov"] = self.tagging["forced_mode_fov"];
	}

	var_02 = 0;
	var_03 = 0.33;
	var_04 = 1;
	for(;;)
	{
		var_05 = self adsbuttonpressed() || isdefined(self.tagging["forced_mode_fov"]);
		var_06 = isdefined(self.tagging["forced_mode_fov"]) && self.tagging["forced_mode_fov"] != self.tagging["fov"];
		if(var_04 || var_02 != var_05 || var_06)
		{
			if(!isdefined(self.tagging["forced_mode_fov"]) && !var_04)
			{
				if(var_05)
				{
					self.tagging["zoom"] = 1;
				}
				else
				{
					self.tagging["zoom"] = 0;
				}
			}

			var_07 = var_00[self.tagging["zoom"]];
			var_08 = var_01[self.tagging["zoom"]];
			if(isdefined(self.tagging["forced_mode_fov"]))
			{
				var_07 = self.tagging["forced_mode_fov"];
			}

			self lerpfov(var_07,var_03);
			thread tagging_zoom_transition(self.tagging["fov"],self.tagging["range"],var_07,var_08,var_03);
			tagging_zoom_sound(self.tagging["zoom"],var_03);
			var_02 = var_05;
			var_04 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 25
tagging_zoom_sound(param_00,param_01)
{
	common_scripts\utility::stop_loop_sound_on_entity("drone_tag_zoom_in_loop");
	common_scripts\utility::stop_loop_sound_on_entity("drone_tag_zoom_out_loop");
	self notify("zoom_sound");
	self endon("zoom_sound");
	if(param_01 <= 0)
	{
		return;
	}

	self playsound("drone_tag_zoom_start");
	if(param_00)
	{
		var_02 = "drone_tag_zoom_in_loop";
	}
	else
	{
		var_02 = "drone_tag_zoom_out_loop";
	}

	thread common_scripts\utility::play_loop_sound_on_entity(var_02);
	wait(param_01);
	common_scripts\utility::stop_loop_sound_on_entity(var_02);
	self playsound("drone_tag_zoom_stop");
}

//Function Number: 26
tagging_zoom_transition(param_00,param_01,param_02,param_03,param_04)
{
	self notify("zoom_transition");
	self endon("zoom_transition");
	var_05 = param_04 * 1000;
	var_06 = var_05 + gettime();
	var_07 = 0;
	var_08 = 0;
	self.tagging["hud"]["small_spinner"] rotateovertime(param_04);
	self.tagging["hud"]["large_spinner"] rotateovertime(param_04);
	if(self.tagging["zoom"])
	{
		self.tagging["hud"]["small_spinner"].rotation = self.tagging["hud"]["small_spinner"].rotation + 90;
		self.tagging["hud"]["large_spinner"].rotation = self.tagging["hud"]["large_spinner"].rotation - 90;
	}
	else
	{
		self.tagging["hud"]["small_spinner"].rotation = self.tagging["hud"]["small_spinner"].rotation - 90;
		self.tagging["hud"]["large_spinner"].rotation = self.tagging["hud"]["large_spinner"].rotation + 90;
	}

	while(var_07 < 1 && isdefined(self.tagging))
	{
		var_07 = clamp(1 - var_06 - gettime() / var_05,0,1);
		self.tagging["fov"] = param_00 + param_02 - param_00 * var_07;
		self.tagging["range"] = param_01 + param_03 - param_01 * var_07;
		if(!self.tagging["zoom"])
		{
			var_08 = 1 - var_07;
		}
		else
		{
			var_08 = var_07;
		}

		self.tagging["hud"]["zoom_guage_text"] setvalue(20 * var_08);
		var_09 = 21.95;
		var_0A = 551;
		if(self.tagging["zoom"])
		{
			var_09 = var_09 * -1;
		}

		var_0B = rotatevector((0,0 - var_0A,0),(0,var_09 * var_07 * 2 - 1,0));
		self.tagging["hud"]["zoom_guage_indicator"].x = var_0B[1] + var_0A + self.tagging["hud"]["zoom_guage_indicator"].left;
		self.tagging["hud"]["zoom_guage_indicator"].y = var_0B[0] * 0.75;
		self.tagging["hud"]["zoom_guage_indicator"].rotation = self.tagging["hud"]["zoom_guage_indicator"].rot_bot + self.tagging["hud"]["zoom_guage_indicator"].rot_top - self.tagging["hud"]["zoom_guage_indicator"].rot_bot * var_08;
		wait(0.05);
	}
}

//Function Number: 27
tag_update_enemy_in_sights()
{
	var_00 = maps\_utility::isads() && self.tagging["enabled"] && self.tagging["outline_enabled"];
	if(var_00)
	{
		var_01 = tagging_enemy_list();
		var_02 = self geteye();
		var_03 = anglestoforward(self getplayerangles());
		var_04 = undefined;
		var_05 = max(0.01,getdvarfloat("tagging_ads_cone_range"));
		var_06 = cos(getdvarfloat("tagging_ads_cone_angle"));
		var_07 = [0,0.5,1];
		var_08 = bullettrace(var_02,var_02 + var_03 * 32000,1,self);
		var_04 = var_08["entity"];
		foreach(var_0A in var_01)
		{
			if(isdefined(var_0A.tagged) && isdefined(var_0A.tagged[self getentitynumber()]))
			{
				continue;
			}

			if(!getdvarint("tagging_vehicle_ride") && isdefined(var_0A.vehicle_ride) && var_0A.vehicle_ride.veh_speed > 0)
			{
				continue;
			}

			var_0B = isdefined(var_04) && var_04 == var_0A;
			if(!var_0B)
			{
				var_0C = var_0A gettagorigin("tag_origin");
				if(isai(var_0A))
				{
					var_0C = var_0A geteye();
				}

				var_0D = distance(var_0C,var_02);
				if(var_0D <= var_05)
				{
					var_0E = min(1,var_06 + 1 - var_06 * var_0D / var_05);
					foreach(var_10 in var_07)
					{
						var_11 = vectorlerp(var_0A.origin,var_0C,var_10);
						var_12 = var_11 - var_02;
						var_13 = vectornormalize(var_12);
						var_14 = vectordot(var_13,var_03);
						if(var_14 > var_0E)
						{
							if(enemy_sight_trace_passed(var_0A))
							{
								var_0B = 1;
								break;
							}
						}
					}
				}
			}

			if(var_0B)
			{
				var_0A tag_trace_update("tracking",self,1);
				continue;
			}

			var_0A tag_trace_update("none",self,1);
		}
	}
}

//Function Number: 28
tag_monitor(param_00)
{
	self notify("tag_monitor");
	self endon("tag_monitor");
	self endon("tagging_off");
	self endon("unsync");
	self endon("death");
	for(;;)
	{
		tag_scan_update(self geteye(),self getplayerangles(),self.tagging["fov"],float(self.tagging["fov"]) * 0.28,self.tagging["range"]);
		wait(0.05);
	}
}

//Function Number: 29
enemy_sight_trace_request()
{
	if(isdefined(self.tagging_sight_traced_queued))
	{
		return;
	}

	if(!isdefined(self.tagging_sight_trace_passed))
	{
		self.tagging_sight_trace_passed = 0;
	}

	if(!isdefined(level.tagging_sight_trace_queue))
	{
		level.tagging_sight_trace_queue = [];
		level thread enemy_sight_trace_process();
	}

	level.tagging_sight_trace_queue = common_scripts\utility::array_add(level.tagging_sight_trace_queue,self);
	self.tagging_sight_traced_queued = 1;
}

//Function Number: 30
enemy_sight_trace_process()
{
	self notify("enemy_sight_trace_process");
	self endon("enemy_sight_trace_process");
	var_00 = 3;
	for(;;)
	{
		level.tagging_sight_trace_queue = common_scripts\utility::array_removeundefined(level.tagging_sight_trace_queue);
		for(var_01 = 0;var_01 < min(var_00,level.tagging_sight_trace_queue.size);var_01++)
		{
			var_02 = level.tagging_sight_trace_queue[0];
			level.tagging_sight_trace_queue = common_scripts\utility::array_remove(level.tagging_sight_trace_queue,var_02);
			var_02.tagging_sight_trace_passed = enemy_sight_trace(var_02);
			var_02.tagging_sight_traced_queued = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 31
enemy_sight_trace_passed(param_00)
{
	param_00 enemy_sight_trace_request();
	return param_00.tagging_sight_trace_passed;
}

//Function Number: 32
enemy_sight_trace(param_00)
{
	var_01 = 0;
	var_02 = level.player geteye();
	if(isai(param_00))
	{
		if(!var_01 && sighttracepassed(var_02,param_00 gettagorigin("j_head"),0,param_00.sight_ignore,param_00,0))
		{
			var_01 = 1;
		}

		if(!var_01 && sighttracepassed(var_02,param_00 gettagorigin("j_spinelower"),0,param_00.sight_ignore,param_00,0))
		{
			var_01 = 1;
		}
	}

	if(!var_01 && sighttracepassed(var_02,param_00.origin,0,param_00.sight_ignore,param_00,0))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 33
tag_scan_update(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = tagging_enemy_list();
	var_06 = cos(float(param_03));
	var_07 = param_04 * param_04;
	foreach(var_09 in var_05)
	{
		var_0A = "tracking";
		var_0B = (0,0,0);
		if(isai(var_09))
		{
			var_0B = var_09 geteye();
		}
		else
		{
			var_0B = var_09 gettagorigin("tag_origin");
		}

		if(isdefined(var_09.tagged) && isdefined(var_09.tagged[self getentitynumber()]))
		{
			continue;
		}

		if(!getdvarint("tagging_vehicle_ride") && isdefined(var_09.vehicle_ride) && var_09.vehicle_ride.veh_speed > 0)
		{
			continue;
		}

		if(!self.tagging["outline_enabled"] || !self.tagging["enabled"])
		{
			continue;
		}

		if(!common_scripts\utility::within_fov(param_00,param_01,var_0B,cos(float(param_02))))
		{
			var_09 tag_trace_update("none",self);
			continue;
		}

		if(!common_scripts\utility::within_fov(param_00,param_01,var_0B,var_06))
		{
			var_09 tag_trace_update("none",self);
			continue;
		}

		if(distancesquared(param_00,var_09.origin) > var_07)
		{
			var_0A = "tracking_slow";
		}

		if(enemy_sight_trace_passed(var_09))
		{
			var_09 tag_trace_update(var_0A,self);
			continue;
		}

		var_09 tag_trace_update("obstructed",self);
	}
}

//Function Number: 34
tag_trace_update(param_00,param_01,param_02)
{
	var_03 = gettime();
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = getdvarint("tagging_normal_pulse_rate");
	var_05 = getdvarint("tagging_normal_prep_time");
	var_06 = getdvarint("tagging_normal_track_time");
	var_07 = 0;
	if(!param_01.tagging["marking_enabled"])
	{
		param_00 = "range";
	}

	switch(param_00)
	{
		case "view":
			var_07 = 1;
			self.tag_trace_state = 0;
			self.tag_trace_track = undefined;
			break;

		case "range":
			self.tag_trace_state = 0;
			self.tag_trace_track = undefined;
			break;

		case "tracking_slow":
			var_04 = getdvarint("tagging_slow_pulse_rate");
			var_05 = getdvarint("tagging_slow_prep_time");
			var_06 = getdvarint("tagging_slow_track_time");
			break;

		case "tracking":
			if(!isdefined(self.tag_trace_track))
			{
				if(gettime() - param_01.tagging["last_tag_start"] / 1000 <= 0.25)
				{
					return;
				}
	
				self.tag_trace_track = var_03;
				param_01.tagging["last_tag_start"] = var_03;
			}
			break;

		case "obstructed":
		case "none":
		default:
			tag_outline_enemy(0);
			self.tag_trace_track = undefined;
			self.tag_trace_sound = undefined;
			break;
	}

	var_08 = var_06 + var_05;
	var_09 = 0;
	if(isdefined(self.tag_trace_track))
	{
		var_09 = var_03 - self.tag_trace_track;
	}

	if(var_09 >= var_08)
	{
		tag_enemy(param_01);
	}
}

//Function Number: 35
tag_outline_enemy(param_00)
{
	if(param_00)
	{
		tagged_status_show();
		thread tagged_enemy_death_cleanup();
		thread tagged_enemy_update();
	}
	else
	{
		tagged_status_hide();
		self notify("tagged_enemy_update");
	}

	tag_threat_detection(param_00);
}

//Function Number: 36
tagged_enemy_update()
{
	self endon("death");
	self notify("tagged_enemy_update");
	self endon("tagged_enemy_update");
	for(;;)
	{
		if(!getdvarint("tagging_vehicle_ride") && isdefined(self.vehicle_ride) && self.vehicle_ride.veh_speed > 0)
		{
			tag_outline_enemy(0);
			self notify("tagged_enemy_death_cleanup");
			self.tagged = undefined;
			return;
		}

		var_00 = self gettagorigin("tag_origin");
		if(isai(self))
		{
			var_00 = self geteye();
		}

		var_01 = vectornormalize(var_00 - level.player geteye());
		var_02 = anglestoforward(level.player getplayerangles());
		if(vectordot(var_01,var_02) < cos(65))
		{
			tag_threat_detection(0);
		}
		else if(enemy_sight_trace_passed(self))
		{
			tag_threat_detection(0);
		}
		else
		{
			tag_threat_detection(1);
		}

		wait(0.05);
	}
}

//Function Number: 37
tag_threat_detection(param_00)
{
	self setthreatdetection("disable");
	if(param_00)
	{
		if(self.team == "axis")
		{
			self setthreatdetection("detected");
		}
	}
}

//Function Number: 38
tag_enemy(param_00)
{
	if(!isdefined(self) || !isalive(self))
	{
		if(isdefined(self))
		{
			tag_outline_enemy(0);
		}

		return;
	}

	if(!isdefined(self.tagged) || !isdefined(self.tagged[param_00 getentitynumber()]) || !self.tagged[param_00 getentitynumber()])
	{
		soundscripts\_snd_playsound::snd_play_2d("drone_tag_success");
	}

	self.tagged[param_00 getentitynumber()] = 1;
	tag_outline_enemy(1);
	self.tag_trace_state = undefined;
	self.tag_trace_pulse = undefined;
	self.tag_trace_track = undefined;
	self.tag_trace_sound = undefined;
	tagged_status_show();
}

//Function Number: 39
tagged_status_show()
{
	tagged_status_hide();
	var_00 = 4;
	if(self.team != "axis" && self.team != "dead" && self.health > 0)
	{
		var_00 = 3;
	}

	if(isdefined(self.tagging_color) && self.tagging_color == var_00)
	{
		return;
	}

	self hudoutlineenable(var_00,0);
	self.tagging_color = var_00;
	thread tagged_status_update();
}

//Function Number: 40
tagged_status_hide()
{
	self notify("tagged_status_update");
	if(isdefined(self.tagging_color))
	{
		self hudoutlinedisable();
		self.tagging_color = undefined;
	}
}

//Function Number: 41
tagged_status_update()
{
	self notify("tagged_status_update");
	self endon("tagged_status_update");
	self endon("death");
	while(isdefined(self))
	{
		var_00 = level.player.tagging["tagging_fade_max"];
		var_01 = var_00 * var_00;
		var_02 = lengthsquared(level.player.origin - self.origin);
		if(var_02 > var_01)
		{
			self hudoutlinedisable();
			continue;
		}

		self hudoutlineenable(self.tagging_color,0);
		wait(0.05);
	}
}

//Function Number: 42
tagged_enemy_death_cleanup()
{
	if(isdefined(self.tagged_enemy_death_cleanup))
	{
		return;
	}

	self notify("tagged_enemy_death_cleanup");
	self endon("tagged_enemy_death_cleanup");
	self.tagged_enemy_death_cleanup = 1;
	common_scripts\utility::waittill_any("death","tagged_death");
	wait(0.1);
	if(isdefined(self) && distancesquared(self.origin,level.player.origin) > 90000)
	{
		var_00 = gettime();
		var_01 = 1;
		while(isdefined(self) && gettime() - var_00 < 1000)
		{
			if(var_01 == 0 && randomint(100) < 30)
			{
				tag_outline_enemy(1);
				var_01 = 1;
				continue;
			}

			if(var_01 == 1)
			{
				tag_outline_enemy(0);
				var_01 = 0;
			}

			wait(0.05);
		}
	}

	if(isdefined(self))
	{
		tag_outline_enemy(0);
	}

	self.tagged_enemy_death_cleanup = undefined;
}