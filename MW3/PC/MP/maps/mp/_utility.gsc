/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_utility.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 230
 * Decompile Time: 4048 ms
 * Timestamp: 10/27/2023 2:15:21 AM
*******************************************************************/

//Function Number: 1
exploder_sound()
{
	if(isdefined(self.script_delay))
	{
		wait self.script_delay;
	}

	self playsound(level.scr_sound[self.script_sound]);
}

//Function Number: 2
_beginlocationselection(param_00,param_01,param_02,param_03)
{
	self setclientdvar("ui_selecting_location","1");
	self beginlocationselection(param_01,param_02,param_03);
	self.selectinglocation = 1;
	self setblurforplayer(10.3,0.3);
	thread endselectiononaction("cancel_location");
	thread endselectiononaction("death");
	thread endselectiononaction("disconnect");
	thread endselectiononaction("used");
	self endon("stop_location_selection");
	thread endselectiononendgame();
	thread endselectiononemp();
	if(isdefined(param_00) && self.team != "spectator")
	{
		if(isdefined(self.streakmsg))
		{
			self.streakmsg destroy();
		}

		if(self issplitscreenplayer())
		{
			self.streakmsg = maps\mp\gametypes\_hud_util::createfontstring("hudbig",0.65);
			self.streakmsg maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,-98);
		}
		else
		{
			self.streakmsg = maps\mp\gametypes\_hud_util::createfontstring("bigfixed",0.8);
			self.streakmsg maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,-190);
		}

		var_04 = tablelookupistring("mp/killstreakTable.csv",1,param_00,2);
		self.streakmsg settext(var_04);
	}
}

//Function Number: 3
stoplocationselection(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "generic";
	}

	if(!param_00)
	{
		self setblurforplayer(0,0.3);
		self endlocationselection();
		self.selectinglocation = undefined;
		if(isdefined(self.streakmsg))
		{
			self.streakmsg destroy();
		}
	}

	self notify("stop_location_selection",param_01);
}

//Function Number: 4
endselectiononemp()
{
	self endon("stop_location_selection");
	for(;;)
	{
		level waittill("emp_update");
		if(!isemped())
		{
			continue;
		}

		thread stoplocationselection(0,"emp");
	}
}

//Function Number: 5
endselectiononaction(param_00)
{
	self endon("stop_location_selection");
	self waittill(param_00);
	thread stoplocationselection(param_00 == "disconnect",param_00);
}

//Function Number: 6
endselectiononendgame()
{
	self endon("stop_location_selection");
	level waittill("game_ended");
	thread stoplocationselection(0,"end_game");
}

//Function Number: 7
isattachment(param_00)
{
	var_01 = tablelookup("mp/attachmentTable.csv",4,param_00,0);
	if(isdefined(var_01) && var_01 != "")
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
getattachmenttype(param_00)
{
	var_01 = tablelookup("mp/attachmentTable.csv",4,param_00,2);
	return var_01;
}

//Function Number: 9
delaythread(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	thread delaythread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 10
delaythread_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait param_01;
	if(!isdefined(param_02))
	{
		thread [[ param_00 ]]();
		return;
	}

	if(!isdefined(param_03))
	{
		thread [[ param_00 ]](param_02);
		return;
	}

	if(!isdefined(param_04))
	{
		thread [[ param_00 ]](param_02,param_03);
		return;
	}

	if(!isdefined(param_05))
	{
		thread [[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(!isdefined(param_06))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 11
getplant()
{
	var_00 = self.origin + (0,0,10);
	var_01 = 11;
	var_02 = anglestoforward(self.angles);
	var_02 = var_02 * var_01;
	var_03[0] = var_00 + var_02;
	var_04 = bullettrace(var_7B[0],var_7B[0] + (0,0,-18),0,undefined);
	if(var_04["fraction"] < 1)
	{
		var_05 = spawnstruct();
		var_05.origin = var_04["position"];
		var_05.angles = orienttonormal(var_04["normal"]);
		return var_05;
	}

	var_05 = bullettrace(var_04[1],var_04[1] + (0,0,-18),0,undefined);
	if(var_05["fraction"] < 1)
	{
		var_05 = spawnstruct();
		var_05.origin = var_04["position"];
		var_05.angles = orienttonormal(var_04["normal"]);
		return var_05;
	}

	var_04[2] = var_02 + (16,16,0);
	var_04[3] = var_02 + (16,-16,0);
	var_04[4] = var_02 + (-16,-16,0);
	var_04[5] = var_02 + (-16,16,0);
	var_06 = undefined;
	var_07 = undefined;
	for(var_08 = 0;var_08 < var_04.size;var_08++ = var_7B[1])
	{
		var_05 = bullettrace(var_04[var_08],var_04[var_08] + (0,0,-1000),0,undefined);
		if(!isdefined(var_06) || var_05["fraction"] < var_06)
		{
			var_06 = var_05["fraction"];
			var_07 = var_05["position"];
		}
	}

	if(var_06 == 1)
	{
		var_07 = self.origin;
	}

	var_05 = spawnstruct();
	var_08.origin = var_06;
	var_08.angles = orienttonormal(var_04["normal"]);
	return var_08;
}

//Function Number: 12
orienttonormal(param_00)
{
	var_01 = (param_00[0],param_00[1],0);
	var_02 = length(var_01);
	if(!var_02)
	{
		return (0,0,0);
	}

	var_03 = vectornormalize(var_01);
	var_04 = param_00[2] * -1;
	var_05 = (var_03[0] * var_04,var_03[1] * var_04,var_02);
	var_06 = vectortoangles(var_05);
	return var_06;
}

//Function Number: 13
deleteplacedentity(param_00)
{
	var_01 = getentarray(param_00,"classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] delete();
	}
}

//Function Number: 14
playsoundonplayers(param_00,param_01,param_02)
{
	if(level.splitscreen)
	{
		if(isdefined(level.players[0]))
		{
			level.players[0] playlocalsound(param_00);
			return;
		}

		return;
	}

	if(isdefined(param_01))
	{
		if(isdefined(param_02))
		{
			for(var_03 = 0;var_03 < level.players.size;var_03++)
			{
				var_04 = level.players[var_03];
				if(var_04 issplitscreenplayer() && !var_04 issplitscreenplayerprimary())
				{
					continue;
				}

				if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == param_01 && !isexcluded(var_04,param_02))
				{
					var_04 playlocalsound(param_00);
				}
			}

			return;
		}

		for(var_03 = 0;var_03 < level.players.size;var_03++)
		{
			var_04 = level.players[var_03];
			if(var_04 issplitscreenplayer() && !var_04 issplitscreenplayerprimary())
			{
				continue;
			}

			if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == param_01)
			{
				var_04 playlocalsound(param_00);
			}
		}

		return;
	}

	if(isdefined(var_03))
	{
		for(var_03 = 0;var_03 < level.players.size;var_03++)
		{
			if(level.players[var_03] issplitscreenplayer() && !level.players[var_03] issplitscreenplayerprimary())
			{
				continue;
			}

			if(!isexcluded(level.players[var_03],param_02))
			{
				level.players[var_03] playlocalsound(param_00);
			}
		}

		return;
	}

	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		if(level.players[var_03] issplitscreenplayer() && !level.players[var_03] issplitscreenplayerprimary())
		{
			continue;
		}

		level.players[var_03] playlocalsound(param_00);
	}
}

//Function Number: 15
sortlowermessages()
{
	for(var_00 = 1;var_00 < self.lowermessages.size;var_00++)
	{
		var_01 = self.lowermessages[var_00];
		var_02 = var_01.priority;
		for(var_03 = var_00 - 1;var_03 >= 0 && var_02 > self.lowermessages[var_03].priority;var_03--)
		{
			self.lowermessages[var_03 + 1] = self.lowermessages[var_03];
		}

		self.lowermessages[var_03 + 1] = var_01;
	}
}

//Function Number: 16
addlowermessage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = undefined;
	foreach(var_0B in self.lowermessages)
	{
		if(var_0B.name == param_00)
		{
			if(var_0B.text == param_01 && var_0B.priority == param_03)
			{
				return;
			}

			var_09 = var_0B;
			break;
		}
	}

	if(!isdefined(var_09))
	{
		var_09 = spawnstruct();
		self.lowermessages[self.lowermessages.size] = var_09;
	}

	var_09.name = param_00;
	var_09.text = param_01;
	var_09.time = param_02;
	var_09.addtime = gettime();
	var_09.priority = param_03;
	var_09.showtimer = param_04;
	var_09.shouldfade = param_05;
	var_09.fadetoalpha = param_06;
	var_09.fadetoalphatime = param_07;
	var_09.hidewhenindemo = param_08;
	sortlowermessages();
}

//Function Number: 17
removelowermessage(param_00)
{
	if(isdefined(self.lowermessages))
	{
		for(var_01 = self.lowermessages.size;var_01 > 0;var_01--)
		{
			if(self.lowermessages[var_01 - 1].name != param_00)
			{
				continue;
			}

			var_02 = self.lowermessages[var_01 - 1];
			for(var_03 = var_01;var_03 < self.lowermessages.size;var_03++)
			{
				if(isdefined(self.lowermessages[var_03]))
				{
					self.lowermessages[var_03 - 1] = self.lowermessages[var_03];
				}
			}

			self.lowermessages[self.lowermessages.size - 1] = undefined;
		}

		sortlowermessages();
	}
}

//Function Number: 18
getlowermessage()
{
	return self.lowermessages[0];
}

//Function Number: 19
setlowermessage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_06))
	{
		param_06 = 0.85;
	}

	if(!isdefined(param_07))
	{
		param_07 = 3;
	}

	if(!isdefined(param_08))
	{
		param_08 = 0;
	}

	addlowermessage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	updatelowermessage();
}

//Function Number: 20
updatelowermessage()
{
	var_00 = getlowermessage();
	if(!isdefined(var_00))
	{
		self.lowermessage.alpha = 0;
		self.lowertimer.alpha = 0;
		return;
	}

	self.lowermessage settext(var_00.text);
	self.lowermessage.alpha = 0.85;
	self.lowertimer.alpha = 1;
	self.lowermessage.hidewhenindemo = var_00.hidewhenindemo;
	if(var_00.shouldfade)
	{
		self.lowermessage fadeovertime(min(var_00.fadetoalphatime,60));
		self.lowermessage.alpha = var_00.fadetoalpha;
	}

	if(var_00.time > 0 && var_00.showtimer)
	{
		self.lowertimer settimer(max(var_00.time - gettime() - var_00.addtime / 1000,0.1));
		return;
	}

	if(var_00.time > 0 && !var_00.showtimer)
	{
		self.lowertimer settext("");
		self.lowermessage fadeovertime(min(var_00.time,60));
		self.lowermessage.alpha = 0;
		thread clearondeath(var_00);
		thread clearafterfade(var_00);
		return;
	}

	self.lowertimer settext("");
}

//Function Number: 21
clearondeath(param_00)
{
	self notify("message_cleared");
	self endon("message_cleared");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	clearlowermessage(param_00.name);
}

//Function Number: 22
clearafterfade(param_00)
{
	wait param_00.time;
	clearlowermessage(param_00.name);
	self notify("message_cleared");
}

//Function Number: 23
clearlowermessage(param_00)
{
	removelowermessage(param_00);
	updatelowermessage();
}

//Function Number: 24
clearlowermessages()
{
	for(var_00 = 0;var_00 < self.lowermessages.size;var_00++)
	{
		self.lowermessages[var_00] = undefined;
	}

	if(!isdefined(self.lowermessage))
	{
		return;
	}

	updatelowermessage();
}

//Function Number: 25
printonteam(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03.team != param_01)
		{
			continue;
		}

		var_03 iprintln(param_00);
	}
}

//Function Number: 26
printboldonteam(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		var_03 = level.players[var_02];
		if(isdefined(var_03.pers["team"]) && var_03.pers["team"] == param_01)
		{
			var_03 iprintlnbold(param_00);
		}
	}
}

//Function Number: 27
printboldonteamarg(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		var_04 = level.players[var_03];
		if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == param_01)
		{
			var_04 iprintlnbold(param_00,param_02);
		}
	}
}

//Function Number: 28
printonteamarg(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		var_04 = level.players[var_03];
		if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == param_01)
		{
			var_04 iprintln(param_00,param_02);
		}
	}
}

//Function Number: 29
printonplayers(param_00,param_01)
{
	var_02 = level.players;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(param_01))
		{
			if(isdefined(var_02[var_03].pers["team"]) && var_02[var_03].pers["team"] == param_01)
			{
				var_02[var_03] iprintln(param_00);
			}

			continue;
		}

		var_02[var_03] iprintln(param_00);
	}
}

//Function Number: 30
printandsoundoneveryone(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = isdefined(param_04);
	var_08 = 0;
	if(isdefined(param_05))
	{
		var_08 = 1;
	}

	if(level.splitscreen || !var_07)
	{
		for(var_09 = 0;var_09 < level.players.size;var_09++)
		{
			var_0A = level.players[var_09];
			var_0B = var_0A.pers["team"];
			if(isdefined(var_0B))
			{
				if(var_0B == param_00 && isdefined(param_02))
				{
					var_0A iprintln(param_02,param_06);
					continue;
				}

				if(var_0B == param_01 && isdefined(param_03))
				{
					var_0A iprintln(param_03,param_06);
				}
			}
		}

		if(var_07)
		{
			level.players[0] playlocalsound(param_04);
			return;
		}

		return;
	}

	if(var_0B)
	{
		for(var_09 = 0;var_09 < level.players.size;var_09++)
		{
			var_0A = level.players[var_09];
			var_0B = var_0A.pers["team"];
			if(isdefined(var_0B))
			{
				if(var_0B == param_00)
				{
					if(isdefined(param_02))
					{
						var_0A iprintln(param_02,param_06);
					}

					var_0A playlocalsound(param_04);
					continue;
				}

				if(var_0B == param_01)
				{
					if(isdefined(param_03))
					{
						var_0A iprintln(param_03,param_06);
					}

					var_0A playlocalsound(param_05);
				}
			}
		}

		return;
	}

	for(var_09 = 0;var_09 < level.players.size;var_09++)
	{
		var_0A = level.players[var_09];
		var_0B = var_0A.pers["team"];
		if(isdefined(var_0B))
		{
			if(var_0B == param_00)
			{
				if(isdefined(param_02))
				{
					var_0A iprintln(param_02,param_06);
				}

				var_0A playlocalsound(param_04);
				continue;
			}

			if(var_0B == param_01)
			{
				if(isdefined(param_03))
				{
					var_0A iprintln(param_03,param_06);
				}
			}
		}
	}
}

//Function Number: 31
printandsoundonteam(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		if(var_04.team != param_00)
		{
			continue;
		}

		var_04 printandsoundonplayer(param_01,param_02);
	}
}

//Function Number: 32
printandsoundonplayer(param_00,param_01)
{
	self iprintln(param_00);
	self playlocalsound(param_01);
}

//Function Number: 33
_playlocalsound(param_00)
{
	if(level.splitscreen && self getentitynumber() != 0)
	{
		return;
	}

	self playlocalsound(param_00);
}

//Function Number: 34
dvarintvalue(param_00,param_01,param_02,param_03)
{
	param_00 = "scr_" + level.gametype + "_" + param_00;
	if(getdvar(param_00) == "")
	{
		setdvar(param_00,param_01);
		return param_01;
	}

	var_04 = getdvarint(param_00);
	if(var_04 > param_03)
	{
		var_04 = param_03;
	}
	else if(var_04 < param_02)
	{
		var_04 = param_02;
	}
	else
	{
		return var_04;
	}

	setdvar(param_00,var_04);
	return var_04;
}

//Function Number: 35
dvarfloatvalue(param_00,param_01,param_02,param_03)
{
	param_00 = "scr_" + level.gametype + "_" + param_00;
	if(getdvar(param_00) == "")
	{
		setdvar(param_00,param_01);
		return param_01;
	}

	var_04 = getdvarfloat(param_00);
	if(var_04 > param_03)
	{
		var_04 = param_03;
	}
	else if(var_04 < param_02)
	{
		var_04 = param_02;
	}
	else
	{
		return var_04;
	}

	setdvar(param_00,var_04);
	return var_04;
}

//Function Number: 36
play_sound_on_tag(param_00,param_01)
{
	if(isdefined(param_01))
	{
		playsoundatpos(self gettagorigin(param_01),param_00);
		return;
	}

	playsoundatpos(self.origin,param_00);
}

//Function Number: 37
getotherteam(param_00)
{
	if(param_00 == "allies")
	{
		return "axis";
	}
	else if(param_00 == "axis")
	{
		return "allies";
	}
}

//Function Number: 38
wait_endon(param_00,param_01,param_02,param_03)
{
	self endon(param_01);
	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	wait param_00;
}

//Function Number: 39
initpersstat(param_00)
{
	if(!isdefined(self.pers[param_00]))
	{
		self.pers[param_00] = 0;
	}
}

//Function Number: 40
getpersstat(param_00)
{
	return self.pers[param_00];
}

//Function Number: 41
incpersstat(param_00,param_01)
{
	self.pers[param_00] = self.pers[param_00] + param_01;
	maps\mp\gametypes\_persistance::statadd(param_00,param_01);
}

//Function Number: 42
setpersstat(param_00,param_01)
{
	self.pers[param_00] = param_01;
}

//Function Number: 43
initplayerstat(param_00,param_01)
{
	if(!isdefined(self.stats["stats_" + param_00]))
	{
		if(!isdefined(param_01))
		{
			param_01 = 0;
		}

		self.stats["stats_" + param_00] = spawnstruct();
		self.stats["stats_" + param_00].value = param_01;
	}
}

//Function Number: 44
incplayerstat(param_00,param_01)
{
	var_02 = self.stats["stats_" + param_00];
	var_02.value = var_02.value + param_01;
}

//Function Number: 45
setplayerstat(param_00,param_01)
{
	var_02 = self.stats["stats_" + param_00];
	var_02.value = param_01;
	var_02.time = gettime();
}

//Function Number: 46
getplayerstat(param_00)
{
	return self.stats["stats_" + param_00].value;
}

//Function Number: 47
getplayerstattime(param_00)
{
	return self.stats["stats_" + param_00].time;
}

//Function Number: 48
setplayerstatifgreater(param_00,param_01)
{
	var_02 = getplayerstat(param_00);
	if(param_01 > var_02)
	{
		setplayerstat(param_00,param_01);
	}
}

//Function Number: 49
setplayerstatiflower(param_00,param_01)
{
	var_02 = getplayerstat(param_00);
	if(param_01 < var_02)
	{
		setplayerstat(param_00,param_01);
	}
}

//Function Number: 50
updatepersratio(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_persistance::statget(param_01);
	var_04 = maps\mp\gametypes\_persistance::statget(param_02);
	if(var_04 == 0)
	{
		var_04 = 1;
	}

	maps\mp\gametypes\_persistance::statset(param_00,int(var_03 * 1000 / var_04));
}

//Function Number: 51
updatepersratiobuffered(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_persistance::statgetbuffered(param_01);
	var_04 = maps\mp\gametypes\_persistance::statgetbuffered(param_02);
	if(var_04 == 0)
	{
		var_04 = 1;
	}

	maps\mp\gametypes\_persistance::statsetbuffered(param_00,int(var_03 * 1000 / var_04));
}

//Function Number: 52
waittillslowprocessallowed(param_00)
{
	if(level.lastslowprocessframe == gettime())
	{
		if(isdefined(param_00) && param_00)
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

//Function Number: 53
waitfortimeornotify(param_00,param_01)
{
	self endon(param_01);
	wait param_00;
}

//Function Number: 54
isexcluded(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_00 == param_01[var_02])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 55
leaderdialog(param_00,param_01,param_02,param_03)
{
	if(level.splitscreen)
	{
		return;
	}

	if(param_00 == "null")
	{
		return;
	}

	if(!isdefined(param_01))
	{
		leaderdialogbothteams(param_00,"allies",param_00,"axis",param_02,param_03);
		return;
	}

	if(level.splitscreen)
	{
		if(level.players.size)
		{
			level.players[0] leaderdialogonplayer(param_00,param_02);
		}

		return;
	}

	if(isdefined(param_03))
	{
		for(var_04 = 0;var_04 < level.players.size;var_04++)
		{
			var_05 = level.players[var_04];
			if(isdefined(var_05.pers["team"]) && var_05.pers["team"] == param_01 && !isexcluded(var_05,param_03))
			{
				if(var_05 issplitscreenplayer() && !var_05 issplitscreenplayerprimary())
				{
					continue;
				}

				var_05 leaderdialogonplayer(param_00,param_02);
			}
		}

		return;
	}

	for(var_04 = 0;var_04 < level.players.size;var_04++)
	{
		var_05 = level.players[var_04];
		if(isdefined(var_05.pers["team"]) && var_05.pers["team"] == param_01)
		{
			if(var_05 issplitscreenplayer() && !var_05 issplitscreenplayerprimary())
			{
				continue;
			}

			var_05 leaderdialogonplayer(param_00,param_02);
		}
	}
}

//Function Number: 56
leaderdialogbothteams(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(level.splitscreen)
	{
		return;
	}

	if(level.splitscreen)
	{
		if(level.players.size)
		{
			level.players[0] leaderdialogonplayer(param_00,param_04);
		}

		return;
	}

	if(isdefined(param_05))
	{
		for(var_06 = 0;var_06 < level.players.size;var_06++)
		{
			var_07 = level.players[var_06];
			var_08 = var_07.pers["team"];
			if(!isdefined(var_08))
			{
				continue;
			}

			if(isexcluded(var_07,param_05))
			{
				continue;
			}

			if(var_07 issplitscreenplayer() && !var_07 issplitscreenplayerprimary())
			{
				continue;
			}

			if(var_08 == param_01)
			{
				var_07 leaderdialogonplayer(param_00,param_04);
				continue;
			}

			if(var_08 == param_03)
			{
				var_07 leaderdialogonplayer(param_02,param_04);
			}
		}

		return;
	}

	for(var_06 = 0;var_06 < level.players.size;var_06++)
	{
		var_07 = level.players[var_06];
		var_08 = var_07.pers["team"];
		if(!isdefined(var_08))
		{
			continue;
		}

		if(var_07 issplitscreenplayer() && !var_07 issplitscreenplayerprimary())
		{
			continue;
		}

		if(var_08 == param_01)
		{
			var_07 leaderdialogonplayer(param_00,param_04);
			continue;
		}

		if(var_08 == param_03)
		{
			var_07 leaderdialogonplayer(param_02,param_04);
		}
	}
}

//Function Number: 57
leaderdialogonplayers(param_00,param_01,param_02)
{
	foreach(var_04 in param_01)
	{
		var_04 leaderdialogonplayer(param_00,param_02);
	}
}

//Function Number: 58
leaderdialogonplayer(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = self.pers["team"];
	if(level.splitscreen)
	{
		return;
	}

	if(!isdefined(var_03))
	{
		return;
	}

	if(var_03 != "allies" && var_03 != "axis")
	{
		return;
	}

	if(isdefined(param_01))
	{
		if(self.leaderdialoggroup == param_01)
		{
			if(param_02)
			{
				self stoplocalsound(self.leaderdialogactive);
				thread playleaderdialogonplayer(param_00,var_03);
			}

			return;
		}

		var_04 = isdefined(self.leaderdialoggroups[param_01]);
		self.leaderdialoggroups[param_01] = param_00;
		param_00 = param_01;
		if(var_04)
		{
			return;
		}
	}

	if(self.leaderdialogactive == "")
	{
		thread playleaderdialogonplayer(param_00,var_03);
		return;
	}

	self.leaderdialogqueue[self.leaderdialogqueue.size] = param_00;
}

//Function Number: 59
playleaderdialogonplayer(param_00,param_01)
{
	self endon("disconnect");
	self notify("playLeaderDialogOnPlayer");
	self endon("playLeaderDialogOnPlayer");
	if(isdefined(self.leaderdialoggroups[param_00]))
	{
		var_02 = param_00;
		param_00 = self.leaderdialoggroups[var_02];
		self.leaderdialoggroups[var_02] = undefined;
		self.leaderdialoggroup = var_02;
	}

	if(issubstr(game["dialog"][param_00],"null"))
	{
		return;
	}

	self.leaderdialogactive = game["voice"][param_01] + game["dialog"][param_00];
	self playlocalsound(game["voice"][param_01] + game["dialog"][param_00]);
	wait 3;
	self.leaderdialoglocalsound = "";
	self.leaderdialogactive = "";
	self.leaderdialoggroup = "";
	if(self.leaderdialogqueue.size > 0)
	{
		var_03 = self.leaderdialogqueue[0];
		for(var_04 = 1;var_04 < self.leaderdialogqueue.size;var_04++)
		{
			self.leaderdialogqueue[var_04 - 1] = self.leaderdialogqueue[var_04];
		}

		self.leaderdialogqueue[var_04 - 1] = undefined;
		thread playleaderdialogonplayer(var_03,param_01);
	}
}

//Function Number: 60
updatemainmenu()
{
	if(self.pers["team"] == "spectator")
	{
		self setclientdvar("g_scriptMainMenu",game["menu_team"]);
		return;
	}

	self setclientdvar("g_scriptMainMenu",game["menu_class_" + self.pers["team"]]);
}

//Function Number: 61
updateobjectivetext()
{
	if(self.pers["team"] == "spectator")
	{
		self setclientdvar("cg_objectiveText","");
		return;
	}

	if(getwatcheddvar("scorelimit") > 0 && !isobjectivebased())
	{
		if(level.splitscreen)
		{
			self setclientdvar("cg_objectiveText",getobjectivescoretext(self.pers["team"]));
			return;
		}

		self setclientdvar("cg_objectiveText",getobjectivescoretext(self.pers["team"]),getwatcheddvar("scorelimit"));
		return;
	}

	self setclientdvar("cg_objectiveText",getobjectivetext(self.pers["team"]));
}

//Function Number: 62
setobjectivetext(param_00,param_01)
{
	game["strings"]["objective_" + param_00] = param_01;
	precachestring(param_01);
}

//Function Number: 63
setobjectivescoretext(param_00,param_01)
{
	game["strings"]["objective_score_" + param_00] = param_01;
	precachestring(param_01);
}

//Function Number: 64
setobjectivehinttext(param_00,param_01)
{
	game["strings"]["objective_hint_" + param_00] = param_01;
	precachestring(param_01);
}

//Function Number: 65
getobjectivetext(param_00)
{
	return game["strings"]["objective_" + param_00];
}

//Function Number: 66
getobjectivescoretext(param_00)
{
	return game["strings"]["objective_score_" + param_00];
}

//Function Number: 67
getobjectivehinttext(param_00)
{
	return game["strings"]["objective_hint_" + param_00];
}

//Function Number: 68
gettimepassed()
{
	if(!isdefined(level.starttime) || !isdefined(level.discardtime))
	{
		return 0;
	}

	if(level.timerstopped)
	{
		return level.timerpausetime - level.starttime - level.discardtime;
	}

	return gettime() - level.starttime - level.discardtime;
}

//Function Number: 69
getsecondspassed()
{
	return gettimepassed() / 1000;
}

//Function Number: 70
getminutespassed()
{
	return getsecondspassed() / 60;
}

//Function Number: 71
clearkillcamstate()
{
	self.forcespectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
}

//Function Number: 72
isinkillcam()
{
	return self.forcespectatorclient != -1 || self.killcamentity != -1;
}

//Function Number: 73
isvalidclass(param_00)
{
	return isdefined(param_00) && param_00 != "";
}

//Function Number: 74
getvalueinrange(param_00,param_01,param_02)
{
	if(param_00 > param_02)
	{
		return param_02;
	}

	if(param_00 < param_01)
	{
		return param_01;
	}

	return param_00;
}

//Function Number: 75
waitfortimeornotifies(param_00)
{
	var_01 = gettime();
	var_02 = gettime() - var_01 / 1000;
	if(var_02 < param_00)
	{
		wait param_00 - var_02;
		return param_00;
	}

	return var_02;
}

//Function Number: 76
closemenus()
{
	self closepopupmenu();
	self closeingamemenu();
}

//Function Number: 77
logxpgains()
{
	if(!isdefined(self.xpgains))
	{
		return;
	}

	var_00 = getarraykeys(self.xpgains);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = self.xpgains[var_00[var_01]];
		if(!var_02)
		{
			continue;
		}

		self logstring("xp " + var_00[var_01] + ": " + var_02);
	}
}

//Function Number: 78
registerroundswitchdvar(param_00,param_01,param_02,param_03)
{
	registerwatchdvarint("roundswitch",param_01);
	param_00 = "scr_" + param_00 + "_roundswitch";
	level.roundswitchdvar = param_00;
	level.roundswitchmin = param_02;
	level.roundswitchmax = param_03;
	level.roundswitch = getdvarint(param_00,param_01);
	if(level.roundswitch < param_02)
	{
		level.roundswitch = param_02;
		return;
	}

	if(level.roundswitch > param_03)
	{
		level.roundswitch = param_03;
	}
}

//Function Number: 79
registerroundlimitdvar(param_00,param_01)
{
	registerwatchdvarint("roundlimit",param_01);
}

//Function Number: 80
registerwinlimitdvar(param_00,param_01)
{
	registerwatchdvarint("winlimit",param_01);
}

//Function Number: 81
registerscorelimitdvar(param_00,param_01)
{
	registerwatchdvarint("scorelimit",param_01);
}

//Function Number: 82
registertimelimitdvar(param_00,param_01)
{
	registerwatchdvarfloat("timelimit",param_01);
	makedvarserverinfo("ui_timelimit",gettimelimit());
}

//Function Number: 83
registerhalftimedvar(param_00,param_01)
{
	registerwatchdvarint("halftime",param_01);
	makedvarserverinfo("ui_halftime",gethalftime());
}

//Function Number: 84
registernumlivesdvar(param_00,param_01)
{
	registerwatchdvarint("numlives",param_01);
}

//Function Number: 85
setovertimelimitdvar(param_00)
{
	makedvarserverinfo("overtimeTimeLimit",param_00);
}

//Function Number: 86
get_damageable_player(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 1;
	var_02.isadestructable = 0;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 87
get_damageable_sentry(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 0;
	var_02.isadestructable = 0;
	var_02.issentry = 1;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 88
get_damageable_grenade(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 0;
	var_02.isadestructable = 0;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 89
get_damageable_mine(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 0;
	var_02.isadestructable = 0;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 90
get_damageable_player_pos(param_00)
{
	return param_00.origin + (0,0,32);
}

//Function Number: 91
getstancecenter()
{
	if(self getstance() == "crouch")
	{
		var_00 = self.origin + (0,0,24);
	}
	else if(self getstance() == "prone")
	{
		var_00 = self.origin + (0,0,10);
	}
	else
	{
		var_00 = self.origin + (0,0,32);
	}

	return var_00;
}

//Function Number: 92
get_damageable_grenade_pos(param_00)
{
	return param_00.origin;
}

//Function Number: 93
getdvarvec(param_00)
{
	var_01 = getdvar(param_00);
	if(var_01 == "")
	{
		return (0,0,0);
	}

	var_02 = strtok(var_01," ");
	if(var_02.size < 3)
	{
		return (0,0,0);
	}

	setdvar("tempR",var_02[0]);
	setdvar("tempG",var_02[1]);
	setdvar("tempB",var_02[2]);
	return (getdvarfloat("tempR"),getdvarfloat("tempG"),getdvarfloat("tempB"));
}

//Function Number: 94
strip_suffix(param_00,param_01)
{
	if(param_00.size <= param_01.size)
	{
		return param_00;
	}

	if(getsubstr(param_00,param_00.size - param_01.size,param_00.size) == param_01)
	{
		return getsubstr(param_00,0,param_00.size - param_01.size);
	}

	return param_00;
}

//Function Number: 95
_takeweaponsexcept(param_00)
{
	var_01 = self getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			continue;
		}
		else
		{
			self takeweapon(var_03);
		}
	}
}

//Function Number: 96
savedata()
{
	var_00 = spawnstruct();
	var_00.offhandclass = self getoffhandsecondaryclass();
	var_00.actionslots = self.saved_actionslotdata;
	var_00.currentweapon = self getcurrentweapon();
	var_01 = self getweaponslistall();
	var_00.weapons = [];
	foreach(var_03 in var_01)
	{
		if(weaponinventorytype(var_03) == "exclusive")
		{
			continue;
		}

		if(weaponinventorytype(var_03) == "altmode")
		{
			continue;
		}

		var_04 = spawnstruct();
		var_04.name = var_03;
		var_04.clipammor = self getweaponammoclip(var_03,"right");
		var_04.clipammol = self getweaponammoclip(var_03,"left");
		var_04.stockammo = self getweaponammostock(var_03);
		if(isdefined(self.throwinggrenade) && self.throwinggrenade == var_03)
		{
			var_04.stockammo--;
		}

		var_00.weapons[var_00.weapons.size] = var_04;
	}

	self.script_savedata = var_00;
}

//Function Number: 97
restoredata()
{
	var_00 = self.script_savedata;
	self setoffhandsecondaryclass(var_00.offhandclass);
	foreach(var_02 in var_00.weapons)
	{
		_giveweapon(var_02.name,int(tablelookup("mp/camoTable.csv",1,self.loadoutprimarycamo,0)));
		self setweaponammoclip(var_02.name,var_02.clipammor,"right");
		if(issubstr(var_02.name,"akimbo"))
		{
			self setweaponammoclip(var_02.name,var_02.clipammol,"left");
		}

		self setweaponammostock(var_02.name,var_02.stockammo);
	}

	foreach(var_06, var_05 in var_00.actionslots)
	{
		_setactionslot(var_06,var_05.type,var_05.item);
	}

	if(self getcurrentweapon() == "none")
	{
		var_02 = var_00.currentweapon;
		if(var_02 == "none")
		{
			var_02 = common_scripts\utility::getlastweapon();
		}

		self setspawnweapon(var_02);
		self switchtoweapon(var_02);
	}
}

//Function Number: 98
_setactionslot(param_00,param_01,param_02)
{
	self.saved_actionslotdata[param_00].type = param_01;
	self.saved_actionslotdata[param_00].item = param_02;
	self setactionslot(param_00,param_01,param_02);
}

//Function Number: 99
isfloat(param_00)
{
	if(int(param_00) != param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 100
registerwatchdvarint(param_00,param_01)
{
	var_02 = "scr_" + level.gametype + "_" + param_00;
	level.watchdvars[var_02] = spawnstruct();
	level.watchdvars[var_02].value = getdvarint(var_02,param_01);
	level.watchdvars[var_02].type = "int";
	level.watchdvars[var_02].notifystring = "update_" + param_00;
}

//Function Number: 101
registerwatchdvarfloat(param_00,param_01)
{
	var_02 = "scr_" + level.gametype + "_" + param_00;
	level.watchdvars[var_02] = spawnstruct();
	level.watchdvars[var_02].value = getdvarfloat(var_02,param_01);
	level.watchdvars[var_02].type = "float";
	level.watchdvars[var_02].notifystring = "update_" + param_00;
}

//Function Number: 102
registerwatchdvar(param_00,param_01)
{
	var_02 = "scr_" + level.gametype + "_" + param_00;
	level.watchdvars[var_02] = spawnstruct();
	level.watchdvars[var_02].value = getdvar(var_02,param_01);
	level.watchdvars[var_02].type = "string";
	level.watchdvars[var_02].notifystring = "update_" + param_00;
}

//Function Number: 103
setoverridewatchdvar(param_00,param_01)
{
	param_00 = "scr_" + level.gametype + "_" + param_00;
	level.overridewatchdvars[param_00] = param_01;
}

//Function Number: 104
getwatcheddvar(param_00)
{
	param_00 = "scr_" + level.gametype + "_" + param_00;
	if(isdefined(level.overridewatchdvars) && isdefined(level.overridewatchdvars[param_00]))
	{
		return level.overridewatchdvars[param_00];
	}

	return level.watchdvars[param_00].value;
}

//Function Number: 105
updatewatcheddvars()
{
	while(game["state"] == "playing")
	{
		var_00 = getarraykeys(level.watchdvars);
		foreach(var_02 in var_00)
		{
			if(level.watchdvars[var_02].type == "string")
			{
				var_03 = getproperty(var_02,level.watchdvars[var_02].value);
			}
			else if(level.watchdvars[var_02].type == "float")
			{
				var_03 = getfloatproperty(var_02,level.watchdvars[var_02].value);
			}
			else
			{
				var_03 = getintproperty(var_02,level.watchdvars[var_02].value);
			}

			if(var_03 != level.watchdvars[var_02].value)
			{
				level.watchdvars[var_02].value = var_03;
				level notify(level.watchdvars[var_02].notifystring,var_03);
			}
		}

		wait 1;
	}
}

//Function Number: 106
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

//Function Number: 107
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

//Function Number: 108
wasonlyround()
{
	if(!level.teambased)
	{
		return 1;
	}

	if(isdefined(level.onlyroundoverride))
	{
		return 0;
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

//Function Number: 109
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

//Function Number: 110
hitroundlimit()
{
	if(getwatcheddvar("roundlimit") <= 0)
	{
		return 0;
	}

	return game["roundsPlayed"] >= getwatcheddvar("roundlimit");
}

//Function Number: 111
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
		for(var_00 = 0;var_00 < level.players.size;var_00++)
		{
			var_01 = level.players[var_00];
			if(isdefined(var_01.score) && var_01.score >= getwatcheddvar("scorelimit"))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 112
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

//Function Number: 113
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

//Function Number: 114
getroundswon(param_00)
{
	return game["roundsWon"][param_00];
}

//Function Number: 115
isobjectivebased()
{
	return level.objectivebased;
}

//Function Number: 116
gettimelimit()
{
	if(inovertime() && !isdefined(game["inNukeOvertime"]) || !game["inNukeOvertime"])
	{
		var_00 = int(getdvar("overtimeTimeLimit"));
		if(isdefined(var_00))
		{
			return var_00;
		}

		return 1;
	}

	if(isdefined(level.dd) && level.dd && isdefined(level.bombexploded) && level.bombexploded > 0)
	{
		return getwatcheddvar("timelimit") + level.bombexploded * level.ddtimetoadd;
	}

	return getwatcheddvar("timelimit");
}

//Function Number: 117
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

//Function Number: 118
inovertime()
{
	return isdefined(game["status"]) && game["status"] == "overtime";
}

//Function Number: 119
gamehasstarted()
{
	if(level.teambased)
	{
		return level.hasspawned["axis"] && level.hasspawned["allies"];
	}

	return level.maxplayercount > 1;
}

//Function Number: 120
getaverageorigin(param_00)
{
	var_01 = (0,0,0);
	if(!param_00.size)
	{
		return undefined;
	}

	foreach(var_03 in param_00)
	{
		var_01 = var_01 + var_03.origin;
	}

	var_05 = int(var_01[0] / param_00.size);
	var_06 = int(var_01[1] / param_00.size);
	var_07 = int(var_01[2] / param_00.size);
	var_01 = (var_05,var_06,var_07);
	return var_01;
}

//Function Number: 121
getlivingplayers(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(level.teambased && isdefined(param_00))
		{
			if(param_00 == var_03.pers["team"])
			{
				var_01[var_01.size] = var_03;
			}

			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 122
setusingremote(param_00)
{
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 0;
	}

	self.usingremote = param_00;
	common_scripts\utility::_disableoffhandweapons();
	self notify("using_remote");
}

//Function Number: 123
getremotename()
{
	return self.usingremote;
}

//Function Number: 124
freezecontrolswrapper(param_00)
{
	if(isdefined(level.hostmigrationtimer))
	{
		self freezecontrols(1);
		return;
	}

	self freezecontrols(param_00);
}

//Function Number: 125
clearusingremote()
{
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 1;
	}

	self.usingremote = undefined;
	common_scripts\utility::_enableoffhandweapons();
	var_00 = self getcurrentweapon();
	if(var_00 == "none" || iskillstreakweapon(var_00))
	{
		self switchtoweapon(common_scripts\utility::getlastweapon());
	}

	freezecontrolswrapper(0);
	self notify("stopped_using_remote");
}

//Function Number: 126
isusingremote()
{
	return isdefined(self.usingremote);
}

//Function Number: 127
queuecreate(param_00)
{
	if(!isdefined(level.queues))
	{
		level.queues = [];
	}

	level.queues[param_00] = [];
}

//Function Number: 128
queueadd(param_00,param_01)
{
	level.queues[param_00][level.queues[param_00].size] = param_01;
}

//Function Number: 129
queueremovefirst(param_00)
{
	var_01 = undefined;
	var_02 = [];
	foreach(var_04 in level.queues[param_00])
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(!isdefined(var_01))
		{
			var_01 = var_04;
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	level.queues[param_00] = var_02;
	return var_01;
}

//Function Number: 130
_giveweapon(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = -1;
	}

	if(issubstr(param_00,"_akimbo") || isdefined(param_02) && param_02 == 1)
	{
		self giveweapon(param_00,param_01,1);
		return;
	}

	self giveweapon(param_00,param_01,0);
}

//Function Number: 131
_hasperk(param_00)
{
	if(isdefined(self.perks[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 132
giveperk(param_00,param_01)
{
	if(issubstr(param_00,"_mp"))
	{
		switch(param_00)
		{
			case "frag_grenade_mp":
				self setoffhandprimaryclass("frag");
				break;

			case "throwingknife_mp":
				self setoffhandprimaryclass("throwingknife");
				break;

			case "trophy_mp":
				self setoffhandsecondaryclass("flash");
				break;
		}

		_giveweapon(param_00,0);
		self givestartammo(param_00);
		_setperk(param_00,param_01);
		return;
	}

	if(issubstr(param_00,"specialty_weapon_"))
	{
		_setperk(param_00,param_01);
		return;
	}

	_setperk(param_00,param_01);
	_setextraperks(param_00);
}

//Function Number: 133
_setperk(param_00,param_01)
{
	self.perks[param_00] = 1;
	if(isdefined(level.perksetfuncs[param_00]))
	{
		self thread [[ level.perksetfuncs[param_00] ]]();
	}

	self setperk(param_00,!isdefined(level.scriptperks[param_00]),param_01);
}

//Function Number: 134
_setextraperks(param_00)
{
	if(param_00 == "specialty_coldblooded")
	{
		giveperk("specialty_heartbreaker",0);
	}

	if(param_00 == "specialty_fasterlockon")
	{
		giveperk("specialty_armorpiercing",0);
	}

	if(param_00 == "specialty_spygame")
	{
		giveperk("specialty_empimmune",0);
	}

	if(param_00 == "specialty_rollover")
	{
		giveperk("specialty_assists",0);
	}
}

//Function Number: 135
_unsetperk(param_00)
{
	self.perks[param_00] = undefined;
	if(isdefined(level.perkunsetfuncs[param_00]))
	{
		self thread [[ level.perkunsetfuncs[param_00] ]]();
	}

	self unsetperk(param_00,!isdefined(level.scriptperks[param_00]));
}

//Function Number: 136
_unsetextraperks(param_00)
{
	if(param_00 == "specialty_bulletaccuracy")
	{
		_unsetperk("specialty_steadyaimpro");
	}

	if(param_00 == "specialty_coldblooded")
	{
		_unsetperk("specialty_heartbreaker");
	}

	if(param_00 == "specialty_fasterlockon")
	{
		_unsetperk("specialty_armorpiercing");
	}

	if(param_00 == "specialty_spygame")
	{
		_unsetperk("specialty_empimmune");
	}

	if(param_00 == "specialty_rollover")
	{
		_unsetperk("specialty_assists");
	}
}

//Function Number: 137
_clearperks()
{
	foreach(var_02, var_01 in self.perks)
	{
		if(isdefined(level.perkunsetfuncs[var_02]))
		{
			self [[ level.perkunsetfuncs[var_02] ]]();
		}
	}

	self.perks = [];
	self clearperks();
}

//Function Number: 138
quicksort(param_00)
{
	return quicksortmid(param_00,0,param_00.size - 1);
}

//Function Number: 139
quicksortmid(param_00,param_01,param_02)
{
	var_03 = param_01;
	var_04 = param_02;
	if(param_02 - param_01 >= 1)
	{
		var_05 = param_00[param_01];
		while(var_04 > var_03)
		{
			while(param_00[var_03] <= var_05 && var_03 <= param_02 && var_04 > var_03)
			{
				var_03++;
			}

			while(param_00[var_04] > var_05 && var_04 >= param_01 && var_04 >= var_03)
			{
				var_04--;
			}

			if(var_04 > var_03)
			{
				param_00 = swap(param_00,var_03,var_04);
			}
		}

		param_00 = swap(param_00,param_01,var_04);
		param_00 = quicksortmid(param_00,param_01,var_04 - 1);
		param_00 = quicksortmid(param_00,var_04 + 1,param_02);
	}
	else
	{
		return param_01;
	}

	return param_00;
}

//Function Number: 140
swap(param_00,param_01,param_02)
{
	var_03 = param_00[param_01];
	param_00[param_01] = param_00[param_02];
	param_00[param_02] = var_03;
	return param_00;
}

//Function Number: 141
_suicide()
{
	if(isusingremote() && !isdefined(self.fauxdead))
	{
		thread maps\mp\gametypes\_damage::playerkilled_internal(self,self,self,10000,"MOD_SUICIDE","frag_grenade_mp",(0,0,0),"none",0,1116,1);
		return;
	}

	if(!isusingremote() && !isdefined(self.fauxdead))
	{
		self suicide();
	}
}

//Function Number: 142
isreallyalive(param_00)
{
	if(isalive(param_00) && !isdefined(param_00.fauxdead))
	{
		return 1;
	}

	return 0;
}

//Function Number: 143
playdeathsound()
{
	var_00 = randomintrange(1,8);
	if(self.team == "axis")
	{
		self playsound("generic_death_russian_" + var_00);
		return;
	}

	self playsound("generic_death_american_" + var_00);
}

//Function Number: 144
rankingenabled()
{
	return level.rankedmatch && !self.usingonlinedataoffline;
}

//Function Number: 145
privatematch()
{
	return level.onlinegame && getdvarint("xblive_privatematch");
}

//Function Number: 146
matchmakinggame()
{
	return level.onlinegame && !getdvarint("xblive_privatematch");
}

//Function Number: 147
setaltsceneobj(param_00,param_01,param_02,param_03)
{
}

//Function Number: 148
endsceneondeath(param_00)
{
	self endon("altscene");
	param_00 waittill("death");
	self notify("end_altScene");
}

//Function Number: 149
getgametypenumlives()
{
	return getwatcheddvar("numlives");
}

//Function Number: 150
givecombathigh(param_00)
{
	self.combathigh = param_00;
}

//Function Number: 151
arrayinsertion(param_00,param_01,param_02)
{
	if(param_00.size != 0)
	{
		for(var_03 = param_00.size;var_03 >= param_02;var_03--)
		{
			param_00[var_03 + 1] = param_00[var_03];
		}
	}

	param_00[param_02] = param_01;
}

//Function Number: 152
getproperty(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvar(param_00,param_01);
	return var_02;
}

//Function Number: 153
getintproperty(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvarint(param_00,param_01);
	return var_02;
}

//Function Number: 154
getfloatproperty(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvarfloat(param_00,param_01);
	return var_02;
}

//Function Number: 155
statusmenu(param_00)
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
	wait param_00;
	self closepopupmenu("status_update");
	wait 10;
	self.statusmenu = 0;
}

//Function Number: 156
ischangingweapon()
{
	return isdefined(self.changingweapon);
}

//Function Number: 157
killshouldaddtokillstreak(param_00)
{
	if(_hasperk("specialty_explosivebullets"))
	{
		return 0;
	}

	if(isdefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1)
	{
		return 0;
	}

	if(isdefined(level.killstreakchainingweapons[param_00]))
	{
		for(var_01 = 1;var_01 < 4;var_01++)
		{
			if(isdefined(self.pers["killstreaks"][var_01]) && isdefined(self.pers["killstreaks"][var_01].streakname) && self.pers["killstreaks"][var_01].streakname == level.killstreakchainingweapons[param_00] && isdefined(self.pers["killstreaks"][var_01].lifeid) && self.pers["killstreaks"][var_01].lifeid == self.pers["deaths"])
			{
				return streakshouldchain(level.killstreakchainingweapons[param_00]);
			}
		}

		return 0;
	}

	return !iskillstreakweapon(var_01);
}

//Function Number: 158
streakshouldchain(param_00)
{
	var_01 = maps\mp\killstreaks\_killstreaks::getstreakcost(param_00);
	var_02 = maps\mp\killstreaks\_killstreaks::getnextstreakname();
	var_03 = maps\mp\killstreaks\_killstreaks::getstreakcost(var_02);
	return var_01 < var_03;
}

//Function Number: 159
isjuggernaut()
{
	if(isdefined(self.isjuggernaut) && self.isjuggernaut == 1)
	{
		return 1;
	}

	if(isdefined(self.isjuggernautdef) && self.isjuggernautdef == 1)
	{
		return 1;
	}

	if(isdefined(self.isjuggernautgl) && self.isjuggernautgl == 1)
	{
		return 1;
	}

	if(isdefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 160
iskillstreakweapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	var_01 = strtok(param_00,"_");
	var_02 = 0;
	if(param_00 != "destructible_car" && param_00 != "barrel_mp")
	{
		foreach(var_04 in var_01)
		{
			if(var_04 == "mp")
			{
				var_02 = 1;
				break;
			}
		}

		if(!var_02)
		{
			param_00 = param_00 + "_mp";
		}
	}

	if(issubstr(param_00,"destructible"))
	{
		return 0;
	}

	if(issubstr(param_00,"killstreak"))
	{
		return 1;
	}

	if(maps\mp\killstreaks\_airdrop::isairdropmarker(param_00))
	{
		return 1;
	}

	if(isdefined(level.killstreakweildweapons[param_00]))
	{
		return 1;
	}

	if(isdefined(weaponinventorytype(param_00)) && weaponinventorytype(param_00) == "exclusive" && param_00 != "destructible_car" && param_00 != "barrel_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 161
isenvironmentweapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "turret_minigun_mp")
	{
		return 1;
	}

	if(issubstr(param_00,"_bipod_"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 162
getweaponclass(param_00)
{
	var_01 = strtok(param_00,"_");
	if(var_01[0] == "iw5")
	{
		var_02 = var_01[0] + "_" + var_01[1];
		var_03 = tablelookup("mp/statstable.csv",4,var_02,2);
	}
	else if(var_03[0] == "alt")
	{
		var_02 = var_03[1] + "_" + var_03[2];
		var_03 = tablelookup("mp/statstable.csv",4,var_02,2);
	}
	else
	{
		var_03 = tablelookup("mp/statstable.csv",4,var_03[0],2);
	}

	if(var_03 == "")
	{
		var_04 = strip_suffix(param_00,"_mp");
		var_03 = tablelookup("mp/statstable.csv",4,var_04,2);
	}

	if(isenvironmentweapon(param_00))
	{
		var_03 = "weapon_mg";
	}
	else if(iskillstreakweapon(param_00))
	{
		var_03 = "killstreak";
	}
	else if(isdeathstreakweapon(param_00))
	{
		var_03 = "deathstreak";
	}
	else if(param_00 == "none")
	{
		var_03 = "other";
	}
	else if(var_03 == "")
	{
		var_03 = "other";
	}

	return var_03;
}

//Function Number: 163
isdeathstreakweapon(param_00)
{
	if(param_00 == "c4death_mp" || param_00 == "frag_grenade_short_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 164
getbaseweaponname(param_00)
{
	var_01 = strtok(param_00,"_");
	if(var_01[0] == "iw5")
	{
	}
	else if(var_7B[0] == "alt")
	{
	}

	return var_7B[0];
}

//Function Number: 165
fixakimbostring(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = 0;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(param_00[var_03] == "a" && param_00[var_03 + 1] == "k" && param_00[var_03 + 2] == "i" && param_00[var_03 + 3] == "m" && param_00[var_03 + 4] == "b" && param_00[var_03 + 5] == "o")
		{
			var_02 = var_03;
			break;
		}
	}

	param_00 = getsubstr(param_00,0,var_02) + getsubstr(param_00,var_02 + 6,param_00.size);
	if(param_01)
	{
		param_00 = param_00 + "_akimbo";
	}

	return param_00;
}

//Function Number: 166
playsoundinspace(param_00,param_01)
{
	playsoundatpos(param_01,param_00);
}

//Function Number: 167
limitdecimalplaces(param_00,param_01)
{
	var_02 = 1;
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		var_02 = var_02 * 10;
	}

	var_04 = param_00 * var_02;
	var_04 = int(var_04);
	var_04 = var_04 / var_02;
	return var_04;
}

//Function Number: 168
rounddecimalplaces(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = "nearest";
	}

	var_03 = 1;
	for(var_04 = 0;var_04 < param_01;var_04++)
	{
		var_03 = var_03 * 10;
	}

	var_05 = param_00 * var_03;
	if(param_02 == "up")
	{
		var_06 = ceil(var_05);
	}
	else if(var_03 == "down")
	{
		var_06 = floor(var_06);
	}
	else
	{
		var_06 = var_06 + 0.5;
	}

	var_05 = int(var_06);
	var_05 = var_05 / var_03;
	return var_05;
}

//Function Number: 169
playerforclientid(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02.clientid == param_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 170
isrested()
{
	if(!rankingenabled())
	{
		return 0;
	}

	return self getplayerdata("restXPGoal") > self getplayerdata("experience");
}

//Function Number: 171
stringtofloat(param_00)
{
	var_01 = strtok(param_00,".");
	var_02 = int(var_01[0]);
	if(isdefined(var_01[1]))
	{
		var_03 = 1;
		for(var_04 = 0;var_04 < var_01[1].size;var_04++)
		{
			var_03 = var_03 * 0.1;
		}

		var_02 = var_02 + int(var_01[1]) * var_03;
	}

	return var_02;
}

//Function Number: 172
setselfusable(param_00)
{
	self makeusable();
	foreach(var_02 in level.players)
	{
		if(var_02 != param_00)
		{
			self disableplayeruse(var_02);
			continue;
		}

		self enableplayeruse(var_02);
	}
}

//Function Number: 173
maketeamusable(param_00)
{
	self makeusable();
	thread _updateteamusable(param_00);
}

//Function Number: 174
_updateteamusable(param_00)
{
	self endon("death");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(var_02.team == param_00)
			{
				self enableplayeruse(var_02);
				continue;
			}

			self disableplayeruse(var_02);
		}

		level waittill("joined_team");
	}
}

//Function Number: 175
makeenemyusable(param_00)
{
	self makeusable();
	thread _updateenemyusable(param_00);
}

//Function Number: 176
_updateenemyusable(param_00)
{
	self endon("death");
	var_01 = param_00.team;
	for(;;)
	{
		if(level.teambased)
		{
			foreach(var_03 in level.players)
			{
				if(var_03.team != var_01)
				{
					self enableplayeruse(var_03);
					continue;
				}

				self disableplayeruse(var_03);
			}
		}
		else
		{
			foreach(var_03 in level.players)
			{
				if(var_03 != param_00)
				{
					self enableplayeruse(var_03);
					continue;
				}

				self disableplayeruse(var_03);
			}
		}

		level waittill("joined_team");
	}
}

//Function Number: 177
getnextlifeid()
{
	var_00 = getmatchdata("lifeCount");
	if(var_00 < level.maxlives)
	{
		setmatchdata("lifeCount",var_00 + 1);
	}

	return var_00;
}

//Function Number: 178
initgameflags()
{
	if(!isdefined(game["flags"]))
	{
		game["flags"] = [];
	}
}

//Function Number: 179
gameflaginit(param_00,param_01)
{
	game["flags"][param_00] = param_01;
}

//Function Number: 180
gameflag(param_00)
{
	return game["flags"][param_00];
}

//Function Number: 181
gameflagset(param_00)
{
	game["flags"][param_00] = 1;
	level notify(param_00);
}

//Function Number: 182
gameflagclear(param_00)
{
	game["flags"][param_00] = 0;
}

//Function Number: 183
gameflagwait(param_00)
{
	while(!gameflag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 184
isprimarydamage(param_00)
{
	if(param_00 == "MOD_RIFLE_BULLET" || param_00 == "MOD_PISTOL_BULLET")
	{
		return 1;
	}

	return 0;
}

//Function Number: 185
isbulletdamage(param_00)
{
	var_01 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";
	if(issubstr(var_01,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 186
initlevelflags()
{
	if(!isdefined(level.levelflags))
	{
		level.levelflags = [];
	}
}

//Function Number: 187
levelflaginit(param_00,param_01)
{
	level.levelflags[param_00] = param_01;
}

//Function Number: 188
levelflag(param_00)
{
	return level.levelflags[param_00];
}

//Function Number: 189
levelflagset(param_00)
{
	level.levelflags[param_00] = 1;
	level notify(param_00);
}

//Function Number: 190
levelflagclear(param_00)
{
	level.levelflags[param_00] = 0;
	level notify(param_00);
}

//Function Number: 191
levelflagwait(param_00)
{
	while(!levelflag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 192
levelflagwaitopen(param_00)
{
	while(levelflag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 193
getweaponattachments(param_00)
{
	var_01 = strtok(param_00,"_");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(issubstr(var_04,"scopevz"))
		{
			var_02[var_02.size] = "vzscope";
		}

		if(maps\mp\gametypes\_class::isvalidattachment(var_04,0))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 194
isemped()
{
	if(self.team == "spectator")
	{
		return 0;
	}

	if(level.teambased)
	{
		return level.teamemped[self.team] || isdefined(self.empgrenaded) && self.empgrenaded || level.teamnukeemped[self.team];
	}

	return (isdefined(level.empplayer) && level.empplayer != self) || isdefined(self.empgrenaded) && self.empgrenaded || isdefined(level.nukeinfo.player) && self != level.nukeinfo.player && level.teamnukeemped[self.team];
}

//Function Number: 195
isairdenied()
{
	return 0;
}

//Function Number: 196
isnuked()
{
	if(self.team == "spectator")
	{
		return 0;
	}

	return isdefined(self.nuked);
}

//Function Number: 197
getplayerforguid(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02.guid == param_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 198
teamplayercardsplash(param_00,param_01,param_02)
{
	if(level.hardcoremode)
	{
		return;
	}

	foreach(var_04 in level.players)
	{
		if(isdefined(param_02) && var_04.team != param_02)
		{
			continue;
		}

		var_04 thread maps\mp\gametypes\_hud_message::playercardsplashnotify(param_00,param_01);
	}
}

//Function Number: 199
iscacprimaryweapon(param_00)
{
	switch(getweaponclass(param_00))
	{
		case "weapon_shotgun":
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

//Function Number: 200
iscacsecondaryweapon(param_00)
{
	switch(getweaponclass(param_00))
	{
		case "weapon_machine_pistol":
		case "weapon_pistol":
		case "weapon_projectile":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 201
getlastlivingplayer(param_00)
{
	var_01 = undefined;
	foreach(var_03 in level.players)
	{
		if(isdefined(param_00) && var_03.team != param_00)
		{
			continue;
		}

		if(!isreallyalive(var_03) && !var_03 maps\mp\gametypes\_playerlogic::mayspawn())
		{
			continue;
		}

		var_01 = var_03;
	}

	return var_01;
}

//Function Number: 202
getpotentiallivingplayers()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(!isreallyalive(var_02) && !var_02 maps\mp\gametypes\_playerlogic::mayspawn())
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 203
waittillrecoveredhealth(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	var_02 = 0;
	if(!isdefined(param_01))
	{
		param_01 = 0.05;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	for(;;)
	{
		if(self.health != self.maxhealth)
		{
			var_02 = 0;
		}
		else
		{
			var_02 = var_02 + param_01;
		}

		wait param_01;
		if(self.health == self.maxhealth && var_02 >= param_00)
		{
			break;
		}
	}
}

//Function Number: 204
attachmentmap(param_00,param_01)
{
	var_02 = tablelookup("mp/statstable.csv",4,param_01,2);
	switch(var_02)
	{
		case "weapon_smg":
			if(param_00 == "reflex")
			{
				return "reflexsmg";
			}
			else if(param_00 == "eotech")
			{
				return "eotechsmg";
			}
			else if(param_00 == "acog")
			{
				return "acogsmg";
			}
			else if(param_00 == "thermal")
			{
				return "thermalsmg";
			}
	
			break;

		case "weapon_lmg":
			if(param_00 == "reflex")
			{
				return "reflexlmg";
			}
			else if(param_00 == "eotech")
			{
				return "eotechlmg";
			}
	
			break;

		case "weapon_machine_pistol":
			if(param_00 == "reflex")
			{
				return "reflexsmg";
			}
			else if(param_00 == "eotech")
			{
				return "eotechsmg";
			}
	
			break;

		default:
			return param_00;
	}
}

//Function Number: 205
validateattachment(param_00)
{
	switch(param_00)
	{
		case "silencer03":
		case "silencer02":
			return "silencer";

		case "gp25":
		case "m320":
			return "gl";

		case "reflexlmg":
		case "reflexsmg":
			return "reflex";

		case "eotechlmg":
		case "eotechsmg":
			return "eotech";

		case "acogsmg":
			return "acog";

		case "thermalsmg":
			return "thermal";

		default:
			return param_00;
	}
}

//Function Number: 206
_objective_delete(param_00)
{
	objective_delete(param_00);
	if(!isdefined(level.reclaimedreservedobjectives))
	{
		level.reclaimedreservedobjectives = [];
		level.reclaimedreservedobjectives[0] = param_00;
		return;
	}

	level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = param_00;
}

//Function Number: 207
touchingbadtrigger()
{
	var_00 = getentarray("trigger_hurt","classname");
	foreach(var_02 in var_00)
	{
		if(self istouching(var_02))
		{
			return 1;
		}
	}

	var_04 = getentarray("radiation","targetname");
	foreach(var_02 in var_04)
	{
		if(self istouching(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 208
setthirdpersondof(param_00)
{
	if(param_00)
	{
		self setdepthoffield(0,110,512,4096,6,1.8);
		return;
	}

	self setdepthoffield(0,0,512,512,4,0);
}

//Function Number: 209
killtrigger(param_00,param_01,param_02)
{
	var_03 = spawn("trigger_radius",param_00,0,param_01,param_02);
	for(;;)
	{
		var_03 waittill("trigger",var_04);
		if(!isplayer(var_04))
		{
			continue;
		}

		var_04 suicide();
	}
}

//Function Number: 210
findisfacing(param_00,param_01,param_02)
{
	var_03 = cos(param_02);
	var_04 = anglestoforward(param_00.angles);
	var_05 = param_01.origin - param_00.origin;
	var_04 = var_04 * (1,1,0);
	var_05 = var_05 * (1,1,0);
	var_05 = vectornormalize(var_05);
	var_04 = vectornormalize(var_04);
	var_06 = vectordot(var_05,var_04);
	if(var_06 >= var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 211
combinearrays(param_00,param_01)
{
	if(!isdefined(param_00) && isdefined(param_01))
	{
		return param_01;
	}

	if(!isdefined(param_01) && isdefined(param_00))
	{
		return param_00;
	}

	foreach(var_03 in param_01)
	{
		param_00[param_00.size] = var_03;
	}

	return param_00;
}

//Function Number: 212
setrecoilscale(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(self.recoilscale))
	{
		self.recoilscale = param_00;
	}
	else
	{
		self.recoilscale = self.recoilscale + param_00;
	}

	if(isdefined(param_01))
	{
		if(isdefined(self.recoilscale) && param_01 < self.recoilscale)
		{
			param_01 = self.recoilscale;
		}

		var_02 = 100 - param_01;
	}
	else
	{
		var_02 = 100 - self.recoilscale;
	}

	if(var_02 < 0)
	{
		var_02 = 0;
	}

	if(var_02 > 100)
	{
		var_02 = 100;
	}

	if(var_02 == 100)
	{
		self player_recoilscaleoff();
		return;
	}

	self player_recoilscaleon(var_02);
}

//Function Number: 213
cleanarray(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_01[var_01.size] = param_00[var_04];
	}

	return var_01;
}

//Function Number: 214
notusableforjoiningplayers(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	for(;;)
	{
		level waittill("player_spawned",var_01);
		if(isdefined(var_01) && var_01 != param_00)
		{
			self disableplayeruse(var_01);
		}
	}
}

//Function Number: 215
isstrstart(param_00,param_01)
{
	return getsubstr(param_00,0,param_01.size) == param_01;
}

//Function Number: 216
validateusestreak()
{
	if(isdefined(self.laststand) && !_hasperk("specialty_finalstand"))
	{
		self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		return 0;
	}

	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	if(isusingremote())
	{
		return 0;
	}

	if(isemped())
	{
		return 0;
	}

	return 1;
}

//Function Number: 217
currentactivevehiclecount(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = param_00;
	if(isdefined(level.helis))
	{
		var_01 = var_01 + level.helis.size;
	}

	if(isdefined(level.littlebirds))
	{
		var_01 = var_01 + level.littlebirds.size;
	}

	if(isdefined(level.ugvs))
	{
		var_01 = var_01 + level.ugvs.size;
	}

	return var_01;
}

//Function Number: 218
maxvehiclesallowed()
{
	return 8;
}

//Function Number: 219
incrementfauxvehiclecount()
{
	level.fauxvehiclecount++;
}

//Function Number: 220
decrementfauxvehiclecount()
{
	level.fauxvehiclecount--;
	if(level.fauxvehiclecount < 0)
	{
		level.fauxvehiclecount = 0;
	}
}

//Function Number: 221
lightweightscalar()
{
	return 1.1;
}

//Function Number: 222
allowteamchoice()
{
	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.gametype,4));
	return var_00;
}

//Function Number: 223
allowclasschoice()
{
	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.gametype,5));
	return var_00;
}

//Function Number: 224
isbuffunlockedforweapon(param_00,param_01)
{
	var_02 = 4;
	var_03 = 0;
	var_04 = 4;
	var_05 = self getplayerdata("weaponRank",param_01);
	var_06 = int(tablelookup("mp/weaponRankTable.csv",var_03,getweaponclass(param_01),var_04));
	var_07 = tablelookup("mp/weaponRankTable.csv",var_06,param_00,var_02);
	if(var_07 != "")
	{
		if(var_05 >= int(var_07))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 225
isbuffequippedonweapon(param_00,param_01)
{
	if(isdefined(self.loadoutprimary) && self.loadoutprimary == param_01)
	{
		if(isdefined(self.loadoutprimarybuff) && self.loadoutprimarybuff == param_00)
		{
			return 1;
		}
	}
	else if(isdefined(self.loadoutsecondary) && self.loadoutsecondary == param_01)
	{
		if(isdefined(self.loadoutsecondarybuff) && self.loadoutsecondarybuff == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 226
setcommonrulesfrommatchrulesdata(param_00)
{
	var_01 = getmatchrulesdata("commonOption","timeLimit");
	setdynamicdvar("scr_" + level.gametype + "_timeLimit",var_01);
	registertimelimitdvar(level.gametype,var_01);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_" + level.gametype + "_scoreLimit",var_02);
	registerscorelimitdvar(level.gametype,var_02);
	var_03 = getmatchrulesdata("commonOption","numLives");
	setdynamicdvar("scr_" + level.gametype + "_numLives",var_03);
	registernumlivesdvar(level.gametype,var_03);
	setdynamicdvar("scr_player_maxhealth",getmatchrulesdata("commonOption","maxHealth"));
	setdynamicdvar("scr_player_healthregentime",getmatchrulesdata("commonOption","healthRegen"));
	level.matchrules_damagemultiplier = 0;
	level.matchrules_vampirism = 0;
	setdynamicdvar("scr_game_spectatetype",getmatchrulesdata("commonOption","spectateModeAllowed"));
	setdynamicdvar("scr_game_allowkillcam",getmatchrulesdata("commonOption","showKillcam"));
	setdynamicdvar("scr_game_forceuav",getmatchrulesdata("commonOption","radarAlwaysOn"));
	setdynamicdvar("scr_" + level.gametype + "_playerrespawndelay",getmatchrulesdata("commonOption","respawnDelay"));
	setdynamicdvar("scr_" + level.gametype + "_waverespawndelay",getmatchrulesdata("commonOption","waveRespawnDelay"));
	setdynamicdvar("scr_player_forcerespawn",getmatchrulesdata("commonOption","forceRespawn"));
	level.matchrules_allowcustomclasses = getmatchrulesdata("commonOption","allowCustomClasses");
	setdynamicdvar("scr_game_hardpoints",getmatchrulesdata("commonOption","allowKillstreaks"));
	setdynamicdvar("scr_game_perks",getmatchrulesdata("commonOption","allowPerks"));
	setdynamicdvar("g_hardcore",getmatchrulesdata("commonOption","hardcoreModeOn"));
	setdynamicdvar("scr_thirdPerson",getmatchrulesdata("commonOption","forceThirdPersonView"));
	setdynamicdvar("camera_thirdPerson",getmatchrulesdata("commonOption","forceThirdPersonView"));
	setdynamicdvar("scr_game_onlyheadshots",getmatchrulesdata("commonOption","headshotsOnly"));
	if(!isdefined(param_00))
	{
		setdynamicdvar("scr_team_fftype",getmatchrulesdata("commonOption","friendlyFire"));
	}

	if(getmatchrulesdata("commonOption","hardcoreModeOn"))
	{
		setdynamicdvar("scr_team_fftype",1);
		setdynamicdvar("scr_player_maxhealth",30);
		setdynamicdvar("scr_player_healthregentime",0);
		setdynamicdvar("scr_player_respawndelay",10);
		setdynamicdvar("scr_game_allowkillcam",0);
		setdynamicdvar("scr_game_forceuav",0);
	}
}

//Function Number: 227
reinitializematchrulesonmigration()
{
	for(;;)
	{
		level waittill("host_migration_begin");
		[[ level.initializematchrules ]]();
	}
}

//Function Number: 228
reinitializethermal(param_00)
{
	self endon("disconnect");
	if(isdefined(param_00))
	{
		param_00 endon("death");
	}

	for(;;)
	{
		level waittill("host_migration_begin");
		if(isdefined(self.lastvisionsetthermal))
		{
			self visionsetthermalforplayer(self.lastvisionsetthermal,0);
		}
	}
}

//Function Number: 229
getmatchrulesspecialclass(param_00,param_01)
{
	var_02 = [];
	if(var_7B["loadoutOffhand"] == "specialty_null")
	{
	}

	var_03 = getmatchrulesdata("defaultClasses",param_01,var_02,"class","perks",5);
	if(var_03 != "specialty_null")
	{
		var_7B["loadoutStreakType"] = var_03;
		var_7B["loadoutKillstreak1"] = maps\mp\gametypes\_class::recipe_getkillstreak(param_01,var_02,var_03,0);
		var_7B["loadoutKillstreak2"] = maps\mp\gametypes\_class::recipe_getkillstreak(param_01,var_02,var_03,1);
		var_7B["loadoutKillstreak3"] = maps\mp\gametypes\_class::recipe_getkillstreak(param_01,var_02,var_03,2);
	}

	var_7B["loadoutDeathstreak"] = getmatchrulesdata("defaultClasses",param_01,var_02,"class","deathstreak");
	var_7B["loadoutJuggernaut"] = getmatchrulesdata("defaultClasses",param_01,var_02,"juggernaut");
	return var_7B;
}

//Function Number: 230
recipeclassapplyjuggernaut()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("spawned_player");
	if(!isdefined(self.isjuiced))
	{
		self.movespeedscaler = 0.7;
		maps\mp\gametypes\_weapons::updatemovespeedscale();
	}

	self.juggmovespeedscaler = 0.7;
	self disableweaponpickup();
	if(!getdvarint("camera_thirdPerson"))
	{
		self.juggernautoverlay = newclienthudelem(self);
		self.juggernautoverlay.x = 0;
		self.juggernautoverlay.y = 0;
		self.juggernautoverlay.alignx = "left";
		self.juggernautoverlay.aligny = "top";
		self.juggernautoverlay.horzalign = "fullscreen";
		self.juggernautoverlay.vertalign = "fullscreen";
		self.juggernautoverlay setshader(level.juggsettings["juggernaut"].overlay,640,480);
		self.juggernautoverlay.sort = -10;
		self.juggernautoverlay.archived = 1;
		self.juggernautoverlay.hidein3rdperson = 1;
	}

	thread maps\mp\killstreaks\_juggernaut::juggernautsounds();
	if(level.gametype != "jugg" || isdefined(level.matchrules_showjuggradaricon) && level.matchrules_showjuggradaricon)
	{
		self setperk("specialty_radarjuggernaut",1,0);
	}

	if(isdefined(self.isjuggmodejuggernaut) && self.isjuggmodejuggernaut)
	{
		var_00 = spawn("script_model",self.origin);
		var_00.team = self.team;
		var_00 makeportableradar(self);
		self.personalradar = var_00;
		thread maps\mp\killstreaks\_juggernaut::radarmover(var_00);
	}

	level notify("juggernaut_equipped",self);
	thread maps\mp\killstreaks\_juggernaut::juggremover();
}