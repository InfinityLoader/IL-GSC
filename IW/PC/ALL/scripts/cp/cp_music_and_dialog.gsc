/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_music_and_dialog.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 1423 ms
 * Timestamp: 10/27/2023 12:09:41 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\common\utility::flag_init("vo_system_setup_done");
	scripts\common\utility::flag_init("dialogue_done");
	scripts\cp\_vo::func_98EA();
	level thread func_C56E();
	level thread func_EF35();
	if(!isdefined(level.var_134DC))
	{
		level.var_134DC = [];
	}

	if(isdefined(level.var_ABE9))
	{
		level.var_134DC = [[ level.var_ABE9 ]](level.var_134DC);
	}

	level.var_18E8 = ::func_9D12;
}

//Function Number: 2
func_2B53()
{
}

//Function Number: 3
func_3837()
{
	if(level.players.size != 4)
	{
		return 0;
	}

	if(scripts\cp\_vo::func_9D13())
	{
		return 0;
	}

	foreach(var_01 in level.players)
	{
		if(var_01.var_134FD == "p5_")
		{
			return 0;
		}

		if(var_01.var_134FD == "p6_")
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 4
func_134DF()
{
	if(level.var_2001 || scripts\common\utility::istrue(level.elvira_playing))
	{
		return 1;
	}
	else if(level.var_D336)
	{
		return 1;
	}
	else
	{
		foreach(var_01 in level.players)
		{
			if(scripts\common\utility::istrue(var_01.var_13518))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 5
func_7F65(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = level.var_134CA[param_00[var_02]];
		var_01 = var_01 + scripts\cp\_vo::func_7C76(var_03 + param_00[var_02]);
	}

	return var_01;
}

//Function Number: 6
func_7DD2(param_00,param_01)
{
	var_02 = [param_00];
	var_03 = param_00;
	for(;;)
	{
		if(param_01 && isdefined(level.var_134B4[var_03].var_BF7B))
		{
			var_02[var_02.size] = level.var_134B4[var_03].var_BF7B;
			var_03 = level.var_134B4[var_03].var_BF7B;
			continue;
		}

		break;
	}

	return var_02;
}

//Function Number: 7
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
	}
}

//Function Number: 8
func_9D12(param_00)
{
	if(isdefined(level.var_134B4[param_00].var_18E3))
	{
		if(int(level.var_134B4[param_00].var_18E3) == 1)
		{
			return 1;
		}

		return 0;
	}
}

//Function Number: 9
func_C57B()
{
	self endon("disconnect");
	self waittill("spawned_player");
	if(!level.splitscreen || level.splitscreen && !isdefined(level.var_CF34))
	{
		if(level.splitscreen)
		{
			level.var_CF34 = 1;
		}
	}

	if(!scripts\common\utility::flag("vo_system_setup_done"))
	{
		scripts\common\utility::flag_set("vo_system_setup_done");
	}
}

//Function Number: 10
func_D58B(param_00,param_01)
{
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		return;
	}

	var_02 = param_00.var_134FD + "laststand";
	param_00 thread scripts\cp\_vo::func_CE8A(var_02);
}

//Function Number: 11
func_D5BB(param_00,param_01)
{
	var_02 = param_00.var_134FD + "reviving";
	param_00 thread scripts\cp\_vo::func_CE8A(var_02);
}

//Function Number: 12
func_D5BD(param_00)
{
	var_01 = -20536;
	var_02 = gettime();
	if(!isdefined(level.var_BF59) || level.var_BF59 < var_02)
	{
		if(isdefined(level.var_BF59))
		{
			if(randomint(100) < 60)
			{
				return;
			}
		}

		level.var_BF59 = var_02 + randomintrange(var_01,var_01 + 5000);
		var_03 = scripts\cp\_utility::func_7833();
		var_04 = scripts\common\utility::random(var_03);
		if(!isdefined(var_04))
		{
			return;
		}

		switch(param_00)
		{
			case "scriptable_alien_lynx_jump":
			case "scriptable_alien_tatra_t815_jump":
				var_05 = var_04.var_134FD + "alien_approach_truck";
				var_04 scripts\cp\_vo::func_CE8A(var_05);
				break;
		}
	}
}

//Function Number: 13
func_EF35()
{
	level endon("game_ended");
	level.var_EF36 = [];
	for(;;)
	{
		level waittill("scriptable",var_00);
		level thread func_D5BD(var_00);
	}
}

//Function Number: 14
func_6A20(param_00)
{
	param_00 playlocalsound("mantle_cloth_plr_24_up");
	wait(0.65);
	if(param_00.var_134FD == "p1_")
	{
		param_00 playlocalsound("p1_breathing_better");
		return;
	}

	if(param_00.var_134FD == "p2_")
	{
		param_00 playlocalsound("p2_breathing_better");
		return;
	}

	if(param_00.var_134FD == "p3_")
	{
		param_00 playlocalsound("p3_breathing_better");
		return;
	}

	if(param_00.var_134FD == "p4_")
	{
		param_00 playlocalsound("p4_breathing_better");
		return;
	}

	if(param_00.var_134FD == "p5_")
	{
		param_00 playlocalsound("p5_breathing_better");
		return;
	}

	if(param_00.var_134FD == "p6_")
	{
		param_00 playlocalsound("p5_breathing_better");
		return;
	}

	param_00 playlocalsound("p3_breathing_better");
}

//Function Number: 15
func_CE1D(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 + "_solo";
	if(soundexists(var_06))
	{
		scripts\cp\_vo::func_CE8A(var_06);
	}
}

//Function Number: 16
playsoundonplayers(param_00,param_01,param_02)
{
	if(level.splitscreen)
	{
		if(isdefined(level.players[0]))
		{
			level.players[0] playlocalsound(param_00);
			return;
		}

		return;
	}

	if(isdefined(param_01))
	{
		if(isdefined(param_02))
		{
			for(var_03 = 0;var_03 < level.players.size;var_03++)
			{
				var_04 = level.players[var_03];
				if(var_04 issplitscreenplayer() && !var_04 issplitscreenplayerprimary())
				{
					continue;
				}

				if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == param_01 && !func_9DE5(var_04,param_02))
				{
					var_04 playlocalsound(param_00);
				}
			}

			return;
		}

		for(var_03 = 0;var_03 < level.players.size;var_03++)
		{
			var_04 = level.players[var_03];
			if(var_04 issplitscreenplayer() && !var_04 issplitscreenplayerprimary())
			{
				continue;
			}

			if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == param_01)
			{
				var_04 playlocalsound(param_00);
			}
		}

		return;
	}

	if(isdefined(var_03))
	{
		for(var_03 = 0;var_03 < level.players.size;var_03++)
		{
			if(level.players[var_03] issplitscreenplayer() && !level.players[var_03] issplitscreenplayerprimary())
			{
				continue;
			}

			if(!func_9DE5(level.players[var_03],param_02))
			{
				level.players[var_03] playlocalsound(param_00);
			}
		}

		return;
	}

	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		if(level.players[var_03] issplitscreenplayer() && !level.players[var_03] issplitscreenplayerprimary())
		{
			continue;
		}

		level.players[var_03] playlocalsound(param_00);
	}
}

//Function Number: 17
func_9DE5(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_00 == param_01[var_02])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 18
func_D468(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = scripts\cp\_utility::func_7833();
	if(var_07.size < 1)
	{
		return;
	}

	var_08 = scripts\common\utility::random(var_07);
	var_09 = var_08.var_134FD + param_00;
	var_08 scripts\cp\_vo::func_CE8A(var_09);
}

//Function Number: 19
func_CE7F(param_00,param_01)
{
	var_02 = param_00.var_134FD + param_01;
	param_00 thread scripts\cp\_vo::func_CE8A(var_02,undefined,2);
}

//Function Number: 20
func_D5A5(param_00,param_01)
{
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		return;
	}

	var_02 = param_00.var_134FD + "last_stand";
	param_00 thread scripts\cp\_vo::func_CE8A(var_02,undefined,1);
}

//Function Number: 21
func_3D8A()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		self waittill("last_stand");
		func_5AF8();
	}
}

//Function Number: 22
func_3D80()
{
	for(;;)
	{
		level waittill("drill_planted",var_00);
		level notify("vo_notify","drill_planted","drill_planted",var_00);
	}
}

//Function Number: 23
func_5AF8()
{
	self endon("disconnect");
	self endon("death");
	self endon("revive");
	wait(4);
	level notify("vo_notify","reaction_casualty_generic","reaction_casualty_generic",self);
	wait(10);
	while(self.var_2A85)
	{
		wait(0.1);
	}

	self notify("vo_notify","bleeding_out","bleeding_out",self);
	wait(8);
	while(self.var_2A85)
	{
		wait(0.1);
	}

	self notify("vo_notify","bleeding_out","bleeding_out",self);
}

//Function Number: 24
func_CFBC(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isplayer(self))
	{
		return;
	}

	var_07 = scripts\cp\_utility::func_7833();
	var_07 = scripts\common\utility::func_22A9(var_07,self);
	if(var_07.size < 1)
	{
		return;
	}

	var_08 = var_07[0];
	var_09 = var_08.var_134FD + "reaction_casualty_generic";
	var_08 scripts\cp\_vo::func_CE8A(var_09,undefined,1);
}

//Function Number: 25
func_9C13(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 26
func_4EBA()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		var_00 = getdvarint("scr_player_vo_prefix",0);
		if(var_00 != 0)
		{
			switch(var_00)
			{
				case 1:
					self.var_134FD = "p1_";
					break;
	
				case 2:
					self.var_134FD = "p2_";
					break;
	
				case 3:
					self.var_134FD = "p3_";
					break;
	
				case 4:
					self.var_134FD = "p4_";
					break;
	
				case 5:
					self.var_134FD = "p5_";
					break;
	
				case 6:
					self.var_134FD = "p6_";
					break;
	
				default:
					break;
			}

			setdvar("scr_player_vo_prefix",0);
		}

		wait(1);
	}
}

//Function Number: 27
func_1752(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(level.var_1DF4))
	{
		level.var_1DF4 = [];
		level thread func_1DF4();
	}

	var_07 = spawnstruct();
	var_07.var_1B46 = param_00;
	var_07.var_CDB8 = param_01;
	var_07.var_B73E = param_02;
	var_07.var_B42B = param_03;
	var_07.var_BF53 = 0;
	var_07.var_3C39 = param_05;
	var_07.var_B44D = param_04;
	if(isdefined(param_06))
	{
		var_07.var_BF53 = gettime() + param_06 * 1000;
	}

	level.var_1DF4 = scripts\common\utility::array_add_safe(level.var_1DF4,var_07);
}

//Function Number: 28
func_1DF4()
{
	for(;;)
	{
		while(level.var_1DF4.size == 0)
		{
			wait(1);
		}

		var_00 = scripts\common\utility::array_randomize(level.var_1DF4);
		foreach(var_02 in var_00)
		{
			if(gettime() < var_02.var_BF53 || isdefined(level.var_572E))
			{
				continue;
			}

			var_03 = randomintrange(var_02.var_B73E,var_02.var_B42B + 1);
			var_04 = var_02.var_3C39;
			if(scripts\cp\_utility::func_203D(var_02.var_CDB8,4096))
			{
				wait(1);
				continue;
			}

			var_05 = scripts\cp\_utility::func_203D(var_02.var_CDB8,var_02.var_B44D);
			if(!var_05 || randomint(100) > var_04)
			{
				wait(1);
				continue;
			}

			var_06 = var_02.var_1B46;
			if(isarray(var_02.var_1B46))
			{
				var_06 = scripts\common\utility::random(var_02.var_1B46);
			}

			if(soundexists(var_06))
			{
				playsoundatpos(var_02.var_CDB8,var_06);
			}

			var_02.var_BF53 = gettime() + var_03 * 1000;
			wait(1);
		}

		wait(1);
	}
}