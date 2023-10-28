/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_tweakables.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 2 ms
 * Timestamp: 10/28/2023 12:10:37 AM
*******************************************************************/

#include maps/mp/_utility;

//Function Number: 1
gettweakabledvarvalue(category,name)
{
	switch(category)
	{
		case "rule":
			dvar = level.rules[name].dvar;
			break;

		case "game":
			dvar = level.gametweaks[name].dvar;
			break;

		case "team":
			dvar = level.teamtweaks[name].dvar;
			break;

		case "player":
			dvar = level.playertweaks[name].dvar;
			break;

		case "class":
			dvar = level.classtweaks[name].dvar;
			break;

		case "weapon":
			dvar = level.weapontweaks[name].dvar;
			break;

		case "killstreak":
			dvar = level.hardpointtweaks[name].dvar;
			break;

		case "hud":
			dvar = level.hudtweaks[name].dvar;
			break;

		default:
			dvar = undefined;
			break;
	}

/#
	assert(IsDefined(dvar));
#/
	value = GetDvarInt(dvar);
	return value;
}

//Function Number: 2
gettweakabledvar(category,name)
{
	switch(category)
	{
		case "rule":
			value = level.rules[name].dvar;
			break;

		case "game":
			value = level.gametweaks[name].dvar;
			break;

		case "team":
			value = level.teamtweaks[name].dvar;
			break;

		case "player":
			value = level.playertweaks[name].dvar;
			break;

		case "class":
			value = level.classtweaks[name].dvar;
			break;

		case "weapon":
			value = level.weapontweaks[name].dvar;
			break;

		case "killstreak":
			value = level.hardpointtweaks[name].dvar;
			break;

		case "hud":
			value = level.hudtweaks[name].dvar;
			break;

		default:
			value = undefined;
			break;
	}

/#
	assert(IsDefined(value));
#/
	return value;
}

//Function Number: 3
gettweakablevalue(category,name)
{
	switch(category)
	{
		case "rule":
			value = level.rules[name].value;
			break;

		case "game":
			value = level.gametweaks[name].value;
			break;

		case "team":
			value = level.teamtweaks[name].value;
			break;

		case "player":
			value = level.playertweaks[name].value;
			break;

		case "class":
			value = level.classtweaks[name].value;
			break;

		case "weapon":
			value = level.weapontweaks[name].value;
			break;

		case "killstreak":
			value = level.hardpointtweaks[name].value;
			break;

		case "hud":
			value = level.hudtweaks[name].value;
			break;

		default:
			value = undefined;
			break;
	}

	overridedvar = "scr_" + level.gametype + "_" + category + "_" + name;
	if(GetDvar(overridedvar) != "")
	{
		return GetDvarInt(overridedvar);
	}

/#
	assert(IsDefined(value));
#/
	return value;
}

//Function Number: 4
gettweakablelastvalue(category,name)
{
	switch(category)
	{
		case "rule":
			value = level.rules[name].lastvalue;
			break;

		case "game":
			value = level.gametweaks[name].lastvalue;
			break;

		case "team":
			value = level.teamtweaks[name].lastvalue;
			break;

		case "player":
			value = level.playertweaks[name].lastvalue;
			break;

		case "class":
			value = level.classtweaks[name].lastvalue;
			break;

		case "weapon":
			value = level.weapontweaks[name].lastvalue;
			break;

		case "killstreak":
			value = level.hardpointtweaks[name].lastvalue;
			break;

		case "hud":
			value = level.hudtweaks[name].lastvalue;
			break;

		default:
			value = undefined;
			break;
	}

/#
	assert(IsDefined(value));
#/
	return value;
}

//Function Number: 5
settweakablevalue(category,name,value)
{
	switch(category)
	{
		case "rule":
			dvar = level.rules[name].dvar;
			break;

		case "game":
			dvar = level.gametweaks[name].dvar;
			break;

		case "team":
			dvar = level.teamtweaks[name].dvar;
			break;

		case "player":
			dvar = level.playertweaks[name].dvar;
			break;

		case "class":
			dvar = level.classtweaks[name].dvar;
			break;

		case "weapon":
			dvar = level.weapontweaks[name].dvar;
			break;

		case "killstreak":
			dvar = level.hardpointtweaks[name].dvar;
			break;

		case "hud":
			dvar = level.hudtweaks[name].dvar;
			break;

		default:
			dvar = undefined;
			break;
	}

	setdvar(dvar,value);
}

//Function Number: 6
settweakablelastvalue(category,name,value)
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

		case "killstreak":
			level.hardpointtweaks[name].lastvalue = value;
			break;

		case "hud":
			level.hudtweaks[name].lastvalue = value;
			break;

		default:
			break;
	}
}

//Function Number: 7
registertweakable(category,name,dvar,value)
{
	if(isstring(value))
	{
		if(GetDvar(dvar) == "")
		{
			setdvar(dvar,value);
		}
		else
		{
			value = GetDvar(dvar);
		}
	}
	else if(GetDvar(dvar) == "")
	{
		setdvar(dvar,value);
	}
	else
	{
		value = GetDvarInt(dvar);
	}

	switch(category)
	{
		case "rule":
			level.rules[name] = spawnstruct();
			level.rules[name].value = value;
			level.rules[name].lastvalue = value;
			level.rules[name].dvar = dvar;
			break;
	IsDefined(level.rules[name])
			break;

		case "game":
			level.gametweaks[name] = spawnstruct();
			level.gametweaks[name].value = value;
			level.gametweaks[name].lastvalue = value;
			level.gametweaks[name].dvar = dvar;
			break;
	IsDefined(level.gametweaks[name])
			break;

		case "team":
			level.teamtweaks[name] = spawnstruct();
			level.teamtweaks[name].value = value;
			level.teamtweaks[name].lastvalue = value;
			level.teamtweaks[name].dvar = dvar;
			break;
	IsDefined(level.teamtweaks[name])
			break;

		case "player":
			level.playertweaks[name] = spawnstruct();
			level.playertweaks[name].value = value;
			level.playertweaks[name].lastvalue = value;
			level.playertweaks[name].dvar = dvar;
			break;
	IsDefined(level.playertweaks[name])
			break;

		case "class":
			level.classtweaks[name] = spawnstruct();
			level.classtweaks[name].value = value;
			level.classtweaks[name].lastvalue = value;
			level.classtweaks[name].dvar = dvar;
			break;
	IsDefined(level.classtweaks[name])
			break;

		case "weapon":
			level.weapontweaks[name] = spawnstruct();
			level.weapontweaks[name].value = value;
			level.weapontweaks[name].lastvalue = value;
			level.weapontweaks[name].dvar = dvar;
			break;
	IsDefined(level.weapontweaks[name])
			break;

		case "killstreak":
			level.hardpointtweaks[name] = spawnstruct();
			level.hardpointtweaks[name].value = value;
			level.hardpointtweaks[name].lastvalue = value;
			level.hardpointtweaks[name].dvar = dvar;
			break;
	IsDefined(level.hardpointtweaks[name])
			break;

		case "hud":
			level.hudtweaks[name] = spawnstruct();
			level.hudtweaks[name].value = value;
			level.hudtweaks[name].lastvalue = value;
			level.hudtweaks[name].dvar = dvar;
			break;
	IsDefined(level.hudtweaks[name])
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
	registertweakable("game","arcadescoring","scr_game_arcadescoring",0);
	registertweakable("game","difficulty","scr_game_difficulty",1);
	registertweakable("game","pinups","scr_game_pinups",0);
	registertweakable("team","teamkillerplaylistbanquantum","scr_team_teamkillerplaylistbanquantum",0);
	registertweakable("team","teamkillerplaylistbanpenalty","scr_team_teamkillerplaylistbanpenalty",0);
	registertweakable("player","allowrevive","scr_player_allowrevive",1);
	registertweakable("weapon","allowfrag","scr_weapon_allowfrags",1);
	registertweakable("weapon","allowsmoke","scr_weapon_allowsmoke",1);
	registertweakable("weapon","allowflash","scr_weapon_allowflash",1);
	registertweakable("weapon","allowc4","scr_weapon_allowc4",1);
	registertweakable("weapon","allowsatchel","scr_weapon_allowsatchel",1);
	registertweakable("weapon","allowbetty","scr_weapon_allowbetty",1);
	registertweakable("weapon","allowrpgs","scr_weapon_allowrpgs",1);
	registertweakable("weapon","allowmines","scr_weapon_allowmines",1);
	registertweakable("hud","showobjicons","ui_hud_showobjicons",1);
	setclienttweakable("hud","showobjicons");
	registertweakable("killstreak","allowradar","scr_hardpoint_allowradar",1);
	registertweakable("killstreak","allowradardirection","scr_hardpoint_allowradardirection",1);
	registertweakable("killstreak","allowcounteruav","scr_hardpoint_allowcounteruav",1);
	registertweakable("killstreak","allowdogs","scr_hardpoint_allowdogs",1);
	registertweakable("killstreak","allowhelicopter_comlink","scr_hardpoint_allowhelicopter_comlink",1);
	registertweakable("killstreak","allowrcbomb","scr_hardpoint_allowrcbomb",1);
	registertweakable("killstreak","allowauto_turret","scr_hardpoint_allowauto_turret",1);
	level thread updateuitweakables();
}

//Function Number: 9
setclienttweakable(category,name)
{
	level.clienttweakables[level.clienttweakables.size] = name;
}

//Function Number: 10
updateuitweakables()
{
	for(;;)
	{
		for(index = 0;index < level.clienttweakables.size;index++)
		{
			clienttweakable = level.clienttweakables[index];
			curvalue = gettweakabledvarvalue("hud",clienttweakable);
			lastvalue = gettweakablelastvalue("hud",clienttweakable);
			if(curvalue != lastvalue)
			{
				updateserverdvar(gettweakabledvar("hud",clienttweakable),curvalue);
				settweakablelastvalue("hud",clienttweakable,curvalue);
			}
		}

		wait(1);
	}
}

//Function Number: 11
updateserverdvar(dvar,value)
{
	makedvarserverinfo(dvar,value);
}