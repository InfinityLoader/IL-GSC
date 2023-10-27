/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_remoteturret.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 95
 * Decompile Time: 1644 ms
 * Timestamp: 10/27/2023 1:52:21 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.turrettype))
	{
		level.turrettype = [];
	}

	level.turrettype["mg_turret"] = "remote_mg_turret";
	level.killstreakfuncs["remote_mg_turret"] = ::tryuseremotemgturret;
	level.killstreakfuncs["remote_mg_sentry_turret"] = ::tryuseremotemgsentryturret;
	level.killstreakwieldweapons["remote_energy_turret_mp"] = "remote_mg_sentry_turret";
	level.killstreakwieldweapons["sentry_minigun_mp"] = "remote_mg_sentry_turret";
	level.killstreakwieldweapons["killstreakmahem_mp"] = "remote_mg_sentry_turret";
	if(!isdefined(level.turretsettings))
	{
		level.turretsettings = [];
	}

	level.turretsettings["mg_turret"] = spawnstruct();
	level.turretsettings["mg_turret"].sentrymodeon = "sentry";
	level.turretsettings["mg_turret"].sentrymodeoff = "sentry_offline";
	level.turretsettings["mg_turret"].timeout = 60;
	level.turretsettings["mg_turret"].maxhealth = 1000;
	level.turretsettings["mg_turret"].streakname = "remote_mg_turret";
	level.turretsettings["mg_turret"].teamsplash = "used_remote_mg_turret";
	level.turretsettings["mg_turret"].hintenter = &"MP_ENTER_REMOTE_TURRET";
	level.turretsettings["mg_turret"].hintpickup = &"MP_HOLD_TO_CARRY";
	level.turretsettings["mg_turret"].hintripoff = &"MP_TURRET_RIP_OFF";
	level.turretsettings["mg_turret"].hintdropturret = &"MP_TURRET_DROP";
	level.turretsettings["mg_turret"].placestring = &"MP_TURRET_PLACE";
	level.turretsettings["mg_turret"].cannotplacestring = &"MP_TURRET_CANNOT_PLACE";
	level.turretsettings["mg_turret"].laptopinfo = "killstreak_remote_turret_mp";
	level._effect["sentry_explode_mp"] = loadfx("vfx/explosion/remote_sentry_death");
	level._effect["sentry_smoke_mp"] = loadfx("vfx/smoke/vehicle_sentrygun_damaged_smoke");
	level._effect["sentry_overheat_mp"] = loadfx("vfx/distortion/sentrygun_overheat");
	level._effect["antenna_light_mp"] = loadfx("vfx/lights/light_detonator_blink");
	level._effect["sentry_stunned_mp"] = loadfx("vfx/sparks/emp_drone_damage");
	level._effect["sentry_laser_flash"] = loadfx("vfx/fire/remote_sentry_laser_flash");
	level._effect["sentry_gone"] = loadfx("vfx/explosion/remote_sentry_death_smoke");
	level._effect["sentry_rocket_muzzleflash_wv"] = loadfx("vfx/muzzleflash/rpg_flash_wv");
	level._effect["sentry_rocket_muzzleflash_view"] = loadfx("vfx/muzzleflash/rpg_flash_view");
	game["dialog"]["ks_sentrygun_destroyed"] = "ks_sentrygun_destroyed";
}

//Function Number: 2
tryuseremotemgsentryturret(param_00,param_01)
{
	var_02 = tryuseremoteturret(param_00,"mg_turret",1,param_01);
	if(var_02)
	{
		maps\mp\_matchdata::logkillstreakevent(level.turretsettings["mg_turret"].streakname,self.origin);
	}

	self.iscarrying = 0;
	return var_02;
}

//Function Number: 3
tryuseremotemgturret(param_00,param_01)
{
	var_02 = tryuseremoteturret(param_00,"mg_turret",0,param_01);
	if(var_02)
	{
		maps\mp\_matchdata::logkillstreakevent(level.turretsettings["mg_turret"].streakname,self.origin);
	}

	self.iscarrying = 0;
	return var_02;
}

//Function Number: 4
takekillstreakweapons(param_00)
{
	maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe(level.turretsettings[param_00].laptopinfo);
}

//Function Number: 5
tryuseremoteturret(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.turret))
	{
		self iprintlnbold(&"KILLSTREAKS_SENTRY_IN_USE");
		return 0;
	}

	var_04 = createturretforplayer(param_01,self,param_02,param_03);
	if(isdefined(level.ishorde) && level.ishorde && self.killstreakindexweapon == 1)
	{
		self.hordeclassturret = var_04;
	}

	playeraddnotifycommands();
	removeperks();
	self.carriedturret = var_04;
	setcarryingturret(var_04,1);
	self.carriedturret = undefined;
	thread restoreperks();
	if(isdefined(var_04))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
setupheavyresistancemodel()
{
	if(self.heavyresistance)
	{
		self hidepart("TAG_OPTIC_STANDARD");
		return;
	}

	self hidepart("TAG_OPTIC_RESISTANCE");
}

//Function Number: 7
setuprippablemodel()
{
	if(!self.rippable)
	{
		self hidepart("TAG_HANDLES");
	}
}

//Function Number: 8
setmodelturretbaseonly()
{
	if(isdefined(self.model) && self.model != "")
	{
		self showallparts();
	}

	if(self.energyturret)
	{
		self setmodel("npc_sentry_energy_turret_empty_base");
	}
	else if(self.rocketturret)
	{
		self setmodel("npc_sentry_rocket_turret_empty_base");
	}
	else if(self.disruptorturret)
	{
		self setmodel("npc_sentry_disruptor_turret_empty_base");
	}
	else
	{
		self setmodel("npc_sentry_minigun_turret_empty_base");
	}

	setupheavyresistancemodel();
	setuprippablemodel();
}

//Function Number: 9
setmodelremoteturret()
{
	if(isdefined(self.model) && self.model != "")
	{
		self showallparts();
	}

	if(self.energyturret)
	{
		self setmodel("npc_sentry_energy_turret_base");
	}
	else if(self.rocketturret)
	{
		self setmodel("npc_sentry_rocket_turret_base");
	}
	else if(self.disruptorturret)
	{
		self setmodel("npc_sentry_disruptor_turret_base");
	}
	else
	{
		self setmodel("npc_sentry_minigun_turret_base");
	}

	setupheavyresistancemodel();
	setuprippablemodel();
}

//Function Number: 10
setmodelturretplacementgood()
{
	if(isdefined(self.model) && self.model != "")
	{
		self showallparts();
	}

	if(self.energyturret)
	{
		self setmodel("npc_sentry_energy_turret_base_yellow_obj");
	}
	else if(self.rocketturret)
	{
		self setmodel("npc_sentry_rocket_turret_base_yellow_obj");
	}
	else if(self.disruptorturret)
	{
		self setmodel("npc_sentry_disruptor_turret_base_yellow_obj");
	}
	else
	{
		self setmodel("npc_sentry_minigun_turret_base_yellow_obj");
	}

	setupheavyresistancemodel();
	setuprippablemodel();
}

//Function Number: 11
setmodelturretplacementfailed()
{
	if(isdefined(self.model) && self.model != "")
	{
		self showallparts();
	}

	if(self.energyturret)
	{
		self setmodel("npc_sentry_energy_turret_base_red_obj");
	}
	else if(self.rocketturret)
	{
		self setmodel("npc_sentry_rocket_turret_base_red_obj");
	}
	else if(self.disruptorturret)
	{
		self setmodel("npc_sentry_disruptor_turret_base_red_obj");
	}
	else
	{
		self setmodel("npc_sentry_minigun_turret_base_red_obj");
	}

	setupheavyresistancemodel();
	setuprippablemodel();
}

//Function Number: 12
setcarryingturret(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!maps\mp\_utility::isreallyalive(self))
	{
		param_00 delete();
		return;
	}

	param_00 turret_setcarried(self);
	var_02 = maps\mp\_utility::getkillstreakweapon("remote_mg_sentry_turret");
	var_03 = self getcurrentprimaryweapon();
	if(!maps\mp\gametypes\_weapons::isvalidlastweapon(var_03) || var_03 == "iw5_underwater_mp")
	{
		var_03 = common_scripts\utility::getlastweapon();
	}

	if(!param_01)
	{
		maps\mp\_utility::_giveweapon(var_02,0);
		self switchtoweapon(var_02);
		self.water_last_weapon = var_02;
		common_scripts\utility::_disableweaponswitch();
	}

	for(;;)
	{
		var_04 = common_scripts\utility::waittill_any_return("place_turret","cancel_turret","force_cancel_placement");
		if(var_04 == "cancel_turret" || var_04 == "force_cancel_placement")
		{
			if(var_04 == "cancel_turret" && !param_01)
			{
				continue;
			}

			param_00 turret_setcancelled();
			if(!param_01)
			{
				if(!isdefined(self.underwater))
				{
					playerswitchawayfromholdingturret(var_03,var_02);
				}
				else
				{
					self.water_last_weapon = var_03;
				}

				common_scripts\utility::_enableweaponswitch();
			}

			return 0;
		}

		if(isdefined(param_00))
		{
			if(!param_00.canbeplaced)
			{
				continue;
			}

			param_00 turret_setplaced();
		}

		if(!param_01)
		{
			if(!isdefined(self.underwater))
			{
				playerswitchawayfromholdingturret(var_03,var_02);
			}
			else
			{
				self.water_last_weapon = var_03;
			}

			common_scripts\utility::_enableweaponswitch();
		}

		return 1;
	}
}

//Function Number: 13
playerswitchawayfromholdingturret(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	maps\mp\_utility::switch_to_last_weapon(param_00);
	while(self getcurrentprimaryweapon() != param_00)
	{
		wait 0.05;
	}

	self.water_last_weapon = param_00;
	maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe(param_01);
}

//Function Number: 14
setripoffturrethead(param_00)
{
	self endon("death");
	self endon("disconnect");
	param_00 setcandamage(0);
	param_00 setcontents(0);
	param_00 freeentitysentient();
	param_00.carriedby = self;
	self.iscarrying = 0;
	param_00 turret_setinactive();
	param_00 setmodelturretbaseonly();
	param_00 notify("carried");
	param_00 notify("ripped");
	param_00 setturretminimapvisible(0);
	param_00 thread deleteaftertime(20);
	if(isdefined(param_00.remoteent))
	{
		param_00.remoteent maps\mp\_utility::makegloballyunusablebytype();
	}

	if(param_00.energyturret)
	{
		thread maps\mp\killstreaks\_rippedturret::playergiveturrethead("turretheadenergy_mp");
	}
	else if(param_00.rocketturret)
	{
		thread maps\mp\killstreaks\_rippedturret::playergiveturrethead("turretheadrocket_mp");
	}
	else if(param_00.disruptorturret)
	{
		thread maps\mp\killstreaks\_rippedturret::playergiveturrethead("turretheaddisruptor_mp");
	}
	else
	{
		thread maps\mp\killstreaks\_rippedturret::playergiveturrethead("turretheadmg_mp");
	}

	param_00 playsound("sentry_gun_detach");
}

//Function Number: 15
deleteaftertime(param_00)
{
	self endon("death");
	level maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	if(isdefined(self))
	{
		deathsoundsandfx();
		self delete();
	}
}

//Function Number: 16
deathsoundsandfx()
{
	var_00 = self gettagorigin("TAG_AIM_PIVOT");
	playfx(common_scripts\utility::getfx("sentry_gone"),var_00);
	playsoundatpos(var_00,"sentry_gun_self_destruct");
}

//Function Number: 17
removeperks()
{
	if(maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	}
}

//Function Number: 18
restoreperks()
{
	if(isdefined(self.restoreperk))
	{
		maps\mp\_utility::giveperk(self.restoreperk,0);
		self.restoreperk = undefined;
	}
}

//Function Number: 19
waitrestoreperks()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	restoreperks();
}

//Function Number: 20
turret_quickdeath(param_00)
{
	self.quick_death = 1;
	self notify("death");
}

//Function Number: 21
turret_setplaced()
{
	setmodelremoteturret();
	thread sentry_attacktargets();
	thread sentry_disruptor();
	self setsentrycarrier(undefined);
	self setcandamage(1);
	self.carriedby forceusehintoff();
	self.carriedby = undefined;
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
		common_scripts\utility::make_entity_sentient_mp(self.owner.team);
	}

	var_00 = spawnstruct();
	var_00.linkparent = self.placementlinkentity;
	var_00.endonstring = "carried";
	var_00.deathoverridecallback = ::turret_quickdeath;
	thread maps\mp\_movers::handle_moving_platforms(var_00);
	self playsound("sentry_gun_deploy");
	thread turret_setactive();
	self notify("placed");
}

//Function Number: 22
turret_setcancelled()
{
	self.carriedby forceusehintoff();
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	self delete();
}

//Function Number: 23
turret_setcarried(param_00)
{
	setmodelturretplacementgood();
	self setcandamage(0);
	self setsentrycarrier(param_00);
	self setcontents(0);
	self freeentitysentient();
	self unlink();
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread updateturretplacement(self);
	thread turret_oncarrierdeath(param_00);
	thread turret_oncarrierdisconnect(param_00);
	thread turret_oncarrierchangedteam(param_00);
	thread turret_ongameended();
	self setdefaultdroppitch(-89);
	turret_setinactive();
	self notify("carried");
}

//Function Number: 24
updateturretplacement(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.canbeplaced = 1;
	param_00.placementlinkentity = undefined;
	var_01 = -1;
	for(;;)
	{
		var_02 = self canplayerplacesentry(1);
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		param_00.canbeplaced = self isonground() && var_02["result"] && abs(param_00.origin[2] - self.origin[2]) < 10 && !param_00 istouchingwater();
		if(isdefined(var_02["entity"]))
		{
			param_00.placementlinkentity = var_02["entity"];
		}
		else
		{
			param_00.placementlinkentity = undefined;
		}

		if(param_00.canbeplaced != var_01)
		{
			if(param_00.canbeplaced)
			{
				param_00 setmodelturretplacementgood();
				self forceusehinton(level.turretsettings[param_00.turrettype].placestring);
			}
			else
			{
				param_00 setmodelturretplacementfailed();
				self forceusehinton(level.turretsettings[param_00.turrettype].cannotplacestring);
			}
		}

		var_01 = param_00.canbeplaced;
		wait(0.05);
	}
}

//Function Number: 25
istouchingwater()
{
	if(!isdefined(level.water_triggers))
	{
		return 0;
	}
	else
	{
		foreach(var_01 in level.water_triggers)
		{
			if(self istouching(var_01))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 26
turret_oncarrierdeath(param_00)
{
	self endon("placed");
	self endon("death");
	self endon("ripped");
	param_00 waittill("death");
	if(self.canbeplaced)
	{
		turret_setplaced();
		return;
	}

	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	self delete();
}

//Function Number: 27
turret_oncarrierdisconnect(param_00)
{
	self endon("placed");
	self endon("death");
	self endon("ripped");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 28
turret_oncarrierchangedteam(param_00)
{
	self endon("placed");
	self endon("death");
	self endon("ripped");
	param_00 common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self delete();
}

//Function Number: 29
turret_ongameended(param_00)
{
	self endon("placed");
	self endon("death");
	self endon("ripped");
	level waittill("game_ended");
	self delete();
}

//Function Number: 30
createturretforplayer(param_00,param_01,param_02,param_03)
{
	var_04 = "sentry_minigun_mp";
	if(common_scripts\utility::array_contains(param_03,"sentry_energy_turret"))
	{
		var_04 = "remote_energy_turret_mp";
	}

	var_05 = spawnturret("misc_turret",param_01.origin,var_04);
	var_05.angles = param_01.angles;
	var_05.owner = param_01;
	var_05.health = level.turretsettings[param_00].maxhealth;
	var_05.maxhealth = level.turretsettings[param_00].maxhealth;
	var_05.turrettype = param_00;
	var_05.stunned = 0;
	var_05.directhacked = 0;
	var_05.modules = param_03;
	var_05.heavyresistance = common_scripts\utility::array_contains(var_05.modules,"sentry_heavy_resistance");
	var_05.antiintrusion = common_scripts\utility::array_contains(var_05.modules,"sentry_anti_intrusion");
	var_05.rocketturret = common_scripts\utility::array_contains(var_05.modules,"sentry_rocket_turret");
	var_05.energyturret = common_scripts\utility::array_contains(var_05.modules,"sentry_energy_turret");
	var_05.disruptorturret = common_scripts\utility::array_contains(var_05.modules,"sentry_disruptor");
	var_05.rippable = common_scripts\utility::array_contains(var_05.modules,"sentry_rippable");
	var_05.issentry = common_scripts\utility::array_contains(var_05.modules,"sentry_guardian");
	var_05.is360 = common_scripts\utility::array_contains(var_05.modules,"sentry_360");
	var_05.weaponinfo = var_04;
	var_05 setmodelremoteturret();
	if(var_05.rocketturret)
	{
		var_05 turretfiredisable();
		var_05.weaponinfo = "killstreakmahem_mp";
	}

	if(var_05.rocketturret || var_05.energyturret || var_05.disruptorturret)
	{
		var_05 turretsetbarrelspinenabled(0);
	}

	var_05 setturretmodechangewait(1);
	var_05 turret_setinactive();
	var_05 setsentryowner(param_01);
	var_05 setturretminimapvisible(1,param_00);
	if(var_05.disruptorturret)
	{
		var_05 setleftarc(0);
		var_05 setrightarc(0);
	}
	else if(var_05.is360)
	{
		var_05 setleftarc(180);
		var_05 setrightarc(180);
	}
	else
	{
		var_05 setleftarc(80);
		var_05 setrightarc(80);
	}

	var_05 settoparc(50);
	var_05 setbottomarc(30);
	var_05 setdefaultdroppitch(-89);
	var_05 thread turret_handleownerdisconnect();
	param_01.turret = var_05;
	var_05.damagefade = 1;
	var_05 thread turret_incrementdamagefade();
	var_05 thread sentry_attacktargets();
	return var_05;
}

//Function Number: 31
turret_setactive()
{
	self endon("death");
	self.owner endon("disconnect");
	self makeunusable();
	self maketurretsolid();
	if(!isdefined(self.owner))
	{
		return;
	}

	var_00 = self.owner;
	level.turrets[self getentitynumber()] = self;
	if(isdefined(var_00.remoteturretlist))
	{
		foreach(var_02 in var_00.remoteturretlist)
		{
			var_02 notify("death");
		}
	}

	var_00.remoteturretlist = [];
	var_00.remoteturretlist[0] = self;
	if(!self.disruptorturret)
	{
		if(!isdefined(self.remoteent))
		{
			self.remoteent = spawn("script_model",self.origin + (0,0,1));
			self.remoteent setmodel("tag_origin");
			self.remoteent.owner = var_00;
			self.remoteent maps\mp\_utility::makegloballyusablebytype("killstreakRemote",level.turretsettings[self.turrettype].hintenter,var_00);
		}
		else
		{
			self.remoteent maps\mp\_utility::enablegloballyusablebytype();
		}
	}

	var_00.using_remote_turret = 0;
	var_00.pickup_message_deleted = undefined;
	var_00.enter_message_deleted = undefined;
	var_00 thread watchownermessageondeath(self);
	if(level.teambased)
	{
		self.team = var_00.team;
		self setturretteam(var_00.team);
		maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,65),"tag_origin");
	}
	else
	{
		maps\mp\_entityheadicons::setplayerheadicon(self.owner,(0,0,65),"tag_origin");
	}

	self.ownertrigger = spawn("trigger_radius",self.origin + (0,0,1),0,32,64);
	self.pickupent = spawn("script_model",self.origin + (0,0,1));
	self.pickupent setmodel("tag_origin");
	self.pickupent.owner = var_00;
	var_00 thread player_handleturretpickup(self);
	var_00 thread player_handleturrethints(self);
	if(self.rippable)
	{
		var_00 thread player_handleturretrippable(self);
	}

	if(!self.disruptorturret)
	{
		thread watchenterandexit();
	}

	thread turret_handledeath();
	thread maps\mp\gametypes\_damage::setentitydamagecallback(self.maxhealth,undefined,::onturretdeath,::turret_modifydamage,1);
	thread turret_timeout();
	thread turret_gameend();
	thread turret_watchemp();
	if(!self.heavyresistance)
	{
		thread turret_watchdisabled();
	}

	if(self.antiintrusion)
	{
		thread turret_createantiintrusionkillcament();
	}

	thread turret_handlepitch();
	thread turret_handlelaser();
	if(isdefined(level.ishorde) && level.ishorde)
	{
		thread turret_hordeshootdronesandturrets();
	}
}

//Function Number: 32
handlemeleedamage(param_00,param_01,param_02)
{
	if(maps\mp\_utility::ismeleemod(param_01))
	{
		var_03 = self.maxhealth + 1;
		if(var_03 > param_02)
		{
			return var_03;
		}
	}

	return param_02;
}

//Function Number: 33
turret_modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = handlemeleedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleempdamage(param_01,param_02,var_04,param_00);
	var_04 = maps\mp\gametypes\_damage::handlemissiledamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handlegrenadedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	if(isdefined(self.owner) && var_04 > 0)
	{
		self.owner playrumbleonentity("damage_heavy");
		self.owner thread maps\mp\killstreaks\_aerial_utility::playershowstreakstaticfordamage();
	}

	return var_04;
}

//Function Number: 34
onturretdeath(param_00,param_01,param_02,param_03)
{
	self notify("death",param_00,param_02,param_01);
	if(isdefined(self.tagmarkedby) && self.tagmarkedby != param_00)
	{
		self.tagmarkedby thread maps\mp\killstreaks\_marking_util::playerprocesstaggedassist(self);
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(!isplayer(param_00))
		{
			param_00 = param_00.owner;
		}
	}

	maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,"sentry_gun_destroyed",undefined,undefined,0);
	self laseroff();
}

//Function Number: 35
playershowturretoverlay(param_00)
{
	self endon("disconnect");
	self endon("playerHideTurretOverlay");
	wait(0.5);
	var_01 = 0;
	if(param_00.weaponinfo == "sentry_minigun_mp")
	{
		var_01 = 1;
	}
	else if(param_00.weaponinfo == "remote_energy_turret_mp")
	{
		var_01 = 2;
	}
	else if(param_00.weaponinfo == "killstreakmahem_mp")
	{
		var_01 = 3;
	}

	self setclientomnvar("ui_sentry_ammo_type",var_01);
	self setclientomnvar("ui_sentry_toggle",1);
	maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
}

//Function Number: 36
playerhideturretoverlay()
{
	self notify("playerHideTurretOverlay");
	self setclientomnvar("ui_sentry_toggle",0);
	maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
}

//Function Number: 37
playerwaittillweaponswitchover(param_00)
{
	self endon("weapon_change");
	self waittill("weapon_switch_started",var_01);
	if(param_00 != var_01)
	{
		return;
	}

	while(self isreloading())
	{
		wait 0.05;
	}
}

//Function Number: 38
startusingremoteturret(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = self.owner;
	if(!param_04)
	{
		var_05 playerlinkto(self.remoteent);
		var_05 playerlinkedoffsetenable();
		var_05 maps\mp\_utility::_giveweapon(level.turretsettings[self.turrettype].laptopinfo);
		var_05 switchtoweapon(level.turretsettings[self.turrettype].laptopinfo);
		var_05 disableoffhandweapons();
		var_05 disableoffhandsecondaryweapons();
		var_05 playerwaittillweaponswitchover(level.turretsettings[self.turrettype].laptopinfo);
		var_06 = var_05 getcurrentweapon();
		if(var_06 != level.turretsettings[self.turrettype].laptopinfo)
		{
			var_05 takekillstreakweapons(self.turrettype);
			var_05 enableoffhandweapons();
			var_05 enableoffhandsecondaryweapons();
			var_05 unlink();
			return 0;
		}
	}

	self.remotecontrolled = 1;
	sentry_stopattackingtargets();
	var_05 thread playerdoridekillstreak(self,param_04);
	var_05 waittill("initRideKillstreak_complete",var_07);
	if(!var_07)
	{
		return 0;
	}

	var_05 maps\mp\_utility::playersaveangles();
	var_05 maps\mp\_utility::setusingremote(self.turrettype);
	self notify("remoteControlledUpdate");
	self.killcamstarttime = gettime();
	var_05 thread waitsetthermal(1,self);
	if(getdvarint("camera_thirdPerson"))
	{
		var_05 maps\mp\_utility::setthirdpersondof(0);
	}

	var_05 playerlinkweaponviewtodelta(self,"tag_player",0,param_00,param_01,param_02,param_03,0);
	var_05 playerlinkedsetviewznear(0);
	var_05 playerlinkedsetusebaseangleforviewclamp(1);
	var_05 remotecontrolturret(self);
	if(isdefined(self.remoteent))
	{
		self.remoteent maps\mp\_utility::disablegloballyusablebytype();
	}

	turret_clearpickuphints();
	var_05 thread playershowturretoverlay(self);
	if(self.rocketturret)
	{
		var_05 thread playermonitorrocketturretfire(self);
	}

	if(var_05 maps\mp\_utility::isjuggernaut())
	{
		var_05.juggernautoverlay.alpha = 0;
	}

	thread maps\mp\_utility::playloopsoundtoplayers("sentry_gun_remote_view_bg",(0,0,60),[var_05]);
	return 1;
}

//Function Number: 39
waitsetthermal(param_00,param_01)
{
	self endon("disconnect");
	self endon("thermalVisionFOFOverlayOff");
	param_01 endon("death");
	wait(param_00);
	self thermalvisionfofoverlayon();
}

//Function Number: 40
setthermaloff()
{
	self notify("thermalVisionFOFOverlayOff");
	self thermalvisionfofoverlayoff();
}

//Function Number: 41
stopusingremoteturret(param_00)
{
	if(!isdefined(self.remotecontrolled) || !self.remotecontrolled)
	{
		return;
	}

	self.remotecontrolled = undefined;
	self notify("remoteControlledUpdate");
	var_01 = self.owner;
	var_01 takekillstreakweapons(self.turrettype);
	var_01 enableoffhandweapons();
	var_01 enableoffhandsecondaryweapons();
	thread sentry_attacktargets();
	var_02 = maps\mp\_utility::getkillstreakweapon(level.turretsettings[self.turrettype].streakname);
	var_01 maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe(var_02);
	var_03 = var_01 common_scripts\utility::getlastweapon();
	if(isdefined(var_01.underwater) && var_01.underwater)
	{
		var_03 = var_01 maps\mp\_utility::get_water_weapon();
	}

	var_01 switchtoweapon(var_03);
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 unlink();
	if(var_01 maps\mp\_utility::isusingremote())
	{
		var_01 setthermaloff();
		var_01 remotecontrolturretoff(self);
		if(var_01 maps\mp\_utility::isusingremote())
		{
			var_01 maps\mp\_utility::clearusingremote();
		}

		if(getdvarint("camera_thirdPerson"))
		{
			var_01 maps\mp\_utility::setthirdpersondof(1);
		}
	}

	if(turret_isstunned())
	{
		var_01 stopshellshock();
	}

	if(!turret_isstunned() && param_00 && !isdefined(var_01.using_remote_turret_when_died) || !var_01.using_remote_turret_when_died)
	{
		self.remoteent maps\mp\_utility::enablegloballyusablebytype();
	}

	if(var_01 maps\mp\_utility::isjuggernaut())
	{
		var_01.juggernautoverlay.alpha = 1;
	}

	var_01 playerhideturretoverlay();
	self notify("stop soundsentry_gun_remote_view_bg");
	if(isdefined(var_01.killcament))
	{
		var_01.killcament delete();
	}

	maps\mp\_utility::playerrestoreangles();
	self notify("exit");
}

//Function Number: 42
playerdoridekillstreak(param_00,param_01)
{
	var_02 = "remote_turret";
	if(param_01)
	{
		var_02 = "coop";
	}

	var_03 = maps\mp\killstreaks\_killstreaks::initridekillstreak(var_02);
	if(!isdefined(self))
	{
		return;
	}

	if(var_03 != "success" || param_00 turret_isstunned() || isdefined(param_00.dead))
	{
		if(var_03 != "disconnect" || param_00 turret_isstunned() || isdefined(param_00.dead))
		{
			thread maps\mp\_utility::playerremotekillstreakshowhud();
			param_00 stopusingremoteturret(!param_01);
		}

		self notify("initRideKillstreak_complete",0);
		return;
	}

	self notify("initRideKillstreak_complete",1);
}

//Function Number: 43
watchownermessageondeath(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("ripped");
	self.using_remote_turret_when_died = 0;
	for(;;)
	{
		if(isalive(self))
		{
			self waittill("death");
		}

		if(isdefined(param_00.remoteent))
		{
			param_00.remoteent maps\mp\_utility::disablegloballyusablebytype();
		}

		param_00 turret_clearpickuphints();
		if(self.using_remote_turret)
		{
			self.using_remote_turret_when_died = 1;
		}
		else
		{
			self.using_remote_turret_when_died = 0;
		}

		self waittill("spawned_player");
		self.using_remote_turret_when_died = 0;
		if(isdefined(param_00.remoteent))
		{
			param_00.remoteent maps\mp\_utility::enablegloballyusablebytype();
		}
	}
}

//Function Number: 44
watchenterandexit()
{
	self endon("death");
	self endon("carried");
	level endon("game_ended");
	var_00 = self.owner;
	thread watchenterandexitinput();
	for(;;)
	{
		if(var_00 player_shoulddisableremoteenter(self))
		{
			if(!isdefined(var_00.enter_message_deleted) || !var_00.enter_message_deleted)
			{
				var_00.enter_message_deleted = 1;
				self.remoteent maps\mp\_utility::disablegloballyusablebytype();
			}
		}
		else if(isdefined(var_00.enter_message_deleted) && var_00.enter_message_deleted)
		{
			self.remoteent maps\mp\_utility::enablegloballyusablebytype();
			var_00.enter_message_deleted = 0;
		}

		wait 0.05;
	}
}

//Function Number: 45
player_shoulddisableremoteenter(param_00)
{
	var_01 = self getcurrentweapon();
	return param_00 turret_isstunned() || player_isusingkillstreak(param_00) || isdefined(self.underwater) && self.underwater || self.using_remote_turret || var_01 == "none" || self istouching(param_00.ownertrigger) || self islinked() && !self.using_remote_turret || isdefined(self.empgrenaded) && self.empgrenaded;
}

//Function Number: 46
watchenterandexitinput()
{
	self endon("death");
	self endon("carried");
	level endon("game_ended");
	var_00 = self.owner;
	var_01 = 50;
	var_02 = 30;
	var_03 = 80;
	var_04 = 80;
	if(self.is360)
	{
		var_03 = 180;
		var_04 = 180;
	}

	for(;;)
	{
		waittillremoteturretusedreturn();
		var_00.using_remote_turret = 1;
		var_05 = startusingremoteturret(var_03,var_04,var_01,var_02);
		if(var_05)
		{
			wait(2);
			waittillremoteturretleavereturn();
			var_00.using_remote_turret = 0;
			stopusingremoteturret();
			wait(2);
			continue;
		}

		var_00.using_remote_turret = 0;
	}
}

//Function Number: 47
waittillremoteturretusedreturn()
{
	var_00 = self.owner;
	for(;;)
	{
		self.remoteent waittill("trigger");
		if(var_00 playercanuseturret(self))
		{
			return;
		}
	}
}

//Function Number: 48
waittillremoteturretleavereturn()
{
	var_00 = self.owner;
	for(;;)
	{
		var_01 = 0;
		while(var_00 usebuttonpressed())
		{
			var_01 = var_01 + 0.05;
			if(var_01 > 0.2 && var_00 playercanuseturret(self))
			{
				return;
			}

			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 49
playercanuseturret(param_00)
{
	if(self fragbuttonpressed() || isdefined(self.throwinggrenade) || self secondaryoffhandbuttonpressed())
	{
		return 0;
	}

	if(self isusingturret() || !self isonground())
	{
		return 0;
	}

	if(isdefined(param_00.ownertrigger) && self istouching(param_00.ownertrigger))
	{
		return 0;
	}

	if(isdefined(self.empgrenaded) && self.empgrenaded)
	{
		return 0;
	}

	if(isdefined(self.iscarrying) && self.iscarrying)
	{
		return 0;
	}

	if(isdefined(self.iscapturingcrate) && self.iscapturingcrate)
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(!self.using_remote_turret && maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(self islinked() && !self.using_remote_turret)
	{
		return 0;
	}

	return 1;
}

//Function Number: 50
player_isusingkillstreak(param_00)
{
	var_01 = self getcurrentweapon();
	return maps\mp\_utility::isjuggernaut() || maps\mp\_utility::isusingremote() || maps\mp\_utility::isinremotetransition() || maps\mp\_utility::iskillstreakweapon(var_01) && var_01 != "killstreak_remote_turret_mp" && var_01 != "sentry_minigun_mp" && var_01 != "remote_energy_turret_mp" && var_01 != level.turretsettings[param_00.turrettype].laptopinfo && var_01 != "none" && var_01 != "turretheadmg_mp" && var_01 != "turretheadenergy_mp" && var_01 != "turretheadrocket_mp";
}

//Function Number: 51
player_handleturrethints(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	if(isbot(self))
	{
		return;
	}

	if(!isdefined(param_00.ownertrigger) || !isdefined(param_00.pickupent))
	{
		return;
	}

	param_00.pickupent endon("death");
	for(;;)
	{
		if(player_shouldclearturretpickuphints(param_00))
		{
			if(!isdefined(self.pickup_message_deleted) || !self.pickup_message_deleted)
			{
				self.pickup_message_deleted = 1;
				param_00 turret_clearpickuphints();
			}
		}
		else if(isdefined(self.pickup_message_deleted) && self.pickup_message_deleted)
		{
			param_00 thread turret_setpickuphints();
			self.pickup_message_deleted = 0;
		}

		wait 0.05;
	}
}

//Function Number: 52
player_shouldclearturretpickuphints(param_00)
{
	var_01 = self getcurrentweapon();
	return param_00 turret_isstunned() || player_isusingkillstreak(param_00) || isdefined(self.underwater) && self.underwater || self.using_remote_turret || var_01 == "none" || !self istouching(param_00.ownertrigger) || !maps\mp\_utility::isreallyalive(self) || !self isonground() || isdefined(param_00.carriedby);
}

//Function Number: 53
player_handleturretpickup(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	if(isbot(self))
	{
		return;
	}

	if(!isdefined(param_00.ownertrigger) || !isdefined(param_00.pickupent))
	{
		return;
	}

	param_00.pickupent endon("death");
	var_01 = 0;
	for(;;)
	{
		if(player_isusingkillstreak(param_00))
		{
			wait 0.05;
			continue;
		}

		if(!self istouching(param_00.ownertrigger))
		{
			wait 0.05;
			continue;
		}

		if(maps\mp\_utility::isreallyalive(self) && self istouching(param_00.ownertrigger) && !isdefined(param_00.carriedby) && self isonground())
		{
			var_02 = 0;
			while(self usebuttonpressed())
			{
				if(!maps\mp\_utility::isreallyalive(self))
				{
					break;
				}

				if(!self istouching(param_00.ownertrigger))
				{
					break;
				}

				if(self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || isdefined(self.throwinggrenade))
				{
					break;
				}

				if(self islinked() || !self isonground() || self isusingturret() || maps\mp\_utility::isusingremote())
				{
					break;
				}

				if(isdefined(self.iscarrying) && self.iscarrying)
				{
					break;
				}

				if(isdefined(self.iscapturingcrate) && self.iscapturingcrate)
				{
					break;
				}

				if(isdefined(self.empgrenaded) && self.empgrenaded)
				{
					break;
				}

				if(isdefined(self.using_remote_turret) && self.using_remote_turret)
				{
					break;
				}

				if(isdefined(self.ball_carried))
				{
					break;
				}

				var_02 = var_02 + 0.05;
				if(var_02 > 0.75)
				{
					param_00 playsound("sentry_gun_pick_up");
					param_00 setmode(level.turretsettings[param_00.turrettype].sentrymodeoff);
					param_00 sentry_stopattackingtargets();
					thread setcarryingturret(param_00,0);
					param_00 turret_clearpickuphints();
					self.remoteturretlist = undefined;
					param_00.pickupent delete();
					param_00.ownertrigger delete();
					return;
				}

				wait 0.05;
			}
		}

		wait 0.05;
	}
}

//Function Number: 54
player_handleturretrippable(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	if(isbot(self))
	{
		return;
	}

	if(!isdefined(param_00.ownertrigger) || !isdefined(param_00.pickupent))
	{
		return;
	}

	param_00.pickupent endon("death");
	var_01 = 0;
	for(;;)
	{
		if(player_isusingkillstreak(param_00))
		{
			wait(0.05);
			continue;
		}

		if(maps\mp\killstreaks\_rippedturret::playerhasturretheadweapon())
		{
			wait 0.05;
			continue;
		}

		if(!self istouching(param_00.ownertrigger))
		{
			wait(0.05);
			continue;
		}

		if(maps\mp\_utility::isreallyalive(self) && self istouching(param_00.ownertrigger) && !isdefined(param_00.carriedby) && self isonground())
		{
			if(self usebuttonpressed())
			{
				if(isdefined(self.using_remote_turret) && self.using_remote_turret)
				{
					continue;
				}

				var_01 = 0;
				while(self usebuttonpressed())
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				var_01 = 0;
				while(!self usebuttonpressed() && var_01 < 0.5)
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				if(!maps\mp\_utility::isreallyalive(self))
				{
					continue;
				}

				if(isdefined(self.using_remote_turret) && self.using_remote_turret)
				{
					continue;
				}

				if(isdefined(self.ball_carried))
				{
					continue;
				}

				param_00 setmode(level.turretsettings[param_00.turrettype].sentrymodeoff);
				param_00 sentry_stopattackingtargets();
				thread setripoffturrethead(param_00);
				param_00 turret_clearpickuphints();
				self.remoteturretlist = undefined;
				param_00.pickupent delete();
				param_00.ownertrigger delete();
				return;
			}
		}

		wait(0.05);
	}
}

//Function Number: 55
turret_blinky_light()
{
	self endon("death");
	self endon("carried");
	for(;;)
	{
		playfxontag(common_scripts\utility::getfx("antenna_light_mp"),self,"tag_fx");
		wait(1);
		stopfxontag(common_scripts\utility::getfx("antenna_light_mp"),self,"tag_fx");
	}
}

//Function Number: 56
turret_setinactive()
{
	self setmode(level.turretsettings[self.turrettype].sentrymodeoff);
	sentry_stopattackingtargets();
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon("none",(0,0,0));
	}
	else if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::setplayerheadicon(undefined,(0,0,0));
	}

	if(!isdefined(self.owner))
	{
		return;
	}

	var_00 = self.owner;
	level.turrets[self getentitynumber()] = undefined;
	if(isdefined(self.remoteent))
	{
		self.remoteent maps\mp\_utility::disablegloballyusablebytype();
	}

	if(isdefined(var_00.using_remote_turret) && var_00.using_remote_turret)
	{
		var_00 thermalvisionoff();
		var_00 setthermaloff();
		var_00 remotecontrolturretoff(self);
		var_00 unlink();
		var_01 = var_00 common_scripts\utility::getlastweapon();
		if(isdefined(var_00.underwater) && var_00.underwater)
		{
			var_01 = var_00 maps\mp\_utility::get_water_weapon();
		}

		var_00 switchtoweapon(var_01);
		if(var_00 maps\mp\_utility::isusingremote())
		{
			var_00 maps\mp\_utility::clearusingremote();
		}

		if(getdvarint("camera_thirdPerson"))
		{
			var_00 maps\mp\_utility::setthirdpersondof(1);
		}

		if(isdefined(var_00.disabledusability) && var_00.disabledusability)
		{
			if(isdefined(level.ishorde) && level.ishorde && isdefined(var_00.laststand) && var_00.laststand)
			{
				if(var_00.disabledusability > 1)
				{
					var_00.disabledusability--;
				}
			}
			else
			{
				var_00 common_scripts\utility::_enableusability();
			}
		}

		var_00 takekillstreakweapons(self.turrettype);
		if(var_00 maps\mp\_utility::isjuggernaut())
		{
			var_00.juggernautoverlay.alpha = 1;
		}
	}
}

//Function Number: 57
turret_handleownerdisconnect()
{
	self endon("death");
	level endon("game_ended");
	self notify("turret_handleOwner");
	self endon("turret_handleOwner");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 58
turret_gameend()
{
	self endon("death");
	level waittill("game_ended");
	if(isdefined(self.owner))
	{
		self.owner playerhideturretoverlay();
	}
}

//Function Number: 59
turret_timeout()
{
	self endon("death");
	level endon("game_ended");
	if(isdefined(self.timeoutstarted))
	{
		return;
	}

	self.timeoutstarted = 1;
	var_00 = level.turretsettings[self.turrettype].timeout;
	if(self.disruptorturret)
	{
		var_00 = var_00 + 30;
	}

	self.owner setclientomnvar("ui_sentry_lifespan",var_00);
	while(var_00)
	{
		wait(1);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		if(!isdefined(self.carriedby))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	if(isdefined(self.owner))
	{
		self.owner playerhideturretoverlay();
	}

	self notify("death");
}

//Function Number: 60
turret_handledeath()
{
	self endon("carried");
	var_00 = self getentitynumber();
	maps\mp\killstreaks\_autosentry::addtoturretlist(var_00);
	self waittill("death",var_01,var_02,var_03);
	self cleartargetentity();
	turret_deathsounds(var_01,var_03);
	self.damagecallback = undefined;
	self setcandamage(0);
	self setdamagecallbackon(0);
	self freeentitysentient();
	self laseroff();
	self.dead = 1;
	maps\mp\killstreaks\_autosentry::removefromturretlist(var_00);
	if(!isdefined(self))
	{
		return;
	}

	turret_clearpickuphints();
	turret_setinactive();
	self setdefaultdroppitch(35);
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	if(isdefined(self.remoteent))
	{
		self.remoteent maps\mp\_utility::makegloballyunusablebytype();
	}

	var_04 = self.owner;
	if(isdefined(var_04))
	{
		stopusingremoteturret();
		var_04.using_remote_turret = 0;
		var_04.turret = undefined;
		var_04 restoreperks();
		var_04 playerremovenotifycommands();
		if(var_04 getcurrentweapon() == "none")
		{
			var_05 = var_04 common_scripts\utility::getlastweapon();
			if(isdefined(var_04.underwater) && var_04.underwater)
			{
				var_05 = var_04 maps\mp\_utility::get_water_weapon();
			}

			var_04 switchtoweapon(var_05);
		}
	}

	self playsound("sentry_gun_death_exp");
	if(!isdefined(self.quick_death) || !self.quick_death)
	{
		playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"TAG_AIM_PIVOT");
		wait(1.5);
		var_06 = 8;
		while(var_06 > 0)
		{
			playfxontag(common_scripts\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
			wait(0.4);
			var_06 = var_06 - 0.4;
		}
	}

	self notify("deleting");
	if(isdefined(self.target_ent))
	{
		self.target_ent delete();
	}

	if(isdefined(self.ownertrigger))
	{
		self.ownertrigger delete();
	}

	if(isdefined(self.pickupent))
	{
		self.pickupent delete();
	}

	if(isdefined(self.remoteent))
	{
		self.remoteent delete();
	}

	if(isdefined(self.rocketmuzzleflashent))
	{
		self.rocketmuzzleflashent delete();
	}

	deathsoundsandfx();
	self delete();
}

//Function Number: 61
turret_deathsounds(param_00,param_01)
{
	if(isdefined(self.owner) && isdefined(param_00) && self.owner != param_00)
	{
		self.owner thread maps\mp\_utility::leaderdialogonplayer("ks_sentrygun_destroyed",undefined,undefined,self.origin);
	}
}

//Function Number: 62
turret_incrementdamagefade()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(self.damagefade < 1)
		{
			self.damagefade = self.damagefade + 0.1;
			var_00 = 1;
		}
		else if(var_00)
		{
			self.damagefade = 1;
			var_00 = 0;
		}

		wait(0.1);
	}
}

//Function Number: 63
turret_setpickuphints()
{
	self notify("turretClearPickupHints");
	self endon("turretClearPickupHints");
	self.pickupent makeusable();
	self.pickupent sethintstring(level.turretsettings[self.turrettype].hintpickup);
	self.pickupent setcursorhint("HINT_NOICON");
	self.pickupent sethintstringvisibleonlytoowner(1);
	if(self.rippable)
	{
		for(;;)
		{
			var_00 = 0;
			if(!var_00 && isdefined(self.owner) && !self.owner maps\mp\killstreaks\_rippedturret::playerhasturretheadweapon())
			{
				self.pickupent setsecondaryhintstring(level.turretsettings[self.turrettype].hintripoff);
				var_00 = 1;
				continue;
			}

			if(var_00)
			{
				self.pickupent setsecondaryhintstring("");
				var_00 = 0;
			}

			wait 0.05;
		}
	}
}

//Function Number: 64
turret_clearpickuphints()
{
	self notify("turretClearPickupHints");
	if(!isdefined(self.pickupent))
	{
		return;
	}

	self.pickupent makeunusable();
	self.pickupent sethintstring("");
	self.pickupent setsecondaryhintstring("");
	self.pickupent sethintstringvisibleonlytoowner(0);
}

//Function Number: 65
sentry_stopattackingtargets()
{
	self notify("sentry_stop");
}

//Function Number: 66
sentry_attacktargets(param_00)
{
	if(!self.issentry)
	{
		return;
	}

	self endon("sentry_stop");
	self endon("death");
	level endon("game_ended");
	self notify("sentry_start");
	self.momentum = 0;
	self.heatlevel = 0;
	self.overheated = 0;
	if(!self.rocketturret)
	{
		thread sentry_heatmonitor("sentry_minigun_mp",4,0.1);
	}

	self setmode(level.turretsettings["mg_turret"].sentrymodeon);
	self.firereadytime = gettime();
	for(;;)
	{
		common_scripts\utility::waittill_either("turretstatechange","cooled");
		if(self isfiringturret())
		{
			thread turret_startshooting(param_00);
			continue;
		}

		thread turret_stopshooting();
	}
}

//Function Number: 67
turret_startshooting(param_00)
{
	if(self.rocketturret)
	{
		thread turret_firerockets();
		return;
	}

	thread sentry_burstfirestart(param_00);
}

//Function Number: 68
turret_stopshooting()
{
	if(self.rocketturret)
	{
		thread turret_stoprockets();
		return;
	}

	sentry_spindown();
	thread sentry_burstfirestop();
}

//Function Number: 69
playermonitorrocketturretfire(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("sentry_start");
	param_00 endon("exit");
	param_00.firereadytime = gettime();
	for(;;)
	{
		self waittill("turret_fire");
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		if(isdefined(level.hostmigrationtimer))
		{
			continue;
		}

		if(gettime() >= param_00.firereadytime)
		{
			param_00 thread turret_firerocket(0);
		}
	}
}

//Function Number: 70
sentry_targetlocksound()
{
	self endon("death");
	self endon("sentry_stop");
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
}

//Function Number: 71
sentry_spinup()
{
	self endon("death");
	self endon("sentry_stop");
	thread sentry_targetlocksound();
	while(self.momentum < 0.05)
	{
		self.momentum = self.momentum + 0.1;
		wait(0.1);
	}
}

//Function Number: 72
sentry_spindown()
{
	self.momentum = 0;
}

//Function Number: 73
sentry_burstfirestart(param_00)
{
	self endon("death");
	self endon("sentry_stop");
	self endon("stop_shooting");
	level endon("game_ended");
	sentry_spinup();
	var_01 = weaponfiretime("sentry_minigun_mp");
	var_02 = 20;
	var_03 = 120;
	var_04 = 0.15;
	var_05 = 0.35;
	for(;;)
	{
		var_06 = randomintrange(var_02,var_03 + 1);
		for(var_07 = 0;var_07 < var_06 && !self.overheated;var_07++)
		{
			if(isdefined(param_00))
			{
				self [[ param_00 ]]();
			}
			else
			{
				self shootturret();
			}

			self.heatlevel = self.heatlevel + var_01;
			wait(var_01);
		}

		wait(randomfloatrange(var_04,var_05));
	}
}

//Function Number: 74
turret_stoprockets()
{
	self notify("stop_shooting");
}

//Function Number: 75
turret_firerockets()
{
	self endon("death");
	self endon("sentry_stop");
	self endon("stop_shooting");
	level endon("game_ended");
	self.firereadytime = gettime();
	for(;;)
	{
		if(gettime() >= self.firereadytime)
		{
			thread turret_firerocket(1);
		}

		wait 0.05;
	}
}

//Function Number: 76
turret_firerocket(param_00)
{
	level endon("game_ended");
	var_01 = self gettagorigin("tag_flash");
	var_02 = anglestoforward(self gettagangles("tag_flash"));
	var_03 = var_01 + var_02 * 10000;
	var_01 = var_01 + var_02 * 10;
	var_04 = bullettrace(var_01,var_03,1);
	var_05 = var_04["entity"];
	var_06 = 0;
	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_06 = isdefined(var_05) && isdefined(var_05.team) && self.team != var_05.team;
	}
	else
	{
		var_06 = isdefined(var_05) && isplayer(var_05) && !isalliedsentient(self.owner,var_05);
	}

	if(!var_06 && param_00)
	{
		return;
	}

	self playrumbleonentity("damage_heavy");
	var_07 = magicbullet("killstreakmahem_mp",var_01,var_03,self.owner);
	if(param_00)
	{
		var_08 = 2500;
	}
	else
	{
		var_08 = 1250;
	}

	self.firereadytime = gettime() + var_08;
	if(!param_00)
	{
		playfxontagforclients(common_scripts\utility::getfx("sentry_rocket_muzzleflash_view"),self,"tag_flash",self.owner);
		if(!isdefined(self.rocketmuzzleflashent))
		{
			self.rocketmuzzleflashent = spawnmuzzleflashent(self,"tag_flash",self.owner);
		}

		playfxontag(common_scripts\utility::getfx("sentry_rocket_muzzleflash_wv"),self.rocketmuzzleflashent,"tag_origin");
		return;
	}

	playfxontag(common_scripts\utility::getfx("sentry_rocket_muzzleflash_wv"),self,"tag_flash");
}

//Function Number: 77
spawnmuzzleflashent(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",(0,0,0));
	var_03 setmodel("tag_origin");
	var_03 linkto(param_00,param_01,(0,0,0),(0,0,0));
	var_03 hide();
	foreach(var_05 in level.players)
	{
		if(var_05 != param_02)
		{
			var_03 showtoplayer(var_05);
		}
	}

	thread onplayerconnectmuzzleflashent(var_03);
	return var_03;
}

//Function Number: 78
onplayerconnectmuzzleflashent(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		level waittill("connected",var_01);
		thread onplayerspawnedmuzzleflashent(param_00,var_01);
	}
}

//Function Number: 79
onplayerspawnedmuzzleflashent(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("disconnect");
	param_01 waittill("spawned_player");
	param_00 showtoplayer(param_01);
}

//Function Number: 80
sentry_burstfirestop()
{
	self notify("stop_shooting");
}

//Function Number: 81
sentry_heatmonitor(param_00,param_01,param_02)
{
	self endon("death");
	self endon("sentry_stop");
	var_03 = weaponfiretime(param_00);
	var_04 = 0;
	var_05 = 0;
	if(self.heatlevel != var_04)
	{
		wait(var_03);
	}
	else
	{
		self.heatlevel = max(0,self.heatlevel - 0.05);
	}

	if(self.heatlevel > param_01)
	{
		self.overheated = 1;
		self turretsetbarrelspinenabled(0);
		thread playheatfx();
		switch(self.turrettype)
		{
			case "mg_turret":
				break;

			default:
				break;
		}
	}
}

//Function Number: 82
playheatfx()
{
	self endon("death");
	self endon("sentry_stop");
	self endon("not_overheated");
	level endon("game_ended");
	self notify("playing_heat_fx");
	self endon("playing_heat_fx");
	for(;;)
	{
		playfxontag(common_scripts\utility::getfx("sentry_overheat_mp"),self,"tag_flash");
		wait(0.3);
	}
}

//Function Number: 83
turret_watchemp()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	self waittill("emp_damage");
	self notify("death");
}

//Function Number: 84
turret_watchdisabled()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("concussed");
		var_00 = 4;
		playfxontag(common_scripts\utility::getfx("sentry_stunned_mp"),self,"tag_aim");
		self notify("stunned");
		self.stunned = 1;
		if(self.issentry)
		{
			self setdefaultdroppitch(35);
			self setmode(level.turretsettings[self.turrettype].sentrymodeoff);
		}

		if(isdefined(self.remotecontrolled) && self.remotecontrolled)
		{
			stopusingremoteturret();
		}

		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
		stopfxontag(common_scripts\utility::getfx("sentry_stunned_mp"),self,"tag_aim");
		if(self.issentry)
		{
			self setdefaultdroppitch(0);
			self setmode(level.turretsettings[self.turrettype].sentrymodeon);
		}

		self.stunned = 0;
		self notify("stunnedDone");
	}
}

//Function Number: 85
turret_isstunned()
{
	return isdefined(self.stunned) && self.stunned;
}

//Function Number: 86
turret_createantiintrusionkillcament()
{
	var_00 = spawn("script_model",self.origin + (0,0,60));
	self.killcament = var_00;
	common_scripts\utility::waittill_any("death","carried");
	wait(3);
	var_00 delete();
}

//Function Number: 87
turret_handlelaser()
{
	self endon("death");
	if(!self.issentry)
	{
		return;
	}

	self laseron("mp_sentry_turret");
	self waittill("carried");
	self laseroff();
}

//Function Number: 88
turret_handlepitch()
{
	self endon("carried");
	self endon("death");
	if(self.issentry || self.disruptorturret)
	{
		self setdefaultdroppitch(0);
		return;
	}
	else
	{
		self setdefaultdroppitch(35);
	}

	for(;;)
	{
		self waittill("remoteControlledUpdate");
		if(isdefined(self.remotecontrolled) && self.remotecontrolled)
		{
			self setdefaultdroppitch(0);
			continue;
		}

		self setdefaultdroppitch(35);
	}
}

//Function Number: 89
turret_hordeshootdronesandturrets()
{
	self endon("death");
	var_00 = (0,0,40);
	for(;;)
	{
		var_01 = 5000000;
		var_02 = undefined;
		foreach(var_04 in level.flying_attack_drones)
		{
			var_05 = distancesquared(self.origin,var_04.origin);
			if(var_05 < var_01)
			{
				if(sighttracepassed(self.origin + var_00,var_04.origin,0,undefined))
				{
					var_01 = var_05;
					var_02 = var_04;
				}
			}
		}

		var_07 = undefined;
		foreach(var_09 in level.hordesentryarray)
		{
			var_05 = distancesquared(self.origin,var_09.origin);
			if(var_05 < var_01)
			{
				if(sighttracepassed(self.origin + var_00,var_09.origin + var_00,0,undefined))
				{
					var_01 = var_05;
					var_07 = var_09;
				}
			}
		}

		if(isdefined(var_07))
		{
			self settargetentity(var_07,var_00);
		}
		else if(isdefined(var_02))
		{
			self settargetentity(var_02);
		}

		wait 0.05;
	}
}

//Function Number: 90
playeraddnotifycommands()
{
	self notifyonplayercommand("turret_fire","+attack");
	self notifyonplayercommand("turret_fire","+attack_akimbo_accessible");
	self notifyonplayercommand("place_turret","+attack");
	self notifyonplayercommand("place_turret","+attack_akimbo_accessible");
	if(!isbot(self))
	{
		self notifyonplayercommand("cancel_turret","weapnext");
		self notifyonplayercommand("cancel_turret","+actionslot 4");
		if(!level.console)
		{
			self notifyonplayercommand("cancel_turret","+actionslot 5");
			self notifyonplayercommand("cancel_turret","+actionslot 6");
			self notifyonplayercommand("cancel_turret","+actionslot 7");
			self notifyonplayercommand("cancel_turret","+actionslot 8");
		}
	}
}

//Function Number: 91
playerremovenotifycommands()
{
	self notifyonplayercommandremove("turret_fire","+attack");
	self notifyonplayercommandremove("turret_fire","+attack_akimbo_accessible");
	self notifyonplayercommandremove("place_turret","+attack");
	self notifyonplayercommandremove("place_turret","+attack_akimbo_accessible");
	if(!isbot(self))
	{
		self notifyonplayercommandremove("cancel_turret","+actionslot 4");
		if(!level.console)
		{
			self notifyonplayercommandremove("cancel_turret","weapnext");
			self notifyonplayercommandremove("cancel_turret","+actionslot 5");
			self notifyonplayercommandremove("cancel_turret","+actionslot 6");
			self notifyonplayercommandremove("cancel_turret","+actionslot 7");
			self notifyonplayercommandremove("cancel_turret","+actionslot 8");
		}
	}
}

//Function Number: 92
sentry_disruptor()
{
	level endon("game_ended");
	self endon("carried");
	self endon("death");
	if(!isdefined(self.owner) || !self.disruptorturret)
	{
		return;
	}

	if(isdefined(level.turretdisruptorcustomthink))
	{
		self thread [[ level.turretdisruptorcustomthink ]]();
		return;
	}

	if(!isdefined(level.turretdisruptorradiussq))
	{
		level.turretdisruptorradiussq = 90000;
		level.turretdisruptordetectdot = 0.5;
	}

	wait(0.5);
	thread turretdisruptorvisualsaudio();
	self.radiationlist = [];
	for(;;)
	{
		var_00 = self gettagorigin("tag_flash");
		var_01 = anglestoforward(self gettagangles("tag_flash"));
		foreach(var_03 in level.players)
		{
			if(self.stunned)
			{
				continue;
			}

			if(var_03 == self.owner || level.teambased && var_03.team == self.team)
			{
				continue;
			}

			if(!turretdisruptorcanhurtplayer(var_03,var_00,var_01))
			{
				continue;
			}

			if(common_scripts\utility::array_contains(self.radiationlist,var_03))
			{
				continue;
			}

			self.radiationlist = common_scripts\utility::array_add(self.radiationlist,var_03);
			thread turretdisruptorhurtplayer(var_03);
		}

		wait 0.05;
	}
}

//Function Number: 93
turretdisruptorcanhurtplayer(param_00,param_01,param_02)
{
	if(!isalive(param_00))
	{
		return 0;
	}

	var_03 = param_00.origin + (0,0,30);
	var_04 = distancesquared(var_03,param_01);
	if(var_04 > level.turretdisruptorradiussq)
	{
		return 0;
	}

	var_05 = vectornormalize(param_00.origin - self.origin);
	var_06 = vectordot(param_02,var_05);
	if(var_06 < level.turretdisruptordetectdot)
	{
		return 0;
	}

	var_07 = param_00 damageconetrace(param_01,self);
	return var_07 > 0;
}

//Function Number: 94
turretdisruptorhurtplayer(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	var_01 = 0.8;
	var_02 = 16;
	var_03 = gettime();
	var_04 = gettime();
	var_05 = 2;
	for(var_06 = 1;var_06;var_06 = turretdisruptorcanhurtplayer(param_00,var_07,var_08))
	{
		var_07 = self gettagorigin("tag_flash");
		var_08 = anglestoforward(self gettagangles("tag_flash"));
		if(self.stunned)
		{
			while(self.stunned)
			{
				wait 0.05;
			}

			var_06 = turretdisruptorcanhurtplayer(param_00,var_07,var_08);
			continue;
		}

		if(gettime() >= var_04)
		{
			param_00 shellshock("mp_radiation_med",var_05);
			var_04 = gettime() + var_05 * 1000;
		}

		if(gettime() >= var_03)
		{
			param_00 dodamage(var_02,var_07,self.owner,self,"MOD_TRIGGER_HURT","iw5_dlcgun12loot3_mp","torso_upper");
			var_03 = gettime() + var_01 * 1000;
			if(isalive(param_00) && !param_00 maps\mp\_utility::_hasperk("specialty_empimmune"))
			{
				param_00 thread maps\mp\_empgrenade::applyemp();
			}
		}

		var_09 = param_00 common_scripts\utility::waittill_notify_or_timeout_return("death",0.05);
		if(!isdefined(var_09) || var_09 != "timeout")
		{
			param_00 stopshellshock();
			break;
		}
	}

	if(isdefined(param_00) && !isalive(param_00))
	{
		param_00 stopshellshock();
	}

	self.radiationlist = common_scripts\utility::array_remove(self.radiationlist,param_00);
}

//Function Number: 95
turretdisruptorvisualsaudio()
{
	var_00 = self gettagangles("tag_flash") + (90,0,0);
	var_01 = spawn("script_model",self gettagorigin("tag_flash"));
	var_01.angles = (var_00[0],var_00[1],0);
	var_01 setmodel("tag_origin");
	playfxontag(common_scripts\utility::getfx("turret_distortion"),var_01,"tag_origin");
	var_01 playsoundonmovingent("wpn_disruptor_snap_npc");
	var_01 playloopsound("wpn_disruptor_beam_hi_npc");
	common_scripts\utility::waittill_any("death","carried");
	killfxontag(common_scripts\utility::getfx("turret_distortion"),var_01,"tag_origin");
	var_01 playsoundonmovingent("wpn_disruptor_off_blast_npc");
	var_01 stoploopsound("wpn_disruptor_beam_hi_npc");
	wait(0.1);
	var_01 delete();
}