/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_h2o_sq.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 299
 * Decompile Time: 4457 ms
 * Timestamp: 4/22/2024 2:19:45 AM
*******************************************************************/

//Function Number: 1
init_sidequest()
{
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("main",::init_main_sidequest,::sidequest_logic,::complete_sidequest,::generic_stage_start,::generic_stage_complete);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage1",::stage1_init,::stage1_logic,::stage1_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage2",::stage2_init,::stage2_logic,::stage2_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage3",::stage3_init,::stage3_logic,::stage3_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage4",::stage4_init,::stage4_logic,::stage4_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage5",::stage5_init,::stage5_logic,::stage5_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage7",::stage7_init,::stage7_logic,::stage7_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage8",::stage8_init,::stage8_logic,::stage8_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage9",::stage9_init,::stage9_logic,::stage9_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage10",::stage10_init,::stage10_logic,::stage10_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage11",::stage11_init,::stage11_logic,::stage11_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage12",::stage12_init,::stage12_logic,::stage12_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage13",::stage13_init,::stage13_logic,::stage13_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage14",::stage14_init,::stage14_logic,::stage14_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main","stage15",::stage15_init,::stage15_logic,::stage15_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest("song",::init_song_sidequest,::sidequest_logic_song);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage1",::songstage1_init,::songstage1_logic,::songstage1_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage2",::songstage2_init,::songstage2_logic,::songstage2_end);
	maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song","stage3",::songstage3_init,::songstage3_logic,::songstage3_end);
	level._effect["sq_capacitor_cover_blown_off"] = loadfx("vfx/explosion/vehicle_assault_drone_death");
	level._effect["sq_capacitor_charge"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_capacitor_charge");
	level._effect["sq_capacitor_charge_complete"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_capacitor_charge_complete");
	level._effect["sq_emz_explode"] = loadfx("vfx/map/mp_zombie_h2o/h2o_sq_emz_explode");
	level._effect["sq_light_puzzle_0"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_0");
	level._effect["sq_light_puzzle_1"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_1");
	level._effect["sq_light_puzzle_2"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_2");
	level._effect["sq_light_puzzle_3"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_3");
	level._effect["sq_light_puzzle_loop"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_light_puzzle_4");
	level._effect["sq_memory_machine_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_memory_pwr_on");
	level._effect["sq_memory_machine_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_memory_pwr_off");
	level._effect["sq_memory_tunnel_player"] = loadfx("vfx/map/mp_zombie_h2o/h2o_teleport_tunnel_player");
	level._effect["sq_bubbles"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_diving_suit_bubble_trail_lp");
	level._effect["sq_bubbles_first_person"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_player_bubbles_breath");
	level._effect["sq_plunge"] = loadfx("vfx/water/screen_fx_plunge");
	level._effect["sq_emerge"] = loadfx("vfx/water/screen_fx_emerge");
	level._effect["h2o_ee_wave_hit_large"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_wave_hit_large");
	level._effect["h2o_ee_wave_hit_med"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_wave_hit_med");
	level._effect["h2o_ee_wave_hit_sm"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_wave_hit_sm");
	level.shouldignoreplayercallback = ::h2oshouldignoreplayer;
	level.zombiehardmodevisionset = "mp_zombie_h2o_hard";
	level.zombiehardmodeinfectedvisionset = "mp_zombie_h2o_infected_hard";
	level thread jumpquest_init();
	level thread starth2osidequest();
	level thread setuptrophycase();
	level thread setuphardmode();
	level thread initvo();
	level thread initcapacitors();
}

//Function Number: 2
starth2osidequest()
{
	var_00 = getent("sq_underwater_switch_off","targetname");
	if(isdefined(var_00))
	{
		var_00 hide();
	}

	var_00 = getent("sq_underwater_switch_on","targetname");
	if(isdefined(var_00))
	{
		var_00 hide();
	}

	var_01 = getent("sqCounterTop0","targetname");
	var_02 = getent("sqCounterTop1","targetname");
	var_03 = getent("sqCounterTop2","targetname");
	var_04 = getent("sqCounterTop3","targetname");
	var_05 = getent("sqCounterBottom0","targetname");
	var_06 = getent("sqCounterBottom1","targetname");
	var_07 = getent("sqCounterBottom2","targetname");
	var_08 = getent("sqCounterBottom3","targetname");
	var_01 hide();
	var_02 hide();
	var_03 hide();
	var_04 hide();
	var_05 hide();
	var_06 hide();
	var_07 hide();
	var_08 hide();
	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		return;
	}

	wait(1);
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("main");
	thread maps\mp\zombies\_zombies_sidequests::sidequest_start("song");
}

//Function Number: 3
setuptrophycase()
{
	var_00 = [];
	var_01 = gettrophy("1a");
	if(!isdefined(var_01))
	{
		return;
	}

	var_00[var_00.size] = var_01;
	var_00[var_00.size] = gettrophy("1b");
	var_00[var_00.size] = gettrophy("2");
	var_00[var_00.size] = gettrophy("3a");
	var_00[var_00.size] = gettrophy("3b");
	var_00[var_00.size] = gettrophy("4a");
	var_00[var_00.size] = gettrophy("4b");
	if(var_00.size != 7)
	{
		return;
	}

	foreach(var_01 in var_00)
	{
		var_01 trophyhide();
	}

	if(!isdefined(level.players) || level.players.size == 0)
	{
		level waittill("player_spawned");
	}

	level thread onplayerconnecttrophies(var_00);
	for(;;)
	{
		foreach(var_05 in level.players)
		{
			var_05 playershowtrophies(var_00);
		}

		level waittill("sq_update_trophies");
		foreach(var_01 in var_00)
		{
			var_01 trophyhide();
		}
	}
}

//Function Number: 4
playershowtrophies(param_00)
{
	var_01 = self getcoopplayerdatareservedint("eggData");
	if(var_01 & 1)
	{
		showtrophyforplayer(param_00,"1a",self);
	}

	if(var_01 & 2)
	{
		showtrophyforplayer(param_00,"1b",self);
	}

	if(var_01 & 4)
	{
		showtrophyforplayer(param_00,"2",self);
	}

	if(var_01 & 8)
	{
		showtrophyforplayer(param_00,"3a",self);
	}

	if(var_01 & 16)
	{
		showtrophyforplayer(param_00,"3b",self);
	}

	if(var_01 & 32)
	{
		showtrophyforplayer(param_00,"4a",self);
	}

	if(var_01 & 64)
	{
		showtrophyforplayer(param_00,"4b",self);
	}
}

//Function Number: 5
showtrophyforplayer(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		if(var_04.id == param_01)
		{
			var_04 trophyshowtoplayer(param_02);
			break;
		}
	}
}

//Function Number: 6
trophyhide()
{
	self hide();
	if(isdefined(self.trophynum))
	{
		self.trophynum hide();
	}
}

//Function Number: 7
trophyshowtoplayer(param_00)
{
	self showtoplayer(param_00);
	if(isdefined(self.trophynum))
	{
		self.trophynum showtoplayer(param_00);
	}
}

//Function Number: 8
gettrophy(param_00)
{
	var_01 = getent("sqTrophy" + param_00,"targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = getent("sqTrophyNum" + param_00,"targetname");
	var_01.id = param_00;
	var_01.trophynum = var_02;
	return var_01;
}

//Function Number: 9
onplayerconnecttrophies(param_00)
{
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 playershowtrophies(param_00);
	}
}

//Function Number: 10
setuphardmode()
{
	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		setnojipscore(1);
		setomnvar("ui_zm_hard_mode",1);
		visionsetpostapply(level.zombiehardmodevisionset,0);
		setmatchdata("gameLengthSeconds",0);
		setmatchdata("lifeCount",0);
		setmatchdata("eventCount",0);
		if(isdefined(level.players))
		{
			foreach(var_01 in level.players)
			{
				var_01 thread playersetuphardmode();
			}
		}

		level thread onplayerconnecthardmode();
		var_03 = getent("sqHardModeButton","targetname");
		var_04 = getent("sqHardModeTrigger","targetname");
		if(isdefined(var_03))
		{
			var_03 hide();
		}

		if(isdefined(var_04))
		{
			var_04 hide();
		}

		level.zmbhardmodeintro = ::zmbhardmodeintro;
		level waittill("zombie_boss_stage2_ended");
		sethardmodebosscoopdatah2o();
		return;
	}

	level thread handlehardmodebutton();
	waittillstarthardmode();
	setnojipscore(1);
	level.zombiegamepaused = 1;
	maps\mp\zombies\_util::writezombiestats();
	level thread endgametohardmode(level.playerteam,game["end_reason"]["zombies_hard_mode"]);
}

//Function Number: 11
zmbhardmodeintro()
{
	announcerozglobalplaysq(34);
}

//Function Number: 12
handlehardmodebutton()
{
	var_00 = getent("sqHardModeButton","targetname");
	var_01 = getent("sqHardModeTrigger","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_01.origin = var_01.origin + (0,0,1000);
	var_00 hide();
	if(isdefined(level.players))
	{
		foreach(var_03 in level.players)
		{
			var_03 playershowhardmodebutton(var_01,var_00);
		}
	}

	level thread onplayerconnectshowhardmodebutton(var_01,var_00);
	for(;;)
	{
		var_01 waittill("trigger",var_03);
		if(maps\mp\zombies\_util::is_true(var_01.enabled))
		{
			if(!maps\mp\zombies\_util::is_true(var_03.hardmodevote))
			{
				var_03.hardmodevote = 1;
				iprintlnbold(&"ZOMBIE_H2O_HARD_MODE_VOTE",numplayersvotedforhardmode(),level.players.size);
			}
			else
			{
				var_03 iprintlnbold(&"ZOMBIE_H2O_HARD_MODE_VOTE",numplayersvotedforhardmode(),level.players.size);
			}

			if(checkstarthardmode())
			{
				return;
			}
		}

		wait(0.5);
	}
}

//Function Number: 13
checkstarthardmode()
{
	if(allplayerswanthardmode())
	{
		wait(1);
		level notify("start_hard_mode");
		return 1;
	}

	return 0;
}

//Function Number: 14
numplayersvotedforhardmode()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(maps\mp\zombies\_util::is_true(var_02.hardmodevote))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 15
allplayerswanthardmode()
{
	foreach(var_01 in level.players)
	{
		if(!maps\mp\zombies\_util::is_true(var_01.hardmodevote))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 16
onplayerconnectshowhardmodebutton(param_00,param_01)
{
	for(;;)
	{
		level waittill("connected",var_02);
		var_02 thread playershowhardmodebutton(param_00,param_01);
	}
}

//Function Number: 17
playershowhardmodebutton(param_00,param_01)
{
	thread onplayerdisconnecthardmodebutton();
	if(playerhashardmode() && !maps\mp\zombies\_util::is_true(param_00.enabled))
	{
		param_00.origin = param_00.origin + (0,0,-1000);
		param_00 setcursorhint("HINT_NOICON");
		param_00 sethintstring(&"ZOMBIE_H2O_START_HARD_MODE");
		param_00.enabled = 1;
		param_01 show();
	}
}

//Function Number: 18
onplayerdisconnecthardmodebutton()
{
	level endon("game_ended");
	self waittill("disconnect");
	checkstarthardmode();
}

//Function Number: 19
sethardmodebosscoopdatah2o()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.joinedround1) || !var_01.joinedround1)
		{
			continue;
		}

		var_02 = var_01 getcoopplayerdatareservedint("eggData");
		var_02 = var_02 | 64;
		var_01 setcoopplayerdatareservedint("eggData",var_02);
	}

	level notify("sq_update_trophies");
}

//Function Number: 20
onplayerconnecthardmode()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawnedhardmode();
	}
}

//Function Number: 21
onplayerspawnedhardmode()
{
	self endon("disconnect");
	self waittill("spawned_player");
	thread playersetuphardmode();
}

//Function Number: 22
playersetuphardmode()
{
	self endon("disconnect");
	playersethardmodecoopdatah2o();
	self method_856B(0);
	for(;;)
	{
		self waittill("spawned_player");
		self method_856B(0);
	}
}

//Function Number: 23
setsidequestcoopdatah2o()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.joinedround1) || !var_01.joinedround1)
		{
			continue;
		}

		var_02 = var_01 getcoopplayerdatareservedint("eggData");
		var_02 = var_02 | 32;
		var_01.sidequest = 1;
		var_01 setcoopplayerdatareservedint("eggData",var_02);
		setmatchdata("players",var_01.clientid,"startPrestige",var_01.sidequest);
	}

	level notify("sq_update_trophies");
}

//Function Number: 24
playersethardmodecoopdatah2o()
{
	var_00 = self getcoopplayerdatareservedint("eggData");
	var_00 = var_00 | 128;
	self setcoopplayerdatareservedint("eggData",var_00);
}

//Function Number: 25
playerhashardmode()
{
	var_00 = self getcoopplayerdatareservedint("eggData");
	return var_00 & 128;
}

//Function Number: 26
givesidequestachievement()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.joinedround1) || !var_01.joinedround1)
		{
			continue;
		}

		var_01 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_EASTEREGG");
	}
}

//Function Number: 27
waittillstarthardmode()
{
	level endon("start_hard_mode");
	level waittill("sidequest_main_complete");
}

//Function Number: 28
endgametohardmode(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(game["state"] == "postgame" || level.gameended)
	{
		return;
	}

	game["state"] = "postgame";
	setdvar("ui_game_state","postgame");
	level.zmbtransitiontohardmode = 1;
	level.gameendtime = gettime();
	level.gameended = 1;
	level.ingraceperiod = 0;
	level notify("game_ended",param_00);
	maps\mp\_utility::levelflagset("game_over");
	maps\mp\_utility::levelflagset("block_notifies");
	var_03 = maps\mp\gametypes\_gamelogic::getgameduration();
	setomnvar("ui_game_duration",var_03 * 1000);
	wait 0.05;
	setgameendtime(0);
	setmatchdata("gameLengthSeconds",var_03);
	setmatchdata("endTimeUTC",getsystemtime());
	maps\mp\gametypes\_gamelogic::checkgameendchallenges();
	if(isdefined(param_00) && isstring(param_00) && maps\mp\_utility::isovertimetext(param_00))
	{
		level.finalkillcam_winner = "none";
		maps\mp\gametypes\_gamelogic::endgameovertime(param_00,param_01);
		return;
	}

	if(isdefined(param_00) && isstring(param_00) && param_00 == "halftime")
	{
		level.finalkillcam_winner = "none";
		maps\mp\gametypes\_gamelogic::endgamehalftime(param_01);
		return;
	}

	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
	}

	game["roundsPlayed"]++;
	setomnvar("ui_current_round",game["roundsPlayed"]);
	if(level.teambased)
	{
		if((param_00 == "axis" || param_00 == "allies") && level.gametype != "ctf")
		{
			game["roundsWon"][param_00]++;
		}

		maps\mp\gametypes\_gamescore::updateteamscore("axis");
		maps\mp\gametypes\_gamescore::updateteamscore("allies");
	}
	else if(isdefined(param_00) && isplayer(param_00))
	{
		game["roundsWon"][param_00.guid]++;
	}

	maps\mp\gametypes\_gamescore::updateplacement();
	maps\mp\gametypes\_gamelogic::rankedmatchupdates(param_00);
	foreach(var_05 in level.players)
	{
		var_05 setclientdvar("ui_opensummary",1);
		if(maps\mp\_utility::wasonlyround() || maps\mp\_utility::waslastround())
		{
			var_05 maps\mp\killstreaks\_killstreaks::clearkillstreaks(1);
		}
	}

	setdvar("g_deadChat",1);
	setdvar("ui_allow_teamchange",0);
	setdvar("bg_compassShowEnemies",0);
	maps\mp\gametypes\_gamelogic::freezeallplayers(1,1);
	if(!maps\mp\_utility::wasonlyround() && !param_02)
	{
		maps\mp\gametypes\_gamelogic::displayroundend(param_00,param_01);
		if(isdefined(level.finalkillcam_winner))
		{
			foreach(var_05 in level.players)
			{
				var_05 notify("reset_outcome");
			}

			level notify("game_cleanup");
			maps\mp\gametypes\_gamelogic::waittillfinalkillcamdone();
		}

		if(!maps\mp\_utility::waslastround())
		{
			maps\mp\_utility::levelflagclear("block_notifies");
			if(maps\mp\gametypes\_gamelogic::checkroundswitch())
			{
				maps\mp\gametypes\_gamelogic::displayroundswitch();
			}

			foreach(var_05 in level.players)
			{
				var_05.pers["stats"] = var_05.stats;
				var_05.pers["segments"] = var_05.segments;
			}

			level notify("restarting");
			game["state"] = "playing";
			setdvar("ui_game_state","playing");
			map_restart(1);
			return;
		}

		if(!level.forcedend)
		{
			var_03 = maps\mp\gametypes\_gamelogic::updateendreasontext(param_02);
		}
	}

	if(!isdefined(game["clientMatchDataDef"]))
	{
		game["clientMatchDataDef"] = "mp/clientmatchdata.def";
		setclientmatchdatadef(game["clientMatchDataDef"]);
	}

	maps\mp\gametypes\_missions::roundend(param_02);
	param_02 = maps\mp\gametypes\_gamelogic::getgamewinner(param_02,1);
	if(level.teambased)
	{
		setomnvar("ui_game_victor",0);
		if(param_02 == "allies")
		{
			setomnvar("ui_game_victor",2);
		}
		else if(param_02 == "axis")
		{
			setomnvar("ui_game_victor",1);
		}
	}

	maps\mp\gametypes\_gamelogic::displaygameend(param_02,var_03);
	foreach(var_09 in level.players)
	{
		var_09 setclientomnvar("ui_round_end_reason",var_03);
	}

	var_0D = gettime();
	if(isdefined(level.finalkillcam_winner) && maps\mp\_utility::wasonlyround())
	{
		foreach(var_09 in level.players)
		{
			var_09 notify("reset_outcome");
		}

		level notify("game_cleanup");
		maps\mp\gametypes\_gamelogic::waittillfinalkillcamdone();
	}

	maps\mp\_utility::levelflagclear("block_notifies");
	level.intermission = 1;
	level notify("spawning_intermission");
	foreach(var_09 in level.players)
	{
		var_09 closepopupmenu();
		var_09 closeingamemenu();
		var_09 notify("reset_outcome");
		var_09 thread maps\mp\gametypes\_playerlogic::spawnintermission();
	}

	maps\mp\gametypes\_gamelogic::processlobbydata();
	wait(1);
	maps\mp\gametypes\_gamelogic::checkforpersonalbests();
	maps\mp\gametypes\_gamelogic::updatecombatrecord();
	if(level.teambased)
	{
		if(param_02 == "axis" || param_02 == "allies")
		{
			setmatchdata("victor",param_02);
		}
		else
		{
			setmatchdata("victor","none");
		}

		setmatchdata("alliesScore",game["teamScores"]["allies"]);
		setmatchdata("axisScore",game["teamScores"]["axis"]);
		tournamentreportwinningteam(param_02);
	}
	else
	{
		setmatchdata("victor","none");
	}

	level maps\mp\_matchdata::endofgamesummarylogger();
	foreach(var_09 in level.players)
	{
		if(var_09 maps\mp\_utility::rankingenabled())
		{
			var_09 maps\mp\_matchdata::logfinalstats();
		}

		var_09 maps\mp\gametypes\_playerlogic::logplayerstats();
	}

	setmatchdata("host",maps\mp\gametypes\_playerlogic::truncateplayername(level.hostname));
	if(maps\mp\_utility::matchmakinggame())
	{
		setmatchdata("playlistVersion",getplaylistversion());
		setmatchdata("playlistID",getplaylistid());
		setmatchdata("isDedicated",isdedicatedserver());
	}

	setmatchdata("levelMaxClients",level.maxclients);
	sendmatchdata();
	foreach(var_09 in level.players)
	{
		var_09.pers["stats"] = var_09.stats;
		var_09.pers["segments"] = var_09.segments;
	}

	tournamentreportendofgame();
	var_16 = 0;
	if(maps\mp\_utility::practiceroundgame())
	{
		var_16 = 5;
	}

	if(isdefined(level.endgamewaitfunc))
	{
		[[ level.endgamewaitfunc ]](var_04,level.postgamenotifies,var_16,param_02);
	}
	else if(!var_04 && !level.postgamenotifies)
	{
		if(!maps\mp\_utility::wasonlyround())
		{
			wait(6 + var_16);
		}
		else
		{
			wait(min(10,4 + var_16 + level.postgamenotifies));
		}
	}
	else
	{
		wait(min(10,4 + var_16 + level.postgamenotifies));
	}

	var_17 = "_gamelogic.gsc";
	var_18 = "all";
	if(level.teambased && isdefined(param_02))
	{
		var_18 = param_02;
	}

	var_19 = "undefined";
	if(isdefined(var_03))
	{
		switch(var_03)
		{
			case 1:
				var_19 = "MP_SCORE_LIMIT_REACHED";
				break;

			case 2:
				var_19 = "MP_TIME_LIMIT_REACHED";
				break;

			case 3:
				var_19 = "MP_PLAYERS_FORFEITED";
				break;

			case 4:
				var_19 = "MP_TARGET_DESTROYED";
				break;

			case 5:
				var_19 = "MP_BOMB_DEFUSED";
				break;

			case 6:
				var_19 = "MP_GHOSTS_ELIMINATED";
				break;

			case 7:
				var_19 = "MP_FEDERATION_ELIMINATED";
				break;

			case 8:
				var_19 = "MP_GHOSTS_FORFEITED";
				break;

			case 9:
				var_19 = "MP_FEDERATION_FORFEITED";
				break;

			case 10:
				var_19 = "MP_ENEMIES_ELIMINATED";
				break;

			case 11:
				var_19 = "MP_MATCH_TIE";
				break;

			case 12:
				var_19 = "GAME_OBJECTIVECOMPLETED";
				break;

			case 13:
				var_19 = "GAME_OBJECTIVEFAILED";
				break;

			case 14:
				var_19 = "MP_SWITCHING_SIDES";
				break;

			case 15:
				var_19 = "MP_ROUND_LIMIT_REACHED";
				break;

			case 16:
				var_19 = "MP_ENDED_GAME";
				break;

			case 17:
				var_19 = "MP_HOST_ENDED_GAME";
				break;

			default:
				break;
		}
	}

	if(!isdefined(var_0D))
	{
		var_0D = -1;
	}

	var_1A = 15;
	var_1B = var_1A;
	var_1C = getmatchdata("playerCount");
	var_1D = getmatchdata("lifeCount");
	if(!isdefined(level.matchdata))
	{
		var_1E = 0;
		var_1F = 0;
		var_20 = 0;
		var_21 = 0;
		var_22 = 0;
		var_23 = 0;
		var_24 = 0;
	}
	else
	{
		if(isdefined(level.matchdata["botJoinCount"]))
		{
			var_1E = level.matchdata["botJoinCount"];
		}
		else
		{
			var_1E = 0;
		}

		if(isdefined(level.matchdata["deathCount"]))
		{
			var_1F = level.matchdata["deathCount"];
		}
		else
		{
			var_1F = 0;
		}

		if(isdefined(level.matchdata["badSpawnDiedTooFastCount"]))
		{
			var_20 = level.matchdata["badSpawnDiedTooFastCount"];
		}
		else
		{
			var_20 = 0;
		}

		if(isdefined(level.matchdata["badSpawnKilledTooFastCount"]))
		{
			var_21 = level.matchdata["badSpawnKilledTooFastCount"];
		}
		else
		{
			var_21 = 0;
		}

		if(isdefined(level.matchdata["badSpawnDmgDealtCount"]))
		{
			var_22 = level.matchdata["badSpawnDmgDealtCount"];
		}
		else
		{
			var_22 = 0;
		}

		if(isdefined(level.matchdata["badSpawnDmgReceivedCount"]))
		{
			var_23 = level.matchdata["badSpawnDmgReceivedCount"];
		}
		else
		{
			var_23 = 0;
		}

		if(isdefined(level.matchdata["badSpawnByAnyMeansCount"]))
		{
			var_24 = level.matchdata["badSpawnByAnyMeansCount"];
		}
		else
		{
			var_24 = 0;
		}
	}

	var_25 = 0;
	if(isdefined(level.spawnsighttracesused_pres1tu))
	{
		var_25 = var_25 + 1;
	}

	if(isdefined(level.spawnsighttracesused_posts1tu))
	{
		var_25 = var_25 + 2;
	}

	reconevent("@"script_mp_match_end: script_file %s, gameTime %d, match_winner %s, win_reason %s, version %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, badSpawnDiedTooFastCount %d, badSpawnKilledTooFastCount %d, badSpawnDmgDealtCount %d, badSpawnDmgReceivedCount %d, badSpawnByAnyMeansCount %d, sightTraceMethodsUsed %d",var_17,var_0D,var_18,var_19,var_1B,var_1C,var_1E,var_1D,var_1F,var_20,var_21,var_22,var_23,var_24,var_25);
	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(isdefined(level.zombiescompleted) && level.zombiescompleted)
		{
			setdvar("cg_drawCrosshair",1);
		}
	}

	foreach(var_09 in level.players)
	{
		var_09.pers["stats"] = var_09.stats;
		var_09.pers["segments"] = var_09.segments;
		var_09.pers["team"] = undefined;
		var_09 sendleaderboards();
		var_09 setclientomnvar("ui_round_end",0);
	}

	setomnvar("ui_zm_hard_mode",1);
	setomnvar("ui_zm_ee_bool",1);
	wait(0.5);
	level notify("restarting");
	game["state"] = "playing";
	game["start_in_zmb_hard_mode"] = 1;
	game["gamestarted"] = undefined;
	setdvar("ui_game_state","playing");
	map_restart(1);
}

//Function Number: 29
initvo()
{
	wait 0.05;
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","sq","sq","dlc4_easter",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","sq","sq_jump_win","dlc4_easter_jumpw",undefined,80);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","sq","sq_jump_fail","dlc4_easter_jumpf",undefined,30);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","sq","sq_dlc4",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","sq3","sq_dlc3",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","global_priority","sq","dlc4_easter",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz","machine_all_players","sq","dlc4_easter",undefined);
}

//Function Number: 30
h2oshouldignoreplayer(param_00)
{
	if(maps\mp\zombies\_util::is_true(param_00.inairlock))
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
init_main_sidequest()
{
}

//Function Number: 32
sidequest_logic()
{
	level thread monitorbossintermission();
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage1");
	level waittill("main_stage1_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage2");
	level waittill("main_stage2_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage3");
	level waittill("main_stage3_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage4");
	level waittill("main_stage4_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage5");
	level waittill("main_stage5_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage7");
	level waittill("main_stage7_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage8");
	level waittill("main_stage8_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage9");
	level waittill("main_stage9_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage10");
	level waittill("main_stage10_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage11");
	level waittill("main_stage11_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage12");
	level waittill("main_stage12_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage13");
	level waittill("main_stage13_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage14");
	level waittill("main_stage14_over");
	maps\mp\zombies\_zombies_sidequests::stage_start("main","stage15");
	level waittill("main_stage15_over");
	wait(2);
	setsidequestcoopdatah2o();
	givesidequestachievement();
}

//Function Number: 33
monitorbossintermission()
{
	level endon("main_stage15_over");
	level.zmbsqinbossintermission = 0;
	for(;;)
	{
		level waittill("zombie_round_count_update");
		level.zmbsqinbossintermission = 1;
		level waittill("zombie_wave_started");
		level.zmbsqinbossintermission = 0;
	}
}

//Function Number: 34
generic_stage_start()
{
}

//Function Number: 35
generic_stage_complete()
{
}

//Function Number: 36
complete_sidequest()
{
}

//Function Number: 37
stage1_init()
{
}

//Function Number: 38
stage1_logic()
{
	var_00 = getentarray("sqValve","targetname");
	if(var_00.size == 0)
	{
		return;
	}

	level.zmbsqnumvalvescomplete = 0;
	assignexplodernumberstovalves(var_00);
	foreach(var_02 in var_00)
	{
		var_02 thread valvesetup();
	}

	level waittill("zmb_sq_valve_complete");
	while(level.zmbsqnumvalvescomplete < 3)
	{
		wait 0.05;
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage1");
}

//Function Number: 39
valvesetup()
{
	self.degreesturned = 0;
	self.firstturn = 0;
	self.halfway = 0;
	self.damagecallback = ::valvedamagecallback;
	self setdamagecallbackon(1);
	self setcandamage(1);
	self waittill("turn_complete");
	level.zmbsqnumvalvescomplete++;
	thread maps\mp\mp_zombie_h2o_aud::sndvalvelight(self.origin);
	level notify("zmb_sq_valve_complete");
	activateclientexploder(self.script_index);
}

//Function Number: 40
assignexplodernumberstovalves(param_00)
{
	if(isdefined(param_00[0].script_index))
	{
		return;
	}

	var_01 = 40;
	param_00 = maps\mp\_utility::quicksort(param_00,::comparevalveheight);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		param_00[var_02].script_index = var_01;
		var_01++;
	}
}

//Function Number: 41
comparevalveheight(param_00,param_01)
{
	return param_00.origin[2] <= param_01.origin[2];
}

//Function Number: 42
valvedamagecallback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(param_04) && isexplosivedamagemod(param_04))
	{
		return;
	}

	if(!isdefined(param_01) || !isplayer(param_01))
	{
		return;
	}

	self.angles = (self.angles[0],self.angles[1],self.angles[2] + 6);
	self.degreesturned = self.degreesturned + 6;
	if(!self.halfway && self.degreesturned >= 180)
	{
		self.halfway = 1;
		self notify("turn_halfway");
	}

	if(!self.firstturn)
	{
		self.firstturn = 1;
		self notify("first_turn");
	}

	if(self.degreesturned >= 360)
	{
		self setdamagecallbackon(0);
		self.damagecallback = undefined;
		self notify("turn_complete");
	}
}

//Function Number: 43
stage1_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Opened secret room");
	thread maps\mp\mp_zombie_h2o_aud::sndcomputerloop();
	level thread opendoors();
}

//Function Number: 44
opendoors()
{
	var_00 = common_scripts\utility::getstruct("sqDoor1","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = getentarray(var_00.target,"targetname");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_04.openpos = common_scripts\utility::getstruct(var_04.target,"targetname");
		var_05 = getent(var_04.target,"targetname");
		var_05 vehicle_jetbikesethoverforcescale(var_04);
		if(!common_scripts\utility::array_contains(var_02,var_04.origin))
		{
			var_02[var_02.size] = var_04.origin;
		}
	}

	var_07 = 1;
	foreach(var_04 in var_01)
	{
		var_04 moveto(var_04.openpos.origin,var_07);
	}

	foreach(var_0B in var_02)
	{
		playsoundatpos(var_0B,"interact_door");
	}

	wait(var_07);
	level.zone_data.zones["easter_egg"].is_enabled = 1;
	common_scripts\utility::flag_set("zone_04_to_easter_egg");
	wait 0.05;
	foreach(var_04 in var_01)
	{
		var_04 delete();
	}
}

//Function Number: 45
stage2_init()
{
}

//Function Number: 46
stage2_logic()
{
	var_00 = common_scripts\utility::getstruct("sqComputer","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = 76;
	var_02 = var_00 maps\mp\zombies\_zombies_sidequests::fake_use("computer_used",undefined,undefined,"main_stage2_over",var_01);
	maps\mp\mp_zombie_h2o_aud::sndcomputeracknowledge(var_00.origin);
	wait(1);
	doangozconversation(var_00);
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage2");
}

//Function Number: 47
doangozconversation(param_00)
{
	var_01 = 76;
	announcerglobalplaysqvowaittilldone(1);
	var_02 = param_00 maps\mp\zombies\_zombies_sidequests::fake_use("computer_used",undefined,undefined,"main_stage2_over",var_01);
	maps\mp\mp_zombie_h2o_aud::sndcomputerfail(param_00.origin);
	wait(1);
	announcerglobalplaysqvowaittilldone(2);
	var_03 = getplayerlistforstage2();
	if(!isdefined(var_02))
	{
		var_02 = getnextplayerfromlist(var_03);
	}

	var_02 playerplaysqvo(1,undefined,1);
	wait(1);
	var_02 = getnextplayerfromlist(var_03,var_02);
	var_02 playerplaysqvo(2,undefined,1);
	wait(1);
	announcerozglobalplaysqwaittilldone(1);
	wait(1);
	var_02 = getnextplayerfromlist(var_03,var_02);
	var_02 playerplaysqvo(4,undefined,1);
	wait(3);
}

//Function Number: 48
getplayerlistforstage2()
{
	var_00 = [];
	var_01 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");
	if(isdefined(var_01))
	{
		var_00[var_00.size] = var_01;
	}

	var_02 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
	if(isdefined(var_02))
	{
		var_00[var_00.size] = var_02;
	}

	var_03 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");
	if(isdefined(var_03))
	{
		var_00[var_00.size] = var_03;
	}

	var_04 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("pilot");
	if(isdefined(var_04))
	{
		var_00[var_00.size] = var_04;
	}

	return var_00;
}

//Function Number: 49
getnextplayerfromlist(param_00,param_01)
{
	var_02 = undefined;
	var_03 = param_00.size;
	if(var_03 == 1)
	{
		return param_01;
	}

	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(!isdefined(param_01) || var_05 == param_01)
		{
			var_02 = var_04;
			break;
		}
	}

	var_04 = 0;
	var_02++;
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(var_02 >= var_03)
		{
			var_02 = 0;
		}

		var_05 = param_00[var_02];
		if(isalive(var_05))
		{
			return var_05;
		}

		var_04++;
		var_02++;
	}

	return param_01;
}

//Function Number: 50
stage2_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Used Computer and talked to Oz");
}

//Function Number: 51
stage3_init()
{
	var_00 = common_scripts\utility::getstruct("sqWaterValveLight","targetname");
	activateclientexploder(70);
	var_01 = getent("sq_underwater_switch_off","targetname");
	if(isdefined(var_01))
	{
		var_01 show();
	}
}

//Function Number: 52
stage3_logic()
{
	var_00 = common_scripts\utility::getstruct("sqAirlockUse","targetname");
	var_01 = getent("airlockClip1","targetname");
	var_02 = getent("sqAirlockUseTrigger","targetname");
	if(!isdefined(var_00) || !isdefined(var_02))
	{
		return;
	}

	var_03 = 0;
	for(;;)
	{
		var_02 waittill("trigger",var_04);
		if(!var_04 isonground())
		{
			continue;
		}

		thread maps\mp\mp_zombie_h2o_aud::snddepressurizeloopstart(var_01);
		activateclientexploder(30);
		level.zmbhighpriorityenemy = var_04;
		if(!var_03)
		{
			var_03 = 1;
			level thread announcerozglobalplaysq(24);
		}

		var_05 = var_01 useholdthink(var_04,0,45000);
		thread maps\mp\mp_zombie_h2o_aud::snddepressurizeloopend(var_01);
		stopclientexploder(30);
		if(var_05)
		{
			level.zmbhighpriorityenemy = undefined;
			break;
		}

		wait(1.5);
		level.zmbhighpriorityenemy = undefined;
	}

	maps\mp\mp_zombie_h2o_aud::snddepressurizecomplete(var_01);
	level thread announcerglobalplaysqvo(3,1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage3");
}

//Function Number: 53
useholdthink(param_00,param_01,param_02)
{
	param_00 playerlinkto(self);
	param_00 playerlinkedoffsetenable();
	if(!isdefined(self.curprogress))
	{
		self.curprogress = param_01;
		self.usetime = param_02;
	}

	self.inuse = 1;
	self.userate = 0;
	param_00 disableweapons();
	param_00 thread personalusebar(self);
	var_03 = useholdthinkloop(param_00);
	if(!isdefined(var_03))
	{
		var_03 = 0;
	}

	self.inuse = 0;
	if(isdefined(param_00))
	{
		param_00 enableweapons();
		param_00 setclientomnvar("ui_use_bar_text",0);
		param_00 setclientomnvar("ui_use_bar_end_time",0);
		param_00 setclientomnvar("ui_use_bar_start_time",0);
		if(param_00 islinked())
		{
			param_00 unlink();
		}
	}

	self notify("zombieUseHoldThinkComplete");
	return var_03;
}

//Function Number: 54
personalusebar(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("enter_last_stand");
	self endon("stop_useHoldThinkLoop");
	self setclientomnvar("ui_use_bar_text",6);
	self setclientomnvar("ui_use_bar_start_time",int(gettime() - param_00.curprogress));
	var_01 = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(param_00) && param_00.inuse && !level.gameended)
	{
		if(var_01 != param_00.userate)
		{
			if(param_00.curprogress > param_00.usetime)
			{
				param_00.curprogress = param_00.usetime;
			}

			if(param_00.userate > 0)
			{
				var_02 = gettime();
				var_03 = param_00.curprogress / param_00.usetime;
				var_04 = var_02 + 1 - var_03 * param_00.usetime / param_00.userate;
				self setclientomnvar("ui_use_bar_end_time",int(var_04));
			}

			var_01 = param_00.userate;
		}

		wait 0.05;
	}
}

//Function Number: 55
useholdthinkloop(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("enter_last_stand");
	param_00 endon("stop_useHoldThinkLoop");
	while(!level.gameended && isdefined(self) && maps\mp\_utility::isreallyalive(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		if(isdefined(self.objectivescaler))
		{
			self.userate = 1 * self.objectivescaler;
		}
		else
		{
			self.userate = 1;
		}

		if(self.curprogress >= self.usetime)
		{
			return maps\mp\_utility::isreallyalive(param_00);
		}

		wait(0.05);
	}

	return 0;
}

//Function Number: 56
stage3_end(param_00)
{
	level.zmbhighpriorityenemy = undefined;
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Activated the airlock");
}

//Function Number: 57
stage4_init()
{
}

//Function Number: 58
stage4_logic()
{
	var_00 = common_scripts\utility::getstruct("sqAirlockUse","targetname");
	var_01 = getent("airlockClip1","targetname");
	var_02 = getent("airlockClip2","targetname");
	var_03 = getent("sqAirlockTrigger1","targetname");
	var_04 = getent("sqAirlockTrigger2","targetname");
	var_05 = getent("sqAirlockVolume","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.angles))
	{
		var_00.angles = (0,180,0);
	}

	var_06 = createairlockdoor(var_01);
	var_07 = createairlockdoor(var_02);
	var_08 = 0;
	var_09 = 0;
	for(;;)
	{
		level.zmbbossteleportdelay = undefined;
		var_0A = activatedairlock(var_00);
		var_0B = 0;
		level thread monitorplayersinairlock(var_05,var_03);
		level thread openairlockdoor(var_06);
		if(canplayercontinuestage4(var_0A) && var_0A maps\mp\_utility::isjuggernaut())
		{
			waittillplayerinairlock(var_0A,var_03,var_05,1);
		}

		level.zmbbossteleportdelay = 1;
		level thread closeairlockdoor(var_06);
		if(maps\mp\zombies\_util::is_true(level.zmbbosscountdowninprogress))
		{
			teleportoutplayersinairlock();
		}
		else
		{
			teleportoutplayersinairlock(var_0A);
		}

		if(!canplayercontinuestage4(var_0A) || !var_0A maps\mp\_utility::isjuggernaut() || !maps\mp\zombies\_util::is_true(var_0A.inairlock))
		{
			level notify("main_stage4_stop_airlock_monitor");
			wait(1);
			continue;
		}

		if(!var_08)
		{
			level thread announcerozglobalplaysq(25);
			var_08 = 1;
		}

		if(!var_09)
		{
			level thread dofloaterzombie();
			var_09 = 1;
		}

		fillairlockwithwater();
		if(canplayercontinuestage4(var_0A) && var_0A maps\mp\_utility::isjuggernaut())
		{
			var_0A playergoliathsetwater(1);
			openairlockdoor(var_07);
			if(canplayercontinuestage4(var_0A) && var_0A maps\mp\_utility::isjuggernaut())
			{
				var_0B = waittillactivatedwatervalve(var_0A);
			}

			if(canplayercontinuestage4(var_0A) && var_0A maps\mp\_utility::isjuggernaut())
			{
				waittillplayerinairlock(var_0A,var_04,var_05,0);
			}

			closeairlockdoor(var_07);
		}
		else if(isdefined(var_0A) && isalive(var_0A))
		{
			var_0A maps\mp\gametypes\zombies::moversuicidecustom();
			wait(2);
		}

		emptywaterfromairlock();
		if(isdefined(var_0A) && isdefined(var_0A.underwatermotiontype))
		{
			var_0A playergoliathsetwater(0);
		}

		if(isdefined(var_0A) && isalive(var_0A))
		{
			openairlockdoor(var_06);
			if(isdefined(var_0A) && isalive(var_0A))
			{
				waittillplayernotinairlock(var_0A,var_03,var_05,1);
			}

			if(isdefined(var_0A))
			{
				var_0A.inairlock = 0;
			}

			closeairlockdoor(var_06);
		}

		level notify("main_stage4_stop_airlock_monitor");
		teleportoutplayersinairlock();
		wait 0.05;
		level.zmbbossteleportdelay = undefined;
		if(maps\mp\zombies\_util::is_true(var_0B))
		{
			break;
		}

		wait(2);
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage4");
}

//Function Number: 59
dofloaterzombie()
{
	var_00 = common_scripts\utility::getstruct("floater_anim_node","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = getent("sq_floater_blocker","targetname");
	if(!isdefined(var_00.angles))
	{
		var_00.angles = (0,0,0);
	}

	level.sqfloater = spawn("script_model",(0,0,0));
	level.sqfloater setmodel("zom_host_fullbody");
	level.sqfloater scriptmodelplayanimdeltamotionfrompos("zom_h2o_floater_enter",var_00.origin,var_00.angles,"floater_notetrack");
	level.sqfloater waittillmatch("end","floater_notetrack");
	level.sqfloater thread floaterzombiedetecthit();
	level.sqfloater scriptmodelplayanimdeltamotionfrompos("zom_h2o_floater_loop",var_00.origin,var_00.angles,"floater_notetrack",1);
	level.sqfloater common_scripts\utility::waittill_any_return_no_endon_death("hit_floater","main_stage4_over");
	level.sqfloater scriptmodelplayanimdeltamotionfrompos("zom_h2o_floater_exit",var_00.origin,var_00.angles,"floater_notetrack",1);
	if(isdefined(var_01))
	{
		var_01 delete();
	}

	level.sqfloater waittillmatch("end","floater_notetrack");
	level.sqfloater delete();
}

//Function Number: 60
floaterzombiedetecthit()
{
	var_00 = 6400;
	var_01 = 0.866;
	wait 0.05;
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(var_03 maps\mp\_utility::isjuggernaut() && var_03 ismeleeing())
			{
				var_04 = distance2dsquared(var_03.origin,self.origin);
				if(var_04 <= var_00)
				{
					var_05 = anglestoforward(var_03.angles);
					var_06 = self.origin - var_03.origin;
					var_06 = vectornormalize((var_06[0],var_06[1],0));
					var_07 = vectordot(var_05,var_06);
					if(var_07 >= var_01)
					{
						self notify("hit_floater");
						return;
					}
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 61
fillairlockwithwater()
{
	var_00 = getent("sqAirlockWater","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.emptypos))
	{
		var_00.emptypos = var_00.origin;
		var_00.filledpos = var_00.origin + (0,0,192);
	}

	thread maps\mp\mp_zombie_h2o_aud::sndfillwithwater();
	var_00 moveto(var_00.filledpos,2,0.1,0.1);
	wait(1.3);
}

//Function Number: 62
emptywaterfromairlock()
{
	var_00 = getent("sqAirlockWater","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	thread maps\mp\mp_zombie_h2o_aud::snddrainwater();
	var_00 moveto(var_00.emptypos,2,0.1,0.1);
	wait(1.3);
}

//Function Number: 63
playergoliathcleanupbubblesondisconnect(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	param_00.bubblesfx = undefined;
	self delete();
}

//Function Number: 64
playergoliathsetwater(param_00)
{
	if(param_00)
	{
		playergoliathhelmet();
		thread playerhandleunderwatershellshock();
		self.underwatermotiontype = "deep";
		maps\mp\zombies\_util::playerallowfire(0,"sq");
		common_scripts\utility::_disableoffhandweapons();
		self disableoffhandsecondaryweapons();
		self.oldmovescaler = self.movespeedscaler;
		self.movespeedscaler = self.movespeedscaler * 0.75;
		maps\mp\gametypes\_weapons::updatemovespeedscale();
		maps\mp\mp_zombie_h2o_aud::sndunderwaterenter(self);
		playfxontag(common_scripts\utility::getfx("sq_bubbles"),self,"j_shoulder_ri");
		self.bubblesfx = spawnfxforclient(common_scripts\utility::getfx("sq_bubbles_first_person"),self.origin,self);
		triggerfx(self.bubblesfx);
		self.bubblesfx thread playergoliathcleanupbubblesondisconnect(self);
		playfxontagforclients(common_scripts\utility::getfx("sq_plunge"),self,"tag_origin",self);
		return;
	}

	if(isalive(self))
	{
		playergoliathnohelmet();
	}

	maps\mp\zombies\_util::playerallowfire(1,"sq");
	self notify("main_stage4_stop_shellshock");
	self stopshellshock();
	self.underwatermotiontype = undefined;
	common_scripts\utility::_enableoffhandweapons();
	self enableoffhandsecondaryweapons();
	self.movespeedscaler = self.oldmovescaler;
	self.oldmovescaler = undefined;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	maps\mp\mp_zombie_h2o_aud::sndunderwaterexit(self);
	killfxontag(common_scripts\utility::getfx("sq_bubbles"),self,"j_shoulder_ri");
	if(isdefined(self.bubblesfx))
	{
		self.bubblesfx delete();
	}

	playfxontagforclients(common_scripts\utility::getfx("sq_emerge"),self,"tag_origin",self);
}

//Function Number: 65
playergoliathhelmet()
{
	self detachall();
	if(level.currentgen)
	{
		self attach("sentinel_udt_strike_head_a");
	}
	else
	{
		self attach("head_hero_cormack_sentinel_halo");
	}

	self attach("npc_exo_armor_minigun_handle","TAG_HANDLE");
}

//Function Number: 66
playergoliathnohelmet()
{
	self detachall();
	self attach(self.characterhead);
	self attach("npc_exo_armor_minigun_handle","TAG_HANDLE");
}

//Function Number: 67
playerhandleunderwatershellshock()
{
	self endon("main_stage4_stop_shellshock");
	self endon("disconnect");
	for(;;)
	{
		self shellshock("underwater",60,0,0);
		wait(59.5);
	}
}

//Function Number: 68
teleportoutplayersinairlock(param_00)
{
	if(isdefined(param_00) && !param_00 maps\mp\_utility::isjuggernaut())
	{
		param_00 = undefined;
	}

	foreach(var_02 in level.players)
	{
		if(isdefined(param_00) && param_00 == var_02)
		{
			continue;
		}

		if(maps\mp\zombies\_util::is_true(var_02.inairlock))
		{
			var_02 playerteleportoutofairlock();
		}
	}
}

//Function Number: 69
playerteleportoutofairlock()
{
	self setorigin(self.lastgroundposition);
	self.inairlock = undefined;
	self.disabletombstonedropinarea = undefined;
}

//Function Number: 70
monitorplayersinairlock(param_00,param_01)
{
	level endon("main_stage4_stop_airlock_monitor");
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(var_03 istouching(param_00) || var_03 istouching(param_01) || var_03 maps\mp\_utility::isjuggernaut() && isdefined(var_03.underwatermotiontype))
			{
				var_03.inairlock = 1;
				var_03.disabletombstonedropinarea = 1;
				continue;
			}

			var_03.inairlock = undefined;
			var_03.disabletombstonedropinarea = 1;
		}

		wait 0.05;
	}
}

//Function Number: 71
createairlockdoor(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	var_02 = var_01[0];
	var_02.closedpos = var_02.origin;
	var_02.openpos = var_02.origin + (0,0,100);
	var_01[1] vehicle_jetbikesethoverforcescale(var_02);
	param_00 vehicle_jetbikesethoverforcescale(var_02);
	return var_02;
}

//Function Number: 72
waittillactivatedwatervalve(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	var_01 = common_scripts\utility::getstruct("sqWaterValve","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = getent("sq_underwater_switch_off","targetname");
	var_03 = getent("sq_underwater_switch_on","targetname");
	var_01 maps\mp\zombies\_zombies_sidequests::fake_use("water_valve_used",undefined,undefined,"main_stage4_over");
	maps\mp\mp_zombie_h2o_aud::sndunderwaterpanelaccessed(var_01.origin);
	level thread announcerglobalplaysqvo(5,1);
	stopclientexploder(70);
	activateclientexploder(71);
	if(isdefined(var_02))
	{
		var_02 delete();
	}

	if(isdefined(var_03))
	{
		var_03 show();
	}

	return 1;
}

//Function Number: 73
canplayercontinuestage4(param_00)
{
	return isdefined(param_00) && isalive(param_00) && !maps\mp\zombies\_util::isplayerinlaststand(param_00);
}

//Function Number: 74
isplayerinairlock(param_00,param_01,param_02)
{
	return param_00 istouching(param_02) && !param_00 istouching(param_01);
}

//Function Number: 75
waittillplayernotinairlock(param_00,param_01,param_02,param_03)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("enter_last_stand");
	var_04 = gettime() + 10000;
	for(;;)
	{
		if(!param_00 istouching(param_02) && !param_00 istouching(param_01))
		{
			break;
		}

		if(param_03 && gettime() > var_04)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 76
waittillplayerinairlock(param_00,param_01,param_02,param_03)
{
	param_00 endon("disconnect");
	param_00 endon("ejectedFromJuggernaut");
	param_00 endon("death");
	param_00 endon("enter_last_stand");
	var_04 = gettime() + 5000;
	for(;;)
	{
		if(maps\mp\zombies\_util::is_true(level.zmbbosscountdowninprogress))
		{
			break;
		}

		if(isplayerinairlock(param_00,param_01,param_02))
		{
			break;
		}

		if(param_03 && gettime() > var_04)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 77
closeairlockdoor(param_00)
{
	playsoundatpos(param_00.origin,"trap_security_door_slam");
	param_00 moveto(param_00.closedpos,0.1,0.1);
	wait(0.2);
}

//Function Number: 78
openairlockdoor(param_00)
{
	playsoundatpos(param_00.origin,"interact_door");
	param_00 moveto(param_00.openpos,1);
	wait(2.1);
}

//Function Number: 79
activatedairlock(param_00)
{
	var_01 = getent("sqAirlockUseTrigger","targetname");
	var_02 = 40000;
	level thread doairlockhint(var_01);
	var_03 = undefined;
	for(;;)
	{
		var_01 waittill("trigger",var_03);
		if(var_03 maps\mp\_utility::isjuggernaut() && !maps\mp\zombies\_util::is_true(level.zmbbosscountdowninprogress))
		{
			break;
		}

		maps\mp\mp_zombie_h2o_aud::sndairlockdoorinteract(param_00.origin);
		wait(1);
	}

	level notify("main_stage4_airlock_activated");
	return var_03;
}

//Function Number: 80
doairlockhint(param_00)
{
	level endon("main_stage4_over");
	level endon("main_stage4_airlock_activated");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!var_01 maps\mp\_utility::isjuggernaut())
		{
			var_02 = var_01 playerplaysqvo(5);
			if(var_02)
			{
				return;
			}
		}

		wait(1);
	}
}

//Function Number: 81
stage4_end(param_00)
{
	level.zmbbossteleportdelay = undefined;
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Released the security clamp in the water");
}

//Function Number: 82
stage5_init()
{
}

//Function Number: 83
stage5_logic()
{
	level thread announcerozglobalplaysq(20);
	if(shoulddelayforbossround())
	{
		waituntilnextround();
	}

	waituntilnextround();
	level thread announcerozglobalplaysq(2);
	for(;;)
	{
		var_00 = 0;
		setomnvar("ui_zm_zone_identifier",1);
		while(var_00 < 5)
		{
			var_01 = donextdrone(var_00,5);
			if(var_01)
			{
				var_00++;
				continue;
			}

			setomnvar("ui_zm_zone_identifier",6);
			if(shoulddelayforbossround())
			{
				waituntilnextround();
			}

			waituntilnextround();
			break;
			wait(1);
		}

		level.sqplayedfindnextdronevo = undefined;
		if(var_00 == 5)
		{
			break;
		}
	}

	level thread announcerozglobalplaysq(16);
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage5");
}

//Function Number: 84
shoulddelayforbossround()
{
	var_00 = level.wavecounter + 1;
	if(level.zmbsqinbossintermission)
	{
		var_00 = level.wavecounter;
	}

	return maps\mp\mp_zombie_h2o::isbossround(var_00);
}

//Function Number: 85
waituntilnextround()
{
	level waittill("zombie_wave_started");
}

//Function Number: 86
donextdrone(param_00,param_01)
{
	var_02 = startsqdrone(param_00);
	if(!isdefined(var_02))
	{
		level thread announcerozglobalplaysq(17);
		if(isdefined(level.ammodrone2))
		{
			level.ammodrone2 notify("disabled");
			wait 0.05;
			level.ammodrone2 maps\mp\zombies\zombie_ammo_drone::droneexplode();
		}
	}
	else if(!var_02)
	{
		level thread announcerozglobalplaysqfailchallenge();
	}
	else if(param_00 + 1 < param_01)
	{
		if(!maps\mp\zombies\_util::is_true(level.sqplayedfindnextdronevo))
		{
			level thread announcerozglobalplaysq(23,1.5);
			level.sqplayedfindnextdronevo = 1;
		}
	}

	return maps\mp\zombies\_util::is_true(var_02);
}

//Function Number: 87
startsqdrone(param_00)
{
	level endon("zombie_wave_ended");
	var_01 = maps\mp\zombies\zombie_ammo_drone::getstartzone();
	var_02 = randomint(var_01.ammodronespawnnodes.size);
	var_03 = var_01.ammodronespawnnodes[var_02];
	if(isdefined(level.ammodrone))
	{
		if(var_03 == level.ammodrone.startnode)
		{
			if(var_02 == 0)
			{
				var_02++;
			}
			else
			{
				var_02--;
			}

			var_03 = var_01.ammodronespawnnodes[var_02];
		}
	}

	if(!isdefined(var_03))
	{
		return;
	}

	maps\mp\_utility::incrementfauxvehiclecount();
	level.ammodrone2 = maps\mp\zombies\zombie_ammo_drone::spawnammodrone(var_03.origin,(0,0,0));
	if(!isdefined(level.ammodrone2))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return;
	}

	level.ammodrone2.health = getdronehealth(param_00);
	level.ammodrone2.speedoverride = 8 + param_00;
	level.ammodrone2.startnode = var_03;
	level.ammodrone2.startzone = var_01;
	level.ammodrone2.linegunignore = 1;
	level.ammodrone2.skipplayervo = 1;
	var_04 = maps\mp\zombies\zombie_ammo_drone::waittillactivate(level.ammodrone2,var_01);
	if(isdefined(var_04))
	{
		var_04 playerplaysqfounddronevo();
	}

	var_05 = maps\mp\zombies\zombie_ammo_drone::getdestinationzone(var_01);
	var_06 = maps\mp\zombies\zombie_ammo_drone::getdestinationnode(var_05,var_03);
	level.ammodrone2.endnode = var_06;
	level.ammodrone2.endzone = var_05;
	level thread maps\mp\zombies\zombie_ammo_drone::droneactivate(level.ammodrone2,var_05,var_06,0);
	var_07 = waittilldronecomplete(level.ammodrone2);
	level.ammodrone2 = undefined;
	return maps\mp\zombies\_util::is_true(var_07);
}

//Function Number: 88
playerplaysqfounddronevo()
{
	var_00 = [7,8,9];
	playerplaysqvo(var_00[randomint(var_00.size)]);
}

//Function Number: 89
waittilldronecomplete(param_00)
{
	var_01 = param_00 common_scripts\utility::waittill_any_return("stopBeeping","disabled");
	if(var_01 == "disabled")
	{
		return 1;
	}

	return 0;
}

//Function Number: 90
getdronehealth(param_00)
{
	var_01 = 1;
	switch(param_00)
	{
		case 0:
			var_01 = 15;
			break;

		case 1:
			var_01 = 18.75;
			break;

		case 2:
			var_01 = 22.5;
			break;

		case 3:
			var_01 = 26.25;
			break;

		case 4:
		default:
			var_01 = 30;
			break;
	}

	var_02 = 2;
	if(level.players.size > 2)
	{
		var_02 = 3;
	}

	var_03 = int(1500 + var_01 * 200 * var_02);
	return var_03;
}

//Function Number: 91
createchallengehud(param_00)
{
	var_01 = newteamhudelem(level.playerteam);
	var_01.foreground = 1;
	var_01.sort = 2;
	var_01.hidewheninmenu = 0;
	var_01.alignx = "left";
	var_01.aligny = "bottom";
	var_01.horzalign = "left";
	var_01.vertalign = "bottom";
	var_01.font = "small";
	var_01.fontscale = 1.5;
	var_01.x = 120;
	var_01.y = -70;
	var_01.alpha = 1;
	var_01.color = (1,0,0);
	var_01 settext(param_00);
	return var_01;
}

//Function Number: 92
stage5_end(param_00)
{
	level thread dochallengehudcomplete();
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 1 - Drones");
}

//Function Number: 93
dochallengehudactive()
{
	level.zmbsqchallengehud.color = (1,0,0);
}

//Function Number: 94
dochallengehudinactive()
{
	level.zmbsqchallengehud.color = (0.5,0.5,0.5);
}

//Function Number: 95
dochallengehudcomplete()
{
	setomnvar("ui_zm_zone_identifier",7);
}

//Function Number: 96
stage7_init()
{
}

//Function Number: 97
stage7_logic()
{
	var_00 = getent("sqCapacitorCover","targetname");
	var_01 = common_scripts\utility::getstruct("sqCapacitors","targetname");
	var_02 = common_scripts\utility::getstruct("sqCapacitorFx","targetname");
	var_03 = getentarray("sqCapacitorMeter","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	level thread launchcover(var_00,var_01);
	runchargecapacitorlogic(var_01,var_02,var_03);
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage7");
}

//Function Number: 98
initcapacitors()
{
	var_00 = getentarray("sqCapacitorMeter","targetname");
	common_scripts\utility::array_thread(var_00,::capacitormetersinit);
}

//Function Number: 99
capacitormetersinit()
{
	var_00 = common_scripts\utility::getstructarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		switch(var_02.script_noteworthy)
		{
			case "end":
				self.end = var_02.origin;
				break;

			case "start":
				self.origin = var_02.origin;
				break;

			default:
				break;
		}
	}

	self.start = self.origin;
}

//Function Number: 100
launchcover(param_00,param_01)
{
	var_02 = anglestoforward(param_01.angles) * 2000;
	param_00 physicslaunchclient(param_00.origin,var_02);
	playfx(common_scripts\utility::getfx("sq_capacitor_cover_blown_off"),param_01.origin);
	maps\mp\mp_zombie_h2o_aud::sndcapacitorcoverblownoff(param_01.origin);
	param_00 common_scripts\utility::waittill_notify_or_timeout("physics_finished",4);
	param_00 physicsstop();
	wait(20);
	param_00 delete();
}

//Function Number: 101
runchargecapacitorlogic(param_00,param_01,param_02)
{
	var_03 = 32400;
	var_04 = 15;
	var_05 = 0;
	activatepersistentclientexploder(85);
	while(var_04 > 0)
	{
		level waittill("zmb_emz_attack",var_06,var_07,var_08);
		var_09 = distancesquared(var_07,param_00.origin);
		if(var_09 < var_03)
		{
			playfx(common_scripts\utility::getfx("sq_emz_explode"),var_06.origin + (0,0,30));
			activateclientexploder(51);
			if(isalive(var_06))
			{
				if(isscriptedagent(var_06) && !var_06 maps\mp\agents\humanoid\_humanoid_util::iscrawling() && isdefined(var_06.agent_type) && var_06.agent_type != "zombie_dog")
				{
					level thread electrocutezombie(var_06,param_00);
				}
				else
				{
					var_06 dodamage(var_06.health,var_06.origin);
				}
			}

			if(!var_05)
			{
				var_05 = 1;
				level thread announcerglobalplaysqvowaittilldone(14,1.5);
			}

			var_04--;
			thread maps\mp\mp_zombie_h2o_aud::sndcapacitorcharging(15 - var_04);
			foreach(var_0B in param_02)
			{
				var_0C = 15 - var_04 / 15;
				var_0D = var_0B.end - var_0B.start * var_0C + var_0B.start;
				var_0B moveto(var_0D,0.1);
			}
		}
	}

	wait(1);
	stopclientexploder(85);
	activateclientexploder(50);
	thread maps\mp\mp_zombie_h2o_aud::sndcapacitorchargedsuccess(param_01);
	announcerglobalplaysqvowaittilldone(15,1);
	announcerglobalplaysqvowaittilldone(6,0.5);
}

//Function Number: 102
electrocutezombie(param_00,param_01)
{
	param_00 endon("death");
	param_00 scragentsetanimmode("anim deltas");
	param_00 scragentsetanimscale(1,1);
	param_00 scragentsetphysicsmode("no_gravity");
	param_00 scragentsetorientmode("face angle abs",param_00.angles);
	var_02 = "sq_electrocute";
	var_03 = param_00 getanimentrycount(var_02);
	var_04 = angleclamp180(param_00.angles[1] - param_01.angles[1]);
	var_05 = 1;
	if(abs(var_04) < 45)
	{
		var_05 = 0;
	}
	else if(var_04 > -135 && var_04 < 0)
	{
		var_05 = 3;
	}
	else if(var_04 < 135 && var_04 > 0)
	{
		var_05 = 2;
	}

	param_00.skipmutilate = 1;
	param_00.ragdollimmediately = 1;
	param_00.godmode = 1;
	if(isdefined(param_00.swapbody))
	{
		param_00 setmodel(param_00.swapbody);
	}

	param_00 notify("humanoidPendingDeath");
	param_00 scragentsetscripted(1);
	param_00 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"sq_electrocute");
	param_00 thread maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_02,var_05,1,"scripted_anim");
	wait(1.5);
	param_00.godmode = 0;
	param_00 dodamage(param_00.health,param_00.origin);
}

//Function Number: 103
stage7_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Capacitors charged");
}

//Function Number: 104
stage8_init()
{
}

//Function Number: 105
stage8_logic()
{
	level thread announcerozglobalplaysq(21);
	if(shoulddelayforbossround())
	{
		waituntilnextround();
	}

	waituntilnextround();
	level thread playstage8startvo();
	setomnvar("ui_zm_zone_identifier",2);
	foreach(var_01 in level.players)
	{
		var_01 thread playerhandleweaponsstage8();
	}

	level thread onplayerconnectstage8();
	level thread handlefeaturesstage8();
	waituntilnextround();
	var_03 = getteamplayersalive(level.playerteam);
	if(var_03 > 0)
	{
		maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage8");
	}
}

//Function Number: 106
playstage8startvo()
{
	announcerozglobalplaysqwaittilldone(11);
	getanyplayer(1) playerplaysqvo(11);
}

//Function Number: 107
handlefeaturesstage8()
{
	maps\mp\zombies\_util::disablekillstreaks();
	maps\mp\zombies\_util::disablepickups();
	maps\mp\zombies\_util::disablewallbuys();
	maps\mp\zombies\_traps::trap_deactivate_all();
	setomnvar("ui_zm_ee_int2",2);
	level waittill("main_stage8_over");
	setomnvar("ui_zm_ee_int2",0);
	maps\mp\zombies\_util::enablekillstreaks();
	maps\mp\zombies\_util::enablepickups();
	maps\mp\zombies\_util::enablewallbuys();
	maps\mp\zombies\_traps::trap_reactivate_all();
}

//Function Number: 108
playerhandleweaponsstage8()
{
	self endon("disconnect");
	if(maps\mp\_utility::isjuggernaut())
	{
		self dodamage(self.mechhealth,self.origin);
		wait(1);
	}

	self notify("stop_useHoldThinkLoop");
	removeweaponsstage8();
	thread playerinfinitegrenadesstage8();
	waituntilnextround();
	if(!isalive(self) || maps\mp\zombies\_util::isplayerinlaststand(self))
	{
		return;
	}

	restoreweaponsstage8();
}

//Function Number: 109
playerinfinitegrenadesstage8()
{
	level endon("main_stage8_over");
	var_00 = self getweaponslistoffhands();
	foreach(var_02 in var_00)
	{
		var_03 = weaponmaxammo(var_02);
		self setweaponammoclip(var_02,var_03);
	}

	for(;;)
	{
		self waittill("grenade_fire",var_05,var_02);
		var_03 = weaponmaxammo(var_02);
		self setweaponammoclip(var_02,var_03);
	}
}

//Function Number: 110
onplayerconnectstage8()
{
	level endon("main_stage8_over");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawnedstage8();
	}
}

//Function Number: 111
onplayerspawnedstage8()
{
	level endon("main_stage8_over");
	self waittill("spawned_player");
	thread playerhandleweaponsstage8();
}

//Function Number: 112
removeweaponsstage8()
{
	playergivecontactgrenade();
	maps\mp\zombies\_util::playerallowfire(0,"sq");
	self disableoffhandsecondaryweapons();
	common_scripts\utility::_disableweaponswitch();
}

//Function Number: 113
playergivecontactgrenade()
{
	var_00 = playergetcontactgrenade();
	if(isdefined(var_00))
	{
		self.hadcontactgrenade = 1;
		return;
	}

	self.hadcontactgrenade = 0;
	maps\mp\zombies\_wall_buys::givezombieequipment(self,"contact_grenade_zombies_mp",0);
}

//Function Number: 114
playergetcontactgrenade()
{
	var_00 = self getweaponslistoffhands();
	foreach(var_02 in var_00)
	{
		var_03 = getweaponbasename(var_02);
		if(var_03 == "contact_grenade_zombies_mp" || var_03 == "contact_grenade_throw_zombies_mp")
		{
			return var_02;
		}
	}
}

//Function Number: 115
playertakecontactgrenade()
{
	if(!self.hadcontactgrenade)
	{
		maps\mp\zombies\_wall_buys::givezombieequipment(self,"frag_grenade_zombies_mp",0);
	}

	self.hadcontactgrenade = undefined;
}

//Function Number: 116
isweaponswitchenabled_duplicate()
{
	return !self.disabledweaponswitch;
}

//Function Number: 117
restoreweaponsstage8()
{
	playertakecontactgrenade();
	maps\mp\zombies\_util::playerallowfire(1,"sq");
	self enableoffhandsecondaryweapons();
	if(!isweaponswitchenabled_duplicate())
	{
		common_scripts\utility::_enableweaponswitch();
	}
}

//Function Number: 118
stage8_end(param_00)
{
	level thread dochallengehudcomplete();
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 2 - Grenades");
}

//Function Number: 119
stage9_init()
{
	if(!level.jumpquest.init)
	{
		return;
	}

	jumpquest_setstage(1);
}

//Function Number: 120
stage9_logic()
{
	if(level.jumpquest.init)
	{
		common_scripts\utility::flag_wait("jumpQuest_final_stage_complete");
		maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage9");
	}
}

//Function Number: 121
stage9_end(param_00)
{
	if(level.jumpquest.init)
	{
		jumpquest_setstage(0);
		level thread announcerglobalplaysqvo(6,0.5);
	}

	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed jumping puzzle");
}

//Function Number: 122
jumpquest_init()
{
	level.jumpquest = spawnstruct();
	level.jumpquest.init = 0;
	common_scripts\utility::flag_init("jumpQuest_final_stage_complete");
	level.jumpquest.refloc = common_scripts\utility::getstruct("jumpQuest_ref","targetname");
	if(!isdefined(level.jumpquest.refloc))
	{
		return;
	}

	jumpquest_initgoal();
	jumpquest_initplatforms();
	jumpquest_initstages();
	jumpquest_initreset();
	jumpquest_initfx();
	level.jumpquest.init = 1;
	jumpquest_arrangeplatforms("default",0);
	level thread jumpquest_run();
}

//Function Number: 123
jumpquest_initgoal()
{
	level.jumpquest.goal = getent("jumpQuest_goal","targetname");
	level.jumpquest.goal.angles = common_scripts\utility::getstruct(level.jumpquest.goal.target,"targetname").angles;
}

//Function Number: 124
jumpquest_initreset()
{
	level.jumpquest.resetlocs = common_scripts\utility::getstructarray("jumpQuest_reset_loc","targetname");
	var_00 = getentarray("jumpQuest_reset_trigger","targetname");
	foreach(var_02 in var_00)
	{
		level.jumpquest thread jumpquest_reset(var_02);
	}

	var_04 = getentarray("jumpQuest_reset_clip","targetname");
	foreach(var_06 in var_04)
	{
		level.jumpquest thread jumpquest_reset_clip(var_06);
	}
}

//Function Number: 125
jumpquest_initfx()
{
	level._effect["jump_quest_goal"] = loadfx("vfx/map/mp_zombie_h2o/h2o_ee_jumping_goal");
}

//Function Number: 126
jumpquest_initplatforms()
{
	level.jumpquest.platformstandtime = 3;
	level.jumpquest.platformresettime = 3;
	level.jumpquest.platforms = getentarray("jumpQuest_platform","targetname");
	foreach(var_01 in level.jumpquest.platforms)
	{
		var_01.noteleportgrenade = 1;
		var_01.unresolved_collision_func = ::jumpquestunresolvedcollision;
		var_01.visuals = getentarray(var_01.target,"targetname");
		foreach(var_03 in var_01.visuals)
		{
			var_03 linkto(var_01);
			var_03.noteleportgrenade = 1;
		}

		var_01.fxtype = "sm";
		if(issubstr(var_01.script_noteworthy,"medium"))
		{
			var_01.fxtype = "med";
		}
		else if(issubstr(var_01.script_noteworthy,"large"))
		{
			var_01.fxtype = "large";
		}

		var_01.angles = common_scripts\utility::getstruct(var_01.target,"targetname").angles;
		var_01 thread jumpquest_platformwatch();
	}
}

//Function Number: 127
jumpquest_platformplayertouch()
{
	level.jumpquest endon("reset");
	if(self.visuals.size > 0)
	{
		var_00 = level.jumpquest.platformstandtime / 3;
		foreach(var_02 in self.visuals)
		{
			var_02 hudoutlineenable(1,1);
		}

		wait(var_00);
		foreach(var_02 in self.visuals)
		{
			var_02 hudoutlineenable(4,1);
		}

		wait(var_00);
		foreach(var_02 in self.visuals)
		{
			var_02 hudoutlineenable(0,1);
		}

		wait(var_00);
	}
	else
	{
		wait(level.jumpquest.platformstandtime);
	}

	self notsolid();
	self ghost();
	foreach(var_02 in self.visuals)
	{
		var_02 ghost();
	}

	wait(level.jumpquest.platformresettime);
	while(!jumpquest_allplayersoffplatforms())
	{
		wait 0.05;
	}
}

//Function Number: 128
jumpquest_platformwatch()
{
	for(;;)
	{
		while(!jumpquest_anyplayeronplatform(self))
		{
			wait 0.05;
		}

		jumpquest_platformplayertouch();
		self solid();
		self show();
		foreach(var_01 in self.visuals)
		{
			var_01 hudoutlinedisable();
			var_01 show();
		}
	}
}

//Function Number: 129
jumpquest_allplayersoffplatforms()
{
	foreach(var_01 in level.players)
	{
		if(!maps\mp\_utility::isreallyalive(var_01))
		{
			continue;
		}

		var_02 = var_01 getgroundentity();
		if(!isdefined(var_02))
		{
			return 0;
		}

		foreach(var_04 in level.jumpquest.platforms)
		{
			if(var_04 == var_02)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 130
jumpquest_anyplayeronplatform(param_00)
{
	if(!isdefined(level.players))
	{
		return 0;
	}

	foreach(var_02 in level.players)
	{
		if(!maps\mp\_utility::isreallyalive(var_02))
		{
			continue;
		}

		var_03 = var_02 getgroundentity();
		if(isdefined(var_03) && var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 131
jumpquest_moveplatform(param_00,param_01,param_02)
{
	param_00 notify("move");
	param_00 endon("move");
	var_03 = (0,0,-800);
	var_04 = 0;
	var_05 = param_01.origin;
	if(var_05 != param_00.origin)
	{
		var_06 = trajectorycalculateinitialvelocity(param_00.origin,var_05,var_03,param_02);
		param_00 movegravity(var_06,param_02);
		var_04 = 1;
	}

	var_07 = param_01.angles;
	if(anglesdelta(var_07,param_00.angles) > 0 || var_04)
	{
		var_08 = randomintrange(-2,2) * 360 + angleclamp180(var_07[0] - param_00.angles[0]);
		var_09 = randomintrange(-2,2) * 360 + angleclamp180(var_07[1] - param_00.angles[1]);
		var_0A = randomintrange(-2,2) * 360 + angleclamp180(var_07[2] - param_00.angles[2]);
		var_0B = 2 * (var_08,var_09,var_0A) / param_02;
		param_00 rotatevelocity(var_0B,param_02,0,param_02);
		var_04 = 1;
	}

	if(!var_04)
	{
		return;
	}

	level thread jumpquest_platformsplash(param_00);
	wait(param_02);
	maps\mp\mp_zombie_h2o_aud::sndjumpingpuzzleplatformlock(param_01.origin);
	jumpquest_setplatform(param_00,param_01);
}

//Function Number: 132
jumpquest_setplatform(param_00,param_01)
{
	param_00.origin = param_01.origin;
	param_00.angles = param_01.angles;
}

//Function Number: 133
jumpquest_platformsplash(param_00)
{
	var_01 = 680;
	if(param_00.origin[2] < var_01)
	{
		while(param_00.origin[2] < var_01)
		{
			wait 0.05;
		}
	}
	else
	{
		while(param_00.origin[2] > var_01)
		{
			wait 0.05;
		}
	}

	var_02 = "h2o_ee_wave_hit_" + param_00.fxtype;
	var_03 = (param_00.origin[0],param_00.origin[1],var_01);
	playfx(common_scripts\utility::getfx(var_02),var_03);
}

//Function Number: 134
jumpquest_initstages()
{
	level.jumpquest.stages = [];
	jumpquest_initstage("default",(2308,0,-104),(0,0,0));
	jumpquest_initstageplatform("default","small_01",(2308,0,-140),(0,0,0));
	jumpquest_initstageplatform("default","small_02",(2308,0,-140),(0,0,0));
	jumpquest_initstageplatform("default","small_03",(2308,0,-140),(0,0,0));
	jumpquest_initstageplatform("default","medium_01",(2308,0,-140),(0,0,0));
	jumpquest_initstageplatform("default","medium_02",(2308,0,-140),(0,0,0));
	jumpquest_initstageplatform("default","medium_03",(2308,0,-140),(0,0,0));
	jumpquest_initstageplatform("default","large_01",(2308,0,-140),(0,0,0));
	jumpquest_initstageplatform("default","large_02",(2308,0,-140),(0,0,0));
	jumpquest_initstageplatform("default","large_03",(2308,0,-140),(0,0,0));
	jumpquest_initstage("stage_1",(480,0,8),(0,0,0));
	jumpquest_initstageplatform("stage_1","medium_01",(96,0,0),(0,0,0));
	jumpquest_initstageplatform("stage_1","medium_02",(480,0,0),(0,0,0));
	jumpquest_initstage("stage_2",(1088,0,8),(0,0,0));
	jumpquest_initstageplatform("stage_2","medium_01",(96,0,0),(0,0,0));
	jumpquest_initstageplatform("stage_2","small_01",(592,0,0),(0,0,0));
	jumpquest_initstageplatform("stage_2","medium_02",(1088,0,0),(0,0,0));
	jumpquest_initstage("stage_3",(1088,0,8),(0,0,0));
	jumpquest_initstageplatform("stage_3","medium_01",(96,0,0),(0,0,0));
	jumpquest_initstageplatform("stage_3","medium_02",(1088,0,0),(0,0,0));
	jumpquest_initstage("stage_4",(408,0,16),(0,0,0));
	jumpquest_initstageplatform("stage_4","medium_01",(196,0,8),(0,0,0));
	jumpquest_initstageplatform("stage_4","large_01",(300,0,192),(0,270,90));
	jumpquest_initstageplatform("stage_4","medium_02",(404,0,8),(0,0,0));
	jumpquest_initstage("stage_5",(1120,0,784),(0,0,0));
	jumpquest_initstageplatform("stage_5","medium_01",(96,0,8),(0,0,0));
	jumpquest_initstageplatform("stage_5","small_01",(384,64,200),(0,0,0));
	jumpquest_initstageplatform("stage_5","small_02",(608,-64,392),(0,0,0));
	jumpquest_initstageplatform("stage_5","small_03",(832,64,584),(0,0,0));
	jumpquest_initstageplatform("stage_5","medium_02",(1120,0,776),(0,0,0));
	jumpquest_initstage("stage_6",(1556,0,16),(0,0,0));
	jumpquest_initstageplatform("stage_6","medium_01",(96,0,8),(0,0,0));
	jumpquest_initstageplatform("stage_6","small_01",(160,0,208),(0,0,0));
	jumpquest_initstageplatform("stage_6","small_02",(160,0,408),(0,0,0));
	jumpquest_initstageplatform("stage_6","small_03",(160,0,608),(0,0,0));
	jumpquest_initstageplatform("stage_6","large_01",(544,0,800),(0,0,0));
	jumpquest_initstageplatform("stage_6","medium_02",(1556,0,8),(0,0,0));
	jumpquest_initstage("stage_7",(928,0,16),(0,0,0));
	jumpquest_initstageplatform("stage_7","medium_01",(96,0,8),(0,0,0));
	jumpquest_initstageplatform("stage_7","small_01",(928,0,8),(0,0,0));
	jumpquest_initstageplatform("stage_7","large_01",(768,-30,192),(0,0,90));
	jumpquest_initstageplatform("stage_7","large_02",(768,30,192),(0,0,90));
	jumpquest_initstage("stage_8",(1792,0,66),(0,0,0));
	jumpquest_initstageplatform("stage_8","large_01",(192,0,-102),(0,0,90));
	jumpquest_initstageplatform("stage_8","large_02",(724,-30,46),(0,0,90));
	jumpquest_initstageplatform("stage_8","large_03",(1308,30,-62),(0,0,90));
	jumpquest_initstageplatform("stage_8","medium_01",(724,-30,334),(0,0,90));
	jumpquest_initstageplatform("stage_8","medium_02",(1792,0,58),(0,0,0));
	jumpquest_initstageplatform("stage_8","small_01",(724,-30,462),(0,0,90));
	jumpquest_initstageplatform("stage_8","small_02",(1216,30,162),(0,0,90));
	jumpquest_initstageplatform("stage_8","small_03",(1420,30,162),(0,0,90));
	jumpquest_initstage("stage_9",(192,0,976),(0,0,0));
	jumpquest_initstageplatform("stage_9","large_01",(192,0,8),(0,0,0));
	jumpquest_initstageplatform("stage_9","small_01",(192,0,200),(0,0,0));
	jumpquest_initstageplatform("stage_9","medium_01",(192,0,392),(0,0,0));
	jumpquest_initstageplatform("stage_9","large_02",(192,0,584),(0,0,0));
	jumpquest_initstageplatform("stage_9","medium_02",(192,0,776),(0,0,0));
	jumpquest_initstageplatform("stage_9","small_02",(192,0,968),(0,0,0));
	level.jumpquest.stageorder = ["stage_1","stage_2","stage_3","stage_4","stage_5","stage_6","stage_7","stage_8","stage_9"];
	jumpquest_setstage(0);
}

//Function Number: 135
jumpquest_arrangeplatforms(param_00,param_01)
{
	level.jumpquest notify("setStage");
	level.jumpquest endon("setStage");
	var_02 = level.jumpquest.stages[param_00];
	var_03 = level.jumpquest.stages["default"];
	var_04 = -1;
	foreach(var_06 in level.jumpquest.platforms)
	{
		var_07 = var_06.script_noteworthy;
		var_08 = var_02.platforms[var_07];
		if(!isdefined(var_08))
		{
			var_08 = var_03.platforms[var_07];
		}

		var_09 = distance(var_06.origin,var_08.origin);
		if(var_09 > var_04)
		{
			var_04 = var_09;
		}

		var_06.arrangeloc = var_08;
		var_06.arrangedist = var_09;
	}

	foreach(var_06 in level.jumpquest.platforms)
	{
		if(var_04 <= 0)
		{
			var_0C = param_01;
		}
		else
		{
			var_0C = var_06.arrangedist / var_04 * param_01;
		}

		if(var_0C > 0)
		{
			thread jumpquest_moveplatform(var_06,var_06.arrangeloc,var_0C);
			continue;
		}

		thread jumpquest_setplatform(var_06,var_06.arrangeloc);
	}

	level thread maps\mp\mp_zombie_h2o_aud::sndjumpingpuzzleplatformwhoosh();
	level.jumpquest.goal.origin = var_02.goal.origin + (0,0,40);
	level.jumpquest.goal.angles = var_02.goal.angles;
}

//Function Number: 136
jumpquest_run()
{
	var_00 = 3;
	for(;;)
	{
		while(level.jumpquest.stagecurrent <= 0)
		{
			level.jumpquest waittill("stage_change");
		}

		var_01 = level.jumpquest.stageorder[level.jumpquest.stagecurrent - 1];
		jumpquest_arrangeplatforms(var_01,var_00);
		wait(var_00 + 0.05);
		var_02 = spawnfx(common_scripts\utility::getfx("jump_quest_goal"),level.jumpquest.goal.origin,anglestoup(level.jumpquest.goal.angles),anglestoright(level.jumpquest.goal.angles));
		triggerfx(var_02);
		setfxkillondelete(var_02,1);
		var_03 = jumpquest_waitforgoal();
		if(isdefined(var_03))
		{
			thread maps\mp\mp_zombie_h2o_aud::sndjumpingpuzzlesucess(var_03);
			jumpquest_setstage(level.jumpquest.stagecurrent + 1);
			if(common_scripts\utility::flag("jumpQuest_final_stage_complete"))
			{
				var_03 thread playerplaysqvo(10);
			}
			else
			{
				var_03 thread playerplaysqvo(undefined,1,0,"sq_jump_win");
			}

			jumpquest_resetplayer(var_03,0);
		}

		var_02 delete();
		level.jumpquest notify("reset");
		jumpquest_arrangeplatforms("default",var_00);
		wait(var_00 + 0.05);
		wait(1);
	}
}

//Function Number: 137
jumpquest_setstage(param_00)
{
	if(!isdefined(level.jumpquest.stagecurrent) || level.jumpquest.stagecurrent != param_00)
	{
		level.jumpquest.stagecurrent = param_00;
		if(level.jumpquest.stagecurrent > level.jumpquest.stageorder.size)
		{
			level.jumpquest.stagecurrent = 0;
			common_scripts\utility::flag_set("jumpQuest_final_stage_complete");
		}

		level.jumpquest notify("stage_change");
	}
}

//Function Number: 138
jumpquest_initstage(param_00,param_01,param_02)
{
	level.jumpquest.stages[param_00] = spawnstruct();
	level.jumpquest.stages[param_00].platforms = [];
	level.jumpquest.stages[param_00].goal = jumpquest_createloc(param_01,param_02,level.jumpquest.refloc);
}

//Function Number: 139
jumpquest_initstageplatform(param_00,param_01,param_02,param_03)
{
	var_04 = jumpquest_createloc(param_02,param_03,level.jumpquest.refloc,param_00);
	level.jumpquest.stages[param_00].platforms[param_01] = var_04;
}

//Function Number: 140
jumpquest_createloc(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.origin = param_00;
	if(isdefined(param_02))
	{
		var_04.origin = rotatevector(var_04.origin,param_02.angles) + param_02.origin;
	}

	var_04.angles = param_01;
	if(isdefined(param_02))
	{
		var_04.angles = var_04.angles + param_02.angles;
	}

	var_04.stagename = param_03;
	return var_04;
}

//Function Number: 141
jumpquest_waitforgoal()
{
	level.jumpquest endon("stage_change");
	for(;;)
	{
		level.jumpquest.goal waittill("trigger",var_00);
		return var_00;
	}
}

//Function Number: 142
jumpquest_reset_clip(param_00)
{
	var_01 = param_00 setcontents(0);
	for(;;)
	{
		if(level.jumpquest.stagecurrent <= 0)
		{
			param_00 notsolid();
		}
		else
		{
			param_00 solid();
			param_00 setcontents(var_01);
		}

		level.jumpquest waittill("stage_change");
	}
}

//Function Number: 143
jumpquest_reset(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(level.jumpquest.stagecurrent > 0)
		{
			jumpquest_resetplayer(var_01,1);
		}
	}
}

//Function Number: 144
jumpquest_resetplayer(param_00,param_01)
{
	if(param_01)
	{
		if(!maps\mp\zombies\_util::is_true(level.zmbsqplayedjumpfailvo))
		{
			level.zmbsqplayedjumpfailvo = 1;
			level thread announcerozglobalplaysq(26);
		}
		else
		{
			param_00 thread playerplaysqvo(undefined,1,0,"sq_jump_fail");
		}
	}

	thread jumpquest_bounceresetplayer(param_00);
}

//Function Number: 145
jumpquest_bounceresetplayer(param_00)
{
	if(param_00 islinked())
	{
		return;
	}

	param_00 thread maps\mp\mp_zombie_h2o_aud::sndjumpingpuzzleplayerwhoosh();
	var_01 = jumpquest_getresetloc(param_00);
	var_02 = distance2d(param_00.origin,var_01.origin);
	var_03 = clamp(var_02 / 1500,0,1) * 1.5 + 1;
	var_04 = trajectorycalculateinitialvelocity(param_00.origin,var_01.origin,(0,0,-800),var_03);
	var_05 = spawn("script_model",param_00.origin);
	var_05 setmodel("tag_origin");
	param_00 playerlinkto(var_05,"tag_origin");
	var_05 movegravity(var_04,var_03);
	wait(var_03);
	var_05.origin = var_01.origin;
	wait 0.05;
	if(isdefined(param_00))
	{
		param_00 unlink();
	}

	var_05 delete();
}

//Function Number: 146
jumpquest_getresetloc(param_00)
{
	level.jumpquest.resetlocs = sortbydistance(level.jumpquest.resetlocs,param_00.origin);
	var_01 = undefined;
	var_02 = 0;
	foreach(var_04 in level.jumpquest.resetlocs)
	{
		var_05 = 0;
		foreach(var_07 in level.characters)
		{
			if(var_07.team == param_00.team)
			{
				continue;
			}

			var_08 = distance2d(var_04.origin,var_07.origin);
			if(var_08 < 100)
			{
				var_05++;
			}
		}

		if(!isdefined(var_01) || var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 147
jumpquestunresolvedcollision(param_00)
{
	jumpquest_resetplayer(param_00,1);
}

//Function Number: 148
stage14_init()
{
}

//Function Number: 149
stage14_logic()
{
	level thread announcerozglobalplaysq(20);
	if(shoulddelayforbossround())
	{
		waituntilnextround();
	}

	waituntilnextround();
	level thread playstage14startvo();
	setomnvar("ui_zm_zone_identifier",5);
	foreach(var_01 in level.players)
	{
		var_01 thread playerhandleweaponsstage14();
	}

	level thread onplayerconnectstage14();
	level thread handlefeaturesstage14();
	waituntilnextround();
	var_03 = getteamplayersalive(level.playerteam);
	if(var_03 > 0)
	{
		maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage14");
	}
}

//Function Number: 150
playstage14startvo()
{
	announcerozglobalplaysqwaittilldone(12);
	getanyplayer(1) playerplaysqvo(12);
}

//Function Number: 151
handlefeaturesstage14()
{
	maps\mp\zombies\_util::disablekillstreaks();
	maps\mp\zombies\_util::disablepickups();
	maps\mp\zombies\_util::disablewallbuys();
	level.dotombstoneweaponswitch = 0;
	level.customreplaceweaponfunc = ::stage14customreplaceweaponfunc;
	maps\mp\zombies\_traps::trap_deactivate_all();
	setomnvar("ui_zm_ee_int2",1);
	level waittill("main_stage14_over");
	setomnvar("ui_zm_ee_int2",0);
	maps\mp\zombies\_util::enablekillstreaks();
	maps\mp\zombies\_util::enablepickups();
	maps\mp\zombies\_util::enablewallbuys();
	level.dotombstoneweaponswitch = undefined;
	level.customreplaceweaponfunc = undefined;
	maps\mp\zombies\_traps::trap_reactivate_all();
}

//Function Number: 152
stage14customreplaceweaponfunc(param_00)
{
	var_01 = param_00 getweaponslistprimaries();
	if(var_01.size > 2)
	{
		var_02 = param_00 playergetmahem();
		if(var_01[0] != var_02)
		{
			return var_01[0];
		}

		foreach(var_04 in var_01)
		{
			if(var_04 != var_02)
			{
				return var_04;
			}
		}
	}

	return "none";
}

//Function Number: 153
playerhandleweaponsstage14()
{
	self endon("disconnect");
	if(maps\mp\_utility::isjuggernaut())
	{
		self dodamage(self.mechhealth,self.origin);
		wait(1);
	}

	self notify("stop_useHoldThinkLoop");
	var_00 = playerwaittilllaststandcomplete();
	if(maps\mp\zombies\_util::is_true(var_00) && isalive(self))
	{
		removeweaponsstage14();
		thread playerinfiniterocketsstage14();
		waituntilnextround();
		if(!isalive(self) || maps\mp\zombies\_util::isplayerinlaststand(self))
		{
			return;
		}

		restoreweaponsstage14();
	}
}

//Function Number: 154
playerwaittilllaststandcomplete()
{
	if(maps\mp\zombies\_util::isplayerinlaststand(self))
	{
		self endon("death");
		level endon("zombie_wave_started");
		self waittill("revive");
		wait 0.05;
	}

	return 1;
}

//Function Number: 155
playerinfiniterocketsstage14()
{
	level endon("main_stage14_over");
	var_00 = playergetmahem();
	var_01 = weaponmaxammo(var_00);
	for(;;)
	{
		self waittill("reload");
		self setweaponammostock(var_00,var_01);
	}
}

//Function Number: 156
onplayerconnectstage14()
{
	level endon("main_stage14_over");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawnedstage14();
	}
}

//Function Number: 157
onplayerspawnedstage14()
{
	level endon("main_stage14_over");
	self waittill("spawned_player");
	thread playerhandleweaponsstage14();
}

//Function Number: 158
removeweaponsstage14()
{
	playergivemahem();
	common_scripts\utility::_disableoffhandweapons();
	self disableoffhandsecondaryweapons();
	common_scripts\utility::_disableweaponswitch();
}

//Function Number: 159
playergivemahem()
{
	maps\mp\zombies\_zombies_laststand::savelaststandweapons("",0);
	self.scriptedtombstoneweapon = self.tombstoneweapon;
	self.scriptedtombstoneweaponlevel = self.tombstoneweaponlevel;
	var_00 = playergetmahem();
	if(isdefined(var_00))
	{
		self.hadmahem = 1;
		self switchtoweapon(var_00);
		if(isdefined(self.weaponstate["iw5_mahemzm_mp"]["level"]) && self.weaponstate["iw5_mahemzm_mp"]["level"] < 10)
		{
			self.oldmahemweaponlevel = self.weaponstate["iw5_mahemzm_mp"]["level"];
			setweaponlevelallowthird(self,var_00,10);
			return;
		}

		return;
	}

	self.hadmahem = 0;
	givezombieweaponallowthird(self,"iw5_mahemzm_mp");
	setweaponlevelallowthird(self,"iw5_mahemzm_mp",25);
}

//Function Number: 160
givezombieweaponallowthird(param_00,param_01)
{
	maps\mp\gametypes\zombies::createzombieweaponstate(param_00,param_01);
	param_00 maps\mp\_utility::_giveweapon(param_01);
	param_00 givemaxammo(param_01);
	param_00 maps\mp\zombies\_wall_buys::givemaxscriptedammo(param_01);
	param_00 switchtoweaponimmediate(param_01);
}

//Function Number: 161
setweaponlevelallowthird(param_00,param_01,param_02)
{
	param_00 takeweapon(param_01);
	var_03 = getweaponbasename(param_01);
	param_00.weaponstate[var_03]["level"] = param_02;
	var_04 = maps\mp\zombies\_wall_buys::getupgradeweaponname(param_00,var_03);
	givezombieweaponallowthird(param_00,var_04);
	if(issubstr(var_04,"iw5_em1zm_mp"))
	{
		param_00 maps\mp\gametypes\zombies::playersetem1maxammo();
	}

	if(isdefined(level.setweaponlevelfunc))
	{
		param_00 [[ level.setweaponlevelfunc ]](param_01,param_02);
	}
}

//Function Number: 162
playergetmahem()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		var_03 = getweaponbasename(var_02);
		if(var_03 == "iw5_mahemzm_mp")
		{
			return var_02;
		}
	}
}

//Function Number: 163
playertakemahem()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		var_03 = getweaponbasename(var_02);
		if(var_03 == "iw5_mahemzm_mp")
		{
			if(self.hadmahem)
			{
				if(isdefined(self.oldmahemweaponlevel))
				{
					maps\mp\zombies\_wall_buys::setweaponlevel(self,var_02,self.oldmahemweaponlevel);
				}
			}
			else
			{
				self.weaponstate[var_03]["level"] = 1;
				self takeweapon(var_02);
				var_00 = self getweaponslistprimaries();
				if(var_00.size > 0)
				{
					self switchtoweapon(var_00[0]);
				}
			}

			break;
		}
	}

	playerclearmahemdata();
}

//Function Number: 164
playerclearmahemdata()
{
	self.hadmahem = undefined;
	self.oldmahemweaponlevel = undefined;
	self.scriptedtombstoneweapon = undefined;
	self.scriptedtombstoneweaponlevel = undefined;
}

//Function Number: 165
restoreweaponsstage14()
{
	playertakemahem();
	if(!common_scripts\utility::isoffhandweaponenabled())
	{
		common_scripts\utility::_enableoffhandweapons();
	}

	self enableoffhandsecondaryweapons();
	if(!isweaponswitchenabled_duplicate())
	{
		common_scripts\utility::_enableweaponswitch();
	}
}

//Function Number: 166
delayclearmahemdata()
{
	wait 0.05;
	foreach(var_01 in level.players)
	{
		var_01 playerclearmahemdata();
	}
}

//Function Number: 167
stage14_end(param_00)
{
	level thread dochallengehudcomplete();
	level thread delayclearmahemdata();
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 5 - Mahem");
}

//Function Number: 168
stage11_init()
{
}

//Function Number: 169
stage11_logic()
{
	var_00 = common_scripts\utility::getstructarray("sqLightPuzzle","targetname");
	if(var_00.size == 0)
	{
		return;
	}

	var_00 = common_scripts\utility::array_randomize(var_00);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_01;
		var_03 = var_01 + 1;
		var_04 = var_00[var_01];
		setuplight(var_04,var_02,var_03);
	}

	setuplightlooping(var_00[0],0);
	wait(1);
	for(;;)
	{
		var_00[0] lightloopingon();
		var_00[0] maps\mp\zombies\_zombies_sidequests::fake_use("light_puzzle_on",undefined,undefined,"main_stage11_over",80);
		var_05 = dolightpuzzle(var_00);
		if(var_05)
		{
			break;
		}

		wait(2);
	}

	announcerglobalplaysqvowaittilldone(6,0.5);
	unlockspecialweaponupgrade();
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage11");
}

//Function Number: 170
setuplight(param_00,param_01,param_02)
{
	param_00.index = param_01;
	param_00.sound = "ee_puzzle_beep" + param_02;
	param_00.fx = spawnfx(common_scripts\utility::getfx("sq_light_puzzle_" + param_01),param_00.origin);
}

//Function Number: 171
setuplightlooping(param_00,param_01)
{
	param_00.fxlooping = spawnfx(common_scripts\utility::getfx("sq_light_puzzle_loop"),param_00.origin);
	triggerfx(param_00.fxlooping);
}

//Function Number: 172
lightloopingon()
{
	self.fxlooping show();
}

//Function Number: 173
lightloopingoff()
{
	self.fxlooping hide();
}

//Function Number: 174
lightturnon()
{
	triggerfx(self.fx);
}

//Function Number: 175
dolightpuzzle(param_00)
{
	param_00[0] lightloopingoff();
	var_01 = generatelightpuzzlepattern(param_00);
	wait(1.5);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = calculatetimeon(var_02);
		playlightsequence(var_02,var_01,var_03);
		var_04 = waittillplayersactivatesequence(var_02,param_00,var_01);
		if(!var_04)
		{
			maps\mp\mp_zombie_h2o_aud::sndlightpuzzlefail();
			if(!maps\mp\zombies\_util::is_true(level.zmbsqplayedlightpuzzlefail))
			{
				level thread announcerozglobalplaysq(28,1.5);
				level.zmbsqplayedlightpuzzlefail = 1;
			}

			return 0;
		}

		wait(1.5);
	}

	wait(1);
	maps\mp\mp_zombie_h2o_aud::sndlightpuzzlesuccess();
	return 1;
}

//Function Number: 176
calculatetimeon(param_00)
{
	var_01 = 1.5;
	if(param_00 > 0)
	{
		var_02 = 1;
		var_03 = var_02 / 8;
		var_01 = var_01 - var_03 * param_00;
	}

	return var_01;
}

//Function Number: 177
playlightsequence(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 <= param_00;var_03++)
	{
		var_04 = param_01[var_03];
		var_04 lightturnon();
		maps\mp\mp_zombie_h2o_aud::sndlightpuzzle(var_04.origin,var_04.sound);
		wait(param_02);
	}
}

//Function Number: 178
generatelightpuzzlepattern(param_00)
{
	var_01 = undefined;
	var_02 = [];
	while(var_02.size < 8)
	{
		var_03 = param_00[randomint(param_00.size)];
		if(isdefined(var_01) && var_03 == var_01)
		{
			wait 0.05;
			continue;
		}

		var_02[var_02.size] = var_03;
		var_01 = var_03;
	}

	return var_02;
}

//Function Number: 179
waittillplayersactivatesequence(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 <= param_00;var_03++)
	{
		var_04 = param_02[var_03];
		var_05 = waittilllightpressed(var_04,param_01);
		if(maps\mp\zombies\_util::is_true(var_05))
		{
			var_04 lightturnon();
			maps\mp\mp_zombie_h2o_aud::sndlightpuzzle(var_04.origin,var_04.sound);
			wait(0.5);
			continue;
		}

		return 0;
	}

	return 1;
}

//Function Number: 180
waittilllightpressed(param_00,param_01)
{
	level endon("sq_light_puzzle_cancel");
	level thread lightusetimeout();
	foreach(var_03 in param_01)
	{
		if(var_03.index != param_00.index)
		{
			var_03 thread lightusecancel();
		}
	}

	param_00 maps\mp\zombies\_zombies_sidequests::fake_use("used",undefined,undefined,"sq_light_uses_off",80);
	level notify("sq_light_uses_off");
	return 1;
}

//Function Number: 181
lightusetimeout()
{
	level endon("sq_light_uses_off");
	wait(5);
	level notify("sq_light_puzzle_cancel");
}

//Function Number: 182
lightusecancel()
{
	level endon("sq_light_uses_off");
	maps\mp\zombies\_zombies_sidequests::fake_use("used",undefined,undefined,"sq_light_uses_off",80);
	level notify("sq_light_puzzle_cancel");
	level notify("sq_light_uses_off");
}

//Function Number: 183
stage11_end(param_00)
{
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed simon lights puzzle");
}

//Function Number: 184
unlockspecialweaponupgrade()
{
	level notify("special_weapon_box_unlocked");
	announcerglobalplaysqvo(3,2,undefined,"sq3");
	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

//Function Number: 185
stage12_init()
{
}

//Function Number: 186
stage12_logic()
{
	level thread announcerozglobalplaysq(22);
	if(shoulddelayforbossround())
	{
		waituntilnextround();
	}

	waituntilnextround();
	level thread announcerglobalplaysqvo(12);
	setomnvar("ui_zm_zone_identifier",4);
	foreach(var_01 in level.players)
	{
		if(var_01 maps\mp\_utility::isjuggernaut())
		{
			var_01 dodamage(var_01.mechhealth,var_01.origin);
		}

		if(isalive(var_01))
		{
			var_01 notify("stop_useHoldThinkLoop");
		}
	}

	level thread handlefeaturesstage12();
	level thread spawncharactersstage12();
	level thread runprizelogic();
	waituntilnextround();
	var_03 = getteamplayersalive(level.playerteam);
	level thread announcerglobalplaysqvo(13);
	if(var_03 > 0)
	{
		maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage12");
	}
}

//Function Number: 187
handlefeaturesstage12()
{
	maps\mp\zombies\_util::disablekillstreaks();
	maps\mp\zombies\_util::setfriendlyfireround(1);
	level waittill("main_stage12_over");
	maps\mp\zombies\_util::setfriendlyfireround(0);
	maps\mp\zombies\_util::enablekillstreaks();
	despawncharacters();
}

//Function Number: 188
runprizelogic()
{
	foreach(var_01 in level.players)
	{
		var_01 thread playerhurtvostage12();
		var_01 thread playerrewardprizestage12();
		var_01 thread playerhandleicon();
	}

	level thread onplayerconnectstage12();
}

//Function Number: 189
playerhandleicon()
{
	var_00 = newteamhudelem(level.playerteam);
	var_00 setshader("hud_upgrade_reward",14,14);
	var_00 setwaypoint(1,1);
	var_00 settargetent(self);
	waittillstage12overordeath(self);
	if(isdefined(var_00))
	{
		var_00 destroy();
	}
}

//Function Number: 190
waittillstage12overordeath(param_00)
{
	param_00 endon("death");
	level waittill("main_stage12_over");
}

//Function Number: 191
playerrewardprizestage12()
{
	level endon("main_stage12_over");
	self notify("playerRewardPrizeStage12");
	self endon("playerRewardPrizeStage12");
	self waittill("death",var_00,var_01,var_02);
	if(isai(self))
	{
		level.zmbsqcharacterskilled++;
		if(level.zmbsqcharacterskilled == 3)
		{
			if(isplayer(var_00))
			{
				var_00 thread playerrewardweaponupgrade();
			}
		}

		level thread dokillplayerozvo();
		return;
	}

	if(isplayer(var_00) && var_00 != self)
	{
		if(!isdefined(level.zmbsqrewardprizes))
		{
			level.zmbsqrewardprizes = 1;
		}
		else if(level.zmbsqrewardprizes < 3)
		{
			level.zmbsqrewardprizes++;
		}
		else
		{
			return;
		}

		var_00 thread playerrewardweaponupgrade();
		level thread dokillplayerozvo();
	}
}

//Function Number: 192
dokillplayerozvo()
{
	var_00 = 0;
	if(level.players.size == 1)
	{
		if(level.zmbsqcharacterskilled == 1)
		{
			var_00 = 29;
		}
		else if(level.zmbsqcharacterskilled == 2)
		{
			var_00 = 30;
		}
		else
		{
			var_00 = 31;
		}
	}
	else
	{
		var_01 = level.players.size;
		var_02 = getteamplayersalive(level.playerteam);
		var_03 = var_01 - var_02;
		if(var_01 == 4 && var_03 == 1)
		{
			var_00 = 29;
		}
		else if((var_01 == 4 && var_03 == 2) || var_01 == 3 && var_03 == 1)
		{
			var_00 = 30;
		}
		else
		{
			var_00 = 31;
		}
	}

	wait(1);
	announcerozglobalplaysq(var_00);
}

//Function Number: 193
playerhurtvostage12()
{
	level endon("main_stage12_over");
	self notify("playerHurtVoStage12");
	self endon("playerHurtVoStage12");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(isdefined(var_01) && var_01 != self && isdefined(var_04) && maps\mp\_utility::isbulletdamage(var_04))
		{
			if(playerplaysqvo(13))
			{
				return;
			}
		}
	}
}

//Function Number: 194
playerrewardweaponupgrade()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(maps\mp\zombies\_util::is_true(self.sqawardingweaponupgrade))
	{
		wait(0.1);
	}

	self.sqawardingweaponupgrade = 1;
	var_00 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,185);
	var_00 settext(&"ZOMBIE_H2O_SQ_WPN_UPGRADE");
	var_00.fontscale = 0.65;
	var_01 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,205);
	var_01 thread update_countdown(self);
	var_01.fontscale = 1;
	common_scripts\utility::waittill_any("timer_countdown_complete");
	var_01 maps\mp\gametypes\_hud_util::destroyelem();
	var_00 maps\mp\gametypes\_hud_util::destroyelem();
	if(isdefined(self.inlaststand) && self.inlaststand == 1)
	{
		while(self.inlaststand == 1)
		{
			wait(0.1);
		}
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		while(self.iscarrying == 1)
		{
			wait(0.1);
		}
	}

	if(isdefined(self.hasbomb) && self.hasbomb == 1)
	{
		while(self.hasbomb == 1)
		{
			wait(0.1);
		}
	}

	var_02 = maps\mp\zombies\_util::getplayerweaponzombies(self);
	var_03 = getweaponbasename(var_02);
	if(!maps\mp\zombies\_util::haszombieweaponstate(self,var_03))
	{
		self.sqawardingweaponupgrade = undefined;
		return;
	}

	if(self.weaponstate[var_03]["level"] < 20)
	{
		maps\mp\zombies\_wall_buys::setweaponlevel(self,var_02,self.weaponstate[var_03]["level"] + 1);
	}
	else if(self.weaponstate[var_03]["level"] == 20)
	{
		maps\mp\zombies\_wall_buys::setweaponlevel(self,var_02,25);
	}
	else
	{
		self.sqawardingweaponupgrade = undefined;
		return;
	}

	thread maps\mp\zombies\_zombies_audio::playerweaponupgrade(0,self.weaponstate[var_03]["level"]);
	self.sqawardingweaponupgrade = undefined;
}

//Function Number: 195
update_countdown(param_00)
{
	param_00 endon("disconnect");
	self endon("death");
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		var_02 = "" + 5 - var_01;
		self settext(var_02);
		param_00 playsoundtoplayer("ee_weapon_upgrade_countdown",param_00);
		wait(1);
	}

	param_00 notify("timer_countdown_complete");
}

//Function Number: 196
onplayerconnectstage12()
{
	level endon("main_stage12_over");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawnedstage12();
	}
}

//Function Number: 197
onplayerspawnedstage12()
{
	level endon("main_stage12_over");
	self waittill("spawned_player");
	thread playerrewardprizestage12();
	thread playerhurtvostage12();
}

//Function Number: 198
spawncharactersstage12()
{
	level endon("main_stage12_over");
	level.zmbsqcharacters = [];
	setupcharacterlogic();
	for(;;)
	{
		while(level.players.size != 1)
		{
			wait 0.05;
		}

		docharacterspawn();
		while(level.players.size == 1)
		{
			wait 0.05;
		}

		despawncharacters();
		level.zmbsqcharacters = [];
	}
}

//Function Number: 199
setupcharacterlogic()
{
	if(!isdefined(level.agent_funcs["sq_character"]))
	{
		maps\mp\zombies\ranged_elite_soldier::init_ally();
		level.agent_funcs["sq_character"] = level.agent_funcs["ranged_elite_soldier"];
		level.agent_funcs["sq_character"]["think"] = ::characterthink;
		level.getloadout["sq_character"] = ::sqcharactergetloadout;
		level.onspawnfinished["sq_character"] = ::onspawnfinishedsqcharacter;
		var_00 = level.agentclasses["ranged_elite_soldier"];
		maps\mp\zombies\_util::agentclassregister(var_00,"sq_character");
	}
}

//Function Number: 200
onspawnfinishedsqcharacter(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("applyLoadout");
	var_01 = common_scripts\utility::array_combine(level.players,level.zmbsqcharacters);
	for(var_02 = 0;var_02 < 4;var_02++)
	{
		var_03 = getcharacterbyindex(var_02,var_01);
		if(!isdefined(var_03))
		{
			self.characterindex = var_02;
			setexocharactermodel();
			break;
		}
	}

	setcharacterbotsettings();
	self agentusescragentclipmask(1);
	self.pers["numberOfTimesCloakingUsed"] = 0;
	self.pers["numberOfTimesShieldUsed"] = 0;
}

//Function Number: 201
setcharacterbotsettings()
{
	self botsetdifficultysetting("meleeReactAllowed",0);
	self botsetdifficultysetting("quickPistolSwitch",1);
	self botsetdifficultysetting("diveChance",0);
	self botsetdifficultysetting("diveDelay",300);
	self botsetdifficultysetting("slideChance",0.6);
	self botsetdifficultysetting("cornerFireChance",1);
	self botsetdifficultysetting("cornerJumpChance",1);
	self botsetdifficultysetting("throwKnifeChance",1);
	self botsetdifficultysetting("meleeDist",100);
	self botsetdifficultysetting("meleeChargeDist",160);
	self botsetdifficultysetting("grenadeCookPrecision",100);
	self botsetdifficultysetting("grenadeDoubleTapChance",1);
	self botsetdifficultysetting("strategyLevel",3);
	self botsetdifficultysetting("intelligentSprintLevel",2);
	self botsetdifficultysetting("holdBreathChance",1);
	self botsetdifficultysetting("intelligentReload",1);
	self botsetdifficultysetting("dodgeChance",0.5);
	self botsetdifficultysetting("dodgeIntelligence",0.8);
	self botsetdifficultysetting("boostSlamChance",0.35);
	self botsetdifficultysetting("boostLookAroundChance",1);
}

//Function Number: 202
sqcharactergetloadout()
{
	var_00 = ::maps\mp\bots\_bots_loadout::bot_loadout_choose_from_attachmenttable;
	var_01 = [];
	var_01["loadoutWildcard1"] = "specialty_null";
	var_01["loadoutWildcard2"] = "specialty_null";
	var_01["loadoutWildcard3"] = "specialty_null";
	var_01["loadoutPrimary"] = common_scripts\utility::random(level.ranged_elite_soldier_weapons["primary"]);
	var_01["loadoutPrimaryAttachment"] = self [[ var_00 ]]("attachmenttable",var_01,"loadoutPrimaryAttachment",self.personality,self.difficulty);
	var_01["loadoutPrimaryAttachment2"] = self [[ var_00 ]]("attachmenttable",var_01,"loadoutPrimaryAttachment2",self.personality,self.difficulty);
	var_01["loadoutPrimaryAttachment3"] = "none";
	var_01["loadoutPrimaryBuff"] = "specialty_null";
	var_01["loadoutPrimaryCamo"] = "none";
	var_01["loadoutPrimaryReticle"] = "none";
	var_01["loadoutSecondary"] = common_scripts\utility::random(level.ranged_elite_soldier_weapons["secondary"]);
	var_01["loadoutSecondaryAttachment"] = self [[ var_00 ]]("attachmenttable",var_01,"loadoutSecondaryAttachment",self.personality,self.difficulty);
	var_01["loadoutSecondaryAttachment2"] = self [[ var_00 ]]("attachmenttable",var_01,"loadoutSecondaryAttachment2",self.personality,self.difficulty);
	var_01["loadoutSecondaryAttachment3"] = "none";
	var_01["loadoutSecondaryBuff"] = "specialty_null";
	var_01["loadoutSecondaryCamo"] = "none";
	var_01["loadoutSecondaryReticle"] = "none";
	var_01["loadoutEquipment"] = common_scripts\utility::random(["frag_grenade_mp","semtex_mp"]);
	var_01["loadoutEquipmentExtra"] = 0;
	var_01["loadoutOffhand"] = "specialty_null";
	var_01["loadoutPerk1"] = "specialty_null";
	var_01["loadoutPerk2"] = "specialty_null";
	var_01["loadoutPerk3"] = "specialty_null";
	var_01["loadoutPerk4"] = "specialty_null";
	var_01["loadoutPerk5"] = "specialty_null";
	var_01["loadoutPerk6"] = "specialty_null";
	var_01["loadoutKillstreaks"][0] = "none";
	var_01["loadoutKillstreaks"][1] = "none";
	var_01["loadoutKillstreaks"][2] = "none";
	var_01["loadoutKillstreaks"][3] = "none";
	for(var_02 = 0;var_02 < 6;var_02++)
	{
		var_01["loadoutPerks"][var_02] = var_01["loadoutPerk" + var_02 + 1];
		var_01["loadoutPerk" + var_02 + 1] = undefined;
	}

	for(var_02 = 0;var_02 < 3;var_02++)
	{
		var_01["loadoutWildcards"][var_02] = var_01["loadoutWildcard" + var_02 + 1];
		var_01["loadoutWildcard" + var_02 + 1] = undefined;
	}

	return var_01;
}

//Function Number: 203
characterthink()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("soldier_think");
	self endon("soldier_think");
	childthread maps\mp\zombies\ranged_elite_soldier::ammorefillprimary();
	childthread maps\mp\zombies\ranged_elite_soldier::ammorefillsecondary();
	childthread maps\mp\zombies\killstreaks\_zombie_squadmate::monitorteleporttraversals();
	if(self.team == level.enemyteam)
	{
		childthread maps\mp\zombies\_util::locateenemypositions();
		return;
	}

	maps\mp\_utility::giveperk("specialty_coldblooded",0);
}

//Function Number: 204
despawncharacters()
{
	foreach(var_01 in level.zmbsqcharacters)
	{
		var_01 suicide();
	}
}

//Function Number: 205
docharacterspawn()
{
	var_00 = getanyplayer();
	spawncharacters(var_00,3,level.enemyteam);
	var_01 = var_00.characterindex;
	level.zmbsqcharacterskilled = 0;
	foreach(var_03 in level.zmbsqcharacters)
	{
		var_03.fakeplayer = 1;
		var_03 thread playerrewardprizestage12();
		var_03 thread playerhandleicon();
	}
}

//Function Number: 206
getanyplayer(param_00)
{
	var_01 = level.players;
	if(maps\mp\zombies\_util::is_true(param_00))
	{
		var_01 = common_scripts\utility::array_randomize(level.players);
	}

	foreach(var_03 in level.players)
	{
		if(isalive(var_03))
		{
			return var_03;
		}
	}

	if(isdefined(level.player))
	{
		return level.player;
	}

	return level.players[0];
}

//Function Number: 207
setexocharactermodel()
{
	switch(self.characterindex)
	{
		case 0:
			thread maps\mp\zombies\_util::setcharactermodel("security_exo",1,1);
			break;

		case 1:
			thread maps\mp\zombies\_util::setcharactermodel("exec_exo",1,1);
			break;

		case 2:
			thread maps\mp\zombies\_util::setcharactermodel("it_exo",1,1);
			break;

		case 3:
		default:
			thread maps\mp\zombies\_util::setcharactermodel("pilot_exo",1,1);
			break;
	}
}

//Function Number: 208
spawncharacters(param_00,param_01,param_02,param_03)
{
	level endon("main_stage12_over");
	var_04 = 0;
	var_05 = [];
	var_06 = 0;
	while(!var_06)
	{
		var_07 = getanyplayer();
		var_08 = var_07 maps\mp\zombies\_util::getenemyagents();
		var_09 = maps\mp\zombies\_util::getnumagentswaitingtodeactivate();
		var_04 = var_08.size + var_09 - maps\mp\zombies\zombies_spawn_manager::getmaxenemycount() - param_01;
		var_05 = maps\mp\zombies\_util::getarrayofoffscreenagentstorecycle(var_08);
		if(var_05.size >= var_04)
		{
			var_06 = 1;
			continue;
		}

		wait 0.05;
	}

	var_0A = 0;
	if(var_04 > 0)
	{
		maps\mp\zombies\_util::pausezombiespawning(1);
		var_0A = 1;
		var_05 = common_scripts\utility::array_randomize(var_05);
		var_0B = [];
		for(var_0C = 0;var_0C < var_04;var_0C++)
		{
			var_0B[var_0C] = var_05[var_0C];
		}

		foreach(var_0E in var_0B)
		{
			var_0E suicide();
		}

		wait(0.5);
	}

	if(!isdefined(param_03))
	{
		param_03 = getnodesforenemycharacters(param_00,param_01);
	}

	level.zmbsqcharacters = [];
	for(var_0C = 0;var_0C < param_01;var_0C++)
	{
		var_12 = param_03[var_0C].origin;
		var_13 = vectortoangles(param_00.origin - param_03[var_0C].origin);
		var_14 = "sq_character";
		var_15 = maps\mp\agents\_agent_common::connectnewagent(var_14,param_02);
		var_15 maps\mp\agents\_agents::spawn_agent_player(var_12,var_13);
		level.zmbsqcharacters[level.zmbsqcharacters.size] = var_15;
		var_16 = 100;
		var_15 maps\mp\agents\_agent_common::set_agent_health(var_16);
		maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(var_15);
		playfx(common_scripts\utility::getfx("npc_teleport_ally"),var_12,(1,0,0),(0,0,1));
		wait 0.05;
	}

	if(var_0A)
	{
		maps\mp\zombies\_util::pausezombiespawning(0);
	}
}

//Function Number: 209
getnodesforenemycharacters(param_00,param_01)
{
	var_02 = maps\mp\zombies\_zombies_zone_manager::getcurrentplayeroccupiedzones();
	var_03 = [];
	var_04 = [];
	var_05 = [];
	while(!isdefined(level.zone_data))
	{
		wait 0.05;
	}

	while(!isdefined(level.closetpathnodescalculated) || !level.closetpathnodescalculated)
	{
		wait 0.05;
	}

	foreach(var_07 in level.zone_data.zones)
	{
		if(!isdefined(var_07.volumes))
		{
			continue;
		}

		if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_07.zone_name))
		{
			continue;
		}

		if(isdefined(level.ammodroneillegalzones))
		{
			if(common_scripts\utility::array_contains(level.ammodroneillegalzones,var_07.zone_name))
			{
				continue;
			}
		}

		if(!common_scripts\utility::array_contains(var_02,var_07.zone_name))
		{
			var_03[var_03.size] = var_07;
			continue;
		}

		var_04[var_04.size] = var_07;
	}

	if(var_03.size == 0)
	{
		var_03 = var_04;
	}

	var_03 = common_scripts\utility::array_randomize(var_03);
	foreach(var_07 in var_03)
	{
		var_0A = var_07.volumes[randomint(var_07.volumes.size)];
		var_0B = getnodesintrigger(var_0A);
		var_0C = [];
		foreach(var_0E in var_0B)
		{
			if(!var_0E nodeisdisconnected() && isdefined(var_0E.zombieszone))
			{
				var_0C[var_0C.size] = var_0E;
			}
		}

		var_05[var_05.size] = var_0C[randomint(var_0C.size)];
		for(var_10 = param_01 - 1;var_10 > 0 && var_05.size < param_01;var_10--)
		{
			if(var_03.size <= var_10)
			{
				var_05[var_05.size] = var_0C[randomint(var_0C.size)];
			}
		}

		if(var_05.size == param_01)
		{
			break;
		}
	}

	return var_05;
}

//Function Number: 210
stage12_end(param_00)
{
	level thread dochallengehudcomplete();
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 4 - Last One Standing");
}

//Function Number: 211
stage13_init()
{
}

//Function Number: 212
stage13_logic()
{
	var_00 = getent("sqCounterTop0","targetname");
	var_01 = getent("sqCounterTop1","targetname");
	var_02 = getent("sqCounterTop2","targetname");
	var_03 = getent("sqCounterTop3","targetname");
	var_04 = getent("sqCounterBottom0","targetname");
	var_05 = getent("sqCounterBottom1","targetname");
	var_06 = getent("sqCounterBottom2","targetname");
	var_07 = getent("sqCounterBottom3","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 show();
	var_01 show();
	var_02 show();
	var_03 show();
	var_04 show();
	var_05 show();
	var_06 show();
	var_07 show();
	var_08 = [var_00,var_01,var_02,var_03];
	var_09 = [var_04,var_05,var_06,var_07];
	level.zmbsqcountertop = setupcounter(var_08);
	level.zmbsqcounterbottom = setupcounter(var_09);
	runcounterpuzzlelogic(level.zmbsqcountertop,level.zmbsqcounterbottom);
	level thread delaydeletecounters(var_08,var_09);
	maps\mp\mp_zombie_h2o_aud::sndcounterdigitsuccess();
	announcerglobalplaysqvowaittilldone(6,2);
	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage13");
}

//Function Number: 213
delaydeletecounters(param_00,param_01)
{
	wait(1);
	foreach(var_03 in param_00)
	{
		var_03 delete();
	}

	foreach(var_03 in param_01)
	{
		var_03 delete();
	}
}

//Function Number: 214
runcounterpuzzlelogic(param_00,param_01)
{
	var_02 = randomintrange(1,10);
	var_03 = randomintrange(1,10);
	var_04 = randomintrange(1,10);
	var_05 = randomintrange(1,10);
	setcounter(param_00,var_02,var_03,var_04,var_05,"red");
	setcounter(param_01,0,0,0,0,"blue");
	level thread monitorboostslamhits(param_01,0);
	level thread monitorjumps(param_01,1);
	level thread monitorweaponspickedup(param_01,2);
	level thread monitorkills(param_01,3);
	for(;;)
	{
		if(docountersmatch(param_00,param_01))
		{
			level notify("sq_counter_puzzle_complete");
			break;
		}

		wait 0.05;
	}
}

//Function Number: 215
docountersmatch(param_00,param_01)
{
	return param_00.digits[0] == param_01.digits[0] && param_00.digits[1] == param_01.digits[1] && param_00.digits[2] == param_01.digits[2] && param_00.digits[3] == param_01.digits[3];
}

//Function Number: 216
monitorboostslamhits(param_00,param_01,param_02)
{
	level endon("main_stage13_over");
	level endon("sq_counter_puzzle_complete");
	if(!isdefined(level.zmbsqboostslamhits))
	{
		level.zmbsqboostslamhits = 0;
	}

	level.processenemydamagedfunc = ::processenemydamagedfuncsq;
	var_03 = level.zmbsqboostslamhits;
	for(;;)
	{
		level waittill("sq_boost_slam_hit");
		waittillframeend;
		var_04 = level.zmbsqboostslamhits - var_03;
		var_05 = getcounterdigit(param_00,param_01);
		var_05 = var_05 + var_04 % 10;
		setcounterdigit(param_00,param_01,var_05,"blue");
		var_03 = level.zmbsqboostslamhits;
	}
}

//Function Number: 217
processenemydamagedfuncsq(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(param_00))
	{
		return;
	}

	if(isdefined(param_04) && param_04 == "MOD_SUICIDE")
	{
		return;
	}

	if(isdefined(param_05) && param_05 == "boost_slam_mp")
	{
		level notify("sq_boost_slam_hit");
		level.zmbsqboostslamhits++;
	}
}

//Function Number: 218
monitorjumps(param_00,param_01)
{
	level endon("main_stage13_over");
	level endon("sq_counter_puzzle_complete");
	if(!isdefined(level.zmbsqplayerjumps))
	{
		level.zmbsqplayerjumps = 0;
	}

	level thread onplayerconnectstage13();
	foreach(var_03 in level.players)
	{
		var_03 thread playermonitorjumps();
	}

	var_05 = level.zmbsqplayerjumps;
	for(;;)
	{
		level waittill("sq_player_jumped");
		waittillframeend;
		var_06 = level.zmbsqplayerjumps - var_05;
		var_07 = getcounterdigit(param_00,param_01);
		var_07 = var_07 + var_06 % 10;
		setcounterdigit(param_00,param_01,var_07,"blue");
		var_05 = level.zmbsqplayerjumps;
	}
}

//Function Number: 219
onplayerconnectstage13()
{
	level endon("main_stage13_over");
	level endon("sq_counter_puzzle_complete");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawnedstage13();
	}
}

//Function Number: 220
onplayerspawnedstage13()
{
	level endon("main_stage13_over");
	level endon("sq_counter_puzzle_complete");
	self endon("disconnect");
	self waittill("spawned_player");
	thread playermonitorjumps();
}

//Function Number: 221
playermonitorjumps()
{
	level endon("main_stage13_over");
	level endon("sq_counter_puzzle_complete");
	self endon("disconnect");
	if(!isdefined(level.zmbsqplayerjumps))
	{
		level.zmbsqplayerjumps = 0;
	}

	for(;;)
	{
		while(!self isjumping())
		{
			wait 0.05;
		}

		level.zmbsqplayerjumps++;
		level notify("sq_player_jumped");
		while(!self isonground())
		{
			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 222
monitorweaponspickedup(param_00,param_01)
{
	level endon("main_stage13_over");
	level endon("sq_counter_puzzle_complete");
	if(!isdefined(level.zmbsqweaponspickedup))
	{
		level.zmbsqweaponspickedup = 0;
	}

	level.zmbprocessweapongivenfunc = ::zmbprocessweapongivenfunc;
	level thread onplayerconnectstage13();
	var_02 = level.zmbsqweaponspickedup;
	for(;;)
	{
		level waittill("sq_weapon_given");
		waittillframeend;
		var_03 = level.zmbsqweaponspickedup - var_02;
		var_04 = getcounterdigit(param_00,param_01);
		var_04 = var_04 + var_03 % 10;
		setcounterdigit(param_00,param_01,var_04,"blue");
		var_02 = level.zmbsqweaponspickedup;
	}
}

//Function Number: 223
zmbprocessweapongivenfunc(param_00,param_01)
{
	if(maps\mp\zombies\_util::iszombieequipment(param_01))
	{
		level.zmbsqweaponspickedup++;
		level notify("sq_weapon_given");
	}
}

//Function Number: 224
monitorkills(param_00,param_01,param_02)
{
	level endon("main_stage13_over");
	level endon("sq_counter_puzzle_complete");
	if(!isdefined(level.zmbsqregularkills))
	{
		level.zmbsqregularkills = 0;
	}

	level.processenemykilledfunc = ::processenemykilledsq;
	var_03 = level.zmbsqregularkills;
	for(;;)
	{
		level waittill("sq_regular_kill");
		waittillframeend;
		var_04 = level.zmbsqregularkills - var_03;
		var_05 = getcounterdigit(param_00,param_01);
		var_05 = var_05 + var_04 % 10;
		setcounterdigit(param_00,param_01,var_05,"blue");
		var_03 = level.zmbsqregularkills;
	}
}

//Function Number: 225
processenemykilledsq(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(param_03) && param_03 == "MOD_SUICIDE")
	{
		return;
	}

	level notify("sq_regular_kill");
	level.zmbsqregularkills++;
}

//Function Number: 226
setcounter(param_00,param_01,param_02,param_03,param_04,param_05)
{
	setcounterdigit(param_00,0,param_01,param_05);
	setcounterdigit(param_00,1,param_02,param_05);
	setcounterdigit(param_00,2,param_03,param_05);
	setcounterdigit(param_00,3,param_04,param_05);
}

//Function Number: 227
getcounterdigit(param_00,param_01)
{
	return param_00.digits[param_01];
}

//Function Number: 228
setcounterdigit(param_00,param_01,param_02,param_03)
{
	var_04 = "neon_alphabet_num_0_off";
	switch(param_02)
	{
		case 0:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_0";
			}
			else if(param_03 == "off")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_0";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_0";
			}
			break;

		case 1:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_1";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_1";
			}
			break;

		case 2:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_2";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_2";
			}
			break;

		case 3:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_3";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_3";
			}
			break;

		case 4:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_4";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_4";
			}
			break;

		case 5:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_5";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_5";
			}
			break;

		case 6:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_6";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_6";
			}
			break;

		case 7:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_7";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_7";
			}
			break;

		case 8:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_8";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_8";
			}
			break;

		case 9:
			if(param_03 == "red")
			{
				var_04 = "h2o_sign_ee_scoreboard_no_9";
			}
			else
			{
				var_04 = "h2o_sign_ee_scoreboard_no_9";
			}
			break;

		default:
			var_04 = "h2o_sign_ee_scoreboard_no_0";
			break;
	}

	param_00.digits[param_01] = param_02;
	param_00.digitmodels[param_01] setmodel(var_04);
	maps\mp\mp_zombie_h2o_aud::sndcounterdigitflip(param_00.digitmodels[param_01].origin);
}

//Function Number: 229
setupcounter(param_00)
{
	var_01 = spawnstruct();
	var_01.digitmodels = param_00;
	var_01.digits = [0,0,0,0];
	return var_01;
}

//Function Number: 230
stage13_end(param_00)
{
	level.zmbprocessweapongivenfunc = undefined;
	level.processenemykilledfunc = undefined;
	level.processenemydamagedfunc = undefined;
	level.zmbsqboostslamhits = undefined;
	level.zmbsqplayerjumps = undefined;
	level.zmbsqregularkills = undefined;
	level.zmbsqweaponspickedup = undefined;
	level.zmbsqcountertop = undefined;
	level.zmbsqcounterbottom = undefined;
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed counters puzzle");
}

//Function Number: 231
stage10_init()
{
}

//Function Number: 232
stage10_logic()
{
	level thread announcerozglobalplaysq(21);
	if(shoulddelayforbossround())
	{
		waituntilnextround();
	}

	waituntilnextround();
	level thread announcerozglobalplaysq(13);
	setomnvar("ui_zm_zone_identifier",3);
	level thread runmovementiscostly();
	waituntilnextround();
	var_00 = getteamplayersalive(level.playerteam);
	if(var_00 > 0)
	{
		level thread announcerozglobalplaysq(33);
		maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage10");
	}
}

//Function Number: 233
runmovementiscostly()
{
	level.zmbsqlinkent = spawn("script_model",(0,0,0));
	foreach(var_01 in level.players)
	{
		var_01 thread playertravelcosts();
	}

	level thread onplayerconnectstage10();
}

//Function Number: 234
onplayerconnectstage10()
{
	level endon("main_stage10_over");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawnedstage10();
	}
}

//Function Number: 235
onplayerspawnedstage10()
{
	level endon("main_stage10_over");
	self endon("disconnect");
	self waittill("spawned_player");
	thread playertravelcosts();
}

//Function Number: 236
getspendincrement(param_00)
{
	var_01 = int(param_00 * 0.01);
	var_02 = var_01 % 5;
	var_01 = var_01 - var_02;
	return int(max(5,var_01));
}

//Function Number: 237
playertravelcosts()
{
	level endon("main_stage10_over");
	self endon("disconnect");
	var_00 = 0;
	var_01 = 1;
	var_02 = 20000;
	var_03 = 60000;
	var_04 = 300;
	var_05 = 0;
	var_06 = 1;
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	for(;;)
	{
		while(self.sessionstate != "playing" || maps\mp\zombies\_util::isplayerteleporting(self))
		{
			wait 0.05;
		}

		var_0A = self.origin;
		wait 0.05;
		if(self.sessionstate != "playing" || maps\mp\zombies\_util::isplayerteleporting(self))
		{
			continue;
		}

		var_0B = distance(self.origin,var_0A);
		var_0C = maps\mp\gametypes\zombies::getcurrentmoney(self);
		var_0D = getspendincrement(var_0C);
		var_0E = var_0D / 50;
		var_00 = var_00 + var_0B * var_0E;
		if(var_00 >= var_0D)
		{
			var_0C = maps\mp\gametypes\zombies::getcurrentmoney(self);
			var_0F = int(var_00 - int(var_00) % var_0D);
			var_00 = var_00 - var_0F;
			if(var_0F > var_0C)
			{
				var_0F = var_0C;
			}

			if(var_0F > 0)
			{
				maps\mp\gametypes\zombies::spendmoney(var_0F);
				if(!maps\mp\zombies\_zombies_audio_announcer::isanyannouncerspeaking() && !var_05 && playerplaysqvo(14))
				{
					var_05 = 1;
				}
			}
		}

		var_0C = maps\mp\gametypes\zombies::getcurrentmoney(self);
		if(!var_06 && var_0C > var_04)
		{
			var_06 = 1;
		}

		if(var_0C > 0 && var_0C < var_04 && var_07 < gettime())
		{
			if(var_06 && playerplaysqvo(15))
			{
				var_07 = gettime() + var_03;
				var_06 = 0;
			}
		}

		if(!var_0C && self isonground() && !self islinked())
		{
			if(var_08 < gettime())
			{
				if(playerplaysqvo(16))
				{
					var_08 = gettime() + var_02;
					if(!var_09)
					{
						level thread announcerozglobalplaysq(32);
						var_09 = 1;
					}
				}
			}

			self playerlinkto(level.zmbsqlinkent);
			self playerlinkedoffsetenable();
			var_01 = 1;
			continue;
		}

		if(var_0C && var_01)
		{
			self unlink();
			var_01 = 0;
		}
	}
}

//Function Number: 238
stage10_end(param_00)
{
	if(isdefined(level.zmbsqlinkent))
	{
		level.zmbsqlinkent delete();
	}

	level thread dochallengehudcomplete();
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Oz Challenge 3 - Movement is Costly");
}

//Function Number: 239
stage15_init()
{
}

//Function Number: 240
stage15_logic()
{
	announcerglobalplaysqvowaittilldone(11,1);
	wait(0.5);
	announcerozglobalplaysqwaittilldone(14);
	var_00 = undefined;
	var_01 = common_scripts\utility::getstruct("sqMemoryDevice","targetname");
	if(isdefined(var_01))
	{
		var_00 = spawn("script_model",var_01.origin);
		var_00 setmodel("tag_origin");
		var_00.angles = var_01.angles;
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_off"),var_00,"tag_origin");
	}

	var_02 = common_scripts\utility::getstruct("sqComputer","targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = 76;
	for(;;)
	{
		for(;;)
		{
			var_04 = var_02 maps\mp\zombies\_zombies_sidequests::fake_use("computer_used",undefined,undefined,"main_stage15_over",var_03);
			if(maps\mp\zombies\_util::is_true(level.zmbbosscountdowninprogress))
			{
				maps\mp\mp_zombie_h2o_aud::sndcomputerfail(var_02.origin);
				wait(1);
				continue;
			}

			thread maps\mp\mp_zombie_h2o_aud::sndusememorymachine(var_02);
			var_05 = maps\mp\zombies\_zombies_zone_manager::getplayersinzone("easter_egg",0);
			if(level.players.size == var_05.size)
			{
				if(isdefined(var_00))
				{
					maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_off"),var_00,"tag_origin");
					maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_on"),var_00,"tag_origin");
					maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_exo"),var_00,"tag_origin",1);
				}

				announcerglobalplaysqvowaittilldone(16);
				break;
			}
			else
			{
				maps\mp\mp_zombie_h2o_aud::sndcomputerfail(var_02.origin);
			}

			wait(1);
		}

		var_06 = runbussequence();
		if(maps\mp\zombies\_util::is_true(var_06))
		{
			break;
		}

		wait(1);
		if(isdefined(var_00))
		{
			maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_on"),var_00,"tag_origin");
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_off"),var_00,"tag_origin");
		}

		wait(2);
	}

	if(isdefined(var_00))
	{
		maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("sq_memory_machine_on"),var_00,"tag_origin");
	}

	foreach(var_04 in level.players)
	{
		if(var_04 maps\mp\_utility::isjuggernaut())
		{
			var_04 dodamage(var_04.mechhealth,var_04.origin);
		}

		if(isalive(var_04))
		{
			var_04 notify("stop_useHoldThinkLoop");
		}
	}

	wait(2);
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	maps\mp\zombies\_zombies_sidequests::stage_completed("main","stage15");
}

//Function Number: 241
stage15_end(param_00)
{
	level.zmbsqbusroundnum = undefined;
	level.zmbbossteleportdelay = undefined;
	maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed Bus Memory Sequence");
}

//Function Number: 242
runbussequence()
{
	level.zmbbossteleportdelay = 1;
	level.zone_data.zones["bus"].is_enabled = 1;
	maps\mp\zombies\_util::pausezombiespawning(1);
	level.zmbpauselightningflashes = 1;
	teleportplayerstobuszone();
	var_00 = runbusroundlogic();
	busroundcomplete();
	return var_00;
}

//Function Number: 243
monitorplayersleavebusarena()
{
	level endon("main_stage15_over");
	level endon("bus_round_complete");
	var_00 = getent("sqBusFloorTeleport","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isplayer(var_01))
		{
			level notify("bus_round_complete");
			return;
		}
	}
}

//Function Number: 244
monitorplayersalive()
{
	level endon("main_stage15_over");
	level endon("bus_round_complete");
	level waittill("bleedout");
	level notify("bus_round_complete");
}

//Function Number: 245
monitorplayerdisconnects()
{
	foreach(var_01 in level.players)
	{
		var_01 thread playernotifyondisconnectstage15();
	}
}

//Function Number: 246
playernotifyondisconnectstage15()
{
	level endon("main_stage15_over");
	level endon("bus_round_complete");
	self waittill("disconnect");
	level notify("bus_round_complete");
}

//Function Number: 247
busroundcomplete()
{
	level notify("bus_round_complete");
	teleportplayersback();
	if(isdefined(level.zmbsqpreviousspecialmutators))
	{
		maps\mp\zombies\_util::enablepickups();
		level.disablespawning = undefined;
		level.special_mutators = level.zmbsqpreviousspecialmutators;
		level.zmbsqpreviousspecialmutators = undefined;
		level.movemodefunc["zombie_generic"] = undefined;
		level.moveratescalefunc["zombie_generic"] = undefined;
		level.nonmoveratescalefunc["zombie_generic"] = undefined;
		level.traverseratescalefunc["zombie_generic"] = undefined;
		if(isdefined(level.zmbsqpreviousroundhealth))
		{
			var_00 = maps\mp\zombies\_util::agentclassget("zombie_generic");
			var_00.roundhealth = level.zmbsqpreviousroundhealth;
			level.zmbsqpreviousroundhealth = undefined;
		}

		var_01 = common_scripts\utility::getstructarray("sqBusPlayerSpawner","targetname");
		foreach(var_03 in var_01)
		{
			var_03.used = undefined;
		}
	}

	var_05 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	foreach(var_07 in var_05)
	{
		var_07 dodamage(var_07.health + 1,var_07.origin);
	}

	level.zone_data.zones["bus"].is_enabled = 0;
	maps\mp\zombies\_util::pausezombiespawning(0);
	level.zmbbossteleportdelay = undefined;
	level.zmbpauselightningflashes = undefined;
}

//Function Number: 248
runbusroundlogic()
{
	level endon("bus_round_complete");
	level common_scripts\utility::waittill_notify_or_timeout("sq_player_teleport_to_bus_zone",1.8);
	level thread spawncharactersstage15();
	level thread monitorplayersleavebusarena();
	level thread monitorplayersalive();
	level thread monitorplayerdisconnects();
	wait(1);
	var_00 = getcharacterbyprefixstage15("janitor");
	var_01 = getcharacterbyprefixstage15("it");
	var_02 = getcharacterbyprefixstage15("exec");
	var_03 = getcharacterbyprefixstage15("guard");
	var_01 playerplaysqvo(27,0.5,1);
	var_00 playerplaysqvo(35,0.5,1);
	var_01 playerplaysqvo(28,0.5,1);
	var_00 playerplaysqvo(36,0.5,1);
	maps\mp\zombies\_util::disablepickups();
	level.disablespawning = 1;
	level.zmbsqpreviousspecialmutators = level.special_mutators;
	level.special_mutators = [];
	maps\mp\zombies\zombies_spawn_manager::defaultmutatorsetup();
	level.movemodefunc["zombie_generic"] = ::calulatezombiemovemode;
	level.moveratescalefunc["zombie_generic"] = ::calculatezombiemoveratescale;
	level.nonmoveratescalefunc["zombie_generic"] = ::calculatezombienonmoveratescale;
	level.traverseratescalefunc["zombie_generic"] = ::calculatezombietraverseratescale;
	var_04 = maps\mp\zombies\_util::agentclassget("zombie_generic");
	level.zmbsqpreviousroundhealth = var_04.roundhealth;
	level.zmbsqbusroundnum = 12;
	var_04.roundhealth = calculatezombiehealth(var_04);
	var_05 = 100;
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		while(maps\mp\zombies\_util::iszombiegamepaused())
		{
			wait 0.05;
		}

		while(maps\mp\agents\_agent_utility::getnumactiveagents() >= level.maxenemycount)
		{
			wait(0.1);
		}

		var_07 = maps\mp\zombies\zombies_spawn_manager::spawnzombietype("zombie_generic",undefined,::applyzombiemutatorbusround);
		var_07.hastraversed = 1;
		wait(0.1);
	}

	for(var_08 = 1;var_08 > 0;var_08 = maps\mp\agents\_agent_utility::getnumactiveagents("zombie_generic"))
	{
		wait(0.1);
	}

	wait(2);
	var_00 playerplaysqvo(41,0.5,1);
	var_02 playerplaysqvo(29,0.5,1);
	var_00 playerplaysqvo(42,0.5,1);
	var_02 playerplaysqvo(30,0.5,1);
	var_00 playerplaysqvo(43,0.5,1);
	var_03 playerplaysqvo(28,0.5,1);
	var_00 playerplaysqvo(44,0.5,1);
	var_01 playerplaysqvo(31,0.5,1);
	var_03 playerplaysqvo(29,0.5,1);
	var_00 playerplaysqvo(45,0.5,1);
	var_02 playerplaysqvo(31,0.5,1);
	var_00 playerplaysqvo(46,0.5,1);
	var_00 playerplaysqvo(47,0.5,1);
	var_03 playerplaysqvo(30,0.5,1);
	level.zmbsqbusroundnum = 20;
	var_04.roundhealth = calculatezombiehealth(var_04);
	var_09 = 100;
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		while(maps\mp\zombies\_util::iszombiegamepaused())
		{
			wait 0.05;
		}

		while(maps\mp\agents\_agent_utility::getnumactiveagents() >= level.maxenemycount)
		{
			wait(0.1);
		}

		var_07 = maps\mp\zombies\zombies_spawn_manager::spawnzombietype("zombie_generic",undefined,::applyzombiemutatorbusround);
		var_07.hastraversed = 1;
		wait(0.1);
	}

	for(var_08 = 1;var_08 > 0;var_08 = maps\mp\agents\_agent_utility::getnumactiveagents("zombie_generic"))
	{
		wait(0.1);
	}

	wait(2);
	var_00 playerplaysqvo(48,0.5,1);
	var_00 playerplaysqvo(49,0.5,1);
	var_03 playerplaysqvo(31,0.5,1);
	var_00 playerplaysqvo(50,0.5,1);
	var_00 playerplaysqvo(51,0.5,1);
	var_00 playerplaysqvo(52,0.5,1);
	wait(1);
	return 1;
}

//Function Number: 249
getcharacterbyprefixstage15(param_00)
{
	var_01 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix(param_00);
	if(isdefined(var_01))
	{
		return var_01;
	}
	else
	{
		var_02 = maps\mp\zombies\_zombies_audio::getcharacterindexbyprefix(param_00);
		foreach(var_04 in level.zmbsqcharacters)
		{
			if(var_04.characterindex == var_02)
			{
				return var_04;
			}
		}
	}

	return level.players[0];
}

//Function Number: 250
applyzombiemutatorbusround(param_00)
{
	if(!isscriptedagent(param_00))
	{
		return;
	}

	var_01 = param_00 maps\mp\zombies\zombies_spawn_manager::specialmutatorshouldapply(level.zmbsqbusroundnum);
	var_02 = [];
	var_03 = param_00 maps\mp\zombies\zombies_spawn_manager::exomutatorshouldapply(level.zmbsqbusroundnum) || var_01;
	if(var_03)
	{
		param_00 thread maps\mp\zombies\_mutators::mutator_apply("exo");
	}

	if(var_01)
	{
		var_04 = [];
		var_05 = 0;
		foreach(var_0A, var_07 in level.special_mutators)
		{
			var_08 = var_07[0];
			var_09 = var_07[1];
			if(isdefined(level.mutators_disabled[param_00.agent_type]))
			{
				if(isdefined(level.mutators_disabled[param_00.agent_type][var_0A]) && level.mutators_disabled[param_00.agent_type][var_0A])
				{
					continue;
				}
			}

			if(param_00 [[ var_08 ]](level.zmbsqbusroundnum))
			{
				var_04[var_04.size] = var_0A;
				var_05 = var_05 + var_09;
			}
		}

		var_0B = randomfloat(var_05);
		var_0C = 0;
		foreach(var_0A in var_04)
		{
			var_09 = level.special_mutators[var_0A][1];
			if(var_0B > var_0C && var_0B <= var_0C + var_09)
			{
				param_00 thread maps\mp\zombies\_mutators::mutator_apply(var_0A);
				break;
			}

			var_0C = var_0C + var_09;
		}
	}
}

//Function Number: 251
spawncharactersstage15()
{
	level.zmbsqcharacters = [];
	setupcharacterlogic();
	maps\mp\zombies\_util::initializecharactermodel("janitor","janitor_body_dlc2","viewhands_janitor",["janitor_head_dlc2"]);
	maps\mp\zombies\_util::initializecharactermodel("janitor_exo","janitor_body_exo_dlc2","viewhands_janitor_exo",["janitor_head_dlc2"]);
	var_00 = getanyplayer();
	var_01 = getnumplayersalive();
	var_02 = 4 - var_01;
	if(var_02 > 0)
	{
		var_03 = getbuszonecharacterspawns();
		spawncharacters(var_00,var_02,level.playerteam,var_03);
		var_04 = getanyplayer();
		foreach(var_06 in level.zmbsqcharacters)
		{
			var_06.bypassagentcorpse = 1;
			var_06.godmode = 1;
			var_06.fakeplayer = 1;
			var_06 maps\mp\zombies\_util::setcharacteraudio(var_06.characterindex,1);
		}
	}

	var_08 = getcharacterbyindex(3,level.players);
	if(!isdefined(var_08))
	{
		var_08 = getcharacterbyindex(3,level.zmbsqcharacters);
	}

	if(isplayer(var_08))
	{
		var_08 maps\mp\zombies\_util::setcharacteraudio(3,1);
	}

	var_09 = !isplayer(var_08);
	var_0A = "janitor";
	if(maps\mp\zombies\_util::is_true(var_08.exosuitonline) || !isplayer(var_08))
	{
		var_0A = "janitor_exo";
	}

	var_08 thread maps\mp\zombies\_util::setcharactermodel(var_0A,1,var_09);
	level waittill("bus_round_complete");
	if(isplayer(var_08))
	{
		if(isalive(var_08))
		{
			var_0A = "pilot";
			if(maps\mp\zombies\_util::is_true(var_08.exosuitonline))
			{
				var_0A = "pilot_exo";
			}

			var_08 thread maps\mp\zombies\_util::setcharactermodel(var_0A,1);
		}

		var_08 maps\mp\zombies\_util::setcharacteraudio(3,0);
	}

	despawncharacters();
}

//Function Number: 252
getprefixbycharacterindex(param_00)
{
	switch(param_00)
	{
		case 0:
			return "guard";

		case 1:
			return "exec";

		case 2:
			return "it";

		case 3:
			return "janitor";
	}
}

//Function Number: 253
getbuszonecharacterspawns()
{
	var_00 = common_scripts\utility::getstructarray("sqBusPlayerSpawner","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!maps\mp\zombies\_util::is_true(var_03.used))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 254
getnumplayersalive()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(isalive(var_02))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 255
getcharacterbyindex(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(isdefined(var_03.characterindex) && var_03.characterindex == param_00)
		{
			return var_03;
		}
	}
}

//Function Number: 256
calculatezombiehealth(param_00)
{
	var_01 = 150;
	if(level.zmbsqbusroundnum == 1)
	{
		var_02 = var_01;
	}
	else if(level.zmbsqbusroundnum <= 9)
	{
		var_02 = var_02 + level.zmbsqbusroundnum - 1 * 100;
	}
	else
	{
		var_03 = 950;
		var_04 = level.zmbsqbusroundnum - 9;
		var_02 = var_03 * pow(1.1,var_04);
	}

	var_02 = int(var_02 * param_00.health_scale);
	return var_02;
}

//Function Number: 257
calulatezombiemovemode()
{
	var_00 = 7;
	var_01 = calculatezombieroundindex(var_00);
	var_02 = int(var_01 / var_00);
	return level.zombie_move_modes[int(clamp(var_02,0,level.zombie_move_modes.size - 1))];
}

//Function Number: 258
calculatezombiemoveratescale()
{
	var_00 = 7;
	var_01 = calculatezombieroundindex(var_00);
	var_02 = var_01 % var_00;
	var_03 = float(var_02) / float(var_00 - 1);
	var_04 = maps\mp\zombies\_util::lerp(var_03,level.moveratescalemod[self.movemode][0],level.moveratescalemod[self.movemode][1]);
	if(level.zmbsqbusroundnum > 24)
	{
		var_04 = var_04 + 0.05;
	}

	if(level.zmbsqbusroundnum > 29)
	{
		var_04 = var_04 + 0.05;
	}

	var_04 = var_04 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
	return var_04;
}

//Function Number: 259
calculatezombienonmoveratescale()
{
	var_00 = level.nonmoveratescalemod[self.movemode];
	var_00 = var_00 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
	return var_00;
}

//Function Number: 260
calculatezombietraverseratescale()
{
	var_00 = 7;
	var_01 = calculatezombieroundindex(var_00);
	var_02 = var_01 / level.zombie_move_modes.size * var_00 - 1;
	var_03 = maps\mp\zombies\_util::lerp(var_02,level.traverseratescalemod[0],level.traverseratescalemod[1]);
	if(level.zmbsqbusroundnum > 24)
	{
		var_03 = var_03 + 0.05;
	}

	if(level.zmbsqbusroundnum > 29)
	{
		var_03 = var_03 + 0.05;
	}

	var_03 = var_03 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
	return var_03;
}

//Function Number: 261
calculatezombieroundindex(param_00)
{
	var_01 = level.zmbsqbusroundnum - 1;
	if(isdefined(self.moverateroundmod))
	{
		var_01 = var_01 + self.moverateroundmod;
	}

	var_01 = int(clamp(var_01,0,level.zombie_move_modes.size * param_00 - 1));
	return var_01;
}

//Function Number: 262
teleportplayerstobuszone()
{
	level thread hideshowkillstreakicons();
	var_00 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	foreach(var_02 in var_00)
	{
		var_02 dodamage(var_02.health + 500000,var_02.origin);
	}

	var_04 = common_scripts\utility::getstructarray("sqBusPlayerSpawner","targetname");
	if(!isdefined(var_04))
	{
		var_04 = [];
		var_05 = spawnstruct();
		var_05.origin = (764,-68,152);
		var_05.angles = (0,190,0);
		var_04[var_04.size] = var_05;
		var_04[var_04.size] = var_05;
		var_04[var_04.size] = var_05;
		var_04[var_04.size] = var_05;
	}

	for(var_06 = 0;var_06 < level.players.size;var_06++)
	{
		level.players[var_06] thread playerteleporttobuszone(var_04[var_06]);
	}

	level thread maps\mp\mp_zombie_h2o_aud::sndbusmusic();
	stopclientexploder(60);
}

//Function Number: 263
playerteleporttobuszone(param_00)
{
	if(!isdefined(self.memorytunnelfx))
	{
		self.memorytunnelfx = spawnfxforclient(common_scripts\utility::getfx("sq_memory_tunnel_player"),self.origin,self);
		self.memorytunnelfx thread teleportfxdelete(self);
	}

	triggerfx(self.memorytunnelfx);
	self.disabletombstonedropinarea = 1;
	param_00.used = 1;
	maps\mp\zombies\_teleport::teleport_players_through_chute([self],0,1);
	thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self],0.75);
	self setorigin(param_00.origin,1);
	self setplayerangles(param_00.angles);
	self setclientomnvar("ui_zm_ee_bool2",1);
	self.inbuszone = 1;
	level notify("sq_player_teleport_to_bus_zone");
	thread maps\mp\mp_zombie_h2o_aud::sndteleporttobuszone();
}

//Function Number: 264
teleportfxdelete(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 265
teleportplayersback()
{
	var_00 = common_scripts\utility::getstructarray("sqExoCorePlayerSpawner","targetname");
	if(!isdefined(var_00))
	{
		var_00 = [];
		var_01 = spawnstruct();
		var_01.origin = (452,2968,-92);
		var_01.angles = (0,190,0);
		var_00[var_00.size] = var_01;
		var_00[var_00.size] = var_01;
		var_00[var_00.size] = var_01;
		var_00[var_00.size] = var_01;
	}

	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		level.players[var_02] thread playerteleportback(var_00[var_02]);
	}

	activatepersistentclientexploder(60);
}

//Function Number: 266
playerteleportback(param_00)
{
	if(!isdefined(self.memorytunnelfx))
	{
		self.memorytunnelfx = spawnfxforclient(common_scripts\utility::getfx("sq_memory_tunnel_player"),self.origin,self);
		self.memorytunnelfx thread teleportfxdelete(self);
	}

	triggerfx(self.memorytunnelfx);
	maps\mp\zombies\_teleport::teleport_players_through_chute([self],0,1);
	thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self],0.75);
	self setorigin(param_00.origin,1);
	self setplayerangles(param_00.angles);
	self setclientomnvar("ui_zm_ee_bool2",0);
	self.inbuszone = undefined;
	level notify("sq_teleport_players_back");
	self.disabletombstonedropinarea = undefined;
}

//Function Number: 267
hideshowkillstreakicons()
{
	level.disablecarepackagedrops = 1;
	wait 0.05;
	var_00 = getentarray("care_package","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread carepackagehidehudicon();
	}

	var_04 = getentarray("goliath_pod_model","targetname");
	foreach(var_06 in var_04)
	{
		var_06 thread carepackagehidehudicon();
	}

	level waittill("sq_teleport_players_back");
	level.disablecarepackagedrops = undefined;
}

//Function Number: 268
carepackagehidehudicon()
{
	level endon("sq_teleport_players_back");
	self endon("death");
	while(!isdefined(self.entityheadicons) || self.entityheadicons.size == 0)
	{
		wait 0.05;
	}

	foreach(var_01 in self.entityheadicons)
	{
		var_01.alpha = 0;
	}

	thread carepackagedelayshowhudicon();
}

//Function Number: 269
carepackagedelayshowhudicon()
{
	self endon("death");
	level waittill("sq_teleport_players_back");
	if(isdefined(self.entityheadicons))
	{
		foreach(var_01 in self.entityheadicons)
		{
			var_01.alpha = 1;
		}
	}
}

//Function Number: 270
init_song_sidequest()
{
	level.sq_song_ent = getent("sq_song","targetname");
	if(!isdefined(level.sq_song_ent))
	{
		level.sq_song_ent = spawn("script_model",(0,0,0));
	}
}

//Function Number: 271
sidequest_logic_song()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage1");
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage2");
	maps\mp\zombies\_zombies_sidequests::stage_start("song","stage3");
	var_03 = 0;
	for(;;)
	{
		var_04 = level common_scripts\utility::waittill_any_return_no_endon_death("song_stage1_over","song_stage2_over","song_stage3_over");
		var_03++;
		if(var_03 < 3)
		{
			thread song_play(var_03);
			continue;
		}

		song_play(2);
		thread song_play();
		break;
	}
}

//Function Number: 272
song_play(param_00)
{
	level notify("sq_song_play");
	level endon("sq_song_play");
	level endon("sq_song_stop");
	if(maps\mp\zombies\_util::is_true(level.sq_song_ent.playing))
	{
		level.sq_song_ent stopsounds();
		level.sq_song_ent.playing = 0;
		wait(0.2);
	}

	var_01 = "zmb_mus_ee_05";
	if(!isdefined(param_00) || param_00 <= 0)
	{
		param_00 = musiclength("zmb_mus_ee_05");
	}
	else
	{
		var_01 = "zmb_mus_ee_05_prvw";
	}

	level.sq_song_ent playsoundonmovingent(var_01);
	level.sq_song_ent.playing = 1;
	wait(param_00);
	level.sq_song_ent stopsounds();
	level.sq_song_ent.playing = 0;
}

//Function Number: 273
song_stop()
{
	level.sq_song_ent stopsounds();
	level.sq_song_ent.playing = 0;
	level notify("sq_song_stop");
}

//Function Number: 274
song_fake_use(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.origin = param_00;
	var_04 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated",undefined,undefined,"song_stage" + param_01 + "_over",param_02,param_03);
	var_04 waittill("activated",var_05);
	return var_05;
}

//Function Number: 275
songstage1_init()
{
}

//Function Number: 276
songstage1_logic()
{
	var_00 = song_fake_use((-550,2719,-76),1,100,1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage1");
}

//Function Number: 277
songstage1_end(param_00)
{
}

//Function Number: 278
songstage2_init()
{
}

//Function Number: 279
songstage2_logic()
{
	var_00 = song_fake_use((-2000,4506,836),2,100,1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage2");
}

//Function Number: 280
songstage2_end(param_00)
{
}

//Function Number: 281
songstage3_init()
{
}

//Function Number: 282
songstage3_logic()
{
	var_00 = song_fake_use((-512,69,181.1),3,160,1);
	maps\mp\zombies\_zombies_sidequests::stage_completed("song","stage3");
}

//Function Number: 283
songstage3_end(param_00)
{
}

//Function Number: 284
musiclength(param_00)
{
	var_01 = tablelookup("mp/sound/soundlength_zm_mp_dlc4.csv",0,param_00,1);
	if(!isdefined(var_01) || var_01 == "")
	{
		return 2;
	}

	var_01 = int(var_01);
	var_01 = var_01 * 0.001;
	return var_01;
}

//Function Number: 285
dofakevo(param_00)
{
	iprintlnbold(param_00);
}

//Function Number: 286
dofakevomultiline(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	dofakevo(param_00);
	if(isdefined(param_01))
	{
		wait(3);
		dofakevo(param_01);
	}

	if(isdefined(param_02))
	{
		wait(3);
		dofakevo(param_02);
	}

	if(isdefined(param_03))
	{
		wait(3);
		dofakevo(param_03);
	}

	if(isdefined(param_04))
	{
		wait(3);
		dofakevo(param_04);
	}

	if(isdefined(param_05))
	{
		wait(3);
		dofakevo(param_05);
	}

	if(isdefined(param_06))
	{
		wait(3);
		dofakevo(param_06);
	}

	if(isdefined(param_07))
	{
		wait(3);
		dofakevo(param_07);
	}

	if(isdefined(param_08))
	{
		wait(3);
		dofakevo(param_08);
	}
}

//Function Number: 287
playerplaysqvo(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	self endon("death");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(maps\mp\zombies\_util::is_true(self.speaking))
	{
		self waittill("done_speaking");
	}

	if(!isdefined(param_03))
	{
		param_03 = "sq";
	}

	var_04 = maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq",param_03,undefined,param_00);
	if(var_04 && maps\mp\zombies\_util::is_true(param_02))
	{
		wait 0.05;
		waittillplayerdonespeaking(self);
	}

	return var_04;
}

//Function Number: 288
waittillplayerdonespeaking(param_00)
{
	param_00 endon("disconnect");
	if(maps\mp\zombies\_util::is_true(param_00.isspeaking))
	{
		param_00 waittill("done_speaking");
	}
}

//Function Number: 289
playsqvowaittilldone(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix(param_00);
	if(isdefined(var_04))
	{
		var_05 = var_04 playerplaysqvo(param_01,param_02,1);
		if(isdefined(param_03))
		{
			wait(param_03);
		}

		return var_05;
	}

	return 0;
}

//Function Number: 290
announcerinworldplaysqvowaittilldone(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_02) && param_02 > 0)
	{
		wait(param_02);
	}

	if(!isdefined(param_03))
	{
		param_03 = level.players;
	}

	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
	maps\mp\zombies\_zombies_audio_announcer::announcerinworlddialog("machine_all_players","sq",param_01,undefined,param_00,undefined,undefined,param_03);
	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

//Function Number: 291
announcerglobalplaysqvo(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(!isdefined(param_02))
	{
		param_02 = level.players;
	}

	if(!isdefined(param_03))
	{
		param_03 = "sq";
	}

	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
	maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority",param_03,undefined,param_00,1,undefined,param_02);
}

//Function Number: 292
announcerglobalplaysqvowaittilldone(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = level.players;
	}

	announcerglobalplaysqvo(param_00,param_01,param_02);
	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

//Function Number: 293
announcerozglobalplaysqwaittilldone(param_00)
{
	announcerozglobalplaysq(param_00);
	waittillannouncerozdonespeaking();
}

//Function Number: 294
announcerozglobalplaysq(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	if(!isdefined(param_02))
	{
		param_02 = level.players;
	}

	waittilldonespeaking();
	var_03 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
	return var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","sq",undefined,param_00,1,undefined,param_02);
}

//Function Number: 295
announcerozinworldplaysq(param_00,param_01,param_02)
{
	waittilldonespeaking();
	var_03 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
	var_03.origin = param_00;
	wait 0.05;
	if(isdefined(param_02))
	{
		param_02 = common_scripts\utility::array_removeundefined(param_02);
	}

	return var_03 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players","sq",undefined,param_01,1,undefined,param_02);
}

//Function Number: 296
waittillannouncerozdonespeaking(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
	}

	if(maps\mp\zombies\_util::is_true(param_00.isspeaking))
	{
		param_00 waittill("done_speaking");
	}
}

//Function Number: 297
announcerozglobalplaysqfailchallenge()
{
	if(!isdefined(level.sqozwonchallengevo) || level.sqozwonchallengevoindex >= level.sqozwonchallengevo.size)
	{
		level.sqozwonchallengevo = common_scripts\utility::array_randomize([3,4,5,6,7,8,9,10]);
		level.sqozwonchallengevoindex = 0;
	}

	announcerozglobalplaysq(level.sqozwonchallengevo[level.sqozwonchallengevoindex]);
	level.sqozwonchallengevoindex++;
}

//Function Number: 298
anyplayersspeaking()
{
	foreach(var_01 in level.players)
	{
		if(maps\mp\zombies\_util::is_true(var_01.isspeaking))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 299
waittilldonespeaking()
{
	while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isanyannouncerspeaking())
	{
		wait 0.05;
	}
}