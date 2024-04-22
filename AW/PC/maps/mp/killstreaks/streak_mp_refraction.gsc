/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_refraction.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 352 ms
 * Timestamp: 4/22/2024 2:12:44 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.mp_refraction_killstreak_duration = 25;
	level.mp_refraction_inuse = 0;
	level.refraction_turrets_alive = 0;
	level.refraction_turrets_moved_down = 0;
	level.mp_refraction_owner = undefined;
	level.killstreakfuncs["mp_refraction"] = ::tryusemprefraction;
	level.mapkillstreak = "mp_refraction";
	level.mapkillstreakpickupstring = &"MP_REFRACTION_MAP_KILLSTREAK_PICKUP";
	level.killstreakwieldweapons["refraction_turret_mp"] = "refraction_turret_mp";
	if(!isdefined(level.sentrysettings))
	{
		level.sentrysettings = [];
	}

	level.sentrysettings["refraction_turret"] = spawnstruct();
	level.sentrysettings["refraction_turret"].health = 999999;
	level.sentrysettings["refraction_turret"].maxhealth = 1000;
	level.sentrysettings["refraction_turret"].burstmin = 20;
	level.sentrysettings["refraction_turret"].burstmax = 120;
	level.sentrysettings["refraction_turret"].pausemin = 0.15;
	level.sentrysettings["refraction_turret"].pausemax = 0.35;
	level.sentrysettings["refraction_turret"].sentrymodeon = "sentry";
	level.sentrysettings["refraction_turret"].sentrymodeoff = "sentry_offline";
	level.sentrysettings["refraction_turret"].timeout = 90;
	level.sentrysettings["refraction_turret"].spinuptime = 0.05;
	level.sentrysettings["refraction_turret"].overheattime = 8;
	level.sentrysettings["refraction_turret"].cooldowntime = 0.1;
	level.sentrysettings["refraction_turret"].fxtime = 0.3;
	level.sentrysettings["refraction_turret"].streakname = "sentry";
	level.sentrysettings["refraction_turret"].weaponinfo = "refraction_turret_mp";
	level.sentrysettings["refraction_turret"].modelbase = "ref_turret_01";
	level.sentrysettings["refraction_turret"].sentrytype = "refraction_turret";
	level.sentrysettings["refraction_turret"].modelplacement = "sentry_minigun_weak_obj";
	level.sentrysettings["refraction_turret"].modelplacementfailed = "sentry_minigun_weak_obj_red";
	level.sentrysettings["refraction_turret"].modeldestroyed = "sentry_minigun_weak_destroyed";
	level.sentrysettings["refraction_turret"].hintstring = &"SENTRY_PICKUP";
	level.sentrysettings["refraction_turret"].headicon = 1;
	level.sentrysettings["refraction_turret"].teamsplash = "used_sentry";
	level.sentrysettings["refraction_turret"].shouldsplash = 0;
	level.sentrysettings["refraction_turret"].vodestroyed = "sentry_destroyed";
	level.refraction_turrets = turret_setup();
	level.turret_movement_sound = "mp_refraction_turret_movement1";
	level.turret_movement2_sound = "mp_refraction_turret_movement2";
	level.turret_movement3_sound = "mp_refraction_turret_movement3";
}

//Function Number: 2
tryusemprefraction(param_00,param_01)
{
	if(isdefined(level.mp_refraction_owner) || level.mp_refraction_inuse)
	{
		self iprintlnbold(&"MP_REFRACTION_IN_USE");
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

	var_02 = setrefractionturretplayer(self);
	if(isdefined(var_02) && var_02)
	{
		maps\mp\_matchdata::logkillstreakevent("mp_refraction",self.origin);
	}

	return var_02;
}

//Function Number: 3
refractionturrettimer()
{
	self endon("game_ended");
	var_00 = level.mp_refraction_killstreak_duration;
	if(level.mp_refraction_owner maps\mp\_utility::_hasperk("specialty_blackbox") && isdefined(level.mp_refraction_owner.specialty_blackbox_bonus))
	{
		var_00 = var_00 * level.mp_refraction_owner.specialty_blackbox_bonus;
	}

	while(var_00 > 0)
	{
		wait(1);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		var_00 = var_00 - 1;
		if(level.mp_refraction_inuse == 0)
		{
			return;
		}
	}

	for(var_01 = 0;var_01 < level.refraction_turrets.size;var_01++)
	{
		level.refraction_turrets[var_01] notify("fake_refraction_death");
	}
}

//Function Number: 4
monitorrefractionkillstreakownership()
{
	level endon("game_ended");
	while(level.refraction_turrets_alive > 0 || level.refraction_turrets_moved_down < level.refraction_turrets.size)
	{
		wait(0.05);
	}

	unsetrefractionturretplayer();
}

//Function Number: 5
setrefractionturretplayer(param_00)
{
	if(isdefined(level.mp_refraction_owner))
	{
		return 0;
	}

	level.mp_refraction_inuse = 1;
	level.mp_refraction_owner = param_00;
	thread maps\mp\_utility::teamplayercardsplash("used_mp_refraction",param_00);
	var_01 = "refraction_turret";
	for(var_02 = 0;var_02 < level.refraction_turrets.size;var_02++)
	{
		level.refraction_turrets_alive++;
		level.refraction_turrets_moved_down = 0;
		level.refraction_turrets[var_02] sentry_setowner(param_00);
		level.refraction_turrets[var_02] setleftarc(45);
		level.refraction_turrets[var_02] setrightarc(45);
		level.refraction_turrets[var_02] settoparc(10);
		level.refraction_turrets[var_02].shouldsplash = 0;
		level.refraction_turrets[var_02].carriedby = param_00;
		level.refraction_turrets[var_02] sentry_setplaced();
		level.refraction_turrets[var_02] thread sentry_handledamage();
		level.refraction_turrets[var_02] thread sentry_handledeath();
		level.refraction_turrets[var_02] thread sentry_lasermark();
		level.refraction_turrets[var_02] thread aud_turrets_activate();
	}

	level thread refractionturrettimer();
	level thread monitorrefractionkillstreakownership();
	return 1;
}

//Function Number: 6
aud_turrets_activate()
{
	thread maps\mp\_audio::snd_play_in_space("turret_cover_explode",self.origin);
	thread maps\mp\_audio::snd_play_in_space("turret_rise_start",self.origin);
}

//Function Number: 7
unsetrefractionturretplayer()
{
	level.mp_refraction_owner = undefined;
	level.mp_refraction_inuse = 0;
}

//Function Number: 8
turret_setup()
{
	var_00 = getentarray("turret_killer","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = undefined;
		if(isdefined(var_02.target))
		{
			var_03 = getentarray(var_02.target,"targetname");
		}

		foreach(var_05 in var_03)
		{
			if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "turret_lifter")
			{
				var_02.lifter = var_05;
				continue;
			}
			else if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "hatch")
			{
				var_02.hatch = var_05;
				continue;
			}
			else
			{
			}
		}

		var_02.lifter.animup = "ref_turret_gun_raise";
		var_02.lifter.animdown = "ref_turret_gun_lower";
		var_02.lifter.idleup = "ref_turret_gun_idle_up";
		var_02.lifter.idledown = "ref_turret_gun_idle_down";
		var_02.hatch.animup = "ref_turret_hatch_raise";
		var_02.hatch.animdown = "ref_turret_hatch_lower";
		var_02.hatch.idleup = "ref_turret_hatch_idle_up";
		var_02.hatch.idledown = "ref_turret_hatch_idle_down";
		var_02.collision = spawnstruct();
		var_07 = undefined;
		if(isdefined(var_02.lifter.target))
		{
			var_07 = getentarray(var_02.lifter.target,"targetname");
		}

		foreach(var_09 in var_07)
		{
			if(isdefined(var_09.script_noteworthy))
			{
				switch(var_09.script_noteworthy)
				{
					case "ref_turret_body_col":
						var_02.collision.col_body = var_09;
						break;

					case "ref_turret_head_col":
						var_02.collision.col_head = var_09;
						break;

					case "ref_turret_leg_r_col":
						var_02.collision.col_leg_r = var_09;
						break;

					case "ref_turret_leg_l_col":
						var_02.collision.col_leg_l = var_09;
						break;

					case "ref_turret_gun_col":
						var_02.collision.col_gun = var_09;
						break;
				}
			}
		}

		var_02.sound_tag = common_scripts\utility::spawn_tag_origin();
		var_02.sound_tag.origin = var_02.origin + (0,0,24);
		var_02 setdefaultdroppitch(0);
		var_0B = level.sentrysettings["refraction_turret"].sentrytype;
		var_02 sentry_initsentry(var_0B);
		var_02 maketurretsolid();
		var_02 hide();
		var_02.laser_tag = spawn("script_model",var_02.origin);
		var_02.laser_tag setmodel("tag_laser");
	}

	return var_00;
}

//Function Number: 9
linkcollisiontoturret(param_00,param_01)
{
	if(param_01 == 0)
	{
		if(isdefined(param_00.collision.col_body))
		{
			param_00.collision.col_body unlink();
		}

		if(isdefined(param_00.collision.col_head))
		{
			param_00.collision.col_head unlink();
		}

		if(isdefined(param_00.collision.col_leg_r))
		{
			param_00.collision.col_leg_r unlink();
		}

		if(isdefined(param_00.collision.col_leg_l))
		{
			param_00.collision.col_leg_l unlink();
		}

		if(isdefined(param_00.collision.col_gun))
		{
			param_00.collision.col_gun unlink();
			return;
		}

		return;
	}

	if(param_01 == 1)
	{
		if(isdefined(param_00.collision.col_body))
		{
			param_00.collision.col_body linkto(self,"tag_origin");
		}

		if(isdefined(param_00.collision.col_head))
		{
			param_00.collision.col_head linkto(self,"tag_aim_animated");
		}

		if(isdefined(param_00.collision.col_leg_r))
		{
			param_00.collision.col_leg_r linkto(self,"arm_r");
		}

		if(isdefined(param_00.collision.col_leg_l))
		{
			param_00.collision.col_leg_l linkto(self,"arm_l");
		}

		if(isdefined(param_00.collision.col_gun))
		{
			param_00.collision.col_gun linkto(self,"tag_barrel");
			return;
		}
	}
}

//Function Number: 10
sentry_lasermark()
{
	level endon("game_ended");
	self waittill("refraction_turret_moved_up");
	self.laser_tag laseron();
	self.laser_tag.origin = self gettagorigin("tag_flash");
	self.laser_tag.angles = self gettagangles("tag_flash");
	self.laser_tag linkto(self,"tag_flash");
	self waittill("fake_refraction_death");
	self.laser_tag laseroff();
}

//Function Number: 11
turret_moveup()
{
	wait(randomfloatrange(1,1.5));
	self.killcament = spawn("script_model",self gettagorigin("tag_player"));
	self.killcament setscriptmoverkillcam("explosive");
	self.lifter linkcollisiontoturret(self,1);
	var_00 = [];
	var_00["ref_turret_raise_doors_start"] = "ref_turret_raise_doors_start";
	var_00["ref_turret_raise_doors_end"] = "ref_turret_raise_doors_end";
	var_00["ref_turret_down_start"] = "ref_turret_down_start";
	var_00["ref_turret_down_end"] = "ref_turret_down_end";
	var_00["ref_turret_doors_close_start"] = "ref_turret_doors_close_start";
	var_00["ref_turret_doors_close_end"] = "ref_turret_doors_close_end";
	var_00["ref_turret_barrell_ext_start"] = "ref_turret_barrell_ext_start";
	var_00["ref_turret_barrell_ext_end"] = "ref_turret_barrell_ext_end";
	self.hatch scriptmodelplayanimdeltamotion(self.hatch.animup);
	self.lifter scriptmodelplayanimdeltamotion(self.lifter.animup,"ref_turret_raise_doors_start");
	self.lifter thread maps\mp\_audio::snd_play_on_notetrack(var_00,"ref_turret_raise_doors_start");
	thread playfxturretmoveup();
	thread playaudioturretmoveup();
	wait(4.17);
	self.lifter linkcollisiontoturret(self,0);
	self show();
	self.lifter hide();
	self notify("refraction_turret_moved_up");
}

//Function Number: 12
playfxturretmoveup()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(1);
	level thread common_scripts\_exploder::activate_clientside_exploder(2);
	level thread common_scripts\_exploder::activate_clientside_exploder(3);
	level thread common_scripts\_exploder::activate_clientside_exploder(4);
	level thread common_scripts\_exploder::activate_clientside_exploder(5);
	level thread common_scripts\_exploder::activate_clientside_exploder(6);
	level thread common_scripts\_exploder::activate_clientside_exploder(7);
	level thread common_scripts\_exploder::activate_clientside_exploder(8);
}

//Function Number: 13
playaudioturretmoveup()
{
	self.sound_tag thread maps\mp\_utility::play_sound_on_tag(level.turret_movement_sound,"tag_origin");
	wait(1);
	self.sound_tag thread maps\mp\_utility::play_sound_on_tag(level.turret_movement2_sound,"tag_origin");
	wait(1);
	self.sound_tag thread maps\mp\_utility::play_sound_on_tag(level.turret_movement3_sound,"tag_origin");
}

//Function Number: 14
turret_movedown(param_00)
{
	wait(randomfloatrange(1,1.5));
	self.lifter show();
	self.lifter linkcollisiontoturret(self,1);
	self hide();
	var_01 = [];
	var_01["ref_turret_raise_doors_start"] = "ref_turret_raise_doors_start";
	var_01["ref_turret_raise_doors_end"] = "ref_turret_raise_doors_end";
	var_01["ref_turret_down_start"] = "ref_turret_down_start";
	var_01["ref_turret_down_end"] = "ref_turret_down_end";
	var_01["ref_turret_barrell_close_start"] = "ref_turret_barrell_close_start";
	var_01["ref_turret_barrell_close_end"] = "ref_turret_barrell_close_end";
	var_01["ref_turret_doors_close_start"] = "ref_turret_doors_close_start";
	var_01["ref_turret_doors_close_end"] = "ref_turret_doors_close_end";
	var_01["ref_turret_doors_lock_start"] = "ref_turret_doors_lock_start";
	var_01["ref_turret_doors_lock_end"] = "ref_turret_doors_lock_end";
	var_02 = self.hatch.angles + (-90,0,0);
	common_scripts\utility::noself_delaycall(4.1,::playfx,common_scripts\utility::getfx("mp_ref_turret_steam_off"),self.hatch.origin,anglestoforward(var_02),anglestoup(var_02));
	self.hatch scriptmodelplayanimdeltamotion(self.hatch.animdown);
	self.lifter scriptmodelplayanimdeltamotion(self.lifter.animdown,"ref_turret_down_end");
	self.lifter thread maps\mp\_audio::snd_play_on_notetrack(var_01,"ref_turret_down_end");
	wait(4.64);
	waittillframeend;
	self.lifter linkcollisiontoturret(self,0);
	level.refraction_turrets_moved_down++;
}

//Function Number: 15
sentry_setplaced()
{
	self setsentrycarrier(undefined);
	self.carriedby forceusehintoff();
	self.carriedby = undefined;
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	thread sentry_setactive();
	self playsound("sentry_gun_plant");
	self notify("placed");
}

//Function Number: 16
sentry_setactive()
{
	turret_moveup();
	self setcandamage(1);
	self setcanradiusdamage(1);
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
	if(level.sentrysettings[self.sentrytype].headicon)
	{
		if(level.teambased)
		{
			maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,95));
			return;
		}

		maps\mp\_entityheadicons::setplayerheadicon(self.owner,(0,0,95));
	}
}

//Function Number: 17
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
	thread maps\mp\killstreaks\_autosentry::sentry_attacktargets();
}

//Function Number: 18
sentry_handledeath()
{
	self waittill("fake_refraction_death");
	if(!isdefined(self))
	{
		return;
	}

	maps\mp\killstreaks\_autosentry::sentry_setinactive();
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	self setcandamage(0);
	self setcanradiusdamage(0);
	self.laser_tag laseroff();
	turret_movedown();
	level.refraction_turrets_alive--;
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}
}

//Function Number: 19
sentry_setowner(param_00)
{
	self.owner = param_00;
	self setsentryowner(self.owner);
	self setturretminimapvisible(1,self.sentrytype);
	if(level.teambased && isdefined(param_00))
	{
		self.team = self.owner.team;
		self setturretteam(self.team);
	}

	thread sentry_handleownerdisconnect();
}

//Function Number: 20
sentry_handleownerdisconnect()
{
	level endon("game_ended");
	self endon("fake_refraction_death");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("fake_refraction_death");
}

//Function Number: 21
sentry_handledamage()
{
	self endon("fake_refraction_death");
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
					var_0A = 0;
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

			self notify("fake_refraction_death");
			return;
		}
	}
}