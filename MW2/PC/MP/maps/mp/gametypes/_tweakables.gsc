/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_tweakables.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

gettweakabledvarvalue(category, name)
{
	switch(category)
	{
		case "rule":
			dvar = level.rules[name].dvar;
			break;

		case "game":
			dvar = level.gametweaks[dvar].dvar;
			break;

		case "team":
			dvar = level.teamtweaks[dvar].dvar;
			break;

		case "player":
			dvar = level.playertweaks[dvar].dvar;
			break;

		case "class":
			dvar = level.classtweaks[dvar].dvar;
			break;

		case "weapon":
			dvar = level.weapontweaks[dvar].dvar;
			break;

		case "hardpoint":
			dvar = level.hardpointtweaks[dvar].dvar;
			break;

		case "hud":
			dvar = level.hudtweaks[dvar].dvar;
			break;

		default:
			dvar = undefined;
			break;
	}

	value = getdvarint(dvar);
	return value;
}

gettweakabledvar(category, name)
{
	switch(category)
	{
		case "rule":
			value = level.rules[name].dvar;
			break;

		case "game":
			value = level.gametweaks[value].dvar;
			break;

		case "team":
			value = level.teamtweaks[value].dvar;
			break;

		case "player":
			value = level.playertweaks[value].dvar;
			break;

		case "class":
			value = level.classtweaks[value].dvar;
			break;

		case "weapon":
			value = level.weapontweaks[value].dvar;
			break;

		case "hardpoint":
			value = level.hardpointtweaks[value].dvar;
			break;

		case "hud":
			value = level.hudtweaks[value].dvar;
			break;

		default:
			value = undefined;
			break;
	}

	return value;
}

gettweakablevalue(category, name)
{
	switch(category)
	{
		case "rule":
			value = level.rules[name].value;
			break;

		case "game":
			value = level.gametweaks[value].value;
			break;

		case "team":
			value = level.teamtweaks[value].value;
			break;

		case "player":
			value = level.playertweaks[value].value;
			break;

		case "class":
			value = level.classtweaks[value].value;
			break;

		case "weapon":
			value = level.weapontweaks[value].value;
			break;

		case "hardpoint":
			value = level.hardpointtweaks[value].value;
			break;

		case "hud":
			value = level.hudtweaks[value].value;
			break;

		default:
			value = undefined;
			break;
	}

	return value;
}

gettweakablelastvalue(category, name)
{
	switch(category)
	{
		case "rule":
			value = level.rules[name].lastvalue;
			break;

		case "game":
			value = level.gametweaks[value].lastvalue;
			break;

		case "team":
			value = level.teamtweaks[value].lastvalue;
			break;

		case "player":
			value = level.playertweaks[value].lastvalue;
			break;

		case "class":
			value = level.classtweaks[value].lastvalue;
			break;

		case "weapon":
			value = level.weapontweaks[value].lastvalue;
			break;

		case "hardpoint":
			value = level.hardpointtweaks[value].lastvalue;
			break;

		case "hud":
			value = level.hudtweaks[value].lastvalue;
			break;

		default:
			value = undefined;
			break;
	}

	return value;
}

settweakablevalue(category, name, value)
{
	switch(category)
	{
		case "rule":
			dvar = level.rules[name].dvar;
			break;

		case "game":
			dvar = level.gametweaks[value].dvar;
			break;

		case "team":
			dvar = level.teamtweaks[value].dvar;
			break;

		case "player":
			dvar = level.playertweaks[value].dvar;
			break;

		case "class":
			dvar = level.classtweaks[value].dvar;
			break;

		case "weapon":
			dvar = level.weapontweaks[value].dvar;
			break;

		case "hardpoint":
			dvar = level.hardpointtweaks[value].dvar;
			break;

		case "hud":
			dvar = level.hudtweaks[value].dvar;
			break;

		default:
			dvar = undefined;
			break;
	}

	setdvar(dvar, value);
}

settweakablelastvalue(category, name, value)
{
	switch(category)
	{
		case "rule":
			level.rules[name].lastvalue = value;
			break;

		case "game":
			level.gametweaks[name].lastvalue = value;
			break;

		case "team":
			level.teamtweaks[name].lastvalue = value;
			break;

		case "player":
			level.playertweaks[name].lastvalue = value;
			break;

		case "class":
			level.classtweaks[name].lastvalue = value;
			break;

		case "weapon":
			level.weapontweaks[name].lastvalue = value;
			break;

		case "hardpoint":
			level.hardpointtweaks[name].lastvalue = value;
			break;

		case "hud":
			level.hudtweaks[name].lastvalue = value;
			break;

		default:
			break;
	}
}

registertweakable(category, name, dvar, value)
{
	if(isstring(value))
	{
		value = getdvar(dvar, value);
	}
	else
	{
		value = getdvarint(dvar, value);
	}

	switch(category)
	{
		case "rule":
			if(!isdefined(level.rules[name]))
			{
				level.rules[name] = spawnstruct();
			}
	
			level.rules[name].value = value;
			level.rules[name].lastvalue = value;
			level.rules[name].dvar = dvar;
			break;

		case "game":
			if(!isdefined(level.gametweaks[name]))
			{
				level.gametweaks[name] = spawnstruct();
			}
	
			level.gametweaks[name].value = value;
			level.gametweaks[name].lastvalue = value;
			level.gametweaks[name].dvar = dvar;
			break;

		case "team":
			if(!isdefined(level.teamtweaks[name]))
			{
				level.teamtweaks[name] = spawnstruct();
			}
	
			level.teamtweaks[name].value = value;
			level.teamtweaks[name].lastvalue = value;
			level.teamtweaks[name].dvar = dvar;
			break;

		case "player":
			if(!isdefined(level.playertweaks[name]))
			{
				level.playertweaks[name] = spawnstruct();
			}
	
			level.playertweaks[name].value = value;
			level.playertweaks[name].lastvalue = value;
			level.playertweaks[name].dvar = dvar;
			break;

		case "class":
			if(!isdefined(level.classtweaks[name]))
			{
				level.classtweaks[name] = spawnstruct();
			}
	
			level.classtweaks[name].value = value;
			level.classtweaks[name].lastvalue = value;
			level.classtweaks[name].dvar = dvar;
			break;

		case "weapon":
			if(!isdefined(level.weapontweaks[name]))
			{
				level.weapontweaks[name] = spawnstruct();
			}
	
			level.weapontweaks[name].value = value;
			level.weapontweaks[name].lastvalue = value;
			level.weapontweaks[name].dvar = dvar;
			break;

		case "hardpoint":
			if(!isdefined(level.hardpointtweaks[name]))
			{
				level.hardpointtweaks[name] = spawnstruct();
			}
	
			level.hardpointtweaks[name].value = value;
			level.hardpointtweaks[name].lastvalue = value;
			level.hardpointtweaks[name].dvar = dvar;
			break;

		case "hud":
			if(!isdefined(level.hudtweaks[name]))
			{
				level.hudtweaks[name] = spawnstruct();
			}
	
			level.hudtweaks[name].value = value;
			level.hudtweaks[name].lastvalue = value;
			level.hudtweaks[name].dvar = dvar;
			break;
	}
}

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
		registertweakable("game", "graceperiod", "scr_game_graceperiod", 15);
	}
	else
	{
		registertweakable("game", "playerwaittime", "scr_game_playerwaittime", 15);
		registertweakable("game", "matchstarttime", "scr_game_matchstarttime", 5);
	}

	registertweakable("game", "onlyheadshots", "scr_game_onlyheadshots", 0);
	registertweakable("game", "allowkillcam", "scr_game_allowkillcam", 1);
	registertweakable("game", "spectatetype", "scr_game_spectatetype", 2);
	registertweakable("game", "deathpointloss", "scr_game_deathpointloss", 0);
	registertweakable("game", "suicidepointloss", "scr_game_suicidepointloss", 0);
	registertweakable("team", "teamkillpointloss", "scr_team_teamkillpointloss", 0);
	registertweakable("team", "fftype", "scr_team_fftype", 0);
	registertweakable("team", "teamkillspawndelay", "scr_team_teamkillspawndelay", 0);
	registertweakable("player", "maxhealth", "scr_player_maxhealth", 100);
	registertweakable("player", "healthregentime", "scr_player_healthregentime", 5);
	registertweakable("player", "forcerespawn", "scr_player_forcerespawn", 1);
	registertweakable("weapon", "allowfrag", "scr_weapon_allowfrags", 1);
	registertweakable("weapon", "allowsmoke", "scr_weapon_allowsmoke", 1);
	registertweakable("weapon", "allowflash", "scr_weapon_allowflash", 1);
	registertweakable("weapon", "allowc4", "scr_weapon_allowc4", 1);
	registertweakable("weapon", "allowclaymores", "scr_weapon_allowclaymores", 1);
	registertweakable("weapon", "allowrpgs", "scr_weapon_allowrpgs", 1);
	registertweakable("weapon", "allowmines", "scr_weapon_allowmines", 1);
	registertweakable("hardpoint", "allowartillery", "scr_hardpoint_allowartillery", 1);
	registertweakable("hardpoint", "allowuav", "scr_hardpoint_allowuav", 1);
	registertweakable("hardpoint", "allowsupply", "scr_hardpoint_allowsupply", 1);
	registertweakable("hardpoint", "allowhelicopter", "scr_hardpoint_allowhelicopter", 1);
	registertweakable("hud", "showobjicons", "ui_hud_showobjicons", 1);
	makedvarserverinfo("ui_hud_showobjicons", 1);
}