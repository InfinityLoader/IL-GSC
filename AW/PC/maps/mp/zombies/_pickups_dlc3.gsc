/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_pickups_dlc3.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 368 ms
 * Timestamp: 4/22/2024 2:13:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["pickup_inf_ammo"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_inf_ammo");
	level._effect["pickup_overcharge"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_overcharge");
	level._effect["dlc_orbiter"] = loadfx("vfx/gameplay/mp/zombie/dlc_orbiter");
	level._effect["dlc3_orbiter_screen"] = loadfx("vfx/ui/dlc/dlc3_orbiter_screen");
	level.pickup["unlimited_ammo"]["func"] = ::unlimitedammopickup;
	level.pickup["unlimited_ammo"]["fx"] = "pickup_inf_ammo";
	level.pickup["explosive_touch"]["func"] = ::explosivetouchpickup;
	level.pickup["explosive_touch"]["fx"] = "pickup_overcharge";
	level.pickup["insta_kill"] = undefined;
	maps\mp\gametypes\zombies::randomizepickuplist();
	maps\mp\_utility::gameflaginit("explosive_touch",0);
	maps\mp\_utility::gameflaginit("unlimited_ammo",0);
}

//Function Number: 2
canspawnpickup(param_00,param_01,param_02,param_03)
{
	if(maps\mp\_utility::gameflag("explosive_touch"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
unlimitedammopickup(param_00)
{
	showteamsplashzombies("zombie_infinite_ammo");
	param_00 playlocalsound("powerup_overcharge_start");
	level thread activateunlimitedammo();
	maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("open_fire",param_00);
	level thread maps\mp\gametypes\zombies::removepickup(self);
}

//Function Number: 4
activateunlimitedammo()
{
	level notify("unlimited_ammo_start");
	level endon("unlimited_ammo_start");
	level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration("ui_zm_infinite_ammo",gettime() + 20000);
	maps\mp\_utility::gameflagset("unlimited_ammo");
	setupammoforplayers();
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("zm_unlimited_ammo",1);
	}

	level thread onplayerspawnedunlimitedammo();
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(20);
	maps\mp\_utility::gameflagclear("unlimited_ammo");
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("zm_unlimited_ammo",0);
		var_01 playlocalsound("powerup_overcharge_end");
	}

	level notify("unlimited_ammo_end");
}

//Function Number: 5
onplayerspawnedunlimitedammo()
{
	level endon("unlimited_ammo_start");
	level endon("unlimited_ammo_end");
	while(maps\mp\_utility::gameflag("unlimited_ammo"))
	{
		level waittill("player_spawned",var_00);
		var_00 setclientomnvar("zm_unlimited_ammo",1);
	}
}

//Function Number: 6
setupammoforplayers()
{
	foreach(var_01 in level.players)
	{
		if(isalive(var_01))
		{
			var_01 thread playergiveoneinclip();
		}
	}
}

//Function Number: 7
playergiveoneinclip()
{
	self endon("death");
	self endon("disconnect");
	var_00 = self getweaponslistprimaries();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(issubstr(var_03,"em1"))
		{
			waittillframeend;
			var_04 = maps\mp\zombies\_util::playergetem1ammo();
			if(var_04 == 0)
			{
				maps\mp\zombies\_util::playerrecordem1ammo(1);
				maps\mp\zombies\_util::playerallowfire(1,"em1");
				var_01[var_01.size] = var_03;
			}

			continue;
		}

		var_05 = 0;
		var_04 = self getweaponammoclip(var_03,"right");
		if(var_04 == 0)
		{
			self setweaponammoclip(var_03,1,"right");
			var_01[var_01.size] = var_03;
			var_05 = 1;
		}

		if(issubstr(var_03,"akimbo"))
		{
			var_04 = self getweaponammoclip(var_03,"left");
			if(var_04 == 0)
			{
				self setweaponammoclip(var_03,1,"left");
				if(!var_05)
				{
					var_01[var_01.size] = var_03;
				}
			}
		}
	}

	if(var_01.size == 0)
	{
		return;
	}

	level waittill("unlimited_ammo_end");
	foreach(var_03 in var_01)
	{
		if(!self hasweapon(var_03))
		{
			continue;
		}

		if(issubstr(var_03,"em1"))
		{
			waittillframeend;
			var_04 = maps\mp\zombies\_util::playergetem1ammo();
			if(var_04 == 1)
			{
				maps\mp\zombies\_util::playerrecordem1ammo(0);
				var_08 = self getcurrentprimaryweapon();
				if(issubstr(var_08,"em1"))
				{
					maps\mp\zombies\_util::playerallowfire(0,"em1");
				}
			}

			continue;
		}

		var_04 = self getweaponammoclip(var_03,"right");
		if(var_04 == 1)
		{
			self setweaponammoclip(var_03,0,"right");
		}

		if(issubstr(var_03,"akimbo"))
		{
			var_04 = self getweaponammoclip(var_03,"left");
			if(var_04 == 1)
			{
				self setweaponammoclip(var_03,0,"left");
			}
		}
	}
}

//Function Number: 8
explosivetouchpickup(param_00)
{
	showteamsplashzombies("zombie_overcharge");
	param_00 playlocalsound("zmb_pickup_general");
	level thread activateexplosivetouch();
	maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("ex_touch",param_00);
	level thread maps\mp\gametypes\zombies::removepickup(self);
}

//Function Number: 9
activateexplosivetouch()
{
	level notify("explosive_touch_start");
	level endon("explosive_touch_start");
	level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration("ui_zm_overcharge",gettime() + 20000);
	level thread cleanupgodmode();
	maps\mp\_utility::gameflagset("explosive_touch");
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.crategodmode))
		{
			var_01.crategodmode = 0;
		}

		var_01.crategodmode++;
		var_01 thread playerdoexplosivetouch();
		var_01 playlocalsound("powerup_explosive_touch");
	}

	if(!isdefined(level.zmbexplosivetouchfp))
	{
		level.zmbexplosivetouchfp = spawnfx(common_scripts\utility::getfx("dlc3_orbiter_screen"),(0,0,0));
		triggerfx(level.zmbexplosivetouchfp);
	}

	explosivetouchwait();
	if(isdefined(level.zmbexplosivetouchfp))
	{
		level.zmbexplosivetouchfp delete();
	}

	level notify("explosive_touch_complete");
	maps\mp\_utility::gameflagclear("explosive_touch");
}

//Function Number: 10
explosivetouchwait()
{
	level endon("game_ended");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(20);
}

//Function Number: 11
cleanupgodmode()
{
	wait 0.05;
	level common_scripts\utility::waittill_any("explosive_touch_start","explosive_touch_complete");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.crategodmode))
		{
			var_01.crategodmode--;
		}
	}
}

//Function Number: 12
playerplayexplosivetoucheffect()
{
	level endon("explosive_touch_start");
	self endon("disconnect");
	if(!isdefined(self.explosivetouchent))
	{
		thread playerthirdpersonexplosivetoucheffects();
		thread playerhandleeffectsdeath();
		thread playerhandleeffectshostmigration();
		thread playerhandleeffectsdisconnect();
	}

	level waittill("explosive_touch_complete");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),self.explosivetouchent,"j_prop_1");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),self.explosivetouchent,"j_prop_2");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),self.explosivetouchent,"j_prop_3");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),self.explosivetouchent,"j_prop_4");
	self.explosivetouchent thread delaydeleteent(1);
	self.explosivetouchent = undefined;
}

//Function Number: 13
playerthirdpersonexplosivetoucheffects()
{
	self endon("disconnect");
	if(!isdefined(self.explosivetouchent))
	{
		self.explosivetouchent = spawn("script_model",(0,0,0));
		self.explosivetouchent setmodel("genericprop_x5");
		wait 0.05;
		self.explosivetouchent vehicle_jetbikesethoverforcescale(self,"tag_origin",(0,0,0),(0,0,0));
		wait 0.05;
		self.explosivetouchent scriptmodelplayanim("dlc3_explosive_touch_prop_anim","explosive_touch");
		self.explosivetouchent deleteonhostmigration();
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),self.explosivetouchent,"j_prop_1");
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),self.explosivetouchent,"j_prop_2");
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),self.explosivetouchent,"j_prop_3");
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),self.explosivetouchent,"j_prop_4");
	}
}

//Function Number: 14
playerhandleeffectsdisconnect()
{
	level endon("explosive_touch_complete");
	var_00 = self.explosivetouchent;
	self waittill("disconnect");
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 endon("death");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),var_00,"j_prop_1");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),var_00,"j_prop_2");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),var_00,"j_prop_3");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"),var_00,"j_prop_4");
	var_00 thread delaydeleteent(1);
}

//Function Number: 15
playerhandleeffectshostmigration()
{
	level endon("explosive_touch_complete");
	self endon("disconnect");
	for(;;)
	{
		level waittill("host_migration_end");
		thread playerthirdpersonexplosivetoucheffects();
	}
}

//Function Number: 16
delaydeleteent(param_00)
{
	self endon("death");
	wait(param_00);
	self delete();
}

//Function Number: 17
playerhandleeffectsdeath()
{
	level endon("explosive_touch_complete");
	self endon("disconnect");
	self waittill("death");
	self.explosivetouchent hide();
	updatefirstpersonfx();
	self waittill("spawned_player");
	self.explosivetouchent show();
	self.explosivetouchent vehicle_jetbikesethoverforcescale(self,"tag_origin",(0,0,0),(0,0,0));
	updatefirstpersonfx();
}

//Function Number: 18
updatefirstpersonfx()
{
	if(!isdefined(level.zmbexplosivetouchfp))
	{
		return;
	}

	level.zmbexplosivetouchfp hide();
	foreach(var_01 in level.players)
	{
		if(isalive(var_01))
		{
			level.zmbexplosivetouchfp showtoplayer(var_01);
		}
	}
}

//Function Number: 19
playerdoexplosivetouch()
{
	self endon("disconnect");
	level endon("explosive_touch_start");
	level endon("explosive_touch_complete");
	var_00 = 3600;
	self.overchargekills = 0;
	thread playerplayexplosivetoucheffect();
	for(;;)
	{
		if(!isalive(self))
		{
			wait 0.05;
			continue;
		}

		var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
		foreach(var_03 in var_01)
		{
			if(var_03.team != level.enemyteam)
			{
				continue;
			}

			if(!isalive(var_03))
			{
				continue;
			}

			if(var_03 maps\mp\zombies\_util::instakillimmune())
			{
				continue;
			}

			var_04 = distancesquared(self.origin,var_03.origin);
			if(var_04 < var_00)
			{
				var_03 dodamage(var_03.health,var_03.origin,self,undefined,"MOD_EXPLOSIVE","explosive_touch_zombies_mp","torso_upper");
				earthquake(randomfloatrange(0.35,0.55),1,self.origin,200,self);
				self playrumbleonentity("damage_heavy");
				self method_8569();
				self.overchargekills++;
				if(self.overchargekills == 20)
				{
					maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_OVERCHARGE");
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 20
gettimedpickupstring(param_00,param_01,param_02)
{
	var_03 = 20;
	var_04 = level.pickuphuds[param_02];
	if(!isdefined(var_04))
	{
		var_04 = maps\mp\gametypes\_hud_util::createserverfontstring("hudbig",1);
		var_04 maps\mp\gametypes\_hud_util::setpoint("BOTTOM",undefined,0,-70 - var_03 * level.pickuphuds.size);
		var_04.label = param_00;
		foreach(var_06 in level.pickuphuds)
		{
			var_04 thread updatetimedpickuphudpos(var_06,var_03);
		}

		level.pickuphuds[param_02] = var_04;
	}

	var_04.color = (1,1,1);
	var_04 settimer(param_01);
	return var_04;
}

//Function Number: 21
updatetimedpickuphudpos(param_00,param_01)
{
	self endon("death");
	param_00 waittill("death");
	self.y = self.y + param_01;
}

//Function Number: 22
timedpickuphud(param_00,param_01,param_02)
{
	level notify("pickupHud_" + param_02);
	level endon("pickupHud_" + param_02);
	if(!isdefined(level.pickuphuds))
	{
		level.pickuphuds = [];
	}

	var_03 = 3;
	var_04 = gettimedpickupstring(param_00,param_01,param_02);
	if(param_01 > var_03)
	{
		wait(param_01 - var_03);
	}

	var_04.color = (1,0,0);
	wait(var_03);
	var_04 destroy();
	level.pickuphuds[param_02] = undefined;
}

//Function Number: 23
showteamsplashzombies(param_00)
{
	foreach(var_02 in level.players)
	{
		if(maps\mp\zombies\_util::isonhumanteam(var_02) && maps\mp\_utility::isreallyalive(var_02))
		{
			var_02 thread maps\mp\gametypes\_hud_message::splashnotify(param_00);
		}
	}
}