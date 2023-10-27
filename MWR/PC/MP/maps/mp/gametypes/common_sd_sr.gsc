/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\common_sd_sr.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 545 ms
 * Timestamp: 10/27/2023 2:38:01 AM
*******************************************************************/

//Function Number: 1
onprecachegametype()
{
	maps\mp\gametypes\common_bomb_gameobject::onprecachegametype();
}

//Function Number: 2
updategametypedvars()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer",45,1,300);
	level.multibomb = maps\mp\_utility::dvarintvalue("multibomb",0,0,1);
	level.silentplant = maps\mp\_utility::dvarintvalue("silentplant",0,0,1);
}

//Function Number: 3
isplayeroutsideofanybombsite(param_00)
{
	if(isdefined(level.bombzones))
	{
		foreach(var_02 in level.bombzones)
		{
			if(distancesquared(self.origin,var_02.trigger.origin) < 4096)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 4
onnormaldeath(param_00,param_01,param_02)
{
	if(game["state"] == "postgame" && param_00.team == game["defenders"] || !level.bombplanted)
	{
		param_01.finalkill = 1;
	}

	if(param_00.isplanting || param_00.isdefusing)
	{
		param_01 thread maps\mp\_events::defendobjectiveevent(param_00,param_02);
		if(param_00.isplanting)
		{
			param_01 maps\mp\gametypes\_misions::processchallenge("ch_" + level.gametype + "_interrupt");
		}

		if(param_00.isdefusing)
		{
			param_01 maps\mp\gametypes\_misions::processchallenge("ch_" + level.gametype + "_protector");
		}
	}

	if(waseliminatedbyenemy(param_00,param_01))
	{
		var_03 = islastplayeralive(param_01);
		param_01 thread maps\mp\_events::eliminateplayerevent(var_03,param_00);
	}
}

//Function Number: 5
waseliminatedbyenemy(param_00,param_01)
{
	if(maps\mp\gametypes\_damage::isfriendlyfire(param_00,param_01))
	{
		return 0;
	}

	if(param_00 maps\mp\gametypes\_playerlogic::mayspawn())
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
onpickup(param_00)
{
	maps\mp\gametypes\common_bomb_gameobject::oncarrybombpickup(param_00,game["attackers"]);
	if(param_00.team == "allies")
	{
		param_00.objective = 1;
	}
	else
	{
		param_00.objective = 2;
	}

	if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[param_00.team]))
	{
		param_00.isrespawningwithbombcarrierclass = 1;
		param_00 thread maps\mp\_utility::applycarrierclass();
	}

	if(!level.bombdefused)
	{
		maps\mp\_utility::teamplayercardsplash("callout_bombtaken",param_00,param_00.team);
		maps\mp\_utility::leaderdialog("bomb_taken",param_00.pers["team"]);
	}
}

//Function Number: 7
bombs()
{
	level.bombplanted = 0;
	level.bombdefused = 0;
	level.bombexploded = 0;
	var_00 = getent("sd_bomb_pickup_trig","targetname");
	if(!isdefined(var_00))
	{
		common_scripts\utility::error("No sd_bomb_pickup_trig trigger found in map.");
		return;
	}

	var_01 = maps\mp\gametypes\common_bomb_gameobject::getcarrybombvisuals("sd_bomb");
	if(!isdefined(var_01))
	{
		common_scripts\utility::error("No sd_bomb script_model found in map.");
		return;
	}

	if(!level.multibomb)
	{
		level.sdbomb = maps\mp\gametypes\common_bomb_gameobject::createbombcarryobject(game["attackers"],"friendly",var_00,var_01);
		thread maps\mp\_utility::streamcarrierweaponstoplayers(level.sdbomb,[game["attackers"]],::shouldstreamcarrierclasstoplayer);
		if(game["attackers"] == "allies")
		{
			maps\mp\_utility::setmlgicons(level.sdbomb,"waypoint_bomb_green");
		}
		else
		{
			maps\mp\_utility::setmlgicons(level.sdbomb,"waypoint_bomb_red");
		}

		level.sdbomb.onpickup = ::onpickup;
		level.sdbomb.ondrop = ::ondrop;
	}
	else
	{
		var_00 delete();
		var_01[0] delete();
	}

	level.bombzones = [];
	var_02 = getentarray("bombzone","targetname");
	var_03 = getentarray("bombzone_augmented","targetname");
	if(maps\mp\_utility::isaugmentedgamemode())
	{
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_05 = var_03[var_04].script_label;
			for(var_06 = 0;var_06 < var_02.size;var_06++)
			{
				if(var_02[var_06].script_label == var_05)
				{
					removebombzone(var_02[var_06]);
					break;
				}
			}
		}
	}
	else
	{
		for(var_07 = 0;var_07 < var_03.size;var_07++)
		{
			removebombzone(var_03[var_07]);
		}
	}

	var_02 = common_scripts\utility::array_combine(var_02,var_03);
	for(var_07 = 0;var_07 < var_02.size;var_07++)
	{
		var_00 = var_02[var_07];
		var_01 = getentarray(var_02[var_07].target,"targetname");
		var_08 = undefined;
		if(!level.multibomb)
		{
			var_08 = level.sdbomb;
		}

		var_09 = maps\mp\gametypes\common_bomb_gameobject::createbombzoneobject(game["defenders"],"enemy","any",var_00,var_08,1);
		maps\mp\_utility::setmlgicons(var_09,"waypoint_esports_snd_target" + var_09.label + "_white");
		var_09.onbeginuse = ::onbeginuse;
		var_09.onenduse = ::onenduse;
		var_09.onuse = ::onuseplantobject;
		var_09.oncantuse = ::oncantuse;
		level.bombzones[level.bombzones.size] = var_09;
		var_09.bombdefusetrig = getent(var_01[0].target,"targetname");
		var_09.bombdefusetrig.origin = var_09.bombdefusetrig.origin + (0,0,-10000);
		var_09.bombdefusetrig.label = var_09.label;
		var_09.bombdefusetrig method_852A(1);
	}

	for(var_07 = 0;var_07 < level.bombzones.size;var_07++)
	{
		var_0A = [];
		for(var_0B = 0;var_0B < level.bombzones.size;var_0B++)
		{
			if(var_0B != var_07)
			{
				var_0A[var_0A.size] = level.bombzones[var_0B];
			}
		}

		level.bombzones[var_07].otherbombzones = var_0A;
	}

	setomnvar("ui_mlg_game_mode_status_1",0);
}

//Function Number: 8
shouldstreamcarrierclasstoplayer(param_00,param_01)
{
	if(level.bombplanted)
	{
		return 0;
	}

	if(isdefined(param_00.carrier) && param_00.carrier == param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
removebombzone(param_00)
{
	var_01 = getentarray("script_brushmodel","classname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_gameobjectname) || var_03.script_gameobjectname != "bombzone")
		{
			continue;
		}

		if(!isdefined(var_03.script_label))
		{
			continue;
		}

		if(issubstr(var_03.script_label,param_00.script_label) && issubstr(var_03.script_label,param_00.targetname))
		{
			var_03 delete();
		}
	}

	var_05 = getentarray(param_00.target,"targetname");
	foreach(var_07 in var_05)
	{
		if(isdefined(var_07.target))
		{
			var_08 = getentarray(var_07.target,"targetname");
			foreach(var_0A in var_08)
			{
				var_0A delete();
			}
		}

		var_07 delete();
	}

	param_00 delete();
}

//Function Number: 10
onuseplantobject(param_00)
{
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		level thread bombplanted(self,param_00);
		for(var_01 = 0;var_01 < level.bombzones.size;var_01++)
		{
			if(level.bombzones[var_01] == self)
			{
				var_02 = level.bombzones[var_01] maps\mp\gametypes\_gameobjects::getlabel();
				maps\mp\_utility::setmlgicons(level.bombzones[var_01],"waypoint_esports_snd_planted" + var_02);
				continue;
			}

			level.bombzones[var_01] maps\mp\gametypes\_gameobjects::disableobject();
			maps\mp\_utility::setmlgicons(level.bombzones[var_01],undefined);
		}

		param_00 maps\mp\gametypes\common_bomb_gameobject::onplayerplantbomb(1,game["attackers"],game["defenders"]);
		if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[param_00.team]))
		{
			param_00 thread maps\mp\_utility::removecarrierclass();
			return;
		}

		return;
	}

	self.bombplantedon = 0;
}

//Function Number: 11
onbeginuse(param_00)
{
	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		maps\mp\gametypes\common_bomb_gameobject::onbegindefusebomb(param_00,level.sdbombmodel);
		return;
	}

	maps\mp\gametypes\common_bomb_gameobject::onbeginplantbomb(param_00);
	if(level.multibomb)
	{
		for(var_01 = 0;var_01 < self.otherbombzones.size;var_01++)
		{
			self.otherbombzones[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
			self.otherbombzones[var_01] maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
		}
	}
}

//Function Number: 12
onenduse(param_00,param_01,param_02)
{
	if(param_01.isplanting && level.multibomb && !param_02)
	{
		for(var_03 = 0;var_03 < self.otherbombzones.size;var_03++)
		{
			self.otherbombzones[var_03] maps\mp\gametypes\_gameobjects::allowuse("enemy");
			self.otherbombzones[var_03] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		}
	}

	var_04 = isdefined(param_01) && param_01.isdefusing && !param_02;
	maps\mp\gametypes\common_bomb_gameobject::onendusebomb(param_01,var_04);
}

//Function Number: 13
bombplantedanim(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 playerlinkto(level.sdbombmodel);
	param_00 playerlinkedoffsetenable();
	while(param_00 getcurrentweapon() == self.useweapon)
	{
		wait 0.05;
	}

	param_00 unlink();
}

//Function Number: 14
bombplanted(param_00,param_01)
{
	level.bombplanted = 1;
	param_01.objective = 0;
	level.defuseendtime = int(gettime() + level.bombtimer * 1000);
	setgameendtime(level.defuseendtime);
	setomnvar("ui_bomb_timer",1);
	if(!level.multibomb)
	{
		level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
		level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
		maps\mp\_utility::setmlgicons(level.sdbomb,undefined);
		level.sdbomb maps\mp\gametypes\_gameobjects::setdropped();
		level.sdbombmodel = level.sdbomb.visuals[0];
	}
	else
	{
		level.sdbombmodel = spawn("script_model",param_01.origin);
		level.sdbombmodel.angles = param_01.angles;
		level.sdbombmodel setmodel("wpn_h1_briefcase_bomb_npc");
	}

	param_00 maps\mp\gametypes\common_bomb_gameobject::onbombplanted(level.sdbombmodel.origin + (0,0,1));
	param_00 maps\mp\gametypes\_gameobjects::allowuse("none");
	param_00 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	var_02 = param_00 maps\mp\gametypes\_gameobjects::getlabel();
	var_03 = param_00.bombdefusetrig;
	var_03.origin = level.sdbombmodel.origin;
	var_04 = [];
	var_05 = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"],var_03,var_04,(0,0,32));
	var_05.label = var_02;
	var_05 maps\mp\gametypes\common_bomb_gameobject::setupzonefordefusing(1);
	var_05.onbeginuse = ::onbeginuse;
	var_05.onenduse = ::onenduse;
	var_05.onuse = ::onusedefuseobject;
	var_05.nousebar = 1;
	var_05.id = "defuseObject";
	if(var_02 == "_a" || var_02 == "_A")
	{
		setomnvar("ui_mlg_game_mode_status_1",1);
	}
	else if(var_02 == "_b" || var_02 == "_B")
	{
		setomnvar("ui_mlg_game_mode_status_1",2);
	}

	bombtimerwait(var_05 isbombsiteb());
	setomnvar("ui_bomb_timer",0);
	setbombendtime(0,var_05 isbombsiteb());
	param_00.tickingobject maps\mp\gametypes\common_bomb_gameobject::stoptickingsound();
	if(level.gameended || level.bombdefused)
	{
		return;
	}

	level.bombexploded = 1;
	setomnvar("ui_mlg_game_mode_status_1",0);
	var_06 = level.sdbombmodel.origin;
	var_06 = var_06 + (0,0,10);
	level.sdbombmodel hide();
	param_00 maps\mp\gametypes\common_bomb_gameobject::onbombexploded(var_06,300,param_01);
	for(var_07 = 0;var_07 < level.bombzones.size;var_07++)
	{
		level.bombzones[var_07] maps\mp\gametypes\_gameobjects::disableobject();
	}

	var_05 maps\mp\gametypes\_gameobjects::disableobject();
	setgameendtime(0);
	wait(3);
	sd_endgame(game["attackers"],game["end_reason"]["target_destroyed"]);
}

//Function Number: 15
isbombsiteb()
{
	return self.label == "_b" || self.label == "_B";
}

//Function Number: 16
setbombendtime(param_00,param_01)
{
	if(param_01)
	{
		setomnvar("ui_bomb_timer_endtime_2",param_00);
		return;
	}

	setomnvar("ui_bomb_timer_endtime",param_00);
}

//Function Number: 17
bombtimerwait(param_00)
{
	level endon("game_ended");
	level endon("bomb_defused");
	var_01 = int(level.bombtimer * 1000 + gettime());
	setbombendtime(var_01,param_00);
	level thread handlehostmigration(var_01,param_00);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

//Function Number: 18
handlehostmigration(param_00,param_01)
{
	level endon("game_ended");
	level endon("bomb_defused");
	level endon("game_ended");
	level endon("disconnect");
	level waittill("host_migration_begin");
	setbombendtime(0,param_01);
	var_02 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(var_02 > 0)
	{
		setbombendtime(param_00 + var_02,param_01);
	}
}

//Function Number: 19
ondrop(param_00)
{
	maps\mp\gametypes\common_bomb_gameobject::oncarrybombdrop(game["attackers"],game["defenders"]);
}

//Function Number: 20
onusedefuseobject(param_00)
{
	param_00 maps\mp\gametypes\common_bomb_gameobject::onplayerdefusebomb(getdefusetype(param_00),game["defenders"],game["attackers"]);
	thread bombdefused(isbombsiteb());
}

//Function Number: 21
getdefusetype(param_00)
{
	var_01 = "defuse";
	if(isdefined(level.bombowner) && maps\mp\_utility::isreallyalive(level.bombowner))
	{
		var_01 = "ninja_defuse";
	}

	if(islastplayeralive(param_00))
	{
		var_01 = "last_man_defuse";
	}

	return var_01;
}

//Function Number: 22
islastplayeralive(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02 == param_00)
		{
			continue;
		}

		if(var_02 maps\mp\gametypes\_playerlogic::mayspawn())
		{
			return 0;
		}

		if(maps\mp\_utility::isreallyalive(var_02))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 23
bombdefused(param_00)
{
	maps\mp\gametypes\_gameobjects::disableobject();
	level.bombdefused = 1;
	setbombendtime(0,param_00);
	setomnvar("ui_bomb_timer",0);
	setomnvar("ui_mlg_game_mode_status_1",0);
	level notify("bomb_defused");
	wait(1.5);
	setgameendtime(0);
	sd_endgame(game["defenders"],game["end_reason"]["bomb_defused"]);
}

//Function Number: 24
oncantuse(param_00)
{
	param_00 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

//Function Number: 25
ontimelimit()
{
	sd_endgame(game["defenders"],game["end_reason"]["time_limit_reached"]);
}

//Function Number: 26
sd_endgame(param_00,param_01)
{
	level.finalkillcam_winner = param_00;
	if(param_00 == game["attackers"])
	{
		if(!isdefined(game["attackerWinCount"]))
		{
			game["attackerWinCount"] = 0;
		}

		game["attackerWinCount"]++;
	}
	else if(param_00 == game["defenders"])
	{
		if(!isdefined(game["defenderWinCount"]))
		{
			game["defenderWinCount"] = 0;
		}

		game["defenderWinCount"]++;
	}

	if(param_01 == game["end_reason"]["target_destroyed"] || param_01 == game["end_reason"]["bomb_defused"])
	{
		var_02 = 1;
		foreach(var_04 in level.bombzones)
		{
			if(isdefined(level.finalkillcam_killcamentityindex[param_00]) && level.finalkillcam_killcamentityindex[param_00] == var_04.killcamentnum)
			{
				var_02 = 0;
				break;
			}
		}

		if(var_02)
		{
			maps\mp\gametypes\_damage::erasefinalkillcam();
		}
	}

	maps\mp\gametypes\_gamescores::giveteamscoreforobjective(param_00,1);
	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 27
checkallowspectating()
{
	wait(0.05);
	var_00 = 0;
	if(!level.alivecount[game["attackers"]])
	{
		level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(!level.alivecount[game["defenders"]])
	{
		level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(var_00)
	{
		maps\mp\gametypes\_spectating::updatespectatesettings();
	}
}

//Function Number: 28
onplayerdisconnect()
{
	level endon("game_ended");
	self notify("onPlayerDisconnect");
	self endon("onPlayerDisconnect");
	self waittill("disconnect");
	thread checkallowspectating();
}

//Function Number: 29
ondeadevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	if(param_00 == "all")
	{
		if(level.bombplanted)
		{
			sd_endgame(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
			return;
		}

		sd_endgame(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["attackers"])
	{
		if(level.bombplanted)
		{
			return;
		}

		level thread sd_endgame(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		level thread sd_endgame(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
		return;
	}
}

//Function Number: 30
ononeleftevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	var_01 = maps\mp\_utility::getlastlivingplayer(param_00);
	var_01 thread givelastonteamwarning();
}

//Function Number: 31
givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	var_00 = maps\mp\_utility::getotherteam(self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive",self,self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive",self,var_00);
	level notify("last_alive",self);
	maps\mp\gametypes\_misions::lastmansd();
}

//Function Number: 32
onreset()
{
}