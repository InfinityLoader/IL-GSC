/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_orbital_carepackage.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 584 ms
 * Timestamp: 10/27/2023 1:52:03 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._orbital_care_pod = [];
	level.orbitaldropmarkers = [];
	level._effect["ocp_death"] = loadfx("vfx/explosion/exo_droppod_explosion");
	level._effect["ocp_midair"] = loadfx("vfx/explosion/exo_droppod_split");
	level._effect["ocp_ground_marker"] = loadfx("vfx/unique/vfx_marker_killstreak_guide_carepackage");
	level._effect["ocp_ground_marker_bad"] = loadfx("vfx/unique/vfx_marker_killstreak_guide_carepackage_fizzle");
	level._effect["ocp_exhaust"] = loadfx("vfx/vehicle/vehicle_ocp_exhaust");
	level._effect["ocp_thruster_small"] = loadfx("vfx/vehicle/vehicle_ocp_thrusters_small");
	level._effect["vfx_ocp_steam"] = loadfx("vfx/steam/vfx_ocp_steam");
	level._effect["vfx_ocp_steam2"] = loadfx("vfx/steam/vfx_ocp_steam2");
	level._effect["ocp_glow"] = loadfx("vfx/unique/orbital_carepackage_glow");
	level.killstreakfuncs["orbital_carepackage"] = ::tryusedefaultorbitalcarepackage;
	level.killstreakwieldweapons["orbital_carepackage_pod_mp"] = "orbital_carepackage";
	level.killstreakfuncs["orbital_carepackage_juggernaut_exosuit"] = ::tryuseorbitaljuggernautexosuit;
	precachempanim("orbital_care_package_open");
	precachempanim("orbital_care_package_fan_spin");
	level.ocp_weap_name = "orbital_carepackage_pod_mp";
	if(!isdefined(level.missileitemclipdelay))
	{
		level.missileitemclipdelay = 3;
	}
}

//Function Number: 2
tryusedefaultorbitalcarepackage(param_00,param_01)
{
	return tryuseorbitalcarepackage(param_00,"orbital_carepackage",param_01);
}

//Function Number: 3
tryuseorbitaljuggernautexosuit(param_00,param_01)
{
	return tryuseorbitalcarepackage(param_00,"orbital_carepackage_juggernaut_exosuit",param_01);
}

//Function Number: 4
tryuseorbitalcarepackage(param_00,param_01,param_02)
{
	if((common_scripts\utility::array_contains(param_02,"orbital_carepackage_drone") && maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed()) || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		return 0;
	}

	var_03 = playerlaunchcarepackage(param_01,param_02);
	if(!isdefined(var_03) || !var_03)
	{
		return 0;
	}

	if(param_01 == "orbital_carepackage")
	{
		maps\mp\gametypes\_missions::processchallenge("ch_streak_orbitalcare",1);
	}

	return 1;
}

//Function Number: 5
playerlaunchcarepackage(param_00,param_01)
{
	var_02 = maps\mp\killstreaks\_orbital_util::playergetoutsidenode("carepackage");
	var_03 = undefined;
	if(isdefined(var_02))
	{
		var_03 = var_02.origin;
	}
	else if(isdefined(level.ishorde) && level.ishorde)
	{
		var_02 = [[ level.hordegetoutsideposition ]]();
		var_03 = var_02.origin;
	}
	else
	{
		thread maps\mp\killstreaks\_orbital_util::playerplayinvalidpositioneffect(common_scripts\utility::getfx("ocp_ground_marker_bad"));
		self setclientomnvar("ui_invalid_orbital_care_package",1);
		return 0;
	}

	var_04 = undefined;
	if(common_scripts\utility::array_contains(param_01,"orbital_carepackage_drone"))
	{
		var_04 = spawnhelicopter(self,var_03 + (0,0,200),(0,0,0),"orbital_carepackage_drone_mp","orbital_carepackage_pod_01_vehicle");
		if(!isdefined(var_04))
		{
			return 0;
		}

		var_04 hide();
	}

	var_05 = firepod(level.ocp_weap_name,self,var_02,param_00,param_01,var_04,undefined,undefined,1);
	return isdefined(var_05);
}

//Function Number: 6
firepod(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_06))
	{
		param_06 = param_01 maps\mp\killstreaks\_orbital_util::playergetorbitalstartpos(param_02,"carepackage");
	}

	var_09 = param_02.origin;
	if(!isdefined(param_07))
	{
		param_07 = [];
	}

	var_0A = magicbullet(param_00,param_06,var_09,param_01,0,1);
	if(!isdefined(var_0A))
	{
		return;
	}

	var_0A thread setmissilespecialclipmaskdelayed(level.missileitemclipdelay);
	if(!isdefined(level.iszombiegame) || !level.iszombiegame)
	{
		var_0A thread trajectory_kill(param_01);
	}

	var_0B = param_01 createplayerdroppod(var_0A);
	var_0B.streakname = param_03;
	var_0B.modules = param_04;
	var_0B.droppoint = param_02.origin;
	var_0B.drone = param_05;
	var_0B.givebackcarepackage = param_08;
	var_0A.team = param_01.team;
	var_0A.owner = param_01;
	var_0A.type = "remote";
	return monitordrop(param_01,var_0A,var_0B,param_03,param_07,param_00);
}

//Function Number: 7
trajectory_kill(param_00)
{
	self endon("death");
	var_01 = self.origin;
	while(isdefined(self))
	{
		if(!level.teambased)
		{
			capsule_damage(10000,self.origin,var_01,30,undefined,param_00);
		}
		else
		{
			capsule_damage(10000,self.origin,var_01,30,level.otherteam[param_00.team],param_00);
		}

		var_01 = self.origin;
		wait(0.05);
	}
}

//Function Number: 8
capsule_damage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_02 - param_01;
	var_07 = vectornormalize(var_06);
	var_08 = length(var_06);
	var_09 = param_03 * param_03;
	foreach(var_0B in level.characters)
	{
		if(!isalive(var_0B))
		{
			continue;
		}

		if(var_0B != param_05 && isdefined(param_04) && isdefined(var_0B.team) && var_0B.team != param_04)
		{
			continue;
		}

		var_0C = var_0B.origin - param_01;
		var_0D = vectordot(var_0C,var_07);
		if(var_0D > param_03 * -1 && var_0D < var_08 + param_03)
		{
			var_0E = param_01 + var_07 * var_0D;
			var_0F = distancesquared(var_0E,var_0B.origin);
			if(var_0F <= var_09)
			{
				var_0B dodamage(param_00,var_0E,param_05,self,"MOD_EXPLOSIVE",level.ocp_weap_name);
			}
		}
	}
}

//Function Number: 9
setmissilespecialclipmaskdelayed(param_00)
{
	self endon("death");
	wait(param_00);
	self setmissilespecialclipmask(1);
}

//Function Number: 10
createplayerdroppod(param_00)
{
	var_01 = 0;
	if(!isdefined(level._orbital_care_pod))
	{
		level._orbital_care_pod = [];
	}
	else
	{
		level._orbital_care_pod = maps\mp\_utility::cleanarray(level._orbital_care_pod);
		var_01 = level._orbital_care_pod.size;
	}

	level._orbital_care_pod[var_01] = spawnstruct();
	level._orbital_care_pod[var_01].hasleftcam = 0;
	level._orbital_care_pod[var_01].podrocket = param_00;
	level._orbital_care_pod[var_01].podrocket.maxhealth = 100;
	level._orbital_care_pod[var_01].podrocket.health = 100;
	level._orbital_care_pod[var_01].podrocket.damagetaken = 0;
	level._orbital_care_pod[var_01].podrocket.ispodrocket = 1;
	level._orbital_care_pod[var_01].owner = self;
	level._orbital_care_pod[var_01].alive = 1;
	return level._orbital_care_pod[var_01];
}

//Function Number: 11
rocket_cleanupondeath()
{
	var_00 = self getentitynumber();
	level.rockets[var_00] = self;
	self waittill("death");
	if(isdefined(level.orbitaldropupgrade) && level.orbitaldropupgrade == 1)
	{
		magicgrenademanual("dna_aoe_grenade_throw_zombie_mp",self.origin + (0,0,64),(0,0,0),3,level.player,1);
	}

	level.rockets[var_00] = undefined;
	if(isdefined(self.killcament))
	{
		self.killcament unlink();
		self.killcament.origin = self.killcament.origin + (0,0,300);
	}
}

//Function Number: 12
getdroptypefromstreakname(param_00)
{
	switch(param_00)
	{
		case "orbital_carepackage_juggernaut_exosuit":
			break;

		case "airdrop_reinforcement_common":
			break;

		case "airdrop_reinforcement_uncommon":
			break;

		case "airdrop_reinforcement_rare":
			break;

		case "airdrop_reinforcement_practice":
			break;

		case "horde_support_drop":
			break;

		default:
			break;
	}
}

//Function Number: 13
allowdronedelivery(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(level.teambased && level.teamemped[param_00.team])
	{
		return 0;
	}

	if(!level.teambased && isdefined(level.empplayer) && level.empplayer != param_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
monitordrop(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getdroptypefromstreakname(param_03);
	if(var_06 == "airdrop_assault" && common_scripts\utility::array_contains(param_02.modules,"orbital_carepackage_odds"))
	{
		var_06 = "airdrop_assault_odds";
	}

	if(isdefined(level.getcratefordroptype))
	{
		var_07 = [[ level.getcratefordroptype ]](var_06);
	}
	else
	{
		var_07 = maps\mp\killstreaks\_airdrop::getcratetypefordroptype(var_07);
	}

	thread monitordropinternal(param_00,param_01,param_02,var_06,var_07,param_05);
	return var_07;
}

//Function Number: 15
monitordropinternal(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("game_ended");
	param_01 thread rocket_cleanupondeath();
	var_06 = common_scripts\utility::array_contains(param_02.modules,"orbital_carepackage_trap");
	var_07 = param_00 maps\mp\killstreaks\_airdrop::createairdropcrate(param_00,param_03,param_04,param_01.origin,undefined,var_06,0);
	var_07.moduletrap = common_scripts\utility::array_contains(param_02.modules,"orbital_carepackage_trap");
	var_07.modulehide = common_scripts\utility::array_contains(param_02.modules,"orbital_carepackage_hide");
	var_07.moduleroll = common_scripts\utility::array_contains(param_02.modules,"orbital_carepackage_roll");
	var_07.modulepickup = common_scripts\utility::array_contains(param_02.modules,"orbital_carepackage_fast_pickup");
	var_07.angles = (0,0,0);
	var_07.en_route_in_air = 1;
	param_01.killcament = var_07.killcament;
	if(param_05 == "orbital_carepackage_pod_plane_mp")
	{
		param_01.killcament.killcamstarttime = gettime();
	}

	var_08 = common_scripts\utility::array_contains(param_02.modules,"orbital_carepackage_drone");
	var_09 = spawn("script_model",param_02.droppoint + (0,0,5));
	var_09.angles = (-90,0,0);
	var_09 setmodel("tag_origin");
	var_09 hide();
	var_09 showtoplayer(param_00);
	playfxontag(common_scripts\utility::getfx("ocp_ground_marker"),var_09,"tag_origin");
	var_09 thread carepackagesetupminimap(param_02.modules,param_00);
	maps\mp\killstreaks\_orbital_util::adddropmarker(var_09);
	if(var_08)
	{
		param_00 thread playermonitorfordronedelivery(param_01,param_02,var_09,var_07);
	}

	var_07 linkto(param_01,"tag_origin",(0,0,0),(-90,0,0));
	param_01 waittill("death",var_0A,var_0B,var_0C);
	if(isdefined(param_01) && !var_08 && param_01.origin[2] > param_02.droppoint[2] && distancesquared(param_01.origin,param_02.droppoint) > 22500)
	{
		if(param_02.givebackcarepackage)
		{
			if(isdefined(level.ishorde) && level.ishorde)
			{
				var_0D = [[ level.hordegetoutsideposition ]]();
				firepod(level.ocp_weap_name,self,var_0D,"horde_support_drop",param_02.modules,0,undefined,undefined,1);
			}
			else if(isdefined(param_00))
			{
				param_00 playergivebackcarepackage(param_02);
			}
		}

		level thread cleanupcarepackage(param_02,var_07,var_09);
		return;
	}

	if(var_08 && allowdronedelivery(param_00) && isdefined(param_02.drone))
	{
		param_02.drone show();
	}
	else
	{
		earthquake(0.4,1,param_02.droppoint,800);
		playrumbleonposition("artillery_rumble",param_02.droppoint);
	}

	killfxontag(common_scripts\utility::getfx("ocp_ground_marker"),var_09,"tag_origin");
	param_02.alive = 0;
	if(var_08 && allowdronedelivery(param_00) && isdefined(param_02.drone))
	{
		param_02.drone waittill("delivered");
		var_07 setcontents(var_07.oldcontents);
		var_07.oldcontents = undefined;
	}

	var_09 thread carepackagecleanup(var_07);
	var_07 clonebrushmodeltoscriptmodel(level.airdropcratecollision);
	var_07.droppingtoground = 1;
	var_07 unlink();
	var_07 physicslaunchserver((0,0,0));
	var_07 thread cratedetectstopphysics();
	var_07 thread orbitalphysicswaiter(param_03,param_04,param_00);
	level thread removepod(var_07,param_02);
	var_07.en_route_in_air = 0;
}

//Function Number: 16
crateimpactcleanup(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = getnodesinradiussorted(self.origin,300,0,300);
	foreach(var_03 in level.characters)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(isalliedsentient(var_03,param_00))
		{
			if(var_03 istouching(self))
			{
				foreach(var_05 in var_01)
				{
					if(distancesquared(var_05.origin,self.origin) > 10000)
					{
						var_03 setorigin(var_05.origin,1);
						var_01 = common_scripts\utility::array_remove(var_01,var_05);
						break;
					}
				}
			}
		}
	}
}

//Function Number: 17
cratedetectstopphysics()
{
	self endon("physics_finished");
	self endon("death");
	var_00 = 4;
	var_01 = var_00 / 0.05;
	var_02 = 25;
	var_03 = 0;
	var_04 = self.origin;
	for(;;)
	{
		wait 0.05;
		var_05 = distancesquared(var_04,self.origin);
		if(var_05 < var_02)
		{
			var_03++;
		}
		else
		{
			var_03 = 0;
		}

		var_04 = self.origin;
		if(var_03 >= var_01)
		{
			self physicsstop();
			return;
		}
	}
}

//Function Number: 18
playergivebackcarepackage(param_00)
{
	var_01 = maps\mp\killstreaks\_killstreaks::getstreakcost("orbital_carepackage");
	var_02 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex("orbital_carepackage",0);
	thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("orbital_carepackage",var_01,undefined,param_00.modules,var_02);
	thread maps\mp\killstreaks\_killstreaks::givekillstreak("orbital_carepackage",0,0,self,param_00.modules);
}

//Function Number: 19
cleanupcarepackage(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		thread removepod(param_01,param_00);
		param_01 delete();
	}

	if(isdefined(param_00.drone))
	{
		param_00.drone maps\mp\killstreaks\_drone_carepackage::carepackagedrone_remove();
	}

	if(isdefined(param_02))
	{
		if(isdefined(param_02.objidfriendly))
		{
			maps\mp\_utility::_objective_delete(param_02.objidfriendly);
		}

		if(isdefined(param_02.objidenemy))
		{
			maps\mp\_utility::_objective_delete(param_02.objidenemy);
		}

		killfxontag(common_scripts\utility::getfx("ocp_ground_marker"),param_02,"tag_origin");
		wait 0.05;
		param_02 delete();
	}
}

//Function Number: 20
orbitalphysicswaiter(param_00,param_01,param_02)
{
	self endon("death");
	maps\mp\killstreaks\_airdrop::physicswaiter(param_00,param_01);
	self playsound("orbital_pkg_panel");
	if(isdefined(self.enemymodel))
	{
		self.enemymodel thread orbitalanimate();
		self.enemymodel solid();
	}

	if(isdefined(self.friendlymodel))
	{
		self.friendlymodel thread orbitalanimate();
		self.friendlymodel solid();
	}

	thread crateimpactcleanup(param_02);
}

//Function Number: 21
orbitalanimate(param_00)
{
	self endon("death");
	if(!isdefined(param_00) || !param_00)
	{
		wait(0.75);
	}

	if(isdefined(param_00) && param_00)
	{
		self scriptmodelplayanim("orbital_care_package_open_loop");
	}
	else
	{
		self scriptmodelplayanim("orbital_care_package_open");
	}

	playfxontag(common_scripts\utility::getfx("ocp_glow"),self,"TAG_ORIGIN");
	if(!isdefined(param_00) || !param_00)
	{
		wait 0.05;
		playfxontag(common_scripts\utility::getfx("vfx_ocp_steam2"),self,"TAG_FX_PANEL_F");
		playfxontag(common_scripts\utility::getfx("vfx_ocp_steam2"),self,"TAG_FX_PANEL_K");
		wait 0.05;
		playfxontag(common_scripts\utility::getfx("vfx_ocp_steam"),self,"TAG_FX_PANEL_FR");
		playfxontag(common_scripts\utility::getfx("vfx_ocp_steam"),self,"TAG_FX_PANEL_KL");
		wait 0.05;
		playfxontag(common_scripts\utility::getfx("vfx_ocp_steam"),self,"TAG_FX_PANEL_FL");
		playfxontag(common_scripts\utility::getfx("vfx_ocp_steam"),self,"TAG_FX_PANEL_KR");
	}
}

//Function Number: 22
delaycleanupdroppod(param_00)
{
	wait(5);
	param_00 delete();
}

//Function Number: 23
removepod(param_00,param_01)
{
	param_00 waittill("death");
	wait(15);
	for(var_02 = 0;var_02 < level._orbital_care_pod.size;var_02++)
	{
		if(isdefined(level._orbital_care_pod[var_02]) && level._orbital_care_pod[var_02] == param_01)
		{
			if(level._orbital_care_pod[var_02].alive == 0)
			{
				level._orbital_care_pod[var_02] = undefined;
			}
		}
	}

	if(isdefined(param_01))
	{
		param_01 = undefined;
	}
}

//Function Number: 24
carepackagesetupminimap(param_00,param_01)
{
	self endon("death");
	if(common_scripts\utility::array_contains(param_00,"orbital_carepackage_hide"))
	{
		return;
	}

	var_02 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_02,"invisible",(0,0,0));
	objective_position(var_02,self.origin);
	objective_state(var_02,"active");
	var_03 = "compass_objpoint_ammo_friendly";
	objective_icon(var_02,var_03);
	if(!level.teambased)
	{
		objective_playerteam(var_02,param_01 getentitynumber());
	}
	else
	{
		objective_team(var_02,param_01.team);
	}

	self.objidfriendly = var_02;
	if(!isdefined(level.ishorde) && level.ishorde)
	{
		var_02 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_02,"invisible",(0,0,0));
		objective_position(var_02,self.origin);
		objective_state(var_02,"active");
		objective_icon(var_02,"compass_objpoint_ammo_enemy");
		if(!level.teambased)
		{
			objective_playerenemyteam(var_02,param_01 getentitynumber());
		}
		else
		{
			objective_team(var_02,level.otherteam[param_01.team]);
		}

		self.objidenemy = var_02;
	}

	if(common_scripts\utility::array_contains(param_00,"orbital_carepackage_drone"))
	{
		self waittill("linkedToDrone");
		objective_onentity(self.objidfriendly,self);
		if(isdefined(self.objidenemy))
		{
			objective_onentity(self.objidenemy,self);
			self show();
		}
	}
}

//Function Number: 25
carepackagecleanup(param_00)
{
	param_00 common_scripts\utility::waittill_any("physics_finished","death");
	if(isdefined(self.objidfriendly))
	{
		maps\mp\_utility::_objective_delete(self.objidfriendly);
	}

	if(isdefined(self.objidenemy))
	{
		maps\mp\_utility::_objective_delete(self.objidenemy);
	}

	killfxontag(common_scripts\utility::getfx("ocp_glow"),self,"TAG_ORIGIN");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_00 notify("drop_pod_cleared");
	}

	wait 0.05;
	self delete();
}

//Function Number: 26
setupdamagecallback(param_00)
{
	param_00.health = 500;
	param_00.maxhealth = param_00.health;
	param_00.readytodie = 0;
	setupdamagecallbackinternal(param_00.friendlymodel);
	setupdamagecallbackinternal(param_00.enemymodel);
}

//Function Number: 27
setupdamagecallbackinternal(param_00)
{
	param_00 thread maps\mp\gametypes\_damage::setentitydamagecallback(9999,undefined,undefined,::cratehandledamagecallback,1);
}

//Function Number: 28
disabledamagecallback(param_00)
{
	disabledamagecallbackinternal(param_00.friendlymodel);
	disabledamagecallbackinternal(param_00.enemymodel);
}

//Function Number: 29
disabledamagecallbackinternal(param_00)
{
	param_00.damagecallback = undefined;
	param_00 setcandamage(0);
	param_00 setdamagecallbackon(0);
}

//Function Number: 30
cratehandledamagecallback(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	if(isdefined(self.parentcrate))
	{
		var_04 = self.parentcrate;
	}

	var_05 = maps\mp\gametypes\_damage::modifydamage(param_00,param_01,param_02,param_03);
	var_04.health = var_04.health - var_05;
	if(var_04.health <= 0)
	{
		disabledamagecallback(var_04);
		var_04 notify("disabled");
	}

	return 0;
}

//Function Number: 31
playermonitorfordronedelivery(param_00,param_01,param_02,param_03)
{
	self endon("disconenct");
	self endon("joined_team");
	self endon("joined_spectators");
	var_04 = 576;
	var_05 = 250000;
	var_06 = param_01.droppoint;
	var_07 = param_00.origin;
	var_08 = distancesquared(var_07,var_06);
	setupdamagecallback(param_03);
	var_09 = param_01.drone;
	var_09 thread carepackagedronewatchcratedeath(param_03);
	param_03.oldcontents = param_03 setcontents(0);
	param_03.friendlymodel solid();
	param_03.enemymodel solid();
	for(;;)
	{
		if(!isdefined(param_00))
		{
			break;
		}

		var_07 = param_00.origin;
		var_08 = distancesquared(var_07,var_06);
		if(var_08 <= var_05)
		{
			break;
		}

		wait 0.05;
	}

	if(var_08 > var_05)
	{
		if(param_01.givebackcarepackage && allowdronedelivery(self))
		{
			playergivebackcarepackage(param_01);
		}

		level thread cleanupcarepackage(param_01,param_03,param_02);
		return;
	}

	if(!isdefined(self))
	{
		level thread cleanupcarepackage(param_01,param_03,param_02);
		return;
	}

	if(!allowdronedelivery(self))
	{
		level thread cleanupcarepackage(param_03,undefined,undefined);
		return;
	}

	var_09 thread carepackagedronewatchdeath();
	var_09 endon("death");
	var_09 vehicle_teleport(param_03.origin,param_03.angles,0,0);
	param_03 linkto(var_09,"tag_origin",(0,0,0),(0,0,0));
	param_03.friendlymodel scriptmodelplayanim("orbital_care_package_fan_spin","nothing");
	param_03.enemymodel scriptmodelplayanim("orbital_care_package_fan_spin","nothing");
	maps\mp\killstreaks\_drone_carepackage::setupcarepackagedrone(var_09,1);
	var_09.crate = param_03;
	if(isdefined(param_00))
	{
		var_07 = param_00.origin;
		param_00 notify("death");
		param_00 delete();
	}

	playsoundatpos(var_07,"orbital_pkg_pod_midair_exp");
	playfx(common_scripts\utility::getfx("ocp_midair"),var_07,getdvarvector("scr_ocp_forward",(0,0,-1)));
	var_09 thread drone_thrusterfx();
	var_0A = param_01.droppoint + (0,0,35);
	var_09 setvehgoalpos(var_0A,1);
	var_09 vehicle_setspeedimmediate(getdvarfloat("scr_ocp_dropspeed",30),getdvarfloat("scr_ocp_dropa",20),getdvarfloat("scr_ocp_dropd",1));
	var_09 sethoverparams(30,5,5);
	var_09 setmaxpitchroll(15,15);
	while(distancesquared(var_09.origin,var_0A) > var_04 && param_03.health > 0)
	{
		wait 0.05;
	}

	if(param_03.health > 0)
	{
		wait(1);
	}

	if(param_03.health > 0)
	{
		param_02 linkto(var_09,"tag_origin");
		param_02 notify("linkedToDrone");
		var_09 thread maps\mp\killstreaks\_drone_carepackage::carepackagedrone_deleteonactivate();
		var_09 carepackagedronefindowner();
	}

	disabledamagecallback(param_03);
	param_03 playsoundonmovingent("orbital_pkg_drone_jets_off");
	if(isdefined(var_09))
	{
		var_09 drone_stopthrustereffects();
	}

	param_03.friendlymodel scriptmodelclearanim("orbital_care_package_fan_spin","nothing");
	param_03.enemymodel scriptmodelclearanim("orbital_care_package_fan_spin","nothing");
	wait 0.05;
	if(isdefined(var_09))
	{
		var_09 maps\mp\killstreaks\_drone_carepackage::carepackagedrone_delete();
	}
}

//Function Number: 32
carepackagedronewatchdeath()
{
	self endon("delivered");
	self waittill("death");
	self notify("delivered");
}

//Function Number: 33
carepackagedronewatchcratedeath(param_00)
{
	self endon("delivered");
	param_00 waittill("disabled");
	self notify("delivered");
}

//Function Number: 34
carepackagedronefindowner()
{
	var_00 = self.owner;
	var_00 endon("disconnect");
	self endon("death");
	self endon("delivered");
	var_01 = 22500;
	var_02 = 1;
	var_03 = gettime();
	for(;;)
	{
		var_04 = maps\mp\_utility::isreallyalive(var_00);
		if(!var_04)
		{
			var_02 = 1;
			wait 0.05;
		}

		if(var_03 < gettime() || var_02)
		{
			var_02 = 0;
			self setdronegoalpos(var_00,(0,-100,15));
			var_03 = gettime() + 1000;
		}

		var_05 = distancesquared(self.origin,var_00.origin + (0,0,15));
		if(var_05 < var_01)
		{
			wait(getdvarfloat("scr_ocp_waitDeliver",1));
			self notify("delivered");
			return;
		}

		wait 0.05;
	}
}

//Function Number: 35
drone_thrusterfx()
{
	self endon("death");
	playfxontag(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_fl");
	playfxontag(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_fr");
	playfxontag(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_kl");
	playfxontag(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_kr");
	wait 0.05;
	wait 0.05;
	if(isdefined(self))
	{
		playfxontag(common_scripts\utility::getfx("ocp_exhaust"),self,"tag_fx");
	}

	for(;;)
	{
		level waittill("connected",var_00);
		thread drone_thrusterplayerconnected(var_00);
	}
}

//Function Number: 36
drone_thrusterplayerconnected(param_00)
{
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	if(isdefined(param_00) && isdefined(self))
	{
		drone_thrusterplayer(param_00);
	}
}

//Function Number: 37
drone_thrusterplayer(param_00)
{
	param_00 endon("disconnect");
	self endon("death");
	playfxontagforclients(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_fl",param_00);
	playfxontagforclients(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_fr",param_00);
	playfxontagforclients(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_kl",param_00);
	playfxontagforclients(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_kr",param_00);
	wait 0.05;
	wait 0.05;
	if(isdefined(self))
	{
		playfxontagforclients(common_scripts\utility::getfx("ocp_exhaust"),self,"tag_fx",param_00);
	}
}

//Function Number: 38
drone_stopthrustereffects()
{
	killfxontag(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_fl");
	killfxontag(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_fr");
	killfxontag(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_kl");
	killfxontag(common_scripts\utility::getfx("ocp_thruster_small"),self,"j_thruster_kr");
	wait 0.05;
	wait 0.05;
	if(isdefined(self))
	{
		killfxontag(common_scripts\utility::getfx("ocp_exhaust"),self,"tag_fx");
	}
}