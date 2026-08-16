/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_music_and_dialog.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

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
	game["music"]["defeat"] = "mp_defeat";
	game["music"]["victory_spectator"] = "mp_defeat";
	game["music"]["winning_time"] = "mp_time_running_out_winning";
	game["music"]["losing_time"] = "mp_time_running_out_losing";
	game["music"]["winning_score"] = "mp_time_running_out_winning";
	game["music"]["losing_score"] = "mp_time_running_out_losing";
	game["music"]["victory_tie"] = "mp_defeat";
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
	game["dialog"]["sentry_destroyed"] = "sentry_gone";
	game["dialog"]["ti_gone"] = "ti_cancelled";
	game["dialog"]["ti_destroyed"] = "ti_blocked";
	level thread onplayerconnect();
	level thread onlastalive();
	level thread musiccontroller();
	level thread ongameended();
	level thread onroundswitch();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onplayerspawned();
		player thread finalkillcammusic();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
	if(!level.splitscreen || level.splitscreen && !isdefined(level.playedstartingmusic))
	{
		self playlocalsound(game["music"]["spawn_" + self.team]);
		if(level.splitscreen)
		{
			level.playedstartingmusic = 1;
		}
	}

	if(isdefined(game["dialog"]["gametype"]) && !level.splitscreen || self == level.players[0])
	{
		if(isdefined(game["dialog"]["allies_gametype"]) && self.team == "allies")
		{
			maps\mp\_utility::leaderdialogonplayer("allies_gametype");
		}
		else if(isdefined(game["dialog"]["axis_gametype"]) && self.team == "axis")
		{
			maps\mp\_utility::leaderdialogonplayer("axis_gametype");
		}
		else
		{
			maps\mp\_utility::leaderdialogonplayer("gametype");
		}
	}

	maps\mp\_utility::gameflagwait("prematch_done");
	if(self.team == game["attackers"])
	{
		maps\mp\_utility::leaderdialogonplayer("offense_obj", "introboost");
		return;
	}

	maps\mp\_utility::leaderdialogonplayer("defense_obj", "introboost");
}

onlastalive()
{
	level endon("game_ended");
	level waittill("last_alive", player);
	if(!isalive(player))
	{
		return;
	}

	player maps\mp\_utility::leaderdialogonplayer("last_alive");
}

onroundswitch()
{
	level waittill("round_switch", switchtype);
	switch(switchtype)
	{
		case "halftime":
			foreach(player in level.players)
			{
				player maps\mp\_utility::leaderdialogonplayer("halftime");
			}
			break;

		case "overtime":
			foreach(player in level.players)
			{
				player maps\mp\_utility::leaderdialogonplayer("overtime");
			}
			break;

		default:
			foreach(player in level.players)
			{
				player maps\mp\_utility::leaderdialogonplayer("side_switch");
			}
			break;
	}
}

ongameended()
{
	level thread roundwinnerdialog();
	level thread gamewinnerdialog();
	level waittill("game_win", winner);
	if(isdefined(level.nukedetonated))
	{
		if(!level.splitscreen)
		{
			maps\mp\_utility::playsoundonplayers(game["music"]["nuke_music"]);
		}
		else
		{
			level.players[0] playlocalsound(game["music"]["nuke_music"]);
		}

		return;
	}

	if(level.teambased)
	{
		if(level.splitscreen)
		{
			if(winner == "allies")
			{
				maps\mp\_utility::playsoundonplayers(game["music"]["victory_allies"], "allies");
				return;
			}

			if(winner == "axis")
			{
				maps\mp\_utility::playsoundonplayers(game["music"]["victory_axis"], "axis");
				return;
			}

			maps\mp\_utility::playsoundonplayers(game["music"]["nuke_music"]);
			return;
		}

		if(winner == "allies")
		{
			maps\mp\_utility::playsoundonplayers(game["music"]["victory_allies"], "allies");
			maps\mp\_utility::playsoundonplayers(game["music"]["defeat_axis"], "axis");
			return;
		}

		if(winner == "axis")
		{
			maps\mp\_utility::playsoundonplayers(game["music"]["victory_axis"], "axis");
			maps\mp\_utility::playsoundonplayers(game["music"]["defeat_allies"], "allies");
			return;
		}

		maps\mp\_utility::playsoundonplayers(game["music"]["nuke_music"]);
		return;
	}

	foreach(player in level.players)
	{
		if(player.pers["team"] != "allies" && player.pers["team"] != "axis")
		{
			player playlocalsound(game["music"]["nuke_music"]);
			continue;
		}

		if(isdefined(winner) && player == winner)
		{
			player playlocalsound(game["music"]["victory_" + player.pers["team"]]);
			continue;
		}

		if(!level.splitscreen)
		{
			player playlocalsound(game["music"]["defeat_" + player.pers["team"]]);
		}
	}
}

roundwinnerdialog()
{
	level waittill("round_win", winner);
	delay = level.roundenddelay / 4;
	if(delay > 0)
	{
		wait delay;
	}

	if(!isdefined(winner) || isplayer(winner) || isdefined(level.nukedetonated))
	{
		return;
	}

	if(winner == "allies")
	{
		maps\mp\_utility::leaderdialog("round_success", "allies");
		maps\mp\_utility::leaderdialog("round_failure", "axis");
		return;
	}

	if(winner == "axis")
	{
		maps\mp\_utility::leaderdialog("round_success", "axis");
		maps\mp\_utility::leaderdialog("round_failure", "allies");
		return;
	}
}

gamewinnerdialog()
{
	level waittill("game_win", winner);
	delay = level.postroundtime / 2;
	if(delay > 0)
	{
		wait delay;
	}

	if(!isdefined(winner) || isplayer(winner) || isdefined(level.nukedetonated))
	{
		return;
	}

	if(winner == "allies")
	{
		maps\mp\_utility::leaderdialog("mission_success", "allies");
		maps\mp\_utility::leaderdialog("mission_failure", "axis");
		return;
	}

	if(winner == "axis")
	{
		maps\mp\_utility::leaderdialog("mission_success", "axis");
		maps\mp\_utility::leaderdialog("mission_failure", "allies");
		return;
	}

	maps\mp\_utility::leaderdialog("mission_draw");
}

musiccontroller()
{
	level endon("game_ended");
	if(!level.hardcoremode)
	{
		thread suspensemusic();
	}

	level waittill("match_ending_soon", reason);
	if(maps\mp\_utility::getwatcheddvar("roundlimit") == 1 || game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar("roundlimit") - 1)
	{
		if(!level.splitscreen)
		{
			if(reason == "time")
			{
				if(level.teambased)
				{
					if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::playsoundonplayers(game["music"]["winning_allies"], "allies");
							maps\mp\_utility::playsoundonplayers(game["music"]["losing_axis"], "axis");
						}

						maps\mp\_utility::leaderdialog("winning_time", "allies");
						maps\mp\_utility::leaderdialog("losing_time", "axis");
					}
					else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::playsoundonplayers(game["music"]["winning_axis"], "axis");
							maps\mp\_utility::playsoundonplayers(game["music"]["losing_allies"], "allies");
						}

						maps\mp\_utility::leaderdialog("winning_time", "axis");
						maps\mp\_utility::leaderdialog("losing_time", "allies");
					}
				}
				else
				{
					if(!level.hardcoremode)
					{
						maps\mp\_utility::playsoundonplayers(game["music"]["losing_time"]);
					}

					maps\mp\_utility::leaderdialog("timesup");
				}
			}
			else if(reason == "score")
			{
				if(level.teambased)
				{
					if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::playsoundonplayers(game["music"]["winning_allies"], "allies");
							maps\mp\_utility::playsoundonplayers(game["music"]["losing_axis"], "axis");
						}

						maps\mp\_utility::leaderdialog("winning_score", "allies");
						maps\mp\_utility::leaderdialog("losing_score", "axis");
					}
					else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::playsoundonplayers(game["music"]["winning_axis"], "axis");
							maps\mp\_utility::playsoundonplayers(game["music"]["losing_allies"], "allies");
						}

						maps\mp\_utility::leaderdialog("winning_score", "axis");
						maps\mp\_utility::leaderdialog("losing_score", "allies");
					}
				}
				else
				{
					winningplayer = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
					losingplayers = maps\mp\gametypes\_gamescore::getlosingplayers();
					excludelist[0] = winningplayer;
					if(!level.hardcoremode)
					{
						winningplayer playlocalsound(game["music"]["winning_" + winningplayer.pers["team"]]);
						foreach(otherplayer in level.players)
						{
							if(otherplayer == winningplayer)
							{
								continue;
							}

							otherplayer playlocalsound(game["music"]["losing_" + otherplayer.pers["team"]]);
						}
					}

					winningplayer maps\mp\_utility::leaderdialogonplayer("winning_score");
					maps\mp\_utility::leaderdialogonplayers("losing_score", losingplayers);
				}
			}

			level waittill("match_ending_very_soon");
			maps\mp\_utility::leaderdialog("timesup");
			return;
		}

		return;
	}

	if(!level.hardcoremode)
	{
		maps\mp\_utility::playsoundonplayers(game["music"]["losing_allies"]);
	}

	maps\mp\_utility::leaderdialog("timesup");
}

suspensemusic()
{
	level endon("game_ended");
	level endon("match_ending_soon");
	numtracks = game["music"]["suspense"].size;
	for(;;)
	{
		wait randomfloatrange(60, 120);
		maps\mp\_utility::playsoundonplayers(game["music"]["suspense"][randomint(numtracks)]);
	}
}

finalkillcammusic()
{
	self waittill("showing_final_killcam");
}