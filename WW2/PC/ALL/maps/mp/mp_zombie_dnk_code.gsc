/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_dnk_code.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 176
 * Decompile Time: 3000 ms
 * Timestamp: 10/27/2023 3:18:48 AM
*******************************************************************/

//Function Number: 1
init_dnk_code()
{
	while(!isdefined(level.var_744A) || level.var_744A.size < 1)
	{
		wait 0.05;
	}

	thread init_dnk_debug();
	thread ship_tilting_init();
	thread audio_log_init();
	thread escape_init();
}

//Function Number: 2
init_dnk_debug()
{
}

//Function Number: 3
___________________ship_tilting___________________()
{
}

//Function Number: 4
ship_tilting_init()
{
	common_scripts\utility::func_3C87("flag_ship_tilting_enabled");
	common_scripts\utility::func_3C8F("flag_ship_tilting_enabled");
	level.groundrefent = spawn("script_model",(0,0,0));
	thread maps\mp\_utility::func_6F74(::ship_tilting_camera_tilt_init);
	thread ship_tilting_tilt_timer();
	thread ship_tilting_object_setup();
	thread ship_tilting_tilt_controller();
	thread ship_tilting_water_tilt();
}

//Function Number: 5
ship_tilting_tilt_timer()
{
	var_00 = 40;
	var_01 = 60;
	var_02 = 20;
	var_03 = 40;
	level.shiptiltingtimermin = var_00;
	level.shiptiltingtimermax = var_01;
	level thread handle_forced_ship_tilt();
	for(;;)
	{
		level common_scripts\utility::func_A70D(randomintrange(level.shiptiltingtimermin,level.shiptiltingtimermax),level,"force_ship_to_tilt");
		if(common_scripts\utility::func_3C77("flag_ship_tilting_enabled"))
		{
			level notify("ship_tilting_change_direction");
		}
	}
}

//Function Number: 6
handle_forced_ship_tilt()
{
	for(;;)
	{
		if(!common_scripts\utility::func_562E(level.ship_is_tilting))
		{
			wait(1);
			if(!common_scripts\utility::func_562E(level.ship_is_tilting) && common_scripts\utility::func_562E(level.trucks_are_port_locked))
			{
				level notify("force_ship_to_tilt");
			}
		}

		wait 0.05;
	}
}

//Function Number: 7
ship_tilting_camera_tilt_init()
{
	self waittill("zombie_player_spawn_finished");
	self playersetgroundreferenceent(level.groundrefent);
}

//Function Number: 8
ship_tilting_object_setup()
{
	var_00 = getentarray("ship_tilting_org","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = getentarray(var_02.var_1A2,"targetname");
		foreach(var_05 in var_03)
		{
			switch(var_05.var_3A)
			{
				case "script_model":
					var_02.tiltermodel = var_05;
					var_05 method_8449(var_02);
					break;

				case "script_brushmodel":
					var_02.tilterclip = var_05;
					var_05 method_8449(var_02);
					break;

				case "script_origin":
					if(var_05.var_165 == "ship_tilting_org_starboard")
					{
						var_02.starboardorigin = var_05.var_116;
					}
					else if(var_05.var_165 == "ship_tilting_org_port")
					{
						var_02.portorigin = var_05.var_116;
					}
					break;

				case "trigger_multiple":
					var_02.safetytrigger = var_05;
					var_05 enablelinkto();
					var_05 method_8449(var_02);
					var_05 thread ship_tilting_collision_backup();
					break;
			}
		}

		var_02.var_6C55 = var_02.var_116;
		var_02 thread ship_tilting_object_movement();
	}
}

//Function Number: 9
ship_tilting_tilt_controller()
{
	thread ship_tilting_camera_tilt();
	if(!isdefined(level.tiltdirection))
	{
		var_00 = randomintrange(0,2);
		if(var_00 == 0)
		{
			level.tiltdirection = "starboard";
		}
		else
		{
			level.tiltdirection = "port";
		}
	}

	for(;;)
	{
		level waittill("ship_tilting_change_direction");
		if(common_scripts\utility::func_562E(level.trucks_are_port_locked) && level.tiltdirection != "port")
		{
			continue;
		}

		level.ship_is_tilting = 1;
		thread ship_tilting_rumble();
		thread ship_tilting_zombie_stumble();
		if(level.tiltdirection == "port")
		{
			level.tiltdirection = "starboard";
			level notify("ship_tilting_starboard");
			continue;
		}

		if(level.tiltdirection == "starboard")
		{
			level.tiltdirection = "port";
			level notify("ship_tilting_port");
		}
	}
}

//Function Number: 10
ship_tilting_object_movement()
{
	for(;;)
	{
		var_00 = randomfloatrange(6,7);
		var_01 = var_00 * 0.3;
		var_02 = var_00 * 0.05;
		var_03 = level common_scripts\utility::func_A715("ship_tilting_starboard","ship_tilting_port");
		wait(var_00 * 0.2);
		self.tilterclip method_8060();
		var_04 = getnodearray("ship_tilting_collision_nodes","targetname");
		if(isdefined(level.var_9068.var_9090) && isarray(level.var_9068.var_9090))
		{
			var_04 = common_scripts\utility::func_F73(var_04,level.var_9068.var_9090);
		}

		self.tilterclip.var_A048 = var_04;
		self.tilterclip.var_A045 = ::ship_tilting_unresolved_collision_func;
		switch(var_03)
		{
			case "ship_tilting_starboard":
				if(isdefined(self.starboardorigin))
				{
					self moveto(self.starboardorigin,var_00,var_01,var_02);
					lib_0378::func_8D74("start_vehicle_slide",var_00,"ship_tilting_starboard");
				}
				else
				{
					self moveto(self.var_6C55,var_00,var_01,var_02);
					lib_0378::func_8D74("start_vehicle_slide",var_00,"ship_tilting_original");
				}
				break;
	
			case "ship_tilting_port":
				if(isdefined(self.portorigin))
				{
					self moveto(self.portorigin,var_00,var_01,var_02);
					lib_0378::func_8D74("start_vehicle_slide",var_00,"ship_tilting_port");
				}
				else
				{
					self moveto(self.var_6C55,var_00,var_01,var_02);
					lib_0378::func_8D74("start_vehicle_slide",var_00,"ship_tilting_original");
				}
				break;
		}

		thread ship_tilting_update_object_navmesh();
		wait(var_00);
		self notify("ship_tilting_object_movement_stop");
		self.tilterclip method_805F();
	}
}

//Function Number: 11
ship_tilting_update_object_navmesh()
{
	self endon("ship_tilting_object_movement_stop");
	for(;;)
	{
		self.tilterclip method_805F();
		wait(0.5);
	}
}

//Function Number: 12
ship_tilting_collision_backup()
{
	var_00 = getnodearray("ship_tilting_collision_nodes","targetname");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(isplayer(var_01))
		{
			maps\mp\_movers::func_A047(var_01,0);
			var_01 down_player();
		}
		else if(function_01EF(var_01))
		{
			var_01 lib_0547::func_5A85(var_01.var_116 + (0,0,30),var_01.var_116 - self.var_116 * 2);
		}

		wait 0.05;
	}
}

//Function Number: 13
ship_tilting_unresolved_collision_func(param_00)
{
	if(isdefined(param_00) && isplayer(param_00))
	{
		maps\mp\_movers::func_A047(param_00,0);
		param_00 down_player();
		return;
	}

	if(isdefined(param_00) && function_01EF(param_00))
	{
		param_00 lib_056D::func_5A86();
	}
}

//Function Number: 14
ship_tilting_zombie_stumble()
{
	var_00 = 0.5;
	var_01 = lib_0547::func_4090("zombie_generic");
	foreach(var_03 in var_01)
	{
		if(lib_0547::func_5565(var_03.var_BA4,"traverse"))
		{
			continue;
		}

		var_04 = randomfloat(1);
		if(var_04 > var_00)
		{
			var_05 = spawnstruct();
			var_05.var_959C = level.groundrefent;
			var_06 = randomintrange(0,2);
			var_07 = 4;
			switch(var_06)
			{
				case 0:
					var_05.var_9598 = "close";
					var_07 = 3;
					break;

				case 1:
					var_05.var_9598 = "medium";
					var_07 = 2;
					break;
			}

			if(!isdefined(var_05.var_9598))
			{
				var_05.var_9598 = "close";
			}

			var_08 = randomfloatrange(0.25,1.5);
			var_03 maps\mp\_utility::func_2CED(var_08,::ship_tilting_zombie_stumble_execute,var_05);
			var_03 maps\mp\_utility::func_2CED(var_08 + var_07,::ship_tilting_zombie_stumble_cleanup,var_05);
		}
	}
}

//Function Number: 15
ship_tilting_zombie_stumble_execute(param_00)
{
	if(isalive(self) && self.var_BA4 != "traverse")
	{
		self.was_ship_tilt_tackled = 1;
		lib_0547::func_959B(param_00);
	}
}

//Function Number: 16
ship_tilting_zombie_stumble_cleanup(param_00)
{
	if(isalive(self) && common_scripts\utility::func_562E(self.was_ship_tilt_tackled))
	{
		self.was_ship_tilt_tackled = 0;
		lib_0547::func_959A(param_00);
	}
}

//Function Number: 17
ship_tilting_water_tilt()
{
	var_00 = getentarray("ship_tilting_water_plane","script_noteworthy");
	var_01 = randomfloatrange(6,7);
	var_02 = var_01 * 0.3;
	var_03 = var_01 * 0.05;
	for(;;)
	{
		var_04 = level common_scripts\utility::func_A715("ship_tilting_starboard","ship_tilting_port");
		wait(var_01 * 0.2);
		switch(var_04)
		{
			case "ship_tilting_starboard":
				thread fx_water_tilt_1();
				foreach(var_06 in var_00)
				{
					var_06 rotateto((1,0,0),var_01,var_02,var_03);
				}
				break;
	
			case "ship_tilting_port":
				thread fx_water_tilt_2();
				foreach(var_06 in var_00)
				{
					var_06 rotateto((-1,0,0),var_01,var_02,var_03);
				}
				break;
		}
	}
}

//Function Number: 18
fx_water_tilt_1()
{
	var_00 = randomfloatrange(3,5);
	level thread common_scripts\_exploder::func_88E(207);
	wait(var_00);
	level thread common_scripts\_exploder::func_88E(205);
}

//Function Number: 19
fx_water_tilt_2()
{
	var_00 = randomfloatrange(3,5);
	level thread common_scripts\_exploder::func_88E(206);
	wait(var_00);
	level thread common_scripts\_exploder::func_88E(204);
}

//Function Number: 20
ship_tilting_camera_tilt()
{
	for(;;)
	{
		var_00 = randomfloatrange(5,7);
		var_01 = level common_scripts\utility::func_A715("ship_tilting_starboard","ship_tilting_port");
		lib_0378::func_8D74("zmb_dnk_ship_tilt",var_01);
		if(var_01 == "ship_tilting_starboard")
		{
			level.groundrefent rotateto((8,0,0),var_00,var_00 * 0.5,var_00 * 0.5);
			wait(var_00);
			level.groundrefent rotateto((5,0,0),var_00,var_00 * 0.5,var_00 * 0.5);
		}
		else if(var_01 == "ship_tilting_port")
		{
			level.groundrefent rotateto((-8,0,0),var_00,var_00 * 0.5,var_00 * 0.5);
			wait(var_00);
			level.groundrefent rotateto((-5,0,0),var_00,var_00 * 0.5,var_00 * 0.5);
		}

		foreach(var_03 in level.var_744A)
		{
			var_03 stoprumble("slide_loop");
		}
	}
}

//Function Number: 21
ship_tilting_rumble()
{
	foreach(var_01 in level.var_744A)
	{
		var_01 playrumblelooponentity("slide_loop");
	}
}

//Function Number: 22
debug_ship_tilting_tilt_ship()
{
	level notify("ship_tilting_change_direction");
}

//Function Number: 23
debug_ship_tilting_disable()
{
	common_scripts\utility::func_3C7B("flag_ship_tilting_enabled");
}

//Function Number: 24
______trap______()
{
}

//Function Number: 25
water_trap_init()
{
	level.var_9CFB = 1;
	level.var_62B5 = 1;
	level.var_611["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_small");
	level.var_611["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink_small");
	level.var_9CD1["ready_to_active"] = undefined;
	level.var_9CD1["active_to_cooldown"] = undefined;
	level.var_9CD1["cooldown_to_active"] = undefined;
	var_00 = common_scripts\utility::func_46B5("trap_ship_tilting_water","script_noteworthy");
	var_00.damagetrigger = getent("ship_tilting_trap_damage_trig","targetname");
	var_00.vfxplane = getent("ship_tilting_trap_vfx_plane","targetname");
	var_00.vfxplane method_805C();
	var_00 thread water_trap_movement();
	thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_ship_tilting_water","active",::water_trap);
}

//Function Number: 26
water_trap(param_00)
{
	level.trapwater = param_00 common_scripts\utility::func_8FFC();
	level.trapwater.var_9CBB = "trap_ship_tilting_water";
	level.trapwater.var_9C92 = param_00;
	lib_0378::func_8D74("start_water_trap",param_00);
	var_01 = undefined;
	if(isdefined(param_00.var_1A2))
	{
		var_02 = common_scripts\utility::func_46B7(param_00.var_1A2,"targetname");
		foreach(var_04 in var_02)
		{
			if(lib_0547::func_5565(var_04.var_165,"activate_model_dest"))
			{
				var_01 = var_04;
			}
		}
	}

	var_06 = param_00.var_6298.var_1D;
	param_00 thread water_trap_rotate_lever(var_06,var_01);
	param_00 thread water_trap_damage();
}

//Function Number: 27
water_trap_rotate_lever(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	self.var_6298 rotateto(param_01.var_1D,0.35,0.1,0.1);
	wait(2);
	self.var_6298 rotateto(param_00,0.35,0.1,0.1);
}

//Function Number: 28
water_trap_movement()
{
	var_00 = randomfloatrange(6,7);
	var_01 = var_00 * 0.3;
	var_02 = var_00 * 0.05;
	var_03 = getent("ship_tilting_trap_org","targetname");
	self.damagetrigger enablelinkto();
	self.damagetrigger method_8449(var_03);
	for(;;)
	{
		var_04 = level common_scripts\utility::func_A715("ship_tilting_starboard","ship_tilting_port");
		wait(var_00 * 0.2);
		switch(var_04)
		{
			case "ship_tilting_starboard":
				var_03 moveto((-216,1968,-296),var_00,var_01,var_02);
				break;
	
			case "ship_tilting_port":
				var_03 moveto((312,1968,-296),var_00,var_01,var_02);
				break;
		}
	}
}

//Function Number: 29
water_trap_damage()
{
	self.var_565F = 1;
	self.vfxplane method_805B();
	level thread common_scripts\_exploder::func_88E(210);
	thread water_trap_damage_zombies();
	thread water_trap_damage_players();
	common_scripts\utility::knock_off_battery("cooldown","no_power","ready","deactivate");
	self.vfxplane method_805C();
	self.var_565F = 0;
	level thread common_scripts\_exploder::func_2A6D(210,undefined,1);
}

//Function Number: 30
water_trap_damage_zombies()
{
	while(self.var_565F)
	{
		var_00 = lib_0547::func_408F();
		foreach(var_02 in var_00)
		{
			if(var_02 istouching(self.damagetrigger))
			{
				var_03 = gettime();
				if(isalive(var_02) && var_02.var_BA4 != "traverse")
				{
					if(!isdefined(var_02.waszappedlast) || isdefined(var_02.waszappedlast) && var_03 > var_02.waszappedlast + 500)
					{
						if(var_02 lib_0547::func_580A())
						{
							var_02 dodamage(var_02.var_BC * 0.1,self.var_116,level.trapwater,level.trapwater,"MOD_ENERGY","trap_zm_mp");
						}
						else
						{
							var_02 thread maps\mp\zombies\_zombies_traps::mark_electrified();
							var_02 dodamage(var_02.var_FB * 0.25,self.var_116,level.trapwater,level.trapwater,"MOD_ENERGY","trap_zm_mp");
							if(!isdefined(var_02.hitbytrap))
							{
								foreach(var_05 in level.var_744A)
								{
									var_05 maps/mp/gametypes/zombies::func_47C7("kill_trap");
									var_02.hitbytrap = 1;
								}
							}
						}

						if(isalive(var_02))
						{
							var_02.waszappedlast = gettime();
						}
					}

					wait 0.05;
				}
			}
		}

		wait(0.15);
	}
}

//Function Number: 31
water_trap_damage_players()
{
	while(self.var_565F)
	{
		foreach(var_01 in level.var_744A)
		{
			if(!isalive(var_01))
			{
				continue;
			}

			if(lib_0547::func_577E(var_01))
			{
				continue;
			}

			var_02 = gettime();
			if(!isdefined(var_01.waszappedlast))
			{
				var_01.waszappedlast = gettime();
			}

			if(var_01 istouching(self.damagetrigger))
			{
				if(isalive(var_01) && !lib_0547::func_577E(var_01) && var_02 > var_01.waszappedlast + 500)
				{
					var_01 lib_0378::func_8D74("water_trap_damage_player");
					var_01 dodamage(5,self.var_116,undefined,undefined,"MOD_ENERGY");
					var_01.waszappedlast = gettime();
					wait 0.05;
				}
			}
		}

		wait(0.15);
	}
}

//Function Number: 32
___________________sinking___________________()
{
}

//Function Number: 33
sinking_init()
{
	level.kpishouldchain = 1;
	thread sinking_vo();
	level.keypointinteractholdtime = 4;
	var_00 = common_scripts\utility::func_46B7("sinking_vfx_struct","targetname");
	var_01 = getentarray("keypoint_interact_trigger","targetname");
	foreach(var_03 in var_00)
	{
		var_03.interacttrigger = common_scripts\utility::func_4461(var_03.var_116,var_01);
		var_03.interacttrigger.var_3F76 = spawn("script_model",var_03.var_116);
		var_03.interacttrigger.var_3F76 setmodel("tag_origin");
		var_03.interacttrigger.var_3F76.var_1D = var_03.var_1D;
		var_03.interacttrigger thread sinking_init_leak_vfx();
		var_03.interacttrigger lib_0378::func_8D74("aud_repair_leaking_water");
		var_03.interacttrigger thread sinking_waitfor_interact_complete();
	}
}

//Function Number: 34
sinking_init_leak_vfx()
{
	while(!isdefined(self.var_565F) || !self.var_565F)
	{
		wait(1);
	}

	switch(self.var_8260)
	{
		case "sinking_vfx_water":
			playfxontag(level.var_611["zmb_dnk_water_busted_pipe"],self.var_3F76,"tag_origin");
			break;

		case "sinking_vfx_metal":
			playfxontag(level.var_611["zmb_dnk_water_busted_pipe_metal"],self.var_3F76,"tag_origin");
			break;

		default:
			break;
	}
}

//Function Number: 35
sinking_waitfor_interact_complete()
{
	level endon("sg_obj_timeout");
	self waittill("interact_completed");
	killfxontag(level.var_611["water_jet"],self.var_3F76,"tag_origin");
	if(isdefined(self.var_3F76))
	{
		self.var_3F76 delete();
	}
}

//Function Number: 36
___________________visions____________________()
{
}

//Function Number: 37
visions_init()
{
	maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("visions",::visions_run,120,1,0);
}

//Function Number: 38
visions_run(param_00)
{
	thread maps\mp\_utility::func_6F74(::visions_state_apply,undefined,"kill_visions_threads");
	thread maps\mp\_utility::func_6F74(::visions_end,undefined,"kill_visions_threads");
	thread visions_vo();
	thread visions_fake_zombie_spawn();
	thread visions_footprints_logic(1);
	var_01 = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_difficulty_setting("dnk_ext_visions_count");
	var_02 = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_player_level_extension");
	var_01 = int(var_01 * var_02);
	lib_0547::func_7BA9(::maps/mp/zombies/sg_events_v1/extermination::exterminationkillcounter);
	level thread maps/mp/zombies/sg_events_v1/extermination::notify_on_extermination_kill_requirement(var_01);
	var_03 = common_scripts\utility::func_A70E(level,"sg_obj_timeout",level,"round complete",level,"extermination complete");
	var_04 = var_03[0];
	var_05 = var_03[1];
	lib_0547::func_2D8C(::maps/mp/zombies/sg_events_v1/extermination::exterminationkillcounter);
	if(var_04 == "sg_obj_timeout")
	{
		return 0;
	}

	return 1;
}

//Function Number: 39
visions_fake_zombie_spawn(param_00,param_01,param_02)
{
	level endon("stop_fake_zombie_spawning");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_00))
	{
		param_00 = 100;
	}

	if(common_scripts\utility::func_562E(param_01))
	{
		level endon("round complete");
		level endon("sg_obj_end");
		level endon("sg_obj_timeout");
	}

	if(isdefined(param_02))
	{
		level endon(param_02);
	}

	for(;;)
	{
		level waittill("spawned_agent",var_03);
		if(isdefined(var_03) && function_01EF(var_03))
		{
			if(var_03.var_A4B == "zombie_generic" || var_03.var_A4B == "zombie_berserker")
			{
				var_04 = randomint(100);
				if(var_04 < param_00)
				{
					var_03 visions_fake_zombie_setup();
				}
			}
		}
	}
}

//Function Number: 40
visions_fake_zombie_setup()
{
	var_00 = self;
	var_00 thread visions_fake_zombie_visibility_cycle();
}

//Function Number: 41
visions_fake_zombie_poof_radius_think()
{
	self endon("death");
	var_00 = self;
	for(;;)
	{
		foreach(var_02 in level.var_744A)
		{
			var_03 = distancesquared(var_00.var_116,var_02.var_116);
			if(var_03 < 30000 && common_scripts\utility::func_AA4A(var_02 geteye(),var_02 geteyeangles(),var_00.var_116,cos(80)))
			{
				var_00.var_1DEB = 1;
				var_00 thread hallucination_poof_fx();
				wait(0.25);
				var_00 lib_056D::func_5A86();
			}
		}

		wait 0.05;
	}
}

//Function Number: 42
visions_fake_zombie_visibility_cycle()
{
	self endon("death");
	var_00 = self;
	var_01 = 1;
	var_02 = 3;
	var_03 = 2;
	var_04 = 5;
	for(;;)
	{
		foreach(var_06 in level.var_744A)
		{
			var_07 = distancesquared(var_00.var_116,var_06.var_116);
			if(var_07 > 30000)
			{
				var_00 thread hallucination_poof_fx();
				wait(0.1);
				var_00 method_805C();
				var_00.hiddenbyvisions = 1;
				var_00.isinvisiblevisionzombie = 1;
				wait(randomfloatrange(var_01,var_02));
				var_00 method_805B();
				wait 0.05;
				var_00 thread hallucination_poof_fx();
				var_00.hiddenbyvisions = 0;
				var_00.isinvisiblevisionzombie = 0;
				wait(randomfloatrange(var_03,var_04));
			}
		}

		wait 0.05;
	}
}

//Function Number: 43
visions_footprints_logic(param_00)
{
	if(common_scripts\utility::func_562E(param_00))
	{
		level endon("round complete");
		level endon("sg_obj_end");
		level endon("sg_obj_timeout");
	}
	else
	{
		level endon("stop_fake_zombie_spawning");
	}

	var_01 = getent("ship_tilting_trap_damage_trig","targetname");
	var_02 = getentarray("footsteps_trigger","targetname");
	var_02 = common_scripts\utility::func_F6F(var_02,var_01);
	for(;;)
	{
		var_03 = lib_0547::func_408F();
		foreach(var_05 in var_03)
		{
			if(isalive(var_05) && var_05.var_BA4 != "traverse" && common_scripts\utility::func_562E(var_05.hiddenbyvisions))
			{
				foreach(var_07 in var_02)
				{
					if(var_05 istouching(var_07))
					{
						var_08 = common_scripts\utility::func_348B(var_05.var_116);
						switch(var_07.var_165)
						{
							case "snow":
								playfx(level.var_611["snow_chunk_impact"],var_08);
								break;
	
							case "water":
								playfx(level.var_611["water_splash_small"],var_08);
								break;
						}

						break;
					}
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 44
visions_state_apply()
{
	thread maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::altered_state_apply(1);
}

//Function Number: 45
visions_end()
{
	level common_scripts\utility::knock_off_battery("sg_obj_end","sg_obj_timeout");
	self notify("altered_state_end");
	maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::altered_state_end_overlay(1);
	level notify("kill_visions_threads");
}

//Function Number: 46
______floating_objects______()
{
}

//Function Number: 47
floating_object_run()
{
	level endon("altered_state_end");
	var_00 = common_scripts\utility::func_46B7("floating_object_struct","script_noteworthy");
	var_01 = ["whale","rideauSwim","rideauEmote","jackHead","brennerHead","monkHead","truck","raft","body"];
	var_02 = randomintrange(6,14);
	for(;;)
	{
		var_03 = spawnstruct();
		var_03.var_186 = common_scripts\utility::func_7A33(var_00);
		var_04 = var_03.var_186.var_116[0] + randomintrange(-50,50);
		var_05 = var_03.var_186.var_116[1] + randomintrange(-50,50);
		var_06 = var_03.var_186.var_116[2] + randomintrange(-150,150);
		var_03.var_9087 = (var_04,var_05,var_06);
		var_03.objectname = common_scripts\utility::func_7A33(var_01);
		thread floating_object_spawn_object(var_03);
		wait(var_02);
	}
}

//Function Number: 48
floating_object_spawn_object(param_00)
{
	level endon("altered_state_end");
	param_00.modelorigin = spawn("script_origin",param_00.var_9087);
	var_01 = common_scripts\utility::func_46B5(param_00.var_186.var_1A2,"targetname");
	var_02 = undefined;
	switch(param_00.objectname)
	{
		case "whale":
			param_00.objectmodel = spawn("script_model",param_00.var_9087);
			param_00.objectmodel setmodel("zmi_dead_whale_01");
			var_02 = 1;
			break;

		case "rideauSwim":
			param_00.objectmodel = spawn("script_model",param_00.var_9087);
			param_00.objectmodel setmodel("zom_rideau_wholebody");
			param_00.objectmodel scriptmodelplayanim("mp_swimming_f","rideauAnim");
			var_02 = 0;
			var_03 = vectortoangles(var_01.var_116 - param_00.var_9087);
			param_00.objectmodel.var_1D = var_03;
			break;

		case "rideauEmote":
			param_00.objectmodel = spawn("script_model",param_00.var_9087);
			param_00.objectmodel setmodel("zom_rideau_wholebody");
			var_04 = ["mp_emote_jumpingjacks_loop"];
			var_05 = common_scripts\utility::func_7A33(var_04);
			param_00.objectmodel scriptmodelplayanim(var_05,"rideauAnim");
			var_02 = 1;
			break;

		case "jackHead":
			param_00.objectmodel = spawn("script_model",param_00.var_9087);
			param_00.objectmodel setmodel("zmb_jack_in_the_box_part_01");
			var_02 = 1;
			break;

		case "brennerHead":
			param_00.objectmodel = spawn("script_model",param_00.var_9087);
			param_00.objectmodel setmodel("jfull_npc_zom_fireman_head");
			var_02 = 1;
			break;

		case "monkHead":
			param_00.objectmodel = spawn("script_model",param_00.var_9087);
			param_00.objectmodel setmodel("jp_npc_zom_monkhead");
			var_02 = 1;
			break;

		case "truck":
			param_00.objectmodel = spawn("script_model",param_00.var_9087);
			param_00.objectmodel setmodel("rblg_usa_trans_cckw_static_04_snow");
			var_02 = 1;
			break;

		case "raft":
			param_00.objectmodel = spawn("script_model",param_00.var_9087);
			param_00.objectmodel setmodel("bsh_life_raft_01_snow");
			var_02 = 1;
			break;

		case "body":
			param_00.objectmodel = spawn("script_model",param_00.var_9087);
			param_00.objectmodel setmodel("zbr_dead_soldier_bat_01");
			var_02 = 1;
			break;
	}

	var_06 = 25;
	var_07 = 30;
	var_08 = randomintrange(var_06,var_07);
	if(isdefined(param_00.objectmodel))
	{
		param_00.objectmodel method_8449(param_00.modelorigin);
		if(common_scripts\utility::func_562E(var_02))
		{
			var_09 = randomintrange(0,360);
			var_0A = randomintrange(0,360);
			var_0B = randomintrange(0,360);
			param_00.objectmodel rotateto((var_09,var_0A,var_0B),0.05);
			var_09 = randomintrange(0,360);
			var_0A = randomintrange(0,360);
			var_0B = randomintrange(0,360);
			param_00.modelorigin rotateto((var_09,var_0A,var_0B),var_08);
		}

		param_00.modelorigin moveto(var_01.var_116,var_08);
		level common_scripts\utility::func_A74B("altered_state_end",var_08);
		param_00.objectmodel thread floating_object_cleanup();
	}

	iprintlnbold(param_00.objectname);
}

//Function Number: 49
floating_object_cleanup()
{
	hallucination_poof_fx();
	self delete();
}

//Function Number: 50
___________________bomb_disposal___________________()
{
}

//Function Number: 51
bomb_disposal_init()
{
	level.keypointinteracttool = "search_dstry_bomb_defuse_mp";
	level.keypointinteracthint = &"ZOMBIE_DLC3_KEYPOINT_INTERACT_DEFUSE";
	level.keypointinteractholdtime = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_difficulty_setting("keypoint_interact_bomb_defuse_time");
	level.kpishouldchain = 1;
	thread bomb_disposal_bomb_setup();
	thread bomb_disposal_care_package_listen();
}

//Function Number: 52
bomb_disposal_bomb_setup()
{
	var_00 = getentarray("bomb_diposal_bomb","script_noteworthy");
	var_01 = getentarray("keypoint_interact_trigger","targetname");
	foreach(var_03 in var_00)
	{
		var_03.interacttrigger = common_scripts\utility::func_4461(var_03.var_116,var_01);
		var_03 thread bomb_disposal_bomb_waitfor_interact_complete();
	}
}

//Function Number: 53
bomb_disposal_bomb_waitfor_interact_complete()
{
	level endon("sg_obj_timeout");
	self.interacttrigger waittill("interact_completed");
	self delete();
}

//Function Number: 54
bomb_disposal_care_package_listen()
{
	level endon("sg_obj_timeout");
	level endon("sg_obj_end");
	var_00 = 0;
	for(;;)
	{
		foreach(var_02 in level.var_744A)
		{
			var_02.hasdisposalkit = 0;
		}

		thread bomb_disposal_care_package_drop();
		level waittill("sg_keypoint_interact_completed");
		var_00++;
		if(var_00 >= level.keypointinteractkeypoints)
		{
			break;
		}
	}
}

//Function Number: 55
bomb_disposal_care_package_drop()
{
	level endon("sg_obj_timeout");
	level endon("sg_obj_end");
	var_00 = common_scripts\utility::func_46B5("carepackage_dz","targetname");
	level.mark_next_package_as_objective_package = 1;
	maps/mp/zombies/zombie_carepackage::zm_care_spawn(common_scripts\utility::func_7A33(level.var_744A),var_00);
	var_01 = level common_scripts\utility::func_A74D("zombies_crate_captured",100);
	if(isdefined(var_01) && var_01 == "timeout")
	{
		bomb_disposal_care_package_drop();
		return;
	}

	var_00 bomb_disposal_kit_spawn();
}

//Function Number: 56
bomb_disposal_kit_spawn()
{
	var_00 = spawn("script_model",getclosestpointonnavmesh(self.var_116) + (0,0,4));
	var_00 setmodel("npc_gen_s_and_d_bomb");
	var_00 hudoutlineenable(0,0);
	var_00 lib_0547::func_AC41(&"ZOMBIE_DLC3_BOMB_DISPOSAL_BOMB_PICKUP",(0,0,16));
	var_00 thread bomb_disposal_kit_listen_for_pickup();
}

//Function Number: 57
bomb_disposal_kit_listen_for_pickup()
{
	level endon("sg_keypoint_interact_completed");
	var_00 = self;
	var_00 waittill("player_used",var_01);
	level notify("sg_keypoint_interact_bomb_pickup");
	var_00 lib_0547::func_AC40();
	var_00 delete();
	var_01.bombdisposaloldweapon = var_01 getcurrentprimaryweapon();
	var_01 lib_0586::func_78C("sg_disposal_kit_zm");
	var_01 bomb_disposal_kit_pickup();
}

//Function Number: 58
bomb_disposal_kit_pickup()
{
	var_00 = self;
	var_00.hasdisposalkit = 1;
	var_00 lib_0586::func_78E("sg_disposal_kit_zm");
	var_00 method_8326();
	var_00 method_8113(0);
	var_00 allowjump(0);
	var_00 waittill("weapon_change");
	while(var_00 method_833B())
	{
		wait 0.05;
	}

	var_00 method_8327();
	var_00 thread bomb_disposal_kit_waitfor_weapon_switch();
	var_00 thread bomb_disposal_kit_waitfor_defuse();
}

//Function Number: 59
bomb_disposal_kit_waitfor_weapon_switch()
{
	var_00 = self;
	level endon("sg_keypoint_interact_start");
	level endon("sg_keypoint_interact_incompleted");
	level endon("sg_keypoint_interact_completed");
	while(!var_00 method_833B())
	{
		wait 0.05;
	}

	var_00 notify("sg_bomb_disposal_weapon_switch");
	var_00 lib_0586::func_790("sg_disposal_kit_zm");
	var_00.hasdisposalkit = 0;
	var_00 lib_0586::func_78E(var_00.bombdisposaloldweapon);
	var_00 method_8113(1);
	var_00 allowjump(1);
	while(var_00 method_833B())
	{
		wait 0.05;
	}

	var_00 bomb_disposal_kit_spawn();
}

//Function Number: 60
bomb_disposal_kit_waitfor_defuse()
{
	var_00 = self;
	var_00 endon("sg_bomb_disposal_weapon_switch");
	var_01 = level common_scripts\utility::func_A715("sg_keypoint_interact_completed","sg_keypoint_interact_incompleted");
	if(var_01 == "sg_keypoint_interact_incompleted")
	{
		wait 0.05;
		var_00 thread bomb_disposal_kit_pickup();
		return;
	}

	if(var_01 == "sg_keypoint_interact_completed")
	{
		var_00 lib_0586::func_790("sg_disposal_kit_zm");
		var_00 lib_0586::func_78E(var_00.bombdisposaloldweapon);
		var_00 method_8113(1);
		var_00 allowjump(1);
	}
}

//Function Number: 61
___________________escape___________________()
{
}

//Function Number: 62
escape_init()
{
	var_00 = getentarray("escape_boat_cleats","script_noteworthy");
	var_01 = getent("escape_boat","targetname");
	foreach(var_03 in var_00)
	{
		var_03 linkto(var_01);
	}

	var_05 = getent("escape_boat_rack","targetname");
	var_01 method_8449(var_05,"rope_01",(0,-80,0),(0,0,0));
	var_05 method_8278("s2_zdu_ship_boat_rack_idle_down");
}

//Function Number: 63
escape_extra_run()
{
	thread escape_higgins_raise();
}

//Function Number: 64
escape_higgins_raise()
{
	var_00 = getentarray("escape_boat_cleats","script_noteworthy");
	var_01 = getent("escape_boat","targetname");
	var_02 = getent("escape_boat_rack","targetname");
	var_02 method_8278("s2_zdu_ship_boat_rack_up");
	playfxontag(level.var_611["zmb_dnk_boat_water_pull"],var_01,"tag_origin");
	var_03 = getanimlength(%s2_zdu_ship_boat_rack_up);
	var_01 lib_0378::func_8D74("escape_boat_rise",var_03);
	wait(getanimlength(%s2_zdu_ship_boat_rack_up));
	var_02 method_8278("s2_zdu_ship_boat_rack_idle_up");
	level notify("escape_ready");
}

//Function Number: 65
escape_higgins_boat_think()
{
}

//Function Number: 66
___________________defense___________________()
{
}

//Function Number: 67
defense_extra_run()
{
	thread defense_spawner_toggle();
}

//Function Number: 68
defense_spawner_toggle()
{
	common_scripts\utility::func_3C7B("dnk_defense_drop_spawner_enabled");
	level waittill("sg_obj_end");
	common_scripts\utility::func_3C8F("dnk_defense_drop_spawner_enabled");
}

//Function Number: 69
___________________audio_log___________________()
{
}

//Function Number: 70
audio_log_init()
{
	var_00 = getent("lore_primary","script_noteworthy");
	var_00.var_9D5E = getent(var_00.var_1A2,"targetname");
	var_00 method_805C();
	var_00.var_9D5E common_scripts\utility::func_9D9F();
	audio_log_listen(var_00);
}

//Function Number: 71
audio_log_listen(param_00)
{
	var_01 = getent("audio_log_hanging_model","targetname");
	var_01 setcandamage(1);
	var_01 waittill("damage");
	var_02 = param_00.var_116 - var_01.var_116;
	var_03 = sqrt(abs(var_02[2] * 2 / 800));
	var_04 = 1 / var_03;
	var_05 = var_02 * (var_04,var_04,0);
	var_01 gravitymove(var_05,var_03);
	var_01 rotateto(param_00.var_1D,var_03);
	wait(var_03);
	var_01.var_116 = param_00.var_116;
	var_01 delete();
	param_00 method_805B();
	param_00.var_9D5E common_scripts\utility::func_9DA3();
}

//Function Number: 72
___________________quest_fish___________________()
{
}

//Function Number: 73
ee_init()
{
	thread ee_vision_state_intensity_controller();
	thread ee_follow_fish_uber_wall_setup();
	thread ee_conquer_fish_setup();
	thread ee_follow_fish_uber_receiver_setup();
	thread ee_get_part_setup();
	ee_init_flags();
	lib_0557::func_786C();
	lib_0557::func_7846("quest_fish",::lib_0557::func_30D8,[],lib_0557::removed_quest_hint());
	lib_0557::func_781E("quest_fish","step_activate_gas",::ee_activate_gas,::lib_0557::func_30D8,lib_0557::removed_quest_hint());
	lib_0557::func_781E("quest_fish","step_summon_fish",::ee_summon_fish,::maps/mp/zombies/shotgun/_zombies_shotgun_exp_events::award_exp_small,lib_0557::removed_quest_hint());
	lib_0557::func_781E("quest_fish","step_follow_fish",::ee_follow_fish,::maps/mp/zombies/shotgun/_zombies_shotgun_exp_events::award_exp_small,lib_0557::removed_quest_hint());
	lib_0557::func_781E("quest_fish","step_conquer_fish",::ee_conquer_fish,::maps/mp/zombies/shotgun/_zombies_shotgun_exp_events::award_exp_smallish,lib_0557::removed_quest_hint());
	lib_0557::func_781E("quest_fish","step_get_part",::ee_get_part,::dnk_completion_rewards,lib_0557::removed_quest_hint());
	lib_0557::func_7848("quest_fish");
}

//Function Number: 74
dnk_completion_rewards()
{
	maps/mp/zombies/shotgun/_zombies_shotgun_exp_events::award_exp_med();
	foreach(var_01 in level.var_744A)
	{
		var_01 lib_056A::func_4772(1);
		var_01 thread maps\mp\gametypes\_hud_message::func_9102("zm_dlc3_ee_2_complete");
		if(function_02A3())
		{
			var_01 ae_reportcomplexgameevent(43,[5,6]);
			var_01 thread maps\mp\gametypes\_hud_message::func_9102("zm_camo_unlocked",0);
		}
	}
}

//Function Number: 75
ee_init_flags()
{
	common_scripts\utility::func_3C87("ee_activate_gas_gas_activated");
	common_scripts\utility::func_3C87("ee_activate_gas_all_players_in_visions");
	common_scripts\utility::func_3C87("ee_activate_gas_round_waited");
	common_scripts\utility::func_3C87("ee_summon_fish_all_fish_destroyed");
	common_scripts\utility::func_3C87("ee_summon_fish_round_waited");
	common_scripts\utility::func_3C87("ee_follow_fish_all_ubers_destroyed");
	common_scripts\utility::func_3C87("ship_to_void");
	common_scripts\utility::func_3C87("ee_conquer_fish_entered_void");
	common_scripts\utility::func_3C87("ee_conquer_fish_straub_complete");
	common_scripts\utility::func_3C87("flag_ee_altered_state_finished");
	common_scripts\utility::func_3C87("ee_get_part_sword_part_picked_up");
}

//Function Number: 76
ee_vision_state_intensity_controller()
{
	level endon("stop_fake_zombie_spawning");
	level waittill("ee_hallucination_intensity_increase");
	thread visions_fake_zombie_spawn(100,0,"ee_hallucination_intensity_increase");
	level waittill("ee_hallucination_intensity_increase");
	thread visions_fake_zombie_spawn(75,0,"ee_hallucination_intensity_increase");
	level waittill("ee_hallucination_intensity_increase");
	thread visions_fake_zombie_spawn(100,0,"ee_hallucination_intensity_increase");
	level waittill("ee_hallucination_intensity_increase");
}

//Function Number: 77
debug_increase_vision_state()
{
	level notify("ee_hallucination_intensity_increase");
}

//Function Number: 78
___________________step_activate_gas___________________()
{
}

//Function Number: 79
ee_activate_gas()
{
	thread ee_activate_gas_uber_think();
	common_scripts\utility::func_3C9F("ee_activate_gas_gas_activated");
	maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::register_banned_objective("dnk_ext_visions");
	thread ee_activate_gas_all_players_wait_for_visions();
	common_scripts\utility::func_3C9F("ee_activate_gas_all_players_in_visions");
	level.zmb_sg_banned_objectives = common_scripts\utility::func_F6F(level.zmb_sg_banned_objectives,"dnk_ext_visions");
	level notify("ee_hallucination_intensity_increase");
	thread wait_for_round_end("ee_activate_gas_round_waited");
	common_scripts\utility::func_3C9F("ee_activate_gas_round_waited");
	lib_0557::func_782D("quest_fish","step_activate_gas");
}

//Function Number: 80
ee_activate_gas_uber_think()
{
	var_00 = getent("ee_uberschnell_intact","script_noteworthy");
	var_01 = getent("ee_trig_dmg_uberschnell","script_noteworthy");
	for(;;)
	{
		var_01 waittill("damage",var_02,var_03,var_04,var_05,var_06);
		if(var_06 == "MELEE" || var_06 == "MOD_MELEE")
		{
			playfx(common_scripts\utility::func_44F5("zmb_dnk_uber_explode"),var_01.var_116);
			var_00 setmodel("zdu_damaged_uber_01");
			playfx(common_scripts\utility::func_44F5("zmb_dnk_uber_leak"),var_01.var_116);
			lib_0378::func_8D74("zmb_dnk_uber_leak_start",var_01.var_116);
			common_scripts\utility::func_3C8F("ee_activate_gas_gas_activated");
			break;
		}
	}

	thread maps\mp\_utility::func_6F74(::ee_activate_gas_player_grant_visions,undefined,"ee_activate_gas_all_players_in_visions");
}

//Function Number: 81
ee_activate_gas_all_players_wait_for_visions()
{
	for(;;)
	{
		var_00 = 0;
		foreach(var_02 in level.var_744A)
		{
			if(common_scripts\utility::func_562E(var_02.invisionstate))
			{
				var_00++;
			}
		}

		if(var_00 >= level.var_744A.size)
		{
			break;
		}

		wait 0.05;
	}

	thread visions_footprints_logic();
	thread maps\mp\_utility::func_6F74(::maintain_player_vision_state,undefined,"bucket_shuffle_complete");
	common_scripts\utility::func_3C8F("ee_activate_gas_all_players_in_visions");
	level notify("ee_activate_gas_all_players_in_visions");
}

//Function Number: 82
ee_activate_gas_player_grant_visions()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_01 = getent("ee_trig_dmg_uberschnell","script_noteworthy");
	while(!common_scripts\utility::func_3C77("ee_activate_gas_all_players_in_visions"))
	{
		if(!common_scripts\utility::func_562E(var_00.invisionstate))
		{
			var_02 = distancesquared(var_00.var_116,var_01.var_116);
			if(var_02 < 20000)
			{
				var_00.invisionstate = 1;
				var_00 thread maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::altered_state_apply(1);
				var_00 thread ee_activate_gas_player_visions_timeout();
				var_00 thread ee_activate_gas_player_visions_end();
			}
		}

		wait(0.25);
	}
}

//Function Number: 83
ee_activate_gas_player_visions_timeout()
{
	self endon("disconnect");
	var_00 = level common_scripts\utility::func_A74D("ee_activate_gas_all_players_in_visions",60);
	if(isdefined(var_00) && var_00 == "timeout")
	{
		self notify("ee_fish_visions_timeout");
	}
}

//Function Number: 84
ee_activate_gas_player_visions_end()
{
	self endon("disconnect");
	self waittill("ee_fish_visions_timeout");
	self notify("altered_state_end");
	if(isdefined(self.invisionstate))
	{
		self.invisionstate = 0;
	}
}

//Function Number: 85
all_players_set_visions()
{
	foreach(var_01 in level.var_744A)
	{
		var_01.invisionstate = 1;
		var_01 thread maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::altered_state_apply(1);
		var_01 thread ee_activate_gas_player_visions_end();
	}
}

//Function Number: 86
maintain_player_vision_state()
{
	level endon("bucket_shuffle_complete");
	self endon("disconnect");
	for(;;)
	{
		level waittill("player_spawned");
		if(common_scripts\utility::func_3C77("flag_ee_altered_state_finished"))
		{
			break;
		}

		if(!common_scripts\utility::func_562E(self.invisionstate))
		{
			self.invisionstate = 1;
			thread maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::altered_state_apply(1);
		}
	}
}

//Function Number: 87
warp_gas_activated()
{
	thread all_players_set_visions();
	common_scripts\utility::func_3C8F("ee_activate_gas_gas_activated");
	common_scripts\utility::func_3C8F("ee_activate_gas_all_players_in_visions");
	common_scripts\utility::func_3C8F("ee_activate_gas_round_waited");
}

//Function Number: 88
___________________step_summon_fish___________________()
{
}

//Function Number: 89
ee_summon_fish()
{
	level.fishdestroyed = 0;
	thread ee_summon_fish_setup_fish();
	thread ee_summon_fish_wait_for_all_fish();
	common_scripts\utility::func_3C9F("ee_summon_fish_all_fish_destroyed");
	thread wait_for_round_end("ee_summon_fish_round_waited");
	common_scripts\utility::func_3C9F("ee_summon_fish_round_waited");
	ee_summon_fish_special_fish_spawn();
	lib_0557::func_782D("quest_fish","step_summon_fish");
}

//Function Number: 90
ee_summon_fish_setup_fish()
{
	var_00 = common_scripts\utility::func_46B7("ee_vfx_flopping_fish","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.damagetrigger = getent(var_02.var_1A2,"targetname");
		var_02.var_3F76 = spawn("script_model",var_02.var_116);
		var_02.var_3F76 setmodel("tag_origin");
		var_02.var_3F76.var_1D = var_02.var_1D;
		var_02 thread ee_summon_fish_play_fx();
		var_02 thread ee_summon_fish_wait_for_damage();
	}
}

//Function Number: 91
ee_summon_fish_wait_for_damage()
{
	for(;;)
	{
		self.damagetrigger waittill("damage",var_00,var_01);
		if(isplayer(var_01))
		{
			break;
		}

		wait 0.05;
	}

	level.fishdestroyed++;
	self notify("Poof!");
	self.var_3F76 thread hallucination_poof_fx();
	killfxontag(level.var_611["fish_flop"],self.var_3F76,"tag_origin");
}

//Function Number: 92
ee_summon_fish_play_fx()
{
	self endon("Poof!");
	for(;;)
	{
		playfxontag(level.var_611["fish_flop"],self.var_3F76,"tag_origin");
		lib_0378::func_8D74("zmb_fish_jump",self.var_3F76);
		wait(1.1);
	}
}

//Function Number: 93
ee_summon_fish_wait_for_all_fish()
{
	var_00 = common_scripts\utility::func_46B7("ee_vfx_flopping_fish","script_noteworthy");
	while(level.fishdestroyed < var_00.size)
	{
		wait(1);
	}

	common_scripts\utility::func_3C8F("ee_summon_fish_all_fish_destroyed");
}

//Function Number: 94
ee_summon_fish_special_fish_spawn()
{
	var_00 = common_scripts\utility::func_46B5("ee_special_fish_start","script_noteworthy");
	level.specialfish = spawn("script_model",var_00.var_116);
	level.specialfish setmodel("zdu_red_herring_obj_01");
	level.specialfish.var_1D = var_00.var_1D;
	level.specialfish scriptmodelplayanim("zmb_follow_the_fish_loop",undefined,0,0.75);
	playfxontag(level.var_611["fish_energy"],level.specialfish,"tag_origin");
}

//Function Number: 95
warp_fish_summoned()
{
	thread all_players_set_visions();
	common_scripts\utility::func_3C8F("ee_summon_fish_all_fish_destroyed");
	common_scripts\utility::func_3C8F("ee_summon_fish_round_waited");
}

//Function Number: 96
___________________step_follow_fish___________________()
{
}

//Function Number: 97
ee_follow_fish()
{
	level.fishchargerequirement = 15;
	if(isdefined(level.specialfish))
	{
		level.specialfish thread ee_follow_fish_fish_think();
	}

	common_scripts\utility::func_3C9F("ee_follow_fish_all_ubers_destroyed");
	lib_0557::func_782D("quest_fish","step_follow_fish");
}

//Function Number: 98
ee_follow_fish_fish_think()
{
	var_00 = common_scripts\utility::func_46B5("ee_special_fish_start","script_noteworthy");
	var_01 = common_scripts\utility::func_46B5(var_00.var_1A2,"targetname");
	for(;;)
	{
		if(isdefined(var_01))
		{
			if(isdefined(var_01.var_165) && var_01.var_165 == "ee_follow_fish_channeling_spot")
			{
				var_02 = common_scripts\utility::func_46B7("ee_fish_uber_receiver_struct","targetname");
				var_01.uberreceiverstruct = common_scripts\utility::func_4461(var_01.var_116,var_02);
				var_01.uberreceiverstruct thread ee_follow_fish_uber_give_to_fish();
				ee_follow_fish_teleport_to_destination(var_01);
				level notify("ee_follow_fish_channel_spot_reached");
				ee_follow_fish_uber_wall_spawn();
				level waittill("ee_follow_fish_uber_given");
			}
			else
			{
				ee_follow_fish_move_to_destination(var_01);
			}

			if(isdefined(var_01.var_1A2))
			{
				var_01 = common_scripts\utility::func_46B5(var_01.var_1A2,"targetname");
			}
			else
			{
				self method_805C();
				common_scripts\utility::func_3C8F("ee_follow_fish_all_ubers_destroyed");
				break;
			}

			var_03 = 0;
			while(!var_03)
			{
				foreach(var_05 in level.var_744A)
				{
					var_06 = distancesquared(self.var_116,var_05.var_116);
					if(var_06 <= 90000)
					{
						var_03 = 1;
					}
				}

				wait 0.05;
			}
		}

		wait 0.05;
	}
}

//Function Number: 99
ee_follow_fish_move_to_destination(param_00)
{
	var_01 = 75;
	var_02 = distance(self.var_116,param_00.var_116);
	var_03 = var_02 / var_01;
	self moveto(param_00.var_116,var_03);
	self rotateto(param_00.var_1D,var_03);
	wait(var_03);
}

//Function Number: 100
ee_follow_fish_teleport_to_destination(param_00)
{
	thread hallucination_poof_fx();
	wait 0.05;
	self method_805C();
	self.var_116 = param_00.var_116;
	self.var_1D = param_00.var_1D;
	wait(2);
	self method_805B();
	param_00 thread hallucination_poof_fx();
	wait(2);
	param_00.uberreceiverstruct thread hallucination_poof_fx();
	param_00.uberreceiverstruct.receivermodel method_805B();
	param_00.uberreceiverstruct.var_241F solid();
}

//Function Number: 101
ee_follow_fish_uber_receiver_setup()
{
	var_00 = common_scripts\utility::func_46B7("ee_fish_uber_receiver_struct","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = common_scripts\utility::func_44BE(var_02.var_1A2,"targetname");
		var_02.failsafe_nodes = [];
		foreach(var_05 in var_03)
		{
			switch(var_05.var_165)
			{
				case "ee_fish_uber_use_trig":
					var_02.usetrigger = var_05;
					break;

				case "ee_fish_receiver_clip":
					var_02.var_241F = var_05;
					var_02.var_241F.var_A045 = ::ee_uber_reciever_unresolved_collide;
					var_05 notsolid();
					break;

				case "ee_fish_uber_receiver":
					var_02.receivermodel = var_05;
					var_05 method_805C();
					break;

				case "ee_fish_uber":
					var_02.var_9FE1 = var_05;
					var_05 method_805C();
					break;

				case "ee_fish_receiver_failsafe_node":
					var_02.failsafe_nodes = common_scripts\utility::func_F6F(var_02.failsafe_nodes,var_05);
					break;
			}
		}

		if(isdefined(var_02.var_241F) && isdefined(var_02.failsafe_nodes) && var_02.failsafe_nodes.size > 0)
		{
			var_02.var_241F.my_uber_struct = var_02;
		}
	}
}

//Function Number: 102
ee_uber_reciever_unresolved_collide(param_00)
{
	self.var_A048 = ee_uber_reciever_get_unresolved_collision_locs(self.my_uber_struct,param_00);
	maps\mp\_movers::func_A047(param_00,0);
}

//Function Number: 103
ee_uber_reciever_get_unresolved_collision_locs(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00.failsafe_nodes) && isarray(param_00.failsafe_nodes))
	{
		var_02 = common_scripts\utility::func_F73(var_02,param_00.failsafe_nodes);
	}

	if(isdefined(level.var_9068.var_9090) && isarray(level.var_9068.var_9090))
	{
		var_02 = common_scripts\utility::func_F73(var_02,level.var_9068.var_9090);
	}

	return var_02;
}

//Function Number: 104
ee_follow_fish_uber_wall_setup()
{
	level.uberbuys = common_scripts\utility::func_46B7("ee_uber_wall_buy_struct","targetname");
	foreach(var_01 in level.uberbuys)
	{
		var_02 = getentarray(var_01.var_1A2,"targetname");
		foreach(var_04 in var_02)
		{
			var_04 method_805C();
			if(var_04.var_165 == "ee_uber_wall_buy_box")
			{
				var_04 notsolid();
			}
		}

		var_01 thread ee_follow_fish_uber_wall_used();
	}
}

//Function Number: 105
ee_follow_fish_uber_wall_used()
{
	self waittill("ee_follow_fish_uber_purchased");
	thread hallucination_poof_fx();
	var_00 = getentarray(self.var_1A2,"targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 106
ee_follow_fish_uber_wall_spawn()
{
	var_00 = common_scripts\utility::func_7A33(level.uberbuys);
	level.uberbuys = common_scripts\utility::func_F93(level.uberbuys,var_00);
	var_01 = getentarray(var_00.var_1A2,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 method_805B();
		switch(var_03.var_165)
		{
			case "ee_uber_wall_use_trig":
				var_00.usetrigger = var_03;
				var_00 thread ee_follow_fish_uber_wall_think();
				break;

			case "ee_uber_wall_buy_box":
				var_00.wallbox = var_03;
				break;

			case "ee_uber_wall_buy_uber":
				var_00.var_9FE1 = var_03;
				break;

			default:
				break;
		}
	}

	if(isdefined(var_00.usetrigger))
	{
		var_05 = lib_0552::func_7BE1(undefined,var_00.usetrigger);
		var_05.var_4028 = lib_0552::func_44FF("dnk_uber_interact");
		var_05.var_401E = 3000;
	}
}

//Function Number: 107
ee_follow_fish_uber_wall_think()
{
	var_00 = self.usetrigger;
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(var_01.var_62D6 >= 3000)
		{
			var_01 maps/mp/gametypes/zombies::func_90F5(3000);
			var_01 lib_0585::func_8555(undefined);
			self notify("ee_follow_fish_uber_purchased");
			break;
		}
	}
}

//Function Number: 108
ee_follow_fish_uber_pickup()
{
	var_00 = self;
	var_00.uberwalloldweapon = var_00 getcurrentprimaryweapon();
	if(!var_00 hasweapon("blimp_battery_zm"))
	{
		var_00 lib_0586::func_78C("blimp_battery_zm");
	}

	var_00 lib_0586::func_78E("blimp_battery_zm");
	var_00 method_8326();
	var_00 method_8113(0);
	var_00 allowjump(0);
	var_00 waittill("weapon_change");
	while(var_00 method_833B())
	{
		wait 0.05;
	}

	var_00 method_8327();
	var_00.hasuber = 1;
	var_00 thread ee_follow_fish_uber_drop();
}

//Function Number: 109
ee_follow_fish_uber_drop(param_00)
{
	level endon("ee_follow_fish_uber_given_start");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = self;
	while(!var_01 method_833B())
	{
		wait 0.05;
	}

	var_01 lib_0586::func_790("blimp_battery_zm");
	var_01 lib_0586::func_78E(var_01.uberwalloldweapon);
	var_01 method_8113(1);
	var_01 allowjump(1);
	var_01.hasuber = 0;
	if(param_00)
	{
		var_01 ee_follow_fish_uber_ground_spawn();
	}
}

//Function Number: 110
ee_follow_fish_uber_ground_spawn()
{
	var_00 = spawn("script_model",getclosestpointonnavmesh(self.var_116) + (0,0,4));
	var_00 setmodel("npc_zom_uber_01");
	var_00 hudoutlineenable(0,0);
	var_00 lib_0547::func_AC41(&"ZOMBIE_DLC3_UBER_WALL_BUY_PICKUP",(0,0,16));
	var_00 waittill("player_used",var_01);
	var_00 lib_0547::func_AC40();
	var_00 delete();
	var_01 ee_follow_fish_uber_pickup();
}

//Function Number: 111
ee_follow_fish_uber_give_to_fish()
{
	var_00 = self.usetrigger;
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		var_02 = var_01 lib_0585::func_9E12();
		if(var_02)
		{
			ee_follow_fish_uber_given(var_01);
			break;
		}

		wait 0.05;
	}
}

//Function Number: 112
ee_follow_fish_uber_given(param_00)
{
	level notify("ee_follow_fish_uber_given_start");
	self.var_9FE1 method_805B();
	ee_follow_fish_uber_charge();
	wait(2);
	ee_follow_fish_uber_completed();
}

//Function Number: 113
ee_follow_fish_uber_charge()
{
	var_00 = spawn("script_model",self.var_9FE1.var_116);
	var_00 setmodel("tag_origin");
	var_00 maps/mp/mp_zombies_soul_collection::func_170B(level.fishchargerequirement,180,100,"zombie_fish_uber_killed",undefined,"tag_origin",undefined,undefined,undefined,undefined,(0,0,64));
	level.fishchargerequirement = level.fishchargerequirement + 5;
}

//Function Number: 114
ee_follow_fish_uber_completed()
{
	var_00 = randomfloatrange(2,4);
	var_01 = common_scripts\utility::func_7A33(level.var_744A);
	if(isdefined(var_01))
	{
		level thread ee_follow_fish_earthquake(var_00,var_01);
	}

	wait(2);
	playfx(common_scripts\utility::func_44F5("zmb_dnk_uber_leak"),self.var_9FE1.var_116);
	level notify("ee_hallucination_intensity_increase");
	wait(2);
	level notify("ee_follow_fish_uber_given");
}

//Function Number: 115
ee_follow_fish_earthquake(param_00,param_01)
{
	earthquake(0.4,param_00,param_01.var_116,850);
	function_01BC("tank_rumble",param_01.var_116);
	lib_0378::func_8D74("ee_follow_fish_earthquake",param_00);
	wait(param_00);
	function_01BD();
}

//Function Number: 116
debug_give_uber()
{
	ee_follow_fish_uber_completed();
}

//Function Number: 117
warp_fish_followed()
{
	thread all_players_set_visions();
}

//Function Number: 118
___________________step_conquer_fish___________________()
{
}

//Function Number: 119
ee_conquer_fish()
{
	while(!common_scripts\utility::func_562E(level.var_AC11))
	{
		wait(0.5);
	}

	if(level.var_A980 >= 9)
	{
		return;
	}

	while(level.var_A980 % 3 == 0)
	{
		wait(0.5);
	}

	while(!common_scripts\utility::func_562E(level.var_AC11))
	{
		wait(0.5);
	}

	lib_056D::func_8A6E(1);
	level.zmb_is_endless_wave = 1;
	wait(3);
	thread ee_conquer_fish_void_enter();
	common_scripts\utility::func_3C9F("ee_conquer_fish_entered_void");
	thread ee_conquer_fish_void_setup();
	common_scripts\utility::func_3C9F("ee_conquer_fish_straub_complete");
	thread ee_conquer_fish_bucket_shuffle_init();
	ee_conquer_fish_bucket_shuffle_completion();
	lib_0557::func_782D("quest_fish","step_conquer_fish");
}

//Function Number: 120
ee_conquer_fish_setup()
{
	var_00 = getent("ee_conquer_fish_water_plane","script_noteworthy");
	var_00 method_805C();
	level.numbucketshuffleassassins = 0;
}

//Function Number: 121
ee_conquer_fish_void_enter()
{
	if(common_scripts\utility::func_3C77("ee_conquer_fish_entered_void"))
	{
		return;
	}

	lib_0378::func_8D74("ctf_void_enter");
	foreach(var_01 in level.var_744A)
	{
		thread lib_0547::func_9E9(var_01,"void_fading");
		var_01 thread ee_conquer_fish_void_enter_fade();
	}

	level waittill("ee_conquer_fish_enter_void_fading");
	level notify("stop_fake_zombie_spawning");
	if(isdefined(level.all_drop_crates) && level.all_drop_crates.size > 0)
	{
		foreach(var_04 in level.all_drop_crates)
		{
			var_04 hudoutlinedisableforclients(level.var_744A);
		}
	}

	level.groundrefent rotateto((0,0,0),0.05);
	common_scripts\utility::func_3C7B("flag_ship_tilting_enabled");
	var_06 = common_scripts\utility::func_46B7("ee_bucket_shuffle_tp_to_void","targetname");
	for(var_07 = 0;var_07 < level.var_744A.size;var_07++)
	{
		level.var_744A[var_07] setorigin(var_06[var_07].var_116);
		level.var_744A[var_07] setangles(var_06[var_07].var_1D);
		thread lib_0547::func_7CF8(level.var_744A[var_07],"void_fading");
	}

	var_08 = lib_0547::func_408F();
	foreach(var_0A in var_08)
	{
		var_0A lib_056D::func_5A86();
	}

	level.var_ABD3 = -10000;
	common_scripts\utility::func_3C8F("ship_to_void");
	level.zmb_locked_spawn_zones = ["zone_the_void"];
	common_scripts\utility::func_3C8F("ee_conquer_fish_entered_void");
}

//Function Number: 122
ee_conquer_fish_void_enter_fade()
{
	var_00 = self;
	if(!isdefined(var_00.entervoidoverlayfade))
	{
		var_00.entervoidoverlayfade = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::altered_state_create_client_overlay("black",0,var_00);
	}

	var_01 = 4;
	var_02 = 1;
	var_00.entervoidoverlayfade.var_18 = 0;
	var_00.entervoidoverlayfade fadeovertime(var_01);
	var_00.entervoidoverlayfade.var_18 = 1;
	var_00 shellshock("zm_dnk_void_fade",var_01);
	wait(var_01);
	level notify("ee_conquer_fish_enter_void_fading");
	var_00.entervoidoverlayfade.var_18 = 1;
	var_00.entervoidoverlayfade fadeovertime(var_02);
	var_00.entervoidoverlayfade.var_18 = 0;
	lib_0378::func_8D74("zmb_dnk_uber_leak_stop");
}

//Function Number: 123
ee_conquer_fish_void_setup()
{
	var_00 = getentarray("ee_conquer_fish_platform","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::func_4CEB();
	}

	var_04 = getentarray("ee_conquer_fish_vignette_prop","targetname");
	foreach(var_06 in var_04)
	{
		var_06 method_805C();
		var_06 notsolid();
	}

	var_08 = getentarray("ee_conquer_fish_straub_clip","targetname");
	foreach(var_0A in var_08)
	{
		var_0A notsolid();
	}

	var_0C = getentarray("trig_ee_conquer_fish_spawn_platform","targetname");
	foreach(var_0E in var_0C)
	{
		var_0E thread ee_conquer_fish_void_platform_think();
	}

	thread ee_conquer_fish_void_platform_vignette_think();
	var_10 = getentarray("vol_ee_conquer_fish_straub_platform","targetname");
	foreach(var_12 in var_10)
	{
		var_12 thread ee_conquer_fish_void_straub_vignette_init();
	}

	level.voidfallteleportlocations = common_scripts\utility::func_46B7("void_tp_platform_start","targetname");
	thread ee_conquer_fish_void_fall_teleport();
}

//Function Number: 124
ee_conquer_fish_void_fall_teleport()
{
	var_00 = getent("void_falling_teleport_trigger","targetname");
	var_01 = 0;
	for(;;)
	{
		var_00 waittill("trigger",var_02);
		if(isplayer(var_02) && isalive(var_02))
		{
			var_02 setorigin(level.voidfallteleportlocations[var_01].var_116);
			var_01++;
			if(var_01 >= level.voidfallteleportlocations.size)
			{
				var_01 = 0;
			}

			var_02 thread ee_conquer_fish_void_fall_damage();
		}
	}
}

//Function Number: 125
ee_conquer_fish_void_fall_damage()
{
	while(!self isonground())
	{
		wait 0.05;
	}

	down_player();
}

//Function Number: 126
ee_conquer_fish_void_platform_think()
{
	var_00 = self;
	var_01 = getentarray(var_00.var_1A2,"targetname");
	var_00 waittill("trigger");
	foreach(var_03 in var_01)
	{
		var_03 thread hallucination_poof_fx();
		var_03 thread platform_fog_fx();
		var_03 common_scripts\utility::func_8BE0();
	}
}

//Function Number: 127
platform_fog_fx()
{
	var_00 = spawn("script_model",self.var_116);
	var_00 setmodel("tag_origin");
	var_00.var_1D = var_00.var_1D + (-90,0,0);
	playfxontag(level.var_611["zmb_dnk_altered_platform_mist"],var_00,"tag_origin");
}

//Function Number: 128
ee_conquer_fish_void_platform_vignette_think()
{
	common_scripts\utility::func_3C87("flag_nest_platform_complete");
	common_scripts\utility::func_3C87("flag_island_platform_complete");
	common_scripts\utility::func_3C87("flag_berlin_platform_complete");
	var_00 = getentarray("ee_conquer_fish_post_straub_platform_one","targetname");
	var_01 = getentarray("ee_conquer_fish_post_straub_platform_two","targetname");
	var_02 = getentarray("ee_conquer_fish_post_straub_platform_three","targetname");
	level waittill("ee_conquer_fish_vignette_complete");
	common_scripts\utility::func_3C8F("flag_nest_platform_complete");
	foreach(var_04 in var_00)
	{
		var_04 thread hallucination_poof_fx();
		var_04 common_scripts\utility::func_8BE0();
	}

	level waittill("ee_conquer_fish_vignette_complete");
	common_scripts\utility::func_3C8F("flag_island_platform_complete");
	foreach(var_04 in var_01)
	{
		var_04 thread hallucination_poof_fx();
		var_04 common_scripts\utility::func_8BE0();
	}

	level waittill("ee_conquer_fish_vignette_complete");
	common_scripts\utility::func_3C8F("flag_berlin_platform_complete");
	foreach(var_04 in var_02)
	{
		var_04 thread hallucination_poof_fx();
		var_04 common_scripts\utility::func_8BE0();
	}
}

//Function Number: 129
func_3D34()
{
	level endon("bucket_shuffle_complete");
	for(;;)
	{
		lib_0378::func_8D74("flare_fx");
		wait(0.75);
		level thread common_scripts\_exploder::func_88E(240);
		wait(randomintrange(5,20));
	}
}

//Function Number: 130
ee_conquer_fish_void_straub_vignette_init()
{
	var_00 = self;
	wait_until_all_players_in_volume(var_00);
	wait(1);
	var_01 = common_scripts\utility::func_46B5(var_00.var_1A2,"targetname");
	var_01 thread hallucination_poof_fx();
	var_02 = spawn("script_model",var_01.var_116);
	var_02 setmodel("zom_straub_wholebody_dlc");
	var_02.color = spawn("script_model",var_01.var_116);
	var_02.color setmodel("zom_head_kier_dirt_org1_dlc");
	var_02.color linkto(var_02,"j_spineupper",(0,0,0),(0,0,0));
	var_03 = undefined;
	switch(var_01.var_165)
	{
		case "ee_conquer_fish_straub_vignette_one":
			level.voidfallteleportlocations = common_scripts\utility::func_46B7("void_tp_platform_one","targetname");
			var_01.var_5055 = "s2_zom_straub_table_cleaver_idle";
			var_01.idleanimlength = getanimlength(%s2_zom_straub_table_cleaver_idle);
			var_01.var_9A8E = "npc_zom_med_knife_02";
			var_01.var_778F = getentarray("ee_conquer_fish_tfr_prop","script_noteworthy");
			var_01.straubvo = "zmb_dnk_stra_youmustbeklausfriendsthea2";
			var_01.straubclip = getent("ee_conquer_fish_straub_clip_one","script_noteworthy");
			var_01.straubclip solid();
			var_01 thread ee_conquer_fish_void_straub_vignette_play(var_02);
			var_04 = common_scripts\utility::func_46B7("ee_conquer_fish_tfr_zombie_spawner","targetname");
			var_01 ee_conquer_fish_void_straub_event(var_02,var_04,15,"zombie_heavy");
			break;

		case "ee_conquer_fish_straub_vignette_two":
			level.voidfallteleportlocations = common_scripts\utility::func_46B7("void_tp_platform_two","targetname");
			level thread common_scripts\_exploder::func_88E(203);
			var_01.var_5055 = "s2_zom_straub_window_gaze_idle";
			var_01.idleanimlength = getanimlength(%s2_zom_straub_window_gaze_idle);
			var_01.var_9A8E = undefined;
			var_01.var_778F = undefined;
			var_01.straubvo = "zmb_dnk_stra_soyousurvivedthehellofmit_delay";
			var_01.straubclip = getent("ee_conquer_fish_straub_clip_two","script_noteworthy");
			var_01.straubclip solid();
			var_01 thread ee_conquer_fish_void_straub_vignette_play(var_02);
			var_04 = common_scripts\utility::func_46B7("ee_conquer_fish_tds_zombie_spawner","targetname");
			var_01 ee_conquer_fish_void_straub_event(var_02,var_04,20,"zombie_assassin");
			maps/mp/gametypes/zombies::func_DB9(level.var_744A[0],1);
			break;

		case "ee_conquer_fish_straub_vignette_three":
			level.voidfallteleportlocations = common_scripts\utility::func_46B7("void_tp_platform_three","targetname");
			level thread common_scripts\_exploder::func_88E(220);
			thread func_3D34();
			var_01.var_5055 = "s2_zom_straub_death_straub";
			var_01.idleanimlength = getanimlength(%s2_zom_straub_death_straub);
			var_01.exitanim = "s2_zom_straub_window_gaze_exit_2";
			var_01.exitanimlength = getanimlength(%s2_zom_straub_window_gaze_exit_2);
			var_01.var_9A8E = undefined;
			var_01.var_778F = getentarray("ee_conquer_fish_vignette_three_prop","script_noteworthy");
			var_01.straubvo = "zmb_dnk_stra_vidlog_straubdeath1";
			var_01.straubvotwo = "zmb_dnk_stra_vidlog_straubdeath2";
			var_01.straubclip = getent("ee_conquer_fish_straub_clip_three","script_noteworthy");
			var_01.straubclip solid();
			var_01.straubclip method_8449(var_02);
			var_01 thread ee_conquer_fish_void_straub_vignette_play(var_02,1);
			var_04 = common_scripts\utility::func_46B7("ee_conquer_fish_tst_zombie_spawner","targetname");
			var_01 ee_conquer_fish_void_straub_event(var_02,var_04,25,"zombie_sizzler");
			common_scripts\utility::func_3C8F("ee_conquer_fish_straub_complete");
			break;
	}

	level notify("ee_conquer_fish_vignette_complete");
}

//Function Number: 131
ee_conquer_fish_void_straub_vignette_play(param_00,param_01)
{
	level endon("ee_conquer_fish_straub_vignette_intro_complete");
	var_02 = self;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(var_02.var_9A8E))
	{
		var_03 = spawn("script_model",var_02.var_116);
		var_03 setmodel(var_02.var_9A8E);
		var_03 linkto(param_00,"TAG_WEAPON_RIGHT",(0,0,0),(0,0,0));
		var_02.var_9A8E = var_03;
	}

	if(isdefined(var_02.var_778F))
	{
		foreach(var_05 in var_02.var_778F)
		{
			var_05 thread hallucination_poof_fx();
			var_05 method_805B();
		}
	}

	if(param_01)
	{
		var_02 thread ee_conquer_fish_void_straub_final_vignette_zombies();
	}

	param_00 method_8495(var_02.var_5055,var_02.var_116,var_02.var_1D);
	param_00.color method_8495(var_02.var_5055,var_02.var_116,var_02.var_1D);
	var_02 ee_conquer_fish_void_straub_vignette_vo(param_00);
	if(param_01)
	{
		foreach(var_08 in level.straub_vignette_zombie)
		{
			if(isdefined(var_08))
			{
				var_08 thread hallucination_poof_fx();
				var_08 delete();
			}
		}

		var_02 ee_conquer_fish_void_straub_final_vignette(param_00);
	}

	if(isdefined(var_02.straubclip))
	{
		var_02.straubclip notsolid();
	}

	level notify("ee_conquer_fish_straub_vignette_intro_complete");
}

//Function Number: 132
ee_conquer_fish_void_straub_vignette_vo(param_00)
{
	level endon("ee_conquer_fish_straub_vignette_intro_complete");
	var_01 = spawn("script_model",param_00.var_116);
	if(isdefined(self.straubvo))
	{
		maps/mp/mp_zombie_berlin_aud::pa_system_dialogue_all_players(self.straubvo,"interior",0,var_01);
	}

	if(isdefined(self.straubvotwo))
	{
		maps/mp/mp_zombie_berlin_aud::pa_system_dialogue_all_players(self.straubvotwo,"interior",0,var_01);
	}
}

//Function Number: 133
ee_conquer_fish_void_straub_event(param_00,param_01,param_02,param_03)
{
	level endon("ee_conquer_fish_straub_event_complete");
	var_04 = 1;
	var_05 = 3;
	var_06 = 0;
	var_07 = undefined;
	maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::add_difficulty_setting("Straub Combat Spawn Rate Max","ee_conquer_fish_spawn_rate_max",var_05,var_05 / 2,1,1);
	maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::add_difficulty_setting("Straub Combat Total Zombies","ee_conquer_fish_total_zombies",param_02,param_02 * 2,1,1);
	var_05 = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_difficulty_setting("ee_conquer_fish_spawn_rate_max");
	param_02 = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_difficulty_setting("ee_conquer_fish_total_zombies");
	level waittill("ee_conquer_fish_straub_vignette_intro_complete");
	param_00 thread hallucination_poof_fx();
	param_00 delete();
	param_00.color delete();
	if(isdefined(self.var_9A8E))
	{
		self.var_9A8E delete();
	}

	if(isdefined(self.var_778F))
	{
		foreach(var_09 in self.var_778F)
		{
			var_09 thread hallucination_poof_fx();
			var_09 delete();
		}
	}

	var_0B = undefined;
	if(lib_0547::func_5565(param_03,"zombie_assassin"))
	{
		self.asssassinspawn = 1;
		var_0C = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_health");
		var_0B = maps/mp/zombies/zombie_assassin_basic::spawn_an_assassin(undefined,var_0C,self);
		var_0B.assassinmustneverleave = 1;
		var_0B.optionaldisablefogsensitivity = 1;
		var_0B.optionaldisablecrouchedambush = 1;
		var_0B.optionaldisableexits = 1;
	}
	else
	{
		self.asssassinspawn = 0;
		var_0B = lib_054D::func_90BA(param_03,self,"straub_void_event_straub",0,0,0);
	}

	var_0B thread hallucination_poof_fx();
	var_0B lib_0547::func_84CB();
	while(var_06 < param_02)
	{
		var_0D = var_04;
		if(var_05 > var_04)
		{
			var_0D = randomfloatrange(var_04,var_05);
		}

		wait(var_0D);
		for(;;)
		{
			var_0E = common_scripts\utility::func_7A33(param_01);
			if(isdefined(var_07) && var_0E == var_07)
			{
				continue;
			}
			else
			{
				break;
			}
		}

		var_07 = var_0E;
		var_0F = "zombie_generic";
		var_10 = lib_054D::func_90BA(var_0F,var_0E,"straub_void_event",0,1,0);
		var_10 thread hallucination_poof_fx();
		var_10 lib_0547::func_84CB();
		var_06++;
	}

	for(;;)
	{
		var_11 = lib_0547::func_408F();
		if(var_11.size < 1)
		{
			break;
		}

		wait 0.05;
	}

	level notify("ee_conquer_fish_straub_event_complete");
}

//Function Number: 134
ee_conquer_fish_void_straub_final_vignette(param_00)
{
	var_01 = self;
	foreach(var_03 in level.var_744A)
	{
		lib_0378::func_8D74("straub_laugh_hallucination",var_03);
	}

	param_00 thread ee_conquer_fish_void_straub_final_vignette_flicker();
	foreach(var_03 in level.var_744A)
	{
		var_03 thread lib_055B::func_598A();
		var_03 shellshock("zm_dig_altered",var_01.exitanimlength);
		var_03 method_8036(1.5,1);
		var_03 common_scripts\utility::func_2CBE(var_01.exitanimlength,::method_8036,1.2,1);
	}

	param_00 scriptmodelclearanim();
	param_00.color scriptmodelclearanim();
	param_00 method_8495(var_01.exitanim,var_01.var_116,var_01.var_1D + (0,-90,0));
	param_00.color method_8495(var_01.exitanim,var_01.var_116,var_01.var_1D + (0,-90,0));
	wait(var_01.exitanimlength);
	level notify("straub_flicker_stop");
}

//Function Number: 135
ee_conquer_fish_void_straub_final_vignette_zombies()
{
	var_00 = self;
	for(var_01 = 0;var_01 < 8;var_01++)
	{
		level.straub_vignette_zombie[var_01] = spawn("script_model",var_00.var_116);
		level.straub_vignette_zombie[var_01] setmodel("zom_infantrya_bodywhole");
		level.straub_vignette_zombie[var_01].animation_name = "s2_zom_straub_death_zom_0" + common_scripts\utility::func_9AAD(var_01 + 1);
		level.straub_vignette_zombie[var_01].idle_anim_name = "s2_zom_straub_death_end_zom_0" + common_scripts\utility::func_9AAD(var_01 + 1);
		level.straub_vignette_zombie[var_01].color = spawn("script_model",var_00.var_116);
		level.straub_vignette_zombie[var_01].color setmodel(common_scripts\utility::func_7A33(["zom_head_fdr02_org1","zom_head_fdr03_org1","zom_head_fdr04_org1"]));
		level.straub_vignette_zombie[var_01].color linkto(level.straub_vignette_zombie[var_01],"j_spineupper",(0,0,0),(0,0,0));
		level.straub_vignette_zombie[var_01] method_8495(level.straub_vignette_zombie[var_01].animation_name,var_00.var_116,var_00.var_1D);
		level.straub_vignette_zombie[var_01].color method_8495(level.straub_vignette_zombie[var_01].animation_name,var_00.var_116,var_00.var_1D);
	}
}

//Function Number: 136
ee_conquer_fish_void_straub_final_vignette_flicker()
{
	level endon("straub_flicker_stop");
	for(;;)
	{
		wait(randomfloatrange(0.01,0.05));
		if(isdefined(self))
		{
			self method_805C();
		}

		if(isdefined(self.color))
		{
			self.color method_805C();
		}

		wait(randomfloatrange(0.01,0.05));
		if(isdefined(self))
		{
			self method_805B();
		}

		if(isdefined(self.color))
		{
			self.color method_805B();
		}
	}
}

//Function Number: 137
ee_conquer_fish_bucket_shuffle_init()
{
	level endon("bucket_shuffle_complete");
	level.bucketfish = getent("ee_bucket_shuffle_fish","targetname");
	level.bucketfish scriptmodelplayanim("zmb_follow_the_fish_loop",undefined,0,0.75);
	thread ee_conquer_fish_bucket_shuffle_fish_float();
	var_00 = getent("vol_ee_conquer_fish_bucket_shuffle_platform","targetname");
	wait_until_all_players_in_volume(var_00);
	level.voidfallteleportlocations = common_scripts\utility::func_46B7("void_tp_platform_final","targetname");
	wait(1);
	level.allbuckets = [];
	level thread maps\mp\_utility::func_6F74(::ee_conquer_fish_bucket_missile_listen,undefined,"bucket_shuffle_complete");
	var_01 = 1;
	for(;;)
	{
		var_02 = ee_conquer_fish_bucket_shuffle_setup_buckets(var_01);
		var_03 = ee_conquer_fish_bucket_shuffle_run(var_01,var_02);
		if(common_scripts\utility::func_562E(var_03))
		{
			var_01++;
		}

		wait(3);
	}
}

//Function Number: 138
ee_conquer_fish_bucket_shuffle_fish_float()
{
	level endon("ee_bucket_shuffle_start");
	for(;;)
	{
		level.bucketfish movez(8,2);
		wait(2);
		level.bucketfish movez(-8,2);
		wait(2);
	}
}

//Function Number: 139
ee_conquer_fish_bucket_shuffle_setup_buckets(param_00)
{
	level notify("ee_bucket_shuffle_start");
	var_01 = common_scripts\utility::func_46B7("ee_bucket_shuffle_bucket","targetname");
	var_02 = 3;
	if(param_00 >= 1)
	{
		var_02 = 3;
	}

	if(param_00 >= 2)
	{
		var_02 = 5;
	}

	if(param_00 >= 3)
	{
		var_02 = 8;
	}

	var_03 = [];
	var_04 = var_01;
	level.allbuckets = [];
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		var_06 = common_scripts\utility::func_7A33(var_04);
		var_04 = common_scripts\utility::func_F93(var_04,var_06);
		var_07 = spawn("script_model",var_06.var_116);
		var_07 setmodel("zdu_water_bucket_01");
		var_07 thread hallucination_poof_fx(0);
		playfxontag(common_scripts\utility::func_44F5("zmb_dnk_bucket_sparks"),var_07,"tag_origin");
		var_07 setcandamage(1);
		var_03 = common_scripts\utility::func_F6F(var_03,var_07);
		level.allbuckets = common_scripts\utility::func_F6F(level.allbuckets,var_07);
		wait(0.75);
	}

	level.chosenbucket = common_scripts\utility::func_7A33(var_03);
	level.chosenbucket.ischosenbucket = 1;
	if(param_00 == 1)
	{
		level.bucketfish thread hallucination_poof_fx(0);
		level.bucketfish method_805C();
	}

	level.bucketfish moveto(level.chosenbucket.var_116 + (0,6,72),0.1);
	level.bucketfish rotateto((0,0,90),0.1);
	wait(1.5);
	level.bucketfish thread hallucination_poof_fx(0);
	level.bucketfish method_805B();
	wait(0.5);
	level.bucketfish movez(5,0.2,0.1,0.1);
	wait(0.3);
	level.bucketfish movez(-64,1,0.2,0.2);
	wait(1);
	level.bucketfish thread hallucination_poof_fx(0);
	level.bucketfish method_805C();
	wait(1);
	return var_03;
}

//Function Number: 140
ee_conquer_fish_bucket_missile_listen()
{
	self endon("spawned_player");
	self endon("faux_spawn");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(isdefined(var_01))
		{
			if(issubstr(var_01,"c4") || issubstr(var_01,"bouncing_betty") || issubstr(var_01,"semtex") || issubstr(var_01,"throwingknife") || issubstr(var_01,"claymore"))
			{
				var_02 = 1;
				if(issubstr(var_01,"throwingknife"))
				{
					var_02 = 0;
				}

				var_00 thread ee_conquer_fish_bucket_watch_stuck(var_02);
			}
		}
	}
}

//Function Number: 141
ee_conquer_fish_bucket_watch_stuck(param_00)
{
	self endon("death");
	self waittill("missile_stuck",var_01);
	if(isdefined(var_01) && isdefined(level.allbuckets) && common_scripts\utility::func_F79(level.allbuckets,var_01))
	{
		wait 0.05;
		if(!function_0279(self))
		{
			if(common_scripts\utility::func_562E(param_00))
			{
				self method_81D6();
				return;
			}

			self delete();
			return;
		}
	}
}

//Function Number: 142
ee_conquer_fish_bucket_shuffle_run(param_00,param_01)
{
	level endon("bucket_shuffle_complete");
	var_02 = 1.5;
	var_03 = 1.5;
	var_04 = 6;
	var_05 = 0;
	switch(param_00)
	{
		case 1:
			var_02 = 0.7;
			var_03 = 0.8;
			var_04 = 8;
			break;

		case 2:
			var_02 = 0.5;
			var_03 = 0.6;
			var_04 = 12;
			break;

		case 3:
			var_02 = 0.4;
			var_03 = 0.5;
			var_04 = 16;
			var_05 = 1;
			break;
	}

	var_06 = common_scripts\utility::func_46B7("ee_bucket_shuffle_bucket","targetname");
	var_07 = 0;
	while(var_07 < var_04)
	{
		var_08 = var_06;
		foreach(var_0A in param_01)
		{
			var_0B = common_scripts\utility::func_7A33(var_08);
			var_08 = common_scripts\utility::func_F93(var_08,var_0B);
			lib_0378::func_8D74("ctf_bucket_move",var_0A,var_02);
			var_0A moveto(var_0B.var_116,var_02);
			var_0A thread ee_conquer_fish_bucket_wait_for_damage();
		}

		var_07++;
		wait(var_03);
	}

	level notify("buckets_shuffled");
	var_0D = level common_scripts\utility::func_A715("bucket_shuffle_success","bucket_shuffle_fail");
	wait(0.25);
	level.damagedbucket movez(64,3);
	wait(3);
	level.damagedbucket rotatepitch(180,0.5,0.2,0.1);
	wait(0.5);
	if(var_0D == "bucket_shuffle_success")
	{
		level.bucketfish moveto(level.damagedbucket.var_116 - (0,-6,24),0.05);
		level.bucketfish rotateto((0,0,90),0.05);
		wait(0.1);
		level.bucketfish method_805B();
		level.bucketfish movez(-12,0.5);
		wait(0.25);
		level.bucketfish rotateto((0,0,0),0.5);
		wait(1);
		var_0E = 0.25;
		var_0F = 10;
		for(var_10 = 0;var_10 < var_0F;var_10++)
		{
			lib_0378::func_8D74("ctf_fish_360",level.bucketfish.var_116,var_0E);
			level.bucketfish rotateyaw(360,var_0E);
			wait(var_0E);
		}

		level.bucketfish thread hallucination_poof_fx(0);
		level.bucketfish method_805C();
		foreach(var_0A in param_01)
		{
			var_0A thread hallucination_poof_fx(0);
			var_0A delete();
		}

		if(common_scripts\utility::func_562E(var_05))
		{
			level notify("bucket_shuffle_complete");
		}

		return 1;
	}

	if(var_12 == "bucket_shuffle_fail")
	{
		wait(2);
		level.bucketfish moveto(level.chosenbucket.var_116 + (0,-6,8),0.05);
		level.bucketfish rotateto((0,0,-90),0.05);
		wait(0.1);
		level.bucketfish method_805B();
		level.bucketfish movez(72,0.6,0,0.5);
		wait(0.6);
		level.bucketfish movez(-96,0.6,0.5,0);
		wait(1);
		level.bucketfish method_805C();
		foreach(var_0F in var_06)
		{
			var_0F thread hallucination_poof_fx(0);
			var_0F delete();
		}

		level.numbucketshuffleassassins++;
		var_15 = common_scripts\utility::func_46B7("ee_conquer_fish_bucket_shuffle_assassin_spawner","targetname");
		var_16 = ["zombie_assassin","zombie_heavy"];
		var_10 = 0;
		while(var_16 < level.numbucketshuffleassassins)
		{
			if(isdefined(var_14[var_16]))
			{
				var_17 = common_scripts\utility::func_7A33(var_15);
				var_18 = undefined;
				if(var_17 == "zombie_assassin")
				{
					var_14[var_16].asssassinspawn = 1;
					var_19 = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_health");
					var_18 = maps/mp/zombies/zombie_assassin_basic::spawn_an_assassin(undefined,var_19,var_14[var_16]);
					var_18.assassinmustneverleave = 1;
					var_18.optionaldisablefogsensitivity = 1;
					var_18.optionaldisablecrouchedambush = 1;
					var_18.optionaldisableexits = 1;
				}
				else
				{
					var_14[var_16].asssassinspawn = 0;
					var_18 = lib_054D::func_90BA(var_17,var_14[var_16],"bucket_shuffle_fail",0,1,0);
				}

				var_18 thread hallucination_poof_fx();
				var_18 lib_0547::func_84CB();
			}

			var_16++;
		}

		for(;;)
		{
			var_1A = lib_0547::func_408F();
			if(var_1A.size < 1)
			{
				break;
			}

			wait 0.05;
		}

		wait(4);
		function_0021();
		return 0;
	}
}

//Function Number: 143
ee_conquer_fish_bucket_wait_for_damage()
{
	level endon("bucket_shuffle_success");
	level endon("bucket_shuffle_fail");
	level waittill("buckets_shuffled");
	for(;;)
	{
		self waittill("damage");
		level.damagedbucket = self;
		if(isdefined(self.ischosenbucket) && self.ischosenbucket)
		{
			level notify("bucket_shuffle_success");
			continue;
		}

		level notify("bucket_shuffle_fail");
	}
}

//Function Number: 144
ee_conquer_fish_bucket_shuffle_completion()
{
	level waittill("bucket_shuffle_complete");
	lib_0378::func_8D74("ctf_void_exit");
	level thread ee_conquer_fish_exit_void();
}

//Function Number: 145
ee_conquer_fish_exit_void()
{
	foreach(var_01 in level.var_744A)
	{
		if(lib_0547::func_577E(var_01))
		{
			var_01 notify("revive_trigger");
		}

		var_01 thread ee_conquer_fish_void_enter_fade();
	}

	level waittill("ee_conquer_fish_enter_void_fading");
	common_scripts\utility::func_3C8F("flag_ship_tilting_enabled");
	common_scripts\utility::func_3C8F("flag_ee_altered_state_finished");
	var_03 = common_scripts\utility::func_46B7("ee_bucket_shuffle_tp_to_ship","targetname");
	for(var_04 = 0;var_04 < level.var_744A.size;var_04++)
	{
		level.var_744A[var_04] setorigin(var_03[var_04].var_116);
		level.var_744A[var_04] setangles(var_03[var_04].var_1D);
		level.var_744A[var_04] notify("altered_state_end");
		level.var_744A[var_04] maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::altered_state_end_overlay(1);
	}

	if(isdefined(level.all_drop_crates) && level.all_drop_crates.size > 0)
	{
		foreach(var_06 in level.all_drop_crates)
		{
			var_06 hudoutlineenableforclients(level.var_744A,2,0);
		}
	}

	level.zmb_sg_banned_objectives = common_scripts\utility::func_F93(level.zmb_sg_banned_objectives,"dnk_ext_visions");
	lib_056D::func_8A6E(0);
	level.zmb_is_endless_wave = 0;
	level.zmb_locked_spawn_zones = undefined;
	level thread ee_conquer_fish_exit_void_failsafe();
}

//Function Number: 146
ee_conquer_fish_exit_void_failsafe()
{
	wait(5);
	for(var_00 = lib_055A::func_5780("zone_the_void");common_scripts\utility::func_562E(var_00);var_00 = lib_055A::func_5780("zone_the_void"))
	{
		foreach(var_02 in level.var_744A)
		{
			if(lib_055A::func_7413(var_02,"zone_the_void"))
			{
				var_03 = common_scripts\utility::func_46B7("ee_bucket_shuffle_tp_to_ship","targetname");
				var_04 = common_scripts\utility::func_7A33(var_03);
				var_02 setorigin(var_04.var_116);
				var_02 setangles(var_04.var_1D);
			}
		}

		wait(5);
	}
}

//Function Number: 147
debug_complete_vignette()
{
	level notify("ee_conquer_fish_straub_event_complete");
}

//Function Number: 148
debug_highlight_bucket()
{
	if(isdefined(level.chosenbucket))
	{
		level.chosenbucket hudoutlineenable(0);
	}
}

//Function Number: 149
warp_start_bucket_shuffle()
{
	common_scripts\utility::func_3C8F("ee_conquer_fish_entered_void");
	common_scripts\utility::func_3C8F("ee_conquer_fish_straub_complete");
	thread all_players_set_visions();
	var_00 = lib_0547::func_408F();
	foreach(var_02 in var_00)
	{
		var_02 lib_056D::func_5A86();
	}

	level.var_ABE2 = 1;
	level.var_ABD3 = -10000;
	common_scripts\utility::func_3C8F("ship_to_void");
	common_scripts\utility::func_3C7B("flag_ship_tilting_enabled");
	level.zmb_locked_spawn_zones = ["zone_the_void"];
}

//Function Number: 150
___________________step_get_part___________________()
{
}

//Function Number: 151
ee_get_part()
{
	thread ee_get_part_think();
	common_scripts\utility::func_3C9F("ee_get_part_sword_part_picked_up");
	level.shattered_ee_complete = 1;
	common_scripts\utility::func_3C8F("zmb_objectives_quest_end");
	lib_0557::func_782D("quest_fish","step_get_part");
}

//Function Number: 152
ee_get_part_setup()
{
	var_00 = getentarray("ee_get_part_parts","targetname");
	foreach(var_02 in var_00)
	{
		var_02 method_805C();
	}
}

//Function Number: 153
ee_get_part_think()
{
	var_00 = getentarray("ee_get_part_parts","targetname");
	foreach(var_02 in var_00)
	{
		var_02 method_805B();
	}

	var_04 = getent("ee_get_part_sword_part","script_noteworthy");
	level thread maps/mp/zombies/weapons/_zombie_dlc3_melee::sword_post_ee_complete_handler();
	var_05 = getent("ee_trig_get_part_sword_part","targetname");
	var_05 sethintstring(&"ZOMBIE_DLC3_PICKUP_PART_3");
	var_05 waittill("trigger",var_06);
	if(!common_scripts\utility::func_F79(var_06 getweaponslistall(),"island_grenade_hc_zm"))
	{
		level thread maps\mp\zombies\_zombies_magicbox::func_A7D5(var_06,"island_grenade_hc_zm",undefined);
	}

	thread ee_get_part_grant_pomel_grenade();
	common_scripts\utility::func_3C8F("ee_get_part_sword_part_picked_up");
}

//Function Number: 154
ee_get_part_grant_pomel_grenade()
{
	var_00 = getent("ee_trig_get_part_sword_part","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(!common_scripts\utility::func_F79(var_01 getweaponslistall(),"island_grenade_hc_zm"))
		{
			level thread maps\mp\zombies\_zombies_magicbox::func_A7D5(var_01,"island_grenade_hc_zm",undefined);
			var_01 thread lib_0367::func_8E3C("pommelpickup",level.var_744A);
		}
	}
}

//Function Number: 155
warp_get_part()
{
	common_scripts\utility::func_3C8F("ee_conquer_fish_entered_void");
}

//Function Number: 156
___________________dnk_util___________________()
{
}

//Function Number: 157
hallucination_poof_fx(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = spawn("script_model",self.var_116);
	var_01 setmodel("tag_origin");
	if(param_00)
	{
		playfxontag(level.var_611["geistkraft_poof"],var_01,"tag_origin");
	}
	else
	{
		playfxontag(level.var_611["zmb_dnk_geistkraftexplode"],var_01,"tag_origin");
	}

	lib_0378::func_8D74("dlc3_magic_poof",self.var_116);
	wait(6);
	var_01 delete();
}

//Function Number: 158
wait_for_round_end(param_00)
{
	level waittill("round complete");
	common_scripts\utility::func_3C8F(param_00);
}

//Function Number: 159
wait_until_all_players_in_volume(param_00)
{
	for(;;)
	{
		var_01 = 0;
		var_02 = [];
		foreach(var_04 in level.var_744A)
		{
			if(isalive(var_04))
			{
				var_02 = common_scripts\utility::func_F6F(var_02,var_04);
			}

			if(var_04 istouching(param_00))
			{
				var_01++;
			}
		}

		if(var_01 >= var_02.size)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 160
down_player()
{
	lib_0547::func_73AC(3);
	lib_0547::func_7442(3);
	self dodamage(self.var_BC,self.var_116);
}

//Function Number: 161
debug_kill_and_pause_zombies()
{
	lib_056D::func_8A6E(1);
	var_00 = lib_0547::func_408F();
	foreach(var_02 in var_00)
	{
		var_02 lib_056D::func_5A86();
	}
}

//Function Number: 162
debug_unpause_zombies()
{
	lib_056D::func_8A6E(0);
}

//Function Number: 163
______________________vo______________________()
{
}

//Function Number: 164
wave_story_wave_1()
{
	var_00 = get_all_alive_player_character_names();
	var_01 = spawnstruct();
	var_01.aliasarray = [];
	var_01.requiredcharacters = [];
	var_01.isvalid = 0;
	if(level.var_744A.size > 1)
	{
		wait(2);
		if(common_scripts\utility::func_F79(var_00,"survivalist") && common_scripts\utility::func_F79(var_00,"batelite"))
		{
			var_01.aliasarray = common_scripts\utility::func_F6F(var_01.aliasarray,"zmb_bp_ship_surv_whatiftheothershipsareabl");
			var_01.requiredcharacters = common_scripts\utility::func_F6F(var_01.requiredcharacters,"survivalist");
		}

		if(common_scripts\utility::func_F79(var_00,"batelite"))
		{
			var_01.aliasarray = common_scripts\utility::func_F6F(var_01.aliasarray,"zmb_bp_ship_ride_ivedividedtheartifactsamo");
			var_01.requiredcharacters = common_scripts\utility::func_F6F(var_01.requiredcharacters,"batelite");
		}

		if(common_scripts\utility::func_F79(var_00,"batagent") && common_scripts\utility::func_F79(var_00,"batelite"))
		{
			var_01.aliasarray = common_scripts\utility::func_F6F(var_01.aliasarray,"zmb_bp_ship_bata_butdoesntthatleaveusvulne");
			var_01.requiredcharacters = common_scripts\utility::func_F6F(var_01.requiredcharacters,"batagent");
		}

		if(common_scripts\utility::func_F79(var_00,"batelite") && common_scripts\utility::func_F79(var_00,"batagent"))
		{
			var_01.aliasarray = common_scripts\utility::func_F6F(var_01.aliasarray,"zmb_bp_ship_ride_itdoesbutitalsomeansthatt");
		}

		play_conversation(var_01.requiredcharacters,var_01.aliasarray);
	}
}

//Function Number: 165
wave_story_wave_4()
{
	var_00 = get_all_alive_player_character_names();
	if(level.var_744A.size > 1)
	{
		if(common_scripts\utility::func_F79(var_00,"survivalist"))
		{
			wait(2);
			var_01 = spawnstruct();
			var_01.aliasarray = [];
			var_01.requiredcharacters = [];
			var_01.isvalid = 0;
			var_01.aliasarray = common_scripts\utility::func_F6F(var_01.aliasarray,"zmb_bp_ship_surv_thisdamnweathermakesithar");
			var_01.requiredcharacters = common_scripts\utility::func_F6F(var_01.requiredcharacters,"survivalist");
			if(common_scripts\utility::func_F79(var_00,"batelite"))
			{
				var_01.aliasarray = common_scripts\utility::func_F6F(var_01.aliasarray,"zmb_bp_ship_ride_youshouldtalkwithdrostanw");
				var_01.requiredcharacters = common_scripts\utility::func_F6F(var_01.requiredcharacters,"batelite");
			}

			play_conversation(var_01.requiredcharacters,var_01.aliasarray);
		}
	}
}

//Function Number: 166
wave_story_pre_boss()
{
	var_00 = ["slayer","survivalist","batelite"];
	var_01 = ["zmb_bp_ship_surv_wevegottheshipsystemsfire","zmb_bp_ship_ride_arewesurethevesselisclear","zmb_bp_ship_slay_thelightsjustbeyondthefog","zmb_bp_ship_ride_lookslikemikhailanddeltor","zmb_bp_ship_surv_holdupsirtheressomethingw"];
	play_conversation(var_00,var_01);
}

//Function Number: 167
wave_story_post_boss()
{
	var_00 = ["survivalist","batelite"];
	var_01 = ["zmb_bp_ship_ride_wellthatshoulddoitensignd","zmb_bp_ship_surv_permissiontospeakfreelysi","zmb_bp_ship_ride_ofcourseensign","zmb_bp_ship_surv_iwantnothingmorethantoget","zmb_bp_ship_ride_watchyourlanguagecaptainn"];
	wait(2);
	play_conversation(var_00,var_01);
}

//Function Number: 168
level_intro_vo()
{
	for(;;)
	{
		if(level.var_A980 >= 1)
		{
			break;
		}

		wait 0.05;
	}

	var_00 = get_all_alive_player_character_names();
	var_01 = [];
	var_02 = [];
	if(level.var_744A.size > 1)
	{
		if(common_scripts\utility::func_F79(var_00,"batagent") && common_scripts\utility::func_F79(var_00,"batelite"))
		{
			var_01 = common_scripts\utility::func_F6F(var_01,"zmb_bp_ship_bata_sirtheothershipshaveallgo");
			var_02 = common_scripts\utility::func_F6F(var_02,"batagent");
		}

		if(common_scripts\utility::func_F79(var_00,"batelite"))
		{
			var_01 = common_scripts\utility::func_F6F(var_01,"zmb_bp_ship_ride_weareunderattackarmyourse");
			var_02 = common_scripts\utility::func_F6F(var_02,"batelite");
		}

		if(common_scripts\utility::func_F79(var_00,"slayer") && common_scripts\utility::func_F79(var_00,"batelite"))
		{
			var_01 = common_scripts\utility::func_F6F(var_01,"zmb_bp_ship_slay_canyouhearthemthedeadthes");
			var_02 = common_scripts\utility::func_F6F(var_02,"slayer");
		}

		if(!isdefined(var_01))
		{
			return;
		}

		play_conversation(var_02,var_01);
	}

	level notify("intro_VO_complete");
}

//Function Number: 169
visions_vo()
{
	var_00 = ["batagent","batelite"];
	var_01 = ["zmb_bp_ship_bata_iidontfeelwell","zmb_bp_ship_ride_seasickharris","zmb_bp_ship_bata_nosirivebeenonshipssincei"];
	wait(2);
	play_conversation(var_00,var_01);
}

//Function Number: 170
sinking_vo()
{
	var_00 = [];
	var_01 = get_all_alive_player_character_names();
	var_02 = [];
	if(common_scripts\utility::func_F79(var_01,"survivalist"))
	{
		var_02 = common_scripts\utility::func_F6F(var_02,"zmb_bp_ship_surv_wearetakingonwater");
		var_00 = common_scripts\utility::func_F6F(var_00,"survivalist");
	}

	if(common_scripts\utility::func_F79(var_01,"batelite"))
	{
		var_02 = common_scripts\utility::func_F6F(var_02,"zmb_bp_ship_ride_thebastardscantdrownthena");
		var_00 = common_scripts\utility::func_F6F(var_00,"batelite");
	}

	if(common_scripts\utility::func_F79(var_01,"batagent"))
	{
		var_02 = common_scripts\utility::func_F6F(var_02,"zmb_bp_ship_bata_letsgettheseholesrepaired");
		var_00 = common_scripts\utility::func_F6F(var_00,"batagent");
	}

	if(!isdefined(var_02) || var_02.size < 1)
	{
		return;
	}

	var_03 = common_scripts\utility::func_7A33(var_02);
	wait(2);
	play_conversation(var_00,var_03);
}

//Function Number: 171
get_all_alive_player_character_names()
{
	var_00 = [];
	foreach(var_02 in level.var_744A)
	{
		var_03 = "";
		switch(var_02.var_20D8)
		{
			case 34:
			case 29:
			case 18:
			case 17:
			case 16:
			case 6:
				var_03 = "survivalist";
				break;

			case 7:
				var_03 = "batagent";
				break;

			case 40:
			case 8:
				var_03 = "batelite";
				break;

			case 35:
			case 31:
			case 21:
			case 20:
			case 19:
			case 9:
				var_03 = "slayer";
				break;
		}

		var_00 = common_scripts\utility::func_F6F(var_00,var_03);
	}

	if(common_scripts\utility::func_3C77("flag_debug_single_speaker"))
	{
		var_00 = ["survivalist","batagent","batelite","slayer"];
	}

	return var_00;
}

//Function Number: 172
update_expected_characters()
{
	level.playercharactersurvivalists = [];
	level.playercharacterbatagents = [];
	level.playercharacterbatelites = [];
	level.playercharacterslayers = [];
	foreach(var_01 in level.var_744A)
	{
		var_02 = var_01.var_20D8;
		switch(var_02)
		{
			case 34:
			case 29:
			case 18:
			case 17:
			case 16:
			case 6:
				level.playercharactersurvivalists = common_scripts\utility::func_F6F(level.playercharactersurvivalists,var_01);
				break;

			case 7:
				level.playercharacterbatagents = common_scripts\utility::func_F6F(level.playercharacterbatagents,var_01);
				break;

			case 40:
			case 8:
				level.playercharacterbatelites = common_scripts\utility::func_F6F(level.playercharacterbatelites,var_01);
				break;

			case 35:
			case 31:
			case 21:
			case 20:
			case 19:
			case 9:
				level.playercharacterslayers = common_scripts\utility::func_F6F(level.playercharacterslayers,var_01);
				break;
		}
	}
}

//Function Number: 173
play_conversation(param_00,param_01)
{
	if(isarray(param_01))
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = [var_02];
	}

	update_expected_characters();
	var_06 = get_all_alive_player_character_names();
	foreach(var_08 in param_00)
	{
		if(!common_scripts\utility::func_F79(var_06,var_08))
		{
			return;
		}
	}

	for(var_0A = 0;var_0A < var_02.size;var_0A++)
	{
		if(isdefined(var_02[var_0A]))
		{
			var_0B = determine_conversation_speaker(var_02[var_0A]);
			var_0C = check_if_speaker_valid(var_0B);
			if(var_0C)
			{
				if(var_02[var_0A] == "zmb_bp_ship_ride_lookslikemikhailanddeltor")
				{
					var_0B lib_0378::func_307E(var_02[var_0A],level.var_744A,undefined,1,"interrupted");
					wait(3.5);
				}
				else
				{
					var_0B lib_0378::func_307E(var_02[var_0A],level.var_744A,undefined,1);
				}
			}
			else
			{
				break;
			}

			wait(0.5);
		}
	}
}

//Function Number: 174
check_if_speaker_valid(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(lib_0547::func_5565(param_00.var_178,"spectator") || lib_0547::func_5565(param_00.var_178,"dead"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 175
determine_conversation_speaker_candidates(param_00)
{
	var_01 = function_036D(param_00,"zmb_bp_ship_");
	if(common_scripts\utility::func_9467(var_01,"surv"))
	{
		var_02 = level.playercharactersurvivalists;
	}
	else if(common_scripts\utility::func_9467(var_02,"bata"))
	{
		var_02 = level.playercharacterbatagents;
	}
	else if(common_scripts\utility::func_9467(var_02,"ride"))
	{
		var_02 = level.playercharacterbatelites;
	}
	else if(common_scripts\utility::func_9467(var_02,"slay"))
	{
		var_02 = level.playercharacterslayers;
	}
	else
	{
		var_02 = [];
	}

	return var_02;
}

//Function Number: 176
determine_conversation_speaker(param_00)
{
	var_01 = determine_conversation_speaker_candidates(param_00);
	var_02 = undefined;
	if(var_01.size > 0)
	{
		var_02 = common_scripts\utility::func_7A33(var_01);
	}

	return var_02;
}