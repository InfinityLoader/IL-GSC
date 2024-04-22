/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_laser2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 1007 ms
 * Timestamp: 4/22/2024 2:12:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	initlaserfx();
	initlasersound();
	initlaser();
	initlaserents();
	level.killstreakfuncs["mp_laser2"] = ::tryusemplaser;
	level.mapkillstreak = "mp_laser2";
	level.mapkillstreakpickupstring = &"MP_LASER2_MAP_KILLSTREAK_PICKUP";
	level.mapkillstreakdamagefeedbacksound = ::handledamagefeedbacksound;
	level.killstreak_laser_fxmode = 0;
	level.mapcustombotkillstreakfunc = ::setupbotsformapkillstreak;
}

//Function Number: 2
setupbotsformapkillstreak()
{
	level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_laser2",::maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

//Function Number: 3
initlaserfx()
{
	level.laser_fx["beahm"] = loadfx("vfx/muzzleflash/laser_wv_mp_laser");
	level.laser_fx["beahm_smoke"] = loadfx("vfx/muzzleflash/laser_wv_mp_laser_smoke");
	level.laser_fx["laser_field1"] = loadfx("vfx/map/mp_laser2/laser_core_lvl1");
	level.laser_fx["laser_field1_cheap"] = loadfx("vfx/map/mp_laser2/laser_core_lvl1_cheap");
	level.laser_fx["laser_field2"] = loadfx("vfx/map/mp_laser2/laser_core_lvl2");
	level.laser_fx["laser_field2_cheap"] = loadfx("vfx/map/mp_laser2/laser_core_lvl2_cheap");
	level.laser_fx["laser_field3"] = loadfx("vfx/map/mp_laser2/laser_core_lvl3");
	level.laser_fx["laser_field2_up"] = loadfx("vfx/map/mp_laser2/laser_core_up_lvl2");
	level.laser_fx["laser_field3_up"] = loadfx("vfx/map/mp_laser2/laser_core_up_lvl3");
	level.laser_fx["laser_field1_up_slow"] = loadfx("vfx/map/mp_laser2/laser_core_up_slow_lvl1");
	level.laser_fx["laser_field2_down"] = loadfx("vfx/map/mp_laser2/laser_core_down_lvl2");
	level.laser_fx["laser_field3_down"] = loadfx("vfx/map/mp_laser2/laser_core_down_lvl3");
	level.laser_fx["laser_field1_down_slow"] = loadfx("vfx/map/mp_laser2/laser_core_down_slow_lvl1");
	level.laser_fx["laser_charge1"] = loadfx("vfx/map/mp_laser2/laser_energy_fire_lvl1");
	level.laser_fx["laser_beam_done1"] = loadfx("vfx/map/mp_laser2/laser_energy_beam_done_lvl1");
	level.laser_fx["hatch_light"] = loadfx("vfx/lights/mp_laser2/light_lasercore_glow");
	level.laser_fx["hatch_light_close"] = loadfx("vfx/lights/mp_laser2/light_lasercore_glow_close");
	level.laser_fx["laser_steam"] = loadfx("vfx/map/mp_laser2/laser_core_steam");
	level.laser_fx["laser_movement_sparks"] = loadfx("vfx/sparks/machinery_scrape_sparks_looping");
}

//Function Number: 4
initlasersound()
{
	game["dialog"]["laser_deactivated"] = "laser_deactivated";
	game["dialog"]["laser_offline"] = "laser_offline";
	game["dialog"]["laser_strength"] = "laser_strength";
}

//Function Number: 5
initlaser()
{
	var_00 = spawnstruct();
	var_00.health = 999999;
	var_00.maxhealth = 1000;
	var_00.burstmin = 20;
	var_00.burstmax = 120;
	var_00.pausemin = 0.15;
	var_00.pausemax = 0.35;
	var_00.sentrymodeon = "sentry_manual";
	var_00.sentrymodeoff = "sentry_offline";
	var_00.timeout = 45;
	var_00.spinuptime = 0.05;
	var_00.overheattime = 8;
	var_00.cooldowntime = 0.1;
	var_00.fxtime = 0.3;
	var_00.streakname = "sky_laser_turret";
	var_00.weaponinfo = "sky_laser_mp";
	var_00.useweaponinfo = "killstreak_laser2_mp";
	var_00.modelbase = "mp_sky_laser_turret_head";
	var_00.modeldestroyed = "mp_sky_laser_turret_head";
	var_00.headicon = 1;
	var_00.teamsplash = "used_mp_laser2";
	var_00.shouldsplash = 0;
	var_00.vodestroyed = "laser_deactivated";
	var_00.vooffline = "laser_offline";
	var_00.vopower = "laser_strength";
	var_00.coreshellshock = "default";
	if(!isdefined(level.sentrysettings))
	{
		level.sentrysettings = [];
	}

	level.sentrysettings["sky_laser_turret"] = var_00;
	level.killstreakwieldweapons["mp_laser2_core"] = "mp_laser2";
}

//Function Number: 6
initlaserents()
{
	var_00 = "sky_laser_turret";
	precacheitem("mp_laser2_core");
	precachemodel("lsr_laser_button_01_obj");
	var_01 = getent("lasergun","targetname");
	var_01 hide();
	var_01 laserlightfill();
	var_01.fxents = var_01 laser_initfxents();
	var_01.offswitch = var_01 laser_initoffswitch();
	var_01.lifter = getent("laser_animated_prop","targetname");
	var_01.lifter.parts = getentarray("lsr_animated_parts","targetname");
	var_01.lifter laserlightfill();
	var_01.moveorgs = var_01.lifter laser_initmoveorgs();
	var_01.lifter.animup = "lsr_laser_turret_up";
	var_01.lifter.animdown = "lsr_laser_turret_down";
	var_01.lifter.animidledown = "lsr_laser_turret_idle_down";
	var_01.lifter.animidleup = "lsr_laser_turret_idle_up";
	var_01.generatorhat = getent("generator_hat","targetname");
	var_01.generatorhat.anim_up = "laser_button_on";
	var_01.generatorhat.anim_down = "laser_button_off";
	var_01.generatorhat.anim_idle_up = "laser_button_idle_on";
	var_01.generatorhat.anim_idle_down = "laser_button_idle_off";
	var_01.coredamagetrig = getent("trig_lasercore_damage","targetname");
	var_01.coredeathtrig = getent("trig_lasercore_death","targetname");
	var_01.firingdamagetrig = getent("trig_laserfire_damage","targetname");
	var_01.ownerlist = [];
	var_01.collision = spawnstruct();
	var_01.collision.col_base = getent("laser_collision_base","targetname");
	var_01.collision.col_head = getent("laser_collision_head","targetname");
	var_01.flaps_top = getentarray("lsr_flap_top","targetname");
	var_01.attachments = getentarray("lsr_geo_attach","targetname");
	var_01.lifter linkgeototurret(var_01,1);
	var_02 = getentarray("lsr_flap_bottom","targetname");
	var_01.flaps = common_scripts\utility::array_combine(var_01.flaps_top,var_02);
	foreach(var_04 in var_01.flaps)
	{
		var_04.col_base = getent(var_04.target,"targetname");
		if(isdefined(var_04.col_base))
		{
			var_04.col_base.unresolved_collision_kill = 1;
		}

		var_04.col_t = getent(var_04.col_base.target,"targetname");
		if(isdefined(var_04.col_t))
		{
			var_04.col_t.unresolved_collision_kill = 1;
		}

		var_04.col_base vehicle_jetbikesethoverforcescale(var_04,"mainFlapBase");
		var_04.col_t vehicle_jetbikesethoverforcescale(var_04,"mainFlap_T");
	}

	var_01.flap_animclose = "lsr_energy_hatch_close";
	var_01.flap_animidleclose = "lsr_energy_hatch_close_idle";
	var_01.flap_animopen = "lsr_energy_hatch_open";
	var_01.flap_animidleopen = "lsr_energy_hatch_open_idle";
	level.sentrygun = var_01;
	level.sentrygun laser_initsentry(var_00);
}

//Function Number: 7
linkgeototurret(param_00,param_01)
{
	if(param_01 == 0)
	{
		param_00.collision.col_base unlink();
		param_00.collision.col_head unlink();
		foreach(var_03 in param_00.flaps_top)
		{
			var_03 unlink();
		}

		foreach(var_06 in param_00.attachments)
		{
			var_06 unlink();
		}

		foreach(var_09 in param_00.lifter.parts)
		{
			var_09 unlink();
		}

		return;
	}

	if(param_01 == 1)
	{
		param_00.collision.col_base linkto(self,"tag_origin");
		param_00.collision.col_head linkto(self,"tag_aim_pivot");
		foreach(var_03 in param_00.flaps_top)
		{
			var_03 vehicle_jetbikesethoverforcescale(self);
		}

		foreach(var_06 in param_00.attachments)
		{
			var_06 vehicle_jetbikesethoverforcescale(self);
		}

		foreach(var_09 in param_00.lifter.parts)
		{
			var_09 vehicle_jetbikesethoverforcescale(self);
		}
	}
}

//Function Number: 8
laser_initmoveorgs()
{
	var_00 = common_scripts\utility::getstruct("laser_lifter_top_loc","targetname");
	var_01 = common_scripts\utility::getstruct("laser_lifter_bottom_loc","targetname");
	var_02 = var_00.origin - var_01.origin;
	var_03 = [];
	var_03["bottom"] = self.origin;
	var_03["top"] = self.origin + var_02;
	return var_03;
}

//Function Number: 9
laser_initfxents()
{
	var_00 = undefined;
	var_01 = common_scripts\utility::getstruct("laser_core_fx_pos","targetname");
	var_00 = var_01 common_scripts\utility::spawn_tag_origin();
	var_00 show();
	var_02 = [];
	var_02["charge_up"] = var_00;
	return var_02;
}

//Function Number: 10
laser_initoffswitch()
{
	var_00 = getent("laser_use_trig","targetname");
	var_01 = getent("laser_switch","targetname");
	var_02 = [];
	var_03 = spawn("script_model",var_01.origin);
	var_03.angles = var_01.angles;
	var_03 setmodel("lsr_laser_button_01_obj");
	var_03 hide();
	var_04 = [var_03];
	var_05 = maps\mp\gametypes\_gameobjects::createuseobject("none",var_00,var_04,(0,0,64));
	var_05 maps\mp\gametypes\_gameobjects::allowuse("none");
	var_05 maps\mp\gametypes\_gameobjects::setusetime(5);
	var_05 maps\mp\gametypes\_gameobjects::setusetext(&"MP_LASERTURRET_HACKING");
	var_05 maps\mp\gametypes\_gameobjects::setusehinttext(&"MP_LASERTURRET_HACK");
	var_05.onbeginuse = ::laser_offswitch_onbeginuse;
	var_05.onenduse = ::laser_offswitch_onenduse;
	var_05.onuse = ::laser_offswitch_onuseplantobject;
	var_05.oncantuse = ::laser_offswitch_oncantuse;
	var_05.useweapon = "search_dstry_bomb_mp";
	var_02 = [];
	var_02["switch_obj"] = var_03;
	var_02["use_zone"] = var_05;
	return var_02;
}

//Function Number: 11
laser_offswitch_onbeginuse(param_00)
{
}

//Function Number: 12
laser_offswitch_onenduse(param_00,param_01,param_02)
{
}

//Function Number: 13
laser_offswitch_onuseplantobject(param_00)
{
	level.sentrygun endon("death");
	level endon("game_ended");
	if(isdefined(level.sentrygun.owner))
	{
		level.sentrygun.owner thread maps\mp\_utility::leaderdialogonplayer(level.sentrysettings[level.sentrygun.sentrytype].vodestroyed);
	}

	param_00 playsound("mp_bomb_plant");
	var_01 = level.sentrysettings["sky_laser_turret"].maxhealth;
	level.sentrygun notify("damage",var_01,param_00,(0,0,0),(0,0,0),"MOD_UNKNOWN",undefined,undefined,undefined,undefined,"none");
}

//Function Number: 14
laser_offswitch_oncantuse(param_00)
{
}

//Function Number: 15
laser_initsentry(param_00)
{
	self.sentrytype = param_00;
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	self.shouldsplash = 1;
	self setcandamage(0);
	self maketurretinoperable();
	self setleftarc(180);
	self setrightarc(180);
	self settoparc(80);
	self setdefaultdroppitch(-10);
	self.laser_on = 0;
	self.lifter scriptmodelplayanimdeltamotion(self.lifter.animidledown);
	foreach(var_02 in self.lifter.parts)
	{
		var_02 scriptmodelplayanimdeltamotion(self.lifter.animidledown);
	}

	var_04 = spawn("script_model",self gettagorigin("tag_laser"));
	var_04 linkto(self);
	self.killcament = var_04;
	self.killcament setscriptmoverkillcam("explosive");
	maps\mp\killstreaks\_autosentry::sentry_makesolid();
	self setturretmodechangewait(1);
	laser_setinactive();
	thread laser_handledamage();
	thread laser_handlefakedeath();
	thread maps\mp\killstreaks\_autosentry::sentry_beepsounds();
}

//Function Number: 16
laser_handledamage()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self.health = level.sentrysettings[self.sentrytype].health;
		self.maxhealth = level.sentrysettings[self.sentrytype].maxhealth;
		self.damagetaken = 0;
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_01))
		{
			continue;
		}

		if(isdefined(var_08) && var_08 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		switch(var_09)
		{
			case "stealth_bomb_mp":
			case "artillery_mp":
				var_00 = var_00 * 4;
				break;
	
			case "bomb_site_mp":
				var_00 = self.maxhealth;
				break;
		}

		if(var_04 == "MOD_MELEE")
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("sentry");
			if(var_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0A = var_00 * level.armorpiercingmod;
			}
		}

		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			var_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("sentry");
		}

		if(isdefined(var_09))
		{
			var_0B = maps\mp\_utility::strip_suffix(var_09,"_lefthand");
			switch(var_0B)
			{
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
				case "stinger_mp":
				case "remotemissile_projectile_mp":
					self.largeprojectiledamage = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "stealth_bomb_mp":
				case "artillery_mp":
					self.largeprojectiledamage = 0;
					var_0A = var_0A + var_00 * 4;
					break;
	
				case "emp_grenade_var_mp":
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
			thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_01,var_00,var_04,var_09);
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				level thread maps\mp\gametypes\_rank::awardgameevent("kill",var_01,var_09,undefined,var_04);
			}

			if(isdefined(self.owner))
			{
				self.owner thread maps\mp\_utility::leaderdialogonplayer(level.sentrysettings[self.sentrytype].vodestroyed,undefined,undefined,self.origin);
			}

			self notify("fakedeath");
		}
	}
}

//Function Number: 17
laser_handlefakedeath()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("fakedeath");
		laser_setinactive();
		self.ownerlist = [];
		self setsentryowner(undefined);
		self.samtargetent = undefined;
		if(level.teambased)
		{
			self.team = undefined;
		}

		if(isdefined(self.ownertrigger))
		{
			self.ownertrigger delete();
		}

		self playsound("sentry_explode");
		if(isdefined(self.inuseby))
		{
			self.inuseby.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
			self.inuseby maps\mp\killstreaks\_autosentry::restoreperks();
			self.inuseby maps\mp\killstreaks\_autosentry::restoreweapons();
			self notify("deleting");
			wait(1);
			continue;
		}

		wait(1.5);
		self playsound("sentry_explode_smoke");
		var_00 = 8;
		while(var_00 > 0)
		{
			wait(0.4);
			var_00 = var_00 - 0.4;
		}
	}
}

//Function Number: 18
tryusemplaser(param_00,param_01)
{
	if(!playercanuselaser())
	{
		self iprintlnbold(&"MP_LASERTURRET_ENEMY");
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

	if(isdefined(level.sentrygun.locked) && level.sentrygun.locked == 1)
	{
		self iprintlnbold(&"MP_LASERTURRET_BUSY");
		return 0;
	}

	maps\mp\_matchdata::logkillstreakevent("mp_laser2",self.origin);
	level.sentrygun laser_setowner(self);
	var_02 = level.sentrygun getmode();
	if((!isdefined(level.sentrygun.mode) || level.sentrygun.mode == "off") && !isdefined(level.sentrygun.moving) || level.sentrygun.moving == 0)
	{
		laser_setplacesentry(level.sentrygun,level.sentrygun.sentrytype);
	}

	return 1;
}

//Function Number: 19
playercanuselaser()
{
	if(!isdefined(level.sentrygun))
	{
		return 0;
	}

	if(level.teambased)
	{
		if(isdefined(level.sentrygun.team) && level.sentrygun.team != self.team)
		{
			return 0;
		}
	}
	else
	{
		foreach(var_01 in level.sentrygun.ownerlist)
		{
			if(isdefined(var_01) && var_01 != self)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 20
laser_setowner(param_00)
{
	self.owner = param_00;
	self.ownerlist = common_scripts\utility::array_add(self.ownerlist,param_00);
	self setsentryowner(self.owner);
	self setturretminimapvisible(1,"sam_turret");
	if(level.teambased)
	{
		self.team = self.owner.team;
		self setturretteam(self.team);
	}

	thread laser_handleownerdisconnect(param_00);
	thread player_sentry_timeout(param_00);
	if(self.ownerlist.size > 1)
	{
		thread playlasercontainmentswap();
	}
}

//Function Number: 21
laser_handleownerdisconnect(param_00)
{
	self endon("death");
	self endon("fakedeath");
	level endon("game_ended");
	param_00 common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self.ownerlist = common_scripts\utility::array_remove(self.ownerlist,param_00);
	if(param_00 != self.owner)
	{
		thread stoplasercontainmentswap();
		return;
	}

	if(param_00 == self.owner)
	{
		var_01 = getnextplayerinownerqueue(self.ownerlist);
		if(isdefined(var_01))
		{
			laser_setowner(var_01);
			return;
		}

		self notify("fakedeath");
		return;
	}
}

//Function Number: 22
array_removefirstinqueue(param_00,param_01)
{
	var_02 = [];
	var_03 = undefined;
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(param_00[var_04] == param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	var_03 = var_02[var_02.size - 1];
	var_05 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(var_04 != var_03)
		{
			var_05[var_05.size] = param_00[var_04];
		}
	}

	return var_05;
}

//Function Number: 23
getnextplayerinownerqueue(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	param_00 = common_scripts\utility::array_reverse(param_00);
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02) && isplayer(var_02) && isalive(var_02))
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 24
laser_setplacesentry(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	var_02 = self;
	if(!var_02 maps\mp\_utility::validateusestreak())
	{
		return 0;
	}

	var_02.last_sentry = param_01;
	param_00 laser_setplaced(self);
	return 1;
}

//Function Number: 25
laser_setplaced(param_00)
{
	if(self getmode() == "manual")
	{
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		self.mode = "off";
	}

	self setsentrycarrier(undefined);
	self setcandamage(1);
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	thread laser_setactive(param_00);
	thread playlasercoreevent();
	thread playlasercontainmentstart();
	self playsound("sentry_gun_plant");
	self notify("placed");
}

//Function Number: 26
playlasercoreevent()
{
	wait(2);
	playfxontag(level.laser_fx["laser_steam"],self.fxents["charge_up"],"tag_origin");
}

//Function Number: 27
stoplasercoreevent()
{
	wait(4);
	stopfxontag(level.laser_fx["laser_steam"],self.fxents["charge_up"],"tag_origin");
	level common_scripts\utility::noself_delaycall(3.5,::activatepersistentclientexploder,200);
}

//Function Number: 28
startlaserlights()
{
	var_00 = getscriptablearray("laser_light","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lsr_part_a","laser_on_a");
	}

	var_00 = getscriptablearray("laser_light_b","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lsr_part_b","laser_on_b");
	}

	var_00 = getscriptablearray("laser_point_lights","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("static_part1","warning");
	}
}

//Function Number: 29
stoplaserlights()
{
	var_00 = getscriptablearray("laser_light","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lsr_part_a","laser_off_a");
	}

	var_00 = getscriptablearray("laser_light_b","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lsr_part_b","laser_off_b");
	}

	var_00 = getscriptablearray("laser_point_lights","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("static_part1","healthy");
	}
}

//Function Number: 30
playlasercontainmentstart()
{
	level.killstreak_laser_fxmode = 1;
	stopclientexploder(200);
	playfxontag(level.laser_fx["hatch_light"],self.fxents["charge_up"],"tag_origin");
	playfxontag(level.laser_fx["hatch_light"],level.sentrygun.lifter,"tag_origin");
	wait(5.33);
	startlaserlights();
	playfxontag(level.laser_fx["laser_field1_up_slow"],self.fxents["charge_up"],"tag_origin");
	wait(1);
	playfxontag(level.laser_fx["laser_field1"],self.fxents["charge_up"],"tag_origin");
}

//Function Number: 31
playlasercontainmentswap()
{
	if(!isdefined(self.ownerlist) || self.ownerlist.size < 1)
	{
		return;
	}

	level.killstreak_laser_fxmode = self.ownerlist.size;
	var_00 = level.killstreak_laser_fxmode;
	switch(var_00)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			stopfxontag(level.laser_fx["laser_field1"],self.fxents["charge_up"],"tag_origin");
			playfxontag(level.laser_fx["laser_field1_cheap"],self.fxents["charge_up"],"tag_origin");
			playfxontag(level.laser_fx["laser_field2_up"],self.fxents["charge_up"],"tag_origin");
			wait(1);
			var_01 = getscriptablearray("laser_light","targetname");
			foreach(var_03 in var_01)
			{
				var_03 setscriptablepartstate("lsr_part_a","laser_on_02_a");
			}
	
			var_05 = getscriptablearray("laser_light_b","targetname");
			foreach(var_07 in var_05)
			{
				var_07 setscriptablepartstate("lsr_part_b","laser_on_02_b");
			}
	
			playfxontag(level.laser_fx["laser_field2"],self.fxents["charge_up"],"tag_origin");
			break;

		case 3:
			stopfxontag(level.laser_fx["laser_field2"],self.fxents["charge_up"],"tag_origin");
			playfxontag(level.laser_fx["laser_field2_cheap"],self.fxents["charge_up"],"tag_origin");
			playfxontag(level.laser_fx["laser_field3_up"],self.fxents["charge_up"],"tag_origin");
			wait(1);
			var_09 = getscriptablearray("laser_light","targetname");
			foreach(var_0B in var_09)
			{
				var_0B setscriptablepartstate("lsr_part_a","laser_on_03_a");
			}
	
			var_05 = getscriptablearray("laser_light_b","targetname");
			foreach(var_07 in var_05)
			{
				var_07 setscriptablepartstate("lsr_part_b","laser_on_03_b");
			}
	
			playfxontag(level.laser_fx["laser_field3"],self.fxents["charge_up"],"tag_origin");
			break;

		default:
			break;
	}
}

//Function Number: 32
stoplasercontainmentswap()
{
	if(!isdefined(level.killstreak_laser_fxmode))
	{
		return;
	}

	var_00 = level.killstreak_laser_fxmode;
	level.killstreak_laser_fxmode = self.ownerlist.size;
	wait(1);
	switch(var_00)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			playfxontag(level.laser_fx["laser_field2_down"],self.fxents["charge_up"],"tag_origin");
			stopfxontag(level.laser_fx["laser_field2"],self.fxents["charge_up"],"tag_origin");
			stopfxontag(level.laser_fx["laser_field1_cheap"],self.fxents["charge_up"],"tag_origin");
			playfxontag(level.laser_fx["laser_field1"],self.fxents["charge_up"],"tag_origin");
			var_01 = getscriptablearray("laser_light","targetname");
			foreach(var_03 in var_01)
			{
				var_03 setscriptablepartstate("lsr_part_a","laser_on_a");
			}
	
			var_01 = getscriptablearray("laser_light_b","targetname");
			foreach(var_03 in var_01)
			{
				var_03 setscriptablepartstate("lsr_part_b","laser_on_b");
			}
			break;

		case 3:
			playfxontag(level.laser_fx["laser_field3_down"],self.fxents["charge_up"],"tag_origin");
			stopfxontag(level.laser_fx["laser_field3"],self.fxents["charge_up"],"tag_origin");
			stopfxontag(level.laser_fx["laser_field2_cheap"],self.fxents["charge_up"],"tag_origin");
			playfxontag(level.laser_fx["laser_field2"],self.fxents["charge_up"],"tag_origin");
			var_01 = getscriptablearray("laser_light","targetname");
			foreach(var_03 in var_01)
			{
				var_03 setscriptablepartstate("lsr_part_a","laser_on_02_a");
			}
	
			var_01 = getscriptablearray("laser_light_b","targetname");
			foreach(var_03 in var_01)
			{
				var_03 setscriptablepartstate("lsr_part_b","laser_on_02_b");
			}
			break;

		default:
			break;
	}
}

//Function Number: 33
stoplasercontainmentend()
{
	if(!isdefined(level.killstreak_laser_fxmode))
	{
		return;
	}

	var_00 = level.killstreak_laser_fxmode;
	level.killstreak_laser_fxmode = 0;
	wait(1.6);
	switch(var_00)
	{
		case 0:
			break;

		case 1:
			playfxontag(level.laser_fx["laser_field1_down_slow"],self.fxents["charge_up"],"tag_origin");
			killfxontag(level.laser_fx["laser_field1"],self.fxents["charge_up"],"tag_origin");
			stoplaserlights();
			wait(1.5);
			playfxontag(level.laser_fx["hatch_light_close"],self.fxents["charge_up"],"tag_origin");
			playfxontag(level.laser_fx["hatch_light_close"],level.sentrygun.lifter,"tag_origin");
			break;

		default:
			break;
	}
}

//Function Number: 34
laser_setinactive()
{
	self.samtargetent = undefined;
	self cleartargetentity();
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
	self.mode = "off";
	var_00 = self getentitynumber();
	maps\mp\killstreaks\_autosentry::removefromturretlist(var_00);
	if(level.teambased)
	{
		setteamheadicon_large("none",(0,0,0));
	}
	else if(isdefined(self.owner))
	{
		setteamheadicon_large("none",(0,0,0));
	}

	self setdefaultdroppitch(-10);
	level.sentrygun setturretminimapvisible(0);
	self setturretminimapvisible(0);
	self setcandamage(0);
	laser_coredamage_deactivated(self.coredamagetrig);
	laser_coredamage_deactivated(self.coredeathtrig);
	if(self.lifter.origin != self.moveorgs["bottom"])
	{
		laser_usableoffswitch_off();
		thread stoplasercoreevent();
		thread stoplasercontainmentend();
		thread laser_handlemovebottom();
	}
}

//Function Number: 35
laser_handlemovebottom()
{
	self endon("death");
	self endon("fakedeath");
	level endon("game_ended");
	foreach(var_01 in self.lifter.parts)
	{
	}

	self.locked = 1;
	self.moving = 1;
	wait(1);
	linkgeototurret(self,0);
	self.lifter show();
	self.lifter linkgeototurret(self,1);
	self hide();
	var_03 = [];
	var_03["laser_xform_down_sec1_start"] = "laser_xform_down_sec1_start";
	var_03["laser_xform_down_sec1_end"] = "laser_xform_down_sec1_end";
	var_03["laser_xform_down_sec2_start"] = "laser_xform_down_sec2_start";
	var_03["laser_xform_down_sec2_end"] = "laser_xform_down_sec2_end";
	self.lifter scriptmodelplayanimdeltamotion(self.lifter.animdown,"laser_xform_down_sec1_start");
	foreach(var_01 in self.lifter.parts)
	{
		var_01 scriptmodelplayanimdeltamotion(self.lifter.animdown,"laser_xform_down_sec1_start");
	}

	self.lifter thread maps\mp\_audio::snd_play_on_notetrack(var_03,"laser_xform_down_sec1_start");
	foreach(var_07 in self.flaps)
	{
		if(isdefined(var_07.targetname) && var_07.targetname == "lsr_flap_bottom")
		{
			var_07 scriptmodelplayanimdeltamotion(self.flap_animclose);
			continue;
		}

		var_07 scriptmodelplayanim(self.flap_animclose);
	}

	self.lifter thread aud_play_laser_move_down(6);
	self.lifter thread playmovementsparks(2.5);
	self.lifter maps\mp\_utility::delaythread(6,::stopmovementsparks);
	wait(7.8);
	self.moving = 0;
	self.locked = 0;
}

//Function Number: 36
laser_handlemovetop()
{
	self endon("death");
	self endon("fakedeath");
	level endon("game_ended");
	foreach(var_01 in self.lifter.parts)
	{
	}

	self.moving = 1;
	var_03 = [];
	var_03["laser_xform_up_sec1_start"] = "laser_xform_up_sec1_start";
	var_03["laser_xform_up_sec1_end"] = "laser_xform_up_sec1_end";
	var_03["laser_xform_up_sec2_start"] = "laser_xform_up_sec2_start";
	var_03["laser_xform_up_sec2_end"] = "laser_xform_up_sec2_end";
	self.lifter scriptmodelplayanimdeltamotion(self.lifter.animup,"laser_xform_up_sec1_start");
	foreach(var_01 in self.lifter.parts)
	{
		var_01 scriptmodelplayanimdeltamotion(self.lifter.animup,"laser_xform_up_sec1_start");
	}

	self.lifter thread maps\mp\_audio::snd_play_on_notetrack(var_03,"laser_xform_up_sec1_start");
	foreach(var_07 in self.flaps)
	{
		if(isdefined(var_07.targetname) && var_07.targetname == "lsr_flap_bottom")
		{
			var_07 scriptmodelplayanimdeltamotion(self.flap_animopen);
			continue;
		}

		var_07 scriptmodelplayanim(self.flap_animopen);
	}

	self.lifter thread aud_play_laser_move_up(5);
	self.lifter thread playmovementsparks(1.5);
	self.lifter maps\mp\_utility::delaythread(5,::stopmovementsparks);
	wait(8);
	self.lifter linkgeototurret(self,0);
	self show();
	linkgeototurret(self,1);
	self.lifter hide();
	waittillframeend;
	self.moving = 0;
}

//Function Number: 37
aud_play_laser_move_up(param_00)
{
	thread maps\mp\_audio::snd_play_in_space_delayed("laser_beam_power_up",(15,382,902),5.2);
	thread maps\mp\_audio::snd_play_linked("laser_platform_move_up_start",self);
	thread aud_laser_energy_beam_start();
	thread maps\mp\_audio::snd_play_loop_in_space("laser_platform_move_alarm_lp",(-1,355,945),"aud_stop_laser_alarm",2);
	wait(param_00);
	thread maps\mp\_audio::snd_play_linked("laser_platform_move_up_end",self);
	level notify("aud_stop_laser_alarm");
}

//Function Number: 38
aud_play_laser_move_down(param_00)
{
	thread maps\mp\_audio::snd_play_in_space_delayed("laser_beam_power_down",(15,382,902),1.25);
	thread aud_laser_pre_move_down();
	wait(2.5);
	var_01 = thread maps\mp\_audio::snd_play_linked("laser_platform_move_down_start",self);
	wait(3);
	thread maps\mp\_audio::snd_play_linked("laser_platform_move_down_legs_fold",self);
	var_01 scalevolume(0,0.05);
	var_01 stopsounds();
	level notify("aud_laser_energy_lp_off");
	wait(0.7);
	thread maps\mp\_audio::snd_play_linked("laser_platform_move_down_end",self);
}

//Function Number: 39
aud_laser_pre_move_down()
{
	wait(1);
	var_00 = thread maps\mp\_audio::snd_play_linked("laser_platform_pre_move_down",self);
}

//Function Number: 40
aud_laser_energy_beam_start()
{
	thread maps\mp\_audio::snd_play_loop_in_space("laser_base_pulse_energy_lp",(-13,393,352),"aud_laser_energy_lp_off",2);
	thread maps\mp\_audio::snd_play_loop_in_space("laser_base_pulse_low_lp",(-13,393,352),"aud_laser_energy_lp_off",2);
	thread maps\mp\_audio::snd_play_loop_in_space("laser_base_pulse_motor_lp",(-13,393,352),"aud_laser_energy_lp_off",2);
}

//Function Number: 41
playmovementsparks(param_00)
{
	wait(param_00);
	foreach(var_02 in self.parts)
	{
		if(var_02.model == "mp_sky_laser_turret_lega")
		{
			playfxontag(level.laser_fx["laser_movement_sparks"],var_02,"fx_joint_0");
		}
	}
}

//Function Number: 42
stopmovementsparks()
{
	foreach(var_01 in self.parts)
	{
		if(var_01.model == "mp_sky_laser_turret_lega")
		{
			stopfxontag(level.laser_fx["laser_movement_sparks"],var_01,"fx_joint_0");
		}
	}
}

//Function Number: 43
player_sentry_timeout(param_00)
{
	self endon("death");
	self endon("fakedeath");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	for(var_01 = level.sentrysettings[self.sentrytype].timeout;var_01;var_01 = max(0,var_01 - 1))
	{
		wait(1);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}

	if(isdefined(param_00))
	{
		self.ownerlist = array_removefirstinqueue(self.ownerlist,param_00);
		if(self.ownerlist.size != 0)
		{
			param_00 thread maps\mp\_utility::leaderdialogonplayer(level.sentrysettings[level.sentrygun.sentrytype].vopower);
			thread stoplasercontainmentswap();
			return;
		}

		param_00 thread maps\mp\_utility::leaderdialogonplayer(level.sentrysettings[level.sentrygun.sentrytype].vooffline);
		self notify("fakedeath");
	}
}

//Function Number: 44
laser_setactive(param_00)
{
	foreach(param_00 in level.players)
	{
		var_02 = self getentitynumber();
		maps\mp\killstreaks\_autosentry::addtoturretlist(var_02);
	}

	if(self.shouldsplash)
	{
		level thread maps\mp\_utility::teamplayercardsplash(level.sentrysettings[self.sentrytype].teamsplash,self.owner,self.owner.team);
		self.shouldsplash = 0;
	}

	laser_coredamage_activated(self.coredamagetrig);
	laser_coredamage_activated(self.coredeathtrig,1);
	laser_handlemovetop();
	self setdefaultdroppitch(5);
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
	self.mode = "on";
	laser_usableoffswitch_on();
	if(level.sentrysettings[self.sentrytype].headicon)
	{
		if(level.teambased)
		{
			setteamheadicon_large(self.team,(0,0,400));
		}
		else
		{
			setteamheadicon_large(self.team,(0,0,400));
		}
	}

	thread laser_attacktargets();
	thread laser_watchdisabled();
}

//Function Number: 45
laser_usableoffswitch_off()
{
	self.generatorhat scriptmodelplayanim(self.generatorhat.anim_down);
	level.sentrygun.offswitch["use_zone"] maps\mp\gametypes\_gameobjects::disableobject();
	level.sentrygun.offswitch["switch_obj"] hide();
}

//Function Number: 46
laser_usableoffswitch_on()
{
	var_00 = "none";
	if(isdefined(level.sentrygun.owner) && isdefined(level.sentrygun.owner.team))
	{
		var_00 = level.sentrygun.owner.team;
	}

	self.generatorhat scriptmodelplayanim(self.generatorhat.anim_up);
	level.sentrygun.offswitch["use_zone"].interactteam = "enemy";
	level.sentrygun.offswitch["use_zone"] maps\mp\gametypes\_gameobjects::setownerteam(var_00);
	foreach(var_02 in level.players)
	{
		if(var_02.team != var_00 && var_00 != "none")
		{
			var_02.laseroffswitch_isvisible = 1;
			level.sentrygun.offswitch["switch_obj"] showtoplayer(var_02);
		}
	}
}

//Function Number: 47
setteamheadicon_large(param_00,param_01)
{
	if(!level.teambased)
	{
		return;
	}

	if(!isdefined(self.entityheadiconteam))
	{
		self.entityheadiconteam = "none";
		self.entityheadicon = undefined;
	}

	var_02 = game["entity_headicon_" + param_00];
	self.entityheadiconteam = param_00;
	if(isdefined(param_01))
	{
		self.entityheadiconoffset = param_01;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	self notify("kill_entity_headicon_thread");
	if(param_00 == "none")
	{
		if(isdefined(self.entityheadicon))
		{
			self.entityheadicon destroy();
		}

		return;
	}

	var_03 = newteamhudelem(param_00);
	var_03.archived = 1;
	var_03.x = self.origin[0] + self.entityheadiconoffset[0];
	var_03.y = self.origin[1] + self.entityheadiconoffset[1];
	var_03.z = self.origin[2] + self.entityheadiconoffset[2];
	var_03.alpha = 1;
	var_03 setshader(var_02,50,50);
	var_03 setwaypoint(0,0,0,1);
	self.entityheadicon = var_03;
	thread maps\mp\_entityheadicons::keepiconpositioned();
	thread maps\mp\_entityheadicons::destroyheadiconsondeath();
}

//Function Number: 48
setplayerheadicon_large(param_00,param_01)
{
	if(level.teambased)
	{
		return;
	}

	if(!isdefined(self.entityheadiconteam))
	{
		self.entityheadiconteam = "none";
		self.entityheadicon = undefined;
	}

	self notify("kill_entity_headicon_thread");
	if(!isdefined(param_00))
	{
		if(isdefined(self.entityheadicon))
		{
			self.entityheadicon destroy();
		}

		return;
	}

	var_02 = param_00.team;
	self.entityheadiconteam = var_02;
	if(isdefined(param_01))
	{
		self.entityheadiconoffset = param_01;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	var_03 = game["entity_headicon_" + var_02];
	var_04 = newclienthudelem(param_00);
	var_04.archived = 1;
	var_04.x = self.origin[0] + self.entityheadiconoffset[0];
	var_04.y = self.origin[1] + self.entityheadiconoffset[1];
	var_04.z = self.origin[2] + self.entityheadiconoffset[2];
	var_04.alpha = 1;
	var_04 setshader(var_03,50,50);
	var_04 setwaypoint(0,0,0,1);
	self.entityheadicon = var_04;
	thread maps\mp\_entityheadicons::keepiconpositioned();
	thread maps\mp\_entityheadicons::destroyheadiconsondeath();
}

//Function Number: 49
laser_watchdisabled()
{
	self endon("death");
	self endon("fakedeath");
	level endon("game_ended");
	self notify("laser_watchDisabled");
	self endon("laser_watchDisabled");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_aim");
		self setdefaultdroppitch(-10);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		self.mode = "none";
		wait(var_01);
		self setdefaultdroppitch(5);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
		self.mode = "on";
	}
}

//Function Number: 50
laser_attacktargets()
{
	self endon("death");
	self endon("fakedeath");
	level endon("game_ended");
	self notify("laser_attackTargets");
	self endon("laser_attackTargets");
	self.samtargetent = undefined;
	self.sammissilegroups = [];
	for(;;)
	{
		self.samtargetent = maps\mp\killstreaks\_autosentry::sam_acquiretarget();
		laser_fireontarget();
		wait(0.05);
	}
}

//Function Number: 51
laser_watchlightbeam()
{
	self endon("death");
	level endon("game_ended");
	wait(0.5);
	if(!isdefined(self.ownerlist) || self.ownerlist.size < 1)
	{
		return;
	}

	var_00 = self.ownerlist.size;
	playfxontag(level.laser_fx["laser_charge1"],self.fxents["charge_up"],"tag_origin");
	playfxontag(level.laser_fx["beahm"],self,"tag_laser");
	laser_coredamage_activated(self.firingdamagetrig);
	var_01 = maps\mp\_audio::snd_play_linked("wpn_skylaser_fire_startup",self);
	thread common_scripts\utility::play_loop_sound_on_entity("wpn_skylaser_beam_lp");
	self laseron("mp_laser2_laser");
	while(isdefined(self.samtargetent) && isdefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent)
	{
		wait(0.05);
	}

	self laseroff();
	stopfxontag(level.laser_fx["laser_charge1"],self.fxents["charge_up"],"tag_origin");
	playfxontag(level.laser_fx["laser_beam_done1"],self.fxents["charge_up"],"tag_origin");
	stopfxontag(level.laser_fx["beahm"],self,"tag_laser");
	playfxontag(level.laser_fx["beahm_smoke"],self,"tag_laser");
	laser_coredamage_deactivated(self.firingdamagetrig);
	common_scripts\utility::stop_loop_sound_on_entity("wpn_skylaser_beam_lp");
	var_02 = maps\mp\_audio::snd_play_linked("wpn_skylaser_beam_stop",self);
	if(isdefined(var_01))
	{
		var_01 stopsounds();
	}
}

//Function Number: 52
laser_fireontarget()
{
	self endon("death");
	self endon("fakedeath");
	level endon("game_ended");
	if(isdefined(self.samtargetent))
	{
		if(isdefined(level.orbitalsupport_planemodel) && self.samtargetent == level.orbitalsupport_planemodel && !isdefined(level.orbitalsupport_player))
		{
			self.samtargetent = undefined;
			self cleartargetentity();
			return;
		}

		self settargetentity(self.samtargetent);
		self waittill("turret_on_target");
		if(!isdefined(self.samtargetent))
		{
			return;
		}

		if(!self.laser_on)
		{
			thread laser_watchlightbeam();
			thread maps\mp\killstreaks\_autosentry::sam_watchlaser();
			thread maps\mp\killstreaks\_autosentry::sam_watchcrashing();
			thread maps\mp\killstreaks\_autosentry::sam_watchleaving();
			thread maps\mp\killstreaks\_autosentry::sam_watchlineofsight();
		}

		wait(0.5);
		if(!isdefined(self.samtargetent))
		{
			return;
		}

		if(isdefined(level.orbitalsupport_planemodel) && self.samtargetent == level.orbitalsupport_planemodel && !isdefined(level.orbitalsupport_player))
		{
			self.samtargetent = undefined;
			self cleartargetentity();
			return;
		}

		self shootturret();
		firelaserbeam();
	}
}

//Function Number: 53
firelaserbeam()
{
	self endon("death");
	self endon("fakedeath");
	level endon("game_ended");
	var_00 = self gettagorigin("tag_laser");
	var_01 = anglestoforward(self gettagangles("tag_laser"));
	var_02 = var_00 + 15000 * var_01;
	var_03 = bullettrace(var_00,var_02,1,self);
	if(isdefined(level.orbitalsupport_planemodel) && self.samtargetent == level.orbitalsupport_planemodel && isdefined(level.orbitalsupport_player))
	{
		radiusdamage(level.orbitalsupport_planemodel.origin,512,100,100,self.owner,"MOD_EXPLOSIVE","killstreak_laser2_mp");
		return;
	}

	if(isdefined(self.samtargetent.ispodrocket) && self.samtargetent.ispodrocket)
	{
		self.samtargetent notify("damage",1000,self.owner,undefined,undefined,"mod_explosive",undefined,undefined,undefined,undefined,"killstreak_laser2_mp");
		return;
	}

	radiusdamage(var_03["position"],512,200,200,self.owner,"MOD_EXPLOSIVE","killstreak_laser2_mp");
}

//Function Number: 54
laser_coredamage_activated(param_00,param_01)
{
	level endon("game_ended");
	thread watchplayerenterlasercore(param_00,param_01);
	param_00 common_scripts\utility::trigger_on();
}

//Function Number: 55
laser_coredamage_deactivated(param_00)
{
	level endon("game_ended");
	param_00 notify("laser_coreDamage_deactivated");
	param_00 common_scripts\utility::trigger_off();
}

//Function Number: 56
watchplayerenterlasercore(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("laser_coreDamage_deactivated");
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		if(isdefined(var_02.lasercoretrigids) && isdefined(var_02.lasercoretrigids[param_00.targetname]) && var_02.lasercoretrigids[param_00.targetname] == 1)
		{
			continue;
		}
		else
		{
			if(!isdefined(var_02.lasercoretrigids))
			{
				var_02.lasercoretrigids = [];
			}

			var_02.lasercoretrigids[param_00.targetname] = 1;
			var_02 thread player_lasercoreeffect(param_00,param_01);
			if(isalive(var_02))
			{
				var_02 thread player_watchexitlasercore(param_00);
				var_02 thread player_watchdeath(param_00);
				continue;
			}

			var_02.lasercoretrigids[param_00.targetname] = 0;
		}
	}
}

//Function Number: 57
player_watchexitlasercore(param_00)
{
	level endon("game_ended");
	self endon("player_leftLaserCoreTrigger" + param_00.targetname);
	self endon("stop_watching_trig");
	while(self istouching(param_00))
	{
		wait(0.05);
	}

	if(isdefined(self.lasercoretrigids))
	{
		self.lasercoretrigids[param_00.targetname] = 0;
	}

	player_resetlasercorevalues();
	self notify("player_leftLaserCoreTrigger" + param_00.targetname);
}

//Function Number: 58
player_lasercoreeffect(param_00,param_01)
{
	level endon("game_ended");
	self endon("player_leftLaserCoreTrigger" + param_00.targetname);
	self endon("stop_watching_trig");
	if(isdefined(param_01) && param_01)
	{
		maps\mp\_utility::_suicide();
		return;
	}

	self.poison = 0;
	var_02 = level.sentrysettings[level.sentrygun.sentrytype].coreshellshock;
	if(!isdefined(self.usingremote) && !isdefined(self.ridevisionset))
	{
		self visionsetnakedforplayer("aftermath",0.5);
		self shellshock(var_02,60);
	}
	else
	{
		self.lasercorevisualsblocked = 1;
	}

	for(;;)
	{
		self.poison++;
		switch(self.poison)
		{
			case 1:
				self viewkick(1,self.origin);
				break;
	
			case 2:
				self viewkick(3,self.origin);
				player_dolasercoredamage(15);
				break;
	
			case 3:
				self viewkick(15,self.origin);
				player_dolasercoredamage(15);
				break;
	
			case 4:
				self viewkick(75,self.origin);
				maps\mp\_utility::_suicide();
				break;
		}

		wait(1);
	}
}

//Function Number: 59
player_watchdeath(param_00)
{
	level endon("game_ended");
	self endon("player_leftLaserCoreTrigger" + param_00.targetname);
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators","death");
	self.lasercoretrigids = undefined;
	player_resetlasercorevalues();
	self notify("stop_watching_trig");
}

//Function Number: 60
player_resetlasercorevalues()
{
	if(!isdefined(self.lasercorevisualsblocked))
	{
		self stopshellshock();
		thread maps\mp\_utility::revertvisionsetforplayer(0.5);
	}

	self.lasercorevisualsblocked = undefined;
}

//Function Number: 61
laserlightfill()
{
	playfxontag(common_scripts\utility::getfx("light_laser_fill"),self,"tag_origin");
}

//Function Number: 62
player_dolasercoredamage(param_00)
{
	if(!isdefined(level.sentrygun.owner))
	{
		return;
	}

	self thread [[ level.callbackplayerdamage ]](self,level.sentrygun.owner,param_00,0,"MOD_TRIGGER_HURT","mp_laser2_core",self.origin,(0,0,0) - self.origin,"none",0);
}

//Function Number: 63
handledamagefeedbacksound(param_00)
{
}