/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_final\cp_final_fast_travel.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 2583 ms
 * Timestamp: 10/27/2023 12:04:57 AM
*******************************************************************/

//Function Number: 1
init_teleport_portals()
{
	level._effect["death_ray_cannon_beam"] = loadfx("vfx/iw7/levels/cp_town/death_ray_cannon_beam.vfx");
	level._effect["death_ray_cannon_rock_impact"] = loadfx("vfx/iw7/levels/cp_final/rhino/vfx_metal_impact.vfx");
	level._effect["portal_glyph"] = loadfx("vfx/iw7/levels/cp_final/portal/vfx_portal_symbol_1.vfx");
	level._effect["vfx_pap_return_portal"] = loadfx("vfx/iw7/levels/cp_disco/vfx_paproom_portal.vfx");
	wait(5);
	var_00 = scripts\common\utility::getstructarray("fast_travel_portal","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread trigger_when_player_close_by();
		wait(0.1);
	}

	level thread func_15B6();
	level thread blast_doors_with_gun();
}

//Function Number: 2
register_portal_interactions()
{
	level.interaction_hintstrings["portal_console"] = &"CP_TOWN_INTERACTIONS_ATM_DEPOSIT";
	scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0,"portal_console",undefined,undefined,::portal_console_hint_func,::portal_console_activate_func,0,1,::portal_console_init_func);
	scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0,"portal_gun_button",undefined,undefined,::portal_gun_hint_func,::portal_gun_activate_func,0,1,::portal_gun_init_func);
}

//Function Number: 3
portal_console_init_func()
{
	var_00 = scripts\common\utility::getstructarray("portal_console","script_noteworthy");
	foreach(var_02 in var_00)
	{
		level thread stand_on_glyph(var_02);
	}
}

//Function Number: 4
portal_console_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 5
portal_console_activate_func(param_00,param_01)
{
}

//Function Number: 6
stand_on_glyph(param_00)
{
	var_01 = scripts\common\utility::getstructarray("fast_travel_portal_symbol","targetname");
	var_02 = scripts\common\utility::getclosest(param_00.origin,var_01,500);
	if(!isdefined(var_02))
	{
		return;
	}

	var_02.var_7542 = spawnfx(level._effect["portal_glyph"],var_02.origin);
	wait(0.1);
	triggerfx(var_02.var_7542);
	var_03 = 0;
	var_04 = 100;
	var_05 = var_04 * var_04;
	while(!var_03)
	{
		foreach(var_07 in level.players)
		{
			if(distancesquared(var_07.origin,var_02.origin) < var_05)
			{
				var_03 = 1;
				break;
			}
		}

		wait(0.5);
	}

	var_09 = scripts\common\utility::getstructarray("fast_travel_portal","targetname");
	var_0A = scripts\common\utility::getclosest(param_00.origin,var_09,500);
	var_0A.var_C626 = 1;
	var_0A.end_point.var_C626 = 1;
	var_02.var_7542 delete();
}

//Function Number: 7
trigger_when_player_close_by()
{
	var_00 = getentarray("fast_travel_portal_trigger","targetname");
	self.trigger = scripts\common\utility::getclosest(self.origin,var_00,500);
	self.trigger endon("death");
	self.start_point_name = self.script_noteworthy;
	self.end_point_name = self.var_EE79;
	self.end_point = scripts\common\utility::getstruct(self.end_point_name,"script_noteworthy");
	if(self.start_point_name == "left_alley")
	{
		self.trigger.origin = self.trigger.origin + (0,-15,0);
	}

	self.var_DDC4 = [];
	self.var_4613 = 0;
	self.var_C626 = 0;
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	self.teleport_spots = scripts\common\utility::getstructarray(self.end_point.target,"targetname");
	foreach(var_02 in self.teleport_spots)
	{
		if(!isdefined(var_02.angles))
		{
			var_02.angles = (0,0,0);
		}

		if(var_02.origin == (1792,1886,64))
		{
			var_02.origin = (1752,1918,64);
		}
	}

	scripts\common\utility::flag_wait("power_on");
	var_04 = scripts\common\utility::getstructarray("fast_travel_portal_spot","targetname");
	self.portal_spot = scripts\common\utility::getclosest(self.origin,var_04,500);
	self.portal_scriptable = spawn("script_model",self.portal_spot.origin + (0,0,53));
	self.portal_scriptable setmodel("tag_origin_final_portal");
	self.portal_scriptable.angles = self.angles;
	self.portal_scriptable setscriptablepartstate("portal","cooldown");
	thread portal_cooldown_monitor();
	wait_for_portal_doors_open();
	self.last_time_player_used = gettime();
	wait(1);
	for(;;)
	{
		self.trigger waittill("trigger",var_05);
		if(scripts\common\utility::istrue(var_05.inlaststand))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(!isplayer(var_05))
		{
			if(self.last_time_player_used + 5000 > gettime())
			{
				if(!isdefined(var_05.last_travel_time) || gettime() > var_05.last_travel_time + 10000)
				{
					thread move_zombie_through_portal_tube(var_05);
				}
			}

			scripts\common\utility::func_136F7();
			continue;
		}

		var_06 = anglestoforward(var_05.angles);
		if(vectordot(vectornormalize(self.portal_spot.origin - var_05.origin),var_06) < 0.66)
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		toggleplayerlocation(var_05,self);
		if(self.end_point.var_C626 && self.var_4613 <= 0)
		{
			self.end_point.var_4613 = self.end_point.var_4613 + 10;
			thread send_followers_through_tube(var_05);
			self.last_time_player_used = gettime();
			move_player_through_portal_tube(var_05);
			if(!scripts\common\utility::istrue(level.used_portal))
			{
				scripts\cp\maps\cp_final\cp_final::setup_era_zombie_model_list();
			}

			level.used_portal = 1;
			if(isdefined(self.end_point_name))
			{
				if(self.end_point_name == "theater")
				{
					var_05 lib_0D2A::func_12D7C("DOUBLE_FEATURE",1);
				}
			}

			activate_room_after_portal_use(self.end_point_name);
		}

		wait(0.1);
	}
}

//Function Number: 8
toggleplayerlocation(param_00,param_01)
{
	if(isdefined(param_01.end_point_name))
	{
		if(param_01.end_point_name == "theater" || param_01.end_point_name == "left_alley" || param_01.end_point_name == "theater_front")
		{
			param_00.currentlocation = "theater";
			return;
		}

		param_00.currentlocation = "facility";
	}
}

//Function Number: 9
activate_room_after_portal_use(param_00)
{
	switch(param_00)
	{
		case "theater":
			scripts\cp\zombies\zombies_spawning::func_15FC("theater_main");
			if(!scripts\common\utility::istrue(level.theater_open))
			{
				foreach(var_02 in level.players)
				{
					var_02 scripts\cp\_merits::func_D9AD("mt_dlc4_theater_open");
				}
	
				level.theater_open = 1;
			}
			break;

		case "cargo_room":
			scripts\cp\zombies\zombies_spawning::func_15FC("cargo");
			break;

		case "left_alley":
			scripts\cp\zombies\zombies_spawning::func_15FC("hallway_to_alley");
			break;

		case "starting_room":
			scripts\cp\zombies\zombies_spawning::func_15FC("facility_start");
			break;

		case "pump_room":
			scripts\cp\zombies\zombies_spawning::func_15FC("medical_lab");
			break;

		case "theater_front":
			scripts\cp\zombies\zombies_spawning::func_15FC("theater_street");
			break;

		default:
			break;
	}
}

//Function Number: 10
wait_for_portal_doors_open()
{
	crack_portal_doors();
	open_portal_doors();
}

//Function Number: 11
crack_portal_doors()
{
	var_00 = getentarray("center_portal_door_left","targetname");
	var_01 = scripts\common\utility::getclosest(self.origin,var_00,500);
	if(isdefined(var_01))
	{
		var_02 = scripts\common\utility::getstructarray("center_portal_door_left_pos","targetname");
		var_03 = scripts\common\utility::getclosest(self.origin,var_02,500);
		if(isdefined(var_03))
		{
			var_04 = var_03.origin - var_01.origin;
			var_05 = scripts\cp\_utility::func_13192(var_04,0.2) + var_01.origin;
			var_01 moveto(var_05,0.5,0.1,0.1);
		}
	}

	var_06 = getentarray("center_portal_door_right","targetname");
	var_07 = scripts\common\utility::getclosest(self.origin,var_06,500);
	if(isdefined(var_07))
	{
		var_02 = scripts\common\utility::getstructarray("center_portal_door_right_pos","targetname");
		var_03 = scripts\common\utility::getclosest(self.origin,var_02,500);
		if(isdefined(var_03))
		{
			var_04 = var_03.origin - var_07.origin;
			var_05 = scripts\cp\_utility::func_13192(var_04,0.2) + var_07.origin;
			var_07 moveto(var_05,0.5,0.1,0.1);
		}
	}

	wait(0.5);
}

//Function Number: 12
open_portal_doors()
{
	var_00 = getentarray("portal_door_left","targetname");
	var_01 = scripts\common\utility::getclosest(self.origin,var_00,500);
	if(isdefined(var_01))
	{
		var_02 = scripts\common\utility::getstructarray("portal_door_left_pos","targetname");
		var_03 = scripts\common\utility::getclosest(self.origin,var_02,500);
		var_01 moveto(var_03.origin,0.5,0.1,0.1);
	}

	var_04 = getentarray("portal_door_right","targetname");
	var_05 = scripts\common\utility::getclosest(self.origin,var_04,500);
	if(isdefined(var_05))
	{
		var_02 = scripts\common\utility::getstructarray("portal_door_right_pos","targetname");
		var_03 = scripts\common\utility::getclosest(self.origin,var_02,500);
		var_05 moveto(var_03.origin,0.5,0.1,0.1);
	}

	wait(0.5);
}

//Function Number: 13
blast_doors_with_gun()
{
	level.portal_gun_activated = 0;
	while(!scripts\common\utility::istrue(level.portal_gun_init_done))
	{
		wait(0.1);
	}

	var_00 = "death_ray_cannon_beam";
	var_01 = "tag_origin_laser_ray_fx";
	var_02 = "death_ray_cannon_rock_impact";
	var_03 = scripts\common\utility::getstructarray("gun_barrel","targetname");
	var_03 = level.portal_gun.barrel_ents;
	while(!level.portal_gun_activated)
	{
		wait(0.1);
	}

	wait(1);
	foreach(var_05 in var_03)
	{
		var_06 = spawn("script_model",var_05.origin);
		var_06.angles = var_05.angles;
		var_06 setmodel(var_01);
		var_05.var_75F5 = var_06;
	}

	wait(1);
	var_08 = (1745,1827,68);
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.angles))
		{
			var_05.angles = (0,0,0);
		}

		function_02E0(level._effect[var_00],var_05.origin,var_05.angles,var_08);
	}

	playsoundatpos(level.portal_gun.origin,"zmb_railgun_fire");
	wait(0.1);
	foreach(var_05 in var_03)
	{
		var_05.var_75F5 delete();
	}

	playfx(level._effect[var_02],var_08);
	var_0D = undefined;
	var_0E = scripts\common\utility::getstructarray("fast_travel_portal","targetname");
	foreach(var_10 in var_0E)
	{
		if(var_10.script_noteworthy == "cargo_room")
		{
			var_0D = var_10;
		}
	}

	if(isdefined(var_0D))
	{
		var_0D.var_C626 = 1;
		var_0D.end_point.var_C626 = 1;
	}

	var_12 = getentarray("center_portal_door_left","targetname");
	var_13 = scripts\common\utility::getclosest(var_03[0].origin,var_12,1000);
	var_13 delete();
	var_12 = getentarray("center_portal_door_right","targetname");
	var_13 = scripts\common\utility::getclosest(var_03[0].origin,var_12,1000);
	var_13 delete();
}

//Function Number: 14
debug_portal_door_open()
{
	for(;;)
	{
		if(getdvarint("scr_open_portals") != 0)
		{
			break;
		}

		wait(1);
	}

	var_00 = scripts\common\utility::getstructarray("fast_travel_portal","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.portal_spot))
		{
			var_02.var_C626 = 1;
		}
	}
}

//Function Number: 15
portal_gun_init_func(param_00,param_01)
{
	level.portal_gun_activated = 0;
	level.portal_gun = getent("portal_gun","targetname");
	var_02 = scripts\common\utility::getstruct("portal_gun_cargo_pos","targetname");
	level.portal_gun.var_10CE2 = level.portal_gun.origin;
	level.portal_gun.var_10B9F = level.portal_gun.angles;
	level.portal_gun.var_62EE = var_02.origin;
	level.portal_gun.end_ang = var_02.angles;
	level.portal_gun_crane = getent("laser_cannon_crane","targetname");
	var_02 = scripts\common\utility::getstruct("laser_cannon_crane_cargo_pos","targetname");
	level.portal_gun_crane.var_10CE2 = level.portal_gun_crane.origin;
	level.portal_gun_crane.var_10B9F = level.portal_gun_crane.angles;
	level.portal_gun_crane.var_62EE = var_02.origin;
	level.portal_gun_crane.end_ang = var_02.angles;
	wait(5);
	var_03 = scripts\common\utility::getstructarray("gun_barrel","targetname");
	level.portal_gun.barrel_ents = [];
	foreach(var_05 in var_03)
	{
		var_06 = spawn("script_origin",var_05.origin);
		wait(0.5);
		var_06.angles = var_05.angles;
		level.portal_gun.barrel_ents[level.portal_gun.barrel_ents.size] = var_06;
		var_06 linkto(level.portal_gun);
	}

	level.portal_gun_init_done = 1;
}

//Function Number: 16
portal_gun_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 17
portal_gun_activate_func(param_00,param_01)
{
	if(scripts\common\utility::flag("power_on"))
	{
		var_02 = getent("portal_gun_button","targetname");
		var_02 setmodel("mp_frag_button_on_green");
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		level.portal_gun moveto(level.portal_gun.var_62EE,5,0.1,0.1);
		level.portal_gun_crane moveto(level.portal_gun_crane.var_62EE,5,0.1,0.1);
		level.portal_gun_crane thread play_move_sounds(5);
		level.portal_gun waittill("movedone");
		level thread play_charge_up_sounds();
		level.portal_gun rotateto(level.portal_gun.end_ang,3,0.1,0.1);
		level.portal_gun waittill("rotatedone");
		level.portal_gun_activated = 1;
		scripts\cp\maps\cp_final\cp_final_mpq::deactivateinteractionsbynoteworthy("portal_gun_button");
	}
}

//Function Number: 18
play_charge_up_sounds()
{
	wait(1.25);
	playsoundatpos(level.portal_gun.origin,"zmb_cannon_charge_up");
}

//Function Number: 19
play_move_sounds(param_00)
{
	var_01 = lookupsoundlength("zmb_cannon_platform_start") / 1000;
	var_02 = lookupsoundlength("zmb_cannon_platform_stop") / 1000;
	var_03 = param_00 - var_01 - var_02;
	self playsoundonmovingent("zmb_cannon_platform_start");
	wait(var_01);
	scripts\cp\_utility::func_CD85("zmb_cannon_platform_loop");
	wait(var_03);
	scripts\cp\_utility::func_11019("zmb_cannon_platform_loop");
	self playsoundonmovingent("zmb_cannon_platform_stop");
}

//Function Number: 20
send_followers_through_tube(param_00)
{
	var_01 = level.spawned_enemies;
	var_02 = param_00.origin;
	var_03 = 500;
	var_04 = var_03 * var_03;
	foreach(var_06 in var_01)
	{
		if(isdefined(var_06.myenemy) && var_06.myenemy == param_00)
		{
			if(distancesquared(var_06.origin,var_02) < var_04)
			{
				thread send_to_portal(var_06);
			}

			continue;
		}

		if(isdefined(var_06.var_10C) && var_06.var_10C == param_00)
		{
			if(distancesquared(var_06.origin,var_02) < var_04)
			{
				thread send_to_portal(var_06);
			}
		}
	}
}

//Function Number: 21
send_to_portal(param_00)
{
	param_00 endon("death");
	param_00 endon("portal_timed_out");
	param_00.var_EF64 = 1;
	param_00.sent_to_portal = 1;
	var_01 = getclosestpointonnavmesh(self.trigger.origin);
	param_00 method_8286(var_01);
	level thread stop_trying_to_go_through_portal(param_00,5);
	param_00 waittill("goal_reached");
	param_00 method_8286(param_00.origin);
}

//Function Number: 22
stop_trying_to_go_through_portal(param_00,param_01)
{
	param_00 endon("death");
	wait(param_01);
	param_00.sent_to_portal = undefined;
	param_00.var_EF64 = 0;
	param_00 notify("portal_timed_out");
	param_00 method_8286(param_00.origin);
}

//Function Number: 23
turn_on_portal()
{
	self.portal_scriptable setscriptablepartstate("portal","active");
}

//Function Number: 24
move_player_through_portal_tube(param_00)
{
	param_00 endon("disconnect");
	param_00 scripts\cp\powers\coop_powers::func_D728();
	param_00.disable_consumables = 1;
	param_00.isfasttravelling = 1;
	param_00 method_80F3();
	param_00 notify("delete_equipment");
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_01 = func_BC83(param_00,"fast_travel_tube_start","fast_travel_tube_end",1);
	self.var_4613 = self.var_4613 + 10;
	teleport_to_portal_safe_spot(param_00);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
	var_01 delete();
	param_00 scripts\cp\_utility::func_E0E6("papRoom",0);
	param_00.var_9C54 = undefined;
	param_00.kicked_out = undefined;
	param_00.isfasttravelling = undefined;
	param_00 notify("fast_travel_complete");
	param_00.disable_consumables = undefined;
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00 thread update_personal_ents_after_delay();
}

//Function Number: 25
move_zombie_through_portal_tube(param_00)
{
	if(scripts\common\utility::istrue(param_00.var_11B2F))
	{
		return;
	}

	param_00.isfasttravelling = 1;
	param_00.last_travel_time = gettime();
	var_01 = ai_move_through_tube(param_00,"fast_travel_tube_start","fast_travel_tube_end",1);
	teleport_ai_to_portal_safe_spot(param_00);
	wait(0.1);
	if(isdefined(var_01))
	{
		var_01 delete();
	}

	param_00.var_EF64 = 0;
	param_00.isfasttravelling = undefined;
}

//Function Number: 26
func_BC83(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("move_through_tube");
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

//Function Number: 27
ai_move_through_tube(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("move_through_tube");
	var_04 = getent(param_01,"targetname");
	var_05 = getent(param_02,"targetname");
	param_00.var_C004 = 1;
	param_00.var_C016 = 1;
	var_06 = var_04.origin + (0,0,-45);
	var_07 = var_05.origin + (0,0,-45);
	param_00.var_9BE1 = 1;
	param_00 scripts\cp\_utility::func_17C0("fast_travel",0,0);
	param_00 dontinterpolate();
	param_00 setorigin(var_06);
	param_00 setplayerangles(var_04.angles);
	var_08 = spawn("script_origin",var_06);
	param_00 linkto(var_08);
	wait(0.1);
	var_08 moveto(var_07,1);
	wait(1);
	param_00.var_9BE1 = undefined;
	param_00.var_9BE1 = undefined;
	param_00.var_C004 = 0;
	param_00.var_C016 = 0;
	param_00.sent_to_portal = undefined;
	param_00.var_EF64 = 0;
	return var_08;
}

//Function Number: 28
update_personal_ents_after_delay()
{
	self endon("disconnect");
	scripts\common\utility::func_136F7();
	scripts\cp\_interaction::func_DE6E();
}

//Function Number: 29
unlinkplayerafterduration()
{
	while(scripts\common\utility::istrue(self.isrewinding) || isdefined(self.rewindmover))
	{
		wait(0.1);
	}

	self unlink();
}

//Function Number: 30
teleport_to_portal_safe_spot(param_00,param_01)
{
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = self.teleport_spots;
	}

	var_03 = undefined;
	while(!isdefined(var_03))
	{
		foreach(var_05 in var_02)
		{
			if(!positionwouldtelefrag(var_05.origin))
			{
				var_03 = var_05;
			}
		}

		if(!isdefined(var_03))
		{
			if(!isdefined(var_02[0].angles))
			{
				var_02[0].angles = (0,0,0);
			}

			var_07 = scripts\cp\_utility::func_13192(anglestoforward(var_02[0].angles),64);
			var_03 = spawnstruct();
			var_03.origin = var_02[0].origin + var_07;
			var_03.angles = var_02[0].angles;
		}

		wait(0.1);
	}

	param_00 method_8447();
	if(scripts\common\utility::istrue(param_00.isrewinding) || isdefined(self.rewindmover))
	{
		param_00 thread unlinkplayerafterduration();
	}
	else
	{
		param_00 unlink();
	}

	param_00 dontinterpolate();
	param_00 setorigin(var_03.origin);
	param_00 setplayerangles(var_03.angles);
	param_00.disable_consumables = undefined;
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00.portal_end_origin = var_03.origin;
	playfx(level._effect["vfx_zmb_portal_exit_burst"],var_03.origin,var_03.angles);
}

//Function Number: 31
teleport_ai_to_portal_safe_spot(param_00)
{
	var_01 = scripts\common\utility::array_randomize(self.teleport_spots);
	var_02 = undefined;
	var_03 = undefined;
	while(!isdefined(var_02))
	{
		foreach(var_03 in var_01)
		{
			if(!scripts\common\utility::istrue(var_03.var_93A8))
			{
				if(!positionwouldtelefrag(var_03.origin))
				{
					var_02 = var_03;
					var_03.var_93A8 = 1;
					break;
				}
			}
		}

		if(!isdefined(var_02))
		{
			if(!isdefined(var_01[0].angles))
			{
				var_01[0].angles = (0,0,0);
			}

			var_06 = scripts\cp\_utility::func_13192(anglestoforward(var_01[0].angles),64);
			if(!positionwouldtelefrag(var_06))
			{
				var_02 = spawnstruct();
				var_02.origin = var_01[0].origin + var_06;
				var_02.angles = var_01[0].angles;
				break;
			}
		}

		wait(0.1);
	}

	if(isdefined(var_03) && scripts\common\utility::istrue(var_03.var_93A8))
	{
		var_03.var_93A8 = undefined;
	}

	var_06 = getclosestpointonnavmesh(var_02.origin) + (0,0,5);
	param_00 unlink();
	param_00 dontinterpolate();
	param_00 setorigin(var_06);
	param_00 setplayerangles(var_02.angles);
	param_00.portal_end_origin = var_06;
	playfx(level._effect["vfx_zmb_portal_exit_burst"],var_06,var_02.angles);
}

//Function Number: 32
portal_cooldown_monitor()
{
	self.portal_scriptable setscriptablepartstate("portal","cooldown");
	while(!scripts\common\utility::istrue(self.end_point.var_C626))
	{
		wait(0.1);
	}

	var_00 = 0.1;
	for(;;)
	{
		if(self.var_4613 > 0)
		{
			self.var_4613 = self.var_4613 - var_00;
			if(self.portal_scriptable method_8551("portal") != "cooldown")
			{
				self.portal_scriptable setscriptablepartstate("portal","cooldown");
			}
		}
		else
		{
			self.portal_scriptable setscriptablepartstate("portal",self.var_EE79);
		}

		if(self.var_4613 < 0)
		{
			self.var_4613 = 0;
		}

		wait(var_00);
	}
}

//Function Number: 33
func_15B6()
{
	level endon("game_ended");
	level thread func_1298D();
	var_00 = scripts\common\utility::getstruct("spawn_portal_fx","script_noteworthy");
	var_01 = scripts\common\utility::getstruct("pap_portal","script_noteworthy");
	level.pap_portal_scriptable = spawn("script_model",var_00.origin);
	level.pap_portal_scriptable setmodel("prop_zm_scriptable_portal_fx_final");
	level.pap_portal_scriptable.angles = var_00.angles;
	for(;;)
	{
		level.var_8E61 = 1;
		func_1297F(1);
		level waittill("hidden_room_portal_used");
		wait(30);
		level.pap_portal_scriptable func_F556();
		var_01.var_4622 = 1;
		level.var_8E61 = 0;
		level.var_8E63 = 1;
		level notify("hidden_room_portal_cooldown_start");
		func_1297F(0);
		thread pappenaltyspawn();
		wait(60);
		level.pap_portal_scriptable func_F28A();
		var_01.var_4622 = undefined;
		level.var_8E63 = 1;
		level notify("hidden_room_portal_cooldown_over");
	}
}

//Function Number: 34
pappenaltyspawn()
{
	if(scripts\common\utility::istrue(level.spawned_phantom))
	{
		if(randomint(100) < 25)
		{
			var_00 = [(3140,6164,134),(3204,6442,195),(3466,6567,227),(2887,6395,189),(3406,6507,227)];
			var_01 = scripts\common\utility::random(var_00);
			if(!positionwouldtelefrag(var_01))
			{
				var_02 = scripts\common\utility::getclosest(var_01,level.players);
				var_03 = spawnstruct();
				var_03.origin = var_01;
				var_03.angles = anglestoforward(var_02.origin - var_01);
				var_04 = var_03 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_phantom");
				if(!isdefined(var_04))
				{
					thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single(var_02.var_245);
				}
			}
		}
		else
		{
			thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single();
		}

		return;
	}

	var_00 = [(3140,6164,134),(3204,6442,195),(3466,6567,227),(2887,6395,189),(3406,6507,227)];
	var_01 = scripts\common\utility::random(var_00);
	var_02 = scripts\common\utility::getclosest(var_01,level.players);
	if(!positionwouldtelefrag(var_01))
	{
		var_03 = spawnstruct();
		var_03.origin = var_01;
		var_03.angles = anglestoforward(var_02.origin - var_01);
		var_04 = var_03 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_phantom");
		if(isdefined(var_04))
		{
			level.spawned_phantom = 1;
			return;
		}

		thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single(var_02.var_245);
		return;
	}

	thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single(var_02.var_245);
}

//Function Number: 35
func_1297F(param_00)
{
	if(param_00)
	{
		level.pap_portal_scriptable setscriptablepartstate("portal","active");
		return;
	}

	level.pap_portal_scriptable setscriptablepartstate("portal","powered_on");
}

//Function Number: 36
func_1298D()
{
	var_00 = scripts\common\utility::getstruct("hidden_room_portal","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("tag_origin");
	var_01.angles = var_00.angles;
	var_02 = anglestoforward(var_00.angles);
	level.pap_room_portal = spawnfx(level._effect["vfx_pap_return_portal"],var_00.origin,var_02);
	wait(1);
	triggerfx(level.pap_room_portal);
	func_11627(var_01);
}

//Function Number: 37
func_11627(param_00)
{
	param_00 makeusable();
	param_00 sethintstring(&"CP_FINAL_INTERACTIONS_EXIT_PAP_ROOM");
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

//Function Number: 38
func_11648()
{
	self endon("left_hidden_room_early");
	var_00 = scripts\common\utility::getstructarray("pap_spawners","targetname");
	move_player_through_pap_tube(self,var_00);
	self method_8447();
	scripts\cp\_utility::func_17C0("papRoom",0,0);
	self.var_9C54 = 1;
	self.disable_consumables = undefined;
	scripts\cp\powers\coop_powers::func_D72E();
	set_in_pap_room(self,1);
	thread func_8E64();
	level notify("hidden_room_portal_used");
}

//Function Number: 39
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

//Function Number: 40
func_8E64()
{
	self endon("left_hidden_room_early");
	self endon("disconnect");
	self endon("last_stand");
	self.kicked_out = undefined;
	thread func_C8A9();
	level thread pap_vo(self);
	self waittill("kicked_out");
	self.kicked_out = 1;
	level thread func_8E60(self);
}

//Function Number: 41
func_8E60(param_00)
{
	param_00 method_80F3();
	param_00 notify("delete_equipment");
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_01 = func_BC83(param_00,"hidden_travel_tube_end","hidden_travel_tube_start",1);
	scripts\common\utility::getstruct("pap_portal","script_noteworthy") func_1164E(param_00);
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

//Function Number: 42
reduce_reserved_post_death()
{
	self waittill("death");
	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
}

//Function Number: 43
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

//Function Number: 44
set_in_pap_room(param_00,param_01)
{
	param_00.is_in_pap = param_01;
}

//Function Number: 45
pap_vo(param_00)
{
	if(level.var_C8A3 != 1)
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("pap_room_first","zmb_pap_vo");
	}

	level.var_C8A3 = 1;
	param_00 endon("disconnect");
	wait(4);
	level thread scripts\cp\_vo::try_to_play_vo("ww_pap_nag","zmb_pap_vo","high",undefined,undefined,undefined,1);
}

//Function Number: 46
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

//Function Number: 47
func_F556()
{
	self setscriptablepartstate("portal","powered_on");
}

//Function Number: 48
func_F28A()
{
	self setscriptablepartstate("portal","active");
}

//Function Number: 49
func_E7F4(param_00,param_01)
{
	if(!param_01 scripts\cp\_utility::isteleportenabled())
	{
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	if(scripts\common\utility::flag("disable_portals"))
	{
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	var_02 = 0;
	if(param_01 scripts\cp\_persistence::func_D0BB(var_02))
	{
		param_01 scripts\cp\_interaction::func_11449(var_02,"fast_travel");
		param_01 thread func_5591(param_01,0.5,"fast_travel_complete");
		param_00 thread func_126BE(param_01);
	}
}

//Function Number: 50
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

//Function Number: 51
func_126BE(param_00)
{
	param_00 scripts\cp\powers\coop_powers::func_D728();
	param_00 notify("delete_equipment");
	param_00.disable_consumables = 1;
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	param_00 func_11648();
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
}

//Function Number: 52
move_player_through_pap_tube(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 scripts\cp\powers\coop_powers::func_D728();
	param_00.disable_consumables = 1;
	param_00.isfasttravelling = 1;
	param_00 method_80F3();
	param_00 notify("delete_equipment");
	param_00 notify("cancel_trap");
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_02 = func_BC83(param_00,"hidden_travel_tube_start","hidden_travel_tube_end");
	if(isdefined(self.var_4613))
	{
		self.var_4613 = self.var_4613 + 10;
	}

	teleport_to_portal_safe_spot(param_00,param_01);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
	var_02 delete();
	param_00 scripts\cp\_utility::func_E0E6("papRoom",0);
	param_00.var_9C54 = undefined;
	param_00.kicked_out = undefined;
	param_00.isfasttravelling = undefined;
	param_00.disable_consumables = undefined;
	param_00 notify("fast_travel_complete");
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00 thread update_personal_ents_after_delay();
	if(param_00.var_134FD == "p5_")
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("fasttravel_exit","town_comment_vo");
	}
}