/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_music_and_dialog.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 166 ms
 * Timestamp: 10/27/2023 2:41:51 AM
*******************************************************************/

//Function Number: 1
init()
{
	game["music"]["spawn_allies"] = maps\mp\gametypes\_teams::getteamspawnmusic("allies");
	game["music"]["victory_allies"] = maps\mp\gametypes\_teams::getteamwinmusic("allies");
	game["music"]["defeat_allies"] = "mp_defeat";
	game["music"]["winning_allies"] = "mp_time_running_out_winning";
	game["music"]["losing_allies"] = "mp_time_running_out_losing";
	game["voice"]["allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "1mc_";
	game["music"]["spawn_axis"] = maps\mp\gametypes\_teams::getteamspawnmusic("axis");
	game["music"]["victory_axis"] = maps\mp\gametypes\_teams::getteamwinmusic("axis");
	game["music"]["defeat_axis"] = "mp_defeat";
	game["music"]["winning_axis"] = "mp_time_running_out_winning";
	game["music"]["losing_axis"] = "mp_time_running_out_losing";
	game["voice"]["axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "1mc_";
	game["music"]["losing_time"] = "null";
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
	game["dialog"]["winning_score"] = "winning";
	game["dialog"]["losing_score"] = "losing";
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
	game["dialog"]["bomb_taken"] = "bomb_taken";
	game["dialog"]["bomb_lost"] = "bomb_lost";
	game["dialog"]["bomb_planted"] = "bomb_planted";
	game["dialog"]["bomb_defused"] = "bomb_defused";
	game["dialog"]["obj_taken"] = "securedobj";
	game["dialog"]["obj_lost"] = "lostobj";
	game["dialog"]["obj_defend"] = "obj_defend";
	game["dialog"]["obj_destroy"] = "obj_destroy";
	game["dialog"]["obj_capture"] = "gbl_secureobj";
	game["dialog"]["objs_capture"] = "gbl_secureobjs";
	game["dialog"]["move_to_new"] = "new_positions";
	game["dialog"]["push_forward"] = "gbl_rally";
	game["dialog"]["attack"] = "attack";
	game["dialog"]["defend"] = "defend";
	game["dialog"]["offense"] = "offense";
	game["dialog"]["defense"] = "defense";
	game["dialog"]["halftime"] = "halftime";
	game["dialog"]["overtime"] = "overtime";
	game["dialog"]["side_switch"] = "switching";
	game["dialog"]["flag_taken"] = "ctf_retrieveflagally";
	game["dialog"]["enemy_flag_taken"] = "ctf_enemyflagcapd";
	game["dialog"]["flag_dropped"] = "ctf_enemydropflag";
	game["dialog"]["enemy_flag_dropped"] = "ctf_allydropflag";
	game["dialog"]["flag_returned"] = "ctf_allyflagback";
	game["dialog"]["enemy_flag_returned"] = "ctf_enemyflagback";
	game["dialog"]["flag_captured"] = "ctf_enemycapflag";
	game["dialog"]["enemy_flag_captured"] = "ctf_allycapflag";
	game["dialog"]["flag_getback"] = "ctf_retrieveflagally";
	game["dialog"]["enemy_flag_bringhome"] = "ctf_bringhomflag";
	game["dialog"]["hq_located"] = "hq_located";
	game["dialog"]["hq_enemy_captured"] = "hq_captured";
	game["dialog"]["hq_enemy_destroyed"] = "hq_destroyed";
	game["dialog"]["hq_secured"] = "hq_secured";
	game["dialog"]["hq_offline"] = "hq_offline";
	game["dialog"]["hq_online"] = "hq_online";
	game["dialog"]["hp_online"] = "hpt_identified";
	game["dialog"]["hp_lost"] = "hpt_enemycap";
	game["dialog"]["hp_contested"] = "hpt_contested";
	game["dialog"]["hp_secured"] = "hpt_allyown";
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
	game["dialog"]["enemy_has_a"] = "enemy_has_a";
	game["dialog"]["enemy_has_b"] = "enemy_has_b";
	game["dialog"]["enemy_has_c"] = "enemy_has_c";
	game["dialog"]["lost_all"] = "take_positions";
	game["dialog"]["secure_all"] = "positions_lock";
	game["dialog"]["destroy_sentry"] = "ks_sentrygun_destroyed";
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
	game["dialog"]["claymore_destroyed"] = "null";
	game["dialog"]["mine_destroyed"] = "null";
	game["dialog"]["ti_destroyed"] = "gbl_tactinsertlost";
	game["dialog"]["lockouts"] = [];
	game["dialog"]["lockouts"]["ks_uav_allyuse"] = 6;
	level thread onplayerconnect();
	level thread onlastalive();
	level thread musiccontroller();
	level thread ongameended();
	level thread onroundswitch();
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
	if(getdvar("virtuallobbyactive") == "0")
	{
		if(!level.splitscreen || level.splitscreen && !isdefined(level.playedstartingmusic))
		{
			if(!maps\mp\_utility::issecondarysplitscreenplayer())
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
				maps\mp\_utility::leaderdialogonplayer("allies_gametype");
			}
			else if(isdefined(game["dialog"]["axis_gametype"]) && self.team == "axis")
			{
				maps\mp\_utility::leaderdialogonplayer("axis_gametype");
			}
			else if(!maps\mp\_utility::issecondarysplitscreenplayer())
			{
				maps\mp\_utility::leaderdialogonplayer("gametype");
			}
		}

		maps\mp\_utility::gameflagwait("prematch_done");
		if(self.team == game["attackers"])
		{
			if(!maps\mp\_utility::issecondarysplitscreenplayer())
			{
				maps\mp\_utility::leaderdialogonplayer("offense_obj","introboost");
				return;
			}

			return;
		}

		if(!maps\mp\_utility::issecondarysplitscreenplayer())
		{
			maps\mp\_utility::leaderdialogonplayer("defense_obj","introboost");
			return;
		}
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

	var_00 maps\mp\_utility::leaderdialogonplayer("last_alive");
}

//Function Number: 5
onroundswitch()
{
	level waittill("round_switch",var_00);
	switch(var_00)
	{
		case "halftime":
			break;

		case "overtime":
			break;

		default:
			break;
	}
}

//Function Number: 6
ongameended()
{
	level thread roundwinnerdialog();
	level thread gamewinnerdialog();
	level waittill("game_win",var_00);
	if(level.teambased)
	{
		if(level.splitscreen)
		{
			if(var_00 == "allies")
			{
				maps\mp\_utility::playsoundonplayers(game["music"]["victory_allies"],"allies");
				return;
			}

			if(var_00 == "axis")
			{
				maps\mp\_utility::playsoundonplayers(game["music"]["victory_axis"],"axis");
				return;
			}

			maps\mp\_utility::playsoundonplayers(game["music"]["defeat_allies"],"allies");
			maps\mp\_utility::playsoundonplayers(game["music"]["defeat_axis"],"axis");
			return;
		}

		if(var_00 == "allies")
		{
			maps\mp\_utility::playsoundonplayers(game["music"]["victory_allies"],"allies");
			maps\mp\_utility::playsoundonplayers(game["music"]["defeat_axis"],"axis");
			return;
		}

		if(var_00 == "axis")
		{
			maps\mp\_utility::playsoundonplayers(game["music"]["victory_axis"],"axis");
			maps\mp\_utility::playsoundonplayers(game["music"]["defeat_allies"],"allies");
			return;
		}

		maps\mp\_utility::playsoundonplayers(game["music"]["defeat_allies"],"allies");
		maps\mp\_utility::playsoundonplayers(game["music"]["defeat_axis"],"axis");
		return;
	}

	foreach(var_02 in level.players)
	{
		if(var_02 maps\mp\_utility::issecondarysplitscreenplayer())
		{
			continue;
		}

		if(var_02.pers["team"] != "allies" && var_02.pers["team"] != "axis")
		{
			var_02 playlocalsound(game["music"]["defeat_allies"]);
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
		return;
	}

	if(var_00 == "allies")
	{
		maps\mp\_utility::leaderdialog("round_success","allies");
		maps\mp\_utility::leaderdialog("round_failure","axis");
		return;
	}

	if(var_00 == "axis")
	{
		maps\mp\_utility::leaderdialog("round_success","axis");
		maps\mp\_utility::leaderdialog("round_failure","allies");
	}
}

//Function Number: 8
gamewinnerdialog()
{
	level waittill("game_win",var_00);
	var_01 = level.postroundtime / 2;
	if(var_01 > 0)
	{
		wait(var_01);
	}

	if(!isdefined(var_00) || isplayer(var_00))
	{
		return;
	}

	if(var_00 == "allies")
	{
		maps\mp\_utility::leaderdialog("mission_success","allies");
		maps\mp\_utility::leaderdialog("mission_failure","axis");
		return;
	}

	if(var_00 == "axis")
	{
		if(isdefined(level.ishorde))
		{
			[[ level.hordevomissionfail ]]();
			return;
		}

		maps\mp\_utility::leaderdialog("mission_success","axis");
		maps\mp\_utility::leaderdialog("mission_failure","allies");
		return;
	}

	maps\mp\_utility::leaderdialog("mission_draw");
}

//Function Number: 9
musiccontroller()
{
	level endon("game_ended");
	if(!level.hardcoremode && getdvar("virtualLobbyActive") == "0")
	{
		thread suspensemusic();
	}

	level waittill("match_ending_soon",var_00);
	if(maps\mp\_utility::getwatcheddvar("roundlimit") == 1 || game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar("roundlimit") - 1)
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
							maps\mp\_utility::playsoundonplayers(game["music"]["winning_allies"],"allies");
							maps\mp\_utility::playsoundonplayers(game["music"]["losing_axis"],"axis");
						}

						maps\mp\_utility::leaderdialog("winning_time","allies");
						maps\mp\_utility::leaderdialog("losing_time","axis");
					}
					else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::playsoundonplayers(game["music"]["winning_axis"],"axis");
							maps\mp\_utility::playsoundonplayers(game["music"]["losing_allies"],"allies");
						}

						maps\mp\_utility::leaderdialog("winning_time","axis");
						maps\mp\_utility::leaderdialog("losing_time","allies");
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
			else if(var_00 == "score")
			{
				if(level.teambased)
				{
					if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::playsoundonplayers(game["music"]["winning_allies"],"allies");
							maps\mp\_utility::playsoundonplayers(game["music"]["losing_axis"],"axis");
						}

						maps\mp\_utility::leaderdialog("winning_score","allies");
						maps\mp\_utility::leaderdialog("losing_score","axis");
					}
					else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
					{
						if(!level.hardcoremode)
						{
							maps\mp\_utility::playsoundonplayers(game["music"]["winning_axis"],"axis");
							maps\mp\_utility::playsoundonplayers(game["music"]["losing_allies"],"allies");
						}

						maps\mp\_utility::leaderdialog("winning_score","axis");
						maps\mp\_utility::leaderdialog("losing_score","allies");
					}
				}
				else
				{
					var_01 = maps\mp\gametypes\_gamescores::gethighestscoringplayer();
					var_02 = maps\mp\gametypes\_gamescores::getlosingplayers();
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

					var_01 maps\mp\_utility::leaderdialogonplayer("winning_score");
					maps\mp\_utility::leaderdialogonplayers("losing_score",var_02);
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

//Function Number: 10
suspensemusic()
{
	level endon("game_ended");
	level endon("match_ending_soon");
	var_00 = game["music"]["suspense"].size;
	wait(120);
	for(;;)
	{
		wait(randomfloatrange(60,120));
		maps\mp\_utility::playsoundonplayers(game["music"]["suspense"][randomint(var_00)]);
	}
}

//Function Number: 11
finalkillcammusic()
{
	self waittill("showing_final_killcam");
}