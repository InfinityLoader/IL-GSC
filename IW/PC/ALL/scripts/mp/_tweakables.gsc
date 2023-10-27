/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_tweakables.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 328 ms
 * Timestamp: 10/27/2023 12:21:51 AM
*******************************************************************/

//Function Number: 1
func_81E5(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			var_02 = level.var_E7B9[param_01].var_5F6A;
			break;

		case "game":
			var_02 = level.var_7689[var_02].var_5F6A;
			break;

		case "team":
			var_02 = level.var_115F0[var_02].var_5F6A;
			break;

		case "player":
			var_02 = level.var_D453[var_02].var_5F6A;
			break;

		case "class":
			var_02 = level.var_4013[var_02].var_5F6A;
			break;

		case "weapon":
			var_02 = level.var_13CDD[var_02].var_5F6A;
			break;

		case "hardpoint":
			var_02 = level.var_8B52[var_02].var_5F6A;
			break;

		case "hud":
			var_02 = level.var_91B2[var_02].var_5F6A;
			break;

		default:
			var_02 = undefined;
			break;
	}

	var_03 = getdvarint(var_02);
	return var_03;
}

//Function Number: 2
func_81E4(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			var_02 = level.var_E7B9[param_01].var_5F6A;
			break;

		case "game":
			var_02 = level.var_7689[var_02].var_5F6A;
			break;

		case "team":
			var_02 = level.var_115F0[var_02].var_5F6A;
			break;

		case "player":
			var_02 = level.var_D453[var_02].var_5F6A;
			break;

		case "class":
			var_02 = level.var_4013[var_02].var_5F6A;
			break;

		case "weapon":
			var_02 = level.var_13CDD[var_02].var_5F6A;
			break;

		case "hardpoint":
			var_02 = level.var_8B52[var_02].var_5F6A;
			break;

		case "hud":
			var_02 = level.var_91B2[var_02].var_5F6A;
			break;

		default:
			var_02 = undefined;
			break;
	}

	return var_02;
}

//Function Number: 3
func_81E7(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			var_02 = level.var_E7B9[param_01].var_13153;
			break;

		case "game":
			var_02 = level.var_7689[var_02].var_13153;
			break;

		case "team":
			var_02 = level.var_115F0[var_02].var_13153;
			break;

		case "player":
			var_02 = level.var_D453[var_02].var_13153;
			break;

		case "class":
			var_02 = level.var_4013[var_02].var_13153;
			break;

		case "weapon":
			var_02 = level.var_13CDD[var_02].var_13153;
			break;

		case "hardpoint":
			var_02 = level.var_8B52[var_02].var_13153;
			break;

		case "hud":
			var_02 = level.var_91B2[var_02].var_13153;
			break;

		default:
			var_02 = undefined;
			break;
	}

	return var_02;
}

//Function Number: 4
func_81E6(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			var_02 = level.var_E7B9[param_01].var_AA40;
			break;

		case "game":
			var_02 = level.var_7689[var_02].var_AA40;
			break;

		case "team":
			var_02 = level.var_115F0[var_02].var_AA40;
			break;

		case "player":
			var_02 = level.var_D453[var_02].var_AA40;
			break;

		case "class":
			var_02 = level.var_4013[var_02].var_AA40;
			break;

		case "weapon":
			var_02 = level.var_13CDD[var_02].var_AA40;
			break;

		case "hardpoint":
			var_02 = level.var_8B52[var_02].var_AA40;
			break;

		case "hud":
			var_02 = level.var_91B2[var_02].var_AA40;
			break;

		default:
			var_02 = undefined;
			break;
	}

	return var_02;
}

//Function Number: 5
func_F89E(param_00,param_01,param_02)
{
	switch(param_00)
	{
		case "rule":
			var_03 = level.var_E7B9[param_01].var_5F6A;
			break;

		case "game":
			var_03 = level.var_7689[param_02].var_5F6A;
			break;

		case "team":
			var_03 = level.var_115F0[param_02].var_5F6A;
			break;

		case "player":
			var_03 = level.var_D453[param_02].var_5F6A;
			break;

		case "class":
			var_03 = level.var_4013[param_02].var_5F6A;
			break;

		case "weapon":
			var_03 = level.var_13CDD[param_02].var_5F6A;
			break;

		case "hardpoint":
			var_03 = level.var_8B52[param_02].var_5F6A;
			break;

		case "hud":
			var_03 = level.var_91B2[param_02].var_5F6A;
			break;

		default:
			var_03 = undefined;
			break;
	}

	setdvar(var_03,param_02);
}

//Function Number: 6
func_F89D(param_00,param_01,param_02)
{
	switch(param_00)
	{
		case "rule":
			level.var_E7B9[param_01].var_AA40 = param_02;
			break;

		case "game":
			level.var_7689[param_01].var_AA40 = param_02;
			break;

		case "team":
			level.var_115F0[param_01].var_AA40 = param_02;
			break;

		case "player":
			level.var_D453[param_01].var_AA40 = param_02;
			break;

		case "class":
			level.var_4013[param_01].var_AA40 = param_02;
			break;

		case "weapon":
			level.var_13CDD[param_01].var_AA40 = param_02;
			break;

		case "hardpoint":
			level.var_8B52[param_01].var_AA40 = param_02;
			break;

		case "hud":
			level.var_91B2[param_01].var_AA40 = param_02;
			break;

		default:
			break;
	}
}

//Function Number: 7
func_DF14(param_00,param_01,param_02,param_03)
{
	if(isstring(param_03))
	{
		param_03 = getdvar(param_02,param_03);
	}
	else
	{
		param_03 = getdvarint(param_02,param_03);
	}

	switch(param_00)
	{
		case "rule":
			if(!isdefined(level.var_E7B9[param_01]))
			{
				level.var_E7B9[param_01] = spawnstruct();
			}
	
			level.var_E7B9[param_01].var_13153 = param_03;
			level.var_E7B9[param_01].var_AA40 = param_03;
			level.var_E7B9[param_01].var_5F6A = param_02;
			break;

		case "game":
			if(!isdefined(level.var_7689[param_01]))
			{
				level.var_7689[param_01] = spawnstruct();
			}
	
			level.var_7689[param_01].var_13153 = param_03;
			level.var_7689[param_01].var_AA40 = param_03;
			level.var_7689[param_01].var_5F6A = param_02;
			break;

		case "team":
			if(!isdefined(level.var_115F0[param_01]))
			{
				level.var_115F0[param_01] = spawnstruct();
			}
	
			level.var_115F0[param_01].var_13153 = param_03;
			level.var_115F0[param_01].var_AA40 = param_03;
			level.var_115F0[param_01].var_5F6A = param_02;
			break;

		case "player":
			if(!isdefined(level.var_D453[param_01]))
			{
				level.var_D453[param_01] = spawnstruct();
			}
	
			level.var_D453[param_01].var_13153 = param_03;
			level.var_D453[param_01].var_AA40 = param_03;
			level.var_D453[param_01].var_5F6A = param_02;
			break;

		case "class":
			if(!isdefined(level.var_4013[param_01]))
			{
				level.var_4013[param_01] = spawnstruct();
			}
	
			level.var_4013[param_01].var_13153 = param_03;
			level.var_4013[param_01].var_AA40 = param_03;
			level.var_4013[param_01].var_5F6A = param_02;
			break;

		case "weapon":
			if(!isdefined(level.var_13CDD[param_01]))
			{
				level.var_13CDD[param_01] = spawnstruct();
			}
	
			level.var_13CDD[param_01].var_13153 = param_03;
			level.var_13CDD[param_01].var_AA40 = param_03;
			level.var_13CDD[param_01].var_5F6A = param_02;
			break;

		case "hardpoint":
			if(!isdefined(level.var_8B52[param_01]))
			{
				level.var_8B52[param_01] = spawnstruct();
			}
	
			level.var_8B52[param_01].var_13153 = param_03;
			level.var_8B52[param_01].var_AA40 = param_03;
			level.var_8B52[param_01].var_5F6A = param_02;
			break;

		case "hud":
			if(!isdefined(level.var_91B2[param_01]))
			{
				level.var_91B2[param_01] = spawnstruct();
			}
	
			level.var_91B2[param_01].var_13153 = param_03;
			level.var_91B2[param_01].var_AA40 = param_03;
			level.var_91B2[param_01].var_5F6A = param_02;
			break;
	}
}

//Function Number: 8
init()
{
	level.var_41F9 = [];
	level.var_12AC9 = 1;
	level.var_E7B9 = [];
	level.var_7689 = [];
	level.var_115F0 = [];
	level.var_D453 = [];
	level.var_4013 = [];
	level.var_13CDD = [];
	level.var_8B52 = [];
	level.var_91B2 = [];
	if(level.console)
	{
		if(level.var_13E0E || level.var_DADC)
		{
			func_DF14("game","graceperiod","scr_game_graceperiod",20);
		}
		else
		{
			func_DF14("game","graceperiod","scr_game_graceperiod",15);
		}

		func_DF14("game","graceperiod_comp","scr_game_graceperiod_comp",30);
	}
	else
	{
		func_DF14("game","playerwaittime","scr_game_playerwaittime",15);
		func_DF14("game","playerwaittime_comp","scr_game_playerwaittime_comp",30);
	}

	func_DF14("game","matchstarttime","scr_game_matchstarttime",15);
	func_DF14("game","onlyheadshots","scr_game_onlyheadshots",0);
	func_DF14("game","allowkillcam","scr_game_allowkillcam",1);
	func_DF14("game","spectatetype","scr_game_spectatetype",2);
	func_DF14("game","allow3rdspectate","scr_game_allow3rdspectate",1);
	func_DF14("game","deathpointloss","scr_game_deathpointloss",0);
	func_DF14("game","suicidepointloss","scr_game_suicidepointloss",0);
	func_DF14("team","teamkillpointloss","scr_team_teamkillpointloss",0);
	func_DF14("team","fftype","scr_team_fftype",0);
	func_DF14("team","teamkillspawndelay","scr_team_teamkillspawndelay",0);
	func_DF14("player","maxhealth","scr_player_maxhealth",100);
	func_DF14("player","healthregentime","scr_player_healthregentime",2);
	func_DF14("player","forcerespawn","scr_player_forcerespawn",1);
	func_DF14("player","streamingwaittime","scr_player_streamingwaittime",5);
	func_DF14("weapon","allowfrag","scr_weapon_allowfrags",1);
	func_DF14("weapon","allowsmoke","scr_weapon_allowsmoke",1);
	func_DF14("weapon","allowflash","scr_weapon_allowflash",1);
	func_DF14("weapon","allowc4","scr_weapon_allowc4",1);
	func_DF14("weapon","allowclaymores","scr_weapon_allowclaymores",1);
	func_DF14("weapon","allowrpgs","scr_weapon_allowrpgs",1);
	func_DF14("weapon","allowmines","scr_weapon_allowmines",1);
	func_DF14("hardpoint","allowartillery","scr_hardpoint_allowartillery",1);
	func_DF14("hardpoint","allowuav","scr_hardpoint_allowuav",1);
	func_DF14("hardpoint","allowsupply","scr_hardpoint_allowsupply",1);
	func_DF14("hardpoint","allowhelicopter","scr_hardpoint_allowhelicopter",1);
	func_DF14("hud","showobjicons","ui_hud_showobjicons",1);
	setdvar("ui_hud_showobjicons",1);
}