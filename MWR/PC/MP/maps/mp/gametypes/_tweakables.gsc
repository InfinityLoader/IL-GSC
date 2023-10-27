/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_tweakables.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 117 ms
 * Timestamp: 10/27/2023 2:42:16 AM
*******************************************************************/

//Function Number: 1
gettweakabledvarvalue(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			break;

		case "game":
			break;

		case "team":
			break;

		case "player":
			break;

		case "class":
			break;

		case "weapon":
			break;

		case "hardpoint":
			break;

		case "hud":
			break;

		default:
			break;
	}
}

//Function Number: 2
gettweakabledvar(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			break;

		case "game":
			break;

		case "team":
			break;

		case "player":
			break;

		case "class":
			break;

		case "weapon":
			break;

		case "hardpoint":
			break;

		case "hud":
			break;

		default:
			break;
	}
}

//Function Number: 3
gettweakablevalue(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			break;

		case "game":
			break;

		case "team":
			break;

		case "player":
			break;

		case "class":
			break;

		case "weapon":
			break;

		case "hardpoint":
			break;

		case "hud":
			break;

		default:
			break;
	}
}

//Function Number: 4
gettweakablelastvalue(param_00,param_01)
{
	switch(param_00)
	{
		case "rule":
			break;

		case "game":
			break;

		case "team":
			break;

		case "player":
			break;

		case "class":
			break;

		case "weapon":
			break;

		case "hardpoint":
			break;

		case "hud":
			break;

		default:
			break;
	}
}

//Function Number: 5
settweakablevalue(param_00,param_01,param_02)
{
	switch(param_00)
	{
		case "rule":
			break;

		case "game":
			break;

		case "team":
			break;

		case "player":
			break;

		case "class":
			break;

		case "weapon":
			break;

		case "hardpoint":
			break;

		case "hud":
			break;

		default:
			break;
	}
}

//Function Number: 6
settweakablelastvalue(param_00,param_01,param_02)
{
	switch(param_00)
	{
		case "rule":
			break;

		case "game":
			break;

		case "team":
			break;

		case "player":
			break;

		case "class":
			break;

		case "weapon":
			break;

		case "hardpoint":
			break;

		case "hud":
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
			break;

		case "game":
			break;

		case "team":
			break;

		case "player":
			break;

		case "class":
			break;

		case "weapon":
			break;

		case "hardpoint":
			break;

		case "hud":
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
}