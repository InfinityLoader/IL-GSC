/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_remoteturret.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 36
 * Decompile Time: 646 ms
 * Timestamp: 10/27/2023 2:27:19 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.turrettype = [];
	level.turrettype["mg_turret"] = "remote_mg_turret";
	level.killstreakfuncs["remote_mg_turret"] = ::func_3177;
	level.turretsettings = [];
	level.turretsettings["mg_turret"] = spawnstruct();
	level.turretsettings["mg_turret"].sentrymodeon = "manual";
	level.turretsettings["mg_turret"].sentrymodeoff = "sentry_offline";
	level.turretsettings["mg_turret"].timeout = 60;
	level.turretsettings["mg_turret"].health = 999999;
	level.turretsettings["mg_turret"].maxhealth = 1000;
	level.turretsettings["mg_turret"].streakname = "remote_mg_turret";
	level.turretsettings["mg_turret"].weaponinfo = "remote_turret_mp";
	level.turretsettings["mg_turret"].modelbase = "mp_remote_turret";
	level.turretsettings["mg_turret"].modelplacement = "mp_remote_turret_placement";
	level.turretsettings["mg_turret"].modelplacementfailed = "mp_remote_turret_placement_failed";
	level.turretsettings["mg_turret"].modeldestroyed = "mp_remote_turret";
	level.turretsettings["mg_turret"].teamsplash = "used_remote_mg_turret";
	level.turretsettings["mg_turret"].hintenter = &"MP_ENTER_REMOTE_TURRET";
	level.turretsettings["mg_turret"].hintexit = &"MP_EARLY_EXIT";
	level.turretsettings["mg_turret"].hintpickup = &"MP_DOUBLE_TAP_TO_CARRY";
	level.turretsettings["mg_turret"].placestring = &"MP_TURRET_PLACE";
	level.turretsettings["mg_turret"].cannotplacestring = &"MP_TURRET_CANNOT_PLACE";
	level.turretsettings["mg_turret"].vodestroyed = "remote_sentry_destroyed";
	level.turretsettings["mg_turret"].laptopinfo = "killstreak_remote_turret_laptop_mp";
	level.turretsettings["mg_turret"].remoteinfo = "killstreak_remote_turret_remote_mp";
	foreach(var_01 in level.turretsettings)
	{
		precacheitem(var_01.weaponinfo);
		precachemodel(var_01.modelbase);
		precachemodel(var_01.modelplacement);
		precachemodel(var_01.modelplacementfailed);
		precachemodel(var_01.modeldestroyed);
		precachestring(var_01.hintenter);
		precachestring(var_01.hintexit);
		precachestring(var_01.placestring);
		precachestring(var_01.cannotplacestring);
		precacheitem(var_01.laptopinfo);
		precacheitem(var_01.remoteinfo);
	}

	level._effect["sentry_explode_mp"] = loadfx("explosions/sentry_gun_explosion");
	level._effect["sentry_smoke_mp"] = loadfx("smoke/car_damage_blacksmoke");
	level._effect["antenna_light_mp"] = loadfx("lights/light_detonator_blink");
}

//Function Number: 2
func_3177(param_00)
{
	var_01 = tryuseremoteturret(param_00,"mg_turret");
	if(var_01)
	{
		maps\mp\_matchdata::logkillstreakevent(level.turretsettings["mg_turret"].streakname,self.origin);
	}

	self.iscarrying = 0;
	return var_01;
}

//Function Number: 3
takekillstreakweapons(param_00)
{
	self takeweapon(level.turretsettings[param_00].laptopinfo);
	self takeweapon(level.turretsettings[param_00].remoteinfo);
}

//Function Number: 4
tryuseremoteturret(param_00,param_01)
{
	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	var_02 = createturretforplayer(param_01,self);
	func_2DF8();
	setcarryingturret(var_02,1);
	thread func_2DFB();
	if(isdefined(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
setcarryingturret(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 func_3181(self);
	common_scripts\utility::_disableweapon();
	self notifyonplayercommand("place_turret","+attack");
	self notifyonplayercommand("place_turret","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_turret","+actionslot 4");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_turret","+actionslot 5");
		self notifyonplayercommand("cancel_turret","+actionslot 6");
		self notifyonplayercommand("cancel_turret","+actionslot 7");
	}

	for(;;)
	{
		var_02 = common_scripts\utility::waittill_any_return("place_turret","cancel_turret","force_cancel_placement");
		if(var_02 == "cancel_turret" || var_02 == "force_cancel_placement")
		{
			if(var_02 == "cancel_turret" && !param_01)
			{
				continue;
			}

			if(level.console)
			{
				var_03 = maps\mp\killstreaks\_killstreaks::func_2C01(level.turretsettings[param_00.turrettype].streakname);
				if(isdefined(self.killstreakindexweapon) && var_03 == maps\mp\killstreaks\_killstreaks::func_2C01(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && !self getweaponslistitems().size)
				{
					maps\mp\_utility::_giveweapon(var_03,0);
					maps\mp\_utility::func_31F3(4,"weapon",var_03);
				}
			}

			param_00 func_3180();
			common_scripts\utility::_enableweapon();
			return 0;
		}

		if(!param_00.canbeplaced)
		{
			continue;
		}

		param_00 func_317F();
		common_scripts\utility::_enableweapon();
		return 1;
	}
}

//Function Number: 6
func_2DF8()
{
	if(maps\mp\_utility::func_27AF("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::func_282E("specialty_explosivebullets");
	}
}

//Function Number: 7
func_2DFB()
{
	if(isdefined(self.restoreperk))
	{
		maps\mp\_utility::giveperk(self.restoreperk,0);
		self.restoreperk = undefined;
	}
}

//Function Number: 8
waitrestoreperks()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.05;
	func_2DFB();
}

//Function Number: 9
func_2DF6()
{
	foreach(var_01 in self.weaponlist)
	{
		var_02 = strtok(var_01,"_");
		if(var_02[0] == "alt")
		{
			self.restoreweaponclipammo[var_01] = self getweaponammoclip(var_01);
			self.restoreweaponstockammo[var_01] = self getweaponammostock(var_01);
			continue;
		}

		self.restoreweaponclipammo[var_01] = self getweaponammoclip(var_01);
		self.restoreweaponstockammo[var_01] = self getweaponammostock(var_01);
	}

	self.weaponstorestore = [];
	foreach(var_01 in self.weaponlist)
	{
		var_02 = strtok(var_01,"_");
		if(var_02[0] == "alt")
		{
			continue;
		}

		self.weaponstorestore[self.weaponstorestore.size] = var_01;
		self takeweapon(var_01);
	}
}

//Function Number: 10
func_2DFA()
{
	if(!isdefined(self.restoreweaponclipammo) || !isdefined(self.restoreweaponstockammo) || !isdefined(self.weaponstorestore))
	{
		return;
	}

	var_00 = [];
	foreach(var_02 in self.weaponstorestore)
	{
		var_03 = strtok(var_02,"_");
		if(var_03[0] == "alt")
		{
			var_00[var_00.size] = var_02;
			continue;
		}

		maps\mp\_utility::_giveweapon(var_02);
		if(isdefined(self.restoreweaponclipammo[var_02]))
		{
			self setweaponammoclip(var_02,self.restoreweaponclipammo[var_02]);
		}

		if(isdefined(self.restoreweaponstockammo[var_02]))
		{
			self setweaponammostock(var_02,self.restoreweaponstockammo[var_02]);
		}
	}

	foreach(var_06 in var_00)
	{
		if(isdefined(self.restoreweaponclipammo[var_06]))
		{
			self setweaponammoclip(var_06,self.restoreweaponclipammo[var_06]);
		}

		if(isdefined(self.restoreweaponstockammo[var_06]))
		{
			self setweaponammostock(var_06,self.restoreweaponstockammo[var_06]);
		}
	}

	self.restoreweaponclipammo = undefined;
	self.restoreweaponstockammo = undefined;
}

//Function Number: 11
waitrestoreweapons()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.05;
	func_2DFA();
}

//Function Number: 12
func_317F()
{
	self setmodel(level.turretsettings[self.turrettype].modelbase);
	self setsentrycarrier(undefined);
	self setcandamage(1);
	self.carriedby forceusehintoff();
	self.carriedby = undefined;
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	self playsound("sentry_gun_plant");
	thread func_318B();
	self notify("placed");
}

//Function Number: 13
func_3180()
{
	self.carriedby forceusehintoff();
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	self delete();
}

//Function Number: 14
func_3181(param_00)
{
	self setmodel(level.turretsettings[self.turrettype].modelplacement);
	self setcandamage(0);
	self setsentrycarrier(param_00);
	self setcontents(0);
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread updateturretplacement(self);
	thread func_3183(param_00);
	thread turret_oncarrierdisconnect(param_00);
	thread turret_oncarrierchangedteam(param_00);
	thread turret_ongameended();
	self setdefaultdroppitch(-89);
	turret_setinactive();
	self notify("carried");
}

//Function Number: 15
updateturretplacement(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.canbeplaced = 1;
	var_01 = -1;
	for(;;)
	{
		var_02 = self canplayerplacesentry();
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		param_00.canbeplaced = self isonground() && var_02["result"] && abs(param_00.origin[2] - self.origin[2]) < 10;
		if(param_00.canbeplaced != var_01)
		{
			if(param_00.canbeplaced)
			{
				param_00 setmodel(level.turretsettings[param_00.turrettype].modelplacement);
				self forceusehinton(level.turretsettings[param_00.turrettype].placestring);
			}
			else
			{
				param_00 setmodel(level.turretsettings[param_00.turrettype].modelplacementfailed);
				self forceusehinton(level.turretsettings[param_00.turrettype].cannotplacestring);
			}
		}

		var_01 = param_00.canbeplaced;
		wait 0.05;
	}
}

//Function Number: 16
func_3183(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("death");
	if(self.canbeplaced)
	{
		func_317F();
		return;
	}

	self delete();
}

//Function Number: 17
turret_oncarrierdisconnect(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 18
turret_oncarrierchangedteam(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self delete();
}

//Function Number: 19
turret_ongameended(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	self delete();
}

//Function Number: 20
createturretforplayer(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_01.origin,level.turretsettings[param_00].weaponinfo);
	var_02.angles = param_01.angles;
	var_02 setmodel(level.turretsettings[param_00].modelbase);
	var_02.owner = param_01;
	var_02.health = level.turretsettings[param_00].health;
	var_02.maxhealth = level.turretsettings[param_00].maxhealth;
	var_02.damagetaken = 0;
	var_02.turrettype = param_00;
	var_02.stunned = 0;
	var_02.stunnedtime = 5;
	var_02 setturretmodechangewait(1);
	var_02 turret_setinactive();
	var_02 setsentryowner(param_01);
	var_02 setturretminimapvisible(1,param_00);
	var_02 setdefaultdroppitch(-89);
	var_02 thread func_3196();
	param_01 setplayerdata("remoteTurretDamageFade",1);
	param_01 setplayerdata("remoteTurretDamaged",0);
	param_01 setplayerdata("remoteTurretDamageState",0);
	var_02.damagefade = 1;
	var_02 thread func_319B();
	var_02 thread turret_watchlowhealth();
	return var_02;
}

//Function Number: 21
func_318B()
{
	self endon("death");
	self.owner endon("disconnect");
	self setdefaultdroppitch(0);
	self makeunusable();
	self maketurretsolid();
	if(!isdefined(self.owner))
	{
		return;
	}

	var_00 = self.owner;
	if(isdefined(var_00.remoteturretlist))
	{
		foreach(var_02 in var_00.remoteturretlist)
		{
			var_02 notify("death");
		}
	}

	var_00.remoteturretlist = [];
	var_00.remoteturretlist[0] = self;
	var_00.using_remote_turret = 0;
	var_00.pickup_message_deleted = 0;
	var_00.enter_message_deleted = 1;
	if(isalive(var_00))
	{
		var_00 maps\mp\_utility::setlowermessage("pickup_remote_turret",level.turretsettings[self.turrettype].hintpickup,undefined,undefined,undefined,undefined,undefined,undefined,1);
	}

	var_00 thread func_3190(self);
	if(level.teambased)
	{
		self.team = var_00.team;
		self setturretteam(var_00.team);
		maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,65));
	}
	else
	{
		maps\mp\_entityheadicons::setplayerheadicon(self.owner,(0,0,65));
	}

	self.ownertrigger = spawn("trigger_radius",self.origin + (0,0,1),0,32,64);
	var_00 thread turret_handlepickup(self);
	thread func_3191();
	thread turret_handledeath();
	thread func_319A();
	thread func_3197();
	thread func_3193();
}

//Function Number: 22
startusingremoteturret()
{
	var_00 = self.owner;
	var_00 maps\mp\_utility::setusingremote(self.turrettype);
	var_00 maps\mp\_utility::freezecontrolswrapper(1);
	var_01 = var_00 maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(var_01 != "success")
	{
		if(var_01 != "disconnect")
		{
			var_00 maps\mp\_utility::clearusingremote();
		}

		return 0;
	}

	var_00 maps\mp\_utility::_giveweapon(level.turretsettings[self.turrettype].remoteinfo);
	var_00 switchtoweaponimmediate(level.turretsettings[self.turrettype].remoteinfo);
	var_00 maps\mp\_utility::freezecontrolswrapper(0);
	var_00 thread waitsetthermal(1,self);
	if(isdefined(level.huditem["thermal_mode"]))
	{
		level.huditem["thermal_mode"] settext("");
	}

	if(getdvarint("camera_thirdPerson"))
	{
		var_00 maps\mp\_utility::setthirdpersondof(0);
	}

	var_00 playerlinkweaponviewtodelta(self,"tag_player",0,180,180,50,25,0);
	var_00 playerlinkedsetviewznear(0);
	var_00 playerlinkedsetusebaseangleforviewclamp(1);
	var_00 remotecontrolturret(self);
	var_00 maps\mp\_utility::clearlowermessage("enter_remote_turret");
	var_00 maps\mp\_utility::clearlowermessage("pickup_remote_turret");
	var_00 maps\mp\_utility::setlowermessage("early_exit",level.turretsettings[self.turrettype].hintexit,undefined,undefined,undefined,undefined,undefined,undefined,1);
	if(var_00 maps\mp\_utility::isjuggernaut())
	{
		var_00.juggernautoverlay.alpha = 0;
	}
}

//Function Number: 23
waitsetthermal(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("death");
	wait param_00;
	self visionsetthermalforplayer(game["thermal_vision"],1.5);
	self thermalvisionon();
	self thermalvisionfofoverlayon();
}

//Function Number: 24
stopusingremoteturret()
{
	var_00 = self.owner;
	if(var_00 maps\mp\_utility::isusingremote())
	{
		var_00 thermalvisionoff();
		var_00 thermalvisionfofoverlayoff();
		var_00 remotecontrolturretoff(self);
		var_00 unlink();
		var_00 switchtoweapon(var_00 common_scripts\utility::getlastweapon());
		var_00 maps\mp\_utility::clearusingremote();
		if(getdvarint("camera_thirdPerson"))
		{
			var_00 maps\mp\_utility::setthirdpersondof(1);
		}

		var_00 visionsetthermalforplayer(game["thermal_vision"],0);
		var_01 = maps\mp\killstreaks\_killstreaks::func_2C01(level.turretsettings[self.turrettype].streakname);
		var_00 maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe(var_01);
	}

	if(self.stunned)
	{
		var_00 stopshellshock();
	}

	var_00 maps\mp\_utility::clearlowermessage("early_exit");
	if(!isdefined(var_00.using_remote_turret_when_died) || !var_00.using_remote_turret_when_died)
	{
		var_00 maps\mp\_utility::setlowermessage("enter_remote_turret",level.turretsettings[self.turrettype].hintenter,undefined,undefined,undefined,1,0.25,1.5,1);
	}

	if(var_00 maps\mp\_utility::isjuggernaut())
	{
		var_00.juggernautoverlay.alpha = 1;
	}

	self notify("exit");
}

//Function Number: 25
func_3190(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	self.using_remote_turret_when_died = 0;
	for(;;)
	{
		if(isalive(self))
		{
			self waittill("death");
		}

		maps\mp\_utility::clearlowermessage("enter_remote_turret");
		maps\mp\_utility::clearlowermessage("pickup_remote_turret");
		if(self.using_remote_turret)
		{
			self.using_remote_turret_when_died = 1;
		}
		else
		{
			self.using_remote_turret_when_died = 0;
		}

		self waittill("spawned_player");
		if(!self.using_remote_turret_when_died)
		{
			maps\mp\_utility::setlowermessage("enter_remote_turret",level.turretsettings[param_00.turrettype].hintenter,undefined,undefined,undefined,1,0.25,1.5,1);
			continue;
		}

		param_00 notify("death");
	}
}

//Function Number: 26
func_3191()
{
	self endon("death");
	self endon("carried");
	level endon("game_ended");
	var_00 = self.owner;
	for(;;)
	{
		var_01 = var_00 getcurrentweapon();
		if(maps\mp\_utility::func_2829(var_01) && var_01 != level.turretsettings[self.turrettype].weaponinfo && var_01 != level.turretsettings[self.turrettype].laptopinfo && var_01 != level.turretsettings[self.turrettype].remoteinfo && var_01 != "none" && !var_00 maps\mp\_utility::isjuggernaut() || var_00 maps\mp\_utility::isusingremote())
		{
			if(!isdefined(var_00.enter_message_deleted) || !var_00.enter_message_deleted)
			{
				var_00.enter_message_deleted = 1;
				var_00 maps\mp\_utility::clearlowermessage("enter_remote_turret");
			}

			wait 0.05;
			continue;
		}

		if(var_00 istouching(self.ownertrigger))
		{
			if(!isdefined(var_00.enter_message_deleted) || !var_00.enter_message_deleted)
			{
				var_00.enter_message_deleted = 1;
				var_00 maps\mp\_utility::clearlowermessage("enter_remote_turret");
			}

			wait 0.05;
			continue;
		}

		if(isdefined(var_00.empgrenaded) && var_00.empgrenaded)
		{
			if(!isdefined(var_00.enter_message_deleted) || !var_00.enter_message_deleted)
			{
				var_00.enter_message_deleted = 1;
				var_00 maps\mp\_utility::clearlowermessage("enter_remote_turret");
			}

			wait 0.05;
			continue;
		}

		if(isdefined(var_00.enter_message_deleted) && var_00.enter_message_deleted && var_01 != "none")
		{
			var_00 maps\mp\_utility::setlowermessage("enter_remote_turret",level.turretsettings[self.turrettype].hintenter,undefined,undefined,undefined,1,0.25,1.5,1);
			var_00.enter_message_deleted = 0;
		}

		var_02 = 0;
		while(var_00 usebuttonpressed() && !var_00 fragbuttonpressed() && !isdefined(var_00.throwinggrenade) && !var_00 secondaryoffhandbuttonpressed() && !var_00 isusingturret() && var_00 isonground() && !var_00 istouching(self.ownertrigger) && !isdefined(var_00.empgrenaded) || !var_00.empgrenaded)
		{
			if(isdefined(var_00.iscarrying) && var_00.iscarrying)
			{
				break;
			}

			if(isdefined(var_00.iscapturingcrate) && var_00.iscapturingcrate)
			{
				break;
			}

			if(!isalive(var_00))
			{
				break;
			}

			if(!var_00.using_remote_turret && var_00 maps\mp\_utility::isusingremote())
			{
				break;
			}

			var_02 = var_02 + 0.05;
			if(var_02 > 0.75)
			{
				var_00.using_remote_turret = !var_00.using_remote_turret;
				if(var_00.using_remote_turret)
				{
					var_00 func_2DF6();
					var_00 takekillstreakweapons(self.turrettype);
					var_00 maps\mp\_utility::_giveweapon(level.turretsettings[self.turrettype].laptopinfo);
					var_00 switchtoweaponimmediate(level.turretsettings[self.turrettype].laptopinfo);
					startusingremoteturret();
					var_00 func_2DFA();
				}
				else
				{
					var_00 takekillstreakweapons(self.turrettype);
					stopusingremoteturret();
				}

				wait 2;
				break;
			}

			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 27
turret_handlepickup(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	if(!isdefined(param_00.ownertrigger))
	{
		return;
	}

	if(isdefined(self.pers["isBot"]) && self.pers["isBot"])
	{
		return;
	}

	var_01 = 0;
	for(;;)
	{
		var_02 = self getcurrentweapon();
		if(maps\mp\_utility::func_2829(var_02) && var_02 != "killstreak_remote_turret_mp" && var_02 != level.turretsettings[param_00.turrettype].weaponinfo && var_02 != level.turretsettings[param_00.turrettype].laptopinfo && var_02 != level.turretsettings[param_00.turrettype].remoteinfo && var_02 != "none" && !maps\mp\_utility::isjuggernaut() || maps\mp\_utility::isusingremote())
		{
			if(!isdefined(self.pickup_message_deleted) || !self.pickup_message_deleted)
			{
				self.pickup_message_deleted = 1;
				maps\mp\_utility::clearlowermessage("pickup_remote_turret");
			}

			wait 0.05;
			continue;
		}

		if(!self istouching(param_00.ownertrigger))
		{
			if(!isdefined(self.pickup_message_deleted) || !self.pickup_message_deleted)
			{
				self.pickup_message_deleted = 1;
				maps\mp\_utility::clearlowermessage("pickup_remote_turret");
			}

			wait 0.05;
			continue;
		}

		if(maps\mp\_utility::isreallyalive(self) && self istouching(param_00.ownertrigger) && !isdefined(param_00.carriedby) && self isonground())
		{
			if(isdefined(self.pickup_message_deleted) && self.pickup_message_deleted && var_02 != "none")
			{
				maps\mp\_utility::setlowermessage("pickup_remote_turret",level.turretsettings[param_00.turrettype].hintpickup,undefined,undefined,undefined,undefined,undefined,undefined,1);
				self.pickup_message_deleted = 0;
			}

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
					wait 0.05;
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				var_01 = 0;
				while(!self usebuttonpressed() && var_01 < 0.5)
				{
					var_01 = var_01 + 0.05;
					wait 0.05;
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

				param_00 setmode(level.turretsettings[param_00.turrettype].sentrymodeoff);
				thread setcarryingturret(param_00,0);
				param_00.ownertrigger delete();
				self.remoteturretlist = undefined;
				maps\mp\_utility::clearlowermessage("pickup_remote_turret");
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 28
func_3193()
{
	self endon("death");
	self endon("carried");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_539("antenna_light_mp"),self,"tag_fx");
		wait 1;
		stopfxontag(common_scripts\utility::func_539("antenna_light_mp"),self,"tag_fx");
	}
}

//Function Number: 29
turret_setinactive()
{
	self setmode(level.turretsettings[self.turrettype].sentrymodeoff);
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
	if(isdefined(var_00.using_remote_turret) && var_00.using_remote_turret)
	{
		var_00 thermalvisionoff();
		var_00 thermalvisionfofoverlayoff();
		var_00 remotecontrolturretoff(self);
		var_00 unlink();
		var_00 switchtoweapon(var_00 common_scripts\utility::getlastweapon());
		var_00 maps\mp\_utility::clearusingremote();
		if(getdvarint("camera_thirdPerson"))
		{
			var_00 maps\mp\_utility::setthirdpersondof(1);
		}

		var_00 maps\mp\killstreaks\_killstreaks::func_3195();
		var_00 visionsetthermalforplayer(game["thermal_vision"],0);
		if(isdefined(var_00.disabledusability) && var_00.disabledusability)
		{
			var_00 common_scripts\utility::_enableusability();
		}

		var_00 takekillstreakweapons(self.turrettype);
		if(var_00 maps\mp\_utility::isjuggernaut())
		{
			var_00.juggernautoverlay.alpha = 1;
		}
	}
}

//Function Number: 30
func_3196()
{
	self endon("death");
	level endon("game_ended");
	self notify("turret_handleOwner");
	self endon("turret_handleOwner");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 31
func_3197()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.turretsettings[self.turrettype].timeout;
	while(var_00)
	{
		wait 1;
		maps\mp\gametypes\_hostmigration::func_273E();
		if(!isdefined(self.carriedby))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	if(isdefined(self.owner))
	{
		self.owner thread maps\mp\_utility::func_2A60("sentry_gone");
	}

	self notify("death");
}

//Function Number: 32
turret_handledeath()
{
	self endon("carried");
	var_00 = self getentitynumber();
	maps\mp\killstreaks\_autosentry::func_2E1D(var_00);
	self waittill("death");
	maps\mp\killstreaks\_autosentry::removefromturretlist(var_00);
	if(!isdefined(self))
	{
		return;
	}

	self setmodel(level.turretsettings[self.turrettype].modeldestroyed);
	turret_setinactive();
	self setdefaultdroppitch(40);
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	if(isdefined(self.ownertrigger))
	{
		self.ownertrigger delete();
	}

	var_01 = self.owner;
	if(isdefined(var_01))
	{
		var_01.using_remote_turret = 0;
		var_01 maps\mp\_utility::clearlowermessage("enter_remote_turret");
		var_01 maps\mp\_utility::clearlowermessage("early_exit");
		var_01 maps\mp\_utility::clearlowermessage("pickup_remote_turret");
		var_01 setplayerdata("remoteTurretDamageState",0);
		var_01 func_2DFB();
		var_01 func_2DFA();
		if(var_01 getcurrentweapon() == "none")
		{
			var_01 switchtoweapon(var_01 common_scripts\utility::getlastweapon());
		}

		if(self.stunned)
		{
			var_01 stopshellshock();
		}
	}

	self playsound("sentry_explode");
	playfxontag(common_scripts\utility::func_539("sentry_explode_mp"),self,"tag_aim");
	wait 1.5;
	self playsound("sentry_explode_smoke");
	var_02 = 8;
	while(var_02 > 0)
	{
		playfxontag(common_scripts\utility::func_539("sentry_smoke_mp"),self,"tag_aim");
		wait 0.4;
		var_02 = var_02 - 0.4;
	}

	self notify("deleting");
	if(isdefined(self.target_ent))
	{
		self.target_ent delete();
	}

	self delete();
}

//Function Number: 33
func_319A()
{
	self endon("death");
	self endon("carried");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::func_27A1(self.owner,var_01))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
					if(var_04 == "MOD_GRENADE_SPLASH" && self.owner.using_remote_turret)
					{
						self.stunned = 1;
						thread turret_stun();
					}
		
					break;
	
				case "smoke_grenade_mp":
					break;
			}
		}

		if(!isdefined(self))
		{
			return;
		}

		if(var_04 == "MOD_MELEE")
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		if(isdefined(var_08) && var_08 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		self.damagefade = 0;
		self.owner setplayerdata("remoteTurretDamaged",1);
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_turret");
			if(var_01 maps\mp\_utility::func_27AF("specialty_armorpiercing"))
			{
				var_0A = var_00 * level.armorpiercingmod;
			}
		}

		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			var_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_turret");
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "remote_mortar_missile_mp":
				case "javelin_mp":
				case "stinger_mp":
				case "remotemissile_projectile_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
					self.largeprojectiledamage = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "stealth_bomb_mp":
				case "artillery_mp":
					self.largeprojectiledamage = 0;
					var_0A = var_0A + var_00 * 4;
					break;
	
				case "emp_grenade_mp":
				case "bomb_site_mp":
					self.largeprojectiledamage = 0;
					var_0A = self.maxhealth + 1;
					break;
			}

			maps\mp\killstreaks\_killstreaks::killstreakhit(var_01,var_09,self);
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				var_01 thread maps\mp\gametypes\_rank::func_2AB3("kill",100,var_09,var_04);
				var_01 notify("destroyed_killstreak");
			}

			if(isdefined(self.owner))
			{
				self.owner thread maps\mp\_utility::func_2A60(level.turretsettings[self.turrettype].vodestroyed);
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 34
func_319B()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(self.damagefade < 1)
		{
			self.owner setplayerdata("remoteTurretDamageFade",self.damagefade);
			self.damagefade = self.damagefade + 0.1;
			var_00 = 1;
		}
		else if(var_00)
		{
			self.damagefade = 1;
			self.owner setplayerdata("remoteTurretDamageFade",self.damagefade);
			self.owner setplayerdata("remoteTurretDamaged",0);
			var_00 = 0;
		}

		wait 0.1;
	}
}

//Function Number: 35
turret_watchlowhealth()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0.1;
	var_01 = 1;
	var_02 = 1;
	for(;;)
	{
		if(var_02)
		{
			if(self.damagetaken > 0)
			{
				var_02 = 0;
				self.owner setplayerdata("remoteTurretDamageState",var_01);
				var_01++;
			}
		}
		else if(self.damagetaken >= self.maxhealth * var_00 * var_01)
		{
			self.owner setplayerdata("remoteTurretDamageState",var_01);
			var_01++;
		}

		wait 0.05;
	}
}

//Function Number: 36
turret_stun()
{
	self notify("stunned");
	self endon("stunned");
	self endon("death");
	while(self.stunned)
	{
		self.owner shellshock("concussion_grenade_mp",self.stunnedtime);
		playfxontag(common_scripts\utility::func_539("sentry_explode_mp"),self,"tag_origin");
		var_00 = 0;
		while(var_00 < self.stunnedtime)
		{
			var_00 = var_00 + 0.05;
			wait 0.05;
		}

		self.stunned = 0;
	}
}