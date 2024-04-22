/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_qte_middle.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 471 ms
 * Timestamp: 4/22/2024 2:33:59 AM
*******************************************************************/

//Function Number: 1
anim_single_solo_d(param_00,param_01)
{
	maps\_anim::anim_single_solo(param_00,param_01);
}

//Function Number: 2
anim_single_qte_middle(param_00,param_01,param_02)
{
	var_03 = param_00[0];
	var_04 = param_00[1];
	thread anim_single_solo_d(param_01[0],param_02);
	var_04.tag_driver thread anim_single_solo_d(param_01[1],param_02);
	var_04.tag_driver thread anim_single_solo_d(param_01[2],param_02);
	var_04.tag_driver thread anim_single_solo_d(param_01[3],param_02);
	thread anim_single_solo_d(param_00[1],param_02);
	if(param_02 == "truck_middle_takedown_pt4")
	{
		thread anim_single_solo_d(param_00[0],param_02);
		var_05 = getanimlength(param_00[0] maps\_utility::getanim(param_02));
		var_06 = int(var_05 * 20);
		wait(var_06 / 20);
		return;
	}

	anim_single_solo_d(param_00[0],param_02);
}

//Function Number: 3
anim_single_qte_middle_fail(param_00,param_01,param_02,param_03)
{
	var_04 = param_00[0];
	var_05 = param_00[1];
	var_06 = param_01[0];
	var_05.tag_driver thread anim_single_solo_d(param_01[1],param_03);
	var_05.tag_driver thread anim_single_solo_d(param_01[2],param_03);
	var_05.tag_driver thread anim_single_solo_d(param_01[3],param_03);
	thread anim_single_solo_d(param_00[0],param_03);
	thread anim_single_solo_d(param_00[1],param_03);
	var_06 linkto(var_04.tag_driver);
	var_04.tag_driver anim_single_solo_d(var_06,param_02);
}

//Function Number: 4
takedown_qte_middle(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	maps\lagos_utility::start_middle_takedown_highway_path_player_side();
	maps\_utility::delaythread(0.05,::maps\_utility::autosave_now_silent);
	level.hint_nofadein = 1;
	maps\lagos_jump::exo_jump_end();
	common_scripts\utility::flag_set("suv_takedown_lighting");
	level.player.old_weapon = level.player getcurrentweapon();
	if(level.player.old_weapon == "none")
	{
		var_07 = level.player getweaponslistprimaries();
		level.player.old_weapon = var_07[0];
	}

	level.player allowads(1);
	level.player maps\_shg_utility::setup_player_for_scene();
	maps\lagos_utility::disable_exo_for_highway();
	level.player maps\_utility::store_players_weapons("traffic_weapons");
	level.player takeallweapons();
	level.player allowmelee(0);
	thread maps\_player_exo::player_exo_deactivate();
	param_00 maps\_anim::anim_first_frame_solo(param_04,"truck_middle_takedown_pt1");
	level.player playerlinktodelta(param_04,"tag_player",1,7,7,5,5,1);
	level.player enableinvulnerability();
	level.player notifyonplayercommand("gunFired","+attack");
	param_06.tag_driver = spawn("script_origin",(0,0,0));
	param_06.tag_driver.origin = param_06 gettagorigin("tag_driver");
	param_06.tag_driver.angles = param_06 gettagangles("tag_driver");
	param_06.tag_driver linkto(param_06);
	param_05.tag_driver = spawn("script_origin",(0,0,0));
	param_05.tag_driver.origin = param_05 gettagorigin("tag_driver");
	param_05.tag_driver.angles = param_05 gettagangles("tag_driver");
	param_05.tag_driver linkto(param_05);
	param_01 linkto(param_06.tag_driver);
	param_02 linkto(param_06.tag_driver);
	param_03 linkto(param_06.tag_driver);
	var_08 = [param_04,param_01,param_02,param_03];
	var_09 = [param_05,param_06];
	param_01 maps\_utility::magic_bullet_shield();
	param_02 maps\_utility::magic_bullet_shield();
	param_03 maps\_utility::magic_bullet_shield();
	if(!isdefined(level.debugstart_post_middle_takedown))
	{
		thread truck_middle_takedown_player_shot_enemy_check("flag_player_shot_enemy",4.55,param_01,param_02,param_03,param_06);
		level.player lerpviewangleclamp(2,0,0,20,20,10,-7);
		thread truck_middle_takedown_middle_player_free_aim(param_04,param_05,param_00,var_09);
		thread truck_middle_takedown_player_dodge_check("flag_player_dodge");
		thread truck_middle_takedown_player_shot_timer(var_09,var_08,"truck_middle_takedown_fail_pt1");
		player_bus_anim_single_break_when_timeout_or_fail(param_00,var_09,var_08);
		if(!common_scripts\utility::flag("flag_player_shot_enemy"))
		{
			truck_middle_takedown_failure();
			truck_middle_takedown_gameover();
			return;
		}

		if(!common_scripts\utility::flag("flag_player_dodge"))
		{
			truck_middle_takedown_failure();
			param_00 anim_single_qte_middle_fail(var_09,var_08,"truck_middle_takedown_fail_pt2","truck_middle_takedown_pt2");
			truck_middle_takedown_gameover();
			return;
		}

		level.player notifyonplayercommandremove("gunFired","+attack");
		thread truck_middle_takedown_player_jump("flag_player_jump",21);
		param_00 anim_single_qte_middle(var_09,var_08,"truck_middle_takedown_pt2");
		if(!common_scripts\utility::flag("flag_player_jump"))
		{
			truck_middle_takedown_failure();
			param_00 anim_single_qte_middle_fail(var_09,var_08,"truck_middle_takedown_fail_pt3","truck_middle_takedown_pt3");
			truck_middle_takedown_gameover();
			return;
		}

		var_0A = getnode("cover_bus_traverse_3","targetname");
		level.burke maps\_utility::teleport_ai(var_0A);
		level.burke.ignoreall = 1;
		thread truck_middle_takedown_player_pull_windshield("flag_player_pull_windshield",21);
		param_00 anim_single_qte_middle(var_09,var_08,"truck_middle_takedown_pt3");
		if(!common_scripts\utility::flag("flag_player_pull_windshield"))
		{
			truck_middle_takedown_failure();
			param_00 anim_single_qte_middle_fail(var_09,var_08,"truck_middle_takedown_fail_pt4","truck_middle_takedown_pt4");
			truck_middle_takedown_gameover();
			return;
		}

		thread truck_middle_takedown_player_jump2("flag_player_jump2",21);
		common_scripts\utility::delay_script_call(4.5,::maps\lagos_utility::post_middle_takedown_highway_path_player_side);
		param_00 thread anim_single_solo_d(level.hit_kva_bus,"truck_middle_takedown_pt5");
		param_00 anim_single_qte_middle(var_09,var_08,"truck_middle_takedown_pt4");
		if(!common_scripts\utility::flag("flag_player_jump2"))
		{
			truck_middle_takedown_failure();
			param_00 anim_single_qte_middle_fail(var_09,var_08,"truck_middle_takedown_fail_pt5","truck_middle_takedown_pt5");
			truck_middle_takedown_gameover();
			return;
		}
	}

	common_scripts\utility::flag_set("flag_player_jump2");
	soundscripts\_snd::snd_message("truck_whipeout_anim_begin");
	thread maps\lagos_utility::post_middle_takedown_highway_path_player_side();
	thread maps\lagos_code::traffic_camera_shake_after_middle_td();
	level.burke maps\lagos_utility::setup_ai_for_bus_sequence();
	level.burke animscripts\utility::setunstableground(1);
	level.burke maps\_utility::disable_pain();
	level.burke maps\_utility::disable_surprise();
	level.burke.grenadeammo = 0;
	level.burke.baseaccuracy = 0.15;
	level.burke thread maps\lagos_utility::keep_filling_clip_ammo(1);
	level.burke pushplayer(1);
	level.burke.pushable = 0;
	thread maps\lagos_code::start_bus_moving_before_anim_ends(level.player_bus,"start_bus_traverse_3",3.7);
	param_00 anim_single_qte_middle(var_09,var_08,"truck_middle_takedown_pt5");
	level.kva_truck common_scripts\utility::delaycall(15,::delete);
	param_00 common_scripts\utility::delaycall(15.1,::delete);
	param_01 maps\_utility::stop_magic_bullet_shield();
	param_02 maps\_utility::stop_magic_bullet_shield();
	param_03 maps\_utility::stop_magic_bullet_shield();
	param_01 delete();
	param_02 delete();
	param_03 delete();
	level.hit_kva_bus delete();
	level.player playerlinkto(level.player_bus.script_origin_roof[1]);
	level.player forcemovingplatformentity(undefined);
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player allowmelee(1);
	level.player maps\_utility::restore_players_weapons("traffic_weapons");
	thread maps\_player_exo::player_exo_activate();
	level.player showviewmodel();
	level.player allowads(1);
	level.player switchtoweaponimmediate(level.player.old_weapon);
	level.player unlink();
	var_0B = getvehiclenode("start_bus_traverse_3","targetname");
	level.player_bus startpath(var_0B);
	level.player notify("qte_done");
	wait 0.05;
	var_0A = getnode("cover_bus_traverse_3","targetname");
	level.burke maps\_utility::teleport_ai(var_0A);
	level.burke.ignoreall = 0;
	maps\_utility::autosave_by_name();
	thread maps\lagos_jump::exo_jump_process();
	common_scripts\utility::flag_set("flag_middle_takedown_complete");
	common_scripts\utility::flag_set("flag_player_traversing_traffic");
	thread maps\lagos_code::traffic_traverse_fail_check();
	level.player disableinvulnerability();
	param_04 delete();
	level.hint_nofadein = undefined;
	level.kva_dead_count = undefined;
	level.player.old_weapon = undefined;
}

//Function Number: 5
player_bus_anim_single_break_when_timeout_or_fail(param_00,param_01,param_02)
{
	level.player endon("part1_done");
	param_00 anim_single_qte_middle(param_01,param_02,"truck_middle_takedown_pt1");
	level.player notify("part1_done");
}

//Function Number: 6
truck_middle_takedown_player_shot_timer(param_00,param_01,param_02)
{
	var_03 = param_00[0];
	var_04 = param_00[1];
	var_05 = param_01[0];
	wait(12.5);
	if(level.kva_dead_count < 2)
	{
		level.player notify("part1_done");
		earthquake(0.5,0.1,level.player.origin,300000);
		wait(0.1);
		level.player disableweapons();
		var_05 linkto(var_03.tag_driver);
		var_03.tag_driver anim_single_solo_d(var_05,param_02);
		level.player dodamage(level.player.maxhealth,var_04.origin);
	}
}

//Function Number: 7
truck_middle_takedown_player_shot_enemy_check(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level.player endon("part1_done");
	param_03 thread maps\lagos_qte::kva_fake_death_checker(param_05,"truck_middle_takedown_death_guy1");
	param_04 thread maps\lagos_qte::kva_fake_death_checker(param_05,"truck_middle_takedown_death_guy3");
	thread truck_middle_takedown_set_normal_time_if_gun_fired();
	for(;;)
	{
		level.kva_dead_count = 0;
		if(!isalive(param_03) || param_03.fake_death)
		{
			level.kva_dead_count++;
		}

		if(!isalive(param_04) || param_04.fake_death)
		{
			level.kva_dead_count++;
		}

		if(level.kva_dead_count >= 2)
		{
			maps\lagos_qte::hostage_truck_slomo_end(1);
			common_scripts\utility::flag_set(param_00);
			break;
		}

		wait 0.05;
	}

	level.player notify("set_normal_time_if_gun_fired_kill_middle");
}

//Function Number: 8
truck_middle_takedown_set_normal_time_if_gun_fired()
{
	level.player endon("part1_done");
	for(;;)
	{
		level.player waittill("gunFired");
		maps\lagos_qte::hostage_truck_slomo_end(1);
		wait 0.05;
	}
}

//Function Number: 9
doclamping_middle()
{
	wait(4);
	level.player lerpviewangleclamp(1,0.25,0.25,0,0,0,0);
}

//Function Number: 10
player_allow_damage(param_00)
{
	level.player notify("player_allow_damage_one_thread_only");
	level.player endon("player_allow_damage_one_thread_only");
	if(param_00)
	{
		wait(1);
		for(;;)
		{
			level.player disableinvulnerability();
			level.player enabledeathshield(1);
			wait(randomfloatrange(0.25,0.5));
			level.player enableinvulnerability();
			level.player enabledeathshield(0);
			wait(randomfloatrange(0.25,0.5));
		}

		return;
	}

	level.player enableinvulnerability();
	level.player enabledeathshield(0);
}

//Function Number: 11
truck_middle_takedown_middle_player_free_aim(param_00,param_01,param_02,param_03)
{
	level.player endon("qte_done");
	level.player endon("qte_fail");
	thread doclamping_middle();
	common_scripts\utility::flag_set("suv_takedown_shoot_lighting");
	var_04 = 0.7;
	var_05 = "iw5_titan45lagostruckmiddletakedown_sp";
	for(;;)
	{
		level.player waittill("do_viewmodel_swap");
		param_00 hideallparts();
		param_00.hidden = 1;
		level.player enableweapons();
		level.player hideviewmodel();
		level.player giveweapon(var_05);
		level.player switchtoweapon(var_05);
		wait(0.7);
		level.player showviewmodel();
		level.player thread player_allow_damage(1);
		level.player giveweapon(var_05);
		level.player switchtoweaponimmediate(var_05);
		level.player forcemovingplatformentity(param_00);
		level.player playerrecoilscaleon(0);
		level.player lerpviewangleclamp(0.05,0.25,0.25,25,40,22.5,22.5);
		level.player allowmelee(0);
		soundscripts\_snd::snd_message("middle_takedown_gun_up");
		level.player waittill("do_viewmodel_swap");
		level.player allowmelee(0);
		level.player thread player_allow_damage(0);
		level.player lerpviewangleclamp(2,0,0,20,20,10,-7);
		level.player playerrecoilscaleon(1);
		level.player disableweapons();
		wait(var_04);
		level.player hideviewmodel();
		level.player takeweapon(var_05);
		param_00 showallparts();
		var_04 = 1.1;
		var_05 = "iw5_titan45lagostruckmiddletakedown2_sp";
	}
}

//Function Number: 12
truck_middle_takedown_player_dodge_check(param_00)
{
	level.player waittill("qte_prompt");
	if(level.kva_dead_count < 2)
	{
		return;
	}

	var_01 = level.kva_truck maps\_shg_utility::hint_button_tag("a","tag_headlight_right",900,900);
	common_scripts\utility::flag_set("suv_takedown_dodge_lighting");
	maps\lagos_qte::wait_for_flag_or_player_command("flag_truck_middle_takedown_is_failure","+gostand");
	var_01 maps\_shg_utility::hint_button_clear();
	if(common_scripts\utility::flag("flag_truck_middle_takedown_is_failure"))
	{
		return;
	}

	maps\lagos_qte::hostage_truck_slomo_end(1);
	common_scripts\utility::flag_set(param_00);
	soundscripts\_snd::snd_message("truck_middle_dodge_slowmo_end");
}

//Function Number: 13
truck_middle_takedown_player_jump(param_00,param_01)
{
	level.player waittill("qte_prompt");
	var_02 = level.kva_truck maps\_shg_utility::hint_button_tag("a","tag_hood",900,900);
	common_scripts\utility::flag_set("suv_takedown_jump_lighting");
	maps\lagos_qte::wait_for_flag_or_player_command("flag_truck_middle_takedown_is_failure","+gostand");
	var_02 maps\_shg_utility::hint_button_clear();
	if(common_scripts\utility::flag("flag_truck_middle_takedown_is_failure"))
	{
		return;
	}

	maps\lagos_qte::hostage_truck_slomo_end(1);
	common_scripts\utility::flag_set(param_00);
	soundscripts\_snd::snd_message("truck_middle_jump_slowmo_end");
}

//Function Number: 14
truck_middle_takedown_player_pull_windshield(param_00,param_01)
{
	level.player waittill("qte_prompt");
	var_02 = level.kva_truck maps\_shg_utility::hint_button_tag("melee","winsmash_l",900,900);
	common_scripts\utility::flag_set("suv_takedown_windshield_lighting");
	var_03 = getbuttonsconfig();
	var_04 = undefined;
	if(issubstr(var_03,"buttons_default") || issubstr(var_03,"buttons_tactical"))
	{
		var_04 = "+melee_zoom";
	}
	else if(issubstr(var_03,"buttons_lefty") || issubstr(var_03,"buttons_nomad"))
	{
		var_04 = "+melee_breath";
	}
	else if(issubstr(var_03,"buttons_nomad_tactical"))
	{
		var_04 = "+stance";
	}

	maps\lagos_qte::wait_for_flag_or_player_command("flag_truck_middle_takedown_is_failure",var_04);
	var_02 maps\_shg_utility::hint_button_clear();
	if(common_scripts\utility::flag("flag_truck_middle_takedown_is_failure"))
	{
		return;
	}

	maps\lagos_qte::hostage_truck_slomo_end(1);
	common_scripts\utility::flag_set(param_00);
	soundscripts\_snd::snd_message("truck_middle_punch_slowmo_end");
}

//Function Number: 15
truck_middle_takedown_player_jump2(param_00,param_01)
{
	level.player waittill("qte_prompt");
	var_02 = level.player_bus maps\_shg_utility::hint_button_tag("a","tag_roof_b",900,900);
	common_scripts\utility::flag_set("suv_takedown_jump2_lighting");
	maps\lagos_qte::wait_for_flag_or_player_command("flag_truck_middle_takedown_is_failure","+gostand");
	var_02 maps\_shg_utility::hint_button_clear();
	if(common_scripts\utility::flag("flag_truck_middle_takedown_is_failure"))
	{
		return;
	}

	maps\lagos_qte::hostage_truck_slomo_end(1);
	common_scripts\utility::flag_set(param_00);
	soundscripts\_snd::snd_message("truck_middle_jump2_slowmo_end");
}

//Function Number: 16
truck_middle_takedown_failure()
{
	level.player notify("qte_fail");
	common_scripts\utility::flag_set("flag_truck_middle_takedown_is_failure");
	maps\lagos_qte::hostage_truck_slomo_end();
	level.player forcemovingplatformentity(undefined);
}

//Function Number: 17
truck_middle_takedown_gameover()
{
	setdvar("ui_deadquote","");
	maps\_utility::missionfailedwrapper();
	level waittill("forever");
}

//Function Number: 18
setup_vehicles_for_middle_takedown()
{
	level.player_bus.animname = "player_bus";
	level.player_bus useanimtree(#animtree);
	level.kva_truck = getent("kva_truck_middle_takedown","targetname");
	level.kva_truck.animname = "kva_truck";
	level.kva_truck useanimtree(#animtree);
	level.hit_kva_bus = maps\_vehicle::spawn_vehicle_from_targetname("hit_kva_bus");
	level.hit_kva_bus.animname = "hit_kva_bus";
	level.hit_kva_bus useanimtree(#animtree);
	level thread maps\lagos_fx::middle_takedown_tread_fx();
}

//Function Number: 19
notify_qte_prompt_and_slowmo(param_00)
{
	level.player endon("qte_success_message");
	if(level.kva_dead_count < 2)
	{
		return;
	}

	level.player notify("qte_prompt");
	wait 0.05;
	soundscripts\_snd::snd_message("notify_qte_prompt_and_slowmo");
	var_01 = 0.095;
	var_02 = 0.095;
	var_03 = 0.2;
	maps\lagos_qte::hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 20
player_bus_slomo_end_notetrack(param_00)
{
	level.player notify("slowmo_end");
	maps\lagos_qte::hostage_truck_slomo_end(0);
}

//Function Number: 21
player_bus_slomo_start_pt1(param_00)
{
	soundscripts\_snd::snd_message("player_bus_slomo_start_pt1");
	var_01 = 0.095;
	var_02 = 0.095;
	var_03 = 0.2;
	maps\lagos_qte::hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 22
player_bus_slomo_start_pt2(param_00)
{
	soundscripts\_snd::snd_message("player_bus_slomo_start_pt2");
	var_01 = 0.1;
	var_02 = 0.1;
	var_03 = 0.2;
	maps\lagos_qte::hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 23
player_bus_slomo_end_pt2(param_00)
{
	soundscripts\_snd::snd_message("player_bus_slomo_end_pt2");
	player_bus_slomo_end_notetrack(param_00);
}

//Function Number: 24
player_bus_slomo_start_pt3(param_00)
{
	soundscripts\_snd::snd_message("player_bus_slomo_start_pt3");
	var_01 = 0.095;
	var_02 = 0.095;
	var_03 = 0.2;
	maps\lagos_qte::hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 25
player_bus_slomo_start_pt4(param_00)
{
	soundscripts\_snd::snd_message("player_bus_slomo_start_pt4");
	var_01 = 0.095;
	var_02 = 0.095;
	var_03 = 0.2;
	maps\lagos_qte::hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 26
player_bus_slomo_start_pt5(param_00)
{
	soundscripts\_snd::snd_message("player_bus_slomo_start_pt5");
	var_01 = 0.095;
	var_02 = 0.095;
	var_03 = 0.2;
	maps\lagos_qte::hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 27
notetrack_unlink_and_start_ragdoll(param_00)
{
	param_00 unlink();
	param_00 startragdoll();
}

//Function Number: 28
notetrack_unlink(param_00)
{
	param_00 unlink();
	var_01 = spawn("script_origin",(0,0,0));
	var_01.origin = level.player.origin;
	param_00 linkto(var_01);
}

//Function Number: 29
qte_middle_shoot_off()
{
	var_00 = "BUTTON_RTRIG";
	if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		var_00 = "mouse1";
	}

	if(level.player buttonpressed(var_00) || isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_SHOOT_KVA")
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
qte_middle_dodge_off()
{
	if(level.player usebuttonpressed() || isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_DODGE")
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
qte_middle_jump_off()
{
	if(level.player jumpbuttonpressed() || isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_JUMP")
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
qte_middle_pull_windshield_off()
{
	if(level.player usebuttonpressed() || isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_PULL_WINDSHIELD")
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
qte_middle_pull_kva_off()
{
	var_00 = "BUTTON_RTRIG";
	if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		var_00 = "mouse1";
	}

	if(level.player buttonpressed(var_00) || isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_MIDDLE_PULL_KVA")
	{
		return 1;
	}

	return 0;
}