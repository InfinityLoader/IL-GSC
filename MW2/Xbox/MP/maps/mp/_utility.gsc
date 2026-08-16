/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_utility.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

exploder_sound()
{
	if(isdefined(self.script_delay))
	{
		wait self.script_delay;
	}

	self playsound(level.scr_sound[self.script_sound]);
}

delaythread(timer, func, param1, param2, param3, param4, param5)
{
	thread delaythread_proc(func, timer, param1, param2, param3, param4, param5);
}

delaythread_proc(func, timer, param1, param2, param3, param4, param5)
{
	wait timer;
	if(!isdefined(param1))
	{
		thread [[ func ]]();
		return;
	}

	if(!isdefined(param2))
	{
		thread [[ func ]](param1);
		return;
	}

	if(!isdefined(param3))
	{
		thread [[ func ]](param1, param2);
		return;
	}

	if(!isdefined(param4))
	{
		thread [[ func ]](param1, param2, param3);
		return;
	}

	if(!isdefined(param5))
	{
		thread [[ func ]](param1, param2, param3, param4);
		return;
	}

	thread [[ func ]](param1, param2, param3, param4, param5);
}

getplant()
{
	start = self.origin + (0,0,10);
	range = 11;
	forward = anglestoforward(self.angles);
	forward = common_scripts\utility::vector_multiply(forward, range);
	traceorigins[0] = start + forward;
	traceorigins[1] = start;
	trace = bullettrace(traceorigins[0], traceorigins[0] + (0,0,-18), 0, undefined);
	if(trace["fraction"] < 1)
	{
		temp = spawnstruct();
		temp.origin = trace["position"];
		temp.angles = orienttonormal(trace["normal"]);
		return temp;
	}

	trace = bullettrace(traceorigins[1], traceorigins[1] + (0,0,-18), 0, undefined);
	if(trace["fraction"] < 1)
	{
		temp = spawnstruct();
		temp.origin = trace["position"];
		temp.angles = orienttonormal(trace["normal"]);
		return temp;
	}

	traceorigins[2] = start + (16,16,0);
	traceorigins[3] = start + (16,-16,0);
	traceorigins[4] = start + (-16,-16,0);
	traceorigins[5] = start + (-16,16,0);
	besttracefraction = undefined;
	besttraceposition = undefined;
	for(i = 0;i < traceorigins.size;i++)
	{
		trace = bullettrace(traceorigins[i], traceorigins[i] + (0,0,-1000), 0, undefined);
		if(!isdefined(besttracefraction) || trace["fraction"] < besttracefraction)
		{
			besttracefraction = trace["fraction"];
			besttraceposition = trace["position"];
		}
	}

	if(besttracefraction == 1)
	{
		besttraceposition = self.origin;
	}

	temp = spawnstruct();
	temp.origin = besttraceposition;
	temp.angles = orienttonormal(trace["normal"]);
	return temp;
}

orienttonormal(normal)
{
	hor_normal = (normal[0],normal[1],0);
	hor_length = length(hor_normal);
	if(!hor_length)
	{
		return (0,0,0);
	}

	hor_dir = vectornormalize(hor_normal);
	neg_height = normal[2] * -1;
	tangent = (hor_dir[0] * neg_height,hor_dir[1] * neg_height,hor_length);
	plant_angle = vectortoangles(tangent);
	return plant_angle;
}

deleteplacedentity(entity)
{
	entities = getentarray(entity, "classname");
	for(i = 0;i < entities.size;i++)
	{
		entities[i] delete();
	}
}

playsoundonplayers(sound, team, excludelist)
{
	if(level.splitscreen)
	{
		if(isdefined(level.players[0]))
		{
			level.players[0] playlocalsound(sound);
			return;
		}

		return;
	}

	if(isdefined(team))
	{
		if(isdefined(excludelist))
		{
			for(i = 0;i < level.players.size;i++)
			{
				player = level.players[i];
				if(isdefined(player.pers["team"]) && player.pers["team"] == team && !isexcluded(player, excludelist))
				{
					player playlocalsound(sound);
				}
			}

			return;
		}

		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			if(isdefined(player.pers["team"]) && player.pers["team"] == team)
			{
				player playlocalsound(sound);
			}
		}

		return;
	}

	if(isdefined(player))
	{
		for(i = 0;i < level.players.size;i++)
		{
			if(!isexcluded(level.players[i], excludelist))
			{
				level.players[i] playlocalsound(sound);
			}
		}

		return;
	}

	for(i = 0;i < level.players.size;i++)
	{
		level.players[i] playlocalsound(sound);
	}
}

sortlowermessages()
{
	for(i = 1;i < self.lowermessages.size;i++)
	{
		message = self.lowermessages[i];
		priority = message.priority;
		for(j = i - 1;j >= 0 && priority > self.lowermessages[j].priority;j--)
		{
			self.lowermessages[j + 1] = self.lowermessages[j];
		}

		self.lowermessages[j + 1] = message;
	}
}

addlowermessage(name, text, time, priority)
{
	newmessage = undefined;
	foreach(message in self.lowermessages)
	{
		if(message.name == name)
		{
			if(message.text == text && message.priority == priority)
			{
				return;
			}

			newmessage = message;
			break;
		}
	}

	if(!isdefined(newmessage))
	{
		newmessage = spawnstruct();
		self.lowermessages[self.lowermessages.size] = newmessage;
	}

	newmessage.name = name;
	newmessage.text = text;
	newmessage.time = time;
	newmessage.addtime = gettime();
	newmessage.priority = priority;
	sortlowermessages();
}

removelowermessage(name)
{
	for(i = 0;i < self.lowermessages.size;i++)
	{
		if(self.lowermessages[i].name != name)
		{
			continue;
		}

		message = self.lowermessages[i];
		if(i < self.lowermessages.size - 1)
		{
			self.lowermessages[i] = self.lowermessages[self.lowermessages.size - 1];
		}

		self.lowermessages[self.lowermessages.size - 1] = undefined;
	}

	sortlowermessages();
}

getlowermessage()
{
	return self.lowermessages[0];
}

setlowermessage(name, text, time, priority)
{
	if(!isdefined(priority))
	{
		priority = 1;
	}

	if(!isdefined(time))
	{
		time = 0;
	}

	addlowermessage(name, text, time, priority);
	updatelowermessage();
}

updatelowermessage()
{
	message = getlowermessage();
	if(!isdefined(message))
	{
		self.lowermessage.alpha = 0;
		self.lowertimer.alpha = 0;
		return;
	}

	self.lowermessage settext(message.text);
	if(isdefined(message.time) && message.time > 0)
	{
		self.lowertimer settimer(max(message.time - gettime() - message.addtime / 1000, 0.1));
	}
	else
	{
		self.lowertimer settext("");
	}

	self.lowermessage.alpha = 0.85;
	self.lowertimer.alpha = 1;
}

clearlowermessage(name, fadetime)
{
	removelowermessage(name);
	updatelowermessage();
}

clearlowermessages()
{
	for(i = 0;i < self.lowermessages.size;i++)
	{
		self.lowermessages[i] = undefined;
	}

	if(!isdefined(self.lowermessage))
	{
		return;
	}

	updatelowermessage();
}

printonteam(printstring, team)
{
	foreach(player in level.players)
	{
		if(player.team != team)
		{
			continue;
		}

		player iprintln(printstring);
	}
}

printboldonteam(text, team)
{
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(isdefined(player.pers["team"]) && player.pers["team"] == team)
		{
			player iprintlnbold(text);
		}
	}
}

printboldonteamarg(text, team, arg)
{
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(isdefined(player.pers["team"]) && player.pers["team"] == team)
		{
			player iprintlnbold(text, arg);
		}
	}
}

printonteamarg(text, team, arg)
{
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(isdefined(player.pers["team"]) && player.pers["team"] == team)
		{
			player iprintln(text, arg);
		}
	}
}

printonplayers(text, team)
{
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		if(isdefined(team))
		{
			if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == team)
			{
				players[i] iprintln(text);
			}

			continue;
		}

		players[i] iprintln(text);
	}
}

printandsoundoneveryone(team, otherteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg)
{
	shoulddosounds = isdefined(soundfriendly);
	shoulddoenemysounds = 0;
	if(isdefined(soundenemy))
	{
		shoulddoenemysounds = 1;
	}

	if(level.splitscreen || !shoulddosounds)
	{
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			playerteam = player.pers["team"];
			if(isdefined(playerteam))
			{
				if(playerteam == team && isdefined(printfriendly))
				{
					player iprintln(printfriendly, printarg);
					continue;
				}

				if(playerteam == otherteam && isdefined(printenemy))
				{
					player iprintln(printenemy, printarg);
				}
			}
		}

		if(shoulddosounds)
		{
			level.players[0] playlocalsound(soundfriendly);
			return;
		}

		return;
	}

	if(playerteam)
	{
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			playerteam = player.pers["team"];
			if(isdefined(playerteam))
			{
				if(playerteam == team)
				{
					if(isdefined(printfriendly))
					{
						player iprintln(printfriendly, printarg);
					}

					player playlocalsound(soundfriendly);
					continue;
				}

				if(playerteam == otherteam)
				{
					if(isdefined(printenemy))
					{
						player iprintln(printenemy, printarg);
					}

					player playlocalsound(soundenemy);
				}
			}
		}

		return;
	}

	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		playerteam = player.pers["team"];
		if(isdefined(playerteam))
		{
			if(playerteam == team)
			{
				if(isdefined(printfriendly))
				{
					player iprintln(printfriendly, printarg);
				}

				player playlocalsound(soundfriendly);
				continue;
			}

			if(playerteam == otherteam)
			{
				if(isdefined(printenemy))
				{
					player iprintln(printenemy, printarg);
				}
			}
		}
	}
}

printandsoundonteam(team, printstring, soundalias)
{
	foreach(player in level.players)
	{
		if(player.team != team)
		{
			continue;
		}

		player printandsoundonplayer(printstring, soundalias);
	}
}

printandsoundonplayer(printstring, soundalias)
{
	self iprintln(printstring);
	self playlocalsound(soundalias);
}

_playlocalsound(soundalias)
{
	if(level.splitscreen && self getentitynumber() != 0)
	{
		return;
	}

	self playlocalsound(soundalias);
}

dvarintvalue(dvar, defval, minval, maxval)
{
	dvar = "scr_" + level.gametype + "_" + dvar;
	if(getdvar(dvar) == "")
	{
		setdvar(dvar, defval);
		return defval;
	}

	value = getdvarint(dvar);
	if(value > maxval)
	{
		value = maxval;
	}
	else if(value < minval)
	{
		value = minval;
	}
	else
	{
		return value;
	}

	setdvar(dvar, value);
	return value;
}

dvarfloatvalue(dvar, defval, minval, maxval)
{
	dvar = "scr_" + level.gametype + "_" + dvar;
	if(getdvar(dvar) == "")
	{
		setdvar(dvar, defval);
		return defval;
	}

	value = getdvarfloat(dvar);
	if(value > maxval)
	{
		value = maxval;
	}
	else if(value < minval)
	{
		value = minval;
	}
	else
	{
		return value;
	}

	setdvar(dvar, value);
	return value;
}

play_sound_on_tag(alias, tag)
{
	if(isdefined(tag))
	{
		playsoundatpos(self gettagorigin(tag), alias);
		return;
	}

	playsoundatpos(self.origin, alias);
}

getotherteam(team)
{
	if(team == "allies")
	{
		return "axis";
	}
	else if(team == "axis")
	{
		return "allies";
	}
}

wait_endon(waittime, endonstring, endonstring2, endonstring3)
{
	self endon(endonstring);
	if(isdefined(endonstring2))
	{
		self endon(endonstring2);
	}

	if(isdefined(endonstring3))
	{
		self endon(endonstring3);
	}

	wait waittime;
}

ismg(weapon)
{
	return issubstr(weapon, "_bipod_") || weapon == "turret_minigun_mp";
}

initpersstat(dataname)
{
	if(!isdefined(self.pers[dataname]))
	{
		self.pers[dataname] = 0;
		return;
	}
}

getpersstat(dataname)
{
	return self.pers[dataname];
}

incpersstat(dataname, increment)
{
	self.pers[dataname] = self.pers[dataname] + increment;
	maps\mp\gametypes\_persistence::statadd(dataname, increment);
}

setpersstat(dataname, value)
{
	self.pers[dataname] = value;
}

initplayerstat(ref, defaultvalue)
{
	if(!isdefined(self.stats["stats_" + ref]))
	{
		if(!isdefined(defaultvalue))
		{
			defaultvalue = 0;
		}

		self.stats["stats_" + ref] = spawnstruct();
		self.stats["stats_" + ref].value = defaultvalue;
		return;
	}
}

incplayerstat(ref, increment)
{
	stat = self.stats["stats_" + ref];
	stat.value = stat.value + increment;
}

setplayerstat(ref, value)
{
	stat = self.stats["stats_" + ref];
	stat.value = value;
	stat.time = gettime();
}

getplayerstat(ref)
{
	return self.stats["stats_" + ref].value;
}

getplayerstattime(ref)
{
	return self.stats["stats_" + ref].time;
}

setplayerstatifgreater(ref, newvalue)
{
	currentvalue = getplayerstat(ref);
	if(newvalue > currentvalue)
	{
		setplayerstat(ref, newvalue);
		return;
	}
}

setplayerstatiflower(ref, newvalue)
{
	currentvalue = getplayerstat(ref);
	if(newvalue < currentvalue)
	{
		setplayerstat(ref, newvalue);
		return;
	}
}

updatepersratio(ratio, num, param_64)
{
	numvalue = maps\mp\gametypes\_persistence::statget(num);
	denomvalue = maps\mp\gametypes\_persistence::statget(param_64);
	if(denomvalue == 0)
	{
		denomvalue = 1;
	}

	maps\mp\gametypes\_persistence::statset(ratio, int(numvalue * 1000 / denomvalue));
}

updatepersratiobuffered(ratio, num, param_64)
{
	numvalue = maps\mp\gametypes\_persistence::statgetbuffered(num);
	denomvalue = maps\mp\gametypes\_persistence::statgetbuffered(param_64);
	if(denomvalue == 0)
	{
		denomvalue = 1;
	}

	maps\mp\gametypes\_persistence::statsetbuffered(ratio, int(numvalue * 1000 / denomvalue));
}

waittillslowprocessallowed(allowloop)
{
	if(level.lastslowprocessframe == gettime())
	{
		if(isdefined(allowloop) && allowloop)
		{
			while(level.lastslowprocessframe == gettime())
			{
				wait 0.05;
			}
		}
		else
		{
			wait 0.05;
			if(level.lastslowprocessframe == gettime())
			{
				wait 0.05;
				if(level.lastslowprocessframe == gettime())
				{
					wait 0.05;
					if(level.lastslowprocessframe == gettime())
					{
						wait 0.05;
					}
				}
			}
		}
	}

	level.lastslowprocessframe = gettime();
}

waitfortimeornotify(time, param_69)
{
	self endon(param_69);
	wait time;
}

isexcluded(entity, entitylist)
{
	for(index = 0;index < entitylist.size;index++)
	{
		if(entity == entitylist[index])
		{
			return 1;
		}
	}

	return 0;
}

leaderdialog(dialog, team, group, excludelist)
{
	if(level.splitscreen)
	{
		return;
	}

	if(dialog == "null")
	{
		return;
	}

	if(!isdefined(team))
	{
		leaderdialogbothteams(dialog, "allies", dialog, "axis", group, excludelist);
		return;
	}

	if(level.splitscreen)
	{
		if(level.players.size)
		{
			level.players[0] leaderdialogonplayer(dialog, group);
		}

		return;
	}

	if(isdefined(excludelist))
	{
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			if(isdefined(player.pers["team"]) && player.pers["team"] == team && !isexcluded(player, excludelist))
			{
				player leaderdialogonplayer(dialog, group);
			}
		}

		return;
	}

	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(isdefined(player.pers["team"]) && player.pers["team"] == team)
		{
			player leaderdialogonplayer(dialog, group);
		}
	}
}

leaderdialogbothteams(dialog1, team1, dialog2, team2, group, excludelist)
{
	if(level.splitscreen)
	{
		return;
	}

	if(level.splitscreen)
	{
		if(level.players.size)
		{
			level.players[0] leaderdialogonplayer(dialog1, group);
		}

		return;
	}

	if(isdefined(excludelist))
	{
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			team = player.pers["team"];
			if(!isdefined(team))
			{
				continue;
			}

			if(isexcluded(player, excludelist))
			{
				continue;
			}

			if(team == team1)
			{
				player leaderdialogonplayer(dialog1, group);
				continue;
			}

			if(team == team2)
			{
				player leaderdialogonplayer(dialog2, group);
			}
		}

		return;
	}

	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		team = player.pers["team"];
		if(!isdefined(team))
		{
			continue;
		}

		if(team == team1)
		{
			player leaderdialogonplayer(dialog1, group);
			continue;
		}

		if(team == team2)
		{
			player leaderdialogonplayer(dialog2, group);
		}
	}
}

leaderdialogonplayers(dialog, players, group)
{
	foreach(player in players)
	{
		player leaderdialogonplayer(dialog, group);
	}
}

leaderdialogonplayer(dialog, group, groupoverride)
{
	if(!isdefined(groupoverride))
	{
		groupoverride = 0;
	}

	team = self.pers["team"];
	if(level.splitscreen)
	{
		return;
	}

	if(!isdefined(team))
	{
		return;
	}

	if(team != "allies" && team != "axis")
	{
		return;
	}

	if(isdefined(group))
	{
		if(self.leaderdialoggroup == group)
		{
			if(groupoverride)
			{
				self stoplocalsound(self.leaderdialogactive);
				thread playleaderdialogonplayer(dialog, team);
			}

			return;
		}

		hadgroupdialog = isdefined(self.leaderdialoggroups[group]);
		self.leaderdialoggroups[group] = dialog;
		dialog = group;
		if(hadgroupdialog)
		{
			return;
		}
	}

	if(self.leaderdialogactive == "")
	{
		thread playleaderdialogonplayer(dialog, team);
		return;
	}

	self.leaderdialogqueue[self.leaderdialogqueue.size] = dialog;
}

playleaderdialogonplayer(dialog, team)
{
	self endon("disconnect");
	self notify("playLeaderDialogOnPlayer");
	self endon("playLeaderDialogOnPlayer");
	if(isdefined(self.leaderdialoggroups[dialog]))
	{
		group = dialog;
		dialog = self.leaderdialoggroups[group];
		self.leaderdialoggroups[group] = undefined;
		self.leaderdialoggroup = group;
	}

	if(issubstr(game["dialog"][dialog], "null"))
	{
		return;
	}

	self.leaderdialogactive = game["voice"][team] + game["dialog"][dialog];
	self playlocalsound(game["voice"][team] + game["dialog"][dialog]);
	wait 3;
	self.leaderdialoglocalsound = "";
	self.leaderdialogactive = "";
	self.leaderdialoggroup = "";
	if(self.leaderdialogqueue.size > 0)
	{
		nextdialog = self.leaderdialogqueue[0];
		for(i = 1;i < self.leaderdialogqueue.size;i++)
		{
			self.leaderdialogqueue[i - 1] = self.leaderdialogqueue[i];
		}

		self.leaderdialogqueue[i - 1] = undefined;
		thread playleaderdialogonplayer(nextdialog, team);
		return;
	}
}

updatemainmenu()
{
	if(self.pers["team"] == "spectator")
	{
		self setclientdvar("g_scriptMainMenu", game["menu_team"]);
		return;
	}

	self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
}

updateobjectivetext()
{
	if(self.pers["team"] == "spectator")
	{
		self setclientdvar("cg_objectiveText", "");
		return;
	}

	if(getwatcheddvar("scorelimit") > 0 && !isobjectivebased())
	{
		if(level.splitscreen)
		{
			self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]));
			return;
		}

		self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]), getwatcheddvar("scorelimit"));
		return;
	}

	self setclientdvar("cg_objectiveText", getobjectivetext(self.pers["team"]));
}

setobjectivetext(team, text)
{
	game["strings"]["objective_" + team] = text;
	precachestring(text);
}

setobjectivescoretext(team, text)
{
	game["strings"]["objective_score_" + team] = text;
	precachestring(text);
}

setobjectivehinttext(team, text)
{
	game["strings"]["objective_hint_" + team] = text;
	precachestring(text);
}

getobjectivetext(team)
{
	return game["strings"]["objective_" + team];
}

getobjectivescoretext(team)
{
	return game["strings"]["objective_score_" + team];
}

getobjectivehinttext(team)
{
	return game["strings"]["objective_hint_" + team];
}

gettimepassed()
{
	if(!isdefined(level.starttime))
	{
		return 0;
	}

	if(level.timerstopped)
	{
		return level.timerpausetime - level.starttime - level.discardtime;
	}

	return gettime() - level.starttime - level.discardtime;
}

getsecondspassed()
{
	return gettimepassed() / 1000;
}

getminutespassed()
{
	return getsecondspassed() / 60;
}

clearkillcamstate()
{
	self.forcespectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
}

isinkillcam()
{
	return self.forcespectatorclient != -1 || self.killcamentity != -1;
}

isvalidclass(class)
{
	return isdefined(class) && class != "";
}

getvalueinrange(value, minvalue, maxvalue)
{
	if(value > maxvalue)
	{
		return maxvalue;
	}

	if(value < minvalue)
	{
		return minvalue;
	}

	return value;
}

waitfortimeornotifies(desireddelay)
{
	startedwaiting = gettime();
	waitedtime = gettime() - startedwaiting / 1000;
	if(waitedtime < desireddelay)
	{
		wait desireddelay - waitedtime;
		return desireddelay;
	}

	return waitedtime;
}

closemenus()
{
	self closepopupmenu();
	self closeingamemenu();
}

logxpgains()
{
	if(!isdefined(self.xpgains))
	{
		return;
	}

	xptypes = getarraykeys(self.xpgains);
	for(index = 0;index < xptypes.size;index++)
	{
		gain = self.xpgains[xptypes[index]];
		if(!gain)
		{
			continue;
		}

		self logstring("xp " + xptypes[index] + ": " + gain);
	}
}

registerroundswitchdvar(dvarstring, defaultvalue, minvalue, maxvalue)
{
	registerwatchdvarint("roundswitch", defaultvalue);
	dvarstring = "scr_" + dvarstring + "_roundswitch";
	level.roundswitchdvar = dvarstring;
	level.roundswitchmin = minvalue;
	level.roundswitchmax = maxvalue;
	level.roundswitch = getdvarint(dvarstring, defaultvalue);
	if(level.roundswitch < minvalue)
	{
		level.roundswitch = minvalue;
		return;
	}

	if(level.roundswitch > maxvalue)
	{
		level.roundswitch = maxvalue;
		return;
	}
}

registerroundlimitdvar(dvarstring, defaultvalue, minvalue, maxvalue)
{
	registerwatchdvarint("roundlimit", defaultvalue);
}

registerwinlimitdvar(dvarstring, defaultvalue, minvalue, maxvalue)
{
	registerwatchdvarint("winlimit", defaultvalue);
}

registerscorelimitdvar(dvarstring, defaultvalue, minvalue, maxvalue)
{
	registerwatchdvarint("scorelimit", defaultvalue);
}

registertimelimitdvar(dvarstring, defaultvalue, minvalue, maxvalue)
{
	registerwatchdvarfloat("timelimit", defaultvalue);
	makedvarserverinfo("ui_timelimit", gettimelimit());
}

registerhalftimedvar(dvarstring, defaultvalue, minvalue, maxvalue)
{
	registerwatchdvarint("halftime", defaultvalue);
	makedvarserverinfo("ui_halftime", gethalftime());
}

registernumlivesdvar(dvarstring, defaultvalue, minvalue, maxvalue)
{
	registerwatchdvarint("numlives", defaultvalue);
}

setovertimelimitdvar(value)
{
	makedvarserverinfo("overtimeTimeLimit", value);
}

get_damageable_player(player, playerpos)
{
	newent = spawnstruct();
	newent.isplayer = 1;
	newent.isadestructable = 0;
	newent.entity = player;
	newent.damagecenter = playerpos;
	return newent;
}

get_damageable_sentry(sentry, param_98)
{
	newent = spawnstruct();
	newent.isplayer = 0;
	newent.isadestructable = 0;
	newent.issentry = 1;
	newent.entity = sentry;
	newent.damagecenter = param_98;
	return newent;
}

get_damageable_grenade(grenade, entpos)
{
	newent = spawnstruct();
	newent.isplayer = 0;
	newent.isadestructable = 0;
	newent.entity = grenade;
	newent.damagecenter = entpos;
	return newent;
}

get_damageable_player_pos(player)
{
	return player.origin + (0,0,32);
}

get_damageable_grenade_pos(grenade)
{
	return grenade.origin;
}

getdvarvec(dvarname)
{
	dvarstring = getdvar(dvarname);
	if(dvarstring == "")
	{
		return (0,0,0);
	}

	dvartokens = strtok(dvarstring, " ");
	if(dvartokens.size < 3)
	{
		return (0,0,0);
	}

	setdvar("tempR", dvartokens[0]);
	setdvar("tempG", dvartokens[1]);
	setdvar("tempB", dvartokens[2]);
	return (getdvarfloat("tempR"),getdvarfloat("tempG"),getdvarfloat("tempB"));
}

strip_suffix(lookupstring, stripstring)
{
	if(lookupstring.size <= stripstring.size)
	{
		return lookupstring;
	}

	if(getsubstr(lookupstring, lookupstring.size - stripstring.size, lookupstring.size) == stripstring)
	{
		return getsubstr(lookupstring, 0, lookupstring.size - stripstring.size);
	}

	return lookupstring;
}

_takeweaponsexcept(saveweapon)
{
	weaponslist = self getweaponslistall();
	foreach(weapon in weaponslist)
	{
		if(weapon == saveweapon)
		{
			continue;
		}
		else
		{
			self takeweapon(weapon);
		}
	}
}

savedata()
{
	savedata = spawnstruct();
	savedata.offhandclass = self getoffhandsecondaryclass();
	savedata.actionslots = self.saved_actionslotdata;
	savedata.currentweapon = self getcurrentweapon();
	weaponslist = self getweaponslistall();
	savedata.weapons = [];
	foreach(weapon in weaponslist)
	{
		if(weaponinventorytype(weapon) == "exclusive")
		{
			continue;
		}

		if(weaponinventorytype(weapon) == "altmode")
		{
			continue;
		}

		saveweapon = spawnstruct();
		saveweapon.name = weapon;
		saveweapon.clipammor = self getweaponammoclip(weapon, "right");
		saveweapon.clipammol = self getweaponammoclip(weapon, "left");
		saveweapon.stockammo = self getweaponammostock(weapon);
		if(isdefined(self.throwinggrenade) && self.throwinggrenade == weapon)
		{
			saveweapon.stockammo--;
		}

		savedata.weapons[savedata.weapons.size] = saveweapon;
	}

	self.script_savedata = savedata;
}

restoredata()
{
	savedata = self.script_savedata;
	self setoffhandsecondaryclass(savedata.offhandclass);
	foreach(weapon in savedata.weapons)
	{
		_giveweapon(weapon.name, int(tablelookup("mp/camoTable.csv", 1, self.loadoutprimarycamo, 0)));
		self setweaponammoclip(weapon.name, weapon.clipammor, "right");
		if(issubstr(weapon.name, "akimbo"))
		{
			self setweaponammoclip(weapon.name, weapon.clipammol, "left");
		}

		self setweaponammostock(weapon.name, weapon.stockammo);
	}

	foreach(slotid, actionslot in savedata.actionslots)
	{
		_setactionslot(slotid, actionslot.type, actionslot.item);
	}

	if(self getcurrentweapon() == "none")
	{
		weapon = savedata.currentweapon;
		if(weapon == "none")
		{
			weapon = common_scripts\utility::getlastweapon();
		}

		self setspawnweapon(weapon);
		self switchtoweapon(weapon);
		return;
	}
}

_setactionslot(slotid, type, item)
{
	self.saved_actionslotdata[slotid].type = type;
	self.saved_actionslotdata[slotid].item = item;
	self setactionslot(slotid, type, item);
}

isfloat(value)
{
	if(int(value) != value)
	{
		return 1;
	}

	return 0;
}

registerwatchdvarint(namestring, defaultvalue)
{
	dvarstring = "scr_" + level.gametype + "_" + namestring;
	level.watchdvars[dvarstring] = spawnstruct();
	level.watchdvars[dvarstring].value = getdvarint(dvarstring, defaultvalue);
	level.watchdvars[dvarstring].type = "int";
	level.watchdvars[dvarstring].notifystring = "update_" + namestring;
}

registerwatchdvarfloat(namestring, defaultvalue)
{
	dvarstring = "scr_" + level.gametype + "_" + namestring;
	level.watchdvars[dvarstring] = spawnstruct();
	level.watchdvars[dvarstring].value = getdvarfloat(dvarstring, defaultvalue);
	level.watchdvars[dvarstring].type = "float";
	level.watchdvars[dvarstring].notifystring = "update_" + namestring;
}

registerwatchdvar(namestring, defaultvalue)
{
	dvarstring = "scr_" + level.gametype + "_" + namestring;
	level.watchdvars[dvarstring] = spawnstruct();
	level.watchdvars[dvarstring].value = getdvar(dvarstring, defaultvalue);
	level.watchdvars[dvarstring].type = "string";
	level.watchdvars[dvarstring].notifystring = "update_" + namestring;
}

getwatcheddvar(dvarstring)
{
	dvarstring = "scr_" + level.gametype + "_" + dvarstring;
	return level.watchdvars[dvarstring].value;
}

updatewatcheddvars()
{
	while(game["state"] == "playing")
	{
		watchdvars = getarraykeys(level.watchdvars);
		foreach(dvarstring in watchdvars)
		{
			if(level.watchdvars[dvarstring].type == "string")
			{
				dvarvalue = getproperty(dvarstring, level.watchdvars[dvarstring].value);
			}
			else if(level.watchdvars[dvarstring].type == "float")
			{
				dvarvalue = getfloatproperty(dvarstring, level.watchdvars[dvarstring].value);
			}
			else
			{
				dvarvalue = getintproperty(dvarstring, level.watchdvars[dvarstring].value);
			}

			if(dvarvalue != level.watchdvars[dvarstring].value)
			{
				level.watchdvars[dvarstring].value = dvarvalue;
				level notify(level.watchdvars[dvarstring].notifystring, dvarvalue);
			}
		}

		wait 1;
	}
}

isroundbased()
{
	if(!level.teambased)
	{
		return 0;
	}

	if(getwatcheddvar("winlimit") != 1 && getwatcheddvar("roundlimit") != 1)
	{
		return 1;
	}

	return 0;
}

islastround()
{
	if(!level.teambased)
	{
		return 1;
	}

	if(getwatcheddvar("roundlimit") > 1 && game["roundsPlayed"] >= getwatcheddvar("roundlimit") - 1)
	{
		return 1;
	}

	if(getwatcheddvar("winlimit") > 1 && game["roundsWon"]["allies"] >= getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] >= getwatcheddvar("winlimit") - 1)
	{
		return 1;
	}

	return 0;
}

wasonlyround()
{
	if(!level.teambased)
	{
		return 1;
	}

	if(getwatcheddvar("winlimit") == 1 && hitwinlimit())
	{
		return 1;
	}

	if(getwatcheddvar("roundlimit") == 1)
	{
		return 1;
	}

	return 0;
}

waslastround()
{
	if(level.forcedend)
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	if(hitroundlimit() || hitwinlimit())
	{
		return 1;
	}

	return 0;
}

hitroundlimit()
{
	if(getwatcheddvar("roundlimit") <= 0)
	{
		return 0;
	}

	return game["roundsPlayed"] >= getwatcheddvar("roundlimit");
}

hitscorelimit()
{
	if(isobjectivebased())
	{
		return 0;
	}

	if(getwatcheddvar("scorelimit") <= 0)
	{
		return 0;
	}

	if(level.teambased)
	{
		if(game["teamScores"]["allies"] >= getwatcheddvar("scorelimit") || game["teamScores"]["axis"] >= getwatcheddvar("scorelimit"))
		{
			return 1;
		}
	}
	else
	{
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			if(isdefined(player.score) && player.score >= getwatcheddvar("scorelimit"))
			{
				return 1;
			}
		}
	}

	return 0;
}

hitwinlimit()
{
	if(getwatcheddvar("winlimit") <= 0)
	{
		return 0;
	}

	if(!level.teambased)
	{
		return 1;
	}

	if(getroundswon("allies") >= getwatcheddvar("winlimit") || getroundswon("axis") >= getwatcheddvar("winlimit"))
	{
		return 1;
	}

	return 0;
}

getscorelimit()
{
	if(isroundbased())
	{
		if(getwatcheddvar("roundlimit"))
		{
			return getwatcheddvar("roundlimit");
		}

		return getwatcheddvar("winlimit");
	}

	return getwatcheddvar("scorelimit");
}

getroundswon(team)
{
	return game["roundsWon"][team];
}

isobjectivebased()
{
	return level.objectivebased;
}

gettimelimit()
{
	if(inovertime() && !isdefined(game["inNukeOvertime"]) || !game["inNukeOvertime"])
	{
		timelimit = int(getdvar("overtimeTimeLimit"));
		if(isdefined(timelimit))
		{
			return timelimit;
		}

		return 1;
	}

	if(isdefined(level.dd) && level.dd && isdefined(level.bombexploded) && level.bombexploded > 0)
	{
		return getwatcheddvar("timelimit") + level.bombexploded * level.ddtimetoadd;
	}

	return getwatcheddvar("timelimit");
}

gethalftime()
{
	if(inovertime())
	{
		return 0;
	}

	if(isdefined(game["inNukeOvertime"]) && game["inNukeOvertime"])
	{
		return 0;
	}

	return getwatcheddvar("halftime");
}

inovertime()
{
	return isdefined(game["status"]) && game["status"] == "overtime";
}

gamehasstarted()
{
	if(level.teambased)
	{
		return level.hasspawned["axis"] && level.hasspawned["allies"];
	}

	return level.maxplayercount > 1;
}

getaverageorigin(ent_array)
{
	avg_origin = (0,0,0);
	if(!ent_array.size)
	{
		return undefined;
	}

	foreach(ent in ent_array)
	{
		avg_origin = avg_origin + ent.origin;
	}

	avg_x = int(avg_origin[0] / ent_array.size);
	avg_y = int(avg_origin[1] / ent_array.size);
	avg_z = int(avg_origin[2] / ent_array.size);
	avg_origin = (avg_x,avg_y,avg_z);
	return avg_origin;
}

getlivingplayers(team)
{
	player_array = [];
	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}

		if(level.teambased && isdefined(team))
		{
			if(team == player.pers["team"])
			{
				player_array[player_array.size] = player;
			}

			continue;
		}

		player_array[player_array.size] = player;
	}

	return player_array;
}

setusingremote(param_D0)
{
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 0;
	}

	self.usingremote = param_D0;
	common_scripts\utility::_disableoffhandweapons();
	self notify("using_remote");
}

getremotename()
{
	return self.usingremote;
}

freezecontrolswrapper(frozen)
{
	if(isdefined(level.hostmigrationtimer))
	{
		self freezecontrols(1);
		return;
	}

	self freezecontrols(frozen);
}

clearusingremote()
{
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 1;
	}

	self.usingremote = undefined;
	common_scripts\utility::_enableoffhandweapons();
	curweapon = self getcurrentweapon();
	if(curweapon == "none" || iskillstreakweapon(curweapon))
	{
		self switchtoweapon(common_scripts\utility::getlastweapon());
	}

	freezecontrolswrapper(0);
	self notify("stopped_using_remote");
}

isusingremote()
{
	return isdefined(self.usingremote);
}

queuecreate(queuename)
{
	if(!isdefined(level.queues))
	{
		level.queues = [];
	}

	level.queues[queuename] = [];
}

queueadd(queuename, entity)
{
	level.queues[queuename][level.queues[queuename].size] = entity;
}

queueremovefirst(queuename)
{
	first = undefined;
	newqueue = [];
	foreach(element in level.queues[queuename])
	{
		if(!isdefined(element))
		{
			continue;
		}

		if(!isdefined(first))
		{
			first = element;
			continue;
		}

		newqueue[newqueue.size] = element;
	}

	level.queues[queuename] = newqueue;
	return first;
}

_giveweapon(weapon, variant, dualwieldoverride)
{
	if(!isdefined(variant))
	{
		variant = 0;
	}

	if(issubstr(weapon, "_akimbo") || isdefined(dualwieldoverride) && dualwieldoverride == 1)
	{
		self giveweapon(weapon, variant, 1);
		return;
	}

	self giveweapon(weapon, variant, 0);
}

_hasperk(perkname)
{
	if(isdefined(self.perks[perkname]))
	{
		return 1;
	}

	return 0;
}

_setperk(perkname)
{
	self.perks[perkname] = 1;
	if(isdefined(level.perksetfuncs[perkname]))
	{
		self thread [[ level.perksetfuncs[perkname] ]]();
	}

	self setperk(perkname, !isdefined(level.scriptperks[perkname]));
}

_unsetperk(perkname)
{
	self.perks[perkname] = undefined;
	if(isdefined(level.perkunsetfuncs[perkname]))
	{
		self thread [[ level.perkunsetfuncs[perkname] ]]();
	}

	self unsetperk(perkname, !isdefined(level.scriptperks[perkname]));
}

_clearperks()
{
	foreach(perkname, perkvalue in self.perks)
	{
		if(isdefined(level.perkunsetfuncs[perkname]))
		{
			self [[ level.perkunsetfuncs[perkname] ]]();
		}
	}

	self.perks = [];
	self clearperks();
}

quicksort(array)
{
	return quicksortmid(array, 0, array.size - 1);
}

quicksortmid(array, start, end)
{
	i = start;
	k = end;
	if(end - start >= 1)
	{
		pivot = array[start];
		while(k > i)
		{
			while(array[i] <= pivot && i <= end && k > i)
			{
				i++;
			}

			while(array[k] > pivot && k >= start && k >= i)
			{
				k--;
			}

			if(k > i)
			{
				array = swap(array, i, k);
			}
		}

		array = swap(array, start, k);
		array = quicksortmid(array, start, k - 1);
		array = quicksortmid(array, k + 1, end);
	}
	else
	{
		return array;
	}

	return array;
}

swap(array, index1, index2)
{
	temp = array[index1];
	array[index1] = array[index2];
	array[index2] = temp;
	return array;
}

_suicide()
{
	if(isusingremote() && !isdefined(self.fauxdead))
	{
		thread maps\mp\gametypes\_damage::playerkilled_internal(self, self, self, 10000, "MOD_SUICIDE", "frag_grenade_mp", (0,0,0), "none", 0, 1116, 1);
		return;
	}

	if(!isusingremote() && !isdefined(self.fauxdead))
	{
		self suicide();
		return;
	}
}

isreallyalive(player)
{
	if(isalive(player) && !isdefined(player.fauxdead))
	{
		return 1;
	}

	return 0;
}

playdeathsound()
{
	rand = randomintrange(1, 8);
	if(self.team == "axis")
	{
		self playsound("generic_death_russian_" + rand);
		return;
	}

	self playsound("generic_death_american_" + rand);
}

rankingenabled()
{
	return level.rankedmatch && !self.usingonlinedataoffline;
}

privatematch()
{
	return level.onlinegame && getdvarint("xblive_privatematch");
}

matchmakinggame()
{
	return level.onlinegame && !getdvarint("xblive_privatematch");
}

setaltsceneobj(object, tagname, fov, param_F4)
{
}

endsceneondeath(object)
{
	self endon("altscene");
	object waittill("death");
	self notify("end_altScene");
}

getgametypenumlives()
{
	return getwatcheddvar("numlives");
}

registeradrenalineinfo(type, value)
{
	if(!isdefined(level.adrenalineinfo))
	{
		level.adrenalineinfo = [];
	}

	level.adrenalineinfo[type] = value;
}

giveadrenaline(type)
{
}

setadrenaline(value)
{
	self.adrenaline = min(value, 1000);
	self setclientdvar("ui_adrenaline", self.adrenaline);
	if(self.adrenaline < 1000)
	{
		self.combathigh = undefined;
		return;
	}
}

givecombathigh(param_F8)
{
	self.combathigh = param_F8;
}

arrayinsertion(array, item, index)
{
	if(array.size != 0)
	{
		for(i = array.size;i >= index;i--)
		{
			array[i + 1] = array[i];
		}
	}

	array[index] = item;
}

getproperty(dvar, defvalue)
{
	value = defvalue;
	value = getdvar(dvar, defvalue);
	return value;
}

getintproperty(dvar, defvalue)
{
	value = defvalue;
	value = getdvarint(dvar, defvalue);
	return value;
}

getfloatproperty(dvar, defvalue)
{
	value = defvalue;
	value = getdvarfloat(dvar, defvalue);
	return value;
}

statusmenu(duration)
{
	self endon("disconnect");
	if(!isdefined(self._statusmenu))
	{
		self.statusmenu = 0;
	}

	if(self.statusmenu)
	{
		return;
	}

	self.statusmenu = 1;
	self openpopupmenu("status_update");
	wait duration;
	self closepopupmenu("status_update");
	wait 10;
	self.statusmenu = 0;
}

ischangingweapon()
{
	return isdefined(self.changingweapon);
}

iskillstreakweapon(weapon)
{
	if(weapon == "none")
	{
		return 0;
	}

	if(weaponinventorytype(weapon) == "exclusive" && weapon != "destructible_car")
	{
		return 1;
	}

	if(issubstr(weapon, "killstreak"))
	{
		return 1;
	}

	switch(weapon)
	{
		case "cobra_20mm_mp":
		case "remotemissile_projectile_mp":
		case "ac130_25mm_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
		case "harrier_20mm_mp":
		case "sentry_minigun_mp":
		case "pavelow_minigun_mp":
		case "stealth_bomb_mp":
		case "artillery_mp":
		case "cobra_player_minigun_mp":
		case "airdrop_mega_marker_mp":
		case "airdrop_sentry_marker_mp":
		case "airdrop_marker_mp":
		case "nuke_mp":
			return 1;

		default:
			return 0;
	}
}

getweaponclass(weapon)
{
	tokens = strtok(weapon, "_");
	weaponclass = tablelookup("mp/statstable.csv", 4, tokens[0], 2);
	if(weaponclass == "")
	{
		weaponname = strip_suffix(weapon, "_mp");
		weaponclass = tablelookup("mp/statstable.csv", 4, weaponname, 2);
	}

	if(ismg(weapon))
	{
		weaponclass = "weapon_mg";
	}
	else if(iskillstreakweapon(weapon))
	{
		weaponclass = "killstreak";
	}
	else if(isdeathstreakweapon(weapon))
	{
		weaponclass = "deathstreak";
	}
	else if(weapon == "none")
	{
		weaponclass = "other";
	}
	else if(weaponclass == "")
	{
		weaponclass = "other";
	}

	return weaponclass;
}

isdeathstreakweapon(weapon)
{
	if(weapon == "c4death_mp" || weapon == "frag_grenade_short_mp")
	{
		return 1;
	}

	return 0;
}

getbaseweaponname(weaponname)
{
	tokens = strtok(weaponname, "_");
	return tokens[0];
}

playsoundinspace(alias, origin)
{
	playsoundatpos(origin, alias);
}

limitdecimalplaces(value, places)
{
	modifier = 1;
	for(i = 0;i < places;i++)
	{
		modifier = modifier * 10;
	}

	newvalue = value * modifier;
	newvalue = int(newvalue);
	newvalue = newvalue / modifier;
	return newvalue;
}

rounddecimalplaces(value, places, style)
{
	if(!isdefined(style))
	{
		style = "nearest";
	}

	modifier = 1;
	for(i = 0;i < places;i++)
	{
		modifier = modifier * 10;
	}

	newvalue = value * modifier;
	if(style == "up")
	{
		roundedvalue = ceil(newvalue);
	}
	else if(style == "down")
	{
		roundedvalue = floor(newvalue);
	}
	else
	{
		roundedvalue = newvalue + 0.5;
	}

	newvalue = int(roundedvalue);
	newvalue = newvalue / modifier;
	return newvalue;
}

playerforclientid(clientid)
{
	foreach(player in level.players)
	{
		if(player.clientid == clientid)
		{
			return player;
		}
	}

	return undefined;
}

isrested()
{
	if(!rankingenabled())
	{
		return 0;
	}

	return self getplayerdata("restXPGoal") > self getplayerdata("experience");
}

stringtofloat(stringval)
{
	floatelements = strtok(stringval, ".");
	floatval = int(floatelements[0]);
	if(isdefined(floatelements[1]))
	{
		modifier = 1;
		for(i = 0;i < floatelements[1].size;i++)
		{
			modifier = modifier * 0.1;
		}

		floatval = floatval + int(floatelements[1]) * modifier;
	}

	return floatval;
}

setselfusable(caller)
{
	self makeusable();
	foreach(player in level.players)
	{
		if(player != caller)
		{
			self disableplayeruse(player);
			continue;
		}

		self enableplayeruse(player);
	}
}

maketeamusable(team)
{
	self makeusable();
	thread _updateteamusable(team);
}

_updateteamusable(team)
{
	self endon("death");
	for(;;)
	{
		foreach(player in level.players)
		{
			if(player.team == team)
			{
				self enableplayeruse(player);
				continue;
			}

			self disableplayeruse(player);
		}

		level waittill("joined_team");
	}
}

makeenemyusable(owner)
{
	self makeusable();
	thread _updateenemyusable(owner);
}

_updateenemyusable(owner)
{
	self endon("death");
	team = owner.team;
	for(;;)
	{
		if(level.teambased)
		{
			foreach(player in level.players)
			{
				if(player.team != team)
				{
					self enableplayeruse(player);
					continue;
				}

				self disableplayeruse(player);
			}
		}
		else
		{
			foreach(player in level.players)
			{
				if(player != owner)
				{
					self enableplayeruse(player);
					continue;
				}

				self disableplayeruse(player);
			}
		}

		level waittill("joined_team");
	}
}

getnextlifeid()
{
	lifeid = getmatchdata("lifeCount");
	if(lifeid < level.maxlives)
	{
		setmatchdata("lifeCount", lifeid + 1);
	}

	return lifeid;
}

initgameflags()
{
	if(!isdefined(game["flags"]))
	{
		game["flags"] = [];
		return;
	}
}

gameflaginit(flagname, isenabled)
{
	game["flags"][flagname] = isenabled;
}

gameflag(flagname)
{
	return game["flags"][flagname];
}

gameflagset(flagname)
{
	game["flags"][flagname] = 1;
	level notify(flagname);
}

gameflagclear(flagname)
{
	game["flags"][flagname] = 0;
}

gameflagwait(flagname)
{
	while(!gameflag(flagname))
	{
		level waittill(flagname);
	}
}

isexplosivedamage(meansofdeath)
{
	explosivedamage = "MOD_GRENADE MOD_GRENADE_SPLASH MOD_PROJECTILE MOD_PROJECTILE_SPLASH MOD_EXPLOSIVE mod_explosive";
	if(issubstr(explosivedamage, meansofdeath))
	{
		return 1;
	}

	return 0;
}

isprimarydamage(meansofdeath)
{
	if(meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET")
	{
		return 1;
	}

	return 0;
}

initlevelflags()
{
	if(!isdefined(level.levelflags))
	{
		level.levelflags = [];
		return;
	}
}

levelflaginit(flagname, isenabled)
{
	level.levelflags[flagname] = isenabled;
}

levelflag(flagname)
{
	return level.levelflags[flagname];
}

levelflagset(flagname)
{
	level.levelflags[flagname] = 1;
	level notify(flagname);
}

levelflagclear(flagname)
{
	level.levelflags[flagname] = 0;
	level notify(flagname);
}

levelflagwait(flagname)
{
	while(!levelflag(flagname))
	{
		level waittill(flagname);
	}
}

levelflagwaitopen(flagname)
{
	while(levelflag(flagname))
	{
		level waittill(flagname);
	}
}

getweaponattachments(weapon)
{
	tokenizedweapon = strtok(weapon, "_");
	attachmentarray = [];
	if(tokenizedweapon.size < 3 || tokenizedweapon[1] == "_mp")
	{
		attachmentarray[0] = "none";
	}
	else if(tokenizedweapon.size > 3)
	{
		attachmentarray[0] = tokenizedweapon[1];
		attachmentarray[1] = tokenizedweapon[2];
	}
	else
	{
		attachmentarray[0] = tokenizedweapon[1];
	}

	return attachmentarray;
}

isemped()
{
	if(self.team == "spectator")
	{
		return 0;
	}

	if(level.teambased)
	{
		return level.teamemped[self.team];
	}

	return isdefined(level.empplayer) && level.empplayer != self;
}

isnuked()
{
	if(self.team == "spectator")
	{
		return 0;
	}

	return isdefined(self.nuked);
}

isbulletdamage(meansofdeath)
{
	bulletdamage = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEADSHOT";
	if(issubstr(bulletdamage, meansofdeath))
	{
		return 1;
	}

	return 0;
}

getplayerforguid(guid)
{
	foreach(player in level.players)
	{
		if(player.guid == guid)
		{
			return player;
		}
	}

	return undefined;
}

teamplayercardsplash(param_119, owner, team)
{
	if(level.hardcoremode)
	{
		return;
	}

	foreach(player in level.players)
	{
		if(isdefined(team) && player.team != team)
		{
			continue;
		}

		player thread maps\mp\gametypes\_hud_message::playercardsplashnotify(param_119, owner);
	}
}

iscacprimaryweapon(weapname)
{
	switch(getweaponclass(weapname))
	{
		case "weapon_lmg":
		case "weapon_sniper":
		case "weapon_riot":
		case "weapon_assault":
		case "weapon_smg":
			return 1;

		default:
			return 0;
	}
}

iscacsecondaryweapon(weapname)
{
	switch(getweaponclass(weapname))
	{
		case "weapon_shotgun":
		case "weapon_machine_pistol":
		case "weapon_pistol":
		case "weapon_projectile":
			return 1;

		default:
			return 0;
	}
}

getlastlivingplayer(team)
{
	liveplayer = undefined;
	foreach(player in level.players)
	{
		if(isdefined(team) && player.team != team)
		{
			continue;
		}

		if(!isreallyalive(player) && !player maps\mp\gametypes\_playerlogic::mayspawn())
		{
			continue;
		}

		liveplayer = player;
	}

	return liveplayer;
}

getpotentiallivingplayers()
{
	liveplayers = [];
	foreach(player in level.players)
	{
		if(!isreallyalive(player) && !player maps\mp\gametypes\_playerlogic::mayspawn())
		{
			continue;
		}

		liveplayers[liveplayers.size] = player;
	}

	return liveplayers;
}

waittillrecoveredhealth(time, interval)
{
	self endon("death");
	self endon("disconnect");
	fullhealthtime = 0;
	if(!isdefined(interval))
	{
		interval = 0.05;
	}

	if(!isdefined(time))
	{
		time = 0;
	}

	for(;;)
	{
		if(self.health != self.maxhealth)
		{
			fullhealthtime = 0;
		}
		else
		{
			fullhealthtime = fullhealthtime + interval;
		}

		wait interval;
		if(self.health == self.maxhealth && fullhealthtime >= time)
		{
			break;
		}
	}
}

_objective_delete(objid)
{
	objective_delete(objid);
	if(!isdefined(level.reclaimedreservedobjectives))
	{
		level.reclaimedreservedobjectives = [];
		level.reclaimedreservedobjectives[0] = objid;
		return;
	}

	level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = objid;
}

touchingbadtrigger()
{
	killtriggers = getentarray("trigger_hurt", "classname");
	foreach(trigger in killtriggers)
	{
		if(self istouching(trigger))
		{
			return 1;
		}
	}

	radtriggers = getentarray("radiation", "targetname");
	foreach(trigger in radtriggers)
	{
		if(self istouching(trigger))
		{
			return 1;
		}
	}

	return 0;
}

setthirdpersondof(isenabled)
{
	if(isenabled)
	{
		self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
		return;
	}

	self setdepthoffield(0, 0, 512, 512, 4, 0);
}

killtrigger(pos, radius, height)
{
	trig = spawn("trigger_radius", pos, 0, radius, height);
	for(;;)
	{
		trig waittill("trigger", player);
		if(!isplayer(player))
		{
			continue;
		}

		player suicide();
	}
}