/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _high_speed_clouds.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 199 ms
 * Timestamp: 4/22/2024 2:21:21 AM
*******************************************************************/

//Function Number: 1
cloudfastinit(param_00,param_01,param_02,param_03)
{
	level.fastcloud_rumble_ent = level.player maps\_utility::get_rumble_ent();
	level._effect["fast_cloud_0"] = loadfx("fx/misc/blank");
	level._effect["fast_cloud_1"] = loadfx("vfx/map/crash/wind_streaks_fast_1");
	level._effect["fast_cloud_2"] = loadfx("vfx/map/crash/wind_streaks_fast_2");
	level._effect["fast_cloud_3"] = loadfx("vfx/map/crash/wind_streaks_fast_3");
	level._effect["fast_cloud_4"] = loadfx("vfx/map/crash/wind_streaks_fast_4");
	level._effect["fast_cloud_5"] = loadfx("vfx/map/crash/wind_streaks_fast_5");
	level._effect["fast_cloud_6"] = loadfx("vfx/map/crash/wind_streaks_fast_6");
	level._effect["fast_cloud_7"] = loadfx("vfx/map/crash/wind_streaks_fast_7");
	level._effect["fast_cloud_8"] = loadfx("vfx/map/crash/wind_streaks_fast_8");
	level._effect["fast_cloud_9"] = loadfx("vfx/map/crash/wind_streaks_fast_9");
	level._effect["fast_cloud_10"] = loadfx("vfx/map/crash/wind_streaks_fast10");
	level._effect["screen_splash_drops_0"] = loadfx("fx/misc/blank");
	level._effect["screen_splash_drops_1"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lght");
	level._effect["screen_splash_drops_2"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lght");
	level._effect["screen_splash_drops_3"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lght");
	level._effect["screen_splash_drops_4"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lght");
	level._effect["screen_splash_drops_5"] = loadfx("vfx/map/crash/screen_splash_drops_fast");
	level._effect["screen_splash_drops_6"] = loadfx("vfx/map/crash/screen_splash_drops_fast");
	level._effect["screen_splash_drops_7"] = loadfx("vfx/map/crash/screen_splash_drops_fast");
	level._effect["screen_splash_drops_8"] = loadfx("vfx/map/crash/screen_splash_drops_fast_hvy");
	level._effect["screen_splash_drops_9"] = loadfx("vfx/map/crash/screen_splash_drops_fast_hvy");
	level._effect["screen_splash_drops_10"] = loadfx("vfx/map/crash/screen_splash_drops_fast_hvy");
	level._effect["lf_screen_splash_drops_0"] = loadfx("fx/misc/blank");
	level._effect["lf_screen_splash_drops_1"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs_lght");
	level._effect["lf_screen_splash_drops_2"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs_lght");
	level._effect["lf_screen_splash_drops_3"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs_lght");
	level._effect["lf_screen_splash_drops_4"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs_lght");
	level._effect["lf_screen_splash_drops_5"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs");
	level._effect["lf_screen_splash_drops_6"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs");
	level._effect["lf_screen_splash_drops_7"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs");
	level._effect["lf_screen_splash_drops_8"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs");
	level._effect["lf_screen_splash_drops_9"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs");
	level._effect["lf_screen_splash_drops_10"] = loadfx("vfx/map/crash/screen_splash_drops_fast_lhs");
	level._effect["rt_screen_splash_drops_0"] = loadfx("fx/misc/blank");
	level._effect["rt_screen_splash_drops_1"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs_lght");
	level._effect["rt_screen_splash_drops_2"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs_lght");
	level._effect["rt_screen_splash_drops_3"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs_lght");
	level._effect["rt_screen_splash_drops_4"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs_lght");
	level._effect["rt_screen_splash_drops_5"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs");
	level._effect["rt_screen_splash_drops_6"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs");
	level._effect["rt_screen_splash_drops_7"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs");
	level._effect["rt_screen_splash_drops_8"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs");
	level._effect["rt_screen_splash_drops_9"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs");
	level._effect["rt_screen_splash_drops_10"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rhs");
	level._effect["rear_screen_splash_drops"] = loadfx("vfx/map/crash/screen_splash_drops_fast_rear");
	if(param_00 == "none")
	{
		level.fastcloudlevel = 0;
		level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
		level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
		level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
		level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
		level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
		level.fastcloud_rumble_ent maps\_utility::set_rumble_intensity(level.fastcloudrumble);
		cloudfastnone(0.1);
	}
	else if(param_00 == "light")
	{
		level.fastcloudlevel = 1;
		level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
		level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
		level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
		level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
		level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
		level.fastcloud_rumble_ent maps\_utility::set_rumble_intensity(level.fastcloudrumble);
		cloudfastlight(0.1);
	}
	else if(param_00 == "medium")
	{
		level.fastcloudlevel = 5;
		level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
		level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
		level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
		level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
		level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
		level.fastcloud_rumble_ent maps\_utility::set_rumble_intensity(level.fastcloudrumble);
		cloudfastmedium(0.1);
	}
	else
	{
		level.fastcloudlevel = 10;
		level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
		level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
		level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
		level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
		level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
		level.fastcloud_rumble_ent maps\_utility::set_rumble_intensity(level.fastcloudrumble);
		cloudfastheavy(0.1);
	}

	if(!isdefined(param_01))
	{
		level.wind_dir = (0,0,0);
	}
	else
	{
		level.wind_dir = param_01;
	}

	level.default_sun_light = getmapsunlight();
	thread cloudfastplayer(param_02);
	if(!isdefined(param_03))
	{
		thread cloudsunflicker();
	}
}

//Function Number: 2
cloudfastheavy(param_00)
{
	level notify("fast_cloud_change","heavy",param_00);
	level thread cloudfasteffectchange(10,param_00);
	wait(param_00);
}

//Function Number: 3
cloudfastmedium(param_00)
{
	level notify("fast_cloud_change","medium",param_00);
	level thread cloudfasteffectchange(8,param_00);
	wait(param_00);
}

//Function Number: 4
cloudfastlight(param_00)
{
	level notify("fast_cloud_change","light",param_00);
	level thread cloudfasteffectchange(5,param_00);
	wait(param_00);
}

//Function Number: 5
cloudfastnone(param_00)
{
	level notify("fast_cloud_change","none",param_00);
	level thread cloudfasteffectchange(0,param_00);
	wait(param_00);
}

//Function Number: 6
cloudfastplayer(param_00)
{
	level endon("stop_fast_clouds");
	var_01 = getentarray("player","classname")[0];
	if(isdefined(param_00) && param_00 >= 0)
	{
		var_01 thread cloudpushplayer(param_00,1);
	}

	for(;;)
	{
		var_02 = level.wind_dir;
		if(level.fastcloudlevel > 5)
		{
			screenshake(level.player.origin,level.fastcloudlevel * 0.1 * 0.09,0,0,0.3,0,0,500,15,1,1);
		}
		else
		{
			screenshake(level.player.origin,level.fastcloudlevel * 0.1 * 0.15,0,0,0.3,0,0,500,15,1,1);
		}

		playfx(level._effect["fast_clouds"],var_01.origin + (0,0,16),(var_02[0],var_02[1] + 90,var_02[2]));
		var_03 = level.player.angles;
		if(level.player islinked())
		{
			var_03 = var_03 + (0,level.player getlinkedparent().angles[1],0);
		}

		var_04 = anglestoforward((0,var_02[1],0));
		var_05 = anglestoforward(var_03);
		var_06 = vectordot(var_04,var_05);
		var_07 = vectorcross((0,0,1),var_04);
		var_08 = vectordot(var_07,var_05);
		if(var_06 >= 0.87)
		{
			playfx(level._effect["screen_splash_drops"],var_01.origin);
		}
		else if(var_06 <= -0.87)
		{
			playfx(level._effect["rear_screen_splash_drops"],var_01.origin);
		}
		else if(var_08 >= 0)
		{
			playfx(level._effect["lf_screen_splash_drops"],var_01.origin);
		}
		else
		{
			playfx(level._effect["rt_screen_splash_drops"],var_01.origin);
		}

		wait(0.3);
	}
}

//Function Number: 7
cloudsunflicker()
{
	level endon("stop_sun_flicker");
	for(;;)
	{
		setsunlight(level.default_sun_light[0] + level.fastcloudlevel * -0.055,level.default_sun_light[1] + level.fastcloudlevel * -0.04,level.default_sun_light[2] + level.fastcloudlevel * -0.02);
		wait(0.3);
	}
}

//Function Number: 8
cloudsunreset()
{
	level notify("stop_sun_flicker");
	wait(0.3);
	resetsunlight();
}

//Function Number: 9
cloudfasteffectchange(param_00,param_01)
{
	level notify("fast_cloud_level_change");
	level endon("fast_cloud_level_change");
	if(!isdefined(param_01) || param_01 == 0)
	{
	}

	if(level.fastcloudlevel > param_00)
	{
		var_02 = level.fastcloudlevel - param_00;
		param_01 = param_01 / var_02;
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			wait(param_01);
			level.fastcloudlevel--;
			level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
			level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
			level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
			level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
			if(level.fastcloudlevel > 4)
			{
				level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
				level.fastcloud_rumble_ent maps\_utility::rumble_ramp_to(level.fastcloudrumble,param_01);
				continue;
			}

			level.fastcloud_rumble_ent maps\_utility::rumble_ramp_to(0,param_01);
		}
	}

	if(level.fastcloudlevel < param_00)
	{
		var_02 = param_00 - level.fastcloudlevel;
		param_01 = param_01 / var_02;
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			wait(param_01);
			level.fastcloudlevel++;
			level._effect["fast_clouds"] = level._effect["fast_cloud_" + level.fastcloudlevel];
			level._effect["screen_splash_drops"] = level._effect["screen_splash_drops_" + level.fastcloudlevel];
			level._effect["lf_screen_splash_drops"] = level._effect["lf_screen_splash_drops_" + level.fastcloudlevel];
			level._effect["rt_screen_splash_drops"] = level._effect["rt_screen_splash_drops_" + level.fastcloudlevel];
			if(level.fastcloudlevel > 4)
			{
				level.fastcloudrumble = level.fastcloudlevel * 0.1 * 0.25;
				level.fastcloud_rumble_ent maps\_utility::rumble_ramp_to(level.fastcloudrumble,param_01);
				continue;
			}

			level.fastcloud_rumble_ent maps\_utility::rumble_ramp_to(0,param_01);
		}
	}
}

//Function Number: 10
cloudpushplayer(param_00,param_01)
{
	level endon("stop_fast_clouds");
	var_02 = level.wind_dir;
	var_03 = anglestoforward((0,180 - var_02[1],0));
	var_04 = (0,0,0);
	for(;;)
	{
		if(level.fastcloudlevel >= param_00)
		{
			var_04 = vectorlerp(var_04,var_03 * level.fastcloudlevel - param_00 + 1 * 100 * 0.05,0.5);
		}
		else
		{
			var_04 = vectorlerp(var_04,(0,0,0),0.25);
		}

		if(!isdefined(param_01) || !param_01 || !self attackbuttonpressed())
		{
			self pushplayervector(var_04,1);
		}
		else
		{
			self pushplayervector((0,0,0),1);
		}

		wait(0.05);
	}
}