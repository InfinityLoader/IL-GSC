/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\solo_challenges.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 1381 ms
 * Timestamp: 10/27/2023 12:09:07 AM
*******************************************************************/

//Function Number: 1
init_solo_challenges()
{
	func_956D();
	func_97B0();
}

//Function Number: 2
func_956D()
{
	var_00 = getdvar("ui_mapname");
	level.var_13F16 = "cp/zombies/" + var_00 + "_challenges.csv";
	if(!tableexists(level.var_13F16))
	{
		level.var_13F16 = undefined;
	}

	level.var_3C17 = [];
	if(isdefined(level.challenge_registration_func))
	{
		[[ level.challenge_registration_func ]]();
	}
}

//Function Number: 3
func_12D9C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isplayer(self))
	{
		if(!func_4B4D(param_00))
		{
			return;
		}

		var_0A = self.var_4B4A;
		self thread [[ var_0A.var_12E9C ]](param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		return;
	}

	if(!var_0A func_4B4D(param_01))
	{
		return;
	}

	var_0A = var_0A.var_4B4A;
	param_09 thread [[ var_0A.var_12E9C ]](param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 4
func_62C6()
{
	if(func_4B4B() && scripts\cp\_utility::func_462B("challenge"))
	{
		func_4DAE();
	}
}

//Function Number: 5
func_4DAE(param_00)
{
	if(!func_4B4B())
	{
		return;
	}

	var_01 = param_00.var_4B4A;
	param_00 func_12BF7();
	if(var_01 [[ var_01.var_9F82 ]](param_00))
	{
		func_56AD("challenge_success",0,undefined,param_00);
		var_01 [[ var_01.var_E4C5 ]]();
		var_02 = "challenge";
		if(isdefined(level.var_3C24))
		{
			var_02 = level.var_3C24;
		}

		if(func_9F17(var_01))
		{
			if(param_00.var_134FD == "p5_" || param_00.var_134FD == "p6_")
			{
				param_00 thread scripts\cp\_vo::try_to_play_vo("challenge_success","zmb_comment_vo");
			}
		}
	}
	else
	{
		func_56AD("challenge_failed",0,undefined,param_00);
		if(func_9F17(var_01))
		{
			if(isdefined(level.var_3C2B[var_01.var_DE3F]) && func_9F17(var_01))
			{
				level.var_3C2B[var_01.var_DE3F]++;
			}

			if(var_01.var_DE3F == "no_laststand" || var_01.var_DE3F == "no_bleedout" || var_01.var_DE3F == "protect_player")
			{
				scripts\cp\zombies\zombie_analytics::func_AF64(var_01.var_DE3F,level.wave_num,0,level.var_3C2B[var_01.var_DE3F]);
			}
			else
			{
				scripts\cp\zombies\zombie_analytics::func_AF64(var_01.var_DE3F,level.wave_num,var_01.var_4BA0 / var_01.var_155 * 100,level.var_3C2B[var_01.var_DE3F]);
			}

			foreach(param_00 in level.players)
			{
				if(!scripts\cp\_utility::isplayingsolo() && level.players.size > 1)
				{
					scripts\cp\_vo::try_to_play_vo_on_all_players("challenge_fail_team");
					continue;
				}

				param_00 thread scripts\cp\_vo::try_to_play_vo("challenge_fail_solo","zmb_comment_vo");
			}
		}

		var_01 [[ var_01.var_6AD0 ]]();
		level.var_1BE8 = 0;
		scripts\cp\_persistence::func_12DDB(0);
		scripts\cp\_analytics::func_12D9F(var_01.var_DE3F,0);
	}

	level notify("challenge_deactivated");
	var_01 [[ var_01.var_4DDE ]](param_00);
}

//Function Number: 6
func_9F17(param_00)
{
	switch(param_00.var_DE3F)
	{
		case "challenge_success":
		case "challenge_failed":
		case "next_challenge":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 7
copy_challenge_struct(param_00)
{
	var_01 = level.var_3C17[param_00];
	var_02 = spawnstruct();
	var_02.var_DE3F = var_01.var_DE3F;
	var_02.var_155 = var_01.var_155;
	var_02.var_5021 = var_01.var_5021;
	var_02.var_9F82 = var_01.var_9F82;
	var_02.var_386E = var_01.var_386E;
	var_02.var_1609 = var_01.var_1609;
	var_02.var_4DDE = var_01.var_4DDE;
	var_02.var_6ACB = var_01.var_6ACB;
	var_02.var_12E9C = var_01.var_12E9C;
	var_02.var_E4C5 = var_01.var_E4C5;
	var_02.var_6AD0 = var_01.var_6AD0;
	return var_02;
}

//Function Number: 8
func_15D7(param_00,param_01)
{
	param_01.var_4B4A = copy_challenge_struct(param_00);
	if(param_01.var_4B4A [[ param_01.var_4B4A.var_386E ]]())
	{
		var_02 = func_7897(param_00);
		if(isdefined(var_02))
		{
			param_01.var_4B4A.var_155 = var_02;
		}
		else
		{
			level.var_4B52 = -1;
		}

		func_56AD(param_00,1,var_02,param_01);
		param_01 func_F31A(param_00);
		param_01 notify("new_challenge_started");
		param_01.var_4B4A [[ param_01.var_4B4A.var_1609 ]](param_01);
		return;
	}

	param_01.var_4B4A [[ param_01.var_4B4A.var_6ACB ]]();
}

//Function Number: 9
func_7897(param_00)
{
	return [[ level.challenge_scalar_func ]](param_00);
}

//Function Number: 10
func_56AD(param_00,param_01,param_02,param_03)
{
	var_04 = tablelookup(level.var_13F16,1,param_00,0);
	if(param_01)
	{
		if(param_00 == "next_challenge")
		{
			param_03 playlocalsound("zmb_challenge_config");
		}
		else
		{
			param_03 playlocalsound("zmb_challenge_start");
		}

		param_03 setclientomnvar("zm_show_challenge",-1);
		wait(0.05);
		if(level.script != "cp_disco")
		{
			param_03 setclientomnvar("ui_intel_active_index",-1);
		}

		param_03 setclientomnvar("ui_intel_progress_current",-1);
		wait(0.05);
		param_03 setclientomnvar("ui_intel_progress_max",-1);
		param_03 setclientomnvar("ui_intel_percent",-1);
		wait(0.05);
		param_03 setclientomnvar("ui_intel_target_player",-1);
		param_03 setclientomnvar("ui_intel_prechallenge",0);
		wait(0.05);
		param_03 setclientomnvar("ui_intel_timer",-1);
		param_03 setclientomnvar("ui_intel_challenge_scalar",-1);
		wait(0.3);
		if(isdefined(param_02))
		{
			var_05 = param_02;
			if(isdefined(param_03.kung_fu_progression) && isdefined(param_03.kung_fu_progression.active_discipline))
			{
				var_05 = param_02 - param_03.kung_fu_progression.challenge_progress[param_03.kung_fu_progression.active_discipline];
			}

			param_03 setclientomnvar("ui_intel_challenge_scalar",param_02);
			param_03 setclientomnvar("ui_intel_progress_max",param_02);
			param_03 setclientomnvar("ui_intel_progress_current",var_05);
		}
		else
		{
			param_03 setclientomnvar("ui_intel_challenge_scalar",-1);
		}

		param_03 setclientomnvar("ui_intel_prechallenge",1);
		param_03 setclientomnvar("ui_intel_active_index",int(var_04));
		param_03.var_4B4C = int(var_04);
		param_03 setclientomnvar("ui_intel_timer",-1);
		param_03 setclientomnvar("zm_show_challenge",4);
		return;
	}

	level thread func_100CB(param_00,var_04,param_03);
}

//Function Number: 11
func_100CB(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_02 endon("disconnect");
	wait(1);
	if(param_00 == "challenge_failed")
	{
		param_02 playlocalsound("zmb_challenge_fail");
		param_02 setclientomnvar("zm_show_challenge",2);
	}
	else
	{
		param_02 playlocalsound("zmb_challenge_complete");
		param_02 setclientomnvar("zm_show_challenge",3);
	}

	if(isdefined(level.show_challenge_outcome_func))
	{
		[[ level.show_challenge_outcome_func ]](param_00,param_01,param_02);
		return;
	}

	wait(3);
	param_02 thread func_E20D();
	setomnvar("zm_challenge_progress",0);
}

//Function Number: 12
func_E20D()
{
	self notify("challenge_complete");
	wait(0.5);
	if(level.script != "cp_disco")
	{
		self setclientomnvar("ui_intel_active_index",-1);
	}

	self setclientomnvar("ui_intel_progress_current",-1);
	self setclientomnvar("ui_intel_progress_max",-1);
	self setclientomnvar("ui_intel_percent",-1);
	self setclientomnvar("ui_intel_target_player",-1);
	self setclientomnvar("ui_intel_prechallenge",0);
	self setclientomnvar("ui_intel_timer",-1);
	self setclientomnvar("ui_intel_challenge_scalar",-1);
	self setclientomnvar("zm_show_challenge",-1);
}

//Function Number: 13
func_DEA1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = spawnstruct();
	var_0B.var_DE3F = param_00;
	var_0B.var_155 = param_01;
	var_0B.var_5021 = param_02;
	var_0B.var_9F82 = ::func_4FFA;
	if(isdefined(param_03))
	{
		var_0B.var_9F82 = param_03;
	}

	var_0B.var_386E = ::func_4FDD;
	if(isdefined(param_04))
	{
		var_0B.var_386E = param_04;
	}

	var_0B.var_1609 = param_05;
	var_0B.var_4DDE = param_06;
	var_0B.var_6ACB = ::func_4FED;
	if(isdefined(param_07))
	{
		var_0B.var_6ACB = param_07;
	}

	var_0B.var_12E9C = param_08;
	var_0B.var_E4C5 = ::func_5011;
	if(isdefined(param_09))
	{
		var_0B.var_E4C5 = param_09;
	}

	var_0B.var_6AD0 = ::func_4FEE;
	if(isdefined(param_0A))
	{
		var_0B.var_6AD0 = param_0A;
	}

	level.var_3C17[param_00] = var_0B;
}

//Function Number: 14
func_12D9E(param_00,param_01)
{
	self setclientomnvar("zm_show_challenge",1);
	self setclientomnvar("ui_intel_progress_current",param_00);
}

//Function Number: 15
func_4FDD()
{
	return 1;
}

//Function Number: 16
func_4FED()
{
}

//Function Number: 17
func_4FFA()
{
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return 0;
}

//Function Number: 18
func_5022()
{
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return self.var_5021;
}

//Function Number: 19
func_4FEE()
{
}

//Function Number: 20
func_5010()
{
	self.var_4B4A.var_111AE = self.var_4B4A.var_5021;
}

//Function Number: 21
func_5011()
{
}

//Function Number: 22
func_4B4B()
{
	return isdefined(self.var_4B4A);
}

//Function Number: 23
func_4B4D(param_00)
{
	return func_4B4B() && self.current_player_challenge == param_00;
}

//Function Number: 24
func_12BF7()
{
	self.var_4B4A = undefined;
}

//Function Number: 25
func_F31A(param_00)
{
	self.current_player_challenge = param_00;
}

//Function Number: 26
func_97B0()
{
	if(!isdefined(level.var_13F16))
	{
		return;
	}

	var_00 = level.var_13F16;
	var_01 = 0;
	var_02 = 1;
	var_03 = 99;
	var_04 = 1;
	var_05 = 2;
	var_06 = 6;
	var_07 = 7;
	var_08 = 8;
	for(var_09 = var_02;var_09 <= var_03;var_09++)
	{
		var_0A = tablelookup(var_00,var_01,var_09,var_04);
		if(var_0A == "")
		{
			break;
		}

		var_0B = tablelookup(var_00,var_01,var_09,var_05);
		var_0C = tablelookup(var_00,var_01,var_09,var_08);
		if(isdefined(level.var_3C17[var_0A]))
		{
			level.var_3C17[var_0A].var_1C81 = var_0B;
			level.var_3C17[var_0A].var_1C8C = int(tablelookup(var_00,var_01,var_09,var_06));
			level.var_3C17[var_0A].var_1649 = strtok(var_0C," ");
		}
	}
}

//Function Number: 27
func_4FE2(param_00)
{
	return 1;
}

//Function Number: 28
func_12DA9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::istrue(self.var_54CB))
	{
		return;
	}

	var_09 = param_01;
	if(isdefined(param_01.playerowner) && param_01.playerowner scripts\cp\_utility::is_valid_player(1))
	{
		var_09 = param_01.playerowner;
	}

	if(!isplayer(var_09))
	{
		return;
	}

	if(!isdefined(var_09.var_4B4A))
	{
		return;
	}

	var_0A = var_09.var_4B4A;
	if(isdefined(level.custom_death_challenge_func))
	{
		var_0B = self [[ level.custom_death_challenge_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		if(!scripts\common\utility::istrue(var_0B))
		{
			return;
		}
	}
}