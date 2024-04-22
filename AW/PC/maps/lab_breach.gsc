/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lab_breach.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 468 ms
 * Timestamp: 4/22/2024 2:32:37 AM
*******************************************************************/

//Function Number: 1
init_facility_breach()
{
	common_scripts\utility::flag_init("breach_done");
	common_scripts\utility::flag_init("lab_breach_all_guys_dead");
	common_scripts\utility::flag_init("flag_burke_kills_guy");
	common_scripts\utility::flag_init("burke_is_in_position_for_facility_breach");
	level.breachfriendlies = [];
	level.breachfriendlies[level.breachfriendlies.size] = level.burke;
	level.breachfriendlies[level.breachfriendlies.size] = level.cormack;
	level.breachfriendlies[level.breachfriendlies.size] = level.knox;
	var_00 = "none";
	if(level.currentgen)
	{
		if(istransientloaded("lab_intro_tr"))
		{
			var_00 = "intro";
		}
		else if(istransientloaded("lab_middle_tr"))
		{
			var_00 = "middle";
		}
		else if(istransientloaded("lab_outro_tr"))
		{
			var_00 = "outro";
		}
	}

	init_facility_breach_anims(var_00);
	if(level.currentgen)
	{
		if(var_00 == "intro")
		{
			thread notetrack_setup_middle();
		}

		if(var_00 == "intro" || var_00 == "middle")
		{
			thread notetrack_setup_outro();
		}
	}
}

//Function Number: 2
init_facility_breach_anims(param_00)
{
	init_facility_breach_model_anims(param_00);
	init_facility_breach_npc_anims(param_00);
	init_facility_breach_view_model_anims(param_00);
}

//Function Number: 3
init_facility_breach_model_anims(param_00)
{
	level.scr_animtree["facility_breach_charge"] = #animtree;
	level.scr_model["facility_breach_charge"] = "breach_charge";
	level.scr_anim["facility_breach_charge"]["facility_breach"] = %lab_breachroom_breach_charge;
	level.scr_animtree["facility_breach_mute_device"] = #animtree;
	level.scr_model["facility_breach_mute_device"] = "muteCharge";
	level.scr_anim["facility_breach_mute_device"]["facility_breach"] = %lab_breachroom_breach_mute;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("facility_breach_mute_device","vfx_mute_device_plant",::maps\lab_fx::mute_device_plant_fx,"facility_breach");
	}

	level.scr_animtree["facility_breach_crate"] = #animtree;
	level.scr_model["facility_breach_crate"] = "genericProp";
	level.scr_anim["facility_breach_crate"]["facility_breach"] = %lab_breachroom_breach_box;
}

//Function Number: 4
init_facility_breach_npc_anims(param_00)
{
	level.scr_anim["burke"]["facility_breach"] = %lab_breachroom_breach_hero_01;
	level.scr_anim["burke"]["facility_breach_idle"][0] = %lab_breachroom_breach_hero_01_idle;
	level.scr_anim["burke"]["facility_breach_end"] = %lab_breachroom_breach_hero_01_exit;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("burke","interrupt_anim",::no_interrupt,"facility_breach");
		maps\_anim::addnotetrack_customfunction("burke","glass_break",::break_glass,"facility_breach");
	}

	level.facility_breach_guys = [];
	level.facility_breach_guys[0] = getent("facility_breach_guy_01","targetname");
	level.facility_breach_guys[0].animname = "facility_breach_guy_01";
	level.scr_anim["facility_breach_guy_01"]["facility_breach"] = %lab_breachroom_breach_guy_01;
	level.facility_breach_guys[1] = getent("facility_breach_guy_02","targetname");
	level.facility_breach_guys[1].animname = "facility_breach_guy_02";
	level.scr_anim["facility_breach_guy_02"]["facility_breach"] = %lab_breachroom_breach_guy_02;
	level.facility_breach_guys[2] = getent("facility_breach_guy_03","targetname");
	level.facility_breach_guys[2].animname = "facility_breach_guy_03";
	level.scr_anim["facility_breach_guy_03"]["facility_breach"] = %lab_breachroom_breach_guy_03;
	level.facility_breach_guys[3] = getent("facility_breach_guy_04","targetname");
	level.facility_breach_guys[3].animname = "facility_breach_guy_04";
	level.scr_anim["facility_breach_guy_04"]["facility_breach"] = %lab_breachroom_breach_guy_04;
	level.facility_breach_guys[4] = getent("facility_breach_guy_05","targetname");
	level.facility_breach_guys[4].animname = "facility_breach_guy_05";
	level.scr_anim["facility_breach_guy_05"]["facility_breach"] = %lab_breachroom_breach_guy_05;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("facility_breach_guy_05","start_ragdoll",::maps\lab_anim::ai_kill,"facility_breach");
	}
}

//Function Number: 5
init_facility_breach_view_model_anims(param_00)
{
	level.scr_anim["player_rig"]["facility_breach"] = %lab_breachroom_breach_vm;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("player_rig","Start_slowdown",::breach_slow_down,"facility_breach");
		maps\_anim::addnotetrack_customfunction("player_rig","Blow_charge",::blow_door,"facility_breach");
		maps\_anim::addnotetrack_customfunction("player_rig","enable_player_control",::enable_player_control,"facility_breach");
	}
}

//Function Number: 6
notetrack_setup_middle()
{
	level waittill("tff_post_intro_to_middle");
	maps\_anim::addnotetrack_customfunction("facility_breach_mute_device","vfx_mute_device_plant",::maps\lab_fx::mute_device_plant_fx,"facility_breach");
	maps\_anim::addnotetrack_customfunction("burke","interrupt_anim",::no_interrupt,"facility_breach");
	maps\_anim::addnotetrack_customfunction("burke","glass_break",::break_glass,"facility_breach");
	maps\_anim::addnotetrack_customfunction("facility_breach_guy_05","start_ragdoll",::maps\lab_anim::ai_kill,"facility_breach");
	maps\_anim::addnotetrack_customfunction("player_rig","Start_slowdown",::breach_slow_down,"facility_breach");
	maps\_anim::addnotetrack_customfunction("player_rig","Blow_charge",::blow_door,"facility_breach");
	maps\_anim::addnotetrack_customfunction("player_rig","enable_player_control",::enable_player_control,"facility_breach");
}

//Function Number: 7
notetrack_setup_outro()
{
	level waittill("tff_post_middle_to_outro");
}

//Function Number: 8
facility_breach_get_burke_into_position()
{
	var_00 = getnode("node_burke_facility_breach","targetname");
	level.burke setgoalnode(var_00);
	var_01 = level.burke.goalradius;
	level.burke.goalradius = 16;
	level.burke waittill("goal");
	level.burke.goalradius = var_01;
	common_scripts\utility::flag_set("burke_is_in_position_for_facility_breach");
}

//Function Number: 9
facility_breach_spawn_bad_guys(param_00)
{
	level.facility_breach_guys = [];
	level.facility_breach_guys[0] = getent("facility_breach_guy_01","targetname") maps\_utility::spawn_ai(1);
	level.facility_breach_guys[0].animname = "facility_breach_guy_01";
	level.facility_breach_guys[1] = getent("facility_breach_guy_02","targetname") maps\_utility::spawn_ai(1);
	level.facility_breach_guys[1].animname = "facility_breach_guy_02";
	level.facility_breach_guys[2] = getent("facility_breach_guy_03","targetname") maps\_utility::spawn_ai(1);
	level.facility_breach_guys[2].animname = "facility_breach_guy_03";
	level.facility_breach_guys[3] = getent("facility_breach_guy_04","targetname") maps\_utility::spawn_ai(1);
	level.facility_breach_guys[3].animname = "facility_breach_guy_04";
	level.facility_breach_guys[4] = getent("facility_breach_guy_05","targetname") maps\_utility::spawn_ai(1);
	level.facility_breach_guys[4].animname = "facility_breach_guy_05";
	param_00 maps\_anim::anim_first_frame(level.facility_breach_guys,"facility_breach");
	foreach(var_02 in level.facility_breach_guys)
	{
		level thread breach_enemy_track_status(var_02);
		var_02.allowdeath = 1;
		var_02.health = 10;
		var_02 maps\_utility::disable_surprise();
		var_02.ignoresonicaoe = 1;
	}
}

//Function Number: 10
facility_breach()
{
	common_scripts\utility::flag_wait("burke_is_in_position_for_facility_breach");
	var_00 = getent("facility_breach_trigger","targetname");
	var_00 thread maps\_utility::addhinttrigger(&"LAB_PLANT_MUTE_HINT",&"LAB_PLANT_MUTE_HINT_PC");
	var_00 thread maps\lab_utility::disable_trigger_while_player_animating("breaching");
	var_01 = var_00 maps\_shg_utility::hint_button_trigger("x");
	for(;;)
	{
		var_00 waittill("trigger");
		if(!isdefined(var_00.trigger_off))
		{
			break;
		}
	}

	var_00 delete();
	var_01 maps\_shg_utility::hint_button_clear();
	common_scripts\utility::flag_set("breach_start");
	var_02 = getent("facility_breach_animation_origin","targetname");
	level.breachenemies_active = 0;
	level.breachenemies_alive = 0;
	level.player_rig = maps\lab_utility::spawn_player_rig();
	level.player_rig hide();
	var_03 = getent("facility_breach_crate_model","targetname");
	var_04 = getent("facility_breach_crate_clip","targetname");
	var_04 linkto(var_03);
	level.facility_breach_crate = maps\_utility::spawn_anim_model("facility_breach_crate",var_03.origin);
	soundscripts\_snd::snd_message("lab_mute_gun_holster");
	var_02 maps\_anim::anim_first_frame_solo(level.facility_breach_crate,"facility_breach");
	var_03 linkto(level.facility_breach_crate,"tag_origin_animated",(0,0,0),(0,0,0));
	level.facility_breach_charge = maps\_utility::spawn_anim_model("facility_breach_charge",var_02.origin);
	level.facility_breach_charge hide();
	var_02 maps\_anim::anim_first_frame_solo(level.facility_breach_charge,"facility_breach");
	level.facility_breach_mute_device = maps\_utility::spawn_anim_model("facility_breach_mute_device",var_02.origin);
	level.facility_breach_mute_device hide();
	var_02 maps\_anim::anim_first_frame_solo(level.facility_breach_mute_device,"facility_breach");
	level notify("breaching");
	breach_friendlies_take_grenades();
	level.player freezecontrols(1);
	level.player maps\_shg_utility::setup_player_for_scene(1);
	maps\_player_exo::player_exo_deactivate();
	thread facility_breach_setup_player();
	var_05 = 0.4;
	var_02 maps\_anim::anim_first_frame_solo(level.player_rig,"facility_breach");
	level.player playerlinktoblend(level.player_rig,"tag_player",var_05);
	level.burke.animname = "burke";
	var_06 = [level.facility_breach_charge,level.facility_breach_mute_device,level.player_rig,level.facility_breach_crate];
	wait(var_05);
	level.facility_breach_mute_device soundscripts\_snd::snd_message("aud_facility_breach_start");
	level.facility_breach_charge show();
	level.facility_breach_mute_device show();
	level.player_rig show();
	var_02 thread maps\_anim::anim_single(var_06,"facility_breach");
	level.burke thread burke_breach(var_02);
	facility_breach_spawn_bad_guys(var_02);
	var_02 thread maps\_anim::anim_single(level.facility_breach_guys,"facility_breach");
	thread burke_breach_interrupt();
	level.facility_breach_guys[0] maps\_utility::delaythread(15,::maps\lab_utility::bloody_death,1,level.burke);
	level.facility_breach_guys[1] maps\_utility::delaythread(15,::maps\lab_utility::bloody_death,1,level.burke);
	level.facility_breach_guys[2] maps\_utility::delaythread(15,::maps\lab_utility::bloody_death,1,level.burke);
	level.facility_breach_guys[3] maps\_utility::delaythread(15,::maps\lab_utility::bloody_death,1,level.burke);
	maps\_utility::delaythread(15,::common_scripts\utility::flag_set,"lab_breach_all_guys_dead");
	level.player thread breach_top_off_weapon();
	var_04 disconnectpaths();
	for(;;)
	{
		if(level.breachenemies_alive <= 0)
		{
			break;
		}

		wait(0.05);
	}

	common_scripts\utility::flag_set("breach_done");
}

//Function Number: 11
burke_breach(param_00)
{
	param_00 maps\_anim::anim_single_solo(self,"facility_breach");
	if(common_scripts\utility::flag("flag_burke_kills_guy"))
	{
		param_00 thread maps\_anim::anim_loop_solo(self,"facility_breach_idle","ender");
		common_scripts\utility::flag_wait("flag_breach_patrol_01_clear");
		param_00 notify("ender");
		self stopanimscripted();
		param_00 maps\_anim::anim_single_solo_run(self,"facility_breach_end");
	}
}

//Function Number: 12
burke_breach_interrupt()
{
	level endon("burke_breach_uninterruptable");
	level.facility_breach_guys[4] waittill("death");
	level.burke notify("single anim","end");
	level.burke stopanimscripted();
}

//Function Number: 13
facility_breach_setup_player()
{
	level.player enableinvulnerability();
	level.player disableweaponswitch();
	level.player disableoffhandweapons();
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowsprint(0);
	level.player allowjump(0);
}

//Function Number: 14
facility_breach_cleanup_player()
{
	level.player disableinvulnerability();
	level.player enableweaponswitch();
	level.player enableoffhandweapons();
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player allowjump(1);
}

//Function Number: 15
breach_top_off_weapon(param_00)
{
	param_00 = self getcurrentweapon();
	if(should_topoff_breach_weapon())
	{
		var_01 = weaponclipsize(param_00);
		if(self getweaponammoclip(param_00) < var_01)
		{
			self setweaponammoclip(param_00,var_01);
		}
	}
}

//Function Number: 16
should_topoff_breach_weapon()
{
	if(level.gameskill > 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
breach_slow_down(param_00)
{
	thread slowmo_begins(1);
}

//Function Number: 18
enable_player_control(param_00)
{
	level.player unlink();
	level.player_rig delete();
	maps\_player_exo::player_exo_activate();
	thread facility_breach_cleanup_player();
}

//Function Number: 19
blow_door(param_00)
{
	level.facility_breach_charge hide();
	var_01 = getent("facility_breach_door","targetname");
	var_02 = getent("facility_breach_door_clip","targetname");
	var_02 connectpaths();
	var_01 delete();
	var_02 delete();
	level thread maps\lab_fx::mute_breach_explosion();
	level notify("breach_explosion");
	level.player_rig hide();
	level.player enableweapons();
	level.player freezecontrols(0);
	setsaveddvar("ammoCounterHide",0);
}

//Function Number: 20
slowmo_begins(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.25;
	}

	level.slomobreachduration = 3.5;
	var_01 = 0.5;
	var_02 = 0.75;
	if(isdefined(level.breaching) && level.breaching == 1)
	{
		return;
	}

	level.breaching = 1;
	var_03 = 0.2;
	if(isdefined(level.slomobreachplayerspeed))
	{
		var_03 = level.slomobreachplayerspeed;
	}

	var_04 = level.player;
	common_scripts\utility::flag_clear("can_save");
	var_04 allowmelee(0);
	maps\_utility::slowmo_setspeed_slow(param_00);
	maps\_utility::slowmo_setlerptime_in(var_01);
	maps\_utility::slowmo_lerp_in();
	var_04 setmovespeedscale(var_03);
	var_05 = gettime();
	var_06 = var_05 + level.slomobreachduration * 1000;
	var_04 thread catch_weapon_switch();
	var_04 thread catch_mission_failed();
	var_07 = 500;
	var_08 = 1000;
	for(;;)
	{
		if(isdefined(level.forced_slowmo_breach_slowdown))
		{
			if(!level.forced_slowmo_breach_slowdown)
			{
				if(isdefined(level.forced_slowmo_breach_lerpout))
				{
					var_02 = level.forced_slowmo_breach_lerpout;
				}

				break;
			}

			wait(0.05);
			continue;
		}

		if(gettime() >= var_06)
		{
			break;
		}

		if(level.breachenemies_active <= 0)
		{
			var_02 = 1.15;
			break;
		}

		if(!maps\_utility::is_coop())
		{
			if(var_04.lastreloadstarttime >= var_05 + var_07)
			{
				break;
			}

			if(var_04.switchedweapons && gettime() - var_05 > var_08)
			{
				break;
			}
		}

		if(maps\_utility::is_specialop() && common_scripts\utility::flag("special_op_terminated"))
		{
			break;
		}

		if(var_04.breach_missionfailed)
		{
			var_02 = 0.5;
			break;
		}

		wait(0.05);
	}

	level notify("slowmo_breach_ending",var_02);
	level notify("stop_player_heartbeat");
	var_04 thread maps\_utility::play_sound_on_entity("slomo_whoosh");
	maps\_utility::slowmo_setlerptime_out(var_02);
	maps\_utility::slowmo_lerp_out();
	var_04 allowmelee(1);
	maps\_utility::slowmo_end();
	common_scripts\utility::flag_set("can_save");
	level.player_one_already_breached = undefined;
	var_04 slowmo_player_cleanup();
	var_04 allowsprint(1);
	level notify("slomo_breach_over");
	level.breaching = 0;
	setsaveddvar("objectiveHide",0);
}

//Function Number: 21
slowmo_player_cleanup()
{
	if(isdefined(level.playerspeed))
	{
		self setmovespeedscale(level.playerspeed);
		return;
	}

	self setmovespeedscale(1);
}

//Function Number: 22
breach_enemy_waitfor_death(param_00)
{
	self endon("breach_status_change");
	param_00 waittill("death");
	self notify("breach_status_change","death");
}

//Function Number: 23
breach_enemy_waitfor_death_counter(param_00)
{
	level.breachenemies_alive++;
	param_00 waittill("death");
	level.breachenemies_alive--;
	if(level.breachenemies_alive <= 0)
	{
		breach_friendlies_restore_grenades();
	}

	level notify("breach_all_enemies_dead");
}

//Function Number: 24
breach_enemy_catch_exceptions(param_00)
{
	self endon("breach_status_change");
	while(isalive(param_00))
	{
		wait(0.05);
	}

	self notify("breach_status_change","exception");
}

//Function Number: 25
breach_enemy_waitfor_breach_ending()
{
	self endon("breach_status_change");
	level waittill("slowmo_breach_ending");
	self notify("breach_status_change","breach_ending");
}

//Function Number: 26
breach_enemy_track_status(param_00)
{
	level.breachenemies_active++;
	var_01 = spawnstruct();
	var_01.enemy = param_00;
	var_01 thread breach_enemy_waitfor_death(param_00);
	var_01 thread breach_enemy_waitfor_death_counter(param_00);
	var_01 thread breach_enemy_catch_exceptions(param_00);
	var_01 thread breach_enemy_waitfor_breach_ending();
	var_01 waittill("breach_status_change",var_02);
	level.breachenemies_active--;
	var_01 = undefined;
}

//Function Number: 27
catch_mission_failed()
{
	level endon("slowmo_breach_ending");
	self.breach_missionfailed = 0;
	level waittill("mission failed");
	self.breach_missionfailed = 1;
}

//Function Number: 28
catch_weapon_switch()
{
	level endon("slowmo_breach_ending");
	self.switchedweapons = 0;
	common_scripts\utility::waittill_any("weapon_switch_started","night_vision_on","night_vision_off");
	self.switchedweapons = 1;
}

//Function Number: 29
breach_friendlies_take_grenades()
{
	if(!isdefined(level.breachfriendlies))
	{
		return;
	}

	level.breachfriendlies_grenades_empty = 1;
	foreach(var_01 in level.breachfriendlies)
	{
		var_01.grenadeammo_prebreach = var_01.grenadeammo;
		var_01.grenadeammo = 0;
	}
}

//Function Number: 30
breach_friendlies_restore_grenades()
{
	if(!isdefined(level.breachfriendlies))
	{
		return;
	}

	if(!isdefined(level.breachfriendlies_grenades_empty))
	{
		return;
	}

	foreach(var_01 in level.breachfriendlies)
	{
		var_01.grenadeammo = var_01.grenadeammo_prebreach;
		var_01.grenadeammo_prebreach = undefined;
	}

	level.breachfriendlies_grenades_empty = undefined;
}

//Function Number: 31
no_interrupt(param_00)
{
	level notify("burke_breach_uninterruptable");
	common_scripts\utility::flag_set("flag_burke_kills_guy");
	level.facility_breach_guys[4].allowdeath = 0;
}

//Function Number: 32
break_glass(param_00)
{
	glassradiusdamage(param_00.origin,100,300,100);
}