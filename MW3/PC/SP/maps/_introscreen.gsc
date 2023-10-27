/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_introscreen.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 481 ms
 * Timestamp: 10/27/2023 2:22:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::flag_init("pullup_weapon");
	common_scripts\utility::flag_init("introscreen_complete");
	common_scripts\utility::flag_init("safe_for_objectives");
	common_scripts\utility::flag_init("introscreen_complete");
	maps\_utility::delaythread(10,::common_scripts\utility::flag_set,"safe_for_objectives");
	level.linefeed_delay = 16;
	precacheshader("black");
	precacheshader("white");
	if(getdvar("introscreen") == "")
	{
		setdvar("introscreen","1");
	}

	if(isdefined(level.credits_active))
	{
		return;
	}

	main_old_maps();
	switch(get_introscreen_levelname())
	{
		case "london":
			precachestring(&"LONDON_INTROSCREEN_LINE_1");
			precachestring(&"LONDON_INTROSCREEN_LINE_2");
			precachestring(&"LONDON_INTROSCREEN_LINE_3");
			precachestring(&"LONDON_INTROSCREEN_LINE_4");
			precachestring(&"LONDON_INTROSCREEN_LINE_5");
			introscreen_delay();
			break;

		case "castle":
			precachestring(&"CASTLE_INTROSCREEN_LINE_1");
			precachestring(&"CASTLE_INTROSCREEN_LINE_2");
			precachestring(&"CASTLE_INTROSCREEN_LINE_3");
			precachestring(&"CASTLE_INTROSCREEN_LINE_4");
			precachestring(&"CASTLE_INTROSCREEN_LINE_5");
			introscreen_delay();
			break;

		case "prague":
			precachestring(&"PRAGUE_INTROSCREEN_LINE_1");
			precachestring(&"PRAGUE_INTROSCREEN_LINE_2");
			precachestring(&"PRAGUE_INTROSCREEN_LINE_3");
			precachestring(&"PRAGUE_INTROSCREEN_LINE_4");
			precachestring(&"PRAGUE_INTROSCREEN_LINE_5");
			introscreen_delay();
			break;

		case "prague_escape":
			precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_1");
			precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_2");
			precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_3");
			precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_4");
			precachestring(&"PRAGUE_ESCAPE_INTROSCREEN_LINE_5");
			introscreen_delay();
			break;

		case "payback":
			precachestring(&"PAYBACK_INTROSCREEN_LINE_1");
			precachestring(&"PAYBACK_INTROSCREEN_LINE_2");
			precachestring(&"PAYBACK_INTROSCREEN_LINE_3");
			precachestring(&"PAYBACK_INTROSCREEN_LINE_4");
			precachestring(&"PAYBACK_INTROSCREEN_LINE_5");
			introscreen_delay();
			break;

		case "example":
			break;

		case "hamburg":
			precachestring(&"TANKCOMMANDER_INTROSCREEN_LINE_1");
			precachestring(&"TANKCOMMANDER_INTROSCREEN_LINE_2");
			precachestring(&"TANKCOMMANDER_INTROSCREEN_LINE_3");
			precachestring(&"TANKCOMMANDER_INTROSCREEN_LINE_4");
			introscreen_delay();
			break;

		case "rescue_2":
			precachestring(&"RESCUE_2_INTROSCREEN_LINE_1");
			precachestring(&"RESCUE_2_INTROSCREEN_LINE_2");
			precachestring(&"RESCUE_2_INTROSCREEN_LINE_3");
			precachestring(&"RESCUE_2_INTROSCREEN_LINE_4");
			introscreen_delay();
			break;

		default:
			wait 0.05;
			level notify("finished final intro screen fadein");
			wait 0.05;
			level notify("starting final intro screen fadeout");
			wait 0.05;
			level notify("controls_active");
			wait 0.05;
			common_scripts\utility::flag_set("introscreen_complete");
			break;
	}
}

//Function Number: 2
introscreen_feed_lines(param_00)
{
	var_01 = getarraykeys(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		var_04 = 1;
		var_05 = var_02 * var_04 + 1;
		maps\_utility::delaythread(var_05,::introscreen_corner_line,param_00[var_03],param_00.size - var_02 - 1,var_04,var_03);
	}
}

//Function Number: 3
introscreen_generic_black_fade_in(param_00,param_01,param_02)
{
	introscreen_generic_fade_in("black",param_00,param_01,param_02);
}

//Function Number: 4
introscreen_generic_white_fade_in(param_00,param_01,param_02)
{
	introscreen_generic_fade_in("white",param_00,param_01,param_02);
}

//Function Number: 5
introscreen_generic_fade_in(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1.5;
	}

	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 0;
	var_04.horzalign = "fullscreen";
	var_04.vertalign = "fullscreen";
	var_04.foreground = 1;
	var_04 setshader(param_00,640,480);
	if(isdefined(param_03) && param_03 > 0)
	{
		var_04.alpha = 0;
		var_04 fadeovertime(param_03);
		var_04.alpha = 1;
		wait param_03;
	}

	wait param_01;
	if(param_02 > 0)
	{
		var_04 fadeovertime(param_02);
	}

	var_04.alpha = 0;
	wait param_02;
	setsaveddvar("com_cinematicEndInWhite",0);
}

//Function Number: 6
introscreen_create_line(param_00)
{
	var_01 = level.introstring.size;
	var_02 = var_01 * 30;
	if(level.console)
	{
		var_02 = var_02 - 60;
	}

	level.introstring[var_01] = newhudelem();
	level.introstring[var_01].x = 0;
	level.introstring[var_01].y = var_02;
	level.introstring[var_01].alignx = "center";
	level.introstring[var_01].aligny = "middle";
	level.introstring[var_01].horzalign = "center";
	level.introstring[var_01].vertalign = "middle";
	level.introstring[var_01].sort = 1;
	level.introstring[var_01].foreground = 1;
	level.introstring[var_01].fontscale = 1.75;
	level.introstring[var_01] settext(param_00);
	level.introstring[var_01].alpha = 0;
	level.introstring[var_01] fadeovertime(1.2);
	level.introstring[var_01].alpha = 1;
}

//Function Number: 7
introscreen_fadeouttext()
{
	for(var_00 = 0;var_00 < level.introstring.size;var_00++)
	{
		level.introstring[var_00] fadeovertime(1.5);
		level.introstring[var_00].alpha = 0;
	}

	wait 1.5;
	for(var_00 = 0;var_00 < level.introstring.size;var_00++)
	{
		level.introstring[var_00] destroy();
	}
}

//Function Number: 8
introscreen_delay(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	waittillframeend;
	waittillframeend;
	if(slamzoom_intro())
	{
		return;
	}

	if(introscreen_old_maps())
	{
		return;
	}

	switch(get_introscreen_levelname())
	{
		case "london":
			london_intro();
			break;

		case "castle":
			castle_intro();
			break;

		case "prague":
			prague_intro();
			break;

		case "prague_escape":
			prague_escape_intro();
			break;

		case "payback":
			payback_intro();
			break;

		case "rescue_2":
			rescue_2_intro();
			break;

		case "hamburg":
			hamburg_intro();
			break;
	}

	level.introblack = newhudelem();
	level.introblack.x = 0;
	level.introblack.y = 0;
	level.introblack.horzalign = "fullscreen";
	level.introblack.vertalign = "fullscreen";
	level.introblack.foreground = 1;
	level.introblack setshader("black",640,480);
	level.player freezecontrols(1);
	wait 0.05;
	level.introstring = [];
	if(isdefined(param_00))
	{
		introscreen_create_line(param_00);
	}

	if(isdefined(param_04))
	{
		wait param_04;
	}
	else
	{
		wait 2;
	}

	if(isdefined(param_01))
	{
		introscreen_create_line(param_01);
	}

	if(isdefined(param_02))
	{
		introscreen_create_line(param_02);
	}

	if(isdefined(param_03))
	{
		if(isdefined(param_05))
		{
			wait param_05;
		}
		else
		{
			wait 2;
		}
	}

	if(isdefined(param_03))
	{
		introscreen_create_line(param_03);
	}

	level notify("finished final intro screen fadein");
	if(isdefined(param_06))
	{
		wait param_06;
	}
	else
	{
		wait 3;
	}

	level.introblack fadeovertime(1.5);
	level.introblack.alpha = 0;
	level notify("starting final intro screen fadeout");
	level.player freezecontrols(0);
	level notify("controls_active");
	introscreen_fadeouttext();
	common_scripts\utility::flag_set("introscreen_complete");
}

//Function Number: 9
_cornerlinethread(param_00,param_01,param_02,param_03)
{
	level notify("new_introscreen_element");
	if(!isdefined(level.intro_offset))
	{
		level.intro_offset = 0;
	}
	else
	{
		level.intro_offset++;
	}

	var_04 = _cornerlinethread_height();
	var_05 = newhudelem();
	var_05.x = 20;
	var_05.y = var_04;
	var_05.alignx = "left";
	var_05.aligny = "bottom";
	var_05.horzalign = "left";
	var_05.vertalign = "bottom";
	var_05.sort = 1;
	var_05.foreground = 1;
	var_05 settext(param_00);
	var_05.alpha = 0;
	var_05 fadeovertime(0.2);
	var_05.alpha = 1;
	var_05.hidewheninmenu = 1;
	var_05.fontscale = 2;
	var_05.color = (0.8,1,0.8);
	var_05.font = "objective";
	var_05.glowcolor = (0.3,0.6,0.3);
	var_05.glowalpha = 1;
	var_06 = int(param_01 * param_02 * 1000 + 4000);
	var_05 setpulsefx(30,var_06,700);
	thread hudelem_destroy(var_05);
	if(!isdefined(param_03))
	{
		return;
	}

	if(!isstring(param_03))
	{
		return;
	}

	if(param_03 != "date")
	{
	}
}

//Function Number: 10
_cornerlinethread_height()
{
	return level.intro_offset * 20 - 82;
}

//Function Number: 11
introscreen_corner_line(param_00,param_01,param_02,param_03)
{
	thread _cornerlinethread(param_00,param_01,param_02,param_03);
}

//Function Number: 12
hudelem_destroy(param_00)
{
	wait level.linefeed_delay;
	param_00 notify("destroying");
	level.intro_offset = undefined;
	var_01 = 0.5;
	param_00 fadeovertime(var_01);
	param_00.alpha = 0;
	wait var_01;
	param_00 notify("destroy");
	param_00 destroy();
}

//Function Number: 13
castle_intro()
{
	level.player freezecontrols(1);
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	thread introscreen_generic_black_fade_in(5);
	var_00 = [];
	introscreen_feed_lines(var_7B);
	wait 5;
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 14
london_intro()
{
	level.player freezecontrols(1);
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	thread introscreen_generic_black_fade_in(5);
	var_00 = [];
	introscreen_feed_lines(var_7B);
	wait 5;
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 15
hamburg_intro()
{
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	thread introscreen_generic_black_fade_in(3.5);
	var_00 = [];
	introscreen_feed_lines(var_7B);
	wait 3;
	common_scripts\utility::flag_set("introscreen_complete");
}

//Function Number: 16
prague_intro()
{
	level.player freezecontrols(1);
	common_scripts\utility::flag_wait("fade_up");
	thread introscreen_generic_black_fade_in(4,5);
	var_00 = [];
	level.player common_scripts\utility::delaycall(4,::freezecontrols,0);
	common_scripts\utility::flag_wait("city_reveal");
	maps\_utility::delaythread(9.25,::introscreen_feed_lines,var_7B);
}

//Function Number: 17
prague_escape_intro()
{
	level.player freezecontrols(1);
	thread introscreen_generic_black_fade_in(8,0.5);
	var_00 = [];
	introscreen_feed_lines(var_7B);
	wait 8;
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 18
payback_intro()
{
	level.player freezecontrols(1);
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	level notify("introscreen_prime_audio");
	level notify("introscreen_fade_start");
	wait 2;
	level.player freezecontrols(0);
	var_00 = 9;
	var_01 = 30;
	var_02 = 10;
	level.hudtimestamp = var_00 * 60 * 60 + var_01 * 60 + var_02;
	level.hudtimestampstarttime = gettime();
	var_03 = [];
	introscreen_feed_lines(var_7B);
	wait 2;
}

//Function Number: 19
feedline_delay()
{
	wait 2;
}

//Function Number: 20
slamzoom_intro()
{
	var_00 = [];
	if(!getdvarint("newintro"))
	{
	}

	var_01 = isdefined(level.customintroangles);
	if(!isdefined(var_7B[get_introscreen_levelname()]))
	{
		return 0;
	}

	if(!isdefined(level.dontrevivehud))
	{
		thread revive_ammo_counter();
	}

	thread hide_hud();
	thread weapon_pullout();
	level.player freezecontrols(1);
	var_02 = ::feedline_delay;
	var_03 = 16000;
	var_04 = 1;
	var_05 = 0;
	var_06 = 0;
	if(var_04)
	{
		var_07 = [];
		switch(get_introscreen_levelname())
		{
			case "london":
				cinematicingamesync("estate_fade");
				var_07 = [];
				var_03 = 4000;
				setsaveddvar("sm_sunSampleSizeNear",0.6);
				maps\_utility::delaythread(0.5,::ramp_out_sunsample_over_time,0.9);
				break;
	var_7B[var_07.size]
	&"LONDON_INTROSCREEN_LINE_4"
	var_7B[var_07.size]
	&"LONDON_INTROSCREEN_LINE_3"
	var_7B[var_07.size]
	&"LONDON_INTROSCREEN_LINE_2"
	var_7B[var_07.size]
	&"LONDON_INTROSCREEN_LINE_1"
				break;
		}

		maps\_utility::add_func(var_02);
		maps\_utility::add_func(::introscreen_feed_lines,var_07);
		thread maps\_utility::do_funcs();
	}

	var_08 = level.player.origin;
	level.player playersetstreamorigin(var_08);
	level.player.origin = var_08 + (0,0,var_03);
	var_09 = spawn("script_model",(69,69,69));
	var_09.origin = level.player.origin;
	var_09 setmodel("tag_origin");
	if(var_01)
	{
		var_09.angles = (0,level.customintroangles[1],0);
	}
	else
	{
		var_09.angles = level.player.angles;
	}

	level.player playerlinkto(var_09,undefined,1,0,0,0,0);
	var_09.angles = (var_09.angles[0] + 89,var_09.angles[1],0);
	wait var_05;
	var_09 moveto(var_08 + (0,0,0),2,0,2);
	wait 1;
	wait 0.5;
	if(var_01)
	{
		var_09 rotateto(level.customintroangles,0.5,0.3,0.2);
	}
	else
	{
		var_09 rotateto((var_09.angles[0] - 89,var_09.angles[1],0),0.5,0.3,0.2);
	}

	if(!var_06)
	{
		savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	}

	wait 0.5;
	common_scripts\utility::flag_set("pullup_weapon");
	wait 0.2;
	level.player unlink();
	level.player freezecontrols(0);
	level.player playerclearstreamorigin();
	thread common_scripts\utility::play_sound_in_space("ui_screen_trans_in",level.player.origin);
	wait 0.2;
	thread common_scripts\utility::play_sound_in_space("ui_screen_trans_out",level.player.origin);
	wait 0.2;
	common_scripts\utility::flag_set("introscreen_complete");
	wait 2;
	var_09 delete();
	return 1;
}

//Function Number: 21
hide_hud()
{
	wait 0.05;
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide","1");
	setsaveddvar("hud_showstance","0");
	setsaveddvar("actionSlotsHide","1");
}

//Function Number: 22
weapon_pullout()
{
	var_00 = level.player getweaponslistall()[0];
	level.player disableweapons();
	common_scripts\utility::flag_wait("pullup_weapon");
	level.player enableweapons();
}

//Function Number: 23
revive_ammo_counter()
{
	common_scripts\utility::flag_wait("safe_for_objectives");
	if(!isdefined(level.nocompass))
	{
		setsaveddvar("compass",1);
	}

	setsaveddvar("ammoCounterHide","0");
	setsaveddvar("actionSlotsHide","0");
	setsaveddvar("hud_showstance","1");
}

//Function Number: 24
ramp_out_sunsample_over_time(param_00,param_01)
{
	var_02 = getdvarfloat("sm_sunSampleSizeNear");
	if(!isdefined(param_01))
	{
		param_01 = 0.25;
	}

	var_03 = var_02 - param_01;
	var_04 = param_00 * 20;
	for(var_05 = 0;var_05 <= var_04;var_05++)
	{
		var_06 = var_05 / var_04;
		var_06 = 1 - var_06;
		var_07 = var_06 * var_03;
		var_08 = param_01 + var_07;
		setsaveddvar("sm_sunSampleSizeNear",var_08);
		wait 0.05;
	}
}

//Function Number: 25
get_introscreen_levelname()
{
	if(isdefined(level.introscreen_levelname))
	{
		return level.introscreen_levelname;
	}

	return level.script;
}

//Function Number: 26
main_old_maps()
{
	switch(get_introscreen_levelname())
	{
		case "dcburning":
			precachestring(&"DCBURNING_INTROSCREEN_1");
			precachestring(&"DCBURNING_INTROSCREEN_2");
			precachestring(&"DCBURNING_INTROSCREEN_3");
			precachestring(&"DCBURNING_INTROSCREEN_4");
			precachestring(&"DCBURNING_INTROSCREEN_5");
			introscreen_delay();
			break;
	}
}

//Function Number: 27
cliffhanger_intro_text()
{
	wait 17;
	var_00 = [];
	introscreen_feed_lines(var_7B);
}

//Function Number: 28
dcburning_intro()
{
	level.player disableweapons();
	thread dcburningintrodvars();
	level.mortar_min_dist = 1;
	level.player freezecontrols(1);
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.foreground = 1;
	var_00 setshader("black",640,480);
	wait 4.25;
	wait 3;
	level notify("black_fading");
	level.mortar_min_dist = undefined;
	var_00 fadeovertime(1.5);
	var_00.alpha = 0;
	wait 1.5;
	common_scripts\utility::flag_set("introscreen_complete");
	level notify("introscreen_complete");
	level.player freezecontrols(0);
	level.player enableweapons();
	wait 0.5;
	setsaveddvar("compass",1);
	setsaveddvar("ammoCounterHide","0");
	setsaveddvar("hud_showStance",1);
	common_scripts\utility::flag_wait("player_exiting_start_trench");
	var_01 = [];
	introscreen_feed_lines(var_7B);
}

//Function Number: 29
dcburningintrodvars()
{
	wait 0.05;
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide","1");
	setsaveddvar("hud_showStance",0);
}

//Function Number: 30
rescue_2_intro()
{
	var_00 = [];
	thread introscreen_generic_black_fade_in(5.4,8);
	introscreen_feed_lines(var_7B);
}

//Function Number: 31
introscreen_old_maps()
{
	switch(get_introscreen_levelname())
	{
		case "dcburning":
			dcburning_intro();
			return 1;
	}

	return 0;
}