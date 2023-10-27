/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\_challenge.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 1076 ms
 * Timestamp: 10/27/2023 12:23:29 AM
*******************************************************************/

//Function Number: 1
init_coop_challenge()
{
	func_956D();
	if(!isdefined(level.challenge_scalar_func))
	{
		level.challenge_scalar_func = ::func_4FE2;
	}

	func_97B0();
}

//Function Number: 2
func_C9B9()
{
	[[ level.challenge_pause_func ]]();
}

//Function Number: 3
func_956D()
{
	scripts\common\utility::flag_init("pause_challenges");
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

	level.var_4B4C = -1;
	level.var_4B51 = -1;
	level.var_4B50 = -1;
	level.var_4B4E = -1;
	level.var_4B53 = -1;
	level.var_4B54 = -1;
	level.var_4B52 = -1;
	level.var_4B55 = -1;
	level.var_4B4F = 0;
	level.var_1BE8 = 1;
	level.var_D7B7 = 0;
	level.var_C1E1 = 0;
	level.var_110AC = 0;
}

//Function Number: 4
func_12D9C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!func_4B4D(param_00) || !scripts\cp\_utility::func_462B("challenge"))
	{
		return;
	}

	if(level.var_D7B7)
	{
		return;
	}

	var_0A = level.var_3C17[level.var_4B4A];
	var_0A thread [[ var_0A.var_12E9C ]](param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 5
func_62C6()
{
	if(func_4B4B() && scripts\cp\_utility::func_462B("challenge"))
	{
		func_4DAE();
	}
}

//Function Number: 6
func_4DAE()
{
	if(!func_4B4B())
	{
		return;
	}

	var_00 = level.var_3C17[level.var_4B4A];
	func_12BF7();
	if(var_00 [[ var_00.var_9F82 ]]())
	{
		func_56AD("challenge_success",0);
		var_00 [[ var_00.var_E4C5 ]]();
		var_01 = "challenge";
		if(isdefined(level.var_3C24))
		{
			var_01 = level.var_3C24;
		}

		lib_0A54::func_12E13(var_01,"challenge_complete");
		scripts\cp\_persistence::func_12DDB(1);
		scripts\cp\_analytics::func_12D9F(var_00.var_DE3F,1);
		if(func_9F17(var_00))
		{
			if(level.var_4B54 - level.var_110AD <= 0.01)
			{
				scripts\cp\zombies\zombie_analytics::func_AF63(var_00.var_DE3F,level.wave_num,level.var_110AD - level.var_4B54);
			}
			else
			{
				scripts\cp\zombies\zombie_analytics::func_AF63(var_00.var_DE3F,level.wave_num,level.var_4B54);
			}

			foreach(var_03 in level.players)
			{
				var_03 thread scripts\cp\_vo::try_to_play_vo("challenge_success_generic","zmb_comment_vo");
			}

			level.var_C1E1++;
		}
	}
	else
	{
		func_56AD("challenge_failed",0);
		if(func_9F17(var_00))
		{
			if(isdefined(level.var_3C2B[var_00.var_DE3F]) && func_9F17(var_00))
			{
				level.var_3C2B[var_00.var_DE3F]++;
			}

			if(var_00.var_DE3F == "no_laststand" || var_00.var_DE3F == "no_bleedout" || var_00.var_DE3F == "protect_player")
			{
				scripts\cp\zombies\zombie_analytics::func_AF64(var_00.var_DE3F,level.wave_num,0,level.var_3C2B[var_00.var_DE3F]);
			}
			else
			{
				scripts\cp\zombies\zombie_analytics::func_AF64(var_00.var_DE3F,level.wave_num,var_00.var_4BA0 / var_00.var_155 * 100,level.var_3C2B[var_00.var_DE3F]);
			}

			foreach(var_03 in level.players)
			{
				if(!scripts\cp\_utility::isplayingsolo() && level.players.size > 1)
				{
					scripts\cp\_vo::try_to_play_vo_on_all_players("challenge_fail_team");
					continue;
				}

				var_03 thread scripts\cp\_vo::try_to_play_vo("challenge_fail_solo","zmb_comment_vo");
			}
		}

		var_00 [[ var_00.var_6AD0 ]]();
		level.var_1BE8 = 0;
		scripts\cp\_persistence::func_12DDB(0);
		scripts\cp\_analytics::func_12D9F(var_00.var_DE3F,0);
	}

	level notify("challenge_deactivated");
	var_00 [[ var_00.var_4DDE ]]();
}

//Function Number: 7
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

//Function Number: 8
func_15D7(param_00)
{
	var_01 = level.var_3C17[param_00];
	if(!isdefined(level.var_3C2B[param_00]) && param_00 != "next_challenge")
	{
		level.var_3C2B[param_00] = 0;
	}

	if(var_01 [[ var_01.var_386E ]]())
	{
		var_02 = func_7897(param_00);
		if(isdefined(var_02))
		{
			level.var_3C17[param_00].var_155 = var_02;
			level.var_4B52 = var_02;
		}
		else
		{
			level.var_4B52 = -1;
		}

		func_56AD(param_00,1,var_02);
		func_F31A(param_00);
		level.var_4B4F = 0;
		var_01 [[ var_01.var_1609 ]]();
		return;
	}

	var_01 [[ var_01.var_6ACB ]]();
}

//Function Number: 9
func_7897(param_00)
{
	return [[ level.challenge_scalar_func ]](param_00);
}

//Function Number: 10
func_3C15()
{
	level endon("game_ended");
	var_00 = int(gettime() + 5000);
	foreach(var_02 in level.players)
	{
		var_02 setclientomnvar("ui_intel_title",1);
	}

	level.var_4B55 = 1;
	wait(5);
	foreach(var_02 in level.players)
	{
		var_02 setclientomnvar("ui_intel_title",-1);
	}

	level.var_4B55 = -1;
	wait(0.5);
}

//Function Number: 11
func_56AD(param_00,param_01,param_02)
{
	var_03 = tablelookup(level.var_13F16,1,param_00,0);
	foreach(var_05 in level.players)
	{
		if(param_01)
		{
			if(isdefined(param_02))
			{
				var_05 setclientomnvar("ui_intel_challenge_scalar",param_02);
				var_05 setclientomnvar("ui_intel_progress_max",param_02);
			}
			else
			{
				var_05 setclientomnvar("ui_intel_challenge_scalar",-1);
			}

			var_05 setclientomnvar("ui_intel_prechallenge",1);
			var_05 setclientomnvar("ui_intel_active_index",int(var_03));
			level.var_4B4C = int(var_03);
			level.var_4B4F = 1;
			if(param_00 == "next_challenge")
			{
				var_05 playlocalsound("zmb_challenge_config");
			}
			else
			{
				var_05 playlocalsound("zmb_challenge_start");
			}

			var_05 setclientomnvar("zm_show_challenge",4);
			level.var_4BD3 = 4;
		}
	}

	if(param_01)
	{
		return;
	}

	if(level.var_4BD3 != 2 && level.var_4BD3 != 3 && level.var_4BD3 != 4)
	{
		level thread func_100CB(param_00,var_03);
	}
}

//Function Number: 12
func_100CB(param_00,param_01)
{
	level endon("game_ended");
	wait(1);
	foreach(var_03 in level.players)
	{
		if(param_00 == "challenge_failed")
		{
			var_03 playlocalsound("zmb_challenge_fail");
			var_03 setclientomnvar("zm_show_challenge",2);
			level.var_4BD3 = 2;
			continue;
		}

		var_03 playlocalsound("zmb_challenge_complete");
		var_03 setclientomnvar("zm_show_challenge",3);
		level.var_4BD3 = 3;
	}

	wait(3);
	foreach(var_03 in level.players)
	{
		var_03 thread func_E20D();
	}

	setomnvar("zm_challenge_progress",0);
	level.var_4B4C = -1;
	level.var_4B51 = -1;
	level.var_4B50 = -1;
	level.var_4B4E = -1;
	level.var_4B53 = -1;
	level.var_4B54 = -1;
	level.var_4B52 = -1;
	level.var_4B4F = 0;
}

//Function Number: 13
func_E20D()
{
	wait(0.5);
	self setclientomnvar("ui_intel_active_index",-1);
	self setclientomnvar("ui_intel_progress_current",-1);
	self setclientomnvar("ui_intel_progress_max",-1);
	self setclientomnvar("ui_intel_percent",-1);
	self setclientomnvar("ui_intel_target_player",-1);
	self setclientomnvar("ui_intel_prechallenge",0);
	self setclientomnvar("ui_intel_timer",-1);
	self setclientomnvar("ui_intel_challenge_scalar",-1);
}

//Function Number: 14
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

//Function Number: 15
func_12D9E(param_00,param_01)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	foreach(var_03 in level.players)
	{
		var_03 setclientomnvar("zm_show_challenge",1);
		var_03 setclientomnvar("ui_intel_progress_current",param_00);
		level.var_4BD3 = 1;
	}

	setomnvar("zm_challenge_progress",param_00 / param_01);
	level.var_4B51 = param_01;
	level.var_4B50 = param_00;
}

//Function Number: 16
func_4FDD()
{
	return 1;
}

//Function Number: 17
func_4FED()
{
}

//Function Number: 18
func_4FFA()
{
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return 0;
}

//Function Number: 19
func_5022()
{
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return self.var_5021;
}

//Function Number: 20
func_4FEE()
{
}

//Function Number: 21
func_5010()
{
	self.var_111AE = self.var_5021;
}

//Function Number: 22
func_5011()
{
}

//Function Number: 23
func_4B4B()
{
	return isdefined(level.var_4B4A);
}

//Function Number: 24
func_4B4D(param_00)
{
	return func_4B4B() && level.var_4B4A == param_00;
}

//Function Number: 25
func_12BF7()
{
	level.var_4B4A = undefined;
}

//Function Number: 26
func_F31A(param_00)
{
	level.var_4B4A = param_00;
	scripts\cp\zombies\zombie_analytics::func_AF62(level.var_4B4A,level.wave_num);
	level.var_110AC = gettime() / 1000;
}

//Function Number: 27
func_7B31()
{
	if(!isdefined(level.var_C1E1))
	{
		return 0;
	}

	return level.var_C1E1;
}

//Function Number: 28
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

//Function Number: 29
func_4FE2(param_00)
{
	return 1;
}

//Function Number: 30
func_12DA9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::istrue(self.var_54CB))
	{
		return;
	}

	if(!isdefined(level.var_4B4A))
	{
		return;
	}

	var_09 = level.var_4B4A;
	if(isdefined(level.custom_death_challenge_func))
	{
		var_0A = self [[ level.custom_death_challenge_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		if(!scripts\common\utility::istrue(var_0A))
		{
			return;
		}
	}
}

//Function Number: 31
func_12DA5(param_00)
{
	level endon("stop_challenge_timer");
	level endon("game_ended");
	level endon("challenge_deactivated");
	self endon("success");
	var_01 = 0;
	var_02 = level.var_4B54;
	while(level.var_4B54 > 0)
	{
		wait(0.1);
		if(scripts\common\utility::flag("pause_challenges"))
		{
			foreach(var_04 in level.players)
			{
				var_04 setclientomnvar("ui_intel_timer",-1);
				var_04 setclientomnvar("zm_show_challenge",10);
			}

			scripts\common\utility::func_6E5A("pause_challenges");
			var_06 = int(gettime() + level.var_4B54 * 1000);
			foreach(var_04 in level.players)
			{
				var_04 setclientomnvar("ui_intel_timer",var_06);
				var_04 setclientomnvar("zm_show_challenge",level.var_4BD3);
			}
		}

		level.var_4B54 = level.var_4B54 - 0.1;
		if(isdefined(param_00))
		{
			func_12D9E(int(var_02 - level.var_4B54),int(var_02));
		}
	}
}

//Function Number: 32
func_5026(param_00)
{
	level endon("game_ended");
	level endon("challenge_deactivated");
	self endon("success");
	var_01 = param_00;
	while(var_01 > 0)
	{
		wait(0.1);
		if(scripts\common\utility::flag("pause_challenges"))
		{
			continue;
		}

		var_01 = var_01 - 0.1;
	}

	self.var_111AE = self.var_5021;
	level thread func_4DAE();
}