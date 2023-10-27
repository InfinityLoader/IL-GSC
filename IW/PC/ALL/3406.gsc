/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3406.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 18 ms
 * Timestamp: 10/27/2023 12:27:05 AM
*******************************************************************/

//Function Number: 1
func_6B8F()
{
	scripts\common\utility::flag_init("fast_travel_init_done");
	level.end_portal_name = "main_street";
	level.var_8E63 = 0;
	func_95D9();
	level.fast_travel_spots = [];
	level.var_6B91 = [];
	var_00 = scripts\common\utility::getstructarray("fast_travel","script_noteworthy");
	level.var_5592 = ::func_5591;
	level.var_6B8D = ::func_126BF;
	level.var_D679 = (646.605,701.459,105.882);
	foreach(var_02 in var_00)
	{
		level.var_6B91[level.var_6B91.size] = var_02;
		var_02 func_95DA();
	}

	scripts\common\utility::flag_set("fast_travel_init_done");
	level thread func_8E62();
	level thread func_B23A();
	level thread func_172F();
	level thread func_172E();
	scripts\common\utility::flag_init("disable_portals");
	scripts\common\utility::flag_init("pap_portal_used");
}

//Function Number: 2
func_95D9()
{
	level._effect["hidden_room_portal_locked"] = loadfx("vfx/iw7/_requests/coop/vfx_cp_z_portal_01_idle.vfx");
	level._effect["hidden_room_portal_locked_exit"] = loadfx("vfx/iw7/_requests/coop/vfx_cp_z_portal_01_out.vfx");
	level._effect["hidden_room_portal_locked_charging"] = loadfx("vfx/iw7/levels/cp_zmb/vfx_cp_z_portal_01.vfx");
	level._effect["hidden_room_portal"] = loadfx("vfx/iw7/core/impact/energy_sm/vfx_cp_z_portal_02.vfx");
}

//Function Number: 3
func_95DA()
{
	level endon("game_ended");
	var_00 = getentarray("portal_center","targetname");
	var_01 = level.end_portal_name == self.script_area;
	if(!var_01)
	{
		var_00 = scripts\common\utility::func_782F(self.origin,var_00);
		self.var_D682 = var_00[0];
		func_F4AA();
	}
	else
	{
		var_00 = scripts\common\utility::func_782F(self.origin,var_00);
		self.var_D682 = var_00[0];
		func_F4AA();
	}

	self.end_positions = scripts\common\utility::getstructarray(self.target,"targetname");
	level.fast_travel_spots[self.script_area] = self;
	var_02 = getentarray("portal_trigger","targetname");
	var_02 = scripts\common\utility::func_782F(self.origin,var_02);
	self.var_D680 = var_02[0];
	self.var_D674 = 0;
	thread func_D681();
	var_03 = getentarray(self.target,"targetname");
	var_03 = scripts\common\utility::func_782F(self.origin,var_03);
	self.var_1B9 = var_03[0];
	if(isdefined(self.var_1B9))
	{
		self.var_1B9 setlightintensity(0);
	}

	self.var_D776 = 0;
	self.var_D674 = 0;
	self.var_D67E = 0;
	self.var_D677 = 0;
	thread func_8947(var_01);
}

//Function Number: 4
func_8947(param_00)
{
	var_01 = self.script_area;
	if(var_01 == "moon")
	{
		var_02 = getentarray("rangetarget","targetname");
		foreach(var_04 in var_02)
		{
			var_04 hide();
		}
	}

	if(param_00)
	{
		for(;;)
		{
			var_06 = level scripts\common\utility::func_13734("power_on",self.var_D71C + " power_on","portal_on","power_off");
			if(var_06 != "power_off")
			{
				self.var_D776 = 1;
				self.var_D674 = 1;
				func_1297F(0);
				getent("center_portal","targetname") setscriptablepartstate("model","on");
				continue;
			}

			self.var_D776 = 0;
			func_1297F(0);
			wait(0.25);
		}

		return;
	}

	for(;;)
	{
		var_06 = level scripts\common\utility::func_13734("power_on",self.var_D71C + " power_on","power_off");
		if(scripts\common\utility::flag("disable_portals"))
		{
			continue;
		}

		if(var_06 != "power_off")
		{
			if(scripts\cp\_utility::map_check(0))
			{
				level thread scripts\cp\_vo::func_1769("dj_portal_use_nag","zmb_dj_vo",60,15,2,1);
			}

			scripts\cp\_vo::try_to_play_vo_on_all_players("nag_use_portal",1);
			switch(var_01)
			{
				default:
					self.var_D776 = 1;
					self.var_D674 = 1;
					self.var_D67E = 0;
					self.var_D677 = 0;
					if(isdefined(self.var_1B9))
					{
						self.var_1B9 setlightintensity(1);
					}
		
					func_F556();
					level notify("portal_on");
					break;
			}
		}
		else
		{
			self.var_D776 = 0;
			if(isdefined(self.var_D682))
			{
				self.var_D682 stoploopsound();
				func_F4AA();
			}

			if(isdefined(self.var_1B9))
			{
				self.var_1B9 setlightintensity(0);
			}
		}

		wait(0.25);
	}
}

//Function Number: 5
func_C8A9()
{
	self endon("disconnect");
	if(!isdefined(self.var_C8A8))
	{
		self.var_C8A8 = 1;
		var_00 = 30;
		self setclientomnvar("zombie_papTimer",var_00);
		wait(1);
		for(;;)
		{
			var_00--;
			if(var_00 < 0)
			{
				var_00 = 30;
				wait(1);
				break;
			}

			self setclientomnvar("zombie_papTimer",var_00);
			wait(1);
		}

		self setclientomnvar("zombie_papTimer",-1);
		self notify("kicked_out");
		wait(30);
		self.var_C8A8 = undefined;
	}
}

//Function Number: 6
func_172F()
{
	var_00 = getent("fast_travel_tube_start","targetname");
	var_01 = anglestoforward(var_00.angles);
	var_02 = spawnfx(level._effect["vfx_zmb_portal_base_01"],var_00.origin + (0,0,15),var_01);
	triggerfx(var_02);
	var_00 = getent("fast_travel_tube_end","targetname");
	var_01 = anglestoforward(var_00.angles);
	var_02 = spawnfx(level._effect["vfx_zmb_portal_centhub"],var_00.origin + (0,0,15),var_01);
	triggerfx(var_02);
}

//Function Number: 7
func_172E()
{
	var_00 = getent("hidden_travel_tube_start","targetname");
	var_01 = anglestoforward(var_00.angles);
	var_02 = spawnfx(level._effect["vfx_zmb_portal_centhub"],var_00.origin + (0,0,15),var_01);
	triggerfx(var_02);
	var_00 = getent("hidden_travel_tube_end","targetname");
	var_01 = anglestoforward(var_00.angles + (0,180,0));
	var_02 = spawnfx(level._effect["hidden_room_portal"],var_00.origin + (0,0,15),var_01);
	triggerfx(var_02);
}

//Function Number: 8
func_6B8E(param_00,param_01)
{
	if(scripts\common\utility::flag("disable_portals"))
	{
		return "";
	}

	if(param_00.var_E1B9 && !param_00.var_D776)
	{
		return &"COOP_INTERACTIONS_REQUIRES_POWER";
	}

	if(param_00.script_area == level.end_portal_name)
	{
		if(scripts\common\utility::istrue(level.var_8E61))
		{
			return &"CP_ZMB_INTERACTIONS_HIDDEN_TELEPORT";
		}
		else if(level.var_8E63)
		{
			return &"COOP_INTERACTIONS_COOLDOWN";
		}
		else
		{
			return &"CP_ZMB_INTERACTIONS_EXIT_PORTAL";
		}
	}

	if(!scripts\common\utility::istrue(param_00.var_D674))
	{
		if(param_00.var_D67E)
		{
			return &"COOP_INTERACTIONS_COOLDOWN";
		}
		else
		{
			return "";
		}
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 9
func_5591(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 scripts\cp\_utility::allow_player_teleport(0);
	param_00 waittill(param_02);
	wait(param_01);
	if(!param_00 scripts\cp\_utility::isteleportenabled())
	{
		param_00 scripts\cp\_utility::allow_player_teleport(1);
	}

	param_00 notify("can_teleport");
}

//Function Number: 10
func_E7F4(param_00,param_01)
{
	if(scripts\common\utility::flag("disable_portals"))
	{
		return;
	}

	if(!param_01 scripts\cp\_utility::isteleportenabled())
	{
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	if(!scripts\common\utility::istrue(param_00.var_D674))
	{
		return;
	}

	var_02 = 0.5;
	if(param_00.script_area != level.end_portal_name)
	{
		if(scripts\common\utility::flag("disable_portals"))
		{
			param_01 scripts\cp\_interaction::func_DE6E();
			return;
		}

		var_03 = 0;
		if(param_01 scripts\cp\_persistence::func_D0BB(var_03))
		{
			param_01 scripts\cp\_interaction::func_11449(var_03,"fast_travel");
			param_00 thread func_6B8B();
			return;
		}

		param_01 thread scripts\cp\_vo::try_to_play_vo("no_cash","zmb_comment_vo","high",30,0,0,1,50);
		param_01 scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_NEED_MONEY");
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	if(scripts\common\utility::istrue(level.var_8E61))
	{
		param_01 thread func_5591(param_01,var_02,"fast_travel_complete");
		param_00 thread func_126BE(param_01);
	}
}

//Function Number: 11
func_6AF8(param_00)
{
	self.var_13DB4 = 1;
	lib_0D12::func_6626(1,param_00);
	wait(param_00);
	if(scripts\common\utility::istrue(self.var_13DB4))
	{
		lib_0D12::func_6978(1);
		self.var_13DB4 = 0;
	}
}

//Function Number: 12
func_126BF(param_00,param_01)
{
	param_00 scripts\cp\powers\coop_powers::func_D728();
	param_00.disable_consumables = 1;
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_02 = func_BC83(param_00,"fast_travel_tube_start","fast_travel_tube_end",param_01);
	level.fast_travel_spots[level.end_portal_name] func_1164E(param_00);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	var_03 = (646.605,701.459,105.882);
	var_04 = anglestoforward((0,90,0));
	playfx(level._effect["vfx_zmb_portal_exit_burst"],var_03,var_04);
	wait(0.1);
	var_02 delete();
	if(!isdefined(param_01))
	{
		if(!scripts\common\utility::istrue(self.var_13068))
		{
			self.var_13068 = 1;
			var_05 = 0;
			var_06 = self.script_area;
			switch(var_06)
			{
				case "moon":
					var_05 = 1;
					break;

				case "europa":
					var_05 = 2;
					break;

				case "mars":
					var_05 = 3;
					break;

				case "arcade":
					var_05 = 0;
					break;

				default:
					var_05 = 0;
					break;
			}

			level notify("turn_on_portal_light",int(var_05));
			if(func_1BF8())
			{
				level.last_portal_opener = param_00;
			}
		}
	}

	param_00 notify("fast_travel_complete");
}

//Function Number: 13
func_CE6F(param_00,param_01)
{
	if(!isdefined(level.var_12913))
	{
		level.var_12913 = 1;
	}

	if(scripts\common\utility::istrue(param_00.var_13068))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01))
	{
		return;
	}

	switch(level.var_12913)
	{
		case 1:
			self playlocalsound("announcer_portal_1of4");
			break;

		case 2:
			self playlocalsound("announcer_portal_2of4");
			break;

		case 3:
			self playlocalsound("announcer_portal_3of4");
			break;

		case 4:
			level notify("pap_portal_unlocked");
			self playlocalsound("announcer_portal_4of4");
			break;

		default:
			break;
	}

	level.var_12913++;
}

//Function Number: 14
func_126BE(param_00)
{
	param_00 scripts\cp\powers\coop_powers::func_D728();
	param_00 notify("delete_equipment");
	param_00.disable_consumables = 1;
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_01 = func_BC83(param_00,"hidden_travel_tube_start","hidden_travel_tube_end");
	param_00 func_11648();
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
	var_01 delete();
}

//Function Number: 15
func_8E60(param_00)
{
	param_00 method_80F3();
	param_00 notify("delete_equipment");
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_01 = func_BC83(param_00,"hidden_travel_tube_end","hidden_travel_tube_start",1);
	level.fast_travel_spots[level.end_portal_name] func_1164E(param_00);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
	var_01 delete();
	if(scripts\common\utility::istrue(param_00.var_13DB4))
	{
		param_00 lib_0D12::func_6978(1);
		param_00.var_13DB4 = 0;
	}

	param_00 scripts\cp\_utility::func_E0E6("papRoom",0);
	param_00.var_9C54 = undefined;
	param_00.kicked_out = undefined;
	param_00 set_in_pap_room(param_00,0);
	param_00 notify("fast_travel_complete");
	scripts\cp\_vo::func_E01F("ww_pap_nag");
	scripts\cp\_vo::func_E01F("nag_find_pap");
}

//Function Number: 16
set_in_pap_room(param_00,param_01)
{
	param_00.is_in_pap = param_01;
}

//Function Number: 17
is_in_pap_room(param_00)
{
	return scripts\common\utility::istrue(self.is_in_pap);
}

//Function Number: 18
func_BC83(param_00,param_01,param_02,param_03)
{
	param_00 earthquakeforplayer(0.3,0.2,param_00.origin,200);
	var_04 = getent(param_01,"targetname");
	var_05 = getent(param_02,"targetname");
	param_00 cancelmantle();
	param_00.var_C004 = 1;
	param_00.var_C016 = 1;
	var_06 = var_04.origin + (0,0,-45);
	var_07 = var_05.origin + (0,0,-45);
	param_00.var_9BE1 = 1;
	param_00 scripts\cp\_utility::func_17C0("fast_travel",0,0);
	param_00 scripts\cp\_utility::func_1C5C(1);
	param_00 dontinterpolate();
	param_00 setorigin(var_06);
	param_00 setplayerangles(var_04.angles);
	param_00 playlocalsound("zmb_portal_travel_lr");
	var_08 = spawn("script_origin",var_06);
	param_00 playerlinkto(var_08);
	param_00 method_8232();
	wait(0.1);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	var_08 moveto(var_07,1);
	wait(1);
	param_00.var_9BE1 = undefined;
	param_00 scripts\cp\_utility::func_E0E6("fast_travel",0);
	if(param_00 scripts\cp\_utility::func_9E3A())
	{
		param_00 scripts\cp\_utility::func_1C5C(0);
	}

	param_00.var_9BE1 = undefined;
	param_00.var_C004 = 0;
	param_00.var_C016 = 0;
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	return var_08;
}

//Function Number: 19
func_B23A()
{
	var_00 = 0;
	var_01 = getent("center_portal","targetname");
	while(var_00 < 4)
	{
		level waittill("turn_on_portal_light",var_02);
		var_03 = undefined;
		switch(var_02)
		{
			case 0:
				var_01 setscriptablepartstate("light2","show");
				break;

			case 1:
				var_01 setscriptablepartstate("light1","show");
				break;

			case 2:
				var_01 setscriptablepartstate("light3","show");
				break;

			case 3:
				var_01 setscriptablepartstate("light4","show");
				break;
		}

		var_00++;
	}
}

//Function Number: 20
func_1164E(param_00)
{
	var_01 = undefined;
	while(!isdefined(var_01))
	{
		foreach(var_03 in self.end_positions)
		{
			if(!positionwouldtelefrag(var_03.origin))
			{
				var_01 = var_03;
			}
		}

		if(!isdefined(var_01))
		{
			var_05 = scripts\cp\_utility::func_13192(anglestoforward(self.end_positions[0].angles,64));
			var_01 = self.end_positions[0].origin + var_05;
		}

		wait(0.1);
	}

	param_00 method_8447();
	param_00 unlink();
	param_00 dontinterpolate();
	param_00 setorigin(var_01.origin);
	param_00 setplayerangles(var_01.angles);
	param_00.disable_consumables = undefined;
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00 thread scripts\cp\_vo::try_to_play_vo("portal_exit","zmb_comment_vo");
}

//Function Number: 21
func_1BF8()
{
	if(getdvarint("debug_teleport_quest_done",0) == 1)
	{
		return 1;
	}

	foreach(var_01 in level.fast_travel_spots)
	{
		if(var_01.script_area == level.end_portal_name)
		{
			continue;
		}

		if(!scripts\common\utility::istrue(var_01.var_13068))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 22
func_8E62()
{
	for(;;)
	{
		if(func_1BF8())
		{
			break;
		}

		wait(0.1);
	}

	if(isdefined(level.last_portal_opener))
	{
		if(isdefined(level.last_portal_opener.var_134FD))
		{
			switch(level.last_portal_opener.var_134FD)
			{
				case "p1_":
					level thread scripts\cp\_vo::try_to_play_vo("portal_pap_valleygirl_1","zmb_dialogue_vo","highest",666,0,0,0,100);
					break;

				case "p2_":
					level thread scripts\cp\_vo::try_to_play_vo("portal_pap_nerd_1","zmb_dialogue_vo","highest",666,0,0,0,100);
					break;

				case "p3_":
					level thread scripts\cp\_vo::try_to_play_vo("portal_pap_rapper_1","zmb_dialogue_vo","highest",666,0,0,0,100);
					break;

				case "p4_":
					level thread scripts\cp\_vo::try_to_play_vo("portal_pap_jock_1","zmb_dialogue_vo","highest",666,0,0,0,100);
					break;

				default:
					break;
			}
		}
	}

	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::func_1769("nag_find_pap","zmb_comment_vo",60,15,6,1);
	}

	level thread scripts\cp\_vo::func_1769("dj_quest_ufo_pap1_nag","zmb_dj_vo",120,100,2,1);
	func_15B6();
}

//Function Number: 23
func_15B6()
{
	level endon("game_ended");
	level thread func_1298D();
	for(;;)
	{
		level.var_8E61 = 1;
		func_1297F(1);
		level waittill("hidden_room_portal_used");
		if(scripts\common\utility::istrue(level.var_C617))
		{
			continue;
		}

		wait(30);
		level.var_8E61 = 0;
		level.var_8E63 = 1;
		level notify("hidden_room_portal_cooldown_start");
		func_1297F(0);
		wait(60);
		level.var_8E63 = 1;
		level notify("hidden_room_portal_cooldown_over");
	}
}

//Function Number: 24
func_1297F(param_00)
{
	if(param_00)
	{
		getent("center_portal","targetname") setscriptablepartstate("portal","active");
		return;
	}

	getent("center_portal","targetname") setscriptablepartstate("portal","powered_on");
}

//Function Number: 25
func_1298D()
{
	var_00 = getent("hidden_room_portal","targetname");
	var_01 = anglestoforward(var_00.angles);
	var_02 = spawnfx(level._effect["vfx_zmb_portal_centhub"],var_00.origin,var_01);
	triggerfx(var_02);
	func_11627(var_00);
}

//Function Number: 26
func_11627(param_00)
{
	param_00 makeusable();
	param_00 sethintstring(&"CP_ZMB_INTERACTIONS_HIDDEN_LEAVE");
	param_00.var_D67A = 1;
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01.kicked_out))
		{
			var_01 notify("left_hidden_room_early");
			var_01.disable_consumables = 1;
			func_8E60(var_01);
		}

		wait(0.1);
	}
}

//Function Number: 27
func_11648()
{
	self endon("left_hidden_room_early");
	set_in_pap_room(self,1);
	scripts\cp\_utility::func_17C0("papRoom",0,0);
	self.var_9C54 = 1;
	self.disable_consumables = undefined;
	var_00 = scripts\common\utility::getstruct("hidden_room_spot","targetname");
	self unlink();
	self dontinterpolate();
	scripts\cp\powers\coop_powers::func_D72E();
	self setorigin(var_00.origin);
	self setplayerangles(var_00.angles);
	self method_8447();
	level notify("hidden_room_portal_used");
	thread func_8E64();
}

//Function Number: 28
func_8E64()
{
	self endon("left_hidden_room_early");
	self endon("disconnect");
	self endon("last_stand");
	self.kicked_out = undefined;
	if(!scripts\common\utility::flag("pap_portal_used"))
	{
		scripts\common\utility::flag_set("pap_portal_used");
	}

	thread func_C8A9();
	level thread pap_vo(self);
	self waittill("kicked_out");
	self.kicked_out = 1;
	level thread func_8E60(self);
}

//Function Number: 29
pap_vo(param_00)
{
	if(level.var_C8A3 != 1)
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("pap_room_first","zmb_pap_vo");
	}

	level.var_C8A3 = 1;
	wait(4);
	param_00 thread scripts\cp\_vo::try_to_play_vo("ww_pap_nag","zmb_pap_vo","high",undefined,undefined,undefined,1);
}

//Function Number: 30
func_6B8B()
{
	self.var_D674 = 0;
	self.var_D682.angles = self.var_D682.angles + (0,180,0);
	self.var_D677 = 1;
	func_F2FE();
	wait(3);
	self.var_D677 = 0;
	self.var_D67A = 1;
	func_F28A();
	wait(15);
	self.var_D67A = 0;
	func_F30B();
	self.var_D682.angles = self.var_D682.angles - (0,180,0);
	self.var_D682 stoploopsound();
	self.var_1B9 setlightintensity(0);
	self.var_D67E = 1;
	wait(30);
	self.var_D674 = 1;
	self.var_D67E = 0;
	func_DE70();
	self.var_1B9 setlightintensity(10);
	func_F556();
}

//Function Number: 31
func_DE70()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.var_A8D3) && var_01.var_A8D3 == self)
		{
			var_01 scripts\cp\_interaction::func_DE6E();
		}
	}
}

//Function Number: 32
func_D678()
{
	if(isdefined(self.var_D67C))
	{
		self.var_D67C delete();
	}
}

//Function Number: 33
func_D681()
{
	level endon("game_ended");
	if(!isdefined(self.var_D680))
	{
		return;
	}

	self.var_D67A = 0;
	var_00 = 0.5;
	for(;;)
	{
		self.var_D680 waittill("trigger",var_01);
		if(scripts\common\utility::flag("disable_portals"))
		{
			wait(0.05);
			continue;
		}

		if(isplayer(var_01) && self.var_D67A)
		{
			if(scripts\cp\_laststand::player_in_laststand(var_01))
			{
				wait(0.05);
				continue;
			}

			scripts\cp\zombies\zombie_analytics::func_AF85(level.wave_num,self.script_area);
			if(scripts\common\utility::istrue(level.var_13DB5))
			{
				var_01 thread func_5591(var_01,var_00,"fast_travel_complete");
				var_01 thread func_6AF8(30);
				level notify("player_entering_wor_changed_portal",var_01);
				thread func_126BE(var_01);
			}
			else
			{
				var_01 thread func_5591(var_01,var_00,"fast_travel_complete");
				thread func_126BF(var_01);
			}
		}

		wait(0.1);
	}
}

//Function Number: 34
func_F556()
{
	self.var_D682 setscriptablepartstate("portal","powered_on");
}

//Function Number: 35
func_F2FE()
{
	self.var_D682 setscriptablepartstate("portal","charging");
}

//Function Number: 36
func_F4AA()
{
	self.var_D682 setscriptablepartstate("portal","off");
}

//Function Number: 37
func_F28A()
{
	self.var_D682 setscriptablepartstate("portal","active");
}

//Function Number: 38
func_F30B()
{
	self.var_D682 setscriptablepartstate("portal","off");
}