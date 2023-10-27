/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_coop.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 320 ms
 * Timestamp: 10/27/2023 1:27:25 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	common_scripts\utility::func_3385("coop_game");
	if(!maps\_utility::func_47D0())
	{
		return;
	}

	common_scripts\utility::flag_set("coop_game");
	common_scripts\utility::func_3385("coop_show_constant_icon");
	setdvarifuninitialized("coop_show_constant_icon",1);
	if(getdvarint("coop_show_constant_icon") == 1)
	{
		common_scripts\utility::flag_set("coop_show_constant_icon");
	}

	precacheshader("hint_health");
	precacheshader("coop_player_location");
	precacheshader("coop_player_location_fire");
	level.var_1F2A = 7;
	level.coop_icon_blinkcrement = 0.375;
	level.var_1F34 = 20;
	foreach(var_01 in level.players)
	{
		var_01.colorblind = var_01 getlocalplayerprofiledata("colorBlind");
		var_01 thread func_4624(var_01.colorblind);
		var_01 thread func_353F();
	}
}

//Function Number: 2
func_4624(param_00)
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
func_63F6(param_00,param_01,param_02)
{
	if(isdefined(self.var_5661))
	{
	}

	if(!isdefined(self.friendlyicon) || self.friendlyicon.var_50CD != param_01)
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
	self.friendlyicon settargetent(maps\_utility::func_3922(self));
	self.friendlyicon.var_50CD = param_00;
	self.friendlyicon.hidewheninmenu = 1;
	if(common_scripts\utility::flag("coop_show_constant_icon"))
	{
		self.friendlyicon.alpha = 1;
	}

	self.friendlyicon.alpha = 0;
}

//Function Number: 5
func_353D()
{
	self endon("death");
	for(;;)
	{
		self waittill("weapon_fired");
		var_00 = maps\_utility::func_3922(self);
		var_00 thread func_353E(var_00.coop_icon_color_shoot,"coop_player_location_fire",1);
	}
}

//Function Number: 6
friendly_hud_icon_blink_on_damage()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage");
		var_00 = maps\_utility::func_3922(self);
		var_00 thread func_353E(var_00.coop_icon_color_damage,"coop_player_location",1);
	}
}

//Function Number: 7
func_353E(param_00,param_01,param_02)
{
	if(isdefined(self.var_5661))
	{
	}

	self endon("death");
	self notify("flash_color_thread");
	self endon("flash_color_thread");
	var_03 = maps\_utility::func_3922(self);
	if(maps\_utility::func_4825(var_03))
	{
	}

	func_63F6(param_00,param_01,param_02);
	wait(0.5);
	param_01 = func_3582();
	var_04 = friendlyhudicon_rotating();
	func_63F6(self.coop_icon_color_normal,param_01,var_04);
}

//Function Number: 8
func_353F()
{
	level endon("special_op_terminated");
	friendlyhudicon_normal();
	thread func_353D();
	thread friendly_hud_icon_blink_on_damage();
	thread func_533C();
	thread func_353B();
	if(isdefined(self.var_5661))
	{
	}

	self.friendlyicon.alpha = 0;
	for(;;)
	{
		common_scripts\utility::flag_wait("coop_show_constant_icon");
		self.friendlyicon.alpha = 1;
		common_scripts\utility::func_33A0("coop_show_constant_icon");
		self.friendlyicon.alpha = 0;
	}
}

//Function Number: 9
func_353B()
{
	level waittill("special_op_terminated");
	foreach(var_01 in level.players)
	{
		var_01 func_5E01();
	}
}

//Function Number: 10
func_5E01()
{
	if(isdefined(self.friendlyicon))
	{
		self.friendlyicon destroy();
	}
}

//Function Number: 11
func_3586()
{
	common_scripts\utility::func_337C("coop_show_constant_icon");
}

//Function Number: 12
friendlyhudicon_showall()
{
	common_scripts\utility::flag_set("coop_show_constant_icon");
}

//Function Number: 13
func_3583()
{
	self.var_5661 = 1;
	func_5E01();
}

//Function Number: 14
func_3585()
{
	self.var_5661 = undefined;
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
	}

	self.coop_icon_state = "ICON_STATE_NORMAL";
	var_00 = func_3582();
	var_01 = friendlyhudicon_rotating();
	func_63F6(self.coop_icon_color_normal,var_00,var_01);
}

//Function Number: 16
func_3584()
{
	if(!common_scripts\utility::flag("coop_game"))
	{
	}

	self.coop_icon_state = "ICON_STATE_DOWNED";
	var_00 = func_3582();
	var_01 = friendlyhudicon_rotating();
	func_63F6(self.coop_icon_color_downed,var_00,var_01);
}

//Function Number: 17
friendlyhudicon_update(param_00)
{
	if(!common_scripts\utility::flag("coop_game"))
	{
	}

	var_01 = func_3582();
	var_02 = friendlyhudicon_rotating();
	func_63F6(param_00,var_01,var_02);
}

//Function Number: 18
func_3582()
{
	var_00 = "coop_player_location";
	switch(self.coop_icon_state)
	{
		case "ICON_STATE_NORMAL":
			var_00 = "coop_player_location";
			break;

		case "ICON_STATE_DOWNED":
			var_00 = "hint_health";
			break;

		default:
			break;
	}

	return var_00;
}

//Function Number: 19
friendlyhudicon_rotating()
{
	var_00 = 0;
	switch(self.coop_icon_state)
	{
		case "ICON_STATE_NORMAL":
			var_00 = 1;
			break;

		case "ICON_STATE_DOWNED":
			var_00 = 0;
			break;

		default:
			break;
	}

	return var_00;
}

//Function Number: 20
func_533C()
{
	for(;;)
	{
		if(self getlocalplayerprofiledata("colorBlind") != self.colorblind)
		{
			self.colorblind = self getlocalplayerprofiledata("colorBlind");
			func_4624(self.colorblind);
			switch(self.coop_icon_state)
			{
				case "ICON_STATE_NORMAL":
					friendlyhudicon_normal();
					break;
	
				case "ICON_STATE_DOWNED":
					func_3584();
					break;
			}
		}

		wait(0.05);
	}
}