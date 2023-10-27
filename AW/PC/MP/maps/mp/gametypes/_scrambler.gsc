/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_scrambler.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 277 ms
 * Timestamp: 10/27/2023 1:50:57 AM
*******************************************************************/

//Function Number: 1
playersethudempscrambled(param_00,param_01,param_02)
{
	var_03 = gettime();
	if(var_03 > param_00)
	{
		return;
	}

	if(!isdefined(self.scrambleevents))
	{
		self.scrambleevents = [];
	}

	_playercleanupscrambleevents();
	var_04 = spawnstruct();
	var_04.endtime = param_00;
	var_04.textid = param_01;
	var_04.typeid = _getscrambletypeidforstring(param_02);
	var_04.scrambleid = _playergetuniquescrambleid();
	self.scrambleevents[self.scrambleevents.size] = var_04;
	if(!isdefined(self.scrambleeventcurrent) || isevent1highpriority(var_04,self.scrambleeventcurrent))
	{
		self setclientomnvar("ui_exo_reboot_end_time",var_04.endtime);
		self setclientomnvar("ui_exo_reboot_text",var_04.textid);
		self setclientomnvar("ui_exo_reboot_type",var_04.typeid);
		self.scrambleeventcurrent = var_04;
		thread _playermonitorscrambleevents(var_04);
	}

	return var_04.scrambleid;
}

//Function Number: 2
playersethudempscrambledoff(param_00)
{
	if(!isdefined(self.scrambleevents))
	{
		return;
	}

	var_01 = _playergetscrambleevent(param_00);
	_playercleanupscrambleevents();
	if(isdefined(var_01))
	{
		self.scrambleevents = common_scripts\utility::array_remove(self.scrambleevents,var_01);
		var_01 notify("done");
		if(var_01 == self.scrambleeventcurrent)
		{
			var_02 = _playergetnextevent();
			if(isdefined(var_02))
			{
				self setclientomnvar("ui_exo_reboot_end_time",var_02.endtime);
				self setclientomnvar("ui_exo_reboot_text",var_02.textid);
				self setclientomnvar("ui_exo_reboot_type",var_02.typeid);
				self.scrambleeventcurrent = var_02;
			}
		}
	}

	if(self.scrambleevents.size == 0)
	{
		self setclientomnvar("ui_exo_reboot_end_time",0);
		self setclientomnvar("ui_exo_reboot_type",0);
		self.scrambleevents = undefined;
		self.scrambleeventcurrent = undefined;
	}
}

//Function Number: 3
_playermonitorscrambleevents(param_00)
{
	self notify("_waitToStartNextScrambleEvent");
	self endon("_waitToStartNextScrambleEvent");
	level endon("game_ended");
	self endon("disconnect");
	while(isdefined(self.scrambleeventcurrent))
	{
		var_01 = self.scrambleeventcurrent.endtime - gettime() / 1000;
		var_02 = self.scrambleeventcurrent common_scripts\utility::waittill_notify_or_timeout_return("done",var_01);
		if(isdefined(var_02) && var_02 == "timeout")
		{
			playersethudempscrambledoff(self.scrambleeventcurrent.scrambleid);
		}
	}
}

//Function Number: 4
_getscrambletypeidforstring(param_00)
{
	switch(param_00)
	{
		case "emp":
			break;

		case "systemHack":
			break;

		default:
			break;
	}
}

//Function Number: 5
_playercleanupscrambleevents()
{
	if(self.scrambleevents.size == 0)
	{
		return;
	}

	var_00 = [];
	var_01 = gettime();
	foreach(var_03 in self.scrambleevents)
	{
		if(var_01 < var_03.endtime)
		{
			var_00[var_00.size] = var_03;
		}
	}

	self.scrambleevents = var_00;
}

//Function Number: 6
_playergetuniquescrambleid()
{
	var_00 = 0;
	foreach(var_02 in self.scrambleevents)
	{
		if(var_02.scrambleid >= var_00)
		{
			var_00 = var_02.scrambleid + 1;
		}
	}

	return var_00;
}

//Function Number: 7
_playergetscrambleevent(param_00)
{
	foreach(var_02 in self.scrambleevents)
	{
		if(var_02.scrambleid == param_00)
		{
			return var_02;
		}
	}
}

//Function Number: 8
_playergetnextevent()
{
	if(self.scrambleevents.size == 0)
	{
		return;
	}

	var_00 = self.scrambleevents[0];
	for(var_01 = 1;var_01 < self.scrambleevents.size;var_01++)
	{
		var_02 = self.scrambleevents[var_01];
		if(isevent1highpriority(var_02,var_00))
		{
			var_00 = var_02;
		}
	}

	return var_00;
}

//Function Number: 9
isevent1highpriority(param_00,param_01)
{
	return param_00.typeid > param_01.typeid || param_00.typeid == param_01.typeid && param_00.endtime > param_01.endtime;
}

//Function Number: 10
deletescrambler(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	foreach(var_02 in level.players)
	{
		if(isdefined(var_02))
		{
			var_02.inplayerscrambler = undefined;
		}
	}

	param_00 notify("death");
	param_00 delete();
	self.deployedscrambler = undefined;
	var_04 = [];
	var_04 = maps\mp\_utility::cleanarray(level.scramblers);
	level.scramblers = var_04;
}

//Function Number: 11
monitorscrambleruse()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "scrambler" || var_01 == "scrambler_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			var_00 hide();
			var_00 waittill("missile_stuck");
			var_02 = 40;
			if(var_02 * var_02 < distancesquared(var_00.origin,self.origin))
			{
				var_03 = bullettrace(self.origin,self.origin - (0,0,var_02),0,self);
				if(var_03["fraction"] == 1)
				{
					var_00 delete();
					self setweaponammostock("scrambler_mp",self setweaponammostock("scrambler_mp") + 1);
					continue;
				}

				var_00.origin = var_03["position"];
			}

			var_00 show();
			if(isdefined(self.deployedscrambler))
			{
				deletescrambler(self.deployedscrambler);
			}

			var_04 = var_00.origin;
			var_05 = spawn("script_model",var_04);
			var_05.health = 100;
			var_05.team = self.team;
			var_05.owner = self;
			var_05 setcandamage(1);
			var_05 makescrambler(self);
			var_05 common_scripts\utility::make_entity_sentient_mp(self.team,1);
			var_05 scramblersetup(self);
			var_05 thread maps\mp\gametypes\_weapons::createbombsquadmodel("weapon_jammer_bombsquad","tag_origin",self);
			level.scramblers[level.scramblers.size] = var_05;
			self.deployedscrambler = var_05;
			self.changingweapon = undefined;
			wait(0.05);
			if(isdefined(var_00))
			{
				var_00 delete();
			}
		}
	}
}

//Function Number: 12
scramblersetup(param_00)
{
	self setmodel("weapon_jammer");
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,20));
	}
	else
	{
		maps\mp\_entityheadicons::setplayerheadicon(param_00,(0,0,20));
	}

	thread scramblerdamagelistener(param_00);
	thread scrambleruselistener(param_00);
	param_00 thread scramblerwatchowner(self);
	thread scramblerbeepsounds();
	thread maps\mp\_utility::notusableforjoiningplayers(param_00);
}

//Function Number: 13
scramblerwatchowner(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators","death");
	level thread deletescrambler(param_00);
}

//Function Number: 14
scramblerbeepsounds()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(3);
		self playsound("scrambler_beep");
	}
}

//Function Number: 15
scramblerdamagelistener(param_00)
{
	self endon("death");
	self.health = 999999;
	self.maxhealth = 100;
	self.damagetaken = 0;
	self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
	if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_02))
	{
		continue;
	}

	if(isdefined(var_0A))
	{
		var_0B = maps\mp\_utility::strip_suffix(var_0A,"_lefthand");
		switch(var_0B)
		{
			case "smoke_grenade_var_mp":
			case "stun_grenade_var_mp":
			case "smoke_grenade_mp":
			case "stun_grenade_mp":
			case "concussion_grenade_mp":
			case "flash_grenade_mp":
				break;
		}
	}
}

//Function Number: 16
scrambleruselistener(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"MP_PATCH_PICKUP_SCRAMBLER");
	maps\mp\_utility::setselfusable(param_00);
	for(;;)
	{
		self waittill("trigger",param_00);
		var_01 = param_00 setweaponammostock("scrambler_mp");
		if(var_01 < weaponmaxammo("scrambler_mp"))
		{
			param_00 playlocalsound("scavenger_pack_pickup");
			param_00 setweaponammostock("scrambler_mp",var_01 + 1);
			param_00 thread deletescrambler(self);
		}
	}
}

//Function Number: 17
scramblerproximitytracker()
{
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	level endon("game_ended");
	self.scramproxyactive = 0;
	var_00 = 512;
	for(;;)
	{
		wait(0.05);
		self.scramproxyactive = 0;
		foreach(var_02 in level.scramblers)
		{
			if(!isdefined(var_02))
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(self))
			{
				continue;
			}

			var_03 = distancesquared(var_02.origin,self.origin);
			if((level.teambased && var_02.team != self.team) || !level.teambased && isdefined(var_02.owner) && var_02.owner != self)
			{
				if(var_03 < var_00 * var_00)
				{
					self.inplayerscrambler = var_02.owner;
				}
				else
				{
					self.inplayerscrambler = undefined;
				}

				continue;
			}

			if(var_03 < var_00 * var_00)
			{
				self.scramproxyactive = 1;
				break;
			}
		}

		if(self.scramproxyactive)
		{
			if(!maps\mp\_utility::_hasperk("specialty_blindeye"))
			{
				maps\mp\_utility::giveperk("specialty_blindeye",0);
				self.scramproxyperk = 1;
			}

			continue;
		}

		if(isdefined(self.scramproxyperk) && self.scramproxyperk)
		{
			self.scramproxyperk = 0;
		}
	}
}