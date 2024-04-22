/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_prison.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 378 ms
 * Timestamp: 4/22/2024 2:12:41 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.mp_prison_killstreak_duration = 25;
	precachelocationselector("map_artillery_selector");
	precachestring(&"KILLSTREAKS_MP_PRISON");
	precacheitem("prison_turret_mp");
	precachelaser("prison_laser");
	level.mp_prison_inuse = 0;
	level.prison_turrets_alive = 0;
	level.prison_turret_alarm_sfx = "mp_prison_ks_alarm";
	level.prison_turret_burn_sfx = "orbital_laser";
	level.prison_turret_warning_light_friendly = loadfx("vfx/lights/light_tracking_prison_blink_friendly");
	level.prison_turret_warning_light_enemy = loadfx("vfx/lights/light_tracking_prison_blink_enemy");
	level.prison_turret_laser_glow = loadfx("vfx/lights/prison_tracking_laser_blue");
	level.killstreakfuncs["mp_prison"] = ::tryusempprison;
	level.mapkillstreak = "mp_prison";
	if(!isdefined(level.sentrysettings))
	{
		level.sentrysettings = [];
	}

	level.sentrysettings["prison_turret"] = spawnstruct();
	level.sentrysettings["prison_turret"].health = 999999;
	level.sentrysettings["prison_turret"].maxhealth = 1000;
	level.sentrysettings["prison_turret"].burstmin = 20;
	level.sentrysettings["prison_turret"].burstmax = 120;
	level.sentrysettings["prison_turret"].pausemin = 0.15;
	level.sentrysettings["prison_turret"].pausemax = 0.35;
	level.sentrysettings["prison_turret"].sentrymodeon = "sentry";
	level.sentrysettings["prison_turret"].sentrymodeoff = "sentry_offline";
	level.sentrysettings["prison_turret"].timeout = 90;
	level.sentrysettings["prison_turret"].spinuptime = 0.05;
	level.sentrysettings["prison_turret"].overheattime = 8;
	level.sentrysettings["prison_turret"].cooldowntime = 0.1;
	level.sentrysettings["prison_turret"].fxtime = 0.3;
	level.sentrysettings["prison_turret"].streakname = "sentry";
	level.sentrysettings["prison_turret"].weaponinfo = "prison_turret_mp";
	level.sentrysettings["prison_turret"].modelbase = "prison_security_laser";
	level.sentrysettings["prison_turret"].modelplacement = "sentry_minigun_weak_obj";
	level.sentrysettings["prison_turret"].modelplacementfailed = "sentry_minigun_weak_obj_red";
	level.sentrysettings["prison_turret"].modeldestroyed = "sentry_minigun_weak_destroyed";
	level.sentrysettings["prison_turret"].hintstring = &"MP_PRISON_SENSOR_PICKUP";
	level.sentrysettings["prison_turret"].headicon = 1;
	level.sentrysettings["prison_turret"].teamsplash = "used_sentry";
	level.sentrysettings["prison_turret"].shouldsplash = 0;
	level.sentrysettings["prison_turret"].vodestroyed = "sentry_destroyed";
	level.mapkillstreakpickupstring = level.sentrysettings["prison_turret"].hintstring;
	level thread onprisonplayerconnect();
	level.prison_turrets = setupprisonturrets();
}

//Function Number: 2
tryusempprison(param_00,param_01)
{
	if(level.mp_prison_inuse)
	{
		self iprintlnbold(&"MP_PRISON_IN_USE");
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(maps\mp\_utility::isairdenied())
	{
		return 0;
	}

	if(maps\mp\_utility::isemped())
	{
		return 0;
	}

	var_02 = setprisonturretplayer(self);
	if(isdefined(var_02) && var_02)
	{
		maps\mp\_matchdata::logkillstreakevent("mp_prison",self.origin);
	}

	return var_02;
}

//Function Number: 3
setupprisonturrets()
{
	var_00 = getentarray("prison_turret","targetname");
	var_01 = "prison_turret";
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_00[var_02].spawned_turret = spawnturret("misc_turret",var_00[var_02].origin,level.sentrysettings[var_01].weaponinfo,0);
		var_00[var_02].spawned_turret maketurretsolid();
		var_00[var_02].spawned_turret sentry_initsentry(var_01);
		var_00[var_02].spawned_turret.angles = var_00[var_02].angles;
		var_00[var_02].spawned_turret.alarm_on = 0;
		var_00[var_02].spawned_turret.burn_on = 0;
		var_00[var_02].spawned_turret.proxy_alarm_on = 0;
		var_00[var_02].spawned_turret.prison_turret_active = 0;
	}

	return var_00;
}

//Function Number: 4
sentry_initsentry(param_00)
{
	self.sentrytype = param_00;
	self.canbeplaced = 1;
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	self maketurretinoperable();
	self setdefaultdroppitch(0);
	self setturretmodechangewait(1);
	maps\mp\killstreaks\_autosentry::sentry_setinactive();
	thread maps\mp\killstreaks\_autosentry::sentry_handleuse();
}

//Function Number: 5
setprisonturretplayer(param_00)
{
	if(level.mp_prison_inuse)
	{
		return 0;
	}

	level.mp_prison_inuse = 1;
	for(var_01 = 0;var_01 < level.prison_turrets.size;var_01++)
	{
		level.prison_turrets_alive++;
		level.prison_turrets[var_01].spawned_turret sentry_setowner(param_00);
		level.prison_turrets[var_01].spawned_turret.shouldsplash = 0;
		level.prison_turrets[var_01].spawned_turret.carriedby = param_00;
		level.prison_turrets[var_01].spawned_turret sentry_setplaced();
		level.prison_turrets[var_01].spawned_turret setcandamage(1);
		level.prison_turrets[var_01].spawned_turret setcanradiusdamage(1);
		level.prison_turrets[var_01].spawned_turret thread sentry_handledamage();
		level.prison_turrets[var_01].spawned_turret thread sentry_handledeath();
		level.prison_turrets[var_01].spawned_turret.alarm_on = 0;
		level.prison_turrets[var_01].spawned_turret.burn_on = 0;
		level.prison_turrets[var_01].spawned_turret.proxy_alarm_on = 0;
		level.prison_turrets[var_01].spawned_turret.shocking_target = 0;
		level.prison_turrets[var_01].spawned_turret.prison_turret_active = 1;
		level.prison_turrets[var_01].spawned_turret.numnearbyplayers = 0;
		level.prison_turrets[var_01].spawned_turret thread prisonturretportableradar();
		level.prison_turrets[var_01].spawned_turret thread repeatoneshotprisonalarm();
		level.prison_turrets[var_01].spawned_turret thread aud_play_announcer_warning();
	}

	level thread prisonturrettimer();
	level thread monitorprisonkillstreakownership();
	level thread applyprisonturretradararrow();
	return 1;
}

//Function Number: 6
prisonturrettimer()
{
	level endon("game_ended");
	var_00 = level.mp_prison_killstreak_duration;
	while(var_00 > 0)
	{
		wait(1);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		var_00--;
		if(level.mp_prison_inuse == 0)
		{
			return;
		}
	}

	for(var_01 = 0;var_01 < level.prison_turrets.size;var_01++)
	{
		level.prison_turrets[var_01].spawned_turret notify("fake_prison_death");
	}
}

//Function Number: 7
sentry_setowner(param_00)
{
	self.owner = param_00;
	self setsentryowner(self.owner);
	if(level.teambased && isdefined(param_00))
	{
		self.team = self.owner.team;
		self setturretteam(self.team);
	}

	thread sentry_handleownerdisconnect();
}

//Function Number: 8
sentry_setplaced()
{
	self setsentrycarrier(undefined);
	self.carriedby forceusehintoff();
	self.carriedby = undefined;
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	sentry_setactive();
	self playsound("sentry_gun_plant");
	self notify("placed");
}

//Function Number: 9
sentry_handledamage()
{
	self endon("fake_prison_death");
	level endon("game_ended");
	self.health = level.sentrysettings[self.sentrytype].health;
	self.maxhealth = level.sentrysettings[self.sentrytype].maxhealth;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_01))
		{
			continue;
		}

		if(isdefined(var_08) && var_08 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		var_0A = 0;
		if(isdefined(var_09))
		{
			var_0B = maps\mp\_utility::strip_suffix(var_09,"_lefthand");
			switch(var_0B)
			{
				case "emp_grenade_var_mp":
				case "emp_grenade_mp":
					self.largeprojectiledamage = 0;
					var_0A = self.maxhealth + 1;
					if(isplayer(var_01))
					{
						var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("sentry");
					}
					break;
	
				default:
					if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
					{
						var_0A = var_00 * 3.5;
					}
					else
					{
						var_0A = 0;
					}
		
					if(isplayer(var_01))
					{
						var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("sentry");
					}
					break;
			}

			maps\mp\killstreaks\_killstreaks::killstreakhit(var_01,var_09,self);
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_01,var_00,var_04,var_09);
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				var_01 maps\mp\_utility::incplayerstat("map_killstreak_destroyed",1);
				level thread maps\mp\gametypes\_rank::awardgameevent("map_killstreak_destroyed",var_01,var_09,undefined,var_04);
			}

			if(isdefined(self.owner))
			{
				self.owner thread maps\mp\_utility::leaderdialogonplayer(level.sentrysettings[self.sentrytype].vodestroyed,undefined,undefined,self.origin);
			}

			self notify("fake_prison_death");
			return;
		}
	}
}

//Function Number: 10
sentry_handledeath()
{
	self waittill("fake_prison_death");
	if(!isdefined(self))
	{
		return;
	}

	maps\mp\killstreaks\_autosentry::sentry_setinactive();
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	if(level.sentrysettings[self.sentrytype].headicon)
	{
		if(level.teambased)
		{
			maps\mp\_entityheadicons::setteamheadicon("none",(0,0,0));
		}
		else
		{
			maps\mp\_entityheadicons::setplayerheadicon("none",(0,0,0));
		}
	}

	level.prison_turrets_alive--;
	self setcandamage(0);
	self setcanradiusdamage(0);
	if(self.alarm_on == 1)
	{
		self.alarm_on = 0;
	}

	if(self.burn_on == 1)
	{
		self.burn_on = 0;
	}

	if(isdefined(self.previous_turret_target))
	{
		self notify("lost_or_changed_target");
		self.previous_turret_target = undefined;
	}

	self.shocking_target = 0;
	self.turret_on_target = undefined;
	if(self.proxy_alarm_on == 1)
	{
		self.proxy_alarm_on = 0;
	}

	self.prison_turret_active = 0;
}

//Function Number: 11
sentry_setactive()
{
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
	if(level.sentrysettings[self.sentrytype].headicon)
	{
		if(level.teambased)
		{
			maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,25));
			return;
		}

		maps\mp\_entityheadicons::setplayerheadicon(self.owner,(0,0,25));
	}
}

//Function Number: 12
sentry_handleownerdisconnect()
{
	level endon("game_ended");
	self endon("fake_prison_death");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("fake_prison_death");
}

//Function Number: 13
monitorprisonkillstreakownership()
{
	level endon("game_ended");
	while(level.prison_turrets_alive > 0)
	{
		wait(0.05);
	}

	level.mp_prison_inuse = 0;
	for(var_00 = 0;var_00 < level.prison_turrets.size;var_00++)
	{
		if(level.prison_turrets[var_00].spawned_turret.proxy_alarm_on == 1)
		{
			level.prison_turrets[var_00].spawned_turret.proxy_alarm_on = 0;
		}

		for(var_01 = 0;var_01 < level.players.size;var_01++)
		{
			level.players[var_01].laser_tag_array[var_00] laseroff();
			stopfxontag(level.prison_turret_laser_glow,level.players[var_01].laser_tag_array[var_00],"tag_laser");
			level.players[var_01].laser_tag_array[var_00] clearlookattarget();
			level.players[var_01].laser_tag_array[var_00].laserfxactive = 0;
		}
	}

	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		level.players[var_02].numnearbyprisonturrets = 0;
		if(level.players[var_02] hasperk("specialty_radararrow",1))
		{
			level.players[var_02] unsetperk("specialty_radararrow",1);
		}

		level.players[var_02] notify("player_not_tracked");
		level.players[var_02].is_being_tracked = 0;
	}
}

//Function Number: 14
handleprisonturretlights()
{
	playfxontag(level.prison_turret_warning_light_friendly,self,"tag_fx");
	self waittill("fake_prison_death");
	stopfxontag(level.prison_turret_warning_light_friendly,self,"tag_fx");
}

//Function Number: 15
prisonturretportableradar()
{
	level endon("game_ended");
	self.portable_radar = spawn("script_model",self.origin);
	self.portable_radar.team = self.team;
	self.portable_radar makeportableradar(self.owner);
	self waittill("fake_prison_death");
	level maps\mp\gametypes\_portable_radar::deleteportableradar(self.portable_radar);
	self.portable_radar = undefined;
}

//Function Number: 16
applyprisonturretradararrow()
{
	level endon("game_ended");
	while(level.mp_prison_inuse)
	{
		if(isdefined(level.prison_turrets) && isdefined(level.players))
		{
			for(var_00 = 0;var_00 < level.prison_turrets.size;var_00++)
			{
				if(level.prison_turrets[var_00].spawned_turret.prison_turret_active != 1)
				{
					for(var_01 = 0;var_01 < level.players.size;var_01++)
					{
						if(level.players[var_01].laser_tag_array[var_00].laserfxactive == 1)
						{
							level.players[var_01].laser_tag_array[var_00] laseroff();
							level.players[var_01].laser_tag_array[var_00] clearlookattarget();
							level.players[var_01].laser_tag_array[var_00].laserfxactive = 0;
						}
					}

					continue;
				}

				level.prison_turrets[var_00].spawned_turret.numnearbyplayers = 0;
				for(var_01 = 0;var_01 < level.players.size;var_01++)
				{
					var_02 = 0;
					var_03 = 10;
					var_04 = (randomfloat(var_03),randomfloat(var_03),randomfloat(var_03)) - (5,5,5);
					if(level.players[var_01] getstance() == "stand")
					{
						var_05 = (0,0,50) + var_04;
					}
					else if(level.players[var_01] getstance() == "crouch")
					{
						var_05 = (0,0,35) + var_04;
					}
					else
					{
						var_05 = (0,0,10) + var_04;
					}

					if(isdefined(level.players[var_01]) && isalive(level.players[var_01]) && (level.teambased && level.players[var_01].team != level.prison_turrets[var_00].spawned_turret.team) || !level.teambased && level.players[var_01] != level.prison_turrets[var_00].spawned_turret.owner)
					{
						var_06 = distancesquared(level.players[var_01].origin,level.prison_turrets[var_00].spawned_turret.origin);
						if(var_06 < 3610000)
						{
							if(sighttracepassed(level.prison_turrets[var_00].spawned_turret.origin,level.players[var_01].origin + var_05,0,undefined))
							{
								var_02 = 1;
							}
						}
					}

					if(var_02)
					{
						if(level.players[var_01].laser_tag_array[var_00].laserfxactive == 0)
						{
							level.players[var_01].laser_tag_array[var_00].laserfxactive = 1;
							level.players[var_01].laser_tag_array[var_00] laseron("prison_laser");
							playfxontag(level.prison_turret_laser_glow,level.players[var_01].laser_tag_array[var_00],"tag_laser");
							level.players[var_01].laser_tag_array[var_00] setlookattarget(level.players[var_01],"bone","tag_eye","randomoffset");
						}

						level.players[var_01].numnearbyprisonturrets++;
						level.prison_turrets[var_00].spawned_turret.numnearbyplayers++;
						continue;
					}

					if(level.players[var_01].laser_tag_array[var_00].laserfxactive == 1)
					{
						level.players[var_01].laser_tag_array[var_00].laserfxactive = 0;
						level.players[var_01].laser_tag_array[var_00] laseroff();
						stopfxontag(level.prison_turret_laser_glow,level.players[var_01].laser_tag_array[var_00],"tag_laser");
						level.players[var_01].laser_tag_array[var_00] clearlookattarget();
					}
				}

				if(level.prison_turrets[var_00].spawned_turret.numnearbyplayers > 0)
				{
					if(level.prison_turrets[var_00].spawned_turret.proxy_alarm_on == 0)
					{
						level.prison_turrets[var_00].spawned_turret.proxy_alarm_on = 1;
					}

					continue;
				}

				if(level.prison_turrets[var_00].spawned_turret.proxy_alarm_on == 1)
				{
					level.prison_turrets[var_00].spawned_turret.proxy_alarm_on = 0;
				}
			}

			for(var_07 = 0;var_07 < level.players.size;var_07++)
			{
				if(level.players[var_07].numnearbyprisonturrets > 0)
				{
					level.players[var_07] setperk("specialty_radararrow",1,0);
					if(level.players[var_07].is_being_tracked == 0)
					{
						level.players[var_07].is_being_tracked = 1;
					}
				}
				else
				{
					if(level.players[var_07] hasperk("specialty_radararrow",1))
					{
						level.players[var_07] unsetperk("specialty_radararrow",1);
					}

					level.players[var_07] notify("player_not_tracked");
					level.players[var_07].is_being_tracked = 0;
				}

				level.players[var_07].numnearbyprisonturrets = 0;
			}
		}

		wait(0.1);
	}
}

//Function Number: 17
createlasertagarray()
{
	if(!isdefined(self.laser_tag_array))
	{
		self.laser_tag_array = [];
		for(var_00 = 0;var_00 < level.prison_turrets.size;var_00++)
		{
			var_01 = level.prison_turrets[var_00].spawned_turret.origin;
			self.laser_tag_array[var_00] = spawn("script_model",var_01);
			self.laser_tag_array[var_00] setmodel("tag_laser");
			self.laser_tag_array[var_00].laserfxactive = 0;
		}
	}
}

//Function Number: 18
deletelasertagarray()
{
	if(isdefined(self.laser_tag_array))
	{
		for(var_00 = 0;var_00 < level.prison_turrets.size;var_00++)
		{
			self.laser_tag_array[var_00] clearlookattarget();
			self.laser_tag_array[var_00] delete();
		}
	}
}

//Function Number: 19
onprisonplayerconnect()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.is_being_tracked = 0;
		var_00 createlasertagarray();
		var_00.numnearbyprisonturrets = 0;
		var_00 thread onprisonplayerdisconnect();
	}
}

//Function Number: 20
onprisonplayerdisconnect()
{
	level endon("game_ended");
	self waittill("disconnect");
	deletelasertagarray();
}

//Function Number: 21
createprisonturrettrackingoverlay()
{
	if(!isdefined(self.prisonturrettrackingoverlay))
	{
		self.prisonturrettrackingoverlay = newclienthudelem(self);
		self.prisonturrettrackingoverlay.x = -80;
		self.prisonturrettrackingoverlay.y = -60;
		self.prisonturrettrackingoverlay setshader("tracking_drone_targeted_overlay",800,600);
		self.prisonturrettrackingoverlay.alignx = "left";
		self.prisonturrettrackingoverlay.aligny = "top";
		self.prisonturrettrackingoverlay.horzalign = "fullscreen";
		self.prisonturrettrackingoverlay.vertalign = "fullscreen";
		self.prisonturrettrackingoverlay.alpha = 0;
	}
}

//Function Number: 22
fadeinoutprisontrackingoverlay()
{
	level endon("game_ended");
	self endon("player_not_tracked");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	for(;;)
	{
		if(isdefined(self.turrettrackingoverlay))
		{
			var_00 = randomfloatrange(0.25,1);
			self.prisonturrettrackingoverlay fadeovertime(0.1);
			self.prisonturrettrackingoverlay.color = (var_00,var_00,var_00);
			self.prisonturrettrackingoverlay.alpha = 1;
			wait(0.1);
		}

		wait(0.05);
	}
}

//Function Number: 23
endprisontrackingoverlay()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self.prisonturrettrackingoverlay fadeovertime(0.2);
	self.prisonturrettrackingoverlay.alpha = 0;
}

//Function Number: 24
repeatoneshotprisonalarm()
{
	self endon("fake_prison_death");
	while(level.mp_prison_inuse)
	{
		if(self.proxy_alarm_on == 1)
		{
			playsoundatpos(self.origin,level.prison_turret_alarm_sfx);
		}

		wait(4);
	}
}

//Function Number: 25
aud_play_announcer_warning()
{
	wait(2.5);
	playsoundatpos((0,0,0),"mp_prison_anouncer_ext");
}