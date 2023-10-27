/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_sp_airdrop.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 914 ms
 * Timestamp: 10/27/2023 2:20:58 AM
*******************************************************************/

//Function Number: 1
sp_airdrop_preload()
{
	precacheitem("airdrop_marker_mp");
	precachemodel("com_plasticcase_friendly");
	precachemodel("com_plasticcase_enemy");
	precachemodel("com_plasticcase_taskforce141");
	precacheshader("compass_objpoint_ammo_friendly");
}

//Function Number: 2
sp_airdrop_init()
{
	if(!isdefined(level.startingkillstreakcrateobjid))
	{
		level.startingkillstreakcrateobjid = 24;
	}

	level.numairdropcrates = 0;
	level.ad = spawnstruct();
	sp_airdrop_setup_crate_collisions();
	level.ad.globalinitdone = 1;
}

//Function Number: 3
sp_airdrop_init_done()
{
	return isdefined(level.ad) && isdefined(level.ad.globalinitdone);
}

//Function Number: 4
sp_try_use_airdrop(param_00)
{
	var_01 = undefined;
	if(maps\_sp_killstreaks::isusingremote())
	{
		return 0;
	}

	var_01 = sp_begin_airdrop_via_marker(param_00);
	if((!isdefined(var_01) || !var_01) && !isdefined(self.airdropmarker))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
sp_begin_airdrop_via_marker(param_00)
{
	self endon("death");
	self endon("airdrop_marker_thrown");
	self.airdropmarker = undefined;
	thread sp_watch_airdrop_marker_usage(param_00);
	var_01 = self getcurrentweapon();
	if(isairdropmarker(var_01))
	{
		var_02 = var_01;
	}
	else
	{
		var_02 = undefined;
	}

	while(isairdropmarker(var_01))
	{
		self waittill("weapon_change",var_01);
		if(isairdropmarker(var_01))
		{
			var_02 = var_01;
		}
	}

	self notify("stopWatchingAirDropMarker");
	if(!isdefined(var_02))
	{
		return 0;
	}

	return !self getammocount(var_02) && self hasweapon(var_02);
}

//Function Number: 6
sp_watch_airdrop_marker_usage(param_00)
{
	self notify("watchAirDropMarkerUsage");
	self endon("disconnect");
	self endon("watchAirDropMarkerUsage");
	self endon("stopWatchingAirDropMarker");
	thread sp_watch_airdrop_marker(param_00);
	for(;;)
	{
		self waittill("grenade_pullback",var_01);
		if(!isairdropmarker(var_01))
		{
			continue;
		}

		common_scripts\utility::_disableusability();
		beginairdropmarkertracking();
	}
}

//Function Number: 7
sp_watch_airdrop_marker(param_00)
{
	self notify("watchAirDropMarker");
	self endon("watchAirDropMarker");
	self endon("spawned_player");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_01,var_02);
		if(!isairdropmarker(var_02))
		{
			continue;
		}

		self notify("airdrop_marker_thrown");
		var_01 thread airdropdetonateonstuck();
		var_01.owner = self;
		var_01.weaponname = var_02;
		self.airdropmarker = var_01;
		var_01 thread sp_airdrop_marker_activate(param_00);
	}
}

//Function Number: 8
sp_airdrop_marker_activate(param_00)
{
	self notify("airDropMarkerActivate");
	self endon("airDropMarkerActivate");
	self waittill("explode",var_01);
	var_02 = self.owner;
	if(!isdefined(var_02))
	{
		return;
	}

	wait 0.05;
	level sp_airdrop_do_flyby(param_00,var_02,var_01,randomfloat(360));
}

//Function Number: 9
sp_airdrop_do_flyby(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getflyheightoffset(param_02);
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = var_05 + param_04;
	if(!isdefined(param_01))
	{
		return;
	}

	var_06 = param_02 * (1,1,0) + (0,0,var_05);
	var_07 = getpathstart(var_06,param_03);
	var_08 = getpathend(var_06,param_03);
	var_06 = var_06 + anglestoforward((0,param_03,0)) * -50;
	var_09 = sp_airdrop_heli_setup(param_01,var_07,var_06);
	var_09 endon("death");
	var_09 setvehgoalpos(var_06,1);
	var_09 thread sp_airdrop_drop_the_crate(param_00,param_02,var_05,0,undefined,var_07);
	wait 2;
	var_09 vehicle_setspeed(75,40);
	var_09 setyawspeed(180,180,180,0.3);
	var_09 waittill("goal");
	wait 0.1;
	var_09 notify("drop_crate");
	var_09 setvehgoalpos(var_08,1);
	var_09 vehicle_setspeed(300,75);
	var_09.leaving = 1;
	var_09 waittill("goal");
	var_09 notify("leaving");
	var_09 notify("delete");
	var_09 delete();
}

//Function Number: 10
sp_airdrop_heli_setup(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02 - param_01);
	var_04 = getent("airdrop_littlebird","targetname");
	var_04.origin = param_01;
	var_04.angles = var_03;
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname("airdrop_littlebird");
	var_05 hide();
	if(!isdefined(var_05))
	{
		return;
	}

	if(isdefined(self.mgturret))
	{
		self notify("mg_off");
		foreach(var_07 in self.mgturret)
		{
			var_07 turretfiredisable();
			var_07 setmode("manual");
		}
	}

	var_05.health = 500;
	var_05 setcandamage(0);
	var_05.owner = param_00;
	var_05.team = param_00.team;
	var_05 thread heli_existence();
	var_05 setmaxpitchroll(45,85);
	var_05 vehicle_setspeed(250,175);
	var_05 common_scripts\utility::delaycall(0.1,::show);
	return var_05;
}

//Function Number: 11
heli_existence()
{
	common_scripts\utility::waittill_any("crashing","leaving");
	self notify("helicopter_gone");
}

//Function Number: 12
sp_airdrop_drop_the_crate(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = [];
	self.owner endon("disconnect");
	var_06 = sp_create_airdrop_crate(self.owner,param_00,param_05);
	var_06 linkto(self,"tag_ground",(32,0,5),(0,0,0));
	var_06.angles = (0,0,0);
	var_06 show();
	var_07 = self.veh_speed;
	self waittill("drop_crate");
	var_06 unlink();
	var_06 physicslaunchserver((0,0,0),(randomint(5),randomint(5),randomint(5)));
	var_06 thread sp_airdrop_crate_physics_waiter();
	var_06 thread sp_airdrop_crate_damage_enemies_on_fall(param_01,64);
}

//Function Number: 13
sp_create_airdrop_crate(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_02);
	var_03.inuse = 0;
	var_03.curprogress = 0;
	var_03.usetime = 0;
	var_03.userate = 0;
	if(isdefined(param_00))
	{
		var_03.owner = param_00;
	}
	else
	{
		var_03.owner = undefined;
	}

	var_03.cratetype = param_01;
	var_03.targetname = "care_package";
	var_03 setmodel("com_plasticcase_taskforce141");
	var_03 sp_airdrop_crate_attach_collision();
	var_03.collision thread sp_airdrop_crate_unlink_collision(var_03);
	var_03.basemodel = spawn("script_model",param_02);
	var_03.basemodel setmodel("com_plasticcase_friendly");
	var_03.basemodel common_scripts\utility::delaycall(0.25,::linkto,var_03,"tag_origin",(0,0,0),(0,0,0));
	var_03 thread sp_airdrop_crate_delete_on_owner_death(param_00);
	level.numairdropcrates++;
	return var_03;
}

//Function Number: 14
sp_delete_airdrop_crate()
{
	if(isdefined(self.objidfriendly))
	{
		objective_delete(self.objidfriendly);
	}

	if(isdefined(level.crates_on_ground) && level.crates_on_ground.size)
	{
		level.crates_on_ground = common_scripts\utility::array_remove(level.crates_on_ground,self);
		level.numairdropcrates--;
	}

	if(isdefined(self))
	{
		self.basemodel delete();
		self delete();
	}
}

//Function Number: 15
sp_airdrop_setup_crate_collisions()
{
	var_00 = getentarray("airdrop_crate_collision","targetname");
	foreach(var_02 in var_00)
	{
		var_02 connectpaths();
		var_02 notsolid();
	}

	level.airdropcratecollisionboxes = var_00;
}

//Function Number: 16
sp_airdrop_get_free_sbmodel_collision()
{
	var_00 = undefined;
	foreach(var_02 in level.airdropcratecollisionboxes)
	{
		if(!isdefined(var_02.isinuse))
		{
			var_00 = var_02;
			break;
		}
	}

	return var_00;
}

//Function Number: 17
sp_airdrop_crate_attach_collision()
{
	var_00 = sp_airdrop_get_free_sbmodel_collision();
	var_00.origin = self.origin;
	var_00.angles = self.angles;
	var_00 solid();
	var_00 linkto(self);
	var_00.isinuse = 1;
	self.collision = var_00;
}

//Function Number: 18
sp_airdrop_crate_damage_enemies_on_fall(param_00,param_01)
{
	while(isdefined(self) && distancesquared(self.origin,param_00) > 1024)
	{
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	var_02 = getaispeciesarray("axis","all");
	foreach(var_04 in var_02)
	{
		if(distancesquared(self.origin,var_04.origin) < param_01 * param_01)
		{
			if(isdefined(self.owner))
			{
				var_04 dodamage(300,self.origin,self.owner,self);
				continue;
			}

			var_04 dodamage(300,self.origin);
		}
	}
}

//Function Number: 19
sp_airdrop_crate_delete_on_owner_death(param_00)
{
	param_00 waittill("death");
	sp_delete_airdrop_crate();
}

//Function Number: 20
sp_airdrop_crate_unlink_collision(param_00)
{
	param_00 waittill("death");
	self unlink();
	self connectpaths();
	self notsolid();
	self.isinuse = undefined;
}

//Function Number: 21
sp_airdrop_crate_physics_waiter()
{
	self waittill("physics_finished");
	self.crate_num = gettime();
	if(!isdefined(level.crates_on_ground))
	{
		level.crates_on_ground = [];
	}

	level.crates_on_ground[level.crates_on_ground.size] = self;
	if(level.crates_on_ground.size > 4)
	{
		level.crates_on_ground[0] sp_delete_airdrop_crate();
	}

	thread sp_airdrop_crate_think();
	level thread sp_airdrop_crate_timeout(self,self.owner);
}

//Function Number: 22
sp_airdrop_crate_timeout(param_00,param_01)
{
	param_00 endon("death");
	var_02 = 120;
	if(isdefined(level.airdropcratetimeout))
	{
		var_02 = level.airdropcratetimeout;
	}

	if(var_02 <= 0)
	{
		return;
	}

	wait var_02;
	while(param_00.curprogress != 0)
	{
		wait 1;
	}

	param_00 sp_delete_airdrop_crate();
}

//Function Number: 23
sp_airdrop_crate_think()
{
	self endon("death");
	sp_airdrop_crate_setup_for_use();
	thread sp_airdrop_crate_owner_capture_think();
	thread sp_airdrop_teammate_capture_think();
	if(isdefined(level.sp_airdrop_crate_custom_thread))
	{
		self thread [[ level.sp_airdrop_crate_custom_thread ]]();
	}

	for(;;)
	{
		self waittill("captured",var_00);
		if(isdefined(self.owner) && var_00 != self.owner)
		{
			thread sp_airdrop_crate_hijack_notify(var_00);
		}

		if(isplayer(var_00))
		{
			var_01 = var_00;
			var_01 playlocalsound("ammo_crate_use");
			if(isdefined(self.killstreakinfo.crateopenfunc))
			{
				if(issubstr(self.killstreakinfo.streaktype,"specialty_"))
				{
					var_01 thread [[ self.killstreakinfo.crateopenfunc ]](self.killstreakinfo.streaktype);
				}
				else
				{
					var_01 thread [[ self.killstreakinfo.crateopenfunc ]]();
				}
			}
			else
			{
				var_01 thread maps\_sp_killstreaks::give_sp_killstreak(self.cratetype);
			}
		}

		sp_delete_airdrop_crate();
	}
}

//Function Number: 24
sp_airdrop_crate_hijack_notify(param_00)
{
	self notify("hijacked",param_00);
	if(!isplayer(self.owner))
	{
		return;
	}

	if(param_00.team == self.owner.team)
	{
		if(isdefined(level.sp_airdrop_crate_friendly_hijack_thread))
		{
			self.owner thread [[ level.sp_airdrop_crate_friendly_hijack_thread ]](param_00);
			return;
		}

		return;
	}

	if(isdefined(level.sp_airdrop_crate_enemy_hijack_thread))
	{
		self.owner thread [[ level.sp_airdrop_crate_enemy_hijack_thread ]](param_00);
	}
}

//Function Number: 25
sp_airdrop_crate_setup_for_use()
{
	self.collision disconnectpaths();
	var_00 = maps\_sp_killstreaks::get_sp_killstreak_info(self.cratetype);
	self.killstreakinfo = var_00;
	var_01 = sp_airdrop_get_crate_obj_id();
	objective_add(var_01,"invisible",(0,0,0));
	objective_position(var_01,self.origin);
	objective_icon(var_01,"compass_objpoint_ammo_friendly");
	self.objidfriendly = var_01;
	sp_crate_world_icon(var_00.crateicon,(0,0,24),14,14);
	self setcursorhint("HINT_NOICON");
	self sethintstring(var_00.cratehint);
	self makeusable();
	if(isdefined(level.airdropcrateunstuck) && level.airdropcrateunstuck)
	{
		thread sp_airdrop_unstuck_think();
	}
}

//Function Number: 26
sp_airdrop_unstuck_think()
{
	self endon("death");
	self endon("captured");
	wait 2;
	var_00 = undefined;
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(isdefined(self.collision) && self.collision istouching(var_03))
		{
			if(isdefined(self.owner) && self.owner == var_03)
			{
				var_00 = var_03;
				continue;
			}

			var_01[var_01.size] = var_03;
		}
	}

	if(isdefined(var_00))
	{
		self notify("trigger",var_00);
		return;
	}

	if(var_01.size > 0)
	{
		self notify("trigger",var_01[0]);
	}
}

//Function Number: 27
sp_airdrop_get_crate_obj_id()
{
	var_00 = undefined;
	if(!isdefined(level.lastusedkillstreakcrateobjid))
	{
		var_00 = level.startingkillstreakcrateobjid;
	}
	else
	{
		var_00 = level.lastusedkillstreakcrateobjid + 1;
	}

	if(var_00 > level.startingkillstreakcrateobjid + 7)
	{
		var_00 = level.startingkillstreakcrateobjid;
	}

	level.lastusedkillstreakcrateobjid = var_00;
	return var_00;
}

//Function Number: 28
sp_crate_world_icon(param_00,param_01,param_02,param_03)
{
	var_04 = newhudelem();
	var_04.archived = 1;
	var_04.x = self.origin[0] + param_01[0];
	var_04.y = self.origin[1] + param_01[1];
	var_04.z = self.origin[2] + param_01[2];
	var_04.alpha = 0.85;
	var_04 setshader(param_00,param_02,param_03);
	var_04 setwaypoint(1,1,0);
	var_04 thread keeppositioned(self,param_01);
	self.crateworldicon = var_04;
	thread destroyiconsondeath();
}

//Function Number: 29
sp_airdrop_crate_owner_capture_think()
{
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		if(isdefined(self.owner) && var_00 != self.owner)
		{
			continue;
		}

		if(!sp_use_hold_think(var_00,500))
		{
			continue;
		}

		self notify("captured",var_00);
		level notify("crate_captured");
	}
}

//Function Number: 30
sp_airdrop_teammate_capture_think()
{
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		if(isdefined(self.owner) && var_00 == self.owner)
		{
			continue;
		}

		if(!sp_use_hold_think(var_00))
		{
			continue;
		}

		self notify("captured",var_00);
		level notify("crate_captured");
	}
}

//Function Number: 31
sp_use_hold_think(param_00,param_01)
{
	param_00 freezecontrols(1);
	param_00 common_scripts\utility::_disableweapon();
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(level.airdropcrateusetime))
	{
		self.usetime = level.airdropcrateusetime;
	}
	else if(isdefined(param_01))
	{
		self.usetime = param_01;
	}
	else
	{
		self.usetime = 3000;
	}

	if(self.usetime > 0)
	{
		param_00 thread sp_personal_use_bar(self);
		var_02 = sp_use_hold_think_loop(param_00);
	}
	else
	{
		var_02 = 1;
	}

	if(isalive(param_00))
	{
		param_00 common_scripts\utility::_enableweapon();
		param_00 freezecontrols(0);
	}

	if(!isdefined(self))
	{
		return 0;
	}

	self.inuse = 0;
	self.curprogress = 0;
	return var_02;
}

//Function Number: 32
sp_use_hold_think_loop(param_00)
{
	while(isdefined(self) && isalive(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		if(isdefined(self.objectivescaler))
		{
			self.userate = 1 * self.objectivescaler;
		}
		else
		{
			self.userate = 1;
		}

		if(self.curprogress >= self.usetime)
		{
			return isalive(param_00);
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 33
sp_personal_use_bar(param_00)
{
	self endon("disconnect");
	var_01 = createprimaryprogressbar(-25);
	var_02 = createprimaryprogressbartext(-25);
	var_02 settext(&"SP_KILLSTREAKS_CAPTURING_CRATE");
	var_03 = -1;
	while(isalive(self) && isdefined(param_00) && param_00.inuse)
	{
		if(var_03 != param_00.userate)
		{
			if(param_00.curprogress > param_00.usetime)
			{
				param_00.curprogress = param_00.usetime;
			}

			var_01 updatebar(param_00.curprogress / param_00.usetime,1000 / param_00.usetime * param_00.userate);
			if(!param_00.userate)
			{
				var_01 hideelem();
				var_02 hideelem();
			}
			else
			{
				var_01 showelem();
				var_02 showelem();
			}
		}

		var_03 = param_00.userate;
		wait 0.05;
	}

	var_01 destroyelem();
	var_02 destroyelem();
}

//Function Number: 34
getflyheightoffset(param_00)
{
	var_01 = 850;
	var_02 = getent("airstrikeheight","targetname");
	if(!isdefined(var_02))
	{
		if(isdefined(level.airstrikeheightscale))
		{
			if(level.airstrikeheightscale > 2)
			{
				var_01 = 1500;
				return var_01 * level.airstrikeheightscale;
			}

			return var_01 * level.airstrikeheightscale + 256 + param_00[2];
		}

		return var_01 + param_00[2];
	}

	return var_02.origin[2];
}

//Function Number: 35
getpathstart(param_00,param_01)
{
	var_02 = 100;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04) * -1 * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 36
getpathend(param_00,param_01)
{
	var_02 = 150;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04 + (0,90,0)) * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 37
isairdropmarker(param_00)
{
	switch(param_00)
	{
		case "airdrop_sentry_marker_mp":
		case "airdrop_mega_marker_mp":
		case "airdrop_marker_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 38
beginairdropmarkertracking()
{
	self notify("beginAirDropMarkerTracking");
	self endon("beginAirDropMarkerTracking");
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("grenade_fire","weapon_change");
	common_scripts\utility::_enableusability();
}

//Function Number: 39
airdropdetonateonstuck()
{
	self endon("death");
	self waittill("missile_stuck");
	self detonate();
}

//Function Number: 40
destroyiconsondeath()
{
	self notify("destroyIconsOnDeath");
	self endon("destroyIconsOnDeath");
	self waittill("death");
	self.crateworldicon destroy();
}

//Function Number: 41
keeppositioned(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	var_02 = param_00.origin;
	for(;;)
	{
		if(var_02 != param_00.origin)
		{
			var_02 = param_00.origin;
			self.x = var_02[0] + param_01[0];
			self.y = var_02[0] + param_01[0];
			self.z = var_02[0] + param_01[0];
		}

		wait 0.05;
	}
}

//Function Number: 42
keepiconpositioned()
{
	self endon("kill_entity_headicon_thread");
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		if(var_00 != self.origin)
		{
			updateheadiconorigin();
			var_00 = self.origin;
		}

		wait 0.05;
	}
}

//Function Number: 43
destroyheadiconsondeath()
{
	self endon("kill_entity_headicon_thread");
	self waittill("death");
	if(!isdefined(self.entityheadicon))
	{
		return;
	}

	self.entityheadicon destroy();
}

//Function Number: 44
updateheadiconorigin()
{
	self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
	self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
	self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

//Function Number: 45
createprimaryprogressbartext(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = maps\_hud_util::createclientfontstring("hudbig",level.primaryprogressbarfontsize);
	var_01.hidden = 0;
	var_01 setpoint("CENTER",undefined,level.primaryprogressbartextx,level.primaryprogressbartexty - param_00);
	var_01.sort = -1;
	return var_01;
}

//Function Number: 46
createprimaryprogressbar(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = createbar((1,1,1),level.primaryprogressbarwidth,level.primaryprogressbarheight);
	var_01 setpoint("CENTER",undefined,level.primaryprogressbarx,level.primaryprogressbary - param_00);
	return var_01;
}

//Function Number: 47
createbar(param_00,param_01,param_02,param_03)
{
	var_04 = newclienthudelem(self);
	var_04.x = 0;
	var_04.y = 0;
	var_04.frac = 0;
	var_04.color = param_00;
	var_04.sort = -2;
	var_04.shader = "progress_bar_fill";
	var_04 setshader("progress_bar_fill",param_01,param_02);
	var_04.hidden = 0;
	if(isdefined(param_03))
	{
		var_04.flashfrac = param_03;
	}

	var_05 = newclienthudelem(self);
	var_05.elemtype = "bar";
	var_05.width = param_01;
	var_05.height = param_02;
	var_05.xoffset = 0;
	var_05.yoffset = 0;
	var_05.bar = var_04;
	var_05.children = [];
	var_05.sort = -3;
	var_05.color = (0,0,0);
	var_05.alpha = 0.5;
	var_05.padding = 0;
	var_05 maps\_hud_util::setparent(level.uiparent);
	var_05 setshader("progress_bar_bg",param_01 + 4,param_02 + 4);
	var_05.hidden = 0;
	return var_05;
}

//Function Number: 48
setpoint(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = maps\_hud_util::getparent();
	if(param_04)
	{
		self moveovertime(param_04);
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self.xoffset = param_02;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	self.yoffset = param_03;
	self.point = param_00;
	self.alignx = "center";
	self.aligny = "middle";
	if(issubstr(param_00,"TOP"))
	{
		self.aligny = "top";
	}

	if(issubstr(param_00,"BOTTOM"))
	{
		self.aligny = "bottom";
	}

	if(issubstr(param_00,"LEFT"))
	{
		self.alignx = "left";
	}

	if(issubstr(param_00,"RIGHT"))
	{
		self.alignx = "right";
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	self.relativepoint = param_01;
	var_06 = "center_adjustable";
	var_07 = "middle";
	if(issubstr(param_01,"TOP"))
	{
		var_07 = "top_adjustable";
	}

	if(issubstr(param_01,"BOTTOM"))
	{
		var_07 = "bottom_adjustable";
	}

	if(issubstr(param_01,"LEFT"))
	{
		var_06 = "left_adjustable";
	}

	if(issubstr(param_01,"RIGHT"))
	{
		var_06 = "right_adjustable";
	}

	if(var_05 == level.uiparent)
	{
		self.horzalign = var_06;
		self.vertalign = var_07;
	}
	else
	{
		self.horzalign = var_05.horzalign;
		self.vertalign = var_05.vertalign;
	}

	if(strip_suffix(var_06,"_adjustable") == var_05.alignx)
	{
		var_08 = 0;
		var_09 = 0;
	}
	else if(var_08 == "center" || var_07.alignx == "center")
	{
		var_08 = int(var_07.width / 2);
		if(var_07 == "left_adjustable" || var_06.alignx == "right")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}
	else
	{
		var_08 = var_07.width;
		if(var_07 == "left_adjustable")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}

	self.x = var_05.x + var_08 * var_09;
	if(strip_suffix(var_07,"_adjustable") == var_05.aligny)
	{
		var_0A = 0;
		var_0B = 0;
	}
	else if(var_09 == "middle" || var_07.aligny == "middle")
	{
		var_0A = int(var_07.height / 2);
		if(var_08 == "top_adjustable" || var_06.aligny == "bottom")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}
	else
	{
		var_0A = var_07.height;
		if(var_08 == "top_adjustable")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}

	self.y = var_05.y + var_0A * var_0B;
	self.x = self.x + self.xoffset;
	self.y = self.y + self.yoffset;
	switch(self.elemtype)
	{
		case "bar":
			setpointbar(param_00,param_01,param_02,param_03);
			break;
	}

	maps\_hud_util::updatechildren();
}

//Function Number: 49
setpointbar(param_00,param_01,param_02,param_03)
{
	self.bar.horzalign = self.horzalign;
	self.bar.vertalign = self.vertalign;
	self.bar.alignx = "left";
	self.bar.aligny = self.aligny;
	self.bar.y = self.y;
	if(self.alignx == "left")
	{
		self.bar.x = self.x;
	}
	else if(self.alignx == "right")
	{
		self.bar.x = self.x - self.width;
	}
	else
	{
		self.bar.x = self.x - int(self.width / 2);
	}

	if(self.aligny == "top")
	{
		self.bar.y = self.y;
	}
	else if(self.aligny == "bottom")
	{
		self.bar.y = self.y;
	}

	updatebar(self.bar.frac);
}

//Function Number: 50
updatebar(param_00,param_01)
{
	if(self.elemtype == "bar")
	{
		updatebarscale(param_00,param_01);
	}
}

//Function Number: 51
updatebarscale(param_00,param_01)
{
	var_02 = int(self.width * param_00 + 0.5);
	if(!var_02)
	{
		var_02 = 1;
	}

	self.bar.frac = param_00;
	self.bar setshader(self.bar.shader,var_02,self.height);
	if(isdefined(param_01) && var_02 < self.width)
	{
		if(param_01 > 0)
		{
			self.bar scaleovertime(1 - param_00 / param_01,self.width,self.height);
		}
		else if(param_01 < 0)
		{
			self.bar scaleovertime(param_00 / -1 * param_01,1,self.height);
		}
	}

	self.bar.rateofchange = param_01;
	self.bar.lastupdatetime = gettime();
}

//Function Number: 52
hideelem()
{
	if(self.hidden)
	{
		return;
	}

	self.hidden = 1;
	if(self.alpha != 0)
	{
		self.alpha = 0;
	}

	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		self.bar.hidden = 1;
		if(self.bar.alpha != 0)
		{
			self.bar.alpha = 0;
		}
	}
}

//Function Number: 53
showelem()
{
	if(!self.hidden)
	{
		return;
	}

	self.hidden = 0;
	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		if(self.alpha != 0.5)
		{
			self.alpha = 0.5;
		}

		self.bar.hidden = 0;
		if(self.bar.alpha != 1)
		{
			self.bar.alpha = 1;
			return;
		}

		return;
	}

	if(self.alpha != 1)
	{
		self.alpha = 1;
	}
}

//Function Number: 54
strip_suffix(param_00,param_01)
{
	if(param_00.size <= param_01.size)
	{
		return param_00;
	}

	if(getsubstr(param_00,param_00.size - param_01.size,param_00.size) == param_01)
	{
		return getsubstr(param_00,0,param_00.size - param_01.size);
	}

	return param_00;
}

//Function Number: 55
destroyelem()
{
	var_00 = [];
	for(var_01 = 0;var_01 < self.children.size;var_01++)
	{
		if(isdefined(self.children[var_01]))
		{
			var_00[var_00.size] = self.children[var_01];
		}
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] maps\_hud_util::setparent(maps\_hud_util::getparent());
	}

	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		self.bar destroy();
	}

	self destroy();
}