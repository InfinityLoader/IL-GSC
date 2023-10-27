/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_arcademode.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 75
 * Decompile Time: 1361 ms
 * Timestamp: 10/27/2023 2:45:40 AM
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
	precacheshader("arcademode_life_empty");
	precacheshader("h1_arcademode_scanelines_border");
	precacheshader("h1_arcademode_scanelines_border_cap");
	precacheshader("h1_arcademode_scanelines_border_end_title");
	precacheshader("h1_arcademode_numberstreak_circles");
	precacheshader("h1_arcademode_numberstreak_glow");
	precacheshader("h1_arcademode_livesmessage_border");
	precacheshader("h1_arcademode_checkpoint_flare");
	precacheshader("h1_arcademode_lives_earned_flare");
	precacheshader("h1_arcademode_lives_message_flare");
	precacheshader("h1_arcademode_number_streak_flare");
	level.color_cool_green = (0.8,2,0.8);
	level.color_cool_green_glow = (0.3,0.6,0.3);
	level.arcademode_ending_hud = [];
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
	if(getdvar("arcademode_full") == "1")
	{
		precacheleaderboards("LB_AM_FULLCHALLENGE");
	}
	else
	{
		precacheleaderboards("LB_AM_" + level.script);
	}

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

	var_01 = getdvarint("arcademode_lives");
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
		wait(0.05);
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
	var_01["cargoship"] = 11;
	var_01["armada"] = 15;
	var_01["bog_a"] = 13;
	var_01["hunted"] = 17;
	var_01["ac130"] = 13;
	var_01["bog_b"] = 15;
	var_01["airlift"] = 14;
	var_01["village_assault"] = 17;
	var_01["scoutsniper"] = 18;
	var_01["ambush"] = 12;
	var_01["sniperescape"] = 20;
	var_01["village_defend"] = 15;
	var_01["icbm"] = 16;
	var_01["launchfacility_a"] = 11;
	var_01["launchfacility_b"] = 14;
	var_01["jeepride"] = 9;
	var_01["airplane"] = 4;
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
		wait(1.5);
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
	var_00.x = -21.66667;
	var_00.y = 38.97778;
	var_00.sort = level.arcademode_hud_sort;
	var_00.fontscale = 1.5;
	var_00.color = (1,1,1);
	var_00.font = "objective";
	var_00 method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
	var_00.hidewheninmenu = 1;
	level.arcademode_hud_timer = var_00;
	level endon("arcadeMode_remove_timer");
	var_01 = level.arcademode_time;
	var_00 settimer(var_01 - 0.1);
	wait(var_01);
	level.arcademode_failurestring = &"SCRIPT_TIME_UP";
	thread arcademode_ends();
	soundscripts\_snd::snd_message("player_death");
}

//Function Number: 6
arcademode_update_lives()
{
	level.player endon("death");
	level endon("missionfailed");
	level.arcademode_lives_hud = [];
	for(var_00 = 0;var_00 < level.arcademode_maxlives;var_00++)
	{
		arcademode_add_life(var_00,-28.66667,68.66667,-14,64,level.arcademode_hud_sort);
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
				level.player thread common_scripts\utility::play_sound_in_space("h1_arcademode_life_lost",level.player geteye());
			}

			arcademode_redraw_lives(var_02);
			level.arcademode_redraw_score = 1;
			setdvar("arcademode_lives_changed",0);
		}

		wait(0.05);
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
	thread draw_checkpoint(0,var_01,1);
	thread draw_checkpoint_scanlines(0,var_01,1);
	thread draw_checkpoint_flare();
}

//Function Number: 9
draw_lives_earned_flare(param_00,param_01,param_02,param_03)
{
	var_04 = newhudelem();
	var_04.foreground = 1;
	var_04.x = param_01 + param_00 * param_03 - 10;
	var_04.y = param_02 + 10;
	var_04 setshader("h1_arcademode_lives_earned_flare",26,26);
	var_04.alignx = "center";
	var_04.aligny = "middle";
	var_04.horzalign = "right";
	var_04.vertalign = "top";
	var_04.sort = level.arcademode_hud_sort + 10 - 1;
	var_04.alpha = 0;
	var_04.hidewheninmenu = 1;
	var_04 fadeovertime(0.05);
	var_04.alpha = 0.4;
	wait(0.05);
	var_04 scaleovertime(0.15,52,52);
	wait(0.15);
	var_04 destroy();
}

//Function Number: 10
arcademode_redraw_life(param_00,param_01)
{
	if(param_00 >= param_01)
	{
		self setshader("arcademode_life_empty",20,20);
		self.empty = 1;
	}
	else
	{
		if(isdefined(self.empty) && self.empty)
		{
			thread draw_lives_earned_flare(param_00,-18.66667,58.66667,-14);
		}

		self setshader("arcademode_life",20,20);
		self.empty = 0;
	}

	self fadeovertime(1);
	self.alpha = 1;
	self.color = (1,1,1);
}

//Function Number: 11
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
	self.empty = 0;
}

//Function Number: 12
arcademode_remove_life_ending(param_00)
{
	if(self.alpha <= 0)
	{
		return;
	}

	self fadeovertime(0.15);
	self.alpha = 0;
	self scaleovertime(0.15,40,40);
}

//Function Number: 13
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

		if(level.arcademode_success)
		{
			level.arcademode_lives_hud[var_02] arcademode_remove_life_ending(var_02);
			continue;
		}

		level.arcademode_lives_hud[var_02] arcademode_remove_life(var_02);
	}
}

//Function Number: 14
arcademode_update_streak_progress()
{
	for(;;)
	{
		level common_scripts\utility::waittill_either("arcademode_decrement_kill_streak","arcademode_new_kill");
		waittillframeend;
		arcademode_redraw_streak_progress();
	}
}

//Function Number: 15
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

//Function Number: 16
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
				wait(3);
			}

			var_06 fadeovertime(var_08);
			var_06.color = (1,0,0);
			var_06.alpha = 0;
			wait(var_08);
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
		wait(0.05);
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

//Function Number: 17
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

//Function Number: 18
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
		wait(1);
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
		wait(param_00 - var_07);
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

		if(isdefined(var_04))
		{
			var_04 scaleovertime(1,var_06,var_01);
		}

		if(isdefined(var_05))
		{
			var_05 scaleovertime(1,var_06,var_01);
		}

		wait(1);
		if(var_06 == 1)
		{
			break;
		}
	}

	thread arcademode_reset_kill_streak();
}

//Function Number: 19
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

//Function Number: 20
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
		wait(var_00);
	}
}

//Function Number: 21
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
	wait(0.05);
	musicplay("airplane_alt_maximum_music");
	level maps\_utility::add_wait(::maps\_utility::_wait,var_00 + 1);
	level maps\_utility::add_wait(::maps\_utility::waittill_msg,"lost_streak");
	maps\_utility::do_wait_any();
	thread arcademode_reset_kill_streak();
	musicstop();
	if(isdefined(level.last_song))
	{
		wait(0.05);
		musicplay(level.last_song);
	}
}

//Function Number: 22
get_score_backer(param_00,param_01,param_02)
{
	var_03 = new_ending_hud("right",0.1,-5.166668,3.222222);
	var_03 setshader("h1_arcademode_scanelines_border",50,50);
	var_03.alignx = "right";
	var_03.aligny = "top";
	var_03.horzalign = "right";
	var_03.vertalign = "top";
	var_03.sort = -100;
	var_03.alpha = 1;
	return var_03;
}

//Function Number: 23
get_hud_score()
{
	var_00 = newhudelem();
	var_00.foreground = 1;
	var_00.x = 0;
	var_00.y = 10.22222;
	var_00.alignx = "right";
	var_00.aligny = "top";
	var_00.horzalign = "right";
	var_00.vertalign = "top";
	var_00.score = 0;
	var_00.font = "objective";
	var_00.fontscale = 2.8;
	var_00.sort = level.arcademode_hud_sort;
	var_00 method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
	var_00.hidewheninmenu = 1;
	return var_00;
}

//Function Number: 24
arcademode_update_score()
{
	level.player endon("death");
	level.arcademode_hud_digits = 10;
	level.arcademode_hud_scores = [];
	for(var_00 = 0;var_00 < level.arcademode_hud_digits;var_00++)
	{
		level.arcademode_hud_scores[level.arcademode_hud_scores.size] = get_hud_score();
		level.arcademode_hud_scores[level.arcademode_hud_scores.size - 1].x = var_00 * -17 + -21.66667;
	}

	level.arcademode_hud_score_backer = get_score_backer();
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
		wait(0.05);
		updatescoreelemsonce();
		if(level.arcademode_redraw_score)
		{
			level.arcademode_redraw_score = 0;
		}
	}
}

//Function Number: 25
updatescoreelemsonce()
{
	if(getdvarint("arcademode_full"))
	{
		hud_update_score("arcadeMode_combined_score");
		return;
	}

	hud_update_score("arcademode_score");
}

//Function Number: 26
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

//Function Number: 27
get_digits_from_score(param_00)
{
	var_01 = [];
	param_00 = int(param_00);
	for(;;)
	{
		var_01[var_01.size] = param_00 % 10;
		param_00 = int(param_00 * 0.1);
		if(param_00 <= 0)
		{
			break;
		}
	}

	return var_01;
}

//Function Number: 28
hud_draw_score(param_00)
{
	hud_draw_score_for_elements(param_00,level.arcademode_hud_scores);
}

//Function Number: 29
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

	level.arcademode_hud_score_backer setshader("h1_arcademode_scanelines_border",50 + var_02.size - 1 * 22,50);
	level.arcademode_hud_score_backer.x = -5.166668 + var_02.size - 1 * 2.4;
	if(!common_scripts\utility::flag("arcademode_complete"))
	{
		level.player thread common_scripts\utility::play_sound_in_space("h1_arcademode_add_counter_pt",level.player geteye());
	}
}

//Function Number: 30
hud_draw_score_for_elements_align_left(param_00,param_01)
{
	var_02 = get_digits_from_score(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(var_03 >= param_01.size - 1)
		{
			break;
		}

		param_01[param_01.size - var_02.size + var_03] setvalue(var_02[var_03]);
		param_01[param_01.size - var_02.size + var_03].alpha = 1;
	}

	for(var_03 = param_01.size - var_02.size - 1;var_03 >= 0;var_03--)
	{
		param_01[var_03].alpha = 0;
	}

	if(param_00 == 0)
	{
		param_01[param_01.size - 1].alpha = 1;
		param_01[param_01.size - 1] setvalue(0);
	}
}

//Function Number: 31
arcademode_add_life(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = newhudelem();
	var_06.foreground = 1;
	var_06.x = param_01 + param_00 * param_03;
	var_06.y = param_02;
	var_06 setshader("arcademode_life",param_04,param_04);
	var_06.alignx = "center";
	var_06.aligny = "middle";
	var_06.horzalign = "right";
	var_06.vertalign = "top";
	var_06.sort = param_05;
	var_06.color = (1,1,1);
	var_06.glowalpha = 0;
	var_06.alpha = 0;
	var_06.hidewheninmenu = 1;
	level.arcademode_lives_hud[level.arcademode_lives_hud.size] = var_06;
}

//Function Number: 32
arcademode_define_damage_multipliers()
{
	var_00["MOD_MELEE"] = 20;
	var_00["MOD_PISTOL_BULLET"] = 20;
	var_00["MOD_RIFLE_BULLET"] = 10;
	var_00["MOD_PROJECTILE"] = 2;
	var_00["MOD_PROJECTILE_SPLASH"] = 2;
	var_00["MOD_EXPLOSIVE"] = 2;
	var_00["MOD_GRENADE"] = 2;
	var_00["MOD_GRENADE_SPLASH"] = 2;
	var_00 = [];
	var_00["melee"] = 1;
	var_00["pistol"] = 1;
	var_00["rifle"] = 0.5;
	var_00["explosive"] = 0.3;
	level.arcademode_weaponmultiplier = var_00;
	var_01 = [];
	var_01["melee"] = 80;
	var_01["pistol"] = 0;
	var_01["rifle"] = 0;
	var_01["explosive"] = 0;
	level.arcademode_weaponbonus = var_01;
	var_02 = [];
	var_02["MOD_MELEE"] = "melee";
	var_02["MOD_PISTOL_BULLET"] = "pistol";
	var_02["MOD_RIFLE_BULLET"] = "rifle";
	var_02["MOD_PROJECTILE"] = "explosive";
	var_02["MOD_PROJECTILE_SPLASH"] = "explosive";
	var_02["MOD_EXPLOSIVE"] = "explosive";
	var_02["MOD_GRENADE"] = "explosive";
	var_02["MOD_GRENADE_SPLASH"] = "explosive";
	level.arcademode_deathtypes = var_02;
	var_03 = [];
	var_03["melee"] = (1,0,1);
	var_03["pistol"] = (0,1,0);
	var_03["rifle"] = (1,1,0);
	var_03["explosive"] = (0,1,1);
	level.arcademode_killcolors = var_03;
	var_04 = [];
	var_04["head"] = 50;
	var_04["helmet"] = 50;
	var_04["neck"] = 20;
	var_04["torso_upper"] = 10;
	var_04["torso_lower"] = 10;
	var_04["right_arm_upper"] = 0;
	var_04["left_arm_lower"] = 0;
	var_04["right_leg_lower"] = 0;
	var_04["left_leg_upper"] = 0;
	var_04["right_leg_upper"] = 0;
	var_04["left_leg_lower"] = 0;
	var_04["left_foot"] = 0;
	var_04["right_foot"] = 0;
	var_04["left_hand"] = 0;
	var_04["left_arm_upper"] = 0;
	var_04["right_hand"] = 0;
	var_04["right_arm_lower"] = 0;
	var_04["gun"] = 0;
	var_04["none"] = 0;
	level.arcademode_locationkillbonus = var_04;
	var_05 = [];
	var_05[0] = 1;
	var_05[1] = 1.5;
	var_05[2] = 3;
	var_05[3] = 4;
	level.arcademode_skillmultiplier = var_05;
	var_06 = [];
	var_06[0] = 9000;
	var_06[1] = 9000;
	var_06[2] = 7000;
	var_06[3] = 6000;
	var_06[0] = 40;
	var_06[1] = 30;
	var_06[2] = 25;
	var_06[3] = 20;
	level.arcademode_kills_until_next_extra_life = 10;
	level.arcademode_extra_lives_range = var_06;
	var_07 = [];
	for(var_08 = 0;var_08 < 4;var_08++)
	{
		var_07[var_08] = var_06[var_08] * 0.15;
	}

	level.arcademode_extra_lives_base = var_07;
}

//Function Number: 33
set_next_extra_life(param_00)
{
}

//Function Number: 34
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
	level.arcademode_ending_hud[level.arcademode_ending_hud.size] = var_04;
	return var_04;
}

//Function Number: 35
extra_lives_display_border()
{
	var_00 = new_ending_hud("center",0.001,0,97.77778);
	var_00 setshader("h1_arcademode_livesmessage_border",210,112);
	var_00.sort = level.arcademode_hud_sort + 10 - 1;
	var_00.vertalign = "top_adjustable";
	var_00.alpha = 0;
	var_00 fadeovertime(0.15);
	var_00.alpha = 1;
	wait(0.15);
	var_00 fadeovertime(0.1);
	var_00.alpha = 0;
	wait(0.1);
	var_00 fadeovertime(0.1);
	var_00.alpha = 1;
	wait(0.1);
	wait(1.2);
	var_00 fadeovertime(0.1);
	var_00.alpha = 0;
	wait(0.1);
	var_00 destroy();
}

//Function Number: 36
extra_lives_display_flare()
{
	var_00 = new_ending_hud("center",0.001,0,97.77778);
	var_00 setshader("h1_arcademode_lives_message_flare",145,26);
	var_00.sort = level.arcademode_hud_sort + 10 + 1;
	var_00.vertalign = "top_adjustable";
	var_00.alpha = 0;
	var_00 fadeovertime(0.05);
	var_00.alpha = 1;
	wait(0.05);
	var_00 fadeovertime(0.05);
	var_00.alpha = 0;
	wait(0.05);
	var_00 fadeovertime(0.05);
	var_00.alpha = 1;
	wait(0.05);
	var_00 fadeovertime(0.05);
	var_00.alpha = 0;
	wait(0.05);
	wait(0.1);
	var_00 fadeovertime(0.15);
	var_00.alpha = 1;
	wait(0.15);
	var_00 fadeovertime(0.1);
	var_00.alpha = 0;
	wait(0.1);
	wait(2.1);
	var_00 destroy();
}

//Function Number: 37
extra_lives_display(param_00)
{
	wait(0.5);
	level.player thread common_scripts\utility::play_sound_in_space("arcademode_extralife",level.player geteye());
	var_01 = new_ending_hud("center",0.001,0,97.77778);
	var_01.fontscale = 1.7;
	var_01.vertalign = "top_adjustable";
	var_01 method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.5,-0.1,0,(0.302,0.588,0.047),0.75);
	var_01.label = &"SCRIPT_EXTRA_LIFE";
	var_01 setvalue(param_00);
	thread extra_lives_display_border();
	thread extra_lives_display_flare();
	var_01.alpha = 0;
	wait(0.4);
	var_01 fadeovertime(0.15);
	var_01.alpha = 1;
	wait(0.15);
	wait(1);
	var_01 fadeovertime(0.1);
	var_01.alpha = 0;
	wait(0.1);
	var_01 destroy();
}

//Function Number: 38
fade_out(param_00)
{
	self fadeovertime(param_00);
	self.alpha = 0;
	wait(param_00);
	self destroy();
}

//Function Number: 39
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
		wait(var_04);
	}
}

//Function Number: 40
round_up_to_five(param_00)
{
	var_01 = param_00 - param_00 % 5;
	if(var_01 < param_00)
	{
		var_01 = var_01 + 5;
	}

	return var_01;
}

//Function Number: 41
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

//Function Number: 42
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

//Function Number: 43
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

//Function Number: 44
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

	if(!common_scripts\utility::flag("arcademode_complete"))
	{
		level.player thread common_scripts\utility::play_sound_in_space("h1_arcademode_pulse_score",level.player geteye());
	}

	var_01 = newhudelem();
	var_01.horzalign = "center";
	var_01.vertalign = "middle";
	var_01.alignx = "center";
	var_01.aligny = "middle";
	var_01 arcademode_set_origin_in_radius();
	var_01.font = "objective";
	var_01.fontscale = 1.5;
	var_01.archived = 0;
	var_01.color = (1,1,1);
	var_01.sort = 4;
	var_02 = level.arcademode_kill_streak_current_multiplier;
	level.player.pointpulsecount++;
	level.player.pointpulseindex++;
	wait(0.05);
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
		var_01 method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
	}

	var_01 setvalue(param_00);
	var_01.alpha = 1;
	var_03 = 4;
	var_04 = 0.025;
	var_05 = 1.5;
	var_06 = 0.2;
	var_01 changefontscaleovertime(var_04);
	var_01.fontscale = var_03;
	wait(0.05);
	var_01 moveovertime(1.75);
	var_01.y = var_01.y - 20;
	var_01 changefontscaleovertime(var_06);
	var_01.fontscale = var_05;
	wait(var_06);
	var_01 fadeovertime(1);
	var_01.alpha = 0;
	wait(1);
	level.player.pointpulsecount--;
	if(level.player.pointpulsecount == 0)
	{
		level.player.pointpulseindex = 0;
	}

	var_01 destroy();
}

//Function Number: 45
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

//Function Number: 46
arcademode_add_points_for_mod(param_00)
{
	for(var_01 = 0;var_01 < level.arcademode_multikills[param_00].size;var_01++)
	{
		arcademode_add_points_for_individual_kill(level.arcademode_multikills[param_00][var_01],param_00,level.arcademode_multikills[param_00].size);
	}
}

//Function Number: 47
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

//Function Number: 48
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
	var_05["type"] = var_04;
	var_05["origin"] = var_03;
	if(var_04 == "explosive")
	{
		var_05["origin"] = self.origin;
	}

	level.arcademode_multikills[var_04][level.arcademode_multikills[var_04].size] = var_05;
}

//Function Number: 49
player_damage(param_00,param_01,param_02)
{
	thread arcademode_add_points(param_02,0,param_00,level.arcademode_damagebase);
}

//Function Number: 50
player_damage_ads(param_00,param_01,param_02)
{
	thread arcademode_add_points(param_02,0,param_00,level.arcademode_damagebase * 1.25);
}

//Function Number: 51
ending_screen_mission_complete_flourish(param_00)
{
	var_01 = new_ending_hud("center",0.05,0,param_00);
	var_01.fontscale = 3;
	var_01.color = (1,1,1);
	var_01 method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
	var_01 settext(&"SCRIPT_MISSION_COMPLETE");
	var_02 = new_ending_hud("center",0.15,0,param_00);
	var_02.fontscale = 4.5;
	var_02.color = (1,1,1);
	var_02 method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
	var_02 settext(&"SCRIPT_MISSION_COMPLETE");
	var_01 changefontscaleovertime(0.15);
	var_01.fontscale = 4.5;
	var_02 changefontscaleovertime(0.15);
	var_02.fontscale = 3;
	wait(0.05);
	var_01 fadeovertime(0.15);
	var_01.alpha = 0;
	wait(0.15);
	var_01 destroy();
	var_02 destroy();
}

//Function Number: 52
end_mission()
{
	setsaveddvar("ui_nextMission","0");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		var_01.maxhealth = 0;
		var_01.health = 1;
	}

	changelevel("");
}

//Function Number: 53
create_total_score_hud(param_00,param_01)
{
	level.arcademode_hud_total_scores = [];
	for(var_02 = 0;var_02 < level.arcademode_hud_digits;var_02++)
	{
		var_03 = get_hud_score();
		level.arcademode_hud_total_scores[level.arcademode_hud_total_scores.size] = var_03;
		level.arcademode_ending_hud[level.arcademode_ending_hud.size] = var_03;
		var_03.x = 0;
		var_03.y = param_01;
		var_03.sort = level.arcademode_hud_sort + 10;
		var_03.alignx = "left";
		var_03.aligny = "middle";
		var_03.horzalign = "fullscreen";
		var_03.vertalign = "middle";
		var_03.fontscale = 1.875;
		var_03.alpha = 0;
		var_03 fadeovertime(1);
		var_03.alpha = 1;
	}
}

//Function Number: 54
set_total_score_hud(param_00)
{
	hud_draw_score_for_elements_align_left(param_00,level.arcademode_hud_total_scores);
}

//Function Number: 55
rescale_ending_huds_thread(param_00,param_01,param_02,param_03,param_04,param_05)
{
	for(;;)
	{
		var_06 = getscreenwidth();
		var_07 = getscreenheight();
		if(var_06 != level.screen_width || var_07 != level.screen_height)
		{
			level.screen_width = var_06;
			level.screen_height = var_07;
			if(level.screen_height == 0)
			{
				level.screen_height = 1;
			}

			if(level.screen_width == 0)
			{
				level.screen_width = 1;
			}

			rescale_ending_huds(param_00,param_01,param_02,param_03,param_04,param_05);
		}

		wait(0.1);
	}
}

//Function Number: 56
rescale_ending_huds(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 1920 / level.screen_width * level.screen_height / 1080;
	var_07 = 37 * var_06;
	var_08 = 11.66667 + 9 * var_06 * 9 + var_07;
	for(var_09 = 0;var_09 < level.arcademode_hud_digits;var_09++)
	{
		level.arcademode_hud_mission_scores[var_09].x = 320 + var_09 * -9 * var_06 + var_08;
		if(isdefined(level.arcademode_hud_total_scores))
		{
			level.arcademode_hud_total_scores[var_09].x = 320 + var_09 * -9 * var_06 + var_08;
		}
	}

	var_0A = 11.66667 + var_07;
	level.arcademode_hud_timer[0].x = 320 + var_0A + 0 * var_06;
	level.arcademode_hud_timer[1].x = 320 + var_0A + 8.3 * var_06;
	level.arcademode_hud_timer[2].x = 320 + var_0A + 16.6 * var_06;
	level.arcademode_hud_timer[3].x = 320 + var_0A + 21 * var_06;
	level.arcademode_hud_timer[4].x = 320 + var_0A + 29.6 * var_06;
	var_0B = 58.5;
	var_0C = var_0B - 10 - param_03 * 13 * 0.5;
	for(var_09 = 0;var_09 < level.arcademode_maxlives;var_09++)
	{
		level.arcademode_lives_hud[var_09].x = var_09 * -13 + var_0C * var_06;
	}

	if(isdefined(param_00))
	{
		param_00.x = 320 + var_07;
	}

	param_01.x = 320 + var_07;
	param_02.x = 320 + var_07;
	if(level.arcademode_success)
	{
		param_04 setshader("h1_arcademode_scanelines_border",int(344 * var_06),65);
	}
	else
	{
		param_04 setshader("h1_arcademode_scanelines_border",int(216 * var_06),65);
	}

	param_05 setshader("h1_arcademode_scanelines_border_end_title",int(291 * var_06),4);
}

//Function Number: 57
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
			wait(2);
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
	if(level.arcademode_success)
	{
		if(var_02 == 0)
		{
			var_02++;
		}
	}

	var_03 = 0.5;
	level.mission_failed_disabled = 1;
	thread player_invul_forever();
	thread black_background(var_03);
	wait(var_03 + 0.25);
	level.player freezecontrols(1);
	var_04 = 1;
	var_05 = 0;
	if(getdvar("arcademode_full") == "1")
	{
		var_05 = 27.55556;
	}

	var_06 = -111.1111;
	var_07 = -72;
	var_08 = var_07;
	var_09 = -72 + var_05;
	var_0A = var_09;
	var_0B = -44.44445 + var_05;
	var_0C = var_0B;
	var_0D = 35.55556 + var_05;
	var_0E = -20.44444 + var_05;
	var_0F = new_ending_hud("center",0.1,0,var_06);
	var_0F.fontscale = 3;
	var_10 = new_ending_hud("center",0.1,320,var_06 + 5);
	var_10.horzalign = "fullscreen";
	var_10.sort = var_0F.sort - 1;
	var_10.alpha = 1;
	level.screen_width = getscreenwidth();
	level.screen_height = getscreenheight();
	var_11 = 1920 / level.screen_width * level.screen_height / 1080;
	if(level.arcademode_success)
	{
		var_0F.color = (1,1,1);
		var_0F method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
		var_10 setshader("h1_arcademode_scanelines_border",int(344 * var_11),65);
		var_0F settext(&"SCRIPT_MISSION_COMPLETE");
		level.player playsound("h1_arcademode_mission_success");
		thread ending_screen_mission_complete_flourish(var_06);
	}
	else
	{
		var_0F.color = (1,0.15,0.16);
		var_0F method_8347(-0.6,0,0,0,(0.5,0.1,0.1),0.3,0,0,(0,0,0),0);
		var_0F settext(level.arcademode_failurestring);
		var_10 setshader("h1_arcademode_scanelines_border",int(216 * var_11),65);
		var_10.color = (1,0.15,0.16);
		level.player playsound("h1_arcademode_mission_fail");
	}

	var_12 = new_ending_hud("center",0.1,0,var_06 + 20);
	var_12 setshader("h1_arcademode_scanelines_border_end_title",int(291 * var_11),4);
	var_12.sort = var_0F.sort - 1;
	var_12.alpha = 1;
	wait(1);
	var_13 = getdvarint("arcademode_lives");
	var_14 = level.arcademode_rewarded_lives;
	if(var_13 > var_14)
	{
		var_13 = var_14;
	}

	for(var_15 = 0;var_15 < level.arcademode_maxlives;var_15++)
	{
		level.arcademode_lives_hud[var_15] destroy();
	}

	level.arcademode_lives_hud = [];
	for(var_15 = 0;var_15 < level.arcademode_maxlives;var_15++)
	{
		arcademode_add_life(var_15,0,var_0E,0,64,level.arcademode_hud_sort + 10);
		level.arcademode_lives_hud[var_15].horzalign = "center";
		level.arcademode_lives_hud[var_15].vertalign = "middle";
	}

	arcademode_redraw_lives(var_13);
	var_16 = 0;
	var_17 = undefined;
	if(getdvar("arcademode_full") == "1")
	{
		var_17 = new_ending_hud("center",var_04,0,var_07);
		var_17.alignx = "right";
		var_17.horzalign = "fullscreen";
		var_17.fontscale = 1.875;
		var_17.color = (1,1,1);
		var_17 method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
		var_17 settext(&"SCRIPT_TOTAL_SCORE");
		create_total_score_hud(0,var_08);
		var_16 = getdvarint("arcademode_combined_score");
		set_total_score_hud(var_16);
	}

	var_18 = new_ending_hud("center",var_04,0,var_09);
	var_18.alignx = "right";
	var_18.horzalign = "fullscreen";
	var_18.fontscale = 1.875;
	var_18.color = (1,1,1);
	var_18 method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
	var_18 settext(&"SCRIPT_MISSION_SCORE");
	level.arcademode_hud_mission_scores = [];
	for(var_15 = 0;var_15 < level.arcademode_hud_digits;var_15++)
	{
		var_19 = get_hud_score();
		level.arcademode_hud_mission_scores[level.arcademode_hud_mission_scores.size] = var_19;
		level.arcademode_ending_hud[level.arcademode_ending_hud.size] = var_19;
		var_19.x = 0;
		var_19.y = var_0A;
		var_19.sort = level.arcademode_hud_sort + 10;
		var_19.alignx = "left";
		var_19.aligny = "middle";
		var_19.horzalign = "fullscreen";
		var_19.vertalign = "middle";
		var_19.fontscale = 1.875;
		var_19.alpha = 0;
		var_19 fadeovertime(var_04);
		var_19.alpha = 1;
	}

	hud_draw_score_for_elements_align_left(0,level.arcademode_hud_mission_scores);
	var_1A = 0;
	var_1B = 0;
	while(var_02 >= 60)
	{
		var_1A++;
		var_02 = var_02 - 60;
	}

	var_1B = var_02;
	var_1C = new_ending_hud("center",var_04,0,var_0C);
	var_1C.alignx = "right";
	var_1C.horzalign = "fullscreen";
	var_1C.fontscale = 1.7;
	var_1C.color = (1,1,1);
	var_1C method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
	var_1C settext(&"SCRIPT_TIME_REMAINING");
	level.arcademode_hud_timer = [];
	level.arcademode_hud_timer[0] = new_ending_hud("center",var_04,0,var_0B);
	level.arcademode_hud_timer[1] = new_ending_hud("center",var_04,0,var_0B);
	level.arcademode_hud_timer[2] = new_ending_hud("center",var_04,0,var_0B);
	level.arcademode_hud_timer[2] settext(&"SCRIPT_COLON");
	level.arcademode_hud_timer[3] = new_ending_hud("center",var_04,0,var_0B);
	level.arcademode_hud_timer[4] = new_ending_hud("center",var_04,0,var_0B);
	for(var_15 = 0;var_15 < 5;var_15++)
	{
		level.arcademode_hud_timer[var_15].alignx = "left";
		level.arcademode_hud_timer[var_15].horzalign = "fullscreen";
		level.arcademode_hud_timer[var_15].vertalign = "middle";
		level.arcademode_hud_timer[var_15].fontscale = 1.7;
		level.arcademode_hud_timer[var_15].fontscale = 1.7;
		level.arcademode_hud_timer[var_15].color = (1,1,1);
		level.arcademode_hud_timer[var_15] method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.3,-0.1,0,(0.302,0.588,0.047),0.75);
	}

	ending_set_time(var_1A,var_1B);
	level.screen_width = getscreenwidth();
	level.screen_height = getscreenheight();
	var_11 = 1920 / level.screen_width * level.screen_height / 1080;
	rescale_ending_huds(var_17,var_18,var_1C,var_13,var_10,var_12);
	thread rescale_ending_huds_thread(var_17,var_18,var_1C,var_13,var_10,var_12);
	wait(var_04);
	wait(1);
	var_1D = getdvarint("arcadeMode_score");
	var_1E = 0;
	var_1F = var_16;
	var_20 = 0;
	for(;;)
	{
		var_21 = var_1D - var_1E;
		var_22 = var_21 * 0.2 + 1;
		if(var_21 <= 15)
		{
			var_22 = 1;
		}

		var_22 = int(var_22);
		var_1E = var_1E + var_22;
		if(var_1E > var_1D)
		{
			var_1E = var_1D;
		}

		hud_draw_score_for_elements_align_left(var_1E,level.arcademode_hud_mission_scores);
		if(var_1E == var_1D)
		{
			break;
		}

		var_20--;
		if(var_20 <= 0)
		{
			level.player playsound("h1_arcademode_ending_mission_pts");
			var_20 = 3;
		}

		wait(0.05);
	}

	wait(1);
	var_23 = 0;
	var_24 = undefined;
	if(level.arcademode_success)
	{
		var_25 = 5;
		var_26 = var_1A * 60 + var_1B;
		var_27 = ceil(var_26 / 15);
		var_28 = ceil(var_26 * var_25);
		var_29 = ceil(var_28 / level.arcademode_difficultytimerscale);
		var_2A = var_1E;
		var_2B = var_1E + var_29;
		var_2C = var_16;
		var_2D = var_16 + var_29;
		for(var_15 = 1;var_15 <= var_27;var_15++)
		{
			var_2E = var_15 * 1 / var_27;
			if(var_15 == var_27)
			{
				var_2E = 1;
			}

			var_1E = int(var_2A * 1 - var_2E + var_2B * var_2E);
			if(getdvar("arcademode_full") == "1")
			{
				var_16 = int(var_2C * 1 - var_2E + var_2D * var_2E);
				set_total_score_hud(var_16);
			}

			hud_draw_score_for_elements_align_left(var_1E,level.arcademode_hud_mission_scores);
			var_2F = int(var_26 * 1 - var_2E);
			ending_set_time(floor(var_2F / 60),var_2F % 60);
			var_20--;
			if(var_20 <= 0)
			{
				level.player playsound("h1_arcademode_ending_time_pts");
				var_20 = 3;
			}

			wait(0.05);
		}

		ending_set_time(0,0);
		wait(1);
		for(;;)
		{
			var_30 = 1;
			if(var_13 > 10)
			{
				var_31 = var_13 % 10;
				if(var_13 - var_31 >= 10)
				{
					var_30 = 10;
				}
				else
				{
					var_30 = var_31;
				}

				if(var_13 < 20)
				{
					var_30 = var_31;
				}
			}

			var_13 = var_13 - var_30;
			if(var_13 < 0)
			{
				break;
			}

			var_32 = 1000;
			var_32 = var_32 * var_30;
			var_22 = int(var_32);
			if(getdvar("arcademode_full") == "1")
			{
				var_16 = var_16 + var_22;
				set_total_score_hud(var_16);
			}

			var_1E = var_1E + var_22;
			level.player playsound("h1_arcademode_ending_lives_pts");
			hud_draw_score_for_elements_align_left(int(var_1E),level.arcademode_hud_mission_scores);
			arcademode_redraw_lives(var_13);
			wait(0.6);
		}

		wait(1);
		if(getdvarint("arcademode_died") != 1 && level.gameskill >= 2)
		{
			var_22 = int(var_1E);
			arcademode_end_boost(var_1E,var_16,var_22,&"SCRIPT_ZERO_DEATHS","arcademode_zerodeaths",var_0D,var_04,var_11);
			var_1E = var_1E + var_22;
			var_16 = var_16 + var_22;
		}
	}
	else
	{
		for(var_15 = 0;var_15 < 5;var_15++)
		{
			level.arcademode_hud_timer[var_15] setpulsefx(0,0,1000);
		}

		var_1C setpulsefx(0,0,1000);
		arcademode_redraw_lives(0);
		wait(2);
	}

	var_33 = level.arcademode_skillmultiplier[level.gameskill];
	if(var_33 > 1)
	{
		if(var_33 == 1.5)
		{
			var_34 = &"SCRIPT_DIFFICULTY_BONUS_ONEANDAHALF";
		}
		else if(var_34 == 3)
		{
			var_34 = &"SCRIPT_DIFFICULTY_BONUS_THREE";
		}
		else
		{
			var_34 = &"SCRIPT_DIFFICULTY_BONUS_FOUR";
		}

		var_22 = int(ceil(var_1E * var_33) - var_1E);
		arcademode_end_boost(var_1E,var_16,var_22,var_34,"h1_arcademode_ending_diff_pts",var_0D,var_04,var_11);
		var_1E = var_1E + var_22;
		var_16 = var_16 + var_22;
	}

	var_35 = 0;
	if(getdvar("arcademode_full") == "1")
	{
		var_36 = "s18";
		var_37 = getdvarint(var_36);
		if(var_16 > var_37)
		{
			var_38 = get_digits_from_score(var_16);
			var_39 = get_score_string_from_digits(var_38);
			setdvar(var_36,var_39);
			var_3A = 0;
			if(!level.arcademode_success)
			{
				var_3A = 1;
			}

			if(level.script == "airplane")
			{
				var_3A = 1;
			}

			if(var_3A)
			{
				var_35 = 1;
			}
		}

		var_3B = level.player getplayerdata(common_scripts\utility::getstatsgroup_sp(),"fullChallengeScore");
		if(var_16 > var_3B)
		{
			level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(),"fullChallengeScore",var_16);
		}

		level.player uploadscore("LB_AM_FULLCHALLENGE",getdvarint(var_36));
	}
	else
	{
		var_3C = [];
		var_3C["cargoship"] = 0;
		var_3C["blackout"] = 1;
		var_3C["armada"] = 2;
		var_3C["bog_a"] = 3;
		var_3C["hunted"] = 4;
		var_3C["ac130"] = 5;
		var_3C["bog_b"] = 6;
		var_3C["airlift"] = 7;
		var_3C["village_assault"] = 8;
		var_3C["scoutsniper"] = 9;
		var_3C["sniperescape"] = 10;
		var_3C["village_defend"] = 11;
		var_3C["ambush"] = 12;
		var_3C["icbm"] = 13;
		var_3C["launchfacility_a"] = 14;
		var_3C["launchfacility_b"] = 15;
		var_3C["jeepride"] = 16;
		var_3C["airplane"] = 17;
		var_3D = var_3C[level.script];
		if(isdefined(var_3D))
		{
			var_3B = level.player getplayerdata(common_scripts\utility::getstatsgroup_sp(),"arcadeScore",level.script);
			if(var_1E > var_3B)
			{
				var_35 = 1;
				level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(),"arcadeScore",level.script,var_1E);
			}

			level.player uploadscore("LB_AM_" + level.script,var_1E);
		}
	}

	if(var_35)
	{
		if(!level.arcademode_success)
		{
			updategamerprofile();
		}

		wait(1);
		var_3E = new_ending_hud("center",var_04,0,var_0D);
		var_3E.fontscale = 2.25;
		var_3E method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.5,-0.1,0,(0.302,0.588,0.047),0.75);
		var_3E settext(&"SCRIPT_NEW_HIGH_SCORE");
		var_3E fadeovertime(0.05);
		var_3E.alpha = 1;
		var_3E setpulsefx(30,3000,1000);
		var_3F = new_ending_hud("center",var_04,0,var_0D + 0.5);
		var_3F setshader("h1_arcademode_livesmessage_border",int(313 * var_11),135);
		var_3F.sort = var_3E.sort - 1;
		var_3F fadeovertime(0.05);
		var_3F.alpha = 1;
		wait(3);
		var_3F fadeovertime(1);
		var_3F.alpha = 0;
		wait(0.5);
	}

	wait(2);
	var_0F setpulsefx(0,0,1000);
	wait(0.5);
	var_18 setpulsefx(0,0,1000);
	for(var_15 = 0;var_15 < level.arcademode_hud_digits;var_15++)
	{
		var_19 = level.arcademode_hud_mission_scores[var_15];
		var_19 setpulsefx(0,0,1000);
	}

	if(getdvar("arcademode_full") == "1")
	{
		var_17 setpulsefx(0,0,1000);
		for(var_15 = 0;var_15 < level.arcademode_hud_digits;var_15++)
		{
			var_19 = level.arcademode_hud_total_scores[var_15];
			var_19 setpulsefx(0,0,1000);
		}
	}

	if(level.arcademode_success)
	{
		wait(0.5);
		for(var_15 = 0;var_15 < 5;var_15++)
		{
			level.arcademode_hud_timer[var_15] setpulsefx(0,0,1000);
		}

		var_1C setpulsefx(0,0,1000);
	}

	wait(1);
	if(getdvar("arcademode_full") == "1")
	{
		logstring("ArcadeMode Score: " + var_1E + ", mission: " + level.script + ", gameskill: " + level.gameskill + ", total: " + var_16);
	}
	else
	{
		logstring("ArcadeMode Score: " + var_1E + ", mission: " + level.script + ", gameskill: " + level.gameskill);
	}

	setdvar("arcademode_combined_score",var_16);
	if(var_16 >= 400000)
	{
		maps\_utility::giveachievement_wrapper("ARCADE_ADDICT");
	}

	if(!level.arcademode_success)
	{
		setdvar("ui_arcade_lost",1);
		end_mission();
	}
	else
	{
		setdvar("ui_arcade_lost",0);
	}

	for(var_15 = 0;var_15 < level.arcademode_ending_hud.size;var_15++)
	{
		if(isdefined(level.arcademode_ending_hud[var_15]))
		{
			level.arcademode_ending_hud[var_15].alpha = 0;
		}
	}

	common_scripts\utility::flag_set("arcademode_ending_complete");
}

//Function Number: 58
arcademode_end_boost(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = new_ending_hud("center",param_06,0,param_05);
	var_08.fontscale = 2.25;
	var_08 method_8347(-0.6,0,0,0,(0.247,0.439,0.094),0.5,-0.1,0,(0.302,0.588,0.047),0.75);
	var_08 settext(param_03);
	var_08 fadeovertime(0.05);
	var_08.alpha = 1;
	var_08 setpulsefx(30,10000,1000);
	var_09 = new_ending_hud("center",0.15,320,param_05 + 0.5);
	var_09 setshader("h1_arcademode_livesmessage_border",int(330 * param_07),135);
	var_09.horzalign = "fullscreen";
	var_09.sort = var_08.sort - 1;
	var_09 fadeovertime(0.05);
	var_09.alpha = 1;
	wait(0.05);
	wait(1);
	var_0A = 0;
	var_0B = param_00 + param_02;
	var_0C = param_01 + param_02;
	for(;;)
	{
		var_0D = var_0B - param_00;
		param_02 = var_0D * 0.2 + 1;
		if(var_0D <= 15)
		{
			param_02 = 1;
		}

		param_02 = int(param_02);
		param_00 = param_00 + param_02;
		if(param_00 > var_0B)
		{
			param_00 = var_0B;
		}

		hud_draw_score_for_elements_align_left(param_00,level.arcademode_hud_mission_scores);
		if(getdvar("arcademode_full") == "1")
		{
			param_01 = param_01 + param_02;
			if(param_01 > var_0C)
			{
				param_01 = var_0C;
			}

			set_total_score_hud(param_01);
		}

		if(param_00 == var_0B)
		{
			break;
		}

		var_0A--;
		if(var_0A <= 0)
		{
			level.player playsound(param_04);
			var_0A = 3;
		}

		wait(0.05);
	}

	wait(0.5);
	var_08 setpulsefx(0,10,1000);
	var_09 fadeovertime(1);
	var_09.alpha = 0;
	wait(1);
}

//Function Number: 59
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

//Function Number: 60
player_invul_forever()
{
	for(;;)
	{
		level.player enableinvulnerability();
		level.player.deathinvulnerabletime = 70000;
		level.player.ignoreme = 1;
		var_00 = getaispeciesarray("all","all");
		common_scripts\utility::array_thread(var_00,::maps\_utility::set_ignoreme,1);
		wait(0.05);
	}
}

//Function Number: 61
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

	level.arcademode_hud_timer[4] setvalue(param_01);
	level.arcademode_hud_timer[3] setvalue(var_03);
	level.arcademode_hud_timer[1] setvalue(param_00);
	level.arcademode_hud_timer[0] setvalue(var_02);
}

//Function Number: 62
draw_checkpoint(param_00,param_01,param_02)
{
	param_00 = param_00 * param_02;
	var_03 = new_ending_hud("center",0.001,param_00,73.33334);
	var_03.vertalign = "top_adjustable";
	var_03.fontscale = 2.5;
	var_03.color = (1,1,1);
	var_03.font = "objective";
	var_03 method_8347(-0.1,0,0,-0.001,(0,0,0),0.2,-0.1,0,(0,0,0),0.5);
	var_03 settext(&"SCRIPT_CHECKPOINT");
	var_03.alpha = 0;
	wait(0.15);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	var_03.fontscale = 3.5;
	wait(0.05);
	var_03.fontscale = 2.5;
	wait(0.05);
	wait(1);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 destroy();
}

//Function Number: 63
draw_checkpoint_scanlines(param_00,param_01,param_02)
{
	param_00 = param_00 * param_02;
	var_03 = new_ending_hud("center",0.1,param_00,73.33334);
	var_03.vertalign = "top_adjustable";
	var_03 setshader("h1_arcademode_scanelines_border",384,48);
	var_03.sort = var_03.sort - 2;
	var_03.alpha = 0.25;
	var_03.alpha = 0;
	wait(0.15);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	wait(0.05);
	wait(0.05);
	wait(1);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 1;
	wait(0.05);
	var_03 fadeovertime(0.05);
	var_03.alpha = 0;
	wait(0.05);
	var_03 destroy();
}

//Function Number: 64
draw_checkpoint_flare()
{
	var_00 = new_ending_hud("center",0.001,0,73.33334);
	var_00.vertalign = "top_adjustable";
	var_00 setshader("h1_arcademode_checkpoint_flare",326,23);
	var_00.sort = level.arcademode_hud_sort + 10 - 1;
	var_00.alpha = 0;
	var_00 fadeovertime(0.05);
	var_00.alpha = 1;
	wait(0.05);
	var_00 fadeovertime(0.05);
	var_00.alpha = 0;
	wait(0.05);
	var_00 fadeovertime(0.05);
	var_00.alpha = 1;
	wait(0.05);
	var_00 fadeovertime(0.05);
	var_00.alpha = 0;
	wait(0.05);
	var_00 fadeovertime(0.05);
	var_00.alpha = 1;
	wait(0.05);
	var_00 fadeovertime(0.05);
	var_00.alpha = 0;
	wait(0.05);
	var_00 destroy();
}

//Function Number: 65
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

//Function Number: 66
arcademode_init_kill_streak_colors()
{
	level.arcademode_streak_color = [];
	level.arcademode_streak_glow = [];
	level.arcademode_streak_color[level.arcademode_streak_color.size] = level.color_cool_green;
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.6784314,0.9764706,0.7686275);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.6588235,0.9647059,0.6196079);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (1,0.9764706,0.3176471);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.9882353,0.8666667,0.3019608);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.9882353,0.8313726,0.3764706);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.9882353,0.7921569,0.2235294);
	level.arcademode_streak_color[level.arcademode_streak_color.size] = (0.9843137,0.7254902,0.1529412);
	for(var_00 = 0;var_00 < level.arcademode_streak_color.size;var_00++)
	{
		level.arcademode_streak_glow[var_00] = (level.arcademode_streak_color[var_00][0] * 0.35,level.arcademode_streak_color[var_00][1] * 0.35,level.arcademode_streak_color[var_00][2] * 0.35);
	}

	level.arcademode_streak_color[0] = level.color_cool_green_glow;
}

//Function Number: 67
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

	var_00 = new_ending_hud("right",0.2,-21.66667,80);
	var_00.aligny = "top";
	var_00.vertalign = "top";
	var_00.glowalpha = 0;
	var_00 setpulsefx(5,3000,1000);
	var_00.fontscale = 0.75;
	var_01 = level.arcademode_kill_streak_current_multiplier - 1;
	var_01 = int(clamp(var_01,1,7));
	var_00.color = level.arcademode_streak_color[var_01];
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

	wait(5);
	var_00 destroy();
}

//Function Number: 68
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

//Function Number: 69
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

//Function Number: 70
get_hud_multi()
{
	var_00 = 0.1;
	var_01 = newhudelem();
	var_01.alignx = "right";
	var_01.aligny = "top";
	var_01.horzalign = "right";
	var_01.vertalign = "top";
	var_01 thread arcademode_draw_multiplier_kill();
	var_01.x = 0;
	var_01.y = 76.33334;
	var_01.font = "objective";
	var_01.fontscale = 2.25;
	var_01.archived = 0;
	var_01.foreground = 1;
	var_01.hidewheninmenu = 1;
	var_01.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
	var_01 method_8347(-0.1,0,0,-0.001,(0,0,0),0.5,-0.1,0,(0,0,0),0.75);
	var_01.sort = level.arcademode_hud_sort;
	var_01.label = &"SCRIPT_X";
	var_01 setvalue(level.arcademode_kill_streak_current_multiplier);
	var_01 moveovertime(var_00);
	var_01.x = -21.66667;
	var_01.alpha = 0.25;
	var_01 fadeovertime(var_00);
	var_01.alpha = 1;
	return var_01;
}

//Function Number: 71
get_hud_multi_emphasis()
{
	var_00 = newhudelem();
	var_00.alignx = "right";
	var_00.aligny = "middle";
	var_00.horzalign = "right";
	var_00.vertalign = "top";
	var_00.x = -21.66667;
	var_00.y = 89.33334;
	var_00.font = "objective";
	var_00.fontscale = 2.25;
	var_00.archived = 0;
	var_00.foreground = 1;
	var_00.hidewheninmenu = 1;
	var_00.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
	var_00 method_8347(-0.6,0,0,0,(0,0,0),0,-0.6,0,var_00.color,1);
	var_00.sort = level.arcademode_hud_sort;
	var_00.label = &"SCRIPT_X";
	var_00 setvalue(level.arcademode_kill_streak_current_multiplier);
	var_00.alpha = 0;
	var_01 = 2;
	var_02 = newhudelem();
	var_02.alignx = "right";
	var_02.aligny = "top";
	var_02.horzalign = "right";
	var_02.vertalign = "top";
	var_02 thread arcademode_draw_multiplier_kill();
	var_02 setshader("h1_arcademode_numberstreak_circles",22 * var_01,27 * var_01);
	var_02.x = 38;
	var_02.y = 72.33334;
	var_02.archived = 0;
	var_02.foreground = 1;
	var_02.hidewheninmenu = 1;
	var_02.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
	var_02.sort = level.arcademode_hud_sort - 1;
	var_03 = newhudelem();
	var_03.alignx = "right";
	var_03.aligny = "top";
	var_03.horzalign = "right";
	var_03.vertalign = "top";
	var_03 thread arcademode_draw_multiplier_kill();
	var_03 setshader("h1_arcademode_numberstreak_glow",64,64);
	var_03.x = 0.8333321;
	var_03.y = 60.33334;
	var_03.archived = 0;
	var_03.foreground = 1;
	var_03.hidewheninmenu = 1;
	var_03.color = level.arcademode_streak_color[level.arcademode_kill_streak_current_multiplier - 1];
	var_03.sort = level.arcademode_hud_sort - 1;
	var_04 = 0.2;
	var_02.alpha = 1;
	var_02 scaleovertime(0.4,27 * var_01,27 * var_01);
	var_03.alpha = 0;
	var_03 fadeovertime(0.4);
	var_05 = 0.1;
	var_02 moveovertime(var_05);
	var_02.x = -20.66667;
	wait(var_05);
	if(isdefined(var_00))
	{
		var_06 = 0.4;
		var_07 = 10;
		var_00 changefontscaleovertime(var_06);
		var_00.fontscale = var_07;
		wait(0.05);
		var_08 = 0.35;
		var_00.alpha = var_08;
		wait(0.05);
		var_00 fadeovertime(var_06);
		var_00.alpha = 0;
	}

	if(isdefined(var_02))
	{
		var_02 fadeovertime(0.2);
		var_02.alpha = 0;
		var_09 = 0.15;
		wait(var_09);
		var_02 scaleovertime(0.2,32 * var_01,27 * var_01);
		wait(0.35 - var_09);
	}

	if(isdefined(var_03))
	{
		var_03 fadeovertime(0.2);
		var_03.alpha = 0;
	}

	wait(0.4);
	if(isdefined(var_00))
	{
		var_00 destroy();
	}

	if(isdefined(var_02))
	{
		var_02 destroy();
	}

	if(isdefined(var_03))
	{
		var_03 destroy();
	}
}

//Function Number: 72
arcademode_draw_multiplier()
{
	level endon("arcademode_new_kill_streak");
	var_00 = get_hud_multi();
	thread get_hud_multi_emphasis();
	level.arcademode_hud_streak = var_00;
	level waittill("arcademode_stop_kill_streak");
	var_00 setpulsefx(0,0,1000);
	wait(1);
	var_00 destroy();
	level.arcademode_hud_streak = undefined;
}

//Function Number: 73
arcademode_draw_mult_sizzle()
{
	level endon("arcademode_new_kill_streak");
	wait(0.05);
	var_00 = 500;
	self moveovertime(2);
	self.x = self.x + randomintrange(var_00 * -1,var_00);
	self.y = self.y + randomintrange(var_00 * -1,var_00);
	wait(0.5);
	self fadeovertime(1);
	self.alpha = 0;
	wait(1);
	self destroy();
}

//Function Number: 74
arcademode_draw_multiplier_kill()
{
	self endon("death");
	level waittill("arcademode_new_kill_streak");
	self destroy();
}

//Function Number: 75
get_score_string_from_digits(param_00)
{
	var_01 = "";
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = param_00[var_02] + var_01;
	}

	return var_01;
}