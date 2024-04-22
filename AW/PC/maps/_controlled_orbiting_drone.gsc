/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _controlled_orbiting_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 572 ms
 * Timestamp: 4/22/2024 2:20:23 AM
*******************************************************************/

//Function Number: 1
precacheassets_and_initflags()
{
	precacheshader("white_multiply");
	precachestring(&"LAGOS_FLY_DRONE_CONTROL");
	common_scripts\utility::flag_init("FlagPlayerEndDroneControl");
	common_scripts\utility::flag_init("FlagPlayerEndDroneStatic");
	common_scripts\utility::flag_init("FlagSniperDroneAnimating");
	common_scripts\utility::flag_init("FlagSniperDroneLookAt");
	common_scripts\utility::flag_init("FlagForcePlayerADS");
	common_scripts\utility::flag_init("FlagHadesVehicleDriveStart");
}

//Function Number: 2
initializesniperdronedata()
{
	var_00 = spawnstruct();
	var_00.droneangularvelocity = 0;
	var_00.droneverticalvelocity = 0;
	var_00.calculatenewhoverdestination = 1;
	var_00.dronehoverdirection = (0,0,-1);
	var_00.hoverspeed = 0.5;
	var_00.lasthoveroffset = (0,0,0);
	var_00.hoverbounceconeangle = 10;
	var_00.currentvelocity = (0,0,0);
	var_00.targetangularacceleration = 0;
	var_00.stickhorizontalinputlength = 0;
	var_00.brakingcurrenttime = 0;
	var_00.bodyrollvelocity = (0,0,0);
	var_00.framerollacceleration = (0,0,0);
	var_00.barrelrollacceleration = (0,0,0);
	var_00.frameviewmodeloffset = (0,0,0);
	var_00.barrelviewmodeloffset = (0,0,0);
	var_00.horizontaloffsetstrafe = 0;
	var_00.verticaloffsetstrafe = 0;
	var_00.horizontaloffsetlook = 0;
	var_00.verticaloffsetlook = 0;
	return var_00;
}

//Function Number: 3
initdroneflyinturnrate()
{
	setsaveddvar("aim_turnrate_pitch",30);
	setsaveddvar("aim_turnrate_pitch_ads",25);
	setsaveddvar("aim_turnrate_yaw",60);
	setsaveddvar("aim_turnrate_yaw_ads",40);
	setsaveddvar("aim_accel_turnrate_lerp",300);
}

//Function Number: 4
initdroneturnrate()
{
	setsaveddvar("aim_turnrate_pitch",70);
	setsaveddvar("aim_turnrate_pitch_ads",55);
	setsaveddvar("aim_turnrate_yaw",125);
	setsaveddvar("aim_turnrate_yaw_ads",90);
	setsaveddvar("aim_accel_turnrate_lerp",600);
}

//Function Number: 5
savedefaultturnrate()
{
	self.aim_turnrate_pitch = getdvarint("aim_turnrate_pitch");
	self.aim_turnrate_pitch_ads = getdvarint("aim_turnrate_pitch_ads");
	self.aim_turnrate_yaw = getdvarint("aim_turnrate_yaw");
	self.aim_turnrate_yaw_ads = getdvarint("aim_turnrate_yaw_ads");
	self.aim_accel_turnrate_lerp = getdvarint("aim_accel_turnrate_lerp");
}

//Function Number: 6
restoredefaultturnrate()
{
	setsaveddvar("aim_turnrate_pitch",self.aim_turnrate_pitch);
	setsaveddvar("aim_turnrate_pitch_ads",self.aim_turnrate_pitch_ads);
	setsaveddvar("aim_turnrate_yaw",self.aim_turnrate_yaw);
	setsaveddvar("aim_turnrate_yaw_ads",self.aim_turnrate_yaw_ads);
	setsaveddvar("aim_accel_turnrate_lerp",self.aim_accel_turnrate_lerp);
}

//Function Number: 7
startdronecontrol(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("drone_control_complete");
	maps\_shg_utility::hide_player_hud();
	var_06 = distance2d(param_00.origin,param_01.origin);
	var_07 = vectortoangles(param_01.origin - param_00.origin);
	level.player disableweapons();
	level.player disableweaponswitch();
	level.player disableoffhandweapons();
	level.player allowcrouch(0);
	var_08 = initializesniperdronedata();
	var_09 = common_scripts\utility::spawn_tag_origin();
	level.player.sniperdronelink = var_09;
	level.player.sniperdronedata = var_08;
	initorbitlowerbounds(param_00.origin,param_05);
	var_0A = sniperdroneoverlays();
	childthread updateflyinscopeoverlay(var_0A["scope"],param_01.origin[2]);
	level.player.sniperdronelink savedefaultturnrate();
	if(param_03)
	{
		var_09 initdroneflyinturnrate();
		common_scripts\utility::flag_wait("drone_fly_anim_done");
	}
	else
	{
		level.player setplayerangles(vectortoangles(param_02.origin - param_01.origin));
	}

	initdroneturnrate();
	calculateinitialposition(param_01,param_00,var_07,var_06);
	thread hintsniperdronemove();
	soundscripts\_snd::snd_message("fly_drone_camera_start_2",var_09,level.player);
	var_0B = var_09.origin;
	var_0C = 0;
	var_0D = 0;
	level.fly_drone_rumbling = 0;
	var_0E = 1;
	while(isdefined(level.player.sniperdronelink))
	{
		if(common_scripts\utility::flag("FlagPlayerEndDroneStatic") || common_scripts\utility::flag("FlagSniperDroneAnimating") || common_scripts\utility::flag("FlagSniperDroneLookAt"))
		{
			wait 0.05;
			continue;
		}

		var_08.droneangularvelocity = updatehorizontalvelocity();
		var_08.droneverticalvelocity = updateverticalvelocity();
		var_0F = angleclamp(var_0C + var_08.droneangularvelocity * 0.05);
		var_10 = combineangles((0,var_0F,0),var_07);
		var_11 = var_0D + var_08.droneverticalvelocity * 0.05;
		var_11 = clamp(var_11,-15,15);
		var_12 = var_0B;
		var_13 = param_00.origin + (0,0,var_11);
		var_0B = var_13 + anglestoforward(var_10) * var_06;
		var_14 = clamppositiontolowerbounds(var_0B,param_00.origin);
		var_0B = (var_0B[0],var_0B[1],var_0B[2] + var_14);
		var_11 = var_11 + var_14;
		var_0F = clampyaworbitoffset(var_0B,param_00.origin,var_07);
		var_09.origin = var_0B;
		var_08.currentvelocity = var_0B - var_12;
		if(length(var_08.currentvelocity) <= 0.6)
		{
			level notify("fly_drone_not_moving");
		}
		else if(level.fly_drone_rumbling == 0)
		{
			thread maps\lagos_utility::rumble_flydrone_control();
		}

		var_15 = vectortoangles(var_13 - var_0B);
		var_15 = var_15 * (0,1,0);
		var_09.angles = var_15;
		var_0C = var_0F;
		var_0D = var_11;
		if(var_0E)
		{
			var_16 = 0.75;
			level.player unlink();
			var_17 = level.player getorigin();
			var_18 = level.player getplayerangles();
			var_19 = 0;
			var_1A = level.player common_scripts\utility::spawn_tag_origin();
			while(var_19 <= var_16)
			{
				var_1B = var_19 / var_16;
				var_1A.origin = vectorlerp(var_17,var_09.origin,var_1B);
				var_1A.angles = vectorlerp(var_18,var_09.angles,var_1B);
				level.player playerlinktodelta(var_1A,"tag_origin",1,10,10,10,30,1);
				wait 0.05;
				var_19 = var_19 + 0.05;
			}

			level.player playerlinktodelta(var_09,"tag_origin",1,10,10,10,30,1);
			var_0E = 0;
		}

		wait 0.05;
	}
}

//Function Number: 8
sniperdroneoverlays()
{
	var_00 = [];
	var_00["scope"] = createoverlay("white_multiply",0);
	return var_00;
}

//Function Number: 9
initorbitlowerbounds(param_00,param_01)
{
	level.player.sniperdronedata.orbitlowerbounds = maps\_sarray::sarray_spawn();
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(!isdefined(param_01[var_02]))
		{
			continue;
		}

		var_03 = vectortoangles(param_00 - param_01[var_02].origin);
		param_01[var_02].orbitangle = var_03[1];
		level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_push(param_01[var_02]);
	}

	maps\_sarray::sarray_sort_by_handler(level.player.sniperdronedata.orbitlowerbounds,maps\_sarray::sarray_create_func_obj(::compareorbitangle));
}

//Function Number: 10
calculateinitialposition(param_00,param_01,param_02,param_03)
{
	level.player.sniperdronelink.angles = vectortoangles(param_01.origin - param_00.origin) * (0,1,0);
}

//Function Number: 11
clamplookangle(param_00)
{
	if(param_00 > 180)
	{
		return param_00 - 360;
	}

	if(param_00 < -180)
	{
		return param_00 + 360;
	}

	return param_00;
}

//Function Number: 12
getlookpitch()
{
	var_00 = level.player getplayerangles();
	return clamplookangle(var_00[0]);
}

//Function Number: 13
getlookyaw()
{
	var_00 = level.player getplayerangles();
	return clamplookangle(var_00[1]) - clamplookangle(level.player.sniperdronelink.angles[1]);
}

//Function Number: 14
clearmovementparameters()
{
	level.player.sniperdronedata.bodyrollvelocity = (0,0,0);
	level.player.sniperdronedata.bodyrollvelocity = (0,0,0);
	level.player.sniperdronedata.framerollacceleration = (0,0,0);
	level.player.sniperdronedata.barrelrollacceleration = (0,0,0);
	level.player.sniperdronedata.targetangularacceleration = 0;
	level.player.sniperdronedata.droneangularvelocity = 0;
	level.player.sniperdronedata.droneverticalvelocity = 0;
}

//Function Number: 15
lerpplayerlook(param_00)
{
	var_01 = level.player getplayerangles();
	var_02 = 0;
	while(var_02 <= 1)
	{
		var_03 = euler_lerp(var_01,param_00,var_02);
		level.player setplayerangles(var_03);
		var_02 = var_02 + 0.1;
		wait(0.05);
	}
}

//Function Number: 16
updateflyinscopeoverlay(param_00,param_01)
{
	while(isdefined(level.player.sniperdronelink))
	{
		var_02 = level.player.sniperdronelink.angles;
		wait(0.05);
		if(!common_scripts\utility::flag("FlagSniperDroneAnimating") && !common_scripts\utility::flag("FlagSniperDroneLookAt"))
		{
			continue;
		}

		var_03 = level.player.sniperdronelink.origin[2] - param_01;
		var_04 = var_02[1] - level.player.sniperdronelink.angles[1];
		var_04 = clamp(var_04,-1,1);
		var_05 = level.player.sniperdronelink.angles[0];
		if(common_scripts\utility::flag("FlagSniperDroneLookAt"))
		{
			var_05 = getlookpitch();
		}
	}
}

//Function Number: 17
hintsniperdronemove()
{
	wait(1);
	thread notifyonplayermovingsniperdrone();
	maps\_utility::hintdisplayhandler("move_fly_drone",5);
}

//Function Number: 18
move_fly_drone_check()
{
	level.player endon("death");
	if(level.player getnormalizedmovement() != 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
notifyonplayermovingsniperdrone()
{
	for(;;)
	{
		var_00 = level.player getnormalizedmovement();
		if(length(var_00) != 0)
		{
			level.player notify("sniperdrone_moving");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 20
enddronecontrol()
{
	level.player.sniperdronelink restoredefaultturnrate();
	wait(0.75);
	level notify("drone_control_complete");
	level.player.sniperdronelink = undefined;
	wait(0.25);
}

//Function Number: 21
iscontrollingdrone()
{
	return isdefined(level.player.sniperdronelink);
}

//Function Number: 22
createoverlay(param_00,param_01)
{
	var_02 = newclienthudelem(level.player);
	var_02.x = 0;
	var_02.y = 0;
	var_02.alignx = "left";
	var_02.aligny = "top";
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02 setshader(param_00,640,480);
	var_02.alpha = param_01;
	var_02.sort = -3;
	return var_02;
}

//Function Number: 23
compareorbitangle(param_00,param_01)
{
	return param_00.orbitangle < param_01.orbitangle;
}

//Function Number: 24
settargetangularacceleration(param_00)
{
	if(abs(level.player.sniperdronedata.targetangularacceleration) > abs(param_00))
	{
		return;
	}

	level.player.sniperdronedata.targetangularacceleration = param_00;
}

//Function Number: 25
updatetargetangularacceleration()
{
	if(!isdefined(level.player.sniperdronedata))
	{
		return;
	}

	level.player.sniperdronedata.targetangularacceleration = level.player.sniperdronedata.targetangularacceleration * 0.95;
}

//Function Number: 26
updatevelocity(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = clamp(abs(param_01),0,1);
	var_0A = 0;
	if(param_02 * param_01 < 0)
	{
		if(level.player adsbuttonpressed() || common_scripts\utility::flag("FlagForcePlayerADS"))
		{
			var_0A = param_08 * param_01;
		}
		else
		{
			var_0A = param_07 * param_01;
		}
	}

	param_02 = param_02 + param_03 * param_01 + var_0A;
	param_02 = clamp(param_02,-1 * param_04,param_04);
	if(isdefined(param_00))
	{
		updatetargetangularacceleration();
		param_00.stickhorizontalinputlength = var_09;
		if(var_09 > 0)
		{
			param_00.targetangularacceleration = param_03 * param_01;
			param_00.brakingcurrenttime = 0;
		}
	}

	if(var_09 == 0)
	{
		var_0B = param_02;
		if(level.player adsbuttonpressed() || common_scripts\utility::flag("FlagForcePlayerADS"))
		{
			param_02 = param_02 * param_06;
		}
		else
		{
			param_02 = param_02 * param_05;
		}

		if(isdefined(param_00))
		{
			settargetangularacceleration(var_0B - param_02 * -1);
		}
	}

	return param_02;
}

//Function Number: 27
scalevelocity(param_00)
{
	if(level.player adsbuttonpressed() || common_scripts\utility::flag("FlagForcePlayerADS"))
	{
		param_00 = param_00 * 0.85;
	}

	if(level.player adsbuttonpressed() && level.player enemyincrosshairs())
	{
		param_00 = param_00 * 0.85;
	}

	return param_00;
}

//Function Number: 28
updatehorizontalvelocity()
{
	var_00 = maps\lagos_utility::calculateleftstickdeadzone();
	var_01 = updatevelocity(level.player.sniperdronedata,var_00[1],level.player.sniperdronedata.droneangularvelocity,1.25,35,0.9,0.4,10,8);
	return scalevelocity(var_01);
}

//Function Number: 29
updateverticalvelocity()
{
	var_00 = maps\lagos_utility::calculateleftstickdeadzone();
	var_01 = updatevelocity(undefined,var_00[0],level.player.sniperdronedata.droneverticalvelocity,5,10,0.75,0.4,150,125);
	return scalevelocity(var_01);
}

//Function Number: 30
clamppositiontolowerbounds(param_00,param_01)
{
	var_02 = vectortoangles(param_01 - param_00);
	var_03 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_length() - 1;
	var_04 = 0;
	for(var_04 = 0;var_04 < level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_length();var_04++)
	{
		if(var_02[1] < level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get(var_04).orbitangle)
		{
			break;
		}

		var_03 = var_04;
	}

	var_04 = var_04 % level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_length();
	var_05 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get(var_03).orbitangle;
	var_06 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get(var_04).orbitangle;
	if(var_05 > var_06)
	{
		var_05 = var_05 - 360;
	}

	var_07 = abs(var_02[1] - var_05) / abs(var_06 - var_05);
	var_08 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get(var_03).origin;
	var_09 = level.player.sniperdronedata.orbitlowerbounds maps\_sarray::sarray_get(var_04).origin;
	var_0A = var_08[2] + var_09[2] - var_08[2] * var_07;
	if(param_00[2] < var_0A)
	{
		return var_0A - param_00[2];
	}

	return 0;
}

//Function Number: 31
clampyaworbitoffset(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_00 - param_01 * (1,1,0));
	var_03 = var_03 - param_02;
	return var_03[1];
}

//Function Number: 32
calculatehoverlocation(param_00,param_01)
{
	level endon("drone_control_complete");
	var_02 = param_00 + level.player.sniperdronedata.dronehoverdirection * 2;
	return vectornormalize(var_02 - level.player.sniperdronelink.origin) * level.player.sniperdronedata.hoverspeed;
}

//Function Number: 33
updatehoverspeed(param_00)
{
	level endon("drone_control_complete");
	var_01 = param_00 + level.player.sniperdronedata.dronehoverdirection * 2;
	var_02 = 10;
	var_03 = length(var_01 - level.player.sniperdronelink.origin);
	if(var_03 > var_02)
	{
		level.player.sniperdronedata.hoverspeed = level.player.sniperdronedata.hoverspeed + 0.5;
		level.player.sniperdronedata.hoverspeed = clamp(level.player.sniperdronedata.hoverspeed,-0.5,0.5);
		return;
	}

	var_04 = maps\_shg_utility::linear_map_clamp(var_03,0,var_02,0,1);
	level.player.sniperdronedata.hoverspeed = maps\_utility::linear_interpolate(var_04,0.25,0.5);
}

//Function Number: 34
updatehoveridle(param_00)
{
	level endon("drone_control_complete");
	if(level.player maps\_utility::isads())
	{
		level.player.sniperdronedata.calculatenewhoverdestination = 1;
	}
	else if(abs(level.player.sniperdronedata.droneangularvelocity) > 0.05 || abs(level.player.sniperdronedata.droneverticalvelocity) > 0.05)
	{
		level.player.sniperdronedata.calculatenewhoverdestination = 1;
		level.player.sniperdronedata.hoverbounceconeangle = 5;
		level.player.sniperdronedata.dronehoverdirection = vectornormalize(level.player.sniperdronedata.currentvelocity) * -1;
	}
	else if(level.player.sniperdronedata.calculatenewhoverdestination)
	{
		level.player.sniperdronedata.calculatenewhoverdestination = 0;
		level.player.sniperdronedata.dronehoverdirection = common_scripts\utility::randomvectorincone(level.player.sniperdronedata.dronehoverdirection * -1,level.player.sniperdronedata.hoverbounceconeangle);
		level.player.sniperdronedata.dronehoverdirection = vectornormalize(level.player.sniperdronedata.dronehoverdirection);
		level.player.sniperdronedata.hoverbounceconeangle = 10;
		level.player.sniperdronedata.hoverspeed = 0;
		return calculatehoverlocation(param_00);
	}
	else
	{
		updatehoverspeed(param_00);
		var_01 = param_00 + level.player.sniperdronedata.dronehoverdirection * 2;
		if(lengthsquared(level.player.sniperdronelink.origin - var_01) < squared(3))
		{
			level.player.sniperdronedata.calculatenewhoverdestination = 1;
		}

		return calculatehoverlocation(param_00);
	}

	return (0,0,0);
}

//Function Number: 35
angle_lerp(param_00,param_01,param_02)
{
	return angleclamp(param_00 + angleclamp180(param_01 - param_00) * param_02);
}

//Function Number: 36
euler_lerp(param_00,param_01,param_02)
{
	return (angle_lerp(param_00[0],param_01[0],param_02),angle_lerp(param_00[1],param_01[1],param_02),angle_lerp(param_00[2],param_01[2],param_02));
}