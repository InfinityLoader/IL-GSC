/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: seoul_code_drop_pod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 598 ms
 * Timestamp: 4/22/2024 2:36:22 AM
*******************************************************************/

//Function Number: 1
droppod_main()
{
	common_scripts\utility::flag_init("turn_on_seo_advertisement");
}

//Function Number: 2
intro_space()
{
	common_scripts\utility::flag_set("set_seoul_space_entry_lighting");
	thread setup_orbital_entry();
}

//Function Number: 3
setup_orbital_entry()
{
	thread setup_reentry();
	thread setup_lower_atmosphere_fall();
	thread handle_reentry_fx();
	level.player waittill("y_pressed");
	maps\_shg_design_tools::white_out(5,2,1);
	wait(1);
	level.player waittill("a_pressed");
	level notify("open_hatch");
	wait(1);
	level.player waittill("a_pressed");
	level notify("start_deployment");
}

//Function Number: 4
handle_reentry_fx()
{
	var_00 = getentarray("reentry_fire_01","targetname");
	common_scripts\utility::array_call(var_00,::hide);
	var_01 = getentarray("reentry_fire_brush","targetname");
	foreach(var_03 in var_01)
	{
		var_03 linkto(level.center_universe,"tag_origin");
	}

	common_scripts\utility::array_call(var_01,::hide);
	level waittill("entering_upper_atmosphere");
	thread rumble_cam_shake();
	if(level.nextgen)
	{
		thread maps\_utility::vision_set_fog_changes("seoul_space_orange",10);
	}

	earthquake(0.2,25,level.player.origin,500);
	wait(12);
	common_scripts\utility::array_call(var_01,::show);
	level notify("ok_to_teleport_player");
	thread make_reentry_strobe();
	wait(2);
	if(level.nextgen)
	{
		thread maps\_utility::vision_set_fog_changes("seoul_space_white",10);
	}

	earthquake(0.1,5,level.player.origin,500);
	level waittill("never_true");
	level waittill("should_telport_player");
	level waittill("should_telport_player");
	common_scripts\utility::array_call(var_01,::hide);
	if(level.nextgen)
	{
		thread maps\_utility::vision_set_fog_changes("seoul",12);
	}

	wait(5);
	earthquake(0.2,25,level.player.origin,500);
	thread make_reentry_strobe();
}

//Function Number: 5
make_reentry_strobe()
{
	for(var_00 = 0;var_00 < 2;var_00++)
	{
		for(var_01 = 0;var_01 < 10;var_01++)
		{
			var_02 = randomfloatrange(0.1,0.5);
			var_03 = randomfloatrange(0.1,1);
			maps\_shg_design_tools::white_out(0.1,var_02,var_03);
			wait(randomfloatrange(0.1,1));
		}

		thread maps\_shg_design_tools::white_out(0.1,0.5,1);
		wait(0.1);
		level notify("should_telport_player");
	}
}

//Function Number: 6
rumble_cam_shake()
{
}

//Function Number: 7
setup_galaxy_hatch()
{
	var_00 = getentarray("galaxy_back_hatch","targetname");
	var_01 = getent("galaxy_back_hatch_org","targetname");
	var_02 = var_01 common_scripts\utility::spawn_tag_origin();
	foreach(var_04 in var_00)
	{
		var_04 linkto(var_02,"tag_origin");
	}

	level waittill("open_hatch");
	var_06 = (-90,var_02.angles[1],var_02.angles[2]);
	var_02 rotateto(var_06,8,3,1);
}

//Function Number: 8
setup_lower_atmosphere_fall()
{
	setup_player_pod_b();
	move_universe_to_new_pod();
	level waittill("reentry_fx_off");
}

//Function Number: 9
move_universe_to_new_pod()
{
}

//Function Number: 10
setup_reentry()
{
	var_00 = getent("pod_center","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	level.center_universe = var_01;
	thread setup_player_pod();
	thread setup_space_transport();
	level.player waittill("x_pressed");
	level notify("begin_deorbit");
	earthquake(0.2,1,level.player.origin,64);
	thread handle_atmospheric_transition();
	thread handle_space_sky();
	thread handle_earth_disc();
	thread handle_sun_spotlight();
	thread rotate_the_universe(var_01);
}

//Function Number: 11
handle_sun_spotlight()
{
	var_00 = getent("sunlight_location","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_01.angles = vectortoangles(level.center_universe.origin - var_01.origin);
	level waittill("begin_deorbit");
	playfxontag(common_scripts\utility::getfx("player_light"),var_01,"tag_origin");
	var_01 linkto(level.center_universe,"tag_origin");
	level waittill("reentry");
	stopfxontag(common_scripts\utility::getfx("player_light"),var_01,"tag_origin");
}

//Function Number: 12
handle_earth_disc()
{
	var_00 = getent("earth_disc","targetname");
	var_00 thread move_earth_with_pod(level.center_universe);
	level waittill("ok_to_teleport_player");
	var_00 delete();
}

//Function Number: 13
handle_space_sky()
{
	var_00 = getentarray("space_brush","targetname");
	foreach(var_02 in var_00)
	{
		var_02 linkto(level.center_universe,"tag_origin");
	}

	level waittill("dropped_from_pod");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 14
handle_atmospheric_transition()
{
	var_00 = getentarray("reentry_gray_brush","targetname");
	level waittill("begin_deorbit");
	common_scripts\utility::array_call(var_00,::hide);
	common_scripts\utility::flag_wait("entering_atmosphere");
}

//Function Number: 15
handle_drop_pod_screen_start()
{
	stopcinematicingame();
	level.pod_screen showpart(level.pod_screen.tag_screen_off);
	level waittill("screen_intialize");
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("drop_pod_glass_reboot");
	wait(3);
	drop_pod_screen_on();
	common_scripts\utility::flag_wait("turn_on_seo_advertisement");
	maps\seoul::ingame_movies();
}

//Function Number: 16
drop_pod_door_close(param_00)
{
	level.entrance_room delete();
}

//Function Number: 17
drop_pod_screen_on()
{
	level notify("pod_screen_on");
	if(level.pod_screen.video_idle)
	{
		cinematicingameloop("drop_pod_glass_idle");
		level.pod_screen.video_idle = 0;
	}
}

//Function Number: 18
drop_pod_screen_off(param_00)
{
	level notify("pod_screen_off");
	cinematicingameloop("drop_pod_glass_evacuate");
	level notify("portal_vista_off");
}

//Function Number: 19
drop_pod_screen_off_damage(param_00)
{
	cinematicingameloop("drop_pod_glass_damaged");
	level notify("pod_screen_off");
}

//Function Number: 20
drop_pod_screen_chrome_abber(param_00)
{
	if(level.pod_screen.video_cab_count < 2)
	{
		cinematicingameloop("drop_pod_glass_glitch");
		wait 0.05;
		level.pod_screen.video_cab_count++;
	}
}

//Function Number: 21
drop_pod_screen_bootup(param_00)
{
	cinematicingameloop("drop_pod_glass_reboot");
	level thread maps\seoul_fx::intro_droppod_velocity_streaks(param_00);
}

//Function Number: 22
drop_pod_screen_on_warning(param_00)
{
	cinematicingameloop("drop_pod_glass_warning");
	level notify("pod_screen_bootup");
}

//Function Number: 23
drop_pod_screen_glitch_warning(param_00)
{
	if(level.pod_screen.video_warn_count == 1)
	{
		level notify("building_2_crash");
	}

	level.pod_screen.video_warn_count++;
}

//Function Number: 24
handle_pod_screen_show(param_00)
{
	for(;;)
	{
		level waittill("pod_screen_on");
		level.pod_screen showpart(level.pod_screen.tag_screen_on);
		level.pod_screen showpart(level.pod_screen.tag_screen_load);
		param_00 hidepart("TAG_ROOF");
		level.pod_screen hidepart(level.pod_screen.tag_screen_off);
	}
}

//Function Number: 25
handle_pod_screen_off(param_00)
{
	for(;;)
	{
		level waittill("pod_screen_off");
		level.pod_screen showpart(level.pod_screen.tag_screen_off);
		param_00 showpart("TAG_ROOF");
	}
}

//Function Number: 26
handle_pod_screen_bootup(param_00)
{
	for(;;)
	{
		level waittill("pod_screen_bootup");
		level.pod_screen hidepart(level.pod_screen.tag_screen_off);
		param_00 hidepart("TAG_ROOF");
	}
}

//Function Number: 27
fov_screen(param_00)
{
	if(level.pod_screen.fov_screen_count == 0)
	{
		level.player lerpfov(85,3);
	}
	else
	{
		level.player lerpfov(85,0.3);
	}

	level.pod_screen.fov_screen_count++;
}

//Function Number: 28
fov_face(param_00)
{
	level.player lerpfov(65,0.3);
}

//Function Number: 29
drop_pod_chromatic_abberation(param_00)
{
	var_01 = 8;
	var_02 = 1;
	var_03 = 8;
	setsaveddvar("r_chromaticAberrationTweaks",1);
	setsaveddvar("r_chromaticAberrationAlpha",0.85);
	for(var_04 = 0;var_04 < param_00;var_04++)
	{
		setsaveddvar("r_chromaticAberration",1);
		var_05 = perlinnoise2d(gettime() * 0.001 * param_00,var_01,4,5,2);
		setsaveddvar("r_chromaticSeparationR",perlinnoise2d(gettime() * 0.001 * param_00,var_01,4,5,2));
		setsaveddvar("r_chromaticSeparationG",perlinnoise2d(gettime() * 0.001 * param_00,var_02,4,5,2));
		setsaveddvar("r_chromaticSeparationB",perlinnoise2d(gettime() * 0.001 * param_00,var_03,4,5,2));
		wait 0.05;
		setsaveddvar("r_chromaticAberration",0);
	}
}

//Function Number: 30
handle_pod_crash_building1()
{
	level waittill("pod_crash_hide_floor1");
	if(level.currentgen)
	{
		level.player lightsetforplayer("space_entry_crash");
	}

	delete_pod_crash_floor(getentarray("pod_crash_hide_floor1","targetname"));
	cinematicingameloop("drop_pod_glass_warning");
	if(level.currentgen)
	{
		wait(0.5);
		level.player lightsetforplayer("seoul_vista");
	}
}

//Function Number: 31
delete_pod_crash_floor(param_00)
{
	maps\_utility::array_delete(param_00);
}

//Function Number: 32
handle_portal_scripting_vista(param_00)
{
	var_01 = getent(param_00,"targetname");
	level waittill("portal_vista_off");
	var_01 enableportalgroup(0);
	level waittill("player_drop_pod_door_kick");
	var_01 enableportalgroup(1);
}

//Function Number: 33
setup_space_transport()
{
	level waittill("begin_deorbit");
	wait(0.2);
	thread setup_rocket_pieces("pod_npc_org");
	thread setup_rocket_pieces("pod_npc_org2");
	thread setup_rocket_pieces("pod_npc_org3");
	thread setup_rocket_pieces("pod_npc_org4");
	thread setup_rocket_pieces("entry_pod_connector_org");
}

//Function Number: 34
setup_rocket_pieces(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	foreach(var_04 in var_02)
	{
		var_05 = var_04 common_scripts\utility::spawn_tag_origin();
		var_05.pieces = getentarray(var_04.target,"targetname");
		foreach(var_07 in var_05.pieces)
		{
			var_07 linkto(var_05,"tag_origin");
		}

		var_05 thread rotate_space_debris();
	}
}

//Function Number: 35
rotate_space_debris()
{
	level endon("reentry");
	var_00 = self;
	var_01 = distance(level.center_universe.origin,self.origin);
	var_02 = 1 + var_01 / 100;
	var_03 = var_00.origin;
	var_04 = 1;
	if(var_03[2] < level.center_universe.origin[2])
	{
		var_04 = -1;
	}

	var_05 = (randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1));
	var_06 = (randomfloatrange(-1,1),randomfloatrange(-1,1),0);
	var_07 = 0;
	var_08 = undefined;
	for(;;)
	{
		if(distance(var_00.origin,var_03) > 250)
		{
			var_00.angles = var_00.angles + var_05;
			var_09 = (var_06[0],var_06[1],var_02);
			if(!var_07)
			{
				var_07 = 1;
				level notify("begin_universe_twirl");
				var_08 = var_00 common_scripts\utility::spawn_tag_origin();
				var_08 linkto(level.center_universe,"tag_origin");
			}

			var_00.origin = var_08.origin + (var_09[0],var_09[1],var_02 * var_04);
		}
		else
		{
			var_09 = (0,0,var_02 * var_04);
			var_00.origin = var_00.origin + var_09;
		}

		wait 0.05;
	}
}

//Function Number: 36
rotate_the_universe(param_00)
{
	level endon("reentry");
	param_00.angles = (90,180,param_00.angles[2]);
	level waittill("begin_universe_twirl");
	var_01 = (1,0.2,0);
	var_02 = 140;
	var_03 = 1;
	var_04 = var_01[0] / var_02;
	var_05 = var_01[1] / var_02;
	var_06 = 0;
	while(!common_scripts\utility::flag("entering_atmosphere"))
	{
		if(var_03)
		{
			for(var_07 = 0;var_07 < var_02;var_07++)
			{
				param_00.angles = param_00.angles + (var_04 * var_07,var_05 * var_07,var_06 * var_07);
				wait 0.05;
			}

			var_03 = 0;
			continue;
		}

		param_00.angles = param_00.angles + var_01;
		wait 0.05;
	}

	var_08 = 90;
	var_09 = 180;
	var_0A = 0;
	for(var_07 = 0;var_07 < var_02;var_07++)
	{
		param_00.angles = param_00.angles + (var_01[0] - var_04 * var_07,var_01[1] - var_05 * var_07,var_06 * var_07);
		wait 0.05;
	}
}

//Function Number: 37
setup_player_pod()
{
	level.player disableweapons();
	var_00 = getent("player_pod_seat","targetname");
	if(!isdefined(var_00))
	{
		var_01 = getentarray("player_pod_seat","targetname");
		var_00 = var_01[0];
	}

	var_02 = getentarray("pod_ally_orgs","targetname");
	var_03 = getent("entrypod_ally_spawner","targetname");
	if(!isdefined(var_00))
	{
		maps\seoul_code_gangnam::seoul_start();
		return;
	}

	level.player maps\_utility::teleport_player(var_00);
	level.player.seattag = level.player common_scripts\utility::spawn_tag_origin();
	level.player playerlinktodelta(level.player.seattag,"tag_origin",1,60,60,60,60,1,1);
	level.player allowcrouch(0);
	level.podsquad = [];
	foreach(var_05 in var_02)
	{
		var_06 = var_05 common_scripts\utility::spawn_tag_origin();
		var_03.count = 1;
		var_07 = var_03 maps\_utility::spawn_ai(1);
		maps\_utility::spawn_failed(var_07);
		var_07.tag = var_06;
		if(common_scripts\utility::cointoss())
		{
			var_06 thread maps\_shg_design_tools::anim_simple(var_07,var_05.animation);
		}
		else
		{
			var_06 thread maps\_anim::anim_generic_first_frame(var_07,var_05.animation + "_single");
		}

		level.podsquad[level.podsquad.size] = var_07;
		wait(0.1);
	}
}

//Function Number: 38
flag_wait_any_or_timeout(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 * 1000;
	var_07 = gettime();
	var_08 = [param_01,param_02,param_03,param_04,param_05];
	for(;;)
	{
		foreach(var_0A in var_08)
		{
			if(common_scripts\utility::flag_exist(var_0A) && common_scripts\utility::flag(var_0A))
			{
				break;
			}
		}

		if(gettime() >= var_07 + var_06)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 39
setup_player_pod_b()
{
	level waittill("never_true");
	level waittill("ok_to_teleport_player");
	var_00 = getentarray("pod_ally_orgs_b","targetname");
	var_01 = getentarray("ally_pod_spawner_b","targetname");
	var_02 = var_01[0];
	foreach(var_04 in var_00)
	{
		var_02.count = 1;
		var_05 = var_04 common_scripts\utility::spawn_tag_origin();
		var_06 = var_02 maps\_utility::spawn_ai(1);
		var_06 maps\_utility::spawn_failed();
		if(common_scripts\utility::cointoss())
		{
			var_05 thread maps\_shg_design_tools::anim_simple(var_06,var_04.animation);
		}
		else
		{
			var_05 thread maps\_anim::anim_generic_first_frame(var_06,var_04.animation + "_single");
		}

		wait 0.05;
	}

	level waittill("should_telport_player");
	level.player unlink();
	level.player.seattag delete();
	var_08 = getent("player_pod_seat_x","targetname");
	level.player.seattag = level.player common_scripts\utility::spawn_tag_origin();
	var_09 = level.player getplayerangles();
	level.player playerlinktodelta(level.player.seattag,"tag_origin",1,60,60,60,60,1,1);
	level.player allowstand(0);
	level.player setplayerangles(var_09);
	var_0A = getent("earth_disc_upper_atmosphere","targetname");
	var_0A notify("stop_earth_movement");
	var_0A delete();
	var_0B = getent("pod_center_b","targetname");
	level.center_universe.origin = var_0B.origin;
	common_scripts\utility::array_call(level.podsquad,::delete);
	level waittill("should_telport_player");
	level waittill("should_telport_player");
	level notify("dropped_from_pod");
	level waittill("should_telport_player");
	level.player unlink();
	level.player.seattag delete();
	var_0C = getent("player_pod_seat_c","targetname");
	level.player.seattag = var_0C common_scripts\utility::spawn_tag_origin();
	level.player playerlinktodelta(level.player.seattag,"tag_origin",1,60,60,60,60,1,1);
	level.player allowstand(0);
	wait(2);
	var_0D = getent("player_pod_door_01","targetname");
	var_0D rotateto(var_0D.angles + (0,0,-95),2,0.2,1);
	wait(3);
	var_0E = getent("player_pod_seat_c2","targetname");
	level.player.seattag moveto(var_0E.origin,3,0.2,0.5);
	level.player.seattag rotateto(var_0E.angles,1,0.2,0.5);
	wait(4);
	level.player unlink();
	level.player enableweapons();
	level.player allowstand(1);
}

//Function Number: 40
move_earth_with_pod(param_00)
{
	level endon("ok_to_teleport_player");
	var_01 = 80;
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"tag_origin");
	var_03 = common_scripts\utility::spawn_tag_origin();
	thread monitor_dist_from_earth(self);
	level.earth_tag = var_02;
	level.earth_tag = var_02;
	var_04 = var_03.origin;
	for(;;)
	{
		self.angles = var_02.angles;
		var_05 = maps\_shg_design_tools::getlerpfraction(var_03.origin,param_00.origin,var_01,5);
		var_03.origin = vectorlerp(var_03.origin,param_00.origin,var_05);
		var_06 = distance(var_04,var_03.origin);
		self.origin = var_02 maps\_shg_design_tools::offset_position_from_tag("up","tag_origin",var_06);
		level.earth_angles = [self.origin,self.angles,var_06];
		wait 0.05;
	}
}

//Function Number: 41
move_earth2_with_pod()
{
	var_00 = 80;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_02 = var_01.origin;
	for(;;)
	{
		self.angles = level.earth_tag.angles;
		var_03 = maps\_shg_design_tools::getlerpfraction(var_01.origin,level.center_universe.origin,var_00,5);
		var_01.origin = vectorlerp(var_01.origin,level.center_universe.origin,var_03);
		var_04 = distance(var_02,var_01.origin);
		self.origin = level.earth_tag maps\_shg_design_tools::offset_position_from_tag("up","tag_origin",var_04);
		wait 0.05;
	}
}

//Function Number: 42
monitor_dist_from_earth(param_00)
{
	while(distance(param_00.origin,level.center_universe.origin) > 1600)
	{
		wait 0.05;
	}

	common_scripts\utility::flag_set("entering_atmosphere");
	level notify("entering_upper_atmosphere");
}