/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_facility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 54
 * Decompile Time: 901 ms
 * Timestamp: 4/22/2024 2:26:14 AM
*******************************************************************/

//Function Number: 1
pre_load()
{
}

//Function Number: 2
post_load()
{
	if(isdefined(common_scripts\utility::getstruct("struct_playerstart_incinerator","targetname")))
	{
		thread setup_spawners();
		level.rh_exit_door = getent("rh_exit_door","targetname");
	}
	else
	{
		iprintln("Warning: S3 Exterior may be compiled out!");
	}

	common_scripts\utility::flag_init("flag_incinerator_start");
	common_scripts\utility::flag_init("flag_incinerator_fires_start");
	common_scripts\utility::flag_init("flag_incinerator_last_fire_loop");
	common_scripts\utility::flag_init("flag_incinerator_push_start");
	common_scripts\utility::flag_init("flag_incinerator_push_done");
	common_scripts\utility::flag_init("flag_incinerator_crawl_start");
	common_scripts\utility::flag_init("flag_incinerator_crawl_pull");
	common_scripts\utility::flag_init("flag_inc_pipe_break");
	common_scripts\utility::flag_init("flag_incinerator_player_saved");
	common_scripts\utility::flag_init("flag_incinerator_player_pipe_grab");
	common_scripts\utility::flag_init("lgt_flag_inc_near_miss");
	common_scripts\utility::flag_init("flag_incinerator_saved");
	common_scripts\utility::flag_init("flag_pushing_cart");
	common_scripts\utility::flag_init("flag_bh_intro_start");
	common_scripts\utility::flag_init("flag_bh_intro_start_scene");
	common_scripts\utility::flag_init("flag_bh_intro_caught");
	common_scripts\utility::flag_init("flag_bh_intro_caught_late");
	common_scripts\utility::flag_init("flag_bh_pit");
	common_scripts\utility::flag_init("flag_bh_pit_end");
	common_scripts\utility::flag_init("flag_bh_pit_all_clear");
	common_scripts\utility::flag_init("flag_bh_yard");
	common_scripts\utility::flag_init("flag_bh_back");
	common_scripts\utility::flag_init("flag_bh_runaway");
	common_scripts\utility::flag_init("flag_player_and_ally_at_window");
	common_scripts\utility::flag_init("flag_bh_run_ally_ready");
	common_scripts\utility::flag_init("flag_bh_run_start_scene");
	common_scripts\utility::flag_init("flag_bh_run_manticore_done");
	common_scripts\utility::flag_init("flag_bh_run");
	common_scripts\utility::flag_init("flag_bh_helo_opfor_killed");
	common_scripts\utility::flag_init("flag_battle_to_heli_end");
	common_scripts\utility::flag_init("flag_bh_open_yard_doors_in");
	common_scripts\utility::flag_init("flag_bh_open_yard_doors_out");
	common_scripts\utility::flag_init("gps_bh_mech_loader_room");
	var_00 = getentarray("trig_start_off","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread common_scripts\utility::trigger_off();
	}

	if(isdefined(level.rh_exit_door))
	{
		level.rh_exit_door.animname = "runtoheli_door";
		level.rh_exit_door maps\_anim::setanimtree();
		level.rh_exit_door.col = getent("door_bh_heli_link","targetname");
		level.rh_exit_door.col linkto(level.rh_exit_door,"j_bone_door_right",(28,1.5,48),(0,0,0));
		common_scripts\utility::getstruct("struct_run_to_heli_manticore","targetname") maps\_anim::anim_first_frame_solo(level.rh_exit_door,"runtoheli_door_kick");
	}

	level._facility = spawnstruct();
	precacherumble("steady_rumble");
	precacherumble("tank_rumble");
}

//Function Number: 3
start(param_00)
{
	level.player maps\captured_util::warp_to_start(param_00);
	if(issubstr(level.start_point,"heliride"))
	{
		var_01 = getent("vehicle_warbird","targetname");
		var_02 = var_01 maps\_utility::spawn_vehicle();
		if(level.currentgen)
		{
			var_02 thread maps\captured_util::tff_cleanup_vehicle("helipad");
		}

		var_02 thread setup_warbird();
		var_02 thread vehicle_scripts\_xh9_warbird::open_left_door();
	}
}

//Function Number: 4
setup_warbird()
{
	self.animname = "vtol";
	maps\_vehicle::godon();
	self makeunusable();
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("vehicle_xh9_warbird_interior_collision");
	var_00 linkto(self,"tag_origin",(0,0,0),(0,0,0));
	level.heli_collision = var_00;
	level._facility.warbird = self;
	var_01 = getent("refl_probe_heli_open","targetname");
	level._facility.warbird overridereflectionprobe(var_01.origin);
	var_00 hide();
	level waittill("heliride_blood");
	var_00 show();
	common_scripts\utility::flag_wait("flag_heliride_end");
	var_00 delete();
}

//Function Number: 5
start_incinerator()
{
	setsaveddvar("g_friendlyNameDist",0);
	maps\captured_util::warp_allies("struct_anim_incinerator");
	level.player thread maps\_utility::blend_movespeedscale(0.8);
	level.player maps\captured_util::warp_to_start("struct_playerstart_incinerator");
	level.player takeallweapons();
	level.player allowmelee(0);
	var_00 = getent("aut_doctor_hatch","targetname");
	var_00 delete();
}

//Function Number: 6
main_incinerator()
{
	common_scripts\utility::flag_wait("flag_incinerator_start");
	maps\_utility::autosave_by_name("incinerator");
	wait(0.05);
	common_scripts\utility::flag_set("flag_incinerator_saved");
	level.player common_scripts\utility::delaycall(0.6,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(0.6,::playrumbleonentity,"heavy_1s");
	maps\_player_exo::player_exo_deactivate();
	var_00 = common_scripts\utility::getstruct("struct_anim_incinerator","targetname");
	var_01 = maps\_utility::spawn_anim_model("player_rig");
	var_02 = maps\_utility::spawn_anim_model("cart_1");
	var_03 = maps\_utility::spawn_anim_model("cart_2");
	var_04 = maps\_utility::spawn_anim_model("grate");
	var_01 hide();
	incinerator_intro(var_00,var_01,var_02,var_03,var_04);
	incinerator_cart_push(var_00,var_01,var_02,var_03,var_04);
	incinerator_crawl(var_00,var_01);
}

//Function Number: 7
incinerator_intro(param_00,param_01,param_02,param_03,param_04)
{
	soundscripts\_snd::snd_message("start_incinerator");
	var_05 = maps\_hud_util::create_client_overlay("black",1,level.player);
	if(level.currentgen)
	{
		if(!istransientloaded("captured_incinerator_tr"))
		{
			level notify("tff_pre_autopsy_to_incinerator");
			unloadtransient("captured_autopsy_tr");
			loadtransient("captured_incinerator_tr");
			while(!istransientloaded("captured_incinerator_tr"))
			{
				wait(0.05);
			}

			level notify("tff_post_autopsy_to_incinerator");
		}
	}

	param_00 maps\_anim::anim_first_frame([param_02,param_03,param_04],"incinerator_push");
	level.ally show();
	level.player freezecontrols(1);
	level.player allowprone(0);
	level.player allowcrouch(1);
	level.player allowstand(0);
	level.player allowjump(0);
	level.player allowsprint(0);
	level.player thread maps\_utility::blend_movespeedscale(0.2);
	thread maps\captured_util::smooth_player_link(param_01,0.4);
	thread incinerator_player_damage();
	param_00 = common_scripts\utility::getstruct("struct_anim_incinerator","targetname");
	param_00 thread maps\_anim::anim_single([param_01,level.ally],"incinerator_intro");
	wait(0.05);
	param_00 maps\captured_util::anim_set_real_time([param_01,level.ally],"incinerator_intro",2.8);
	param_00 maps\_utility::delaythread(getanimlength(level.ally maps\_utility::getanim("incinerator_intro")) - 2.8,::maps\_anim::anim_loop_solo,level.ally,"incinerator_intro_wait_loop","started_pushing_cart");
	var_06 = getanimlength(param_01 maps\_utility::getanim("incinerator_intro")) - 2.7;
	level.player common_scripts\utility::delaycall(var_06,::freezecontrols,0);
	level.player maps\_utility::delaythread(var_06,::maps\_utility::blend_movespeedscale,0.5,5);
	level.player maps\_utility::delaythread(var_06,::incinerator_stance);
	level.player common_scripts\utility::delaycall(var_06,::unlink);
	param_01 common_scripts\utility::delaycall(var_06,::hide);
	wait(8.3);
	common_scripts\utility::flag_set("flag_incinerator_fires_start");
	var_05 fadeovertime(0.05);
	var_05.alpha = 0;
}

//Function Number: 8
incinerator_cart_push(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\_utility::get_rumble_ent();
	var_05 maps\_utility::rumble_ramp_to(0,0.05);
	var_06 = getent("use_incinerator_cart","targetname");
	level.pipe = maps\_utility::spawn_anim_model("incinerator_pipe");
	var_07 = spawn("script_model",(7959,-13466,-1773));
	var_07 setmodel("tag_origin");
	level.pipe retargetscriptmodellighting(var_07);
	param_00 maps\_anim::anim_first_frame_solo(level.pipe,"incinerator_crawl");
	wait(21);
	var_06 makeusable();
	var_06 maps\_utility::addhinttrigger(&"CAPTURED_HINT_PUSH_CONSOLE",&"CAPTURED_HINT_PUSH_PC");
	level notify("incineratory_usable");
	maps\captured_actions::incinerator_push_action(var_06,param_00);
	soundscripts\_snd::snd_message("aud_incin_cart_start");
	var_06 delete();
	level.player thread maps\_utility::blend_movespeedscale(0.8);
	level.player thread still_pressing_use_button();
	level.player freezecontrols(1);
	level.player allowstand(1);
	level.player allowprone(0);
	level.player allowcrouch(0);
	common_scripts\utility::flag_set("flag_incinerator_push_start");
	level.ally setanim(level.ally maps\_utility::getanim("incinerator_push_stop_1")[0],0.9,0.5);
	param_00 thread maps\_anim::anim_single_solo(param_01,"incinerator_push_start");
	level.player playerlinktoblend(param_01,"tag_player",0.5);
	wait(0.5);
	param_01 show();
	level.player playerlinktodelta(param_01,"tag_player",1,0,0,0,0,1);
	var_08 = getanimlength(param_01 maps\_utility::getanim("incinerator_push_start"));
	wait(var_08 - 0.5);
	var_09 = 0;
	var_0A = [param_01,level.ally,param_02,param_03,param_04];
	param_00 notify("started_pushing_cart");
	common_scripts\utility::flag_set("flag_pushing_cart");
	soundscripts\_snd::snd_message("aud_incin_cart_push");
	param_00 thread maps\_anim::anim_single(var_0A,"incinerator_push");
	while(var_09 < 0.38)
	{
		wait(0.05);
		param_00 notify("started_pushing_cart");
		var_0B = level.player getnormalizedmovement();
		var_0C = max(var_0B[0],-1 * var_0B[1]);
		var_0D = param_01 maps\_utility::getanim("incinerator_push");
		var_0E = getanimlength(var_0D);
		var_09 = param_01 getanimtime(var_0D) * var_0E + 0.05 / var_0E;
		if(0.2 > var_09 || var_09 > 0.28)
		{
			if(var_0C > 0.5 && !common_scripts\utility::flag("flag_pushing_cart"))
			{
				common_scripts\utility::flag_set("flag_pushing_cart");
				maps\_anim::anim_set_rate(var_0A,"incinerator_push",1);
				soundscripts\_snd::snd_message("aud_incin_cart_push");
				level.ally thread incinerator_ally_push(param_00,var_09);
				continue;
			}

			if(var_0C < 0.5 && common_scripts\utility::flag("flag_pushing_cart"))
			{
				common_scripts\utility::flag_clear("flag_pushing_cart");
				maps\_anim::anim_set_rate(var_0A,"incinerator_push",0);
				soundscripts\_snd::snd_message("aud_incin_cart_push_stop");
				level.ally thread incinerator_ally_push_stop(param_00,var_09);
			}
		}
	}

	soundscripts\_snd::snd_message("aud_incin_cart_done");
	level.ally stopanimscripted();
	common_scripts\utility::flag_set("flag_pushing_cart");
	common_scripts\utility::flag_set("flag_incinerator_push_done");
	maps\_anim::anim_set_rate(var_0A,"incinerator_push",1);
	level.ally notify("started_pushing_cart");
	param_00 maps\_utility::delaythread(0.05,::maps\_anim::anim_set_time,[level.ally],"incinerator_push",var_09);
	param_00 thread maps\captured_anim::anim_single_to_loop_solo(level.ally,"incinerator_push","incinerator_crawl_wait_loop","ally_pull_player");
	param_00 waittill("incinerator_push");
}

//Function Number: 9
incinerator_crawl(param_00,param_01)
{
	common_scripts\utility::flag_set("flag_incinerator_crawl_start");
	maps\_utility::autosave_by_name_silent("incinerator_crawl");
	var_02 = 0;
	var_03 = [param_01,level.pipe];
	thread incinerator_player_end_anim_and_cleanup(param_00,var_03);
	level.player enableslowaim(0.3,0.15);
	level.player playerlinktodelta(param_01,"tag_player",0.5,20,30,15,0,1);
	while(!common_scripts\utility::flag("flag_incinerator_player_pipe_grab"))
	{
		wait(0.05);
		var_04 = level.player getnormalizedmovement()[0];
		var_02 = param_01 getanimtime(param_01 maps\_utility::getanim("incinerator_crawl"));
		if(var_04 > 0.5 && !common_scripts\utility::flag("flag_pushing_cart"))
		{
			common_scripts\utility::flag_set("flag_pushing_cart");
			maps\_anim::anim_set_rate(var_03,"incinerator_crawl",1);
			continue;
		}

		if(var_04 < 0.5 && common_scripts\utility::flag("flag_pushing_cart"))
		{
			common_scripts\utility::flag_clear("flag_pushing_cart");
			maps\_anim::anim_set_rate(var_03,"incinerator_crawl",0);
		}
	}

	common_scripts\utility::flag_set("flag_incinerator_crawl_pull");
	maps\_anim::anim_set_rate(var_03,"incinerator_crawl",1);
	common_scripts\utility::flag_wait("flag_incinerator_player_saved");
	level.player playerlinktoblend(param_01,"tag_player",1);
	param_00 notify("ally_pull_player");
	param_00 thread maps\_anim::anim_single_solo(level.ally,"incinerator_crawl_pull",undefined,0.2);
}

//Function Number: 10
incinerator_player_end_anim_and_cleanup(param_00,param_01)
{
	level.player thread maps\_utility::blend_movespeedscale(0.2);
	param_00 maps\_anim::anim_single(param_01,"incinerator_crawl");
	setsaveddvar("g_friendlyNameDist",level.friendlynamedist);
	level.player unlink();
	level.player freezecontrols(0);
	level.player allowstand(1);
	level.player allowprone(1);
	level.player allowjump(1);
	level.player allowcrouch(1);
	level.player enableweapons();
	level.player allowsprint(1);
	level.player allowmelee(1);
	level.player disableslowaim();
	level.player enableoffhandweapons();
	param_01[0] delete();
	level.player thread incinerator_player_wobble();
	level.player thread maps\captured_util::start_one_handed_gunplay("iw5_titan45pickup_sp_xmags");
	level.player maps\_utility::blend_movespeedscale(0.33,5.95);
	level.player maps\_utility::delaythread(6,::maps\_utility::blend_movespeedscale,0.8,8);
	maps\_player_exo::player_exo_activate();
}

//Function Number: 11
incinerator_stance()
{
	level endon("flag_pushing_cart");
	while(!common_scripts\utility::flag("flag_between_carts_end"))
	{
		level.player setstance("crouch");
		level.player allowstand(0);
		common_scripts\utility::flag_wait_either("flag_between_carts","flag_between_carts_end");
		level.player setstance("stand");
		level.player allowstand(1);
		if(common_scripts\utility::flag("flag_between_carts"))
		{
			level.player forcemantle();
		}

		common_scripts\utility::flag_waitopen("flag_between_carts");
	}
}

//Function Number: 12
incinerator_ally_push(param_00,param_01)
{
	self notify("started_pushing_cart");
	self endon("started_pushing_cart");
	self setanim(maps\_utility::getanim("incinerator_push_stop_1")[0],0,0.5);
}

//Function Number: 13
incinerator_ally_push_stop(param_00,param_01)
{
	if(param_01 < 0.22)
	{
		self setanim(maps\_utility::getanim("incinerator_push_stop_1")[0],0.99,0.5);
		return;
	}

	self setanim(maps\_utility::getanim("incinerator_push_stop_2")[0],0.99,0.5);
}

//Function Number: 14
still_pressing_use_button()
{
	self endon("death");
	self endon("started_pushing_cart");
	self.still_pressing_use = 1;
	while(self usebuttonpressed())
	{
		wait(0.05);
	}

	self.still_pressing_use = undefined;
}

//Function Number: 15
usebuttonrepressed()
{
	if(isdefined(self.still_pressing_use))
	{
		return 0;
	}

	return self usebuttonpressed();
}

//Function Number: 16
incinerator_player_damage()
{
	level.player endon("death");
	var_00 = common_scripts\utility::getstruct("incinerator_fire_damage_source","targetname");
	common_scripts\utility::flag_wait("flag_incinerator_fires_start");
	var_01 = 0;
	var_02 = 1;
	for(var_03 = 0;var_03 < 4;var_03++)
	{
		level waittill("incinerator_flame_on");
		for(var_04 = 0;var_04 < var_02;var_04++)
		{
			if(!common_scripts\utility::flag("flag_incinerator_push_done"))
			{
				wait(0.05);
				level.player dodamage(var_01,var_00.origin);
				continue;
			}

			thread incinerator_rumble_hold(3);
			break;
		}

		var_01 = var_01 + 5;
		var_02 = var_02 + 3;
	}

	var_01 = 0;
	while(!common_scripts\utility::flag("flag_incinerator_push_done"))
	{
		wait(0.5);
		level.player dodamage(var_01,var_00.origin);
		var_01 = var_01 + 0.1;
	}

	common_scripts\utility::flag_wait("lgt_flag_inc_near_miss");
	while(!common_scripts\utility::flag("flag_incinerator_crawl_start"))
	{
		level.player playrumbleonentity("tank_rumble");
		wait(1);
	}

	stopallrumbles();
	var_02 = 1;
	while(!common_scripts\utility::flag("flag_incinerator_player_pipe_grab"))
	{
		wait(var_02);
		level.player dodamage(var_01,var_00.origin);
		var_01 = var_01 + 0.5;
		if(var_02 > 0.05)
		{
			var_05 = randomfloatrange(0.04,0.06);
			var_02 = var_02 - var_05;
		}
	}

	common_scripts\utility::flag_wait("flag_incinerator_player_saved");
	wait(2);
	level.player thread incinerator_player_blur();
	level.player playrumbleonentity("damage_heavy");
	for(var_03 = 0;var_03 < 4;var_03++)
	{
		level.player playrumbleonentity("tank_rumble");
		wait(1);
	}
}

//Function Number: 17
incinerator_rumble_hold(param_00)
{
	level.player endon("death");
	level endon("flag_incinerator_crawl_start");
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		level.player playrumbleonentity("tank_rumble");
		wait(1);
	}
}

//Function Number: 18
incinerator_player_blur()
{
	self endon("death");
	var_00 = 6;
	while(var_00 > 1)
	{
		var_01 = randomfloatrange(1,2);
		setblur(randomfloatrange(0.6666667 * var_00,var_00),var_01);
		wait(var_01);
		setblur(0,var_01);
		wait(var_01);
		wait(randomfloatrange(2,4));
		var_00 = var_00 - 1.2;
	}
}

//Function Number: 19
incinerator_player_wobble()
{
	self endon("death");
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_01 = (randomfloatrange(-6,6),randomfloatrange(-6,6),randomfloatrange(-6,6));
	self playersetgroundreferenceent(var_00);
	var_00 rotateto(var_01,3,randomfloatrange(0.75,1.5),randomfloatrange(0.75,1.5));
	wait(3);
	var_00 rotateto((0,0,0),3,randomfloatrange(0.75,1.5),randomfloatrange(0.75,1.5));
	wait(3);
	self playersetgroundreferenceent(undefined);
	var_00 delete();
}

//Function Number: 20
nt_incinerator_player_saved(param_00)
{
	common_scripts\utility::flag_set("flag_incinerator_player_saved");
}

//Function Number: 21
nt_incinerator_player_pipe_grab(param_00)
{
	soundscripts\_snd::snd_message("aud_incin_pipe_grab");
	common_scripts\utility::flag_set("flag_incinerator_player_pipe_grab");
}

//Function Number: 22
start_battle_to_heli()
{
	maps\captured_util::warp_allies("struct_allystart_battle_to_heli");
	level.player thread maps\_utility::blend_movespeedscale(0.8);
	level.player maps\captured_util::warp_to_start("struct_playerstart_battle_to_heli");
	level.player thread maps\captured_util::start_one_handed_gunplay("iw5_titan45pickup_sp_xmags");
	maps\_player_exo::player_exo_activate();
	soundscripts\_snd::snd_message("start_battle_to_heli");
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
}

//Function Number: 23
main_battle_to_heli()
{
	level thread bh_intro();
	if(level.currentgen)
	{
		if(!istransientloaded("captured_helipad_tr"))
		{
			level waittill("tff_post_incinerator_to_helipad");
		}
	}

	thread maps\captured_util::captured_caravan_spawner("s3_exterior_trucks",undefined,3.5,7,"helipad");
	thread bh_yard_doors();
	level bh_pit();
	level bh_yard();
	level bh_yard_exit();
	level thread run_to_heli_heli_landing();
	common_scripts\utility::flag_wait("flag_bh_run_manticore_done");
}

//Function Number: 24
bh_intro()
{
	level.ally thread maps\_utility::set_force_color("r");
	var_00 = maps\_utility::spawn_targetname("opfor_bh_intro_alarm",1);
	var_00 maps\captured_util::ignore_everything();
	var_00.allowdeath = 1;
	var_01 = common_scripts\utility::getstruct("struct_scene_battle_to_heli_alarm_guard","targetname");
	var_01 thread maps\_anim::anim_loop([var_00],"alarm_start_loop","stop_alarm_loop");
	common_scripts\utility::flag_wait("flag_bh_intro_start_scene");
	if(level.nextgen)
	{
		maps\_utility::autosave_by_name("bh_intro");
	}
	else
	{
		thread bh_intro_autosave();
	}

	var_01 notify("stop_alarm_loop");
	var_00.allowdeath = 1;
	var_01 thread maps\captured_anim::anim_single_to_loop([var_00],"alarm_push","alarm_end_loop","stop_alarm_loop");
	soundscripts\_snd::snd_message("start_outdoor_alarms");
	maps\_utility::delaythread(2.4,::common_scripts\utility::flag_set,"flag_bh_intro_caught");
	maps\_utility::delaythread(2.9,::common_scripts\utility::flag_set,"flag_bh_intro_caught_late");
}

//Function Number: 25
bh_intro_autosave()
{
	common_scripts\utility::flag_wait("flag_bh_intro_currentgen_autosave");
	maps\_utility::autosave_by_name("bh_intro");
}

//Function Number: 26
bh_pit()
{
	common_scripts\utility::flag_wait("flag_bh_pit");
	thread maps\_utility::battlechatter_on("allies");
	thread maps\_utility::battlechatter_on("axis");
	level.nextgrenadedrop = 573000;
	thread bh_helo_flyby();
	maps\_utility::flood_spawn(getentarray("opfor_bh_pit","targetname"));
	maps\captured_util::delay_retreat("opfor_bh",30,-2,"flag_bh_pit_end","color_bh_pit_end",1);
	thread maps\_spawner::killspawner(1300);
	level thread bh_pit_exit(getent("color_bh_yard_start","targetname"),-1 * maps\_utility::get_ai_group_sentient_count("opfor_bh"));
}

//Function Number: 27
bh_pit_exit(param_00,param_01)
{
	level endon("bh_pit_all_clear");
	var_02 = getnodearray("traverse_bh_disconnect","script_noteworthy");
	disconnectnodepair(var_02[0],var_02[1]);
	level thread bh_pit_yard_visblock(getent("visblock_bh_pit_end","targetname"));
	maps\_utility::flood_spawn(getentarray("opfor_bh_pit_exit","targetname"));
	thread maps\captured_util::delay_retreat("opfor_bh",20,param_01 - 1,"flag_bh_pit_all_clear","color_bh_yard_start",1);
	while(!common_scripts\utility::flag("flag_bh_yard") && !common_scripts\utility::flag("flag_bh_pit_all_clear"))
	{
		var_03 = level.player getcurrentweapon();
		if(var_03 != "none" && var_03 != "iw5_kvahazmatknifeonearm_sp" && level.player getammocount(var_03) / weaponclipsize(var_03) >= 0.5)
		{
			break;
		}

		wait(0.05);
	}

	if(common_scripts\utility::flag("flag_bh_yard") || common_scripts\utility::flag("flag_bh_pit_all_clear"))
	{
		level bh_pit_cleanup();
	}

	while(!common_scripts\utility::flag("flag_bh_yard") && !common_scripts\utility::flag("flag_bh_pit_all_clear") && !maps\_utility::player_can_see_ai(level.ally))
	{
		wait(0.05);
	}

	if(common_scripts\utility::flag("flag_bh_yard") || common_scripts\utility::flag("flag_bh_pit_all_clear"))
	{
		level bh_pit_cleanup();
	}

	param_00 common_scripts\utility::trigger_on();
	param_00 waittill("trigger");
	level bh_pit_cleanup();
}

//Function Number: 28
bh_yard()
{
	level.one_handed_help = 1;
	maps\_utility::flood_spawn(getentarray("opfor_bh_yard_ar","targetname"));
	maps\_utility::flagwaitthread("flag_bh_yard",::maps\_utility::flood_spawn,getentarray("opfor_bh_yard_smg","targetname"));
	maps\_utility::flagwaitthread("flag_bh_runaway",::common_scripts\utility::flag_set,"flag_bh_back");
	maps\captured_util::delay_retreat("opfor_bh",120,[-9,3],"flag_bh_back","color_bh_back",1);
	getent("color_bh_yard","targetname") delete();
	thread maps\_spawner::killspawner(1302);
	maps\_utility::flood_spawn(getentarray("opfor_bh_yard_exit","targetname"));
	maps\captured_util::delay_retreat("opfor_bh",90,0,"flag_bh_runaway","color_bh_runaway",1);
	level.player thread maps\captured_util::one_handed_modify_threatbias("standard");
	var_00 = getent("trig_bh_open_yard_doors","targetname");
	var_00 maps\_utility::flagwaitthread("gps_bh_mech_loader_room",::common_scripts\utility::trigger_on);
	level.player maps\_utility::flagwaitthread("gps_bh_mech_loader_room",::maps\captured_util::one_handed_modify_threatbias,"aggro");
	thread bh_run_mechs();
	level.one_handed_help = undefined;
	thread maps\_spawner::killspawner(1303);
}

//Function Number: 29
bh_yard_exit()
{
	var_00 = getentarray("door_bh_yard","targetname");
	level.ally maps\_utility::disable_ai_color();
	level.ally maps\_utility::follow_path(getnode("node_bh_yard_exit","targetname"));
	wait(0.5);
	while(distance2d(level.ally.origin,level.player.origin) > 160 && !common_scripts\utility::flag("gps_bh_mech_loader_room"))
	{
		wait(0.05);
	}

	level.player notify("gps_bh_mech_loader_room_stop_flagWaitThread");
	level.player thread maps\captured_util::one_handed_modify_threatbias("default");
	level notify("bh_doors_manual");
	soundscripts\_snd::snd_message("aud_door","yard_doors","open");
	foreach(var_02 in var_00)
	{
		var_02 moveto(var_02.open,1.25,0.2,0.5);
		var_02.link common_scripts\utility::delaycall(0.75,::connectpaths);
	}

	level.ally maps\_utility::enable_cqbwalk();
	var_04 = common_scripts\utility::getstruct("struct_run_to_heli_manticore","targetname");
	var_04 maps\_anim::anim_reach_solo(level.ally,"runtoheli_window_start");
	level notify("bh_ally_start_manticore_anims");
	var_04 thread maps\captured_anim::anim_single_to_loop(level.ally,"runtoheli_window_start","runtoheli_window_loop","runtoheli_window_ender");
	thread rh_loader_movement();
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	for(;;)
	{
		common_scripts\utility::flag_wait("gps_bh_mech_loader_room");
		soundscripts\_snd::snd_message("aud_door","yard_doors","close");
		foreach(var_02 in var_00)
		{
			var_02 moveto(var_02.close,1.25,0.2,0.5);
			var_02.link common_scripts\utility::delaycall(0.5,::disconnectpaths);
			var_02.link common_scripts\utility::delaycall(0.75,::disconnectpaths);
		}

		wait(1.25);
		if(common_scripts\utility::flag("gps_bh_mech_loader_room"))
		{
			break;
		}

		soundscripts\_snd::snd_message("aud_door","yard_doors","open");
		wait(0.25);
		foreach(var_02 in var_00)
		{
			var_02 moveto(var_02.open,1.25,0.2,0.5);
			var_02.link common_scripts\utility::delaycall(0.5,::connectpaths);
		}

		wait(1.25);
	}

	var_09 = getent("gps_bh_mech_loader_room","targetname");
	var_0A = maps\_utility::get_ai_group_ai("opfor_bh");
	foreach(var_0C in var_0A)
	{
		if(!var_0C istouching(var_09))
		{
			var_0C notify("stop_opfor_one_handed");
			var_0C delete();
		}
	}
}

//Function Number: 30
bh_helo_flyby()
{
	var_00 = getent("vehicle_bh_warbird_ambient","targetname");
	var_01 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_01 soundscripts\_snd::snd_message("aud_heli_battle_flyover");
	if(level.currentgen)
	{
		var_01 thread maps\captured_util::tff_cleanup_vehicle("helipad");
	}

	var_01 maps\_vehicle::godon();
	thread maps\captured_fx::fx_heli_flyby_dust(var_01);
}

//Function Number: 31
bh_pit_yard_visblock(param_00)
{
	param_00 movez(256,0.05);
	common_scripts\utility::flag_wait("flag_bh_pit_all_clear");
	param_00 maps\_utility::delaythread(30,::maps\_utility::_delete);
	param_00 maps\_utility::flagwaitthread(["flag_bh_yard",15],::maps\_utility::_delete);
	while(isdefined(param_00))
	{
		level waittill("ai_killed",var_01);
		if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "opfor_bh_pit")
		{
			continue;
		}

		if(isdefined(var_01.lastattacker) && isplayer(var_01.lastattacker))
		{
			break;
		}
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 32
bh_yard_doors()
{
	level endon("bh_doors_manual");
	var_00 = common_scripts\utility::getstruct("door_bh_yard_close","targetname");
	var_01 = getentarray("door_bh_yard","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = getent(var_03.target,"targetname");
		var_04 linkto(var_03);
		var_03.link = var_04;
		var_03.open = var_03.origin;
		var_03.close = var_00.origin;
		var_03 moveto(var_03.close,0.05);
	}

	for(;;)
	{
		common_scripts\utility::flag_wait_either("flag_bh_open_yard_doors_in","flag_bh_open_yard_doors_out");
		soundscripts\_snd::snd_message("aud_door","yard_doors","open");
		foreach(var_03 in var_01)
		{
			var_03 moveto(var_03.open,1.25,0.2,0.5);
			var_03.link common_scripts\utility::delaycall(0.5,::connectpaths);
		}

		wait(1.5);
		while(common_scripts\utility::flag("flag_bh_open_yard_doors_in") || common_scripts\utility::flag("flag_bh_open_yard_doors_out"))
		{
			wait(0.05);
		}

		soundscripts\_snd::snd_message("aud_door","yard_doors","close");
		foreach(var_03 in var_01)
		{
			var_03 moveto(var_03.close,1.25,0.2,0.5);
			var_03.link common_scripts\utility::delaycall(0.5,::disconnectpaths);
		}
	}
}

//Function Number: 33
bh_pit_cleanup()
{
	thread maps\_spawner::killspawner(1301);
	maps\_utility::autosave_by_name("bh_yard");
	var_00 = maps\_utility::get_living_ai_array("opfor_bh_pit_exit_AI","targetname");
	maps\_utility::delaythread(randomfloat(1),::common_scripts\utility::array_thread,var_00,::maps\_utility::follow_path,getnode("cover_bh_yard","targetname"));
	if(!common_scripts\utility::flag("flag_bh_pit_all_clear"))
	{
		common_scripts\utility::flag_set("flag_bh_pit_all_clear");
	}

	wait(0.05);
	if(common_scripts\utility::flag("flag_bh_yard"))
	{
		getent("color_bh_yard","targetname") notify("trigger");
	}

	level notify("bh_pit_all_clear");
}

//Function Number: 34
start_run_to_heli()
{
	maps\captured_util::warp_allies("struct_allystart_run_to_heli");
	level.ally thread maps\_utility::set_force_color("r");
	getent("color_bh_runaway","targetname") notify("trigger");
	thread bh_run_mechs();
	thread rh_loader_movement();
	level.ally maps\_utility::enable_cqbwalk();
	var_00 = common_scripts\utility::getstruct("struct_run_to_heli_manticore","targetname");
	var_00 maps\_anim::anim_reach_solo(level.ally,"runtoheli_window_start");
	level notify("bh_ally_start_manticore_anims");
	var_00 thread maps\captured_anim::anim_single_to_loop(level.ally,"runtoheli_window_start","runtoheli_window_loop","runtoheli_window_ender");
	level.player thread maps\_utility::blend_movespeedscale(0.8);
	level.player maps\captured_util::warp_to_start("struct_playerstart_run_to_heli");
	level.player thread maps\captured_util::start_one_handed_gunplay("iw5_titan45pickup_sp_xmags");
	maps\_player_exo::player_exo_activate();
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	level thread maps\captured_util::captured_caravan_spawner("s3_exterior_trucks",undefined,3.5,7,"helipad");
	level thread run_to_heli_heli_landing();
}

//Function Number: 35
main_run_to_heli()
{
	run_to_heli_manticore_scene(level.rh_exit_door);
	thread bh_attacker_accuracy_increaser();
	var_00 = maps\_utility::spawn_targetname("opfor_bh_helo_stairs");
	level.ally maps\_utility::disable_cqbwalk();
	level.ally.ignoreall = 0;
	thread bh_run_civilians();
	common_scripts\utility::flag_set("flag_bh_run");
	level.ally maps\_utility::disable_ai_color();
	level.ally thread maps\_utility::follow_path(getnode("node_bh_run","targetname"));
	setsaveddvar("player_sprintUnlimited","1");
	level notify("stop_caravan_spawner");
	var_01 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("veh_bh_explo");
	var_02 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("veh_bh_mid");
	var_01 soundscripts\_snd::snd_message("aud_cap_escape_to_heli_truck_1");
	var_02 soundscripts\_snd::snd_message("aud_cap_escape_to_heli_truck_2");
	if(level.currentgen)
	{
		var_01 thread maps\captured_util::tff_cleanup_vehicle("helipad");
		var_02 thread maps\captured_util::tff_cleanup_vehicle("helipad");
	}

	wait(1.5);
	if(!common_scripts\utility::flag("flag_bh_helo_opfor_stairs"))
	{
		level.ally shoot();
		maps\_utility::kill_deathflag("flag_bh_helo_opfor_stairs");
	}

	wait(2.2);
	level.ally shoot();
	common_scripts\utility::flag_wait("flag_battle_to_heli_end");
}

//Function Number: 36
run_to_heli_heli_landing()
{
	common_scripts\_exploder::exploder("fx_heli_flyby_dust_settle");
	var_00 = getent("vehicle_bh_warbird","targetname");
	var_01 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_01 soundscripts\_snd::snd_message("aud_heli_manticore_flyover");
	var_01 soundscripts\_snd::snd_message("aud_heli_escape_idle_sfx");
	if(level.currentgen)
	{
		var_01 thread maps\captured_util::tff_cleanup_vehicle("helipad");
	}

	var_01 thread setup_warbird();
	thread maps\captured_fx::fx_heli_manticore_dust(var_01);
}

//Function Number: 37
run_to_heli_manticore_scene(param_00)
{
	level endon("run_to_heli_failed");
	level notify("lgt_dof_run_to_heli");
	level.ally maps\captured_util::ignore_everything();
	level.player.ignoreme = 1;
	var_01 = common_scripts\utility::getstruct("struct_run_to_heli_manticore","targetname");
	common_scripts\utility::flag_wait("flag_player_and_ally_at_window");
	var_02 = maps\_utility::array_spawn_targetname("opfor_bh_at_helo",1);
	common_scripts\utility::array_thread(var_02,::maps\_utility::set_baseaccuracy,0.01);
	thread bh_heli_enemy_killer(var_02,var_01);
	common_scripts\utility::flag_waitopen("flag_currently_nagging");
	wait(1);
	var_03 = getanimlength(level.ally maps\_utility::getanim("runtoheli_window_start"));
	var_04 = level.ally getanimtime(level.ally maps\_utility::getanim("runtoheli_window_start"));
	if(var_04 > 0)
	{
		wait(var_03 - var_04 * var_03);
	}

	var_01 notify("runtoheli_window_ender");
	var_01 maps\_anim::anim_single_solo(level.ally,"runtoheli_window");
	var_01 thread maps\captured_anim::anim_single_to_loop(level.ally,"runtoheli_door_start","runtoheli_door_loop","runtoheli_door_ender");
	var_05 = getanimlength(level.ally maps\_utility::getanim("runtoheli_door_start"));
	wait(var_05);
	common_scripts\utility::flag_set("flag_bh_run_ally_ready");
	for(var_06 = 0;var_06 < 15;var_06++)
	{
		if(maps\_utility::player_can_see_ai(level.ally))
		{
			break;
		}

		wait(0.5);
	}

	thread maps\_utility::autosave_now();
	var_01 notify("runtoheli_door_ender");
	var_01 thread maps\_anim::anim_single_solo(level.ally,"runtoheli_door_kick");
	var_01 thread maps\_anim::anim_single_solo(param_00,"runtoheli_door_kick");
	param_00.col connectpaths();
	level notify("stop_caravan_spawner");
}

//Function Number: 38
bh_attacker_accuracy_increaser()
{
	level.player endon("death");
	level endon("flag_heliride_warbird_mount");
	level.player maps\_utility::set_player_attacker_accuracy(0.01);
	common_scripts\utility::flag_wait("flag_bh_run");
	var_00 = 0.01;
	var_01 = 0.01;
	var_02 = 1;
	var_03 = 1;
	for(;;)
	{
		if(common_scripts\utility::flag("flag_runtoheli_player_bounds"))
		{
			var_02 = var_02 + 3;
		}
		else
		{
			var_02 = 0.25;
		}

		if(var_02 > 10)
		{
			level.player dodamage(500,(12248,-12629,-1948));
		}

		if(var_00 > 0.01)
		{
			var_01 = var_01 * var_02;
		}

		level.player maps\_utility::set_player_attacker_accuracy(var_01);
		var_00 = var_00 + 0.01;
		var_01 = var_00;
		if(level.player maps\_player_exo::overdrive_is_on() && common_scripts\utility::flag("flag_runtoheli_player_bounds"))
		{
			var_03 = 0.2;
		}
		else
		{
			var_03 = 0.4;
		}

		wait(var_03);
		if(var_00 > 0.4)
		{
			break;
		}
	}

	var_04 = getent("trigger_battle_to_heli_end","targetname");
	var_04 delete();
	level notify("run_to_heli_failed");
	level._facility.warbird maps\_vehicle::godoff();
	level._facility.warbird.perferred_crash_location = level._facility.warbird;
	level._facility.warbird maps\_utility::destructible_force_explosion();
	level.ally maps\_utility::stop_magic_bullet_shield();
	level.ally kill();
	setdvar("ui_deadquote",&"CAPTURED_FAIL_GIDEON_KILLED");
	thread maps\_utility::missionfailedwrapper();
}

//Function Number: 39
bh_run_civilians()
{
	level endon("run_to_heli_failed");
	wait(1);
	var_00 = maps\_utility::array_spawn_targetname("run_to_heli_civilians");
	foreach(var_02 in var_00)
	{
		var_02.team = "allies";
		var_02.diequietly = 1;
	}

	common_scripts\utility::array_thread(var_00,::maps\captured_util::ignore_everything);
	common_scripts\utility::flag_wait("flag_heliride_warbird_mount");
	var_00 = maps\_utility::remove_dead_from_array(var_00);
	maps\_utility::array_kill(var_00);
}

//Function Number: 40
bh_run_mechs()
{
	level endon("run_to_heli_failed");
	var_00 = maps\_utility::array_spawn(getentarray("opfor_bh_mech","targetname"),1);
	common_scripts\utility::array_thread(var_00,::maps\captured_util::ignore_everything);
	var_01 = getdvarfloat("ai_eventDistGunshot");
	setsaveddvar("ai_eventDistGunshot",0);
	var_02 = maps\_utility::array_spawn(getentarray("run_to_heli_mechanic","targetname"),1);
	common_scripts\utility::array_thread(var_02,::maps\captured_util::ignore_everything);
	var_02[0].animname = "worker_1";
	var_02[1].animname = "worker_2";
	var_03 = common_scripts\utility::getstruct("struct_runtoheli_mech_worker_1","targetname");
	var_04 = common_scripts\utility::getstruct("struct_runtoheli_mech_worker_2","targetname");
	var_03 thread maps\_anim::anim_loop_solo(var_02[0],"runtoheli_worker_window_loop_1");
	var_04 thread maps\_anim::anim_loop_solo(var_02[1],"runtoheli_worker_window_loop_2");
	maps\_utility::trigger_wait_targetname("run_to_heli_exited_door");
	maps\_utility::array_delete(var_02);
	var_05 = getent("door_bh_mech","targetname");
	var_06 = getent("door_bh_mech_door_cover","targetname");
	var_06 hide();
	var_06 notsolid();
	var_05 movez(100,6,0,0.5);
	var_07 = getnodearray("bh_run_mech_node","targetname");
	wait(3);
	common_scripts\utility::array_thread(var_00,::maps\captured_util::unignore_everything);
	setsaveddvar("ai_eventDistGunshot",var_01);
	wait(3);
	var_08 = 0;
	foreach(var_0A in var_00)
	{
		if(isalive(var_0A))
		{
			var_0A notify("stop_hunting");
			var_0A thread maps\_mech::mech_generic_attacking_behavior();
			var_0A.walkdist = 999999;
			var_0A.walkdistfacingmotion = var_0A.walkdist;
			var_0A.goalradius = 80;
			var_0A thread maps\_utility::follow_path(var_07[var_08]);
			var_08 = var_08 + 1;
			wait(randomfloatrange(1,3));
		}
	}
}

//Function Number: 41
bh_heli_enemy_killer(param_00,param_01)
{
	level endon("run_to_heli_failed");
	level._facility.warbird thread vehicle_scripts\_xh9_warbird::open_left_door();
	param_01 waittill("runtoheli_door_ender");
	wait(4);
	level.player.ignoreme = 0;
	foreach(var_03 in param_00)
	{
		if(isalive(var_03))
		{
			var_03 maps\_utility::set_ignoresuppression(1);
		}
	}

	wait(3);
	var_05 = 1;
	foreach(var_03 in param_00)
	{
		if(isalive(var_03))
		{
			level.ally shoot();
			level.ally shoot();
			maps\_utility::kill_deathflag(var_03.script_deathflag);
		}

		wait(randomfloatrange(0.5,1.5));
	}
}

//Function Number: 42
bh_cleanup()
{
	var_00 = getentarray("opfor_bh_helo","targetname");
	foreach(var_02 in var_00)
	{
		var_02 notify("stop current floodspawner");
	}

	var_04 = getaiarray("axis");
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.targetname))
		{
			if(var_06.targetname != "actor_player_mech_AI")
			{
				var_06.diequietly = 1;
			}
		}
	}

	maps\_utility::kill_deathflag("flag_bh_helo_opfor_killed");
	maps\_utility::kill_deathflag("flag_bh_helo_opfor_killed_1");
	maps\_utility::kill_deathflag("flag_bh_helo_opfor_killed_2");
	maps\_utility::kill_deathflag("flag_bh_helo_opfor_killed_3");
	maps\_utility::kill_deathflag("flag_bh_opfor_killed");
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06) && isalive(var_06))
		{
			if(!var_06 == level.pilot || var_06 == level.mech_pilot)
			{
				if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
				{
					var_06 maps\_utility::stop_magic_bullet_shield();
				}

				if(isdefined(var_06.targetname))
				{
					if(var_06.targetname != "actor_player_mech_AI")
					{
						var_06 delete();
					}
				}
			}
		}
	}

	level.player notify("stop_one_handed_gunplay");
	setsaveddvar("player_sprintUnlimited","0");
}

//Function Number: 43
rh_loader_movement()
{
	level endon("run_to_heli_failed");
	level endon("stop_caravan_spawner");
	var_00 = undefined;
	var_01 = getent("crane_straps","targetname");
	var_02 = getent("rh_crane_front","targetname");
	var_03 = getentarray("manticore_pallet_moving","targetname");
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_00))
		{
			var_00 = var_05;
			continue;
		}

		var_05 linkto(var_00);
	}

	var_07 = getent("rh_crane_back","targetname");
	playfxontag(level._effect["cap_crane_light"],var_02,"crane_T");
	playfxontag(level._effect["cap_crane_light"],var_07,"crane_T");
	soundscripts\_snd::snd_message("aud_manticore_crane");
	var_02 movey(240,10,2,2);
	var_01 movey(240,10,2,2);
	var_00 movey(240,10,2,2);
	wait(10);
	var_01 movez(-122,8,2,2);
	var_00 movez(-122,8,2,2);
	wait(9);
	var_01 movez(60,4,2,2);
	wait(4);
	var_02 movey(-400,15,2,2);
	var_01 movey(-400,15,2,2);
	wait(15);
	var_07 movex(-460,10,2,2);
	wait(10);
	var_07 movex(460,10,2,2);
}

//Function Number: 44
setup_spawners()
{
	maps\_utility::array_spawn_function(getentarray("opfor_bh_pit","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_pit_exit","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_yard_ar","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_yard_pyr_ar","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_yard_smg","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_yard_pyr_smg","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_yard_exit","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_helo","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_helo_stairs","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_at_helo","targetname"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("cover_bh_run","target"),::opfor_bh);
	maps\_utility::array_spawn_function(getentarray("opfor_bh_intro_alarm","targetname"),::actor_alarm_guard);
}

//Function Number: 45
opfor_bh()
{
	self endon("death");
	level endon("run_to_heli_failed");
	thread maps\captured_util::opfor_death_mod();
	thread maps\captured_util::opfor_ammo_drop_mod();
	thread maps\_utility::set_grenadeammo(int(max(0,randomintrange(-3,3))));
	var_00 = undefined;
	if(isdefined(self.target,"targetname"))
	{
		var_00 = getentarray(self.target,"targetname");
	}

	while(isdefined(var_00) && var_00.size > 0)
	{
		var_01 = randomint(var_00.size);
		if(isdefined(var_00[var_01].target) && isdefined(var_00[var_01].script_flag_wait) && common_scripts\utility::flag(var_00[var_01].script_flag_wait))
		{
			var_00 = getentarray(var_00[var_01].target,"targetname");
			continue;
		}

		thread maps\_utility::follow_path(var_00[var_01]);
		break;
	}
}

//Function Number: 46
actor_alarm_guard()
{
	self endon("death");
	self.no_friendly_fire_penalty = 1;
	self.animname = "op_alarm";
}

//Function Number: 47
main_heliride()
{
	thread vtol_sequence();
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	common_scripts\_exploder::exploder("fx_heli_flyby_dust_settle");
	common_scripts\_exploder::exploder("fx_heli_dust_settle");
	common_scripts\utility::flag_wait("flag_heliride_warbird_mount");
	setsaveddvar("g_friendlyNameDist",0);
	common_scripts\utility::flag_set("flag_battle_to_heli_end");
	soundscripts\_snd::snd_message("stop_post_courtyard_ext_alarms_2");
	common_scripts\utility::array_thread(getentarray("trig_mb1","script_noteworthy"),::common_scripts\utility::trigger_off);
	common_scripts\utility::array_thread(getentarray("trig_mb2","script_noteworthy"),::common_scripts\utility::trigger_off);
	maps\_utility::flood_spawn(getentarray("opfor_bh_helo","targetname"));
	level thread maps\captured_fx::fx_heli_ride();
	common_scripts\utility::flag_wait("flag_heliride_end");
	common_scripts\utility::array_thread(getentarray("trig_mb1","script_noteworthy"),::common_scripts\utility::trigger_on);
	common_scripts\utility::array_thread(getentarray("trig_mb2","script_noteworthy"),::common_scripts\utility::trigger_on);
}

//Function Number: 48
vtol_sequence()
{
	level endon("run_to_heli_failed");
	level.player endon("death");
	var_00 = level._facility.warbird;
	var_00.animname = "warbird";
	common_scripts\utility::flag_wait("flag_heliride_warbird_mount");
	level.player common_scripts\utility::delaycall(6.25,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(9.45,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(12.45,::playrumbleonentity,"light_2s");
	level.player common_scripts\utility::delaycall(15,::playrumbleonentity,"heavy_3s");
	level.player common_scripts\utility::delaycall(18,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(19.75,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(21,::playrumbleonentity,"heavy_3s");
	level.player common_scripts\utility::delaycall(25.25,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(26.4,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(26.75,::playrumbleonentity,"heavy_3s");
	setsaveddvar("ammoCounterHide","1");
	level.player notify("stop_one_handed_gunplay");
	level.player stopsliding();
	level.player allowpowerslide(0);
	level.player setstance("stand");
	level.player freezecontrols(1);
	level.player allowcrouch(0);
	level.player allowjump(0);
	level.player allowmelee(0);
	level.player allowprone(0);
	level.player allowsprint(0);
	var_01 = spawnstruct();
	var_01.origin = (10401.94,-5807.297,637.251);
	level.glass = spawn("script_model",var_01.origin);
	level.glass setmodel("vehicle_xh9_warbird_interior_glass");
	level.glass linkto(level._facility.warbird,"tag_origin",(0,0,0),(0,0,0));
	level.glass hide();
	level.glass_broken = spawn("script_model",var_01.origin);
	level.glass_broken setmodel("vehicle_xh9_warbird_interior_glass_brkn");
	level.glass_broken linkto(level._facility.warbird,"tag_origin",(0,0,0),(0,0,0));
	level.glass_broken hide();
	maps\_player_exo::player_exo_deactivate();
	level.player maps\_utility::player_speed_default();
	level.ally maps\_utility::disable_heat_behavior();
	level.ally maps\captured_util::unignore_everything();
	level.player maps\_utility::set_player_attacker_accuracy(1);
	level.player enableinvulnerability();
	maps\_utility::autosave_by_name("heliride");
	level.player_rig = maps\_utility::spawn_anim_model("player_rig");
	level.player_rig hide();
	var_02 = getent("heliride_mech_pilot","targetname");
	level.mech_pilot = var_02 maps\_utility::spawn_ai(1);
	level.mech_pilot.animname = "heli_mech_pilot";
	var_03 = getent("heliride_pilot","targetname");
	level.pilot = var_03 maps\_utility::spawn_ai(1);
	level.pilot.animname = "heli_pilot";
	var_04 = maps\_utility::spawn_anim_model("heli_mech");
	var_05 = [level.ally,var_00,level.pilot,var_04,level.mech_pilot];
	var_01 thread maps\_anim::anim_single_solo(level.player_rig,"warbird_scene_begin");
	thread heliride_rockets_and_slowmo();
	level.player disableweapons();
	level notify("all_heliride_pieces_spawned");
	level.player playerlinktoblend(level.player_rig,"tag_player",0.5);
	var_06 = getanimlength(level.player_rig maps\_utility::getanim("warbird_scene_begin"));
	thread bh_cleanup();
	wait(var_06);
	level.player_rig show();
	var_01 thread warbird_anims(var_05);
	var_01 maps\_anim::anim_single_solo(level.player_rig,"warbird_scene");
	var_07 = maps\_hud_util::create_client_overlay("black",1,level.player);
	level notify("heli_ride_crashed");
	level.player showviewmodel();
	var_00 delete();
	level.player_rig delete();
	var_04 delete();
	level.pilot delete();
	level.mech_pilot delete();
	level.player disableinvulnerability();
	if(isdefined(common_scripts\utility::getstruct("struct_playerstart_mb1","targetname")))
	{
		level.player maps\captured_util::warp_to_start("struct_playerstart_mb1");
	}

	if(level.currentgen)
	{
		if(!istransientloaded("captured_mechbattle_tr"))
		{
			level notify("tff_pre_helipad_to_mechbattle");
			unloadtransient("captured_helipad_tr");
			loadtransient("captured_mechbattle_tr");
			while(!istransientloaded("captured_mechbattle_tr"))
			{
				wait(0.05);
			}

			level notify("tff_post_helipad_to_mechbattle");
		}
	}

	wait(5.1);
	var_07 fadeovertime(5);
	var_07.alpha = 0;
	thread maps\captured_fx::fx_heli_crash_hero_falling_dust();
	setsaveddvar("ammoCounterHide","0");
	common_scripts\utility::flag_set("flag_heliride_end");
}

//Function Number: 49
warbird_anims(param_00)
{
	thread maps\_anim::anim_single(param_00,"warbird_scene");
	level waittill("heliride_blood");
	level.glass show();
	level waittill("heliride_punch");
	level.glass hide();
	level.glass_broken show();
	common_scripts\utility::flag_wait("flag_heliride_end");
	level.glass delete();
	level.glass_broken delete();
}

//Function Number: 50
heliride_rockets_and_slowmo()
{
	level endon("run_to_heli_failed");
	level.player endon("death");
	wait(4);
	var_00 = common_scripts\utility::getstruct("heliride_rocket_start","targetname");
	var_01 = common_scripts\utility::getstruct("heliride_rocket_end_01","targetname");
	var_02 = magicbullet("iw5_mahemstraight_sp",var_00.origin,var_01.origin);
	wait(1.5);
	var_01 = common_scripts\utility::getstruct("heliride_rocket_end_02","targetname");
	var_02 = magicbullet("iw5_mahemstraight_sp",var_00.origin,var_01.origin);
	level waittill("heliride_slowmo_start");
	settimescale(0.75);
	level waittill("heliride_slowmo_end");
	settimescale(1);
}

//Function Number: 51
nt_warbird_mech_link(param_00)
{
	var_01 = param_00;
	var_01 vehicle_jetbikesethoverforcescale(level._facility.warbird,"tag_origin",(0,0,0),(0,0,0));
}

//Function Number: 52
nt_warbird_anims_start(param_00)
{
	level notify("heliride_start");
}

//Function Number: 53
nt_helicrash_slowstart(param_00)
{
	level notify("heliride_slowmo_start");
}

//Function Number: 54
nt_helicrash_slowend(param_00)
{
	level notify("heliride_slowmo_end");
}