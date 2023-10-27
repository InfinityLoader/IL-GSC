/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_hud_message.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 921 ms
 * Timestamp: 10/27/2023 12:20:34 AM
*******************************************************************/

//Function Number: 1
init()
{
	game["round_end"]["draw"] = 1;
	game["round_end"]["round_draw"] = 2;
	game["round_end"]["round_win"] = 3;
	game["round_end"]["round_loss"] = 4;
	game["round_end"]["victory"] = 5;
	game["round_end"]["defeat"] = 6;
	game["round_end"]["halftime"] = 7;
	game["round_end"]["overtime"] = 8;
	game["round_end"]["roundend"] = 9;
	game["round_end"]["intermission"] = 10;
	game["round_end"]["side_switch"] = 11;
	game["round_end"]["match_bonus"] = 12;
	game["round_end"]["tie"] = 13;
	game["round_end"]["spectator"] = 14;
	game["round_end"]["final_round"] = 15;
	game["round_end"]["match_point"] = 16;
	game["end_reason"]["score_limit_reached"] = 1;
	game["end_reason"]["time_limit_reached"] = 2;
	game["end_reason"]["players_forfeited"] = 3;
	game["end_reason"]["target_destroyed"] = 4;
	game["end_reason"]["bomb_defused"] = 5;
	game["end_reason"]["allies_eliminated"] = 6;
	game["end_reason"]["axis_eliminated"] = 7;
	game["end_reason"]["allies_forfeited"] = 8;
	game["end_reason"]["axis_forfeited"] = 9;
	game["end_reason"]["enemies_eliminated"] = 10;
	game["end_reason"]["tie"] = 11;
	game["end_reason"]["objective_completed"] = 12;
	game["end_reason"]["objective_failed"] = 13;
	game["end_reason"]["switching_sides"] = 14;
	game["end_reason"]["round_limit_reached"] = 15;
	game["end_reason"]["ended_game"] = 16;
	game["end_reason"]["host_ended_game"] = 17;
	game["end_reason"]["loss_stat_prevented"] = 18;
	game["end_reason"]["time_to_beat_ctf_win"] = 19;
	game["end_reason"]["time_to_beat_ctf_loss"] = 20;
	game["end_reason"]["time_to_beat_uplink_win"] = 21;
	game["end_reason"]["time_to_beat_uplink_loss"] = 22;
	game["end_reason"]["nuke_end"] = 23;
	game["strings"]["overtime"] = &"MP_OVERTIME";
	level thread func_C56E();
	level.showerrormessagefunc = ::func_10122;
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_B0E1();
		var_00 thread func_10A40();
		var_00 thread func_68B8();
	}
}

//Function Number: 3
func_10134(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	var_03 = undefined;
	if(scripts\mp\_utility::func_9FB3(param_02))
	{
		var_03 = 1;
	}

	func_10151(param_00,param_01,undefined,var_03);
}

//Function Number: 4
func_10151(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isdefined(param_02))
	{
		var_04 = param_02 getentitynumber();
	}

	if(isdefined(self.var_DDCD) && self.var_DDCD >= 6)
	{
		func_DB99(param_00,param_01,param_02,var_04,param_03);
		return;
	}

	if(!scripts\mp\_utility::func_9F19(self) && !self ismlgspectator())
	{
		func_DB99(param_00,param_01,param_02,var_04,param_03);
		return;
	}

	func_10152(param_00,param_01,param_02,var_04,param_03);
}

//Function Number: 5
func_10152(param_00,param_01,param_02,param_03,param_04)
{
	if(!isplayer(self))
	{
		return;
	}

	if(isdefined(param_03))
	{
		if(!isdefined(param_02))
		{
			return;
		}
	}

	var_05 = tablelookuprownum(func_814B(),0,param_00);
	if(!isdefined(var_05) || var_05 < 0)
	{
		return;
	}

	if(!isdefined(self.var_BFAE))
	{
		self.var_BFAE = 0;
	}

	if(!isdefined(self.var_10A37))
	{
		self.var_10A37 = 1;
	}

	var_06 = var_05;
	if(self.var_10A37)
	{
		var_06 = var_06 | 2048;
	}

	if(isdefined(param_01))
	{
		self setclientomnvar("ui_player_splash_param_" + self.var_BFAE,param_01);
	}
	else
	{
		self setclientomnvar("ui_player_splash_param_" + self.var_BFAE,-1);
	}

	if(isdefined(param_03))
	{
		self setclientomnvar("ui_player_splash_cardClientId_" + self.var_BFAE,param_03);
	}
	else
	{
		self setclientomnvar("ui_player_splash_cardClientId_" + self.var_BFAE,-1);
	}

	if(isdefined(param_04))
	{
		self setclientomnvar("ui_player_splash_use_alt_" + self.var_BFAE,param_04);
	}
	else
	{
		self setclientomnvar("ui_player_splash_use_alt_" + self.var_BFAE,0);
	}

	self setclientomnvar("ui_player_splash_id_" + self.var_BFAE,var_06);
	if(!isdefined(self.var_DDCD))
	{
		self.var_DDCD = 1;
	}
	else
	{
		self.var_DDCD++;
	}

	thread func_4103();
	self.var_BFAE++;
	if(self.var_BFAE >= 6)
	{
		self.var_BFAE = 0;
		self.var_10A37 = !self.var_10A37;
	}
}

//Function Number: 6
func_DB99(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.var_DE3F = param_00;
	var_05.var_C6BB = param_01;
	var_05.var_D390 = param_02;
	var_05.playernumforplayercard = param_03;
	var_05.altdisplayindex = param_04;
	if(!isdefined(self.var_10A3E))
	{
		self.var_10A3E = var_05;
		self.var_10A3F = var_05;
		thread func_89E9();
		return;
	}

	var_06 = self.var_10A3F;
	var_06.var_BFAD = var_05;
	self.var_10A3F = var_05;
}

//Function Number: 7
func_89E9()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	while(isdefined(self.var_10A3E))
	{
		scripts\common\utility::waittill_any_3("splash_list_cleared","spawned_player");
		for(var_00 = 0;var_00 < 6;var_00++)
		{
			var_01 = self.var_10A3E;
			func_10152(var_01.var_DE3F,var_01.var_C6BB,var_01.var_D390,var_01.playernumforplayercard,var_01.altdisplayindex);
			self.var_10A3E = var_01.var_BFAD;
			if(!isdefined(self.var_10A3E))
			{
				break;
			}
		}
	}

	self.var_10A3F = undefined;
}

//Function Number: 8
func_B0E1()
{
	self endon("disconnect");
	self.lowermessages = [];
	var_00 = "default";
	if(isdefined(level.var_B0DF))
	{
		var_00 = level.var_B0DF;
	}

	var_01 = level.var_B0E5;
	var_02 = level.var_B0E4;
	var_03 = 1.25;
	if(level.splitscreen || self issplitscreenplayer() && !isai(self))
	{
		var_01 = var_01 - 40;
		var_02 = level.var_B0E4 * 1.3;
		var_03 = var_03 * 1.5;
	}

	self.lowermessage = scripts\mp\_hud_util::createfontstring(var_00,var_02);
	self.lowermessage settext("");
	self.lowermessage.archived = 0;
	self.lowermessage.sort = 10;
	self.lowermessage.showinkillcam = 0;
	self.lowermessage scripts\mp\_hud_util::setpoint("CENTER",level.var_B0E6,0,var_01);
	self.lowertimer = scripts\mp\_hud_util::createfontstring("default",var_03);
	self.lowertimer scripts\mp\_hud_util::setparent(self.lowermessage);
	self.lowertimer scripts\mp\_hud_util::setpoint("TOP","BOTTOM",0,0);
	self.lowertimer settext("");
	self.lowertimer.archived = 0;
	self.lowertimer.sort = 10;
	self.lowertimer.showinkillcam = 0;
}

//Function Number: 9
func_9DC6()
{
	return 0;
}

//Function Number: 10
func_115DD(param_00,param_01,param_02)
{
	self endon("disconnect");
	var_03 = self.pers["team"];
	if(self ismlgspectator())
	{
		var_03 = self method_813B();
	}

	if(!isdefined(var_03) || var_03 != "allies" && var_03 != "axis")
	{
		var_03 = "allies";
	}

	if(param_00 == "halftime")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["halftime"]);
		param_00 = "allies";
	}
	else if(param_00 == "intermission")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["intermission"]);
		param_00 = "allies";
	}
	else if(param_00 == "roundend")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["roundend"]);
		param_00 = "allies";
	}
	else if(param_00 == "overtime")
	{
		if(scripts\mp\_utility::func_A00B() && game["teamScores"]["allies"] != game["teamScores"]["axis"])
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["match_point"]);
		}
		else
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["overtime"]);
		}

		param_00 = "allies";
	}
	else if(param_00 == "finalround")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["final_round"]);
		param_00 = "allies";
	}
	else if(param_00 == "tie")
	{
		if(param_01 && !scripts\mp\_utility::func_13916())
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["round_draw"]);
		}
		else
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["draw"]);
		}

		param_00 = "allies";
	}
	else if(self ismlgspectator())
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["spectator"]);
	}
	else if(isdefined(self.pers["team"]) && param_00 == var_03)
	{
		if(param_01 && !scripts\mp\_utility::func_13916())
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["round_win"]);
		}
		else
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["victory"]);
		}
	}
	else if(param_01 && !scripts\mp\_utility::func_13916())
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["round_loss"]);
	}
	else
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["defeat"]);
		if(scripts\mp\_utility::func_9FB3(self.var_A49D) && scripts\mp\_utility::func_DCD5())
		{
			param_02 = game["end_reason"]["loss_stat_prevented"];
		}
	}

	if(scripts\mp\_utility::func_9900() && scripts\mp\_utility::func_13916() && scripts\mp\_utility::func_9FAA())
	{
		if(level.gametype == "ctf")
		{
			if(isdefined(self.pers["team"]) && param_00 == var_03)
			{
				param_02 = game["end_reason"]["time_to_beat_ctf_win"];
			}
			else if(isdefined(self.pers["team"]) && param_00 == level.var_C74B[self.pers["team"]])
			{
				param_02 = game["end_reason"]["time_to_beat_ctf_loss"];
			}
		}
		else if(level.gametype == "ball")
		{
			if(isdefined(self.pers["team"]) && param_00 == var_03)
			{
				param_02 = game["end_reason"]["time_to_beat_uplink_win"];
			}
			else if(isdefined(self.pers["team"]) && param_00 == level.var_C74B[self.pers["team"]])
			{
				param_02 = game["end_reason"]["time_to_beat_uplink_loss"];
			}
		}
	}

	self setclientomnvar("ui_round_end_reason",param_02);
	if(!scripts\mp\_utility::func_9F32() || !scripts\mp\_utility::func_9EBD() || scripts\mp\_utility::func_9EA9())
	{
		self setclientomnvar("ui_round_end_friendly_score",scripts\mp\_gamescore::func_12B6(var_03));
		self setclientomnvar("ui_round_end_enemy_score",scripts\mp\_gamescore::func_12B6(level.var_C74B[var_03]));
	}
	else
	{
		self setclientomnvar("ui_round_end_friendly_score",game["roundsWon"][var_03]);
		self setclientomnvar("ui_round_end_enemy_score",game["roundsWon"][level.var_C74B[var_03]]);
	}

	if(isdefined(self.var_B3DD))
	{
		self setclientomnvar("ui_round_end_match_bonus",self.var_B3DD);
	}
}

//Function Number: 11
func_C752(param_00,param_01)
{
	self endon("disconnect");
	var_02 = level.var_CC1D["all"];
	var_03 = var_02[0];
	var_04 = var_02[1];
	var_05 = var_02[2];
	if(isstring(param_00) && param_00 == "tie")
	{
		if((isdefined(var_03) && self == var_03) || isdefined(var_04) && self == var_04 || isdefined(var_05) && self == var_05)
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["tie"]);
		}
		else
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["defeat"]);
		}
	}
	else if((isdefined(var_03) && self == var_03) || isdefined(var_04) && self == var_04 || isdefined(var_05) && self == var_05)
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["victory"]);
	}
	else
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["defeat"]);
		if(scripts\mp\_utility::func_9FB3(self.var_A49D) && scripts\mp\_utility::func_DCD5())
		{
			param_01 = game["end_reason"]["loss_stat_prevented"];
		}
	}

	self setclientomnvar("ui_round_end_reason",param_01);
	if(isdefined(self.var_B3DD))
	{
		self setclientomnvar("ui_round_end_match_bonus",self.var_B3DD);
	}
}

//Function Number: 12
func_814B()
{
	return "mp/splashTable.csv";
}

//Function Number: 13
getsplashtablemaxaltdisplays()
{
	return 5;
}

//Function Number: 14
func_4103()
{
	self endon("disconnect");
	self notify("cleanupLocalPlayerSplashList()");
	self endon("cleanupLocalPlayerSplashList()");
	scripts\common\utility::waittill_notify_or_timeout("death",0.5);
	while(!scripts\mp\_utility::func_9F19(self) && !self ismlgspectator())
	{
		wait(0.15);
	}

	self.var_DDCD = undefined;
	self notify("splash_list_cleared");
}

//Function Number: 15
func_10A40()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 != "splash_shown")
		{
			continue;
		}

		var_02 = tablelookupbyrow(func_814B(),var_01,0);
		var_03 = tablelookupbyrow(func_814B(),var_01,5);
		switch(var_03)
		{
			case "killstreak_splash":
				func_C549(var_02);
				break;
		}
	}
}

//Function Number: 16
func_C549(param_00)
{
	scripts\mp\_utility::func_D4B6(param_00,"killstreak_earned",1);
}

//Function Number: 17
func_10122(param_00,param_01)
{
	var_02 = tablelookuprownum("mp/errorMessages.csv",0,param_00);
	if(isdefined(param_01))
	{
		self setclientomnvar("ui_mp_error_message_param",param_01);
	}
	else
	{
		self setclientomnvar("ui_mp_error_message_param",-1);
	}

	self setclientomnvar("ui_mp_error_message_id",var_02);
	if(!isdefined(self.var_66BF))
	{
		self.var_66BF = 0;
	}

	self.var_66BF = !self.var_66BF;
	self setclientomnvar("ui_mp_error_trigger",scripts\common\utility::func_116D7(self.var_66BF,2,1));
}

//Function Number: 18
func_10123(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		func_10122(param_00,param_01);
	}
}

//Function Number: 19
func_11750(param_00)
{
	var_01 = tablelookuprownum("mp/miscMessages.csv",0,param_00);
	if(isdefined(var_01) && var_01 >= 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
func_1013D(param_00)
{
	var_01 = tablelookuprownum("mp/miscMessages.csv",0,param_00);
	var_02 = tablelookupbyrow("mp/miscMessages.csv",var_01,3);
	if(isdefined(var_02) && var_02 != "")
	{
		self playlocalsound(var_02);
	}

	self setclientomnvar("ui_misc_message_id",var_01);
	self setclientomnvar("ui_misc_message_trigger",1);
}

//Function Number: 21
func_68B8()
{
	self endon("disconnect");
	self waittill("spawned_player");
	wait(5);
	if(!isdefined(self))
	{
		return;
	}

	if(!scripts\mp\_utility::func_B3EC())
	{
		return;
	}

	var_00 = self method_85BE() > 1;
	if(getdvarint("online_mp_xpscale") == 2 || var_00 && getdvarint("online_mp_party_xpscale") == 2)
	{
		func_10151("event_double_xp");
	}

	if(getdvarint("online_mp_weapon_xpscale") == 2 || var_00 && getdvarint("online_mp_party_weapon_xpscale") == 2)
	{
		func_10151("event_double_weapon_xp");
	}

	if(getdvarint("online_double_keys") > 0)
	{
		func_10151("event_double_keys");
	}

	if(getdvarint("online_mp_missionteam_xpscale") == 2 || var_00 && getdvarint("online_mp_party_missionteam_xpscale") == 2)
	{
		func_10151("event_double_xp_teams");
	}
}