/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _sp_matchdata.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 209 ms
 * Timestamp: 4/22/2024 2:22:48 AM
*******************************************************************/

//Function Number: 1
init()
{
	setspmatchdatadef("sp/sp_matchdata.def");
	setspmatchdata("level_name",level.script);
	setspmatchdata("timestamp_start",level.player getsystemtimesp());
	setspmatchdata("xuid",level.player getxuid());
	setspmatchdata("dwid",level.player getdwid());
	level.player setplayerinfospmatchdata();
	setspmatchdata("challenges","upgrade_challenge_stage_0",int(level.player getlocalplayerprofiledata("sp_upgradeChallengeStage_0")));
	setspmatchdata("challenges","upgrade_challenge_progress_0",int(level.player getlocalplayerprofiledata("sp_upgradeChallengeProgress_0")));
	setspmatchdata("challenges","upgrade_challenge_stage_1",int(level.player getlocalplayerprofiledata("sp_upgradeChallengeStage_1")));
	setspmatchdata("challenges","upgrade_challenge_progress_1",int(level.player getlocalplayerprofiledata("sp_upgradeChallengeProgress_1")));
	setspmatchdata("challenges","upgrade_challenge_stage_2",int(level.player getlocalplayerprofiledata("sp_upgradeChallengeStage_2")));
	setspmatchdata("challenges","upgrade_challenge_progress_2",int(level.player getlocalplayerprofiledata("sp_upgradeChallengeProgress_2")));
	setspmatchdata("challenges","upgrade_challenge_stage_3",int(level.player getlocalplayerprofiledata("sp_upgradeChallengeStage_3")));
	setspmatchdata("challenges","upgrade_challenge_progress_3",int(level.player getlocalplayerprofiledata("sp_upgradeChallengeProgress_3")));
	setspmatchdata("career","intel_collected",level.player getlocalplayerprofiledata("cheatPoints"));
	setspmatchdata("career","kills_total",level.player getlocalplayerprofiledata("sp_career_kills_total"));
	setspmatchdata("career","deaths_total",level.player getlocalplayerprofiledata("sp_career_deaths_total"));
	level.player thread register_sp_perks();
	level.player thread register_boost_dodge();
}

//Function Number: 2
increment_kill(param_00,param_01)
{
	param_00 = getweaponbasename(param_00);
	var_02 = self;
	var_03 = int(getspmatchdata("career","kills_total")) + 1;
	setspmatchdata("career","kills_total",var_03);
	set_weapon_data(param_00,"kills_total");
	level.player setlocalplayerprofiledata("sp_career_deaths_total",var_03);
	var_04 = getspmatchdata("checkpoints",0,"kills_total") + 1;
	setspmatchdata("checkpoints",0,"kills_total",var_04);
	if(param_01)
	{
		var_05 = getspmatchdata("checkpoints",0,"headshots_total") + 1;
		setspmatchdata("checkpoints",0,"headshots_total",var_05);
		set_weapon_data(param_00,"headshots_total");
	}
}

//Function Number: 3
shots_fired(param_00)
{
	set_weapon_data(getweaponbasename(param_00),"shots_total");
	var_01 = getspmatchdata("checkpoints",0,"shots_total") + 1;
	setspmatchdata("checkpoints",0,"shots_total",var_01);
}

//Function Number: 4
increment_hit(param_00)
{
	set_weapon_data(getweaponbasename(param_00),"shots_hit");
	var_01 = getspmatchdata("checkpoints",0,"hits_total") + 1;
	setspmatchdata("checkpoints",0,"hits_total",var_01);
}

//Function Number: 5
register_death(param_00,param_01)
{
	if(isdefined(param_00))
	{
		param_00 = getweaponbasename(param_00);
		if(!cause_is_explosive(param_01))
		{
			set_weapon_data(param_00,"deaths_total");
		}
	}

	var_02 = getspmatchdata("checkpoints",0,"deaths_total") + 1;
	setspmatchdata("checkpoints",0,"deaths_total",var_02);
	var_03 = level.player getlocalplayerprofiledata("sp_career_deaths_total") + 1;
	level.player setlocalplayerprofiledata("sp_career_deaths_total",var_03);
	setspmatchdata("career","deaths_total",var_03);
	var_04 = level.player getplayersetting("gameskill");
	var_05 = level.difficultytype[int(var_04)];
	setspmatchdata("final_difficulty",var_05);
	var_06 = level.player getlocalplayerprofiledata("sp_duration_total_seconds") + int(gettime() / 1000);
	level.player setlocalplayerprofiledata("sp_duration_total_seconds",int(var_06));
}

//Function Number: 6
register_boost_jump()
{
	var_00 = getspmatchdata("checkpoints",0,"boosted_total") + 1;
	setspmatchdata("checkpoints",0,"boosted_total",var_00);
}

//Function Number: 7
register_boost_slam()
{
	var_00 = getspmatchdata("checkpoints",0,"boosted_total") + 1;
	setspmatchdata("checkpoints",0,"boosted_total",var_00);
}

//Function Number: 8
register_boost_dodge()
{
	self endon("death");
	for(;;)
	{
		self waittill("exo_dodge");
		var_00 = getspmatchdata("checkpoints",0,"dodges_total") + 1;
		setspmatchdata("checkpoints",0,"boosted_total",var_00);
	}
}

//Function Number: 9
register_sp_perks()
{
	self endon("death");
	for(;;)
	{
		self waittill("give_perk",var_00);
		setspmatchdata("perks",var_00,1);
	}
}

//Function Number: 10
level_complete(param_00)
{
	var_01 = level.player getsystemtimesp();
	setspmatchdata("timestamp_end",var_01);
	setspmatchdata("career","level_completion_timestamp",param_00,var_01);
	setspmatchdata("career","levels_completed",param_00,1);
	var_02 = level.player getplayersetting("gameskill");
	var_03 = level.difficultytype[int(var_02)];
	setspmatchdata("final_difficulty",var_03);
	var_04 = level.player getlocalplayerprofiledata("sp_duration_total_seconds") + int(gettime() / 1000);
	level.player setlocalplayerprofiledata("sp_duration_total_seconds",var_04);
	setspmatchdata("career","duration_total_seconds",var_04);
	setspmatchdata("career","intel_collected",level.player getlocalplayerprofiledata("cheatPoints"));
	sendspmatchdata();
}

//Function Number: 11
does_weapon_exist(param_00)
{
	var_01 = ["ammo","iw5_bal27_sp","iw5_ak12_sp","iw5_hbra3_sp","iw5_himar_sp","iw5_arx160_sp","iw5_m182spr_sp","iw5_sn6_sp","iw5_hmr9_sp","iw5_mp11_sp","iw5_sac3_sp","iw5_asm1_sp","iw5_kf5_sp","iw5_mors_sp","iw5_gm6_sp","iw5_thor_sp","iw5_uts19_sp","iw5_maul_sp","iw5_rhino_sp","iw5_lsat_sp","iw5_asaw_sp","iw5_em1_sp","iw5_epm3_sp","iw5_titan45_sp","iw5_pbw_sp","iw5_vbr_sp","iw5_rw1_sp","iw5_microdronelauncher_sp","iw5_stingerm7_sp","iw5_mahem_sp","iw5_maaws_sp","unknown",""];
	return common_scripts\utility::array_contains(var_01,param_00);
}

//Function Number: 12
set_weapon_data(param_00,param_01)
{
	if(isdefined(param_00) && does_weapon_exist(param_00))
	{
		var_02 = int(getspmatchdata("weapon_stats",param_00,param_01)) + 1;
		setspmatchdata("weapon_stats",param_00,param_01,var_02);
		return;
	}

	var_02 = int(getspmatchdata("weapon_stats","unknown",var_02)) + 1;
	setspmatchdata("weapon_stats","unknown",param_01,var_02);
}

//Function Number: 13
cause_is_explosive(param_00)
{
	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "splash":
		case "mod_explosive":
		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
			return 1;

		default:
			return 0;
	}

	return 0;
}