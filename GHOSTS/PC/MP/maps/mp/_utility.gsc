/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_utility.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 381
 * Decompile Time: 6396 ms
 * Timestamp: 10/27/2023 1:22:51 AM
*******************************************************************/

//Function Number: 1
func_30C3()
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
	self.selectinglocation = 1;
	self setblurforplayer(10.3,0.3);
	thread func_2DEF("cancel_location");
	thread func_2DEF("death");
	thread func_2DEF("disconnect");
	thread func_2DEF("used");
	thread func_2DEF("weapon_change");
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
			self.streakmsg = maps\mp\gametypes\_hud_util::createfontstring("default",1.3);
			self.streakmsg maps\mp\gametypes\_hud_util::func_70A4("CENTER","CENTER",0,-98);
		}
		else
		{
			self.streakmsg = maps\mp\gametypes\_hud_util::createfontstring("default",1.6);
			self.streakmsg maps\mp\gametypes\_hud_util::func_70A4("CENTER","CENTER",0,-190);
		}

		var_04 = func_3AFD(param_00);
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
		if(!func_48B2())
		{
			continue;
		}

		thread stoplocationselection(0,"emp");
	}
}

//Function Number: 5
func_2DEF(param_00)
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
	if(func_47BB())
	{
		var_01 = tablelookup("mp/alien/alien_attachmentTable.csv",4,param_00,0);
	}
	else
	{
		var_01 = tablelookup("mp/attachmentTable.csv",4,var_01,0);
	}

	if(isdefined(var_01) && var_01 != "")
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
getattachmenttype(param_00)
{
	if(func_47BB())
	{
		var_01 = tablelookup("mp/alien/alien_attachmentTable.csv",4,param_00,2);
	}
	else
	{
		var_01 = tablelookup("mp/attachmentTable.csv",4,var_01,2);
	}

	return var_01;
}

//Function Number: 9
func_252F(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	thread delaythread_proc(param_01,param_00,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 10
delaythread_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait(param_01);
	if(!isdefined(param_02))
	{
		thread [[ param_00 ]]();
	}

	if(!isdefined(param_03))
	{
		thread [[ param_00 ]](param_02);
	}

	if(!isdefined(param_04))
	{
		thread [[ param_00 ]](param_02,param_03);
	}

	if(!isdefined(param_05))
	{
		thread [[ param_00 ]](param_02,param_03,param_04);
	}

	if(!isdefined(param_06))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05);
	}

	thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 11
func_0EE2(param_00,param_01)
{
	foreach(var_04, var_03 in param_00)
	{
		if(var_04 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 12
func_3B93()
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
		var_05.angles = func_59E3(var_04["normal"]);
		return var_05;
	}

	var_05 = bullettrace(var_04[1],var_04[1] + (0,0,-18),0,undefined);
	if(var_05["fraction"] < 1)
	{
		var_05 = spawnstruct();
		var_05.origin = var_04["position"];
		var_05.angles = func_59E3(var_04["normal"]);
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
	var_08.angles = func_59E3(var_04["normal"]);
	return var_08;
}

//Function Number: 13
func_59E3(param_00)
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
func_6045(param_00,param_01,param_02)
{
	if(level.splitscreen)
	{
		if(isdefined(level.players[0]))
		{
			level.players[0] playlocalsound(param_00);
		}
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

				if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == param_01 && !func_48B8(var_04,param_02))
				{
					var_04 playlocalsound(param_00);
				}
			}
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
	}

	if(isdefined(var_03))
	{
		for(var_03 = 0;var_03 < level.players.size;var_03++)
		{
			if(level.players[var_03] issplitscreenplayer() && !level.players[var_03] issplitscreenplayerprimary())
			{
				continue;
			}

			if(!func_48B8(level.players[var_03],param_02))
			{
				level.players[var_03] playlocalsound(param_00);
			}
		}
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

//Function Number: 16
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

//Function Number: 17
addlowermessage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = undefined;
	foreach(var_0C in self.lowermessages)
	{
		if(var_0C.name == param_00)
		{
			if(var_0C.text == param_01 && var_0C.priority == param_03)
			{
			}

			var_0A = var_0C;
			break;
		}
	}

	if(!isdefined(var_0A))
	{
		var_0A = spawnstruct();
		self.lowermessages[self.lowermessages.size] = var_0A;
	}

	var_0A.name = param_00;
	var_0A.text = param_01;
	var_0A.time = param_02;
	var_0A.addtime = gettime();
	var_0A.priority = param_03;
	var_0A.showtimer = param_04;
	var_0A.shouldfade = param_05;
	var_0A.fadetoalpha = param_06;
	var_0A.fadetoalphatime = param_07;
	var_0A.hidewhenindemo = param_08;
	var_0A.hidewheninmenu = param_09;
	sortlowermessages();
}

//Function Number: 18
func_65A0(param_00)
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

//Function Number: 19
getlowermessage()
{
	if(!isdefined(self.lowermessages))
	{
		return undefined;
	}

	return self.lowermessages[0];
}

//Function Number: 20
setlowermessage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
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

	if(!isdefined(param_09))
	{
		param_09 = 1;
	}

	addlowermessage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	func_86FC();
}

//Function Number: 21
func_86FC()
{
	if(!isdefined(self))
	{
	}

	var_00 = getlowermessage();
	if(!isdefined(var_00))
	{
		if(isdefined(self.lowermessage) && isdefined(self.lowertimer))
		{
			self.lowermessage.alpha = 0;
			self.lowertimer.alpha = 0;
		}
	}

	self.lowermessage settext(var_00.text);
	self.lowermessage.alpha = 0.85;
	self.lowertimer.alpha = 1;
	self.lowermessage.hidewhenindemo = var_00.hidewhenindemo;
	self.lowermessage.hidewheninmenu = var_00.hidewheninmenu;
	if(var_00.shouldfade)
	{
		self.lowermessage fadeovertime(min(var_00.fadetoalphatime,60));
		self.lowermessage.alpha = var_00.fadetoalpha;
	}

	if(var_00.time > 0 && var_00.showtimer)
	{
		self.lowertimer settimer(max(var_00.time - gettime() - var_00.addtime / 1000,0.1));
	}

	if(var_00.time > 0 && !var_00.showtimer)
	{
		self.lowertimer settext("");
		self.lowermessage fadeovertime(min(var_00.time,60));
		self.lowermessage.alpha = 0;
		thread clearondeath(var_00);
		thread clearafterfade(var_00);
	}

	self.lowertimer settext("");
}

//Function Number: 22
clearondeath(param_00)
{
	self notify("message_cleared");
	self endon("message_cleared");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	func_1D47(param_00.name);
}

//Function Number: 23
clearafterfade(param_00)
{
	wait(param_00.time);
	func_1D47(param_00.name);
	self notify("message_cleared");
}

//Function Number: 24
func_1D47(param_00)
{
	func_65A0(param_00);
	func_86FC();
}

//Function Number: 25
func_1D48()
{
	for(var_00 = 0;var_00 < self.lowermessages.size;var_00++)
	{
		self.lowermessages[var_00] = undefined;
	}

	if(!isdefined(self.lowermessage))
	{
	}

	func_86FC();
}

//Function Number: 26
func_61AC(param_00,param_01)
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

//Function Number: 27
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

//Function Number: 28
func_61A5(param_00,param_01,param_02)
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

//Function Number: 29
func_61AD(param_00,param_01,param_02)
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

//Function Number: 30
func_61AB(param_00,param_01)
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

//Function Number: 31
func_61A1(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
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
		}
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

//Function Number: 32
func_61A3(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		if(var_04.team != param_00)
		{
			continue;
		}

		var_04 func_61A2(param_01,param_02);
	}
}

//Function Number: 33
func_61A2(param_00,param_01)
{
	self iprintln(param_00);
	self playlocalsound(param_01);
}

//Function Number: 34
_playlocalsound(param_00)
{
	if(level.splitscreen && self getentitynumber() != 0)
	{
	}

	self playlocalsound(param_00);
}

//Function Number: 35
func_2B99(param_00,param_01,param_02,param_03)
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

//Function Number: 36
func_2B98(param_00,param_01,param_02,param_03)
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

//Function Number: 37
func_5D25(param_00,param_01)
{
	if(isdefined(param_01))
	{
		playsoundatpos(self gettagorigin(param_01),param_00);
	}

	playsoundatpos(self.origin,param_00);
}

//Function Number: 38
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

//Function Number: 39
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

//Function Number: 40
func_463E(param_00)
{
	if(!isdefined(self.pers[param_00]))
	{
		self.pers[param_00] = 0;
	}
}

//Function Number: 41
func_3B8D(param_00)
{
	return self.pers[param_00];
}

//Function Number: 42
func_4479(param_00,param_01,param_02)
{
	if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers[param_00]))
	{
		self.pers[param_00] = self.pers[param_00] + param_01;
		if(!isdefined(param_02) || param_02 == 0)
		{
			maps\mp\gametypes\_persistence::func_7B07(param_00,param_01);
		}
	}
}

//Function Number: 43
func_7093(param_00,param_01)
{
	self.pers[param_00] = param_01;
}

//Function Number: 44
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

//Function Number: 45
func_447B(param_00,param_01)
{
	if(isagent(self) || isbot(self))
	{
	}

	var_02 = self.stats["stats_" + param_00];
	var_02.value = var_02.value + param_01;
}

//Function Number: 46
func_70A0(param_00,param_01)
{
	var_02 = self.stats["stats_" + param_00];
	var_02.value = param_01;
	var_02.time = gettime();
}

//Function Number: 47
getplayerstat(param_00)
{
	return self.stats["stats_" + param_00].value;
}

//Function Number: 48
func_3B9C(param_00)
{
	return self.stats["stats_" + param_00].time;
}

//Function Number: 49
func_70A1(param_00,param_01)
{
	var_02 = getplayerstat(param_00);
	if(param_01 > var_02)
	{
		func_70A0(param_00,param_01);
	}
}

//Function Number: 50
func_70A2(param_00,param_01)
{
	var_02 = getplayerstat(param_00);
	if(param_01 < var_02)
	{
		func_70A0(param_00,param_01);
	}
}

//Function Number: 51
func_870C(param_00,param_01,param_02)
{
	if(!func_634C())
	{
	}

	var_03 = maps\mp\gametypes\_persistence::func_7B16(param_01);
	var_04 = maps\mp\gametypes\_persistence::func_7B16(param_02);
	if(var_04 == 0)
	{
		var_04 = 1;
	}

	maps\mp\gametypes\_persistence::func_7B26(param_00,int(var_03 * 1000 / var_04));
}

//Function Number: 52
func_870D(param_00,param_01,param_02)
{
	if(!func_634C())
	{
	}

	var_03 = maps\mp\gametypes\_persistence::statgetbuffered(param_01);
	var_04 = maps\mp\gametypes\_persistence::statgetbuffered(param_02);
	if(var_04 == 0)
	{
		var_04 = 1;
	}

	maps\mp\gametypes\_persistence::func_7B27(param_00,int(var_03 * 1000 / var_04));
}

//Function Number: 53
func_8BC1(param_00)
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

//Function Number: 54
waitfortimeornotify(param_00,param_01)
{
	self endon(param_01);
	wait(param_00);
}

//Function Number: 55
func_48B8(param_00,param_01)
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

//Function Number: 56
func_4D30(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = game["dialog"][param_00];
	if(!isdefined(var_05))
	{
	}

	var_06 = game["voice"]["allies"] + var_05;
	var_07 = game["voice"]["axis"] + var_05;
	queuedialog(var_06,var_07,param_00,2,param_01,param_02,param_03,param_04);
}

//Function Number: 57
func_4D37(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in param_01)
	{
		var_05 func_4D35(param_00,param_02,undefined,param_03);
	}
}

//Function Number: 58
func_4D35(param_00,param_01,param_02,param_03)
{
	if(!isdefined(game["dialog"][param_00]))
	{
	}

	var_04 = self.pers["team"];
	if(isdefined(var_04) && var_04 == "axis" || var_04 == "allies")
	{
		var_05 = game["voice"][var_04] + game["dialog"][param_00];
		self queuedialogforplayer(var_05,param_00,2,param_01,param_02,param_03);
	}
}

//Function Number: 59
func_3B45()
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

//Function Number: 60
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

//Function Number: 61
func_86FF()
{
	if(self.pers["team"] == "spectator")
	{
		self setclientdvar("g_scriptMainMenu",game["menu_team"]);
	}

	self setclientdvar("g_scriptMainMenu",game["menu_class_" + self.pers["team"]]);
}

//Function Number: 62
updateobjectivetext()
{
	if(self.pers["team"] == "spectator")
	{
		self setclientdvar("cg_objectiveText","");
	}

	if(getwatcheddvar("scorelimit") > 0 && !func_491C())
	{
		if(isdefined(func_3B5F(self.pers["team"])))
		{
			if(level.splitscreen)
			{
				self setclientdvar("cg_objectiveText",func_3B5F(self.pers["team"]));
			}

			self setclientdvar("cg_objectiveText",func_3B5F(self.pers["team"]),getwatcheddvar("scorelimit"));
		}
	}

	if(isdefined(getobjectivetext(self.pers["team"])))
	{
		self setclientdvar("cg_objectiveText",getobjectivetext(self.pers["team"]));
	}
}

//Function Number: 63
func_7084(param_00,param_01)
{
	game["strings"]["objective_" + param_00] = param_01;
}

//Function Number: 64
func_7083(param_00,param_01)
{
	game["strings"]["objective_score_" + param_00] = param_01;
}

//Function Number: 65
setobjectivehinttext(param_00,param_01)
{
	game["strings"]["objective_hint_" + param_00] = param_01;
}

//Function Number: 66
getobjectivetext(param_00)
{
	return game["strings"]["objective_" + param_00];
}

//Function Number: 67
func_3B5F(param_00)
{
	return game["strings"]["objective_score_" + param_00];
}

//Function Number: 68
func_3B5E(param_00)
{
	return game["strings"]["objective_hint_" + param_00];
}

//Function Number: 69
func_3C4B()
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

//Function Number: 70
gettimepassedpercentage()
{
	return func_3C4B() / func_3C4A() * 60 * 1000 * 100;
}

//Function Number: 71
func_3BE4()
{
	return func_3C4B() / 1000;
}

//Function Number: 72
func_3B2E()
{
	return func_3BE4() / 60;
}

//Function Number: 73
clearkillcamstate()
{
	self.forcespectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.spectatekillcam = 0;
}

//Function Number: 74
func_48E2()
{
	return self.spectatekillcam;
}

//Function Number: 75
func_499C(param_00)
{
	return isdefined(param_00) && param_00 != "";
}

//Function Number: 76
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

//Function Number: 77
func_8AFB(param_00)
{
	var_01 = gettime();
	var_02 = gettime() - var_01 / 1000;
	if(var_02 < param_00)
	{
		wait(param_00 - var_02);
		return param_00;
	}

	return var_02;
}

//Function Number: 78
logxpgains()
{
	if(!isdefined(self.xpgains))
	{
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

//Function Number: 79
func_6473(param_00,param_01,param_02,param_03)
{
	func_647B("roundswitch",param_01);
	param_00 = "scr_" + param_00 + "_roundswitch";
	level.roundswitchdvar = param_00;
	level.roundswitchmin = param_02;
	level.roundswitchmax = param_03;
	level.roundswitch = getdvarint(param_00,param_01);
	if(level.roundswitch < param_02)
	{
		level.roundswitch = param_02;
	}

	if(level.roundswitch > param_03)
	{
		level.roundswitch = param_03;
	}
}

//Function Number: 80
func_6472(param_00,param_01)
{
	func_647B("roundlimit",param_01);
}

//Function Number: 81
func_6471(param_00,param_01)
{
	func_647B("numTeams",param_01);
}

//Function Number: 82
func_647C(param_00,param_01)
{
	func_647B("winlimit",param_01);
}

//Function Number: 83
func_6475(param_00,param_01)
{
	func_647B("scorelimit",param_01);
}

//Function Number: 84
func_6476(param_00,param_01)
{
	func_647A("timelimit",param_01);
	setdvar("ui_timelimit",func_3C4A());
}

//Function Number: 85
func_646A(param_00,param_01)
{
	func_647B("halftime",param_01);
	setdvar("ui_halftime",gethalftime());
}

//Function Number: 86
func_6470(param_00,param_01)
{
	func_647B("numlives",param_01);
}

//Function Number: 87
func_708C(param_00)
{
	setdvar("overtimeTimeLimit",param_00);
}

//Function Number: 88
get_damageable_player(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 1;
	var_02.isadestructable = 0;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 89
func_3848(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 0;
	var_02.isadestructable = 0;
	var_02.issentry = 1;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 90
func_3843(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 0;
	var_02.isadestructable = 0;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 91
get_damageable_mine(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.isplayer = 0;
	var_02.isadestructable = 0;
	var_02.entity = param_00;
	var_02.damagecenter = param_01;
	return var_02;
}

//Function Number: 92
func_3847(param_00)
{
	return param_00.origin + (0,0,32);
}

//Function Number: 93
func_3C02()
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

//Function Number: 94
func_3844(param_00)
{
	return param_00.origin;
}

//Function Number: 95
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

//Function Number: 96
func_7CEA(param_00,param_01)
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

//Function Number: 97
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

//Function Number: 98
func_6AA8()
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

//Function Number: 99
func_665A()
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
			var_02 = common_scripts\utility::func_3B0A();
		}

		self setspawnweapon(var_02);
		self switchtoweapon(var_02);
	}
}

//Function Number: 100
_setactionslot(param_00,param_01,param_02)
{
	self.saved_actionslotdata[param_00].type = param_01;
	self.saved_actionslotdata[param_00].item = param_02;
	self setactionslot(param_00,param_01,param_02);
}

//Function Number: 101
func_48C6(param_00)
{
	if(int(param_00) != param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 102
func_647B(param_00,param_01)
{
	var_02 = "scr_" + level.gametype + "_" + param_00;
	level.watchdvars[var_02] = spawnstruct();
	level.watchdvars[var_02].value = getdvarint(var_02,param_01);
	level.watchdvars[var_02].type = "int";
	level.watchdvars[var_02].notifystring = "update_" + param_00;
}

//Function Number: 103
func_647A(param_00,param_01)
{
	var_02 = "scr_" + level.gametype + "_" + param_00;
	level.watchdvars[var_02] = spawnstruct();
	level.watchdvars[var_02].value = getdvarfloat(var_02,param_01);
	level.watchdvars[var_02].type = "float";
	level.watchdvars[var_02].notifystring = "update_" + param_00;
}

//Function Number: 104
func_6479(param_00,param_01)
{
	var_02 = "scr_" + level.gametype + "_" + param_00;
	level.watchdvars[var_02] = spawnstruct();
	level.watchdvars[var_02].value = getdvar(var_02,param_01);
	level.watchdvars[var_02].type = "string";
	level.watchdvars[var_02].notifystring = "update_" + param_00;
}

//Function Number: 105
func_708B(param_00,param_01)
{
	param_00 = "scr_" + level.gametype + "_" + param_00;
	level.overridewatchdvars[param_00] = param_01;
}

//Function Number: 106
getwatcheddvar(param_00)
{
	param_00 = "scr_" + level.gametype + "_" + param_00;
	if(isdefined(level.overridewatchdvars) && isdefined(level.overridewatchdvars[param_00]))
	{
		return level.overridewatchdvars[param_00];
	}

	return level.watchdvars[param_00].value;
}

//Function Number: 107
func_8755()
{
	while(game["state"] == "playing")
	{
		var_00 = getarraykeys(level.watchdvars);
		foreach(var_02 in var_00)
		{
			if(level.watchdvars[var_02].type == "string")
			{
				var_03 = func_3BAA(var_02,level.watchdvars[var_02].value);
			}
			else if(level.watchdvars[var_02].type == "float")
			{
				var_03 = func_3AAF(var_02,level.watchdvars[var_02].value);
			}
			else
			{
				var_03 = func_3ADD(var_02,level.watchdvars[var_02].value);
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

//Function Number: 108
func_4950()
{
	if(!level.teambased)
	{
		return 0;
	}

	if(getwatcheddvar("winlimit") != 1 && getwatcheddvar("roundlimit") != 1)
	{
		return 1;
	}

	if(level.gametype == "sr" || level.gametype == "sd" || level.gametype == "siege")
	{
		return 1;
	}

	return 0;
}

//Function Number: 109
func_48C1()
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

//Function Number: 110
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

//Function Number: 111
func_8C4A()
{
	if(!level.teambased)
	{
		return 1;
	}

	if(isdefined(level.onlyroundoverride))
	{
		return 0;
	}

	if(getwatcheddvar("winlimit") == 1 && func_4281())
	{
		return 1;
	}

	if(getwatcheddvar("roundlimit") == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 112
func_8C49()
{
	if(level.forcedend)
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	if(hitroundlimit() || func_4281())
	{
		return 1;
	}

	return 0;
}

//Function Number: 113
func_4280()
{
	if(getwatcheddvar("timelimit") <= 0)
	{
		return 0;
	}

	var_00 = maps\mp\gametypes\_gamelogic::gettimeremaining();
	if(var_00 > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 114
hitroundlimit()
{
	if(getwatcheddvar("roundlimit") <= 0)
	{
		return 0;
	}

	return game["roundsPlayed"] >= getwatcheddvar("roundlimit");
}

//Function Number: 115
func_427E()
{
	if(func_491C())
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

//Function Number: 116
func_4281()
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

//Function Number: 117
getscorelimit()
{
	if(func_4950())
	{
		if(getwatcheddvar("roundlimit"))
		{
			return getwatcheddvar("roundlimit");
		}

		return getwatcheddvar("winlimit");
	}

	return getwatcheddvar("scorelimit");
}

//Function Number: 118
getroundswon(param_00)
{
	return game["roundsWon"][param_00];
}

//Function Number: 119
func_491C()
{
	return level.objectivebased;
}

//Function Number: 120
func_3C4A()
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

//Function Number: 121
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

//Function Number: 122
inovertime()
{
	return isdefined(game["status"]) && game["status"] == "overtime";
}

//Function Number: 123
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

//Function Number: 124
func_3A30(param_00)
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

//Function Number: 125
func_3B16(param_00)
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

//Function Number: 126
func_720F(param_00)
{
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 0;
	}

	self.usingremote = param_00;
	common_scripts\utility::_disableoffhandweapons();
	self notify("using_remote");
}

//Function Number: 127
func_3BD3()
{
	return self.usingremote;
}

//Function Number: 128
func_350E(param_00)
{
	if(isdefined(level.hostmigrationtimer))
	{
		self.hostmigrationcontrolsfrozen = 1;
		self freezecontrols(1);
	}

	self freezecontrols(param_00);
	self.controlsfrozen = param_00;
}

//Function Number: 129
func_1D59()
{
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 1;
	}

	self.usingremote = undefined;
	common_scripts\utility::func_66F();
	var_00 = self getcurrentweapon();
	if(var_00 == "none" || func_48F7(var_00))
	{
		var_01 = common_scripts\utility::func_3B0A();
		if(func_4945(self))
		{
			if(!self hasweapon(var_01))
			{
				var_01 = maps\mp\killstreaks\_killstreaks::func_3AAA();
			}

			self switchtoweapon(var_01);
		}
	}

	func_350E(0);
	self notify("stopped_using_remote");
}

//Function Number: 130
func_4995()
{
	return isdefined(self.usingremote);
}

//Function Number: 131
isrocketcorpse()
{
	return isdefined(self.isrocketcorpse) && self.isrocketcorpse;
}

//Function Number: 132
func_6297(param_00)
{
	if(!isdefined(level.queues))
	{
		level.queues = [];
	}

	level.queues[param_00] = [];
}

//Function Number: 133
func_6295(param_00,param_01)
{
	level.queues[param_00][level.queues[param_00].size] = param_01;
}

//Function Number: 134
func_6299(param_00)
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

//Function Number: 135
_giveweapon(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = -1;
	}

	if(issubstr(param_00,"_akimbo") || isdefined(param_02) && param_02 == 1)
	{
		self giveweapon(param_00,param_01,1);
	}

	self giveweapon(param_00,param_01,0);
}

//Function Number: 136
perksenabled()
{
	return getdvarint("scr_game_perks") == 1;
}

//Function Number: 137
_hasperk(param_00)
{
	var_01 = self.perks;
	if(!isdefined(var_01))
	{
		return 0;
	}

	if(isdefined(var_01[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 138
func_3CFB(param_00,param_01)
{
	if(issubstr(param_00,"specialty_weapon_"))
	{
		_setperk(param_00,param_01);
	}

	_setperk(param_00,param_01);
	_setextraperks(param_00);
}

//Function Number: 139
giveperkequipment(param_00,param_01)
{
	if(param_00 == "none" || param_00 == "specialty_null")
	{
		self setoffhandprimaryclass("none");
	}

	self.primarygrenade = param_00;
	if(issubstr(param_00,"_mp"))
	{
		switch(param_00)
		{
			case "mortar_shelljugg_mp":
			case "mortar_shell_mp":
			case "frag_grenade_mp":
				self setoffhandprimaryclass("frag");
				break;

			case "throwingknifejugg_mp":
			case "throwingknife_mp":
				self setoffhandprimaryclass("throwingknife");
				break;

			case "thermobaric_grenade_mp":
			case "motion_sensor_mp":
			case "emp_grenade_mp":
			case "flash_grenade_mp":
			case "trophy_mp":
				self setoffhandprimaryclass("flash");
				break;

			case "concussion_grenade_mp":
			case "smoke_grenadejugg_mp":
			case "smoke_grenade_mp":
				self setoffhandprimaryclass("smoke");
				break;

			default:
				self setoffhandprimaryclass("other");
				break;
		}

		_giveweapon(param_00,0);
		self givestartammo(param_00);
		_setperk(param_00,param_01);
	}

	_setperk(param_00,param_01);
}

//Function Number: 140
func_3CFD(param_00,param_01)
{
	if(param_00 == "none" || param_00 == "specialty_null")
	{
		self setoffhandsecondaryclass("none");
	}

	self.secondarygrenade = param_00;
	if(issubstr(param_00,"_mp"))
	{
		switch(param_00)
		{
			case "mortar_shelljugg_mp":
			case "mortar_shell_mp":
			case "frag_grenade_mp":
				self setoffhandsecondaryclass("frag");
				break;

			case "throwingknifejugg_mp":
			case "throwingknife_mp":
				self setoffhandsecondaryclass("throwingknife");
				break;

			case "thermobaric_grenade_mp":
			case "motion_sensor_mp":
			case "emp_grenade_mp":
			case "flash_grenade_mp":
			case "trophy_mp":
				self setoffhandsecondaryclass("flash");
				break;

			case "concussion_grenade_mp":
			case "smoke_grenadejugg_mp":
			case "smoke_grenade_mp":
				self setoffhandsecondaryclass("smoke");
				break;

			default:
				self setoffhandsecondaryclass("other");
				break;
		}

		_giveweapon(param_00,0);
		switch(param_00)
		{
			case "concussion_grenade_mp":
			case "smoke_grenade_mp":
			case "thermobaric_grenade_mp":
			case "motion_sensor_mp":
			case "emp_grenade_mp":
			case "flash_grenade_mp":
			case "trophy_mp":
				self setweaponammoclip(param_00,1);
				break;

			default:
				self givestartammo(param_00);
				break;
		}

		_setperk(param_00,param_01);
	}

	_setperk(param_00,param_01);
}

//Function Number: 141
_setperk(param_00,param_01)
{
	self.perks[param_00] = 1;
	self.perksperkname[param_00] = param_00;
	self.perksuseslot[param_00] = param_01;
	var_02 = level.perksetfuncs[param_00];
	if(isdefined(var_02))
	{
		self thread [[ var_02 ]]();
	}

	self setperk(param_00,!isdefined(level.scriptperks[param_00]),param_01);
}

//Function Number: 142
_setextraperks(param_00)
{
	if(param_00 == "specialty_stun_resistance")
	{
		func_3CFB("specialty_empimmune",0);
	}

	if(param_00 == "specialty_hardline")
	{
		func_3CFB("specialty_assists",0);
	}

	if(param_00 == "specialty_incog")
	{
		func_3CFB("specialty_spygame",0);
		func_3CFB("specialty_coldblooded",0);
		func_3CFB("specialty_noscopeoutline",0);
		func_3CFB("specialty_heartbreaker",0);
	}

	if(param_00 == "specialty_blindeye")
	{
		func_3CFB("specialty_noplayertarget",0);
	}

	if(param_00 == "specialty_sharp_focus")
	{
		func_3CFB("specialty_reducedsway",0);
	}

	if(param_00 == "specialty_quickswap")
	{
		func_3CFB("specialty_fastoffhand",0);
	}
}

//Function Number: 143
_unsetperk(param_00)
{
	self.perks[param_00] = undefined;
	self.perksperkname[param_00] = undefined;
	self.perksuseslot[param_00] = undefined;
	if(isdefined(level.perkunsetfuncs[param_00]))
	{
		self thread [[ level.perkunsetfuncs[param_00] ]]();
	}

	self unsetperk(param_00,!isdefined(level.scriptperks[param_00]));
}

//Function Number: 144
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

	if(param_00 == "specialty_heartbreaker")
	{
		_unsetperk("specialty_empimmune");
	}

	if(param_00 == "specialty_rollover")
	{
		_unsetperk("specialty_assists");
	}
}

//Function Number: 145
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
	self clearperks();
}

//Function Number: 146
func_62A1(param_00)
{
	return func_62A2(param_00,0,param_00.size - 1);
}

//Function Number: 147
func_62A2(param_00,param_01,param_02)
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
				param_00 = func_7D8D(param_00,var_03,var_04);
			}
		}

		param_00 = func_7D8D(param_00,param_01,var_04);
		param_00 = func_62A2(param_00,param_01,var_04 - 1);
		param_00 = func_62A2(param_00,var_04 + 1,param_02);
	}
	else
	{
		return param_01;
	}

	return param_00;
}

//Function Number: 148
func_7D8D(param_00,param_01,param_02)
{
	var_03 = param_00[param_01];
	param_00[param_01] = param_00[param_02];
	param_00[param_02] = var_03;
	return param_00;
}

//Function Number: 149
_suicide()
{
	if(func_4995() && !isdefined(self.fauxdead))
	{
		thread maps\mp\gametypes\_damage::playerkilled_internal(self,self,self,10000,"MOD_SUICIDE","frag_grenade_mp",(0,0,0),"none",0,1116,1);
	}

	if(!func_4995() && !isdefined(self.fauxdead))
	{
		self suicide();
	}
}

//Function Number: 150
func_4945(param_00)
{
	if(isalive(param_00) && !isdefined(param_00.fauxdead))
	{
		return 1;
	}

	return 0;
}

//Function Number: 151
func_8B37(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	if(isdefined(param_01))
	{
		thread common_scripts\utility::func_8B9F(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		thread common_scripts\utility::func_8B9F(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		thread common_scripts\utility::func_8B9F(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		thread common_scripts\utility::func_8B9F(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		thread common_scripts\utility::func_8B9F(param_05,var_06);
	}

	var_06 thread _timeout_pause_on_death_and_prematch(param_00,self);
	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 152
_timeout_pause_on_death_and_prematch(param_00,param_01)
{
	self endon("die");
	var_02 = 0.05;
	while(param_00 > 0)
	{
		if(isplayer(param_01) && !func_4945(param_01))
		{
			param_01 waittill("spawned_player");
		}

		if(getomnvar("ui_prematch_period"))
		{
			level waittill("prematch_over");
		}

		wait(var_02);
		param_00 = param_00 - var_02;
	}

	self notify("returned","timeout");
}

//Function Number: 153
func_5D5B()
{
	var_00 = randomintrange(1,8);
	var_01 = "generic";
	if(self hasfemalecustomizationmodel())
	{
		var_01 = "female";
	}

	if(self.team == "axis")
	{
		self playsound(var_01 + "_death_russian_" + var_00);
	}

	self playsound(var_01 + "_death_american_" + var_00);
}

//Function Number: 154
func_634C()
{
	if(!isplayer(self))
	{
		return 0;
	}

	return level.rankedmatch && !self.usingonlinedataoffline;
}

//Function Number: 155
func_61B9()
{
	return level.onlinegame && getdvarint("xblive_privatematch");
}

//Function Number: 156
func_50C1()
{
	return level.onlinegame && !getdvarint("xblive_privatematch");
}

//Function Number: 157
func_6FDC(param_00,param_01,param_02,param_03)
{
}

//Function Number: 158
func_2DEE(param_00)
{
	self endon("altscene");
	param_00 waittill("death");
	self notify("end_altScene");
}

//Function Number: 159
func_3ABB()
{
	return getwatcheddvar("numlives");
}

//Function Number: 160
givecombathigh(param_00)
{
	self.combathigh = param_00;
}

//Function Number: 161
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

//Function Number: 162
func_3BAA(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvar(param_00,param_01);
	return var_02;
}

//Function Number: 163
func_3ADD(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvarint(param_00,param_01);
	return var_02;
}

//Function Number: 164
func_3AAF(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvarfloat(param_00,param_01);
	return var_02;
}

//Function Number: 165
func_4899()
{
	return isdefined(self.changingweapon);
}

//Function Number: 166
func_4B2A(param_00)
{
	if(param_00 == "venomxgun_mp" || param_00 == "venomxproj_mp")
	{
		return 1;
	}

	if(_hasperk("specialty_explosivebullets"))
	{
		return 0;
	}

	if(isdefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1)
	{
		return 0;
	}

	var_01 = self.pers["killstreaks"];
	if(isdefined(level.killstreakweildweapons[param_00]) && isdefined(self.streaktype) && self.streaktype != "support")
	{
		for(var_02 = 1;var_02 < 4;var_02++)
		{
			if(isdefined(var_01[var_02]) && isdefined(var_01[var_02].streakname) && var_01[var_02].streakname == level.killstreakweildweapons[param_00] && isdefined(var_01[var_02].lifeid) && var_01[var_02].lifeid == self.pers["deaths"])
			{
				return func_7C95(level.killstreakweildweapons[param_00]);
			}
		}

		return 0;
	}

	return !func_48F7(var_01);
}

//Function Number: 167
func_7C95(param_00)
{
	var_01 = maps\mp\killstreaks\_killstreaks::func_3C16(param_00);
	var_02 = maps\mp\killstreaks\_killstreaks::func_3B47();
	var_03 = maps\mp\killstreaks\_killstreaks::func_3C16(var_02);
	return var_01 < var_03;
}

//Function Number: 168
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

	if(isdefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 169
func_48F7(param_00)
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

	if(func_4888(param_00))
	{
		return 0;
	}

	if(issubstr(param_00,"killstreak"))
	{
		return 1;
	}

	if(issubstr(param_00,"cobra"))
	{
		return 1;
	}

	if(issubstr(param_00,"remote_tank_projectile"))
	{
		return 1;
	}

	if(issubstr(param_00,"artillery_mp"))
	{
		return 1;
	}

	if(issubstr(param_00,"harrier"))
	{
		return 1;
	}

	var_01 = strtok(param_00,"_");
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

	if(isdefined(level.killstreakweildweapons[param_00]))
	{
		return 1;
	}

	if(maps\mp\killstreaks\_killstreaks::isairdropmarker(param_00))
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

//Function Number: 170
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
			return 1;
	}

	return 0;
}

//Function Number: 171
func_4888(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "bomb_site_mp":
		case "briefcase_bomb_mp":
			return 1;
	}

	return 0;
}

//Function Number: 172
func_48B7(param_00)
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

//Function Number: 173
func_48EF(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "iw6_mariachimagnum_mp_akimbo":
		case "iw6_predatorcannon_mp":
		case "iw6_axe_mp":
		case "iw6_riotshieldjugg_mp":
		case "iw6_knifeonlyjugg_mp":
		case "iw6_p226jugg_mp":
		case "iw6_magnumjugg_mp":
		case "iw6_minigunjugg_mp":
		case "smoke_grenadejugg_mp":
		case "throwingknifejugg_mp":
		case "mortar_shelljugg_mp":
			return 1;
	}

	return 0;
}

//Function Number: 174
getweaponclass(param_00)
{
	var_01 = func_3A37(param_00);
	if(func_47BB())
	{
		var_02 = tablelookup("mp/alien/mode_string_tables/alien_statstable.csv",4,var_01,2);
	}
	else
	{
		var_02 = tablelookup("mp/statstable.csv",4,var_02,2);
	}

	if(var_02 == "")
	{
		var_03 = func_7CEA(param_00,"_mp");
		if(func_47BB())
		{
			var_02 = tablelookup("mp/alien/mode_string_tables/alien_statstable.csv",4,var_03,2);
		}
		else
		{
			var_02 = tablelookup("mp/statstable.csv",4,var_03,2);
		}
	}

	if(func_48B7(param_00))
	{
		var_02 = "weapon_mg";
	}
	else if(!func_47BB() && func_48F7(param_00))
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

//Function Number: 175
func_3C6F(param_00)
{
	param_00 = func_3A37(param_00);
	if(!isdefined(level.weaponattachments[param_00]))
	{
		var_01 = [];
		for(var_02 = 0;var_02 <= 19;var_02++)
		{
			var_03 = tablelookup("mp/statsTable.csv",4,param_00,10 + var_02);
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

//Function Number: 176
getweaponattachmentfromstats(param_00,param_01)
{
	param_00 = func_3A37(param_00);
	return tablelookup("mp/statsTable.csv",4,param_00,10 + param_01);
}

//Function Number: 177
attachmentscompatible(param_00,param_01)
{
	param_00 = attachmentmap_tobase(param_00);
	param_01 = attachmentmap_tobase(param_01);
	var_02 = 1;
	if(param_00 == param_01)
	{
		var_02 = 0;
	}
	else if(param_00 != "none" && param_01 != "none")
	{
		var_03 = tablelookuprownum("mp/attachmentcombos.csv",0,param_01);
		if(tablelookup("mp/attachmentcombos.csv",0,param_00,var_03) == "no")
		{
			var_02 = 0;
		}
	}

	return var_02;
}

//Function Number: 178
func_3A37(param_00)
{
	var_01 = strtok(param_00,"_");
	if(var_01[0] == "iw5" || var_01[0] == "iw6")
	{
		param_00 = var_01[0] + "_" + var_01[1];
	}
	else if(var_01[0] == "alt")
	{
		param_00 = var_01[1] + "_" + var_01[2];
	}

	return param_00;
}

//Function Number: 179
getbaseperkname(param_00)
{
	if(isendstr(param_00,"_ks"))
	{
		param_00 = getsubstr(param_00,0,param_00.size - 3);
	}

	return param_00;
}

//Function Number: 180
getvalidextraammoweapons()
{
	var_00 = [];
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		var_04 = weaponclass(var_03);
		if(!func_48F7(var_03) && var_04 != "grenade" && var_04 != "rocketlauncher")
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 181
func_66D5()
{
	var_00 = 0;
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(maps\mp\gametypes\_weapons::func_494E(var_03))
		{
			var_00 = 1;
			break;
		}
	}

	return var_00;
}

//Function Number: 182
func_66D4()
{
	var_00 = 0;
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(maps\mp\gametypes\_weapons::func_494E(var_03))
		{
			var_00++;
		}

		if(var_00 == 2)
		{
			break;
		}
	}

	return var_00 == 2;
}

//Function Number: 183
riotshield_attach(param_00,param_01)
{
	var_02 = undefined;
	if(param_00)
	{
		self.riotshieldmodel = param_01;
		var_02 = "tag_weapon_right";
	}
	else
	{
		self.riotshieldmodelstowed = param_01;
		var_02 = "tag_shield_back";
	}

	self attachshieldmodel(param_01,var_02);
	self.hasriotshield = func_66D5();
}

//Function Number: 184
riotshield_detach(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	if(param_00)
	{
		var_01 = self.riotshieldmodel;
		var_02 = "tag_weapon_right";
	}
	else
	{
		var_01 = self.riotshieldmodelstowed;
		var_02 = "tag_shield_back";
	}

	self detachshieldmodel(var_01,var_02);
	if(param_00)
	{
		self.riotshieldmodel = undefined;
	}
	else
	{
		self.riotshieldmodelstowed = undefined;
	}

	self.hasriotshield = func_66D5();
}

//Function Number: 185
func_66D7(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	if(param_00)
	{
		var_03 = self.riotshieldmodel;
		var_01 = "tag_weapon_right";
		var_02 = "tag_shield_back";
	}
	else
	{
		var_03 = self.riotshieldmodelstowed;
		var_01 = "tag_shield_back";
		var_02 = "tag_weapon_right";
	}

	self moveshieldmodel(var_03,var_01,var_02);
	if(param_00)
	{
		self.riotshieldmodelstowed = var_03;
		self.riotshieldmodel = undefined;
	}

	self.riotshieldmodel = var_03;
	self.riotshieldmodelstowed = undefined;
}

//Function Number: 186
func_66D1()
{
	self.hasriotshieldequipped = 0;
	self.hasriotshield = 0;
	self.riotshieldmodelstowed = undefined;
	self.riotshieldmodel = undefined;
}

//Function Number: 187
riotshield_getmodel()
{
	return common_scripts\utility::func_803F(isjuggernaut(),"weapon_riot_shield_jug_iw6","weapon_riot_shield_iw6");
}

//Function Number: 188
func_5A43(param_00,param_01,param_02,param_03)
{
	var_04 = level.players;
	var_05 = maps\mp\gametypes\_outline::func_5A3F(param_01);
	var_06 = maps\mp\gametypes\_outline::func_5A4F(param_03);
	return maps\mp\gametypes\_outline::func_5A46(param_00,var_05,var_04,param_02,var_06,"ALL");
}

//Function Number: 189
func_5A45(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getteamarray(param_02,0);
	var_06 = maps\mp\gametypes\_outline::func_5A3F(param_01);
	var_07 = maps\mp\gametypes\_outline::func_5A4F(param_04);
	return maps\mp\gametypes\_outline::func_5A46(param_00,var_06,var_05,param_03,var_07,"TEAM",param_02);
}

//Function Number: 190
func_5A44(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = maps\mp\gametypes\_outline::func_5A3F(param_01);
	var_06 = maps\mp\gametypes\_outline::func_5A4F(param_04);
	if(isagent(param_02))
	{
		return maps\mp\gametypes\_outline::func_5A48();
	}

	return maps\mp\gametypes\_outline::func_5A46(param_00,var_05,[param_02],param_03,var_06,"ENTITY");
}

//Function Number: 191
func_5A40(param_00,param_01)
{
	maps\mp\gametypes\_outline::func_5A41(param_00,param_01);
}

//Function Number: 192
func_6044(param_00,param_01)
{
	playsoundatpos(param_01,param_00);
}

//Function Number: 193
func_4E13(param_00,param_01)
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

//Function Number: 194
func_6893(param_00,param_01,param_02)
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

//Function Number: 195
func_5FAB(param_00)
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

//Function Number: 196
func_494B()
{
	if(!func_634C())
	{
		return 0;
	}

	return self getrankedplayerdata("restXPGoal") > self getrankedplayerdata("experience");
}

//Function Number: 197
func_7CE9(param_00)
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

//Function Number: 198
func_70BF(param_00)
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

//Function Number: 199
func_5021(param_00)
{
	self makeusable();
	thread _updateteamusable(param_00);
}

//Function Number: 200
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

//Function Number: 201
func_5013(param_00)
{
	self makeusable();
	thread _updateenemyusable(param_00);
}

//Function Number: 202
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

//Function Number: 203
initgameflags()
{
	if(!isdefined(game["flags"]))
	{
		game["flags"] = [];
	}
}

//Function Number: 204
func_36F3(param_00,param_01)
{
	game["flags"][param_00] = param_01;
}

//Function Number: 205
func_36F1(param_00)
{
	return game["flags"][param_00];
}

//Function Number: 206
func_36F4(param_00)
{
	game["flags"][param_00] = 1;
	level notify(param_00);
}

//Function Number: 207
func_36F2(param_00)
{
	game["flags"][param_00] = 0;
}

//Function Number: 208
gameflagwait(param_00)
{
	while(!func_36F1(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 209
func_493D(param_00)
{
	if(param_00 == "MOD_RIFLE_BULLET" || param_00 == "MOD_PISTOL_BULLET")
	{
		return 1;
	}

	return 0;
}

//Function Number: 210
func_488D(param_00)
{
	var_01 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";
	if(issubstr(var_01,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 211
isfmjdamage(param_00,param_01,param_02)
{
	return isdefined(param_02) && param_02 _hasperk("specialty_bulletpenetration") && isdefined(param_01) && func_488D(param_01);
}

//Function Number: 212
initlevelflags()
{
	if(!isdefined(level.levelflags))
	{
		level.levelflags = [];
	}
}

//Function Number: 213
func_4DB5(param_00,param_01)
{
	level.levelflags[param_00] = param_01;
}

//Function Number: 214
levelflag(param_00)
{
	return level.levelflags[param_00];
}

//Function Number: 215
levelflagset(param_00)
{
	level.levelflags[param_00] = 1;
	level notify(param_00);
}

//Function Number: 216
func_4DB4(param_00)
{
	level.levelflags[param_00] = 0;
	level notify(param_00);
}

//Function Number: 217
func_4DB8(param_00)
{
	while(!levelflag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 218
levelflagwaitopen(param_00)
{
	while(levelflag(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 219
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
		level.global_tables["killstreakTable"].kills_col = 4;
		level.global_tables["killstreakTable"].earned_hint_col = 5;
		level.global_tables["killstreakTable"].sound_col = 6;
		level.global_tables["killstreakTable"].earned_dialog_col = 7;
		level.global_tables["killstreakTable"].allies_dialog_col = 8;
		level.global_tables["killstreakTable"].enemy_dialog_col = 9;
		level.global_tables["killstreakTable"].enemy_use_dialog_col = 10;
		level.global_tables["killstreakTable"].weapon_col = 11;
		level.global_tables["killstreakTable"].score_col = 12;
		level.global_tables["killstreakTable"].icon_col = 13;
		level.global_tables["killstreakTable"].overhead_icon_col = 14;
		level.global_tables["killstreakTable"].dpad_icon_col = 15;
		level.global_tables["killstreakTable"].unearned_icon_col = 16;
		level.global_tables["killstreakTable"].all_team_steak_col = 17;
	}
}

//Function Number: 220
func_48F6()
{
	return func_48B2() || isairdenied();
}

//Function Number: 221
func_48B2()
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

//Function Number: 222
isairdenied()
{
	if(self.team == "spectator")
	{
		return 0;
	}

	if(level.teambased)
	{
		return level.teamairdenied[self.team];
	}

	return isdefined(level.airdeniedplayer) && level.airdeniedplayer != self;
}

//Function Number: 223
func_491B()
{
	if(self.team == "spectator")
	{
		return 0;
	}

	return isdefined(self.nuked);
}

//Function Number: 224
func_3B96(param_00)
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

//Function Number: 225
func_7FA0(param_00,param_01,param_02,param_03)
{
	if(level.hardcoremode && !func_47BB())
	{
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

		var_05 thread maps\mp\gametypes\_hud_message::func_5F9A(param_00,param_01,param_03);
	}
}

//Function Number: 226
iscacprimaryweapon(param_00)
{
	switch(getweaponclass(param_00))
	{
		case "weapon_shotgun":
		case "weapon_lmg":
		case "weapon_dmr":
		case "weapon_sniper":
		case "weapon_riot":
		case "weapon_assault":
		case "weapon_smg":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 227
func_4890(param_00)
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

//Function Number: 228
func_3B09(param_00)
{
	var_01 = undefined;
	foreach(var_03 in level.players)
	{
		if(isdefined(param_00) && var_03.team != param_00)
		{
			continue;
		}

		if(!func_4945(var_03) && !var_03 maps\mp\gametypes\_playerlogic::func_5128())
		{
			continue;
		}

		if(isdefined(var_03.switching_teams) && var_03.switching_teams)
		{
			continue;
		}

		var_01 = var_03;
	}

	return var_01;
}

//Function Number: 229
func_3BA0()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(!func_4945(var_02) && !var_02 maps\mp\gametypes\_playerlogic::func_5128())
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 230
func_8BBE(param_00,param_01)
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

//Function Number: 231
enableweaponlaser()
{
	if(!isdefined(self.weaponlasercalls))
	{
		self.weaponlasercalls = 0;
	}

	self.weaponlasercalls++;
	self laseron();
}

//Function Number: 232
func_27C1()
{
	self.weaponlasercalls--;
	if(self.weaponlasercalls == 0)
	{
		self laseroff();
		self.weaponlasercalls = undefined;
	}
}

//Function Number: 233
attachmentmap_tounique(param_00,param_01)
{
	var_02 = param_00;
	param_01 = func_3A37(param_01);
	if(isdefined(level.attachmentmap_basetounique[param_01]) && isdefined(level.attachmentmap_basetounique[param_01][param_00]))
	{
		var_02 = level.attachmentmap_basetounique[param_01][param_00];
	}
	else
	{
		if(func_47BB())
		{
			var_03 = tablelookup("mp/alien/mode_string_tables/alien_statstable.csv",4,param_01,2);
		}
		else
		{
			var_03 = tablelookup("mp/statstable.csv",4,var_02,2);
		}

		if(isdefined(level.attachmentmap_basetounique[var_03]) && isdefined(level.attachmentmap_basetounique[var_03][param_00]))
		{
			var_02 = level.attachmentmap_basetounique[var_03][param_00];
		}
	}

	return var_02;
}

//Function Number: 234
func_0FD0(param_00)
{
	var_01 = undefined;
	if(isdefined(level.attachmentmap_attachtoperk[param_00]))
	{
		var_01 = level.attachmentmap_attachtoperk[param_00];
	}

	return var_01;
}

//Function Number: 235
weaponperkmap(param_00)
{
	var_01 = undefined;
	if(isdefined(level.weaponmap_toperk[param_00]))
	{
		var_01 = level.weaponmap_toperk[param_00];
	}

	return var_01;
}

//Function Number: 236
func_487E(param_00,param_01)
{
	var_02 = strtok(param_00,"_");
	return isattachmentsniperscopedefaulttokenized(var_02,param_01);
}

//Function Number: 237
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

//Function Number: 238
getnumdefaultattachments(param_00)
{
	if(weaponclass(param_00) == "sniper")
	{
		var_01 = getweaponattachments(param_00);
		foreach(var_03 in var_01)
		{
			if(func_487E(param_00,var_03))
			{
				return 1;
			}
		}
	}
	else if(func_4971(param_00,"iw6_dlcweap02"))
	{
		var_01 = getweaponattachments(param_00);
		foreach(var_03 in var_01)
		{
			if(var_03 == "dlcweap02scope")
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 239
func_3C72(param_00)
{
	var_01 = getweaponattachments(param_00);
	foreach(var_04, var_03 in var_01)
	{
		var_01[var_04] = attachmentmap_tobase(var_03);
	}

	return var_01;
}

//Function Number: 240
getattachmentlistbasenames()
{
	var_00 = [];
	var_01 = 0;
	if(func_47BB())
	{
		var_02 = tablelookup("mp/alien/alien_attachmentTable.csv",0,var_01,5);
	}
	else
	{
		var_02 = tablelookup("mp/attachmentTable.csv",0,var_02,5);
	}

	while(var_02 != "")
	{
		if(!common_scripts\utility::array_contains(var_00,var_02))
		{
			var_00[var_00.size] = var_02;
		}

		var_01++;
		if(func_47BB())
		{
			var_02 = tablelookup("mp/alien/alien_attachmentTable.csv",0,var_01,5);
			continue;
		}

		var_02 = tablelookup("mp/attachmentTable.csv",0,var_01,5);
	}

	return var_00;
}

//Function Number: 241
getattachmentlistuniqenames()
{
	var_00 = [];
	var_01 = 0;
	if(func_47BB())
	{
		var_02 = tablelookup("mp/alien/alien_attachmentTable.csv",0,var_01,4);
	}
	else
	{
		var_02 = tablelookup("mp/attachmentTable.csv",0,var_02,4);
	}

	while(var_02 != "")
	{
		var_00[var_00.size] = var_02;
		var_01++;
		if(func_47BB())
		{
			var_02 = tablelookup("mp/alien/alien_attachmentTable.csv",0,var_01,4);
			continue;
		}

		var_02 = tablelookup("mp/attachmentTable.csv",0,var_01,4);
	}

	return var_00;
}

//Function Number: 242
func_1855()
{
	var_00 = getattachmentlistuniqenames();
	level.attachmentmap_uniquetobase = [];
	foreach(var_02 in var_00)
	{
		if(func_47BB())
		{
			var_03 = tablelookup("mp/alien/alien_attachmentTable.csv",4,var_02,5);
		}
		else
		{
			var_03 = tablelookup("mp/attachmenttable.csv",4,var_02,5);
		}

		if(var_02 == var_03)
		{
			continue;
		}

		level.attachmentmap_uniquetobase[var_02] = var_03;
	}

	var_05 = [];
	var_06 = 1;
	if(func_47BB())
	{
		var_07 = tablelookupbyrow("mp/alien/alien_attachmentmap.csv",var_06,0);
	}
	else
	{
		var_07 = tablelookupbyrow("mp/attachmentmap.csv",var_07,0);
	}

	while(var_07 != "")
	{
		var_05[var_05.size] = var_07;
		var_06++;
		if(func_47BB())
		{
			var_07 = tablelookupbyrow("mp/alien/alien_attachmentmap.csv",var_06,0);
			continue;
		}

		var_07 = tablelookupbyrow("mp/attachmentmap.csv",var_06,0);
	}

	var_08 = [];
	var_09 = 1;
	if(func_47BB())
	{
		var_0A = tablelookupbyrow("mp/alien/alien_attachmentmap.csv",0,var_09);
	}
	else
	{
		var_0A = tablelookupbyrow("mp/attachmentmap.csv",0,var_0A);
	}

	while(var_0A != "")
	{
		var_08[var_0A] = var_09;
		var_09++;
		if(func_47BB())
		{
			var_0A = tablelookupbyrow("mp/alien/alien_attachmentmap.csv",0,var_09);
			continue;
		}

		var_0A = tablelookupbyrow("mp/attachmentmap.csv",0,var_09);
	}

	level.attachmentmap_basetounique = [];
	foreach(var_07 in var_05)
	{
		foreach(var_0F, var_0D in var_08)
		{
			if(func_47BB())
			{
				var_0E = tablelookup("mp/alien/alien_attachmentmap.csv",0,var_07,var_0D);
			}
			else
			{
				var_0E = tablelookup("mp/attachmentmap.csv",0,var_07,var_0D);
			}

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
		if(func_47BB())
		{
			var_13 = tablelookup("mp/alien/alien_attachmenttable.csv",4,var_12,12);
		}
		else
		{
			var_13 = tablelookup("mp/attachmenttable.csv",4,var_12,12);
		}

		if(var_13 == "")
		{
			continue;
		}

		level.attachmentmap_attachtoperk[var_12] = var_13;
	}
}

//Function Number: 243
buildweaponperkmap()
{
	level.weaponmap_toperk = [];
	if(func_47BB())
	{
	}

	for(var_00 = 0;tablelookup("mp/statstable.csv",0,var_00,0) != "";var_00++)
	{
		var_01 = tablelookup("mp/statstable.csv",0,var_00,5);
		if(var_01 != "")
		{
			var_02 = tablelookup("mp/statstable.csv",0,var_00,4);
			if(var_02 != "")
			{
				level.weaponmap_toperk[var_02] = var_01;
			}
		}
	}
}

//Function Number: 244
attachmentmap_tobase(param_00)
{
	if(isdefined(level.attachmentmap_uniquetobase[param_00]))
	{
		param_00 = level.attachmentmap_uniquetobase[param_00];
	}

	return param_00;
}

//Function Number: 245
func_8DAC(param_00)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "semtexproj_mp":
				param_00 = "iw6_mk32_mp";
				break;

			case "iw6_maawshoming_mp":
			case "iw6_maawschild_mp":
				param_00 = "iw6_maaws_mp";
				break;

			case "iw6_knifeonlyfast_mp":
				param_00 = "iw6_knifeonly_mp";
				break;

			case "iw6_pdwauto_mp":
				param_00 = "iw6_pdw_mp";
				break;

			default:
				break;
		}
	}

	return param_00;
}

//Function Number: 246
weaponhasintegratedsilencer(param_00)
{
	return param_00 == "iw6_vks" || param_00 == "iw6_k7" || param_00 == "iw6_honeybadger";
}

//Function Number: 247
weaponisfiretypeburst(param_00)
{
	if(weaponhasintegratedfiretypeburst(param_00))
	{
		return 1;
	}

	return weaponhasattachment(param_00,"firetypeburst");
}

//Function Number: 248
weaponhasintegratedfiretypeburst(param_00)
{
	var_01 = func_3A37(param_00);
	if(var_01 == "iw6_pdw")
	{
		return 1;
	}

	if(var_01 == "iw6_msbs")
	{
		var_02 = func_3C72(param_00);
		foreach(var_04 in var_02)
		{
			if(var_04 == "firetypeauto" || var_04 == "firetypesingle")
			{
				return 0;
			}
		}

		return 1;
	}

	return 0;
}

//Function Number: 249
weaponhasintegratedgrip(param_00)
{
	return param_00 == "iw6_g28";
}

//Function Number: 250
weaponhasintegratedfmj(param_00)
{
	return param_00 == "iw6_cbjms";
}

//Function Number: 251
weaponhasintegratedtrackerscope(param_00)
{
	var_01 = func_3A37(param_00);
	if(var_01 == "iw6_dlcweap03")
	{
		var_02 = getweaponattachments(param_00);
		foreach(var_04 in var_02)
		{
			if(func_4971(var_04,"dlcweap03"))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 252
weaponhasattachment(param_00,param_01)
{
	var_02 = func_3C72(param_00);
	foreach(var_04 in var_02)
	{
		if(var_04 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 253
weapongetnumattachments(param_00)
{
	var_01 = getnumdefaultattachments(param_00);
	var_02 = getweaponattachments(param_00);
	return var_02.size - var_01;
}

//Function Number: 254
isplayerads()
{
	return self playerads() > 0.5;
}

//Function Number: 255
_objective_delete(param_00)
{
	objective_delete(param_00);
	if(!isdefined(level.reclaimedreservedobjectives))
	{
		level.reclaimedreservedobjectives = [];
		level.reclaimedreservedobjectives[0] = param_00;
	}

	level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = param_00;
}

//Function Number: 256
func_818D(param_00)
{
	var_01 = getentarray("trigger_hurt","classname");
	foreach(var_03 in var_01)
	{
		if(self istouching(var_03) && level.mapname != "mp_mine" || var_03.dmg > 0)
		{
			return 1;
		}
	}

	var_05 = getentarray("radiation","targetname");
	foreach(var_03 in var_05)
	{
		if(self istouching(var_03))
		{
			return 1;
		}
	}

	if(isdefined(param_00) && param_00 == "gryphon")
	{
		var_08 = getentarray("gryphonDeath","targetname");
		foreach(var_03 in var_08)
		{
			if(self istouching(var_03))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 257
func_70E6(param_00)
{
	if(param_00)
	{
		self setdepthoffield(0,110,512,4096,6,1.8);
	}

	self setdepthoffield(0,0,512,512,4,0);
}

//Function Number: 258
func_4B4F(param_00,param_01,param_02)
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

//Function Number: 259
func_3287(param_00,param_01,param_02)
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

//Function Number: 260
func_2A7E(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 261
drawsphere(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 262
func_70B1(param_00,param_01)
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
	}

	self player_recoilscaleon(var_02);
}

//Function Number: 263
func_1CBF(param_00)
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

//Function Number: 264
func_573A(param_00)
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

//Function Number: 265
func_4971(param_00,param_01)
{
	return getsubstr(param_00,0,param_01.size) == param_01;
}

//Function Number: 266
disableallstreaks()
{
	level.killstreaksdisabled = 1;
}

//Function Number: 267
func_2CE0()
{
	level.killstreaksdisabled = undefined;
}

//Function Number: 268
func_8818(param_00,param_01)
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

	if(!self isonground() && func_494D(var_02) || func_4897(var_02))
	{
		return 0;
	}

	if(func_4995())
	{
		return 0;
	}

	if(isdefined(self.selectinglocation))
	{
		return 0;
	}

	if(shouldpreventearlyuse(var_02) && level.killstreakrounddelay)
	{
		if(level.graceperiod - level.ingraceperiod < level.killstreakrounddelay)
		{
			if(!isdefined(param_01) && param_01)
			{
				self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_FOR_N",level.killstreakrounddelay - level.graceperiod - level.ingraceperiod);
			}

			return 0;
		}
	}

	if(isdefined(self.nuked) && self.nuked && func_48B2())
	{
		if(func_48F3(var_02))
		{
			if(!isdefined(param_01) && param_01)
			{
				self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_FOR_N_WHEN_NUKE",level.nukeemptimeremaining);
			}

			return 0;
		}
	}

	if(func_48B2())
	{
		if(func_48F3(var_02))
		{
			if(!isdefined(param_01) && param_01)
			{
				self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_WHEN_JAMMED");
			}

			return 0;
		}
	}

	if(isairdenied())
	{
		if(func_48C7(var_02) && var_02 != "air_superiority")
		{
			if(!isdefined(param_01) && param_01)
			{
				self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_WHEN_AA");
			}

			return 0;
		}
	}

	if(self isusingturret() && func_494D(var_02) || func_4897(var_02))
	{
		if(!isdefined(param_01) && param_01)
		{
			self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_USING_TURRET");
		}

		return 0;
	}

	if(isdefined(self.laststand) && !_hasperk("specialty_finalstand"))
	{
		if(!isdefined(level.allowlaststandai) || !level.allowlaststandai || var_02 != "agent")
		{
			if(!isdefined(param_01) && param_01)
			{
				self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LASTSTAND");
			}

			return 0;
		}
	}

	if(!common_scripts\utility::func_49B6())
	{
		return 0;
	}

	if(isdefined(level.civilianjetflyby) && func_48C7(var_02))
	{
		if(!isdefined(param_01) && param_01)
		{
			self iprintlnbold(&"KILLSTREAKS_CIVILIAN_AIR_TRAFFIC");
		}

		return 0;
	}

	return 1;
}

//Function Number: 269
func_494D(param_00)
{
	switch(param_00)
	{
		case "ac130":
		case "ca_a10_strafe":
		case "odin_assault":
		case "odin_support":
		case "drone_hive":
		case "heli_pilot":
		case "vanguard":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 270
func_4897(param_00)
{
	switch(param_00)
	{
		case "ims":
		case "deployable_exp_ammo":
		case "deployable_grenades":
		case "deployable_ammo":
		case "deployable_vest":
		case "gl_turret":
		case "minigun_turret":
		case "sentry_gl":
		case "sentry":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 271
shouldpreventearlyuse(param_00)
{
	switch(param_00)
	{
		case "uav_3dping":
		case "jammer":
		case "recon_agent":
		case "ball_drone_radar":
		case "aa_launcher":
		case "uplink_support":
		case "ball_drone_backup":
		case "guard_dog":
		case "uplink":
		case "ims":
		case "deployable_ammo":
		case "deployable_vest":
		case "air_superiority":
		case "sentry":
			return 0;

		default:
			return !func_4971(param_00,"airdrop_");
	}
}

//Function Number: 272
func_48F3(param_00)
{
	switch(param_00)
	{
		case "zerosub_level_killstreak":
		case "dome_seekers":
		case "recon_agent":
		case "guard_dog":
		case "deployable_ammo":
		case "deployable_vest":
		case "agent":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 273
iskillstreakaffectedbyjammer(param_00)
{
	return func_48F3(param_00) && !func_48C7(param_00);
}

//Function Number: 274
func_48C7(param_00)
{
	switch(param_00)
	{
		case "airdrop_juggernaut_maniac":
		case "airdrop_assault":
		case "heli_sniper":
		case "airdrop_juggernaut_recon":
		case "airdrop_juggernaut":
		case "airdrop_sentry_minigun":
		case "ac130":
		case "ca_a10_strafe":
		case "odin_assault":
		case "odin_support":
		case "drone_hive":
		case "heli_pilot":
		case "vanguard":
		case "air_superiority":
		case "helicopter":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 275
func_4870(param_00)
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

//Function Number: 276
getkillstreakrownum(param_00)
{
	return tablelookuprownum(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00);
}

//Function Number: 277
func_3AFB(param_00)
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

//Function Number: 278
getkillstreakreference(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].ref_col);
}

//Function Number: 279
getkillstreakreferencebyweapon(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].weapon_col,param_00,level.global_tables["killstreakTable"].ref_col);
}

//Function Number: 280
func_3AFD(param_00)
{
	return tablelookupistring(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].name_col);
}

//Function Number: 281
func_3AF3(param_00)
{
	return tablelookupistring(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].desc_col);
}

//Function Number: 282
func_3AFC(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].kills_col);
}

//Function Number: 283
getkillstreakearnedhint(param_00)
{
	return tablelookupistring(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].earned_hint_col);
}

//Function Number: 284
func_3B02(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].sound_col);
}

//Function Number: 285
func_3AF5(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].earned_dialog_col);
}

//Function Number: 286
func_3AEF(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].allies_dialog_col);
}

//Function Number: 287
func_3AF7(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].enemy_dialog_col);
}

//Function Number: 288
func_3AF8(param_00)
{
	return int(tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].enemy_use_dialog_col));
}

//Function Number: 289
getkillstreakweapon(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].weapon_col);
}

//Function Number: 290
getkillstreakscore(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].score_col);
}

//Function Number: 291
getkillstreakicon(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].icon_col);
}

//Function Number: 292
getkillstreakoverheadicon(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].overhead_icon_col);
}

//Function Number: 293
func_3AF4(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].dpad_icon_col);
}

//Function Number: 294
func_3B03(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].unearned_icon_col);
}

//Function Number: 295
getkillstreakallteamstreak(param_00)
{
	return tablelookup(level.global_tables["killstreakTable"].path,level.global_tables["killstreakTable"].ref_col,param_00,level.global_tables["killstreakTable"].all_team_streak_col);
}

//Function Number: 296
func_21E7(param_00)
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

//Function Number: 297
maxvehiclesallowed()
{
	return 8;
}

//Function Number: 298
func_4487()
{
	level.fauxvehiclecount++;
}

//Function Number: 299
decrementfauxvehiclecount()
{
	level.fauxvehiclecount--;
	var_00 = func_21E7();
	if(var_00 > level.fauxvehiclecount)
	{
		level.fauxvehiclecount = var_00;
	}

	if(level.fauxvehiclecount < 0)
	{
		level.fauxvehiclecount = 0;
	}
}

//Function Number: 300
func_4E12()
{
	return 1.07;
}

//Function Number: 301
allowteamchoice()
{
	if(level.gametype == "cranked")
	{
		return level.teambased;
	}

	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.gametype,4));
	return var_00;
}

//Function Number: 302
allowclasschoice()
{
	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.gametype,5));
	return var_00;
}

//Function Number: 303
showfakeloadout()
{
	if(level.gametype == "sotf" || level.gametype == "sotf_ffa" || level.gametype == "gun" || level.gametype == "infect")
	{
		return 1;
	}

	if(level.gametype == "horde" && !func_50C1() && issplitscreen())
	{
		return 0;
	}

	if(level.gametype == "horde" && level.currentroundnumber == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 304
setfakeloadoutweaponslot(param_00,param_01)
{
	var_02 = func_3A37(param_00);
	var_03 = [];
	if(var_02 != "iw6_knifeonly" && var_02 != "iw6_knifeonlyfast")
	{
		var_03 = getweaponattachments(param_00);
	}

	var_04 = "ui_fakeloadout_weapon" + param_01;
	if(isdefined(var_02))
	{
		var_05 = tablelookuprownum("mp/statsTable.csv",4,var_02);
		self setclientomnvar(var_04,var_05);
	}
	else
	{
		self setclientomnvar(var_04,-1);
	}

	for(var_06 = 0;var_06 < 3;var_06++)
	{
		var_07 = var_04 + "_attach" + var_06 + 1;
		var_08 = -1;
		if(isdefined(var_03[var_06]))
		{
			if(!func_487E(param_00,var_03[var_06]))
			{
				var_08 = tablelookuprownum("mp/attachmentTable.csv",4,var_03[var_06]);
			}
		}

		self setclientomnvar(var_07,var_08);
	}
}

//Function Number: 305
func_488C(param_00,param_01)
{
	var_02 = 4;
	var_03 = 0;
	var_04 = 4;
	var_05 = self getrankedplayerdata("weaponRank",param_01);
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

//Function Number: 306
func_488B(param_00,param_01)
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

//Function Number: 307
func_700A(param_00)
{
	var_01 = getmatchrulesdata("commonOption","timeLimit");
	setdynamicdvar("scr_" + level.gametype + "_timeLimit",var_01);
	func_6476(level.gametype,var_01);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_" + level.gametype + "_scoreLimit",var_02);
	func_6475(level.gametype,var_02);
	var_03 = getmatchrulesdata("commonOption","numLives");
	setdynamicdvar("scr_" + level.gametype + "_numLives",var_03);
	func_6470(level.gametype,var_03);
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
	level.supportintel = getmatchrulesdata("commonOption","allowIntel");
	setdynamicdvar("scr_game_hardpoints",getmatchrulesdata("commonOption","allowKillstreaks"));
	setdynamicdvar("scr_game_perks",getmatchrulesdata("commonOption","allowPerks"));
	setdynamicdvar("g_hardcore",getmatchrulesdata("commonOption","hardcoreModeOn"));
	setdynamicdvar("scr_game_onlyheadshots",getmatchrulesdata("commonOption","headshotsOnly"));
	if(!isdefined(param_00))
	{
		setdynamicdvar("scr_team_fftype",getmatchrulesdata("commonOption","friendlyFire"));
	}

	if(getmatchrulesdata("commonOption","hardcoreModeOn"))
	{
		setdynamicdvar("scr_team_fftype",2);
		setdynamicdvar("scr_player_maxhealth",30);
		setdynamicdvar("scr_player_healthregentime",0);
		setdynamicdvar("scr_player_respawndelay",0);
		setdynamicdvar("scr_game_allowkillcam",0);
		setdynamicdvar("scr_game_forceuav",0);
	}

	setdvar("bg_compassShowEnemies",getdvar("scr_game_forceuav"));
}

//Function Number: 308
func_647E()
{
	for(;;)
	{
		level waittill("host_migration_begin");
		[[ level.initializematchrules ]]();
	}
}

//Function Number: 309
func_647F(param_00)
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

//Function Number: 310
func_3B24(param_00,param_01)
{
	var_02 = [];
	var_02["loadoutPrimaryAttachment2"] = "none";
	var_02["loadoutSecondaryAttachment2"] = "none";
	var_03 = [];
	var_02["loadoutPrimary"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"weapon");
	var_02["loadoutPrimaryAttachment"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"attachment",0);
	var_02["loadoutPrimaryAttachment2"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"attachment",1);
	var_02["loadoutPrimaryBuff"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"buff");
	var_02["loadoutPrimaryCamo"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"camo");
	var_02["loadoutPrimaryReticle"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",0,"reticle");
	var_02["loadoutSecondary"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"weapon");
	var_02["loadoutSecondaryAttachment"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"attachment",0);
	var_02["loadoutSecondaryAttachment2"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"attachment",1);
	var_02["loadoutSecondaryBuff"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"buff");
	var_02["loadoutSecondaryCamo"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"camo");
	var_02["loadoutSecondaryReticle"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","weaponSetups",1,"reticle");
	var_02["loadoutEquipment"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","perks",0);
	var_02["loadoutOffhand"] = getmatchrulesdata("defaultClasses",param_00,param_01,"class","perks",1);
	if(var_02["loadoutOffhand"] == "specialty_null")
	{
		var_02["loadoutOffhand"] = "none";
		if(level.gametype == "infect" && param_00 == "axis")
		{
			var_02["loadoutOffhand"] = "specialty_tacticalinsertion";
		}
	}

	for(var_04 = 0;var_04 < maps\mp\gametypes\_class::getnumabilitycategories();var_04++)
	{
		for(var_05 = 0;var_05 < maps\mp\gametypes\_class::getnumsubability();var_05++)
		{
			var_06 = 0;
			var_06 = getmatchrulesdata("defaultClasses",param_00,param_01,"class","abilitiesPicked",var_04,var_05);
			if(isdefined(var_06) && var_06)
			{
				var_07 = tablelookup("mp/cacAbilityTable.csv",0,var_04 + 1,var_05 + 4);
				var_03[var_03.size] = var_07;
			}
		}
	}

	var_02["loadoutPerks"] = var_03;
	var_08 = getmatchrulesdata("defaultClasses",param_00,param_01,"class","perks",5);
	if(var_08 != "specialty_null")
	{
		var_02["loadoutStreakType"] = var_08;
		var_02["loadoutKillstreak1"] = maps\mp\gametypes\_class::recipe_getkillstreak(param_00,param_01,var_08,0);
		var_02["loadoutKillstreak2"] = maps\mp\gametypes\_class::recipe_getkillstreak(param_00,param_01,var_08,1);
		var_02["loadoutKillstreak3"] = maps\mp\gametypes\_class::recipe_getkillstreak(param_00,param_01,var_08,2);
	}

	var_02["loadoutJuggernaut"] = getmatchrulesdata("defaultClasses",param_00,param_01,"juggernaut");
	return var_02;
}

//Function Number: 311
recipeclassapplyjuggernaut(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	if(level.ingraceperiod && !self.hasdonecombat)
	{
		self waittill("giveLoadout");
	}
	else
	{
		self waittill("spawned_player");
	}

	if(param_00)
	{
		self notify("lost_juggernaut");
		wait(0.5);
	}

	if(!isdefined(self.isjuiced))
	{
		self.movespeedscaler = 0.7;
		maps\mp\gametypes\_weapons::func_8707();
	}

	self.juggmovespeedscaler = 0.7;
	self disableweaponpickup();
	if(!getdvarint("camera_thirdPerson"))
	{
		self setclientomnvar("ui_juggernaut",1);
	}

	thread maps\mp\killstreaks\_juggernaut::func_4A2A();
	if(level.gametype != "jugg" || isdefined(level.matchrules_showjuggradaricon) && level.matchrules_showjuggradaricon)
	{
		self setperk("specialty_radarjuggernaut",1,0);
	}

	if(isdefined(self.isjuggmodejuggernaut) && self.isjuggmodejuggernaut)
	{
		self makeportableradar(self);
	}

	level notify("juggernaut_equipped",self);
	thread maps\mp\killstreaks\_juggernaut::func_4A2D();
}

//Function Number: 312
func_8730(param_00,param_01)
{
	self.sessionstate = param_00;
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	self.statusicon = param_01;
	self setclientomnvar("ui_session_state",param_00);
}

//Function Number: 313
func_3A55(param_00)
{
	return level.classmap[param_00];
}

//Function Number: 314
isteaminlaststand()
{
	var_00 = func_3B16(self.team);
	foreach(var_02 in var_00)
	{
		if(var_02 != self && !isdefined(var_02.laststand) || !var_02.laststand)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 315
killteaminlaststand(param_00)
{
	var_01 = func_3B16(param_00);
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.laststand) && var_03.laststand)
		{
			var_03 thread maps\mp\gametypes\_damage::func_2726(randomintrange(1,3));
		}
	}
}

//Function Number: 316
func_7E17(param_00)
{
	if(!isai(self))
	{
		self switchtoweapon(param_00);
	}

	self switchtoweapon("none");
}

//Function Number: 317
func_486C(param_00)
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

//Function Number: 318
func_4984(param_00)
{
	if(func_486C(param_00))
	{
		return 1;
	}

	if(isplayer(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 319
isaigameparticipant(param_00)
{
	if(isagent(param_00) && isdefined(param_00.agent_gameparticipant) && param_00.agent_gameparticipant == 1)
	{
		return 1;
	}

	if(isbot(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 320
func_48CE(param_00)
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

//Function Number: 321
func_3C3B(param_00)
{
	var_01 = 0;
	if(level.teambased)
	{
		switch(param_00)
		{
			case "axis":
				var_01 = 1;
				break;

			case "allies":
				var_01 = 2;
				break;
		}
	}

	return var_01;
}

//Function Number: 322
getteamarray(param_00,param_01)
{
	var_02 = [];
	if(!isdefined(param_01) || param_01)
	{
		foreach(var_04 in level.characters)
		{
			if(var_04.team == param_00)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}
	else
	{
		foreach(var_04 in level.players)
		{
			if(var_04.team == param_00)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 323
func_48D2(param_00,param_01,param_02,param_03)
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

	return (param_01 == "head" || param_01 == "helmet") && param_02 != "MOD_MELEE" && param_02 != "MOD_IMPACT" && param_02 != "MOD_SCARAB" && param_02 != "MOD_CRUSH" && !func_48B7(param_00);
}

//Function Number: 324
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

	if(level.gametype == "infect" && param_00.pers["team"] == param_01.team && isdefined(param_01.teamchangedthisframe))
	{
		return 0;
	}

	if(level.gametype == "infect" && param_00.pers["team"] != param_01.team && isdefined(param_01.teamchangedthisframe))
	{
		return 1;
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

//Function Number: 325
set_high_priority_target_for_bot(param_00)
{
	if(!isdefined(self.high_priority_for) && common_scripts\utility::array_contains(self.high_priority_for,param_00))
	{
		self.high_priority_for = common_scripts\utility::array_add(self.high_priority_for,param_00);
		param_00 notify("calculate_new_level_targets");
	}
}

//Function Number: 326
add_to_bot_use_targets(param_00,param_01)
{
	if(isdefined(level.bot_funcs["bots_add_to_level_targets"]))
	{
		param_00.use_time = param_01;
		param_00.bot_interaction_type = "use";
		[[ level.bot_funcs["bots_add_to_level_targets"] ]](param_00);
	}
}

//Function Number: 327
func_652A(param_00)
{
	if(isdefined(level.bot_funcs["bots_remove_from_level_targets"]))
	{
		[[ level.bot_funcs["bots_remove_from_level_targets"] ]](param_00);
	}
}

//Function Number: 328
add_to_bot_damage_targets(param_00)
{
	if(isdefined(level.bot_funcs["bots_add_to_level_targets"]))
	{
		param_00.bot_interaction_type = "damage";
		[[ level.bot_funcs["bots_add_to_level_targets"] ]](param_00);
	}
}

//Function Number: 329
remove_from_bot_damage_targets(param_00)
{
	if(isdefined(level.bot_funcs["bots_remove_from_level_targets"]))
	{
		[[ level.bot_funcs["bots_remove_from_level_targets"] ]](param_00);
	}
}

//Function Number: 330
func_5707(param_00)
{
	if(isdefined(level.bot_funcs["notify_enemy_bots_bomb_used"]))
	{
		self [[ level.bot_funcs["notify_enemy_bots_bomb_used"] ]](param_00);
	}
}

//Function Number: 331
func_397A()
{
	if(isdefined(level.bot_funcs["bot_get_rank_xp"]))
	{
		return self [[ level.bot_funcs["bot_get_rank_xp"] ]]();
	}
}

//Function Number: 332
func_8FFB()
{
	var_00 = 1;
	if(getdvar("squad_use_hosts_squad") == "1")
	{
		var_01 = undefined;
		if(isdefined(self.bot_team))
		{
			var_01 = self.bot_team;
		}
		else if(isdefined(self.pers["team"]))
		{
			var_01 = self.pers["team"];
		}

		if(isdefined(var_01) && level.wargame_client.team == var_01)
		{
			var_00 = 0;
		}
		else
		{
			var_00 = 1;
		}
	}
	else
	{
		var_00 = self botisrandomized();
	}

	return var_00;
}

//Function Number: 333
isassaultkillstreak(param_00)
{
	switch(param_00)
	{
		case "airdrop_juggernaut_maniac":
		case "airdrop_assault":
		case "airdrop_juggernaut":
		case "airdrop_sentry_minigun":
		case "ball_drone_backup":
		case "guard_dog":
		case "uplink":
		case "ims":
		case "odin_assault":
		case "drone_hive":
		case "heli_pilot":
		case "vanguard":
		case "sentry":
		case "helicopter":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 334
issupportkillstreak(param_00)
{
	switch(param_00)
	{
		case "sam_turret":
		case "heli_sniper":
		case "airdrop_juggernaut_recon":
		case "uav_3dping":
		case "jammer":
		case "recon_agent":
		case "ball_drone_radar":
		case "aa_launcher":
		case "uplink_support":
		case "deployable_ammo":
		case "deployable_vest":
		case "odin_support":
		case "air_superiority":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 335
func_496B(param_00)
{
	switch(param_00)
	{
		case "specialty_deadeye_ks":
		case "specialty_boom_ks":
		case "specialty_twoprimaries_ks":
		case "specialty_hardline_ks":
		case "specialty_gambler_ks":
		case "specialty_explosivedamage_ks":
		case "specialty_extra_attachment_ks":
		case "specialty_extra_deadly_ks":
		case "specialty_extra_equipment_ks":
		case "specialty_extraammo_ks":
		case "specialty_gunsmith_ks":
		case "_specialty_blastshield_ks":
		case "specialty_stun_resistance_ks":
		case "specialty_sharp_focus_ks":
		case "specialty_regenfaster_ks":
		case "specialty_falldamage_ks":
		case "specialty_comexp_ks":
		case "specialty_selectivehearing_ks":
		case "specialty_detectexplosive_ks":
		case "specialty_scavenger_ks":
		case "specialty_paint_ks":
		case "specialty_incog_ks":
		case "specialty_quieter_ks":
		case "specialty_gpsjammer_ks":
		case "specialty_blindeye_ks":
		case "specialty_silentkill_ks":
		case "specialty_sprintreload_ks":
		case "specialty_quickdraw_ks":
		case "specialty_bulletaccuracy_ks":
		case "specialty_pitcher_ks":
		case "specialty_quickswap_ks":
		case "specialty_reducedsway_ks":
		case "specialty_stalker_ks":
		case "specialty_marathon_ks":
		case "specialty_lightweight_ks":
		case "specialty_fastreload_ks":
		case "specialty_fastsprintrecovery_ks":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 336
bot_is_fireteam_mode()
{
	var_00 = botautoconnectenabled() == 2;
	if(var_00)
	{
		if(!level.teambased || level.gametype != "war" && level.gametype != "dom")
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 337
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

//Function Number: 338
func_47F6()
{
	if(level.xb3 || level.ps4 || !level.console)
	{
		return 1;
	}

	return 0;
}

//Function Number: 339
func_7026(param_00,param_01,param_02)
{
	if(!isdefined(level.console) || !isdefined(level.xb3) || !isdefined(level.ps4))
	{
		set_console_status();
	}

	if(func_47F6())
	{
		setdvar(param_00,param_02);
	}

	setdvar(param_00,param_01);
}

//Function Number: 340
func_49AB(param_00,param_01,param_02)
{
	return isdefined(param_02.team) && param_02.team == param_01;
}

//Function Number: 341
isvalidffatarget(param_00,param_01,param_02)
{
	return isdefined(param_02.owner) && !isdefined(param_00) || param_02.owner != param_00;
}

//Function Number: 342
gethelipilotmeshoffset()
{
	return (0,0,5000);
}

//Function Number: 343
func_3AC9()
{
	return (0,0,2500);
}

//Function Number: 344
getlinknamenodes()
{
	var_00 = [];
	if(isdefined(self.script_linkto))
	{
		var_01 = strtok(self.script_linkto," ");
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = getnode(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 345
func_47BB()
{
	return level.gametype == "aliens";
}

//Function Number: 346
func_3959(param_00,param_01)
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
		if(var_05 == self)
		{
			continue;
		}

		var_06 = 0;
		if(!param_01)
		{
			if(var_05.team == "spectator" || var_05.sessionstate == "spectator")
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

//Function Number: 347
set_visionset_for_watching_players(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_3959(param_04,param_05);
	foreach(var_08 in var_06)
	{
		var_08 notify("changing_watching_visionset");
		if(isdefined(param_03) && param_03)
		{
			var_08 visionsetmissilecamforplayer(param_00,param_01);
		}
		else
		{
			var_08 visionsetnakedforplayer(param_00,param_01);
		}

		if(param_00 != "" && isdefined(param_02))
		{
			var_08 thread func_6602(self,param_01 + param_02);
			var_08 thread func_6601(self);
			if(var_08 func_48E2())
			{
				var_08 thread reset_visionset_on_spawn();
			}
		}
	}
}

//Function Number: 348
reset_visionset_on_spawn()
{
	self endon("disconnect");
	self waittill("spawned");
	self visionsetnakedforplayer("",0);
}

//Function Number: 349
func_6602(param_00,param_01)
{
	self endon("changing_watching_visionset");
	var_02 = gettime();
	var_03 = self.team;
	while(gettime() - var_02 < param_01 * 1000)
	{
		if(self.team != var_03 || !common_scripts\utility::array_contains(param_00 func_3959(),self))
		{
			self visionsetnakedforplayer("",0);
			self notify("changing_visionset");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 350
func_6601(param_00)
{
	self endon("changing_watching_visionset");
	param_00 waittill("disconnect");
	self visionsetnakedforplayer("",0);
}

//Function Number: 351
_setplayerdata(param_00,param_01)
{
	if(func_50C1())
	{
		self setrankedplayerdata(param_00,param_01);
	}

	self setprivateplayerdata(param_00,param_01);
}

//Function Number: 352
_getplayerdata(param_00)
{
	if(func_50C1())
	{
		return self getrankedplayerdata(param_00);
	}

	return self getprivateplayerdata(param_00);
}

//Function Number: 353
_validateattacker(param_00)
{
	if(isagent(param_00) && !isdefined(param_00.isactive) || !param_00.isactive)
	{
		return undefined;
	}

	if(isagent(param_00) && !isdefined(param_00.classname))
	{
		return undefined;
	}

	return param_00;
}

//Function Number: 354
func_8B68()
{
	self waittill("grenade_fire",var_00,var_01);
	if(isdefined(var_00))
	{
		if(!isdefined(var_00.weapon_name))
		{
			var_00.weapon_name = var_01;
		}

		if(!isdefined(var_00.owner))
		{
			var_00.owner = self;
		}

		if(!isdefined(var_00.team))
		{
			var_00.team = self.team;
		}
	}

	return var_00;
}

//Function Number: 355
func_8B6F()
{
	self waittill("missile_fire",var_00,var_01);
	if(isdefined(var_00))
	{
		if(!isdefined(var_00.weapon_name))
		{
			var_00.weapon_name = var_01;
		}

		if(!isdefined(var_00.owner))
		{
			var_00.owner = self;
		}

		if(!isdefined(var_00.team))
		{
			var_00.team = self.team;
		}
	}

	return var_00;
}

//Function Number: 356
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

//Function Number: 357
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

//Function Number: 358
isplayeroutsideofanybombsite(param_00)
{
	if(isdefined(level.bombzones))
	{
		foreach(var_02 in level.bombzones)
		{
			if(self istouching(var_02.trigger))
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 359
weaponignoresblastshield(param_00)
{
	return param_00 == "heli_pilot_turret_mp" || param_00 == "bomb_site_mp";
}

//Function Number: 360
func_49B3(param_00)
{
	return param_00 == "ims_projectile_mp" || param_00 == "remote_tank_projectile_mp";
}

//Function Number: 361
func_6659(param_00)
{
	self visionsetnakedforplayer("",param_00);
}

//Function Number: 362
playplayerandnpcsounds(param_00,param_01,param_02)
{
	param_00 playlocalsound(param_01);
	param_00 playsoundtoteam(param_02,"allies",param_00);
	param_00 playsoundtoteam(param_02,"axis",param_00);
}

//Function Number: 363
isenemy(param_00)
{
	if(level.teambased)
	{
		return isplayeronenemyteam(param_00);
	}

	return isplayerffaenemy(param_00);
}

//Function Number: 364
isplayeronenemyteam(param_00)
{
	return param_00.team != self.team;
}

//Function Number: 365
isplayerffaenemy(param_00)
{
	if(isdefined(param_00.owner))
	{
		return param_00.owner != self;
	}

	return param_00 != self;
}

//Function Number: 366
setextrascore0(param_00)
{
	self.extrascore0 = param_00;
	func_7093("extrascore0",param_00);
}

//Function Number: 367
allowlevelkillstreaks()
{
	if(level.gametype == "sotf" && level.gametype == "sotf_ffa" && level.gametype == "infect" && level.gametype == "horde")
	{
		return 0;
	}

	return 1;
}

//Function Number: 368
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

//Function Number: 369
getrandomplayingplayer()
{
	var_00 = common_scripts\utility::array_removeundefined(level.players);
	for(;;)
	{
		if(!var_00.size)
		{
		}

		var_01 = randomintrange(0,var_00.size);
		var_02 = var_00[var_01];
		if(!func_4945(var_02) || var_02.sessionstate != "playing")
		{
			var_00 = common_scripts\utility::array_remove(var_00,var_02);
			continue;
		}

		return var_02;
	}
}

//Function Number: 370
getmapname()
{
	if(!isdefined(level.mapname))
	{
		level.mapname = getdvar("mapname");
	}

	return level.mapname;
}

//Function Number: 371
issinglehitweapon(param_00)
{
	switch(param_00)
	{
		case "iw6_panzerfaust3_mp":
		case "iw6_rgm_mp":
		case "iw6_maaws_mp":
		case "iw6_mk32_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 372
gamehasneutralcrateowner(param_00)
{
	switch(param_00)
	{
		case "sotf_ffa":
		case "sotf":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 373
array_remove_keep_index(param_00,param_01)
{
	var_02 = [];
	foreach(var_05, var_04 in param_00)
	{
		if(var_04 != param_01)
		{
			var_02[var_05] = var_04;
		}
	}

	return var_02;
}

//Function Number: 374
isanymlgmatch()
{
	if(getdvarint("xblive_competitionmatch"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 375
func_92AD()
{
	if(getdvarint("systemlink") && getdvarint("xblive_competitionmatch"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 376
func_92AC()
{
	if(func_61B9() && getdvarint("xblive_competitionmatch"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 377
func_92AB()
{
	if(func_92AD() || func_92AC())
	{
		return 1;
	}

	return 0;
}

//Function Number: 378
func_4912()
{
	if(level.gametype == "blitz" || level.gametype == "dom")
	{
		return 1;
	}

	return 0;
}

//Function Number: 379
isusingdefaultclass(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_01))
	{
		if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses",param_00,param_01,"class","inUse"))
		{
			var_02 = 1;
		}
	}
	else
	{
		for(param_01 = 0;param_01 < 6;param_01++)
		{
			if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses",param_00,param_01,"class","inUse"))
			{
				var_02 = 1;
				break;
			}
		}
	}

	return var_02;
}

//Function Number: 380
cancustomjuggusekillstreak(param_00)
{
	var_01 = 1;
	if(isdefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom && isdefined(self.canusekillstreakcallback) && !self [[ self.canusekillstreakcallback ]](param_00))
	{
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 381
printcustomjuggkillstreakerrormsg()
{
	if(isdefined(self.killstreakerrormsg))
	{
		[[ self.killstreakerrormsg ]]();
	}
}