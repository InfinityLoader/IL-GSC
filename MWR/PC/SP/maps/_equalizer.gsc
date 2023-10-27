/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_equalizer.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 380 ms
 * Timestamp: 10/27/2023 2:45:48 AM
*******************************************************************/

//Function Number: 1
loadpresets()
{
	level.eq_defs = [];
	level.ambient_reverb = [];
	generic_eq();
	old_iw4_eq();
	generic_filters();
	old_iw4_filters();
}

//Function Number: 2
generic_eq()
{
	define_reverb("deathsdoor");
	set_reverb_roomtype("deathsdoor","underwater");
	set_reverb_drylevel("deathsdoor",0.5);
	set_reverb_wetlevel("deathsdoor",0.4);
	set_reverb_fadetime("deathsdoor",2);
	set_reverb_priority("deathsdoor","snd_enveffectsprio_level");
	define_reverb("alley");
	set_reverb_roomtype("alley","alley");
	set_reverb_drylevel("alley",0.9);
	set_reverb_wetlevel("alley",0.1);
	set_reverb_fadetime("alley",2);
	set_reverb_priority("alley","snd_enveffectsprio_level");
	define_reverb("bunker");
	set_reverb_roomtype("bunker","stoneroom");
	set_reverb_drylevel("bunker",0.8);
	set_reverb_wetlevel("bunker",0.4);
	set_reverb_fadetime("bunker",2);
	set_reverb_priority("bunker","snd_enveffectsprio_level");
	define_reverb("city");
	set_reverb_roomtype("city","city");
	set_reverb_drylevel("city",0.8);
	set_reverb_wetlevel("city",0.3);
	set_reverb_fadetime("city",2);
	set_reverb_priority("city","snd_enveffectsprio_level");
	define_reverb("container");
	set_reverb_roomtype("container","sewerpipe");
	set_reverb_drylevel("container",0.9);
	set_reverb_wetlevel("container",0.4);
	set_reverb_fadetime("container",2);
	set_reverb_priority("container","snd_enveffectsprio_level");
	define_reverb("exterior");
	set_reverb_roomtype("exterior","city");
	set_reverb_drylevel("exterior",0.9);
	set_reverb_wetlevel("exterior",0.15);
	set_reverb_fadetime("exterior",6);
	set_reverb_priority("exterior","snd_enveffectsprio_level");
	define_reverb("exterior1");
	set_reverb_roomtype("exterior1","alley");
	set_reverb_drylevel("exterior1",0.9);
	set_reverb_wetlevel("exterior1",0.2);
	set_reverb_fadetime("exterior1",2);
	set_reverb_priority("exterior1","snd_enveffectsprio_level");
	define_reverb("exterior2");
	set_reverb_roomtype("exterior2","alley");
	set_reverb_drylevel("exterior2",0.9);
	set_reverb_wetlevel("exterior2",0.2);
	set_reverb_fadetime("exterior2",2);
	set_reverb_priority("exterior2","snd_enveffectsprio_level");
	define_reverb("exterior3");
	set_reverb_roomtype("exterior3","alley");
	set_reverb_drylevel("exterior3",0.9);
	set_reverb_wetlevel("exterior3",0.2);
	set_reverb_fadetime("exterior3",2);
	set_reverb_priority("exterior3","snd_enveffectsprio_level");
	define_reverb("exterior4");
	set_reverb_roomtype("exterior4","alley");
	set_reverb_drylevel("exterior4",0.9);
	set_reverb_wetlevel("exterior4",0.2);
	set_reverb_fadetime("exterior4",2);
	set_reverb_priority("exterior4","snd_enveffectsprio_level");
	define_reverb("exterior5");
	set_reverb_roomtype("exterior5","alley");
	set_reverb_drylevel("exterior5",0.9);
	set_reverb_wetlevel("exterior5",0.2);
	set_reverb_fadetime("exterior5",2);
	set_reverb_priority("exterior5","snd_enveffectsprio_level");
	define_reverb("forrest");
	set_reverb_roomtype("forrest","forest");
	set_reverb_drylevel("forrest",0.9);
	set_reverb_wetlevel("forrest",0.1);
	set_reverb_fadetime("forrest",2);
	set_reverb_priority("forrest","snd_enveffectsprio_level");
	define_reverb("hangar");
	set_reverb_roomtype("hangar","hangar");
	set_reverb_drylevel("hangar",0.8);
	set_reverb_wetlevel("hangar",0.3);
	set_reverb_fadetime("hangar",4);
	set_reverb_priority("hangar","snd_enveffectsprio_level");
	define_reverb("interior");
	set_reverb_roomtype("interior","stonecorridor");
	set_reverb_drylevel("interior",0.9);
	set_reverb_wetlevel("interior",0.3);
	set_reverb_fadetime("interior",2);
	set_reverb_priority("interior","snd_enveffectsprio_level");
	define_reverb("interior_metal");
	set_reverb_roomtype("interior_metal","sewerpipe");
	set_reverb_drylevel("interior_metal",0.8);
	set_reverb_wetlevel("interior_metal",0.3);
	set_reverb_fadetime("interior_metal",2);
	set_reverb_priority("interior_metal","snd_enveffectsprio_level");
	define_reverb("interior_stone");
	set_reverb_roomtype("interior_stone","stoneroom");
	set_reverb_drylevel("interior_stone",0.9);
	set_reverb_wetlevel("interior_stone",0.2);
	set_reverb_fadetime("interior_stone",2);
	set_reverb_priority("interior_stone","snd_enveffectsprio_level");
	define_reverb("interior_vehicle");
	set_reverb_roomtype("interior_vehicle","carpetedhallway");
	set_reverb_drylevel("interior_vehicle",0.9);
	set_reverb_wetlevel("interior_vehicle",0.1);
	set_reverb_fadetime("interior_vehicle",2);
	set_reverb_priority("interior_vehicle","snd_enveffectsprio_level");
	define_reverb("interior_wood");
	set_reverb_roomtype("interior_wood","livingroom");
	set_reverb_drylevel("interior_wood",0.9);
	set_reverb_wetlevel("interior_wood",0.2);
	set_reverb_fadetime("interior_wood",2);
	set_reverb_priority("interior_wood","snd_enveffectsprio_level");
	define_reverb("invasion_ext1");
	set_reverb_roomtype("invasion_ext1","parkinglot");
	set_reverb_drylevel("invasion_ext1",0.9);
	set_reverb_wetlevel("invasion_ext1",0.2);
	set_reverb_fadetime("invasion_ext1",3);
	set_reverb_priority("invasion_ext1","snd_enveffectsprio_level");
	define_reverb("invasion_ext3");
	set_reverb_roomtype("invasion_ext3","parkinglot");
	set_reverb_drylevel("invasion_ext3",0.9);
	set_reverb_wetlevel("invasion_ext3",0.2);
	set_reverb_fadetime("invasion_ext3",3);
	set_reverb_priority("invasion_ext3","snd_enveffectsprio_level");
	define_reverb("mountains");
	set_reverb_roomtype("mountains","mountains");
	set_reverb_drylevel("mountains",0.8);
	set_reverb_wetlevel("mountains",0.3);
	set_reverb_fadetime("mountains",2);
	set_reverb_priority("mountains","snd_enveffectsprio_level");
	define_reverb("pipe");
	set_reverb_roomtype("pipe","sewerpipe");
	set_reverb_drylevel("pipe",0.9);
	set_reverb_wetlevel("pipe",0.4);
	set_reverb_fadetime("pipe",2);
	set_reverb_priority("pipe","snd_enveffectsprio_level");
	define_reverb("shanty");
	set_reverb_roomtype("shanty","livingroom");
	set_reverb_drylevel("shanty",0.9);
	set_reverb_wetlevel("shanty",0.1);
	set_reverb_fadetime("shanty",2);
	set_reverb_priority("shanty","snd_enveffectsprio_level");
	define_reverb("snow_base");
	set_reverb_roomtype("snow_base","mountains");
	set_reverb_drylevel("snow_base",0.8);
	set_reverb_wetlevel("snow_base",0.3);
	set_reverb_fadetime("snow_base",5);
	set_reverb_priority("snow_base","snd_enveffectsprio_level");
	define_reverb("snow_cliff");
	set_reverb_roomtype("snow_cliff","mountains");
	set_reverb_drylevel("snow_cliff",0.8);
	set_reverb_wetlevel("snow_cliff",0.3);
	set_reverb_fadetime("snow_cliff",5);
	set_reverb_priority("snow_cliff","snd_enveffectsprio_level");
	define_reverb("underpass");
	set_reverb_roomtype("underpass","stonecorridor");
	set_reverb_drylevel("underpass",0.9);
	set_reverb_wetlevel("underpass",0.3);
	set_reverb_fadetime("underpass",2);
	set_reverb_priority("underpass","snd_enveffectsprio_level");
	define_reverb("tunnel");
	set_reverb_roomtype("tunnel","cave");
	set_reverb_drylevel("tunnel",0.85);
	set_reverb_wetlevel("tunnel",0.35);
	set_reverb_fadetime("tunnel",2);
	set_reverb_priority("tunnel","snd_enveffectsprio_level");
}

//Function Number: 3
generic_filters()
{
	define_filter("deathsdoor");
	set_filter_type("deathsdoor",0,"highshelf");
	set_filter_freq("deathsdoor",0,2800);
	set_filter_gain("deathsdoor",0,-12);
	set_filter_q("deathsdoor",0,1);
	set_filter_type("deathsdoor",1,"lowshelf");
	set_filter_freq("deathsdoor",1,1000);
	set_filter_gain("deathsdoor",1,-6);
	set_filter_q("deathsdoor",1,1);
	add_channel_to_filter("deathsdoor","physics");
	add_channel_to_filter("deathsdoor","ambdist1");
	add_channel_to_filter("deathsdoor","ambdist2");
	add_channel_to_filter("deathsdoor","auto");
	add_channel_to_filter("deathsdoor","auto2");
	add_channel_to_filter("deathsdoor","autodog");
	add_channel_to_filter("deathsdoor","explosiveimpact");
	add_channel_to_filter("deathsdoor","element");
	add_channel_to_filter("deathsdoor","vehicle");
	add_channel_to_filter("deathsdoor","vehiclelimited");
	add_channel_to_filter("deathsdoor","body");
	add_channel_to_filter("deathsdoor","reload");
	add_channel_to_filter("deathsdoor","effects1");
	add_channel_to_filter("deathsdoor","effects2");
	add_channel_to_filter("deathsdoor","weapon");
	add_channel_to_filter("deathsdoor","voice");
	define_filter("alley");
	set_filter_type("alley",0,"highshelf");
	set_filter_freq("alley",0,3500);
	set_filter_gain("alley",0,-2);
	set_filter_q("alley",0,1);
	add_channel_to_filter("alley","ambient");
	add_channel_to_filter("alley","element");
	add_channel_to_filter("alley","vehicle");
	add_channel_to_filter("alley","weapon");
	add_channel_to_filter("alley","voice");
	define_filter("bunker");
	set_filter_type("bunker",0,"highshelf");
	set_filter_freq("bunker",0,3500);
	set_filter_gain("bunker",0,-2);
	set_filter_q("bunker",0,1);
	add_channel_to_filter("bunker","ambient");
	add_channel_to_filter("bunker","element");
	add_channel_to_filter("bunker","vehicle");
	add_channel_to_filter("bunker","weapon");
	add_channel_to_filter("bunker","voice");
	define_filter("container");
	set_filter_type("container",0,"highshelf");
	set_filter_freq("container",0,3500);
	set_filter_gain("container",0,-6);
	set_filter_q("container",0,1);
	add_channel_to_filter("container","ambient");
	add_channel_to_filter("container","element");
	add_channel_to_filter("container","vehicle");
	add_channel_to_filter("container","weapon");
	add_channel_to_filter("container","voice");
	define_filter("hangar");
	set_filter_type("hangar",0,"highshelf");
	set_filter_freq("hangar",0,3500);
	set_filter_gain("hangar",0,-9);
	set_filter_q("hangar",0,1);
	add_channel_to_filter("hangar","ambient");
	add_channel_to_filter("hangar","element");
	add_channel_to_filter("hangar","vehicle");
	add_channel_to_filter("hangar","weapon");
	add_channel_to_filter("hangar","voice");
	define_filter("interior_metal");
	set_filter_type("interior_metal",0,"highshelf");
	set_filter_freq("interior_metal",0,3500);
	set_filter_gain("interior_metal",0,-18);
	set_filter_q("interior_metal",0,1);
	add_channel_to_filter("interior_metal","ambient");
	add_channel_to_filter("interior_metal","element");
	add_channel_to_filter("interior_metal","vehicle");
	add_channel_to_filter("interior_metal","weapon");
	add_channel_to_filter("interior_metal","voice");
	define_filter("interior_stone");
	set_filter_type("interior_stone",0,"highshelf");
	set_filter_freq("interior_stone",0,3500);
	set_filter_gain("interior_stone",0,-6);
	set_filter_q("interior_stone",0,1);
	add_channel_to_filter("interior_stone","ambient");
	add_channel_to_filter("interior_stone","element");
	add_channel_to_filter("interior_stone","vehicle");
	add_channel_to_filter("interior_stone","weapon");
	add_channel_to_filter("interior_stone","voice");
	define_filter("interior_vehicle");
	set_filter_type("interior_vehicle",0,"highshelf");
	set_filter_freq("interior_vehicle",0,2700);
	set_filter_gain("interior_vehicle",0,-12);
	set_filter_q("interior_vehicle",0,1);
	add_channel_to_filter("interior_vehicle","ambient");
	add_channel_to_filter("interior_vehicle","auto");
	add_channel_to_filter("interior_vehicle","auto2");
	add_channel_to_filter("interior_vehicle","autodog");
	add_channel_to_filter("interior_vehicle","body");
	add_channel_to_filter("interior_vehicle","element");
	add_channel_to_filter("interior_vehicle","vehicle");
	add_channel_to_filter("interior_vehicle","weapon");
	add_channel_to_filter("interior_vehicle","voice");
	define_filter("interior_wood");
	set_filter_type("interior_wood",0,"highshelf");
	set_filter_freq("interior_wood",0,3500);
	set_filter_gain("interior_wood",0,-6);
	set_filter_q("interior_wood",0,1);
	add_channel_to_filter("interior_wood","ambient");
	add_channel_to_filter("interior_wood","element");
	add_channel_to_filter("interior_wood","vehicle");
	add_channel_to_filter("interior_wood","weapon");
	add_channel_to_filter("interior_wood","voice");
	define_filter("shanty");
	set_filter_type("shanty",0,"highshelf");
	set_filter_freq("shanty",0,3500);
	set_filter_gain("shanty",0,-2);
	set_filter_q("shanty",0,1);
	add_channel_to_filter("shanty","ambient");
	add_channel_to_filter("shanty","element");
	add_channel_to_filter("shanty","vehicle");
	add_channel_to_filter("shanty","weapon");
	add_channel_to_filter("shanty","voice");
	define_filter("pipe");
	set_filter_type("pipe",0,"highshelf");
	set_filter_freq("pipe",0,3500);
	set_filter_gain("pipe",0,-6);
	set_filter_q("pipe",0,1);
	add_channel_to_filter("pipe","ambient");
	add_channel_to_filter("pipe","element");
	add_channel_to_filter("pipe","vehicle");
	add_channel_to_filter("pipe","weapon");
	add_channel_to_filter("pipe","voice");
	define_filter("tunnel");
	set_filter_type("tunnel",0,"highshelf");
	set_filter_freq("tunnel",0,3500);
	set_filter_gain("tunnel",0,-2);
	set_filter_q("tunnel",0,1);
	add_channel_to_filter("tunnel","ambient");
	add_channel_to_filter("tunnel","element");
	add_channel_to_filter("tunnel","vehicle");
	add_channel_to_filter("tunnel","weapon");
	add_channel_to_filter("tunnel","voice");
	define_filter("underpass");
	set_filter_type("underpass",0,"highshelf");
	set_filter_freq("underpass",0,3500);
	set_filter_gain("underpass",0,-2);
	set_filter_q("underpass",0,1);
	add_channel_to_filter("underpass","ambient");
	add_channel_to_filter("underpass","element");
	add_channel_to_filter("underpass","vehicle");
	add_channel_to_filter("underpass","weapon");
	add_channel_to_filter("underpass","voice");
	define_filter("sound_fadeout");
	set_filter_type("sound_fadeout",0,"lowpass");
	set_filter_freq("sound_fadeout",0,0);
	set_filter_gain("sound_fadeout",0,0);
	set_filter_q("sound_fadeout",0,1);
	add_all_channels_to_filter("sound_fadeout");
	define_filter("fadeout_noncritical");
	set_filter_type("fadeout_noncritical",0,"lowpass");
	set_filter_freq("fadeout_noncritical",0,0);
	set_filter_gain("fadeout_noncritical",0,0);
	set_filter_q("fadeout_noncritical",0,1);
	add_all_channels_but_music_and_mission("fadeout_noncritical");
	define_filter("fadeall_but_music");
	set_filter_type("fadeall_but_music",0,"lowpass");
	set_filter_freq("fadeall_but_music",0,0);
	set_filter_gain("fadeall_but_music",0,0);
	set_filter_q("fadeall_but_music",0,1);
	add_all_channels_but_music("fadeall_but_music");
}

//Function Number: 4
old_iw4_eq()
{
	switch(level.script)
	{
		case "co_hunted":
		case "estate":
			break;

		case "af_caves":
			break;

		case "af_chase":
			break;

		case "airport":
			break;

		case "arcadia":
			break;

		case "boneyard":
			break;

		case "dcburning":
			break;

		case "dc_whitehouse":
		case "dcemp":
			break;

		case "roadkill":
		case "trainer":
			break;

		case "favela":
			break;

		case "favela_escape":
			break;

		case "so_showers_gulag":
		case "gulag":
			break;

		case "oilrig":
			break;

		case "cliffhanger":
			break;
	}
}

//Function Number: 5
old_iw4_filters()
{
	switch(level.script)
	{
		case "ac130":
			break;

		case "af_caves":
			break;

		case "airport":
			break;

		case "dc_whitehouse":
		case "dcemp":
			break;

		case "favela":
			break;

		case "so_showers_gulag":
		case "gulag":
			break;

		case "oilrig":
			break;
	}
}

//Function Number: 6
define_filter(param_00)
{
	level.eq_defs[param_00] = [];
}

//Function Number: 7
set_filter_type(param_00,param_01,param_02)
{
	level.eq_defs[param_00]["type"][param_01] = param_02;
}

//Function Number: 8
set_filter_freq(param_00,param_01,param_02)
{
	level.eq_defs[param_00]["freq"][param_01] = param_02;
}

//Function Number: 9
set_filter_gain(param_00,param_01,param_02)
{
	level.eq_defs[param_00]["gain"][param_01] = param_02;
}

//Function Number: 10
set_filter_q(param_00,param_01,param_02)
{
	level.eq_defs[param_00]["q"][param_01] = param_02;
}

//Function Number: 11
define_reverb(param_00)
{
	level.ambient_reverb[param_00] = [];
}

//Function Number: 12
set_reverb_roomtype(param_00,param_01)
{
	level.ambient_reverb[param_00]["roomtype"] = param_01;
}

//Function Number: 13
set_reverb_drylevel(param_00,param_01)
{
	level.ambient_reverb[param_00]["drylevel"] = param_01;
}

//Function Number: 14
set_reverb_wetlevel(param_00,param_01)
{
	level.ambient_reverb[param_00]["wetlevel"] = param_01;
}

//Function Number: 15
set_reverb_fadetime(param_00,param_01)
{
	level.ambient_reverb[param_00]["fadetime"] = param_01;
}

//Function Number: 16
set_reverb_priority(param_00,param_01)
{
	level.ambient_reverb[param_00]["priority"] = param_01;
}

//Function Number: 17
getfilter(param_00)
{
	if(!isdefined(level.eq_defs))
	{
		return undefined;
	}

	if(!isdefined(level.eq_defs[param_00]))
	{
		return undefined;
	}

	return level.eq_defs[param_00];
}

//Function Number: 18
add_channel_to_filter(param_00,param_01)
{
	if(!isdefined(level.ambient_eq[param_00]))
	{
		level.ambient_eq[param_00] = [];
	}

	level.ambient_eq[param_00][param_01] = 1;
}

//Function Number: 19
add_all_channels_to_filter(param_00)
{
	if(!isdefined(level.ambient_eq[param_00]))
	{
		level.ambient_eq[param_00] = [];
	}

	var_01 = get_all_channels();
	foreach(var_04, var_03 in var_01)
	{
		level.ambient_eq[param_00][var_04] = 1;
	}
}

//Function Number: 20
add_all_channels_but_music_and_mission(param_00)
{
	if(!isdefined(level.ambient_eq[param_00]))
	{
		level.ambient_eq[param_00] = [];
	}

	var_01 = get_all_channels();
	var_01["music"] = undefined;
	var_01["mission"] = undefined;
	foreach(var_04, var_03 in var_01)
	{
		level.ambient_eq[param_00][var_04] = 1;
	}
}

//Function Number: 21
add_all_channels_but_music(param_00)
{
	if(!isdefined(level.ambient_eq[param_00]))
	{
		level.ambient_eq[param_00] = [];
	}

	var_01 = get_all_channels();
	var_01["music"] = undefined;
	foreach(var_04, var_03 in var_01)
	{
		level.ambient_eq[param_00][var_04] = 1;
	}
}

//Function Number: 22
get_all_channels()
{
	var_00 = [];
	var_00["announcer"] = 1;
	var_00["ambient"] = 1;
	var_00["ambdist1"] = 1;
	var_00["ambdist2"] = 1;
	var_00["auto"] = 1;
	var_00["auto2"] = 1;
	var_00["auto2d"] = 1;
	var_00["autodog"] = 1;
	var_00["body"] = 1;
	var_00["body2d"] = 1;
	var_00["bulletimpact"] = 1;
	var_00["bulletwhizbyin"] = 1;
	var_00["bulletwhizbyout"] = 1;
	var_00["effects1"] = 1;
	var_00["effects2"] = 1;
	var_00["element"] = 1;
	var_00["explosiveimpact"] = 1;
	var_00["hurt"] = 1;
	var_00["item"] = 1;
	var_00["local"] = 1;
	var_00["local2"] = 1;
	var_00["local3"] = 1;
	var_00["menu"] = 1;
	var_00["mission"] = 1;
	var_00["music"] = 1;
	var_00["nonshock"] = 1;
	var_00["player1"] = 1;
	var_00["player2"] = 1;
	var_00["physics"] = 1;
	var_00["reload"] = 1;
	var_00["reload2d"] = 1;
	var_00["vehicle"] = 1;
	var_00["vehiclelimited"] = 1;
	var_00["voice"] = 1;
	var_00["weapon"] = 1;
	return var_00;
}