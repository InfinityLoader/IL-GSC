/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\_aerial_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 1148 ms
 * Timestamp: 4/22/2024 2:11:23 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(getdvarint("virtuallobbyactive",0))
	{
		return;
	}

	level.helis = [];
	level.littlebirds = [];
	level.heli_leave_nodes = getentorstructarray("heli_leave","targetname");
	level.heli_crash_nodes = getentorstructarray("heli_crash_start","targetname");
	level.chopper_fx["explode"]["death"] = [];
	level.chopper_fx["explode"]["air_death"] = [];
	level.chopper_fx["damage"]["light_smoke"] = loadfx("vfx/trail/smoke_trail_white_heli_emitter");
	level.chopper_fx["damage"]["heavy_smoke"] = loadfx("vfx/trail/smoke_trail_black_heli_emitter");
	level.chopper_fx["damage"]["on_fire"] = loadfx("vfx/fire/helicopter_damaged_fire_m");
	level.chopper_fx["explode"]["large"] = loadfx("fx/explosions/helicopter_explosion_secondary_small");
	level.chopper_fx["rocketlaunch"]["warbird"] = loadfx("vfx/muzzleflash/rocket_launch_air_to_ground");
	level.heli_sound["allies"]["hit"] = "warbird_death_explo";
	level.heli_sound["axis"]["hit"] = "warbird_death_explo";
	level.heli_sound["allies"]["spinloop"] = "warbird_death_spin_loop";
	level.heli_sound["axis"]["spinloop"] = "warbird_death_spin_loop";
	level.heli_sound["allies"]["crash"] = "warbird_air_death";
	level.heli_sound["axis"]["crash"] = "warbird_air_death";
	level._effect["flare"] = loadfx("vfx/lensflare/flares_warbird");
	level.heli_attract_strength = 1000;
	level.heli_attract_range = 4096;
	level.heli_maxhealth = 2000;
	level.heli_targeting_delay = 0.5;
}

//Function Number: 2
makehelitype(param_00,param_01,param_02)
{
	level.chopper_fx["explode"]["death"][param_00] = loadfx(param_01);
	level.lightfxfunc[param_00] = param_02;
}

//Function Number: 3
addairexplosion(param_00,param_01)
{
	level.chopper_fx["explode"]["air_death"][param_00] = loadfx(param_01);
}

//Function Number: 4
addtohelilist()
{
	level.helis[self getentitynumber()] = self;
}

//Function Number: 5
removefromhelilist(param_00)
{
	level.helis[param_00] = undefined;
}

//Function Number: 6
addtolittlebirdlist(param_00)
{
	level.littlebirds[self getentitynumber()] = self;
}

//Function Number: 7
removefromlittlebirdlistondeath(param_00)
{
	var_01 = self getentitynumber();
	self waittill("death");
	level.littlebirds[var_01] = undefined;
}

//Function Number: 8
exceededmaxlittlebirds(param_00)
{
	if(level.littlebirds.size >= 4)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
heli_leave_on_disconnect(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 waittill("disconnect");
	thread heli_leave();
}

//Function Number: 10
heli_leave_on_changeteams(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 common_scripts\utility::waittill_any("joined_team","joined_spectators");
	thread heli_leave();
}

//Function Number: 11
heli_modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\gametypes\_damage::modifydamage(param_00,param_01,param_02,param_03);
	if(var_04 > 0)
	{
		heli_staticdamage(param_01,param_02,var_04);
	}

	return var_04;
}

//Function Number: 12
heli_addrecentdamage(param_00)
{
	self endon("death");
	self.recentdamageamount = self.recentdamageamount + param_00;
	wait(4);
	self.recentdamageamount = self.recentdamageamount - param_00;
}

//Function Number: 13
heli_leave_on_timeout(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	thread heli_leave();
}

//Function Number: 14
heli_leave_on_gameended(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	level waittill("game_ended");
	thread heli_leave();
}

//Function Number: 15
heli_leave(param_00)
{
	self notify("leaving");
	self.isleaving = 1;
	self clearlookatent();
	var_01 = undefined;
	if(!isdefined(param_00))
	{
		var_01 = heli_pick_fly_node(level.heli_leave_nodes);
		param_00 = var_01.origin;
	}

	var_02 = spawn("script_origin",param_00);
	if(isdefined(var_02))
	{
		self setlookatent(var_02);
		var_02 thread wait_and_delete(3);
	}

	heli_reset();
	self vehicle_setspeed(100,45);
	if(isdefined(var_01))
	{
		if(isdefined(var_01.target))
		{
			heli_fly_simple_path(var_01);
		}
		else
		{
			_setvehgoalpos(var_01.origin,0);
			self waittillmatch("goal");
		}
	}
	else
	{
		_setvehgoalpos(param_00,0);
		self waittillmatch("goal");
	}

	self notify("death");
	wait(0.05);
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}

//Function Number: 16
heli_pick_fly_node(param_00)
{
	var_01 = self.origin;
	var_02 = undefined;
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = param_00[var_06].origin;
		if(flynodeorgtracepassed(var_01,var_07,self))
		{
			var_08 = var_07 - var_01;
			var_09 = distance(var_01,var_07);
			var_0A = rotatevector(var_08,(0,90,0));
			var_0B = var_01 + var_0A * 100;
			var_0C = var_0B + var_08 * var_09;
			if(flynodeorgtracepassed(var_0B,var_0C,self))
			{
				var_0D = rotatevector(var_08,(0,-90,0));
				var_0B = var_01 + var_0D * 100;
				var_0C = var_0B + var_08 * var_09;
				if(flynodeorgtracepassed(var_0B,var_0C,self))
				{
					return param_00[var_06];
				}
			}
		}
	}

	return param_00[randomint(param_00.size)];
}

//Function Number: 17
flynodeorgtracepassed(param_00,param_01,param_02)
{
	var_03 = bullettrace(param_00,param_01,0,param_02,0,0,1,0,0);
	var_04 = var_03["fraction"] >= 1;
}

//Function Number: 18
wait_and_delete(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 19
deleteaftertime(param_00)
{
	wait(param_00);
	self delete();
}

//Function Number: 20
heli_reset()
{
	self cleartargetyaw();
	self cleargoalyaw();
	self vehicle_setspeed(60,25);
	self setyawspeed(100,45,45);
	self setmaxpitchroll(30,30);
	self setneargoalnotifydist(100);
	self setturningability(1);
}

//Function Number: 21
_setvehgoalpos(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self setvehgoalpos(param_00,param_01);
}

//Function Number: 22
heli_flares_monitor(param_00)
{
	switch(self.helitype)
	{
		default:
			self.numflares = 1;
			break;
	}

	if(isdefined(param_00))
	{
		self.numflares = self.numflares + param_00;
	}

	thread handleincomingstinger();
}

//Function Number: 23
handleincomingstinger(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	for(;;)
	{
		level waittill("stinger_fired",var_01,var_02);
		if(!maps\mp\_stingerm7::anystingermissilelockedon(var_02,self))
		{
			continue;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(isdefined(param_00))
		{
			level thread [[ param_00 ]](var_02,var_01,var_01.team);
			continue;
		}

		level thread watchmissileproximity(var_02,var_01,var_01.team);
	}
}

//Function Number: 24
watchmissileproximity(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		var_04 thread missilewatchproximity(param_01,param_02,var_04.lockedstingertarget);
	}
}

//Function Number: 25
missilewatchproximity(param_00,param_01,param_02)
{
	self endon("death");
	param_02 endon("death");
	var_03 = 5;
	var_04 = 4000;
	for(;;)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		var_05 = param_02 getpointinbounds(0,0,0);
		var_06 = distance(self.origin,var_05);
		if(isdefined(param_02.player))
		{
			param_02.player thread doproximityalarm(self,param_02);
		}

		if(var_06 < var_04)
		{
			if(param_02.numflares > 0 || isdefined(param_02.flarestarget))
			{
				if(isdefined(param_02.owner) && iswarbird(param_02))
				{
					if(param_02.numflares == 2)
					{
						param_02.owner setclientomnvar("ui_warbird_flares",1);
					}
					else if(param_02.numflares == 1)
					{
						param_02.owner setclientomnvar("ui_warbird_flares",2);
					}

					param_02.owner playlocalsound("paladin_deploy_flares");
				}

				var_07 = param_02 deployflares(var_03);
				playfxontag(common_scripts\utility::getfx("flare"),var_07,"tag_origin");
				if(!isdefined(param_02.flarestarget))
				{
					param_02.numflares--;
					level thread handleflarestimer(param_02,var_07,var_03);
				}

				self missile_settargetent(var_07);
				return;
			}
		}

		wait(0.05);
	}
}

//Function Number: 26
deployflares(param_00)
{
	var_01 = self gettagorigin("tag_origin") + (0,0,-50);
	var_02 = spawn("script_model",var_01);
	var_02 setmodel("tag_origin");
	var_02.angles = self.angles;
	if(!isdefined(self.flaresdeployedyaw))
	{
		self.flaresdeployedyaw = randomfloatrange(-180,180);
	}
	else
	{
		self.flaresdeployedyaw = self.flaresdeployedyaw + 90;
	}

	var_03 = anglestoforward((self.angles[0],self.flaresdeployedyaw,self.angles[2]));
	var_03 = vehiclemodifyflarevector(var_03);
	var_02 movegravity(var_03,param_00);
	var_02 thread deleteaftertime(param_00);
	return var_02;
}

//Function Number: 27
vehiclemodifyflarevector(param_00)
{
	if(self.vehicletype == "warbird")
	{
		return vectornormalize(param_00 + (0,0,-0.2)) * 300;
	}

	if(self.vehicletype == "paladin")
	{
		return vectornormalize(param_00 + (0,0,-0.5)) * 2000;
	}

	return vectornormalize(param_00 + (0,0,-0.4)) * 1000;
}

//Function Number: 28
handleflarestimer(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00.flarestarget = param_01;
	wait(param_02);
	param_00.flarestarget = undefined;
	if(isdefined(param_00.owner) && iswarbird(param_00))
	{
		param_00.owner setclientomnvar("ui_warbird_flares",0);
	}
}

//Function Number: 29
hastag(param_00,param_01)
{
	var_02 = getnumparts(param_00);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		if(tolower(getpartname(param_00,var_03)) == tolower(param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
iswarbird(param_00)
{
	return isdefined(param_00.heli_type) && param_00.heli_type == "warbird";
}

//Function Number: 31
doproximityalarm(param_00,param_01)
{
	self endon("disconnect");
	if(shouldstopproximityalarm(param_00,param_01) || isdefined(param_01.incomingmissilesound))
	{
		return;
	}

	if(iswarbird(param_01))
	{
		self setclientomnvar("ui_warbird_flares",3);
	}

	self playlocalsound("mp_aerial_enemy_locked");
	param_01.incomingmissilesound = 1;
	for(;;)
	{
		if(shouldstopproximityalarm(param_00,param_01))
		{
			self stoplocalsound("mp_aerial_enemy_locked");
			param_01.incomingmissilesound = undefined;
			return;
		}

		wait 0.05;
	}
}

//Function Number: 32
playerfakeshootpaintmissile(param_00)
{
	var_01 = vectornormalize(anglestoforward(self getplayerangles()));
	var_02 = vectornormalize(anglestoright(self getplayerangles()));
	var_03 = self geteye() + var_01 * 100;
	var_04 = var_03 + var_01 * 20000;
	var_05 = bullettrace(var_03,var_04,0);
	if(var_05["fraction"] == 1)
	{
		return;
	}

	earthquake(0.1,1,self geteye(),500,self);
	var_03 = self geteye() + var_02 * -1 * 50;
	var_04 = var_05["position"];
	var_06 = magicbullet("paint_missile_killstreak_mp",var_03,var_04,self);
	var_06.owner = self;
	var_06 thread watchpaintgrenade();
	thread playerfiresounds(param_00,"paladin_threat_bomb_shot_2d","paladin_threat_bomb_shot_3d");
}

//Function Number: 33
playerfakeshootpaintgrenadeattarget(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 5000;
	earthquake(0.2,1,self getvieworigin(),300);
	var_06 = vectornormalize(param_02 - param_01);
	var_07 = var_06 * var_05;
	var_08 = magicgrenademanual("paint_grenade_killstreak_mp",param_01,var_07,2,self);
	var_08.owner = self;
	var_08 thread watchpaintgrenade(param_03,param_04);
	thread playerfiresounds(param_00,"recon_drn_launcher_shot_plr","recon_drn_launcher_shot_npc");
	self playrumbleonentity("damage_heavy");
}

//Function Number: 34
playerfakeshootempgrenadeattarget(param_00,param_01,param_02)
{
	var_03 = 5000;
	earthquake(0.2,1,self getvieworigin(),300);
	var_04 = vectornormalize(param_02 - param_01);
	var_05 = var_04 * var_03;
	var_06 = magicgrenademanual("emp_grenade_killstreak_mp",param_01,var_05,2,self);
	var_06.owner = self;
	thread playerfiresounds(param_00,"recon_drn_launcher_shot_plr","recon_drn_launcher_shot_npc");
	self playrumbleonentity("damage_heavy");
}

//Function Number: 35
playerfiresounds(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		param_00 playsoundonmovingent(param_02);
	}

	if(isdefined(param_01))
	{
		self playlocalsound(param_01);
	}
}

//Function Number: 36
watchpaintgrenade(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_02 = self.owner;
	var_02 endon("disconnect");
	var_02 endon("death");
	self waittill("explode",var_03);
	if(var_02 maps\mp\_utility::isemped() && isdefined(level.empequipmentdisabled) && level.empequipmentdisabled)
	{
		return;
	}

	detectiongrenadethink(var_03,var_02,param_00,param_01);
}

//Function Number: 37
detectiongrenadethink(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	foreach(var_05 in level.players)
	{
		if(!isdefined(var_05) || !maps\mp\_utility::isreallyalive(var_05) || !isalliedsentient(param_01,var_05))
		{
			continue;
		}

		thread maps\mp\_threatdetection::detection_grenade_hud_effect(var_05,param_00,1,400);
		thread maps\mp\_threatdetection::detection_highlight_hud_effect(var_05,5);
	}

	var_07 = getplayersonteam(param_01.team);
	foreach(var_05 in level.participants)
	{
		if(!isdefined(var_05) || !maps\mp\_utility::isreallyalive(var_05) || isalliedsentient(param_01,var_05) || var_05 maps\mp\_utility::_hasperk("specialty_coldblooded"))
		{
			continue;
		}

		if(distance(var_05.origin,param_00) < 400)
		{
			var_05 maps\mp\_threatdetection::addthreatevent(var_07,5,"PAINT_GRENADE",1,0);
			param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("paint");
			var_05 thread detectiongrenadewatch(param_01,5);
			var_05 notify("paint_marked_target",param_01);
			if(param_02)
			{
				maps\mp\gametypes\_weapons::flashbangplayer(var_05,param_00,param_01);
			}

			if(isdefined(param_03) && param_03.vehname == "recon_uav")
			{
				param_01 maps\mp\gametypes\_missions::processchallenge("ch_streak_recon");
			}
		}
	}
}

//Function Number: 38
detectiongrenadewatch(param_00,param_01)
{
	level endon("game_ended");
	self notify("detectionGrenadeWatch");
	self endon("detectionGrenadeWatch");
	if(!isdefined(self.tagmarkedby) || self.tagmarkedby != param_00)
	{
		if(!isdefined(level.ishorde))
		{
			param_00 thread maps\mp\_events::killstreaktagevent();
		}

		param_00 playrumbleonentity("damage_heavy");
	}

	if(!isagent(self))
	{
		self designatefoftarget(1);
	}

	self.tagmarkedby = param_00;
	common_scripts\utility::waittill_any_timeout(param_01,"death","disconnect");
	if(isdefined(self))
	{
		if(!isagent(self))
		{
			self designatefoftarget(0);
		}

		self.tagmarkedby = undefined;
	}
}

//Function Number: 39
getplayersonteam(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(var_03.hasspawned && isalive(var_03) && param_00 == var_03.team && !isplayer(self) || var_03 != self)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 40
shouldstopproximityalarm(param_00,param_01)
{
	return !isdefined(param_01) || !isdefined(param_01.player) || !isdefined(param_00) || isdefined(param_01.flarestarget) || !maps\mp\_utility::isreallyalive(self) || isdefined(param_01.crashed) || isdefined(param_01.iscrashing);
}

//Function Number: 41
heli_staticdamage(param_00,param_01,param_02)
{
	if(param_02 > 0 && isdefined(self.owner))
	{
		self.owner thread playershowstreakstaticfordamage();
	}

	if(param_02 > 0 && isdefined(self.warbirdbuddyturret) && isdefined(self.warbirdbuddyturret.owner))
	{
		self.warbirdbuddyturret.owner thread playershowstreakstaticfordamage();
	}
}

//Function Number: 42
heli_monitoremp()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		self waittill("emp_damage");
		thread heli_empgrenaded();
	}
}

//Function Number: 43
heli_empgrenaded()
{
	self notify("heli_EMPGrenaded");
	self endon("heli_EMPGrenaded");
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	self.owner endon("disconnect");
	level endon("game_ended");
	self.empgrenaded = 1;
	if(isdefined(self.mgturretleft))
	{
		self.mgturretleft notify("stop_shooting");
	}

	if(isdefined(self.mgturretright))
	{
		self.mgturretright notify("stop_shooting");
	}

	wait(3.5);
	self.empgrenaded = 0;
	if(isdefined(self.mgturretleft))
	{
		self.mgturretleft notify("turretstatechange");
	}

	if(isdefined(self.mgturretright))
	{
		self.mgturretright notify("turretstatechange");
	}
}

//Function Number: 44
heli_existance()
{
	var_00 = self getentitynumber();
	common_scripts\utility::waittill_any("death","crashing","leaving");
	removefromhelilist(var_00);
	self notify("helicopter_done");
}

//Function Number: 45
heli_crash()
{
	self notify("crashing");
	self playsoundonmovingent("orbital_pkg_self_destruct");
	self clearlookatent();
	self.iscrashing = 1;
	var_00 = heli_pick_fly_node(level.heli_crash_nodes);
	if(isdefined(self.mgturretleft))
	{
		self.mgturretleft notify("stop_shooting");
	}

	if(isdefined(self.mgturretright))
	{
		self.mgturretright notify("stop_shooting");
	}

	thread heli_spin(180);
	thread heli_secondary_explosions();
	self vehicle_setspeed(100,45);
	if(isdefined(var_00.target))
	{
		heli_fly_simple_path(var_00);
	}
	else
	{
		_setvehgoalpos(var_00.origin,0);
		self waittillmatch("goal");
	}

	thread heli_explode();
}

//Function Number: 46
heli_secondary_explosions()
{
	var_00 = self.team;
	playfxontag(level.chopper_fx["explode"]["large"],self,"tag_engine_left");
	if(isdefined(level.heli_sound[var_00]["hitsecondary"]))
	{
		self playsound(level.heli_sound[var_00]["hitsecondary"]);
	}

	wait(3);
	if(!isdefined(self))
	{
		return;
	}

	playfxontag(level.chopper_fx["explode"]["large"],self,"tag_engine_left");
	if(isdefined(level.heli_sound[var_00]["hitsecondary"]))
	{
		self playsound(level.heli_sound[var_00]["hitsecondary"]);
	}
}

//Function Number: 47
heli_spin(param_00)
{
	self endon("death");
	var_01 = self.team;
	self playsound(level.heli_sound[var_01]["hit"]);
	thread spinsoundshortly();
	self setyawspeed(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + param_00 * 0.9);
		wait(1);
	}
}

//Function Number: 48
spinsoundshortly()
{
	self endon("death");
	wait(0.25);
	var_00 = self.team;
	self stoploopsound();
	wait(0.05);
	self playloopsound(level.heli_sound[var_00]["spinloop"]);
	wait(0.05);
	if(isdefined(level.heli_sound[var_00]["spinstart"]))
	{
		self playloopsound(level.heli_sound[var_00]["spinstart"]);
	}
}

//Function Number: 49
heli_explode(param_00)
{
	self notify("death");
	if(isdefined(param_00) && isdefined(level.chopper_fx["explode"]["air_death"][self.heli_type]))
	{
		var_01 = self gettagangles("tag_deathfx");
		playfx(level.chopper_fx["explode"]["air_death"][self.heli_type],self gettagorigin("tag_deathfx"),anglestoforward(var_01),anglestoup(var_01));
	}
	else
	{
		var_02 = self.origin;
		var_03 = self.origin + (0,0,1) - self.origin;
		playfx(level.chopper_fx["explode"]["death"][self.heli_type],var_02,var_03);
	}

	var_04 = self.team;
	self playsound(level.heli_sound[var_04]["crash"]);
	wait(0.05);
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	maps\mp\_utility::decrementfauxvehiclecount();
	self delete();
}

//Function Number: 50
heli_fly_simple_path(param_00)
{
	self endon("death");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	heli_reset();
	for(var_01 = param_00;isdefined(var_01.target);var_01 = var_02)
	{
		var_02 = getentorstruct(var_01.target,"targetname");
		if(isdefined(var_01.script_airspeed) && isdefined(var_01.script_accel))
		{
			var_03 = var_01.script_airspeed;
			var_04 = var_01.script_accel;
		}
		else
		{
			var_03 = 30 + randomint(20);
			var_04 = 15 + randomint(15);
		}

		if(isdefined(self.isattacking) && self.isattacking)
		{
			wait(0.05);
			continue;
		}

		if(isdefined(self.isperformingmaneuver) && self.isperformingmaneuver)
		{
			wait(0.05);
			continue;
		}

		self vehicle_setspeed(var_03,var_04);
		if(!isdefined(var_02.target))
		{
			_setvehgoalpos(var_02.origin + self.zoffset,0);
			self waittill("near_goal");
			continue;
		}

		_setvehgoalpos(var_02.origin + self.zoffset,0);
		self waittill("near_goal");
		self setgoalyaw(var_02.angles[1]);
		self waittillmatch("goal");
	}
}

//Function Number: 51
handle_player_starting_aerial_view()
{
	self notify("player_start_aerial_view");
}

//Function Number: 52
handle_player_ending_aerial_view()
{
	self notify("player_stop_aerial_view");
}

//Function Number: 53
gethelianchor()
{
	if(isdefined(level.helianchor))
	{
		return level.helianchor;
	}

	var_00 = getentorstruct("warbird_anchor","targetname");
	if(!isdefined(var_00))
	{
		var_00 = spawnstruct();
		var_00.origin = (0,0,2032);
		var_00.targetname = "warbird_anchor";
	}

	if(!isdefined(var_00.script_noteworthy))
	{
		var_00.script_noteworthy = 3500;
	}

	level.helianchor = var_00;
	return level.helianchor;
}

//Function Number: 54
playerhandleboundarystatic(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	var_03 = getentarray("remote_heli_range","targetname");
	if(!isdefined(param_00.vehicletype) || var_03.size == 0)
	{
		playerhandleboundarystaticradius(param_00,param_01,param_02);
		return;
	}

	for(;;)
	{
		var_04 = 0;
		if(isdefined(level.isoutofboundscustomfunc))
		{
			var_04 = [[ level.isoutofboundscustomfunc ]](param_00,self,var_03);
		}
		else
		{
			var_04 = param_00 vehicletouchinganytrigger(var_03);
		}

		if(var_04)
		{
			thread playerstartoutofboundsstatic(param_00,param_01,param_02);
			for(;;)
			{
				wait 0.05;
				if(!isdefined(param_00.alwaysstaticout) || !param_00.alwaysstaticout)
				{
					var_04 = 0;
					if(isdefined(level.isoutofboundscustomfunc))
					{
						var_04 = [[ level.isoutofboundscustomfunc ]](param_00,self,var_03);
					}
					else
					{
						var_04 = param_00 vehicletouchinganytrigger(var_03);
					}

					if(!var_04)
					{
						param_00 notify("staticDone");
						thread playerstatictonormal(param_00,param_01,param_02);
						break;
					}
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 55
vehicletouchinganytrigger(param_00)
{
	foreach(var_02 in param_00)
	{
		if(self istouching(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 56
playerstatictonormal(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	param_00 endon("staticStarting");
	param_00.staticlevel--;
	while(param_00.staticlevel > 0)
	{
		playershowstreakstaticforrange(param_00.staticlevel);
		if(isdefined(param_00.buddy))
		{
			param_00.buddy playershowstreakstaticforrange(param_00.staticlevel);
		}

		wait(0.5);
		param_00.staticlevel--;
	}

	playershowstreakstaticforrange(0);
	if(isdefined(param_00.buddy))
	{
		param_00.buddy playershowstreakstaticforrange(0);
	}
}

//Function Number: 57
playerstartoutofboundsstatic(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	param_00 notify("staticStarting");
	param_00 endon("staticDone");
	if(!isdefined(param_00.staticlevel) || param_00.staticlevel == 0)
	{
		param_00.staticlevel = 1;
	}

	while(param_00.staticlevel < 4)
	{
		playershowstreakstaticforrange(param_00.staticlevel);
		if(isdefined(param_00.buddy))
		{
			param_00.buddy playershowstreakstaticforrange(param_00.staticlevel);
		}

		if(isdefined(param_00.playerattachpoint))
		{
			param_00.playerattachpoint playsound("mp_warbird_outofbounds_warning");
		}

		if(isdefined(param_00.staticlevelwaittime))
		{
			wait(param_00.staticlevelwaittime);
			continue;
		}

		wait(2);
		param_00.staticlevel++;
	}

	param_00 notify("outOfBounds");
}

//Function Number: 58
playerhandleboundarystaticradius(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	var_03 = gethelianchor();
	var_04 = int(var_03.script_noteworthy);
	for(;;)
	{
		var_05 = distance(var_03.origin,param_00.origin);
		if(var_05 < var_04)
		{
			playershowstreakstaticforrange(0);
		}
		else if(var_05 > var_04 && var_05 < var_04 + 500)
		{
			playershowstreakstaticforrange(1);
			if(isdefined(param_00.playerattachpoint))
			{
				param_00.playerattachpoint playsound("mp_warbird_outofbounds_warning");
			}
		}
		else if(var_05 > var_04 + 500 && var_05 < var_04 + 1000)
		{
			playershowstreakstaticforrange(2);
			if(isdefined(param_00.playerattachpoint))
			{
				param_00.playerattachpoint playsound("mp_warbird_outofbounds_warning");
			}
		}
		else if(var_05 > var_04 + 1000 && var_05 < var_04 + 1500)
		{
			playershowstreakstaticforrange(3);
			if(isdefined(param_00.playerattachpoint))
			{
				param_00.playerattachpoint playsound("mp_warbird_outofbounds_warning");
			}
		}
		else
		{
			playershowstreakstaticforrange(4);
			param_00 notify("outOfBounds");
		}

		wait(0.5);
	}
}

//Function Number: 59
playerenablestreakstatic()
{
	self notify("playerUpdateStreakStatic");
	self setclientomnvar("ui_streak_overlay_state",1);
}

//Function Number: 60
playerdisablestreakstatic()
{
	self notify("playerUpdateStreakStatic");
	self setclientomnvar("ui_streak_overlay_state",0);
}

//Function Number: 61
playershowfullstatic()
{
	self notify("playerUpdateStreakStatic");
	self setclientomnvar("ui_streak_overlay_state",7);
}

//Function Number: 62
playershowstreakstaticfordamage()
{
	self endon("disconnect");
	if(self getclientomnvar("ui_streak_overlay_state") != 1)
	{
		return;
	}

	self notify("playerUpdateStreakStatic");
	self endon("playerUpdateStreakStatic");
	self setclientomnvar("ui_streak_overlay_state",2);
	wait(1);
	self setclientomnvar("ui_streak_overlay_state",1);
}

//Function Number: 63
playershowstreakstaticforrange(param_00)
{
	var_01 = 1;
	switch(param_00)
	{
		case 0:
			var_01 = 1;
			break;

		case 1:
			var_01 = 3;
			break;

		case 2:
			var_01 = 4;
			break;

		case 3:
			var_01 = 5;
			break;

		case 4:
			var_01 = 6;
			break;

		default:
			break;
	}

	self notify("playerUpdateStreakStatic");
	self setclientomnvar("ui_streak_overlay_state",var_01);
}

//Function Number: 64
getentorstruct(param_00,param_01)
{
	var_02 = getent(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	return common_scripts\utility::getstruct(param_00,param_01);
}

//Function Number: 65
getentorstructarray(param_00,param_01)
{
	var_02 = common_scripts\utility::getstructarray(param_00,param_01);
	var_03 = getentarray(param_00,param_01);
	if(var_03.size > 0)
	{
		var_02 = common_scripts\utility::array_combine(var_02,var_03);
	}

	return var_02;
}

//Function Number: 66
playerhandlekillvehicle(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	if(!isdefined(level.vehicle_kill_triggers))
	{
		return;
	}

	for(;;)
	{
		var_03 = param_00 vehicletouchinganytrigger(level.vehicle_kill_triggers);
		if(var_03)
		{
			param_00 notify("death");
		}

		wait 0.05;
	}
}

//Function Number: 67
setup_kill_drone_trig(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getentarray(param_00,param_01);
		common_scripts\utility::array_thread(var_02,::setup_kill_drone_trig_proc);
		return;
	}

	if(isvehiclekilltrigger())
	{
		setup_kill_drone_trig_proc();
	}
}

//Function Number: 68
setup_kill_drone_trig_proc()
{
	if(isvehiclekilltrigger())
	{
		if(!isdefined(level.vehicle_kill_triggers))
		{
			level.vehicle_kill_triggers = [];
		}

		level.vehicle_kill_triggers[level.vehicle_kill_triggers.size] = self;
	}
}

//Function Number: 69
isvehiclekilltrigger()
{
	if(isdefined(self.classname) && issubstr(self.classname,"trigger_multiple") && isdefined(self.spawnflags) && self.spawnflags & 16)
	{
		return 1;
	}

	return 0;
}

//Function Number: 70
vehicleiscloaked()
{
	return isdefined(self.cloakstate) && self.cloakstate < 1;
}

//Function Number: 71
thermalvision(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon(param_00);
	var_07 = 0;
	disableorbitalthermal(self);
	self visionsetthermalforplayer("default",0.25);
	self setclientomnvar("ui_killstreak_optic",0);
	if(isbot(self))
	{
		return;
	}

	self notifyonplayercommand("switch thermal","+actionslot 1");
	thread playercleanupthermalvisioncommands(param_00);
	for(;;)
	{
		self waittill("switch thermal");
		if(!var_07)
		{
			enableorbitalthermal(self,param_00,param_01,param_02,param_03,param_04,param_05,param_06);
			self setclientomnvar("ui_killstreak_optic",1);
			self playlocalsound("paladin_toggle_flir_plr");
		}
		else
		{
			disableorbitalthermal(self);
			self setclientomnvar("ui_killstreak_optic",0);
			self playlocalsound("paladin_toggle_flir_plr");
		}

		var_07 = !var_07;
	}
}

//Function Number: 72
playercleanupthermalvisioncommands(param_00)
{
	self endon("disconnect");
	self waittill(param_00);
	self notifyonplayercommandremove("switch thermal","+actionslot 1");
}

//Function Number: 73
disableorbitalthermal(param_00)
{
	param_00 thermalvisionoff();
	param_00 notify("thermal_vision_off");
	param_00 disablephysicaldepthoffieldscripting();
	param_00.orbitalthermalmode = 0;
}

//Function Number: 74
enableorbitalthermal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("faux_spawn");
	param_00 endon(param_01);
	if(!isdefined(param_00.opticsthermalenabled))
	{
		param_00.opticsthermalenabled = 0;
	}

	if(!isdefined(param_00.orbitalthermalmode))
	{
		param_00.orbitalthermalmode = 0;
	}

	param_00.orbitalthermalmode = 1;
	while(param_00.opticsthermalenabled)
	{
		wait(0.05);
	}

	param_00 thermalvisionon();
	param_00 enablephysicaldepthoffieldscripting(3);
	param_00 thread setthermaldof(param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 75
setthermaldof(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon(param_00);
	self endon("disconnect");
	self endon("thermal_vision_off");
	for(;;)
	{
		var_07 = self playerads();
		var_08 = float_lerp(param_03,param_01,var_07);
		var_09 = float_lerp(param_04,param_02,var_07);
		self setphysicaldepthoffield(var_08,var_09,param_05,param_06);
		wait(0.1);
	}
}

//Function Number: 76
float_lerp(param_00,param_01,param_02)
{
	return param_00 + param_02 * param_01 - param_00;
}

//Function Number: 77
patchheliloopnode(param_00,param_01)
{
	var_02 = [];
	var_03 = getentorstruct("heli_loop_start","targetname");
	for(;;)
	{
		if(common_scripts\utility::array_contains(var_02,var_03))
		{
			break;
		}

		if(var_03.origin == param_00)
		{
			var_03.origin = param_01;
			return;
		}

		var_02[var_02.size] = var_03;
		var_03 = getentorstruct(var_03.target,"targetname");
	}
}