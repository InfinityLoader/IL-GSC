/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_music_and_dialog.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 11
 * Decompile Time: 165 ms
 * Timestamp: 10/27/2023 2:25:41 AM
*******************************************************************/

//Function Number: 1
init()
{
	game["music"]["spawn_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "spawn_music";
	game["music"]["defeat_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "defeat_music";
	game["music"]["victory_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "victory_music";
	game["music"]["winning_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "winning_music";
	game["music"]["losing_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "losing_music";
	game["voice"]["allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "1mc_";
	game["music"]["spawn_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "spawn_music";
	game["music"]["defeat_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "defeat_music";
	game["music"]["victory_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "victory_music";
	game["music"]["winning_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "winning_music";
	game["music"]["losing_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "losing_music";
	game["voice"]["axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "1mc_";
	game["music"]["losing_time"] = "mp_time_running_out_losing";
	game["music"]["suspense"] = [];
	game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_01";
	game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_02";
	game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_03";
	game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_04";
	game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_05";
	game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_06";
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
	game["dialog"]["destroy_sentry"] = "dest_sentrygun";
	game["music"]["nuke_music"] = "nuke_music";
	game["dialog"]["sentry_gone"] = "sentry_gone";
	game["dialog"]["sentry_destroyed"] = "sentry_destroyed";
	game["dialog"]["ti_gone"] = "ti_cancelled";
	game["dialog"]["ti_destroyed"] = "ti_blocked";
	game["dialog"]["ims_destroyed"] = "ims_destroyed";
	game["dialog"]["lbguard_destroyed"] = "lbguard_destroyed";
	game["dialog"]["ballistic_vest_destroyed"] = "ballistic_vest_destroyed";
	game["dialog"]["remote_sentry_destroyed"] = "remote_sentry_destroyed";
	game["dialog"]["sam_destroyed"] = "sam_destroyed";
	game["dialog"]["sam_gone"] = "sam_gone";
	level thread onplayerconnect();
	level thread onlastalive();
	level thread func_2D6D();
	level thread func_2D67();
	level thread func_2D66();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
		var_00 thread finalkillcammusic();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
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
			maps\mp\_utility::func_2A60("allies_gametype");
		}
		else if(isdefined(game["dialog"]["axis_gametype"]) && self.team == "axis")
		{
			maps\mp\_utility::func_2A60("axis_gametype");
		}
		else if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
		{
			maps\mp\_utility::func_2A60("gametype");
		}
	}

	maps\mp\_utility::func_274B("prematch_done");
	if(self.team == game["attackers"])
	{
		if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
		{
			maps\mp\_utility::func_2A60("offense_obj","introboost");
			return;
		}

		return;
	}

	if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
	{
		maps\mp\_utility::func_2A60("defense_obj","introboost");
	}
}

//Function Number: 4
onlastalive()
{
	level endon("game_ended");
	level waittill("last_alive",var_00);
	if(!isalive(var_00))
	{
		return;
	}

	var_00 maps\mp\_utility::func_2A60("last_alive");
}

//Function Number: 5
func_2D66()
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
	
				var_02 maps\mp\_utility::func_2A60("halftime");
			}
			break;

		case "overtime":
			foreach(var_02 in level.players)
			{
				if(var_02 issplitscreenplayer() && !var_02 issplitscreenplayerprimary())
				{
					continue;
				}
	
				var_02 maps\mp\_utility::func_2A60("overtime");
			}
			break;

		default:
			foreach(var_02 in level.players)
			{
				if(var_02 issplitscreenplayer() && !var_02 issplitscreenplayerprimary())
				{
					continue;
				}
	
				var_02 maps\mp\_utility::func_2A60("side_switch");
			}
			break;
	}
}

//Function Number: 6
func_2D67()
{
	level thread func_2D69();
	level thread gamewinnerdialog();
	level waittill("game_win",var_00);
	if(level.teambased)
	{
		if(level.splitscreen)
		{
			if(var_00 == "allies")
			{
				maps\mp\_utility::func_2D68(game["music"]["victory_allies"],"allies");
				return;
			}

			if(var_00 == "axis")
			{
				maps\mp\_utility::func_2D68(game["music"]["victory_axis"],"axis");
				return;
			}

			maps\mp\_utility::func_2D68(game["music"]["nuke_music"]);
			return;
		}

		if(var_00 == "allies")
		{
			maps\mp\_utility::func_2D68(game["music"]["victory_allies"],"allies");
			maps\mp\_utility::func_2D68(game["music"]["defeat_axis"],"axis");
			return;
		}

		if(var_00 == "axis")
		{
			maps\mp\_utility::func_2D68(game["music"]["victory_axis"],"axis");
			maps\mp\_utility::func_2D68(game["music"]["defeat_allies"],"allies");
			return;
		}

		maps\mp\_utility::func_2D68(game["music"]["nuke_music"]);
		return;
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

//Function Number: 7
func_2D69()
{
	level waittill("round_win",var_00);
	var_01 = level.roundenddelay / 4;
	if(var_01 > 0)
	{
		wait var_01;
	}

	if(!isdefined(var_00) || isplayer(var_00))
	{
		return;
	}

	if(var_00 == "allies")
	{
		maps\mp\_utility::func_26E5("round_success","allies");
		maps\mp\_utility::func_26E5("round_failure","axis");
		return;
	}

	if(var_00 == "axis")
	{
		maps\mp\_utility::func_26E5("round_success","axis");
		maps\mp\_utility::func_26E5("round_failure","allies");
	}
}

//Function Number: 8
gamewinnerdialog()
{
	level waittill("game_win",var_00);
	var_01 = level.postroundtime / 2;
	if(var_01 > 0)
	{
		wait var_01;
	}

	if(!isdefined(var_00) || isplayer(var_00))
	{
		return;
	}

	if(var_00 == "allies")
	{
		maps\mp\_utility::func_26E5("mission_success","allies");
		maps\mp\_utility::func_26E5("mission_failure","axis");
		return;
	}

	if(var_00 == "axis")
	{
		maps\mp\_utility::func_26E5("mission_success","axis");
		maps\mp\_utility::func_26E5("mission_failure","allies");
		return;
	}

	maps\mp\_utility::func_26E5("mission_draw");
}

//Function Number: 9
func_2D6D()
{
	level endon("game_ended");
	if(!level.hardcoremode)
	{
		thread suspensemusic();
	}

	level waittill("match_ending_soon",var_00);
	if(maps\mp\_utility::func_18D0("roundlimit") == 1 || game["roundsPlayed"] == maps\mp\_utility::func_18D0("roundlimit") - 1)
	{
		if(!level.splitscreen)
		{
			if(var_00 == "time")
			{
				if(level.teambased)
				{
					if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::func_2D68(game["music"]["winning_allies"],"allies");
							maps\mp\_utility::func_2D68(game["music"]["losing_axis"],"axis");
						}

						maps\mp\_utility::func_26E5("winning_time","allies");
						maps\mp\_utility::func_26E5("losing_time","axis");
					}
					else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::func_2D68(game["music"]["winning_axis"],"axis");
							maps\mp\_utility::func_2D68(game["music"]["losing_allies"],"allies");
						}

						maps\mp\_utility::func_26E5("winning_time","axis");
						maps\mp\_utility::func_26E5("losing_time","allies");
					}
				}
				else
				{
					if(!level.hardcoremode)
					{
						maps\mp\_utility::func_2D68(game["music"]["losing_time"]);
					}

					maps\mp\_utility::func_26E5("timesup");
				}
			}
			else if(var_00 == "score")
			{
				if(level.teambased)
				{
					if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::func_2D68(game["music"]["winning_allies"],"allies");
							maps\mp\_utility::func_2D68(game["music"]["losing_axis"],"axis");
						}

						maps\mp\_utility::func_26E5("winning_score","allies");
						maps\mp\_utility::func_26E5("losing_score","axis");
					}
					else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::func_2D68(game["music"]["winning_axis"],"axis");
							maps\mp\_utility::func_2D68(game["music"]["losing_allies"],"allies");
						}

						maps\mp\_utility::func_26E5("winning_score","axis");
						maps\mp\_utility::func_26E5("losing_score","allies");
					}
				}
				else
				{
					var_01 = maps\mp\gametypes\_gamescore::func_26D0();
					var_02 = maps\mp\gametypes\_gamescore::getlosingplayers();
					var_03[0] = var_01;
					if(!level.hardcoremode)
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

					var_01 maps\mp\_utility::func_2A60("winning_score");
					maps\mp\_utility::func_2D6E("losing_score",var_02);
				}
			}

			level waittill("match_ending_very_soon");
			maps\mp\_utility::func_26E5("timesup");
			return;
		}

		return;
	}

	if(!level.hardcoremode)
	{
		maps\mp\_utility::func_2D68(game["music"]["losing_allies"]);
	}

	maps\mp\_utility::func_26E5("timesup");
}

//Function Number: 10
suspensemusic()
{
	level endon("game_ended");
	level endon("match_ending_soon");
	var_00 = game["music"]["suspense"].size;
	wait 120;
	for(;;)
	{
		wait randomfloatrange(60,120);
		maps\mp\_utility::func_2D68(game["music"]["suspense"][randomint(var_00)]);
	}
}

//Function Number: 11
finalkillcammusic()
{
	self waittill("showing_final_killcam");
}