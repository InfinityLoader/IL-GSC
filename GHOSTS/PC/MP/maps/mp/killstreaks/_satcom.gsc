/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_satcom.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 462 ms
 * Timestamp: 10/27/2023 1:21:39 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.uplinks = [];
	level.killstreakfuncs["uplink"] = ::tryuseuplink;
	level.killstreakfuncs["uplink_support"] = ::tryuseuplink;
	level.comexpfuncs = [];
	level.comexpfuncs["giveComExpBenefits"] = ::func_3CE5;
	level.comexpfuncs["removeComExpBenefits"] = ::func_6582;
	level.comexpfuncs["getRadarStrengthForTeam"] = ::func_3BB0;
	level.comexpfuncs["getRadarStrengthForPlayer"] = ::getradarstrengthforplayer;
	unblockteamradar("axis");
	unblockteamradar("allies");
	level thread func_8762();
	level thread func_8763();
	var_00 = spawnstruct();
	var_00.streakname = "uplink";
	var_00.weaponinfo = "ims_projectile_mp";
	var_00.modelbase = "mp_satcom";
	var_00.modelplacement = "mp_satcom_obj";
	var_00.modelplacementfailed = "mp_satcom_obj_red";
	var_00.modelbombsquad = "mp_satcom_bombsquad";
	var_00.hintstring = &"KILLSTREAKS_HINTS_UPLINK_PICKUP";
	var_00.placestring = &"KILLSTREAKS_HINTS_UPLINK_PLACE";
	var_00.cannotplacestring = &"KILLSTREAKS_HINTS_UPLINK_CANNOT_PLACE";
	var_00.headiconheight = 42;
	var_00.splashname = "used_uplink";
	var_00.lifespan = 30;
	var_00.maxhealth = 500;
	var_00.allowmeleedamage = 1;
	var_00.allowempdamage = 1;
	var_00.damagefeedback = "trophy";
	var_00.xppopup = "destroyed_uplink";
	var_00.destroyedvo = "satcom_destroyed";
	var_00.placementheighttolerance = 30;
	var_00.placementradius = 16;
	var_00.placementoffsetz = 16;
	var_00.onplaceddelegate = ::func_595A;
	var_00.oncarrieddelegate = ::func_5902;
	var_00.placedsfx = "mp_killstreak_satcom_deploy";
	var_00.activesfx = "mp_killstreak_satcom_loop";
	var_00.onmovingplatformcollision = ::uplink_override_moving_platform_death;
	var_00.ondeathdelegate = ::ondeath;
	var_00.ondestroyeddelegate = ::func_5915;
	var_00.deathvfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death");
	level.placeableconfigs["uplink"] = var_00;
	level.placeableconfigs["uplink_support"] = var_00;
}

//Function Number: 2
func_8762()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("update_uplink");
		level childthread func_86C8();
	}
}

//Function Number: 3
func_86C8()
{
	self notify("updateAllUplinkThreads");
	self endon("updateAllUplinkThreads");
	level childthread func_9079();
	if(level.teambased)
	{
		level childthread func_8745("axis");
		level childthread func_8745("allies");
	}
	else
	{
		level childthread func_8714();
	}

	level childthread func_86DB();
}

//Function Number: 4
func_9079()
{
	var_00 = [];
	if(!level.teambased)
	{
		level waittill("radar_status_change_players");
	}
	else
	{
		while(var_00.size < 2)
		{
			level waittill("radar_status_change",var_01);
			var_00[var_00.size] = var_01;
		}
	}

	level notify("start_com_exp");
}

//Function Number: 5
func_8745(param_00)
{
	var_01 = func_3BB0(param_00);
	var_02 = var_01 == 1;
	var_03 = var_01 >= 2;
	var_04 = var_01 >= 3;
	var_05 = var_01 >= 4;
	if(var_03)
	{
		unblockteamradar(param_00);
	}

	if(var_04)
	{
		level.radarmode[param_00] = "fast_radar";
	}
	else
	{
		level.radarmode[param_00] = "normal_radar";
	}

	foreach(var_07 in level.participants)
	{
		if(!isdefined(var_07))
		{
			continue;
		}

		if(var_07.team != param_00)
		{
			continue;
		}

		var_07.shouldbeeyeson = var_02;
		var_07 seteyesonuplinkenabled(var_02);
		var_07.radarmode = level.radarmode[var_07.team];
		var_07.radarshowenemydirection = var_05;
		var_07 updatesatcomactiveomnvar(param_00);
		wait(0.05);
	}

	setteamradar(param_00,var_03);
	level notify("radar_status_change",param_00);
}

//Function Number: 6
func_8714()
{
	foreach(var_01 in level.participants)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = getradarstrengthforplayer(var_01);
		func_709E(var_01,var_02);
		var_01 updatesatcomactiveomnvar();
		wait(0.05);
	}

	level notify("radar_status_change_players");
}

//Function Number: 7
func_86DB()
{
	level waittill("start_com_exp");
	foreach(var_01 in level.participants)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 func_3CE5();
		wait(0.05);
	}
}

//Function Number: 8
func_3CE5()
{
	if(maps\mp\_utility::_hasperk("specialty_comexp"))
	{
		var_00 = getradarstrengthforcomexp(self);
		func_709E(self,var_00);
		updatesatcomactiveomnvar();
	}
}

//Function Number: 9
updatesatcomactiveomnvar(param_00)
{
	var_01 = 0;
	if(isdefined(param_00))
	{
		var_01 = func_3BB0(param_00);
	}
	else
	{
		var_01 = getradarstrengthforplayer(self);
	}

	if(maps\mp\_utility::_hasperk("specialty_comexp"))
	{
		var_01 = getradarstrengthforcomexp(self);
	}

	if(var_01 > 0)
	{
		self setclientomnvar("ui_satcom_active",1);
	}

	self setclientomnvar("ui_satcom_active",0);
}

//Function Number: 10
func_6582()
{
	self.shouldbeeyeson = 0;
	self seteyesonuplinkenabled(0);
	self.radarshowenemydirection = 0;
	self.radarmode = "normal_radar";
	self.hasradar = 0;
	self.isradarblocked = 0;
}

//Function Number: 11
func_709E(param_00,param_01)
{
	var_02 = param_01 == 1;
	var_03 = param_01 >= 2;
	var_04 = param_01 >= 3;
	var_05 = param_01 >= 4;
	param_00.shouldbeeyeson = var_02;
	param_00 seteyesonuplinkenabled(var_02);
	param_00.radarshowenemydirection = var_05;
	param_00.radarmode = "normal_radar";
	param_00.hasradar = var_03;
	param_00.isradarblocked = 0;
	if(var_04)
	{
		param_00.radarmode = "fast_radar";
	}
}

//Function Number: 12
tryuseuplink(param_00,param_01)
{
	var_02 = lib_0614::func_3CFF(param_01);
	if(var_02)
	{
		maps\mp\_matchdata::func_4F1D("uplink",self.origin);
	}

	self.iscarrying = undefined;
	return var_02;
}

//Function Number: 13
func_5902(param_00)
{
	var_01 = self getentitynumber();
	if(isdefined(level.uplinks[var_01]))
	{
		func_7C77();
	}
}

//Function Number: 14
func_595A(param_00)
{
	var_01 = level.placeableconfigs[param_00];
	self.owner notify("uplink_deployed");
	self setmodel(var_01.modelbase);
	self.immediatedeath = 0;
	self setotherent(self.owner);
	common_scripts\utility::func_5009(self.owner.team,1);
	self.config = var_01;
	func_7AFB(1);
	thread func_8CDF();
}

//Function Number: 15
func_7AFB(param_00)
{
	adduplinktolevellist(self);
	thread playuplinkanimations(param_00);
	self playloopsound(self.config.activesfx);
}

//Function Number: 16
func_7C77()
{
	maps\mp\gametypes\_weapons::func_7C5B();
	self scriptmodelclearanim();
	if(isdefined(self.bombsquadmodel))
	{
		self.bombsquadmodel scriptmodelclearanim();
	}

	func_65BB(self);
	self stoploopsound();
}

//Function Number: 17
playuplinkanimations(param_00)
{
	self endon("emp_damage");
	self endon("death");
	self endon("carried");
	if(param_00)
	{
		var_01 = getnotetracktimes(%satcom_killstreak,"stop anim");
		var_02 = getanimlength(%satcom_killstreak);
		self scriptmodelplayanim("Satcom_killStreak");
		if(isdefined(self.bombsquadmodel))
		{
			self.bombsquadmodel scriptmodelplayanim("Satcom_killStreak");
		}

		wait(var_01[0] * var_02);
	}

	self scriptmodelplayanim("Satcom_killStreak_idle");
	if(isdefined(self.bombsquadmodel))
	{
		self.bombsquadmodel scriptmodelplayanim("Satcom_killStreak_idle");
	}

	thread maps\mp\gametypes\_weapons::doblinkinglight("tag_fx");
}

//Function Number: 18
func_5915(param_00,param_01,param_02,param_03)
{
	param_01 notify("destroyed_equipment");
}

//Function Number: 19
ondeath(param_00,param_01,param_02,param_03)
{
	maps\mp\gametypes\_weapons::func_7C5B();
	maps\mp\gametypes\_weapons::equipmentdeathvfx();
	func_65BB(self);
	self scriptmodelclearanim();
	if(!self.immediatedeath)
	{
		wait(3);
	}

	maps\mp\gametypes\_weapons::equipmentdeletevfx();
}

//Function Number: 20
adduplinktolevellist(param_00)
{
	var_01 = param_00 getentitynumber();
	level.uplinks[var_01] = param_00;
	level notify("update_uplink");
}

//Function Number: 21
func_65BB(param_00)
{
	var_01 = param_00 getentitynumber();
	level.uplinks[var_01] = undefined;
	level notify("update_uplink");
}

//Function Number: 22
func_3BB0(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.uplinks)
	{
		if(isdefined(var_03) && var_03.team == param_00)
		{
			var_01++;
		}
	}

	if(var_01 == 0 && isdefined(level.helisnipereyeson) && level.helisnipereyeson.team == param_00)
	{
		var_01++;
	}

	return clamp(var_01,0,4);
}

//Function Number: 23
getradarstrengthforplayer(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.uplinks)
	{
		if(isdefined(var_03))
		{
			if(isdefined(var_03.owner))
			{
				if(var_03.owner.guid == param_00.guid)
				{
					var_01++;
				}

				continue;
			}

			var_04 = var_03 getentitynumber();
			level.uplinks[var_04] = undefined;
		}
	}

	if(!level.teambased && var_01 > 0)
	{
		var_01++;
	}

	return clamp(var_01,0,4);
}

//Function Number: 24
getradarstrengthforcomexp(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.uplinks)
	{
		if(isdefined(var_03))
		{
			var_01++;
		}
	}

	if(!level.teambased && var_01 > 0)
	{
		var_01++;
	}

	return clamp(var_01,0,4);
}

//Function Number: 25
uplink_override_moving_platform_death(param_00)
{
	self.immediatedeath = 1;
	self notify("death");
}

//Function Number: 26
func_8CDF()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		maps\mp\gametypes\_weapons::equipmentempstunvfx();
		func_7C77();
		wait(var_01);
		func_7AFB(0);
	}
}

//Function Number: 27
func_8763()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		var_01 = isdefined(var_00.shouldbeeyeson) && var_00.shouldbeeyeson;
		var_00 seteyesonuplinkenabled(var_01);
	}
}