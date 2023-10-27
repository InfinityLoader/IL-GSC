/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_arcademode.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 1079 ms
 * Timestamp: 10/27/2023 2:22:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachestring(&"SCRIPT_COLON");
	precachestring(&"SCRIPT_TIME_REMAINING");
	precachestring(&"SCRIPT_TOTAL_SCORE");
	precachestring(&"SCRIPT_EXTRA_LIFE");
	precachestring(&"SCRIPT_CHECKPOINT");
	precachestring(&"SCRIPT_MISSION_SCORE");
	precachestring(&"SCRIPT_ZERO_DEATHS");
	precachestring(&"SCRIPT_PLUS");
	precachestring(&"SCRIPT_TIME_UP");
	precachestring(&"SCRIPT_1UP");
	precachestring(&"SCRIPT_GAME_OVER");
	precachestring(&"SCRIPT_DIFFICULTY_BONUS_ONEANDAHALF");
	precachestring(&"SCRIPT_DIFFICULTY_BONUS_THREE");
	precachestring(&"SCRIPT_DIFFICULTY_BONUS_FOUR");
	precachestring(&"SCRIPT_MISSION_COMPLETE");
	precachestring(&"SCRIPT_NEW_HIGH_SCORE");
	precachestring(&"SCRIPT_STREAK_BONUS_LOST");
	precachestring(&"SCRIPT_STREAK_COMPLETE");
	precachestring(&"SCRIPT_X");
	precacheshader("arcademode_life");
	level.color_cool_green = (0.8,2,0.8);
	level.color_cool_green_glow = (0.3,0.6,0.3);
	arcademode_init_kill_streak_colors();
	level.arcademode_checkpoint_dvars = [];
	level.arcademode_checkpoint_max = 10;
	level.arcademode_kills_hud = [];
	level.arcademode_kill_streak_ends = 0;
	level.arcademode_last_streak_time = 0;
	level.arcademode_ramping_score = 0;
	level.arcademode_new_kill_streak_allowed = 1;
	common_scripts\utility::flag_init("arcadeMode_multiplier_maxed");
	setdvar("arcademode_lives_changed",0);
	level.arcademode_kill_streak_current_multiplier = 1;
	level.arcademode_kill_streak_multiplier_count = 3;
	arcademode_reset_kill_streak();
	for(var_00 = 0;var_00 < level.arcademode_checkpoint_max;var_00++)
	{
		setdvar("arcademode_checkpoint_" + var_00,"");
	}

	level.arcademode_last_multi_kill_sound = 0;
	level.arcademode_success = 0;
	arcademode_define_damage_multipliers();
	common_scripts\utility::flag_init("arcademode_complete");
	common_scripts\utility::flag_init("arcademode_ending_complete");
	waittillframeend;
	level.global_kill_func = ::player_kill;
	level.global_damage_func_ads = ::player_damage_ads;
	level.global_damage_func = ::player_damage;
	level.arcademode_hud_sort = 50;
	level.arcademode_maxlives = 10;
	level.arcademode_rewarded_lives = 0;
	if(getdvar("arcademode_lives") == "" || getdvar("arcademode_full") != "1" || level.script == "cargoship")
	{
		setdvar("arcademode_lives",2);
		level.arcademode_rewarded_lives = 2;
	}

	if(getdvar("arcademode_full") == "1" && level.script == "cargoship")
	{
		setdvar("arcademode_lives",5);
		level.arcademode_rewarded_lives = 5;
	}

	var_01 = getdvarint("arcadeMode_lives");
	setdvar("arcademode_earned_lives",var_01);
	level.arcademode_playthrough = getdvarint("arcademode_playthrough_count");
	level.arcademode_playthrough++;
	setdvar("arcademode_playthrough_count",level.arcademode_playthrough);
	setdvar("arcademode_died",0);
	setdvar("arcademode_score",0);
	if(getdvar("arcademode_combined_score") == "" || getdvar("arcademode_full") == "1" && level.script == "cargoship")
	{
		setdvar("arcademode_combined_score",0);
	}

	var_02 = arcademode_get_level_time();
	var_02 = var_02 * 60;
	level.arcdemode_starttime = gettime();
	level.arcademode_time = var_02;
	level.arcademode_killbase = 50;
	level.arcademode_damagebase = 5;
	level.arcademode_multikills = [];
	var_03 = getarraykeys(level.arcademode_weaponmultiplier);
	for(var_00 = 0;var_00 < var_03.size;var_00++)
	{
		level.arcademode_multikills[var_03[var_00]] = [];
	}

	var_04 = level.arcademode_multikills;
	thread arcademode_update_lives();
	thread arcademode_update_score();
	thread arcademode_update_timer();
	thread arcademode_death_detection();
	arcademode_redraw_lives(var_01);
	for(;;)
	{
		wait 0.05;
		waittillframeend;
		waittillframeend;
		var_03 = getarraykeys(level.arcademode_multikills);
		common_scripts\utility::array_levelthread(var_03,::arcademode_add_points_for_mod);
		level.arcademode_multikills = var_04;
	}
}

//Function Number: 2
arcademode_complete()
{
	if(getdvar("arcademode") != "1")
	{
		return 0;
	}

	return common_scripts\utility::flag("arcademode_complete");
}

//Function Number: 3
arcademode_get_level_time()
{
	var_00 = 20;
	var_01 = [];
	var_02 = 1;
	if(isdefined(var_01[level.script]))
	{
		var_00 = var_01[level.script];
	}

	level.arcademode_difficultytimerscale = var_02;
	return var_00;
}

//Function Number: 4
arcademode_death_detection()
{
	level endon("arcademode_complete");
	level maps\_utility::add_wait(::common_scripts\utility::flag_wait,"missionfailed");
	level.player maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::do_wait_any();
	setdvar("arcademode_died",1);
	var_00 = getdvarint("arcademode_lives");
	var_01 = getdvarint("arcademode_earned_lives");
	if(var_00 > var_01)
	{
		var_00 = var_01;
	}

	var_00 = var_00 - 1;
	setdvar("arcademode_lives",var_00);
	setdvar("arcademode_lives_changed",-1);
	arcademode_redraw_lives(var_00 + 1);
	level.arcademode_redraw_score = 1;
	updatescoreelemsonce();
	if(var_00 < 0)
	{
		wait 1.5;
		level.arcademode_failurestring = &"SCRIPT_GAME_OVER";
		thread arcademode_ends();
		return;
	}

	if(isalive(level.player))
	{
		missionfailed();
	}
}

//Function Number: 5
arcademode_update_timer()
{
	level.player endon("death");
	var_00 = newhudelem();
	var_00.foreground = 1;
	var_00.alignx = "right";
	var_00.aligny = "top";
	var_00.horzalign = "right";
	var_00.vertalign = "top";
	var_00.x = 0;
	var_00.y = 60;
	var_00.sort = level.arcademode_hud_sort;
	var_00.fontscale = 3;
	var_00.color = (0.8,1,0.8);
	var_00.font = "objective";
	var_00.glowcolor = (0.3,0.6,0.3);
	var_00.glowalpha = 1;
	var_00.hidewheninmenu = 1;
	level.arcademode_hud_timer = var_00;
	level endon("arcadeMode_remove_timer");
	var_01 = level.arcademode_time;
	var_00 settimer(var_01 - 0.1);
	wait var_01;
	level.arcademode_failurestring = &"SCRIPT_TIME_UP";
	thread arcademode_ends();
}

//Function Number: 6
arcademode_update_lives()
{
	level.player endon("death");
	level endon("missionfailed");
	level.arcademode_lives_hud = [];
	for(var_00 = 0;var_00 < level.arcademode_maxlives;var_00++)
	{
		arcademode_add_life(var_00,16,78,-18,64,level.arcademode_hud_sort);
	}

	for(;;)
	{
		var_01 = getdvarint("arcademode_lives_changed");
		if(var_01 != 0)
		{
			var_02 = getdvarint("arcademode_lives");
			if(var_02 < 0)
			{
				level.arcademode_failurestring = &"SCRIPT_GAME_OVER";
				thread arcademode_ends();
				return;
			}

			if(var_01 == -1)
			{
				level notify("lost_streak");
				level.arcademode_kill_streak_ends = gettime();
				thread arcademode_add_kill_streak_time(0);
				level.arcademode_new_kill_streak_allowed = 0;
				var_03 = getdvarint("arcademode_earned_lives");
				var_03--;
				var_02 = var_03;
				setdvar("arcademode_earned_lives",var_03);
				setdvar("arcademode_lives",var_03);
			}

			arcademode_redraw_lives(var_02);
			level.arcademode_redraw_score = 1;
			setdvar("arcademode_lives_changed",0);
		}

		wait 0.05;
	}
}

//Function Number: 7
arcademode_convert_extra_lives()
{
	var_00 = getdvarint("arcademode_lives");
	var_01 = getdvarint("arcademode_earned_lives");
	if(var_00 > var_01)
	{
		thread extra_lives_display(var_00 - var_01);
	}

	setdvar("arcademode_earned_lives",var_00);
	thread arcademode_redraw_lives(var_00);
	return var_00 > var_01;
}

//Function Number: 8
arcademode_checkpoint_print()
{
	if(!maps\_utility::arcademode())
	{
		return;
	}

	arcademode_convert_extra_lives();
	var_00 = 800;
	var_01 = 0.8;
	level.player thread common_scripts\utility::play_sound_in_space("arcademode_checkpoint",level.player geteye());
	thread draw_checkpoint(var_00,var_01,1);
	thread draw_checkpoint(var_00,var_01,-1);
}

//Function Number: 9
arcademode_redraw_life(param_00,param_01)
{
	if(param_00 >= param_01)
	{
		self setshader("arcademode_life",64,64);
	}
	else
	{
		self setshader("stance_stand",64,64);
	}

	self fadeovertime(1);
	self.alpha = 1;
	self.glowalpha = 1;
	self.color = level.color_cool_green;
}

//Function Number: 10
arcademode_remove_life(param_00)
{
	if(self.alpha <= 0)
	{
		return;
	}

	self fadeovertime(1);
	self.alpha = 0;
	self.color = (1,0,0);
	self.glowalpha = 0;
}

//Function Number: 11
arcademode_redraw_lives(param_00)
{
	if(param_00 > 10)
	{
		param_00 = 10;
	}

	var_01 = getdvarint("arcademode_earned_lives");
	for(var_02 = 0;var_02 < param_00;var_02++)
	{
		level.arcademode_lives_hud[var_02] arcademode_redraw_life(var_02,var_01);
	}

	for(var_02 = param_00;var_02 < level.arcademode_maxlives;var_02++)
	{
		if(var_02 < 0)
		{
			continue;
		}

		if(var_02 >= 10)
		{
			continue;
		}

		level.arcademode_lives_hud[var_02] arcademode_remove_life(var_02);
	}
}

//Function Number: 12
arcademode_update_streak_progress()
{
	for(;;)
	{
		level common_scripts\utility::waittill_either("arcademode_decrement_kill_streak","arcademode_new_kill");
		waittillframeend;
		arcademode_redraw_streak_progress();
	}
}

//Function Number: 13
arcademode_redraw_streak_progress()
{
	for(var_00 = 0;var_00 < level.arcademode_kill_streak_current_count;var_00++)
	{
		if(var_00 >= level.arcademode_kills_hud.size)
		{
			return;
		}

		level.arcademode_kills_hud[var_00].color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
		level.arcademode_kills_hud[var_00].glowcolor = level.arcademode_streak_glow[level.arcademode_kill_streak_current_multiplier - 1];
	}

	var_01 = 0;
	for(;;)
	{
		var_02 = level.arcademode_kill_streak_current_multiplier + var_01;
		if(var_02 >= level.arcademode_streak_color.size)
		{
			var_02 = level.arcademode_streak_color.size - 1;
		}

		for(var_00 = level.arcademode_kill_streak_current_count + var_01 * level.arcademode_kill_streak_multiplier_count;var_00 < level.arcademode_kill_streak_current_count + var_01 + 1 * level.arcademode_kill_streak_multiplier_count;var_00++)
		{
			if(var_00 >= level.arcademode_kills_hud.size)
			{
				return;
			}

			level.arcademode_kills_hud[var_00].color = level.arcademode_streak_color[var_02];
			level.arcademode_kills_hud[var_00].glowcolor = level.arcademode_streak_glow[var_02];
		}

		var_01++;
	}
}

//Function Number: 14
arcademode_add_kill(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("arcademode_stop_kill_streak_art");
	var_06 = newhudelem();
	var_06.foreground = 1;
	var_06.x = param_01 + param_00 * param_03;
	if(level.arcademode_kills_hud.size == 0)
	{
		level.arcademode_kill_zero_x_location = var_06.x;
	}

	var_06.y = param_02;
	var_06 setshader("arcademode_kill",param_04,param_04);
	var_06.alignx = "right";
	var_06.aligny = "top";
	var_06.horzalign = "right";
	var_06.vertalign = "top";
	var_06.sort = param_05;
	var_06.color = level.color_cool_green;
	var_06.glowcolor = level.color_cool_green_glow;
	var_06.glowalpha = 1;
	var_06.hidewheninmenu = 1;
	var_07 = 0;
	level.arcademode_kills_hud[level.arcademode_kills_hud.size] = var_06;
	if(level.arcademode_kills_hud.size == 10)
	{
		var_07 = 1;
		var_06.alpha = 0;
	}
	else
	{
		var_06.alpha = 1;
	}

	for(;;)
	{
		if(var_06.x == level.arcademode_kill_zero_x_location)
		{
			var_08 = 4;
			if(level.arcademode_kills_hud.size == 1)
			{
				wait 3;
			}

			var_06 fadeovertime(var_08);
			var_06.color = (1,0,0);
			var_06.alpha = 0;
			wait var_08;
			level notify("arcademode_decrement_kill_streak");
			var_06 destroy();
			for(var_09 = 0;var_09 < level.arcademode_kills_hud.size - 1;var_09++)
			{
				level.arcademode_kills_hud[var_09] = level.arcademode_kills_hud[var_09 + 1];
			}

			level.arcademode_kills_hud[level.arcademode_kills_hud.size - 1] = undefined;
			if(!level.arcademode_kills_hud.size)
			{
				thread arcademode_reset_kill_streak();
			}

			return;
		}

		level waittill("arcademode_decrement_kill_streak");
		wait 0.05;
		var_08 moveovertime(0.5);
		var_08.x = var_08.x - param_05;
		if(var_09)
		{
			var_08 fadeovertime(0.5);
			var_08.alpha = 1;
			var_09 = 0;
		}
	}
}

//Function Number: 15
get_streak_hud(param_00,param_01,param_02,param_03)
{
	var_04 = newhudelem();
	var_04.foreground = 1;
	var_04.x = param_00 + -4;
	var_04.y = param_01 + 14;
	var_04.alignx = "right";
	var_04.aligny = "top";
	var_04.horzalign = "right";
	var_04.vertalign = "top";
	var_04.color = level.color_cool_green;
	var_04.sort = level.arcademode_hud_sort - 1;
	var_04.alpha = 0;
	var_04.glowcolor = level.color_cool_green_glow;
	var_04.glowalpha = 0;
	var_04.hidewheninmenu = 1;
	var_04 setshader("white",param_02,param_03);
	return var_04;
}

//Function Number: 16
arcademode_add_kill_streak_time(param_00)
{
	if(!level.arcademode_new_kill_streak_allowed)
	{
		return;
	}

	level notify("arcademode_new_kill_streak_time");
	level endon("arcademode_new_kill_streak_time");
	if(level.arcademode_kill_streak_ends < gettime())
	{
		level.arcademode_kill_streak_ends = gettime() + param_00 * 1000;
	}
	else
	{
		level.arcademode_kill_streak_ends = level.arcademode_kill_streak_ends + param_00 * 1000;
	}

	waittillframeend;
	if(isdefined(level.arcademode_hud_streak))
	{
		level.arcademode_hud_streak fadeovertime(0.05);
		level.arcademode_hud_streak.alpha = 1;
	}

	var_01 = 26;
	var_02 = 12;
	var_03 = 90;
	var_04 = level.arcademode_streak_hud;
	var_05 = level.arcademode_streak_hud_shadow;
	var_06 = level.arcademode_kill_streak_ends - gettime();
	var_06 = var_06 * 0.001;
	if(var_06 > var_03)
	{
		var_06 = var_03;
	}

	var_06 = var_06 * var_02;
	var_06 = int(var_06);
	if(var_06 > 980)
	{
		var_06 = 980;
	}

	if(!isdefined(var_04))
	{
		var_04 = get_streak_hud(0,0,var_06,var_01);
		var_05 = get_streak_hud(3,3,var_06,var_01);
		var_05.sort = var_05.sort - 1;
		var_05.alpha = 0;
		var_05.color = (0,0,0);
	}
	else
	{
		var_04 scaleovertime(1,var_06,var_01);
		var_05 scaleovertime(1,var_06,var_01);
		wait 1;
	}

	level.arcademode_streak_hud = var_04;
	level.arcademode_streak_hud_shadow = var_05;
	var_04 endon("death");
	param_00 = level.arcademode_kill_streak_ends - gettime();
	param_00 = param_00 * 0.001;
	var_07 = int(param_00);
	if(var_07 > var_03)
	{
		var_07 = var_03;
		wait param_00 - var_07;
	}

	for(;;)
	{
		var_06 = level.arcademode_kill_streak_ends - gettime();
		var_06 = var_06 * 0.001;
		var_08 = var_06;
		if(isdefined(level.arcademode_hud_streak))
		{
			level.arcademode_hud_streak fadeovertime(1);
			level.arcademode_hud_streak.alpha = var_08 - 1 / 5;
		}

		var_06 = var_06 * var_02;
		var_06 = int(var_06);
		if(var_06 <= 0)
		{
			var_06 = 1;
		}

		if(var_06 > 980)
		{
			var_06 = 980;
		}

		var_04 scaleovertime(1,var_06,var_01);
		var_05 scaleovertime(1,var_06,var_01);
		wait 1;
		if(var_06 == 1)
		{
			break;
		}
	}

	thread arcademode_reset_kill_streak();
}

//Function Number: 17
arcademode_add_kill_streak()
{
	if(common_scripts\utility::flag("arcadeMode_multiplier_maxed"))
	{
		return;
	}

	level endon("arcadeMode_multiplier_maxed");
	level endon("arcademode_stop_kill_streak");
	level.arcademode_kill_streak_current_count--;
	var_00 = gettime();
	if(level.arcademode_kill_streak_current_count <= 0 && var_00 > level.arcademode_last_streak_time)
	{
		level.arcademode_last_streak_time = var_00;
		var_01 = level.arcademode_kill_streak_current_multiplier;
		level.arcademode_kill_streak_current_multiplier++;
		if(level.arcademode_kill_streak_current_multiplier >= level.arcademode_streak_color.size)
		{
			level.arcademode_kill_streak_current_multiplier = level.arcademode_streak_color.size;
			thread arcademode_multiplier_maxed();
		}

		if(var_01 != level.arcademode_kill_streak_current_multiplier)
		{
			level notify("arcademode_new_kill_streak");
			level.player playsound("arcademode_" + level.arcademode_kill_streak_current_multiplier + "x");
			thread arcademode_draw_multiplier();
		}

		level.arcademode_kill_streak_current_count = level.arcademode_kill_streak_multiplier_count;
	}

	level notify("arcademode_new_kill");
	for(;;)
	{
		if(level.arcademode_kills_hud.size < 10)
		{
			arcademode_add_kill_streak_time(5);
			return;
		}

		level waittill("arcademode_decrement_kill_streak");
	}
}

//Function Number: 18
streak_timer_color_pulse()
{
	waittillframeend;
	waittillframeend;
	level.arcademode_streak_hud endon("death");
	for(;;)
	{
		var_00 = randomfloatrange(0.1,1);
		level.arcademode_streak_hud fadeovertime(var_00);
		level.arcademode_streak_hud.color = (randomfloat(1),randomfloat(1),randomfloat(1));
		wait var_00;
	}
}

//Function Number: 19
arcademode_multiplier_maxed()
{
	waittillframeend;
	if(common_scripts\utility::flag("arcadeMode_multiplier_maxed"))
	{
		return;
	}

	common_scripts\utility::flag_set("arcadeMode_multiplier_maxed");
	var_00 = 20;
	level.arcademode_kill_streak_ends = gettime() + var_00 * 1000;
	thread arcademode_add_kill_streak_time(0);
	thread streak_timer_color_pulse();
	musicstop();
	wait 0.05;
	musicplay("airplane_alt_maximum_music");
	maps\_utility::add_wait(::maps\_utility::_wait,var_00 + 1);
	level maps\_utility::add_wait(::maps\_utility::waittill_msg,"lost_streak");
	maps\_utility::do_wait_any();
	thread arcademode_reset_kill_streak();
	musicstop();
	if(isdefined(level.last_song))
	{
		wait 0.05;
		musicplay(level.last_song);
	}
}

//Function Number: 20
get_hud_score()
{
	var_00 = newhudelem();
	var_00.foreground = 1;
	var_00.x = 0;
	var_00.y = 10;
	var_00.alignx = "right";
	var_00.aligny = "top";
	var_00.horzalign = "right";
	var_00.vertalign = "top";
	var_00.score = 0;
	var_00.font = "objective";
	var_00.fontscale = 5;
	var_00.sort = level.arcademode_hud_sort;
	var_00.glowcolor = level.color_cool_green_glow;
	var_00.glowalpha = 1;
	var_00.hidewheninmenu = 1;
	return var_00;
}

//Function Number: 21
arcademode_update_score()
{
	level.player endon("death");
	level.arcademode_hud_digits = 10;
	level.arcademode_hud_scores = [];
	for(var_00 = 0;var_00 < level.arcademode_hud_digits;var_00++)
	{
		level.arcademode_hud_scores[level.arcademode_hud_scores.size] = get_hud_score();
		level.arcademode_hud_scores[level.arcademode_hud_scores.size - 1].x = var_00 * -30;
	}

	if(getdvarint("arcademode_full"))
	{
		var_01 = getdvarint("arcademode_combined_score");
	}
	else
	{
		var_01 = getdvarint("arcademode_score");
	}

	hud_draw_score(var_01);
	level.arcademode_redraw_score = 0;
	for(;;)
	{
		wait 0.05;
		updatescoreelemsonce();
		if(level.arcademode_redraw_score)
		{
			level.arcademode_redraw_score = 0;
		}
	}
}

//Function Number: 22
updatescoreelemsonce()
{
	if(getdvarint("arcademode_full"))
	{
		hud_update_score("arcadeMode_combined_score");
		return;
	}

	hud_update_score("arcademode_score");
}

//Function Number: 23
hud_update_score(param_00)
{
	var_01 = getdvarint(param_00);
	if(level.arcademode_redraw_score)
	{
		level.arcademode_ramping_score = var_01;
		hud_draw_score(var_01);
		return;
	}

	if(level.arcademode_ramping_score >= var_01)
	{
		return;
	}

	var_02 = var_01 - level.arcademode_ramping_score;
	var_03 = var_02 * 0.2 + 1;
	if(var_02 <= 15)
	{
		var_03 = 1;
	}

	level.arcademode_ramping_score = level.arcademode_ramping_score + var_03;
	if(level.arcademode_ramping_score > var_01)
	{
		level.arcademode_ramping_score = var_01;
	}

	hud_draw_score(int(level.arcademode_ramping_score));
}

//Function Number: 24
get_digits_from_score(param_00)
{
	var_01 = [];
	param_00 = int(param_00);
	for(;;)
	{
		var_01 = int(var_01 * 0.1);
		if(var_01 <= 0)
		{
			break;
		}
	}

	return var_7B;
}

//Function Number: 25
hud_draw_score(param_00)
{
	hud_draw_score_for_elements(param_00,level.arcademode_hud_scores);
}

//Function Number: 26
hud_draw_score_for_elements(param_00,param_01)
{
	var_02 = get_digits_from_score(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(var_03 >= param_01.size - 1)
		{
			break;
		}

		param_01[var_03] setvalue(var_02[var_03]);
		param_01[var_03].alpha = 1;
	}

	for(var_03 = var_02.size;var_03 < param_01.size;var_03++)
	{
		param_01[var_03].alpha = 0;
	}

	if(param_00 == 0)
	{
		param_01[0].alpha = 1;
		param_01[0] setvalue(0);
	}
}

//Function Number: 27
arcademode_add_life(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = newhudelem();
	var_06.foreground = 1;
	var_06.x = param_01 + param_00 * param_03;
	var_06.y = param_02;
	var_06 setshader("stance_stand",param_04,param_04);
	var_06.alignx = "right";
	var_06.aligny = "top";
	var_06.horzalign = "right";
	var_06.vertalign = "top";
	var_06.sort = param_05;
	var_06.color = level.color_cool_green;
	var_06.glowcolor = level.color_cool_green_glow;
	var_06.glowalpha = 0;
	var_06.alpha = 0;
	var_06.hidewheninmenu = 1;
	level.arcademode_lives_hud[level.arcademode_lives_hud.size] = var_06;
}

//Function Number: 28
arcademode_define_damage_multipliers()
{
	var_00[0] = 40;
	level.arcademode_kills_until_next_extra_life = 10;
	level.arcademode_extra_lives_range = var_7B;
	var_01 = [];
	for(var_02 = 0;var_02 < 4;var_02++ = var_7B[3])
	{
		var_01[var_02] = var_7B[var_02] * 0.15;
	}

	level.arcademode_extra_lives_base = var_01;
}

//Function Number: 29
set_next_extra_life(param_00)
{
}

//Function Number: 30
new_ending_hud(param_00,param_01,param_02,param_03)
{
	var_04 = newhudelem();
	var_04.foreground = 1;
	var_04.x = param_02;
	var_04.y = param_03;
	var_04.alignx = param_00;
	var_04.aligny = "middle";
	var_04.horzalign = param_00;
	var_04.vertalign = "middle";
	var_04.fontscale = 3;
	if(getdvar("widescreen") == "1")
	{
		var_04.fontscale = 5;
	}

	var_04.color = (0.8,1,0.8);
	var_04.font = "objective";
	var_04.glowcolor = (0.3,0.6,0.3);
	var_04.glowalpha = 1;
	var_04.alpha = 0;
	var_04 fadeovertime(param_01);
	var_04.alpha = 1;
	var_04.hidewheninmenu = 1;
	var_04.sort = level.arcademode_hud_sort + 10;
	return var_04;
}

//Function Number: 31
extra_lives_display(param_00)
{
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		thread extra_lives_sizzle();
	}

	var_02 = new_ending_hud("center",0.2,0,-100);
	var_02.label = &"SCRIPT_EXTRA_LIFE";
	var_02 setvalue(param_00);
	var_02 setpulsefx(5,3000,1000);
	wait 5;
	var_02 destroy();
}

//Function Number: 32
fade_out(param_00)
{
	self fadeovertime(param_00);
	self.alpha = 0;
	wait param_00;
	self destroy();
}

//Function Number: 33
extra_lives_sizzle()
{
	var_00 = new_ending_hud("center",0.2,0,-100);
	var_00.alpha = randomfloatrange(0.1,0.45);
	var_00.sort = var_00.sort - 1;
	var_00 settext(&"SCRIPT_EXTRA_LIFE");
	var_00 maps\_utility::delaythread(3,::fade_out,1);
	var_00 endon("death");
	var_01 = var_00.x;
	var_02 = var_00.y;
	var_03 = 20;
	for(;;)
	{
		var_04 = randomfloatrange(0.1,0.2);
		var_00 moveovertime(var_04);
		var_00.x = var_01 + randomfloatrange(var_03 * -1,var_03);
		var_00.y = var_02 + randomfloatrange(var_03 * -1,var_03);
		wait var_04;
	}
}

//Function Number: 34
round_up_to_five(param_00)
{
	var_01 = param_00 - param_00 % 5;
	if(var_01 < param_00)
	{
		var_01 = var_01 + 5;
	}

	return var_01;
}

//Function Number: 35
arcademode_add_points(param_00,param_01,param_02,param_03)
{
	if(param_03 <= 0)
	{
		return;
	}

	if(isdefined(level.arcademode_deathtypes[param_02]))
	{
		param_02 = level.arcademode_deathtypes[param_02];
	}

	param_03 = int(param_03);
	param_03 = round_up_to_five(param_03);
	param_03 = param_03 * level.arcademode_kill_streak_current_multiplier;
	var_04 = getdvarint("arcademode_score");
	var_04 = var_04 + param_03;
	var_05 = getdvarint("arcademode_combined_score");
	var_05 = var_05 + param_03;
	setdvar("arcademode_combined_score",var_05);
	setdvar("arcademode_score",var_04);
	var_06 = 60;
	var_07 = 1.5;
	var_08 = 0.9 + param_03 - 10 * 0.01;
	if(var_08 > 1.4)
	{
		var_08 = 1.4;
	}

	var_09 = (0.75,0,0);
	if(param_01)
	{
		thread arcademode_add_kill_streak();
		thread arcademode_add_point_towards_extra_life();
		var_09 = level.arcademode_killcolors[param_02];
	}

	level.player pointpulse(param_03);
}

//Function Number: 36
arcademode_add_point_towards_extra_life()
{
	level.arcademode_kills_until_next_extra_life = level.arcademode_kills_until_next_extra_life - 1;
	if(level.arcademode_kills_until_next_extra_life > 0)
	{
		return;
	}

	level.arcademode_rewarded_lives++;
	var_00 = getdvarint("arcademode_lives");
	var_00++;
	if(var_00 >= level.arcademode_maxlives)
	{
		var_00 = level.arcademode_maxlives;
	}
	else
	{
		setdvar("arcademode_lives",var_00);
		setdvar("arcademode_lives_changed",1);
	}

	level.arcademode_kills_until_next_extra_life = level.arcademode_extra_lives_range[level.gameskill];
}

//Function Number: 37
arcademode_set_origin_in_radius()
{
	var_00 = 60;
	var_01 = 90;
	if(level.player.pointpulseindex > 0)
	{
		if(level.player.pointpulseindex == 1)
		{
			var_02 = randomint(1);
			level.player.thirdpointpulseside = 1 - var_02;
			if(var_02)
			{
				var_01 = 45;
			}
			else
			{
				var_01 = 135;
			}
		}
		else if(level.player.pointpulseindex == 2)
		{
			var_02 = level.player.thirdpointpulseside;
			if(var_02)
			{
				var_01 = 45;
			}
			else
			{
				var_01 = 135;
			}
		}
		else if(level.player.pointpulseindex <= 4)
		{
			var_01 = randomfloatrange(0,180);
			var_00 = randomfloatrange(60,120);
		}
		else if(level.player.pointpulseindex <= 8)
		{
			var_01 = randomfloatrange(0,180);
			var_00 = randomfloatrange(60,160);
		}
		else
		{
			var_01 = randomfloatrange(-30,210);
			var_00 = randomfloatrange(60,200);
		}
	}

	self.x = var_00 * cos(var_01);
	self.y = 0 - var_00 * sin(var_01);
}

//Function Number: 38
pointpulse(param_00)
{
	if(param_00 == 0)
	{
		return;
	}

	if(!isdefined(level.player.pointpulsecount))
	{
		level.player.pointpulsecount = 0;
		level.player.pointpulseindex = 0;
	}

	var_01 = newhudelem();
	var_01.horzalign = "center";
	var_01.vertalign = "middle";
	var_01.alignx = "center";
	var_01.aligny = "middle";
	var_01 arcademode_set_origin_in_radius();
	var_01.font = "objective";
	var_01.fontscale = 2.5;
	var_01.archived = 0;
	var_01.color = (0.5,0.5,0.5);
	var_01.sort = 4;
	var_02 = level.arcademode_kill_streak_current_multiplier;
	level.player.pointpulsecount++;
	level.player.pointpulseindex++;
	wait 0.05;
	if(param_00 <= 0)
	{
		var_01.label = &"";
		var_01.color = (1,0,0);
		var_01.glowcolor = (0,0,0);
		var_01.glowalpha = 0;
	}
	else
	{
		var_01.label = &"SCRIPT_PLUS";
		var_01.color = (1,1,1);
		var_01.glowcolor = level.color_cool_green_glow;
		var_01.glowalpha = 1;
	}

	var_01 setvalue(param_00);
	var_01.alpha = 1;
	var_01 changefontscaleovertime(0.15);
	var_01.fontscale = 3.5;
	wait 0.15;
	var_01 moveovertime(1.75);
	var_01.y = var_01.y - 40;
	var_01 changefontscaleovertime(0.25);
	var_01.fontscale = 2.5;
	wait 0.25;
	wait 0.5;
	var_01 fadeovertime(1);
	var_01.alpha = 0;
	wait 0.5;
	level.player.pointpulsecount--;
	if(level.player.pointpulsecount == 0)
	{
		level.player.pointpulseindex = 0;
	}

	var_01 destroy();
}

//Function Number: 39
set_circular_origin()
{
	var_00 = 50;
	for(;;)
	{
		var_01 = randomint(var_00);
		var_02 = randomint(var_00);
		if(distance((0,0,0),(var_01,var_02,0)) < var_00)
		{
			break;
		}
	}

	if(common_scripts\utility::cointoss())
	{
		var_01 = var_01 * -1;
	}

	if(common_scripts\utility::cointoss())
	{
		var_02 = var_02 * -1;
	}

	self.x = var_01;
	self.y = var_02;
}

//Function Number: 40
arcademode_add_points_for_mod(param_00)
{
	for(var_01 = 0;var_01 < level.arcademode_multikills[param_00].size;var_01++)
	{
		arcademode_add_points_for_individual_kill(level.arcademode_multikills[param_00][var_01],param_00,level.arcademode_multikills[param_00].size);
	}
}

//Function Number: 41
arcademode_add_points_for_individual_kill(param_00,param_01,param_02)
{
	if(param_00["type"] != "melee")
	{
		var_03 = level.arcademode_killbase + level.arcademode_locationkillbonus[param_00["damage_location"]] + level.arcademode_weaponbonus[param_00["type"]];
	}
	else
	{
		var_03 = level.arcademode_killbase + level.arcademode_weaponbonus[param_01["type"]];
	}

	thread arcademode_add_points(param_00["origin"],1,param_01,var_03);
}

//Function Number: 42
player_kill(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	var_03 = level.arcademode_deathtypes[param_00];
	if(!isdefined(var_03))
	{
		var_04 = level.arcademode_killbase;
		thread arcademode_add_points(param_02,1,"melee",var_04);
		return;
	}

	var_05["damage_location"] = param_02;
	if(var_05 == "explosive")
	{
	}

	level.arcademode_multikills[var_05][level.arcademode_multikills[var_05].size] = var_7B;
}

//Function Number: 43
player_damage(param_00,param_01,param_02)
{
	thread arcademode_add_points(param_02,0,param_00,level.arcademode_damagebase);
}

//Function Number: 44
player_damage_ads(param_00,param_01,param_02)
{
	thread arcademode_add_points(param_02,0,param_00,level.arcademode_damagebase * 1.25);
}

//Function Number: 45
end_mission()
{
	setsaveddvar("ui_nextMission","0");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		var_01.maxhealth = 0;
		var_01.health = 1;
	}

	missionsuccess("killhouse");
}

//Function Number: 46
create_total_score_hud(param_00,param_01)
{
	level.arcademode_hud_total_scores = [];
	for(var_02 = 0;var_02 < level.arcademode_hud_digits;var_02++)
	{
		var_03 = get_hud_score();
		level.arcademode_hud_total_scores[level.arcademode_hud_total_scores.size] = var_03;
		var_03.x = var_02 * -30 + -150 + param_00;
		var_03.y = param_01;
		var_03.alignx = "right";
		var_03.aligny = "middle";
		var_03.horzalign = "right";
		var_03.vertalign = "middle";
		var_03.alpha = 0;
		var_03.sort = level.arcademode_hud_sort + 10;
	}
}

//Function Number: 47
set_total_score_hud(param_00)
{
	hud_draw_score_for_elements(param_00,level.arcademode_hud_total_scores);
}

//Function Number: 48
arcademode_ends()
{
	if(common_scripts\utility::flag("arcademode_complete"))
	{
		return;
	}

	common_scripts\utility::flag_set("arcademode_complete");
	maps\_utility::slowmo_setlerptime_out(0.05);
	maps\_utility::slowmo_lerp_out();
	maps\_utility::slowmo_end();
	if(level.arcademode_success)
	{
		if(arcademode_convert_extra_lives())
		{
			wait 2;
		}
	}

	var_00 = 0;
	if(isdefined(level.arcademode_stoptime))
	{
		var_00 = gettime() - level.arcademode_stoptime;
		var_00 = var_00 * 0.001;
	}

	var_01 = gettime() - level.arcdemode_starttime;
	var_01 = var_01 * 0.001;
	var_01 = var_01 - var_00;
	var_02 = level.arcademode_time - var_01;
	var_02 = int(var_02);
	if(var_02 == 0)
	{
		var_02++;
	}

	var_03 = 0.5;
	level.mission_failed_disabled = 1;
	thread player_invul_forever();
	thread black_background(var_03);
	wait var_03 + 0.25;
	level.player freezecontrols(1);
	var_04 = 1;
	var_05 = -140;
	var_06 = -80;
	var_07 = -20;
	var_08 = 40;
	var_09 = 100;
	var_0A = 300;
	var_0B = new_ending_hud("center",var_04,0,var_05);
	if(level.arcademode_success)
	{
		var_0B.color = (1,1,1);
		var_0B settext(&"SCRIPT_MISSION_COMPLETE");
	}
	else
	{
		var_0B.color = (1,0.4,0.2);
		var_0B.glowcolor = (0.75,0.3,0.3);
		var_0B settext(level.arcademode_failurestring);
	}

	wait 1;
	for(var_0C = 0;var_0C < level.arcademode_maxlives;var_0C++)
	{
		level.arcademode_lives_hud[var_0C] destroy();
	}

	var_0D = 130;
	level.arcademode_lives_hud = [];
	for(var_0C = 0;var_0C < level.arcademode_maxlives;var_0C++)
	{
		arcademode_add_life(var_0C,-135 + var_0D,var_0A,-30,96,level.arcademode_hud_sort + 10);
	}

	var_0E = getdvarint("arcademode_lives");
	var_0F = level.arcademode_rewarded_lives;
	if(var_0E > var_0F)
	{
		var_0E = var_0F;
	}

	arcademode_redraw_lives(var_0E);
	var_10 = 0;
	var_11 = undefined;
	if(getdvar("arcademode_full") == "1")
	{
		var_11 = new_ending_hud("left",var_04,20,var_06);
		var_11 settext(&"SCRIPT_TOTAL_SCORE");
		create_total_score_hud(var_0D,var_06);
		var_10 = getdvarint("arcademode_combined_score");
		set_total_score_hud(var_10);
	}

	var_12 = new_ending_hud("left",var_04,20,var_07);
	var_12 settext(&"SCRIPT_MISSION_SCORE");
	for(var_0C = 0;var_0C < level.arcademode_hud_digits;var_0C++)
	{
		var_13 = level.arcademode_hud_scores[var_0C];
		var_13.x = var_0C * -30 + -150 + var_0D;
		var_13.y = var_07;
		var_13.sort = level.arcademode_hud_sort + 10;
		var_13.alignx = "right";
		var_13.aligny = "middle";
		var_13.horzalign = "right";
		var_13.vertalign = "middle";
	}

	hud_draw_score(0);
	var_14 = 0;
	var_15 = 0;
	while(var_02 >= 60)
	{
		var_14++;
		var_02 = var_02 - 60;
	}

	var_15 = var_02;
	var_16 = new_ending_hud("left",var_04,20,var_08);
	var_16 settext(&"SCRIPT_TIME_REMAINING");
	level.arcademode_hud_timer_minutes_tens = new_ending_hud("right",var_04,-265 + var_0D,var_08);
	level.arcademode_hud_timer_minutes_ones = new_ending_hud("right",var_04,-235 + var_0D,var_08);
	var_17 = new_ending_hud("right",var_04,-215 + var_0D,var_08 - 5);
	var_17 settext(&"SCRIPT_COLON");
	level.arcademode_hud_timer_seconds_tens = new_ending_hud("right",var_04,-180 + var_0D,var_08);
	level.arcademode_hud_timer_seconds_ones = new_ending_hud("right",var_04,-150 + var_0D,var_08);
	ending_set_time(var_14,var_15);
	wait var_04;
	wait 1;
	var_18 = getdvarint("arcadeMode_score");
	var_19 = 0;
	var_1A = var_10;
	var_1B = 0;
	for(;;)
	{
		var_1C = var_18 - var_19;
		var_1D = var_1C * 0.2 + 1;
		if(var_1C <= 15)
		{
			var_1D = 1;
		}

		var_1D = int(var_1D);
		var_19 = var_19 + var_1D;
		if(var_19 > var_18)
		{
			var_19 = var_18;
		}

		hud_draw_score(var_19);
		if(var_19 == var_18)
		{
			break;
		}

		var_1B--;
		if(var_1B <= 0)
		{
			level.player thread common_scripts\utility::play_sound_in_space("bullet_ap_dirt",level.player geteye());
			var_1B = 3;
		}

		wait 0.05;
	}

	wait 1;
	var_1E = 0;
	var_1F = undefined;
	if(level.arcademode_success)
	{
		var_20 = 5;
		var_21 = var_14 * 60 + var_15;
		var_22 = ceil(var_21 / 15);
		var_23 = ceil(var_21 * var_20);
		var_24 = ceil(var_23 / level.arcademode_difficultytimerscale);
		var_25 = var_19;
		var_26 = var_19 + var_24;
		var_27 = var_10;
		var_28 = var_10 + var_24;
		for(var_0C = 1;var_0C <= var_22;var_0C++)
		{
			var_29 = var_0C * 1 / var_22;
			if(var_0C == var_22)
			{
				var_29 = 1;
			}

			var_19 = int(var_25 * 1 - var_29 + var_26 * var_29);
			if(getdvar("arcademode_full") == "1")
			{
				var_10 = int(var_27 * 1 - var_29 + var_28 * var_29);
				set_total_score_hud(var_10);
			}

			hud_draw_score(var_19);
			var_2A = int(var_21 * 1 - var_29);
			ending_set_time(floor(var_2A / 60),var_2A % 60);
			var_1B--;
			if(var_1B <= 0)
			{
				level.player thread common_scripts\utility::play_sound_in_space("bullet_ap_metal",level.player geteye());
				var_1B = 3;
			}

			wait 0.05;
		}

		ending_set_time(0,0);
		wait 1;
		for(;;)
		{
			var_2B = 1;
			if(var_0E > 10)
			{
				var_2C = var_0E % 10;
				if(var_0E - var_2C >= 10)
				{
					var_2B = 10;
				}
				else
				{
					var_2B = var_2C;
				}

				if(var_0E < 20)
				{
					var_2B = var_2C;
				}
			}

			var_0E = var_0E - var_2B;
			if(var_0E < 0)
			{
				break;
			}

			var_2D = 1000;
			var_2D = var_2D * var_2B;
			var_1D = int(var_2D);
			if(getdvar("arcademode_full") == "1")
			{
				var_10 = var_10 + var_1D;
				set_total_score_hud(var_10);
			}

			var_19 = var_19 + var_1D;
			level.player thread common_scripts\utility::play_sound_in_space("mortar_explosion",level.player geteye());
			hud_draw_score(int(var_19));
			arcademode_redraw_lives(var_0E);
			wait 0.6;
		}

		wait 1;
		if(getdvarint("arcademode_died") != 1 && level.gameskill >= 2)
		{
			var_1D = int(var_19);
			arcademode_end_boost(var_19,var_10,var_1D,&"SCRIPT_ZERO_DEATHS","bullet_ap_bark",var_09,var_04);
			var_19 = var_19 + var_1D;
			var_10 = var_10 + var_1D;
		}
	}
	else
	{
		level.arcademode_hud_timer_seconds_ones setpulsefx(0,0,1000);
		level.arcademode_hud_timer_seconds_tens setpulsefx(0,0,1000);
		level.arcademode_hud_timer_minutes_ones setpulsefx(0,0,1000);
		level.arcademode_hud_timer_minutes_tens setpulsefx(0,0,1000);
		var_17 setpulsefx(0,0,1000);
		var_16 setpulsefx(0,0,1000);
		arcademode_redraw_lives(0);
		wait 2;
	}

	var_2E = level.arcademode_skillmultiplier[level.gameskill];
	if(var_2E > 1)
	{
		if(var_2E == 1.5)
		{
			var_2F = &"SCRIPT_DIFFICULTY_BONUS_ONEANDAHALF";
		}
		else if(var_2F == 3)
		{
			var_2F = &"SCRIPT_DIFFICULTY_BONUS_THREE";
		}
		else
		{
			var_2F = &"SCRIPT_DIFFICULTY_BONUS_FOUR";
		}

		var_1D = int(ceil(var_19 * var_2E) - var_19);
		arcademode_end_boost(var_19,var_10,var_1D,var_2F,"bullet_ap_glass",var_09,var_04);
		var_19 = var_19 + var_1D;
		var_10 = var_10 + var_1D;
	}

	var_30 = 0;
	if(getdvar("arcademode_full") == "1")
	{
		var_31 = "s18";
		var_32 = getdvarint(var_31);
		if(var_10 > var_32)
		{
			var_33 = get_digits_from_score(var_10);
			var_34 = get_score_string_from_digits(var_33);
			setdvar(var_31,var_34);
			var_35 = 0;
			if(!level.arcademode_success)
			{
				var_35 = 1;
			}

			if(level.script == "airplane")
			{
				var_35 = 1;
			}

			if(var_35)
			{
				var_30 = 1;
			}
		}

		level.player uploadscore("LB_FULL",getdvarint(var_31));
	}
	else
	{
		var_36 = [];
	}

	if(var_30)
	{
		if(!level.arcademode_success)
		{
			updategamerprofile();
		}

		wait 1;
		var_37 = new_ending_hud("center",var_04,0,var_09);
		var_37 settext(&"SCRIPT_NEW_HIGH_SCORE");
		var_37.alpha = 1;
		var_37 fadeovertime(0.05);
		var_37 setpulsefx(30,3000,1000);
		wait 3.5;
	}

	wait 2;
	var_0B setpulsefx(0,0,1000);
	wait 0.5;
	var_12 setpulsefx(0,0,1000);
	for(var_0C = 0;var_0C < level.arcademode_hud_digits;var_0C++)
	{
		var_13 = level.arcademode_hud_scores[var_0C];
		var_13 setpulsefx(0,0,1000);
	}

	if(getdvar("arcademode_full") == "1")
	{
		var_11 setpulsefx(0,0,1000);
		for(var_0C = 0;var_0C < level.arcademode_hud_digits;var_0C++)
		{
			var_13 = level.arcademode_hud_total_scores[var_0C];
			var_13 setpulsefx(0,0,1000);
		}
	}

	if(level.arcademode_success)
	{
		wait 0.5;
		level.arcademode_hud_timer_seconds_ones setpulsefx(0,0,1000);
		level.arcademode_hud_timer_seconds_tens setpulsefx(0,0,1000);
		level.arcademode_hud_timer_minutes_ones setpulsefx(0,0,1000);
		level.arcademode_hud_timer_minutes_tens setpulsefx(0,0,1000);
		var_17 setpulsefx(0,0,1000);
		var_16 setpulsefx(0,0,1000);
	}

	wait 1;
	if(getdvar("arcademode_full") == "1")
	{
		logstring("ArcadeMode Score: " + var_19 + ", mission: " + level.script + ", gameskill: " + level.gameskill + ", total: " + var_10);
	}
	else
	{
		logstring("ArcadeMode Score: " + var_19 + ", mission: " + level.script + ", gameskill: " + level.gameskill);
	}

	setdvar("arcademode_combined_score",var_10);
	if(!level.arcademode_success)
	{
		setdvar("ui_arcade_lost",1);
		end_mission();
	}
	else
	{
		setdvar("ui_arcade_lost",0);
	}

	common_scripts\utility::flag_set("arcademode_ending_complete");
}

//Function Number: 49
arcademode_end_boost(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = new_ending_hud("center",param_06,0,param_05);
	var_07 settext(param_03);
	var_07.alpha = 1;
	var_07 fadeovertime(0.05);
	wait 0.05;
	wait 1;
	var_08 = 0;
	var_09 = param_00 + param_02;
	var_0A = param_01 + param_02;
	for(;;)
	{
		var_0B = var_09 - param_00;
		param_02 = var_0B * 0.2 + 1;
		if(var_0B <= 15)
		{
			param_02 = 1;
		}

		param_02 = int(param_02);
		param_00 = param_00 + param_02;
		if(param_00 > var_09)
		{
			param_00 = var_09;
		}

		hud_draw_score(param_00);
		if(getdvar("arcademode_full") == "1")
		{
			param_01 = param_01 + param_02;
			if(param_01 > var_0A)
			{
				param_01 = var_0A;
			}

			set_total_score_hud(param_01);
		}

		if(param_00 == var_09)
		{
			break;
		}

		var_08--;
		if(var_08 <= 0)
		{
			level.player thread common_scripts\utility::play_sound_in_space(param_04,level.player geteye());
			var_08 = 3;
		}

		wait 0.05;
	}

	wait 0.5;
	var_07 setpulsefx(0,0,1000);
	wait 1;
}

//Function Number: 50
black_background(param_00)
{
	var_01 = newhudelem();
	var_01.foreground = 1;
	var_01.x = 0;
	var_01.y = 0;
	var_01 setshader("black",640,480);
	var_01.alignx = "left";
	var_01.aligny = "top";
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01.sort = level.arcademode_hud_sort + 5;
	var_01.alpha = 0;
	if(param_00 > 0)
	{
		var_01 fadeovertime(param_00);
	}

	var_01.alpha = 1;
}

//Function Number: 51
player_invul_forever()
{
	for(;;)
	{
		level.player enableinvulnerability();
		level.player.deathinvulnerabletime = 70000;
		level.player.ignoreme = 1;
		var_00 = getaispeciesarray("all","all");
		common_scripts\utility::array_thread(var_00,::maps\_utility::set_ignoreme,1);
		wait 0.05;
	}
}

//Function Number: 52
ending_set_time(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	while(param_00 >= 10)
	{
		var_02++;
		param_00 = param_00 - 10;
	}

	while(param_01 >= 10)
	{
		var_03++;
		param_01 = param_01 - 10;
	}

	level.arcademode_hud_timer_seconds_ones setvalue(param_01);
	level.arcademode_hud_timer_seconds_tens setvalue(var_03);
	level.arcademode_hud_timer_minutes_ones setvalue(param_00);
	level.arcademode_hud_timer_minutes_tens setvalue(var_02);
}

//Function Number: 53
draw_checkpoint(param_00,param_01,param_02)
{
	param_00 = param_00 * param_02;
	var_03 = new_ending_hud("center",0.1,param_00,90);
	var_03 settext(&"SCRIPT_CHECKPOINT");
	var_03 moveovertime(param_01);
	var_03.x = 0;
	wait param_01;
	wait 0.5;
	var_03 moveovertime(param_01);
	var_03.x = param_00 * -1;
	wait param_01;
	var_03 destroy();
}

//Function Number: 54
arcademode_checkpoint_getid(param_00)
{
	for(var_01 = 0;var_01 < level.arcademode_checkpoint_dvars.size;var_01++)
	{
		if(level.arcademode_checkpoint_dvars[var_01] == param_00)
		{
			return var_01;
		}
	}

	return undefined;
}

//Function Number: 55
arcademode_init_kill_streak_colors()
{
	level.arcademode_streak_color = [];
	level.arcademode_streak_glow = [];
	level.arcademode_streak_color[level.arcademode_streak_color.size] = level.color_cool_green;
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.8,0.8,2);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (2,0.8,0);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.5,2,2);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (2,0.5,2);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.3,0.3,2);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (2,2,0.5);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (2,2,2);
	for(var_00 = 0;var_00 < level.arcademode_streak_color.size;var_00++)
	{
		level.arcademode_streak_glow[var_00] = (level.arcademode_streak_color[var_00][0] * 0.35,level.arcademode_streak_color[var_00][1] * 0.35,level.arcademode_streak_color[var_00][2] * 0.35);
	}

	level.arcademode_streak_color[0] = level.color_cool_green_glow;
}

//Function Number: 56
arcademode_killstreak_complete_display()
{
	if(level.arcademode_kill_streak_current_multiplier == 1)
	{
		return;
	}

	if(common_scripts\utility::flag("arcademode_complete"))
	{
		return;
	}

	var_00 = new_ending_hud("right",0.2,-10,-57);
	var_00 setpulsefx(5,3000,1000);
	var_00.fontscale = 2;
	if(level.arcademode_kill_streak_current_multiplier >= 8)
	{
		level.player thread common_scripts\utility::play_sound_in_space("arcademode_kill_streak_won",level.player geteye());
		var_00 settext(&"SCRIPT_STREAK_COMPLETE");
	}
	else
	{
		level.player thread common_scripts\utility::play_sound_in_space("arcademode_kill_streak_lost",level.player geteye());
		var_00 settext(&"SCRIPT_STREAK_BONUS_LOST");
	}

	wait 5;
	var_00 destroy();
}

//Function Number: 57
arcademode_reset_kill_streak_art()
{
	if(isdefined(level.arcademode_streak_hud))
	{
		level.arcademode_streak_hud destroy();
		level.arcademode_streak_hud = undefined;
		level.arcademode_streak_hud_shadow destroy();
	}

	level notify("arcademode_stop_kill_streak_art");
	for(var_00 = 0;var_00 < level.arcademode_kills_hud.size;var_00++)
	{
		level.arcademode_kills_hud[var_00] destroy();
	}

	level.arcademode_kills_hud = [];
}

//Function Number: 58
arcademode_reset_kill_streak()
{
	level.arcademode_new_kill_streak_allowed = 1;
	thread arcademode_killstreak_complete_display();
	level notify("arcademode_stop_kill_streak");
	arcademode_reset_kill_streak_art();
	common_scripts\utility::flag_clear("arcadeMode_multiplier_maxed");
	level.arcademode_kill_streak_current_count = level.arcademode_kill_streak_multiplier_count;
	level.arcademode_kill_streak_current_multiplier = 1;
}

//Function Number: 59
get_hud_multi()
{
	var_00 = newhudelem();
	var_00.alignx = "right";
	var_00.aligny = "top";
	var_00.horzalign = "right";
	var_00.vertalign = "top";
	var_00 thread arcademode_draw_multiplier_kill();
	var_00.x = 0;
	var_00.y = 126;
	var_00.font = "objective";
	var_00.fontscale = 0.1;
	var_00.archived = 0;
	var_00.foreground = 1;
	var_00.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
	var_00.glowcolor = level.arcademode_streak_glow[level.arcademode_kill_streak_current_multiplier - 1];
	var_00.sort = level.arcademode_hud_sort;
	var_00.label = &"SCRIPT_X";
	var_00 setvalue(level.arcademode_kill_streak_current_multiplier);
	var_00 changefontscaleovertime(0.5);
	var_00.fontscale = 3;
	var_00.alpha = 0;
	var_00 fadeovertime(0.5);
	var_00.alpha = 1;
	return var_00;
}

//Function Number: 60
arcademode_draw_multiplier()
{
	for(var_00 = 0;var_00 < 40;var_00++)
	{
		var_01 = get_hud_multi();
		var_01 thread arcademode_draw_mult_sizzle();
	}

	level endon("arcademode_new_kill_streak");
	var_02 = get_hud_multi();
	level.arcademode_hud_streak = var_02;
	level waittill("arcademode_stop_kill_streak");
	var_02 setpulsefx(0,0,1000);
	wait 1;
	var_02 destroy();
	level.arcademode_hud_streak = undefined;
}

//Function Number: 61
arcademode_draw_mult_sizzle()
{
	level endon("arcademode_new_kill_streak");
	wait 0.05;
	var_00 = 500;
	self moveovertime(2);
	self.x = self.x + randomintrange(var_00 * -1,var_00);
	self.y = self.y + randomintrange(var_00 * -1,var_00);
	wait 0.5;
	self fadeovertime(1);
	self.alpha = 0;
	wait 1;
	self destroy();
}

//Function Number: 62
arcademode_draw_multiplier_kill()
{
	self endon("death");
	level waittill("arcademode_new_kill_streak");
	self destroy();
}

//Function Number: 63
get_score_string_from_digits(param_00)
{
	var_01 = "";
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = param_00[var_02] + var_01;
	}

	return var_01;
}