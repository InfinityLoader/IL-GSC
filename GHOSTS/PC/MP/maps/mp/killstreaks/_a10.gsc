/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_a10.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 691 ms
 * Timestamp: 10/27/2023 1:20:07 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	precachelocationselector("map_artillery_selector");
	var_00 = spawnstruct();
	var_00.modelnames = [];
	var_00.modelnames["allies"] = "vehicle_a10_warthog_iw6_mp";
	var_00.modelnames["axis"] = "vehicle_a10_warthog_iw6_mp";
	var_00.vehicle = "a10_warthog_mp";
	var_00.inboundsfx = "veh_mig29_dist_loop";
	var_00.speed = 3000;
	var_00.halfdistance = 12500;
	var_00.heightrange = 750;
	var_00.choosedirection = 1;
	var_00.selectlocationvo = "KS_hqr_airstrike";
	var_00.inboundvo = "KS_ast_inbound";
	var_00.cannonfirevfx = loadfx("fx/smoke/smoke_trail_white_heli");
	var_00.cannonrumble = "ac130_25mm_fire";
	var_00.turretname = "a10_30mm_turret_mp";
	var_00.turretattachpoint = "tag_barrel";
	var_00.rocketmodelname = "maverick_projectile_mp";
	var_00.numrockets = 4;
	var_00.delaybetweenrockets = 0.125;
	var_00.delaybetweenlockon = 0.4;
	var_00.lockonicon = "veh_hud_target_chopperfly";
	var_00.maxhealth = 1000;
	var_00.xppopup = "destroyed_a10_strafe";
	var_00.callout = "callout_destroyed_a10";
	var_00.vodestroyed = undefined;
	var_00.explodevfx = loadfx("fx/explosions/aerial_explosion");
	var_00.sfxcannonfireloop_1p = "veh_a10_plr_fire_gatling_lp";
	var_00.sfxcannonfirestop_1p = "veh_a10_plr_fire_gatling_cooldown";
	var_00.sfxcannonfireloop_3p = "veh_a10_npc_fire_gatling_lp";
	var_00.sfxcannonfirestop_3p = "veh_a10_npc_fire_gatling_cooldown";
	var_00.sfxcannonfireburptime = 500;
	var_00.sfxcannonfireburpshort_3p = "veh_a10_npc_fire_gatling_short_burst";
	var_00.sfxcannonfireburplong_3p = "veh_a10_npc_fire_gatling_long_burst";
	var_00.sfxcannonbulletimpact = "veh_a10_bullet_impact_lp";
	var_00.sfxmissilefire_1p = [];
	var_00.sfxmissilefire_1p[0] = "veh_a10_plr_missile_ignition_left";
	var_00.sfxmissilefire_1p[1] = "veh_a10_plr_missile_ignition_right";
	var_00.sfxmissilefire_3p = "veh_a10_npc_missile_fire";
	var_00.sfxmissile = "veh_a10_missile_loop";
	var_00.sfxengine_1p = "veh_a10_plr_engine_lp";
	var_00.sfxengine_3p = "veh_a10_dist_loop";
	level.planeconfigs["a10_strafe"] = var_00;
	level.killstreakfuncs["a10_strafe"] = ::onuse;
	func_1854();
}

//Function Number: 2
onuse(param_00,param_01)
{
	if(isdefined(level.a10strafeactive))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(maps\mp\_utility::func_4995() || maps\mp\_utility::func_48F6())
	{
		return 0;
	}

	if(getcsplinecount() < 2)
	{
		return 0;
	}

	thread dostrike(param_00,"a10_strafe");
	return 1;
}

//Function Number: 3
dostrike(param_00,param_01)
{
	self endon("end_remote");
	self endon("death");
	level endon("game_ended");
	var_02 = func_3B81();
	var_03 = func_7AF5(param_01,param_00);
	if(var_03)
	{
		var_04 = func_785E(param_01,param_00,level.var_79A[var_02]);
		if(isdefined(var_04))
		{
			var_04 dooneflyby();
			func_7E19(var_04,param_01);
			var_04 = func_785E(param_01,param_00,level.var_79A[var_02]);
			if(isdefined(var_04))
			{
				thread maps\mp\killstreaks\_killstreaks::clearrideintro(1,0.75);
				var_04 dooneflyby();
				var_04 thread func_2D53(param_01);
				func_2DF3(param_01);
			}
		}
	}
}

//Function Number: 4
func_7AF5(param_00,param_01)
{
	maps\mp\_utility::func_720F("a10_strafe");
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::func_70E6(0);
	}

	self.restoreangles = self.angles;
	maps\mp\_utility::func_350E(1);
	var_02 = maps\mp\killstreaks\_killstreaks::func_4649("a10_strafe");
	if(var_02 != "success")
	{
		if(var_02 != "disconnect")
		{
			maps\mp\_utility::func_1D59();
		}

		if(isdefined(self.disabledweapon) && self.disabledweapon)
		{
			common_scripts\utility::_enableweapon();
		}

		self notify("death");
		return 0;
	}

	if(maps\mp\_utility::isjuggernaut() && isdefined(self.juggernautoverlay))
	{
		self.juggernautoverlay.alpha = 0;
	}

	maps\mp\_utility::func_350E(0);
	level.a10strafeactive = 1;
	self.using_remote_a10 = 1;
	level thread maps\mp\_utility::func_7FA0("used_" + param_00,self,self.team);
	return 1;
}

//Function Number: 5
func_2DF3(param_00)
{
	maps\mp\_utility::func_1D59();
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::func_70E6(1);
	}

	if(maps\mp\_utility::isjuggernaut() && isdefined(self.juggernautoverlay))
	{
		self.juggernautoverlay.alpha = 1;
	}

	self setplayerangles(self.restoreangles);
	self.restoreangles = undefined;
	thread a10_freezebuffer();
	level.a10strafeactive = undefined;
	self.using_remote_a10 = undefined;
}

//Function Number: 6
func_7E19(param_00,param_01)
{
	self.usingremote = undefined;
	self visionsetnakedforplayer("black_bw",0.75);
	thread maps\mp\_utility::set_visionset_for_watching_players("black_bw",0.75,0.75);
	wait(0.75);
	if(isdefined(param_00))
	{
		param_00 thread func_2D53(param_01);
	}
}

//Function Number: 7
func_785E(param_00,param_01,param_02)
{
	var_03 = createplaneasheli(param_00,param_01,param_02);
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_03.streakname = param_00;
	self remotecontrolvehicle(var_03);
	var_03 setplanesplineid(self,param_02);
	thread func_8CFB(param_00,var_03);
	var_04 = level.planeconfigs[param_00];
	var_03 playloopsound(var_04.sfxengine_1p);
	var_03 thread a10_handledamage();
	maps\mp\killstreaks\_plane::func_7AFA(var_03);
	return var_03;
}

//Function Number: 8
attachturret(param_00)
{
	var_01 = level.planeconfigs[param_00];
	var_02 = self gettagorigin(var_01.turretattachpoint);
	var_03 = spawnturret("misc_turret",self.origin + var_02,var_01.turretname,0);
	var_03 linkto(self,var_01.turretattachpoint,(0,0,0),(0,0,0));
	var_03 setmodel("vehicle_ugv_talon_gun_mp");
	var_03.angles = self.angles;
	var_03.owner = self.owner;
	var_03 maketurretinoperable();
	var_03 setturretmodechangewait(0);
	var_03 setmode("sentry_offline");
	var_03 makeunusable();
	var_03 setcandamage(0);
	var_03 setsentryowner(self.owner);
	self.owner remotecontrolturret(var_03);
	self.turret = var_03;
}

//Function Number: 9
func_1CE9()
{
	if(isdefined(self.turret))
	{
		self.turret delete();
	}

	foreach(var_01 in self.targetlist)
	{
		if(isdefined(var_01["icon"]))
		{
			var_01["icon"] destroy();
			var_01["icon"] = undefined;
		}
	}

	self delete();
}

//Function Number: 10
func_3B81()
{
	return randomint(level.var_79A.size);
}

//Function Number: 11
dooneflyby()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("splinePlaneReachedNode",var_00);
		if(isdefined(var_00) && var_00 == "End")
		{
			self notify("a10_end_strafe");
			break;
		}
	}
}

//Function Number: 12
func_2D53(param_00)
{
	if(!isdefined(self))
	{
	}

	self.owner remotecontrolvehicleoff(self);
	if(isdefined(self.turret))
	{
		self.owner remotecontrolturretoff(self.turret);
	}

	self notify("end_remote");
	self.owner setclientomnvar("ui_a10",0);
	self.owner thermalvisionfofoverlayoff();
	var_01 = level.planeconfigs[param_00];
	self stoploopsound(var_01.sfxcannonfireloop_1p);
	maps\mp\killstreaks\_plane::func_7C76(self);
	wait(5);
	if(isdefined(self))
	{
		self stoploopsound(var_01.sfxengine_1p);
		func_1CE9();
	}
}

//Function Number: 13
createplaneasheli(param_00,param_01,param_02)
{
	var_03 = level.planeconfigs[param_00];
	var_04 = getcsplinepointposition(param_02,0);
	var_05 = getcsplinepointtangent(param_02,0);
	var_06 = vectortoangles(var_05);
	var_07 = spawnhelicopter(self,var_04,var_06,var_03.vehicle,var_03.modelnames[self.team]);
	if(!isdefined(var_07))
	{
		return undefined;
	}

	var_07 makevehiclesolidcapsule(18,-9,18);
	var_07.owner = self;
	var_07.team = self.team;
	var_07.lifeid = param_01;
	var_07 thread maps\mp\killstreaks\_plane::func_6034();
	return var_07;
}

//Function Number: 14
func_3F75()
{
	level endon("game_ended");
	self endon("delete");
	self waittill("death");
	level.a10strafeactive = undefined;
	self.owner.using_remote_a10 = undefined;
	self delete();
}

//Function Number: 15
a10_freezebuffer()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	maps\mp\_utility::func_350E(1);
	wait(0.5);
	maps\mp\_utility::func_350E(0);
}

//Function Number: 16
func_53B8(param_00,param_01)
{
	param_01 endon("end_remote");
	param_01 endon("death");
	self endon("death");
	level endon("game_ended");
	var_02 = level.planeconfigs[param_00];
	param_01.numrocketsleft = var_02.numrockets;
	self notifyonplayercommand("rocket_fire_pressed","+speed_throw");
	self notifyonplayercommand("rocket_fire_pressed","+ads_akimbo_accessible");
	if(!level.console)
	{
		self notifyonplayercommand("rocket_fire_pressed","+toggleads_throw");
	}

	self setclientomnvar("ui_a10_rocket",param_01.numrocketsleft);
	while(param_01.numrocketsleft > 0)
	{
		self waittill("rocket_fire_pressed");
		param_01 onfirerocket(param_00);
		wait(var_02.delaybetweenrockets);
	}
}

//Function Number: 17
monitorrocketfire2(param_00,param_01)
{
	param_01 endon("end_remote");
	param_01 endon("death");
	self endon("death");
	level endon("game_ended");
	var_02 = level.planeconfigs[param_00];
	param_01.numrocketsleft = var_02.numrockets;
	self notifyonplayercommand("rocket_fire_pressed","+speed_throw");
	self notifyonplayercommand("rocket_fire_pressed","+ads_akimbo_accessible");
	if(!level.console)
	{
		self notifyonplayercommand("rocket_fire_pressed","+toggleads_throw");
	}

	param_01.targetlist = [];
	self setclientomnvar("ui_a10_rocket",param_01.numrocketsleft);
	while(param_01.numrocketsleft > 0)
	{
		if(!self adsbuttonpressed())
		{
			self waittill("rocket_fire_pressed");
		}

		param_01 func_52BF();
		if(param_01.targetlist.size > 0)
		{
			param_01 thread func_330E();
		}
	}
}

//Function Number: 18
func_52C5()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(missileisgoodtarget(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	foreach(var_05 in level.uplinks)
	{
		if(missileisgoodtarget(var_05))
		{
			var_00[var_00.size] = var_05;
		}
	}

	if(var_00.size > 0)
	{
		var_07 = sortbydistance(var_00,self.origin);
		return var_07[0];
	}

	return undefined;
}

//Function Number: 19
missileisgoodtarget(param_00)
{
	return isalive(param_00) && param_00.team != self.owner.team && !func_4911(param_00) && isplayer(param_00) && !param_00 maps\mp\_utility::_hasperk("specialty_blindeye") && missiletargetangle(param_00) > 0.25;
}

//Function Number: 20
missiletargetangle(param_00)
{
	var_01 = vectornormalize(param_00.origin - self.origin);
	var_02 = anglestoforward(self.angles);
	return vectordot(var_01,var_02);
}

//Function Number: 21
func_52BF()
{
	self endon("death");
	self endon("end_remote");
	level endon("game_ended");
	self endon("a10_missiles_fired");
	var_00 = level.planeconfigs[self.streakname];
	self.owner setclientomnvar("ui_a10_rocket_lock",1);
	thread func_52D7();
	var_01 = undefined;
	while(self.targetlist.size < self.numrocketsleft)
	{
		if(!isdefined(var_01))
		{
			var_01 = func_52C5();
			if(isdefined(var_01))
			{
				thread func_52CA(var_01);
				wait(var_00.delaybetweenlockon);
				var_01 = undefined;
				continue;
			}
		}

		wait(0.1);
	}

	self.owner setclientomnvar("ui_a10_rocket_lock",0);
	self notify("a10_missiles_fired");
}

//Function Number: 22
func_52D7()
{
	self endon("end_remote");
	self endon("death");
	level endon("game_ended");
	self endon("a10_missiles_fired");
	var_00 = self.owner;
	var_00 notifyonplayercommand("rocket_fire_released","-speed_throw");
	var_00 notifyonplayercommand("rocket_fire_released","-ads_akimbo_accessible");
	if(!level.console)
	{
		var_00 notifyonplayercommand("rocket_fire_released","-toggleads_throw");
	}

	self.owner waittill("rocket_fire_released");
	var_00 setclientomnvar("ui_a10_rocket_lock",0);
	self notify("a10_missiles_fired");
}

//Function Number: 23
func_52CA(param_00)
{
	var_01 = level.planeconfigs[self.streakname];
	var_02 = [];
	var_02["icon"] = param_00 maps\mp\_entityheadicons::setheadicon(self.owner,var_01.lockonicon,(0,0,-70),10,10,0,0.05,1,0,0,0);
	var_02["target"] = param_00;
	self.targetlist[param_00 getentitynumber()] = var_02;
	self.owner playlocalsound("recondrone_lockon");
}

//Function Number: 24
func_4911(param_00)
{
	return isdefined(self.targetlist[param_00 getentitynumber()]);
}

//Function Number: 25
func_330E()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.planeconfigs[self.streakname];
	foreach(var_02 in self.targetlist)
	{
		if(self.numrocketsleft > 0)
		{
			var_03 = func_5938(self.streakname,var_02["target"],(0,0,-70));
			if(isdefined(var_02["icon"]))
			{
				var_03.icon = var_02["icon"];
				var_02["icon"] = undefined;
			}

			wait(var_00.delaybetweenrockets);
			continue;
		}

		break;
	}

	var_05 = [];
}

//Function Number: 26
func_5938(param_00,param_01,param_02)
{
	var_03 = self.numrocketsleft % 2;
	var_04 = "tag_missile_" + var_03 + 1;
	var_05 = self gettagorigin(var_04);
	if(isdefined(var_05))
	{
		var_06 = self.owner;
		var_07 = level.planeconfigs[param_00];
		var_08 = magicbullet(var_07.rocketmodelname,var_05,var_05 + 100 * anglestoforward(self.angles),self.owner);
		var_08 thread a10_missile_set_target(param_01,param_02);
		earthquake(0.25,0.05,self.origin,512);
		self.numrocketsleft--;
		self.owner setclientomnvar("ui_a10_rocket",self.numrocketsleft);
		var_07 = level.planeconfigs[param_00];
		var_08 playsoundonmovingent(var_07.sfxmissilefire_1p[var_03]);
		var_08 playloopsound(var_07.sfxmissile);
		return var_08;
	}

	return undefined;
}

//Function Number: 27
onfirerocket(param_00)
{
	var_01 = "tag_missile_" + self.numrocketsleft;
	var_02 = self gettagorigin(var_01);
	if(isdefined(var_02))
	{
		var_03 = self.owner;
		var_04 = level.planeconfigs[param_00];
		var_05 = magicbullet(var_04.rocketmodelname,var_02,var_02 + 100 * anglestoforward(self.angles),self.owner);
		earthquake(0.25,0.05,self.origin,512);
		self.numrocketsleft--;
		self.owner setclientomnvar("ui_a10_rocket",self.numrocketsleft);
		var_05 playsoundonmovingent(var_04.sfxmissilefire_1p[self.numrocketsleft]);
		var_05 playloopsound(var_04.sfxmissile);
		self playsoundonmovingent("a10p_missile_launch");
	}
}

//Function Number: 28
a10_missile_set_target(param_00,param_01)
{
	thread a10_missile_cleanup();
	wait(0.2);
	self missile_settargetent(param_00,param_01);
}

//Function Number: 29
a10_missile_cleanup()
{
	self waittill("death");
	if(isdefined(self.icon))
	{
		self.icon destroy();
	}
}

//Function Number: 30
func_53D8(param_00,param_01)
{
	param_01 endon("end_remote");
	param_01 endon("death");
	self endon("death");
	level endon("game_ended");
	var_02 = level.planeconfigs[param_00];
	param_01.ammocount = 1350;
	self setclientomnvar("ui_a10_cannon",param_01.ammocount);
	self notifyonplayercommand("a10_cannon_start","+attack");
	self notifyonplayercommand("a10_cannon_stop","-attack");
	while(param_01.ammocount > 0)
	{
		if(!self attackbuttonpressed())
		{
			self waittill("a10_cannon_start");
		}

		var_03 = gettime() + var_02.sfxcannonfireburptime;
		param_01 playloopsound(var_02.sfxcannonfireloop_1p);
		param_01 thread func_86D1(param_00);
		self waittill("a10_cannon_stop");
		param_01 stoploopsound(var_02.sfxcannonfireloop_1p);
		param_01 playsoundonmovingent(var_02.sfxcannonfirestop_1p);
		if(gettime() < var_03)
		{
			playsoundatpos(param_01.origin,var_02.sfxcannonfireburpshort_3p);
			continue;
		}

		playsoundatpos(param_01.origin,var_02.sfxcannonfireburplong_3p);
	}
}

//Function Number: 31
func_86D1(param_00)
{
	self.owner endon("a10_cannon_stop");
	self endon("death");
	level endon("game_ended");
	var_01 = level.planeconfigs[param_00];
	while(self.ammocount > 0)
	{
		earthquake(0.2,0.5,self.origin,512);
		self.ammocount = self.ammocount - 10;
		self.owner setclientomnvar("ui_a10_cannon",self.ammocount);
		var_02 = self gettagorigin("tag_flash_attach") + 20 * anglestoforward(self.angles);
		playfx(var_01.cannonfirevfx,var_02);
		self playrumbleonentity(var_01.cannonrumble);
		wait(0.1);
	}

	self.turret turretfiredisable();
}

//Function Number: 32
func_5370(param_00,param_01)
{
	param_01 endon("end_remote");
	param_01 endon("death");
	self endon("death");
	level endon("game_ended");
	self setclientomnvar("ui_a10_alt_warn",0);
	for(;;)
	{
		var_02 = int(clamp(param_01.origin[2],0,16383));
		self setclientomnvar("ui_a10_alt",var_02);
		if(var_02 <= 1000 && !isdefined(param_01.altwarning))
		{
			param_01.altwarning = 1;
			self setclientomnvar("ui_a10_alt_warn",1);
		}
		else if(var_02 > 1000 && isdefined(param_01.altwarning))
		{
			param_01.altwarning = undefined;
			self setclientomnvar("ui_a10_alt_warn",0);
		}

		wait(0.1);
	}
}

//Function Number: 33
func_8CFB(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("intro_cleared");
	self setclientomnvar("ui_a10",1);
	thread func_5370(param_00,param_01);
	thread monitorrocketfire2(param_00,param_01);
	thread func_53D8(param_00,param_01);
	thread func_8D19(param_01,param_00);
	self thermalvisionfofoverlayon();
	thread func_8CDE(param_01);
}

//Function Number: 34
func_8D19(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("leaving");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level common_scripts\utility::func_8B2A("round_end_finished","game_ended");
	param_00 thread func_2D53(param_01);
	func_2DF3(param_01);
	a10_explode();
}

//Function Number: 35
func_1854()
{
	var_00 = [];
	var_00[0] = 1;
	var_00[1] = 2;
	var_00[2] = 3;
	var_00[3] = 4;
	var_00[4] = 1;
	var_00[5] = 2;
	var_00[6] = 4;
	var_00[7] = 3;
	var_01 = [];
	var_01[0] = 2;
	var_01[1] = 1;
	var_01[2] = 4;
	var_01[3] = 3;
	var_01[4] = 1;
	var_01[5] = 4;
	var_01[6] = 3;
	var_01[7] = 2;
	func_1853(var_00,var_01);
}

//Function Number: 36
func_1853(param_00,param_01)
{
	level.var_79A = param_00;
	level.a10splinesout = param_01;
}

//Function Number: 37
a10_cockpit_breathing()
{
	level endon("remove_player_control");
	wait(randomfloatrange(3,7));
}

//Function Number: 38
func_8CDE(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("a10_end_strafe");
	param_00 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
	param_00 waittill("killstreakExit");
	self notify("end_remote");
	param_00 thread func_2D53(param_00.streakname);
	func_2DF3(param_00.streakname);
	param_00 a10_explode();
}

//Function Number: 39
a10_handledamage()
{
	self endon("end_remote");
	var_00 = level.planeconfigs[self.streakname];
	maps\mp\gametypes\_damage::func_537B(var_00.maxhealth,"helicopter",::handledeathdamage,::modifydamage,1);
}

//Function Number: 40
modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = maps\mp\gametypes\_damage::handleempdamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 41
handledeathdamage(param_00,param_01,param_02,param_03)
{
	var_04 = level.planeconfigs[self.streakname];
	maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,var_04.vodestroyed,var_04.xppopup,var_04.callout);
	a10_explode();
}

//Function Number: 42
a10_explode()
{
	var_00 = level.planeconfigs[self.streakname];
	maps\mp\killstreaks\_plane::func_7C76(self);
	playfx(var_00.explodevfx,self.origin);
	self delete();
}