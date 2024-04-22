/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_security_camera.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 547 ms
 * Timestamp: 4/22/2024 2:31:22 AM
*******************************************************************/

//Function Number: 1
precachesecuritycamera()
{
	precacheshader("line_vertical");
	precachestring(&"GREECE_CAMERA_ZOOM");
	precachestring(&"GREECE_CAMERA_CYCLE");
	precachestring(&"GREECE_CAMERA_POTENTIAL_TARGET");
	precachestring(&"GREECE_CAMERA_TARGET_POS");
	precachestring(&"GREECE_CAMERA_TARGET_NEG");
	precachestring(&"GREECE_CAMERA_TARGET_FREQ");
	precachestring(&"GREECE_CAMERA_SOURCE_FREQ");
	precachestring(&"GREECE_CAMERA_GHZ");
	precachestring(&"GREECE_CAMERA_SAT_CONNECT");
	precachemodel("tag_player");
	precachestring(&"add_hudelement_gsc");
	precachestring(&"manhuntTabletHud");
	precachestring(&"remove_hudelement_gsc");
	precachestring(&"updateTargetReticule");
	precachestring(&"updateCurrentCamera");
	precachestring(&"updateProgressBarVisibility");
	precachestring(&"updateProgressBar");
	precachestring(&"updateTargetDetails");
	precachestring(&"displayScanResults");
	precachestring(&"initTabletHUD");
	level.player setclientomnvar("ui_manhunttablet",1);
}

//Function Number: 2
securitycameraenable(param_00)
{
	self endon("DisableScanning");
	level.securitycamerahud = [];
	level.securitycamerascanhud = [];
	level.activetarget = undefined;
	level.marketcamiszoomed = 0;
	self disableoffhandweapons();
	self disableweaponswitch();
	self allowcrouch(0);
	self enableweapons();
	self disableslowaim();
	self giveweapon("hms_security_camera");
	self switchtoweaponimmediate("hms_security_camera");
	self hideviewmodel();
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",3);
	_adjustcamerayawpitchrate("Zoom Out");
	var_01 = getent("MarketCameraCliffView","targetname");
	var_02 = getent("MarketCameraCafe","targetname");
	var_03 = getent("MarketCameraExit","targetname");
	if(!isdefined(param_00))
	{
		param_00 = [var_01,var_02,var_03];
	}

	var_04 = undefined;
	var_05 = 0;
	foreach(var_07 in param_00)
	{
		if(isdefined(var_07.script_noteworthy) && var_07.script_noteworthy == "default_security_camera")
		{
			var_04 = var_07;
			var_05 = getindex(param_00,var_07);
		}
	}

	if(!isdefined(var_04))
	{
		var_04 = param_00[var_05];
	}

	securitycameraviewlink(var_04);
	wait(0.25);
	level.player setblurforplayer(0,1);
	wait(0.25);
	common_scripts\utility::flag_set("init_tablet_overlay");
	level.player thread maps\_hud_util::fade_in(0.25,"white");
	wait(0.15);
	setsaveddvar("cg_cinematicfullscreen","1");
	cinematicingame("greece_match_search_scene_intro");
	maps\_utility::lerp_fov_overtime(0.35,70);
	thread securitycamerahud();
	thread securitycameraminimapangles();
	thread securitycameratargetfrequency();
	thread securitycamerapotentialsignalmatch();
	thread securitycamerascantrace();
	level.player thread securitycameraadsmonitor();
	thread securitycamerareturndistancetotarget();
	thread securitycameraswitching(param_00,var_05);
	level.player notify("CafeScanFirstCameraActive");
}

//Function Number: 3
securitycameraswitching(param_00,param_01)
{
	level.player endon("DisableScanning");
	level waittill("SafehouseCafeFeedSwitch");
	for(;;)
	{
		if(self fragbuttonpressed())
		{
			if(param_01 < param_00.size - 1)
			{
				param_01++;
			}
			else if(param_01 == param_00.size - 1)
			{
				param_01 = 0;
			}

			thread securitycameratransitionblur(param_00[param_01],param_00);
			wait(0.5);
		}
		else if(self secondaryoffhandbuttonpressed())
		{
			if(param_01 > 0)
			{
				param_01--;
			}
			else if(param_01 == 0)
			{
				param_01 = param_00.size - 1;
			}

			thread securitycameratransitionblur(param_00[param_01],param_00);
			wait(0.5);
		}

		wait(0.05);
	}
}

//Function Number: 4
getindex(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		if(var_04 == param_01)
		{
			return var_02;
		}

		var_02++;
	}
}

//Function Number: 5
securitycameraviewlink(param_00)
{
	self unlink();
	wait(0.05);
	if(isdefined(param_00.script_parameters))
	{
		var_01 = lookupcameraconstraints(param_00.script_parameters);
	}
	else
	{
		var_01 = [0,75,75,25,60,70];
	}

	self playerlinktodelta(param_00,"tag_player",0,var_01[1],var_01[2],var_01[3],var_01[4],0,0);
	self setplayerangles(param_00.angles);
	level.cameralinkpoint = param_00;
	maps\_utility::lerp_fov_overtime(0.5,var_01[5]);
}

//Function Number: 6
lookupcameraconstraints(param_00)
{
	switch(param_00)
	{
		case "Camera1":
			var_01 = [0,110,70,30,35,80];
			soundscripts\_snd::snd_message("mhunt_cafe_cam1_switch");
			return var_01;

		case "Camera2":
			var_01 = [0,135,25,30,45,65];
			soundscripts\_snd::snd_message("mhunt_cafe_cam2_switch");
			return var_01;

		case "Camera3":
			var_01 = [0,35,45,45,60,60];
			soundscripts\_snd::snd_message("mhunt_cafe_cam3_switch");
			return var_01;

		case "Camera4":
			var_01 = [0,45,55,30,40,90];
			soundscripts\_snd::snd_message("mhunt_cafe_cam4_switch");
			return var_01;
	}
}

//Function Number: 7
securitycameratransitionblur(param_00,param_01)
{
	soundscripts\_snd::snd_message("mhunt_cafe_cam_switch");
	var_02 = getindex(param_01,param_00);
	level.player maps\_hud_util::fade_out(0.15,"black");
	level.player notify("Zoom_Out");
	level notify("MarketCameraSwitch");
	common_scripts\utility::flag_set("FlagMarketCameraSwitched");
	wait(0.15);
	thread securitycameraviewlink(param_00);
	level.player maps\_hud_util::fade_in(0.15,"black");
	luinotifyevent(&"updateCurrentCamera",1,var_02);
}

//Function Number: 8
securitycameratargetfrequency()
{
	level.player endon("DisableSecurityCameras");
	level.frequencytarget = 1500;
	level.frequencysource = 0;
	var_00 = maps\_hud_util::createclientfontstring("default",1.5);
	var_00 maps\_hud_util::setpoint("TOP",undefined,0,30);
	level.securitycamerascanhud = common_scripts\utility::array_add(level.securitycamerascanhud,var_00);
	var_01 = maps\_hud_util::createclientfontstring("default",1.5);
	var_01 maps\_hud_util::setpoint("TOP",undefined,0,60);
	level.securitycamerascanhud = common_scripts\utility::array_add(level.securitycamerascanhud,var_01);
	var_02 = &"GREECE_CAMERA_TARGET_FREQ";
	var_03 = &"GREECE_CAMERA_SOURCE_FREQ";
	var_04 = &"GREECE_CAMERA_GHZ";
	for(;;)
	{
		if(isdefined(level.activetarget) && isdefined(level.activetarget.frequency))
		{
			level.frequencysource = level.activetarget.frequency;
		}
		else if(!isdefined(level.activetarget))
		{
			level.frequencysource = 0;
		}

		level.player common_scripts\utility::waittill_any("target_active","target_lost");
		wait(0.05);
	}
}

//Function Number: 9
securitycamerareturndistancetotarget()
{
	level.player endon("DisableScanning");
	for(;;)
	{
		if(isdefined(level.activetarget))
		{
			var_00 = distance(level.cameralinkpoint.origin,level.activetarget.origin);
		}

		wait(0.05);
	}
}

//Function Number: 10
comparescreenpos(param_00,param_01)
{
	return length2d(param_00.screenpos) < length2d(param_01.screenpos);
}

//Function Number: 11
updaterumble()
{
	level.player endon("DisableScanning");
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_01 = maps\_sarray::sarray_spawn();
	for(;;)
	{
		wait(0.05);
		var_01 maps\_sarray::sarray_clear();
		if(!level.marketcamiszoomed)
		{
			var_00 maps\_utility::set_rumble_intensity(0);
			level.intensity = 0;
			continue;
		}

		foreach(var_03 in level.potentialscantargets)
		{
			if(!isalive(var_03) || !var_03.potentialtarget)
			{
				continue;
			}

			var_04 = 70;
			if(level.marketcamiszoomed)
			{
				var_04 = 20;
			}

			var_03.screenpos = level.player worldpointtoscreenpos(var_03 getpointinbounds(0,0,0.5),var_04);
			if(!isdefined(var_03.screenpos))
			{
				continue;
			}

			var_01 maps\_sarray::sarray_push(var_03);
		}

		level.intensity = 0;
		if(var_01.array.size > 0)
		{
			maps\_sarray::sarray_sort_by_handler(var_01,maps\_sarray::sarray_create_func_obj(::comparescreenpos));
			var_06 = length2d(var_01.array[0].screenpos);
			level.intensity = 1 - clamp(var_06 / 500,0,1);
			level.intensity = squared(level.intensity);
		}

		var_00.rumble_base_entity = level.cameralinkpoint;
		var_07 = maps\_utility::linear_interpolate(level.intensity,0,0.2);
		var_00 maps\_utility::set_rumble_intensity(var_07);
	}
}

//Function Number: 12
rumblemonitor()
{
	level.player endon("DisableScanning");
	for(;;)
	{
		if(isdefined(level.intensity) && level.intensity == 0)
		{
			level notify("NotRumbling");
		}
		else if(isdefined(level.intensity) && level.intensity > 0)
		{
			level notify("Rumbling");
		}

		wait(0.05);
	}
}

//Function Number: 13
updatevisualmarker()
{
	level.player endon("DisableScanning");
	for(;;)
	{
		level waittill("Rumbling");
		playfxontag(common_scripts\utility::getfx("na45_beacon"),self,"tag_eye");
		level waittill("NotRumbling");
		stopfxontag(common_scripts\utility::getfx("na45_beacon"),self,"tag_eye");
	}
}

//Function Number: 14
securitycamerapotentialsignalmatch()
{
	level.player endon("DisableScanning");
	thread updaterumble();
	for(;;)
	{
		level.player common_scripts\utility::waittill_any("target_active","target_lost","target_scanned");
		if(isdefined(level.activetarget) && isdefined(level.activetarget.potentialtarget) && level.activetarget.potentialtarget == 1 && level.marketcamiszoomed == 1)
		{
			luinotifyevent(&"updateProgressBarVisibility",2,1,int(level.activetarget.frequency));
			if(!isdefined(level.activetarget.scanprogress))
			{
				level.activetarget.scanprogress = 0;
			}

			soundscripts\_snd::snd_message("mhunt_cafe_cam_scan_target");
			thread updatescanbar();
			thread maps\greece_safehouse_vo::scancamerafoundpotentialtarget();
		}
		else if(!isdefined(level.activetarget) || !isdefined(level.activetarget.potentialtarget) || level.activetarget.potentialtarget == 0 || level.marketcamiszoomed == 0)
		{
			luinotifyevent(&"updateProgressBarVisibility",1,0);
			soundscripts\_snd::snd_message("mhunt_cafe_cam_scan_stop");
		}

		wait(0.05);
	}
}

//Function Number: 15
updatescanbar()
{
	self endon("death");
	level endon("KVATargetFound");
	while(isdefined(level.activetarget) && isdefined(level.activetarget.scanprogress))
	{
		if(level.player attackbuttonpressed() && level.activetarget.scanprogress != 60)
		{
			soundscripts\_snd::snd_message("mhunt_cafe_cam_scan_start");
			level.activetarget.scanprogress++;
			if(!iscinematicplaying())
			{
				cinematicingameloop("greece_match_search");
			}
		}
		else if(!level.player attackbuttonpressed())
		{
			soundscripts\_snd::snd_message("mhunt_cafe_cam_scan_stop");
			stopcinematicingame();
		}
		else if(level.activetarget.scanprogress == 60)
		{
			soundscripts\_snd::snd_message("mhunt_cafe_cam_scan_stop");
			stopcinematicingame();
			level.activetarget.potentialtarget = 0;
			level.player notify("target_scanned");
			level.activetarget notify("target_scanned");
			level.activetarget thread displayscanresults();
			break;
		}

		luinotifyevent(&"updateProgressBar",2,int(level.activetarget.scanprogress),int(60));
		wait(0.05);
	}
}

//Function Number: 16
securitycamerahud()
{
	thread securitycamerazoomincontrols();
	thread securitycamerazoomoutcontrols();
	thread securitycamerazoommodifier();
	luinotifyevent(&"updateCurrentCamera",1,0);
	luinotifyevent(&"initTabletHUD",0);
}

//Function Number: 17
securitycameraminimapangles()
{
	self endon("DisableSecurityCameras");
	for(;;)
	{
		var_00 = level.player getplayerangles();
		level.player setclientomnvar("ui_greece_camera_angle",int(var_00[1]));
		wait 0.05;
	}
}

//Function Number: 18
displayscanresults()
{
	level.player endon("DisableScanning");
	if(self.team == "axis" && !common_scripts\utility::flag("FlagKVATargetWaitTimerExpired"))
	{
		luinotifyevent(&"displayScanResults",2,1,int(level.activetarget.frequency));
		soundscripts\_snd::snd_message("mhunt_cafe_cam_scan_get");
		level notify("KVATargetFound");
		level notify("CancelMarketScanDialog");
		thread securitycameramarktargets(2);
		thread maps\greece_safehouse_vo::scancameratargetdialogue();
	}
	else if(self.team != "axis" && !common_scripts\utility::flag("FlagKVATargetWaitTimerExpired"))
	{
		luinotifyevent(&"displayScanResults",2,0,int(level.activetarget.frequency));
		soundscripts\_snd::snd_message("mhunt_cafe_cam_scan_fail");
		thread securitycameramarktargets(1);
		thread maps\greece_safehouse_vo::scancameratargetdialogue();
		level.player notify("CafeScanResultsNegative");
	}

	wait(2);
}

//Function Number: 19
securitycameramarktargets(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	self hudoutlineenable(param_00,1);
	thread securitycameraclearscannedtarget();
}

//Function Number: 20
securitycameraclearscannedtarget()
{
	level.player endon("DisableSecurityCameras");
	self waittill("death");
	if(isdefined(self.team) && self.team != "axis")
	{
		if(target_istarget(self))
		{
			target_remove(self);
		}

		self hudoutlinedisable();
	}
}

//Function Number: 21
securitycameraclearalltargets()
{
	level.potentialscantargets = common_scripts\utility::array_removeundefined(level.potentialscantargets);
	foreach(var_01 in level.potentialscantargets)
	{
		if(target_istarget(var_01))
		{
			target_remove(var_01);
		}
	}
}

//Function Number: 22
securitycamerazoominstructions()
{
	level.player waittill("Zoom_Out");
	level.player setclientomnvar("ui_greece_camera_zoom_instructions",1);
}

//Function Number: 23
securitycamerazoomincontrols()
{
	self endon("DisableSecurityCameras");
	common_scripts\utility::flag_wait("FlagCameraScanUnlockZoom");
	setsaveddvar("cg_cinematicfullscreen","0");
	for(;;)
	{
		level.player waittill("Zoom_In");
		level.marketcamiszoomed = 1;
		soundscripts\_snd::snd_message("mhunt_cafe_cam_zoom_in");
		luinotifyevent(&"updateTargetReticule",1,1);
		maps\_utility::lerp_fov_overtime(0.35,20);
		_adjustcamerayawpitchrate("Zoom In");
		level.player waittill("Zoom_Out");
	}
}

//Function Number: 24
securitycamerazoomoutcontrols()
{
	self endon("DisableSecurityCameras");
	common_scripts\utility::flag_wait("FlagCameraScanUnlockZoom");
	thread securitycamerazoominstructions();
	for(;;)
	{
		level.player waittill("Zoom_Out");
		level.marketcamiszoomed = 0;
		soundscripts\_snd::snd_message("mhunt_cafe_cam_zoom_out");
		luinotifyevent(&"updateTargetReticule",1,0);
		maps\_utility::lerp_fov_overtime(0.35,70);
		_adjustcamerayawpitchrate("Zoom Out");
		level.player waittill("Zoom_In");
	}
}

//Function Number: 25
securitycameraadsmonitor()
{
	self endon("DisableSecurityCameras");
	for(;;)
	{
		if(level.player adsbuttonpressed())
		{
			level.player notify("Zoom_In");
		}
		else
		{
			level.player notify("Zoom_Out");
		}

		wait(0.05);
	}
}

//Function Number: 26
securitycamerazoommodifier()
{
	self endon("DisableSecurityCameras");
	for(;;)
	{
		while(level.marketcamiszoomed)
		{
			if(isdefined(level.activetarget) && isdefined(level.activetarget.potentialtarget) && level.activetarget.potentialtarget == 1)
			{
				maps\_utility::lerp_fov_overtime(0.15,15);
			}
			else
			{
				maps\_utility::lerp_fov_overtime(0.15,20);
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 27
_adjustcamerayawpitchrate(param_00)
{
	switch(param_00)
	{
		case "Zoom In":
			setsaveddvar("aim_turnrate_pitch",35);
			setsaveddvar("aim_turnrate_yaw",35);
			setsaveddvar("aim_accel_turnrate_lerp",35);
			break;

		case "Zoom Out":
			setsaveddvar("aim_turnrate_pitch",50);
			setsaveddvar("aim_turnrate_yaw",50);
			setsaveddvar("aim_accel_turnrate_lerp",75);
			break;
	}
}

//Function Number: 28
securitycameradisable()
{
	if(!isdefined(level.securitycamerascanhud))
	{
		return;
	}

	self notify("DisableScanning");
	stopallrumbles();
	thread securitycameraclearalltargets();
	foreach(var_01 in level.securitycamerascanhud)
	{
		if(isdefined(var_01))
		{
			var_01 maps\_hud_util::destroyelem();
		}
	}

	self waittill("DisableSecurityCameras");
	wait(0.25);
	level.player setblurforplayer(10,0.5);
	level.player maps\_hud_util::fade_out(0.25,"white");
	level.player setclientomnvar("ui_manhunttablet",0);
	common_scripts\utility::flag_set("init_safehouse_follow_lighting");
	if(isdefined(level.activetarget))
	{
		level.activetarget hudoutlinedisable();
	}

	foreach(var_04 in level.potentialscantargets)
	{
		if(isalive(var_04))
		{
			var_04 hudoutlinedisable();
		}
	}

	foreach(var_01 in level.securitycamerahud)
	{
		if(isdefined(var_01))
		{
			var_01 maps\_hud_util::destroyelem();
		}
	}

	level.player takeweapon("hms_security_camera");
	maps\_utility::lerp_fov_overtime(0.1,65);
	setsaveddvar("aim_turnrate_pitch",90);
	setsaveddvar("aim_turnrate_pitch_ads",55);
	setsaveddvar("aim_turnrate_yaw",260);
	setsaveddvar("aim_turnrate_yaw_ads",90);
	setsaveddvar("aim_accel_turnrate_lerp",1200);
	setsaveddvar("cg_cinematicfullscreen","1");
}

//Function Number: 29
scanfadeintro()
{
	wait(0.1);
	level.player lerpfov(40,0.5);
	level.player setblurforplayer(10,0.5);
	wait(0.25);
	level.player maps\_hud_util::fade_out(0.1,"white");
}

//Function Number: 30
scanfadeoutro()
{
	wait(0.1);
	thread maps\_hud_util::fade_in(0.25,"white");
	wait(0.1);
	level.player setblurforplayer(0,0.1);
}

//Function Number: 31
securitycamerascantrace()
{
	self endon("DisableScanning");
	for(;;)
	{
		wait(0.05);
		if(!level.marketcamiszoomed)
		{
			level.activetarget = undefined;
			continue;
		}

		level.player thread updatetraceentity();
		level.player thread updatetargetdetails();
	}
}

//Function Number: 32
updatetargetdetails()
{
	var_00 = 0;
	if(isdefined(level.activetarget) && isdefined(level.activetarget.potentialtarget))
	{
		if(level.activetarget.potentialtarget == 1)
		{
			var_00 = 2;
		}
		else
		{
			var_00 = 1;
		}
	}

	luinotifyevent(&"updateTargetDetails",2,var_00,int(level.intensity * 1000));
}

//Function Number: 33
updatetraceentity()
{
	self endon("DisableScanning");
	var_00 = level.player geteye();
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = var_00 + var_02 * 7000;
	var_04 = bullettrace(var_00,var_03,1,self,0,1);
	var_05 = var_04["entity"];
	if(isdefined(var_05))
	{
		if(!isdefined(level.activetarget) || var_05 != level.activetarget)
		{
			level.activetarget = var_05;
			level.player notify("target_active");
			level.activetarget thread targetmonitor();
			if(isdefined(level.activetarget.potentialtarget) && level.activetarget.potentialtarget)
			{
				level.activetarget hudoutlineenable(5,0);
				return;
			}

			return;
		}

		return;
	}

	if(!isdefined(var_05))
	{
		level.activetarget = undefined;
	}
}

//Function Number: 34
securitycamerafovcheck()
{
	level.player waittill("CafeScanFirstCameraActive");
	level.player endon("DisableScanning");
	self endon("death");
	var_00 = 0;
	if(isalive(self))
	{
		for(;;)
		{
			var_01 = level.cameralinkpoint.origin;
			var_02 = level.player getplayerangles();
			var_03 = self.origin + (0,0,48);
			thread maps\_utility::draw_circle_for_time(var_03,24,1,0,0,0.5);
			var_04 = common_scripts\utility::within_fov(var_01,var_02,var_03,cos(10));
			if(var_04 == 1 && level.marketcamiszoomed == 1 && var_00 == 0)
			{
				var_00 = 1;
				continue;
			}

			if(var_04 == 0 || level.marketcamiszoomed == 0)
			{
				var_00 = 0;
			}

			wait(0.5);
		}
	}
}

//Function Number: 35
targetmonitor()
{
	self endon("death");
	for(;;)
	{
		if(!isdefined(level.activetarget) || level.activetarget != self)
		{
			level.player notify("target_lost");
			return;
		}

		wait(0.05);
	}
}