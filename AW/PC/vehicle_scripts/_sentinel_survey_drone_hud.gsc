/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _sentinel_survey_drone_hud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 156 ms
 * Timestamp: 4/22/2024 2:05:32 AM
*******************************************************************/

//Function Number: 1
hud_precache()
{
	precacheshader("sentinel_drone_overlay");
	precacheshader("sentinel_drone_scanlines");
	precacheshader("sentinel_drone_target");
	precacheshader("sentinel_drone_cam_name_1");
	precacheshader("sentinel_drone_cam_name_2");
	precacheshader("sentinel_drone_reticle");
	precacheshader("cinematic_screen");
	precacheshader("white");
	level._effect["drone_cam_distortion"] = loadfx("vfx/code/drone_cam_distortion");
	common_scripts\utility::flag_init("drone_cam_on");
}

//Function Number: 2
hud_start(param_00,param_01,param_02)
{
	setsaveddvar("compass","0");
	setsaveddvar("g_friendlynamedist",0);
	setsaveddvar("ammoCounterHide","1");
	setsaveddvar("hud_showStance","0");
	hud_init(param_00,param_01,param_02);
}

//Function Number: 3
hud_end()
{
	setsaveddvar("compass","1");
	setsaveddvar("g_friendlynamedist",15000);
	setsaveddvar("ammoCounterHide","0");
	setsaveddvar("hud_showStance","1");
}

//Function Number: 4
hud_init(param_00,param_01,param_02)
{
	level.dronehud = [];
	level.dronetarget = [];
	create_hud_drone_overlay(param_00,param_01,param_02);
	wait(0.5);
	common_scripts\utility::flag_set("drone_cam_on");
	thread drone_cam_timer();
	thread attachdistortionfx(param_00);
}

//Function Number: 5
destroy_sentinel_drone_hud()
{
	foreach(var_01 in level.dronehud)
	{
		if(isdefined(var_01))
		{
			var_01 destroy();
		}
	}

	level.dronehudfx delete();
	common_scripts\utility::flag_clear("drone_cam_on");
}

//Function Number: 6
create_hud_drone_overlay(param_00,param_01,param_02)
{
	var_03 = (1,1,1);
	var_04 = 1;
	if(param_02 == 1)
	{
		var_05 = newhudelem();
		var_05 setshader("sentinel_drone_cam_name_1",256,32);
		var_05.horzalign = "left";
		var_05.vertalign = "top";
		var_05.alpha = var_04;
		var_05.color = (1,1,1);
		var_05.x = -56;
		var_05.y = -32;
		var_05.sort = -4;
		level.dronehud["camName"] = var_05;
	}
	else if(param_02 == 2)
	{
		var_05 = newhudelem();
		var_05 setshader("sentinel_drone_cam_name_2",256,32);
		var_05.horzalign = "left";
		var_05.vertalign = "top";
		var_05.alpha = var_04;
		var_05.color = (1,1,1);
		var_05.x = -56;
		var_05.y = -32;
		var_05.sort = -4;
		level.dronehud["camName"] = var_05;
	}

	var_06 = newhudelem();
	var_06 setshader("sentinel_drone_scanlines",640,480);
	var_06.horzalign = "fullscreen";
	var_06.vertalign = "fullscreen";
	var_06.alpha = 0.1;
	var_06.color = (1,1,1);
	var_06.sort = 2;
	level.dronehud["scanlines"] = var_06;
	var_07 = newhudelem();
	var_07 setshader("sentinel_drone_text_scroll",128,256);
	var_07.horzalign = "left";
	var_07.vertalign = "top";
	var_07.alpha = var_04;
	var_07.color = (1,1,1);
	var_07.x = 0;
	var_07.y = 32;
	var_07.sort = -4;
	level.dronehud["text_scroll"] = var_07;
	var_08 = newhudelem();
	var_08 setshader("sentinel_drone_text_scroll",128,256);
	var_08.horzalign = "left";
	var_08.vertalign = "bottom";
	var_08.alpha = var_04;
	var_08.color = (1,1,1);
	var_08.x = 0;
	var_08.y = -64;
	var_08.sort = -4;
	level.dronehud["text_scroll2"] = var_08;
	level.dronehud["timer"] = newhudelem();
	level.dronehud["timer"].x = -64;
	level.dronehud["timer"].y = -64;
	level.dronehud["timer"].color = var_03;
	level.dronehud["timer"].horzalign = "center";
	level.dronehud["timer"].vertalign = "bottom";
	level.dronehud["timer"].fontscale = 2.25;
	level.dronehud["timer"] settext("00:00:00");
	level.dronehud["timer"].alpha = 1;
	level.dronehud["timer"].font = "default";
	level.dronehud["timer"].glowcolor = (1,1,1);
	level.dronehud["timer"].glowalpha = 1;
	var_09 = newhudelem();
	var_09 setshader("sentinel_drone_reticle",512,512);
	var_09.horzalign = "center";
	var_09.vertalign = "middle";
	var_09.alpha = var_04;
	var_09.x = -256;
	var_09.y = -256;
	var_09.sort = 2;
	level.dronehud["reticule"] = var_09;
	var_0A = -128;
	var_0B = 0;
	var_0C = newhudelem();
	var_0C setshader("sentinel_drone_pip",128,256);
	var_0C.horzalign = "right";
	var_0C.vertalign = "top";
	var_0C.alpha = 0.5;
	var_0C.x = var_0A;
	var_0C.y = var_0B;
	var_0C.sort = 1;
	level.dronehud["pip_movie_bg"] = var_0C;
	var_0D = newhudelem();
	var_0D setshader("cinematic_screen",128,256);
	var_0D.horzalign = "right";
	var_0D.vertalign = "top";
	var_0D.alpha = var_04;
	var_0D.x = var_0A;
	var_0D.y = var_0B;
	var_0D.sort = 2;
	level.dronehud["pip_movie"] = var_0D;
	var_0E = newhudelem();
	var_0E setshader("sentinel_drone_pip_overlay",128,256);
	var_0E.horzalign = "right";
	var_0E.vertalign = "top";
	var_0E.alpha = var_04;
	var_0E.x = var_0A;
	var_0E.y = var_0B;
	var_0E.sort = 2;
	level.dronehud["pip_overlay"] = var_0E;
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloopresident("sentinel_drone_pip_black_bg");
}

//Function Number: 7
create_hud_drone_target(param_00)
{
	self endon("death");
	var_01 = (0.25,0.25,0.25);
	var_02 = newhudelem();
	var_02 setshader("sentinel_drone_target",64,64);
	var_02.color = var_01;
	var_02.alpha = 1;
	var_02.sort = 2;
	var_02 setwaypoint(0,0);
	var_02 settargetent(self);
	level.dronetarget[level.dronetarget.size + 1] = var_02;
}

//Function Number: 8
remove_hud_drone_target()
{
	foreach(var_01 in level.dronetarget)
	{
		if(isdefined(var_01))
		{
			var_01 fadeovertime(0.25);
			var_01.alpha = 0;
		}
	}

	wait(0.25);
	foreach(var_01 in level.dronetarget)
	{
		if(isdefined(var_01))
		{
			var_01 destroy();
		}
	}

	level notify("remove_hud_drone_target");
}

//Function Number: 9
drone_cam_timer()
{
	level.drone_cam_timer = [];
	level.drone_cam_timer["seconds"] = 0;
	level.drone_cam_timer["minutes"] = 0;
	level.drone_cam_timer["hours"] = 0;
	while(common_scripts\utility::flag("drone_cam_on"))
	{
		level.drone_cam_timer["seconds"]++;
		if(level.drone_cam_timer["seconds"] == 60)
		{
			level.drone_cam_timer["seconds"] = 0;
			level.drone_cam_timer["minutes"]++;
		}

		if(level.drone_cam_timer["minutes"] == 60)
		{
			level.drone_cam_timer["minutes"] = 0;
			level.drone_cam_timer["hours"]++;
		}

		var_00 = maps\_utility::string(level.drone_cam_timer["hours"]);
		if(var_00.size == 1)
		{
			var_00 = "0" + var_00;
		}

		var_01 = maps\_utility::string(level.drone_cam_timer["minutes"]);
		if(var_01.size == 1)
		{
			var_01 = "0" + var_01;
		}

		var_02 = maps\_utility::string(level.drone_cam_timer["seconds"]);
		if(var_02.size == 1)
		{
			var_02 = "0" + var_02;
		}

		var_03 = var_00 + ":" + var_01 + ":" + var_02;
		level.dronehud["timer"] settext(var_03);
		wait(1);
	}
}

//Function Number: 10
attachdistortionfx(param_00)
{
	level.dronehudfx = common_scripts\utility::spawn_tag_origin();
	level.dronehudfx.origin = param_00.origin;
	level.dronehudfx.angles = param_00.angles;
	level.dronehudfx linkto(param_00);
	playfxontag(common_scripts\utility::getfx("drone_cam_distortion"),level.dronehudfx,"tag_origin");
}