/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_deployablebox.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 508 ms
 * Timestamp: 10/27/2023 2:13:57 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["deployable_vest"] = ::tryusedeployablevest;
	level.boxsettings = [];
	level.boxsettings["deployable_vest"] = spawnstruct();
	level.boxsettings["deployable_vest"].weaponinfo = "deployable_vest_marker_mp";
	level.boxsettings["deployable_vest"].modelbase = "com_deploy_ballistic_vest_friend_world";
	level.boxsettings["deployable_vest"].hintstring = &"MP_LIGHT_ARMOR_PICKUP";
	level.boxsettings["deployable_vest"].capturingstring = &"MP_BOX_GETTING_VEST";
	level.boxsettings["deployable_vest"].eventstring = &"MP_DEPLOYED_VEST";
	level.boxsettings["deployable_vest"].streakname = "deployable_vest";
	level.boxsettings["deployable_vest"].splashname = "used_deployable_vest";
	level.boxsettings["deployable_vest"].shadername = "compass_objpoint_deploy_friendly";
	level.boxsettings["deployable_vest"].lifespan = 60;
	level.boxsettings["deployable_vest"].xp = 50;
	level.boxsettings["deployable_vest"].vodestroyed = "ballistic_vest_destroyed";
	foreach(var_01 in level.boxsettings)
	{
		precacheitem(var_01.weaponinfo);
		precachemodel(var_01.modelbase);
		precachestring(var_01.hintstring);
		precachestring(var_01.capturingstring);
		precachestring(var_01.eventstring);
		precacheshader(var_01.shadername);
	}

	precachestring(&"PLATFORM_HOLD_TO_USE");
	level._effect["box_explode_mp"] = loadfx("fire/ballistic_vest_death");
}

//Function Number: 2
tryusedeployablevest(param_00)
{
	var_01 = begindeployableviamarker(param_00,"deployable_vest");
	if(!isdefined(var_01) || !var_01)
	{
		return 0;
	}

	maps\mp\_matchdata::logkillstreakevent("deployable_vest",self.origin);
	return 1;
}

//Function Number: 3
begindeployableviamarker(param_00,param_01)
{
	self endon("death");
	self.marker = undefined;
	thread watchmarkerusage(param_00,param_01);
	var_02 = self getcurrentweapon();
	if(ismarker(var_02))
	{
		var_03 = var_02;
	}
	else
	{
		var_03 = undefined;
	}

	while(ismarker(var_02))
	{
		self waittill("weapon_change",var_02);
		if(ismarker(var_02))
		{
			var_03 = var_02;
		}
	}

	self notify("stopWatchingMarker");
	if(!isdefined(var_03))
	{
		return 0;
	}

	return !self getammocount(var_03) && self hasweapon(var_03);
}

//Function Number: 4
watchmarkerusage(param_00,param_01)
{
	self notify("watchMarkerUsage");
	self endon("death");
	self endon("disconnect");
	self endon("watchMarkerUsage");
	self endon("stopWatchingMarker");
	thread watchmarker(param_00,param_01);
	for(;;)
	{
		self waittill("grenade_pullback",var_02);
		if(!ismarker(var_02))
		{
			continue;
		}

		common_scripts\utility::_disableusability();
		beginmarkertracking();
	}
}

//Function Number: 5
watchmarker(param_00,param_01)
{
	self notify("watchMarker");
	self endon("watchMarker");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("stopWatchingMarker");
	for(;;)
	{
		self waittill("grenade_fire",var_02,var_03);
		if(!ismarker(var_03))
		{
			continue;
		}

		if(!isalive(self))
		{
			var_02 delete();
			return;
		}

		var_02.owner = self;
		var_02.weaponname = var_03;
		self.marker = var_02;
		thread takeweapononstuck(var_02,var_03);
		var_02 thread markeractivate(param_00,param_01,::box_setactive);
	}
}

//Function Number: 6
takeweapononstuck(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 playsoundtoplayer("mp_vest_deployed_ui",self);
	if(self hasweapon(param_01))
	{
		self takeweapon(param_01);
		self switchtoweapon(common_scripts\utility::getlastweapon());
	}
}

//Function Number: 7
beginmarkertracking()
{
	self notify("beginMarkerTracking");
	self endon("beginMarkerTracking");
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("grenade_fire","weapon_change");
	common_scripts\utility::_enableusability();
}

//Function Number: 8
markeractivate(param_00,param_01,param_02)
{
	self notify("markerActivate");
	self endon("markerActivate");
	self waittill("missile_stuck");
	var_03 = self.owner;
	var_04 = self.origin;
	if(!isdefined(var_03))
	{
		return;
	}

	var_05 = createboxforplayer(param_01,var_04,var_03);
	wait 0.05;
	var_05 thread [[ param_02 ]]();
	self delete();
}

//Function Number: 9
ismarker(param_00)
{
	switch(param_00)
	{
		case "deployable_vest_marker_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 10
createboxforplayer(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_01);
	var_03 setmodel(level.boxsettings[param_00].modelbase);
	var_03.health = 1000;
	var_03.angles = param_02.angles;
	var_03.boxtype = param_00;
	var_03.owner = param_02;
	var_03.team = param_02.team;
	var_03 box_setinactive();
	var_03 thread box_handleownerdisconnect();
	return var_03;
}

//Function Number: 11
box_setactive()
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.boxsettings[self.boxtype].hintstring);
	self.inuse = 0;
	if(level.teambased)
	{
		var_00 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_00,"invisible",(0,0,0));
		objective_position(var_00,self.origin);
		objective_state(var_00,"active");
		objective_icon(var_00,level.boxsettings[self.boxtype].shadername);
		objective_team(var_00,self.team);
		self.objidfriendly = var_00;
		foreach(var_02 in level.players)
		{
			if(self.team == var_02.team && !var_02 maps\mp\_utility::isjuggernaut())
			{
				maps\mp\_entityheadicons::setheadicon(var_02,maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(level.boxsettings[self.boxtype].streakname),(0,0,20),14,14,undefined,undefined,undefined,undefined,undefined,0);
			}
		}
	}
	else
	{
		var_00 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_00,"invisible",(0,0,0));
		objective_position(var_00,self.origin);
		objective_state(var_00,"active");
		objective_icon(var_00,level.boxsettings[self.boxtype].shadername);
		objective_player(var_00,self.owner getentitynumber());
		self.objidfriendly = var_00;
		if(!self.owner maps\mp\_utility::isjuggernaut())
		{
			maps\mp\_entityheadicons::setheadicon(self.owner,maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(level.boxsettings[self.boxtype].streakname),(0,0,20),14,14,undefined,undefined,undefined,undefined,undefined,0);
		}
	}

	self makeusable();
	self.isusable = 1;
	self setcandamage(1);
	thread box_handledamage();
	thread box_handledeath();
	thread box_timeout();
	thread disablewhenjuggernaut();
	foreach(var_02 in level.players)
	{
		if(level.teambased)
		{
			if(self.team == var_02.team)
			{
				if(var_02 maps\mp\_utility::isjuggernaut())
				{
					self disableplayeruse(var_02);
					thread doubledip(var_02);
				}
				else
				{
					self enableplayeruse(var_02);
				}

				thread boxthink(var_02);
			}
			else
			{
				self disableplayeruse(var_02);
			}

			thread box_playerjoinedteam(var_02);
			continue;
		}

		if(isdefined(self.owner) && self.owner == var_02)
		{
			if(var_02 maps\mp\_utility::isjuggernaut())
			{
				self disableplayeruse(var_02);
				thread doubledip(var_02);
			}
			else
			{
				self enableplayeruse(var_02);
			}

			thread boxthink(var_02);
			continue;
		}

		self disableplayeruse(var_02);
	}

	level thread maps\mp\_utility::teamplayercardsplash(level.boxsettings[self.boxtype].splashname,self.owner,self.team);
	thread box_playerconnected();
}

//Function Number: 12
box_playerconnected()
{
	self endon("death");
	level waittill("connected",var_00);
	var_00 waittill("spawned_player");
	if(level.teambased)
	{
		if(self.team == var_00.team)
		{
			self enableplayeruse(var_00);
			thread boxthink(var_00);
			maps\mp\_entityheadicons::setheadicon(var_00,maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(level.boxsettings[self.boxtype].streakname),(0,0,20),14,14,undefined,undefined,undefined,undefined,undefined,0);
			return;
		}

		self disableplayeruse(var_00);
		maps\mp\_entityheadicons::setheadicon(var_00,"",(0,0,0));
	}
}

//Function Number: 13
box_playerjoinedteam(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("joined_team");
		if(level.teambased)
		{
			if(self.team == param_00.team)
			{
				self enableplayeruse(param_00);
				thread boxthink(param_00);
				maps\mp\_entityheadicons::setheadicon(param_00,maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(level.boxsettings[self.boxtype].streakname),(0,0,20),14,14,undefined,undefined,undefined,undefined,undefined,0);
				continue;
			}

			self disableplayeruse(param_00);
			maps\mp\_entityheadicons::setheadicon(param_00,"",(0,0,0));
		}
	}
}

//Function Number: 14
box_setinactive()
{
	self makeunusable();
	self.isusable = 0;
	maps\mp\_entityheadicons::setheadicon("none","",(0,0,0));
	if(isdefined(self.objidfriendly))
	{
		maps\mp\_utility::_objective_delete(self.objidfriendly);
	}
}

//Function Number: 15
box_handledamage()
{
	self.health = 999999;
	self.maxhealth = 300;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_01))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "flash_grenade_mp":
				case "smoke_grenade_mp":
				case "concussion_grenade_mp":
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
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("deployable_bag");
			if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
			{
				if(var_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
				{
					var_0A = var_0A + var_00 * level.armorpiercingmod;
				}
			}
		}

		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			var_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("deployable_bag");
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "javelin_mp":
				case "stinger_mp":
				case "remote_mortar_missile_mp":
				case "remotemissile_projectile_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
					self.var_30C8 = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "stealth_bomb_mp":
				case "artillery_mp":
					self.var_30C8 = 0;
					var_0A = var_0A + var_00 * 4;
					break;
	
				case "bomb_site_mp":
					self.var_30C8 = 0;
					var_0A = self.maxhealth + 1;
					break;
			}
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				var_01 thread maps\mp\gametypes\_rank::giverankxp("kill",100,var_09,var_04);
				var_01 notify("destroyed_killstreak");
			}

			if(isdefined(self.owner))
			{
				self.owner thread maps\mp\_utility::leaderdialogonplayer(level.boxsettings[self.boxtype].vodestroyed);
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 16
box_handledeath()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	box_setinactive();
	playfx(common_scripts\utility::getfx("box_explode_mp"),self.origin);
	wait 0.5;
	self notify("deleting");
	self delete();
}

//Function Number: 17
box_handleownerdisconnect()
{
	self endon("death");
	level endon("game_ended");
	self notify("box_handleOwner");
	self endon("box_handleOwner");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 18
boxthink(param_00)
{
	self endon("death");
	thread boxcapturethink(param_00);
	for(;;)
	{
		self waittill("captured",var_01);
		if(var_01 != param_00)
		{
			continue;
		}

		switch(self.boxtype)
		{
			case "deployable_vest":
				param_00 playlocalsound("ammo_crate_use");
				param_00 [[ level.killstreakfuncs["light_armor"] ]]();
				break;
		}

		if(isdefined(self.owner) && param_00 != self.owner)
		{
			self.owner thread maps\mp\gametypes\_rank::func_2F45(level.boxsettings[self.boxtype].eventstring);
			self.owner thread maps\mp\gametypes\_rank::giverankxp("support",level.boxsettings[self.boxtype].xp);
		}

		maps\mp\_entityheadicons::setheadicon(param_00,"",(0,0,0));
		self disableplayeruse(param_00);
		thread doubledip(param_00);
	}
}

//Function Number: 19
doubledip(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("death");
	if(level.teambased)
	{
		if(self.team == param_00.team)
		{
			maps\mp\_entityheadicons::setheadicon(param_00,maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(level.boxsettings[self.boxtype].streakname),(0,0,20),14,14,undefined,undefined,undefined,undefined,undefined,0);
			self enableplayeruse(param_00);
			return;
		}

		return;
	}

	if(isdefined(self.owner) && self.owner == param_00)
	{
		maps\mp\_entityheadicons::setheadicon(param_00,maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon(level.boxsettings[self.boxtype].streakname),(0,0,20),14,14,undefined,undefined,undefined,undefined,undefined,0);
		self enableplayeruse(param_00);
	}
}

//Function Number: 20
boxcapturethink(param_00)
{
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(var_01 != param_00)
		{
			continue;
		}

		if(!useholdthink(param_00,2000))
		{
			continue;
		}

		self notify("captured",param_00);
	}
}

//Function Number: 21
isfriendlytobox(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 22
box_timeout()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.boxsettings[self.boxtype].lifespan;
	while(var_00)
	{
		wait 1;
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		if(!isdefined(self.carriedby))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	self notify("death");
}

//Function Number: 23
deleteonownerdeath(param_00)
{
	wait 0.25;
	self linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00 waittill("death");
	self delete();
}

//Function Number: 24
box_modelteamupdater(param_00)
{
	self endon("death");
	self hide();
	foreach(var_02 in level.players)
	{
		if(var_02.team == param_00)
		{
			self showtoplayer(var_02);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_02 in level.players)
		{
			if(var_02.team == param_00)
			{
				self showtoplayer(var_02);
			}
		}
	}
}

//Function Number: 25
useholdthink(param_00,param_01)
{
	param_00 playerlinkto(self);
	param_00 playerlinkedoffsetenable();
	param_00 common_scripts\utility::_disableweapon();
	param_00.boxparams = spawnstruct();
	param_00.boxparams.curprogress = 0;
	param_00.boxparams.inuse = 1;
	param_00.boxparams.userate = 0;
	if(isdefined(param_01))
	{
		param_00.boxparams.usetime = param_01;
	}
	else
	{
		param_00.boxparams.usetime = 3000;
	}

	param_00 thread personalusebar(self);
	var_02 = useholdthinkloop(param_00);
	if(isalive(param_00))
	{
		param_00 common_scripts\utility::_enableweapon();
		param_00 unlink();
	}

	if(!isdefined(self))
	{
		return 0;
	}

	param_00.boxparams.inuse = 0;
	param_00.boxparams.curprogress = 0;
	return var_02;
}

//Function Number: 26
personalusebar(param_00)
{
	self endon("disconnect");
	var_01 = maps\mp\gametypes\_hud_util::createprimaryprogressbar(0,25);
	var_02 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,25);
	var_02 settext(level.boxsettings[param_00.boxtype].capturingstring);
	var_03 = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(param_00) && self.boxparams.inuse && param_00.isusable && !level.gameended)
	{
		if(var_03 != self.boxparams.userate)
		{
			if(self.boxparams.curprogress > self.boxparams.usetime)
			{
				self.boxparams.curprogress = self.boxparams.usetime;
			}

			var_01 maps\mp\gametypes\_hud_util::updatebar(self.boxparams.curprogress / self.boxparams.usetime,1000 / self.boxparams.usetime * self.boxparams.userate);
			if(!self.boxparams.userate)
			{
				var_01 maps\mp\gametypes\_hud_util::hideelem();
				var_02 maps\mp\gametypes\_hud_util::hideelem();
			}
			else
			{
				var_01 maps\mp\gametypes\_hud_util::showelem();
				var_02 maps\mp\gametypes\_hud_util::showelem();
			}
		}

		var_03 = self.boxparams.userate;
		wait 0.05;
	}

	var_01 maps\mp\gametypes\_hud_util::destroyelem();
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 27
useholdthinkloop(param_00)
{
	while(!level.gameended && isdefined(self) && maps\mp\_utility::isreallyalive(param_00) && param_00 usebuttonpressed() && param_00.boxparams.curprogress < param_00.boxparams.usetime)
	{
		param_00.boxparams.curprogress = param_00.boxparams.curprogress + 50 * param_00.boxparams.userate;
		if(isdefined(param_00.objectivescaler))
		{
			param_00.boxparams.userate = 1 * param_00.objectivescaler;
		}
		else
		{
			param_00.boxparams.userate = 1;
		}

		if(param_00.boxparams.curprogress >= param_00.boxparams.usetime)
		{
			return maps\mp\_utility::isreallyalive(param_00);
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 28
disablewhenjuggernaut()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("juggernaut_equipped",var_00);
		maps\mp\_entityheadicons::setheadicon(var_00,"",(0,0,0));
		self disableplayeruse(var_00);
		thread doubledip(var_00);
	}
}