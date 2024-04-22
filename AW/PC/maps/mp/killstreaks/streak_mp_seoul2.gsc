/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_seoul2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 722 ms
 * Timestamp: 4/22/2024 2:12:46 AM
*******************************************************************/

//Function Number: 1
streak_init()
{
	precacheitem("iw5_dlcgun12loot2_mp");
	level.killstreakfuncs["mp_seoul2"] = ::tryusempswarm;
	level.mapkillstreak = "mp_seoul2";
	level.mapkillstreakpickupstring = &"MP_SEOUL2_MAP_KILLSTREAK_PICKUP";
	level.killstreakwieldweapons["iw5_dlcgun12loot2_mp"] = "mp_seoul2";
	level.swarm_use_duration = 40;
	level.swarm_speed = 40;
	var_00 = getentarray("minimap_corner","targetname");
	var_01 = (0,0,0);
	if(var_00.size)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::findboxcenter(var_00[0].origin,var_00[1].origin);
	}

	level.swarmrig = spawn("script_model",var_01);
	level.swarmrig setmodel("c130_zoomrig");
	level.swarmrig.angles = (0,115,0);
	level.swarmrig hide();
	thread rotateswarm(level.swarm_speed);
	level._effect["orbitalsupport_rocket_explode_player"] = loadfx("vfx/explosion/rocket_explosion_distant");
	level.swarminuse = 0;
	level._effect["drone_swarm_loop"] = loadfx("vfx/map/mp_seoul2/drone_swarm_loop");
	level._effect["drone_swarm_trail"] = loadfx("vfx/trail/drone_swarm_missile_trail");
	level._effect["drone_swarm_trail_inair"] = loadfx("vfx/trail/drone_swarm_missile_trail_inair");
}

//Function Number: 2
tryusempswarm(param_00,param_01)
{
	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(maps\mp\_utility::isemped())
	{
		return 0;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	if(isdefined(level.swarm_player) || level.swarminuse)
	{
		self iprintlnbold(&"MP_SEOUL2_SWARM_IN_USE");
		return 0;
	}

	level.swarminuse = 1;
	thread playerclearswarmonteamchange();
	var_02 = maps\mp\killstreaks\_killstreaks::initridekillstreak("paladin",0,undefined,3);
	if(var_02 != "success")
	{
		level.swarminuse = 0;
		return 0;
	}

	maps\mp\_utility::setusingremote("orbitalplatform");
	thread setswarmplayer(self);
	maps\mp\_matchdata::logkillstreakevent("dlc_streak5",self.origin);
	return 1;
}

//Function Number: 3
playerclearswarmonteamchange()
{
	self endon("rideKillstreakBlack");
	self waittill("joined_team");
	level.swarminuse = 0;
}

//Function Number: 4
setswarmplayer(param_00)
{
	self endon("swarm_player_removed");
	self endon("disconnect");
	level.swarm_player = param_00;
	param_00 maps\mp\_utility::playersaveangles();
	param_00 swarm_spawn();
	level.swarm_planemodel.vehicletype = "paladin";
	level.swarm_planemodel.player = param_00;
	level.swarm_planemodel.helitype = "osp";
	param_00 startac130();
	param_00 maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
	param_00 maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();
	param_00 thread waitsetthermal(1);
	param_00 thread waitdisableshadows(1);
	param_00 thread setswarmvisionandlightsetpermap(1.25);
	if(getdvarint("camera_thirdPerson"))
	{
		param_00 maps\mp\_utility::setthirdpersondof(0);
	}

	param_00 playerswitchtoturret(level.swarm_big_turret);
	param_00.controlled_swarm_turret = "medium";
	param_00.reloading_rocket_swarm_gun = 0;
	param_00 thread removeswarmplayerondisconnect();
	param_00 thread removeswarmplayeronchangeteams();
	param_00 thread removeswarmplayeronspectate();
	param_00 thread removeswarmplayerongamecleanup();
	param_00 thread removeswarmplayeronsystemhack();
	wait(1);
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	param_00 setclientomnvar("ui_solar_beam",1);
	param_00 thread waitsetstatic(0.1);
	var_01 = level.swarm_use_duration;
	param_00.swarm_endtime = gettime() + var_01 * 1000;
	param_00 setclientomnvar("ui_warbird_countdown",param_00.swarm_endtime);
	self notifyonplayercommand("swarm_fire","+attack");
	self notifyonplayercommand("swarm_fire","+attack_akimbo_accessible");
	param_00 thread firerocketswarmgun();
	if(isdefined(level.swarm_targetent))
	{
		playfxontag(common_scripts\utility::getfx("vehicle_osp_rocket_marker"),level.swarm_targetent,"tag_origin");
	}

	param_00 thread pulseswarmreloadtext();
	param_00 thread showaerialmarker();
	param_00 thread removeswarmplayeraftertime(var_01);
	param_00 thread removeswarmplayeroncommand();
	level.swarm_planemodel thread swarmexit(var_01);
	level thread setupplayersduringstreak();
}

//Function Number: 5
waitsetstatic(param_00)
{
	self endon("swarm_player_removed");
	self endon("disconnect");
	wait(param_00);
	maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
}

//Function Number: 6
waitsetthermal(param_00)
{
	self endon("disconnect");
	level endon("swarm_player_removed");
	self endon("swarm_player_removed");
	wait(param_00);
	self thermalvisionfofoverlayon();
	var_01 = 3000;
	var_02 = 0.3;
	var_03 = var_01;
	var_04 = 0.3;
	var_05 = var_01 * 0.75;
	var_06 = 20;
	var_07 = 30;
	thread maps\mp\killstreaks\_aerial_utility::thermalvision("swarm_player_removed",var_02,var_03,var_04,var_05,var_06,var_07);
}

//Function Number: 7
waitdisableshadows(param_00)
{
	self endon("disconnect");
	level endon("swarm_player_removed");
	self endon("swarm_player_removed");
	wait(param_00);
	self setshadowrendering(0);
}

//Function Number: 8
setswarmvisionandlightsetpermap(param_00)
{
	self endon("disconnect");
	level endon("swarm_player_removed");
	wait(param_00);
	if(isdefined(level.swarmvisionset))
	{
		self setclienttriggervisionset(level.swarmvisionset,0);
	}

	if(isdefined(level.swarmlightset))
	{
		self lightsetforplayer(level.swarmlightset);
	}

	maps\mp\killstreaks\_aerial_utility::handle_player_starting_aerial_view();
}

//Function Number: 9
removeswarmvisionandlightsetpermap(param_00)
{
	self setclienttriggervisionset("",param_00);
	self lightsetforplayer("");
	maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
}

//Function Number: 10
removeswarmplayeroncommand()
{
	self endon("swarm_player_removed");
	var_00 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = var_00 + 0.05;
			if(var_00 > 1)
			{
				level thread removeswarmplayer(self,0);
				return;
			}
		}
		else
		{
			var_00 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 11
removeswarmplayerongamecleanup()
{
	self endon("swarm_player_removed");
	level waittill("game_ended");
	level thread removeswarmplayer(self,0);
}

//Function Number: 12
removeswarmplayerondisconnect()
{
	self endon("swarm_player_removed");
	self waittill("disconnect");
	level thread removeswarmplayer(self,1);
}

//Function Number: 13
removeswarmplayeronchangeteams()
{
	self endon("swarm_player_removed");
	self waittill("joined_team");
	level thread removeswarmplayer(self,0);
}

//Function Number: 14
removeswarmplayeronspectate()
{
	self endon("swarm_player_removed");
	common_scripts\utility::waittill_any("joined_spectators","spawned");
	level thread removeswarmplayer(self,0);
}

//Function Number: 15
removeswarmplayeraftertime(param_00)
{
	self endon("swarm_player_removed");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	level thread removeswarmplayer(self,0);
}

//Function Number: 16
removeswarmplayeronsystemhack()
{
	self endon("swarm_player_removed");
	for(;;)
	{
		self waittill("EMP_Artifacts");
		wait(0.15);
		if(level.empstreaksdisabled)
		{
			level thread removeswarmplayer(self,0);
		}
	}
}

//Function Number: 17
removeswarmplayer(param_00,param_01)
{
	param_00 notify("swarm_player_removed");
	level notify("swarm_player_removed");
	waittillframeend;
	level.swarm_planemodel.player = undefined;
	if(!param_01)
	{
		param_00 playerresetswarmomnvars();
		param_00 notifyonplayercommandremove("swarm_fire","+attack");
		param_00 notifyonplayercommandremove("swarm_fire","+attack_akimbo_accessible");
		param_00 remotecontrolturretoff(level.swarm_big_turret);
		level.swarm_big_turret hide();
		param_00 unlink();
		var_02 = maps\mp\_utility::getkillstreakweapon("orbitalsupport");
		param_00 takeweapon(var_02);
		if(param_00 maps\mp\_utility::isusingremote())
		{
			param_00 maps\mp\_utility::clearusingremote();
		}

		maps\mp\killstreaks\_aerial_utility::disableorbitalthermal(param_00);
		param_00 setshadowrendering(1);
		param_00 thermalvisionfofoverlayoff();
		param_00 setblurforplayer(0,0);
		param_00 removeswarmvisionandlightsetpermap(1.5);
		param_00 stopac130();
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 maps\mp\_utility::setthirdpersondof(1);
		}

		if(isdefined(param_00.darkscreenoverlay))
		{
			param_00.darkscreenoverlay destroy();
		}

		param_00.reloading_rocket_swarm_gun = undefined;
		param_00 maps\mp\_utility::playerrestoreangles();
	}

	if(isdefined(level.swarm_targetent))
	{
		stopfxontag(common_scripts\utility::getfx("vehicle_osp_rocket_marker"),level.swarm_targetent,"tag_origin");
		level.swarm_targetent delete();
	}

	level.swarm_player = undefined;
	level.swarm_planemodel stoploopsound();
	level.swarm_planemodel playsound("paladin_orbit_return");
}

//Function Number: 18
cleanupswarments()
{
	level.swarm_planemodel stoploopsound();
	if(isdefined(level.swarm_planemodel.farflightsound))
	{
		level.swarm_planemodel.farflightsound stoploopsound();
		level.swarm_planemodel.farflightsound delete();
	}

	if(isdefined(level.swarm_planemodel.closeflightsound))
	{
		level.swarm_planemodel.closeflightsound stoploopsound();
		level.swarm_planemodel.closeflightsound delete();
	}

	if(isdefined(level.swarm_planemodel.minimapicon))
	{
		level.swarm_planemodel.minimapicon delete();
	}
}

//Function Number: 19
swarm_spawn()
{
	var_00 = getentarray("minimap_corner","targetname");
	var_01 = (0,0,0);
	if(var_00.size)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::findboxcenter(var_00[0].origin,var_00[1].origin);
		var_01 = (var_01[0],var_01[1],0);
	}

	level.swarm_planemodel = spawn("script_model",var_01);
	level.swarm_planemodel.angles = (0,0,0);
	level.swarm_planemodel setmodel("vehicle_mp_seoul2_killstreak_osp_rig");
	level.swarm_planemodel.owner = self;
	level.swarm_planemodel common_scripts\utility::make_entity_sentient_mp(self.team);
	level.swarm_planemodel.minimapicon = spawnplane(self,"script_model",var_01,"compass_objpoint_seoul2_swarm_friendly","compass_objpoint_seoul2_swarm_enemy");
	level.swarm_planemodel.minimapicon setmodel("tag_origin");
	level.swarm_planemodel.minimapicon vehicle_jetbikesethoverforcescale(level.swarm_planemodel,"tag_origin",(0,0,0),(0,0,0));
	level.swarm_planemodel.fxent = level.swarm_planemodel common_scripts\utility::spawn_tag_origin();
	level.swarm_planemodel.fxent vehicle_jetbikesethoverforcescale(level.swarm_planemodel,"tag_origin",(0,0,-800),(0,0,0));
	level.swarm_planemodel.fxent show();
	playfxontag(common_scripts\utility::getfx("drone_swarm_loop"),level.swarm_planemodel.fxent,"tag_origin");
	level.swarm_planemodel setcandamage(1);
	level.swarm_planemodel setcanradiusdamage(1);
	level.swarm_planemodel.showthreatmarker = 0;
	level.swarm_planemodel setrandomswarmstartposition();
	level.swarm_big_turret = spawnswarmturret("orbitalsupport_medium_turret_mp","orbitalsupport_big_turret","tag_orbitalsupport_biggun");
	level.swarm_planemodel thread moveswarmtodestination();
}

//Function Number: 20
spawnswarmturret(param_00,param_01,param_02)
{
	var_03 = spawnturret("misc_turret",level.swarm_planemodel gettagorigin(param_02),param_00,0);
	var_03.angles = level.swarm_planemodel gettagangles(param_02);
	var_03 setmodel(param_01);
	var_03 setdefaultdroppitch(45);
	var_03 linkto(level.swarm_planemodel,param_02,(0,0,0),(0,0,0));
	var_03.owner = undefined;
	var_03.health = 99999;
	var_03.maxhealth = 1000;
	var_03.damagetaken = 0;
	var_03.stunned = 0;
	var_03.stunnedtime = 0;
	var_03 setcandamage(0);
	var_03 setcanradiusdamage(0);
	var_03 turretfiredisable();
	return var_03;
}

//Function Number: 21
swarmturretspawnsoundent(param_00)
{
	wait 0.05;
	self.soundent = spawn("script_model",self.origin);
	self.soundent setmodel("tag_origin");
	self.soundent linkto(level.swarm_planemodel,param_00,(0,0,0),(0,0,0));
}

//Function Number: 22
pulseswarmreloadtext()
{
	level endon("swarm_player_removed");
	self endon("swarm_player_removed");
	self setclientomnvar("ui_osp_reload_bitfield",0);
	var_00 = 4;
	for(;;)
	{
		var_01 = 0;
		if(self.reloading_rocket_swarm_gun)
		{
			var_01 = var_01 + var_00;
		}

		self setclientomnvar("ui_osp_reload_bitfield",var_01);
		wait(0.05);
	}
}

//Function Number: 23
playerswitchtoturret(param_00)
{
	self unlink();
	level thread handleturretsoundent(param_00);
	var_01 = 75;
	var_02 = 75;
	var_03 = -30;
	var_04 = 360;
	self playerlinkweaponviewtodelta(param_00,"tag_player",0,var_01,var_02,var_03,var_04,1);
	self playerlinkedsetusebaseangleforviewclamp(1);
	var_05 = 45;
	self remotecontrolturret(param_00,var_05);
}

//Function Number: 24
handleturretsoundent(param_00)
{
	param_00 endon("death");
	param_00 notify("startHandleSoundEnt");
	param_00 endon("startHandleSoundEnt");
	if(isdefined(param_00.soundent))
	{
		param_00.soundent hide();
	}

	foreach(var_02 in level.players)
	{
		if(isdefined(param_00.owner) && param_00.owner != var_02)
		{
			if(isdefined(param_00.soundent))
			{
				param_00.soundent showtoplayer(var_02);
			}
		}
	}

	for(;;)
	{
		level waittill("connected",var_02);
		if(isdefined(param_00.soundent))
		{
			param_00.soundent showtoplayer(var_02);
		}
	}
}

//Function Number: 25
random_vector(param_00)
{
	return (randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5);
}

//Function Number: 26
firerocketswarmgun()
{
	self endon("swarm_player_removed");
	var_00 = 3;
	thread updateshootinglocation();
	while(!isdefined(level.swarm_planemodel.swarmflying))
	{
		wait 0.05;
	}

	for(;;)
	{
		self.reloading_rocket_swarm_gun = 0;
		if(self attackbuttonpressed() && !isdefined(level.hostmigrationtimer))
		{
			earthquake(0.3,1,level.swarm_planemodel.origin,1000,self);
			var_01 = level.swarm_big_turret gettagorigin("tag_missile1");
			var_02 = vectornormalize(anglestoforward(self getplayerangles()));
			var_03 = vectornormalize(anglestoforward(level.swarm_planemodel gettagangles("tag_origin")));
			for(var_04 = 0;var_04 < 1;var_04++)
			{
				var_05 = var_02 + (0,0,0.4) + random_vector(0.5);
				var_06 = var_01 + common_scripts\utility::randomvectorrange(-1,1);
				var_07 = magicbullet("iw5_dlcgun12loot2_mp",var_01,var_01 + var_05,self);
				var_08 = var_07 common_scripts\utility::spawn_tag_origin();
				var_08 show();
				var_08 vehicle_jetbikesethoverforcescale(var_07,"tag_fx");
				var_09 = [];
				foreach(var_0B in level.players)
				{
					if(var_0B != self)
					{
						var_09[var_09.size] = spawnlinkedfxforclient(common_scripts\utility::getfx("drone_swarm_trail"),var_08,"tag_origin",var_0B);
					}
				}

				var_09[var_09.size] = spawnlinkedfxforclient(common_scripts\utility::getfx("drone_swarm_trail_inair"),var_08,"tag_origin",self);
				foreach(var_0E in var_09)
				{
					setfxkillondelete(var_0E,1);
					triggerfx(var_0E);
				}

				thread cleanupdronemissilefx(var_07,var_08,var_09);
				var_07.vehicle_fired_from = level.swarm_planemodel;
				self playlocalsound("paladin_missile_shot_2d");
				self playrumbleonentity("ac130_40mm_fire");
				var_07 missile_settargetent(level.swarm_targetent);
				var_07 missile_setflightmodedirect();
				wait(0.1);
			}

			self.reloading_rocket_swarm_gun = 1;
			thread rocketreloadsound(var_00);
			wait(var_00);
			self notify("rocketReloadComplete");
		}

		wait 0.05;
	}
}

//Function Number: 27
cleanupdronemissilefx(param_00,param_01,param_02)
{
	param_00 waittill("death");
	foreach(var_04 in param_02)
	{
		var_04 delete();
	}

	param_01 delete();
}

//Function Number: 28
updateshootinglocation()
{
	self endon("swarm_player_removed");
	level.swarm_targetent = spawn("script_model",(0,0,0));
	level.swarm_targetent setmodel("tag_origin");
	level.swarm_big_turret turretsetgroundaimentity(level.swarm_targetent);
	for(;;)
	{
		var_00 = level.swarm_big_turret gettagorigin("tag_player");
		var_01 = level.swarm_big_turret gettagorigin("tag_player") + anglestoforward(level.swarm_big_turret gettagangles("tag_player")) * 20000;
		var_02 = bullettrace(var_00,var_01,0,level.swarm_big_turret);
		var_03 = var_02["position"];
		level.swarm_targetent.origin = var_03;
		wait 0.05;
	}
}

//Function Number: 29
rocketreloadsound(param_00)
{
	self endon("rocketReloadComplete");
	self endon("swarm_player_removed");
	self playlocalsound("warbird_missile_reload_bed");
	wait(0.5);
	self playlocalsound("warbird_missile_reload");
}

//Function Number: 30
showaerialmarker()
{
	level.swarm_planemodel endon("death");
	while(!isdefined(level.swarm_planemodel.swarmflying))
	{
		wait 0.05;
	}

	level.swarm_planemodel.showthreatmarker = 1;
	level.swarm_planemodel thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
	level.swarm_planemodel common_scripts\utility::waittill_either("crashing","leaving");
	level.swarm_planemodel.showthreatmarker = 0;
	level.swarm_planemodel thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
}

//Function Number: 31
setrandomswarmstartposition()
{
	var_00 = level.mapcenter[2] + 3000;
	var_01 = 2000;
	var_02 = (0,randomint(360),0);
	level.swarm_planemodel.angles = var_02;
	level.swarm_planemodel.origin = level.swarm_planemodel.origin - vectornormalize(-1 * anglestoright(level.swarm_planemodel gettagangles("tag_origin"))) * var_01;
	level.swarm_planemodel.origin = level.swarm_planemodel.origin + (0,0,var_00);
	level.swarm_planemodel.destination2 = spawnstruct();
	level.swarm_planemodel.destination2.origin = level.swarm_planemodel.origin;
	level.swarm_planemodel.destination2.angles = level.swarm_planemodel.angles;
	level.swarm_planemodel.origin = level.swarm_planemodel.origin + (0,0,65000);
}

//Function Number: 32
moveswarmtodestination(param_00)
{
	self endon("death");
	self endon("crashing");
	level endon("game_ended");
	level endon("swarm_player_removed");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	thread rotateswarm(1,"off");
	thread playentrysounddelayed();
	level.swarm_planemodel scriptmodelplayanimdeltamotion("mp_seoul2_ks_callin","paladin_notetrack");
	level.swarm_planemodel waittillmatch("engines_full","paladin_notetrack");
	level.swarm_planemodel waittillmatch("downward_stop","paladin_notetrack");
	if(param_00)
	{
		level.swarm_planemodel vehicle_jetbikesethoverforcescale(level.swarmrig,"tag_player");
		thread rotateswarm(level.swarm_speed);
	}

	level.swarm_planemodel waittillmatch("end","paladin_notetrack");
	level.swarm_planemodel scriptmodelclearanim();
	level.swarm_planemodel scriptmodelplayanim("paladin_ks_loop","paladin_notetrack");
	if(isdefined(level.swarm_planemodel.owner))
	{
		level.swarm_planemodel.closeflightsound = spawn("script_origin",(0,0,0));
		level.swarm_planemodel.closeflightsound vehicle_jetbikesethoverforcescale(level.swarm_planemodel,"tag_origin",(0,0,0),(0,0,0));
		level.swarm_planemodel.closeflightsound playloopsound("paladin_flight_loop_near");
	}

	level.swarm_planemodel.farflightsound = spawn("script_origin",(0,0,0));
	level.swarm_planemodel.farflightsound vehicle_jetbikesethoverforcescale(level.swarm_planemodel,"tag_origin",(0,0,0),(0,0,0));
	level.swarm_planemodel.farflightsound playloopsound("paladin_flight_loop_dist");
	setupflightsounds();
	level.swarm_planemodel.swarmflying = 1;
}

//Function Number: 33
setupflightsounds()
{
	if(isdefined(level.swarm_planemodel.closeflightsound))
	{
		level.swarm_planemodel.closeflightsound hide();
		if(isdefined(level.swarm_planemodel.owner))
		{
			level.swarm_planemodel.closeflightsound showtoplayer(level.swarm_planemodel.owner);
		}
	}

	if(isdefined(level.swarm_planemodel.farflightsound))
	{
		level.swarm_planemodel.farflightsound hide();
		foreach(var_01 in level.players)
		{
			if(level.splitscreen || isdefined(level.swarm_planemodel.owner) && bothplayerssplitscreen(level.swarm_planemodel.owner,var_01))
			{
				continue;
			}

			if(isdefined(level.swarm_planemodel.owner) && var_01 != level.swarm_planemodel.owner)
			{
				level.swarm_planemodel.farflightsound showtoplayer(var_01);
			}
		}
	}
}

//Function Number: 34
bothplayerssplitscreen(param_00,param_01)
{
	return param_00 issplitscreenplayer() && param_01 issplitscreenplayer();
}

//Function Number: 35
playerdelayrumble(param_00)
{
	self endon("disconnect");
	self endon("swarm_player_removed");
	wait(param_00);
	self playrumbleonentity("orbital_laser_charge");
}

//Function Number: 36
playentrysounddelayed()
{
	self endon("death");
	self endon("crashing");
	level endon("game_ended");
	level endon("swarm_player_removed");
	wait(1);
	playsoundatpos(level.swarm_planemodel.destination2.origin,"paladin_orbit_drop");
}

//Function Number: 37
swarmexit(param_00)
{
	level.swarm_planemodel endon("crashing");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	level.swarm_planemodel notify("leaving");
	level.swarm_planemodel unlink();
	level.swarm_planemodel.fxent unlink();
	level.swarm_planemodel scriptmodelplayanimdeltamotion("paladin_ks_exit","paladin_notetrack");
	wait(4.8);
	cleanupswarments();
	level.swarm_planemodel delete();
	level.swarminuse = 0;
}

//Function Number: 38
setupplayersduringstreak()
{
	level.swarm_chatter_timer = 0;
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.team) && level.swarm_planemodel.owner.team == var_01.team)
		{
			continue;
		}
		else if(!isdefined(var_01.team))
		{
			var_01 onplayerspawnedduringstreak();
			continue;
		}
	}

	level thread onplayerconnectduringstreak();
}

//Function Number: 39
onplayerconnectduringstreak()
{
	level endon("game_ended");
	level.swarm_planemodel.owner endon("swarm_player_removed");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawnedduringstreak();
	}
}

//Function Number: 40
onplayerspawnedduringstreak()
{
	self waittill("spawned_player");
	setupflightsounds();
}

//Function Number: 41
turretdeletesoundent()
{
	if(isdefined(self.soundent))
	{
		self.soundent delete();
	}
}

//Function Number: 42
playerresetswarmomnvars()
{
	self setclientomnvar("ui_killstreak_optic",0);
	self setclientomnvar("ui_osp_reload_bitfield",0);
	self setclientomnvar("ui_solar_beam",0);
	maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
}

//Function Number: 43
rotateswarm(param_00,param_01)
{
	level notify("stop_rotateSwarm_thread");
	level endon("stop_rotateSwarm_thread");
	if(!isdefined(param_01))
	{
		param_01 = "on";
	}

	if(param_01 == "on")
	{
		level.swarmrig rotateyaw(360,param_00,0.5);
		wait(param_00);
		for(;;)
		{
			level.swarmrig rotateyaw(360,param_00);
			wait(param_00);
		}

		return;
	}

	if(param_01 == "off")
	{
		var_02 = 10;
		var_03 = param_00 / 360 * var_02;
		level.swarmrig rotateyaw(level.swarmrig.angles[2] + var_02,var_03,0,var_03);
	}
}