/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_detroit.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 266 ms
 * Timestamp: 4/22/2024 2:12:32 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakwieldweapons["detroit_tram_turret_mp"] = "mp_detroit";
	level.killstreakfuncs["mp_detroit"] = ::tryusekillstreak;
	level.mapkillstreak = "mp_detroit";
	level.mapkillstreakpickupstring = &"MP_DETROIT_MAP_KILLSTREAK_PICKUP";
	level.getaerialkillstreakarray = ::tramlockonentsforteam;
	level.streak_trams = getentarray("streak_tram","targetname");
	common_scripts\utility::array_thread(level.streak_trams,::maps\mp\mp_detroit_events::tram_init);
	common_scripts\utility::array_thread(level.streak_trams,::tram_killstreak_init);
	level.detroittramobjids = [];
	var_00 = ["allies","axis"];
	foreach(var_02 in var_00)
	{
		level.detroittramobjids[var_02] = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(level.detroittramobjids[var_02],"invisible",(0,0,0));
		objective_icon(level.detroittramobjids[var_02],common_scripts\utility::ter_op(var_02 == "allies","compass_objpoint_tram_turret_friendly","compass_objpoint_tram_turret_enemy"));
	}
}

//Function Number: 2
setupbotsformapkillstreak()
{
	level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_detroit",::maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

//Function Number: 3
tram_killstreak_init()
{
	self.getstingertargetposfunc = ::tram_stinger_target_pos;
}

//Function Number: 4
tram_stinger_target_pos()
{
	return self gettagorigin("tag_turret");
}

//Function Number: 5
tramlockonentsforteam(param_00)
{
	var_01 = [];
	foreach(var_03 in level.streak_trams)
	{
		if(var_03.active && isdefined(var_03.owner) && !level.teambased || var_03.owner.team == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 6
tryusekillstreak(param_00,param_01)
{
	if(level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		return 0;
	}

	var_02 = 0;
	foreach(var_04 in level.streak_trams)
	{
		if(var_04.active)
		{
			var_02 = 1;
			break;
		}
		else
		{
			var_04 maps\mp\mp_detroit_events::tram_reset();
		}
	}

	var_06 = undefined;
	if(!var_02)
	{
		level.streak_trams = sortbydistance(level.streak_trams,self.origin);
		var_06 = level.streak_trams[0];
	}

	if(isdefined(var_06))
	{
		var_07 = maps\mp\killstreaks\_killstreaks::initridekillstreak("mp_detroit_tram");
		if(var_07 != "success")
		{
			return 0;
		}

		maps\mp\_utility::incrementfauxvehiclecount();
		thread run_tram_killstreak(var_06);
		return 1;
	}

	self iprintlnbold(&"MP_DETROIT_MAP_KILLSTREAK_NOT_AVAILABLE");
	return 0;
}

//Function Number: 7
run_tram_killstreak(param_00)
{
	var_01 = 35;
	param_00 maps\mp\mp_detroit_events::tram_reset();
	param_00.owner = self;
	param_00.team = self.team;
	param_00.turret = param_00 spawn_tram_turret();
	param_00.isleaving = 0;
	param_00.stopdamagefunc = 0;
	param_00 tram_show_icon();
	param_00 thread maps\mp\gametypes\_damage::setentitydamagecallback(1000,undefined,::tramondeath,undefined,1);
	self notifyonplayercommand("CancelTramStart","+usereload");
	self notifyonplayercommand("CancelTramEnd","-usereload");
	maps\mp\_utility::setusingremote("mp_detroit_tram");
	self remotecontrolturret(param_00.turret,30,param_00.angles[1] - 90);
	param_00 thread tram_update_shooting_location();
	param_00 common_scripts\utility::make_entity_sentient_mp(param_00.team);
	self playerlinkweaponviewtodelta(param_00,"tag_player",0,180,180,0,90,0);
	self playerlinkedsetviewznear(0);
	self thermalvisionfofoverlayon();
	self setclientomnvar("ui_detroit_tram_turret",1);
	param_00 thread tram_killstreak_team_change_watch();
	param_00 thread tram_killstreak_cancel_watch();
	param_00 thread tram_killstreak_exit_watch();
	param_00 thread tram_killstreak_move(var_01);
	param_00 thread tram_killstreak_match_ended();
	param_00 thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
}

//Function Number: 8
tram_update_shooting_location()
{
	var_00 = self.owner;
	self endon("player_exit");
	var_00 endon("disconnect");
	self.turret endon("death");
	self.target_ent = spawn("script_model",(0,0,0));
	self.target_ent setmodel("tag_origin");
	self.turret turretsetgroundaimentity(self.target_ent);
	for(;;)
	{
		var_01 = self.turret gettagorigin("tag_player");
		var_02 = self.turret gettagorigin("tag_player") + anglestoforward(self.turret gettagangles("tag_player")) * 20000;
		var_03 = bullettrace(var_01,var_02,0,self.turret);
		var_04 = var_03["position"];
		self.target_ent.origin = var_04;
		wait 0.05;
	}
}

//Function Number: 9
tram_killstreak_match_ended()
{
	self endon("player_exit");
	level waittill("game_ended");
	self notify("player_exit");
}

//Function Number: 10
tram_show_icon()
{
	foreach(var_02, var_01 in level.detroittramobjids)
	{
		objective_state(var_01,"active");
		if(var_02 == "allies")
		{
			objective_playerteam(var_01,self.owner getentitynumber());
		}
		else
		{
			objective_playerenemyteam(var_01,self.owner getentitynumber());
		}

		objective_onentitywithrotation(var_01,self.turret.obj_ent);
	}
}

//Function Number: 11
tram_hide_icon()
{
	foreach(var_01 in level.detroittramobjids)
	{
		objective_state(var_01,"invisible");
	}
}

//Function Number: 12
tramondeath(param_00,param_01,param_02,param_03)
{
	self notify("player_exit");
	maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,"map_killstreak_destroyed",undefined,"callout_destroyed_tram_turet",1);
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("vehicle_pdrone_explosion"),self,"tag_turret");
	if(isdefined(self.turret))
	{
		self.turret delete();
	}

	if(isdefined(self.target_ent))
	{
		self.target_ent delete();
	}
}

//Function Number: 13
tram_killstreak_cancel_watch()
{
	var_00 = self.owner;
	self endon("player_exit");
	var_00 endon("disconnect");
	for(;;)
	{
		var_00 waittill("CancelTramStart");
		var_01 = var_00 common_scripts\utility::waittill_any_timeout(1,"CancelTramEnd");
		if(var_01 == "timeout")
		{
			self notify("player_exit");
		}
	}
}

//Function Number: 14
tram_killstreak_team_change_watch()
{
	var_00 = self.owner;
	self endon("player_exit");
	var_00 endon("disconnect");
	var_00 common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self notify("player_exit");
}

//Function Number: 15
tram_killstreak_move(param_00)
{
	maps\mp\mp_detroit_events::tram_spline_move(param_00);
	self notify("player_exit");
	self waittill("trackEnd");
	if(isdefined(self.turret))
	{
		self.turret delete();
	}

	if(isdefined(self.target_ent))
	{
		self.target_ent delete();
	}
}

//Function Number: 16
tram_killstreak_exit_watch()
{
	self endon("disconnect");
	self waittill("player_exit");
	tram_hide_icon();
	self.owner setclientomnvar("ui_detroit_tram_turret",0);
	self.owner thermalvisionfofoverlayoff();
	self.owner unlink();
	self.owner remotecontrolturretoff(self.turret);
	self freeentitysentient();
	self.owner maps\mp\_utility::clearusingremote();
	self.owner = undefined;
	thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
	self notify("leaving");
	self.isleaving = 1;
}

//Function Number: 17
spawn_tram_turret()
{
	var_00 = "tag_turret";
	var_01 = spawnturret("misc_turret",self.origin,"detroit_tram_turret_mp",0);
	var_01.angles = (0,0,0);
	var_01 setmodel("vehicle_xh9_warbird_turret_detroit_mp");
	var_01 setdefaultdroppitch(45);
	var_01 linkto(self,var_00,(0,0,0),(0,0,0));
	var_01.owner = self.owner;
	var_01.health = 99999;
	var_01.maxhealth = 1000;
	var_01.damagetaken = 0;
	var_01.stunned = 0;
	var_01.stunnedtime = 0;
	var_01 setcandamage(0);
	var_01 setcanradiusdamage(0);
	var_01.team = self.team;
	var_01.pers["team"] = self.team;
	if(level.teambased)
	{
		var_01 setturretteam(self.team);
	}

	var_01 setmode("sentry_manual");
	var_01 setsentryowner(self.owner);
	var_01 setturretminimapvisible(0);
	var_01.chopper = self;
	var_02 = spawn("script_model",self.origin);
	var_02 linkto(var_01,"tag_aim_pivot",(0,0,0),(0,0,0));
	var_02 setcontents(0);
	var_01 thread common_scripts\utility::delete_on_death(var_02);
	var_01.obj_ent = var_02;
	return var_01;
}