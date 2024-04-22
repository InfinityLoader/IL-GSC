/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_dam.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 372 ms
 * Timestamp: 4/22/2024 2:12:31 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["mp_dam"] = ::tryusedamkillstreak;
	level.mapkillstreak = "mp_dam";
	level.mapkillstreakpickupstring = &"MP_DAM_MAP_KILLSTREAK_PICKUP";
	level.dam_killstreak_duration = 30;
	precacheshader("s1_railgun_hud_reticle_center");
	precacheshader("s1_railgun_hud_reticle_meter_circ");
	precacheshader("s1_railgun_hud_inner_frame_edge");
	precacheshader("s1_railgun_hud_inner_frame_edge_right");
	precacheitem("killstreak_dam_mp");
	precachemodel("mp_dam_large_caliber_turret");
	level.huditem = [];
}

//Function Number: 2
tryusedamkillstreak(param_00,param_01)
{
	if(isdefined(level.mp_dam_player))
	{
		self iprintlnbold(&"MP_DAM_IN_USE");
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

	if(isdefined(self.controllingwarbird) && self.controllingwarbird == 1)
	{
		self iprintlnbold(&"MP_WARBIRD_ACTIVE");
		return 0;
	}

	var_02 = maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(var_02 != "success")
	{
		return 0;
	}

	maps\mp\_utility::setusingremote("mp_dam");
	var_02 = setmpdamplayer(self);
	if(isdefined(var_02) && var_02)
	{
		maps\mp\_matchdata::logkillstreakevent("mp_dam",self.origin);
	}
	else if(maps\mp\_utility::isusingremote())
	{
		maps\mp\_utility::clearusingremote();
	}

	return var_02;
}

//Function Number: 3
setmpdamplayer(param_00)
{
	self endon("mp_dam_player_removed");
	if(isdefined(level.mp_dam_player))
	{
		return 0;
	}

	level.mp_dam_player = param_00;
	param_00 notifyonplayercommand("SwitchTurret","weapnext");
	param_00 notifyonplayercommand("SwitchVisionMode","+actionslot 1");
	thread maps\mp\_utility::teamplayercardsplash("used_mp_dam",param_00);
	param_00 thread waitsetthermal(1);
	if(getdvarint("camera_thirdPerson"))
	{
		param_00 maps\mp\_utility::setthirdpersondof(0);
	}

	param_00 thread cycleturretcontrol();
	param_00 thread removempdamplayeraftertime(level.dam_killstreak_duration);
	param_00 thread removempdamplayerondisconnect();
	param_00 thread removempdamplayeronchangeteams();
	param_00 thread removempdamplayeronspectate();
	param_00 thread removempdamplayerongamecleanup();
	param_00 thread removempdamplayeroncommand();
	return 1;
}

//Function Number: 4
cycleturretcontrol()
{
	self endon("mp_dam_player_removed");
	var_00 = self;
	if(isdefined(level.damturrets))
	{
		var_00 enableslowaim(0.2,0.2);
		for(;;)
		{
			for(var_01 = 0;var_01 < level.damturrets.size;var_01++)
			{
				var_02 = level.damturrets[var_01];
				var_02.owner = var_00;
				var_02.team = var_00.team;
				var_02.pers["team"] = var_00.team;
				if(level.teambased)
				{
					var_02 setturretteam(var_00.team);
				}

				var_00.turret = var_02;
				var_02 setmode("sentry_manual");
				var_02 setsentryowner(var_00);
				var_00 thread shotfired(var_02);
				if(var_01 == 0)
				{
					var_00 playerlinkweaponviewtodelta(var_02,"tag_player",0,60,30,5,58,0);
				}
				else
				{
					var_00 playerlinkweaponviewtodelta(var_02,"tag_player",0,40,50,5,58,0);
				}

				var_00 playerlinkedsetusebaseangleforviewclamp(1);
				var_00 remotecontrolturret(var_02,40);
				if(!isdefined(var_02.killcament))
				{
					var_03 = (-142,0,562);
					var_02.killcament = spawn("script_model",var_02 gettagorigin("tag_player") + var_03);
					var_02.killcament setscriptmoverkillcam("explosive");
					var_02.killcament linkto(var_02);
					var_02.killcament setcontents(0);
				}

				wait(0.5);
				if(isdefined(self.damthermal) && self.damthermal == 1)
				{
					self thermalvisionon();
				}

				self setclientomnvar("ui_damturret_toggle",1);
				self waittill("SwitchTurret");
				if(isdefined(self.damthermal) && self.damthermal == 1)
				{
					self thermalvisionoff();
				}

				self setclientomnvar("ui_damturret_toggle",0);
				if(isdefined(var_02.killcament))
				{
					var_02.killcament delete();
				}

				var_00 transitionturret();
				var_00 unlink();
				var_00 remotecontrolturretoff(var_02);
				var_02 setmode("manual");
				var_02 settargetentity(level.damdefaultaiment);
			}
		}
	}
}

//Function Number: 5
transitionturret()
{
	self visionsetnakedforplayer("black_bw",0.75);
	wait(0.8);
	revertvisionsetforturretplayer(0.5);
}

//Function Number: 6
revertvisionsetforturretplayer(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(isdefined(level.nukedetonated) && isdefined(level.nukevisionset))
	{
		self visionsetnakedforplayer(level.nukevisionset,param_00);
		return;
	}

	if(isdefined(self.usingremote) && isdefined(self.ridevisionset))
	{
		self visionsetnakedforplayer(self.ridevisionset,param_00);
		return;
	}

	self visionsetnakedforplayer("",param_00);
}

//Function Number: 7
waitsetthermal(param_00)
{
	self endon("disconnect");
	level endon("mp_dam_player_removed");
	wait(param_00);
	self visionsetthermalforplayer(game["thermal_vision"],0);
	self thermalvisionfofoverlayon();
	self setblurforplayer(1.1,0);
}

//Function Number: 8
thermalvision()
{
	self endon("mp_dam_player_removed");
	for(;;)
	{
		self.damthermal = 0;
		self waittill("SwitchVisionMode");
		self thermalvisionon();
		self.damthermal = 1;
		self waittill("SwitchVisionMode");
		self thermalvisionoff();
	}
}

//Function Number: 9
creatempdamkillstreakclock()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("mp_dam_player_removed");
	self.dam_clock = maps\mp\gametypes\_hud_util::createtimer("hudsmall",0.9);
	self.dam_clock maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,-145);
	self.dam_clock settimer(level.dam_killstreak_duration);
	self.dam_clock.color = (1,1,1);
	self.dam_clock.archived = 0;
	self.dam_clock.foreground = 1;
	thread destroympdamkillstreakclock();
}

//Function Number: 10
destroympdamkillstreakclock()
{
	self waittill("mp_dam_player_removed");
	if(isdefined(self.dam_clock))
	{
		self.dam_clock destroy();
	}
}

//Function Number: 11
removempdamplayeroncommand()
{
	self endon("mp_dam_player_removed");
	for(;;)
	{
		var_00 = 0;
		while(self usebuttonpressed())
		{
			var_00 = var_00 + 0.05;
			if(var_00 > 0.75)
			{
				level thread removempdamplayer(self,0);
				return;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 12
removempdamplayerongamecleanup()
{
	self endon("mp_dam_player_removed");
	level waittill("game_cleanup");
	level thread removempdamplayer(self,0);
}

//Function Number: 13
removempdamplayerondeath()
{
	self endon("mp_dam_player_removed");
	self waittill("death");
	level thread removempdamplayer(self,0);
}

//Function Number: 14
removempdamplayerondisconnect()
{
	self endon("mp_dam_player_removed");
	self waittill("disconnect");
	level thread removempdamplayer(self,1);
}

//Function Number: 15
removempdamplayeronchangeteams()
{
	self endon("mp_dam_player_removed");
	self waittill("joined_team");
	level thread removempdamplayer(self,0);
}

//Function Number: 16
removempdamplayeronspectate()
{
	self endon("mp_dam_player_removed");
	common_scripts\utility::waittill_any("joined_spectators","spawned");
	level thread removempdamplayer(self,0);
}

//Function Number: 17
removempdamplayeraftertime(param_00)
{
	self endon("mp_dam_player_removed");
	if(maps\mp\_utility::_hasperk("specialty_blackbox") && isdefined(self.specialty_blackbox_bonus))
	{
		param_00 = param_00 * self.specialty_blackbox_bonus;
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	level thread removempdamplayer(self,0);
}

//Function Number: 18
removempdamplayer(param_00,param_01)
{
	param_00 notify("mp_dam_player_removed");
	level notify("mp_dam_player_removed");
	waittillframeend;
	if(!param_01)
	{
		param_00 setclientomnvar("ui_damturret_toggle",0);
		param_00 setblurforplayer(0,0);
		param_00 thermalvisionoff();
		param_00 thermalvisionfofoverlayoff();
		param_00 remotecontrolturretoff(param_00.turret);
		param_00 unlink();
		param_00 maps\mp\_utility::clearusingremote();
		param_00 maps\mp\_utility::revertvisionsetforplayer(0.5);
		param_00 disableslowaim();
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 maps\mp\_utility::setthirdpersondof(1);
		}

		if(isdefined(param_00.darkscreenoverlay))
		{
			param_00.darkscreenoverlay destroy();
		}

		foreach(var_03 in level.damturrets)
		{
			var_03 setmode("manual");
			var_03 settargetentity(level.damdefaultaiment);
			if(isdefined(var_03.killcament))
			{
				var_03.killcament delete();
			}
		}

		param_00.turret = undefined;
	}

	level.mp_dam_player = undefined;
}

//Function Number: 19
overlay(param_00)
{
	level.huditem["thermal_vision"] = newclienthudelem(param_00);
	level.huditem["thermal_vision"].x = 200;
	level.huditem["thermal_vision"].y = 0;
	level.huditem["thermal_vision"].alignx = "left";
	level.huditem["thermal_vision"].aligny = "top";
	level.huditem["thermal_vision"].horzalign = "left";
	level.huditem["thermal_vision"].vertalign = "top";
	level.huditem["thermal_vision"].fontscale = 2.5;
	level.huditem["thermal_vision"] settext(&"AC130_HUD_FLIR");
	level.huditem["thermal_vision"].alpha = 1;
	level.huditem["enhanced_vision"] = newclienthudelem(param_00);
	level.huditem["enhanced_vision"].x = -200;
	level.huditem["enhanced_vision"].y = 0;
	level.huditem["enhanced_vision"].alignx = "right";
	level.huditem["enhanced_vision"].aligny = "top";
	level.huditem["enhanced_vision"].horzalign = "right";
	level.huditem["enhanced_vision"].vertalign = "top";
	level.huditem["enhanced_vision"].fontscale = 2.5;
	level.huditem["enhanced_vision"] settext(&"AC130_HUD_OPTICS");
	level.huditem["enhanced_vision"].alpha = 1;
	param_00 setblurforplayer(1.2,0);
}

//Function Number: 20
shotfired(param_00)
{
	self endon("mp_dam_player_removed");
	self endon("SwitchTurret");
	for(;;)
	{
		param_00 waittill("turret_fire");
		earthquake(0.25,1,param_00.origin,3500);
		playrumbleonposition("artillery_rumble",param_00.origin);
		thread shotfireddarkscreenoverlay();
		wait(0.05);
	}
}

//Function Number: 21
shotfireddarkscreenoverlay()
{
	self endon("mp_dam_player_removed");
	self notify("darkScreenOverlay");
	self endon("darkScreenOverlay");
	if(!isdefined(self.darkscreenoverlay))
	{
		self.darkscreenoverlay = newclienthudelem(self);
		self.darkscreenoverlay.x = 0;
		self.darkscreenoverlay.y = 0;
		self.darkscreenoverlay.alignx = "left";
		self.darkscreenoverlay.aligny = "top";
		self.darkscreenoverlay.horzalign = "fullscreen";
		self.darkscreenoverlay.vertalign = "fullscreen";
		self.darkscreenoverlay setshader("black",640,480);
		self.darkscreenoverlay.sort = -10;
		self.darkscreenoverlay.alpha = 0;
	}

	self.darkscreenoverlay.alpha = 0;
	self.darkscreenoverlay fadeovertime(0.05);
	self.darkscreenoverlay.alpha = 0.2;
	wait(0.4);
	self.darkscreenoverlay fadeovertime(0.8);
	self.darkscreenoverlay.alpha = 0;
}

//Function Number: 22
movementaudio(param_00)
{
	self endon("mp_dam_player_removed");
	self endon("SwitchTurret");
	if(!isdefined(level.aud))
	{
		level.aud = spawnstruct();
	}

	thread movementaudiocleanup();
	for(;;)
	{
		var_01 = param_00 getturretyawrate();
		var_01 = abs(var_01);
		var_02 = param_00 getturretpitchrate();
		var_02 = abs(var_02);
		if(var_01 > 0.1)
		{
			if(!isdefined(level.aud.turretyawlp))
			{
				level.aud.turretyawlp = spawn("script_origin",param_00.origin);
				level.aud.turretyawlp playloopsound("wpn_railgun_dam_lat_move_lp");
			}
		}
		else if(isdefined(level.aud.turretyawlp))
		{
			level.aud.turretyawlp stoploopsound();
			level.aud.turretyawlp delete();
			level.aud.turretyawlp = undefined;
			param_00 playsound("wpn_railgun_dam_lat_stop");
		}

		if(var_02 > 0.1)
		{
			if(!isdefined(level.aud.turretpitchlp))
			{
				level.aud.turretpitchlp = spawn("script_origin",param_00.origin);
				level.aud.turretpitchlp playloopsound("wpn_railgun_dam_vert_move_lp");
			}
		}
		else if(isdefined(level.aud.turretpitchlp))
		{
			level.aud.turretpitchlp stoploopsound();
			level.aud.turretpitchlp delete();
			level.aud.turretpitchlp = undefined;
			param_00 playsound("wpn_railgun_dam_vert_stop");
		}

		wait(0.05);
	}
}

//Function Number: 23
movementaudiocleanup()
{
	self waittill("mp_dam_player_removed");
	if(isdefined(level.aud.turretyawlp))
	{
		level.aud.turretyawlp stoploopsound();
		level.aud.turretyawlp delete();
		level.aud.turretyawlp = undefined;
	}

	if(isdefined(level.aud.turretpitchlp))
	{
		level.aud.turretpitchlp stoploopsound();
		level.aud.turretpitchlp delete();
		level.aud.turretpitchlp = undefined;
	}
}