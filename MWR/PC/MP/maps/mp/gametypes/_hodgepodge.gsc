/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hodgepodge.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 974 ms
 * Timestamp: 10/27/2023 2:37:48 AM
*******************************************************************/

//Function Number: 1
init()
{
	setdvarifuninitialized("scr_game_hodgepodgeMode",0);
	setdvarifuninitialized("scr_game_pumpking",0);
	if(maps\mp\_utility::invirtuallobby())
	{
		level.hodgepodgemode = 0;
		return;
	}

	level.hodgepodgemode = getdvarint("scr_game_hodgepodgeMode",0);
	level.madpropsmode = getdvarint("scr_game_madprops",0);
	if(level.hodgepodgemode == 0)
	{
		return;
	}

	if(level.hodgepodgemode == 2 || level.hodgepodgemode == 6 || level.hodgepodgemode == 7)
	{
		level.oldschool = 0;
	}

	if(level.hodgepodgemode == 9)
	{
		level.oldschool = 0;
		level.onstartgametype = ::blank;
	}

	level.hodgepodgeonstartgametype = level.onstartgametype;
	level.onstartgametype = ::hodgepodgeonstartgametype;
	level thread hodgepodgeonconnect();
}

//Function Number: 2
blank()
{
}

//Function Number: 3
hodgepodgeonstartgametype()
{
	[[ level.hodgepodgeonstartgametype ]]();
	if(level.hodgepodgemode == 2)
	{
		initmmmode();
		return;
	}

	if(level.hodgepodgemode == 4)
	{
		initsnipersonly();
		return;
	}

	if(level.hodgepodgemode == 6)
	{
		level.rpgonlyreload = 1;
		initrpgonly();
		return;
	}

	if(level.hodgepodgemode == 7)
	{
		level.rpgonlyreload = 0;
		initrpgonly();
		return;
	}

	if(level.hodgepodgemode == 9)
	{
		initprophunt();
		return;
	}
}

//Function Number: 4
hodgepodgeonconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(level.hodgepodgemode == 9)
		{
			var_00 thread maps\mp\gametypes\_hodgepodge_ph::onconnect();
		}

		if(level.hodgepodgemode == 3)
		{
			var_00 thread watchapplyloadout(::giveprimaryonly);
		}

		if(level.hodgepodgemode == 4)
		{
			var_00 thread watchapplyloadout(::giveprimaryonlynomelee);
			var_00 thread killrangeindicator();
		}
	}
}

//Function Number: 5
initmmmode()
{
	level.ondeadevent = ::ondeadevent;
	level.callbackplayerdamage = ::mmcallbackplayerdamage;
	level.onplayerkilled = ::onmmplayerkilled;
	level.onspawnplayer = ::onmmspawnplayer;
	level.autoassign = ::mmautoassign;
	level.bypassclasschoicefunc = ::mmclass;
	level.getspawnpoint = ::getmmspawnpoint;
	level.ononeleftevent = ::mmononeleftevent;
	level.doprematch = 1;
	level.disableforfeit = 1;
	level.blockweapondrops = 1;
	level.bot_ignore_personality = 1;
	level.mm_allowsuicide = 0;
	level.mm_choseslasher = 0;
	level.mm_choosingslasher = 0;
	level.mm_countdowninprogress = 0;
	common_scripts\utility::flag_init("slasher_chosen");
	level.mm_teamscores["axis"] = 0;
	level.mm_teamscores["allies"] = 0;
	updateteamscores();
	level.spectateoverride["allies"].allowenemyspectate = 1;
	level.allowlatecomers = 0;
	setupdvarsmm();
	setspecialloadouts();
	setclientnamemode("auto_change");
	var_00 = &"OBJECTIVES_MM";
	maps\mp\_utility::setobjectivetext("allies",var_00);
	maps\mp\_utility::setobjectivetext("axis",var_00);
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",var_00);
		maps\mp\_utility::setobjectivescoretext("axis",var_00);
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",var_00);
		maps\mp\_utility::setobjectivescoretext("axis",var_00);
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_INFECT_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_INFECT_HINT");
	level thread mmawardxp();
	level thread watchhostmigrationmm();
}

//Function Number: 6
setupdvarsmm()
{
	setdynamicdvar("scr_game_hardpoints",0);
	setdynamicdvar("scr_war_timelimit",10);
	setdynamicdvar("scr_war_numLives",1);
	setdynamicdvar("g_oldschool",1);
	setdynamicdvar("scr_game_mmUavTime",30);
}

//Function Number: 7
watchhostmigrationmm()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_begin");
		setupdvarsmm();
		level waittill("host_migration_end");
		setupdvarsmm();
	}
}

//Function Number: 8
ondeadevent(param_00)
{
}

//Function Number: 9
mmautoassign()
{
	thread maps\mp\gametypes\_menus::setteam("allies");
	self.slasher_team = "allies";
}

//Function Number: 10
ontimelimit()
{
	level.finalkillcam_winner = "allies";
	level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 11
mmawardxp()
{
	level endon("game_ended");
	level.xpeventinfo["kill"]["value"] = 300;
	common_scripts\utility::flag_wait("slasher_chosen");
	for(;;)
	{
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(10);
		foreach(var_01 in level.players)
		{
			if(maps\mp\_utility::is_true(var_01.isslasher))
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(var_01))
			{
				continue;
			}

			level thread maps\mp\gametypes\_rank::awardgameevent("still_alive",var_01);
		}
	}
}

//Function Number: 12
onmmspawnplayer()
{
	self allowmelee(0);
	if(isai(self))
	{
		self allowfire(0);
	}

	thread switchtostartweapon(self.team);
	self setplayerdata(common_scripts\utility::getstatsgroup_common(),"hasEverVisitedDepot",0);
	if(!maps\mp\_utility::is_true(level.mm_choseslasher))
	{
		maps\mp\_utility::giveperk("specialty_radarimmune",0);
	}

	level.mm_teamscores["allies"]++;
	updateteamscores();
	if(!level.mm_choosingslasher)
	{
		level.mm_choosingslasher = 1;
		level thread chooseslasher();
	}

	thread monitordisconnectmm();
	if(level.mm_choseslasher)
	{
		if(level.mm_teamscores["axis"] && level.mm_teamscores["allies"])
		{
			if(level.mm_teamscores["allies"] == 1)
			{
				thread onfinalsurvivordelayed();
			}
		}
	}

	var_00 = self getweaponslistoffhands();
	foreach(var_02 in var_00)
	{
		self setweaponammoclip(var_02,0);
	}

	if(isai(self))
	{
		thread botmmlogic();
	}
}

//Function Number: 13
onfinalsurvivordelayed()
{
	self endon("disconnect");
	wait 0.05;
	onfinalsurvivor();
}

//Function Number: 14
chooseslasher()
{
	level endon("game_ended");
	level endon("mm_stopCountdown");
	level.mm_allowsuicide = 0;
	maps\mp\_utility::gameflagwait("prematch_done");
	level.mm_countdowninprogress = 1;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
	var_00 = 15;
	setomnvar("ui_match_countdown_title",4);
	setomnvar("ui_match_countdown_toggle",1);
	while(var_00 > 0 && !level.gameended)
	{
		var_00--;
		setomnvar("ui_match_countdown",var_00 + 1);
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
	}

	setomnvar("ui_match_countdown",1);
	setomnvar("ui_match_countdown_title",0);
	setomnvar("ui_match_countdown_toggle",0);
	level.mm_countdowninprogress = 0;
	var_01 = [];
	var_02 = undefined;
	foreach(var_04 in level.players)
	{
		if(maps\mp\_utility::matchmakinggame() && level.players.size > 1 && var_04 ishost())
		{
			var_02 = var_04;
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(var_04))
		{
			continue;
		}

		if(var_04.team == "axis")
		{
			continue;
		}

		if(!var_04.hasspawned)
		{
			continue;
		}

		var_01[var_01.size] = var_04;
	}

	if(!var_01.size && isdefined(var_02))
	{
		var_01[var_01.size] = var_02;
	}

	level.slasher = var_01[randomint(var_01.size)];
	level.slasher setasslasher();
	foreach(var_04 in level.players)
	{
		if(maps\mp\_utility::is_true(var_04.isslasher))
		{
			continue;
		}

		var_04.issurvivor = 1;
		var_04.isslasher = 0;
		var_04 maps\mp\_utility::_clearperks();
	}

	level.gamehasstarted = 1;
	common_scripts\utility::flag_set("slasher_chosen");
	setnojiptime(1);
	var_09 = getaliveplayersonteam("allies");
	if(var_09.size <= 0)
	{
		level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["end_reason"]["allies_eliminated"]);
	}

	if(level.mm_teamscores["axis"] && level.mm_teamscores["allies"])
	{
		if(level.mm_teamscores["allies"] == 1)
		{
			thread onfinalsurvivordelayed();
		}
	}
}

//Function Number: 15
switchtostartweapon(param_00)
{
	var_01 = maps\mp\gametypes\_class::buildweaponname("h1_meleeshovel");
	if(param_00 == "allies")
	{
		var_01 = maps\mp\gametypes\_class::buildweaponname("h1_colt45");
	}

	waittillframeend;
	self takeallweapons();
	self giveweapon(var_01);
	self setspawnweapon(var_01);
	self switchtoweapon(var_01);
	self setweaponammostock(var_01,0);
	self setweaponammoclip(var_01,8);
}

//Function Number: 16
setasslasher()
{
	self endon("disconnect");
	prepareforclasschange();
	self.mm_isbeingchosen = 1;
	maps\mp\gametypes\_menus::addtoteam("axis",undefined,1);
	self.slasher_team = "axis";
	level.mm_choseslasher = 1;
	self.mm_isbeingchosen = undefined;
	level notify("update_game_time");
	level.mm_teamscores["axis"] = 1;
	level.mm_teamscores["allies"]--;
	updateteamscores();
	level.mm_allowsuicide = 1;
	slashersettings();
	thread slashermovespeedscale();
}

//Function Number: 17
slashersettings()
{
	self.isslasher = 1;
	self.issurvivor = 0;
	self notify("faux_spawn");
	self.pers["gamemodeLoadout"] = level.mm_loadouts["axis"];
	maps\mp\gametypes\_class::giveandapplyloadout("axis","gamemode");
	thread switchtostartweapon("axis");
	self allowmelee(1);
	if(isai(self))
	{
		self allowfire(1);
	}

	thread slashermovespeedscale();
}

//Function Number: 18
onslasherdamage(param_00)
{
	self.slowmovetime = clamp(self.slowmovetime + 2500,gettime() + 2500,gettime() + 8000);
}

//Function Number: 19
slashermovespeedscale()
{
	self endon("death");
	self endon("disconnect");
	var_00 = 1.1;
	var_01 = 0.25;
	self.slowmovetime = 0;
	for(;;)
	{
		if(self.slowmovetime > gettime())
		{
			self.slashermovespeedscale = var_01;
			self allowsprint(0);
		}
		else
		{
			self.slashermovespeedscale = var_00;
			self allowsprint(1);
		}

		self setmovespeedscale(self.slashermovespeedscale);
		wait 0.05;
	}
}

//Function Number: 20
slasherdouav()
{
	level endon("game_ended");
	self endon("disconnect");
	level notify("slasherDoUav");
	level endon("slasherDoUav");
	level.radarviewtime = 4;
	var_00 = getdvarfloat("scr_game_mmUavTime",30);
	for(;;)
	{
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
		maps\mp\gametypes\_hardpoints::useradaritem();
	}
}

//Function Number: 21
prepareforclasschange()
{
	while(!maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::isusingremote())
	{
		wait(0.05);
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismeleeing())
	{
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground() && !self isonladder())
	{
		wait(0.05);
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	wait(0.05);
	while(!maps\mp\_utility::isreallyalive(self))
	{
		wait(0.05);
	}
}

//Function Number: 22
getaliveplayersonteam(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03) && isalive(var_03) && !isdefined(var_03.sessionstate) || var_03.sessionstate == "playing")
		{
			if(!isdefined(param_00) || var_03.team == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 23
monitordisconnectmm()
{
	level endon("game_ended");
	self endon("eliminated");
	self notify("mm_monitor_disconnect");
	self endon("mm_monitor_disconnect");
	self waittill("disconnect");
	var_00 = self.slasher_team;
	var_01 = getaliveplayersonteam(var_00);
	level.mm_teamscores[var_00] = var_01.size;
	updateteamscores();
	if(isdefined(self.mm_isbeingchosen) || level.mm_choseslasher)
	{
		if(level.mm_teamscores["axis"] && level.mm_teamscores["allies"])
		{
			if(var_00 == "allies" && level.mm_teamscores["allies"] == 1)
			{
				onfinalsurvivor();
				return;
			}

			if(var_00 == "axis" && level.mm_teamscores["axis"] == 1)
			{
				foreach(var_03 in level.players)
				{
					if(var_03 != self && var_03.team == "axis")
					{
						var_03 setasslasher();
					}
				}

				return;
			}

			return;
		}

		if(level.mm_teamscores["allies"] == 0)
		{
			onsurvivorseliminated();
			return;
		}

		if(level.mm_teamscores["axis"] == 0)
		{
			if(level.mm_teamscores["allies"] == 1)
			{
				onslashereliminated();
				return;
			}

			if(level.mm_teamscores["allies"] > 1)
			{
				level.mm_choseslasher = 0;
				level thread chooseslasher();
				return;
			}

			return;
		}

		return;
	}

	if(level.mm_countdowninprogress && level.mm_teamscores["allies"] == 0 && level.mm_teamscores["axis"] == 0)
	{
		level notify("mm_stopCountdown");
		level.mm_choosingslasher = 0;
		setomnvar("ui_match_start_countdown",0);
	}
}

//Function Number: 24
onsurvivorseliminated()
{
	level.finalkillcam_winner = "axis";
	level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["end_reason"]["allies_eliminated"]);
}

//Function Number: 25
onslashereliminated()
{
	level.finalkillcam_winner = "allies";
	level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["end_reason"]["axis_eliminated"]);
}

//Function Number: 26
onfinalsurvivor()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01.team != "allies")
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(var_01))
		{
			continue;
		}

		var_01 slashersettings();
		break;
	}
}

//Function Number: 27
updateteamscores()
{
	game["teamScores"]["allies"] = level.mm_teamscores["allies"];
	setteamscore("allies",level.mm_teamscores["allies"]);
	game["teamScores"]["axis"] = level.mm_teamscores["axis"];
	setteamscore("axis",level.mm_teamscores["axis"]);
}

//Function Number: 28
slasherreducesprint()
{
	self notify("slasherReduceSprint");
	self endon("slasherReduceSprint");
	self allowsprint(0);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3);
	self allowsprint(1);
}

//Function Number: 29
mmcallbackplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(maps\mp\_utility::is_true(self.isslasher))
	{
		if(isdefined(param_01) && maps\mp\_utility::isbulletdamage(param_04))
		{
			thread onslasherdamage(param_02);
		}

		if(!isdefined(param_01) || level.mm_teamscores["allies"] > 1)
		{
			return;
		}
	}

	maps\mp\gametypes\_damage::callback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 30
onmmplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_01))
	{
		return;
	}

	var_0A = param_01 == self || !isplayer(param_01);
	if(var_0A && !level.mm_allowsuicide)
	{
		return;
	}

	level notify("update_game_time");
	level.mm_teamscores[self.team]--;
	updateteamscores();
	if(self.team == "allies")
	{
		maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured","allies");
		maps\mp\_utility::playsoundonplayers("mp_war_objective_taken","axis");
	}

	level thread maps\mp\_utility::teamplayercardsplash("callout_eliminated",self,self.team);
	if(level.mm_teamscores["allies"] == 0)
	{
		onsurvivorseliminated();
		return;
	}

	if(level.mm_teamscores["axis"] == 0)
	{
		onslashereliminated();
		return;
	}

	if(level.mm_teamscores["allies"] == 1)
	{
		onfinalsurvivor();
	}
}

//Function Number: 31
getmmspawnpoint()
{
	if(level.ingraceperiod)
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getstartspawnffa(self.team);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.team);
		var_00 = maps\mp\gametypes\_spawnscoring::getspawnpoint_freeforall(var_01);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_00);
	return var_00;
}

//Function Number: 32
mmclass()
{
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "";
	self.pers["gamemodeLoadout"] = level.mm_loadouts[self.pers["team"]];
	self.class = self.pers["class"];
	self.lastclass = self.pers["lastClass"];
}

//Function Number: 33
setspecialloadouts()
{
	level.mm_loadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
	level.mm_loadouts["allies"]["loadoutSecondary"] = "h1_colt45";
	level.mm_loadouts["allies"]["loadoutPrimary"] = "h1_ak47";
	level.mm_loadouts["allies"]["loadoutEquipment"] = "h1_fraggrenade_mp";
	level.mm_loadouts["allies"]["loadoutOffhand"] = "h1_smokegrenade_mp";
	level.mm_loadouts["axis"] = maps\mp\gametypes\_class::getemptyloadout();
	level.mm_loadouts["axis"]["loadoutMelee"] = "h1_meleeshovel";
	level.mm_loadouts["axis"]["loadoutPrimary"] = "h1_ak47";
	level.mm_loadouts["axis"]["loadoutEquipment"] = "h1_fraggrenade_mp";
	level.mm_loadouts["axis"]["loadoutOffhand"] = "h1_smokegrenade_mp";
}

//Function Number: 34
mmononeleftevent(param_00)
{
	if(param_00 == "axis")
	{
		return;
	}

	var_01 = maps\mp\_utility::getlastlivingplayer(param_00);
	var_01 thread givelastonteamwarning();
}

//Function Number: 35
givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive",self,self.pers["team"]);
	level notify("last_alive",self);
}

//Function Number: 36
botslasheristargetingme()
{
	if(isdefined(level.slasher))
	{
		if(isai(level.slasher))
		{
			return isdefined(level.slasher.enemy) && level.slasher.enemy == self && level.slasher botcanseeentity(self);
		}
		else
		{
			return common_scripts\utility::within_fov(level.slasher geteye(),level.slasher getplayerangles(),self geteye(),0.422618) && sighttracepassed(level.slasher geteye(),self geteye(),0,self);
		}
	}

	return 0;
}

//Function Number: 37
botmmlogic()
{
	self notify("botMMLogic");
	self endon("botMMLogic");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.next_hide_time = 0;
	self.next_bad_place_time = 0;
	var_00 = 1;
	var_01 = 300;
	var_02 = 1000;
	var_03 = 30000;
	for(;;)
	{
		wait(0.05);
		if(self.health <= 0)
		{
			continue;
		}

		if(maps\mp\_utility::is_true(self.isslasher) || level.mm_teamscores["allies"] == 1)
		{
			if(self botgetscriptgoaltype() == "critical")
			{
				self botclearscriptgoal();
			}

			continue;
		}

		if(botslasheristargetingme())
		{
			if(self bothasscriptgoal())
			{
				self botclearscriptgoal();
			}

			self.ignoreall = 1;
			if(gettime() > self.next_bad_place_time)
			{
				badplace_cylinder("slasher",var_02 / 1000,level.slasher.origin,var_01,75,"allies");
				self.next_bad_place_time = gettime() + var_02;
			}

			continue;
		}

		if(gettime() > self.next_hide_time)
		{
			self.ignoreall = 0;
			var_04 = getnodesinradius(self.origin,900,0,300);
			var_05 = self botnodepick(var_04,var_04.size * 0.15,"node_hide_anywhere");
			if(!isdefined(var_05))
			{
				var_05 = self getnearestnode();
			}

			if(isdefined(var_05))
			{
				var_06 = self botsetscriptgoalnode(var_05,"critical");
				if(var_06)
				{
					self.next_hide_time = gettime() + var_03;
				}
			}
		}
	}
}

//Function Number: 38
watchapplyloadout(param_00)
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("applyLoadout");
		self thread [[ param_00 ]]();
	}
}

//Function Number: 39
giveprimaryweapon(param_00,param_01,param_02)
{
	var_03 = self.primaryweapon;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	var_04 = self.secondaryweapon;
	var_05 = maps\mp\_utility::is_true(param_01) && maps\mp\_utility::_hasperk("specialty_twoprimaries") && var_04 != "none";
	if(maps\mp\_utility::is_true(param_00))
	{
		self allowmelee(0);
	}

	self takeallweapons();
	self giveweapon(var_03);
	self setspawnweapon(var_03);
	self switchtoweapon(var_03);
	if(var_05)
	{
		self giveweapon(var_04);
	}

	if(maps\mp\_utility::_hasperk("specialty_extraammo"))
	{
		self givemaxammo(var_03);
		if(var_05)
		{
			self givemaxammo(var_04);
		}
	}
}

//Function Number: 40
giveprimaryonly()
{
	giveprimaryweapon(0,1);
}

//Function Number: 41
giveprimaryonlynomelee()
{
	giveprimaryweapon(1,1);
}

//Function Number: 42
initrpgonly()
{
	level.onspawnplayer = ::onrpgspawnplayer;
	level.bypassclasschoicefunc = ::rpgonlyclass;
	level.modifyplayerdamage = ::rpgonlymodifyplayerdamage;
	level.rpg_loadout = maps\mp\gametypes\_class::getemptyloadout();
	level.rpg_loadout["loadoutSecondary"] = "h1_rpg";
	level.rpg_loadout["loadoutEquipment"] = "h1_fraggrenade_mp";
	level.rpg_loadout["loadoutOffhand"] = "h1_smokegrenade_mp";
	setupdvarsrpg();
	level thread watchhostmigrationrpg();
}

//Function Number: 43
setupdvarsrpg()
{
	setdynamicdvar("g_oldschool",1);
}

//Function Number: 44
watchhostmigrationrpg()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_begin");
		setupdvarsrpg();
		level waittill("host_migration_end");
		setupdvarsrpg();
	}
}

//Function Number: 45
rpgonlyclass()
{
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "";
	self.pers["gamemodeLoadout"] = level.rpg_loadout;
	self.class = self.pers["class"];
	self.lastclass = self.pers["lastClass"];
}

//Function Number: 46
onrpgspawnplayer()
{
	thread refillrpgammo();
	thread onrpgspawnplayerwait();
}

//Function Number: 47
onrpgspawnplayerwait()
{
	self endon("disconnect");
	waittillframeend;
	giverpgperks();
	giveprimaryweapon(0,0,"h1_rpg_mp");
}

//Function Number: 48
giverpgperks()
{
	maps\mp\_utility::giveperk("specialty_fastreload",0);
}

//Function Number: 49
refillrpgammo()
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("refillRPGAmmo");
	self endon("refillRPGAmmo");
	if(level.rpgonlyreload)
	{
		for(;;)
		{
			self setweaponammostock("h1_rpg_mp",2);
			self waittill("reload");
		}

		return;
	}

	for(;;)
	{
		self waittill("weapon_fired",var_00);
		if(var_00 == "h1_rpg_mp")
		{
			self setweaponammoclip("h1_rpg_mp",1);
		}
	}
}

//Function Number: 50
rpgonlymodifyplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(param_04 == "h1_rpg_mp" && isdefined(param_00))
	{
		var_08 = 50;
		var_09 = 200;
		var_0A = 500;
		var_0B = 100;
		var_0C = length(param_06);
		var_0D = 1 - clamp(var_0C - var_08 / var_09 - var_08,0,1);
		var_0E = var_0A - var_0B * var_0D + var_0B;
		if(param_06[2] < 0)
		{
			param_06 = (param_06[0],param_06[1],0);
		}

		var_0F = vectornormalize(param_06);
		var_10 = param_00 getvelocity();
		param_00 setvelocity(var_10 + var_0F * var_0E);
		if(isdefined(param_01) && param_01 == param_00)
		{
			var_11 = 50;
			var_12 = 300;
			var_13 = 100;
			var_14 = 0;
			var_0D = 1 - clamp(var_0C - var_11 / var_12 - var_11,0,1);
			var_15 = var_13 - var_14 * var_0D + var_14;
			param_02 = int(var_15);
		}
	}

	return param_02;
}

//Function Number: 51
initprophunt()
{
	level.bot_ignore_personality = 1;
	maps\mp\gametypes\_hodgepodge_ph::ph_init();
}

//Function Number: 52
flashkillindicator()
{
	self notify("newKillIndicator");
	self endon("newKillIndicator");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.killindicator.alpha = 1;
	self.killindicator fadeovertime(3);
	self.killindicator.alpha = 0;
}

//Function Number: 53
updatekillindicator(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	var_01 = param_00;
	if(param_00 >= 150)
	{
		self.killindicator.color = (0,1,0);
	}
	else
	{
		var_01 = 0.01 * 100 - 0.67 * var_01;
		self.killindicator.color = (var_01,1,var_01);
	}

	self.killindicator setvalue(param_00);
	if(!isdefined(self.maxkillrange) || self.maxkillrange < param_00)
	{
		self.maxkillrange = param_00;
		self.maxkillindicator.color = (var_01,1,var_01);
		self.maxkillindicator setvalue(self.maxkillrange);
		self.maxkillindicator.alpha = 1;
		if(param_00 >= 150)
		{
			self.maxkillindicator.color = (0,1,0);
			self.maxkillindicator.glowalpha = 0.5;
		}

		if(!isdefined(level.maxmatchrange) || level.maxmatchrange < param_00)
		{
			level.maxmatchrange = param_00;
			level.maxmatchindicator.color = (var_01,1,var_01);
			level.maxmatchindicator setvalue(level.maxmatchrange);
			level.maxmatchindicator.alpha = 1;
			if(param_00 >= 150)
			{
				level.maxmatchindicator.color = (0,1,0);
				level.maxmatchindicator.glowalpha = 0.5;
			}
		}
	}

	thread flashkillindicator();
}

//Function Number: 54
hidekillindicator()
{
	self endon("disconnect");
	for(;;)
	{
		level waittill("game_ended");
		self.killindicator.alpha = 0;
		self.maxkillindicator.alpha = 0;
	}
}

//Function Number: 55
killrangeindicator()
{
	self endon("disconnect");
	self.killindicator = maps\mp\gametypes\_hud_util::createfontstring("objective",1);
	self.killindicator.label = &"MP_RANGE_KILL_INDICATOR";
	self.killindicator setvalue(0);
	self.killindicator.x = 0;
	self.killindicator.y = 20;
	self.killindicator.alignx = "center";
	self.killindicator.aligny = "middle";
	self.killindicator.horzalign = "center_adjustable";
	self.killindicator.vertalign = "middle";
	self.killindicator.archived = 1;
	self.killindicator.fontscale = 1;
	self.killindicator.alpha = 0;
	self.killindicator.glowalpha = 0.5;
	self.killindicator.hidewheninmenu = 0;
	self.maxkillindicator = maps\mp\gametypes\_hud_util::createfontstring("objective",1);
	self.maxkillindicator.x = -6;
	self.maxkillindicator.y = 2;
	self.maxkillindicator.alignx = "right";
	self.maxkillindicator.aligny = "top";
	self.maxkillindicator.horzalign = "right_adjustable";
	self.maxkillindicator.vertalign = "top_adjustable";
	self.maxkillindicator.label = &"MP_MAX_KILL_INDICATOR";
	self.maxkillindicator setvalue(0);
	self.maxkillindicator.alpha = 0;
	self.maxkillindicator.archived = 0;
	self.maxkillindicator.hidewheninmenu = 1;
	thread hidekillindicator();
}

//Function Number: 56
onsniperonlyplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = self;
	if(!isdefined(param_01))
	{
		return;
	}

	var_0B = param_01 == self || !isplayer(param_01);
	if(var_0B)
	{
		return;
	}

	if(isdefined(param_01) && isdefined(var_0A) && isdefined(param_01.origin) && isdefined(var_0A.origin))
	{
		var_0C = int(exp(distance(param_01.origin,var_0A.origin) * 0.0254));
		if(var_0C <= 0)
		{
			var_0C = 1;
		}
	}
	else
	{
		return;
	}

	param_01 thread updatekillindicator(var_0C);
}

//Function Number: 57
matchbestkillrangeindicator()
{
	level.maxmatchindicator = maps\mp\gametypes\_hud_util::createserverfontstring("objective",1);
	level.maxmatchindicator.x = -6;
	level.maxmatchindicator.y = 14;
	level.maxmatchindicator.alignx = "right";
	level.maxmatchindicator.aligny = "top";
	level.maxmatchindicator.horzalign = "right_adjustable";
	level.maxmatchindicator.vertalign = "top_adjustable";
	level.maxmatchindicator.label = &"MP_MAX_MATCH_INDICATOR";
	level.maxmatchindicator setvalue(0);
	level.maxmatchindicator.alpha = 0;
	level.maxmatchindicator.archived = 0;
	level.maxmatchindicator.hidewheninmenu = 1;
}

//Function Number: 58
initsnipersonly()
{
	level.onplayerkilled = ::onsniperonlyplayerkilled;
	level matchbestkillrangeindicator();
}