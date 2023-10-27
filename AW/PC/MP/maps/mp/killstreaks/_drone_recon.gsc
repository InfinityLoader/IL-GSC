/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_drone_recon.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 429 ms
 * Timestamp: 10/27/2023 1:51:42 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["emp_grenade"] = loadfx("vfx/explosion/emp_grenade_explosion");
	level._effect["antenna_light_mp"] = loadfx("vfx/lights/light_reconugv_antenna");
	level._effect["recon_drone_marker_threat"] = loadfx("vfx/ui/vfx_marker_drone_recon");
	level._effect["recon_drone_marker_emp"] = loadfx("vfx/ui/vfx_marker_drone_recon2");
	level._effect["recond_drone_exhaust"] = loadfx("vfx/vehicle/vehicle_mp_recon_drone_smoke");
	level.ugvmarkedarrays = [];
	thread onplayerconnect();
	level.killstreakfuncs["recon_ugv"] = ::tryuserecondrone;
	level.killstreakwieldweapons["recon_drone_turret_mp"] = "recon_ugv";
	level.killstreakwieldweapons["emp_grenade_killstreak_mp"] = "recon_ugv";
	level.killstreakwieldweapons["paint_grenade_killstreak_mp"] = "recon_ugv";
	game["dialog"]["ks_recdrone_destroyed"] = "ks_recdrone_destroyed";
}

//Function Number: 2
getdronespawnpoint()
{
	var_00 = maps\mp\killstreaks\_drone_common::dronegetspawnpoint();
	return var_00;
}

//Function Number: 3
tryuserecondrone(param_00,param_01)
{
	if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		return 0;
	}

	maps\mp\_utility::incrementfauxvehiclecount();
	var_02 = getdronespawnpoint();
	if(!var_02.placementok)
	{
		self iprintlnbold(&"MP_DRONE_PLACEMENT_INVALID");
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	common_scripts\utility::_disableweaponswitch();
	var_03 = maps\mp\killstreaks\_killstreaks::initridekillstreak("recon_ugv");
	if(var_03 != "success")
	{
		common_scripts\utility::_enableweaponswitch();
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	maps\mp\_utility::setusingremote("recon_ugv");
	var_04 = createreconuav(param_00,param_01,var_02.origin,var_02.angles);
	common_scripts\utility::_enableweaponswitch();
	self switchtoweapon("killstreak_predator_missile_mp");
	if(isdefined(var_04))
	{
		maps\mp\_matchdata::logkillstreakevent("recon_ugv",self.origin);
		thread maps\mp\_utility::teamplayercardsplash("used_recon_ugv",self);
		return 1;
	}

	maps\mp\_utility::decrementfauxvehiclecount();
	return 0;
}

//Function Number: 4
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 5
onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
	var_00 = spawnstruct();
	var_00.markedplayerarray = [];
	var_00.markedturretarray = [];
	var_00.owner = self;
	var_00.monitormarkingthread = 0;
	level.ugvmarkedarrays = common_scripts\utility::array_add(level.ugvmarkedarrays,var_00);
}

//Function Number: 6
createreconuav(param_00,param_01,param_02,param_03)
{
	var_04 = "recon_uav_mp";
	var_05 = "vehicle_atlas_aerial_drone_02_patrol_mp_static_75p";
	var_06 = spawnhelicopter(self,param_02,param_03,var_04,var_05);
	if(!isdefined(var_06))
	{
		return undefined;
	}

	thread playercommonreconvehiclesetup(var_06,param_01,param_00);
	var_06.maxhealth = 250;
	var_06.vehicletype = "drone_recon";
	var_06.vehname = "recon_uav";
	var_06.markdistance = 1500;
	if(var_06.hasincreasedtime)
	{
		var_07 = 45;
	}
	else
	{
		var_07 = 30;
	}

	var_06.lifespan = var_07;
	var_06.endtime = gettime() + var_07 * 1000;
	var_06 thread maps\mp\gametypes\_damage::setentitydamagecallback(var_06.maxhealth,undefined,::onrecondronedeath,::maps\mp\killstreaks\_aerial_utility::heli_modifydamage,1);
	if(var_06.hascloak)
	{
		thread maps\mp\killstreaks\_drone_common::dronecloakready(var_06,var_06.hascloak);
	}

	startusingreconvehicle(var_06);
	thread monitoruavsafearea(var_06);
	thread monitorplayerdisconnect(var_06);
	thread monitorplayerswitchteams(var_06);
	thread monitorplayergameended(var_06);
	thread reconhandletimeoutwarning(var_06);
	thread reconhandletimeout(var_06);
	thread reconhandledeath(var_06);
	thread reconhudsetup(var_06);
	thread maps\mp\killstreaks\_drone_common::playerwatchfordroneemp(var_06);
	var_08 = spawnstruct();
	var_08.validateaccuratetouching = 1;
	var_08.deathoverridecallback = ::override_drone_platform_death;
	var_06 thread maps\mp\_movers::handle_moving_platforms(var_08);
	var_06.getstingertargetposfunc = ::reconuav_stinger_target_pos;
	return var_06;
}

//Function Number: 7
reconuav_stinger_target_pos()
{
	return self gettagorigin("tag_origin");
}

//Function Number: 8
override_drone_platform_death(param_00)
{
	self notify("death");
}

//Function Number: 9
setupplayercommands(param_00)
{
	if(isbot(self))
	{
		return;
	}

	self notifyonplayercommand("recon_fire_main","+attack");
	self notifyonplayercommand("recon_fire_main","+attack_akimbo_accessible");
	self notifyonplayercommand("recon_fire_secondary","+speed_throw");
	self notifyonplayercommand("recon_fire_secondary","+toggleads_throw");
	self notifyonplayercommand("recon_fire_secondary","+ads_akimbo_accessible");
	if(common_scripts\utility::array_contains(param_00,"recon_ugv_cloak"))
	{
		self notifyonplayercommand("Cloak","+activate");
		self notifyonplayercommand("Cloak","+usereload");
	}
}

//Function Number: 10
disableplayercommands(param_00)
{
	if(isbot(self))
	{
		return;
	}

	self notifyonplayercommandremove("recon_fire_main","+attack");
	self notifyonplayercommandremove("recon_fire_main","+attack_akimbo_accessible");
	self notifyonplayercommandremove("recon_fire_secondary","+speed_throw");
	self notifyonplayercommandremove("recon_fire_secondary","+toggleads_throw");
	self notifyonplayercommandremove("recon_fire_secondary","+ads_akimbo_accessible");
	if(isdefined(param_00) && param_00.hascloak)
	{
		self notifyonplayercommandremove("Cloak","+activate");
		self notifyonplayercommandremove("Cloak","+usereload");
	}
}

//Function Number: 11
playercommonreconvehiclesetup(param_00,param_01,param_02)
{
	self endon("reconStreakComplete");
	param_00 endon("death");
	self.using_remote_tank = 0;
	param_00.lifeid = param_02;
	param_00.team = self.team;
	param_00.owner = self;
	param_00.damagetaken = 0;
	param_00.destroyed = 0;
	param_00.empgrenaded = 0;
	param_00.damagefade = 1;
	param_00.markedplayers = [];
	param_00.modules = param_01;
	param_00.hasarhud = common_scripts\utility::array_contains(param_00.modules,"recon_ugv_ar_hud");
	param_00.haspaintgrenade = 1;
	param_00.hasassistpoints = common_scripts\utility::array_contains(param_00.modules,"recon_ugv_assist_points");
	param_00.hasstun = common_scripts\utility::array_contains(param_00.modules,"recon_ugv_stun");
	param_00.hasincreasedtime = common_scripts\utility::array_contains(param_00.modules,"recon_ugv_increased_time");
	param_00.hascloak = common_scripts\utility::array_contains(param_00.modules,"recon_ugv_cloak");
	param_00.hasempgrenade = common_scripts\utility::array_contains(param_00.modules,"recon_ugv_emp");
	param_00 hide();
	param_00 makeunusable();
	param_00 makevehiclesolidcapsule(23,-9,23);
	param_00 setcandamage(1);
	param_00 common_scripts\utility::make_entity_sentient_mp(param_00.team);
	reconspawnturret(param_00);
	thread maps\mp\killstreaks\_drone_common::dronesetupcloaking(param_00,param_00.hascloak);
	wait(1.6);
	setupplayercommands(param_01);
	thread notify_recon_drone_on_player_command(param_00);
	var_03 = "recon_drone_marker_threat";
	if(param_00.hasempgrenade)
	{
		var_03 = "recon_drone_marker_emp";
	}

	thread maps\mp\killstreaks\_drone_common::updateshootinglocation(param_00,common_scripts\utility::getfx(var_03),1);
	thread maps\mp\killstreaks\_drone_common::playerhandleexhaustfx(param_00,"recond_drone_exhaust","tag_exhaust");
	param_00.mgturret settargetentity(param_00.targetent);
	thread reconplayerexit(param_00);
}

//Function Number: 12
reconspawnturret(param_00)
{
	var_01 = "recon_drone_turret_mp";
	var_02 = "tag_turret";
	var_03 = "vehicle_atlas_aerial_drone_02_patrol_mp_turret_75p";
	var_04 = spawnturret("misc_turret",param_00 gettagorigin(var_02),var_01,0);
	var_04.angles = param_00 gettagangles(var_02);
	var_04 setmodel(var_03);
	var_04 setdefaultdroppitch(45);
	var_04 linkto(param_00,var_02,(0,0,0),(0,0,0));
	var_04.owner = param_00.owner;
	var_04.health = 99999;
	var_04.maxhealth = 1000;
	var_04.damagetaken = 0;
	var_04.stunned = 0;
	var_04.stunnedtime = 0;
	var_04 setcandamage(0);
	var_04 setcanradiusdamage(0);
	var_04 makeunusable();
	var_04.team = param_00.team;
	var_04.pers["team"] = param_00.team;
	if(level.teambased)
	{
		var_04 setturretteam(param_00.team);
	}

	var_04 setmode("sentry_manual");
	var_04 setsentryowner(param_00.owner);
	var_04 setturretminimapvisible(0);
	var_04.chopper = param_00;
	var_04 setcontents(0);
	var_04.firesoundent = spawn("script_model",param_00 gettagorigin(var_02));
	var_04.firesoundent setmodel("tag_origin");
	var_04.firesoundent vehicle_jetbikesethoverforcescale(param_00,var_02,(0,0,0),(0,0,0));
	var_04.firesoundent setcontents(0);
	var_04 hide();
	param_00.mgturret = var_04;
	if(param_00.haspaintgrenade)
	{
		thread firethreatgrenades(param_00);
	}

	if(param_00.hasempgrenade)
	{
		thread fireempgrenades(param_00);
	}
}

//Function Number: 13
firethreatgrenades(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	var_01 = gettime();
	var_02 = 0;
	for(;;)
	{
		self waittill("recon_fire_main");
		self notify("ForceUncloak");
		var_03 = param_00.mgturret gettagorigin("tag_aim");
		var_04 = param_00.targetent.origin;
		if(param_00.hasstun && gettime() >= var_01)
		{
			var_01 = gettime() + 6000;
			var_02 = 1;
		}

		maps\mp\killstreaks\_aerial_utility::playerfakeshootpaintgrenadeattarget(param_00.mgturret.firesoundent,var_03,var_04,var_02,param_00);
		self setclientomnvar("ui_recondrone_paint",2);
		wait(2);
		self setclientomnvar("ui_recondrone_paint",1);
		var_02 = 0;
	}
}

//Function Number: 14
fireempgrenades(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("recon_fire_secondary");
		self notify("ForceUncloak");
		var_01 = param_00.mgturret gettagorigin("tag_aim");
		var_02 = param_00.targetent.origin;
		maps\mp\killstreaks\_aerial_utility::playerfakeshootempgrenadeattarget(param_00.mgturret.firesoundent,var_01,var_02);
		self setclientomnvar("ui_recondrone_emp",2);
		wait(5);
		self setclientomnvar("ui_recondrone_emp",1);
	}
}

//Function Number: 15
notify_recon_drone_on_player_command(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	for(;;)
	{
		var_01 = common_scripts\utility::waittill_any_return("recon_fire_main","recon_fire_secondary","Cloak");
		if(isdefined(var_01))
		{
			param_00 notify(var_01);
		}
	}
}

//Function Number: 16
startusingreconvehicle(param_00)
{
	var_01 = self;
	if(getdvarint("camera_thirdPerson"))
	{
		var_01 maps\mp\_utility::setthirdpersondof(0);
	}

	var_01 maps\mp\_utility::playersaveangles();
	var_01 cameralinkto(param_00,"tag_origin");
	var_01 remotecontrolvehicle(param_00);
	var_01 thread maps\mp\killstreaks\_drone_common::setdronevisionandlightsetpermap(1.5,param_00);
	var_01.using_remote_tank = 1;
	if(var_01 maps\mp\_utility::isjuggernaut())
	{
		var_01.juggernautoverlay.alpha = 0;
	}
}

//Function Number: 17
reconhudsetup(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	reconhudremove(param_00);
	wait(0.5);
	self setclientomnvar("ui_recondrone_toggle",1);
	maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
	self setclientomnvar("ui_recondrone_countdown",param_00.endtime);
	if(param_00.hascloak)
	{
		self setclientomnvar("ui_drone_cloak",2);
	}

	if(param_00.haspaintgrenade)
	{
		self setclientomnvar("ui_recondrone_paint",1);
	}

	if(param_00.hasempgrenade)
	{
		self setclientomnvar("ui_recondrone_emp",1);
	}

	if(param_00.hasarhud)
	{
		self thermalvisionfofoverlayon();
	}
}

//Function Number: 18
reconhudremove(param_00)
{
	self setclientomnvar("ui_recondrone_toggle",0);
	self setclientomnvar("ui_recondrone_countdown",0);
	self setclientomnvar("ui_drone_cloak",0);
	self setclientomnvar("ui_drone_cloak_time",0);
	self setclientomnvar("ui_drone_cloak_cooldown",0);
	self setclientomnvar("ui_recondrone_paint",0);
	self setclientomnvar("ui_recondrone_emp",0);
	maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
}

//Function Number: 19
monitoruavsafearea(param_00)
{
	self endon("reconStreakComplete");
	thread maps\mp\killstreaks\_aerial_utility::playerhandleboundarystatic(param_00,"reconStreakComplete");
	thread maps\mp\killstreaks\_aerial_utility::playerhandlekillvehicle(param_00,"reconStreakComplete");
	param_00 waittill("outOfBounds");
	wait(2);
	param_00 notify("death");
}

//Function Number: 20
monitorplayerdisconnect(param_00)
{
	self endon("StopWaitForDisconnect");
	param_00 endon("death");
	self waittill("disconnect");
	param_00 notify("death");
}

//Function Number: 21
monitorplayerswitchteams(param_00)
{
	self endon("reconStreakComplete");
	common_scripts\utility::waittill_any("joined_team","joined_spectators");
	param_00 notify("death");
}

//Function Number: 22
monitorplayergameended(param_00)
{
	self endon("reconStreakComplete");
	level waittill("game_ended");
	param_00 notify("death");
}

//Function Number: 23
onrecondronedeath(param_00,param_01,param_02,param_03)
{
	self notify("death",param_00,param_02,param_01);
	maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,"recon_drone_destroyed",undefined,"callout_destroyed_drone_recon",1);
}

//Function Number: 24
reconhandletimeoutwarning(param_00)
{
	param_00 endon("death");
	var_01 = 10;
	var_02 = 1;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00.lifespan - var_01);
	while(var_01 > 0)
	{
		param_00 playsound("mp_warbird_outofbounds_warning");
		var_01 = var_01 - var_02;
		wait(var_02);
	}

	param_00 notify("death");
}

//Function Number: 25
reconhandletimeout(param_00)
{
	param_00 endon("death");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00.lifespan);
	param_00 notify("death");
}

//Function Number: 26
reconhandledeath(param_00)
{
	var_01 = param_00 getentitynumber();
	param_00 maps\mp\killstreaks\_drone_common::droneaddtogloballist(var_01);
	param_00 waittill("death",var_02);
	if(isdefined(param_00))
	{
		param_00 ghost();
	}

	if(isdefined(param_00.mgturret))
	{
		param_00.mgturret ghost();
	}

	if(isdefined(self))
	{
		maps\mp\_utility::freezecontrolswrapper(1);
	}

	self notify("reconStreakComplete");
	self notify("StopWaitForDisconnect");
	param_00 playsound("assault_drn_death");
	param_00 maps\mp\killstreaks\_drone_common::droneremovefromgloballist(var_01);
	wait 0.05;
	playfxontag(level._effect["remote_tank_explode"],param_00,"tag_origin");
	wait(1);
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(isdefined(self) && !level.gameended)
	{
		maps\mp\_utility::freezecontrolswrapper(0);
	}

	if(isdefined(self) && isdefined(var_02) && self != var_02)
	{
		thread maps\mp\_utility::leaderdialogonplayer("ks_recdrone_destroyed",undefined,undefined,self.origin);
	}

	if(isdefined(self) && self.using_remote_tank || maps\mp\_utility::isusingremote())
	{
		reconsetinactivity(param_00);
		self.using_remote_tank = 0;
		if(maps\mp\_utility::isjuggernaut())
		{
			self.juggernautoverlay.alpha = 1;
		}
	}

	maps\mp\_utility::decrementfauxvehiclecount();
	if(isdefined(param_00.mgturret))
	{
		if(isdefined(param_00.mgturret.firesoundent))
		{
			param_00.mgturret.firesoundent delete();
		}

		param_00.mgturret delete();
	}

	if(isdefined(param_00.thing))
	{
		param_00.thing delete();
	}

	param_00 delete();
}

//Function Number: 27
reconsetinactivity(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = self;
	if(isdefined(var_01.using_remote_tank) && var_01.using_remote_tank)
	{
		var_01 notify("end_remote");
		var_01 remotecontrolvehicleoff(param_00);
		var_01 thermalvisionfofoverlayoff();
		thread maps\mp\killstreaks\_drone_common::removedronevisionandlightsetpermap(1.5);
		var_01 reconhudremove(param_00);
		var_01 disableplayercommands(param_00);
		if(var_01 maps\mp\_utility::isusingremote() && !level.gameended)
		{
			var_01 maps\mp\_utility::clearusingremote();
		}

		var_02 = maps\mp\_utility::getkillstreakweapon("recon_ugv");
		var_01 takeweapon(var_02);
		var_01 enableweaponswitch();
		var_01 switchtoweapon(common_scripts\utility::getlastweapon());
		var_01 maps\mp\_utility::playerrestoreangles();
		if(getdvarint("camera_thirdPerson"))
		{
			var_01 maps\mp\_utility::setthirdpersondof(1);
		}

		if(isdefined(var_01.disabledusability) && var_01.disabledusability)
		{
			var_01 common_scripts\utility::_enableusability();
		}

		var_01.using_remote_tank = 0;
	}
}

//Function Number: 28
reconplayerexit(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	var_01 = self;
	level endon("game_ended");
	var_01 endon("disconnect");
	param_00 endon("death");
	for(;;)
	{
		var_02 = 0;
		while(var_01 usebuttonpressed())
		{
			var_02 = var_02 + 0.05;
			if(var_02 > 0.75)
			{
				param_00 notify("death");
				return;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}