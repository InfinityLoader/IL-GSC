/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\siege.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 63
 * Decompile Time: 1134 ms
 * Timestamp: 10/27/2023 1:29:27 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::func_44DF();
	maps\mp\gametypes\_callbacksetup::func_71F0();
	maps\mp\gametypes\_globallogic::func_71F0();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_647E();
	}
	else
	{
		maps\mp\_utility::func_6473(level.gametype,3,0,9);
		maps\mp\_utility::func_6476(level.gametype,5);
		maps\mp\_utility::func_6475(level.gametype,1);
		maps\mp\_utility::func_6472(level.gametype,0);
		maps\mp\_utility::func_647C(level.gametype,4);
		maps\mp\_utility::func_6470(level.gametype,1);
		maps\mp\_utility::func_646A(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.objectivebased = 1;
	level.teambased = 1;
	level.nobuddyspawns = 1;
	level.gamehasstarted = 0;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.var_5976 = ::func_5976;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.ononeleftevent = ::ononeleftevent;
	level.ontimelimit = ::ontimelimit;
	level.initgametypeawards = ::initgametypeawards;
	level.lastcaptime = gettime();
	level.alliesprevflagcount = 0;
	level.axisprevflagcount = 0;
	level.allowlatecomers = 0;
	level.gametimerbeeps = 0;
	level.siegeflagcapturing = [];
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["offense_obj"] = "capture_objs";
	game["dialog"]["defense_obj"] = "capture_objs";
	game["dialog"]["revived"] = "sr_rev";
	thread func_595D();
	thread onplayerswitchteam();
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	var_00 = getmatchrulesdata("siegeData","roundLength");
	setdynamicdvar("scr_siege_timelimit",var_00);
	maps\mp\_utility::func_6476("siege",var_00);
	var_01 = getmatchrulesdata("siegeData","roundSwitch");
	setdynamicdvar("scr_siege_roundswitch",var_01);
	maps\mp\_utility::func_6473("siege",var_01,0,9);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_siege_winlimit",var_02);
	maps\mp\_utility::func_647C("siege",var_02);
	var_03 = getmatchrulesdata("siegeData","capRate");
	setdynamicdvar("scr_siege_caprate",var_03);
	var_04 = getmatchrulesdata("siegeData","rushTimer");
	setdynamicdvar("scr_siege_rushtimer",var_04);
	var_05 = getmatchrulesdata("siegeData","rushTimerAmount");
	setdynamicdvar("scr_siege_rushtimeramount",var_05);
	var_06 = getmatchrulesdata("siegeData","preCapPoints");
	setdynamicdvar("scr_siege_precap",var_06);
	setdynamicdvar("scr_siege_roundlimit",0);
	maps\mp\_utility::func_6472("siege",0);
	setdynamicdvar("scr_siege_scorelimit",1);
	maps\mp\_utility::func_6475("siege",1);
	setdynamicdvar("scr_siege_halftime",0);
	maps\mp\_utility::func_646A("siege",0);
	setdynamicdvar("scr_siege_promode",0);
}

//Function Number: 3
onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["switchedsides"])
	{
		var_00 = game["attackers"];
		var_01 = game["defenders"];
		game["attackers"] = var_01;
		game["defenders"] = var_00;
	}

	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_DOM");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_DOM");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_DOM");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_DOM");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_DOM_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_DOM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_DOM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_DOM_HINT");
	initspawns();
	var_02[0] = "dom";
	maps\mp\gametypes\_gameobjects::func_4FDD(var_02);
	level.flagbasefxid["neutral"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_grey");
	level.flagbasefxid["friendly"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_cyan");
	level.flagbasefxid["enemy"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_orange");
	thread domflags();
	thread watchflagtimerpause();
	thread watchflagtimerreset();
	thread watchflagenduse();
	thread watchgameinactive();
	thread watchgamestart();
}

//Function Number: 4
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_dom_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_dom_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 5
getspawnpoint()
{
	var_00 = self.pers["team"];
	var_01 = maps\mp\_utility::getotherteam(var_00);
	if(level.usestartspawns)
	{
		if(game["switchedsides"])
		{
			var_02 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn_" + var_01 + "_start");
			var_03 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_02);
		}
		else
		{
			var_02 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn_" + var_02 + "_start");
			var_03 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_03);
		}
	}
	else
	{
		var_04 = func_3C30(var_02);
		var_05 = maps\mp\_utility::getotherteam(var_00);
		var_06 = func_3C30(var_05);
		var_07 = func_3B85(var_04,var_06);
		var_02 = maps\mp\gametypes\_spawnlogic::func_3C41(var_00);
		var_03 = maps\mp\gametypes\_spawnscoring::getspawnpoint_domination(var_02,var_07);
	}

	return var_03;
}

//Function Number: 6
func_3C30(param_00)
{
	var_01 = [];
	foreach(var_03 in level.domflags)
	{
		if(var_03.ownerteam == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 7
func_3B85(param_00,param_01)
{
	var_02 = [];
	var_02[0] = 0;
	var_02[1] = 0;
	var_02[2] = 0;
	var_03 = self.pers["team"];
	if(param_00.size == level.domflags.size)
	{
		var_04 = var_03;
		var_05 = level.bestspawnflag[var_03];
		var_02[var_05.useobj.dompointnumber] = 1;
		return var_02;
	}

	if(var_02.size > 0)
	{
		foreach(var_07 in var_02)
		{
			var_04[var_07.dompointnumber] = 1;
		}

		return var_04;
	}

	if(var_05.size == 0)
	{
		var_04 = var_08;
		var_05 = level.bestspawnflag[var_08];
		if(var_04.size > 0 && var_04.size < level.domflags.size)
		{
			var_08 = func_3C5D(var_07,undefined);
			level.bestspawnflag[var_07] = var_08;
		}

		var_05[var_08.useobj.dompointnumber] = 1;
		return var_05;
	}

	return var_07;
}

//Function Number: 8
gettimesincedompointcapture(param_00)
{
	return gettime() - param_00.capturetime;
}

//Function Number: 9
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00._domflageffect = [];
		var_00 thread func_5962();
		var_00 thread func_93EA();
		var_00.siegelatecomer = 1;
	}
}

//Function Number: 10
onplayerswitchteam()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("joined_team",var_00);
		if(maps\mp\_utility::gamehasstarted())
		{
			var_00.siegelatecomer = 1;
		}
	}
}

//Function Number: 11
func_5976()
{
	maps\mp\_utility::setextrascore0(0);
	if(isdefined(self.pers["captures"]))
	{
		maps\mp\_utility::setextrascore0(self.pers["captures"]);
	}

	level notify("spawned_player");
}

//Function Number: 12
func_5962()
{
	self waittill("disconnect");
	foreach(var_01 in self._domflageffect)
	{
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 13
func_1B91()
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
		maps\mp\gametypes\_spectating::func_8733();
	}
}

//Function Number: 14
initgametypeawards()
{
	maps\mp\_awards::func_4652("pointscaptured",0,::maps\mp\_awards::highestwins);
}

//Function Number: 15
func_86F0()
{
}

//Function Number: 16
domflags()
{
	level endon("game_ended");
	level.laststatus["allies"] = 0;
	level.laststatus["axis"] = 0;
	game["flagmodels"] = [];
	game["flagmodels"]["neutral"] = "prop_flag_neutral";
	game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getteamflagmodel("allies");
	game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getteamflagmodel("axis");
	var_00 = getentarray("flag_primary","targetname");
	var_01 = getentarray("flag_secondary","targetname");
	if(var_00.size + var_01.size < 2)
	{
	}

	level.flags = [];
	var_02 = "mp/siegeFlagPos.csv";
	var_03 = maps\mp\_utility::getmapname();
	var_04 = 1;
	for(var_05 = 2;var_05 < 11;var_05++)
	{
		var_06 = tablelookup(var_02,var_04,var_03,var_05);
		if(var_06 != "")
		{
			setflagpositions(var_05,castfloat(var_06));
		}
	}

	for(var_07 = 0;var_07 < var_00.size;var_07++)
	{
		level.flags[level.flags.size] = var_00[var_07];
	}

	for(var_07 = 0;var_07 < var_01.size;var_07++)
	{
		level.flags[level.flags.size] = var_01[var_07];
	}

	level.domflags = [];
	for(var_07 = 0;var_07 < level.flags.size;var_07++)
	{
		var_08 = level.flags[var_07];
		var_08.origin = getflagpos(var_08.script_label,var_08.origin);
		if(isdefined(var_08.target))
		{
			var_09[0] = getent(var_08.target,"targetname");
		}
		else
		{
			var_09[0] = spawn("script_model",var_08.origin);
			var_09[0].angles = var_08.angles;
		}

		var_0A = maps\mp\gametypes\_gameobjects::func_212D("neutral",var_08,var_09,(0,0,100));
		var_0A maps\mp\gametypes\_gameobjects::allowuse("enemy");
		var_0A maps\mp\gametypes\_gameobjects::func_720E(getdvarfloat("scr_siege_caprate"));
		var_0A maps\mp\gametypes\_gameobjects::func_720D(&"MP_SECURING_POSITION");
		var_0B = var_0A maps\mp\gametypes\_gameobjects::func_3B06();
		var_0A.label = var_0B;
		var_0A maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_defend" + var_0B);
		var_0A maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_defend" + var_0B);
		var_0A maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_captureneutral" + var_0B);
		var_0A maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_captureneutral" + var_0B);
		var_0A maps\mp\gametypes\_gameobjects::func_7212("any");
		var_0A.onuse = ::onuse;
		var_0A.onbeginuse = ::onbeginuse;
		var_0A.onuseupdate = ::onuseupdate;
		var_0A.onenduse = ::onenduse;
		var_0A.nousebar = 1;
		var_0A.id = "domFlag";
		var_0A.firstcapture = 1;
		var_0A.prevteam = "neutral";
		var_0A.flagcapsuccess = 0;
		var_0C = var_09[0].origin + (0,0,32);
		var_0D = var_09[0].origin + (0,0,-32);
		var_0E = bullettrace(var_0C,var_0D,0,undefined);
		var_0A.baseeffectpos = var_0E["position"];
		var_0F = vectortoangles(var_0E["normal"]);
		var_0A.baseeffectforward = anglestoforward(var_0F);
		var_0A thread func_7035();
		level.flags[var_07].useobj = var_0A;
		var_0A.levelflag = level.flags[var_07];
		level.domflags[level.domflags.size] = var_0A;
	}

	var_10 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn_axis_start");
	var_11 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn_allies_start");
	level.startpos["allies"] = var_11[0].origin;
	level.startpos["axis"] = var_10[0].origin;
	level.bestspawnflag = [];
	level.bestspawnflag["allies"] = func_3C5D("allies",undefined);
	level.bestspawnflag["axis"] = func_3C5D("axis",level.bestspawnflag["allies"]);
	if(getdvarint("scr_siege_precap"))
	{
		storecenterflag();
		var_12 = [];
		var_12[var_12.size] = level.centerflag;
		if(game["switchedsides"])
		{
			level.closestalliesflag = func_3C5D("axis",level.centerflag);
			var_12[var_12.size] = level.closestalliesflag;
			level.closestaxisflag = func_3C5D("allies",var_12);
		}
		else
		{
			level.closestalliesflag = func_3C5D("allies",level.centerflag);
			var_12[var_12.size] = level.closestalliesflag;
			level.closestaxisflag = func_3C5D("axis",var_12);
		}

		level.closestalliesflag.useobj func_7034("allies","neutral",undefined,1);
		level.closestaxisflag.useobj func_7034("axis","neutral",undefined,1);
	}

	func_33A8();
}

//Function Number: 17
setflagpositions(param_00,param_01)
{
	switch(param_00)
	{
		case 2:
			level.siege_a_xpos = param_01;
			break;

		case 3:
			level.siege_a_ypos = param_01;
			break;

		case 4:
			level.siege_a_zpos = param_01;
			break;

		case 5:
			level.siege_b_xpos = param_01;
			break;

		case 6:
			level.siege_b_ypos = param_01;
			break;

		case 7:
			level.siege_b_zpos = param_01;
			break;

		case 8:
			level.siege_c_xpos = param_01;
			break;

		case 9:
			level.siege_c_ypos = param_01;
			break;

		case 10:
			level.siege_c_zpos = param_01;
			break;
	}
}

//Function Number: 18
getflagpos(param_00,param_01)
{
	var_02 = param_01;
	if(param_00 == "_a")
	{
		if(isdefined(level.siege_a_xpos) && isdefined(level.siege_a_ypos) && isdefined(level.siege_a_zpos))
		{
			var_02 = (level.siege_a_xpos,level.siege_a_ypos,level.siege_a_zpos);
		}
	}
	else if(param_00 == "_b")
	{
		if(isdefined(level.siege_b_xpos) && isdefined(level.siege_b_ypos) && isdefined(level.siege_b_zpos))
		{
			var_02 = (level.siege_b_xpos,level.siege_b_ypos,level.siege_b_zpos);
		}
	}
	else if(isdefined(level.siege_c_xpos) && isdefined(level.siege_c_ypos) && isdefined(level.siege_c_zpos))
	{
		var_02 = (level.siege_c_xpos,level.siege_c_ypos,level.siege_c_zpos);
	}

	return var_02;
}

//Function Number: 19
storecenterflag()
{
	var_00 = undefined;
	foreach(var_02 in level.flags)
	{
		if(var_02.script_label == "_b")
		{
			level.centerflag = var_02;
		}
	}
}

//Function Number: 20
watchflagtimerpause()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("flag_capturing",var_00);
		if(getdvarint("scr_siege_rushtimer"))
		{
			var_01 = maps\mp\_utility::getotherteam(var_00.prevteam);
			if(var_00.prevteam != "neutral" && isdefined(level.siegetimerstate) && level.siegetimerstate != "pause" && !iswinningteam(var_01))
			{
				level.gametimerbeeps = 0;
				level.siegetimerstate = "pause";
				pausecountdowntimer();
				if(!flagownersalive(var_00.prevteam))
				{
					setwinner(var_01,var_00.prevteam + "_eliminated");
				}
			}
		}
	}
}

//Function Number: 21
iswinningteam(param_00)
{
	var_01 = 0;
	var_02 = getflagcount(param_00);
	if(var_02 == 2)
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 22
flagownersalive(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.participants)
	{
		if(isdefined(var_03) && var_03.team == param_00 && maps\mp\_utility::func_4945(var_03) || var_03.pers["lives"] > 0)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 23
pausecountdowntimer()
{
	setgameendtime(0);
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("ui_bomb_timer",5);
	}

	level notify("siege_timer_paused");
}

//Function Number: 24
watchflagtimerreset()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("start_flag_captured",var_00);
		if(getdvarint("scr_siege_rushtimer"))
		{
			if(isdefined(level.siegetimerstate) && level.siegetimerstate != "reset")
			{
				level.gametimerbeeps = 0;
				level.siegetimeleft = undefined;
				level.siegetimerstate = "reset";
				notifyplayers("siege_timer_reset");
			}
		}

		level notify("flag_end_use",var_00);
	}
}

//Function Number: 25
watchflagenduse()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = 0;
		var_01 = 0;
		level waittill("flag_end_use",var_02);
		var_00 = getflagcount("allies");
		var_01 = getflagcount("axis");
		if(var_00 == 2 || var_01 == 2)
		{
			if(getdvarint("scr_siege_rushtimer"))
			{
				if(level.siegeflagcapturing.size == 0 && !var_02.flagcapsuccess || !isdefined(level.siegetimerstate) || level.siegetimerstate != "start")
				{
					var_03 = getdvarfloat("scr_siege_rushtimeramount");
					if(isdefined(level.siegetimeleft))
					{
						var_03 = level.siegetimeleft;
					}

					var_04 = castint(gettime() + var_03 * 1000);
					foreach(var_06 in level.players)
					{
						var_06 setclientomnvar("ui_bomb_timer",0);
					}

					level.timelimitoverride = 1;
					maps\mp\gametypes\_gamelogic::func_5B5D();
					setgameendtime(var_04);
					if(!isdefined(level.siegetimerstate) || level.siegetimerstate == "pause")
					{
						level.siegetimerstate = "start";
						notifyplayers("siege_timer_start");
					}

					if(!level.gametimerbeeps)
					{
						thread watchgametimer(var_03);
					}
				}
			}
		}
		else if(var_00 == 3)
		{
			setwinner("allies","score_limit_reached");
		}
		else if(var_01 == 3)
		{
			setwinner("axis","score_limit_reached");
		}

		var_02.prevteam = var_02.ownerteam;
	}
}

//Function Number: 26
watchgameinactive()
{
	level endon("game_ended");
	level endon("flag_capturing");
	var_00 = getdvarfloat("scr_siege_timelimit");
	if(var_00 > 0)
	{
		var_01 = var_00 * 60 - 1;
		while(var_01 > 0)
		{
			var_01 = var_01 - 1;
			wait(1);
		}

		level.siegegameinactive = 1;
	}
}

//Function Number: 27
watchgamestart()
{
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	while(!havespawnedplayers())
	{
		common_scripts\utility::func_8AFE();
	}

	level.gamehasstarted = 1;
}

//Function Number: 28
havespawnedplayers()
{
	if(level.teambased)
	{
		return level.hasspawned["axis"] && level.hasspawned["allies"];
	}

	return level.maxplayercount > 1;
}

//Function Number: 29
watchgametimer(param_00)
{
	level endon("game_ended");
	level endon("siege_timer_paused");
	level endon("siege_timer_reset");
	var_01 = param_00;
	var_02 = spawn("script_origin",(0,0,0));
	var_02 hide();
	level.gametimerbeeps = 1;
	while(var_01 > 0)
	{
		var_01 = var_01 - 1;
		level.siegetimeleft = var_01;
		if(var_01 <= 30)
		{
			if(var_01 != 0)
			{
				var_02 playsound("ui_mp_timer_countdown");
			}
		}

		wait(1);
	}

	ontimelimit();
}

//Function Number: 30
getflagcount(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.domflags)
	{
		if(var_03.ownerteam == param_00 && !isbeingcaptured(var_03))
		{
			var_01 = var_01 + 1;
		}
	}

	return var_01;
}

//Function Number: 31
isbeingcaptured(param_00)
{
	var_01 = 0;
	if(isdefined(param_00))
	{
		if(level.siegeflagcapturing.size > 0)
		{
			foreach(var_03 in level.siegeflagcapturing)
			{
				if(param_00.label == var_03)
				{
					var_01 = 1;
				}
			}
		}
	}

	return var_01;
}

//Function Number: 32
setwinner(param_00,param_01)
{
	if(param_00 != "tie")
	{
		level.finalkillcam_winner = param_00;
	}
	else
	{
		level.finalkillcam_winner = "none";
	}

	foreach(var_03 in level.players)
	{
		if(!isai(var_03))
		{
			var_03 setclientomnvar("ui_dom_securing",0);
			var_03 setclientomnvar("ui_bomb_timer",0);
		}
	}

	thread maps\mp\gametypes\_gamelogic::endgame(param_00,game["end_reason"][param_01]);
}

//Function Number: 33
onbeginuse(param_00)
{
	var_01 = maps\mp\gametypes\_gameobjects::func_3B78();
	self.didstatusnotify = 0;
	maps\mp\gametypes\_gameobjects::func_720E(getdvarfloat("scr_siege_caprate"));
	level.siegeflagcapturing[level.siegeflagcapturing.size] = self.label;
	level notify("flag_capturing",self);
}

//Function Number: 34
onuse(param_00)
{
	var_01 = param_00.team;
	var_02 = maps\mp\gametypes\_gameobjects::func_3B78();
	self.capturetime = gettime();
	func_7034(var_01,var_02,param_00);
	level.usestartspawns = 0;
	if(var_02 == "neutral")
	{
		var_03 = maps\mp\_utility::getotherteam(var_01);
		thread maps\mp\_utility::func_61A1(var_01,var_03,undefined,undefined,"mp_dom_flag_captured",undefined,param_00);
		if(func_3C33(var_01) < level.flags.size)
		{
			func_7B2B("secured" + self.label,var_01,1);
			func_7B2B("enemy_has" + self.label,var_03,1);
		}
	}

	param_00 maps\mp\_events::giveobjectivepointstreaks();
	thread giveflagcapturexp(self.touchlist[var_01]);
}

//Function Number: 35
onuseupdate(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_gameobjects::func_3B78();
	if(param_01 > 0.05 && param_02 && !self.didstatusnotify)
	{
		if(var_03 == "neutral")
		{
			func_7B2B("securing" + self.label,param_00);
			self.prevownerteam = maps\mp\_utility::getotherteam(param_00);
		}
		else
		{
			func_7B2B("losing" + self.label,var_03,1);
			func_7B2B("securing" + self.label,param_00);
		}

		maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_taking" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_taking" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_losing" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_losing" + self.label);
		self.didstatusnotify = 1;
	}
}

//Function Number: 36
onenduse(param_00,param_01,param_02)
{
	if(isplayer(param_01))
	{
		param_01 setclientomnvar("ui_dom_securing",0);
		param_01.ui_dom_securing = undefined;
	}

	if(param_02)
	{
		self.flagcapsuccess = 1;
		level notify("start_flag_captured",self);
	}
	else
	{
		self.flagcapsuccess = 0;
		level notify("flag_end_use",self);
	}

	var_03 = maps\mp\gametypes\_gameobjects::func_3B78();
	if(var_03 != "neutral")
	{
		maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_capture" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_capture" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_defend" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_defend" + self.label);
	}
	else
	{
		maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_captureneutral" + self.label);
	}

	level.siegeflagcapturing = common_scripts\utility::array_remove(level.siegeflagcapturing,self.label);
}

//Function Number: 37
onreset()
{
}

//Function Number: 38
func_3C5D(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	foreach(var_06 in level.flags)
	{
		if(var_06.useobj func_3AAB() != "neutral")
		{
			continue;
		}

		var_07 = distancesquared(var_06.origin,level.startpos[param_00]);
		if(isdefined(param_01))
		{
			if(!isflagexcluded(var_06,param_01) && !isdefined(var_02) || var_07 < var_03)
			{
				var_03 = var_07;
				var_02 = var_06;
			}

			continue;
		}

		if(!isdefined(var_02) || var_07 < var_03)
		{
			var_03 = var_07;
			var_02 = var_06;
		}
	}

	return var_02;
}

//Function Number: 39
isflagexcluded(param_00,param_01)
{
	var_02 = 0;
	if(isarray(param_01))
	{
		foreach(var_04 in param_01)
		{
			if(param_00 == var_04)
			{
				var_02 = 1;
				break;
			}
		}
	}
	else if(param_00 == param_01)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 40
ondeadevent(param_00)
{
	if(maps\mp\_utility::gamehasstarted())
	{
		if(param_00 == "all")
		{
			ontimelimit();
		}

		if(param_00 == game["attackers"])
		{
			if(getflagcount(param_00) == 2)
			{
			}

			setwinner(game["defenders"],game["attackers"] + "_eliminated");
		}

		if(param_00 == game["defenders"])
		{
			if(getflagcount(param_00) == 2)
			{
			}

			setwinner(game["attackers"],game["defenders"] + "_eliminated");
		}
	}
}

//Function Number: 41
ononeleftevent(param_00)
{
	var_01 = maps\mp\_utility::func_3B09(param_00);
	var_01 thread func_3CF4();
}

//Function Number: 42
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01) || param_01.team == self.team)
	{
	}

	var_0A = 0;
	var_0B = 0;
	var_0C = self;
	foreach(var_0E in var_0C.touchtriggers)
	{
		if(var_0E != level.flags[0] && var_0E != level.flags[1] && var_0E != level.flags[2])
		{
			continue;
		}

		var_0F = var_0E.useobj.ownerteam;
		var_10 = var_0C.team;
		if(var_0F == "neutral")
		{
			continue;
		}

		if(var_10 == var_0F)
		{
			var_0A = 1;
			param_01 thread maps\mp\gametypes\_hud_message::func_794C("assault",maps\mp\gametypes\_rank::func_3BE0("assault"));
			param_01 thread maps\mp\gametypes\_rank::giverankxp("assault");
			maps\mp\gametypes\_gamescore::func_3D00("assault",param_01);
			thread maps\mp\_matchdata::func_4F1A(param_09,"defending");
			continue;
		}

		var_0B = 1;
		param_01 thread maps\mp\gametypes\_hud_message::func_794C("defend",maps\mp\gametypes\_rank::func_3BE0("defend"));
		param_01 thread maps\mp\gametypes\_rank::giverankxp("defend");
		maps\mp\gametypes\_gamescore::func_3D00("defend",param_01);
		param_01 maps\mp\_utility::func_4479("defends",1);
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","defends",param_01.pers["defends"]);
		param_01 maps\mp\gametypes\_missions::func_61CE("ch_domprotector");
		thread maps\mp\_matchdata::func_4F1A(param_09,"assaulting");
	}

	foreach(var_0E in param_01.touchtriggers)
	{
		if(var_0E != level.flags[0] && var_0E != level.flags[1] && var_0E != level.flags[2])
		{
			continue;
		}

		var_0F = var_0E.useobj.ownerteam;
		var_13 = param_01.team;
		if(var_0F == "neutral")
		{
			continue;
		}

		if(var_13 != var_0F)
		{
			if(!var_0A)
			{
				param_01 thread maps\mp\gametypes\_hud_message::func_794C("assault",maps\mp\gametypes\_rank::func_3BE0("assault"));
			}

			param_01 thread maps\mp\gametypes\_rank::giverankxp("assault");
			maps\mp\gametypes\_gamescore::func_3D00("assault",param_01);
			thread maps\mp\_matchdata::func_4F1A(param_09,"defending");
		}
	}

	foreach(var_0E in level.flags)
	{
		var_0F = var_0E.useobj.ownerteam;
		var_13 = param_01.team;
		var_16 = distancesquared(var_0E.origin,var_0C.origin);
		var_17 = 90000;
		if(var_13 == var_0F && var_16 < var_17)
		{
			if(!var_0B)
			{
				param_01 thread maps\mp\gametypes\_hud_message::func_794C("defend",maps\mp\gametypes\_rank::func_3BE0("defend"));
			}

			param_01 thread maps\mp\gametypes\_rank::giverankxp("defend");
			maps\mp\gametypes\_gamescore::func_3D00("defend",param_01);
			param_01 maps\mp\_utility::func_4479("defends",1);
			param_01 maps\mp\gametypes\_persistence::func_7B28("round","defends",param_01.pers["defends"]);
			thread maps\mp\_matchdata::func_4F1A(param_09,"assaulting");
		}
	}
}

//Function Number: 43
func_3CF4()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::func_8BBE(3);
	var_00 = maps\mp\_utility::getotherteam(self.pers["team"]);
	level thread maps\mp\_utility::func_7FA0("callout_lastteammemberalive",self,self.pers["team"]);
	level thread maps\mp\_utility::func_7FA0("callout_lastenemyalive",self,var_00);
	level notify("last_alive",self);
	maps\mp\gametypes\_missions::lastmansd();
}

//Function Number: 44
ontimelimit()
{
	if(isdefined(level.siegegameinactive))
	{
		level thread maps\mp\gametypes\_gamelogic::func_34D1();
	}

	var_00 = getflagcount("allies");
	var_01 = getflagcount("axis");
	if(var_00 > var_01)
	{
		setwinner("allies","time_limit_reached");
	}

	if(var_01 > var_00)
	{
		setwinner("axis","time_limit_reached");
	}

	setwinner("tie","time_limit_reached");
}

//Function Number: 45
func_7B2B(param_00,param_01,param_02)
{
	var_03 = gettime();
	if(gettime() < level.laststatus[param_01] + 5000 && !isdefined(param_02) || !param_02)
	{
	}

	thread func_2526(param_00,param_01);
	level.laststatus[param_01] = gettime();
}

//Function Number: 46
func_2526(param_00,param_01)
{
	level endon("game_ended");
	wait(0.1);
	maps\mp\_utility::func_8BC1();
	maps\mp\_utility::func_4D30(param_00,param_01);
}

//Function Number: 47
teamrespawn(param_00,param_01)
{
	foreach(var_03 in level.participants)
	{
		if(isdefined(var_03) && var_03.team == param_00 && !maps\mp\_utility::func_4945(var_03) && !common_scripts\utility::array_contains(level.alive_players[var_03.team],var_03) && !isdefined(var_03.waitingtoselectclass) || !var_03.waitingtoselectclass)
		{
			if(isdefined(var_03.siegelatecomer) && var_03.siegelatecomer)
			{
				var_03.siegelatecomer = 0;
			}

			var_03 maps\mp\gametypes\_playerlogic::incrementalivecount(var_03.team);
			var_03.alreadyaddedtoalivecount = 1;
			var_03 thread func_9586();
			var_03 thread maps\mp\gametypes\_hud_message::func_794C("sr_respawned");
			level notify("sr_player_respawned",var_03);
			var_03 maps\mp\_utility::func_4D35("revived");
			param_01 maps\mp\gametypes\_missions::func_61CE("ch_rescuer");
			if(!isdefined(param_01.rescuedplayers))
			{
				param_01.rescuedplayers = [];
			}

			param_01.rescuedplayers[var_03.guid] = 1;
			if(param_01.rescuedplayers.size == 4)
			{
				param_01 maps\mp\gametypes\_missions::func_61CE("ch_helpme");
			}
		}
	}
}

//Function Number: 48
func_9586()
{
	self endon("started_spawnPlayer");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self) && self.sessionstate == "spectator" || !maps\mp\_utility::func_4945(self))
		{
			self.pers["lives"] = 1;
			maps\mp\gametypes\_playerlogic::func_7866();
			continue;
		}
	}
}

//Function Number: 49
notifyplayers(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 thread maps\mp\gametypes\_hud_message::func_794C(param_00);
	}

	level notify("match_ending_soon","time");
	level notify(param_00);
}

//Function Number: 50
func_660A()
{
	var_00 = maps\mp\gametypes\_gameobjects::func_3B78();
	if(var_00 == "neutral")
	{
		func_6005();
	}

	foreach(var_02 in level.players)
	{
		showcapturedbaseeffecttoplayer(var_00,var_02);
	}
}

//Function Number: 51
func_93EA()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "mlg_view_change")
		{
			foreach(var_03 in level.domflags)
			{
				if(var_03.ownerteam != "neutral")
				{
					var_03 showcapturedbaseeffecttoplayer(var_03.ownerteam,self);
				}
			}
		}
	}
}

//Function Number: 52
showcapturedbaseeffecttoplayer(param_00,param_01)
{
	if(isdefined(param_01._domflageffect[self.label]))
	{
		param_01._domflageffect[self.label] delete();
	}

	var_02 = undefined;
	var_03 = param_01.team;
	var_04 = param_01 setmlgcameradefaults();
	if(var_04)
	{
		var_03 = param_01 setmlgspectator();
	}
	else if(var_03 == "spectator")
	{
		var_03 = "allies";
	}

	if(var_03 == param_00)
	{
		var_02 = botgetteamlimit(level.flagbasefxid["friendly"],self.baseeffectpos,param_01,self.baseeffectforward);
	}
	else
	{
		var_02 = botgetteamlimit(level.flagbasefxid["enemy"],self.baseeffectpos,param_01,self.baseeffectforward);
	}

	param_01._domflageffect[self.label] = var_02;
	triggerfx(var_02);
}

//Function Number: 53
func_7035()
{
	self notify("flag_neutral");
	maps\mp\gametypes\_gameobjects::func_708D("neutral");
	self.visuals[0] setmodel(game["flagmodels"]["neutral"]);
	foreach(var_01 in level.players)
	{
		var_02 = var_01._domflageffect[self.label];
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}

	func_6005();
}

//Function Number: 54
func_6005()
{
	if(isdefined(self.neutralflagfx))
	{
		self.neutralflagfx delete();
	}

	self.neutralflagfx = spawnfx(level.flagbasefxid["neutral"],self.baseeffectpos,self.baseeffectforward);
	triggerfx(self.neutralflagfx);
}

//Function Number: 55
func_3C33(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		if(level.domflags[var_02] maps\mp\gametypes\_gameobjects::func_3B78() == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 56
func_3AAB()
{
	return maps\mp\gametypes\_gameobjects::func_3B78();
}

//Function Number: 57
func_33A8()
{
	foreach(var_01 in level.domflags)
	{
		switch(var_01.label)
		{
			case "_a":
				var_01.dompointnumber = 0;
				break;

			case "_b":
				var_01.dompointnumber = 1;
				break;

			case "_c":
				var_01.dompointnumber = 2;
				break;
		}
	}

	var_03 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn");
	foreach(var_05 in var_03)
	{
		var_05.dompointa = 0;
		var_05.dompointb = 0;
		var_05.dompointc = 0;
		var_05.nearflagpoint = func_3B3A(var_05);
		switch(var_05.nearflagpoint.useobj.dompointnumber)
		{
			case 0:
				var_05.dompointa = 1;
				break;

			case 1:
				var_05.dompointb = 1;
				break;

			case 2:
				var_05.dompointc = 1;
				break;
		}
	}
}

//Function Number: 58
func_3B3A(param_00)
{
	var_01 = maps\mp\gametypes\_spawnlogic::func_4928();
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.domflags)
	{
		var_06 = undefined;
		if(var_01)
		{
			var_06 = badplace_global(param_00.origin,var_05.levelflag.origin,999999);
		}

		if(!isdefined(var_06) || var_06 == -1)
		{
			var_06 = distancesquared(var_05.levelflag.origin,param_00.origin);
		}

		if(!isdefined(var_02) || var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02.levelflag;
}

//Function Number: 59
giveflagcapturexp(param_00)
{
	level endon("game_ended");
	var_01 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();
	if(isdefined(var_01.owner))
	{
		var_01 = var_01.owner;
	}

	level.lastcaptime = gettime();
	if(isplayer(var_01))
	{
		level thread maps\mp\_utility::func_7FA0("callout_securedposition" + self.label,var_01);
		var_01 thread maps\mp\_matchdata::loggameevent("capture",var_01.origin);
	}

	var_02 = getarraykeys(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = param_00[var_02[var_03]].player;
		if(isdefined(var_04.owner))
		{
			var_04 = var_04.owner;
		}

		if(!isplayer(var_04))
		{
			continue;
		}

		var_04 thread maps\mp\gametypes\_hud_message::func_794C("capture",maps\mp\gametypes\_rank::func_3BE0("capture"));
		var_04 thread func_86DF();
		var_04 thread maps\mp\gametypes\_rank::giverankxp("capture",maps\mp\gametypes\_rank::func_3BE0("capture") * var_04 getcapxpscale());
		maps\mp\gametypes\_gamescore::func_3D00("capture",var_04);
		var_04 maps\mp\_utility::func_447B("pointscaptured",1);
		var_04 maps\mp\_utility::func_4479("captures",1);
		var_04 maps\mp\gametypes\_persistence::func_7B28("round","captures",var_04.pers["captures"]);
		var_04 maps\mp\gametypes\_missions::func_61CE("ch_domcap");
		var_04 maps\mp\_utility::setextrascore0(var_04.pers["captures"]);
		if(var_04 != var_01)
		{
			var_04 maps\mp\_events::giveobjectivepointstreaks();
		}

		wait(0.05);
	}
}

//Function Number: 60
getcapxpscale()
{
	if(self.cpm < 4)
	{
		return 1;
	}

	return 0.25;
}

//Function Number: 61
func_86DF()
{
	if(!isdefined(self.cpm))
	{
		self.numcaps = 0;
		self.cpm = 0;
	}

	self.numcaps++;
	if(maps\mp\_utility::func_3B2E() < 1)
	{
	}

	self.cpm = self.numcaps / maps\mp\_utility::func_3B2E();
}

//Function Number: 62
func_7034(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\gametypes\_gameobjects::func_3B06();
	maps\mp\gametypes\_gameobjects::func_708D(param_00);
	maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_capture" + var_04);
	maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_capture" + var_04);
	maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_defend" + self.label);
	maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_defend" + self.label);
	self.visuals[0] setmodel(game["flagmodels"][param_00]);
	if(isdefined(self.neutralflagfx))
	{
		self.neutralflagfx delete();
	}

	foreach(var_06 in level.players)
	{
		showcapturedbaseeffecttoplayer(param_00,var_06);
	}

	if(!isdefined(param_03))
	{
		if(param_01 != "neutral")
		{
			func_7B2B("secured" + self.label,param_00,1);
			func_7B2B("lost" + self.label,param_01,1);
			maps\mp\_utility::func_6045("mp_dom_flag_lost",param_01);
			level.lastcaptime = gettime();
		}

		teamrespawn(param_00,param_02);
		self.firstcapture = 0;
	}

	thread baseeffectswaitforjoined();
}

//Function Number: 63
baseeffectswaitforjoined()
{
	level endon("game_ended");
	self endon("flag_neutral");
	for(;;)
	{
		level waittill("joined_team",var_00);
		if(isdefined(var_00._domflageffect[self.label]))
		{
			var_00._domflageffect[self.label] delete();
			var_00._domflageffect[self.label] = undefined;
		}

		if(var_00.team != "spectator")
		{
			showcapturedbaseeffecttoplayer(self.ownerteam,var_00);
		}
	}
}