/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\cp_disco_challenges.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 573 ms
 * Timestamp: 10/27/2023 12:03:47 AM
*******************************************************************/

//Function Number: 1
register_default_challenges()
{
	scripts\common\utility::flag_init("pause_challenges");
	scripts\cp\zombies\solo_challenges::func_DEA1("tiger_1_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("crane_1_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("snake_1_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("dragon_1_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("tiger_2_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("crane_2_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("snake_2_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("dragon_2_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("tiger_3_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("crane_3_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("snake_3_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("dragon_3_challenge",undefined,0,::challenge_success,undefined,::activate_challenge,::func_0104,undefined,::update_disco_challenge);
	scripts\cp\zombies\solo_challenges::func_DEA1("challenge_failed",undefined,0,undefined,undefined,::scripts\cp\zombies\solo_challenges::func_5010,::scripts\cp\zombies\solo_challenges::func_5010,undefined,undefined);
	scripts\cp\zombies\solo_challenges::func_DEA1("challenge_success",undefined,0,undefined,undefined,::scripts\cp\zombies\solo_challenges::func_5010,::scripts\cp\zombies\solo_challenges::func_5010,undefined,undefined);
}

//Function Number: 2
activate_challenge(param_00)
{
	param_00 scripts\cp\zombies\solo_challenges::func_5010();
	param_00.var_4B4A.var_4BA0 = param_00.kung_fu_progression.challenge_progress[param_00.kung_fu_progression.active_discipline];
	param_00 scripts\cp\zombies\solo_challenges::func_12D9E(param_00.var_4B4A.var_4BA0,param_00.var_4B4A.var_155);
}

//Function Number: 3
update_disco_challenge(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	self.var_4B4A.var_4BA0 = self.var_4B4A.var_4BA0 + param_00;
	if(self.var_4B4A.var_4BA0 >= self.var_4B4A.var_155)
	{
		self.var_4B4A.var_111AE = 1;
	}

	scripts\cp\zombies\solo_challenges::func_12D9E(self.var_4B4A.var_4BA0,self.var_4B4A.var_155);
	if(self.var_4B4A.var_111AE)
	{
		self notify("current_challenge_ended");
		scripts\cp\zombies\solo_challenges::func_4DAE(self);
		self.current_player_challenge = undefined;
		return;
	}

	if(scripts\common\utility::istrue(param_01))
	{
		self notify("current_challenge_ended");
		self.var_4B4A.var_111AE = 0;
		scripts\cp\zombies\solo_challenges::func_4DAE(self);
		self.current_player_challenge = undefined;
	}
}

//Function Number: 4
chi_challenge_activate(param_00)
{
	param_00 endon("disconnect");
	wait(0.1);
	var_01 = param_00.kung_fu_progression.active_discipline;
	var_02 = param_00.kung_fu_progression.disciplines_levels[param_00.kung_fu_progression.active_discipline];
	if(isdefined(param_00.current_player_challenge))
	{
		if(issubstr(param_00.current_player_challenge,var_01))
		{
			return;
		}
	}

	if(var_02 < 3)
	{
		param_00 thread chi_challenge_start(var_01 + "_" + var_02 + 1 + "_challenge");
	}
}

//Function Number: 5
chi_challenge_start(param_00)
{
	scripts\cp\zombies\solo_challenges::func_15D7(param_00,self);
}

//Function Number: 6
challenge_success(param_00)
{
	scripts\cp\maps\cp_disco\kung_fu_mode::update_player_abilities(param_00,param_00.kung_fu_progression.active_discipline);
	var_01 = 0;
	param_00 thread scripts\cp\_vo::try_to_play_vo("challenge_success_chi","zmb_comment_vo","low",10,0,0,1,100);
	var_02 = param_00.kung_fu_progression.disciplines_levels[param_00.kung_fu_progression.active_discipline];
	switch(param_00.kung_fu_progression.active_discipline)
	{
		case "snake":
			if(var_02 == 1)
			{
				var_01 = 1;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_snake_1","pam_dialogue_vo");
			}
			else if(var_02 == 2)
			{
				var_01 = 2;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_snake_2","pam_dialogue_vo");
			}
			else if(var_02 == 3)
			{
				var_01 = 3;
				param_00.chi_master_snake = 1;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_snake_3","pam_dialogue_vo");
				param_00 scripts\cp\_merits::func_D9AD("mt_dlc2_chi_master");
			}
			break;

		case "dragon":
			if(var_02 == 1)
			{
				var_01 = 10;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_dragon_1","pam_dialogue_vo");
			}
			else if(var_02 == 2)
			{
				var_01 = 11;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_dragon_2","pam_dialogue_vo");
			}
			else if(var_02 == 3)
			{
				var_01 = 12;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_dragon_3","pam_dialogue_vo");
				param_00.chi_master_dragon = 1;
				param_00 scripts\cp\_merits::func_D9AD("mt_dlc2_chi_master");
			}
			break;

		case "crane":
			if(var_02 == 1)
			{
				var_01 = 7;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_crane_1","pam_dialogue_vo");
			}
			else if(var_02 == 2)
			{
				var_01 = 8;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_crane_2","pam_dialogue_vo");
			}
			else if(var_02 == 3)
			{
				var_01 = 9;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_crane_3","pam_dialogue_vo");
				param_00.chi_master_crane = 1;
				param_00 scripts\cp\_merits::func_D9AD("mt_dlc2_chi_master");
			}
			break;

		case "tiger":
			if(var_02 == 1)
			{
				var_01 = 4;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_tiger_1","pam_dialogue_vo");
			}
			else if(var_02 == 2)
			{
				var_01 = 5;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_tiger_2","pam_dialogue_vo");
			}
			else if(var_02 == 3)
			{
				var_01 = 6;
				param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_tiger_3","pam_dialogue_vo");
				param_00.chi_master_tiger = 1;
				param_00 scripts\cp\_merits::func_D9AD("mt_dlc2_chi_master");
			}
			break;
	}

	param_00 setclientomnvarbit("zm_challenges_completed",var_01,1);
	if(scripts\common\utility::istrue(param_00.chi_master_tiger) && scripts\common\utility::istrue(param_00.chi_master_dragon) && scripts\common\utility::istrue(param_00.chi_master_snake) && scripts\common\utility::istrue(param_00.chi_master_crane))
	{
		param_00 lib_0D2A::func_12D7C("SHAOLIN_SKILLS",1);
		param_00 thread scripts\cp\_vo::try_to_play_vo("pam_rank_all_max","pam_dialogue_vo");
	}

	param_00.kung_fu_progression.challenge_progress[param_00.kung_fu_progression.active_discipline] = 0;
	if(isdefined(self.var_111AE))
	{
		return self.var_111AE;
	}

	return self.var_5021;
}

//Function Number: 7
func_0104(param_00)
{
}

//Function Number: 8
challenge_scalar_func(param_00)
{
	var_01 = func_7C28(param_00);
	return var_01;
}

//Function Number: 9
func_7C28(param_00)
{
	var_01 = level.var_13F16;
	var_02 = 0;
	var_03 = 1;
	var_04 = 99;
	var_05 = 1;
	var_06 = 9;
	for(var_07 = var_03;var_07 <= var_04;var_07++)
	{
		var_08 = tablelookup(var_01,var_02,var_07,var_05);
		if(var_08 == "")
		{
			return undefined;
		}

		if(var_08 != param_00)
		{
			continue;
		}

		var_09 = tablelookup(var_01,var_02,var_07,var_06);
		if(isdefined(var_09))
		{
			var_09 = strtok(var_09," ");
			if(var_09.size > 0)
			{
				return int(var_09[0]);
			}
		}
	}
}

//Function Number: 10
default_playerdamage_challenge_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.var_4B4A))
	{
		return 0;
	}

	if(scripts\common\utility::flag("pause_challenges"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
default_death_challenge_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = param_01;
	if(isdefined(param_01.playerowner) && param_01.playerowner scripts\cp\_utility::is_valid_player(1))
	{
		var_09 = param_01.playerowner;
	}

	if(!isdefined(var_09.current_player_challenge) || !isdefined(var_09.kung_fu_progression.active_discipline))
	{
		return 0;
	}

	if(!isdefined(param_04))
	{
		return 0;
	}

	var_0A = var_09.kung_fu_progression.active_discipline;
	var_0B = var_09.kung_fu_progression.disciplines_levels[var_09.kung_fu_progression.active_discipline];
	switch(var_0B)
	{
		case 0:
			if(!issubstr(param_04,"fists_zm_"))
			{
				return 0;
			}
			break;

		case 1:
			if(param_04 != "iw7_shuriken_" + var_0A + "_proj" && param_04 != "iw7_shuriken_zm_" + var_0A)
			{
				return 0;
			}
			break;

		case 2:
			if(param_04 == "none" && !isplayer(param_01))
			{
				break;
			}
	
			if(var_0A == "tiger" && param_03 == "MOD_EXPLOSIVE" && param_04 == "none")
			{
				break;
			}
	
			if(!issubstr(param_04,"fists_zm_") || param_03 != "MOD_UNKNOWN")
			{
				return 0;
			}
			break;

		case 3:
			if(param_04 != "power_repulsor")
			{
				return 0;
			}
			break;
	}

	var_09.kung_fu_progression.challenge_progress[var_09.kung_fu_progression.active_discipline]++;
	var_09 thread scripts\cp\zombies\solo_challenges::func_12D9C(var_0A + "_" + var_0B + 1 + "_challenge",1);
	return 0;
}