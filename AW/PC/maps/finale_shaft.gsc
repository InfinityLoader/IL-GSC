/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_shaft.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 693 ms
 * Timestamp: 4/22/2024 2:29:25 AM
*******************************************************************/

//Function Number: 1
set_cam_shake(param_00)
{
	var_01 = param_00 / 40;
	if(var_01 < 0.001)
	{
		var_01 = 0.001;
	}

	var_01 = var_01 * 0.7;
	var_02 = self getactiveanimations();
	if(var_02.size < 4)
	{
		self setanimknobrestart(%fin_silo_exhaust_hatch_breach_camshake_vm,1,0,3);
	}

	self setanimlimited(%fin_silo_exhaust_hatch_breach_camshake_root,var_01,0.05);
}

//Function Number: 2
hatch_open_se_update_rumble_intensity(param_00)
{
	var_01 = 0.05 + param_00 / 100;
	maps\finale_utility::set_level_player_rumble_ent_intensity(var_01);
}

//Function Number: 3
button_pressed_think(param_00,param_01,param_02)
{
	level.player.button_pressed = 0;
	level.player notifyonplayercommand("hatch_action",param_00);
	if(isdefined(param_02))
	{
		level.player notifyonplayercommand("hatch_action",param_02);
	}

	while(param_01.state != 4)
	{
		level.player waittill("hatch_action");
		level.player.button_pressed = 1;
		wait 0.05;
		level.player.button_pressed = 0;
	}

	level.player notifyonplayercommandremove("hatch_action",param_00);
	if(isdefined(param_02))
	{
		level.player notifyonplayercommandremove("hatch_action",param_02);
	}
}

//Function Number: 4
hatch_button_gameplay(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	var_08 = "+usereload";
	var_09 = "+activate";
	param_00 thread maps\_anim::anim_loop(param_01,"exhaust_hatch_vm_idle_noinput","ender_player");
	param_00.state = 0;
	level.player thread maps\_shg_utility::button_mash_dynamic_hint(&"FINALE_PISTON_BREAK_BUTTON",var_08,"notetrack_break_bar",var_09);
	param_03 thread maps\_shg_utility::hint_button_create_flashing("piston5_r","x","notetrack_break_bar",(0,-12,12));
	level.player thread button_pressed_think(var_08,param_00,var_09);
	param_02 set_cam_shake(0);
	while(var_04 < 40)
	{
		waittillframeend;
		if(level.player.button_pressed)
		{
			var_07++;
		}
		else
		{
			var_07 = 0;
		}

		if(var_07 > 0 && var_07 < 30)
		{
			if(var_04 < 40)
			{
				var_04 = var_04 + 1;
			}

			var_06 = 0;
			var_07++;
		}
		else
		{
			var_06++;
			if(var_06 >= 6 && var_04 > 0)
			{
				var_04 = var_04 - 1;
			}
		}

		param_02 set_cam_shake(var_04);
		hatch_open_se_update_rumble_intensity(var_04);
		switch(param_00.state)
		{
			case 0:
				if(var_04 > 0)
				{
					change_state(param_00,1,param_02);
				}
				break;

			case 1:
				if(!isdefined(param_00.wait_for_anim))
				{
					if(var_04 > var_05)
					{
						change_state(param_00,2,param_02);
					}
					else
					{
						change_state(param_00,3,param_02);
					}
				}
				break;

			case 2:
				if(var_04 < var_05)
				{
					change_state(param_00,3,param_02);
				}
				else if(var_04 == 40)
				{
					thread change_state(param_00,4,param_02);
				}
				break;

			case 3:
				if(!isdefined(param_00.wait_for_anim))
				{
					if(var_04 > var_05)
					{
						thread change_state(param_00,1,param_02);
					}
					else
					{
						thread change_state(param_00,0,param_02);
					}
				}
				break;
		}

		var_05 = var_04;
		wait 0.05;
	}

	thread post_win_camshake(param_00,param_02,var_04,gettime() + 3000);
	thread post_win_disable_rumbles();
}

//Function Number: 5
post_win_camshake(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		if(isdefined(param_01.stop_camshake) && param_01.stop_camshake)
		{
			break;
		}

		if(gettime() > param_03)
		{
			break;
		}

		param_01 set_cam_shake(param_02);
		wait 0.05;
	}

	param_01 setanimknobrestart(%fin_silo_exhaust_hatch_breach_camshake_vm,0,0.2,3);
	param_01 setanimlimited(%fin_silo_exhaust_hatch_breach_camshake_root,0,0.2);
}

//Function Number: 6
post_win_disable_rumbles()
{
	wait(2);
	maps\finale_utility::set_level_player_rumble_ent_intensity(0);
}

//Function Number: 7
notetrack_break_bar(param_00)
{
	level.player notify("notetrack_break_bar");
	param_00.stop_camshake = 1;
}

//Function Number: 8
change_state(param_00,param_01,param_02)
{
	var_03 = param_00.state;
	param_00.state = param_01;
	if(param_01 != var_03)
	{
		param_00 notify("ender_player");
		if(param_00.state == 0)
		{
			param_00 thread maps\_anim::anim_loop_solo(param_02,"exhaust_hatch_vm_idle_noinput","ender_player");
			return;
		}

		if(param_00.state == 1)
		{
			param_00.wait_for_anim = 1;
			param_00 thread anim_single_solo_custom(param_00,param_02,"exhaust_hatch_vm_noinput_to_input");
			return;
		}

		if(param_00.state == 2)
		{
			param_00 thread maps\_anim::anim_loop_solo(param_02,"exhaust_hatch_vm_idle_input","ender_player");
			return;
		}

		if(param_00.state == 3)
		{
			param_00.wait_for_anim = 1;
			param_00 thread anim_single_solo_custom(param_00,param_02,"exhaust_hatch_vm_input_to_noinput");
			return;
		}

		return;
	}
}

//Function Number: 9
anim_single_solo_custom(param_00,param_01,param_02)
{
	param_00.wait_for_anim = 1;
	param_00 notify("ender");
	param_00 maps\_anim::anim_single_solo(param_01,param_02);
	param_00.wait_for_anim = undefined;
}

//Function Number: 10
do_shaft_gameplay_setup(param_00)
{
	level.drop_locator = maps\_utility::spawn_anim_model("locator");
	level.drop_locator.anim_speed = calculate_locator_anim_speed(param_00);
	level.drop_locator.drop_started_status = 0;
	param_00 maps\_anim::anim_first_frame_solo(level.drop_locator,"shaft_drop");
}

//Function Number: 11
setup_mech_for_drop(param_00)
{
	var_01 = level.player.player_rig;
	if(!isdefined(level.player.player_rig))
	{
		var_01 = maps\_utility::spawn_anim_model("world_body_mech",level.player.origin + (0,0,30),level.player.angles);
		maps\_playermech_code::hide_mech_glass_static_overlay(var_01);
	}

	if(isdefined(param_00) && param_00)
	{
		if(0)
		{
			var_02 = -38.6;
			var_03 = -10.6;
			var_04 = -105.8;
			var_01 linktoplayerviewignoreparentrot(level.player,"TAG_ORIGIN",(var_04,var_03,var_02),(0,0,0),1,0,0,1);
			level.player hideviewmodel();
		}
		else
		{
			if(!isdefined(level.player getlinkedparent()) || !level.player getlinkedparent() == var_01)
			{
				level.player playerlinktoblend(var_01,"TAG_PLAYER",1);
				level.player maps\_playermech_code::mech_setup_player_for_scene();
			}

			var_01 linkto(level.drop_locator,"TAG_ORIGIN_ANIMATED");
		}
	}

	return var_01;
}

//Function Number: 12
set_player_link_angles_tag_relative(param_00,param_01)
{
	level.ground_ref = spawn("script_origin",param_00.origin);
	level.ground_ref.angles = param_00 gettagangles("TAG_PLAYER");
	level.player playersetgroundreferenceent(level.ground_ref);
}

//Function Number: 13
calculate_locator_anim_speed(param_00)
{
	var_01 = maps\_utility::spawn_anim_model("locator");
	param_00 maps\_anim::anim_first_frame_solo(var_01,"shaft_drop");
	wait 0.05;
	maps\_anim::anim_set_time([var_01],"shaft_drop",1);
	var_02 = var_01 gettagorigin("TAG_ORIGIN_ANIMATED");
	var_03 = distance(var_01.origin,var_02);
	var_04 = getanimlength(var_01 maps\_utility::getanim("shaft_drop"));
	var_01 delete();
	return var_03 / var_04;
}

//Function Number: 14
speed_to_anim_rate(param_00)
{
	var_01 = param_00 / level.drop_locator.anim_speed;
	return var_01;
}

//Function Number: 15
anim_rate_to_speed(param_00)
{
	var_01 = param_00 * level.drop_locator.anim_speed;
	return var_01;
}

//Function Number: 16
rigsetvelocity(param_00,param_01)
{
	if(0)
	{
		self setvelocity((0,0,param_00));
		return;
	}

	if(level.drop_locator.drop_started_status == 0)
	{
		level.drop_locator.drop_started_status = 1;
	}

	level.drop_locator.speed = param_00;
	if(!isdefined(param_01))
	{
		param_01 = 0.05;
	}

	var_02 = speed_to_anim_rate(-1 * param_00);
	level.drop_locator setflaggedanim("single anim",level.drop_locator maps\_utility::getanim("shaft_drop"),1,param_01,var_02);
}

//Function Number: 17
riggetvelocity()
{
	if(0)
	{
		return self getvelocity()[2];
	}

	return level.drop_locator.speed;
}

//Function Number: 18
riggetgravity()
{
	if(0)
	{
		return level.player getgravity();
	}

	return level.drop_locator.gravity;
}

//Function Number: 19
rigsetgravity(param_00)
{
	if(0)
	{
		self setgravityoverride(int(param_00));
		return;
	}

	level.drop_locator.gravity = param_00;
}

//Function Number: 20
rigprocessvelocity()
{
	if(level.drop_locator.drop_started_status == 0)
	{
		return;
	}

	var_00 = 0.05;
	var_01 = level.drop_locator.speed + -1 * level.drop_locator.gravity * var_00;
	if(-1 * var_01 < 0)
	{
		var_01 = 0;
	}

	var_02 = speed_to_anim_rate(-1 * var_01);
	if(level.drop_locator.drop_started_status == 2)
	{
		level.drop_locator setanimrate(level.drop_locator maps\_utility::getanim("shaft_drop"),var_02);
	}

	level.drop_locator.drop_started_status = 2;
	wait(var_00);
	level.drop_locator.speed = var_01;
}

//Function Number: 21
set_cam_shake_drop(param_00)
{
	switch(param_00)
	{
		case "shaft_both_hands":
		case "shaft_right_hand_to_both":
		case "shaft_left_hand_to_both":
		case "shaft_no_hands_to_both":
			self setanimknobrestart(%fin_shaft_fall_idle_both_hands_mech_cam_vm,1,0,1);
			self setanimlimited(%fin_shaft_fall_idle_both_hands_mech_cam_root,1,0.05);
			break;

		case "shaft_left_hand":
		case "shaft_right_hand_to_left":
		case "shaft_no_hands_to_left":
		case "shaft_both_hands_to_left":
			self setanimknobrestart(%fin_shaft_fall_idle_left_hand_mech_cam_vm,1,0,1);
			self setanimlimited(%fin_shaft_fall_idle_left_hand_mech_cam_root,1,0.05);
			break;

		case "shaft_right_hand":
		case "shaft_left_hand_to_right":
		case "shaft_no_hands_to_right":
		case "shaft_both_hands_to_right":
			self setanimknobrestart(%fin_shaft_fall_idle_right_hand_mech_cam_vm,1,0,1);
			self setanimlimited(%fin_shaft_fall_idle_right_hand_mech_cam_root,1,0.05);
			break;

		case "shaft_no_hands":
		case "shaft_right_hand_to_no":
		case "shaft_left_hand_to_no":
		case "shaft_both_hands_to_no":
			self setanimknobrestart(%fin_shaft_fall_idle_no_hands_mech_cam_vm,1,0,1);
			self setanimlimited(%fin_shaft_fall_idle_no_hands_mech_cam_root,1,0.05);
			break;
	}
}

//Function Number: 22
store_speed(param_00)
{
	var_01 = param_00.origin;
	while(!common_scripts\utility::flag("flag_player_exhaust_corridor"))
	{
		var_02 = param_00 gettagorigin("TAG_PLAYER");
		var_03 = var_02 - var_01 / 0.05;
		param_00.speed = var_03;
		var_01 = var_02;
		wait 0.05;
	}
}

//Function Number: 23
do_shaft_gameplay()
{
	var_00 = undefined;
	var_01 = 0;
	var_02 = undefined;
	var_03 = "none";
	var_04 = "none";
	var_05 = 400;
	var_06 = maps\_utility::getent_or_struct("org_shaft_drop_controls_start","targetname");
	var_07 = maps\_utility::getent_or_struct("org_shaft_drop_controls_end","targetname");
	level.player.hint_allow_hide_time = gettime() + 2000;
	var_08 = getkeybinding("+toggleads_throw");
	if(level.player common_scripts\utility::is_player_gamepad_enabled() || var_08["count"] == 0)
	{
		thread maps\_utility::hintdisplaymintimehandler("player_input_shaft_buttons",30);
	}
	else
	{
		thread maps\_utility::hintdisplaymintimehandler("player_input_shaft_buttons_pc_alt",30);
	}

	var_09 = setup_mech_for_drop(1);
	var_0A = 0;
	if(isdefined(var_09.speed))
	{
		var_0A = var_09.speed[2];
	}

	level.player rigsetvelocity(var_0A,0);
	level.player rigsetgravity(level.player getgravity());
	var_0B = var_0A;
	var_0C = undefined;
	var_09.anim_state = "";
	var_09.wait_for_anim = 0;
	thread process_animation(var_09,level.drop_locator);
	thread process_fov(var_09);
	maps\finale_utility::set_level_player_rumble_ent_intensity(0.1);
	soundscripts\_snd::snd_message("shaft_descent_start");
	while(level.player.origin[2] > var_07.origin[2] + 2)
	{
		var_0A = level.player riggetvelocity();
		soundscripts\_snd::snd_message("shaft_descent_speed_update",var_0A);
		var_0D = level.player attackbuttonpressed();
		var_0E = level.player adsbuttonpressed(1);
		if(var_0D && var_0E)
		{
			var_09.anim_state = "shaft_both_hands";
		}
		else if(var_0D)
		{
			var_09.anim_state = "shaft_right_hand";
		}
		else if(var_0E)
		{
			var_09.anim_state = "shaft_left_hand";
		}
		else
		{
			var_09.anim_state = "shaft_no_hands";
		}

		if(var_09.anim_state != var_04)
		{
			soundscripts\_snd::snd_message("shaft_descent_state_change",var_04,var_09.anim_state);
			switch(var_09.anim_state)
			{
				case "shaft_both_hands":
				case "shaft_right_hand_to_both":
				case "shaft_left_hand_to_both":
				case "shaft_no_hands_to_both":
					var_01 = -400;
					if(isdefined(var_01) && var_0A < var_01)
					{
						var_00 = -400;
					}
					else
					{
						var_00 = var_05 * 0.5;
					}
	
					var_02 = "less";
					maps\finale_utility::set_level_player_rumble_ent_intensity(0.8);
					break;

				case "shaft_right_hand":
				case "shaft_left_hand_to_right":
				case "shaft_no_hands_to_right":
				case "shaft_both_hands_to_right":
					var_01 = -700;
					if(isdefined(var_01) && var_0A < var_01)
					{
						var_00 = -200;
					}
					else
					{
						var_00 = var_05 * 0.5;
					}
	
					var_02 = "more";
					maps\finale_utility::set_level_player_rumble_ent_intensity(0.4);
					break;

				case "shaft_left_hand":
				case "shaft_right_hand_to_left":
				case "shaft_no_hands_to_left":
				case "shaft_both_hands_to_left":
					var_01 = -700;
					if(isdefined(var_01) && var_0A < var_01)
					{
						var_00 = -200;
					}
					else
					{
						var_00 = var_05 * 0.5;
					}
	
					var_02 = "more";
					maps\finale_utility::set_level_player_rumble_ent_intensity(0.4);
					break;

				case "shaft_no_hands":
				case "shaft_right_hand_to_no":
				case "shaft_left_hand_to_no":
				case "shaft_both_hands_to_no":
					var_01 = -1200;
					var_00 = var_05;
					var_02 = "none";
					maps\finale_utility::set_level_player_rumble_ent_intensity(0.1);
					break;
			}

			if(!isdefined(var_01))
			{
				var_03 = "speedup";
			}
			else if(var_01 > var_0A)
			{
				var_03 = "slowdown";
			}
			else if(var_01 < var_0A)
			{
				var_03 = "speedup";
			}
		}

		if(var_03 != "constantspeed" && level.player riggetgravity() != var_00)
		{
			level.player rigsetgravity(var_00);
		}

		if(isdefined(var_01))
		{
			if(is_speed_target_just_reached(var_03,var_0B,var_0A,var_01))
			{
				level.player rigsetvelocity(var_01);
				level.player rigsetgravity(0);
				var_03 = "constantspeed";
				if(var_0A == 0)
				{
					var_02 = "strong";
				}
			}
			else if(var_0A == 0)
			{
				var_02 = "none";
			}
		}

		var_0B = var_0A;
		var_04 = var_09.anim_state;
		level.player rigprocessvelocity();
	}

	maps\finale_utility::set_level_player_rumble_ent_intensity(0);
	soundscripts\_snd::snd_message("shaft_descent_end");
	level.player notify("free_fall_done");
	if(0)
	{
		level.player resetgravityoverride();
	}

	var_09.anim_state = "drop_finished";
	var_09 unlink();
	level notify("kill_drop_fx_thread");
	var_0F = level.player.health;
	var_10 = level.player riggetvelocity();
	var_11 = getgroundposition(level.player.origin,5);
	var_12 = animscripts\utility::get_trajectory_v_given_x(level.player.origin[2],var_11[2],var_10,-1 * level.player getgravity());
	if(var_12 < -1200)
	{
		var_12 = -1200;
	}

	var_13 = maps\_player_land_assist::do_custom_fall_damage(var_12,0);
	if(var_13 > 50)
	{
		var_09 thread maps\_playermech_code::scripted_screen_flicker_loop(5);
	}

	if(var_0B <= -1200 || var_13 >= var_0F)
	{
		level.player.player_failed_drop = 1;
		level.player maps\_playermech_code::mech_setup_player_for_gameplay();
		var_09 hide();
		var_09 unlink();
		level.player unlink();
		level.player setvelocity((0,0,level.drop_locator.speed));
		var_14 = level.player dodamage(999999,level.player.origin);
		maps\_utility::missionfailedwrapper();
		wait(1111);
		return;
	}

	common_scripts\utility::flag_set("flag_player_exhaust_corridor");
}

//Function Number: 24
is_speed_target_just_reached(param_00,param_01,param_02,param_03)
{
	if(param_01 != param_02)
	{
		if(param_00 == "slowdown" && param_02 >= param_03 - 10)
		{
			return 1;
		}

		if(param_00 == "speedup" && param_02 <= param_03 + 10)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 25
do_shake(param_00)
{
	level.player endon("free_fall_done");
	level.player endon("death");
	if(isdefined(level.player.shake_in_progress) && level.player.shake_in_progress == param_00)
	{
		return;
	}

	if(param_00 == "none")
	{
		return;
	}

	level.player.shake_in_progress = param_00;
	var_01 = level.player getgravity();
	if(param_00 == "less")
	{
		var_02 = 0.4 + randomfloat(100) * 0.01 * 0.25;
		var_03 = 0.2 + randomfloat(100) * 0.01 * 0.5;
		var_02 = var_02 * 0.5;
		earthquake(var_02,var_03,level.player.origin,100);
		wait(var_03 * 0.5);
	}
	else if(param_00 == "more")
	{
		var_02 = 0.4 + randomfloat(100) * 0.01 * 0.25;
		var_03 = 0.2 + randomfloat(100) * 0.01 * 0.5;
		earthquake(var_02,var_03,level.player.origin,100);
		wait(var_03 * 0.5);
	}
	else if(param_00 == "strong")
	{
		var_02 = 0.4 + randomfloat(100) * 0.01 * 0.25;
		var_03 = 0.2 + randomfloat(100) * 0.01 * 0.5;
		var_02 = var_02 * 1.5;
		earthquake(var_02,var_03,level.player.origin,100);
		wait(var_03 * 0.5);
	}

	level.player.shake_in_progress = undefined;
}

//Function Number: 26
process_fov(param_00)
{
	var_01 = getdvarint("cg_fov");
	var_02 = 1;
	var_03 = 1.25;
	var_04 = 0;
	var_05 = var_02;
	var_06 = var_03 - var_05 / squared(-1200 - var_04);
	while(isdefined(param_00) && param_00.anim_state != "drop_finished")
	{
		var_07 = level.player riggetvelocity();
		var_08 = var_06 * squared(var_07 - var_04) + var_05;
		level.player lerpfovscale(var_08,0.05);
		wait 0.05;
	}

	level.player lerpfovscale(1,1);
}

//Function Number: 27
get_fx_count_for_speed(param_00)
{
	for(var_01 = self.drop_thresholds.size - 1;var_01 >= 0;var_01--)
	{
		if(param_00 < self.drop_thresholds[var_01])
		{
			return self.drop_fx_count[var_01];
		}
	}

	return 1;
}

//Function Number: 28
drop_fx_thread(param_00,param_01)
{
	level notify("kill_drop_fx_thread");
	level endon("kill_drop_fx_thread");
	for(;;)
	{
		wait 0.05;
		waittillframeend;
		waittillframeend;
		waittillframeend;
		if(param_01.fx_current < param_01.fx_goal_count)
		{
			param_01.fx_current++;
			playfx_fordrop(param_00,param_01);
			continue;
		}

		if(param_01.fx_current > param_01.fx_goal_count)
		{
			param_01.fx_current = 0;
			stopfx_fordrop(param_00,param_01);
		}
	}
}

//Function Number: 29
process_animation(param_00,param_01)
{
	param_00 endon("death");
	if(!isdefined(self.drop_thresholds))
	{
		param_00.drop_thresholds = [0,-200,-400,-600,-800,-1000];
		param_00.drop_fx_count = [1,1,2,3,4,6];
	}

	if(!isdefined(param_00.anim_state))
	{
		param_00.anim_state = "shaft_no_hands";
	}

	var_02 = "";
	var_03 = 1000;
	param_00.tag_left_hand = "j_wrist_le";
	param_00.tag_right_hand = "j_wrist_ri";
	param_00.tag_left_foot = "j_ball_le";
	param_00.tag_right_foot = "j_ball_ri";
	param_00.fx_goal_count = 0;
	param_00.fx_current = 0;
	for(;;)
	{
		waittillframeend;
		var_04 = param_00.anim_state;
		var_05 = level.player riggetvelocity();
		if(var_02 != var_04)
		{
			if(var_04 == "drop_finished")
			{
				stopfx_fordrop(var_02,param_00);
				return;
			}

			param_00 notify("stop_anim_state");
			param_01 notify("stop_anim_state");
			if(0)
			{
				var_06 = param_00 getlinkedparent();
				if(isdefined(var_06))
				{
					var_06 setviewmodelanim(level.scr_anim_viewmodel[var_04]);
				}
			}

			if(is_transition(var_04))
			{
				param_00.wait_for_anim = 1;
				param_01 thread anim_single_solo_with_wait_flag(param_00,var_04,"TAG_ORIGIN_ANIMATED");
				param_00 set_cam_shake_drop(var_04);
			}
			else
			{
				param_00.wait_for_anim = 0;
				param_01 thread maps\_anim::anim_loop_solo(param_00,var_04,"stop_anim_state","TAG_ORIGIN_ANIMATED");
				param_00 set_cam_shake_drop(var_04);
			}

			param_00.fx_current = 0;
			param_00.fx_goal_count = 0;
			stopfx_fordrop(var_02,param_00);
			thread drop_fx_thread(var_04,param_00);
			var_02 = var_04;
		}

		if(var_04 == "shaft_no_hands")
		{
			param_00.fx_goal_count = 0;
		}
		else
		{
			param_00.fx_goal_count = param_00 get_fx_count_for_speed(var_05);
		}

		var_03 = var_05;
		wait 0.05;
	}
}

//Function Number: 30
anim_single_solo_with_wait_flag(param_00,param_01,param_02)
{
	param_00 endon("death");
	maps\_anim::anim_single_solo(param_00,param_01,param_02);
	param_00.wait_for_anim = 0;
}

//Function Number: 31
is_transition_to_right(param_00)
{
	if(issubstr(param_00,"_to_right"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
is_transition_to_no(param_00)
{
	if(issubstr(param_00,"_to_no"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
is_transition_to_both(param_00)
{
	if(issubstr(param_00,"_to_both"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
is_transition_to_left(param_00)
{
	if(issubstr(param_00,"_to_left"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
is_transition(param_00)
{
	if(issubstr(param_00,"_to_"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
playfx_fordrop(param_00,param_01)
{
	playorstopfx_fordrop(1,param_00,param_01);
}

//Function Number: 37
stopfx_fordrop(param_00,param_01)
{
	playorstopfx_fordrop(0,param_00,param_01);
}

//Function Number: 38
playfxontag_functionhack(param_00,param_01,param_02)
{
	playfxontag(param_00,param_01,param_02);
}

//Function Number: 39
stopfxontag_functionhack(param_00,param_01,param_02)
{
	stopfxontag(param_00,param_01,param_02);
}

//Function Number: 40
playorstopfx_fordrop(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_00 == 1)
	{
		var_03 = ::playfxontag_functionhack;
	}
	else
	{
		var_03 = ::stopfxontag_functionhack;
	}

	switch(param_01)
	{
		case "shaft_both_hands":
		case "shaft_right_hand_to_both":
		case "shaft_left_hand_to_both":
		case "shaft_no_hands_to_both":
			[[ var_03 ]](common_scripts\utility::getfx("sparks_runner_lp_sml"),param_02,param_02.tag_right_hand);
			[[ var_03 ]](common_scripts\utility::getfx("sparks_runner_lp_sml"),param_02,param_02.tag_left_hand);
			[[ var_03 ]](common_scripts\utility::getfx("sparks_runner_lp_sml"),param_02,param_02.tag_left_foot);
			[[ var_03 ]](common_scripts\utility::getfx("sparks_runner_lp_sml"),param_02,param_02.tag_right_foot);
			break;

		case "shaft_left_hand":
		case "shaft_right_hand_to_left":
		case "shaft_no_hands_to_left":
		case "shaft_both_hands_to_left":
			[[ var_03 ]](common_scripts\utility::getfx("sparks_runner_lp_sml"),param_02,param_02.tag_right_hand);
			[[ var_03 ]](common_scripts\utility::getfx("sparks_runner_lp_sml"),param_02,param_02.tag_left_foot);
			break;

		case "shaft_right_hand":
		case "shaft_left_hand_to_right":
		case "shaft_no_hands_to_right":
		case "shaft_both_hands_to_right":
			[[ var_03 ]](common_scripts\utility::getfx("sparks_runner_lp_sml"),param_02,param_02.tag_left_hand);
			[[ var_03 ]](common_scripts\utility::getfx("sparks_runner_lp_sml"),param_02,param_02.tag_right_foot);
			break;

		case "shaft_no_hands":
		case "shaft_right_hand_to_no":
		case "shaft_left_hand_to_no":
		case "shaft_both_hands_to_no":
			break;
	}
}

//Function Number: 41
player_input_shaft_buttons_off()
{
	if(gettime() > level.player.hint_allow_hide_time && level.player buttonpressed("BUTTON_LTRIG") || level.player buttonpressed("BUTTON_RTRIG"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("flag_player_exhaust_corridor"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
get_walk_anim(param_00)
{
	if(param_00 == "handsblocking")
	{
		return "blast_walk";
	}

	if(param_00 == "nohands")
	{
		return "blast_walk_nohands";
	}

	if(param_00 == "noguns")
	{
		return "blast_walk_nogun";
	}
}

//Function Number: 43
get_idle_anim(param_00)
{
	if(param_00 == "handsblocking")
	{
		return "blast_idle";
	}

	if(param_00 == "nohands")
	{
		return "blast_idle_nohands";
	}

	if(param_00 == "noguns")
	{
		return "blast_idle_nogun";
	}
}

//Function Number: 44
think_player_blast_walk_anims(param_00)
{
	var_01 = "none";
	var_02 = "";
	level.player notify("kill_think_player_blast_walk_anims");
	level.player endon("kill_think_player_blast_walk_anims");
	thread maps\finale_anim_vm::anim_loop_solo_vm(level.player,get_idle_anim(param_00),"kill_think_player_blast_walk_anims");
	for(;;)
	{
		var_03 = level.player getnormalizedmovement()[0];
		if(var_03 > 0.1 || var_03 < -0.5)
		{
			var_02 = get_walk_anim(param_00);
			if(var_02 != var_01)
			{
				level.player setadditiveviewmodelanim(maps\finale_anim_vm::getanim_vm_index(var_02));
			}
		}
		else
		{
			var_02 = get_idle_anim(param_00);
			if(var_02 != var_01)
			{
				level.player setadditiveviewmodelanim(0);
			}
		}

		wait 0.05;
	}
}

//Function Number: 45
anim_single_solo_with_lerp(param_00,param_01)
{
	var_02 = 360;
	var_03 = 500;
	var_04 = var_02 / var_03;
	var_05 = getent("org_player_knockback_limit","targetname");
	var_06 = spawn("script_origin",var_05.origin);
	var_06.angles = (0,180,0);
	var_07 = 0;
	if(level.player.origin[0] < level.gideon.origin[0])
	{
		var_07 = 1;
	}

	if(var_07)
	{
		var_06.origin = (level.gideon.origin[0] + var_02,var_06.origin[1],var_06.origin[2]);
	}
	else
	{
		var_06.origin = (level.player.origin[0] + var_02,var_06.origin[1],var_06.origin[2]);
	}

	if(var_06.origin[0] > var_05.origin[0])
	{
		var_06.origin = (var_05.origin[0],var_06.origin[1],var_06.origin[2]);
	}

	var_04 = var_02 / var_03;
	param_00 = level.player.player_rig;
	if(!isdefined(param_00))
	{
		param_00 = maps\_utility::spawn_anim_model("world_body_mech",level.player.origin + (0,0,30),level.player.angles);
		maps\_playermech_code::hide_mech_glass_static_overlay(param_00);
	}

	level.player thread maps\_playermech_code::scripted_screen_flicker_loop();
	param_00 thread maps\_playermech_code::scripted_screen_flicker_loop();
	level.player notify("kill_think_player_blast_walk_anims");
	do_player_explode_react(param_00,var_06);
}

//Function Number: 46
do_player_explode_react(param_00,param_01)
{
	level.player maps\_anim::anim_first_frame_solo(param_00,"exhaust_blast_react");
	param_00.origin = level.player.origin;
	param_00.angles = param_01.angles;
	param_00 show();
	level.player maps\_playermech_code::mech_setup_player_for_scene();
	param_00 thread lerp_to_target(param_01.origin,param_01.angles,1,0.25);
	level.player thread anim_single_solo_in_place(param_00,"exhaust_blast_react");
	level.player playerlinktoabsolute(param_00,"TAG_PLAYER");
	var_02 = getanimlength(param_00 maps\_utility::getanim("exhaust_blast_react"));
	wait(var_02);
	thread think_player_blast_walk_anims("noguns");
	level.player maps\_playermech_code::mech_setup_player_for_forced_walk_scene();
	wait 0.05;
	level.player unlink();
	param_00 hide();
	thread maps\finale_code::exhaust_corridor_timer();
}

//Function Number: 47
lerp_to_target(param_00,param_01,param_02,param_03)
{
	var_04 = level.player.origin;
	var_05 = level.player.angles;
	var_06 = spawn("Script_origin",(var_04[0],var_04[1],param_00[2]));
	var_06.angles = var_05;
	self linkto(var_06);
	var_06 moveto(param_00,param_02,param_02 * 0.25);
	var_06 rotateto(param_01,param_03,param_03 * 0.25);
	wait(param_02);
	self unlink();
	var_06 delete();
}

//Function Number: 48
anim_single_solo_in_place(param_00,param_01)
{
	param_00 maps\_anim::anim_single_solo(param_00,param_01);
	param_00 notify("anim_done");
}