/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_torqued.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 885 ms
 * Timestamp: 4/22/2024 2:12:52 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["mp_torqued"] = ::tryusemptorqued;
	level.mapkillstreak = "mp_torqued";
	level.mapkillstreakpickupstring = &"MP_TORQUED_MAP_KILLSTREAK_PICKUP";
	level.killstreakwieldweapons["mp_torqued_beam"] = "mp_torqued";
	level.mapcustombotkillstreakfunc = ::setupbotsformapkillstreak;
	level.torquedkillstreakactive = 0;
	thread fusioncoresetup();
}

//Function Number: 2
setupbotsformapkillstreak()
{
	level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_torqued",::maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

//Function Number: 3
fusioncoresetup()
{
	if(!isdefined(level.fusioncore))
	{
		level.fusioncore = spawnstruct();
	}

	level.fusioncore.particle01 = loadfx("vfx/map/mp_torqued/reactor_core");
	level.fusioncore.particleexplosion = loadfx("vfx/map/mp_torqued/mp_torqued_shock_impact");
	level.fusioncore.particleexplosion2 = loadfx("fx/explosions/generic_explosion_distortion");
	level.fusioncore.particlezap = loadfx("vfx/map/mp_torqued/mp_torqued_energy_impact");
	level.fusioncore.particlezaptrail = loadfx("vfx/trail/charged_shot_2_trail_blue");
	level.fusioncore.particlezaptrail2 = loadfx("vfx/map/mp_torqued/mp_torqued_energy_trail");
	level.fusioncore.particlefinger01 = loadfx("vfx/map/mp_torqued/mp_torqued_electric_trail");
	level.fusioncore.camspawnarray = getentarray("core_killcam","targetname");
	fusioncoresetuppos(1);
	level.fusioncore.minimapenemyicon = "compassping_torqued_streak_enemy";
	level.fusioncore.minimapfriendlyicon = "compassping_torqued_streak_friendly";
	level thread onplayerconnectfucntions();
	foreach(var_01 in level.fusioncore.camspawnarray)
	{
		var_01 fusioncorekillcam();
	}
}

//Function Number: 4
fusioncoresetuppos(param_00)
{
	if(!isdefined(level.fusioncore))
	{
		return;
	}

	level.fusioncore.icon = getent("fusion_world_icon_" + param_00,"targetname");
	level.fusioncore.icon_fake = level.fusioncore.icon;
	level.fusioncore.center = common_scripts\utility::getstruct("fusion_origin_" + param_00,"targetname");
	level.fusioncore.laserarray = common_scripts\utility::getstructarray("laser_origin_" + param_00,"targetname");
}

//Function Number: 5
onplayerconnectfucntions()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 createtorquedfusiontrackingoverlay();
	}
}

//Function Number: 6
tryusemptorqued(param_00,param_01)
{
	if(!maps\mp\_utility::validateusestreak())
	{
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(level.torquedkillstreakactive == 1)
	{
		self iprintlnbold(&"MP_TORQUED_IN_USE");
		return 0;
	}

	level thread killstreaktorqued(self);
	return 1;
}

//Function Number: 7
killstreaktorqued(param_00)
{
	level endon("killstreak_over");
	level.torquedkillstreakactive = 1;
	var_01 = param_00.team;
	while(level.torqued_rockfall_active)
	{
		wait 0.05;
	}

	level.fusioncore.kill_list = [];
	fusioncorespinup(param_00);
	fusioncoretrackpeople(var_01,param_00);
	fusioncorekillpeople(var_01,param_00);
	fusioncorecooldown();
	fusioncoretrackpeople(var_01,param_00);
	fusioncorekillpeople(var_01,param_00);
	fusioncorecooldown();
	fusioncorecleanup(param_00);
	thread killstreakend();
}

//Function Number: 8
fusioncorecleanup(param_00)
{
	level notify("shutdown_streak_particles");
	level.fusioncore.icon_fake minimapremoveteamicon();
	destroyfriendlyplayericons(param_00);
	foreach(var_02 in level.players)
	{
		var_02 endtorquedtrackingoverlay();
	}
}

//Function Number: 9
fusioncorespinup(param_00)
{
	var_01 = 768;
	var_02 = 0.25;
	var_03 = "steady_rumble";
	var_04 = spawn("script_origin",level.fusioncore.center.origin);
	var_04 thread fusionspinupsound();
	playrumblelooponposition(var_03,level.fusioncore.center.origin);
	thread quakethink(var_02,var_01,level.fusioncore.center);
}

//Function Number: 10
destroyfriendlyplayericons(param_00)
{
	if(isdefined(level.fusioncore.icon.entityheadicons))
	{
		if(isdefined(level.fusioncore.icon.entityheadicons[param_00.team]))
		{
			level.fusioncore.icon.entityheadicons[param_00.team] destroy();
			level.fusioncore.icon.entityheadicons[param_00.team] = undefined;
			return;
		}

		if(isdefined(level.fusioncore.icon.entityheadicons[param_00.guid]))
		{
			level.fusioncore.icon.entityheadicons[param_00.guid] destroy();
			level.fusioncore.icon.entityheadicons[param_00.guid] = undefined;
			return;
		}
	}
}

//Function Number: 11
fusionspinupsound()
{
	thread maps\mp\_utility::playsoundinspace("mp_torqued_reactor_engine",level.fusioncore.center.origin);
}

//Function Number: 12
fusioncoretrackpeople(param_00,param_01)
{
	var_02 = 3;
	var_03 = "tank_rumble";
	level.fusioncore.center thread particlethink(level.fusioncore.particle01);
	playrumblelooponposition(var_03,level.fusioncore.center.origin);
	thread maps\mp\_utility::playsoundinspace("mp_torqued_reactor_ramp_up",level.fusioncore.center.origin);
	thread startlasertest(param_00,param_01);
	wait(var_02);
}

//Function Number: 13
fusioncorekillpeople(param_00,param_01)
{
	level.fusioncore.center thread particlethink(level.fusioncore.particleexplosion,2);
	level.fusioncore.center thread particlethink(level.fusioncore.particleexplosion2,2);
	thread maps\mp\_utility::playsoundinspace("mp_torqued_reactor_blast",level.fusioncore.center.origin);
	thread empenemyteam(param_00,param_01);
	foreach(var_03 in level.fusioncore.kill_list)
	{
		if(isdefined(var_03) && maps\mp\_utility::isreallyalive(var_03))
		{
			var_03 thread deathtouchzap(param_01);
		}
	}

	level notify("zap_players");
}

//Function Number: 14
empenemyteam(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.teamnamelist.size;var_02++)
	{
		if(param_00 != level.teamnamelist[var_02])
		{
			thread destroyactivesmallvehicles(param_01,level.teamnamelist[var_02]);
		}
	}

	foreach(var_04 in level.players)
	{
		if(var_04.team != param_00)
		{
			if(maps\mp\_utility::isreallyalive(var_04))
			{
				var_04 notify("emp_grenaded",param_01);
			}
		}
	}
}

//Function Number: 15
destroyactivesmallvehicles(param_00,param_01)
{
	thread maps\mp\killstreaks\_emp::destroyactiveturrets(param_00,param_01);
	thread maps\mp\killstreaks\_emp::destroyactiverockets(param_00,param_01);
	thread maps\mp\killstreaks\_emp::destroyactiveugvs(param_00,param_01);
}

//Function Number: 16
fusioncorecooldown()
{
	level notify("shutdown_streak_particles");
	var_00 = 3;
	level notify("Reactor_Cooldown");
	stopallrumbles();
	level.fusioncore.kill_list = [];
	foreach(var_02 in level.players)
	{
		var_02 endtorquedtrackingoverlay();
	}

	wait(var_00);
}

//Function Number: 17
particlelaserthink(param_00)
{
	var_01 = 15;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		thread particlelaserspawn(param_00);
	}
}

//Function Number: 18
particlelaserspawn(param_00)
{
	level endon("Reactor_Cooldown");
	var_01 = spawnfx(param_00,self.origin);
	var_02 = randomintrange(-180,180);
	var_03 = randomintrange(-180,180);
	var_04 = randomintrange(-180,180);
	var_05 = (var_02,var_03,var_04);
	var_01.angles = var_05;
	var_01 thread particlelasercleanup();
	for(;;)
	{
		triggerfx(var_01);
		wait(0.05);
	}
}

//Function Number: 19
particlelasercleanup()
{
	level waittill("Reactor_Cooldown");
	self delete();
}

//Function Number: 20
particlethink(param_00,param_01)
{
	var_02 = spawnfx(param_00,self.origin);
	var_02.angles = self.angles;
	triggerfx(var_02);
	if(!isdefined(param_01))
	{
		level waittill("shutdown_streak_particles");
		if(isdefined(var_02))
		{
			var_02 delete();
			return;
		}

		return;
	}

	if(isdefined(param_01))
	{
		wait(param_01);
		if(isdefined(var_02))
		{
			var_02 delete();
			return;
		}
	}
}

//Function Number: 21
particletrailthink(param_00,param_01)
{
	var_02 = level.fusioncore.center.origin;
	if(isdefined(self.lasernode))
	{
		var_02 = self.lasernode.origin;
	}

	var_03 = self geteye() + (0,0,-3);
	var_04 = var_02;
	var_05 = vectortoangles(var_03 - var_02);
	var_04 = var_04 + anglestoforward(var_05) * 32;
	var_06 = spawnfx(param_00,var_04);
	var_06.angles = var_05;
	triggerfx(var_06);
	var_07 = 3;
	for(var_08 = 0;var_08 < var_07;var_08++)
	{
		thread particlevolley(param_01,var_04,var_03,var_05);
		wait(0.05);
	}

	var_06 delete();
}

//Function Number: 22
particlevolley(param_00,param_01,param_02,param_03)
{
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04.origin = param_01;
	var_04.angles = param_03;
	var_04 show();
	wait(0.05);
	var_04 show();
	var_04 moveto(param_02,0.25);
	playfxontag(param_00,var_04,"tag_origin");
	wait(0.05);
	var_04 show();
	playfxontag(param_00,var_04,"tag_origin");
	wait(0.05);
	var_04 show();
	playfxontag(param_00,var_04,"tag_origin");
	var_04 waittill("movedone");
	stopfxontag(param_00,var_04,"tag_origin");
	var_04 delete();
}

//Function Number: 23
zapplayers(param_00)
{
}

//Function Number: 24
quakethink(param_00,param_01,param_02)
{
	level endon("killstreak_over");
	for(;;)
	{
		var_03 = randomfloatrange(1,1.7);
		earthquake(param_00,var_03,param_02.origin,param_01);
		wait(var_03 - 0.2);
	}
}

//Function Number: 25
deathtouchzap(param_00)
{
	particletrailthink(level.fusioncore.particlezaptrail,level.fusioncore.particlezaptrail2);
	thread particlethink(level.fusioncore.particlezap,1);
	var_01 = findfarthestkillcam();
	if(self.fuisioncorekillrange)
	{
		setplayerprekilledfunc();
		self thread [[ level.callbackplayerdamage ]](var_01,param_00,self.health + 9999,0,"MOD_HEAD_SHOT","mp_torqued_beam",self.origin,(0,0,0) - self.origin,"none",0);
		clearplayerprekilledfunc();
		return;
	}

	thread maps\mp\_flashgrenades::applyflash(5,2.5);
}

//Function Number: 26
setplayerprekilledfunc()
{
	self.prekilledfunc = ::playerprekilled;
}

//Function Number: 27
clearplayerprekilledfunc()
{
	self.prekilledfunc = undefined;
	self.hideondeath = 0;
}

//Function Number: 28
playerprekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(param_05 == "mp_torqued_beam")
	{
		playerplayvaporizefx();
	}
}

//Function Number: 29
playerplayvaporizefx()
{
	self.hideondeath = 1;
	var_00 = (0,0,30);
	var_01 = self getstance();
	if(var_01 == "crouch")
	{
		var_00 = (0,0,20);
	}
	else if(var_01 == "prone")
	{
		var_00 = (0,0,10);
	}

	playfx(common_scripts\utility::getfx("torqued_killstreak_death"),self.origin + var_00);
}

//Function Number: 30
findfarthestkillcam()
{
	var_00 = sortbydistance(level.fusioncore.camspawnarray,self.origin);
	var_01 = var_00[var_00.size - 1];
	return var_01;
}

//Function Number: 31
fusioncorekillcam(param_00)
{
	var_01 = undefined;
	var_01 = spawn("script_model",self.origin);
	var_01.angles = self.angles;
	self.killcament = var_01;
}

//Function Number: 32
removekillcamentity()
{
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}
}

//Function Number: 33
startlasertest(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(level.teambased == 0 && var_03 != param_01)
		{
			var_03 thread tracktargets();
			continue;
		}

		if(var_03 == param_01)
		{
			continue;
		}

		if(var_03.team != param_00)
		{
			var_03 thread tracktargets();
			continue;
		}

		var_03 thread onteamswitchdurringstreak(param_00);
	}

	thread onplayerconnectdurringstreak(param_00);
}

//Function Number: 34
tracktargets()
{
	self endon("disconnected");
	level endon("zap_players");
	var_00 = 0.1;
	self.lasernode = undefined;
	var_01 = 500;
	var_02 = 1000;
	var_03 = var_01 * var_01;
	var_04 = var_02 * var_02;
	for(;;)
	{
		foreach(var_06 in level.fusioncore.laserarray)
		{
			var_07 = 0;
			while(var_07 == 0)
			{
				if(isdefined(self))
				{
					var_08 = self geteye() + (0,0,-3);
					var_09 = distancesquared(var_08,var_06.origin);
					if(var_09 <= var_04)
					{
						var_0A = bullettrace(var_06.origin,var_08,1,0);
						if(isdefined(var_0A["entity"]) && self == var_0A["entity"] && isalive(self))
						{
							self.fuisioncorekillrange = var_09 <= var_03;
							if(!common_scripts\utility::array_contains(level.fusioncore.kill_list,self))
							{
								level.fusioncore.kill_list = common_scripts\utility::add_to_array(level.fusioncore.kill_list,self);
								self.lasernode = var_06;
								thread fadeinouttorquedtrackingoverlay();
								thread watchdeath();
							}

							thread drawparticleline(var_06);
							wait(var_00);
							continue;
						}
					}

					level.fusioncore.kill_list = common_scripts\utility::array_remove(level.fusioncore.kill_list,self);
					var_07 = 1;
					self notify("player_not_tracked");
					endtorquedtrackingoverlay();
					wait(var_00);
				}
			}
		}

		wait(var_00);
	}
}

//Function Number: 35
drawparticleline(param_00)
{
	var_01 = 200;
	var_02 = 1;
	var_03 = 200;
	var_04 = self geteye();
	var_05 = param_00.origin;
	var_01 = distance(var_04,var_05);
	if(var_01 < 200)
	{
		var_01 = 200;
	}

	var_02 = var_01 / var_03;
	var_02 = var_02 + 0.5;
	var_02 = int(var_02);
	var_06 = vectortoangles(var_04 - var_05);
	for(var_07 = 0;var_07 < var_02;var_07++)
	{
		var_08 = spawnfx(level.fusioncore.particlefinger01,var_05);
		var_08.angles = var_06;
		triggerfx(var_08);
		var_08 thread deleteparticlefinger();
		var_05 = var_05 + anglestoforward(var_06) * 200;
	}
}

//Function Number: 36
deleteparticlefinger()
{
	wait(0.15);
	self delete();
}

//Function Number: 37
watchdeath()
{
	level endon("zap_players");
	level endon("killstreak_over");
	self endon("disconnected");
	self waittill("death");
	level.fusioncore.kill_list = common_scripts\utility::array_remove(level.fusioncore.kill_list,self);
	endtorquedtrackingoverlay();
}

//Function Number: 38
waitingforspawnduringstreak(param_00)
{
	level endon("zap_players");
	self waittill("spawned_player");
	level.fusioncore.kill_list = common_scripts\utility::array_remove(level.fusioncore.kill_list,self);
	if(level.teambased == 0)
	{
		thread tracktargets();
		return;
	}

	if(self.team != param_00)
	{
		thread tracktargets();
	}
}

//Function Number: 39
onteamswitchdurringstreak(param_00)
{
	level endon("zap_players");
	for(;;)
	{
		self waittill("joined_team");
		thread waitingforspawnduringstreak(param_00);
		return 1;
	}
}

//Function Number: 40
onplayerconnectdurringstreak(param_00)
{
	level endon("zap_players");
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread waitingforspawnduringstreak(param_00);
		return 1;
	}
}

//Function Number: 41
minimapdisplayteamicon(param_00,param_01,param_02)
{
	if(!level.teambased)
	{
		var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_03,"invisible",self.origin);
		objective_state(var_03,"active");
		objective_player(var_03,param_00 getentitynumber());
		objective_icon(var_03,param_01);
		self.objid01 = var_03;
		var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(var_03,"invisible",self.origin);
		objective_state(var_03,"active");
		objective_playerenemyteam(var_03,param_00 getentitynumber());
		objective_icon(var_03,param_02);
		self.objid02 = var_03;
		return;
	}

	var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_03,"invisible",self.origin);
	objective_state(var_03,"active");
	objective_team(var_03,param_00.team);
	objective_icon(var_03,param_01);
	self.objid03 = var_03;
	var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_03,"invisible",self.origin);
	objective_state(var_03,"active");
	objective_team(var_03,level.otherteam[param_00.team]);
	objective_icon(var_03,param_02);
	self.objid04 = var_03;
}

//Function Number: 42
minimapremoveteamicon()
{
	if(isdefined(self.objid01))
	{
		maps\mp\_utility::_objective_delete(self.objid01);
	}

	if(isdefined(self.objid02))
	{
		maps\mp\_utility::_objective_delete(self.objid02);
	}

	if(isdefined(self.objid03))
	{
		maps\mp\_utility::_objective_delete(self.objid03);
	}

	if(isdefined(self.objid04))
	{
		maps\mp\_utility::_objective_delete(self.objid04);
	}
}

//Function Number: 43
createtorquedfusiontrackingoverlay()
{
	if(!isdefined(self.torquedfusiontrackingoverlay))
	{
		self.torquedfusiontrackingoverlay = newclienthudelem(self);
		self.torquedfusiontrackingoverlay.x = 0;
		self.torquedfusiontrackingoverlay.y = 0;
		self.torquedfusiontrackingoverlay setshader("torqued_reactor_tracking_overlay",640,480);
		self.torquedfusiontrackingoverlay.alignx = "left";
		self.torquedfusiontrackingoverlay.aligny = "top";
		self.torquedfusiontrackingoverlay.horzalign = "fullscreen";
		self.torquedfusiontrackingoverlay.vertalign = "fullscreen";
		self.torquedfusiontrackingoverlay.alpha = 0;
	}
}

//Function Number: 44
fadeinouttorquedtrackingoverlay()
{
	level endon("zap_players");
	level endon("killstreak_over");
	level endon("game_ended");
	self endon("player_not_tracked");
	if(isdefined(self.torquedfusiontrackingoverlay))
	{
		for(;;)
		{
			self.torquedfusiontrackingoverlay fadeovertime(0.2);
			self.torquedfusiontrackingoverlay.alpha = 1;
			wait(0.3);
			self.torquedfusiontrackingoverlay fadeovertime(0.2);
			self.torquedfusiontrackingoverlay.alpha = 0.3;
			wait(0.3);
		}
	}
}

//Function Number: 45
endtorquedtrackingoverlay()
{
	if(isdefined(self.torquedfusiontrackingoverlay))
	{
		self.torquedfusiontrackingoverlay fadeovertime(0.2);
		self.torquedfusiontrackingoverlay.alpha = 0;
	}
}

//Function Number: 46
killstreakend()
{
	var_00 = 3;
	level notify("killstreak_over");
	stopallrumbles();
	wait(var_00);
	level.torquedkillstreakactive = 0;
}