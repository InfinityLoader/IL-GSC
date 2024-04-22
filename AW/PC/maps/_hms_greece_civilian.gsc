/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _hms_greece_civilian.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 162 ms
 * Timestamp: 4/22/2024 2:21:25 AM
*******************************************************************/

//Function Number: 1
precachecivilian()
{
	precachepropmodels();
	precacheciviliananims();
}

//Function Number: 2
precachepropmodels()
{
	precachemodel("electronics_pda");
	precachemodel("com_cellphone_on");
	precachemodel("prop_cigarette");
	precachemodel("greece_cafe_gps_pad");
}

//Function Number: 3
precacheciviliananims()
{
	level.scr_animtree["generic"] = #animtree;
	level.scr_anim["generic"]["civilian_texting_standing"][0] = %civilian_texting_standing;
	level.scr_anim["generic"]["civilian_stand_idle"][0] = %civilian_stand_idle;
	level.scr_anim["generic"]["civilian_smoking_A"][0] = %civilian_smoking_a;
	level.scr_anim["generic"]["london_station_civ1_idle"][0] = %london_station_civ1_idle;
	level.scr_anim["generic"]["london_station_civ2_idle"][0] = %london_station_civ2_idle;
	level.scr_anim["generic"]["london_station_civ4_idle"][0] = %london_station_civ4_idle;
	level.scr_anim["generic"]["london_station_civ5_idle"][0] = %london_station_civ5_idle;
	level.scr_anim["generic"]["london_station_civ7_idle"][0] = %london_station_civ7_idle;
	level.scr_anim["generic"]["london_station_civ11_idle"][0] = %london_station_civ11_idle;
	level.scr_anim["generic"]["parabolic_leaning_guy_smoking_idle"][0] = %parabolic_leaning_guy_smoking_idle;
	level.scr_anim["generic"]["parabolic_leaning_guy_idle"][0] = %parabolic_leaning_guy_idle;
	level.scr_anim["generic"]["oilrig_balcony_smoke_idle"][0] = %oilrig_balcony_smoke_idle;
	level.scr_anim["generic"]["civilian_directions_1_A"][0] = %civilian_directions_1_a;
	level.scr_anim["generic"]["civilian_directions_1_B"][0] = %civilian_directions_1_b;
	level.scr_anim["generic"]["hms_greece_market_shopper_idle_01"][0] = %hms_greece_market_shopper_idle_01;
	level.scr_anim["generic"]["hms_greece_market_shopper_idle_02"][0] = %hms_greece_market_shopper_idle_02;
	level.scr_anim["generic"]["hms_greece_market_shopper_idle_03"][0] = %hms_greece_market_shopper_idle_03;
	level.scr_anim["generic"]["hms_greece_market_shopper_idle_04"][0] = %hms_greece_market_shopper_idle_04;
	level.scr_anim["generic"]["hms_greece_market_shopper_idle_05"][0] = %hms_greece_market_shopper_idle_05;
	level.scr_anim["generic"]["hms_greece_market_shopper_idle_06"][0] = %hms_greece_market_shopper_idle_06;
	level.scr_anim["generic"]["hms_greece_market_shopper_idle_07"][0] = %hms_greece_market_shopper_idle_07;
	level.scr_anim["generic"]["hms_greece_market_shopper_idle_08"][0] = %hms_greece_market_shopper_idle_08;
	level.scr_anim["generic"]["hms_greece_market_shopper_idle_09"][0] = %hms_greece_market_shopper_idle_09;
	level.scr_anim["generic"]["civilian_texting_sitting"][0] = %civilian_texting_sitting;
	level.scr_anim["generic"]["guardB_sit_drinker_idle"][0] = %guardb_sit_drinker_idle;
	level.scr_anim["generic"]["london_civ_idle_lookover"] = %london_civ_idle_lookover;
	level.scr_anim["generic"]["london_civ_idle_checkwatch"] = %london_civ_idle_checkwatch;
	level.scr_anim["generic"]["london_civ_idle_lookbehind"] = %london_civ_idle_lookbehind;
	level.scr_anim["generic"]["london_civ_idle_scratchnose"] = %london_civ_idle_scratchnose;
	level.scr_anim["generic"]["london_civ_idle_foldarms_scratchass"] = %london_civ_idle_foldarms_scratchass;
	level.scr_anim["generic"]["london_civ_idle_foldarms2"] = %london_civ_idle_foldarms2;
	level.scr_anim["generic"]["hms_greece_market_civ_idle_01"] = %hms_greece_market_civ_idle_01;
	level.scr_anim["generic"]["hms_greece_market_civ_idle_02"] = %hms_greece_market_civ_idle_02;
	level.scr_anim["generic"]["hms_greece_market_civ_idle_03"] = %hms_greece_market_civ_idle_03;
	level.scr_anim["generic"]["hms_greece_market_civ_idle_04"] = %hms_greece_market_civ_idle_04;
	level.randomidleanims = [];
	level.randomidleanims[0] = "london_civ_idle_lookover";
	level.randomidleanims[1] = "london_civ_idle_checkwatch";
	level.randomidleanims[2] = "london_civ_idle_lookbehind";
	level.randomidleanims[3] = "london_civ_idle_foldarms_scratchass";
	level.randomidleanims[4] = "london_civ_idle_foldarms2";
	level.randomidleanims[5] = "london_civ_idle_scratchnose";
	level.randomidleanims[6] = "hms_greece_market_civ_idle_01";
	level.randomidleanims[7] = "hms_greece_market_civ_idle_02";
	level.randomidleanims[8] = "hms_greece_market_civ_idle_03";
	level.randomidleanims[9] = "hms_greece_market_civ_idle_04";
	var_00 = [];
	var_00[0] = 2;
	var_00[1] = 1;
	var_00[2] = 1;
	var_00[3] = 1;
	level.scr_anim["civilian_crazy_walk"]["run_noncombat"][0] = %civilian_crazywalker_loop;
	level.scr_anim["civilian_crazy_walk"]["run_noncombat"][1] = %civilian_crazywalker_twitcha;
	level.scr_anim["civilian_crazy_walk"]["run_noncombat"][2] = %civilian_crazywalker_twitchb;
	level.scr_anim["civilian_crazy_walk"]["run_noncombat"][3] = %civilian_crazywalker_twitchc;
	level.scr_anim["civilian_crazy_walk"]["run_weights"] = var_00;
	var_01 = [];
	var_01[0] = 7;
	var_01[1] = 3;
	var_02 = common_scripts\utility::get_cumulative_weights(var_01);
	level.scr_anim["civilian_cellphone_walk"]["run_noncombat"][0] = %civilian_cellphonewalk;
	level.scr_anim["civilian_cellphone_walk"]["dodge_left"] = %civilian_cellphonewalk_dodge_l;
	level.scr_anim["civilian_cellphone_walk"]["dodge_right"] = %civilian_cellphonewalk_dodge_r;
	level.scr_anim["civilian_cellphone_walk"]["turn_left_90"] = %civilian_cellphonewalk_turn_l;
	level.scr_anim["civilian_cellphone_walk"]["turn_right_90"] = %civilian_cellphonewalk_turn_r;
	level.scr_anim["civilian_soda_walk"]["run_noncombat"][0] = %civilian_sodawalk;
	level.scr_anim["civilian_soda_walk"]["run_noncombat"][1] = %civilian_sodawalk_twitch;
	level.scr_anim["civilian_soda_walk"]["run_weights"] = var_02;
	level.scr_anim["civilian_hurried_walk"]["run_noncombat"][0] = %civilian_walk_hurried_1;
	level.scr_anim["civilian_hurried_walk"]["run_noncombat"][1] = %civilian_walk_hurried_2;
	level.scr_anim["civilian_nervous_walk"]["run_noncombat"][0] = %civilian_walk_nervous;
	level.scr_anim["civilian_cool_walk"]["run_noncombat"][0] = %civilian_walk_cool;
	level.scr_anim["civilian_paper_walk"]["run_noncombat"][0] = %civilian_walk_paper;
	level.scr_anim["civilian_coffee_walk"]["run_noncombat"][0] = %civilian_walk_coffee;
	level.scr_anim["civilian_backpack_walk"]["run_noncombat"][0] = %civilian_walk_backpack;
	level.scr_anim["civilian_backpack_walk"]["run_noncombat"][1] = %civilian_walk_backpack_twitch;
	level.scr_anim["civilian_backpack_walk"]["run_weights"] = var_02;
	level.scr_anim["civilian_pda_walk"]["run_noncombat"][0] = %civilian_walk_pda;
	level.scr_anim["civilian_briefcase_walk"]["run_noncombat"][0] = %civilian_briefcase_walk;
	level.scr_anim["civilian_briefcase_walk"]["dodge_left"] = %civilian_briefcase_walk_dodge_l;
	level.scr_anim["civilian_briefcase_walk"]["dodge_right"] = %civilian_briefcase_walk_dodge_r;
	level.scr_anim["civilian_briefcase_walk"]["turn_left_90"] = %civilian_briefcase_walk_turn_l;
	level.scr_anim["civilian_briefcase_walk"]["turn_right_90"] = %civilian_briefcase_walk_turn_r;
	level.scr_anim["civilian_walk_male"]["run_noncombat"][0] = %hms_greece_market_civ_walk_male_01;
	level.scr_anim["civilian_walk_male"]["run_noncombat"][1] = %hms_greece_market_civ_walk_look_male_01;
	level.scr_anim["civilian_walk_male"]["run_weights"] = var_02;
	level.scr_anim["civilian_walk_male"]["dodge_left"] = %hms_greece_market_civ_walk_briefcase_dodge_l_alt;
	level.scr_anim["civilian_walk_male"]["dodge_right"] = %hms_greece_market_civ_walk_briefcase_dodge_r_alt;
	level.scr_anim["civilian_slow_walk_male"]["run_noncombat"][0] = %hms_greece_market_civ_walk_slow_male_01;
	level.scr_anim["civilian_slow_walk_male"]["run_noncombat"][1] = %hms_greece_market_civ_walk_slow_look_male_01;
	level.scr_anim["civilian_slow_walk_male"]["run_weights"] = var_02;
	level.scr_anim["civilian_slow_walk_male"]["dodge_left"] = %hms_greece_market_civ_walk_briefcase_dodge_l_alt;
	level.scr_anim["civilian_slow_walk_male"]["dodge_right"] = %hms_greece_market_civ_walk_briefcase_dodge_r_alt;
	level.scr_anim["civilian_slow_walk_female"]["run_noncombat"][0] = %hms_greece_market_civ_walk_slow_female_01;
	level.scr_anim["civilian_slow_walk_female"]["run_noncombat"][1] = %hms_greece_market_civ_walk_slow_look_female_01;
	level.scr_anim["civilian_slow_walk_female"]["run_weights"] = var_02;
	level.scr_anim["civilian_slow_walk_female"]["dodge_left"] = %hms_greece_market_civ_walk_briefcase_dodge_l_alt;
	level.scr_anim["civilian_slow_walk_female"]["dodge_right"] = %hms_greece_market_civ_walk_briefcase_dodge_r_alt;
}

//Function Number: 4
populatedronecivilians(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = [];
	foreach(var_06 in param_01)
	{
		var_07 = param_00 maps\_utility::dronespawn();
		var_04 = common_scripts\utility::array_add(var_04,var_07);
		param_00.count = 1;
		var_07.origin = var_06.origin;
		var_07.angles = var_06.angles;
		if(isdefined(var_06.script_noteworthy))
		{
			var_07.script_noteworthy = var_06.script_noteworthy;
		}

		wait(0.05);
		if(var_06.animation == "random")
		{
			var_07 thread randomidleanimation(var_06);
			continue;
		}

		if(param_02 == 1)
		{
			var_07 thread loopingidleanimation(var_06);
			continue;
		}

		var_07 thread singleanimation(var_06,param_03);
	}

	return var_04;
}

//Function Number: 5
randomidleanimation(param_00)
{
	self endon("death");
	for(;;)
	{
		var_01 = common_scripts\utility::random(level.randomidleanims);
		param_00 maps\_anim::anim_generic(self,var_01);
		wait(0.05);
	}
}

//Function Number: 6
loopingidleanimation(param_00)
{
	self.animname = "generic";
	var_01 = param_00.animation;
	param_00 thread maps\_anim::anim_generic_loop(self,var_01);
	var_02 = attachprops(var_01);
	self waittill("death");
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 7
singleanimation(param_00,param_01)
{
	self.animname = "generic";
	var_02 = param_00.animation;
	var_03 = attachprops(var_02);
	if(param_01 == 1)
	{
		param_00 maps\_anim::anim_generic(self,var_02);
		if(isdefined(var_03))
		{
			var_03 delete();
		}

		self delete();
		return;
	}

	param_00 thread maps\_anim::anim_generic(self,var_02);
	self waittill("death");
	if(isdefined(var_03))
	{
		var_03 delete();
	}
}

//Function Number: 8
attachprops(param_00)
{
	if(isdefined(self.hasattachedprops))
	{
		return;
	}

	initcivilianprops();
	var_01 = level.civilianprops[param_00];
	if(isdefined(var_01))
	{
		var_02 = self attach(var_01,"tag_inhand",1);
		self.hasattachedprops = 1;
		return var_02;
	}
}

//Function Number: 9
initcivilianprops()
{
	if(isdefined(level.civilianprops))
	{
		anim.civilianprops = [];
	}

	level.civilianprops["civilian_texting_standing"] = "electronics_pda";
	level.civilianprops["civilian_texting_sitting"] = "electronics_pda";
	level.civilianprops["civilian_directions_2_A_idle"] = "electronics_pda";
	level.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
	level.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
	level.civilianprops["civilian_smoking_A"] = "prop_cigarette";
	level.civilianprops["civilian_smoking_B"] = "prop_cigarette";
	level.civilianprops["parabolic_leaning_guy_smoking_idle"] = "prop_cigarette";
	level.civilianprops["oilrig_balcony_smoke_idle"] = "prop_cigarette";
	level.civilianprops["hms_greece_cc_takedown_idle_target"] = "prop_cigarette";
	level.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
	level.civilianprops["civilian_sitting_business_lunch_B_1"] = "com_cellphone_on";
	level.civilianprops["civilian_reader_1"] = "greece_cafe_gps_pad";
	level.civilianprops["civilian_reader_2"] = "greece_cafe_gps_pad";
	level.civilianprops["civilian_cellphone_walk"] = "com_cellphone_on";
	level.civilianprops["civilian_soda_walk"] = "ma_cup_single_closed";
}