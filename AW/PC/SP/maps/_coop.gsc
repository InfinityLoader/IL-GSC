/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_coop.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 304 ms
 * Timestamp: 10/27/2023 1:58:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::flag_init("coop_game");
	if(!maps\_utility::is_coop())
	{
		return;
	}

	common_scripts\utility::flag_set("coop_game");
	common_scripts\utility::flag_init("coop_show_constant_icon");
	setdvarifuninitialized("coop_show_constant_icon",1);
	if(getdvarint("coop_show_constant_icon") == 1)
	{
		common_scripts\utility::flag_set("coop_show_constant_icon");
	}

	precacheshader("hint_health");
	precacheshader("coop_player_location");
	precacheshader("coop_player_location_fire");
	level.coop_icon_blinktime = 7;
	level.coop_icon_blinkcrement = 0.375;
	level.coop_revive_nag_hud_refreshtime = 20;
	foreach(var_01 in level.players)
	{
		var_01.colorblind = var_01 getlocalplayerprofiledata("colorBlind");
		var_01 thread initialize_colors(var_01.colorblind);
		var_01 thread friendly_hud_init();
	}
}

//Function Number: 2
initialize_colors(param_00)
{
	if(param_00)
	{
		var_01 = (0.35,1,1);
		var_02 = (1,0.65,0.2);
		var_03 = (1,1,1);
		self.coop_icon_color_normal = var_01;
		self.coop_icon_color_downed = var_02;
		self.coop_icon_color_shoot = var_01;
		self.coop_icon_color_damage = var_03;
		self.coop_icon_color_dying = var_02;
		self.coop_icon_color_blink = var_03;
		return;
	}

	var_04 = (0.635,0.929,0.604);
	var_05 = (1,1,0.2);
	var_02 = (1,0.65,0.2);
	var_06 = (1,0.2,0.2);
	var_03 = (1,1,1);
	self.coop_icon_color_normal = var_04;
	self.coop_icon_color_downed = var_05;
	self.coop_icon_color_shoot = var_04;
	self.coop_icon_color_damage = var_02;
	self.coop_icon_color_dying = var_06;
	self.coop_icon_color_blink = var_03;
}

//Function Number: 3
rebuild_friendly_icon(param_00,param_01,param_02)
{
	if(isdefined(self.nofriendlyhudicon))
	{
		return;
	}

	if(!isdefined(self.friendlyicon) || self.friendlyicon.material != param_01)
	{
		create_fresh_friendly_icon(param_01);
	}

	self.friendlyicon.color = param_00;
	if(isdefined(param_02) && param_02)
	{
		self.friendlyicon setwaypointedgestyle_rotatingicon();
	}
}

//Function Number: 4
create_fresh_friendly_icon(param_00)
{
	if(isdefined(self.friendlyicon))
	{
		self.friendlyicon destroy();
	}

	self.friendlyicon = newclienthudelem(self);
	self.friendlyicon setshader(param_00,1,1);
	self.friendlyicon setwaypoint(1,1,0);
	self.friendlyicon setwaypointiconoffscreenonly();
	self.friendlyicon settargetent(maps\_utility::get_other_player(self));
	self.friendlyicon.material = param_00;
	self.friendlyicon.hidewheninmenu = 1;
	if(common_scripts\utility::flag("coop_show_constant_icon"))
	{
		self.friendlyicon.alpha = 1;
		return;
	}

	self.friendlyicon.alpha = 0;
}

//Function Number: 5
friendly_hud_icon_blink_on_fire()
{
	self endon("death");
	for(;;)
	{
		self waittill("weapon_fired");
		var_00 = maps\_utility::get_other_player(self);
		var_00 thread friendly_hud_icon_flash(var_00.coop_icon_color_shoot,"coop_player_location_fire",1);
	}
}

//Function Number: 6
friendly_hud_icon_blink_on_damage()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage");
		var_00 = maps\_utility::get_other_player(self);
		var_00 thread friendly_hud_icon_flash(var_00.coop_icon_color_damage,"coop_player_location",1);
	}
}

//Function Number: 7
friendly_hud_icon_flash(param_00,param_01,param_02)
{
	if(isdefined(self.nofriendlyhudicon))
	{
		return;
	}

	self endon("death");
	self notify("flash_color_thread");
	self endon("flash_color_thread");
	var_03 = maps\_utility::get_other_player(self);
	if(maps\_utility::is_player_down(var_03))
	{
		return;
	}

	rebuild_friendly_icon(param_00,param_01,param_02);
	wait(0.5);
	param_01 = friendlyhudicon_currentmaterial();
	var_04 = friendlyhudicon_rotating();
	rebuild_friendly_icon(self.coop_icon_color_normal,param_01,var_04);
}

//Function Number: 8
friendly_hud_init()
{
	level endon("special_op_terminated");
	friendlyhudicon_normal();
	thread friendly_hud_icon_blink_on_fire();
	thread friendly_hud_icon_blink_on_damage();
	thread monitor_color_blind_toggle();
	thread friendly_hud_destroy_on_mission_end();
	if(isdefined(self.nofriendlyhudicon))
	{
		return;
	}

	self.friendlyicon.alpha = 0;
	for(;;)
	{
		common_scripts\utility::flag_wait("coop_show_constant_icon");
		self.friendlyicon.alpha = 1;
		common_scripts\utility::flag_waitopen("coop_show_constant_icon");
		self.friendlyicon.alpha = 0;
	}
}

//Function Number: 9
friendly_hud_destroy_on_mission_end()
{
	level waittill("special_op_terminated");
	foreach(var_01 in level.players)
	{
		var_01 player_friendly_hud_destroy();
	}
}

//Function Number: 10
player_friendly_hud_destroy()
{
	if(isdefined(self.friendlyicon))
	{
		self.friendlyicon destroy();
	}
}

//Function Number: 11
friendlyhudicon_hideall()
{
	common_scripts\utility::flag_clear("coop_show_constant_icon");
}

//Function Number: 12
friendlyhudicon_showall()
{
	common_scripts\utility::flag_set("coop_show_constant_icon");
}

//Function Number: 13
friendlyhudicon_disable()
{
	self.nofriendlyhudicon = 1;
	player_friendly_hud_destroy();
}

//Function Number: 14
friendlyhudicon_enable()
{
	self.nofriendlyhudicon = undefined;
	if(!isdefined(self.friendlyicon))
	{
		friendlyhudicon_normal();
	}
}

//Function Number: 15
friendlyhudicon_normal()
{
	if(!common_scripts\utility::flag("coop_game"))
	{
		return;
	}

	self.coop_icon_state = "ICON_STATE_NORMAL";
	var_00 = friendlyhudicon_currentmaterial();
	var_01 = friendlyhudicon_rotating();
	rebuild_friendly_icon(self.coop_icon_color_normal,var_00,var_01);
}

//Function Number: 16
friendlyhudicon_downed()
{
	if(!common_scripts\utility::flag("coop_game"))
	{
		return;
	}

	self.coop_icon_state = "ICON_STATE_DOWNED";
	var_00 = friendlyhudicon_currentmaterial();
	var_01 = friendlyhudicon_rotating();
	rebuild_friendly_icon(self.coop_icon_color_downed,var_00,var_01);
}

//Function Number: 17
friendlyhudicon_update(param_00)
{
	if(!common_scripts\utility::flag("coop_game"))
	{
		return;
	}

	var_01 = friendlyhudicon_currentmaterial();
	var_02 = friendlyhudicon_rotating();
	rebuild_friendly_icon(param_00,var_01,var_02);
}

//Function Number: 18
friendlyhudicon_currentmaterial()
{
	var_00 = "coop_player_location";
	switch(self.coop_icon_state)
	{
		case "ICON_STATE_NORMAL":
			break;

		case "ICON_STATE_DOWNED":
			break;

		default:
			break;
	}
}

//Function Number: 19
friendlyhudicon_rotating()
{
	var_00 = 0;
	switch(self.coop_icon_state)
	{
		case "ICON_STATE_NORMAL":
			break;

		case "ICON_STATE_DOWNED":
			break;

		default:
			break;
	}
}

//Function Number: 20
monitor_color_blind_toggle()
{
	if(self getlocalplayerprofiledata("colorBlind") != self.colorblind)
	{
		self.colorblind = self getlocalplayerprofiledata("colorBlind");
		initialize_colors(self.colorblind);
		switch(self.coop_icon_state)
		{
			case "ICON_STATE_NORMAL":
				break;

			case "ICON_STATE_DOWNED":
				break;
		}
	}
}