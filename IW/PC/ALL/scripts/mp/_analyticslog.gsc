/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_analyticslog.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 2768 ms
 * Timestamp: 10/27/2023 12:14:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	setdvarifuninitialized("enable_analytics_log",0);
	level.var_1E61 = spawnstruct();
	level.var_1E61.var_BFA4 = 0;
	level.var_1E61.var_BF9C = 0;
	level.var_1E61.var_BF79 = 0;
	if(!analyticsactive())
	{
		return;
	}

	thread func_13A33();
	if(func_1E62())
	{
		thread func_AFCA();
		thread func_AF93();
		thread func_AFA6();
	}
}

//Function Number: 2
analyticsactive()
{
	if(func_1E6A())
	{
		return 1;
	}

	if(func_1E62())
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
func_1E62()
{
	return getdvarint("enable_analytics_log") == 1;
}

//Function Number: 4
func_81EE()
{
	var_00 = level.var_1E61.var_BF9C;
	level.var_1E61.var_BF9C++;
	return var_00;
}

//Function Number: 5
func_36A5(param_00)
{
	if(!isdefined(self.var_1E61.var_36A3))
	{
		self.var_1E61.var_36A3 = 0;
	}

	self.var_1E61.var_36A3 = self.var_1E61.var_36A3 | param_00;
}

//Function Number: 6
func_13A33()
{
	if(!analyticsactive())
	{
		return;
	}

	for(;;)
	{
		level waittill("connected",var_00);
		var_00 func_AFA8();
		var_00 thread func_13A31();
		var_00 thread func_13A5C();
		var_00 thread func_13A7E();
	}
}

//Function Number: 7
func_13A31()
{
	self endon("disconnect");
	if(!func_1E62())
	{
		return;
	}

	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_return_no_endon_death_3("adjustedStance","jumped","weapon_fired","reload_start","spawned_player");
		if(var_00 == "adjustedStance")
		{
			func_3E4C();
			continue;
		}

		if(var_00 == "jumped")
		{
			func_36A5(4);
			continue;
		}

		if(var_00 == "weapon_fired")
		{
			func_36A5(8);
			continue;
		}

		if(var_00 == "reload_start")
		{
			func_36A5(16);
			continue;
		}

		if(var_00 == "spawned_player")
		{
			thread func_AFAB();
			thread func_AFB2();
		}
	}
}

//Function Number: 8
func_13A5C()
{
	self endon("disconnect");
	if(!func_1E62())
	{
		return;
	}

	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_return_no_endon_death_3("doubleJumpBegin","doubleJumpEnd","sprint_slide_begin");
		if(var_00 == "doubleJumpBegin")
		{
			func_36A5(64);
			continue;
		}

		if(var_00 == "doubleJumpEnd")
		{
			func_36A5(128);
			continue;
		}

		if(var_00 == "sprint_slide_begin")
		{
			func_36A5(256);
		}
	}
}

//Function Number: 9
func_13A7E()
{
	self endon("disconnect");
	if(isai(self))
	{
		return;
	}

	if(getdvarint("scr_playtest",0) == 0)
	{
		return;
	}

	self notifyonplayercommand("log_user_event_start","+actionslot 3");
	self notifyonplayercommand("log_user_event_end","-actionslot 3");
	self notifyonplayercommand("log_user_event_generic_event","+gostand");
	for(;;)
	{
		self waittill("log_user_event_start");
		var_00 = scripts\common\utility::func_13734("log_user_event_end","log_user_event_generic_event");
		if(isdefined(var_00) && var_00 == "log_user_event_generic_event")
		{
			self iprintlnbold("Event Logged");
			func_AFA5(self.name,self.origin,"Generic User Event");
		}
	}
}

//Function Number: 10
func_3E4C()
{
	var_00 = self getstance();
	if(var_00 == "prone")
	{
		func_36A5(1);
		return;
	}

	if(var_00 == "crouch")
	{
		func_36A5(2);
	}
}

//Function Number: 11
func_AF93()
{
	if(!func_1E62())
	{
		return;
	}

	for(;;)
	{
		var_00 = gettime();
		var_01 = level.players;
		foreach(var_03 in var_01)
		{
			if(!func_10044(var_03))
			{
				continue;
			}

			if(isdefined(var_03) && scripts\mp\_utility::func_9F19(var_03))
			{
				var_03 func_AFA7();
				var_03 func_AFB0();
				scripts\common\utility::func_136F7();
			}
		}

		wait(max(0.05,1.5 - gettime() - var_00 / 1000));
	}
}

//Function Number: 12
func_804F()
{
	var_00 = scripts\common\utility::func_116D7(isdefined(self.var_1E61.var_36A3),self.var_1E61.var_36A3,0);
	if(self method_8446())
	{
		var_00 = var_00 | 32;
	}
}

//Function Number: 13
func_41CB()
{
	self.var_1E61.var_36A3 = 0;
	func_3E4C();
}

//Function Number: 14
func_3211()
{
	var_00 = 0;
	var_01 = self getstance();
	if(var_01 == "prone")
	{
		var_00 = var_00 | 1;
	}
	else if(var_01 == "crouch")
	{
		var_00 = var_00 | 2;
	}

	if(self isjumping())
	{
		var_00 = var_00 | 4;
	}

	if(isdefined(self.var_A9EE) && gettime() - self.var_A9EE < 500)
	{
		var_00 = var_00 | 8;
	}

	if(self method_81B8())
	{
		var_00 = var_00 | 16;
	}

	return var_00;
}

//Function Number: 15
func_3212()
{
	var_00 = "archetype=" + self.var_AE62 + ";" + "powerPrimary=" + self.var_AE7B + ";" + "powerSecondary=" + self.var_AE7D + ";" + "weaponPrimary\t =" + scripts\mp\_class::func_3224(self.var_AE7F,self.var_AE86,self.var_AE88,self.var_AE90) + ";" + "weaponSecondary =" + scripts\mp\_class::func_3224(self.var_AE94,self.var_AE9A,self.var_AE9C,self.var_AEA4) + ";";
	return var_00;
}

//Function Number: 16
func_321B(param_00)
{
	var_01 = "";
	if(isdefined(param_00.var_A94A))
	{
		if(isdefined(param_00.var_A94A["allies"]))
		{
			var_01 = var_01 + "alliesBucket=" + param_00.var_A94A["allies"] + ";";
		}

		if(isdefined(param_00.var_A94A["axis"]))
		{
			var_01 = var_01 + "axisBucket=" + param_00.var_A94A["axis"] + ";";
		}
	}

	return var_01;
}

//Function Number: 17
func_AFA7()
{
	if(!func_10044(self))
	{
		return;
	}

	var_00 = anglestoforward(self getplayerangles());
	bbprint("gamemp_path","playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f action %i health %i",self.var_1E61.var_D3AB,self.origin[0],self.origin[1],self.origin[2],var_00[0],var_00[1],var_00[2],func_804F(),func_80FF());
	func_41CB();
}

//Function Number: 18
func_AFAB()
{
	if(!func_10044(self))
	{
		return;
	}

	var_00 = isdefined(self.var_A9F4) && isdefined(self.var_A9F4.var_3165) && self.var_A9F4.var_3165;
	var_01 = anglestoforward(self.angles);
	bbprint("gamemp_spawn_in","playerid %i x %f y %f z %f orientx %f orienty %f orientz %f loadout %s type %s team %s",self.var_1E61.var_D3AB,self.origin[0],self.origin[1],self.origin[2],var_01[0],var_01[1],var_01[2],func_3212(),scripts\common\utility::func_116D7(var_00,"Buddy","Normal"),self.team);
}

//Function Number: 19
func_AFA8()
{
	if(!analyticsactive())
	{
		return;
	}

	if(!isdefined(self.var_1E61))
	{
		self.var_1E61 = spawnstruct();
	}

	self.var_1E61.var_D3AB = level.var_1E61.var_BFA4;
	level.var_1E61.var_BFA4++;
	if(!func_1E62())
	{
		return;
	}

	var_00 = scripts\mp\_class::func_3688();
	var_01 = self getxuid();
	bbprint("gamemp_player_connect","playerid %i player_name %s player_xuid %s player_super_name %s",self.var_1E61.var_D3AB,self.name,var_01,var_00);
}

//Function Number: 20
func_AFA9(param_00,param_01,param_02)
{
	if(!func_10044(self) || !isplayer(self))
	{
		return;
	}

	var_03 = anglestoforward(self getplayerangles());
	var_04 = -1;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	var_0B = "s";
	var_0C = 0;
	if(isdefined(param_00) && isplayer(param_00))
	{
		var_04 = param_00.var_1E61.var_D3AB;
		if(isdefined(param_00.team))
		{
			if(param_00.team == "axis")
			{
				var_0B = "a";
			}
			else
			{
				var_0B = "l";
			}
		}

		if(isdefined(param_00.origin))
		{
			var_05 = param_00.origin[0];
			var_06 = param_00.origin[1];
			var_07 = param_00.origin[2];
		}

		if(isdefined(param_00.var_AC68))
		{
			var_0C = param_00.var_AC68;
		}

		var_0D = anglestoforward(param_00 getplayerangles());
		if(isdefined(var_0D))
		{
			var_08 = var_0D[0];
			var_09 = var_0D[1];
			var_0A = var_0D[2];
		}
	}

	var_0E = level.var_1E61.var_BF79;
	level.var_1E61.var_BF79++;
	param_02 = scripts\common\utility::func_116D7(isdefined(param_02),param_02,"None");
	var_0F = "s";
	if(self.team == "axis")
	{
		var_0F = "a";
	}
	else
	{
		var_0F = "l";
	}

	bbprint("gamemp_death","@"playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f weapon %s mean_of_death %s attackerid %i action %i server_death_id %i victim_life_index %d attacker_life_index %d victim_team %s attacker_team %s attacker_pos_x %f attacker_pos_y %f attacker_pos_z %f attacker_gun_orientx %f attacker_gun_orienty %f attacker_gun_orientz %f victim_weapon %s",self.var_1E61.var_D3AB,self.origin[0],self.origin[1],self.origin[2],var_03[0],var_03[1],var_03[2],param_02,scripts\common\utility::func_116D7(isdefined(param_01),param_01,"None"),var_04,func_3211(),var_0E,self.var_AC68,var_0C,var_0F,var_0B,var_05,var_06,var_07,var_08,var_09,var_0A,self.var_D8E1);
	if(isdefined(param_01) && function_0107(param_01))
	{
		func_AF9E(scripts\common\utility::func_116D7(isdefined(param_02),param_02,"generic"),self.origin,param_00,1);
	}

	if(isdefined(self.var_2507))
	{
		foreach(var_11 in self.var_2507)
		{
			if(isdefined(var_11) && isplayer(var_11) && var_11 != param_00)
			{
				func_AF9C(var_11.var_1E61.var_D3AB,var_0E,param_02);
			}
		}
	}
}

//Function Number: 21
func_AFAA(param_00,param_01,param_02)
{
	if(!func_10044(self))
	{
		return;
	}

	var_03 = anglestoforward(self getplayerangles());
	bbprint("gamemp_kill","playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f weapon %s mean_of_kill %s victimid %i action %i attacker_health %i victim_pixel_count %i",self.var_1E61.var_D3AB,self.origin[0],self.origin[1],self.origin[2],var_03[0],var_03[1],var_03[2],scripts\common\utility::func_116D7(isdefined(param_02),param_02,"None"),scripts\common\utility::func_116D7(isdefined(param_01),param_01,"None"),scripts\common\utility::func_116D7(isdefined(param_00) && isplayer(param_00),param_00.var_1E61.var_D3AB,"-1"),func_3211(),func_80FF(),0);
}

//Function Number: 22
func_AF9E(param_00,param_01,param_02,param_03,param_04)
{
	if(!func_1E62())
	{
		return;
	}

	if(!isdefined(param_04))
	{
		param_04 = (1,0,0);
	}

	bbprint("gamemp_explosion","playerid %i x %f y %f z %f orientx %f orienty %f orientz %f duration %i type %s",param_02.var_1E61.var_D3AB,param_01[0],param_01[1],param_01[2],param_04[0],param_04[1],param_04[2],param_03,param_00);
}

//Function Number: 23
func_AFB2()
{
	if(!func_1E62())
	{
		return;
	}

	if(!isdefined(level.var_108FB))
	{
		return;
	}

	foreach(var_01 in level.var_108FB)
	{
		bbprint("gamemp_spawn_point","x %f y %f z %f allies_score %i axis_score %i allies_max_score %i axis_max_score %i state %s",var_01.origin[0],var_01.origin[1],var_01.origin[2],scripts\common\utility::func_116D7(isdefined(var_01.var_A9E9["allies"]),var_01.var_A9E9["allies"],0),scripts\common\utility::func_116D7(isdefined(var_01.var_A9E9["axis"]),var_01.var_A9E9["axis"],0),scripts\common\utility::func_116D7(isdefined(var_01.var_11A3A),var_01.var_11A3A,0),scripts\common\utility::func_116D7(isdefined(var_01.var_11A3A),var_01.var_11A3A,0),func_321B(var_01));
	}
}

//Function Number: 24
func_AF9F(param_00,param_01,param_02,param_03,param_04)
{
	if(!func_1E62())
	{
		return;
	}

	bbprint("gamemp_front_line","startx %f starty %f endx %f endy %f axis_centerx %f axis_centery %f allies_centerx %f allies_centery %f, state %i",param_00[0],param_00[1],param_01[0],param_01[1],param_03[0],param_03[1],param_02[0],param_02[1],param_04);
}

//Function Number: 25
func_AFA0(param_00,param_01,param_02,param_03,param_04)
{
	if(!func_1E62())
	{
		return;
	}

	bbprint("gamemp_object","uniqueid %i x %f y %f z %f ownerid %i type %s state %s",param_01,param_02[0],param_02[1],param_02[2],param_03,param_00,param_04);
}

//Function Number: 26
func_AFA5(param_00,param_01,param_02)
{
	if(!func_1E62())
	{
		return;
	}

	bbprint("gamemp_message","ownerid %s x %f y %f z %f message %s",param_00,param_01[0],param_01[1],param_01[2],param_02);
}

//Function Number: 27
func_AFB5(param_00)
{
	if(!func_1E62())
	{
		return;
	}

	bbprint("gamemp_matchtags","message %s",param_00);
}

//Function Number: 28
func_AFAC(param_00,param_01)
{
	if(!func_10044(self))
	{
		return;
	}

	var_02 = anglestoforward(self.angles);
	bbprint("gamemp_power","ownerid %i x %f y %f z %f orientx %f orienty %f orientz %f type %s state %s",self.var_1E61.var_D3AB,self.origin[0],self.origin[1],self.origin[2],var_02[0],var_02[1],var_02[2],param_00,param_01);
}

//Function Number: 29
func_AFB0()
{
	if(!func_10044(self))
	{
		return;
	}

	var_00 = anglestoforward(self.angles);
	bbprint("gamemp_scoreboard","ownerid %i score %i",self.var_1E61.var_D3AB,self.var_278);
}

//Function Number: 30
func_AFA6()
{
	if(!func_1E62())
	{
		return;
	}

	var_00 = getentarray("minimap_corner","targetname");
	if(!isdefined(var_00) || var_00.size != 2)
	{
		return;
	}

	bbprint("gamemp_map","cornera_x %f cornera_y %f cornerb_x %f cornerb_y %f north %f",var_00[0].origin[0],var_00[0].origin[1],var_00[1].origin[0],var_00[1].origin[1],getnorthyaw());
}

//Function Number: 31
func_AF9C(param_00,param_01,param_02)
{
	if(!func_1E62())
	{
		return;
	}

	bbprint("gamemp_assists","playerid %i server_death_id %i weapon %s",param_00,param_01,param_02);
}

//Function Number: 32
func_80FF()
{
	return int(clamp(self.health,0,100000));
}

//Function Number: 33
func_10044(param_00)
{
	if(!func_1E62())
	{
		return 0;
	}

	if(!isdefined(param_00.team) || param_00.team == "spectator" || param_00.sessionstate != "playing" && param_00.sessionstate != "dead")
	{
		return 0;
	}

	return 1;
}

//Function Number: 34
func_AFCA()
{
	var_00 = getdvar("scr_analytics_tag","");
	if(var_00 != "")
	{
		func_AFB5(var_00);
	}

	if(scripts\mp\_utility::func_B3EC())
	{
		func_AFB5("OnlineMatch");
		return;
	}

	if(getdvarint("xblive_privatematch"))
	{
		func_AFB5("PrivateMatch");
		return;
	}

	if(!getdvarint("onlinegame"))
	{
		func_AFB5("OfflineMatch");
		return;
	}
}

//Function Number: 35
func_AFB4(param_00,param_01,param_02,param_03)
{
	if(!func_1E62())
	{
		return;
	}

	var_04 = -1;
	if(isdefined(self.var_1E61) && isdefined(self.var_1E61.var_D3AB))
	{
		var_04 = self.var_1E61.var_D3AB;
	}

	bbprint("analytics_mp_supers","super_name %s time_to_use %i num_hits %i num_kills %i player_id %i",param_00,param_01,param_02,param_03,var_04);
}

//Function Number: 36
func_AFB3(param_00)
{
	if(!func_1E62())
	{
		return;
	}

	var_01 = -1;
	if(isdefined(self.var_1E61) && isdefined(self.var_1E61.var_D3AB))
	{
		var_01 = self.var_1E61.var_D3AB;
	}

	bbprint("analytics_mp_super_earned","match_time %i player_id %i",param_00,var_01);
}

//Function Number: 37
func_AFA4(param_00,param_01)
{
	if(!func_1E62())
	{
		return;
	}

	var_02 = -1;
	if(isdefined(self.var_1E61) && isdefined(self.var_1E61.var_D3AB))
	{
		var_02 = self.var_1E61.var_D3AB;
	}

	bbprint("analytics_mp_killstreak_earned","killstreak_name %d match_time %i player_id %i",param_00,param_01,var_02);
}

//Function Number: 38
func_AFA3(param_00,param_01)
{
	if(!func_1E62())
	{
		return;
	}

	var_02 = -1;
	if(isdefined(self.var_1E61) && isdefined(self.var_1E61.var_D3AB))
	{
		var_02 = self.var_1E61.var_D3AB;
	}

	bbprint("analytics_mp_killstreak","killstreak_name %s time_to_activate %i player_id %i",param_00,param_01,var_02);
}

//Function Number: 39
func_AF9D(param_00)
{
	if(!func_1E62())
	{
		return;
	}

	bbprint("analytics_mp_awards","award_message %s",param_00);
}

//Function Number: 40
func_AFA2(param_00,param_01,param_02,param_03)
{
	if(!func_1E62())
	{
		return;
	}

	var_04 = -1;
	if(isdefined(self.var_1E61) && isdefined(self.var_1E61.var_D3AB))
	{
		var_04 = self.var_1E61.var_D3AB;
	}

	bbprint("analytics_mp_player_xp","current_prestige %d current_level %d xp_gained %d xp_source %s player_id %i",param_00,param_01,param_02,param_03,var_04);
}

//Function Number: 41
func_AFA1(param_00,param_01,param_02,param_03,param_04)
{
	if(!func_1E62())
	{
		return;
	}

	var_05 = -1;
	if(isdefined(self.var_1E61) && isdefined(self.var_1E61.var_D3AB))
	{
		var_05 = self.var_1E61.var_D3AB;
	}

	bbprint("analytics_mp_weapon_xp","weapon %s current_prestige %d current_level %d xp_gained %d xp_source %s player_id %i",param_00,param_01,param_02,param_03,param_04,var_05);
}

//Function Number: 42
func_AFB1()
{
	if(!func_1E62())
	{
		return;
	}

	var_00 = [];
	var_01 = [];
	var_02 = 0;
	for(var_02 = 0;var_02 < 12;var_02++)
	{
		var_00[var_02] = 0;
		var_01[var_02] = "";
	}

	var_02 = 0;
	foreach(var_04 in level.players)
	{
		if(!isai(var_04))
		{
			var_00[var_02] = var_04.var_1E61.var_D3AB;
			var_01[var_02] = var_04 getxuid();
		}

		var_02 = var_02 + 1;
	}

	bbprint("analytics_match_player_index_init","@"player1_index %d player1_xuid %s player2_index %d player2_xuid %s player3_index %d player3_xuid %s player4_index %d player4_xuid %s player5_index %d player5_xuid %s player6_index %d player6_xuid %s player7_index %d player7_xuid %s player8_index %d player8_xuid %s player9_index %d player9_xuid %s player10_index %d player10_xuid %s player11_index %d player11_xuid %s player12_index %d player12_xuid %s",var_00[0],var_01[0],var_00[1],var_01[1],var_00[2],var_01[2],var_00[3],var_01[3],var_00[4],var_01[4],var_00[5],var_01[5],var_00[6],var_01[6],var_00[7],var_01[7],var_00[8],var_01[8],var_00[9],var_01[9],var_00[10],var_01[10],var_00[11],var_01[11]);
}

//Function Number: 43
func_1E6A()
{
	return getdvarint("enable_analytics_spawn_log") != 0;
}

//Function Number: 44
func_9CCB(param_00,param_01)
{
	return param_00 < param_01;
}

//Function Number: 45
func_1E6B()
{
	if(isdefined(level.var_10841) && isdefined(level.var_108D8) && isdefined(level.var_BFAC))
	{
		game["spawnCount"] = level.var_10841;
		game["spawnIdsToBeInstrumented"] = level.var_108D8;
		game["nextSpawnToBeInstrumented"] = level.var_BFAC;
	}
}

//Function Number: 46
func_1E5E()
{
	if(isdefined(level.var_10841) && isdefined(level.var_108D8) && isdefined(level.var_BFAC))
	{
		return 1;
	}

	return 0;
}

//Function Number: 47
func_1E60()
{
	var_00 = game["spawnCount"];
	var_01 = game["spawnIdsToBeInstrumented"];
	var_02 = game["nextSpawnToBeInstrumented"];
	if(isdefined(var_00) && isdefined(var_01) && isdefined(var_02))
	{
		level.var_10841 = var_00;
		level.var_108D8 = var_01;
		level.var_BFAC = var_02;
		return;
	}

	level.var_10841 = 0;
	level.var_108D8 = [];
	level.var_BFAC = 0;
	var_03 = getdvarint("analytics_spawn_event_log_count");
	var_04 = func_1E5D();
	var_05 = [];
	for(var_06 = 0;var_06 < var_03;var_06++)
	{
		var_07 = randomintrange(20,var_04);
		if(isdefined(var_05[var_07]))
		{
			level.var_108D8[var_06] = -1;
			continue;
		}

		var_05[var_07] = 1;
		level.var_108D8[var_06] = var_07;
	}

	level.var_108D8 = scripts\common\utility::func_22C3(level.var_108D8,::func_9CCB);
}

//Function Number: 48
func_1E65(param_00)
{
	if(isdefined(level.var_BFAC) && isdefined(level.var_108D8))
	{
		if(level.var_BFAC < level.var_108D8.size)
		{
			if(level.var_108D8[level.var_BFAC] == -1)
			{
				level.var_BFAC++;
			}

			if(level.var_108D8[level.var_BFAC] == param_00)
			{
				level.var_BFAC++;
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 49
func_1E68(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_spawnfactor::func_7ED7();
	var_05 = var_04.var_B72B;
	var_06 = 0;
	var_07 = 0;
	var_08 = 0;
	if(isdefined(var_05))
	{
		var_06 = var_05[0];
		var_07 = var_05[1];
		var_08 = var_05[2];
	}

	var_09 = 0;
	if(isdefined(var_04.var_115C7))
	{
		var_09 = var_04.var_115C7;
	}

	var_0A = var_04.var_9D25[param_01];
	var_0B = 0;
	if(isdefined(var_04.var_55DD) && isdefined(var_04.var_55DD[param_01]))
	{
		var_0B = var_04.var_55DD[param_01];
	}

	var_0C = level.var_108D1.var_AFC0;
	var_0D = 0;
	if(isdefined(level.var_108D1.var_3164))
	{
		var_0D = level.var_108D1.var_3164;
		level.var_108D1.var_3164 = 0;
	}

	bbreportspawntypes(var_06,var_07,var_08,var_09,param_03,var_0A,var_0B,param_02,var_0C,var_0D);
}

//Function Number: 50
func_1E67(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		if(scripts\mp\_utility::func_9F19(var_04))
		{
			var_05 = var_04 getplayerangles();
			var_06 = vectortoyaw(var_05);
			var_07 = var_04.origin[0];
			var_08 = var_04.origin[1];
			var_09 = var_04.origin[2];
			var_0A = 0;
			if(var_04 == param_00)
			{
				var_0A = 1;
			}

			var_0B = 0;
			if(isdefined(param_00.var_1B1) && param_00.var_1B1 == var_04)
			{
				var_0B = 1;
			}

			var_0C = 0;
			if(var_04.team == "axis")
			{
				var_0C = 1;
			}
			else if(var_04.team == "allies")
			{
				var_0C = 2;
			}

			var_0D = 0;
			if(isdefined(var_04.var_1E61.var_D3AB))
			{
				var_0D = var_04.var_1E61.var_D3AB;
			}

			bbreportspawnplayerdetails(param_02,var_06,var_07,var_08,var_09,var_0D,var_0C,var_0A,var_0B);
		}
	}
}

//Function Number: 51
func_1E66(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in level.var_108D1.var_108FD)
	{
		var_06 = var_05.var_11A3B;
		var_07 = var_05.var_1E5B.var_1D30;
		var_08 = var_05.var_1E5B.var_654A;
		var_09 = var_05.var_1E5B.var_1192A;
		var_0A = 0;
		if(isdefined(param_00.var_A9F4) && param_00.var_A9F4 == var_05)
		{
			var_0A = 1;
		}

		var_0B = 0;
		if(param_03 == var_05)
		{
			var_0B = 1;
		}

		var_0C = var_05.var_1E5B.var_B498;
		var_0D = var_05.var_1E5B.var_DCC5;
		var_0E = var_05.var_1E5B.var_1091B;
		var_0F = 0;
		if(var_05.var_A9F5 == "axis")
		{
			var_0F = 1;
		}
		else if(var_05.var_A9F5 == "allies")
		{
			var_0F = 2;
		}

		var_10 = var_05.var_A9F6;
		var_11 = var_05.var_1E5B.var_B4A5;
		var_12 = 0;
		if(isdefined(var_05.index) && var_05.index <= 1023)
		{
			var_12 = var_05.index;
		}

		var_13 = 0;
		if(isdefined(var_05.var_1E5B) && isdefined(var_05.var_1E5B.var_10919))
		{
			var_13 = var_05.var_1E5B.var_10919;
		}

		var_14 = 0;
		if(isdefined(var_05.var_275D))
		{
			var_14 = var_05.var_275D;
		}

		bbreportspawnfactors(2,var_06,var_0C,var_11,var_0D,param_02,var_07,var_08,var_0B,var_0A,var_0F,var_12,var_0E,var_09,var_13,var_14);
	}
}

//Function Number: 52
func_1E5D()
{
	var_00 = 120;
	if(isdefined(level.gametype))
	{
		if(level.gametype == "war")
		{
			var_00 = 120;
		}
		else if(level.gametype == "dom")
		{
			var_00 = 120;
		}
		else if(level.gametype == "conf")
		{
			var_00 = 120;
		}
		else if(level.gametype == "front")
		{
			var_00 = 40;
		}
		else if(level.gametype == "sd")
		{
			var_00 = 50;
		}
		else if(level.gametype == "dm")
		{
			var_00 = 50;
		}
		else if(level.gametype == "koth")
		{
			var_00 = 125;
		}
		else if(level.gametype == "ctf")
		{
			var_00 = 50;
		}
		else if(level.gametype == "tdef")
		{
			var_00 = 75;
		}
		else if(level.gametype == "siege")
		{
			var_00 = 25;
		}
		else if(level.gametype == "gun")
		{
			var_00 = 50;
		}
		else if(level.gametype == "sr")
		{
			var_00 = 25;
		}
		else if(level.gametype == "grind")
		{
			var_00 = 75;
		}
		else if(level.gametype == "ball")
		{
			var_00 = 50;
		}
	}

	return var_00;
}

//Function Number: 53
func_AFAD(param_00,param_01,param_02)
{
	if(!func_1E62())
	{
		return;
	}

	var_03 = 1;
	if(!isdefined(param_02))
	{
		param_02 = -1;
	}

	bbprint("analytics_mp_score_event","score_type %d score_points %d score_eventid %d game_time %d player_id %d",var_03,param_00,param_02,param_01,self.var_1E61.var_D3AB);
}

//Function Number: 54
func_AFAE(param_00,param_01,param_02)
{
	if(!func_1E62())
	{
		return;
	}

	var_03 = 2;
	if(!isdefined(param_02))
	{
		param_02 = -1;
	}

	bbprint("analytics_mp_score_event","score_type %d score_points %d score_eventid %d game_time %d player_id %d",var_03,param_00,param_02,param_01,self.var_1E61.var_D3AB);
}

//Function Number: 55
func_AFAF(param_00,param_01)
{
	if(!func_1E62())
	{
		return;
	}

	var_02 = 3;
	bbprint("analytics_mp_score_event","score_type %d score_points %d game_time %d player_id %d",var_02,param_00,param_01,self.var_1E61.var_D3AB);
}