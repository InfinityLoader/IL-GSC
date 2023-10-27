/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_flare.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 13
 * Decompile Time: 203 ms
 * Timestamp: 10/27/2023 2:34:20 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01)
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	level._effect["flare_runner_intro"] = loadfx("misc/flare_start");
	level._effect["flare_runner"] = loadfx("misc/flare");
	level._effect["flare_runner_fizzout"] = loadfx("misc/flare_end");
	maps\_vehicle::build_template("flare",param_00,param_01,"script_vehicle");
	maps\_vehicle::build_localinit(::func_269F);
	maps\_vehicle::build_life(9999);
}

//Function Number: 2
func_269F()
{
}

//Function Number: 3
func_3B92(param_00,param_01,param_02,param_03)
{
	wait param_00;
	param_01 = param_01 * 20;
	var_04 = [];
	for(var_05 = 0;var_05 < param_01;var_05++)
	{
		var_06 = var_05 / param_01;
		level.var_3B93 = var_06;
		var_07 = [];
		for(var_08 = 0;var_08 < 3;var_08++)
		{
			var_07[var_08] = param_03[var_08] * var_06 + param_02[var_08] * 1 - var_06;
		}

		level.sun_color = (var_07[0],var_07[1],var_07[2]);
		wait 0.05;
	}
}

//Function Number: 4
merge_sunsingledvar(param_00,param_01,param_02,param_03,param_04)
{
	setsaveddvar(param_00,param_03);
	wait param_01;
	param_02 = param_02 * 20;
	var_05 = [];
	for(var_06 = 0;var_06 < param_02;var_06++)
	{
		var_07 = var_06 / param_02;
		level.var_3B93 = var_07;
		var_08 = param_04 * var_07 + param_03 * 1 - var_07;
		setsaveddvar(param_00,var_08);
		wait 0.05;
	}

	setsaveddvar(param_00,param_04);
}

//Function Number: 5
func_3B96(param_00,param_01,param_02,param_03)
{
	wait param_00;
	param_01 = param_01 * 20;
	var_04 = [];
	for(var_05 = 0;var_05 < param_01;var_05++)
	{
		var_06 = var_05 / param_01;
		level.var_3B93 = var_06;
		var_07 = param_03 * var_06 + param_02 * 1 - var_06;
		level.var_3B97 = var_07;
		wait 0.05;
	}

	level.var_3B97 = param_03;
}

//Function Number: 6
func_3B98()
{
	level endon("stop_combining_sunlight_and_brightness");
	wait 0.05;
	for(;;)
	{
		var_00 = level.var_3B97;
		if(var_00 > 1)
		{
			var_00 = var_00 + randomfloat(0.2);
		}

		var_01 = level.sun_color * var_00;
		setsunlight(var_01[0],var_01[1],var_01[2]);
		wait 0.05;
	}
}

//Function Number: 7
flare_path()
{
	thread maps\_vehicle::func_1B44(self);
	common_scripts\utility::flag_wait("flare_stop_setting_sundir");
	self delete();
}

//Function Number: 8
flare_initial_fx()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("tag_origin");
	var_00 linkto(self,"tag_origin",(0,0,0),(0,0,0));
	playfxontag(level._effect["flare_runner_intro"],var_00,"tag_origin");
	self waittillmatch("flare_intro_node","noteworthy");
	var_00 delete();
}

//Function Number: 9
flare_explodes()
{
	common_scripts\utility::flag_set("flare_start_setting_sundir");
	level.var_3B97 = 1;
	level.red_suncolor = (0.8,0.4,0.4);
	level.original_suncolor = getmapsunlight();
	level.sun_color = level.original_suncolor;
	thread merge_sunsingledvar("sm_sunSampleSizeNear",0,0.25,0.25,1);
	thread func_3B98();
	thread func_3B92(0,0.25,level.original_suncolor,level.red_suncolor);
	thread func_3B96(0,0.25,1,3);
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("tag_origin");
	var_00 linkto(self,"tag_origin",(0,0,0),(0,0,0));
	playfxontag(level._effect["flare_runner"],var_00,"tag_origin");
	self waittillmatch("flare_fade_node","noteworthy");
	var_00 delete();
}

//Function Number: 10
func_3B9E()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("tag_origin");
	var_00 linkto(self,"tag_origin",(0,0,0),(0,0,0));
	playfxontag(level._effect["flare_runner_fizzout"],var_00,"tag_origin");
	thread merge_sunsingledvar("sm_sunSampleSizeNear",0,1,1,0.25);
	thread func_3B96(0,1,3,0);
	thread func_3B92(0,1,level.red_suncolor,level.original_suncolor);
	thread func_3B96(1,1,0,1);
	var_00 delete();
	wait 1;
	common_scripts\utility::flag_set("flare_stop_setting_sundir");
	resetsundirection();
	wait 1;
	level notify("stop_combining_sunlight_and_brightness");
	waittillframeend;
	resetsunlight();
	common_scripts\utility::flag_set("flare_complete");
}

//Function Number: 11
func_23DC()
{
	flare_initial_fx();
	flare_explodes();
	func_3B9E();
}

//Function Number: 12
flag_flare(param_00)
{
	if(!isdefined(level.flag[param_00]))
	{
		common_scripts\utility::flag_init(param_00);
	}
}

//Function Number: 13
func_3BA0(param_00)
{
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname(param_00);
	flag_flare("flare_in_use");
	flag_flare("flare_complete");
	flag_flare("flare_stop_setting_sundir");
	flag_flare("flare_start_setting_sundir");
	common_scripts\utility::flag_waitopen("flare_in_use");
	common_scripts\utility::flag_set("flare_in_use");
	resetsunlight();
	resetsundirection();
	var_01 thread flare_path();
	var_01 thread func_23DC();
	var_02 = getmapsundirection();
	var_03 = var_02;
	var_04 = var_03 * -100;
	common_scripts\utility::flag_wait("flare_start_setting_sundir");
	var_05 = getent(var_01.script_linkto,"script_linkname").origin;
	var_03 = vectortoangles(var_01.origin - var_05);
	var_06 = anglestoforward(var_03);
	for(;;)
	{
		wait 0.05;
		if(common_scripts\utility::flag("flare_stop_setting_sundir"))
		{
			break;
		}

		var_03 = vectortoangles(var_01.origin - var_05);
		var_07 = anglestoforward(var_03);
		lerpsundirection(var_06,var_07,0.05);
		var_06 = var_07;
	}

	common_scripts\utility::flag_wait("flare_complete");
	waittillframeend;
	common_scripts\utility::flag_clear("flare_complete");
	common_scripts\utility::flag_clear("flare_stop_setting_sundir");
	common_scripts\utility::flag_clear("flare_start_setting_sundir");
	resetsunlight();
	resetsundirection();
	common_scripts\utility::flag_clear("flare_in_use");
}