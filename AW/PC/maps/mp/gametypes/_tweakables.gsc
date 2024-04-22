/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_tweakables.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 130 ms
 * Timestamp: 4/22/2024 2:10:27 AM
*******************************************************************/

//Function Number: 1
gettweakabledvarvalue(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			var_02 = level.rules[param_01].dvar;
			break;

		case "game":
			var_02 = level.gametweaks[var_02].dvar;
			break;

		case "team":
			var_02 = level.teamtweaks[var_02].dvar;
			break;

		case "player":
			var_02 = level.playertweaks[var_02].dvar;
			break;

		case "class":
			var_02 = level.classtweaks[var_02].dvar;
			break;

		case "weapon":
			var_02 = level.weapontweaks[var_02].dvar;
			break;

		case "hardpoint":
			var_02 = level.hardpointtweaks[var_02].dvar;
			break;

		case "hud":
			var_02 = level.hudtweaks[var_02].dvar;
			break;

		default:
			var_02 = undefined;
			break;
	}

	var_03 = getdvarint(var_02);
	return var_03;
}

//Function Number: 2
gettweakabledvar(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			var_02 = level.rules[param_01].dvar;
			break;

		case "game":
			var_02 = level.gametweaks[var_02].dvar;
			break;

		case "team":
			var_02 = level.teamtweaks[var_02].dvar;
			break;

		case "player":
			var_02 = level.playertweaks[var_02].dvar;
			break;

		case "class":
			var_02 = level.classtweaks[var_02].dvar;
			break;

		case "weapon":
			var_02 = level.weapontweaks[var_02].dvar;
			break;

		case "hardpoint":
			var_02 = level.hardpointtweaks[var_02].dvar;
			break;

		case "hud":
			var_02 = level.hudtweaks[var_02].dvar;
			break;

		default:
			var_02 = undefined;
			break;
	}

	return var_02;
}

//Function Number: 3
gettweakablevalue(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			var_02 = level.rules[param_01].value;
			break;

		case "game":
			var_02 = level.gametweaks[var_02].value;
			break;

		case "team":
			var_02 = level.teamtweaks[var_02].value;
			break;

		case "player":
			var_02 = level.playertweaks[var_02].value;
			break;

		case "class":
			var_02 = level.classtweaks[var_02].value;
			break;

		case "weapon":
			var_02 = level.weapontweaks[var_02].value;
			break;

		case "hardpoint":
			var_02 = level.hardpointtweaks[var_02].value;
			break;

		case "hud":
			var_02 = level.hudtweaks[var_02].value;
			break;

		default:
			var_02 = undefined;
			break;
	}

	return var_02;
}

//Function Number: 4
gettweakablelastvalue(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			var_02 = level.rules[param_01].lastvalue;
			break;

		case "game":
			var_02 = level.gametweaks[var_02].lastvalue;
			break;

		case "team":
			var_02 = level.teamtweaks[var_02].lastvalue;
			break;

		case "player":
			var_02 = level.playertweaks[var_02].lastvalue;
			break;

		case "class":
			var_02 = level.classtweaks[var_02].lastvalue;
			break;

		case "weapon":
			var_02 = level.weapontweaks[var_02].lastvalue;
			break;

		case "hardpoint":
			var_02 = level.hardpointtweaks[var_02].lastvalue;
			break;

		case "hud":
			var_02 = level.hudtweaks[var_02].lastvalue;
			break;

		default:
			var_02 = undefined;
			break;
	}

	return var_02;
}

//Function Number: 5
settweakablevalue(param_00,param_01,param_02)
{
	switch(param_00)
	{
		case "rule":
			var_03 = level.rules[param_01].dvar;
			break;

		case "game":
			var_03 = level.gametweaks[param_02].dvar;
			break;

		case "team":
			var_03 = level.teamtweaks[param_02].dvar;
			break;

		case "player":
			var_03 = level.playertweaks[param_02].dvar;
			break;

		case "class":
			var_03 = level.classtweaks[param_02].dvar;
			break;

		case "weapon":
			var_03 = level.weapontweaks[param_02].dvar;
			break;

		case "hardpoint":
			var_03 = level.hardpointtweaks[param_02].dvar;
			break;

		case "hud":
			var_03 = level.hudtweaks[param_02].dvar;
			break;

		default:
			var_03 = undefined;
			break;
	}

	setdvar(var_03,param_02);
}

//Function Number: 6
settweakablelastvalue(param_00,param_01,param_02)
{
	switch(param_00)
	{
		case "rule":
			level.rules[param_01].lastvalue = param_02;
			break;

		case "game":
			level.gametweaks[param_01].lastvalue = param_02;
			break;

		case "team":
			level.teamtweaks[param_01].lastvalue = param_02;
			break;

		case "player":
			level.playertweaks[param_01].lastvalue = param_02;
			break;

		case "class":
			level.classtweaks[param_01].lastvalue = param_02;
			break;

		case "weapon":
			level.weapontweaks[param_01].lastvalue = param_02;
			break;

		case "hardpoint":
			level.hardpointtweaks[param_01].lastvalue = param_02;
			break;

		case "hud":
			level.hudtweaks[param_01].lastvalue = param_02;
			break;

		default:
			break;
	}
}

//Function Number: 7
registertweakable(param_00,param_01,param_02,param_03)
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
			if(!isdefined(level.rules[param_01]))
			{
				level.rules[param_01] = spawnstruct();
			}
	
			level.rules[param_01].value = param_03;
			level.rules[param_01].lastvalue = param_03;
			level.rules[param_01].dvar = param_02;
			break;

		case "game":
			if(!isdefined(level.gametweaks[param_01]))
			{
				level.gametweaks[param_01] = spawnstruct();
			}
	
			level.gametweaks[param_01].value = param_03;
			level.gametweaks[param_01].lastvalue = param_03;
			level.gametweaks[param_01].dvar = param_02;
			break;

		case "team":
			if(!isdefined(level.teamtweaks[param_01]))
			{
				level.teamtweaks[param_01] = spawnstruct();
			}
	
			level.teamtweaks[param_01].value = param_03;
			level.teamtweaks[param_01].lastvalue = param_03;
			level.teamtweaks[param_01].dvar = param_02;
			break;

		case "player":
			if(!isdefined(level.playertweaks[param_01]))
			{
				level.playertweaks[param_01] = spawnstruct();
			}
	
			level.playertweaks[param_01].value = param_03;
			level.playertweaks[param_01].lastvalue = param_03;
			level.playertweaks[param_01].dvar = param_02;
			break;

		case "class":
			if(!isdefined(level.classtweaks[param_01]))
			{
				level.classtweaks[param_01] = spawnstruct();
			}
	
			level.classtweaks[param_01].value = param_03;
			level.classtweaks[param_01].lastvalue = param_03;
			level.classtweaks[param_01].dvar = param_02;
			break;

		case "weapon":
			if(!isdefined(level.weapontweaks[param_01]))
			{
				level.weapontweaks[param_01] = spawnstruct();
			}
	
			level.weapontweaks[param_01].value = param_03;
			level.weapontweaks[param_01].lastvalue = param_03;
			level.weapontweaks[param_01].dvar = param_02;
			break;

		case "hardpoint":
			if(!isdefined(level.hardpointtweaks[param_01]))
			{
				level.hardpointtweaks[param_01] = spawnstruct();
			}
	
			level.hardpointtweaks[param_01].value = param_03;
			level.hardpointtweaks[param_01].lastvalue = param_03;
			level.hardpointtweaks[param_01].dvar = param_02;
			break;

		case "hud":
			if(!isdefined(level.hudtweaks[param_01]))
			{
				level.hudtweaks[param_01] = spawnstruct();
			}
	
			level.hudtweaks[param_01].value = param_03;
			level.hudtweaks[param_01].lastvalue = param_03;
			level.hudtweaks[param_01].dvar = param_02;
			break;
	}
}

//Function Number: 8
init()
{
	level.clienttweakables = [];
	level.tweakablesinitialized = 1;
	level.rules = [];
	level.gametweaks = [];
	level.teamtweaks = [];
	level.playertweaks = [];
	level.classtweaks = [];
	level.weapontweaks = [];
	level.hardpointtweaks = [];
	level.hudtweaks = [];
	if(level.console)
	{
		registertweakable("game","graceperiod","scr_game_graceperiod",15);
		registertweakable("game","graceperiod_ds","scr_game_graceperiod_ds",20);
	}
	else
	{
		registertweakable("game","playerwaittime","scr_game_playerwaittime",15);
		registertweakable("game","playerwaittime_ds","scr_game_playerwaittime_ds",20);
	}

	registertweakable("game","matchstarttime","scr_game_matchstarttime",15);
	registertweakable("game","roundstarttime","scr_game_roundstarttime",5);
	registertweakable("game","onlyheadshots","scr_game_onlyheadshots",0);
	registertweakable("game","allowkillcam","scr_game_allowkillcam",1);
	registertweakable("game","spectatetype","scr_game_spectatetype",2);
	registertweakable("game","lockspectatepov","scr_game_lockspectatorpov",0);
	registertweakable("game","deathpointloss","scr_game_deathpointloss",0);
	registertweakable("game","suicidepointloss","scr_game_suicidepointloss",0);
	registertweakable("game","suicidespawndelay","scr_game_suicidespawndelay",0);
	registertweakable("team","teamkillpointloss","scr_team_teamkillpointloss",0);
	registertweakable("team","fftype","scr_team_fftype",0);
	registertweakable("team","teamkillspawndelay","scr_team_teamkillspawndelay",20);
	registertweakable("team","teamkillkicklimit","scr_team_teamkillkicklimit",0);
	registertweakable("player","maxhealth","scr_player_maxhealth",100);
	registertweakable("player","healthregentime","scr_player_healthregentime",5);
	registertweakable("player","forcerespawn","scr_player_forcerespawn",1);
	registertweakable("weapon","allowfrag","scr_weapon_allowfrags",1);
	registertweakable("weapon","allowsmoke","scr_weapon_allowsmoke",1);
	registertweakable("weapon","allowflash","scr_weapon_allowflash",1);
	registertweakable("weapon","allowc4","scr_weapon_allowc4",1);
	registertweakable("weapon","allowclaymores","scr_weapon_allowclaymores",1);
	registertweakable("weapon","allowrpgs","scr_weapon_allowrpgs",1);
	registertweakable("weapon","allowmines","scr_weapon_allowmines",1);
	registertweakable("hardpoint","allowartillery","scr_hardpoint_allowartillery",1);
	registertweakable("hardpoint","allowuav","scr_hardpoint_allowuav",1);
	registertweakable("hardpoint","allowsupply","scr_hardpoint_allowsupply",1);
	registertweakable("hardpoint","allowhelicopter","scr_hardpoint_allowhelicopter",1);
}