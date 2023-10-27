/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 392
 * Decompile Time: 6048 ms
 * Timestamp: 10/27/2023 2:08:59 AM
*******************************************************************/

//Function Number: 1
exploder_sound()
{
	if(isdefined(self.script_delay))
	{
		wait(self.script_delay);
	}

	self playsound(level.scr_sound[self.script_sound]);
}

//Function Number: 2
_beginlocationselection(param_00,param_01,param_02,param_03)
{
	self beginlocationselection(param_01,param_02,param_03);
	self setclientomnvar("ui_map_location_selector",1);
	self.selectinglocation = 1;
	self setblurforplayer(10.3,0.3);
	thread endselectiononaction("cancel_location");
	thread endselectiononaction("death");
	thread endselectiononaction("disconnect");
	thread endselectiononaction("used");
	thread endselectiononaction("weapon_change");
	self endon("stop_location_selection");
	thread endselectiononendgame();
	thread endselectiononemp();
	thread endselectionohostmigration();
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
		self setclientomnvar("ui_map_location_selector",0);
		self setblurforplayer(0,0.3);
		self endlocationselection();
		self.selectinglocation = undefined;
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
endselectiononaction(param_00,param_01)
{
	self endon("stop_location_selection");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	while(param_01 > 0)
	{
		self waittill(param_00);
		param_01--;
	}

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
endselectionohostmigration()
{
	self endon("stop_location_selection");
	level waittill("host_migration_begin");
	thread stoplocationselection(0,"hostmigrate");
}

//Function Number: 8
isattachment(param_00)
{
	var_01 = tablelookup("mp/attachmentTable.csv",3,param_00,0);
	if(isdefined(var_01) && var_01 != "")
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
getattachmenttype(param_00)
{
	var_01 = tablelookup("mp/attachmentTable.csv",3,param_00,1);
	return var_01;
}

//Function Number: 10
delaythread(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	thread delaythread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 11
delaythread_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait(param_01);
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

//Function Number: 12
getplant()
{
	var_00 = self.origin + (0,0,10);
	var_01 = 11;
	var_02 = anglestoforward(self.angles);
	var_02 = var_02 * var_01;
	var_03[0] = var_00 + var_02;
	var_03[1] = var_00;
	var_04 = bullettrace(var_03[0],var_03[0] + (0,0,-18),0,undefined);
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

	var_04[2] = var_01 + (16,16,0);
	var_04[3] = var_01 + (16,-16,0);
	var_04[4] = var_01 + (-16,-16,0);
	var_04[5] = var_01 + (-16,16,0);
	var_06 = undefined;
	var_07 = undefined;
	for(var_08 = 0;var_08 < var_04.size;var_08++)
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

//Function Number: 13
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

//Function Number: 14
deleteplacedentity(param_00)
{
	var_01 = getentarray(param_00,"classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] delete();
	}
}

//Function Number: 15
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

	if(isdefined(var_04))
	{
		for(var_03 = 0;var_03 < level.players.size;var_03++)
		{
			var_04 = level.players[var_03];
			if(var_04 issplitscreenplayer() && !var_04 issplitscreenplayerprimary())
			{
				continue;
			}

			if(!isexcluded(var_04,param_02))
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

		var_04 playlocalsound(param_00);
	}
}

//Function Number: 16
playloopsoundtoplayers(param_00,param_01,param_02)
{
	if(!soundexists(param_00))
	{
		return;
	}

	var_03 = spawn("script_origin",(0,0,0));
	var_03 endon("death");
	thread common_scripts\utility::delete_on_death(var_03);
	if(isdefined(param_02))
	{
		var_03 hide();
		foreach(var_05 in param_02)
		{
			var_03 showtoplayer(var_05);
		}
	}

	if(isdefined(param_01))
	{
		var_03.origin = self.origin + param_01;
		var_03.angles = self.angles;
		var_03 vehicle_jetbikesethoverforcescale(self);
	}
	else
	{
		var_03.origin = self.origin;
		var_03.angles = self.angles;
		var_03 vehicle_jetbikesethoverforcescale(self);
	}

	var_03 playloopsound(param_00);
	self waittill("stop sound" + param_00);
	var_03 stoploopsound(param_00);
	var_03 delete();
}

//Function Number: 17
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

//Function Number: 18
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

//Function Number: 19
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

//Function Number: 20
getlowermessage()
{
	return self.lowermessages[0];
}

//Function Number: 21
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

//Function Number: 22
updatelowermessage()
{
	if(!isdefined(self.lowermessage))
	{
		return;
	}

	var_00 = getlowermessage();
	if(!isdefined(var_00))
	{
		if(isdefined(self.lowermessage) && isdefined(self.lowertimer))
		{
			self.lowermessage.alpha = 0;
			self.lowertimer.alpha = 0;
		}

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

//Function Number: 23
clearondeath(param_00)
{
	self notify("message_cleared");
	self endon("message_cleared");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	clearlowermessage(param_00.name);
}

//Function Number: 24
clearafterfade(param_00)
{
	wait(param_00.time);
	clearlowermessage(param_00.name);
	self notify("message_cleared");
}

//Function Number: 25
clearlowermessage(param_00)
{
	removelowermessage(param_00);
	updatelowermessage();
}

//Function Number: 26
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

//Function Number: 27
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

//Function Number: 28
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

//Function Number: 29
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

//Function Number: 30
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

//Function Number: 31
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

//Function Number: 32
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
			var_0B = var_0A.team;
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
			var_0B = var_0A.team;
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
		var_0B = var_0A.team;
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

//Function Number: 33
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

//Function Number: 34
printandsoundonplayer(param_00,param_01)
{
	self iprintln(param_00);
	self playlocalsound(param_01);
}

//Function Number: 35
_playlocalsound(param_00)
{
	if(level.splitscreen && self getentitynumber() != 0)
	{
		return;
	}

	self playlocalsound(param_00);
}

//Function Number: 36
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

//Function Number: 37
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

//Function Number: 38
play_sound_on_tag(param_00,param_01)
{
	if(isdefined(param_01))
	{
		playsoundatpos(self gettagorigin(param_01),param_00);
		return;
	}

	playsoundatpos(self.origin,param_00);
}

//Function Number: 39
getotherteam(param_00)
{
	if(level.multiteambased)
	{
	}

	if(param_00 == "allies")
	{
		return "axis";
	}
	else if(param_00 == "axis")
	{
		return "allies";
	}
	else
	{
		return "none";
	}
}

//Function Number: 40
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

	wait(param_00);
}

//Function Number: 41
initpersstat(param_00)
{
	if(!isdefined(self.pers[param_00]))
	{
		self.pers[param_00] = 0;
	}
}

//Function Number: 42
getpersstat(param_00)
{
	return self.pers[param_00];
}

//Function Number: 43
incpersstat(param_00,param_01)
{
	if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers[param_00]))
	{
		self.pers[param_00] = self.pers[param_00] + param_01;
		maps\mp\gametypes\_persistence::statadd(param_00,param_01);
	}
}

//Function Number: 44
setpersstat(param_00,param_01)
{
	self.pers[param_00] = param_01;
}

//Function Number: 45
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
		if(rankingenabled())
		{
			self setcommonplayerdata("round","awards",param_00,0);
		}
	}
}

//Function Number: 46
incplayerstat(param_00,param_01)
{
	if(isagent(self))
	{
		return;
	}

	var_02 = self.stats["stats_" + param_00];
	var_02.value = var_02.value + param_01;
	if(isdefined(level.awards[param_00]) && isdefined(level.awards[param_00].process) && level.awards[param_00].saveonupdate)
	{
		var_03 = level.awards[param_00].process;
		self [[ var_03 ]](param_00,param_01);
	}
}

//Function Number: 47
setplayerstat(param_00,param_01)
{
	var_02 = self.stats["stats_" + param_00];
	var_02.value = param_01;
	var_02.time = gettime();
}

//Function Number: 48
getplayerstat(param_00)
{
	return self.stats["stats_" + param_00].value;
}

//Function Number: 49
getplayerstattime(param_00)
{
	return self.stats["stats_" + param_00].time;
}

//Function Number: 50
setplayerstatifgreater(param_00,param_01)
{
	var_02 = getplayerstat(param_00);
	if(param_01 > var_02)
	{
		setplayerstat(param_00,param_01);
	}
}

//Function Number: 51
setplayerstatiflower(param_00,param_01)
{
	var_02 = getplayerstat(param_00);
	if(param_01 < var_02)
	{
		setplayerstat(param_00,param_01);
	}
}

//Function Number: 52
updatepersratio(param_00,param_01,param_02)
{
	if(!rankingenabled())
	{
		return;
	}

	var_03 = maps\mp\gametypes\_persistence::statget(param_01);
	var_04 = maps\mp\gametypes\_persistence::statget(param_02);
	if(var_04 == 0)
	{
		var_04 = 1;
	}

	maps\mp\gametypes\_persistence::statset(param_00,int(var_03 * 1000 / var_04));
}

//Function Number: 53
updatepersratiobuffered(param_00,param_01,param_02)
{
	if(!rankingenabled())
	{
		return;
	}

	var_03 = maps\mp\gametypes\_persistence::statgetbuffered(param_01);
	var_04 = maps\mp\gametypes\_persistence::statgetbuffered(param_02);
	if(var_04 == 0)
	{
		var_04 = 1;
	}

	maps\mp\gametypes\_persistence::statsetbuffered(param_00,int(var_03 * 1000 / var_04));
}

//Function Number: 54
waittillslowprocessallowed(param_00)
{
	if(level.lastslowprocessframe == gettime())
	{
		if(isdefined(param_00) && param_00)
		{
			while(level.lastslowprocessframe == gettime())
			{
				wait(0.05);
			}
		}
		else
		{
			wait(0.05);
			if(level.lastslowprocessframe == gettime())
			{
				wait(0.05);
				if(level.lastslowprocessframe == gettime())
				{
					wait(0.05);
					if(level.lastslowprocessframe == gettime())
					{
						wait(0.05);
					}
				}
			}
		}
	}

	level.lastslowprocessframe = gettime();
}

//Function Number: 55
waitfortimeornotify(param_00,param_01)
{
	self endon(param_01);
	wait(param_00);
}

//Function Number: 56
waitfortimeornotifies(param_00,param_01)
{
	if(isdefined(param_01))
	{
		foreach(var_03 in param_01)
		{
			self endon(var_03);
		}
	}

	if(isdefined(param_00) && param_00 > 0)
	{
		wait(param_00);
	}
}

//Function Number: 57
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

//Function Number: 58
leaderdialog(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		return;
	}

	if(param_00 == "null")
	{
		return;
	}

	if(!isdefined(param_01))
	{
		leaderdialogbothteams(param_00,"allies",param_00,"axis",param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		for(var_05 = 0;var_05 < level.players.size;var_05++)
		{
			var_06 = level.players[var_05];
			if(isdefined(var_06.pers["team"]) && var_06.pers["team"] == param_01 && !isexcluded(var_06,param_03))
			{
				if(var_06 issplitscreenplayer() && !var_06 issplitscreenplayerprimary())
				{
					continue;
				}

				var_06 leaderdialogonplayer(param_00,param_02,undefined,param_04);
			}
		}

		return;
	}

	for(var_05 = 0;var_05 < level.players.size;var_05++)
	{
		var_06 = level.players[var_05];
		if(isdefined(var_06.pers["team"]) && var_06.pers["team"] == param_01)
		{
			if(var_06 issplitscreenplayer() && !var_06 issplitscreenplayerprimary())
			{
				continue;
			}

			var_06 leaderdialogonplayer(param_00,param_02,undefined,param_04);
		}
	}
}

//Function Number: 59
leaderdialogbothteams(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		return;
	}

	if(level.splitscreen)
	{
		return;
	}

	if(level.splitscreen)
	{
		if(level.players.size)
		{
			level.players[0] leaderdialogonplayer(param_00,param_04,undefined,param_06);
		}

		return;
	}

	if(isdefined(param_05))
	{
		for(var_07 = 0;var_07 < level.players.size;var_07++)
		{
			var_08 = level.players[var_07];
			var_09 = var_08.pers["team"];
			if(!isdefined(var_09))
			{
				continue;
			}

			if(isexcluded(var_08,param_05))
			{
				continue;
			}

			if(var_08 issplitscreenplayer() && !var_08 issplitscreenplayerprimary())
			{
				continue;
			}

			if(var_09 == param_01)
			{
				var_08 leaderdialogonplayer(param_00,param_04,undefined,param_06);
				continue;
			}

			if(var_09 == param_03)
			{
				var_08 leaderdialogonplayer(param_02,param_04,undefined,param_06);
			}
		}

		return;
	}

	for(var_07 = 0;var_07 < level.players.size;var_07++)
	{
		var_08 = level.players[var_07];
		var_09 = var_08.pers["team"];
		if(!isdefined(var_09))
		{
			continue;
		}

		if(var_08 issplitscreenplayer() && !var_08 issplitscreenplayerprimary())
		{
			continue;
		}

		if(var_09 == param_01)
		{
			var_08 leaderdialogonplayer(param_00,param_04,undefined,param_06);
			continue;
		}

		if(var_09 == param_03)
		{
			var_08 leaderdialogonplayer(param_02,param_04,undefined,param_06);
		}
	}
}

//Function Number: 60
leaderdialogonplayers(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		return;
	}

	foreach(var_05 in param_01)
	{
		var_05 leaderdialogonplayer(param_00,param_02,undefined,param_03);
	}
}

//Function Number: 61
leaderdialogonplayer(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = self.pers["team"];
	if(isdefined(level.ishorde) && !self issplitscreenplayerprimary())
	{
		return;
	}

	if(isdefined(level.announcerdisabled) && level.announcerdisabled)
	{
		return;
	}

	if(!isdefined(var_04))
	{
		return;
	}

	if(var_04 != "allies" && var_04 != "axis")
	{
		return;
	}

	if(self issplitscreenplayer() && !self issplitscreenplayerprimary())
	{
		return;
	}

	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	if(isdefined(param_01))
	{
		if(self.leaderdialoggroup == param_01)
		{
			if(param_02)
			{
				if(self.leaderdialogactive != "")
				{
					self stoplocalsound(self.leaderdialogactive);
				}

				thread leaderdialogonplayer_internal(param_00,var_04,param_03);
			}

			return;
		}

		var_05 = isdefined(self.leaderdialoggroups[param_01]);
		self.leaderdialoggroups[param_01] = param_00;
		param_00 = param_01;
		if(var_05)
		{
			return;
		}
	}

	if(self.leaderdialogactive == "")
	{
		thread leaderdialogonplayer_internal(param_00,var_04,param_03);
		return;
	}

	self.leaderdialogqueue[self.leaderdialogqueue.size] = param_00;
	self.leaderdialoglocqueue[self.leaderdialoglocqueue.size] = param_03;
}

//Function Number: 62
leaderdialog_trylockout(param_00,param_01)
{
	var_02 = 2;
	if(isdefined(game["dialog"]["lockouts"][param_00]))
	{
		var_02 = game["dialog"]["lockouts"][param_00];
		if(var_02 == 0)
		{
			return;
		}
	}

	if(!isdefined(param_01.active_vo_lockouts))
	{
		param_01.active_vo_lockouts = [];
	}

	param_01.active_vo_lockouts[param_00] = 1;
	thread leaderdialog_lockoutcleardelayed(param_00,param_01,var_02);
}

//Function Number: 63
leaderdialog_lockoutcleardelayed(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	wait(param_02);
	param_01.active_vo_lockouts[param_00] = undefined;
}

//Function Number: 64
leaderdialog_islockedout(param_00,param_01)
{
	if(isdefined(param_01.active_vo_lockouts))
	{
		if(isdefined(param_01.active_vo_lockouts[param_00]))
		{
			if(isdefined(param_01.active_vo_lockouts[param_00] == 1))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 65
leaderdialogonplayer_internal(param_00,param_01,param_02)
{
	self endon("disconnect");
	self notify("playLeaderDialogOnPlayer");
	self endon("playLeaderDialogOnPlayer");
	if(isdefined(self.leaderdialoggroups[param_00]))
	{
		var_03 = param_00;
		param_00 = self.leaderdialoggroups[var_03];
		self.leaderdialoggroups[var_03] = undefined;
		self.leaderdialoggroup = var_03;
	}

	if(!isdefined(game["dialog"][param_00]))
	{
		return;
	}

	if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["leader_dialog"]))
	{
		self [[ level.bot_funcs["leader_dialog"] ]](param_00,param_02);
	}

	if(issubstr(game["dialog"][param_00],"null"))
	{
		return;
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(issubstr(param_00,"coop_gdn"))
		{
			var_04 = param_00;
		}
		else
		{
			var_04 = "AT_anr0_" + game["dialog"][param_01];
		}
	}
	else
	{
		var_04 = game["voice"][param_02] + game["dialog"][param_01];
	}

	if(soundexists(var_04))
	{
		if(leaderdialog_islockedout(game["dialog"][param_00],self))
		{
			return;
		}

		self.leaderdialogactive = var_04;
		self playlocalannouncersound(var_04);
		leaderdialog_trylockout(game["dialog"][param_00],self);
	}
	else
	{
	}

	wait(2);
	self.leaderdialoglocalsound = "";
	self.leaderdialogactive = "";
	self.leaderdialoggroup = "";
	if(self.leaderdialogqueue.size > 0)
	{
		var_05 = self.leaderdialogqueue[0];
		var_06 = self.leaderdialoglocqueue[0];
		for(var_07 = 1;var_07 < self.leaderdialogqueue.size;var_07++)
		{
			self.leaderdialogqueue[var_07 - 1] = self.leaderdialogqueue[var_07];
		}

		for(var_07 = 1;var_07 < self.leaderdialoglocqueue.size;var_07++)
		{
			self.leaderdialoglocqueue[var_07 - 1] = self.leaderdialoglocqueue[var_07];
		}

		self.leaderdialogqueue[var_07 - 1] = undefined;
		self.leaderdialoglocqueue[var_07 - 1] = undefined;
		thread leaderdialogonplayer_internal(var_05,param_01,var_06);
	}
}

//Function Number: 66
getnextrelevantdialog()
{
	for(var_00 = 0;var_00 < self.leaderdialogqueue.size;var_00++)
	{
		if(issubstr(self.leaderdialogqueue[var_00],"losing"))
		{
			if(self.team == "allies")
			{
				if(issubstr(level.axiscapturing,self.leaderdialogqueue[var_00]))
				{
					return self.leaderdialogqueue[var_00];
				}
				else
				{
					common_scripts\utility::array_remove(self.leaderdialogqueue,self.leaderdialogqueue[var_00]);
				}
			}
			else if(issubstr(level.alliescapturing,self.leaderdialogqueue[var_00]))
			{
				return self.leaderdialogqueue[var_00];
			}
			else
			{
				common_scripts\utility::array_remove(self.leaderdialogqueue,self.leaderdialogqueue[var_00]);
			}

			continue;
		}

		return level.alliescapturing[self.leaderdialogqueue];
	}
}

//Function Number: 67
orderonqueueddialog()
{
	self endon("disconnect");
	var_00 = [];
	var_00 = self.leaderdialogqueue;
	for(var_01 = 0;var_01 < self.leaderdialogqueue.size;var_01++)
	{
		if(issubstr(self.leaderdialogqueue[var_01],"losing"))
		{
			for(var_02 = var_01;var_02 >= 0;var_02--)
			{
				if(!issubstr(self.leaderdialogqueue[var_02],"losing") && var_02 != 0)
				{
					continue;
				}

				if(var_02 != var_01)
				{
					arrayinsertion(var_00,self.leaderdialogqueue[var_01],var_02);
					common_scripts\utility::array_remove(var_00,self.leaderdialogqueue[var_01]);
					break;
				}
			}
		}
	}

	self.leaderdialogqueue = var_00;
}

//Function Number: 68
flushdialogonplayer()
{
	self.leaderdialoggroups = [];
	self.leaderdialogqueue = [];
	self.leaderdialogactive = "";
	self.currentleaderdialoggroup = "";
	self notify("flush_dialog");
}

//Function Number: 69
flushgroupdialog(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 flushgroupdialogonplayer(param_00);
	}
}

//Function Number: 70
arrayremovevalue(param_00,param_01)
{
	var_02 = 0;
	for(var_03 = 0;var_02 < param_00.size;var_03++)
	{
		if(param_00[var_02] == param_01)
		{
			var_02++;
			continue;
		}

		if(var_02 != var_03)
		{
			param_00[var_03] = param_00[var_02];
		}

		var_02++;
	}

	while(var_03 < param_00.size)
	{
		param_00[var_03] = undefined;
		var_03++;
	}
}

//Function Number: 71
flushgroupdialogonplayer(param_00)
{
	self.leaderdialoggroups[param_00] = undefined;
	arrayremovevalue(self.leaderdialogqueue,param_00);
	if(self.leaderdialogqueue.size == 0)
	{
		flushdialogonplayer();
	}
}

//Function Number: 72
updatemainmenu()
{
	if(self.pers["team"] == "spectator")
	{
		self setclientdvar("g_scriptMainMenu",game["menu_team"]);
		return;
	}

	self setclientdvar("g_scriptMainMenu",game["menu_class_" + self.pers["team"]]);
}

//Function Number: 73
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

//Function Number: 74
setobjectivetext(param_00,param_01)
{
	game["strings"]["objective_" + param_00] = param_01;
}

//Function Number: 75
setobjectivescoretext(param_00,param_01)
{
	game["strings"]["objective_score_" + param_00] = param_01;
}

//Function Number: 76
setobjectivehinttext(param_00,param_01)
{
	game["strings"]["objective_hint_" + param_00] = param_01;
}

//Function Number: 77
getobjectivetext(param_00)
{
	return game["strings"]["objective_" + param_00];
}

//Function Number: 78
getobjectivescoretext(param_00)
{
	return game["strings"]["objective_score_" + param_00];
}

//Function Number: 79
getobjectivehinttext(param_00)
{
	return game["strings"]["objective_hint_" + param_00];
}

//Function Number: 80
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

//Function Number: 81
getunpausedtimepassedraw()
{
	if(!isdefined(level.matchdurationstarttime))
	{
		return 0;
	}

	return gettime() - level.matchdurationstarttime;
}

//Function Number: 82
getgametimepassedms()
{
	var_00 = getmatchdata("gameLengthSeconds") * 1000;
	var_00 = var_00 + getunpausedtimepassedraw();
	return var_00;
}

//Function Number: 83
getgametimepassedseconds()
{
	var_00 = getgametimepassedms();
	var_01 = int(var_00 / 1000);
	return var_01;
}

//Function Number: 84
gettimepassedpercentage()
{
	return gettimepassed() / gettimelimit() * 60 * 1000 * 100;
}

//Function Number: 85
getsecondspassed()
{
	return gettimepassed() / 1000;
}

//Function Number: 86
getminutespassed()
{
	return getsecondspassed() / 60;
}

//Function Number: 87
gettimedeciseconds()
{
	return convertmillisecondstodecisecondsandclamptoshort(gettime());
}

//Function Number: 88
gettimepasseddeciseconds()
{
	return convertmillisecondstodecisecondsandclamptoshort(gettimepassed());
}

//Function Number: 89
gettimepasseddecisecondsincludingrounds()
{
	var_00 = getgametimepassedms();
	return convertmillisecondstodecisecondsandclamptoshort(var_00);
}

//Function Number: 90
convertmillisecondstodecisecondsandclamptoshort(param_00)
{
	return clamptoshort(param_00 / 100);
}

//Function Number: 91
clamptoshort(param_00)
{
	param_00 = int(param_00);
	if(param_00 > 32767)
	{
		param_00 = 32767;
	}

	if(param_00 < -32768)
	{
		param_00 = -32768;
	}

	return param_00;
}

//Function Number: 92
clamptobyte(param_00)
{
	param_00 = int(param_00);
	if(param_00 > 255)
	{
		param_00 = 255;
	}

	if(param_00 < 0)
	{
		param_00 = 0;
	}

	return param_00;
}

//Function Number: 93
clearkillcamstate()
{
	self.forcespectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.spectatekillcam = 0;
}

//Function Number: 94
isinkillcam()
{
	return self.spectatekillcam;
}

//Function Number: 95
isvalidclass(param_00)
{
	return isdefined(param_00) && param_00 != "";
}

//Function Number: 96
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

//Function Number: 97
logxpgains()
{
	if(!isdefined(self.pers["summary"]))
	{
		return;
	}

	if(isai(self))
	{
		return;
	}

	var_00 = 0;
	if(isdefined(self.timeplayed["total"]))
	{
		var_00 = self.timeplayed["total"];
	}

	reconevent("script_EarnedXP: totalXP %d, timeplayed %d, score %d, challenge %d, match %d, misc %d, gamemode %s",self.pers["summary"]["xp"],var_00,self.pers["summary"]["score"],self.pers["summary"]["challenge"],self.pers["summary"]["match"],self.pers["summary"]["misc"],level.gametype);
}

//Function Number: 98
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

//Function Number: 99
registerroundlimitdvar(param_00,param_01)
{
	registerwatchdvarint("roundlimit",param_01);
}

//Function Number: 100
registernumteamsdvar(param_00,param_01)
{
	registerwatchdvarint("numTeams",param_01);
}

//Function Number: 101
registerwinlimitdvar(param_00,param_01)
{
	registerwatchdvarint("winlimit",param_01);
}

//Function Number: 102
registerscorelimitdvar(param_00,param_01)
{
	registerwatchdvarint("scorelimit",param_01);
}

//Function Number: 103
registertimelimitdvar(param_00,param_01)
{
	registerwatchdvarfloat("timelimit",param_01);
	setdvar("ui_timelimit",gettimelimit());
}

//Function Number: 104
registerhalftimedvar(param_00,param_01)
{
	registerwatchdvarint("halftime",param_01);
	setdvar("ui_halftime",gethalftime());
}

//Function Number: 105
registernumlivesdvar(param_00,param_01)
{
	registerwatchdvarint("numlives",param_01);
}

//Function Number: 106
setovertimelimitdvar(param_00)
{
	setdvar("overtimeTimeLimit",param_00);
}

//Function Number: 107
get_damageable_player(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 1;
	var_02.isadestructable = 0;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 108
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

//Function Number: 109
get_damageable_grenade(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 0;
	var_02.isadestructable = 0;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 110
get_damageable_mine(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 0;
	var_02.isadestructable = 0;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 111
get_damageable_player_pos(param_00)
{
	return param_00.origin + (0,0,32);
}

//Function Number: 112
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

//Function Number: 113
get_damageable_grenade_pos(param_00)
{
	return param_00.origin;
}

//Function Number: 114
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

//Function Number: 115
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

//Function Number: 116
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

//Function Number: 117
savedata()
{
	var_00 = spawnstruct();
	var_00.offhandclass = self gettacticalweapon();
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
		var_04.stockammo = self setweaponammostock(var_03);
		if(isdefined(self.throwinggrenade) && self.throwinggrenade == var_03)
		{
			var_04.stockammo--;
		}

		var_00.weapons[var_00.weapons.size] = var_04;
	}

	self.script_savedata = var_00;
}

//Function Number: 118
restoredata()
{
	var_00 = self.script_savedata;
	self settacticalweapon(var_00.offhandclass);
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

//Function Number: 119
setextrascore0(param_00)
{
	self.extrascore0 = param_00;
	setpersstat("extrascore0",param_00);
}

//Function Number: 120
setextrascore1(param_00)
{
	self.extrascore1 = param_00;
	setpersstat("extrascore1",param_00);
}

//Function Number: 121
_setactionslot(param_00,param_01,param_02)
{
	self.saved_actionslotdata[param_00].type = param_01;
	self.saved_actionslotdata[param_00].item = param_02;
	self setactionslot(param_00,param_01,param_02);
}

//Function Number: 122
isfloat(param_00)
{
	if(int(param_00) != param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 123
registerwatchdvarint(param_00,param_01)
{
	var_02 = "scr_" + level.gametype + "_" + param_00;
	level.watchdvars[var_02] = spawnstruct();
	level.watchdvars[var_02].value = getdvarint(var_02,param_01);
	level.watchdvars[var_02].type = "int";
	level.watchdvars[var_02].notifystring = "update_" + param_00;
}

//Function Number: 124
registerwatchdvarfloat(param_00,param_01)
{
	var_02 = "scr_" + level.gametype + "_" + param_00;
	level.watchdvars[var_02] = spawnstruct();
	level.watchdvars[var_02].value = getdvarfloat(var_02,param_01);
	level.watchdvars[var_02].type = "float";
	level.watchdvars[var_02].notifystring = "update_" + param_00;
}

//Function Number: 125
registerwatchdvar(param_00,param_01)
{
	var_02 = "scr_" + level.gametype + "_" + param_00;
	level.watchdvars[var_02] = spawnstruct();
	level.watchdvars[var_02].value = getdvar(var_02,param_01);
	level.watchdvars[var_02].type = "string";
	level.watchdvars[var_02].notifystring = "update_" + param_00;
}

//Function Number: 126
setoverridewatchdvar(param_00,param_01)
{
	param_00 = "scr_" + level.gametype + "_" + param_00;
	level.overridewatchdvars[param_00] = param_01;
}

//Function Number: 127
getwatcheddvar(param_00)
{
	param_00 = "scr_" + level.gametype + "_" + param_00;
	if(isdefined(level.overridewatchdvars) && isdefined(level.overridewatchdvars[param_00]))
	{
		return level.overridewatchdvars[param_00];
	}

	return level.watchdvars[param_00].value;
}

//Function Number: 128
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

		wait(1);
	}
}

//Function Number: 129
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

//Function Number: 130
isfirstround()
{
	if(!level.teambased)
	{
		return 1;
	}

	if(getwatcheddvar("roundlimit") > 1 && game["roundsPlayed"] == 0)
	{
		return 1;
	}

	if(getwatcheddvar("winlimit") > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 131
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

//Function Number: 132
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

//Function Number: 133
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

//Function Number: 134
hitroundlimit()
{
	if(getwatcheddvar("roundlimit") <= 0)
	{
		return 0;
	}

	return game["roundsPlayed"] >= getwatcheddvar("roundlimit");
}

//Function Number: 135
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

//Function Number: 136
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

//Function Number: 137
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

//Function Number: 138
getroundswon(param_00)
{
	return game["roundsWon"][param_00];
}

//Function Number: 139
isobjectivebased()
{
	return level.objectivebased;
}

//Function Number: 140
gettimelimit()
{
	if(inovertime())
	{
		var_00 = float(getdvar("overtimeTimeLimit"));
		if(!isdefined(var_00))
		{
			var_00 = 1;
		}

		return var_00;
	}

	return getwatcheddvar("timelimit");
}

//Function Number: 141
gethalftime()
{
	if(inovertime())
	{
		return 0;
	}

	return getwatcheddvar("halftime");
}

//Function Number: 142
inovertime()
{
	return isdefined(game["status"]) && isovertimetext(game["status"]);
}

//Function Number: 143
isovertimetext(param_00)
{
	return param_00 == "overtime" || param_00 == "overtime_halftime";
}

//Function Number: 144
gamehasstarted()
{
	if(isdefined(level.gamehasstarted))
	{
		return level.gamehasstarted;
	}

	if(level.teambased)
	{
		return level.hasspawned["axis"] && level.hasspawned["allies"];
	}

	return level.maxplayercount > 1;
}

//Function Number: 145
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

//Function Number: 146
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

//Function Number: 147
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

//Function Number: 148
getremotename()
{
	return self.usingremote;
}

//Function Number: 149
freezecontrolswrapper(param_00)
{
	if(isdefined(level.hostmigrationtimer))
	{
		self freezecontrols(1);
		return;
	}

	self freezecontrols(param_00);
	self.controlsfrozen = param_00;
}

//Function Number: 150
freezecontrolswrapperwithdelay(param_00,param_01)
{
	wait(param_01);
	if(isdefined(self))
	{
		freezecontrolswrapper(param_00);
	}
}

//Function Number: 151
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
	playerremotekillstreakshowhud();
	self notify("stopped_using_remote");
}

//Function Number: 152
playerremotekillstreakhidehud()
{
	self setclientomnvar("ui_killstreak_remote",1);
}

//Function Number: 153
playerremotekillstreakshowhud()
{
	self setclientomnvar("ui_killstreak_remote",0);
}

//Function Number: 154
get_water_weapon()
{
	if(isdefined(self.underwatermotiontype))
	{
		if(self.underwatermotiontype == "shallow" && isdefined(level.shallow_water_weapon))
		{
			return level.shallow_water_weapon;
		}

		if(self.underwatermotiontype == "deep" && isdefined(level.deep_water_weapon))
		{
			return level.deep_water_weapon;
		}

		if(self.underwatermotiontype != "none" && isdefined(level.shallow_water_weapon))
		{
			return level.shallow_water_weapon;
		}
	}

	return "none";
}

//Function Number: 155
isusingremote()
{
	return isdefined(self.usingremote);
}

//Function Number: 156
isinremotetransition()
{
	return isdefined(self.remoteridetransition);
}

//Function Number: 157
isrocketcorpse()
{
	return isdefined(self.isrocketcorpse) && self.isrocketcorpse;
}

//Function Number: 158
queuecreate(param_00)
{
	if(!isdefined(level.queues))
	{
		level.queues = [];
	}

	level.queues[param_00] = [];
}

//Function Number: 159
queueadd(param_00,param_01)
{
	level.queues[param_00][level.queues[param_00].size] = param_01;
}

//Function Number: 160
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

//Function Number: 161
_giveweapon(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = -1;
	}

	var_03 = 0;
	if(isdefined(self.pers["toggleScopeStates"]) && isdefined(self.pers["toggleScopeStates"][param_00]))
	{
		var_03 = self.pers["toggleScopeStates"][param_00];
	}

	if(issubstr(param_00,"_akimbo") || isdefined(param_02) && param_02 == 1)
	{
		if(isagent(self))
		{
			self giveweapon(param_00,param_01,1,-1,0);
			return;
		}

		self giveweapon(param_00,param_01,1,-1,0,self,var_03);
		return;
	}

	if(isagent(self))
	{
		self giveweapon(param_00,param_01,0,-1,0);
		return;
	}

	self giveweapon(param_00,param_01,0,-1,0,self,var_03);
}

//Function Number: 162
_hasperk(param_00)
{
	if(isdefined(self.perks) && isdefined(self.perks[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 163
giveperk(param_00,param_01,param_02)
{
	if(issubstr(param_00,"_mp"))
	{
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

	_setperk(param_00,param_01,param_02);
}

//Function Number: 164
_setperk(param_00,param_01,param_02)
{
	self.perks[param_00] = 1;
	self.perksperkname[param_00] = param_00;
	self.perksuseslot[param_00] = param_01;
	if(isdefined(level.perksetfuncs[param_00]))
	{
		self thread [[ level.perksetfuncs[param_00] ]]();
	}

	var_03 = strip_suffix(param_00,"_lefthand");
	if(isdefined(param_02))
	{
		self setperk(param_00,!isdefined(level.scriptperks[var_03]),param_01,param_02);
		return;
	}

	self setperk(param_00,!isdefined(level.scriptperks[var_03]),param_01);
}

//Function Number: 165
_unsetperk(param_00)
{
	self.perks[param_00] = undefined;
	self.perksperkname[param_00] = undefined;
	self.perksuseslot[param_00] = undefined;
	self.perksperkpower[param_00] = undefined;
	if(isdefined(level.perkunsetfuncs[param_00]))
	{
		self thread [[ level.perkunsetfuncs[param_00] ]]();
	}

	var_01 = strip_suffix(param_00,"_lefthand");
	self unsetperk(param_00,!isdefined(level.scriptperks[var_01]));
}

//Function Number: 166
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
	self.perksperkname = [];
	self.perksuseslot = [];
	self.perksperkpower = [];
	self clearperks();
}

//Function Number: 167
cangiveability(param_00)
{
	return _cangiveability(param_00);
}

//Function Number: 168
_cangiveability(param_00)
{
	if(!isdefined(level.abilitycansetfuncs) || !isdefined(level.abilitycansetfuncs[param_00]))
	{
		return 1;
	}

	return self [[ level.abilitycansetfuncs[param_00] ]]();
}

//Function Number: 169
giveability(param_00,param_01)
{
	_setability(param_00,param_01);
}

//Function Number: 170
_setability(param_00,param_01)
{
	self.abilities[param_00] = 1;
	if(isplayer(self))
	{
		if(isdefined(level.abilitysetfuncs[param_00]))
		{
			self thread [[ level.abilitysetfuncs[param_00] ]]();
		}
	}

	self setperk(param_00,!isdefined(level.scriptabilities[param_00]),param_01);
}

//Function Number: 171
_unsetability(param_00)
{
	self.abilities[param_00] = undefined;
	if(isplayer(self))
	{
		if(isdefined(level.abilityunsetfuncs[param_00]))
		{
			self thread [[ level.abilityunsetfuncs[param_00] ]]();
		}
	}

	self unsetperk(param_00,!isdefined(level.scriptabilities[param_00]));
}

//Function Number: 172
_clearabilities()
{
	if(isplayer(self))
	{
		if(isdefined(level.abilityunsetfuncs[self.pers["ability"]]))
		{
			self [[ level.abilityunsetfuncs[self.pers["ability"]] ]]();
		}
	}

	self.abilities = [];
	self clearperks();
}

//Function Number: 173
_hasability(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		if(isdefined(self.abilities[param_00]) && self.abilities[param_00])
		{
			return 1;
		}
	}
	else if(isdefined(self.pers["ability"]) && self.pers["ability"] == param_00 && isdefined(self.pers["abilityOn"]) && self.pers["abilityOn"])
	{
		return 1;
	}

	return 0;
}

//Function Number: 174
quicksort(param_00,param_01)
{
	return quicksortmid(param_00,0,param_00.size - 1,param_01);
}

//Function Number: 175
quicksortmid(param_00,param_01,param_02,param_03)
{
	var_04 = param_01;
	var_05 = param_02;
	if(!isdefined(param_03))
	{
		param_03 = ::quicksort_compare;
	}

	if(param_02 - param_01 >= 1)
	{
		var_06 = param_00[param_01];
		while(var_05 > var_04)
		{
			while([[ param_03 ]](param_00[var_04],var_06) && var_04 <= param_02 && var_05 > var_04)
			{
				var_04++;
			}

			while(![[ param_03 ]](param_00[var_05],var_06) && var_05 >= param_01 && var_05 >= var_04)
			{
				var_05--;
			}

			if(var_05 > var_04)
			{
				param_00 = swap(param_00,var_04,var_05);
			}
		}

		param_00 = swap(param_00,param_01,var_05);
		param_00 = quicksortmid(param_00,param_01,var_05 - 1,param_03);
		param_00 = quicksortmid(param_00,var_05 + 1,param_02,param_03);
	}
	else
	{
		return param_01;
	}

	return param_00;
}

//Function Number: 176
quicksort_compare(param_00,param_01)
{
	return param_00 <= param_01;
}

//Function Number: 177
swap(param_00,param_01,param_02)
{
	var_03 = param_00[param_01];
	param_00[param_01] = param_00[param_02];
	param_00[param_02] = var_03;
	return param_00;
}

//Function Number: 178
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

//Function Number: 179
isreallyalive(param_00)
{
	if(isalive(param_00) && !isdefined(param_00.fauxdead))
	{
		return 1;
	}

	return 0;
}

//Function Number: 180
waittill_any_timeout_pause_on_death_and_prematch(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	if(isdefined(param_01))
	{
		thread common_scripts\utility::waittill_string_no_endon_death(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		thread common_scripts\utility::waittill_string_no_endon_death(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		thread common_scripts\utility::waittill_string_no_endon_death(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		thread common_scripts\utility::waittill_string_no_endon_death(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		thread common_scripts\utility::waittill_string_no_endon_death(param_05,var_06);
	}

	var_06 thread _timeout_pause_on_death_and_prematch(param_00,self);
	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 181
_timeout_pause_on_death_and_prematch(param_00,param_01)
{
	self endon("die");
	var_02 = 0.05;
	while(param_00 > 0)
	{
		if(isplayer(param_01) && !isreallyalive(param_01))
		{
			param_01 waittill("spawned_player");
		}

		if(getdvarint("ui_inprematch"))
		{
			level waittill("prematch_over");
		}

		wait(var_02);
		param_00 = param_00 - var_02;
	}

	self notify("returned","timeout");
}

//Function Number: 182
playdeathsound()
{
	if(isdefined(level.customplaydeathsound))
	{
		self thread [[ level.customplaydeathsound ]]();
		return;
	}

	var_00 = randomintrange(1,8);
	if(maps\mp\killstreaks\_juggernaut::get_is_in_mech())
	{
		return;
	}

	if(self.team == "axis")
	{
		if(self hasfemalecustomizationmodel())
		{
			self playsound("generic_death_enemy_fm_" + var_00);
			return;
		}

		self playsound("generic_death_enemy_" + var_00);
		return;
	}

	if(self hasfemalecustomizationmodel())
	{
		self playsound("generic_death_friendly_fm_" + var_00);
		return;
	}

	self playsound("generic_death_friendly_" + var_00);
}

//Function Number: 183
rankingenabled()
{
	if(!isplayer(self))
	{
		return 0;
	}

	return level.rankedmatch && !self.usingonlinedataoffline;
}

//Function Number: 184
privatematch()
{
	return !level.onlinegame || getdvarint("xblive_privatematch");
}

//Function Number: 185
matchmakinggame()
{
	return level.onlinegame && !getdvarint("xblive_privatematch");
}

//Function Number: 186
practiceroundgame()
{
	return level.practiceround;
}

//Function Number: 187
setaltsceneobj(param_00,param_01,param_02,param_03)
{
}

//Function Number: 188
endsceneondeath(param_00)
{
	self endon("altscene");
	param_00 waittill("death");
	self notify("end_altScene");
}

//Function Number: 189
getmapname()
{
	return getdvar("mapname");
}

//Function Number: 190
getgametypenumlives()
{
	return getwatcheddvar("numlives");
}

//Function Number: 191
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

//Function Number: 192
getproperty(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvar(param_00,param_01);
	return var_02;
}

//Function Number: 193
getintproperty(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvarint(param_00,param_01);
	return var_02;
}

//Function Number: 194
getfloatproperty(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvarfloat(param_00,param_01);
	return var_02;
}

//Function Number: 195
ischangingweapon()
{
	return isdefined(self.changingweapon);
}

//Function Number: 196
killshouldaddtokillstreak(param_00)
{
	return 1;
}

//Function Number: 197
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

	if(isdefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 198
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

	if(isdestructibleweapon(param_00))
	{
		return 0;
	}

	if(isbombsiteweapon(param_00))
	{
		return 0;
	}

	if(issubstr(param_00,"killstreak"))
	{
		return 1;
	}

	if(param_00 == "airdrop_sentry_marker_mp")
	{
		return 1;
	}

	var_01 = getweaponnametokens(param_00);
	var_02 = 0;
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

	if(maps\mp\killstreaks\_airdrop::isairdropmarker(param_00))
	{
		return 1;
	}

	if(isdefined(level.killstreakwieldweapons) && isdefined(level.killstreakwieldweapons[param_00]))
	{
		return 1;
	}

	var_06 = weaponinventorytype(param_00);
	if(isdefined(var_06) && var_06 == "exclusive")
	{
		return 1;
	}

	return 0;
}

//Function Number: 199
isdestructibleweapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "barrel_mp":
		case "destructible":
		case "destructible_car":
		case "destructible_toy":
			break;
	}
}

//Function Number: 200
isaugmentedgamemode()
{
	return getdvarint("scr_game_high_jump",0);
}

//Function Number: 201
isgrapplinghookgamemode()
{
	if(invirtuallobby())
	{
		return 0;
	}

	return getdvarint("scr_game_grappling_hook",0);
}

//Function Number: 202
isdivisionmode()
{
	return getdvarint("scr_game_division",0);
}

//Function Number: 203
isbombsiteweapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "bomb_site_mp":
		case "search_dstry_bomb_defuse_mp":
		case "search_dstry_bomb_mp":
			break;
	}
}

//Function Number: 204
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

//Function Number: 205
is_legacy_weapon(param_00)
{
	switch(param_00)
	{
		case "iw5_dlcgun8loot1":
		case "iw5_dlcgun7loot6":
		case "iw5_dlcgun7loot0":
		case "iw5_dlcgun6loot5":
		case "iw5_dlcgun6":
			break;

		default:
			break;
	}
}

//Function Number: 206
islootweapon(param_00)
{
	if(is_legacy_weapon(param_00))
	{
		return 0;
	}

	if(issubstr(param_00,"loot"))
	{
		return 1;
	}

	if(issubstr(param_00,"atlas"))
	{
		return 1;
	}

	if(issubstr(param_00,"gold"))
	{
		return 1;
	}

	if(issubstr(param_00,"blops2"))
	{
		return 1;
	}

	if(issubstr(param_00,"ghosts"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 207
getweaponnametokens(param_00)
{
	return strtok(param_00,"_");
}

//Function Number: 208
getweaponclass(param_00)
{
	var_01 = getbaseweaponname(param_00);
	var_02 = tablelookup("mp/statstable.csv",4,var_01,2);
	if(var_02 == "")
	{
		var_03 = strip_suffix(param_00,"_lefthand");
		var_03 = strip_suffix(var_03,"_mp");
		var_02 = tablelookup("mp/statstable.csv",4,var_03,2);
	}

	if(isenvironmentweapon(param_00))
	{
		var_02 = "weapon_mg";
	}
	else if(iskillstreakweapon(param_00))
	{
		var_02 = "killstreak";
	}
	else if(param_00 == "none")
	{
		var_02 = "other";
	}
	else if(var_02 == "")
	{
		var_02 = "other";
	}

	return var_02;
}

//Function Number: 209
getweaponattachmentarrayfromstats(param_00)
{
	param_00 = getbaseweaponname(param_00);
	if(!isdefined(level.weaponattachments[param_00]))
	{
		var_01 = [];
		for(var_02 = 0;var_02 <= 29;var_02++)
		{
			var_03 = tablelookup("mp/statsTable.csv",4,param_00,11 + var_02);
			if(var_03 == "")
			{
				break;
			}

			var_01[var_01.size] = var_03;
		}

		level.weaponattachments[param_00] = var_01;
	}

	return level.weaponattachments[param_00];
}

//Function Number: 210
getweaponattachmentfromstats(param_00,param_01)
{
	param_00 = getbaseweaponname(param_00);
	return tablelookup("mp/statsTable.csv",4,param_00,11 + param_01);
}

//Function Number: 211
getbaseweaponname(param_00,param_01)
{
	var_02 = getweaponnametokens(param_00);
	var_03 = "";
	if(var_02[0] == "iw5" || var_02[0] == "iw6" || var_02[0] == "s1")
	{
		var_03 = var_02[0] + "_" + var_02[1];
	}
	else if(var_02[0] == "alt")
	{
		var_03 = var_02[1] + "_" + var_02[2];
	}
	else if(var_02.size > 1 && var_02[1] == "grenade" || var_02[1] == "marker")
	{
		var_03 = var_02[0] + "_" + var_02[1];
	}
	else
	{
		var_03 = var_02[0];
	}

	var_04 = "";
	if(isdefined(param_01) && param_01 == 1)
	{
		var_04 = tablelookup("mp/statsTable.csv",4,var_03,59);
	}

	if(var_04 != "")
	{
		return "iw5_" + var_04;
	}

	return var_03;
}

//Function Number: 212
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

//Function Number: 213
playsoundinspace(param_00,param_01)
{
	playsoundatpos(param_01,param_00);
}

//Function Number: 214
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

//Function Number: 215
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

//Function Number: 216
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

//Function Number: 217
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

//Function Number: 218
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

//Function Number: 219
setselfunusuable()
{
	self makeunusable();
	foreach(var_01 in level.players)
	{
		self disableplayeruse(var_01);
	}
}

//Function Number: 220
maketeamusable(param_00)
{
	self makeusable();
	thread _updateteamusable(param_00);
}

//Function Number: 221
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

//Function Number: 222
makeenemyusable(param_00)
{
	self makeusable();
	thread _updateenemyusable(param_00);
}

//Function Number: 223
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

//Function Number: 224
getnextlifeid()
{
	var_00 = getmatchdata("lifeCount");
	if(var_00 < level.maxlives)
	{
		setmatchdata("lifeCount",var_00 + 1);
		return var_00;
	}

	return level.maxlives - 1;
}

//Function Number: 225
initgameflags()
{
	if(!isdefined(game["flags"]))
	{
		game["flags"] = [];
	}
}

//Function Number: 226
gameflaginit(param_00,param_01)
{
	game["flags"][param_00] = param_01;
}

//Function Number: 227
gameflag(param_00)
{
	return game["flags"][param_00];
}

//Function Number: 228
gameflagset(param_00)
{
	game["flags"][param_00] = 1;
	level notify(param_00);
}

//Function Number: 229
gameflagclear(param_00)
{
	game["flags"][param_00] = 0;
}

//Function Number: 230
gameflagwait(param_00)
{
	while(!gameflag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 231
isbulletdamage(param_00)
{
	var_01 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";
	if(issubstr(var_01,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 232
isfmjdamage(param_00,param_01,param_02)
{
	return isdefined(param_02) && isplayer(param_02) && param_02 _hasperk("specialty_bulletpenetration") && isdefined(param_01) && isbulletdamage(param_01);
}

//Function Number: 233
initlevelflags()
{
	if(!isdefined(level.levelflags))
	{
		level.levelflags = [];
	}
}

//Function Number: 234
levelflaginit(param_00,param_01)
{
	level.levelflags[param_00] = param_01;
}

//Function Number: 235
levelflag(param_00)
{
	return level.levelflags[param_00];
}

//Function Number: 236
levelflagset(param_00)
{
	level.levelflags[param_00] = 1;
	level notify(param_00);
}

//Function Number: 237
levelflagclear(param_00)
{
	level.levelflags[param_00] = 0;
	level notify(param_00);
}

//Function Number: 238
levelflagwait(param_00)
{
	while(!levelflag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 239
levelflagwaitopen(param_00)
{
	while(levelflag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 240
invirtuallobby()
{
	if(!isdefined(level.virtuallobbyactive) || level.virtuallobbyactive == 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 241
initglobals()
{
	if(!isdefined(level.global_tables))
	{
		level.global_tables["killstreakTable"] = spawnstruct();
		level.global_tables["killstreakTable"].path = "mp/killstreakTable.csv";
		level.global_tables["killstreakTable"].index_col = 0;
		level.global_tables["killstreakTable"].ref_col = 1;
		level.global_tables["killstreakTable"].name_col = 2;
		level.global_tables["killstreakTable"].desc_col = 3;
		level.global_tables["killstreakTable"].adrenaline_col = 4;
		level.global_tables["killstreakTable"].earned_hint_col = 5;
		level.global_tables["killstreakTable"].sound_col = 6;
		level.global_tables["killstreakTable"].earned_dialog_col = 7;
		level.global_tables["killstreakTable"].allies_dialog_col = 8;
		level.global_tables["killstreakTable"].opfor_dialog_col = 9;
		level.global_tables["killstreakTable"].enemy_use_dialog_col = 10;
		level.global_tables["killstreakTable"].weapon_col = 11;
		level.global_tables["killstreakTable"].score_col = 12;
		level.global_tables["killstreakTable"].icon_col = 13;
		level.global_tables["killstreakTable"].overhead_icon_col = 14;
		level.global_tables["killstreakTable"].overhead_icon_col_plus1 = 15;
		level.global_tables["killstreakTable"].overhead_icon_col_plus2 = 16;
		level.global_tables["killstreakTable"].overhead_icon_col_plus3 = 17;
		level.global_tables["killstreakTable"].dpad_icon_col = 18;
		level.global_tables["killstreakTable"].unearned_icon_col = 19;
	}
}

//Function Number: 242
iskillstreakdenied()
{
	if(invirtuallobby())
	{
		return 0;
	}

	return isemped() || isairdenied();
}

//Function Number: 243
isemped()
{
	if(self.team == "spectator")
	{
		return 0;
	}

	if(invirtuallobby())
	{
		return 0;
	}

	if(level.teambased)
	{
		return level.teamemped[self.team] || isdefined(self.empgrenaded) && self.empgrenaded;
	}

	return (isdefined(level.empplayer) && level.empplayer != self) || isdefined(self.empgrenaded) && self.empgrenaded;
}

//Function Number: 244
isempedbykillstreak()
{
	if(self.team == "spectator")
	{
		return 0;
	}

	if(invirtuallobby())
	{
		return 0;
	}

	if(level.teambased)
	{
		return level.teamemped[self.team];
	}

	return isdefined(level.empplayer) && level.empplayer != self;
}

//Function Number: 245
isairdenied()
{
	return 0;
}

//Function Number: 246
isnuked()
{
	if(self.team == "spectator")
	{
		return 0;
	}

	return isdefined(self.nuked);
}

//Function Number: 247
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

//Function Number: 248
teamplayercardsplash(param_00,param_01,param_02,param_03)
{
	if(level.hardcoremode)
	{
		return;
	}

	foreach(var_05 in level.players)
	{
		if(isdefined(param_02) && var_05.team != param_02)
		{
			continue;
		}

		if(!isplayer(var_05))
		{
			continue;
		}

		var_05 thread maps\mp\gametypes\_hud_message::playercardsplashnotify(param_00,param_01,param_03);
	}
}

//Function Number: 249
iscacprimaryweapon(param_00)
{
	switch(getweaponclass(param_00))
	{
		case "weapon_special":
		case "weapon_heavy":
		case "weapon_shotgun":
		case "weapon_lmg":
		case "weapon_sniper":
		case "weapon_riot":
		case "weapon_assault":
		case "weapon_smg":
			break;

		default:
			break;
	}
}

//Function Number: 250
iscacsecondaryweapon(param_00)
{
	switch(getweaponclass(param_00))
	{
		case "weapon_sec_special":
		case "weapon_machine_pistol":
		case "weapon_pistol":
		case "weapon_projectile":
			break;

		default:
			break;
	}
}

//Function Number: 251
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

//Function Number: 252
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

//Function Number: 253
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

		wait(param_01);
		if(self.health == self.maxhealth && var_02 >= param_00)
		{
			break;
		}
	}
}

//Function Number: 254
attachmentmap_tounique(param_00,param_01)
{
	var_02 = param_00;
	param_01 = getbaseweaponname(param_01,1);
	if(param_01 != "iw5_dlcgun6loot5" && islootweapon(param_01))
	{
		param_01 = maps\mp\gametypes\_class::getbasefromlootversion(param_01);
	}

	if(isdefined(level.attachmentmap_basetounique[param_01]) && isdefined(level.attachmentmap_basetounique[param_01][param_00]))
	{
		var_02 = level.attachmentmap_basetounique[param_01][param_00];
	}
	else
	{
		var_03 = tablelookup("mp/statstable.csv",4,param_01,2);
		if(isdefined(level.attachmentmap_basetounique[var_03]) && isdefined(level.attachmentmap_basetounique[var_03][param_00]))
		{
			var_02 = level.attachmentmap_basetounique[var_03][param_00];
		}
	}

	return var_02;
}

//Function Number: 255
attachmentperkmap(param_00)
{
	var_01 = undefined;
	if(isdefined(level.attachmentmap_attachtoperk[param_00]))
	{
		var_01 = level.attachmentmap_attachtoperk[param_00];
	}

	return var_01;
}

//Function Number: 256
isattachmentsniperscopedefault(param_00,param_01)
{
	var_02 = strtok(param_00,"_");
	return isattachmentsniperscopedefaulttokenized(var_02,param_01);
}

//Function Number: 257
isattachmentsniperscopedefaulttokenized(param_00,param_01)
{
	var_02 = 0;
	if(param_00.size && isdefined(param_01))
	{
		var_03 = 0;
		if(param_00[0] == "alt")
		{
			var_03 = 1;
		}

		if(param_00.size >= 3 + var_03 && param_00[var_03] == "iw5" || param_00[var_03] == "iw6")
		{
			if(weaponclass(param_00[var_03] + "_" + param_00[var_03 + 1] + "_" + param_00[var_03 + 2]) == "sniper")
			{
				var_02 = param_00[var_03 + 1] + "scope" == param_01;
			}
		}
	}

	return var_02;
}

//Function Number: 258
getweaponattachmentsbasenames(param_00)
{
	var_01 = getweaponattachments(param_00);
	foreach(var_04, var_03 in var_01)
	{
		var_01[var_04] = attachmentmap_tobase(var_03);
	}

	return var_01;
}

//Function Number: 259
getattachmentlistbasenames()
{
	var_00 = [];
	var_01 = 0;
	var_02 = tablelookup("mp/attachmentTable.csv",0,var_01,4);
	while(var_02 != "")
	{
		if(!common_scripts\utility::array_contains(var_00,var_02))
		{
			var_00[var_00.size] = var_02;
		}

		var_01++;
		var_02 = tablelookup("mp/attachmentTable.csv",0,var_01,4);
	}

	return var_00;
}

//Function Number: 260
getattachmentlistuniqenames()
{
	var_00 = [];
	var_01 = 0;
	var_02 = tablelookup("mp/attachmentTable.csv",0,var_01,3);
	while(var_02 != "")
	{
		var_00[var_00.size] = var_02;
		var_01++;
		var_02 = tablelookup("mp/attachmentTable.csv",0,var_01,3);
	}

	return var_00;
}

//Function Number: 261
buildattachmentmaps()
{
	var_00 = getattachmentlistuniqenames();
	level.attachmentmap_uniquetobase = [];
	foreach(var_02 in var_00)
	{
		var_03 = tablelookup("mp/attachmentTable.csv",3,var_02,4);
		if(var_02 == var_03)
		{
			continue;
		}

		level.attachmentmap_uniquetobase[var_02] = var_03;
	}

	var_05 = [];
	var_06 = 1;
	var_07 = tablelookupbyrow("mp/attachmentmap.csv",var_06,0);
	while(var_07 != "")
	{
		var_05[var_05.size] = var_07;
		var_06++;
		var_07 = tablelookupbyrow("mp/attachmentmap.csv",var_06,0);
	}

	var_08 = [];
	var_09 = 1;
	var_0A = tablelookupbyrow("mp/attachmentmap.csv",0,var_09);
	while(var_0A != "")
	{
		var_08[var_0A] = var_09;
		var_09++;
		var_0A = tablelookupbyrow("mp/attachmentmap.csv",0,var_09);
	}

	level.attachmentmap_basetounique = [];
	foreach(var_07 in var_05)
	{
		foreach(var_0F, var_0D in var_08)
		{
			var_0E = tablelookup("mp/attachmentmap.csv",0,var_07,var_0D);
			if(var_0E == "")
			{
				continue;
			}

			if(!isdefined(level.attachmentmap_basetounique[var_07]))
			{
				level.attachmentmap_basetounique[var_07] = [];
			}

			level.attachmentmap_basetounique[var_07][var_0F] = var_0E;
		}
	}

	level.attachmentmap_attachtoperk = [];
	foreach(var_12 in var_00)
	{
		var_13 = tablelookup("mp/attachmentTable.csv",3,var_12,8);
		if(var_13 == "")
		{
			continue;
		}

		level.attachmentmap_attachtoperk[var_12] = var_13;
	}
}

//Function Number: 262
attachmentmap_tobase(param_00)
{
	if(isdefined(level.attachmentmap_uniquetobase[param_00]))
	{
		param_00 = level.attachmentmap_uniquetobase[param_00];
	}

	return param_00;
}

//Function Number: 263
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

//Function Number: 264
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

	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(getmapname() == "mp_torqued")
		{
			if(isdefined(level.hordeavalanche) && level.hordeavalanche && isdefined(level.dyneventavalanche.status) && level.dyneventavalanche.status != "post_avalanche")
			{
				var_07 = getentarray("quake_kill_volume01","targetname");
				foreach(var_09 in var_07)
				{
					if(self istouching(var_09))
					{
						return 1;
					}
				}
			}
		}
		else if(getmapname() == "mp_lost")
		{
			foreach(var_0C in level.hordekilltriggers)
			{
				if(self istouching(var_0C))
				{
					return 1;
				}
			}
		}
	}

	if(getdvar("g_gametype") == "hp" && isdefined(level.zone) && isdefined(level.zone.trig) && self istouching(level.zone.trig))
	{
		return 1;
	}

	return 0;
}

//Function Number: 265
setthirdpersondof(param_00)
{
	if(param_00)
	{
		self setdepthoffield(0,110,512,4096,6,1.8);
		return;
	}

	self setdepthoffield(0,0,512,512,4,0);
}

//Function Number: 266
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

//Function Number: 267
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

//Function Number: 268
drawline(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 269
drawsphere(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 270
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
		self playerrecoilscaleoff();
		return;
	}

	self playerrecoilscaleon(var_02);
}

//Function Number: 271
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

//Function Number: 272
notusableforjoiningplayers(param_00)
{
	self notify("notusablejoiningplayers");
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	self endon("notusablejoiningplayers");
	for(;;)
	{
		level waittill("player_spawned",var_01);
		if(isdefined(var_01) && var_01 != param_00)
		{
			self disableplayeruse(var_01);
		}
	}
}

//Function Number: 273
isstrstart(param_00,param_01)
{
	return getsubstr(param_00,0,param_01.size) == param_01;
}

//Function Number: 274
disableallstreaks()
{
	level.killstreaksdisabled = 1;
}

//Function Number: 275
enableallstreaks()
{
	level.killstreaksdisabled = undefined;
}

//Function Number: 276
validateusestreak(param_00,param_01)
{
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}
	else
	{
		var_03 = self.pers["killstreaks"];
		var_02 = var_03[self.killstreakindexweapon].streakname;
	}

	if(isdefined(level.killstreaksdisabled) && level.killstreaksdisabled)
	{
		return 0;
	}

	if(isdefined(self.killstreaksdisabled) && self.killstreaksdisabled)
	{
		return 0;
	}

	if(!self isonground() && isridekillstreak(var_02))
	{
		return 0;
	}

	if(isusingremote() || isinremotetransition())
	{
		return 0;
	}

	if(isdefined(self.selectinglocation))
	{
		return 0;
	}

	if(shouldpreventearlyuse(var_02) && level.killstreakrounddelay)
	{
		var_04 = 0;
		if(isdefined(level.prematch_done_time))
		{
			var_04 = gettime() - level.prematch_done_time / 1000;
		}

		if(var_04 < level.killstreakrounddelay)
		{
			var_05 = int(level.killstreakrounddelay - var_04 + 0.5);
			if(!var_05)
			{
				var_05 = 1;
			}

			if(!isdefined(param_01) && param_01)
			{
				self iprintlnbold(&"MP_UNAVAILABLE_FOR_N",var_05);
			}

			return 0;
		}
	}

	if(isemped() && !isdefined(level.iszombiegame) || !level.iszombiegame)
	{
		if(!isdefined(var_02) && var_02)
		{
			if(isdefined(level.emptimeremaining) && level.emptimeremaining > 0)
			{
				self iprintlnbold(&"MP_UNAVAILABLE_FOR_N_WHEN_EMP",level.emptimeremaining);
			}
			else if(isdefined(self.empendtime) && int(self.empendtime - gettime() / 1000) > 0)
			{
				self iprintlnbold(&"MP_UNAVAILABLE_FOR_N",int(self.empendtime - gettime() / 1000));
			}
		}

		return 0;
	}

	if(self isusingturret() && isridekillstreak(var_04) || iscarrykillstreak(var_04))
	{
		if(!isdefined(var_02) && var_02)
		{
			self iprintlnbold(&"MP_UNAVAILABLE_USING_TURRET");
		}

		return 0;
	}

	if(isjuggernaut())
	{
		return 0;
	}

	if(isdefined(self.laststand) && !_hasperk("specialty_finalstand"))
	{
		if(!isdefined(var_02) && var_02)
		{
			self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		}

		return 0;
	}

	if(!common_scripts\utility::isweaponenabled())
	{
		return 0;
	}

	return 1;
}

//Function Number: 277
isridekillstreak(param_00)
{
	switch(param_00)
	{
		case "mp_seoul2":
		case "mp_bigben2":
		case "assault_ugv":
		case "warbird":
		case "recon_ugv":
		case "mp_recreation":
		case "orbitalsupport":
		case "orbital_strike_drone":
		case "orbital_strike_cluster":
		case "orbital_strike_laser_chem":
		case "orbital_strike_chem":
		case "orbital_strike_laser":
		case "orbital_strike":
		case "missile_strike":
		case "mp_terrace":
		case "mp_solar":
		case "mp_levity":
		case "mp_detroit":
		case "mp_dam":
			break;

		default:
			break;
	}
}

//Function Number: 278
iscarrykillstreak(param_00)
{
	switch(param_00)
	{
		case "remote_mg_sentry_turret":
		case "deployable_exp_ammo":
		case "deployable_grenades":
		case "deployable_ammo":
		case "sentry":
			break;

		default:
			break;
	}
}

//Function Number: 279
shouldpreventearlyuse(param_00)
{
	switch(param_00)
	{
		case "strafing_run_airstrike":
		case "warbird":
		case "orbitalsupport":
		case "orbital_strike_laser":
		case "missile_strike":
			break;
	}
}

//Function Number: 280
iskillstreakaffectedbyemp(param_00)
{
	switch(param_00)
	{
		case "refill_grenades":
		case "speed_boost":
		case "eyes_on":
		case "high_value_target":
		case "recon_agent":
		case "agent":
		case "placeable_barrier":
		case "deployable_juicebox":
		case "deployable_grenades":
		case "deployable_ammo":
			break;

		default:
			break;
	}
}

//Function Number: 281
iskillstreakaffectedbyjammer(param_00)
{
	return iskillstreakaffectedbyemp(param_00) && !isflyingkillstreak(param_00);
}

//Function Number: 282
isflyingkillstreak(param_00)
{
	switch(param_00)
	{
		case "orbital_carepackag":
		case "airdrop_support":
		case "airdrop_assault":
		case "airdrop_sentry_minigun":
		case "orbitalsupport":
		case "orbital_strike_drone":
		case "orbital_strike_cluster":
		case "orbital_strike_laser_chem":
		case "orbital_strike_chem":
		case "orbital_strike_laser":
		case "orbital_strike":
		case "missile_strike":
			break;

		default:
			break;
	}
}

//Function Number: 283
isallteamstreak(param_00)
{
	var_01 = getkillstreakallteamstreak(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	if(int(var_01) == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 284
getkillstreakrownum(param_00)
{
	return tablelookuprownum(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00);
}

//Function Number: 285
getkillstreakindex(param_00)
{
	var_01 = tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].index_col);
	if(var_01 == "")
	{
		var_02 = -1;
	}
	else
	{
		var_02 = int(var_02);
	}

	return var_02;
}

//Function Number: 286
getkillstreakreference(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].ref_col);
}

//Function Number: 287
getkillstreakname(param_00)
{
	return tablelookupistring(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].name_col);
}

//Function Number: 288
getkillstreakdescription(param_00)
{
	return tablelookupistring(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].desc_col);
}

//Function Number: 289
getkillstreakkills(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].adrenaline_col);
}

//Function Number: 290
getkillstreakearnedhint(param_00)
{
	return tablelookupistring(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].earned_hint_col);
}

//Function Number: 291
getkillstreaksound(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].sound_col);
}

//Function Number: 292
getkillstreakearneddialog(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].earned_dialog_col);
}

//Function Number: 293
getkillstreakalliesdialog(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].allies_dialog_col);
}

//Function Number: 294
getkillstreakenemydialog(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].enemy_dialog_col);
}

//Function Number: 295
getkillstreakenemyusedialog(param_00)
{
	return int(tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].enemy_use_dialog_col));
}

//Function Number: 296
getkillstreakweapon(param_00,param_01)
{
	if(isdefined(param_01) && param_01.size > 0)
	{
		var_02 = _getmodulekillstreakweapon(param_00,param_01);
		if(isdefined(var_02))
		{
			return var_02;
		}
	}

	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].weapon_col);
}

//Function Number: 297
_getmodulekillstreakweapon(param_00,param_01)
{
	var_02 = param_01;
	var_04 = getfirstarraykey(var_02);
	if(isdefined(var_04))
	{
		var_03 = var_02[var_04];
		switch(var_03)
		{
			case "warbird_ai_follow":
			case "warbird_ai_attack":
				break;

			case "assault_ugv_ai":
				break;

			case "turretheadmg_mp":
			case "turretheadrocket_mp":
			case "turretheadenergy_mp":
				break;

			default:
				break;
		}
	}
}

//Function Number: 298
getkillstreakscore(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].score_col);
}

//Function Number: 299
getkillstreakicon(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].icon_col);
}

//Function Number: 300
getkillstreakoverheadicon(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].overhead_icon_col);
}

//Function Number: 301
getkillstreakdpadicon(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].dpad_icon_col);
}

//Function Number: 302
getkillstreakunearnedicon(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].unearned_icon_col);
}

//Function Number: 303
getkillstreakallteamstreak(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].all_team_streak_col);
}

//Function Number: 304
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

	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(isdefined(level.flying_attack_drones))
		{
			var_01 = var_01 + level.flying_attack_drones.size;
		}

		if(isdefined(level.trackingdrones))
		{
			var_01 = var_01 + level.trackingdrones.size;
		}
	}

	return var_01;
}

//Function Number: 305
maxvehiclesallowed()
{
	return 8;
}

//Function Number: 306
incrementfauxvehiclecount()
{
	level.fauxvehiclecount++;
}

//Function Number: 307
decrementfauxvehiclecount()
{
	level.fauxvehiclecount--;
	if(level.fauxvehiclecount < 0)
	{
		level.fauxvehiclecount = 0;
	}
}

//Function Number: 308
lightweightscalar(param_00)
{
	return 1.07;
}

//Function Number: 309
allowteamchoice()
{
	if(!isshipbuild() && getdvarint("scr_skipclasschoice",0) > 0)
	{
		return 0;
	}

	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.gametype,4));
	return var_00;
}

//Function Number: 310
allowclasschoice()
{
	if(!isshipbuild() && getdvarint("scr_skipclasschoice",0) > 0)
	{
		return 0;
	}

	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.gametype,5));
	return var_00;
}

//Function Number: 311
showgenericmenuonmatchstart()
{
	if(allowteamchoice() || allowclasschoice())
	{
		return 0;
	}

	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.gametype,7));
	return var_00;
}

//Function Number: 312
isbuffequippedonweapon(param_00,param_01)
{
	return 0;
}

//Function Number: 313
setcommonrulesfrommatchrulesdata(param_00)
{
	var_01 = getmatchrulesdata("commonOption","timeLimit");
	setdynamicdvar("scr_" + level.gametype + "_timeLimit",var_01);
	registertimelimitdvar(level.gametype,var_01);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_" + level.gametype + "_scoreLimit",var_02);
	registerscorelimitdvar(level.gametype,var_02);
	setdynamicdvar("scr_game_matchstarttime",getmatchrulesdata("commonOption","preMatchTimer"));
	setdynamicdvar("scr_game_roundstarttime",getmatchrulesdata("commonOption","preRoundTimer"));
	setdynamicdvar("scr_game_suicidespawndelay",getmatchrulesdata("commonOption","suicidePenalty"));
	setdynamicdvar("scr_team_teamkillspawndelay",getmatchrulesdata("commonOption","teamKillPenalty"));
	setdynamicdvar("scr_team_teamkillkicklimit",getmatchrulesdata("commonOption","teamKillKickLimit"));
	var_03 = getmatchrulesdata("commonOption","numLives");
	setdynamicdvar("scr_" + level.gametype + "_numLives",var_03);
	registernumlivesdvar(level.gametype,var_03);
	setdynamicdvar("scr_player_maxhealth",getmatchrulesdata("commonOption","maxHealth"));
	setdynamicdvar("scr_player_healthregentime",getmatchrulesdata("commonOption","healthRegen"));
	level.matchrules_damagemultiplier = 0;
	level.matchrules_vampirism = 0;
	setdynamicdvar("scr_game_spectatetype",getmatchrulesdata("commonOption","spectateModeAllowed"));
	setdynamicdvar("scr_game_lockspectatorpov",getmatchrulesdata("commonOption","spectateModePOV"));
	setdynamicdvar("scr_game_allowkillcam",getmatchrulesdata("commonOption","showKillcam"));
	setdynamicdvar("scr_game_forceuav",getmatchrulesdata("commonOption","radarAlwaysOn"));
	setdynamicdvar("scr_" + level.gametype + "_playerrespawndelay",getmatchrulesdata("commonOption","respawnDelay"));
	setdynamicdvar("scr_" + level.gametype + "_waverespawndelay",getmatchrulesdata("commonOption","waveRespawnDelay"));
	setdynamicdvar("scr_player_forcerespawn",getmatchrulesdata("commonOption","forceRespawn"));
	level.matchrules_allowcustomclasses = getmatchrulesdata("commonOption","allowCustomClasses");
	level.customclasspickcount = getmatchrulesdata("commonOption","classPickCount");
	setdynamicdvar("scr_game_high_jump",getmatchrulesdata("commonOption","highJump"));
	setdynamicdvar("jump_slowdownEnable",getdvar("scr_game_high_jump") == "0");
	setdynamicdvar("scr_game_hardpoints",1);
	setdynamicdvar("scr_game_perks",1);
	setdynamicdvar("g_hardcore",getmatchrulesdata("commonOption","hardcoreModeOn"));
	setdynamicdvar("scr_thirdPerson",getmatchrulesdata("commonOption","forceThirdPersonView"));
	setdynamicdvar("camera_thirdPerson",getmatchrulesdata("commonOption","forceThirdPersonView"));
	setdynamicdvar("scr_game_onlyheadshots",getmatchrulesdata("commonOption","headshotsOnly"));
	if(!isdefined(param_00))
	{
		setdynamicdvar("scr_team_fftype",getmatchrulesdata("commonOption","ffType"));
	}

	setdynamicdvar("scr_game_killstreakdelay",getmatchrulesdata("commonOption","streakGracePeriod"));
	level.dynamiceventstype = getmatchrulesdata("commonOption","dynamicEventsType");
	level.mapstreaksdisabled = getmatchrulesdata("commonOption","mapStreaksDisabled");
	level.chatterdisabled = getmatchrulesdata("commonOption","chatterDisabled");
	level.announcerdisabled = getmatchrulesdata("commonOption","announcerDisabled");
	level.matchrules_switchteamdisabled = getmatchrulesdata("commonOption","switchTeamDisabled");
	level.grenadegraceperiod = getmatchrulesdata("commonOption","grenadeGracePeriod");
	if(getmatchrulesdata("commonOption","hardcoreModeOn"))
	{
		setdynamicdvar("scr_team_fftype",1);
		setdynamicdvar("scr_player_maxhealth",30);
		setdynamicdvar("scr_player_healthregentime",0);
		setdynamicdvar("scr_player_respawndelay",10);
		setdynamicdvar("scr_game_allowkillcam",0);
		setdynamicdvar("scr_game_forceuav",0);
	}

	setdvar("bg_compassShowEnemies",getdvar("scr_game_forceuav"));
}

//Function Number: 314
reinitializematchrulesonmigration()
{
	for(;;)
	{
		level waittill("host_migration_begin");
		[[ level.initializematchrules ]]();
	}
}

//Function Number: 315
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

//Function Number: 316
getmatchrulesspecialclass(param_00,param_01)
{
	var_02 = [];
	var_02["loadoutPrimary"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"weapon");
	var_02["loadoutPrimaryAttachment"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"attachment",0);
	var_02["loadoutPrimaryAttachment2"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"attachment",1);
	var_02["loadoutPrimaryAttachment3"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"attachment",2);
	var_02["loadoutPrimaryCamo"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"camo");
	var_02["loadoutPrimaryReticle"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"reticle");
	var_02["loadoutSecondary"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"weapon");
	var_02["loadoutSecondaryAttachment"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"attachment",0);
	var_02["loadoutSecondaryAttachment2"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"attachment",1);
	var_02["loadoutSecondaryAttachment3"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"attachment",2);
	var_02["loadoutSecondaryCamo"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"camo");
	var_02["loadoutSecondaryReticle"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"reticle");
	var_02["loadoutEquipment"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","equipmentSetups",0,"equipment");
	var_02["loadoutEquipmentExtra"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","equipmentSetups",0,"extra");
	var_02["loadoutOffhand"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","equipmentSetups",1,"equipment");
	var_02["loadoutOffhandExtra"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","equipmentSetups",1,"extra");
	for(var_03 = 0;var_03 < 6;var_03++)
	{
		var_02["loadoutPerks"][var_03] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","perkSlots",var_03);
	}

	for(var_03 = 0;var_03 < 3;var_03++)
	{
		var_02["loadoutWildcards"][var_03] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","wildcardSlots",var_03);
	}

	for(var_03 = 0;var_03 < 4;var_03++)
	{
		var_02["loadoutKillstreaks"][var_03] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","assaultStreaks",var_03,"streak");
		for(var_04 = 0;var_04 < 3;var_04++)
		{
			var_02["loadoutKillstreakModules"][var_03][var_04] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","assaultStreaks",var_03,"modules",var_04);
		}
	}

	var_02["loadoutJuggernaut"] = getmatchrulesdata("defaultClasses",param_00,param_01,"juggernaut");
	return var_02;
}

//Function Number: 317
recipeclassapplyjuggernaut(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	if(!isdefined(level.ishorde) && !isdefined(level.iszombiegame) && level.iszombiegame)
	{
		if(level.ingraceperiod && !self.hasdonecombat)
		{
			self waittill("applyLoadout");
		}
		else
		{
			self waittill("spawned_player");
		}
	}
	else
	{
		self waittill("applyLoadout");
	}

	if(param_00)
	{
		self notify("lost_juggernaut");
		wait(0.5);
	}

	if(!isdefined(self.isjuiced))
	{
		self.movespeedscaler = 0.7;
		maps\mp\gametypes\_weapons::updatemovespeedscale();
	}

	self.juggmovespeedscaler = 0.7;
	self disableweaponpickup();
	if(!getdvarint("camera_thirdPerson") && !isdefined(level.ishorde) && !isdefined(level.iszombiegame) && level.iszombiegame)
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
		var_01 = spawn("script_model",self.origin);
		var_01.team = self.team;
		var_01 makeportableradar(self);
		self.personalradar = var_01;
		thread maps\mp\killstreaks\_juggernaut::radarmover(var_01);
	}

	level notify("juggernaut_equipped",self);
	thread maps\mp\killstreaks\_juggernaut::juggremover();
}

//Function Number: 318
updatesessionstate(param_00)
{
	self.sessionstate = param_00;
	self setclientomnvar("ui_session_state",param_00);
}

//Function Number: 319
cac_getcustomclassloc()
{
	if(isdefined(level.forcecustomclassloc))
	{
		return level.forcecustomclassloc;
	}

	if(getdvarint("xblive_privatematch") || issystemlink())
	{
		return "privateMatchCustomClasses";
	}

	return "customClasses";
}

//Function Number: 320
getclassindex(param_00)
{
	return level.classmap[param_00];
}

//Function Number: 321
isteaminlaststand()
{
	var_00 = getlivingplayers(self.team);
	foreach(var_02 in var_00)
	{
		if(var_02 != self && !isdefined(var_02.laststand) || !var_02.laststand)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 322
killteaminlaststand(param_00)
{
	var_01 = getlivingplayers(param_00);
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.laststand) && var_03.laststand)
		{
			var_03 thread maps\mp\gametypes\_damage::dieaftertime(randomintrange(1,3));
		}
	}
}

//Function Number: 323
switch_to_last_weapon(param_00)
{
	if(!isai(self))
	{
		self switchtoweapon(param_00);
		return;
	}

	self switchtoweapon("none");
}

//Function Number: 324
isaiteamparticipant(param_00)
{
	if(isagent(param_00) && param_00.agent_teamparticipant == 1)
	{
		return 1;
	}

	if(isbot(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 325
isteamparticipant(param_00)
{
	if(isaiteamparticipant(param_00))
	{
		return 1;
	}

	if(isplayer(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 326
isaigameparticipant(param_00)
{
	if(isagent(param_00) && param_00.agent_gameparticipant == 1)
	{
		return 1;
	}

	if(isbot(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 327
isgameparticipant(param_00)
{
	if(isaigameparticipant(param_00))
	{
		return 1;
	}

	if(isplayer(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 328
getteamindex(param_00)
{
	var_01 = 0;
	if(level.teambased)
	{
		switch(param_00)
		{
			case "axis":
				break;

			case "allies":
				break;
		}
	}
}

//Function Number: 329
ismeleemod(param_00)
{
	return param_00 == "MOD_MELEE" || param_00 == "MOD_MELEE_ALT";
}

//Function Number: 330
isheadshot(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		if(isdefined(param_03.owner))
		{
			if(param_03.code_classname == "script_vehicle")
			{
				return 0;
			}

			if(param_03.code_classname == "misc_turret")
			{
				return 0;
			}

			if(param_03.code_classname == "script_model")
			{
				return 0;
			}
		}

		if(isdefined(param_03.agent_type))
		{
			if(param_03.agent_type == "dog" || param_03.agent_type == "alien")
			{
				return 0;
			}
		}
	}

	return (param_01 == "head" || param_01 == "helmet") && !ismeleemod(param_02) && param_02 != "MOD_IMPACT" && !isenvironmentweapon(param_00);
}

//Function Number: 331
attackerishittingteam(param_00,param_01)
{
	if(!level.teambased)
	{
		return 0;
	}

	if(!isdefined(param_01) || !isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.team) || !isdefined(param_01.team))
	{
		return 0;
	}

	if(param_00 == param_01)
	{
		return 0;
	}

	if(param_00.pers["team"] == param_01.team && isdefined(param_01.teamchangedthisframe))
	{
		return 0;
	}

	if(isdefined(param_01.scrambled) && param_01.scrambled)
	{
		return 0;
	}

	if(param_00.team == param_01.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 332
set_high_priority_target_for_bot(param_00)
{
	if(!isdefined(self.high_priority_for) && common_scripts\utility::array_contains(self.high_priority_for,param_00))
	{
		self.high_priority_for = common_scripts\utility::array_add(self.high_priority_for,param_00);
		param_00 notify("calculate_new_level_targets");
	}
}

//Function Number: 333
add_to_bot_use_targets(param_00,param_01)
{
	if(isdefined(level.bot_funcs["bots_add_to_level_targets"]))
	{
		param_00.use_time = param_01;
		param_00.bot_interaction_type = "use";
		[[ level.bot_funcs["bots_add_to_level_targets"] ]](param_00);
	}
}

//Function Number: 334
remove_from_bot_use_targets(param_00)
{
	if(isdefined(level.bot_funcs["bots_remove_from_level_targets"]))
	{
		[[ level.bot_funcs["bots_remove_from_level_targets"] ]](param_00);
	}
}

//Function Number: 335
add_to_bot_damage_targets(param_00)
{
	if(isdefined(level.bot_funcs["bots_add_to_level_targets"]))
	{
		param_00.bot_interaction_type = "damage";
		[[ level.bot_funcs["bots_add_to_level_targets"] ]](param_00);
	}
}

//Function Number: 336
remove_from_bot_damage_targets(param_00)
{
	if(isdefined(level.bot_funcs["bots_remove_from_level_targets"]))
	{
		[[ level.bot_funcs["bots_remove_from_level_targets"] ]](param_00);
	}
}

//Function Number: 337
notify_enemy_bots_bomb_used(param_00)
{
	if(isdefined(level.bot_funcs["notify_enemy_bots_bomb_used"]))
	{
		self [[ level.bot_funcs["notify_enemy_bots_bomb_used"] ]](param_00);
	}
}

//Function Number: 338
get_rank_xp_and_prestige_for_bot()
{
	if(isdefined(level.bot_funcs["bot_get_rank_xp_and_prestige"]))
	{
		return self [[ level.bot_funcs["bot_get_rank_xp_and_prestige"] ]]();
	}
}

//Function Number: 339
set_rank_xp_and_prestige_for_bot()
{
	var_00 = get_rank_xp_and_prestige_for_bot();
	if(isdefined(var_00))
	{
		self.pers["rankxp"] = var_00.rankxp;
		self.pers["prestige"] = var_00.prestige;
		self.pers["prestige_fake"] = var_00.prestige;
	}
}

//Function Number: 340
set_console_status()
{
	if(!isdefined(level.console))
	{
		level.console = getdvar("consoleGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.xenon))
	{
		level.xenon = getdvar("xenonGame") == "true";
	}
	else
	{
	}

	if(!isdefined(level.ps3))
	{
		level.ps3 = getdvar("ps3Game") == "true";
	}
	else
	{
	}

	if(!isdefined(level.xb3))
	{
		level.xb3 = getdvar("xb3Game") == "true";
	}
	else
	{
	}

	if(!isdefined(level.ps4))
	{
		level.ps4 = getdvar("ps4Game") == "true";
	}
}

//Function Number: 341
is_gen4()
{
	if(level.xb3 || level.ps4 || !level.console)
	{
		return 1;
	}

	return 0;
}

//Function Number: 342
setdvar_cg_ng(param_00,param_01,param_02)
{
	if(!isdefined(level.console) || !isdefined(level.xb3) || !isdefined(level.ps4))
	{
		set_console_status();
	}

	if(is_gen4())
	{
		setdvar(param_00,param_02);
		return;
	}

	setdvar(param_00,param_01);
}

//Function Number: 343
isvalidteamtarget(param_00,param_01)
{
	return isdefined(param_01.team) && param_01.team != param_00.team;
}

//Function Number: 344
isvalidffatarget(param_00,param_01)
{
	return isdefined(param_01.owner) && param_01.owner != param_00;
}

//Function Number: 345
gethelipilotmeshoffset()
{
	return (0,0,5000);
}

//Function Number: 346
gethelipilottraceoffset()
{
	return (0,0,2500);
}

//Function Number: 347
revertvisionsetforplayer(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(isdefined(level.nukedetonated) && isdefined(level.nukevisionset))
	{
		self setclienttriggervisionset(level.nukevisionset,param_00);
		self visionsetnakedforplayer(level.nukevisionset,param_00);
		set_visionset_for_watching_players(level.nukevisionset,param_00);
		return;
	}

	if(isdefined(self.usingremote) && isdefined(self.ridevisionset))
	{
		self setclienttriggervisionset(self.ridevisionset,param_00);
		self visionsetnakedforplayer(self.ridevisionset,param_00);
		set_visionset_for_watching_players(self.ridevisionset,param_00);
		return;
	}

	self setclienttriggervisionset("",param_00);
	self visionsetnakedforplayer("",param_00);
	set_visionset_for_watching_players("",param_00);
}

//Function Number: 348
set_light_set_for_player(param_00)
{
	if(!isplayer(self))
	{
		return;
	}

	if(isdefined(level.lightset_current))
	{
		level.lightset_previous = level.lightset_current;
	}

	level.lightset_current = param_00;
	self lightsetforplayer(param_00);
}

//Function Number: 349
clear_light_set_for_player()
{
	if(!isplayer(self))
	{
		return;
	}

	var_00 = getmapcustom("map");
	if(isdefined(level.lightset_previous))
	{
		var_00 = level.lightset_previous;
		level.lightset_previous = undefined;
	}

	level.lightset_current = var_00;
	self lightsetforplayer(var_00);
}

//Function Number: 350
light_set_override_for_player(param_00,param_01,param_02,param_03)
{
	if(!isplayer(self))
	{
		return;
	}

	self lightsetoverrideenableforplayer(param_00,param_01);
	waitfortimeornotifies(param_02,["death","disconnect"]);
	if(isdefined(self))
	{
		self lightsetoverrideenableforplayer(param_03);
	}
}

//Function Number: 351
getuniqueid()
{
	if(isdefined(self.pers["guid"]))
	{
		return self.pers["guid"];
	}

	var_00 = self getguid();
	if(var_00 == "0000000000000000")
	{
		if(isdefined(level.guidgen))
		{
			level.guidgen++;
		}
		else
		{
			level.guidgen = 1;
		}

		var_00 = "script" + level.guidgen;
	}

	self.pers["guid"] = var_00;
	return self.pers["guid"];
}

//Function Number: 352
get_players_watching(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = self getentitynumber();
	var_03 = [];
	foreach(var_05 in level.players)
	{
		if(!isdefined(var_05) || var_05 == self)
		{
			continue;
		}

		var_06 = 0;
		if(!param_01)
		{
			if((isdefined(var_05.team) && var_05.team == "spectator") || var_05.sessionstate == "spectator")
			{
				var_07 = var_05 getspectatingplayer();
				if(isdefined(var_07) && var_07 == self)
				{
					var_06 = 1;
				}
			}

			if(var_05.forcespectatorclient == var_02)
			{
				var_06 = 1;
			}
		}

		if(!param_00)
		{
			if(var_05.killcamentity == var_02)
			{
				var_06 = 1;
			}
		}

		if(var_06)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 353
set_visionset_for_watching_players(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = get_players_watching(param_04,param_05);
	foreach(var_09 in var_07)
	{
		var_09 notify("changing_watching_visionset");
		if(isdefined(param_03) && param_03)
		{
			var_09 visionsetmissilecamforplayer(param_00,param_01);
		}
		else if(isdefined(param_06) && param_06)
		{
			var_09 visionsetpostapplyforplayer(param_00,param_01);
		}
		else
		{
			var_09 visionsetnakedforplayer(param_00,param_01);
		}

		if(param_00 != "" && isdefined(param_02))
		{
			var_09 thread reset_visionset_on_team_change(self,param_01 + param_02,param_06);
			var_09 thread reset_visionset_on_disconnect(self,param_06);
			if(var_09 isinkillcam())
			{
				var_09 thread reset_visionset_on_spawn();
			}
		}
	}
}

//Function Number: 354
reset_visionset_on_spawn()
{
	self endon("disconnect");
	self waittill("spawned");
	self visionsetnakedforplayer("",0);
	self visionsetpostapplyforplayer("",0);
}

//Function Number: 355
reset_visionset_on_team_change(param_00,param_01,param_02)
{
	self endon("changing_watching_visionset");
	param_00 endon("disconnect");
	var_03 = gettime();
	var_04 = self.team;
	while(gettime() - var_03 < param_01 * 1000)
	{
		if(self.team != var_04 || !common_scripts\utility::array_contains(param_00 get_players_watching(),self))
		{
			if(isdefined(param_02) && param_02)
			{
				self visionsetpostapplyforplayer("",0);
			}
			else
			{
				self visionsetnakedforplayer("",0);
			}

			self notify("changing_visionset");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 356
reset_visionset_on_disconnect(param_00,param_01)
{
	self endon("changing_watching_visionset");
	param_00 waittill("disconnect");
	if(isdefined(param_01) && param_01)
	{
		self visionsetpostapplyforplayer("",0);
		return;
	}

	self visionsetnakedforplayer("",0);
}

//Function Number: 357
_validateattacker(param_00)
{
	if(isagent(param_00) && !isdefined(param_00.isactive) || !param_00.isactive)
	{
		return undefined;
	}

	return param_00;
}

//Function Number: 358
_setnameplatematerial(param_00,param_01)
{
	if(!isdefined(self.nameplatematerial))
	{
		self.nameplatematerial = [];
		self.prevnameplatematerial = [];
	}
	else
	{
		self.prevnameplatematerial[0] = self.nameplatematerial[0];
		self.prevnameplatematerial[1] = self.nameplatematerial[1];
	}

	self.nameplatematerial[0] = param_00;
	self.nameplatematerial[1] = param_01;
	self setnameplatematerial(param_00,param_01);
}

//Function Number: 359
_restorepreviousnameplatematerial()
{
	if(isdefined(self.prevnameplatematerial))
	{
		self setnameplatematerial(self.prevnameplatematerial[0],self.prevnameplatematerial[1]);
	}
	else
	{
		self setnameplatematerial("","");
	}

	self.nameplatematerial = undefined;
	self.prevnameplatematerial = undefined;
}

//Function Number: 360
findandplayanims(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	if(var_02.size > 0)
	{
		foreach(var_04 in var_02)
		{
			var_05 = 0;
			if(isdefined(var_04.script_animation))
			{
				if(isdefined(var_04.script_parameters) && var_04.script_parameters == "delta_anim")
				{
					var_05 = 1;
				}

				var_04 thread playanim(param_01,var_05);
			}
		}
	}
}

//Function Number: 361
playanim(param_00,param_01)
{
	if(param_00 == 1)
	{
		wait(randomfloatrange(0,1));
	}

	if(param_01 == 0)
	{
		self scriptmodelplayanim(self.script_animation);
		return;
	}

	self scriptmodelplayanimdeltamotion(self.script_animation);
}

//Function Number: 362
playerallowhighjump(param_00,param_01)
{
	_playerallow("highjump",param_00,param_01,::allowhighjump);
}

//Function Number: 363
playerallowhighjumpdrop(param_00,param_01)
{
	_playerallow("highjumpdrop",param_00,param_01,::allowhighjumpdrop);
}

//Function Number: 364
playerallowboostjump(param_00,param_01)
{
	_playerallow("boostjump",param_00,param_01,::allowboostjump);
}

//Function Number: 365
playerallowpowerslide(param_00,param_01)
{
	_playerallow("powerslide",param_00,param_01,::allowpowerslide);
}

//Function Number: 366
playerallowdodge(param_00,param_01)
{
	_playerallow("dodge",param_00,param_01,::allowdodge);
}

//Function Number: 367
_playerallow(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(self.playerdisableabilitytypes))
	{
		self.playerdisableabilitytypes = [];
	}

	if(!isdefined(self.playerdisableabilitytypes[param_00]))
	{
		self.playerdisableabilitytypes[param_00] = [];
	}

	if(!isdefined(param_02))
	{
		param_02 = "default";
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(param_01)
	{
		self.playerdisableabilitytypes[param_00] = common_scripts\utility::array_remove(self.playerdisableabilitytypes[param_00],param_02);
		if(!self.playerdisableabilitytypes[param_00].size)
		{
			if(param_04)
			{
				self [[ param_03 ]](1);
				return;
			}

			self [[ param_03 ]](1);
			return;
		}

		return;
	}

	if(!isdefined(common_scripts\utility::array_find(self.playerdisableabilitytypes[param_00],param_02)))
	{
		self.playerdisableabilitytypes[param_00] = common_scripts\utility::array_add(self.playerdisableabilitytypes[param_00],param_02);
	}

	if(param_04)
	{
		self [[ param_03 ]](0);
		return;
	}

	self [[ param_03 ]](0);
}

//Function Number: 368
makegloballyusablebytype(param_00,param_01,param_02,param_03)
{
	var_04 = 500;
	switch(param_00)
	{
		case "killstreakRemote":
			break;

		case "coopStreakPrompt":
			break;

		default:
			break;
	}
}

//Function Number: 369
_insertintoglobalusablelist(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.globalusableents))
	{
		level.globalusableents = [];
	}

	var_04 = -1;
	for(var_05 = 0;var_05 < level.globalusableents.size;var_05++)
	{
		var_06 = level.globalusableents[var_05];
		if(var_06.priority > param_00)
		{
			if(var_04 == -1)
			{
				var_04 = var_05;
			}

			break;
		}

		if(var_06.priority == param_00)
		{
			var_06.priority = var_06.priority + 0.01;
			if(var_06.enabled)
			{
				var_06.ent makeglobalusable(var_06.priority,var_06.player,var_06.team);
			}

			if(var_04 == -1)
			{
				var_04 = var_05;
			}
		}
	}

	if(var_04 == -1)
	{
		var_04 = 0;
	}

	var_07 = spawnstruct();
	var_07.ent = self;
	var_07.priority = param_00;
	var_07.type = param_01;
	var_07.player = param_02;
	var_07.team = param_03;
	var_07.enabled = 1;
	level.globalusableents = common_scripts\utility::array_insert(level.globalusableents,var_07,var_04);
}

//Function Number: 370
makegloballyunusablebytype()
{
	var_00 = undefined;
	foreach(var_02 in level.globalusableents)
	{
		if(var_02.ent == self)
		{
			var_00 = var_02;
			break;
		}
	}

	if(isdefined(var_00))
	{
		var_04 = var_00.priority;
		level.globalusableents = common_scripts\utility::array_remove(level.globalusableents,var_00);
		self makeglobalunusable();
		foreach(var_02 in level.globalusableents)
		{
			if(var_04 > var_02.priority && int(var_04) == int(var_02.priority))
			{
				var_02.priority = var_02.priority - 0.01;
				if(var_02.enabled)
				{
					var_02.ent makeglobalusable(var_02.priority,var_02.player,var_02.team);
				}
			}
		}
	}
}

//Function Number: 371
disablegloballyusablebytype()
{
	foreach(var_01 in level.globalusableents)
	{
		if(var_01.ent == self)
		{
			if(var_01.enabled)
			{
				var_01.ent makeglobalunusable();
				var_01.enabled = 0;
			}

			break;
		}
	}
}

//Function Number: 372
enablegloballyusablebytype()
{
	foreach(var_01 in level.globalusableents)
	{
		if(var_01.ent == self)
		{
			if(!var_01.enabled)
			{
				var_01.ent makeglobalusable(var_01.priority,var_01.player,var_01.team);
				var_01.enabled = 1;
			}

			break;
		}
	}
}

//Function Number: 373
setdof(param_00)
{
	self setdepthoffield(param_00["nearStart"],param_00["nearEnd"],param_00["farStart"],param_00["farEnd"],param_00["nearBlur"],param_00["farBlur"]);
}

//Function Number: 374
is_exo_ability_weapon(param_00)
{
	switch(param_00)
	{
		case "iw5_dlcgun12loot7_mp":
		case "exomute_equipment_mp":
		case "exocloakhorde_equipment_mp":
		case "exohoverhorde_equipment_mp":
		case "exoshieldhorde_equipment_mp":
		case "exoshield_equipment_mp":
		case "exorepulsor_equipment_mp":
		case "exoping_equipment_mp":
		case "exohover_equipment_mp":
		case "exocloak_equipment_mp":
		case "extra_health_mp":
		case "adrenaline_mp":
			break;

		default:
			break;
	}
}

//Function Number: 375
isenemy(param_00)
{
	if(level.teambased)
	{
		return isplayeronenemyteam(param_00);
	}

	return isplayerffaenemy(param_00);
}

//Function Number: 376
isplayeronenemyteam(param_00)
{
	return param_00.team != self.team;
}

//Function Number: 377
isplayerffaenemy(param_00)
{
	if(isdefined(param_00.owner))
	{
		return param_00.owner != self;
	}

	return param_00 != self;
}

//Function Number: 378
ismlgsystemlink()
{
	if(issystemlink() && getdvarint("xblive_competitionmatch"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 379
ismlgsplitscreen()
{
	if(issplitscreen() && getdvarint("xblive_competitionmatch"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 380
ismlgprivatematch()
{
	if(privatematch() && getdvarint("xblive_competitionmatch"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 381
ismlgmatch()
{
	if(ismlgsystemlink() || ismlgsplitscreen() || ismlgprivatematch())
	{
		return 1;
	}

	return 0;
}

//Function Number: 382
spawnfxshowtoteam(param_00,param_01,param_02,param_03)
{
	var_04 = spawnfx(param_00,param_02,param_03);
	var_04 fxshowtoteam(param_01);
	return var_04;
}

//Function Number: 383
fxshowtoteam(param_00)
{
	thread showfxtoteam(param_00);
	setfxkillondelete(self,1);
	triggerfx(self);
}

//Function Number: 384
showfxtoteam(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self hide();
		foreach(var_02 in level.players)
		{
			var_03 = var_02.team;
			if(var_03 != "axis" || var_02 ismlgspectator())
			{
				var_03 = "allies";
			}

			if(param_00 == var_03 || param_00 == "neutral")
			{
				self showtoplayer(var_02);
			}
		}

		level waittill("joined_team");
	}
}

//Function Number: 385
get_spawn_weapon_name(param_00)
{
	var_01 = "iw5_combatknife_mp";
	if(isdefined(param_00.primaryname) && param_00.primaryname != "none" && param_00.primaryname != "iw5_combatknife_mp")
	{
		var_01 = param_00.primaryname;
	}
	else if(isdefined(param_00.secondaryname) && param_00.secondaryname != "none")
	{
		var_01 = param_00.secondaryname;
	}

	return var_01;
}

//Function Number: 386
playersaveangles()
{
	self.restoreangles = self getplayerangles();
}

//Function Number: 387
playerrestoreangles()
{
	if(isdefined(self.restoreangles))
	{
		if(self.team != "spectator")
		{
			self setplayerangles(self.restoreangles);
		}

		self.restoreangles = undefined;
	}
}

//Function Number: 388
setmlgicons(param_00,param_01)
{
	param_00 maps\mp\gametypes\_gameobjects::set2dicon("mlg",param_01);
	param_00 maps\mp\gametypes\_gameobjects::set3dicon("mlg",param_01);
}

//Function Number: 389
spawnpatchclip(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_04 = spawn("script_model",param_01);
	var_04 clonebrushmodeltoscriptmodel(var_03);
	var_04.angles = param_02;
	return var_04;
}

//Function Number: 390
iscoop()
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		return 1;
	}

	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		return 1;
	}

	return 0;
}

//Function Number: 391
setlightingstate_patched(param_00)
{
	var_01 = getentarray();
	setomnvar("lighting_state",param_00);
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03.lightingstate) && var_03.classname == "script_brushmodel" || var_03.classname == "script_model")
			{
				if(var_03.lightingstate == 0)
				{
					continue;
				}

				if(var_03.lightingstate == param_00)
				{
					var_03 common_scripts\utility::show_solid();
					var_03 allowriotshieldplant();
					continue;
				}

				var_03 notify("hidingLightingState");
				var_03 common_scripts\utility::hide_notsolid();
			}
		}
	}
}

//Function Number: 392
gettimeutc_for_stat_recording()
{
	return gettimeutc();
}