/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_introscreen.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 729 ms
 * Timestamp: 10/27/2023 2:48:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.credits_active))
	{
		return 0;
	}

	introscreen_init();
	if(!introscreen_should_activate())
	{
		simple_intro();
		return;
	}

	initialize_strings();
	activate_intro();
}

//Function Number: 2
introscreen_init()
{
	common_scripts\utility::flag_init("pullup_weapon");
	common_scripts\utility::flag_init("introscreen_activate");
	common_scripts\utility::flag_init("introscreen_remove_submix");
	common_scripts\utility::flag_init("introscreen_complete");
	common_scripts\utility::flag_init("safe_for_objectives");
	maps\_utility::delaythread(10,::common_scripts\utility::flag_set,"safe_for_objectives");
	level.linefeed_delay = 16;
	level.background_sort = 1000;
	level.intro_text_sort = 1001;
	precacheshader("black");
	precacheshader("white");
	if(getdvar("introscreen") == "")
	{
		setdvar("introscreen","1");
	}

	waittillframeend;
	waittillframeend;
}

//Function Number: 3
introscreen_should_activate()
{
	if(!introscreen_is_enabled())
	{
		return 0;
	}

	if(!maps\_utility::is_h1_level())
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
introscreen_is_enabled()
{
	if(getdvar("beautiful_corner") == "1")
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
activate_intro()
{
	if(should_revive_ammo_counter())
	{
		thread revive_ammo_counter();
	}

	common_scripts\utility::flag_set("introscreen_activate");
	switch(level.script)
	{
		case "ac130":
			break;

		case "aftermath":
			break;

		case "airlift":
			break;

		case "ambush":
			break;

		case "armada":
			break;

		case "cargoship":
			break;

		case "hunted":
			break;

		case "jeepride":
			break;

		case "launchfacility_b":
			break;

		case "scoutsniper":
			break;

		case "village_defend":
			break;

		case "village_assault":
		case "launchfacility_a":
		case "killhouse":
		case "icbm":
		case "bog_b":
		case "bog_a":
		case "blackout":
			break;

		case "simplecredits":
		case "sniperescape":
		case "coup":
		case "airplane":
			break;
	}
}

//Function Number: 6
simple_intro()
{
	waittillframeend;
	waittillframeend;
	waittillframeend;
	waittillframeend;
	common_scripts\utility::flag_set("introscreen_remove_submix");
	common_scripts\utility::flag_set("introscreen_complete");
}

//Function Number: 7
flying_intro_dvars()
{
	wait(0.05);
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide",1);
	setsaveddvar("hud_showstance",0);
	setsaveddvar("actionSlotsHide",1);
}

//Function Number: 8
flying_intro()
{
	thread flying_intro_dvars();
	thread weapon_pullout();
	level.player freezecontrols(1);
	var_00 = 16000;
	var_01 = 1;
	var_02 = 0;
	var_03 = 0;
	if(var_01)
	{
		switch(level.script)
		{
			case "bog_a":
				break;

			case "bog_b":
				break;

			case "blackout":
				break;

			case "killhouse":
				break;

			case "icbm":
				break;

			case "launchfacility_a":
				break;

			case "village_assault":
				break;
		}
	}
}

//Function Number: 9
flying_intro_force_streaming_center(param_00)
{
	self endon("introscreen_complete");
	for(;;)
	{
		level.player method_8237(param_00);
		wait(0.01);
	}
}

//Function Number: 10
cargoship_intro_dvars()
{
	wait(0.05);
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide","1");
	setsaveddvar("hud_showStance",0);
	setsaveddvar("hud_drawhud","0");
}

//Function Number: 11
cargoship_intro()
{
	thread cargoship_intro_dvars();
	level.player freezecontrols(1);
	cinematicingamesync("cargoship_fade");
	wait(0.4);
	level notify("intro_movie_done");
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	common_scripts\utility::flag_set("introscreen_remove_submix");
	introscreen_generic_white_fade_in(1.75);
	introscreen_feed_lines(level.introscreen_lines);
	wait(1);
	level.player freezecontrols(0);
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 12
jeepride_intro()
{
	level.player freezecontrols(1);
	cinematicingamesync("jeepride_fade");
	introscreen_feed_lines(level.introscreen_lines);
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 13
airlift_intro_dvars()
{
	wait(0.05);
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide","1");
}

//Function Number: 14
airlift_intro()
{
	thread airlift_intro_dvars();
	level.player freezecontrols(1);
	cinematicingamesync("airlift_fade");
	introscreen_feed_lines(level.introscreen_lines);
	wait(2);
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	level notify("introscreen_black");
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.foreground = 1;
	var_00.sort = level.background_sort;
	var_00 setshader("white",640,480);
	wait(1);
	var_00 fadeovertime(1.5);
	var_00.alpha = 0;
	common_scripts\utility::flag_set("introscreen_remove_submix");
	wait(1);
	common_scripts\utility::flag_set("introscreen_complete");
	thread maps\_utility::autosave_now(1);
	level.player freezecontrols(0);
}

//Function Number: 15
village_defend_intro_dvars()
{
	wait(0.05);
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide","1");
}

//Function Number: 16
village_defend_intro()
{
	thread village_defend_intro_dvars();
	level.player freezecontrols(1);
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.foreground = 1;
	var_00.sort = level.background_sort;
	var_00 setshader("black",640,480);
	wait(0.25);
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.alignx = "center";
	var_01.aligny = "middle";
	var_01.horzalign = "center";
	var_01.vertalign = "middle";
	var_01.sort = level.intro_text_sort;
	var_01.foreground = 1;
	var_01 settext(&"VILLAGE_DEFEND_PRESENT_DAY");
	var_01.fontscale = 1.6;
	var_01.color = (0.8,1,0.8);
	var_01.font = "objective";
	var_01.glowcolor = (0.26,0.65,0.32);
	var_01.glowalpha = 0.2;
	var_01 setpulsefx(30,8000,700);
	wait(8.8);
	introscreen_feed_lines(level.introscreen_lines);
	wait(10);
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	common_scripts\utility::flag_set("introscreen_remove_submix");
	var_00 fadeovertime(1.5);
	var_00.alpha = 0;
	wait(1);
	level.player freezecontrols(0);
	setsaveddvar("compass",1);
	setsaveddvar("ammoCounterHide","0");
	setsaveddvar("hud_showStance",1);
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 17
scoutsniper_intro()
{
	thread scoutsniperintrodvars();
	thread scoutsniperintroplayer();
	cinematicingamesync("scoutsniper_fade");
	wait(4);
	maps\_utility::set_vision_set("grayscale");
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.foreground = 1;
	var_00.sort = level.background_sort;
	var_00 setshader("black",640,480);
	wait(0.25);
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.alignx = "center";
	var_01.aligny = "middle";
	var_01.horzalign = "center";
	var_01.vertalign = "middle";
	var_01.sort = level.intro_text_sort;
	var_01.foreground = 1;
	var_01 settext(&"SCOUTSNIPER_15_YEARS_AGO");
	var_01.fontscale = 1.6;
	var_01.color = (0.8,1,0.8);
	var_01.font = "objective";
	var_01.glowcolor = (0.26,0.65,0.32);
	var_01.glowalpha = 0.2;
	var_01 setpulsefx(30,2000,700);
	wait(2);
	introscreen_feed_lines(level.introscreen_lines);
	wait(1);
	var_00 fadeovertime(1.5);
	var_00.alpha = 0;
	common_scripts\utility::flag_set("introscreen_remove_submix");
	wait(4.5);
	maps\_utility::set_vision_set("scoutsniper_start",1);
	wait(8);
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
	wait(0.5);
	setsaveddvar("compass",1);
	setsaveddvar("ammoCounterHide","0");
	setsaveddvar("hud_showStance",1);
}

//Function Number: 18
scoutsniperintroplayer()
{
	var_00 = level.player getplayerangles();
	wait(1);
	level.player setstance("crouch");
	level.player freezecontrols(1);
	level.player setplayerangles(var_00);
}

//Function Number: 19
scoutsniperintrodvars()
{
	wait(0.05);
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide","1");
	setsaveddvar("hud_showStance",0);
}

//Function Number: 20
ac130_intro()
{
	level.player freezecontrols(1);
	introscreen_feed_lines(level.introscreen_lines);
	level notify("introscreen_black");
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.foreground = 1;
	var_00.sort = level.background_sort;
	var_00 setshader("black",640,480);
	wait(4);
	level notify("introscreen_almost_complete");
	wait(1.5);
	level notify("introscreen_fading_out");
	var_00 fadeovertime(1.5);
	var_00.alpha = 0;
	wait(1);
	level.player freezecontrols(0);
	setsaveddvar("hud_showStance",0);
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 21
aftermath_intro()
{
	cinematicingamesync("black");
	common_scripts\utility::flag_set("introscreen_complete");
}

//Function Number: 22
hunted_intro_dvars()
{
	wait(0.05);
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide","1");
}

//Function Number: 23
hunted_intro()
{
	thread hunted_intro_dvars();
	level.player freezecontrols(1);
	introscreen_feed_lines(level.introscreen_lines);
	cinematicingamesync("hunted_fade");
	wait(1);
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	common_scripts\utility::flag_set("introscreen_remove_submix");
	introscreen_generic_white_fade_in(2);
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	wait(1);
	level.player freezecontrols(0);
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 24
launchfacility_b_intro_dvars()
{
	wait(0.05);
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide","1");
	setsaveddvar("actionSlotsHide","1");
	setsaveddvar("hud_showstance","0");
	thread revive_ammo_counter();
}

//Function Number: 25
launchfacility_b_intro()
{
	thread launchfacility_b_intro_dvars();
	level.player freezecontrols(1);
	introscreen_feed_lines(level.introscreen_lines);
	introscreen_generic_white_fade_in(1);
	common_scripts\utility::flag_set("introscreen_remove_submix");
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	wait(1);
	level.player freezecontrols(0);
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 26
ambush_intro_dvars()
{
	wait(0.05);
	setsaveddvar("compass",0);
	setsaveddvar("ammoCounterHide","1");
}

//Function Number: 27
ambush_intro()
{
	thread ambush_intro_dvars();
	level.player freezecontrols(1);
	introscreen_feed_lines(level.introscreen_lines);
	cinematicingamesync("ambush_fade");
	wait(2);
	savegame("levelstart",&"AUTOSAVE_LEVELSTART","whatever",1);
	introscreen_generic_white_fade_in(2);
	common_scripts\utility::flag_set("introscreen_remove_submix");
	thread maps\_utility::autosave_now(1);
	setsaveddvar("compass",1);
	setsaveddvar("ammoCounterHide","0");
	setsaveddvar("hud_showStance",1);
	wait(1);
	level.player freezecontrols(0);
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 28
armada_intro()
{
	setsaveddvar("hud_drawhud","0");
	level.player disableweapons();
	introscreen_generic_black_fade_in(0.2,0.2);
	introscreen_feed_lines(level.introscreen_lines);
	wait(3);
	level.player freezecontrols(0);
	wait(2);
	common_scripts\utility::flag_set("introscreen_complete");
	wait(2);
	maps\_utility::autosave_by_name("levelstart");
	wait(4);
	level.player enableweapons();
}

//Function Number: 29
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

//Function Number: 30
introscreen_generic_black_fade_in(param_00,param_01)
{
	introscreen_generic_fade_in("black",param_00,param_01);
}

//Function Number: 31
introscreen_generic_white_fade_in(param_00,param_01)
{
	introscreen_generic_fade_in("white",param_00,param_01);
}

//Function Number: 32
introscreen_generic_fade_in(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1.5;
	}

	var_03 = newhudelem();
	var_03.x = 0;
	var_03.y = 0;
	var_03.horzalign = "fullscreen";
	var_03.vertalign = "fullscreen";
	var_03.foreground = 1;
	var_03.sort = level.background_sort;
	var_03 setshader(param_00,640,480);
	wait(param_01);
	var_03 fadeovertime(1.5);
	var_03.alpha = 0;
}

//Function Number: 33
introscreen_create_line(param_00)
{
	var_01 = level.introstring.size;
	var_02 = var_01 * 30;
	if(level.console)
	{
		var_02 = var_02 - 60;
	}

	var_03 = newhudelem();
	var_03.x = 0;
	var_03.y = var_02;
	var_03.alignx = "center";
	var_03.aligny = "middle";
	var_03.horzalign = "center";
	var_03.vertalign = "middle";
	var_03.sort = level.intro_text_sort;
	var_03.foreground = 1;
	var_03.fontscale = 1.75;
	var_03 settext(param_00);
	var_03.alpha = 0;
	var_03 fadeovertime(1.2);
	var_03.alpha = 1;
	common_scripts\utility::array_insert(level.introstring,var_03,0);
}

//Function Number: 34
introscreen_fadeouttext()
{
	for(var_00 = 0;var_00 < level.introstring.size;var_00++)
	{
		level.introstring[var_00] fadeovertime(1.5);
		level.introstring[var_00].alpha = 0;
	}

	wait(1.5);
	for(var_00 = 0;var_00 < level.introstring.size;var_00++)
	{
		level.introstring[var_00] destroy();
	}
}

//Function Number: 35
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
	var_05.x = 30.7;
	var_05.y = var_04 - 8.7;
	var_05.alignx = "left";
	var_05.aligny = "bottom";
	var_05.horzalign = "left_adjustable";
	var_05.vertalign = "bottom_adjustable";
	var_05.sort = level.intro_text_sort;
	var_05.foreground = 1;
	var_05 settext(param_00);
	var_05.alpha = 0;
	var_05 fadeovertime(0.2);
	var_05.alpha = 1;
	var_05.hidewheninmenu = 1;
	var_05.fontscale = 1.25;
	var_05.color = (0.8,1,0.8);
	var_05.font = "objective";
	var_05.glowcolor = (0.26,0.65,0.32);
	var_05.glowalpha = 0.2;
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

//Function Number: 36
_cornerlinethread_height()
{
	return level.intro_offset * 18 - 82;
}

//Function Number: 37
introscreen_corner_line(param_00,param_01,param_02,param_03)
{
	thread _cornerlinethread(param_00,param_01,param_02,param_03);
}

//Function Number: 38
hudelem_destroy(param_00)
{
	wait(level.linefeed_delay);
	param_00 notify("destroying");
	level.intro_offset = undefined;
	var_01 = 0.5;
	param_00 fadeovertime(var_01);
	param_00.alpha = 0;
	wait(var_01);
	param_00 notify("destroy");
	param_00 destroy();
}

//Function Number: 39
weapon_pullout()
{
	var_00 = level.player getweaponslistall()[0];
	level.player disableweapons();
	common_scripts\utility::flag_wait("pullup_weapon");
	level.player enableweapons();
}

//Function Number: 40
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

//Function Number: 41
introscreen_add_line(param_00)
{
	if(!isdefined(level.introscreen_lines))
	{
		level.introscreen_lines = [];
	}

	precachestring(param_00);
	level.introscreen_lines[level.introscreen_lines.size] = param_00;
}

//Function Number: 42
should_revive_ammo_counter()
{
	switch(level.script)
	{
		case "simplecredits":
		case "sniperescape":
		case "coup":
		case "airplane":
		case "aftermath":
		case "ac130":
		case "airlift":
			break;
	}
}

//Function Number: 43
initialize_strings()
{
	switch(level.script)
	{
		case "ac130":
			break;

		case "airlift":
			break;

		case "ambush":
			break;

		case "armada":
			break;

		case "blackout":
			break;

		case "bog_a":
			break;

		case "bog_b":
			break;

		case "cargoship":
			break;

		case "hunted":
			break;

		case "icbm":
			break;

		case "jeepride":
			break;

		case "killhouse":
			break;

		case "launchfacility_a":
			break;

		case "launchfacility_b":
			break;

		case "scoutsniper":
			break;

		case "village_assault":
			break;

		case "village_defend":
			break;
	}
}