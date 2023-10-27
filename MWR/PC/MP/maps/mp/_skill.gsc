/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_skill.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 459 ms
 * Timestamp: 10/27/2023 2:38:33 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.skill_rdur_min_sec = getdvarint("skill_rdur_min",60);
	level.skill_recent_sosc = float(getdvarint("skill_recent_sosc",1000)) / 1000;
	level.skill_sos_max_weight = getdvarint("skill_sos_max_weight",5);
	level.skill_sos_tanh_scale = float(getdvarint("skill_sos_tanh_scale",1000)) / 1000;
	level.skill_sos_default_rating = float(getdvarint("skill_sos_default_rating",500)) / 1000;
	level thread onplayerspawned();
}

//Function Number: 2
initsosproxy(param_00)
{
	if(!param_00 isskillenabled())
	{
		return;
	}

	if(isdefined(param_00.sos_id))
	{
		return;
	}

	param_00.sos_id = level.sos_id;
	level.sos_id++;
	var_01 = spawnstruct();
	var_01.begin_time = maps\mp\_utility::getgametimepassedseconds();
	var_01.begin_sos_rating = param_00 getplayerdata("rankedMatchData","sosRating");
	var_01.begin_sos_weight = param_00 getplayerdata("rankedMatchData","sosWeight");
	if(var_01.begin_sos_weight <= 0.5)
	{
		var_01.begin_sos_rating = level.skill_sos_default_rating;
	}

	var_01.begin_gdf_rating = param_00 getplayerdata("rankedMatchData","gdfRating");
	var_01.begin_gdf_variance = param_00 getplayerdata("rankedMatchData","gdfVariance");
	var_01.latest_time = var_01.begin_time;
	var_01.score_per_second = undefined;
	level.sos_players[param_00.sos_id] = var_01;
}

//Function Number: 3
process()
{
	foreach(var_01 in level.players)
	{
		var_01 _updateskill();
	}
}

//Function Number: 4
processplayer()
{
	_updateskill();
}

//Function Number: 5
onplayerspawned()
{
	level.sos_players = [];
	level.sos_id = 0;
	for(;;)
	{
		level waittill("player_spawned",var_00);
		initsosproxy(var_00);
	}
}

//Function Number: 6
isskillenabled()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(isbot(self))
	{
		return 0;
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
_ipow(param_00,param_01)
{
	var_02 = 1;
	while(param_01)
	{
		if(param_01 & 1)
		{
			var_02 = var_02 * param_00;
		}

		param_01 = param_01 >> 1;
		param_00 = param_00 * param_00;
	}

	return var_02;
}

//Function Number: 8
_cube_root(param_00)
{
	var_01 = common_scripts\utility::sign(param_00);
	var_02 = function_00E5(log(abs(param_00)) / 3);
	var_02 = var_02 * var_01;
	return var_02;
}

//Function Number: 9
_rational_tanh(param_00)
{
	if(param_00 <= -3)
	{
		return -1;
	}

	if(param_00 >= 3)
	{
		return 1;
	}

	var_01 = param_00 * param_00;
	var_02 = param_00 * 27 + var_01 / 27 + 9 * var_01;
	return var_02;
}

//Function Number: 10
_inv_rational_tanh(param_00)
{
	if(param_00 <= -1)
	{
		return -3;
	}

	if(param_00 >= 1)
	{
		return 3;
	}

	var_01 = param_00 * param_00;
	var_02 = var_01 * param_00;
	var_03 = 27 * var_02 + var_01 - 1 - param_00;
	var_04 = _cube_root(var_03);
	var_05 = 3 * param_00;
	var_06 = 9 * 1 - var_01;
	var_07 = var_04;
	var_08 = -1 * var_06 / var_07;
	var_09 = var_04 + var_05 + var_08;
	return var_09;
}

//Function Number: 11
_inverse_skill_transform(param_00)
{
	var_01 = param_00;
	var_01 = var_01 * 2;
	var_01 = var_01 - 1;
	var_01 = _inv_rational_tanh(var_01) / level.skill_sos_tanh_scale;
	return var_01;
}

//Function Number: 12
_forward_skill_transform(param_00)
{
	param_00 = clamp(param_00,-3.141593,3.141593);
	var_01 = param_00;
	var_01 = _rational_tanh(var_01 * level.skill_sos_tanh_scale);
	var_01 = var_01 + 1;
	var_01 = var_01 * 0.5;
	return var_01;
}

//Function Number: 13
_adjust_rating(param_00,param_01)
{
	var_02 = _inverse_skill_transform(param_00);
	var_02 = var_02 + param_01;
	var_03 = _forward_skill_transform(var_02);
	return var_03;
}

//Function Number: 14
_convert_rating_to_skill(param_00)
{
	var_01 = param_00 * 2000;
	return int(var_01);
}

//Function Number: 15
_convert_skill_to_rating(param_00)
{
	var_01 = float(param_00) / 2000;
	var_01 = clamp(var_01,0,1);
	return var_01;
}

//Function Number: 16
_calc_rating(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 + param_02 * 0.5 + param_03;
	var_05 = param_00 + param_02 + param_01 + 2 * param_03;
	if(var_05 == 0)
	{
		return 0.5;
	}

	var_06 = var_04 / var_05;
	return var_06;
}

//Function Number: 17
_calc_sos_adjusted_rating(param_00,param_01)
{
	var_02 = param_00 - 0.5;
	var_02 = var_02 * 1;
	var_03 = _adjust_rating(param_01,var_02);
	return var_03;
}

//Function Number: 18
_normalize_assoc(param_00)
{
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		var_01 = var_01 + abs(var_04);
	}

	if(var_01 != 0)
	{
		var_02 = 1 / var_01;
	}

	foreach(var_07, var_04 in param_00)
	{
		param_00[var_07] = param_00[var_07] * var_02;
	}

	return param_00;
}

//Function Number: 19
_dot_assoc(param_00,param_01)
{
	var_02 = 0;
	foreach(var_05, var_04 in param_00)
	{
		if(isdefined(param_01[var_05]))
		{
			var_02 = var_02 + var_04 * param_01[var_05];
		}
	}

	return var_02;
}

//Function Number: 20
_rating_error(param_00)
{
	if(param_00 < -10)
	{
		return 0 - param_00;
	}

	return _norm_pdf(param_00) / _norm_cdf(param_00);
}

//Function Number: 21
_variance_error(param_00,param_01)
{
	return param_00 * param_00 + param_01;
}

//Function Number: 22
_norm_pdf(param_00)
{
	return 0.3989423 * function_00E5(param_00 * param_00 * 0.5 * -1);
}

//Function Number: 23
_norm_cdf(param_00)
{
	var_01 = abs(0.7071068 * param_00);
	var_02 = 1 / 1 + 0.5 * var_01;
	var_03 = var_02 * function_00E5(var_01 * var_01 * -1 - 1.265512 + var_02 * 1.000024 + var_02 * 0.374092 + var_02 * 0.09678418 + var_02 * -0.1862881 + var_02 * 0.2788681 + var_02 * -1.135204 + var_02 * 1.488516 + var_02 * -0.8221523 + var_02 * 0.1708728);
	if(param_00 >= 0)
	{
		var_03 = 2 - var_03;
	}

	return 0.5 * var_03;
}

//Function Number: 24
_updatesosproxy(param_00)
{
	if(isbot(param_00))
	{
		return;
	}

	if(!isdefined(param_00.sos_id))
	{
		return;
	}

	level.sos_players[param_00.sos_id].latest_time = maps\mp\_utility::getgametimepassedseconds();
	var_01 = level.sos_players[param_00.sos_id].latest_time - level.sos_players[param_00.sos_id].begin_time;
	if(var_01 > level.skill_rdur_min_sec && isdefined(param_00.pers) && isdefined(param_00.pers["score"]))
	{
		level.sos_players[param_00.sos_id].score_per_second = param_00.pers["score"] / var_01;
		return;
	}

	level.sos_players[param_00.sos_id].score_per_second = undefined;
}

//Function Number: 25
_updateskill()
{
	if(!isskillenabled())
	{
		return;
	}

	if(isdefined(self.skillcalculated) || !isdefined(self.sos_id))
	{
		return;
	}

	self.skillcalculated = 1;
	if(!isdefined(level.sos_players[self.sos_id]))
	{
		return;
	}

	foreach(var_01 in level.players)
	{
		_updatesosproxy(var_01);
	}

	var_03 = level.sos_players[self.sos_id];
	if(!isdefined(var_03.score_per_second))
	{
		return;
	}

	var_04 = var_03.latest_time - var_03.begin_time;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	var_08 = var_03.begin_sos_rating * var_04;
	var_09 = var_04;
	var_0A = var_03.begin_gdf_variance;
	var_0B = var_03.begin_gdf_rating;
	var_0C = 0;
	var_0D = 0;
	if(var_0A == 0)
	{
		var_0A = min(1,max(0.8596 + abs(var_03.begin_gdf_rating) * -0.18397,0.05));
	}

	foreach(var_16, var_0F in level.sos_players)
	{
		if(var_16 == self.sos_id)
		{
			continue;
		}

		if(!isdefined(var_0F.score_per_second))
		{
			continue;
		}

		var_10 = var_0F.latest_time - max(var_03.begin_time,var_0F.begin_time);
		if(var_10 <= 0)
		{
			continue;
		}

		var_11 = 7 + var_0A;
		if(var_0F.begin_gdf_variance)
		{
			var_11 = var_11 + var_0F.begin_gdf_variance;
		}
		else
		{
			var_11 = var_11 + min(max(abs(var_0F.begin_gdf_rating) * -0.18397 + 0.8596,0.05),1);
		}

		var_12 = sqrt(var_11);
		var_13 = var_0B - var_0F.begin_gdf_rating / var_12;
		var_14 = 0;
		if(var_03.score_per_second > var_0F.score_per_second)
		{
			var_05 = var_05 + 1;
			var_14 = 1;
		}
		else if(var_03.score_per_second < var_0F.score_per_second)
		{
			var_06 = var_06 + 1;
			var_14 = 0;
		}
		else
		{
			var_07 = var_07 + 1;
			var_14 = 0.5;
		}

		var_15 = 1 / 1 + function_00E5(var_13 * -1);
		var_0C = var_0C + var_14 - var_15 / var_12;
		var_0D = var_0D + sqrt(var_0A) / var_12 * var_15 * 1 - var_15 / var_11;
		var_08 = var_08 + var_0F.begin_sos_rating * var_10;
		var_09 = var_09 + var_10;
	}

	var_0A = var_0A + 0.0001;
	var_0B = var_0B + var_0A * var_0C;
	var_0A = max(0.05,var_0A * 1 - var_0A * var_0D);
	self setplayerdata("rankedMatchData","gdfRating",var_0B);
	self setplayerdata("rankedMatchData","gdfVariance",var_0A);
	var_17 = var_08 / var_09;
	var_18 = 1;
	var_19 = _calc_rating(var_05,var_06,var_07,level.skill_recent_sosc);
	var_1A = _calc_sos_adjusted_rating(var_19,var_17);
	var_1B = var_1A;
	var_1C = min(var_03.begin_sos_weight,level.skill_sos_max_weight);
	var_1D = var_1C + var_18;
	if(var_1D > 0)
	{
		var_1B = var_03.begin_sos_rating * var_1C + var_1B * var_18 / var_1D;
		self setplayerdata("rankedMatchData","sosRating",var_1B);
		self setplayerdata("rankedMatchData","sosWeight",var_03.begin_sos_weight + var_18);
	}
}