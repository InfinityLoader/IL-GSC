/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _controlled_sniperdrone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 76
 * Decompile Time: 1142 ms
 * Timestamp: 4/22/2024 2:20:27 AM
*******************************************************************/

//Function Number: 1
precacheassets()
{
	precacheshader("white_multiply");
	precacheshader("overlay_static_digital");
	precacheshader("sentinel_drone_scanlines");
	precacheshader("sentinel_drone_overlay_distort");
	precacheshader("ugv_vignette_overlay");
	precacheshader("remote_chopper_overlay_scratches");
	precacheshader("wasp_screencrack");
	precacheitem("hms_sniperdrone");
	precacheshellshock("barrett");
	precachestring(&"sniper_drone_hud");
	precachestring(&"sniper_drone_hud_update");
	maps\_utility::add_control_based_hint_strings("drone_move",&"GREECE_HINT_DRONE_MOVE",::hintdronemoveoff,&"GREECE_HINT_DRONE_MOVE_KB",&"GREECE_HINT_DRONE_MOVE_SP");
	maps\_utility::add_control_based_hint_strings("drone_shoot",&"GREECE_HINT_DRONE_JUSTSHOOT",::hintdroneshootoff);
	precachestring(&"GREECE_WARN_DRONE_DRYFIRE");
	precachestring(&"GREECE_WARN_INCOMING_MISSILE");
	precachemodel("vehicle_sniper_drone_outerparts");
	precachemodel("vehicle_sniper_drone_outerparts_cloak");
	precachemodel("vehicle_vm_sniper_drone");
	precachemodel("vehicle_vm_sniper_drone_cloak");
	precachemodel("vehicle_sniper_drone_hud_glass");
	precachemodel("vehicle_sniper_drone_hud_glass_break");
}

//Function Number: 2
initializesniperdronedata()
{
	var_00 = spawnstruct();
	var_00.droneangularvelocity = 0;
	var_00.droneverticalvelocity = 0;
	var_00.calculatenewhoverdestination = 1;
	var_00.dronehoverdirection = (0,0,-1);
	var_00.hoverspeed = 1;
	var_00.lasthoveroffset = (0,0,0);
	var_00.hoverbounceconeangle = 120;
	var_00.lastrecoiloffset = (0,0,0);
	var_00.recoildirection = (0,0,0);
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
	var_00.dronesattackspeedmultiplier = 0.9;
	return var_00;
}

//Function Number: 3
alerthighlighthudeffect(param_00)
{
	level.player notify("AlertHudEffect");
	level.player endon("AlertHudEffect");
	var_01 = newclienthudelem(level.player);
	var_01.color = (1,0.05,0.025);
	var_01.alpha = 1;
	var_01 setradarhighlight(param_00);
	return var_01;
}

//Function Number: 4
initdroneflyinturnrate()
{
	setsaveddvar("aim_turnrate_pitch",30);
	setsaveddvar("aim_turnrate_pitch_ads",25);
	setsaveddvar("aim_turnrate_yaw",60);
	setsaveddvar("aim_turnrate_yaw_ads",40);
	setsaveddvar("aim_accel_turnrate_lerp",300);
}

//Function Number: 5
initdroneturnrate()
{
	setsaveddvar("aim_turnrate_pitch",70);
	setsaveddvar("aim_turnrate_pitch_ads",55);
	setsaveddvar("aim_turnrate_yaw",125);
	setsaveddvar("aim_turnrate_yaw_ads",90);
	setsaveddvar("aim_accel_turnrate_lerp",600);
}

//Function Number: 6
savedefaultturnrate()
{
	self.aim_turnrate_pitch = getdvarint("aim_turnrate_pitch");
	self.aim_turnrate_pitch_ads = getdvarint("aim_turnrate_pitch_ads");
	self.aim_turnrate_yaw = getdvarint("aim_turnrate_yaw");
	self.aim_turnrate_yaw_ads = getdvarint("aim_turnrate_yaw_ads");
	self.aim_accel_turnrate_lerp = getdvarint("aim_accel_turnrate_lerp");
}

//Function Number: 7
restoredefaultturnrate()
{
	setsaveddvar("aim_turnrate_pitch",self.aim_turnrate_pitch);
	setsaveddvar("aim_turnrate_pitch_ads",self.aim_turnrate_pitch_ads);
	setsaveddvar("aim_turnrate_yaw",self.aim_turnrate_yaw);
	setsaveddvar("aim_turnrate_yaw_ads",self.aim_turnrate_yaw_ads);
	setsaveddvar("aim_accel_turnrate_lerp",self.aim_accel_turnrate_lerp);
}

//Function Number: 8
startdronecontrol(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getdvarfloat("g_friendlyNameDist");
	setomnvar("ui_sniperdrone",1);
	maps\_shg_utility::hide_player_hud();
	setsaveddvar("compass","1");
	common_scripts\utility::create_dvar("SniperDrone_Hide",0);
	var_07 = level.player getcurrentweapon();
	var_08 = getdvarint("cg_fov",65) * getdvarfloat("cg_playerFovScale0",1);
	var_09 = distance2d(param_00.origin,param_01.origin);
	var_0A = vectortoangles(param_01.origin - param_00.origin);
	level.player hideviewmodel();
	level.player disableweaponswitch();
	level.player disableoffhandweapons();
	level.player allowcrouch(0);
	var_0B = initializesniperdronedata();
	var_0C = common_scripts\utility::spawn_tag_origin();
	level.player.sniperdronelink = var_0C;
	level.player.sniperdronedata = var_0B;
	initorbitlowerbounds(param_00.origin,param_05);
	soundscripts\_snd::snd_message("start_sniper_drone");
	level.droneweapon = "hms_sniperdrone";
	level.player giveweapon(level.droneweapon);
	level.player switchtoweaponimmediate(level.droneweapon);
	level.variable_scope_weapons = ["hms_sniperdrone"];
	maps\_hms_utility::printlnscreenandconsole("Drone is now armed with " + level.droneweapon);
	var_0B.frameviewmodel = spawn("script_model",var_0C.origin);
	var_0B.frameviewmodel setmodel("vehicle_sniper_drone_outerparts_cloak");
	var_0B.frameviewmodel linktoplayerview(level.player,"tag_origin",(13,0,-3),(0,0,0),1);
	var_0C.frameviewmodel = var_0B.frameviewmodel;
	var_0B.frameviewmodel childthread viewmodelanimupdate(%sniper_drone_outerparts_idle,%sniper_drone_outerparts_fire);
	var_0B.frameviewmodel thread sniperdronecloak();
	var_0B.barrelviewmodel = spawn("script_model",var_0C.origin);
	var_0B.barrelviewmodel setmodel("vehicle_vm_sniper_drone_cloak");
	var_0B.barrelviewmodel linktoplayerview(level.player,"tag_origin",(-1,0,-1.75),(0,0,0),1);
	var_0C.barrelviewmodel = var_0B.barrelviewmodel;
	var_0B.barrelviewmodel childthread viewmodelanimupdate(%sniper_drone_vm_idle,%sniper_drone_vm_fire);
	var_0B.barrelviewmodel thread sniperdronecloak();
	if(!level.currentgen)
	{
		var_0B.lensviewmodel = spawn("script_model",var_0C.origin);
		var_0B.lensviewmodel setmodel("vehicle_sniper_drone_hud_glass");
		var_0B.lensviewmodel linktoplayerview(level.player,"tag_origin",(9,0,0),(0,0,0),1);
		childthread sniperdronelensdamaged();
	}

	playfxontag(common_scripts\utility::getfx("sniper_drone_thruster_view"),var_0B.barrelviewmodel,"TAG_ORIGIN");
	playfxontag(common_scripts\utility::getfx("sniper_drone_wind_marker"),var_0B.barrelviewmodel,"TAG_ORIGIN");
	setsaveddvar("cg_drawBreathHint",0);
	var_0D = sniperdroneoverlays();
	var_0E = alerthighlighthudeffect(3600);
	level.player enableweapons();
	level.player enableinvulnerability();
	childthread dofiringeffects();
	childthread doadsblur(param_04);
	childthread adjustfov(param_04,var_0D["black_sides"],var_0D["tech"]);
	childthread adjustshadowcenter(param_04);
	childthread cameralookatescapevehicle(param_00,var_0A,var_09);
	childthread updateflyinscopeoverlay(var_0D["scope"],param_01.origin[2]);
	childthread updateviewmodelvisibility();
	if(!param_04)
	{
		thread disabledronefiringatstart(param_03);
	}

	level.player.sniperdronelink savedefaultturnrate();
	if(param_03)
	{
		var_0C initdroneflyinturnrate();
		maps\greece_conf_center::sniperdroneflyin(var_0C);
		level.player playerlinktodelta(var_0C,"tag_origin",0,90,90,20,60,1);
		var_0F = var_0C.angles;
		var_10 = vectortoangles(param_00.origin - param_01.origin) * (0,1,0);
		var_11 = 0;
		while(var_11 <= 1)
		{
			wait(0.05);
			var_11 = var_11 + 0.1;
			var_12 = euler_lerp(var_0F * (1,0,0),var_10 * (1,0,0),var_11) * (1,0,0);
			var_0C.angles = (var_12[0],var_0C.angles[1],var_0C.angles[2]);
		}

		var_11 = 0;
		while(var_11 <= 1)
		{
			wait(0.05);
			var_11 = var_11 + 0.2;
			var_13 = euler_lerp(var_0F * (0,1,0),var_10 * (0,1,0),var_11) * (0,1,0);
			var_0C.angles = (var_0C.angles[0],var_13[1],var_0C.angles[2]);
		}
	}
	else
	{
		level.player setplayerangles(vectortoangles(param_02.origin - param_01.origin));
	}

	initdroneturnrate();
	calculateinitialposition(param_01.origin,param_00,var_0A,var_09);
	level.player playerlinktodelta(var_0C,"tag_origin",1,90,90,20,60,1);
	var_14 = var_0C.origin;
	var_15 = 0;
	var_16 = 0;
	setsaveddvar("g_friendlyNameDist",15000);
	while(isdefined(level.player.sniperdronelink))
	{
		wait(0.05);
		if(common_scripts\utility::flag("FlagPlayerEndDroneStatic") || common_scripts\utility::flag("FlagSniperDroneAnimating") || common_scripts\utility::flag("FlagSniperDroneLookAt"))
		{
			continue;
		}

		setomnvar("ui_sniperdrone",1);
		updatescopeoverlay(var_0D["scope"],var_16,param_04);
		updatedronesattackspeedmultiplier();
		var_0B.droneangularvelocity = updatehorizontalvelocity();
		var_0B.droneverticalvelocity = updateverticalvelocity();
		var_17 = angleclamp(var_15 + var_0B.droneangularvelocity * 0.05);
		var_18 = combineangles((0,var_17,0),var_0A);
		var_19 = var_16 + var_0B.droneverticalvelocity * 0.05;
		var_19 = clamp(var_19,-900,900);
		var_1A = var_14;
		var_1B = param_00.origin + (0,0,var_19);
		var_14 = var_1B + anglestoforward(var_18) * var_09;
		var_1C = clamppositiontolowerbounds(var_14,param_00.origin);
		var_14 = (var_14[0],var_14[1],var_14[2] + var_1C);
		var_19 = var_19 + var_1C;
		var_17 = clampyaworbitoffset(var_14,param_00.origin,var_0A);
		var_1D = updatehoveridle(var_14);
		var_0B.lasthoveroffset = var_0B.lasthoveroffset + var_1D;
		var_1E = updaterecoiloffset();
		var_0C.origin = var_14 + var_0B.lasthoveroffset + var_1E;
		var_0B.currentvelocity = var_14 - var_1A;
		var_1F = vectortoangles(var_1B - var_14);
		var_1F = var_1F * (0,1,0);
		var_1F = updatebodyroll(var_1F);
		var_0C.angles = var_1F;
		var_15 = var_17;
		var_16 = var_19;
	}

	setsaveddvar("sm_sunShadowCenter","0 0 0");
	setsaveddvar("sm_lightScore_eyeProjectDist",64);
	setsaveddvar("sv_znear","0");
	common_scripts\utility::flag_set("init_safehouse_outro_start_lighting");
	level.player disableinvulnerability();
	level.player enableweaponswitch();
	level.player enableoffhandweapons();
	level.player allowads(1);
	level.player allowcrouch(1);
	level.player takeweapon(level.droneweapon);
	maps\_shg_utility::show_player_hud();
	foreach(var_21 in var_0D)
	{
		var_21 destroy();
	}

	var_0E destroy();
	var_0B.frameviewmodel unlinkfromplayerview(level.player);
	var_0B.barrelviewmodel unlinkfromplayerview(level.player);
	if(!level.currentgen)
	{
		var_0B.damagedlensviewmodel unlinkfromplayerview(level.player);
	}

	level.player unlink();
	maps\_utility::teleport_player(common_scripts\utility::getstruct("PlayerStartConfCenter","targetname"));
	level.player showviewmodel();
	level.player lerpfov(var_08,0.5);
	level.player disablefocus(2);
	level.player disableaudiozoom(1);
	setsaveddvar("cg_drawBreathHint",1);
	setsaveddvar("g_friendlyNameDist",var_06);
	soundscripts\_snd::snd_message("stop_sniper_drone");
	level.player switchtoweaponimmediate(var_07);
}

//Function Number: 9
sniperdronecloak()
{
	self drawpostresolve();
	self setmaterialscriptparam(0,0);
	common_scripts\utility::flag_wait("FlagSniperDroneCloakOff");
	self drawpostresolveoff();
	self setmaterialscriptparam(1,1);
}

//Function Number: 10
sniperdroneoverlays()
{
	var_00 = [];
	var_00["scope"] = createoverlay("white_multiply",0);
	var_00["static"] = createoverlay("overlay_static_digital",0.01);
	var_00["scanlines"] = createoverlay("sentinel_drone_scanlines",0);
	var_00["distort"] = createoverlay("sentinel_drone_overlay_distort",0);
	var_00["scratches"] = createoverlay("remote_chopper_overlay_scratches",0);
	childthread flickerstaticoverlay(var_00["static"],"FlagPlayerStartDroneFlight",0.1,2.5,0,0.1);
	childthread flickerstaticoverlay(var_00["scanlines"],"FlagSniperDroneFlinch",0.5,7.5,0,0.25);
	childthread flickerstaticoverlay(var_00["static"],"FlagSniperDroneFlinch",0.25,2.5);
	childthread adjuststaticoverlay(var_00["scratches"],"FlagSniperDroneFlinch",1,undefined,0.5);
	thread sniperdronemissilewarnmsg();
	childthread flickerstaticoverlay(var_00["scanlines"],"FlagSniperDroneHit",0.75,5,0,0.25);
	childthread flickerstaticoverlay(var_00["static"],"FlagSniperDroneHit",0.5,5);
	childthread adjuststaticoverlay(var_00["static"],"FlagPlayerEndDroneStatic",1);
	childthread flickerstaticoverlay(var_00["scanlines"],"FlagPlayerEndDroneStatic",0.75,1);
	return var_00;
}

//Function Number: 11
viewmodelanimupdate(param_00,param_01)
{
	self useanimtree(#animtree);
	var_02 = getanimlength(param_01);
	var_03 = 0;
	while(isdefined(level.player.sniperdronelink))
	{
		if(!var_03)
		{
			self setanimknob(param_00);
			level.player waittill("weapon_fired");
		}

		self setanimknobrestart(param_01);
		var_03 = 0;
		if(!isdefined(waittillplayerfireortime(var_02)))
		{
			var_03 = 1;
		}
	}
}

//Function Number: 12
waittillplayerfireortime(param_00)
{
	level.player endon("weapon_fired");
	wait(param_00);
	return 1;
}

//Function Number: 13
disabledronefiringatstart(param_00)
{
	level.player allowfire(0);
	if(param_00 == 1)
	{
		common_scripts\utility::flag_wait("FlagPlayerEndDroneFlight");
	}

	thread sniperdronedryfire("FlagOkayToShootDrone");
	wait(1);
	hintsniperdronemove();
	common_scripts\utility::flag_wait("FlagOkayToShootDrone");
	level notify("SniperdroneSafetyOff");
	level.player allowfire(1);
	wait(0.05);
	thread maps\greece_code::warning_fade();
	hintsniperdroneshoot();
}

//Function Number: 14
disabledronefiringafterkill()
{
	level.player allowfire(0);
	thread sniperdronedryfire("FlagConfRoomAlliesRecover");
	common_scripts\utility::flag_wait("FlagConfRoomAlliesRecover");
	level notify("SniperdroneSafetyOff");
	level.player allowfire(1);
	wait(0.05);
	thread maps\greece_code::warning_fade();
}

//Function Number: 15
disabledronefiringduringcrash()
{
	level.player allowfire(0);
	level.player allowads(0);
	thread sniperdronebadfire();
}

//Function Number: 16
sniperdronedryfire(param_00)
{
	level endon("SniperdroneSafetyOff");
	while(!common_scripts\utility::flag(param_00))
	{
		if(level.player attackbuttonpressed())
		{
			soundscripts\_snd::snd_message("sniper_drone_dry_fire");
			thread sniperdronedryfiremsg();
		}

		wait 0.05;
	}

	thread maps\greece_code::warning_fade();
}

//Function Number: 17
sniperdronedryfiremsg()
{
	thread maps\greece_code::warning(&"GREECE_WARN_DRONE_DRYFIRE");
	wait(3);
	thread maps\greece_code::warning_fade();
}

//Function Number: 18
sniperdronemissilewarnmsg()
{
	common_scripts\utility::flag_wait("FlagHadesVehicleDroneLaunch");
	thread maps\greece_code::warning(&"GREECE_WARN_INCOMING_MISSILE",undefined,60,2);
	common_scripts\utility::flag_wait("FlagSniperDroneHit");
	thread maps\greece_code::warning_fade();
}

//Function Number: 19
sniperdronebadfire()
{
	level endon("EndDroneControl");
	while(!common_scripts\utility::flag("FlagPlayerEndDroneControl"))
	{
		if(level.player attackbuttonpressed())
		{
			soundscripts\_snd::snd_message("sniper_drone_dmg_fire");
		}

		wait 0.05;
	}
}

//Function Number: 20
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

//Function Number: 21
calculateinitialposition(param_00,param_01,param_02,param_03)
{
	level.player.sniperdronelink.origin = param_01.origin + anglestoforward(param_02) * param_03;
	level.player.sniperdronelink.angles = vectortoangles(param_01.origin - param_00) * (0,1,0);
}

//Function Number: 22
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

//Function Number: 23
getlookpitch()
{
	var_00 = level.player getplayerangles();
	return clamplookangle(var_00[0]);
}

//Function Number: 24
getlookyaw()
{
	var_00 = level.player getplayerangles();
	return clamplookangle(var_00[1]) - clamplookangle(level.player.sniperdronelink.angles[1]);
}

//Function Number: 25
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

//Function Number: 26
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

//Function Number: 27
updateviewmodelvisibility()
{
	level.player endon("death");
	level endon("end_sniper_drone");
	var_00 = 0;
	for(;;)
	{
		wait(0.05);
		if(getdvarint("SniperDrone_Hide") == 1 && !var_00)
		{
			level.player.sniperdronedata.frameviewmodel hide();
			level.player.sniperdronedata.barrelviewmodel hide();
			if(isdefined(level.player.sniperdronedata.lensviewmodel))
			{
				level.player.sniperdronedata.lensviewmodel hide();
			}

			var_00 = 1;
			continue;
		}

		if(getdvarint("SniperDrone_Hide") == 0 && var_00)
		{
			level.player.sniperdronedata.frameviewmodel show();
			level.player.sniperdronedata.barrelviewmodel show();
			if(isdefined(level.player.sniperdronedata.lensviewmodel))
			{
				level.player.sniperdronedata.lensviewmodel show();
			}

			var_00 = 0;
		}
	}
}

//Function Number: 28
cameralookatescapevehicle(param_00,param_01,param_02)
{
	level.player endon("death");
	level endon("end_sniper_drone");
	common_scripts\utility::flag_wait("FlagHadesVehicleDroneLaunch");
	var_03 = getvehiclenode("HadesEscapeVehicleStart","targetname");
	common_scripts\utility::flag_set("FlagSniperDroneLookAt");
	level.player allowads(0);
	var_04 = (0,0,0);
	foreach(var_06 in level.allenemyvehicles)
	{
		if(isdefined(var_06.escapevehicle))
		{
			var_04 = var_06.origin;
		}
	}

	var_08 = vectortoangles(var_04 - level.player.sniperdronelink.origin);
	clearmovementparameters();
	lerpplayerlook(var_08);
	common_scripts\utility::flag_clear("FlagSniperDroneLookAt");
}

//Function Number: 29
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
		updatescopeoverlayalpha(0,param_00);
		luinotifyevent(&"sniper_drone_hud_update",8,int(maps\_utility::round_float(var_04 * 100,0,0)),0,int(var_03),0,0,int(param_00.alpha * 10),0,gettime());
		var_05 = level.player.sniperdronelink.angles[0];
		if(common_scripts\utility::flag("FlagSniperDroneLookAt"))
		{
			var_05 = getlookpitch();
		}

		updateviewmodelpitchoffset(var_05);
		level.player.sniperdronedata.frameviewmodel unlinkfromplayerview(level.player);
		level.player.sniperdronedata.frameviewmodel linktoplayerview(level.player,"tag_origin",level.player.sniperdronedata.frameviewmodeloffset,(0,0,0),1);
		level.player.sniperdronedata.barrelviewmodel unlinkfromplayerview(level.player);
		level.player.sniperdronedata.barrelviewmodel linktoplayerview(level.player,"tag_origin",level.player.sniperdronedata.barrelviewmodeloffset,(0,0,0),1);
	}
}

//Function Number: 30
hintsniperdronemove()
{
	thread notifyonplayermovingsniperdrone();
	thread maps\_utility::hintdisplaymintimehandler("drone_move",15,5);
}

//Function Number: 31
hintdronemoveoff()
{
	if(isdefined(level.playermovingdrone) && level.playermovingdrone == 1)
	{
		return level.playermovingdrone;
	}
	else if(common_scripts\utility::flag("FlagGateGuardsAtAllyVehicle"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
notifyonplayermovingsniperdrone()
{
	for(;;)
	{
		var_00 = level.player getnormalizedmovement();
		if(length(var_00) != 0)
		{
			level.playermovingdrone = 1;
			break;
		}

		wait(0.05);
	}
}

//Function Number: 33
hintsniperdroneshoot()
{
	thread maps\_utility::hintdisplaymintimehandler("drone_shoot",10,3);
}

//Function Number: 34
hintdroneshootoff()
{
	return level.player attackbuttonpressed();
}

//Function Number: 35
dofiringeffects()
{
	level endon("end_sniper_drone");
	level.player endon("death");
	var_00 = common_scripts\utility::getfx("sniper_drone_flash_view");
	var_01 = common_scripts\utility::getfx("sniper_drone_tracer");
	var_02 = level.player common_scripts\utility::spawn_tag_origin();
	var_02 linktoplayerview(level.player,"tag_origin",(0,0,-5),(0,0,0),1);
	while(level.droneweapon == "hms_sniperdrone")
	{
		level.player waittill("weapon_fired");
		level.player shellshock("barrett",0.3);
		level.player.sniperdronedata.recoildirection = anglestoforward(level.player getgunangles()) * -1;
		level.player.sniperdronedata.calculatenewhoverdestination = 1;
		level.player.sniperdronedata.lastrecoiloffset = (0,0,0);
		if(level.player adsbuttonpressed())
		{
			var_03 = level.player geteye();
			var_04 = anglestoforward(level.player getgunangles());
			var_05 = var_03 + var_04 * 100;
			var_06 = var_03 + var_04 * 5000;
			var_07 = bullettrace(var_05,var_06,1,undefined,0,1);
			var_08 = var_03 - (0,0,5);
			var_09 = var_07["position"] - var_08;
			playfx(var_01,var_08,var_09,(0,0,1));
			screenshake(level.player.origin,0.25,0,0,0.2,0.1,0.1,0,0.5);
			continue;
		}

		playfxontag(var_00,level.player.sniperdronedata.barrelviewmodel,"tag_flash");
		playfxontag(var_01,level.player.sniperdronedata.barrelviewmodel,"tag_flash");
	}
}

//Function Number: 36
updaterecoiloffset(param_00)
{
	if(level.player.sniperdronedata.recoildirection != (0,0,0))
	{
		var_01 = level.player.sniperdronedata.recoildirection * 250;
		level.player.sniperdronedata.recoildirection = (0,0,0);
		level.player.sniperdronedata.lastrecoiloffset = var_01;
		return var_01;
	}

	if(level.player.sniperdronedata.lastrecoiloffset == (0,0,0))
	{
		return (0,0,0);
	}

	level.player.sniperdronedata.lastrecoiloffset = vectorlerp(level.player.sniperdronedata.lastrecoiloffset,(0,0,0),0.1);
	return level.player.sniperdronedata.lastrecoiloffset;
}

//Function Number: 37
isadsenabled(param_00)
{
	if(common_scripts\utility::flag("FlagHadesVehicleDroneLaunch") || common_scripts\utility::flag("FlagConfRoomExplosion"))
	{
		return 0;
	}

	if(!param_00 && !common_scripts\utility::flag("FlagMonitorZoomOnHades") && !common_scripts\utility::flag("FlagGateGuardsApproachingAllyVehicle") && !common_scripts\utility::flag("FlagConfRoomExplosion") && !common_scripts\utility::flag("FlagHadesVehicleDroneLaunch"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 38
doadsblur(param_00)
{
	level.player endon("death");
	level endon("end_sniper_drone");
	var_01 = level.player adsbuttonpressed();
	for(;;)
	{
		wait(0.05);
		if(common_scripts\utility::flag("FlagForcePlayerADS") || !isadsenabled(param_00))
		{
			continue;
		}

		var_02 = level.player adsbuttonpressed();
		if(!var_01 && var_02)
		{
			level.player setblurforplayer(2,0.1);
			wait(0.3);
			level.player setblurforplayer(0,0.1);
		}
		else if(var_01 && !var_02)
		{
			level.player setblurforplayer(2,0.1);
			wait(0.3);
			level.player setblurforplayer(0,0.1);
		}

		var_01 = var_02;
	}
}

//Function Number: 39
adjustfov(param_00,param_01,param_02)
{
	level.player endon("death");
	level endon("end_sniper_drone");
	var_03 = 40;
	var_04 = 7.5;
	var_05 = 0;
	var_06 = 0;
	level.player lerpfov(var_03,0.5);
	level.player enablefocus(var_04 / 2,var_04,1,0);
	while(isdefined(level.player.sniperdronelink))
	{
		wait(0.05);
		if(!isdefined(level.player.sniperdronelink))
		{
			break;
		}

		if(issaverecentlyloaded() && !var_06)
		{
			var_05 = 1;
			var_06 = 1;
		}
		else if(!issaverecentlyloaded())
		{
			var_06 = 0;
		}

		if((isadsenabled(param_00) && level.player adsbuttonpressed()) || common_scripts\utility::flag("FlagForcePlayerADS"))
		{
			if(!var_05)
			{
				level.player lerpfov(var_04,0.25);
				level.player enablefocus(7.5,20,0.125,1);
				level.player enableaudiozoom(2,1);
				var_05 = 1;
			}

			continue;
		}

		if(var_05)
		{
			level.player lerpfov(var_03,0.5);
			level.player enablefocus(7.5,20,1,1);
			level.player disableaudiozoom(1);
			var_05 = 0;
		}
	}
}

//Function Number: 40
updatesunshadowcenter(param_00,param_01)
{
	var_02 = anglestoforward(level.player getgunangles());
	var_03 = param_01;
	var_04 = level.player geteye() + var_02 * 100;
	var_05 = level.player.origin + var_02 * 5000;
	var_06 = bullettrace(var_04,var_05,1,level.player);
	if(isdefined(var_06["position"]))
	{
		var_07 = distance(var_04,var_06["position"]);
		var_03 = param_00.origin + var_02 * var_07 * 0.9;
	}

	setsaveddvar("sm_sunShadowCenter",var_03);
}

//Function Number: 41
adjustshadowcenter(param_00)
{
	level.player endon("death");
	level endon("end_sniper_drone");
	var_01 = 0;
	var_02 = getent("PlayerDroneTargetpoint","targetname");
	while(isdefined(level.player.sniperdronelink))
	{
		wait(0.1);
		if(!isdefined(level.player.sniperdronelink))
		{
			break;
		}

		if((isadsenabled(param_00) && level.player adsbuttonpressed()) || common_scripts\utility::flag("FlagForcePlayerADS"))
		{
			updatesunshadowcenter(level.player.sniperdronelink,var_02);
			if(!var_01)
			{
				level.player lightsetforplayer("confcenter_drone_zoom");
				var_01 = 1;
			}

			continue;
		}

		if(var_01)
		{
			setsaveddvar("sm_sunShadowCenter","0 0 0");
			level.player lightsetforplayer("confcenter_start");
			var_01 = 0;
		}
	}
}

//Function Number: 42
adjuststaticoverlay(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00.alpha;
	common_scripts\utility::flag_wait(param_01);
	if(isdefined(param_04))
	{
		wait(param_04);
	}

	param_00.alpha = param_02;
	if(isdefined(param_03))
	{
		wait(param_03);
		param_00.alpha = var_05;
	}
}

//Function Number: 43
flickerstaticoverlay(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00.alpha;
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_07 = 0.01 + param_04;
	var_08 = 0.05 + param_04;
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_09 = 0.25 + param_05;
	var_0A = 0.75 + param_05;
	common_scripts\utility::flag_wait(param_01);
	var_0B = gettime() * 0.001;
	var_0C = 0;
	while(var_0C < param_03)
	{
		if(isdefined(param_00))
		{
			param_00.alpha = param_02;
		}

		wait(randomfloatrange(var_07,var_08));
		soundscripts\_snd::snd_message("start_wasp_flicker");
		if(isdefined(param_00))
		{
			param_00.alpha = var_06;
		}

		wait(randomfloatrange(var_09,var_0A));
		var_0D = gettime() * 0.001;
		var_0C = var_0D - var_0B;
		wait(0.05);
	}
}

//Function Number: 44
adjustmissileoverlay(param_00,param_01,param_02)
{
	common_scripts\utility::flag_wait(param_01);
	param_00.alpha = 1;
	soundscripts\_snd::snd_message("start_wasp_missile_warning");
	common_scripts\utility::flag_wait(param_02);
	param_00.alpha = 0;
	soundscripts\_snd::snd_message("stop_wasp_missile_warning");
}

//Function Number: 45
sniperdronelensdamaged()
{
	level.player waittill("kamikaze_damaged_lens");
	level.player.sniperdronedata.lensviewmodel unlinkfromplayerview(level.player);
	level.player.sniperdronedata.lensviewmodel hide();
	level.player.sniperdronedata.lensviewmodel delete();
	level.player.sniperdronedata.damagedlensviewmodel = spawn("script_model",level.player.sniperdronelink.origin);
	level.player.sniperdronedata.damagedlensviewmodel setmodel("vehicle_sniper_drone_hud_glass_break");
	level.player.sniperdronedata.damagedlensviewmodel linktoplayerview(level.player,"tag_origin",(9,0,0),(0,0,0),1);
}

//Function Number: 46
enddronecontrol()
{
	rumblesniperdronetakenout();
	level.player.sniperdronelink restoredefaultturnrate();
	wait(0.75);
	level.player setblurforplayer(10,0.5);
	maps\_hud_util::fade_out(0.25,"white");
	level.player.sniperdronelink = undefined;
	setomnvar("ui_sniperdrone",0);
	soundscripts\_snd::snd_message("stop_drone_death_static");
	wait(0.25);
	common_scripts\utility::flag_set("init_safehouse_outro_start_lighting");
	level.player setblurforplayer(0,0.1);
	common_scripts\utility::flag_set("FlagSafeHouseOutroStart");
}

//Function Number: 47
iscontrollingdrone()
{
	return isdefined(level.player.sniperdronelink);
}

//Function Number: 48
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

//Function Number: 49
createmissileoverlay(param_00,param_01)
{
	var_02 = newclienthudelem(level.player);
	var_02.x = 320;
	var_02.y = 350;
	var_02.sort = 0;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02 setshader(param_00,256,64);
	var_02.alpha = 0;
	return var_02;
}

//Function Number: 50
updatescopeoverlayalpha(param_00,param_01)
{
	if(((isadsenabled(param_00) && level.player adsbuttonpressed()) || common_scripts\utility::flag("FlagForcePlayerADS")) && param_01.alpha < 1)
	{
		param_01.alpha = param_01.alpha + 0.2;
		soundscripts\_snd::snd_message("start_sniper_drone_zoom");
		return;
	}

	if(!level.player adsbuttonpressed() || common_scripts\utility::flag("FlagForcePlayerADS") && param_01.alpha > 0)
	{
		param_01.alpha = param_01.alpha - 0.2;
		soundscripts\_snd::snd_message("stop_sniper_drone_zoom");
	}
}

//Function Number: 51
updatescopeoverlay(param_00,param_01,param_02)
{
	var_03 = level.player getnormalizedmovement();
	var_04 = level.player getnormalizedcameramovements();
	updatescopeoverlayalpha(param_02,param_00);
	luinotifyevent(&"sniper_drone_hud_update",8,int(maps\_utility::round_float(var_03[1] * 100,0,0)),int(maps\_utility::round_float(var_04[1] * 100,0,0)),int(param_01),int(getlookpitch()),int(getlookyaw()),int(param_00.alpha * 10),int(level.player.sniperdronedata.droneangularvelocity),gettime());
}

//Function Number: 52
updatedronesattackspeedmultiplier()
{
	if(!common_scripts\utility::flag("FlagHadesVehicleDriveStart"))
	{
		return;
	}

	level.player.sniperdronedata.dronesattackspeedmultiplier = level.player.sniperdronedata.dronesattackspeedmultiplier - 0.015;
	level.player.sniperdronedata.dronesattackspeedmultiplier = clamp(level.player.sniperdronedata.dronesattackspeedmultiplier,0.75,1);
}

//Function Number: 53
setupsniperdebughudelem()
{
	var_00 = newhudelem();
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.x = 40;
	var_00.y = 40;
	var_00.alpha = 0.6;
	var_00.fontscale = 1.5;
	var_00.foreground = 1;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	return var_00;
}

//Function Number: 54
drawsniperdebug(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "yawOrbitOffset " + param_01 + " verticalOffset " + param_02;
	param_00 settext(var_05);
	common_scripts\utility::draw_arrow_time(param_03,param_04,(0,1,0),0.05);
}

//Function Number: 55
compareorbitangle(param_00,param_01)
{
	return param_00.orbitangle < param_01.orbitangle;
}

//Function Number: 56
settargetangularacceleration(param_00)
{
	if(abs(level.player.sniperdronedata.targetangularacceleration) > abs(param_00))
	{
		return;
	}

	level.player.sniperdronedata.targetangularacceleration = param_00;
}

//Function Number: 57
updatetargetangularacceleration()
{
	if(!isdefined(level.player.sniperdronedata))
	{
		return;
	}

	level.player.sniperdronedata.targetangularacceleration = level.player.sniperdronedata.targetangularacceleration * 0.95;
}

//Function Number: 58
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

//Function Number: 59
scalevelocity(param_00)
{
	if(level.player adsbuttonpressed() || common_scripts\utility::flag("FlagForcePlayerADS"))
	{
		param_00 = param_00 * 0.85;
	}

	if(common_scripts\utility::flag("FlagHadesVehicleDriveStart") || common_scripts\utility::flag("FlagForcePlayerSlowMovement"))
	{
		param_00 = param_00 * level.player.sniperdronedata.dronesattackspeedmultiplier;
	}

	if(level.player adsbuttonpressed() && level.player enemyincrosshairs())
	{
		param_00 = param_00 * 0.85;
	}

	return param_00;
}

//Function Number: 60
updatehorizontalvelocity()
{
	var_00 = maps\greece_code::calculateleftstickdeadzone();
	var_01 = updatevelocity(level.player.sniperdronedata,var_00[1],level.player.sniperdronedata.droneangularvelocity,1.25,35,0.9,0.4,10,8);
	return scalevelocity(var_01);
}

//Function Number: 61
updateverticalvelocity()
{
	var_00 = maps\greece_code::calculateleftstickdeadzone();
	var_01 = updatevelocity(undefined,var_00[0],level.player.sniperdronedata.droneverticalvelocity,15,375,0.75,0.4,150,125);
	return scalevelocity(var_01);
}

//Function Number: 62
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

//Function Number: 63
clampyaworbitoffset(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_00 - param_01 * (1,1,0));
	var_03 = var_03 - param_02;
	return var_03[1];
}

//Function Number: 64
calculatehoverlocation(param_00)
{
	var_01 = param_00 + level.player.sniperdronedata.dronehoverdirection * 50;
	return vectornormalize(var_01 - level.player.sniperdronelink.origin) * level.player.sniperdronedata.hoverspeed;
}

//Function Number: 65
updatehoverspeed(param_00)
{
	var_01 = param_00 + level.player.sniperdronedata.dronehoverdirection * 50;
	var_02 = 10;
	var_03 = length(var_01 - level.player.sniperdronelink.origin);
	if(var_03 > var_02)
	{
		level.player.sniperdronedata.hoverspeed = level.player.sniperdronedata.hoverspeed + 0.5;
		level.player.sniperdronedata.hoverspeed = clamp(level.player.sniperdronedata.hoverspeed,-1,1);
		return;
	}

	var_04 = maps\_shg_utility::linear_map_clamp(var_03,0,var_02,0,1);
	level.player.sniperdronedata.hoverspeed = maps\_utility::linear_interpolate(var_04,0.5,1);
}

//Function Number: 66
updatehoveridle(param_00)
{
	if(level.player maps\_utility::isads())
	{
		level.player.sniperdronedata.calculatenewhoverdestination = 1;
	}
	else if(abs(level.player.sniperdronedata.droneangularvelocity) > 0.05 || abs(level.player.sniperdronedata.droneverticalvelocity) > 0.05)
	{
		level.player.sniperdronedata.calculatenewhoverdestination = 1;
		level.player.sniperdronedata.hoverbounceconeangle = 30;
		level.player.sniperdronedata.dronehoverdirection = vectornormalize(level.player.sniperdronedata.currentvelocity) * -1;
	}
	else if(level.player.sniperdronedata.calculatenewhoverdestination)
	{
		level.player.sniperdronedata.calculatenewhoverdestination = 0;
		level.player.sniperdronedata.dronehoverdirection = common_scripts\utility::randomvectorincone(level.player.sniperdronedata.dronehoverdirection * -1,level.player.sniperdronedata.hoverbounceconeangle);
		level.player.sniperdronedata.dronehoverdirection = vectornormalize(level.player.sniperdronedata.dronehoverdirection);
		level.player.sniperdronedata.hoverbounceconeangle = 120;
		level.player.sniperdronedata.hoverspeed = 0;
		return calculatehoverlocation(param_00);
	}
	else
	{
		updatehoverspeed(param_00);
		var_01 = param_00 + level.player.sniperdronedata.dronehoverdirection * 50;
		if(lengthsquared(level.player.sniperdronelink.origin - var_01) < squared(3))
		{
			level.player.sniperdronedata.calculatenewhoverdestination = 1;
		}

		return calculatehoverlocation(param_00);
	}

	return (0,0,0);
}

//Function Number: 67
updateviewmodelacceleration(param_00)
{
	var_01 = level.player.sniperdronedata;
	if(level.player maps\_utility::isads())
	{
		var_01.framerollacceleration = vectorlerp(var_01.framerollacceleration,(0,0,0),0.1);
		var_01.barrelrollacceleration = vectorlerp(var_01.barrelrollacceleration,(0,0,0),0.1);
		return;
	}

	if(var_01.stickhorizontalinputlength >= 0.1)
	{
		var_01.framerollacceleration = vectorlerp(var_01.framerollacceleration,param_00 * var_01.targetangularacceleration,0.1);
		var_01.barrelrollacceleration = vectorlerp(var_01.barrelrollacceleration,param_00 * var_01.targetangularacceleration,0.05);
		return;
	}

	var_02 = 0.4 * squared(var_01.brakingcurrenttime);
	var_03 = 0.9 * squared(var_01.brakingcurrenttime);
	var_01.framerollacceleration = vectorlerp(var_01.framerollacceleration,param_00 * var_01.targetangularacceleration,var_02);
	var_01.barrelrollacceleration = vectorlerp(var_01.barrelrollacceleration,param_00 * var_01.targetangularacceleration,var_03);
	var_01.brakingcurrenttime = var_01.brakingcurrenttime + 0.05;
	var_01.brakingcurrenttime = clamp(var_01.brakingcurrenttime,0,1);
}

//Function Number: 68
updateviewmodellookoffset(param_00)
{
	if(level.player maps\_utility::isads())
	{
		level.player.sniperdronedata.horizontaloffsetlook = maps\_utility::linear_interpolate(0.1,level.player.sniperdronedata.horizontaloffsetlook,0);
		level.player.sniperdronedata.verticaloffsetlook = maps\_utility::linear_interpolate(0.075,level.player.sniperdronedata.verticaloffsetlook,0);
		return;
	}

	var_01 = level.player getnormalizedcameramovements();
	var_02 = 0;
	if(var_01[1] > 0)
	{
		var_02 = maps\_utility::linear_interpolate(var_01[1],0,1.5);
	}
	else
	{
		var_02 = maps\_utility::linear_interpolate(-1 * var_01[1],0,1.5) * -1;
	}

	var_03 = 0;
	if(var_01[0] > 0)
	{
		var_03 = maps\_utility::linear_interpolate(var_01[0],0,1) * -1;
	}
	else
	{
		var_03 = maps\_utility::linear_interpolate(-1 * var_01[0],0,1);
	}

	level.player.sniperdronedata.horizontaloffsetlook = maps\_utility::linear_interpolate(0.05,level.player.sniperdronedata.horizontaloffsetlook,var_02);
	level.player.sniperdronedata.verticaloffsetlook = maps\_utility::linear_interpolate(0.03,level.player.sniperdronedata.verticaloffsetlook,var_03);
}

//Function Number: 69
getviewmodelrotation(param_00,param_01,param_02,param_03)
{
	var_04 = (0,0,1) + param_00 * maps\_utility::linear_interpolate(param_01,0,param_03);
	var_05 = vectorcross(var_04,param_02);
	param_02 = vectorcross(var_05,var_04);
	return axistoangles(param_02,var_05 * -1,var_04);
}

//Function Number: 70
updateviewmodelpitchoffset(param_00)
{
	param_00 = clamplookangle(param_00);
	var_01 = 120;
	var_02 = 1.5;
	var_03 = param_00 + 60 / var_01;
	var_03 = 1 - clamp(var_03,0,1);
	var_04 = (13,0,-3)[0];
	var_05 = (-1,0,-1.75)[0];
	var_06 = maps\_utility::linear_interpolate(var_03,var_04 + var_02,var_04 - var_02);
	var_07 = maps\_utility::linear_interpolate(var_03,var_05 + var_02,var_05 - var_02);
	level.player.sniperdronedata.frameviewmodeloffset = (var_06,0,(13,0,-3)[2]);
	level.player.sniperdronedata.barrelviewmodeloffset = (var_07,0,(-1,0,-1.75)[2]);
}

//Function Number: 71
getviewmodelstrafeoffset()
{
	level.player.sniperdronedata.horizontaloffsetstrafe = maps\_utility::linear_interpolate(0.2,level.player.sniperdronedata.horizontaloffsetstrafe,level.player.sniperdronedata.droneangularvelocity / 35);
	level.player.sniperdronedata.verticaloffsetstrafe = maps\_utility::linear_interpolate(0.2,level.player.sniperdronedata.verticaloffsetstrafe,level.player.sniperdronedata.droneverticalvelocity / 375);
	return (0,level.player.sniperdronedata.horizontaloffsetstrafe * 1.5,level.player.sniperdronedata.verticaloffsetstrafe);
}

//Function Number: 72
updatebodyroll(param_00)
{
	var_01 = level.player.sniperdronedata;
	if(level.player maps\_utility::isads())
	{
		var_01.bodyrollvelocity = vectorlerp(var_01.bodyrollvelocity,(0,0,0),0.1);
	}
	else
	{
		var_01.bodyrollvelocity = vectorlerp(var_01.bodyrollvelocity,var_01.currentvelocity * (1,1,0),0.2);
	}

	var_02 = anglestoforward(level.player getplayerangles() * (0,1,0));
	var_02 = vectornormalize(var_02 * (1,1,0));
	var_03 = anglestoforward(param_00 * (0,1,0));
	var_04 = vectordot(var_02,var_03);
	var_04 = clamp(var_04,-1,1);
	var_05 = acos(var_04) / 90;
	var_06 = clamp(var_05,0,1);
	var_06 = 1 - squared(var_06);
	var_07 = (0,0,1) + var_01.bodyrollvelocity * maps\_utility::linear_interpolate(var_06,0.0001,0.0025);
	var_08 = vectorcross(var_07,var_03);
	var_09 = vectorcross(var_08,var_07);
	var_0A = vectorcross(var_09,(0,0,1));
	var_0A = vectornormalize(var_0A);
	var_0B = axistoangles(var_09,var_08 * -1,var_07);
	updateviewmodelacceleration(var_0A);
	updateviewmodellookoffset(param_00);
	var_01.lastplayerangles = level.player getplayerangles();
	var_0C = getviewmodelrotation(var_01.framerollacceleration,var_06,var_09,0.125);
	updateviewmodelpitchoffset(getlookpitch());
	var_0D = getviewmodelstrafeoffset();
	var_0D = (0,var_0D[1] + var_01.horizontaloffsetlook,var_0D[2] + var_01.verticaloffsetlook);
	var_01.frameviewmodel unlinkfromplayerview(level.player);
	var_01.frameviewmodel linktoplayerview(level.player,"tag_origin",var_01.frameviewmodeloffset + var_0D,var_0C * (0,0,1),1);
	var_0E = getviewmodelrotation(var_01.barrelrollacceleration,var_06,var_09,0.125);
	var_01.barrelviewmodel unlinkfromplayerview(level.player);
	var_01.barrelviewmodel linktoplayerview(level.player,"tag_origin",var_01.barrelviewmodeloffset + var_0D * 0.5,var_0E * (0,0,1),1);
	return var_0B;
}

//Function Number: 73
angle_lerp(param_00,param_01,param_02)
{
	return angleclamp(param_00 + angleclamp180(param_01 - param_00) * param_02);
}

//Function Number: 74
euler_lerp(param_00,param_01,param_02)
{
	return (angle_lerp(param_00[0],param_01[0],param_02),angle_lerp(param_00[1],param_01[1],param_02),angle_lerp(param_00[2],param_01[2],param_02));
}

//Function Number: 75
rumblesniperdronefire()
{
	level.player playrumbleonentity("heavygun_fire");
	earthquake(0.1,0.1,level.player.origin,100);
}

//Function Number: 76
rumblesniperdronetakenout()
{
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.5,1,level.player.origin,100);
}