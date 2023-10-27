/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_nuke.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 362 ms
 * Timestamp: 10/27/2023 2:14:23 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheitem("nuke_mp");
	precachelocationselector("map_nuke_selector");
	precachestring(&"MP_TACTICAL_NUKE_CALLED");
	precachestring(&"MP_FRIENDLY_TACTICAL_NUKE");
	precachestring(&"MP_TACTICAL_NUKE");
	level.nukevisionset = "aftermath";
	level._effect["nuke_player"] = loadfx("explosions/player_death_nuke");
	level._effect["nuke_flash"] = loadfx("explosions/player_death_nuke_flash");
	level._effect["nuke_aftermath"] = loadfx("dust/nuke_aftermath_mp");
	game["strings"]["nuclear_strike"] = &"MP_TACTICAL_NUKE";
	level.killstreakfuncs["nuke"] = ::tryusenuke;
	setdvarifuninitialized("scr_nukeTimer",10);
	setdvarifuninitialized("scr_nukeCancelMode",0);
	level.nuketimer = getdvarint("scr_nukeTimer");
	level.cancelmode = getdvarint("scr_nukeCancelMode");
	level.teamnukeemped["allies"] = 0;
	level.teamnukeemped["axis"] = 0;
	level.nukeemptimeout = 60;
	level.nukeemptimeremaining = int(level.nukeemptimeout);
	level.nukeinfo = spawnstruct();
	level.nukeinfo.var_36 = 2;
	level.nukedetonated = undefined;
	level thread nuke_empteamtracker();
	level thread onplayerconnect();
}

//Function Number: 2
tryusenuke(param_00,param_01)
{
	if(isdefined(level.nukeincoming))
	{
		self iprintlnbold(&"MP_NUKE_ALREADY_INBOUND");
		return 0;
	}

	if(maps\mp\_utility::isusingremote() && !isdefined(level.gtnw) || !level.gtnw)
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	thread donuke(param_01);
	self notify("used_nuke");
	maps\mp\_matchdata::logkillstreakevent("nuke",self.origin);
	return 1;
}

//Function Number: 3
delaythread_nuke(param_00,param_01)
{
	level endon("nuke_cancelled");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	thread [[ param_01 ]]();
}

//Function Number: 4
donuke(param_00)
{
	level endon("nuke_cancelled");
	level.nukeinfo.player = self;
	level.nukeinfo.team = self.pers["team"];
	level.nukeincoming = 1;
	setdvar("ui_bomb_timer",4);
	if(level.teambased)
	{
		thread maps\mp\_utility::teamplayercardsplash("used_nuke",self,self.team);
	}
	else if(!level.hardcoremode)
	{
		self iprintlnbold(&"MP_FRIENDLY_TACTICAL_NUKE");
	}

	level thread delaythread_nuke(level.nuketimer - 3.3,::nukesoundincoming);
	level thread delaythread_nuke(level.nuketimer,::nukesoundexplosion);
	level thread delaythread_nuke(level.nuketimer,::nukeslowmo);
	level thread delaythread_nuke(level.nuketimer,::nukeeffects);
	level thread delaythread_nuke(level.nuketimer + 0.25,::nukevision);
	level thread delaythread_nuke(level.nuketimer + 1.5,::nukedeath);
	level thread delaythread_nuke(level.nuketimer + 1.5,::nukeearthquake);
	level thread nukeaftermatheffect();
	level thread update_ui_timers();
	if(level.cancelmode && param_00)
	{
		level thread cancelnukeondeath(self);
	}

	if(!isdefined(level.nuke_clockobject))
	{
		level.nuke_clockobject = spawn("script_origin",(0,0,0));
		level.nuke_clockobject hide();
	}

	if(!isdefined(level.nuke_soundobject))
	{
		level.nuke_soundobject = spawn("script_origin",(0,0,1));
		level.nuke_soundobject hide();
	}

	for(var_01 = level.nuketimer;var_01 > 0;var_01--)
	{
		level.nuke_clockobject playsound("ui_mp_nukebomb_timer");
		wait 1;
	}
}

//Function Number: 5
cancelnukeondeath(param_00)
{
	param_00 common_scripts\utility::waittill_any("death","disconnect");
	if(isdefined(param_00) && level.cancelmode == 2)
	{
		param_00 thread maps\mp\killstreaks\_emp::emp_use(0,0);
	}

	setdvar("ui_bomb_timer",0);
	level.nukeincoming = undefined;
	level notify("nuke_cancelled");
}

//Function Number: 6
nukesoundincoming()
{
	level endon("nuke_cancelled");
	if(isdefined(level.nuke_soundobject))
	{
		level.nuke_soundobject playsound("nuke_incoming");
	}
}

//Function Number: 7
nukesoundexplosion()
{
	level endon("nuke_cancelled");
	if(isdefined(level.nuke_soundobject))
	{
		level.nuke_soundobject playsound("nuke_explosion");
		level.nuke_soundobject playsound("nuke_wave");
	}
}

//Function Number: 8
nukeeffects()
{
	level endon("nuke_cancelled");
	setdvar("ui_bomb_timer",0);
	level.nukedetonated = 1;
	foreach(var_01 in level.players)
	{
		var_02 = anglestoforward(var_01.angles);
		var_02 = (var_02[0],var_02[1],0);
		var_02 = vectornormalize(var_02);
		var_03 = 5000;
		var_04 = spawn("script_model",var_01.origin + var_02 * var_03);
		var_04 setmodel("tag_origin");
		var_04.angles = (0,var_01.angles[1] + 180,90);
		var_04 thread nukeeffect(var_01);
	}
}

//Function Number: 9
nukeeffect(param_00)
{
	level endon("nuke_cancelled");
	param_00 endon("disconnect");
	common_scripts\utility::waitframe();
	playfxontagforclients(level._effect["nuke_flash"],self,"tag_origin",param_00);
}

//Function Number: 10
nukeaftermatheffect()
{
	level endon("nuke_cancelled");
	level waittill("spawning_intermission");
	var_00 = getentarray("mp_global_intermission","classname");
	var_00 = var_00[0];
	var_01 = anglestoup(var_00.angles);
	var_02 = anglestoright(var_00.angles);
	playfx(level._effect["nuke_aftermath"],var_00.origin,var_01,var_02);
}

//Function Number: 11
nukeslowmo()
{
	level endon("nuke_cancelled");
	setslowmotion(1,0.25,0.5);
	level waittill("nuke_death");
	setslowmotion(0.25,1,2);
}

//Function Number: 12
nukevision()
{
	level endon("nuke_cancelled");
	level.nukevisioninprogress = 1;
	visionsetnaked("mpnuke",3);
	level waittill("nuke_death");
	visionsetnaked(level.nukevisionset,5);
	visionsetpain(level.nukevisionset);
}

//Function Number: 13
nukedeath()
{
	level endon("nuke_cancelled");
	level notify("nuke_death");
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	ambientstop(1);
	foreach(var_01 in level.players)
	{
		if(level.teambased)
		{
			if(isdefined(level.nukeinfo.team) && var_01.team == level.nukeinfo.team)
			{
				continue;
			}
		}
		else if(isdefined(level.nukeinfo.player) && var_01 == level.nukeinfo.player)
		{
			continue;
		}

		var_01.nuked = 1;
		if(isalive(var_01))
		{
			var_01 thread maps\mp\gametypes\_damage::finishplayerdamagewrapper(level.nukeinfo.player,level.nukeinfo.player,999999,0,"MOD_EXPLOSIVE","nuke_mp",var_01.origin,var_01.origin,"none",0,0);
		}
	}

	level thread nuke_empjam();
	level.nukeincoming = undefined;
}

//Function Number: 14
nukeearthquake()
{
	level endon("nuke_cancelled");
	level waittill("nuke_death");
}

//Function Number: 15
nuke_empjam()
{
	level endon("game_ended");
	level maps\mp\killstreaks\_emp::func_35BE(level.nukeinfo.player,maps\mp\_utility::getotherteam(level.nukeinfo.team));
	level notify("nuke_EMPJam");
	level endon("nuke_EMPJam");
	if(level.teambased)
	{
		level.teamnukeemped[maps\mp\_utility::getotherteam(level.nukeinfo.team)] = 1;
	}
	else
	{
		level.teamnukeemped[level.nukeinfo.team] = 1;
		level.teamnukeemped[maps\mp\_utility::getotherteam(level.nukeinfo.team)] = 1;
	}

	level notify("nuke_emp_update");
	level thread keepnukeemptimeremaining();
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.nukeemptimeout);
	if(level.teambased)
	{
		level.teamnukeemped[maps\mp\_utility::getotherteam(level.nukeinfo.team)] = 0;
	}
	else
	{
		level.teamnukeemped[level.nukeinfo.team] = 0;
		level.teamnukeemped[maps\mp\_utility::getotherteam(level.nukeinfo.team)] = 0;
	}

	foreach(var_01 in level.players)
	{
		if(level.teambased && var_01.team == level.nukeinfo.team)
		{
			continue;
		}

		var_01.nuked = undefined;
	}

	level notify("nuke_emp_update");
	level notify("nuke_emp_ended");
}

//Function Number: 16
keepnukeemptimeremaining()
{
	level notify("keepNukeEMPTimeRemaining");
	level endon("keepNukeEMPTimeRemaining");
	level endon("nuke_emp_ended");
	level.nukeemptimeremaining = int(level.nukeemptimeout);
	while(level.nukeemptimeremaining)
	{
		wait 1;
		level.nukeemptimeremaining--;
	}
}

//Function Number: 17
nuke_empteamtracker()
{
	level endon("game_ended");
	for(;;)
	{
		level common_scripts\utility::waittill_either("joined_team","nuke_emp_update");
		foreach(var_01 in level.players)
		{
			if(var_01.team == "spectator")
			{
				continue;
			}

			if(level.teambased)
			{
				if(isdefined(level.nukeinfo.team) && var_01.team == level.nukeinfo.team)
				{
					continue;
				}
			}
			else if(isdefined(level.nukeinfo.player) && var_01 == level.nukeinfo.player)
			{
				continue;
			}

			if(!level.teamnukeemped[var_01.team] && !var_01 maps\mp\_utility::isemped())
			{
				var_01 setempjammed(0);
				continue;
			}

			var_01 setempjammed(1);
		}
	}
}

//Function Number: 18
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 19
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if(level.teamnukeemped[self.team])
		{
			if(level.teambased)
			{
				self setempjammed(1);
			}
			else if(!isdefined(level.nukeinfo.player) || isdefined(level.nukeinfo.player) && self != level.nukeinfo.player)
			{
				self setempjammed(1);
			}
		}

		if(isdefined(level.nukedetonated))
		{
			self visionsetnakedforplayer(level.nukevisionset,0);
		}
	}
}

//Function Number: 20
update_ui_timers()
{
	level endon("game_ended");
	level endon("disconnect");
	level endon("nuke_cancelled");
	level endon("nuke_death");
	var_00 = level.nuketimer * 1000 + gettime();
	setdvar("ui_nuke_end_milliseconds",var_00);
	level waittill("host_migration_begin");
	var_01 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(var_01 > 0)
	{
		setdvar("ui_nuke_end_milliseconds",var_00 + var_01);
	}
}