/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_music_and_dialog.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 332 ms
 * Timestamp: 10/27/2023 1:18:50 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	game["music"]["spawn_allies"] = "mus_us_spawn";
	game["music"]["defeat_allies"] = "mus_us_defeat";
	game["music"]["victory_allies"] = "mus_us_victory";
	game["music"]["winning_allies"] = "mus_us_winning";
	game["music"]["losing_allies"] = "mus_us_losing";
	game["voice"]["allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "1mc_";
	game["music"]["allies_used_nuke"] = "mus_us_nuke_fired";
	game["music"]["allies_hit_by_nuke"] = "mus_us_nuke_hit";
	game["music"]["draw_allies"] = "mus_us_draw";
	game["music"]["spawn_axis"] = "mus_fd_spawn";
	game["music"]["defeat_axis"] = "mus_fd_defeat";
	game["music"]["victory_axis"] = "mus_fd_victory";
	game["music"]["winning_axis"] = "mus_fd_winning";
	game["music"]["losing_axis"] = "mus_fd_losing";
	game["voice"]["axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "1mc_";
	game["music"]["axis_used_nuke"] = "mus_fd_nuke_fired";
	game["music"]["axis_hit_by_nuke"] = "mus_fd_nuke_hit";
	game["music"]["draw_axis"] = "mus_fd_draw";
	game["music"]["losing_time"] = "mp_time_running_out_losing";
	game["music"]["allies_suspense"] = [];
	game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_01";
	game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_02";
	game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_03";
	game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_04";
	game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_05";
	game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_us_suspense_06";
	game["music"]["axis_suspense"] = [];
	game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_01";
	game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_02";
	game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_03";
	game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_04";
	game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_05";
	game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_fd_suspense_06";
	game["dialog"]["mission_success"] = "mission_success";
	game["dialog"]["mission_failure"] = "mission_fail";
	game["dialog"]["mission_draw"] = "draw";
	game["dialog"]["round_success"] = "encourage_win";
	game["dialog"]["round_failure"] = "encourage_lost";
	game["dialog"]["round_draw"] = "draw";
	game["dialog"]["timesup"] = "timesup";
	game["dialog"]["winning_time"] = "winning";
	game["dialog"]["losing_time"] = "losing";
	game["dialog"]["winning_score"] = "winning_fight";
	game["dialog"]["losing_score"] = "losing_fight";
	game["dialog"]["lead_lost"] = "lead_lost";
	game["dialog"]["lead_tied"] = "tied";
	game["dialog"]["lead_taken"] = "lead_taken";
	game["dialog"]["last_alive"] = "lastalive";
	game["dialog"]["boost"] = "boost";
	if(!isdefined(game["dialog"]["offense_obj"]))
	{
		game["dialog"]["offense_obj"] = "boost";
	}

	if(!isdefined(game["dialog"]["defense_obj"]))
	{
		game["dialog"]["defense_obj"] = "boost";
	}

	game["dialog"]["hardcore"] = "hardcore";
	game["dialog"]["highspeed"] = "highspeed";
	game["dialog"]["tactical"] = "tactical";
	game["dialog"]["challenge"] = "challengecomplete";
	game["dialog"]["promotion"] = "promotion";
	game["dialog"]["bomb_taken"] = "acheive_bomb";
	game["dialog"]["bomb_lost"] = "bomb_taken";
	game["dialog"]["bomb_defused"] = "bomb_defused";
	game["dialog"]["bomb_defused_axis"] = "bomb_defused_axis";
	game["dialog"]["bomb_defused_allies"] = "bomb_defused_allies";
	game["dialog"]["bomb_planted"] = "bomb_planted";
	game["dialog"]["obj_taken"] = "securedobj";
	game["dialog"]["obj_lost"] = "lostobj";
	game["dialog"]["obj_defend"] = "obj_defend";
	game["dialog"]["obj_destroy"] = "obj_destroy";
	game["dialog"]["obj_capture"] = "capture_obj";
	game["dialog"]["objs_capture"] = "capture_objs";
	game["dialog"]["hq_located"] = "hq_located";
	game["dialog"]["hq_enemy_captured"] = "hq_captured";
	game["dialog"]["hq_enemy_destroyed"] = "hq_destroyed";
	game["dialog"]["hq_secured"] = "hq_secured";
	game["dialog"]["hq_offline"] = "hq_offline";
	game["dialog"]["hq_online"] = "hq_online";
	game["dialog"]["move_to_new"] = "new_positions";
	game["dialog"]["push_forward"] = "pushforward";
	game["dialog"]["attack"] = "attack";
	game["dialog"]["defend"] = "defend";
	game["dialog"]["offense"] = "offense";
	game["dialog"]["defense"] = "defense";
	game["dialog"]["halftime"] = "halftime";
	game["dialog"]["overtime"] = "overtime";
	game["dialog"]["side_switch"] = "switching";
	game["dialog"]["flag_taken"] = "ourflag";
	game["dialog"]["flag_dropped"] = "ourflag_drop";
	game["dialog"]["flag_returned"] = "ourflag_return";
	game["dialog"]["flag_captured"] = "ourflag_capt";
	game["dialog"]["flag_getback"] = "getback_ourflag";
	game["dialog"]["enemy_flag_bringhome"] = "enemyflag_tobase";
	game["dialog"]["enemy_flag_taken"] = "enemyflag";
	game["dialog"]["enemy_flag_dropped"] = "enemyflag_drop";
	game["dialog"]["enemy_flag_returned"] = "enemyflag_return";
	game["dialog"]["enemy_flag_captured"] = "enemyflag_capt";
	game["dialog"]["got_flag"] = "achieve_flag";
	game["dialog"]["dropped_flag"] = "lost_flag";
	game["dialog"]["enemy_got_flag"] = "enemy_has_flag";
	game["dialog"]["enemy_dropped_flag"] = "enemy_dropped_flag";
	game["dialog"]["capturing_a"] = "capturing_a";
	game["dialog"]["capturing_b"] = "capturing_b";
	game["dialog"]["capturing_c"] = "capturing_c";
	game["dialog"]["captured_a"] = "capture_a";
	game["dialog"]["captured_b"] = "capture_c";
	game["dialog"]["captured_c"] = "capture_b";
	game["dialog"]["securing_a"] = "securing_a";
	game["dialog"]["securing_b"] = "securing_b";
	game["dialog"]["securing_c"] = "securing_c";
	game["dialog"]["secured_a"] = "secure_a";
	game["dialog"]["secured_b"] = "secure_b";
	game["dialog"]["secured_c"] = "secure_c";
	game["dialog"]["losing_a"] = "losing_a";
	game["dialog"]["losing_b"] = "losing_b";
	game["dialog"]["losing_c"] = "losing_c";
	game["dialog"]["lost_a"] = "lost_a";
	game["dialog"]["lost_b"] = "lost_b";
	game["dialog"]["lost_c"] = "lost_c";
	game["dialog"]["enemy_taking_a"] = "enemy_take_a";
	game["dialog"]["enemy_taking_b"] = "enemy_take_b";
	game["dialog"]["enemy_taking_c"] = "enemy_take_c";
	game["dialog"]["enemy_has_a"] = "enemy_has_a";
	game["dialog"]["enemy_has_b"] = "enemy_has_b";
	game["dialog"]["enemy_has_c"] = "enemy_has_c";
	game["dialog"]["lost_all"] = "take_positions";
	game["dialog"]["secure_all"] = "positions_lock";
	game["dialog"]["losing_target"] = "enemy_capture";
	game["dialog"]["lost_target"] = "lost_target";
	game["dialog"]["taking_target"] = "capturing_target";
	game["dialog"]["took_target"] = "achieve_target";
	game["dialog"]["defcon_raised"] = "defcon_raised";
	game["dialog"]["defcon_lowered"] = "defcon_lowered";
	game["dialog"]["one_minute_left"] = "one_minute";
	game["dialog"]["thirty_seconds_left"] = "thirty_seconds";
	game["music"]["nuke_music"] = "nuke_music";
	game["dialog"]["sentry_destroyed"] = "sentry_destroyed";
	game["dialog"]["sentry_gone"] = "sentry_gone";
	game["dialog"]["ti_destroyed"] = "ti_blocked";
	game["dialog"]["ti_gone"] = "ti_cancelled";
	game["dialog"]["ims_destroyed"] = "ims_destroyed";
	game["dialog"]["satcom_destroyed"] = "satcom_destroyed";
	game["dialog"]["ballistic_vest_destroyed"] = "ballistic_vest_destroyed";
	game["dialog"]["ammocrate_destroyed"] = "ammocrate_destroyed";
	game["dialog"]["ammocrate_gone"] = "ammocrate_gone";
	game["dialog"]["achieve_carepackage"] = "achieve_carepackage";
	game["dialog"]["gryphon_destroyed"] = "gryphon_destroyed";
	game["dialog"]["gryphon_gone"] = "gryphon_gone";
	game["dialog"]["vulture_destroyed"] = "vulture_destroyed";
	game["dialog"]["vulture_gone"] = "vulture_gone";
	game["dialog"]["nowl_destroyed"] = "nowl_destroyed";
	game["dialog"]["nowl_gone"] = "nowl_gone";
	game["dialog"]["oracle_gone"] = "oracle_gone";
	game["dialog"]["dog_gone"] = "dog_gone";
	game["dialog"]["dog_killed"] = "dog_killed";
	game["dialog"]["squad_gone"] = "squad_gone";
	game["dialog"]["squad_killed"] = "squad_killed";
	game["dialog"]["odin_gone"] = "odin_gone";
	game["dialog"]["odin_carepackage"] = "odin_carepackage";
	game["dialog"]["odin_marking"] = "odin_marking";
	game["dialog"]["odin_marked"] = "odin_marked";
	game["dialog"]["odin_m_marked"] = "odin_m_marked";
	game["dialog"]["odin_smoke"] = "odin_smoke";
	game["dialog"]["odin_moving"] = "odin_moving";
	game["dialog"]["loki_gone"] = "loki_gone";
	game["dialog"]["odin_target_killed"] = "odin_target_killed";
	game["dialog"]["odin_targets_killed"] = "odin_targets_killed";
	game["dialog"]["claymore_destroyed"] = "null";
	game["dialog"]["mine_destroyed"] = "null";
	level thread func_595D();
	level thread func_594A();
	level thread func_5543();
	level thread func_593F();
	level thread func_5970();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
		var_00 thread finalkillcammusic();
		var_00 thread watchhostmigration();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	if(!isai(self))
	{
		self waittill("spawned_player");
		thread dointro();
	}
}

//Function Number: 4
dointro()
{
	level endon("host_migration_begin");
	if(!level.splitscreen || level.splitscreen && !isdefined(level.playedstartingmusic))
	{
		if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
		{
			self playlocalsound(game["music"]["spawn_" + self.team]);
		}

		if(level.splitscreen)
		{
			level.playedstartingmusic = 1;
		}
	}

	if(isdefined(game["dialog"]["gametype"]) && !level.splitscreen || self == level.players[0])
	{
		if(isdefined(game["dialog"]["allies_gametype"]) && self.team == "allies")
		{
			maps\mp\_utility::func_4D35("allies_gametype");
		}
		else if(isdefined(game["dialog"]["axis_gametype"]) && self.team == "axis")
		{
			maps\mp\_utility::func_4D35("axis_gametype");
		}
		else if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
		{
			maps\mp\_utility::func_4D35("gametype");
		}
	}

	maps\mp\_utility::gameflagwait("prematch_done");
	if(!isdefined(self))
	{
	}

	if(self.team == game["attackers"])
	{
		if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
		{
			maps\mp\_utility::func_4D35("offense_obj","introboost");
		}
	}

	if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
	{
		maps\mp\_utility::func_4D35("defense_obj","introboost");
	}
}

//Function Number: 5
watchhostmigration()
{
	self endon("disconnect");
	level endon("grace_period_ending");
	for(;;)
	{
		level waittill("host_migration_begin");
		var_00 = level.ingraceperiod;
		level waittill("host_migration_end");
		if(var_00)
		{
			thread dointro();
		}
	}
}

//Function Number: 6
func_594A()
{
	level endon("game_ended");
	level waittill("last_alive",var_00);
	if(!isalive(var_00))
	{
	}

	var_00 maps\mp\_utility::func_4D35("last_alive");
}

//Function Number: 7
func_5970()
{
	level waittill("round_switch",var_00);
	switch(var_00)
	{
		case "halftime":
			foreach(var_02 in level.players)
			{
				if(var_02 issplitscreenplayer() && !var_02 issplitscreenplayerprimary())
				{
					continue;
				}
	
				var_02 maps\mp\_utility::func_4D35("halftime");
			}
			break;

		case "overtime":
			foreach(var_02 in level.players)
			{
				if(var_02 issplitscreenplayer() && !var_02 issplitscreenplayerprimary())
				{
					continue;
				}
	
				var_02 maps\mp\_utility::func_4D35("overtime");
			}
			break;

		default:
			foreach(var_02 in level.players)
			{
				if(var_02 issplitscreenplayer() && !var_02 issplitscreenplayerprimary())
				{
					continue;
				}
	
				var_02 maps\mp\_utility::func_4D35("side_switch");
			}
			break;
	}
}

//Function Number: 8
func_593F()
{
	level thread roundwinnerdialog();
	level thread func_3708();
	level waittill("game_win",var_00);
	if(level.teambased)
	{
		if(level.splitscreen)
		{
			if(var_00 == "allies")
			{
				maps\mp\_utility::func_6045(game["music"]["victory_allies"],"allies");
			}

			if(var_00 == "axis")
			{
				maps\mp\_utility::func_6045(game["music"]["victory_axis"],"axis");
			}

			maps\mp\_utility::func_6045(game["music"]["nuke_music"]);
		}

		if(var_00 == "allies")
		{
			maps\mp\_utility::func_6045(game["music"]["victory_allies"],"allies");
			maps\mp\_utility::func_6045(game["music"]["defeat_axis"],"axis");
		}

		if(var_00 == "axis")
		{
			maps\mp\_utility::func_6045(game["music"]["victory_axis"],"axis");
			maps\mp\_utility::func_6045(game["music"]["defeat_allies"],"allies");
		}

		maps\mp\_utility::func_6045(game["music"]["draw_axis"],"axis");
		maps\mp\_utility::func_6045(game["music"]["draw_allies"],"allies");
	}

	foreach(var_02 in level.players)
	{
		if(var_02 issplitscreenplayer() && !var_02 issplitscreenplayerprimary())
		{
			continue;
		}

		if(var_02.pers["team"] != "allies" && var_02.pers["team"] != "axis")
		{
			var_02 playlocalsound(game["music"]["nuke_music"]);
			continue;
		}

		if(isdefined(var_00) && isplayer(var_00) && var_02 == var_00)
		{
			var_02 playlocalsound(game["music"]["victory_" + var_02.pers["team"]]);
			continue;
		}

		if(!level.splitscreen)
		{
			var_02 playlocalsound(game["music"]["defeat_" + var_02.pers["team"]]);
		}
	}
}

//Function Number: 9
roundwinnerdialog()
{
	level waittill("round_win",var_00);
	var_01 = level.roundenddelay / 4;
	if(var_01 > 0)
	{
		wait(var_01);
	}

	if(!isdefined(var_00) || isplayer(var_00))
	{
	}

	if(var_00 == "allies")
	{
		maps\mp\_utility::func_4D30("round_success","allies");
		maps\mp\_utility::func_4D30("round_failure","axis");
	}

	if(var_00 == "axis")
	{
		maps\mp\_utility::func_4D30("round_success","axis");
		maps\mp\_utility::func_4D30("round_failure","allies");
	}
}

//Function Number: 10
func_3708()
{
	level waittill("game_win",var_00);
	var_01 = level.postroundtime / 2;
	if(var_01 > 0)
	{
		wait(var_01);
	}

	if(!isdefined(var_00) || isplayer(var_00))
	{
	}

	if(var_00 == "allies")
	{
		maps\mp\_utility::func_4D30("mission_success","allies");
		maps\mp\_utility::func_4D30("mission_failure","axis");
	}

	if(var_00 == "axis")
	{
		maps\mp\_utility::func_4D30("mission_success","axis");
		maps\mp\_utility::func_4D30("mission_failure","allies");
	}

	maps\mp\_utility::func_4D30("mission_draw");
}

//Function Number: 11
func_5543()
{
	level endon("game_ended");
	level.musicenabled = 1;
	thread func_7D8A();
	level waittill("match_ending_soon",var_00);
	if(maps\mp\_utility::getwatcheddvar("roundlimit") == 1 || game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar("roundlimit") - 1 || maps\mp\_utility::func_4912())
	{
		if(!level.splitscreen)
		{
			if(var_00 == "time")
			{
				if(level.teambased)
				{
					if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
					{
						if(ismusicenabled())
						{
							maps\mp\_utility::func_6045(game["music"]["winning_allies"],"allies");
							maps\mp\_utility::func_6045(game["music"]["losing_axis"],"axis");
						}

						maps\mp\_utility::func_4D30("winning_time","allies");
						maps\mp\_utility::func_4D30("losing_time","axis");
					}
					else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::func_6045(game["music"]["winning_axis"],"axis");
							maps\mp\_utility::func_6045(game["music"]["losing_allies"],"allies");
						}

						maps\mp\_utility::func_4D30("winning_time","axis");
						maps\mp\_utility::func_4D30("losing_time","allies");
					}
				}
				else
				{
					if(ismusicenabled())
					{
						maps\mp\_utility::func_6045(game["music"]["losing_time"]);
					}

					maps\mp\_utility::func_4D30("timesup");
				}
			}
			else if(var_00 == "score")
			{
				if(level.teambased)
				{
					if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
					{
						if(ismusicenabled())
						{
							maps\mp\_utility::func_6045(game["music"]["winning_allies"],"allies");
							maps\mp\_utility::func_6045(game["music"]["losing_axis"],"axis");
						}

						maps\mp\_utility::func_4D30("winning_score","allies");
						maps\mp\_utility::func_4D30("losing_score","axis");
					}
					else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
					{
						if(ismusicenabled())
						{
							maps\mp\_utility::func_6045(game["music"]["winning_axis"],"axis");
							maps\mp\_utility::func_6045(game["music"]["losing_allies"],"allies");
						}

						maps\mp\_utility::func_4D30("winning_score","axis");
						maps\mp\_utility::func_4D30("losing_score","allies");
					}
				}
				else
				{
					var_01 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
					var_02 = maps\mp\gametypes\_gamescore::getlosingplayers();
					var_03[0] = var_01;
					if(ismusicenabled())
					{
						var_01 playlocalsound(game["music"]["winning_" + var_01.pers["team"]]);
						foreach(var_05 in level.players)
						{
							if(var_05 == var_01)
							{
								continue;
							}

							var_05 playlocalsound(game["music"]["losing_" + var_05.pers["team"]]);
						}
					}

					var_01 maps\mp\_utility::func_4D35("winning_score");
					maps\mp\_utility::func_4D37("losing_score",var_02);
				}
			}

			level waittill("match_ending_very_soon");
			maps\mp\_utility::func_4D30("timesup");
		}
	}

	if(!level.hardcoremode)
	{
		maps\mp\_utility::func_6045(game["music"]["losing_allies"]);
	}

	maps\mp\_utility::func_4D30("timesup");
}

//Function Number: 12
func_7D8A(param_00)
{
	if(!ismusicenabled())
	{
	}

	level endon("game_ended");
	level endon("match_ending_soon");
	level endon("stop_suspense_music");
	if(isdefined(level.nosuspensemusic) && level.nosuspensemusic)
	{
	}

	var_01 = game["music"]["allies_suspense"].size;
	var_02 = game["music"]["axis_suspense"].size;
	level.cursuspsensetrack = [];
	if(isdefined(param_00) && param_00)
	{
		wait(120);
	}

	for(;;)
	{
		wait(randomfloatrange(60,120));
		level.cursuspsensetrack["allies"] = randomint(var_01);
		maps\mp\_utility::func_6045(game["music"]["allies_suspense"][level.cursuspsensetrack["allies"]],"allies");
		level.cursuspsensetrack["axis"] = randomint(var_02);
		maps\mp\_utility::func_6045(game["music"]["axis_suspense"][level.cursuspsensetrack["axis"]],"axis");
	}
}

//Function Number: 13
func_94EB()
{
	level notify("stop_suspense_music");
	if(isdefined(level.cursuspsensetrack) && level.cursuspsensetrack.size == 2)
	{
		foreach(var_01 in level.players)
		{
			var_02 = var_01.team;
			var_01 stoplocalsound(game["music"][var_02 + "_suspense"][level.cursuspsensetrack[var_02]]);
		}
	}
}

//Function Number: 14
finalkillcammusic()
{
	self waittill("showing_final_killcam");
}

//Function Number: 15
enablemusic()
{
	if(level.musicenabled == 0)
	{
		thread func_7D8A();
	}

	level.musicenabled++;
}

//Function Number: 16
disablemusic()
{
	if(level.musicenabled > 0)
	{
		level.musicenabled--;
		if(level.musicenabled == 0)
		{
			func_94EB();
		}
	}
}

//Function Number: 17
ismusicenabled()
{
	return !level.hardcoremode && level.musicenabled > 0;
}