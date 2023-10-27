/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_warbird.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 93
 * Decompile Time: 1507 ms
 * Timestamp: 10/27/2023 2:10:07 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.warbirdsetting = [];
	level.warbirdsetting["Warbird"] = spawnstruct();
	level.warbirdsetting["Warbird"].vehicle = "warbird_player_mp";
	level.warbirdsetting["Warbird"].modelbase = "vehicle_xh9_warbird_low_cloaked_in_out_mp_cloak";
	level.warbirdsetting["Warbird"].helitype = "warbird";
	level.warbirdsetting["Warbird"].maxhealth = level.heli_maxhealth;
	level.killstreakfuncs["warbird"] = ::tryusewarbird;
	level.killstreakwieldweapons["warbird_remote_turret_mp"] = "warbird";
	level.killstreakwieldweapons["warbird_player_turret_mp"] = "warbird";
	level.killstreakwieldweapons["warbird_missile_mp"] = "warbird";
	level.killstreakwieldweapons["paint_missile_killstreak_mp"] = "warbird";
	if(!isdefined(level.spawnedwarbirds))
	{
		level.spawnedwarbirds = [];
	}

	if(!isdefined(level.warbirdinuse))
	{
		level.warbirdinuse = 0;
	}

	level.chopper_fx["light"]["warbird"] = loadfx("vfx/lights/air_light_wingtip_red");
	level.chopper_fx["engine"]["warbird"] = loadfx("vfx/distortion/distortion_warbird_mp");
	maps\mp\killstreaks\_aerial_utility::makehelitype("warbird","vfx/explosion/vehicle_warbird_explosion_midair",::warbirdlightfx);
	maps\mp\killstreaks\_aerial_utility::addairexplosion("warbird","vfx/explosion/vehicle_warbird_explosion_midair");
	game["dialog"]["assist_mp_warbird"] = "ks_warbird_joinreq";
	game["dialog"]["pilot_sup_mp_warbird"] = "pilot_sup_mp_warbird";
	game["dialog"]["pilot_aslt_mp_warbird"] = "pilot_aslt_mp_warbird";
	game["dialog"]["ks_warbird_destroyed"] = "ks_warbird_destroyed";
}

//Function Number: 2
tryusewarbird(param_00,param_01)
{
	if(!canusewarbird())
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		return 0;
	}

	maps\mp\_utility::incrementfauxvehiclecount();
	level.warbirdinuse = 1;
	var_02 = common_scripts\utility::array_contains(param_01,"warbird_ai_attack") || common_scripts\utility::array_contains(param_01,"warbird_ai_follow");
	if(!var_02)
	{
		thread playerclearwarbirdonteamchange();
		var_03 = maps\mp\killstreaks\_killstreaks::initridekillstreak("warbird");
		if(var_03 != "success")
		{
			maps\mp\_utility::decrementfauxvehiclecount();
			level.warbirdinuse = 0;
			return 0;
		}

		maps\mp\_utility::setusingremote("warbird");
	}

	var_03 = setupwarbirdkillstreak(param_00,param_01);
	if(var_03)
	{
		maps\mp\_matchdata::logkillstreakevent("warbird",self.origin);
	}

	return var_03;
}

//Function Number: 3
playerclearwarbirdonteamchange()
{
	self endon("rideKillstreakBlack");
	self endon("rideKillstreakFailed");
	self waittill("joined_team");
	level.warbirdinuse = 0;
	maps\mp\_utility::decrementfauxvehiclecount();
}

//Function Number: 4
canusewarbird()
{
	return !level.warbirdinuse;
}

//Function Number: 5
iscontrollingwarbird()
{
	return isdefined(self.controllingwarbird) && self.controllingwarbird;
}

//Function Number: 6
warbirdmakevehiclesolidcapsule()
{
	self endon("death");
	wait 0.05;
	self makevehiclesolidcapsule(300,-9,160);
}

//Function Number: 7
setupplayercommands(param_00)
{
	if(isbot(self))
	{
		return;
	}

	self notifyonplayercommand("SwitchVisionMode","+actionslot 1");
	self notifyonplayercommand("SwitchWeapon","weapnext");
	self notifyonplayercommand("ToggleControlState","+activate");
	self notifyonplayercommand("ToggleControlCancel","-activate");
	self notifyonplayercommand("ToggleControlState","+usereload");
	self notifyonplayercommand("ToggleControlCancel","-usereload");
	self notifyonplayercommand("StartFire","+attack");
	self notifyonplayercommand("StartFire","+attack_akimbo_accessible");
	if(isdefined(param_00) && common_scripts\utility::array_contains(param_00,"warbird_cloak"))
	{
		self notifyonplayercommand("Cloak","+smoke");
	}
}

//Function Number: 8
disableplayercommands(param_00)
{
	if(isbot(self))
	{
		return;
	}

	self notifyonplayercommandremove("SwitchVisionMode","+actionslot 1");
	self notifyonplayercommandremove("SwitchWeapon","weapnext");
	self notifyonplayercommandremove("ToggleControlState","+activate");
	self notifyonplayercommandremove("ToggleControlCancel","-activate");
	self notifyonplayercommandremove("ToggleControlState","+usereload");
	self notifyonplayercommandremove("ToggleControlCancel","-usereload");
	self notifyonplayercommandremove("StartFire","+attack");
	self notifyonplayercommandremove("StartFire","+attack_akimbo_accessible");
	if(isdefined(param_00) && param_00.cancloak)
	{
		self notifyonplayercommandremove("Cloak","+smoke");
	}
}

//Function Number: 9
setupwarbirdkillstreak(param_00,param_01)
{
	self endon("warbirdStreakComplete");
	setupplayercommands(param_01);
	self.possesswarbird = 0;
	self.controllingwarbird = 0;
	self.warbirdinit = 1;
	var_02 = buildvalidflightpaths();
	var_03 = findbestspawnlocation(var_02);
	var_03 = rotatehelispawn(var_03);
	var_04 = spawnhelicopter(self,var_03.origin,var_03.angles,level.warbirdsetting["Warbird"].vehicle,level.warbirdsetting["Warbird"].modelbase);
	var_04.currentnode = var_03;
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_04 thread warbird_audio();
	var_04 hide();
	var_04 thread warbirdmakevehiclesolidcapsule();
	var_04.targetent = spawn("script_origin",(0,0,0));
	var_04.vehicletype = "Warbird";
	var_04.heli_type = level.warbirdsetting["Warbird"].helitype;
	var_04.helitype = level.warbirdsetting["Warbird"].helitype;
	var_04.attractor = missile_createattractorent(var_04,level.heli_attract_strength,level.heli_attract_range);
	var_04.lifeid = param_00;
	var_04.team = self.pers["team"];
	var_04.pers["team"] = self.pers["team"];
	var_04.owner = self;
	var_04.maxhealth = level.warbirdsetting["Warbird"].maxhealth;
	var_04.zoffset = (0,0,0);
	var_04.targeting_delay = level.heli_targeting_delay;
	var_04.primarytarget = undefined;
	var_04.secondarytarget = undefined;
	var_04.attacker = undefined;
	var_04.currentstate = "ok";
	var_04.picknewtarget = 1;
	var_04.lineofsight = 0;
	var_04.overheattime = 6;
	var_04.firetime = 0;
	var_04.weaponfire = 0;
	var_04.ismoving = 1;
	var_04.cloakcooldown = 0;
	var_04.iscrashing = 0;
	var_04.ispossessed = 0;
	var_04.modules = param_01;
	var_04.aiattack = common_scripts\utility::array_contains(var_04.modules,"warbird_ai_attack");
	var_04.aifollow = common_scripts\utility::array_contains(var_04.modules,"warbird_ai_follow");
	var_04.hasai = var_04.aiattack || var_04.aifollow;
	var_04.cancloak = common_scripts\utility::array_contains(var_04.modules,"warbird_cloak");
	var_04.hasrockets = common_scripts\utility::array_contains(var_04.modules,"warbird_rockets");
	var_04.coopoffensive = common_scripts\utility::array_contains(var_04.modules,"warbird_coop_offensive");
	var_04.extraflare = common_scripts\utility::array_contains(var_04.modules,"warbird_flares");
	if(var_04.extraflare)
	{
		var_04.numextraflares = 1;
	}
	else
	{
		var_04.numextraflares = 0;
	}

	if(var_04.hasrockets)
	{
		var_04.rocketclip = 3;
	}
	else
	{
		var_04.rocketclip = 0;
	}

	var_04.remainingrocketshots = var_04.rocketclip;
	if(var_04.hasai)
	{
		var_04.usableent = spawn("script_origin",(0,0,0));
		var_04.usableent linkto(var_04);
		var_04.usableent maps\mp\_utility::makegloballyusablebytype("killstreakRemote",&"MP_WARBIRD_PLAYER_PROMPT",self);
	}

	var_04 thread [[ level.lightfxfunc["warbird"] ]]();
	var_04 common_scripts\utility::make_entity_sentient_mp(var_04.team);
	if(!isdefined(level.spawnedwarbirds))
	{
		level.spawnedwarbirds = [];
	}

	level.spawnedwarbirds = common_scripts\utility::array_add(level.spawnedwarbirds,var_04);
	var_04 maps\mp\killstreaks\_aerial_utility::addtohelilist();
	var_04 thread maps\mp\killstreaks\_aerial_utility::heli_flares_monitor(var_04.numextraflares);
	var_04 thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_disconnect(self);
	var_04 thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_changeteams(self);
	var_04 thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_gameended(self);
	var_05 = 30;
	if(common_scripts\utility::array_contains(var_04.modules,"warbird_time"))
	{
		var_05 = 45;
	}

	if(maps\mp\_utility::_hasperk("specialty_blackbox") && isdefined(self.specialty_blackbox_bonus))
	{
		var_05 = var_05 * self.specialty_blackbox_bonus;
	}

	var_04.endtime = gettime() + var_05 * 1000;
	var_04 thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_timeout(var_05);
	var_04 thread maps\mp\killstreaks\_aerial_utility::heli_monitoremp();
	var_04 thread maps\mp\gametypes\_damage::setentitydamagecallback(var_04.maxhealth,undefined,::warbirdondeath,::maps\mp\killstreaks\_aerial_utility::heli_modifydamage,1);
	var_04 thread warbird_health();
	var_04 thread maps\mp\killstreaks\_aerial_utility::heli_existance();
	thread monitoraiwarbirddeathortimeout(var_04);
	thread monitorplayerdisconnect(var_04);
	var_04.warbirdturret = var_04 spawn_warbird_turret("warbird_remote_turret_mp","vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak","tag_player_mp",0);
	var_04.warbirdturret hide();
	if(!var_04.aiattack && !var_04.aifollow)
	{
		var_04.warbirdturret showtoplayer(self);
	}

	var_06 = "orbitalsupport_big_turret_mp";
	if(var_04.coopoffensive)
	{
		var_06 = "warbird_remote_turret_mp";
	}

	var_04.warbirdbuddyturret = var_04 spawn_warbird_turret(var_06,"vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak","tag_playerbuddy_mp",1);
	var_04.warbirdbuddyturret hide();
	thread setupcloaking(var_04);
	thread warbirdoverheatbarcolormonitor(var_04,var_04.warbirdturret);
	if(var_04.aiattack || var_04.aifollow)
	{
		thread playermonitorwarbirdpossession(var_04);
	}
	else
	{
		thread playercontrolwarbirdsetup(var_04);
	}

	if(isdefined(var_04))
	{
		if(level.teambased)
		{
			level thread handlecoopjoining(var_04,self);
		}

		return 1;
	}

	return 0;
}

//Function Number: 10
playermonitorwarbirdpossession(param_00)
{
	self endon("warbirdStreakComplete");
	param_00 waittill("cloaked");
	wait 0.05;
	for(;;)
	{
		monitoraiwarbirdswitch(param_00);
		param_00.usableent waittill("trigger");
		thread manuallyjoinwarbird();
		playercontrolwarbirdsetup(param_00);
	}
}

//Function Number: 11
manuallyjoinwarbird()
{
	self.manuallyjoiningkillstreak = 1;
	common_scripts\utility::waittill_any("death","initRideKillstreak_complete","warbirdStreakComplete");
	self.manuallyjoiningkillstreak = 0;
}

//Function Number: 12
warbirdondeath(param_00,param_01,param_02,param_03)
{
	maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,"warbird_destroyed","ks_warbird_destroyed","callout_destroyed_warbird",1);
}

//Function Number: 13
setupcloaking(param_00)
{
	param_00.cloakstate = 0;
	cloakingtransition(param_00,1,1);
}

//Function Number: 14
warbirdrockethudupdate(param_00)
{
	if(!param_00.hasrockets)
	{
		return;
	}

	switch(param_00.remainingrocketshots)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;

		case 3:
			break;
	}
}

//Function Number: 15
setupwarbirdhud(param_00,param_01,param_02)
{
	self endon("warbirdStreakComplete");
	param_00 endon("death");
	self endon("ResumeWarbirdAI");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self forcefirstpersonwhenfollowed();
	maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
	wait(0.05);
	if(param_01)
	{
		self setclientomnvar("ui_warbird_toggle",2);
	}
	else
	{
		self setclientomnvar("ui_warbird_toggle",1);
	}

	maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
	self setclientomnvar("ui_warbird_cloak",0);
	self setclientomnvar("ui_warbird_countdown",param_00.endtime);
	if(!param_01)
	{
		warbirdrockethudupdate(param_00);
	}

	if(param_01 && !param_00.coopoffensive)
	{
		self setclientomnvar("ui_warbird_weapon",3);
	}
	else if(param_01 && param_00.coopoffensive)
	{
		self setclientomnvar("ui_warbird_weapon",0);
	}
	else if(param_00.hasrockets)
	{
		self setclientomnvar("ui_warbird_weapon",1);
	}
	else
	{
		self setclientomnvar("ui_warbird_weapon",0);
	}

	if(param_01)
	{
		var_03 = param_02 getentitynumber();
		self setclientomnvar("ui_coop_primary_num",var_03);
	}

	if(param_00.cancloak && !param_01)
	{
		self setclientomnvar("ui_warbird_cloaktext",1);
	}
	else
	{
		self setclientomnvar("ui_warbird_cloaktext",0);
	}

	self setclientomnvar("ui_killstreak_optic",0);
}

//Function Number: 16
warbirdoverheatbarcolormonitor(param_00,param_01)
{
	self endon("warbirdStreakComplete");
	param_00 endon("death");
	for(;;)
	{
		param_01.heat_level = param_01 getturretheat();
		self setclientomnvar("ui_warbird_heat",param_01.heat_level);
		var_02 = 0;
		if(isdefined(param_01))
		{
			var_02 = param_01 isturretoverheated();
		}

		if(var_02)
		{
			self setclientomnvar("ui_warbird_fire",1);
		}
		else if(param_01.heat_level > 0.7)
		{
			self setclientomnvar("ui_warbird_fire",2);
		}
		else
		{
			self setclientomnvar("ui_warbird_fire",0);
		}

		while(var_02)
		{
			wait(0.05);
			var_02 = param_01 isturretoverheated();
			param_01.heat_level = param_01 getturretheat();
			self setclientomnvar("ui_warbird_heat",param_01.heat_level);
		}

		self notify("overheatFinished");
		wait 0.05;
	}
}

//Function Number: 17
spawn_warbird_turret(param_00,param_01,param_02,param_03)
{
	var_04 = spawnturret("misc_turret",self gettagorigin(param_02),param_00,0);
	var_04.angles = self gettagangles(param_02);
	var_04 setmodel(param_01);
	var_04 setdefaultdroppitch(45);
	var_04 linkto(self,param_02,(0,0,0),(0,0,0));
	var_04.owner = self.owner;
	var_04.health = 99999;
	var_04.maxhealth = 1000;
	var_04.damagetaken = 0;
	var_04.stunned = 0;
	var_04.stunnedtime = 0;
	var_04 setcandamage(0);
	var_04 setcanradiusdamage(0);
	var_04.team = self.team;
	var_04.pers["team"] = self.team;
	if(level.teambased)
	{
		var_04 setturretteam(self.team);
	}

	var_04 setmode("sentry_manual");
	var_04 setsentryowner(self.owner);
	var_04 setturretminimapvisible(0);
	var_04.chopper = self;
	if(param_03)
	{
		var_04.firesoundent = spawn("script_model",self gettagorigin(param_02));
		var_04.firesoundent setmodel("tag_origin");
		var_04.firesoundent vehicle_jetbikesethoverforcescale(self,param_02,(0,0,0),(0,0,0));
	}

	return var_04;
}

//Function Number: 18
takeover_warbird_turret_buddy(param_00)
{
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(0);
	}

	param_00.warbirdbuddyturret.owner = self;
	param_00.warbirdbuddyturret setmode("sentry_manual");
	param_00.warbirdbuddyturret setsentryowner(self);
	self playerlinkweaponviewtodelta(param_00.warbirdbuddyturret,"tag_player",0,180,180,-20,180,0);
	self playerlinkedsetviewznear(0);
	self playerlinkedsetusebaseangleforviewclamp(1);
	self remotecontrolturret(param_00.warbirdbuddyturret,45,param_00.angles[1]);
}

//Function Number: 19
findbestspawnlocation(param_00)
{
	var_01 = common_scripts\utility::get_array_of_closest(self.origin,param_00);
	return var_01[0];
}

//Function Number: 20
rotatehelispawn(param_00)
{
	var_01 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
	var_02 = anglestoforward(param_00.angles);
	var_03 = var_01.origin - param_00.origin;
	var_04 = vectortoangles(var_03);
	param_00.angles = var_04;
	return param_00;
}

//Function Number: 21
buildvalidflightpaths()
{
	self endon("warbirdStreakComplete");
	if(!isdefined(level.warbirdflightpathnodes))
	{
		level.warbirdflightpathnodes = [];
	}
	else
	{
		return level.warbirdflightpathnodes;
	}

	var_00 = maps\mp\killstreaks\_aerial_utility::getentorstruct("heli_loop_start","targetname");
	var_01 = var_00;
	var_02 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
	var_03 = var_02.origin[2];
	for(;;)
	{
		var_04 = maps\mp\killstreaks\_aerial_utility::getentorstruct(var_01.target,"targetname");
		var_01.next = var_04;
		var_04.prev = var_01;
		var_04.origin = (var_04.origin[0],var_04.origin[1],var_03);
		if(isinarray(level.warbirdflightpathnodes,var_04))
		{
			break;
		}

		level.warbirdflightpathnodes = common_scripts\utility::array_add(level.warbirdflightpathnodes,var_04);
		var_01 = var_04;
	}

	foreach(var_06 in level.warbirdflightpathnodes)
	{
	}

	return level.warbirdflightpathnodes;
}

//Function Number: 22
isinarray(param_00,param_01)
{
	if(isdefined(param_00))
	{
		foreach(var_03 in param_00)
		{
			if(var_03 == param_01)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 23
monitorwarbirdsafearea(param_00)
{
	self endon("warbirdStreakComplete");
	self endon("ResumeWarbirdAI");
	thread maps\mp\killstreaks\_aerial_utility::playerhandleboundarystatic(param_00,"warbirdStreakComplete","ResumeWarbirdAI");
	param_00 waittill("outOfBounds");
	wait(2);
	param_00 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
}

//Function Number: 24
warbirdaiattack(param_00)
{
	thread warbirdfire(param_00);
	thread warbirdlookatenemy(param_00);
	thread warbirdmovetoattackpoint(param_00);
}

//Function Number: 25
warbirdmovetoattackpoint(param_00)
{
	self endon("warbirdPlayerControlled");
	self endon("warbirdStreakComplete");
	if(!isdefined(level.warbirdaiattackbasespeed))
	{
		level.warbirdaiattackbasespeed = 40;
	}

	if(!isdefined(level.warbirdaiattackneargoal))
	{
		level.warbirdaiattackneargoal = 100;
	}

	var_01 = level.warbirdaiattackbasespeed;
	param_00 vehicle_setspeed(var_01,var_01 / 4,var_01 / 4);
	param_00 setneargoalnotifydist(level.warbirdaiattackneargoal);
	var_02 = param_00.currentnode;
	if(!isdefined(var_02))
	{
		var_03 = common_scripts\utility::get_array_of_closest(param_00.origin,buildvalidflightpaths());
		var_04 = param_00.origin;
		for(var_05 = 0;var_05 < var_03.size;var_05++)
		{
			var_06 = var_03[var_05].origin;
			if(maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed(var_04,var_06,param_00))
			{
				var_07 = var_06 - var_04;
				var_08 = distance(var_04,var_06);
				var_09 = rotatevector(var_07,(0,90,0));
				var_0A = var_04 + var_09 * 100;
				var_0B = var_0A + var_07 * var_08;
				if(maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed(var_0A,var_0B,param_00))
				{
					var_0C = rotatevector(var_07,(0,-90,0));
					var_0A = var_04 + var_0C * 100;
					var_0B = var_0A + var_07 * var_08;
					if(maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed(var_0A,var_0B,param_00))
					{
						var_02 = var_03[var_05];
						break;
					}
				}
			}

			wait 0.05;
		}
	}
	else
	{
		var_02 = var_02.next;
	}

	if(!isdefined(var_02))
	{
		return;
	}

	for(;;)
	{
		var_0D = 0;
		if(param_00.aifollow)
		{
			var_0D = 1;
		}

		param_00 setvehgoalpos(var_02.origin,var_0D);
		param_00.ismoving = 1;
		param_00 waittill("near_goal");
		param_00.currentnode = var_02;
		param_00.ismoving = 0;
		var_02 = waituntilmovereturnnode(param_00);
		param_00.currentnode = undefined;
	}
}

//Function Number: 26
waituntilmovereturnnode(param_00)
{
	if(param_00.aifollow && isdefined(param_00.owner))
	{
		var_01 = param_00.currentnode;
		var_02 = var_01.next;
		var_03 = var_01.prev;
		while(isdefined(param_00.owner))
		{
			var_04 = distance2dsquared(param_00.owner.origin,var_01.origin);
			var_05 = distance2dsquared(param_00.owner.origin,var_02.origin);
			var_06 = distance2dsquared(param_00.owner.origin,var_03.origin);
			if(var_05 < var_04 && var_05 < var_06)
			{
				return var_02;
			}
			else if(var_06 < var_04 && var_06 < var_05)
			{
				return var_03;
			}

			wait 0.05;
		}

		return;
	}

	return var_06.currentnode.next;
}

//Function Number: 27
warbirdlookatenemy(param_00)
{
	self endon("warbirdPlayerControlled");
	self endon("warbirdStreakComplete");
	for(;;)
	{
		if(isdefined(param_00.enemy_target))
		{
			monitorlookatent(param_00);
			param_00.warbirdturret cleartargetentity();
		}

		wait 0.05;
	}
}

//Function Number: 28
monitorlookatent(param_00)
{
	self endon("warbirdPlayerControlled");
	self endon("warbirdStreakComplete");
	param_00 endon("pickNewTarget");
	param_00 setlookatent(param_00.enemy_target);
	param_00.warbirdturret settargetentity(param_00.enemy_target);
	param_00.enemy_target common_scripts\utility::waittill_either("death","disconnect");
	param_00.picknewtarget = 1;
	param_00.lineofsight = 0;
}

//Function Number: 29
warbirdfire(param_00)
{
	self endon("warbirdPlayerControlled");
	self endon("warbirdStreakComplete");
	thread fireai(param_00);
	for(;;)
	{
		if(param_00.picknewtarget)
		{
			var_01 = level.participants;
			var_02 = [];
			foreach(var_04 in var_01)
			{
				if(var_04.team != self.team)
				{
					var_02 = common_scripts\utility::array_add(var_02,var_04);
				}
			}

			if(param_00.aiattack)
			{
				var_02 = sortbydistance(var_02,param_00.origin);
			}
			else
			{
				var_02 = sortbydistance(var_02,self.origin);
			}

			var_06 = undefined;
			foreach(var_04 in var_02)
			{
				if(!isdefined(var_04))
				{
					continue;
				}

				if(!isalive(var_04))
				{
					continue;
				}

				if(var_04 maps\mp\_utility::_hasperk("specialty_blindeye"))
				{
					continue;
				}

				if(isdefined(var_04.spawntime) && gettime() - var_04.spawntime / 1000 < 5)
				{
					continue;
				}

				var_06 = var_04;
				param_00.enemy_target = var_06;
				checkwarbirdtargetlos(param_00);
				break;
			}
		}

		param_00 notify("LostLOS");
		wait(0.05);
	}
}

//Function Number: 30
fireai(param_00)
{
	self endon("warbirdPlayerControlled");
	self endon("warbirdStreakComplete");
	param_00.remainingrocketshots = param_00.rocketclip;
	for(;;)
	{
		wait 0.05;
		if(!isdefined(param_00.enemy_target) || !isalive(param_00.enemy_target) || !param_00.lineofsight)
		{
			continue;
		}

		if(param_00.hasrockets && param_00.remainingrocketshots)
		{
			fireairocket(param_00);
		}

		param_00.warbirdturret shootturret();
	}
}

//Function Number: 31
fireairocket(param_00)
{
	var_01 = param_00 gettagorigin("tag_missile_right");
	var_02 = vectornormalize(anglestoforward(param_00.angles));
	var_03 = param_00 vehicle_getvelocity();
	var_04 = magicbullet("warbird_missile_mp",var_01 + var_03 / 10,self geteye() + var_03 + var_02 * 1000,self);
	var_04.killcament = param_00;
	playfxontag(level.chopper_fx["rocketlaunch"]["warbird"],param_00,"tag_missile_right");
	var_04 missile_settargetent(param_00.enemy_target);
	var_04 missile_setflightmodedirect();
	param_00.remainingrocketshots--;
	if(param_00.remainingrocketshots <= 0)
	{
		thread warbirdairocketreload(param_00);
	}

	waittillrocketdeath(param_00,var_04);
}

//Function Number: 32
warbirdairocketreload(param_00)
{
	param_00 endon("warbirdStreakComplete");
	wait(6);
	param_00.remainingrocketshots = param_00.rocketclip;
}

//Function Number: 33
waittillrocketdeath(param_00,param_01)
{
	param_00.enemy_target endon("death");
	param_00.enemy_target endon("disconnect");
	param_01 waittill("death");
}

//Function Number: 34
checkwarbirdtargetlos(param_00)
{
	self endon("warbirdPlayerControlled");
	self endon("warbirdStreakComplete");
	param_00.enemy_target endon("death");
	param_00.enemy_target endon("disconnect");
	for(;;)
	{
		var_01 = param_00 gettagorigin("TAG_FLASH1");
		var_02 = param_00.enemy_target geteye();
		var_03 = vectornormalize(var_02 - var_01);
		var_04 = var_01 + var_03 * 20;
		var_05 = bullettrace(var_04,var_02,0,param_00,0,0,0,0,0);
		if(!checktargetisinvision(param_00) && var_05["fraction"] < 1)
		{
			param_00.lineofsight = 0;
			param_00.picknewtarget = 1;
			param_00.enemy_target = undefined;
			param_00 notify("pickNewTarget");
			return;
		}

		param_00.lineofsight = 1;
		wait(0.25);
	}
}

//Function Number: 35
checktargetisinvision(param_00)
{
	var_01 = anglestoforward(param_00.angles);
	var_02 = param_00.enemy_target.origin - param_00.origin;
	var_03 = vectordot(var_01,var_02);
	return var_03 < 0;
}

//Function Number: 36
playercontrolwarbirdsetup(param_00)
{
	self endon("warbirdStreakComplete");
	self.possesswarbird = 1;
	self.controllingwarbird = 1;
	param_00.player = self;
	param_00.currentnode = undefined;
	maps\mp\_utility::playersaveangles();
	wait 0.05;
	self notify("warbirdPlayerControlled");
	param_00.ispossessed = 1;
	param_00.killcamstarttime = undefined;
	param_00.warbirdturret.killcament = undefined;
	if(self.warbirdinit != 1)
	{
		maps\mp\_utility::_giveweapon("killstreak_predator_missile_mp");
		self switchtoweapon("killstreak_predator_missile_mp");
		while(self getcurrentweapon() != "killstreak_predator_missile_mp")
		{
			wait 0.05;
		}

		thread playerdoridekillstreak(param_00,0);
		self waittill("initRideKillstreak_complete",var_01);
		if(!var_01)
		{
			return;
		}

		maps\mp\_utility::setusingremote("Warbird");
	}

	thread setupwarbirdhud(param_00);
	thread monitorwarbirdsafearea(param_00);
	thread waitsetthermal(0.5);
	thread setwarbirdvisionsetpermap(0.5);
	self enableslowaim(0.3,0.3);
	pausewarbirdenginefxforplayer(param_00);
	param_00.playerattachpoint = spawn("script_model",(0,0,0));
	param_00.playerattachpoint setmodel("tag_player");
	param_00.playerattachpoint hide();
	var_02 = param_00 gettagorigin("tag_origin");
	var_03 = param_00 gettagangles("tag_origin");
	var_04 = anglestoforward(var_03);
	var_02 = var_02 + var_04 * 165;
	var_02 = var_02 + (0,0,-10);
	param_00.playerattachpoint.origin = var_02;
	param_00.playerattachpoint.angles = var_03;
	param_00.playerattachpoint linkto(param_00,"tag_player_mp");
	self unlink();
	param_00 cancelaimove(param_00);
	thread warbirdrocketdamageindicator(param_00);
	self remotecontrolvehicle(param_00);
	thread weaponsetup(param_00);
	thread playercloakready(param_00);
	param_00.warbirdturret setmode("sentry_manual");
	self remotecontrolturret(param_00.warbirdturret,45);
	while(self.possesswarbird)
	{
		exitwarbirdcontrolstate(param_00);
	}

	maps\mp\_utility::playerrestoreangles();
	if(!param_00.aiattack && !param_00.aifollow)
	{
		param_00 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
	}
}

//Function Number: 37
setwarbirdvisionsetpermap(param_00)
{
	self endon("disconnect");
	self endon("warbirdStreakComplete");
	wait(param_00);
	if(isdefined(level.warbirdvisionset))
	{
		self setclienttriggervisionset(level.warbirdvisionset,0);
	}
}

//Function Number: 38
removewarbirdvisionsetpermap(param_00)
{
	self setclienttriggervisionset("",param_00);
}

//Function Number: 39
playerdoridekillstreak(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = "warbird";
	if(param_01)
	{
		var_02 = "coop";
	}

	var_03 = maps\mp\killstreaks\_killstreaks::initridekillstreak(var_02);
	if(var_03 != "success" || param_01 && !level.warbirdinuse || !isdefined(param_00) || isdefined(param_00.isleaving) && param_00.isleaving)
	{
		if(param_01)
		{
			removewarbirdbuddy(param_00,var_03 == "disconnect");
		}
		else if(var_03 != "disconnect")
		{
			playerreset(param_00);
		}

		self notify("initRideKillstreak_complete",0);
		return;
	}

	self notify("initRideKillstreak_complete",1);
}

//Function Number: 40
exitwarbirdcontrolstate(param_00)
{
	self endon("warbirdStreakComplete");
	self waittill("ToggleControlState");
	thread cancelexitbuttonpressmonitor();
	self.possesswarbird = 0;
	wait(0.5);
	self notify("ExitHoldTimeComplete");
}

//Function Number: 41
cancelexitbuttonpressmonitor()
{
	self endon("warbirdStreakComplete");
	self endon("ExitHoldTimeComplete");
	self waittill("ToggleControlCancel");
	self.possesswarbird = 1;
}

//Function Number: 42
waitsetthermal(param_00)
{
	self endon("warbirdStreakComplete");
	self endon("ResumeWarbirdAI");
	wait(param_00);
	self thermalvisionfofoverlayon();
	self setblurforplayer(1.1,0);
	var_01 = 135;
	var_02 = 0;
	var_03 = 60;
	var_04 = 0;
	var_05 = 12;
	var_06 = 5;
	maps\mp\killstreaks\_aerial_utility::thermalvision("warbirdThermalOff",var_01,var_02,var_03,var_04,var_05,var_06);
}

//Function Number: 43
waitsetthermalbuddy(param_00)
{
	self endon("warbirdStreakComplete");
	self endon("ResumeWarbirdAI");
	wait(param_00);
	self thermalvisionfofoverlayon();
	self setblurforplayer(1.1,0);
	var_01 = 100;
	var_02 = 60;
	var_03 = 512;
	var_04 = 0;
	var_05 = 12;
	var_06 = 5;
	maps\mp\killstreaks\_aerial_utility::thermalvision("warbirdThermalOff",var_01,var_02,var_03,var_04,var_05,var_06);
}

//Function Number: 44
playercloakready(param_00,param_01)
{
	self endon("warbirdStreakComplete");
	self endon("ResumeWarbirdAI");
	if(isdefined(self.warbirdinit) && self.warbirdinit == 1)
	{
		param_00 waittill("cloaked");
		common_scripts\utility::waittill_any_return_no_endon_death("ForceUncloak","Cloak","ResumeWarbirdAI");
		switchtovisible(param_00);
		param_00.playerattachpoint play_sound_on_entity("warbird_cloak_deactivate");
	}

	for(;;)
	{
		thread playercloakactivated(param_00);
		thread playercloakcooldown(param_00);
		if(param_00.cloakcooldown != 0)
		{
			self setclientomnvar("ui_warbird_cloaktext",3);
			wait(param_00.cloakcooldown);
		}

		thread cloakreadydialog();
		if(param_00.cancloak)
		{
			self setclientomnvar("ui_warbird_cloaktext",1);
		}

		self waittill("Cloak");
		self notify("ActivateCloak");
		param_00 play_sound_on_entity("warbird_cloak_activate");
		self waittill("CloakCharged");
	}
}

//Function Number: 45
playercloakactivated(param_00)
{
	self endon("warbirdStreakComplete");
	self endon("ResumeWarbirdAI");
	self waittill("ActivateCloak");
	var_01 = 10000;
	self setclientomnvar("ui_warbird_cloaktime",var_01 + gettime());
	switchtocloaked(param_00);
	thread cloakactivateddialog(param_00);
	self setclientomnvar("ui_warbird_cloaktext",2);
	param_00.cloakcooldown = 5;
	thread cloakcooldown(param_00);
	thread playercloakwaitforexit(param_00);
}

//Function Number: 46
playercloakcooldown(param_00)
{
	self endon("warbirdStreakComplete");
	self waittill("UnCloak");
	thread playcloakoverheatdialog(param_00);
	switchtovisible(param_00);
	self setclientomnvar("ui_warbird_cloaktext",3);
	thread cloakdeactivateddialog(param_00);
}

//Function Number: 47
cloakcooldown(param_00)
{
	self endon("warbirdStreakComplete");
	self waittill("UnCloak");
	while(param_00.cloakcooldown > 0)
	{
		param_00.cloakcooldown = param_00.cloakcooldown - 0.5;
		wait(0.5);
	}

	param_00.cloakcooldown = 0;
	self notify("CloakCharged");
}

//Function Number: 48
playercloakwaitforexit(param_00)
{
	self endon("warbirdStreakComplete");
	var_01 = gettime();
	common_scripts\utility::waittill_any_timeout_no_endon_death(10,"ForceUncloak","Cloak","ResumeWarbirdAI");
	var_02 = gettime();
	var_03 = max(var_02 - var_01,5000);
	param_00.cloakcooldown = var_03 / 1000;
	var_04 = gettime() + var_03;
	self setclientomnvar("ui_warbird_cloakdur",var_04);
	self notify("UnCloak");
}

//Function Number: 49
switchtocloaked(param_00)
{
	if(isdefined(param_00))
	{
		thread cloakingtransition(param_00,1);
		missile_deleteattractor(param_00.attractor);
		self setclientomnvar("ui_warbird_cloak",1);
		thread monitordamagewhilecloaking(param_00);
	}
}

//Function Number: 50
switchtovisible(param_00)
{
	if(isdefined(param_00))
	{
		thread cloakingtransition(param_00,0);
		param_00.attractor = missile_createattractorent(param_00,level.heli_attract_strength,level.heli_attract_range);
		self setclientomnvar("ui_warbird_cloak",0);
	}
}

//Function Number: 51
cloakingtransition(param_00,param_01,param_02)
{
	param_00 notify("cloaking_transition");
	param_00 endon("cloaking_transition");
	param_00 endon("warbirdStreakComplete");
	if(param_01)
	{
		if(param_00.cloakstate == -2)
		{
			return;
		}

		param_00.cloakstate = -1;
		param_00 cloakingenable();
		param_00.warbirdturret cloakingenable();
		if(param_00.coopoffensive)
		{
			param_00.warbirdbuddyturret cloakingenable();
		}

		param_00 vehicle_setminimapvisible(0);
		if(!isdefined(param_02) || !param_02)
		{
			wait(0.2);
		}
		else
		{
			wait(1.5);
		}

		param_00 show();
		param_00.warbirdturret show();
		if(param_00.coopoffensive)
		{
			param_00.warbirdbuddyturret show();
		}

		param_00.cloakstate = -2;
		param_00 notify("cloaked");
		param_00 stopwarbirdenginefx();
		return;
	}

	if(param_00.cloakstate == 2)
	{
		return;
	}

	param_00.cloakstate = 1;
	param_00 cloakingdisable();
	param_00 vehicle_setminimapvisible(1);
	param_00.warbirdturret cloakingdisable();
	if(param_00.coopoffensive)
	{
		param_00.warbirdbuddyturret cloakingdisable();
	}

	wait(2.2);
	param_00.cloakstate = 2;
	param_00 playwarbirdenginefx();
}

//Function Number: 52
cloakdeactivateddialog(param_00)
{
	self endon("CloakCharged");
	self endon("warbirdStreakComplete");
	self endon("ResumeWarbirdAI");
	for(;;)
	{
		self waittill("Cloak");
		param_00.playerattachpoint play_sound_on_entity("warbird_cloak_notready");
		wait(1);
	}
}

//Function Number: 53
cloakreadydialog()
{
}

//Function Number: 54
cloakactivateddialog(param_00)
{
}

//Function Number: 55
playcloakoverheatdialog(param_00)
{
	param_00.playerattachpoint play_sound_on_entity("warbird_cloak_deactivate");
}

//Function Number: 56
cloakwarbirdexit(param_00,param_01)
{
	if(isdefined(param_00) && param_00.iscrashing == 0)
	{
		if(isdefined(param_01))
		{
			param_01 notify("ActivateCloak");
		}

		thread cloakingtransition(param_00,1);
		missile_deleteattractor(param_00.attractor);
	}
}

//Function Number: 57
monitordamagewhilecloaking(param_00)
{
	self endon("UnCloak");
	self endon("warbirdStreakComplete");
	self endon("ResumeWarbirdAI");
	wait(1);
	param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05);
	self notify("ForceUncloak");
}

//Function Number: 58
warbirdrocketdamageindicator(param_00)
{
	self endon("ResumeWarbirdAI");
	self endon("warbirdStreakComplete");
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(var_05 == "MOD_PROJECTILE")
		{
			earthquake(0.75,1,param_00.origin,1000);
			self shellshock("frag_grenade_mp",0.5);
		}
	}
}

//Function Number: 59
updateshootinglocation(param_00)
{
	self endon("warbirdStreakComplete");
	level endon("ResumeWarbirdAI");
	for(;;)
	{
		var_01 = self getplayerangles();
		var_02 = param_00.playerattachpoint.origin;
		var_03 = anglestoforward(var_01);
		var_04 = var_02 + var_03 * 4000;
		param_00.targetent.origin = var_04;
		wait(0.05);
	}
}

//Function Number: 60
monitorweaponselection(param_00)
{
	self endon("warbirdStreakComplete");
	self endon("ResumeWarbirdAI");
	self.current_warbird_weapon = "turret";
	param_00.warbirdturret turretfireenable();
	if(!param_00.hasrockets)
	{
		return;
	}

	for(;;)
	{
		self waittill("SwitchWeapon");
		if(self.current_warbird_weapon == "turret")
		{
			self.current_warbird_weapon = "missiles";
			param_00.warbirdturret turretfiredisable();
			self setclientomnvar("ui_warbird_weapon",2);
		}
		else if(self.current_warbird_weapon == "missiles")
		{
			self.current_warbird_weapon = "turret";
			param_00.warbirdturret turretfireenable();
			self setclientomnvar("ui_warbird_weapon",1);
		}

		self playlocalsound("warbird_weapon_cycle_plr");
	}
}

//Function Number: 61
weaponsetup(param_00)
{
	if(param_00.hasrockets)
	{
		thread firewarbirdrockets(param_00);
	}

	thread monitorweaponselection(param_00);
	thread updateshootinglocation(param_00);
	thread force_uncloak_on_fire(param_00);
}

//Function Number: 62
waittillturretfired(param_00)
{
	param_00 endon("warbirdStreakComplete");
	param_00.warbirdturret endon("turret_fire");
	if(param_00.coopoffensive)
	{
		param_00.warbirdbuddyturret endon("turret_fire");
	}

	level waittill("forever");
}

//Function Number: 63
force_uncloak_on_fire(param_00)
{
	level endon("game_ended");
	self endon("warbirdStreakComplete");
	for(;;)
	{
		waittillturretfired(param_00);
		self notify("ForceUncloak");
		wait(0.05);
	}
}

//Function Number: 64
firewarbirdthreatgrenades(param_00)
{
	param_00 endon("warbirdStreakComplete");
	self endon("warbirdStreakComplete");
	self endon("warbird_player_removed");
	for(;;)
	{
		self waittill("StartFire");
		maps\mp\killstreaks\_aerial_utility::playerfakeshootpaintmissile(param_00.warbirdbuddyturret.firesoundent);
		playfxontag(level.chopper_fx["rocketlaunch"]["warbird"],param_00,"tag_origin");
		wait(2);
	}
}

//Function Number: 65
firewarbirdrockets(param_00)
{
	self endon("ResumeWarbirdAI");
	self endon("warbirdStreakComplete");
	param_00.remainingrocketshots = param_00.rocketclip;
	for(;;)
	{
		if(self.guid == "bot0" || self.guid == "bot1" || self.guid == "bot2" || self.guid == "bot3")
		{
			wait(3);
		}
		else
		{
			self waittill("StartFire");
		}

		if(self.current_warbird_weapon == "missiles" || self.guid == "bot0" || self.guid == "bot1" || self.guid == "bot2" || self.guid == "bot3")
		{
			earthquake(0.4,1,param_00.origin,1000);
			self playrumbleonentity("ac130_105mm_fire");
			var_01 = param_00 gettagorigin("tag_missile_right");
			var_02 = vectornormalize(anglestoforward(self getplayerangles()));
			var_03 = param_00 getentityvelocity();
			var_04 = magicbullet("warbird_missile_mp",var_01 + var_03 / 10,self geteye() + var_03 + var_02 * 1000,self);
			playfxontag(level.chopper_fx["rocketlaunch"]["warbird"],param_00,"tag_missile_right");
			var_04 missile_settargetent(param_00.targetent);
			var_04 missile_setflightmodedirect();
			param_00.remainingrocketshots--;
			self notify("ForceUncloak");
			warbirdrockethudupdate(param_00);
			if(param_00.remainingrocketshots == 0)
			{
				thread warbirdrocketreloadsound(param_00,6);
				wait(6);
				param_00.remainingrocketshots = param_00.rocketclip;
				self notify("rocketReloadComplete");
				warbirdrockethudupdate(param_00);
			}
			else
			{
				wait(0.05);
			}
		}
	}
}

//Function Number: 66
warbirdrocketreloadsound(param_00,param_01)
{
	self endon("rocketReloadComplete");
	self endon("ResumeWarbirdAI");
	self endon("warbirdStreakComplete");
	var_02 = 3;
	self playlocalsound("warbird_missile_reload_bed");
	wait(0.5);
	for(;;)
	{
		self playlocalsound("warbird_missile_reload");
		wait(param_01 / var_02);
	}
}

//Function Number: 67
handlecoopjoining(param_00,param_01)
{
	var_02 = "warbird_coop_defensive";
	var_03 = &"MP_JOIN_WARBIRD_DEF";
	var_04 = "pilot_sup_mp_warbird";
	var_05 = "copilot_sup_mp_paladin";
	if(param_00.coopoffensive)
	{
		var_02 = "warbird_coop_offensive";
		var_03 = &"MP_JOIN_WARBIRD_OFF";
		var_04 = "pilot_aslt_mp_warbird";
		var_05 = "copilot_aslt_mp_paladin";
	}

	for(;;)
	{
		var_06 = maps\mp\killstreaks\_coop_util::promptforstreaksupport(param_01.team,var_03,var_02,"assist_mp_warbird",var_04,param_01,var_05);
		level thread watchforjoin(var_06,param_00,param_01);
		var_07 = waittillpromptcomplete(param_00,"buddyJoinedStreak");
		maps\mp\killstreaks\_coop_util::stoppromptforstreaksupport(var_06);
		if(!isdefined(var_07))
		{
			return;
		}

		var_07 = waittillpromptcomplete(param_00,"buddyLeftWarbird");
		if(!isdefined(var_07))
		{
			return;
		}
	}
}

//Function Number: 68
waittillpromptcomplete(param_00,param_01)
{
	param_00 endon("warbirdStreakComplete");
	param_00 waittill(param_01);
	return 1;
}

//Function Number: 69
watchforjoin(param_00,param_01,param_02)
{
	param_01 endon("warbirdStreakComplete");
	var_03 = maps\mp\killstreaks\_coop_util::waittillbuddyjoinedstreak(param_00);
	param_01 notify("buddyJoinedStreak");
	var_03 thread buddyjoinwarbirdsetup(param_01,param_02);
}

//Function Number: 70
buddyjoinwarbirdsetup(param_00,param_01)
{
	param_00 endon("warbirdStreakComplete");
	self endon("warbirdStreakComplete");
	self endon("warbird_player_removed");
	thread warbirdoverheatbarcolormonitor(param_00,param_00.warbirdbuddyturret);
	param_00.buddy = self;
	self.controllingwarbird = 1;
	thread playerdoridekillstreak(param_00,1);
	self waittill("initRideKillstreak_complete",var_02);
	if(!var_02)
	{
		return;
	}

	maps\mp\_utility::setusingremote("Warbird");
	maps\mp\_utility::playersaveangles();
	thread setupwarbirdhud(param_00,1,param_01);
	thread monitorbuddywarbirddeathortimeout(param_00);
	thread monitorbuddydisconnect(param_00);
	thread waitsetthermalbuddy(0.5);
	thread setwarbirdvisionsetpermap(0.5);
	pausewarbirdenginefxforplayer(param_00);
	thread warbirdrocketdamageindicator(param_00);
	takeover_warbird_turret_buddy(param_00);
	setupplayercommands();
	if(!param_00.coopoffensive)
	{
		thread firewarbirdthreatgrenades(param_00);
	}

	if(!isbot(self))
	{
		thread removewarbirdbuddyoncommand(param_00);
	}
}

//Function Number: 71
removewarbirdbuddy(param_00,param_01)
{
	self notify("warbird_player_removed");
	if(!param_01)
	{
		playerresetwarbirdomnvars();
		self setblurforplayer(0,0);
		self notify("warbirdThermalOff");
		maps\mp\killstreaks\_aerial_utility::disableorbitalthermal(self);
		thread removewarbirdvisionsetpermap(1.5);
		self thermalvisionfofoverlayoff();
		if(isdefined(param_00.warbirdbuddyturret) && iscontrollingwarbird())
		{
			self remotecontrolturretoff(param_00.warbirdbuddyturret);
		}

		self.controllingwarbird = undefined;
		self enableweapons();
		self unlink();
		maps\mp\killstreaks\_coop_util::playerresetaftercoopstreak();
		self disableslowaim();
		disableplayercommands(param_00);
		restartwarbirdenginefxforplayer(param_00);
		if(maps\mp\_utility::isusingremote())
		{
			maps\mp\_utility::clearusingremote();
		}

		maps\mp\_utility::playerremotekillstreakshowhud();
		maps\mp\_utility::playerrestoreangles();
	}

	param_00 notify("buddyLeftWarbird");
	param_00.buddy = undefined;
}

//Function Number: 72
monitorbuddywarbirddeathortimeout(param_00)
{
	self endon("disconnect");
	param_00 common_scripts\utility::waittill_any("leaving","death","crashing");
	self notify("warbirdStreakComplete");
	self notify("StopWaitForDisconnect");
	waittillframeend;
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	thread removewarbirdbuddy(param_00,0);
}

//Function Number: 73
monitorbuddydisconnect(param_00)
{
	self endon("StopWaitForDisconnect");
	self waittill("disconnect");
	thread removewarbirdbuddy(param_00,1);
}

//Function Number: 74
removewarbirdbuddyoncommand(param_00)
{
	self endon("warbird_player_removed");
	for(;;)
	{
		self waittill("ToggleControlState");
		thread startwarbirdbuddyexitcommand(param_00);
		thread cancelwarbirdbuddyexitcommand();
	}
}

//Function Number: 75
startwarbirdbuddyexitcommand(param_00)
{
	self endon("warbird_player_removed");
	self endon("ToggleControlCancel");
	self.warbird_buddy_exit = 1;
	wait(0.5);
	if(self.warbird_buddy_exit == 1)
	{
		thread removewarbirdbuddy(param_00,0);
	}
}

//Function Number: 76
cancelwarbirdbuddyexitcommand()
{
	self endon("warbird_player_removed");
	self waittill("ToggleControlCancel");
	self.warbird_buddy_exit = 0;
}

//Function Number: 77
monitoraiwarbirdswitch(param_00,param_01)
{
	self endon("warbirdStreakComplete");
	self.warbirdinit = 0;
	self notify("ResumeWarbirdAI");
	self notify("warbirdThermalOff");
	param_00.ispossessed = 0;
	thread cloakingtransition(param_00,0);
	param_00.warbirdturret setmode("auto_nonai");
	playerresetwarbirdomnvars();
	waittillframeend;
	thread warbirdaiattack(param_00);
	param_00.killcamstarttime = gettime();
	param_00.warbirdturret.killcament = param_00;
	param_00.player = undefined;
	if(maps\mp\_utility::isusingremote())
	{
		playerreset(param_00);
	}

	wait 0.05;
}

//Function Number: 78
monitoraiwarbirddeathortimeout(param_00)
{
	self endon("disconnect");
	thread checkforcrashing(param_00);
	var_01 = param_00 common_scripts\utility::waittill_any_return("leaving","death","crashing");
	playerresetafterwarbird(param_00);
	level thread warbirdcleanup(param_00,self,var_01 != "death");
}

//Function Number: 79
warbirdcleanup(param_00,param_01,param_02)
{
	level.spawnedwarbirds = common_scripts\utility::array_remove(level.spawnedwarbirds,param_00);
	level.warbirdinuse = 0;
	if(isdefined(param_00.usableent))
	{
		param_00.usableent maps\mp\_utility::makegloballyunusablebytype();
	}

	thread cloakwarbirdexit(param_00,param_01);
	if(isdefined(param_00.attractor))
	{
		missile_deleteattractor(param_00.attractor);
	}

	if(isdefined(param_00.playerattachpoint))
	{
		param_00.playerattachpoint delete();
	}

	param_00.enemy_target = undefined;
	if(param_02)
	{
		param_00 waittill("death");
	}
	else
	{
		waittillframeend;
	}

	var_03 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(var_03 != 0)
	{
		wait 0.05;
	}

	param_00.warbirdturret delete();
	if(isdefined(param_00.warbirdbuddyturret))
	{
		if(isdefined(param_00.warbirdbuddyturret.firesoundent))
		{
			param_00.warbirdbuddyturret.firesoundent delete();
		}

		param_00.warbirdbuddyturret delete();
	}

	if(isdefined(param_00.usableent))
	{
		param_00.usableent delete();
	}
}

//Function Number: 80
playerresetafterwarbird(param_00)
{
	self notify("warbirdStreakComplete");
	param_00 notify("warbirdStreakComplete");
	waittillframeend;
	playerresetwarbirdomnvars();
	if(param_00.ispossessed && !maps\mp\_utility::isinremotetransition())
	{
		playerreset(param_00);
		param_00.ispossessed = 0;
	}

	disableplayercommands(param_00);
	self notify("StopWaitForDisconnect");
}

//Function Number: 81
playerreset(param_00)
{
	self setblurforplayer(0,0);
	maps\mp\killstreaks\_aerial_utility::disableorbitalthermal(self);
	self thermalvisionfofoverlayoff();
	thread removewarbirdvisionsetpermap(1.5);
	self remotecontrolvehicleoff();
	if(isdefined(param_00.warbirdturret) && iscontrollingwarbird())
	{
		self remotecontrolturretoff(param_00.warbirdturret);
	}

	self.controllingwarbird = undefined;
	self.possesswarbird = undefined;
	self enableweapons();
	self unlink();
	if(maps\mp\_utility::isusingremote())
	{
		maps\mp\_utility::clearusingremote();
	}
	else
	{
		var_01 = self getcurrentweapon();
		if(var_01 == "none" || maps\mp\_utility::iskillstreakweapon(var_01))
		{
			self switchtoweapon(common_scripts\utility::getlastweapon());
		}

		maps\mp\_utility::playerremotekillstreakshowhud();
	}

	thread playerdelaycontrol();
	if(param_00.hasai)
	{
		maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe("killstreak_predator_missile_mp");
	}

	self enableweaponswitch();
	self disableslowaim();
	if(!isdefined(param_00.isleaving) || !param_00.isleaving)
	{
		restartwarbirdenginefxforplayer(param_00);
	}

	maps\mp\_utility::playerrestoreangles();
}

//Function Number: 82
playerdelaycontrol()
{
	self endon("disconnect");
	maps\mp\_utility::freezecontrolswrapper(1);
	wait(0.5);
	maps\mp\_utility::freezecontrolswrapper(0);
}

//Function Number: 83
checkforcrashing(param_00)
{
	param_00 common_scripts\utility::waittill_any("crashing","death");
	param_00.iscrashing = 1;
}

//Function Number: 84
monitorplayerdisconnect(param_00)
{
	self endon("StopWaitForDisconnect");
	self waittill("disconnect");
	param_00 notify("warbirdStreakComplete");
	self notify("warbirdStreakComplete");
	self notify("warbirdThermalOff");
	param_00 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
	level thread warbirdcleanup(param_00,self,1);
}

//Function Number: 85
play_sound_on_entity(param_00)
{
	self playsound(param_00);
}

//Function Number: 86
warbird_health()
{
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	self.currentstate = "ok";
	self.laststate = "ok";
	self setdamagestage(3);
	var_00 = 3;
	self setdamagestage(var_00);
	for(;;)
	{
		if(self.damagetaken >= self.maxhealth * 0.33 && var_00 == 3)
		{
			var_00 = 2;
			self setdamagestage(var_00);
			self.currentstate = "light smoke";
			playfxontag(level.chopper_fx["damage"]["light_smoke"],self,"tag_static_main_rotor_l");
		}
		else if(self.damagetaken >= self.maxhealth * 0.66 && var_00 == 2)
		{
			var_00 = 1;
			self setdamagestage(var_00);
			self.currentstate = "heavy smoke";
			stopfxontag(level.chopper_fx["damage"]["light_smoke"],self,"tag_static_main_rotor_l");
			playfxontag(level.chopper_fx["damage"]["heavy_smoke"],self,"tag_static_main_rotor_l");
		}
		else if(self.damagetaken >= self.maxhealth)
		{
			var_00 = 0;
			self setdamagestage(var_00);
			if(isdefined(self.largeprojectiledamage) && self.largeprojectiledamage)
			{
				thread maps\mp\killstreaks\_aerial_utility::heli_explode(1);
			}
			else
			{
				playfxontag(level.chopper_fx["damage"]["on_fire"],self,"TAG_TAIL_FX");
				thread maps\mp\killstreaks\_aerial_utility::heli_crash();
			}
		}

		wait(0.05);
	}
}

//Function Number: 87
playerresetwarbirdomnvars()
{
	self setclientomnvar("ui_warbird_heat",0);
	self setclientomnvar("ui_warbird_flares",0);
	self setclientomnvar("ui_warbird_fire",0);
	self setclientomnvar("ui_warbird_cloak",0);
	self setclientomnvar("ui_warbird_cloaktime",0);
	self setclientomnvar("ui_warbird_cloakdur",0);
	self setclientomnvar("ui_warbird_countdown",0);
	self setclientomnvar("ui_warbird_missile",-1);
	self setclientomnvar("ui_warbird_weapon",0);
	self setclientomnvar("ui_warbird_cloaktext",0);
	self setclientomnvar("ui_warbird_toggle",0);
	self setclientomnvar("ui_coop_primary_num",0);
	maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
	self disableforcefirstpersonwhenfollowed();
}

//Function Number: 88
playwarbirdenginefx()
{
	playfxontag(level.chopper_fx["engine"]["warbird"],self,"tag_static_main_rotor_r");
	playfxontag(level.chopper_fx["engine"]["warbird"],self,"tag_static_main_rotor_l");
	if(isdefined(self.player))
	{
		self.player pausewarbirdenginefxforplayer(self);
	}

	if(isdefined(self.buddy))
	{
		self.buddy pausewarbirdenginefxforplayer(self);
	}
}

//Function Number: 89
stopwarbirdenginefx()
{
	stopfxontag(level.chopper_fx["engine"]["warbird"],self,"tag_static_main_rotor_r");
	stopfxontag(level.chopper_fx["engine"]["warbird"],self,"tag_static_main_rotor_l");
}

//Function Number: 90
pausewarbirdenginefxforplayer(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	stopfxontagforclient(level.chopper_fx["engine"]["warbird"],param_00,"tag_static_main_rotor_r",self);
	stopfxontagforclient(level.chopper_fx["engine"]["warbird"],param_00,"tag_static_main_rotor_l",self);
}

//Function Number: 91
restartwarbirdenginefxforplayer(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(maps\mp\killstreaks\_aerial_utility::vehicleiscloaked())
	{
		return;
	}

	playfxontagforclients(level.chopper_fx["engine"]["warbird"],param_00,"tag_static_main_rotor_r",self);
	playfxontagforclients(level.chopper_fx["engine"]["warbird"],param_00,"tag_static_main_rotor_l",self);
}

//Function Number: 92
warbird_audio()
{
	if(isdefined(self))
	{
	}
}

//Function Number: 93
warbirdlightfx()
{
	self endon("death");
	for(;;)
	{
		self.owner waittill("UnCloak");
		playfxontag(level.chopper_fx["light"]["warbird"],self,"tag_light_body_L");
		wait(0.05);
		playfxontag(level.chopper_fx["light"]["warbird"],self,"tag_light_body_R");
		wait(0.05);
		playfxontag(level.chopper_fx["light"]["warbird"],self,"tag_light_tail");
		self.owner waittill("ActivateCloak");
		stopfxontag(level.chopper_fx["light"]["warbird"],self,"tag_light_body_L");
		wait(0.05);
		stopfxontag(level.chopper_fx["light"]["warbird"],self,"tag_light_body_R");
		wait(0.05);
		stopfxontag(level.chopper_fx["light"]["warbird"],self,"tag_light_tail");
	}
}