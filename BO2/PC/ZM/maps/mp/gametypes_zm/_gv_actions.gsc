/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_gv_actions.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 71
 * Decompile Time: 101 ms
 * Timestamp: 10/27/2023 3:02:37 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_globallogic;
#include maps/mp/gametypes_zm/_globallogic_score;
#include maps/mp/gametypes_zm/_globallogic_ui;
#include maps/mp/gametypes_zm/_hud_util;

//Function Number: 1
initializeactionarray()
{
	level.gametypeactions = [];
	level.gametypeactions["GiveAmmo"] = ::dogiveammo;
	level.gametypeactions["RemoveAmmo"] = ::doremoveammo;
	level.gametypeactions["PlaySound"] = ::doplaysound;
	level.gametypeactions["EnableUAV"] = ::doenableuav;
	level.gametypeactions["GiveScore"] = ::dogivescore;
	level.gametypeactions["RemoveScore"] = ::doremovescore;
	level.gametypeactions["SetHeader"] = ::dosetheader;
	level.gametypeactions["SetSubHeader"] = ::dosetsubheader;
	level.gametypeactions["DisplayMessage"] = ::dodisplaymessage;
	level.gametypeactions["GiveHealth"] = ::dogivehealth;
	level.gametypeactions["RemoveHealth"] = ::doremovehealth;
	level.gametypeactions["SetHealthRegen"] = ::dosethealthregen;
	level.gametypeactions["ChangeClass"] = ::dochangeclass;
	level.gametypeactions["ChangeTeam"] = ::dochangeteam;
	level.gametypeactions["GivePerk"] = ::dogiveperk;
	level.gametypeactions["RemovePerk"] = ::doremoveperk;
	level.gametypeactions["GiveInvuln"] = ::dogiveinvuln;
	level.gametypeactions["RemoveInvuln"] = ::doremoveinvuln;
	level.gametypeactions["SetDamageModifier"] = ::dosetdamagemodifier;
	level.gametypeactions["GiveKillstreak"] = ::dogivekillstreak;
	level.gametypeactions["RemoveKillstreak"] = ::doremovekillstreak;
	level.gametypeactions["GiveLives"] = ::dogivelives;
	level.gametypeactions["RemoveLives"] = ::doremovelives;
	level.gametypeactions["ScaleMoveSpeed"] = ::doscalemovespeed;
	level.gametypeactions["ShowOnRadar"] = ::doshowonradar;
	level.conditionals = [];
	level.conditionals["Equals"] = ::equals;
	level.conditionals["=="] = ::equals;
	level.conditionals["!="] = ::notequals;
	level.conditionals["<"] = ::lessthan;
	level.conditionals["<="] = ::lessthanequals;
	level.conditionals[">"] = ::greaterthan;
	level.conditionals[">="] = ::greaterthanequals;
	level.conditionals["InPlace"] = ::inplace;
	level.conditionallefthandside = [];
	level.conditionallefthandside["PlayersLeft"] = ::playersleft;
	level.conditionallefthandside["RoundsPlayed"] = ::roundsplayed;
	level.conditionallefthandside["HitBy"] = ::hitby;
	level.conditionallefthandside["PlayersClass"] = ::playersclass;
	level.conditionallefthandside["VictimsClass"] = ::playersclass;
	level.conditionallefthandside["AttackersClass"] = ::attackersclass;
	level.conditionallefthandside["PlayersPlace"] = ::playersplace;
	level.conditionallefthandside["VictimsPlace"] = ::playersplace;
	level.conditionallefthandside["AttackersPlace"] = ::attackersplace;
	level.targets = [];
	level.targets["Everyone"] = ::gettargeteveryone;
	level.targets["PlayersLeft"] = ::gettargetplayersleft;
	level.targets["PlayersEliminated"] = ::gettargetplayerseliminated;
	level.targets["PlayersTeam"] = ::gettargetplayersteam;
	level.targets["VictimsTeam"] = ::gettargetplayersteam;
	level.targets["OtherTeam"] = ::gettargetotherteam;
	level.targets["AttackersTeam"] = ::gettargetotherteam;
	level.targets["PlayersLeftOnPlayersTeam"] = ::gettargetplayersleftonplayersteam;
	level.targets["PlayersLeftOnOtherTeam"] = ::gettargetplayersleftonotherteam;
	level.targets["PlayersLeftOnVictimsTeam"] = ::gettargetplayersleftonplayersteam;
	level.targets["PlayersLeftOnAttackersTeam"] = ::gettargetplayersleftonotherteam;
	level.targets["PlayersEliminatedOnPlayersTeam"] = ::gettargetplayerseliminatedonplayersteam;
	level.targets["PlayersEliminatedOnOtherTeam"] = ::gettargetplayerseliminatedonotherteam;
	level.targets["PlayersEliminatedOnVictimsTeam"] = ::gettargetplayerseliminatedonplayersteam;
	level.targets["PlayersEliminatedOnAttackersTeam"] = ::gettargetplayerseliminatedonotherteam;
	level.targets["AssistingPlayers"] = ::getassistingplayers;
}

//Function Number: 2
equals(param1,param2)
{
	return param1 == param2;
}

//Function Number: 3
notequals(param1,param2)
{
	return param1 != param2;
}

//Function Number: 4
lessthan(param1,param2)
{
	return param1 < param2;
}

//Function Number: 5
lessthanequals(param1,param2)
{
	return param1 <= param2;
}

//Function Number: 6
greaterthan(param1,param2)
{
	return param1 > param2;
}

//Function Number: 7
greaterthanequals(param1,param2)
{
	return param1 >= param2;
}

//Function Number: 8
inplace(param1,param2)
{
	if(param1 == param2)
	{
		return 1;
	}

	if(param2 == "top3" && param1 == "first")
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
playersleft(rule)
{
	return 0;
}

//Function Number: 10
roundsplayed(rule)
{
	return game["roundsplayed"] + 1;
}

//Function Number: 11
hitby(rule)
{
	meansofdeath = rule.target["MeansOfDeath"];
	weapon = rule.target["Weapon"];
	if(!IsDefined(meansofdeath) || !IsDefined(weapon))
	{
		return undefined;
	}

	switch(weapon)
	{
		case "knife_ballistic_mp":
			return "knife";
	}

	switch(meansofdeath)
	{
		case "MOD_PISTOL_BULLET":
		case "MOD_RIFLE_BULLET":
			return "bullet";

		case "MOD_BAYONET":
		case "MOD_MELEE":
			return "knife";

		case "MOD_HEAD_SHOT":
			return "headshot";

		case "MOD_EXPLOSIVE":
		case "MOD_GRENADE":
		case "MOD_GRENADE_SPLASH":
		case "MOD_PROJECTILE":
		case "MOD_PROJECTILE_SPLASH":
			return "explosive";
	}

	return undefined;
}

//Function Number: 12
getplayersclass(player)
{
	return player.pers["class"];
}

//Function Number: 13
playersclass(rule)
{
	player = rule.target["Player"];
	return getplayersclass(player);
}

//Function Number: 14
attackersclass(rule)
{
	player = rule.target["Attacker"];
	return getplayersclass(player);
}

//Function Number: 15
getplayersplace(player)
{
	maps/mp/gametypes_zm/_globallogic::updateplacement();
	if(!(IsDefined(level.placement["all"])))
	{
		return;
	}

	for(place = 0;place < level.placement["all"].size;place++)
	{
		if(level.placement["all"][place] == player)
		{
			break;
		}
	}

	place++;
	if(place == 1)
	{
		return "first";
	}
	else if(place <= 3)
	{
		return "top3";
	}
	else if(place == level.placement["all"].size)
	{
		return "last";
	}

	return "middle";
}

//Function Number: 16
playersplace(rule)
{
	player = rule.target["Player"];
	return getplayersplace(player);
}

//Function Number: 17
attackersplace(rule)
{
	player = rule.target["Attacker"];
	return getplayersplace(player);
}

//Function Number: 18
gettargeteveryone(rule)
{
	return level.players;
}

//Function Number: 19
gettargetplayersleft(rule)
{
	return 0;
}

//Function Number: 20
gettargetplayerseliminated(rule)
{
	return 0;
}

//Function Number: 21
gettargetplayersteam(rule)
{
	player = rule.target["Player"];
	if(!(IsDefined(player)))
	{
		return [];
	}

	return getplayersonteam(level.players,player.pers["team"]);
}

//Function Number: 22
gettargetotherteam(rule)
{
	player = rule.target["Player"];
	if(!(IsDefined(player)))
	{
		return [];
	}

	return getplayersonteam(level.players,getotherteam(player.pers["team"]));
}

//Function Number: 23
gettargetplayersleftonplayersteam(rule)
{
	return [];
}

//Function Number: 24
gettargetplayersleftonotherteam(rule)
{
	return [];
}

//Function Number: 25
gettargetplayerseliminatedonplayersteam(rule)
{
	return [];
}

//Function Number: 26
gettargetplayerseliminatedonotherteam(rule)
{
	return [];
}

//Function Number: 27
getassistingplayers(rule)
{
	assisters = [];
	attacker = rule.target["Attacker"];
	if(!IsDefined(rule.target["Assisters"]) || !IsDefined(attacker))
	{
		return assisters;
	}

	for(j = 0;j < rule.target["Assisters"].size;j++)
	{
		player = rule.target["Assisters"][j];
		if(!(IsDefined(player)))
		{
		}
		else if(player == attacker)
		{
		}
		else
		{
			assisters[assisters.size] = player;
		}
	}

	return assisters;
}

//Function Number: 28
executegametypeeventrule(rule)
{
	if(!(aregametypeeventruleconditionalsmet(rule)))
	{
		return;
	}

	if(!(IsDefined(level.gametypeactions[rule.action])))
	{
/#
		error("GAMETYPE VARIANTS - unknown action:  " + rule.action + "!");
#/
		return;
	}

	thread internalexecuterule(rule);
}

//Function Number: 29
internalexecuterule(rule)
{
}

//Function Number: 30
aregametypeeventruleconditionalsmet(rule)
{
	if(!IsDefined(rule.conditionals) || rule.conditionals.size == 0)
	{
		return 1;
	}

	combinedresult = 1;
	if(rule.conditionaleval == "OR")
	{
		combinedresult = 0;
	}

	for(i = 0;i < rule.conditionals.size;i++)
	{
		conditionalresult = evaluategametypeeventruleconditional(rule,rule.conditionals[i]);
		switch(rule.conditionaleval)
		{
			case "AND":
				combinedresult = combinedresult && conditionalresult;
				break;

			case "OR":
				combinedresult = combinedresult || conditionalresult;
				break;
		}

		if(rule.conditionaleval == "AND" && !combinedresult)
		{
			break;
		}

		if(rule.conditionaleval == "OR" && combinedresult)
		{
			break;
		}
	}

	return combinedresult;
}

//Function Number: 31
evaluategametypeeventruleconditional(rule,conditional)
{
	if(!IsDefined(conditional.lhs) || !IsDefined(conditional.operand) || !IsDefined(conditional.rhs))
	{
		return 0;
	}

	if(!(IsDefined(level.conditionallefthandside[conditional.lhs])))
	{
		return 0;
	}

	lhsvalue = [[ level.conditionallefthandside[conditional.lhs] ]](rule);
	if(!IsDefined(lhsvalue) || !IsDefined(level.conditionals[conditional.operand]))
	{
		return 0;
	}

	return [[ level.conditionals[conditional.operand] ]](lhsvalue,conditional.rhs);
}

//Function Number: 32
getplayersonteam(players,team)
{
	playersonteam = [];
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		if(player.pers["team"] == team)
		{
			playersonteam[playersonteam.size] = player;
		}
	}

	return playersonteam;
}

//Function Number: 33
gettargetsforgametypeeventrule(rule)
{
	targets = [];
	if(!(IsDefined(rule.targetname)))
	{
		return targets;
	}

	if(IsDefined(rule.target[rule.targetname]))
	{
		targets[targets.size] = rule.target[rule.targetname];
	}
	else if(IsDefined(level.targets[rule.targetname]))
	{
		targets = [[ level.targets[rule.targetname] ]](rule);
	}

	return targets;
}

//Function Number: 34
doesrulehavevalidparam(rule)
{
	return IsDefined(rule.params) && isarray(rule.params) && rule.params.size > 0;
}

//Function Number: 35
sortplayersbylivesdescending(players)
{
	if(!(IsDefined(players)))
	{
		return undefined;
	}

	swapped = 1;
	for(n = players.size;swapped;n--)
	{
		swapped = 0;
		for(i = 0;i < n - 1;i++)
		{
			if(players[i].pers["lives"] < players[i + 1].pers["lives"])
			{
				temp = players[i];
				players[i] = players[i + 1];
				players[i + 1] = temp;
				swapped = 1;
			}
		}
	}

	return players;
}

//Function Number: 36
giveammo(players,amount)
{
	for(i = 0;i < players.size;i++)
	{
		wait(0.5);
		player = players[i];
		currentweapon = player getcurrentweapon();
		clipammo = player getweaponammoclip(currentweapon);
		player setweaponammoclip(currentweapon,clipammo + amount);
	}
}

//Function Number: 37
dogiveammo(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	targets = gettargetsforgametypeeventrule(rule);
	giveammo(targets,rule.params[0]);
}

//Function Number: 38
doremoveammo(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	targets = gettargetsforgametypeeventrule(rule);
	giveammo(targets,0 - rule.params[0]);
}

//Function Number: 39
doplaysound(rule)
{
	if(doesrulehavevalidparam(rule))
	{
		playsoundonplayers(rule.params[0]);
	}
}

//Function Number: 40
doenableuav(rule)
{
	targets = gettargetsforgametypeeventrule(rule);
	for(targetindex = 0;targetindex < targets.size;targetindex++)
	{
		targets[targetindex].pers["hasRadar"] = 1;
		targets[targetindex].hasspyplane = 1;
	}
}

//Function Number: 41
givescore(players,amount)
{
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		score = maps/mp/gametypes_zm/_globallogic_score::_getplayerscore(player);
		maps/mp/gametypes_zm/_globallogic_score::_setplayerscore(player,score + amount);
	}
}

//Function Number: 42
dogivescore(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	targets = gettargetsforgametypeeventrule(rule);
	givescore(targets,rule.params[0]);
}

//Function Number: 43
doremovescore(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	targets = gettargetsforgametypeeventrule(rule);
	givescore(targets,0 - rule.params[0]);
}

//Function Number: 44
dosetheader(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	targets = gettargetsforgametypeeventrule(rule);
	for(targetindex = 0;targetindex < targets.size;targetindex++)
	{
		target = targets[targetindex];
		displaytextonhudelem(target,target.customgametypeheader,rule.params[0],rule.params[1],"gv_header",rule.params[2]);
	}
}

//Function Number: 45
dosetsubheader(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	targets = gettargetsforgametypeeventrule(rule);
	for(targetindex = 0;targetindex < targets.size;targetindex++)
	{
		target = targets[targetindex];
		displaytextonhudelem(target,target.customgametypesubheader,rule.params[0],rule.params[1],"gv_subheader",rule.params[2]);
	}
}

//Function Number: 46
displaytextonhudelem(target,texthudelem,text,secondstodisplay,notifyname,valueparam)
{
	texthudelem.alpha = 1;
	if(IsDefined(valueparam))
	{
		texthudelem settext(text,valueparam);
	}
	else
	{
		texthudelem settext(text);
	}

	if(!IsDefined(secondstodisplay) || secondstodisplay <= 0)
	{
		target.doingnotify = 0;
		target notify(notifyname);
		return;
	}

	target thread fadecustomgametypehudelem(texthudelem,secondstodisplay,notifyname);
}

//Function Number: 47
fadecustomgametypehudelem(hudelem,seconds,notifyname)
{
	self endon("disconnect");
	self notify(notifyname);
	self endon(notifyname);
	if(seconds <= 0)
	{
		return;
	}

	self.doingnotify = 1;
	wait(seconds);
	while(hudelem.alpha > 0)
	{
		hudelem.alpha = hudelem.alpha - 0.05;
		if(hudelem.alpha < 0)
		{
			hudelem.alpha = 0;
		}

		wait(0.05);
	}

	self.doingnotify = 0;
}

//Function Number: 48
dodisplaymessage(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	targets = gettargetsforgametypeeventrule(rule);
	for(targetindex = 0;targetindex < targets.size;targetindex++)
	{
		thread announcemessage(targets[targetindex],rule.params[0],2);
	}
}

//Function Number: 49
announcemessage(target,messagetext,time)
{
	target endon("disconnect");
	clientannouncement(target,messagetext,int(time * 1000));
	if(time == 0)
	{
		time = GetDvarFloat(#"E8C4FC20");
	}

	target.doingnotify = 1;
	wait(time);
	target.doingnotify = 0;
}

//Function Number: 50
givehealth(players,amount)
{
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		player.health = player.health + amount;
	}
}

//Function Number: 51
dogivehealth(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	givehealth(gettargetsforgametypeeventrule(rule),rule.params[0]);
}

//Function Number: 52
doremovehealth(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	givehealth(gettargetsforgametypeeventrule(rule),0 - rule.params[0]);
}

//Function Number: 53
dosethealthregen(rule)
{
	targets = gettargetsforgametypeeventrule(rule);
	for(targetindex = 0;targetindex < targets.size;targetindex++)
	{
		player = targets[targetindex];
		player.regenrate = rule.params[0];
	}
}

//Function Number: 54
dochangeclass(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
	}
}

//Function Number: 55
dochangeteam(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	team = rule.params[0];
	teamkeys = getarraykeys(level.teams);
	targets = gettargetsforgametypeeventrule(rule);
	for(targetindex = 0;targetindex < targets.size;targetindex++)
	{
		target = targets[targetindex];
		if(target.pers["team"] == team)
		{
		}
		else
		{
			if(team == "toggle")
			{
				team = teamkeys[randomint(teamkeys.size)];
				for(teamindex = 0;teamindex < teamkeys.size;teamindex++)
				{
					if(target.pers["team"] == teamkeys[teamindex])
					{
						team = teamkeys[teamindex + 1 % teamkeys.size];
						break;
					}
				}
			}

			target.pers["team"] = team;
			target.team = team;
			if(level.teambased)
			{
				target.sessionteam = team;
			}
			else
			{
				target.sessionteam = "none";
			}

			target notify("joined_team");
			level notify("joined_team");
		}
	}
}

//Function Number: 56
displayperk(player,imagename)
{
	index = 0;
	if(IsDefined(player.perkicon))
	{
		index = -1;
		for(i = 0;i < player.perkicon.size;i++)
		{
			if(player.perkicon[i].alpha == 0)
			{
				index = i;
				break;
			}
		}

		if(index == -1)
		{
			return;
		}
	}

	player maps/mp/gametypes_zm/_hud_util::showperk(index,imagename,10);
	player thread maps/mp/gametypes_zm/_globallogic_ui::hideloadoutaftertime(3);
	player thread maps/mp/gametypes_zm/_globallogic_ui::hideloadoutondeath();
}

//Function Number: 57
setorunsetperk(players,perks,shouldset)
{
	if(level.perksenabled == 0)
	{
		return;
	}

	if(perks.size < 2)
	{
		return;
	}

	hasperkalready = 0;
	imagename = perks[perks.size - 1];
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		for(perkindex = 0;perkindex < perks.size - 1;perkindex++)
		{
			perk = perks[perkindex];
			if(player hasperk(perk))
			{
				hasperkalready = 1;
			}

			if(shouldset)
			{
				player setperk(perk);
			}
			else
			{
				player unsetperk(perk);
			}
		}

		if(shouldset && !hasperkalready && GetDvarInt(#"BB4CAD78") == 1)
		{
			displayperk(player,imagename);
		}
	}
}

//Function Number: 58
dogiveperk(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	setorunsetperk(gettargetsforgametypeeventrule(rule),rule.params,1);
}

//Function Number: 59
doremoveperk(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	setorunsetperk(gettargetsforgametypeeventrule(rule),rule.params,0);
}

//Function Number: 60
giveorremovekillstreak(rule,shouldgive)
{
}

//Function Number: 61
dogivekillstreak(rule)
{
	giveorremovekillstreak(rule,1);
}

//Function Number: 62
doremovekillstreak(rule)
{
	giveorremovekillstreak(rule,0);
}

//Function Number: 63
givelives(players,amount)
{
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		player.pers["lives"] = player.pers["lives"] + amount;
		if(player.pers["lives"] < 0)
		{
			player.pers["lives"] = 0;
		}
	}
}

//Function Number: 64
dogivelives(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	givelives(gettargetsforgametypeeventrule(rule),rule.params[0]);
}

//Function Number: 65
doremovelives(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	givelives(gettargetsforgametypeeventrule(rule),0 - rule.params[0]);
}

//Function Number: 66
giveorremoveinvuln(players,shouldgiveinvuln)
{
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
	}
}

//Function Number: 67
dogiveinvuln(rule)
{
	giveorremoveinvuln(gettargetsforgametypeeventrule(rule),1);
}

//Function Number: 68
doremoveinvuln(rule)
{
	giveorremoveinvuln(gettargetsforgametypeeventrule(rule),0);
}

//Function Number: 69
dosetdamagemodifier(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	players = gettargetsforgametypeeventrule(rule);
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		player.damagemodifier = rule.params[0];
	}
}

//Function Number: 70
doscalemovespeed(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	movespeedscale = rule.params[0];
	targets = gettargetsforgametypeeventrule(rule);
	for(targetindex = 0;targetindex < targets.size;targetindex++)
	{
		target = targets[targetindex];
		target.movementspeedmodifier = movespeedscale * target getmovespeedscale();
		if(target.movementspeedmodifier < 0.1)
		{
			target.movementspeedmodifier = 0.1;
		}
		else if(target.movementspeedmodifier > 4)
		{
			target.movementspeedmodifier = 4;
		}

		target setmovespeedscale(target.movementspeedmodifier);
	}
}

//Function Number: 71
doshowonradar(rule)
{
	if(!(doesrulehavevalidparam(rule)))
	{
		return;
	}

	targets = gettargetsforgametypeeventrule(rule);
	for(targetindex = 0;targetindex < targets.size;targetindex++)
	{
		if(rule.params[0] == "enable")
		{
			targets[targetindex] setperk("specialty_showonradar");
		}
		else
		{
			targets[targetindex] unsetperk("specialty_showonradar");
		}
	}
}