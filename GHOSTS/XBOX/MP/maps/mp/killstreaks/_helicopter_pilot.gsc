/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter_pilot.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 28
 * Decompile Time: 421 ms
 * Timestamp: 10/27/2023 1:32:42 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["heli_pilot"] = ::func_843A;
	level.heli_pilot = [];
	level.helipilotsettings = [];
	level.helipilotsettings["heli_pilot"] = addstruct();
	level.helipilotsettings["heli_pilot"].timeout = 60;
	level.helipilotsettings["heli_pilot"].maxhealth = 2000;
	level.helipilotsettings["heli_pilot"].streakname = "heli_pilot";
	level.helipilotsettings["heli_pilot"].vehicleinfo = "heli_pilot_mp";
	level.helipilotsettings["heli_pilot"].modelbase = level.littlebird_model;
	level.helipilotsettings["heli_pilot"].teamsplash = "used_heli_pilot";
	helipilot_setairstartnodes();
	level.heli_pilot_mesh = getent("heli_pilot_mesh","targetname");
	if(!isdefined(level.heli_pilot_mesh))
	{
	}
	else
	{
		level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + maps\mp\_utility::gethelipilotmeshoffset();
	}

	var_00 = addstruct();
	var_00.xppopup = "destroyed_helo_pilot";
	var_00.vodestroyed = undefined;
	var_00.callout = "callout_destroyed_helo_pilot";
	var_00.samdamagescale = 0.09;
	var_00.enginevfxtag = "tag_engine_right";
	level.heliconfigs["heli_pilot"] = var_00;
}

//Function Number: 2
func_843A(param_00,param_01)
{
	var_02 = "heli_pilot";
	var_03 = 1;
	if(isdefined(self.underwater) && self.underwater)
	{
		return 0;
	}
	else if(func_303F(self.team))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_03 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	maps\mp\_utility::func_4487();
	var_04 = func_20F8(var_02);
	if(!isdefined(var_04))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	level.heli_pilot[self.team] = var_04;
	var_05 = starthelipilot(var_04);
	if(!isdefined(var_05))
	{
		var_05 = 0;
	}

	return var_05;
}

//Function Number: 3
func_303F(param_00)
{
	if(level.gametype == "dm")
	{
		if(isdefined(level.heli_pilot[param_00]) || isdefined(level.heli_pilot[level.otherteam[param_00]]))
		{
			return 1;
		}

		return 0;
	}

	if(isdefined(level.heli_pilot[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
watchhostmigrationfinishedinit(param_00)
{
	param_00 endon("killstreak_disowned");
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		param_00 setclientomnvar("ui_heli_pilot",1);
	}
}

//Function Number: 5
func_20F8(param_00)
{
	var_01 = func_4164(self.origin);
	var_02 = func_4165(var_01);
	var_03 = vectortoangles(var_02.origin - var_01.origin);
	var_04 = anglestoforward(self.angles);
	var_05 = var_02.origin + var_04 * -100;
	var_06 = var_01.origin;
	var_07 = spawnhelicopter(self,var_06,var_03,level.helipilotsettings[param_00].vehicleinfo,level.helipilotsettings[param_00].modelbase);
	if(!isdefined(var_07))
	{
	}

	var_07 makevehiclesolidcapsule(18,-9,18);
	var_07 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
	var_07 thread maps\mp\killstreaks\_helicopter::func_6590();
	var_07.maxhealth = level.helipilotsettings[param_00].maxhealth;
	var_07.speed = 40;
	var_07.owner = self;
	var_07 setotherent(self);
	var_07.team = self.team;
	var_07.helitype = "littlebird";
	var_07.helipilottype = "heli_pilot";
	var_07 setmaxpitchroll(45,45);
	var_07 setspeed(var_07.speed,40,40);
	var_07 setyawspeed(120,60);
	var_07 neargoalnotifydist(32);
	var_07 sethoverparams(100,100,100);
	var_07 common_scripts\utility::func_5009(var_07.team);
	var_07.targetpos = var_05;
	var_07.currentnode = var_02;
	var_07.attract_strength = 10000;
	var_07.attract_range = 150;
	var_07.attractor = missilecreateattractorent(var_07,var_07.attract_strength,var_07.attract_range);
	var_07 thread maps\mp\killstreaks\_helicopter::func_40A5("heli_pilot");
	var_07 thread func_4167();
	var_07 thread helipilot_watchtimeout();
	var_07 thread helipilot_watchownerloss();
	var_07 thread func_416D();
	var_07 thread func_416B();
	var_07 thread helipilot_watchdeath();
	var_07 thread watchhostmigrationfinishedinit(self);
	var_07.owner maps\mp\_matchdata::func_4F1D(level.helipilotsettings[var_07.helipilottype].streakname,var_07.targetpos);
	return var_07;
}

//Function Number: 6
func_4167()
{
	playfxontag(level.chopper_fx["light"]["left"],self,"tag_light_nose");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["belly"],self,"tag_light_belly");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail1");
	wait(0.05);
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail2");
}

//Function Number: 7
starthelipilot(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	maps\mp\_utility::func_720F(param_00.helipilottype);
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::func_70E6(0);
	}

	self.restoreangles = self.angles;
	param_00 thread maps\mp\killstreaks\_flares::ks_setup_manual_flares(2,"+smoke","ui_heli_pilot_flare_ammo","ui_heli_pilot_warn");
	thread func_8CFB(param_00);
	maps\mp\_utility::func_350E(1);
	var_01 = maps\mp\killstreaks\_killstreaks::func_4649(param_00.helipilottype);
	if(var_01 != "success")
	{
		if(isdefined(self.disabledweapon) && self.disabledweapon)
		{
			common_scripts\utility::_enableweapon();
		}

		param_00 notify("death");
		return 0;
	}

	maps\mp\_utility::func_350E(0);
	var_02 = maps\mp\_utility::func_3AC9();
	var_03 = param_00.currentnode.origin + maps\mp\_utility::gethelipilotmeshoffset() + var_02;
	var_04 = param_00.currentnode.origin + maps\mp\_utility::gethelipilotmeshoffset() - var_02;
	var_05 = bullettrace(var_03,var_04,0,undefined,0,0,1);
	if(!isdefined(var_05["entity"]))
	{
	}

	var_06 = var_05["position"] - maps\mp\_utility::gethelipilotmeshoffset() + (0,0,250);
	var_07 = spawn("script_origin",var_06);
	self remotecontrolvehicle(param_00);
	param_00 thread func_415A(var_07);
	param_00 thread func_4169();
	level thread maps\mp\_utility::func_7FA0(level.helipilotsettings[param_00.helipilottype].teamsplash,self);
	param_00.killcament = spawn("script_origin",self sethybridscopestate());
	return 1;
}

//Function Number: 8
func_415A(param_00)
{
	self endon("death");
	level endon("game_ended");
	self remotecontrolvehicletarget(param_00);
	self waittill("goal_reached");
	self remotecontrolvehicletargetoff();
	param_00 delete();
}

//Function Number: 9
func_8CFB(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	param_00 endon("death");
	self waittill("intro_cleared");
	self setclientomnvar("ui_heli_pilot",1);
	var_01 = maps\mp\_utility::func_5A44(self,"cyan",self,0,"killstreak");
	func_65A4(var_01,param_00);
	foreach(var_03 in level.participants)
	{
		if(!maps\mp\_utility::func_4945(var_03) || var_03.sessionstate != "playing")
		{
			continue;
		}

		if(maps\mp\_utility::isenemy(var_03))
		{
			if(!var_03 maps\mp\_utility::_hasperk("specialty_noplayertarget"))
			{
				var_01 = maps\mp\_utility::func_5A44(var_03,"orange",self,0,"killstreak");
				var_03 func_65A4(var_01,param_00);
				continue;
			}

			var_03 thread func_9597(param_00);
		}
	}

	param_00 thread func_9599();
	thread func_8CDE(param_00);
}

//Function Number: 10
func_9597(param_00)
{
	self notify("watchForPerkRemoval");
	self endon("watchForPerkRemoval");
	self endon("death");
	self waittill("removed_specialty_noplayertarget");
	var_01 = maps\mp\_utility::func_5A44(self,"orange",param_00.owner,0,"killstreak");
	func_65A4(var_01,param_00);
}

//Function Number: 11
func_9599()
{
	self endon("leaving");
	self endon("death");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(var_00.sessionstate == "playing" && self.owner maps\mp\_utility::isenemy(var_00))
		{
			var_00 thread func_9597(self);
		}
	}
}

//Function Number: 12
func_65A4(param_00,param_01)
{
	thread func_9230(param_00,param_01);
	thread func_93AA(param_00,param_01);
}

//Function Number: 13
func_9230(param_00,param_01)
{
	self notify("heliRemoveOutline");
	self endon("heliRemoveOutline");
	self endon("outline_removed");
	self endon("disconnect");
	level endon("game_ended");
	var_02 = ["leaving","death"];
	param_01 common_scripts\utility::waittill_any_in_array_return_no_endon_death(var_02);
	if(isdefined(self))
	{
		maps\mp\_utility::func_5A40(param_00,self);
		self notify("outline_removed");
	}
}

//Function Number: 14
func_93AA(param_00,param_01)
{
	self notify("playerRemoveOutline");
	self endon("playerRemoveOutline");
	self endon("outline_removed");
	self endon("disconnect");
	level endon("game_ended");
	var_02 = ["death"];
	common_scripts\utility::waittill_any_in_array_return_no_endon_death(var_02);
	maps\mp\_utility::func_5A40(param_00,self);
	self notify("outline_removed");
}

//Function Number: 15
helipilot_watchdeath()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	if(isdefined(self.owner))
	{
		self.owner func_4162(self);
	}

	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	thread maps\mp\killstreaks\_helicopter::func_4D0A();
}

//Function Number: 16
func_416B()
{
	level endon("game_ended");
	self endon("gone");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	level waittill("objective_cam");
	thread maps\mp\killstreaks\_helicopter::func_4D0A();
	if(isdefined(self.owner))
	{
		self.owner func_4162(self);
	}
}

//Function Number: 17
helipilot_watchtimeout()
{
	level endon("game_ended");
	self endon("death");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	var_00 = level.helipilotsettings[self.helipilottype].timeout;
	maps\mp\gametypes\_hostmigration::func_8B0D(var_00);
	thread helipilot_leave();
}

//Function Number: 18
helipilot_watchownerloss()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner common_scripts\utility::func_8B2A("disconnect","joined_team","joined_spectators");
	thread helipilot_leave();
}

//Function Number: 19
func_416D()
{
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	level common_scripts\utility::func_8B2A("round_end_finished","game_ended");
	thread helipilot_leave();
}

//Function Number: 20
helipilot_leave()
{
	self endon("death");
	self notify("leaving");
	if(isdefined(self.owner))
	{
		self.owner func_4162(self);
	}

	var_00 = maps\mp\killstreaks\_airdrop::func_3AB0(self.origin);
	var_01 = self.origin + (0,0,var_00);
	self setspeed(140,60);
	self setmaxpitchroll(45,180);
	self setgoalpos(var_01);
	self waittill("goal");
	var_01 = var_01 + anglestoforward(self.angles) * 15000;
	var_02 = spawn("script_origin",var_01);
	if(isdefined(var_02))
	{
		self setlookatent(var_02);
		var_02 thread func_8A65(3);
	}

	self setgoalpos(var_01);
	self waittill("goal");
	self notify("gone");
	maps\mp\killstreaks\_helicopter::func_659E();
}

//Function Number: 21
func_8A65(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 22
func_4162(param_00)
{
	if(isdefined(param_00))
	{
		self setclientomnvar("ui_heli_pilot",0);
		param_00 notify("end_remote");
		if(maps\mp\_utility::func_4995())
		{
			maps\mp\_utility::func_1D59();
		}

		if(getdvarint("camera_thirdPerson"))
		{
			maps\mp\_utility::func_70E6(1);
		}

		self remotecontrolvehicleoff(param_00);
		self setangles(self.restoreangles);
		thread func_4163();
	}
}

//Function Number: 23
func_4163()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	maps\mp\_utility::func_350E(1);
	wait(0.5);
	maps\mp\_utility::func_350E(0);
}

//Function Number: 24
func_4169()
{
	self endon("leaving");
	self endon("death");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(isdefined(self.owner))
		{
			if(self.owner adsbuttonpressed())
			{
				if(!var_00)
				{
					self.owner setclientomnvar("ui_heli_pilot",2);
					var_00 = 1;
				}
			}
			else if(var_00)
			{
				self.owner setclientomnvar("ui_heli_pilot",1);
				var_00 = 0;
			}
		}

		wait(0.1);
	}
}

//Function Number: 25
helipilot_setairstartnodes()
{
	level.air_start_nodes = common_scripts\utility::func_3C1A("chopper_boss_path_start","targetname");
}

//Function Number: 26
func_4165(param_00)
{
	if(isdefined(param_00.script_linkto))
	{
		var_01 = param_00 common_scripts\utility::get_links();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = common_scripts\utility::func_3C18(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 27
func_4164(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.air_start_nodes)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 28
func_8CDE(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	self endon("leaving");
	param_00 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
	param_00 waittill("killstreakExit");
	param_00 thread helipilot_leave();
}