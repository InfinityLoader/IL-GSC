/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_battlebuddy.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 417 ms
 * Timestamp: 4/22/2024 2:09:02 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.battlebuddywaitlist))
	{
		level.battlebuddywaitlist = [];
	}

	level thread onplayerspawned();
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",var_00);
		var_00 thread initteamspawnelements();
		var_00 thread onbattlebuddymenuselection();
		var_00 thread ondisconnect();
	}
}

//Function Number: 3
onplayerspawned()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(!isai(var_00))
		{
			var_00.isspawningonbattlebuddy = undefined;
			if(var_00 wantsbattlebuddy())
			{
				if(!var_00 hasbattlebuddy())
				{
					var_00.firstspawn = 0;
					var_00 findbattlebuddy();
				}

				continue;
			}

			if(var_00 hasbattlebuddy())
			{
				var_00 clearbattlebuddy();
			}
		}
	}
}

//Function Number: 4
initteamspawnelements()
{
	if(!isdefined(self.kc_teamspawntext))
	{
		self.kc_teamspawntext = newclienthudelem(self);
		self.kc_teamspawntext.archived = 0;
		self.kc_teamspawntext.y = 34;
		self.kc_teamspawntext.alignx = "left";
		self.kc_teamspawntext.aligny = "top";
		self.kc_teamspawntext.horzalign = "center";
		self.kc_teamspawntext.vertalign = "middle";
		self.kc_teamspawntext.sort = 10;
		self.kc_teamspawntext.font = "small";
		self.kc_teamspawntext.foreground = 1;
		self.kc_teamspawntext.hidewheninmenu = 1;
		if(level.splitscreen)
		{
			self.kc_teamspawntext.x = 16;
			self.kc_teamspawntext.fontscale = 1.2;
		}
		else
		{
			self.kc_teamspawntext.x = 62;
			self.kc_teamspawntext.fontscale = 1.6;
		}
	}

	if(!isdefined(self.kc_randomspawntext))
	{
		self.kc_randomspawntext = newclienthudelem(self);
		self.kc_randomspawntext.archived = 0;
		self.kc_randomspawntext.y = 58;
		self.kc_randomspawntext.alignx = "left";
		self.kc_randomspawntext.aligny = "top";
		self.kc_randomspawntext.horzalign = "center";
		self.kc_randomspawntext.vertalign = "middle";
		self.kc_randomspawntext.sort = 10;
		self.kc_randomspawntext.font = "small";
		self.kc_randomspawntext.foreground = 1;
		self.kc_randomspawntext.hidewheninmenu = 1;
		if(level.splitscreen)
		{
			self.kc_randomspawntext.x = 16;
			self.kc_randomspawntext.fontscale = 1.2;
			return;
		}

		self.kc_randomspawntext.x = 62;
		self.kc_randomspawntext.fontscale = 1.6;
	}
}

//Function Number: 5
onbattlebuddymenuselection()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "battlebuddy_update")
		{
			var_02 = !wantsbattlebuddy();
			self setplayerdata("enableBattleBuddy",var_02);
			if(var_02)
			{
				findbattlebuddy();
			}
			else if(hasbattlebuddy())
			{
				if(!isalive(self.battlebuddy))
				{
					self.battlebuddy setupforrandomspawn();
				}
				else if(!isalive(self))
				{
					setupforrandomspawn();
				}

				clearbattlebuddy();
			}
			else
			{
				removefrombattlebuddywaitlist(self);
				self setclientdvar("ui_battle_buddy_entity_num",-1);
			}

			continue;
		}

		if(var_00 == "team_select")
		{
			removefrombattlebuddywaitlist(self);
		}
	}
}

//Function Number: 6
ondisconnect()
{
}

//Function Number: 7
waitforplayerrespawnchoice()
{
	maps\mp\_utility::updatesessionstate("spectator");
	self.forcespectatorclient = self.battlebuddy getentitynumber();
	self forcethirdpersonwhenfollowing();
	waitforbuddyspawntimer();
}

//Function Number: 8
watchforrandomspawnbutton()
{
	self endon("disconnect");
	self endon("abort_battlebuddy_spawn");
	self endon("teamSpawnPressed");
	level endon("game_ended");
	self.kc_randomspawntext settext(&"PLATFORM_PRESS_TO_RESPAWN");
	self.kc_randomspawntext.alpha = 1;
	self notifyonplayercommand("respawn_random","+usereload");
	wait(0.5);
	self waittill("respawn_random");
	setupforrandomspawn();
}

//Function Number: 9
setupforrandomspawn()
{
	clearbuddymessage();
	self.isspawningonbattlebuddy = undefined;
	self notify("randomSpawnPressed");
	cleanupbuddyspawn();
}

//Function Number: 10
waitforbuddyspawntimer()
{
	self endon("randomSpawnPressed");
	level endon("game_ended");
	if(!isdefined(self.kc_teamspawntext))
	{
		initteamspawnelements();
	}

	self.isspawningonbattlebuddy = undefined;
	thread watchforrandomspawnbutton();
	if(isdefined(self.battlebuddyrespawntimestamp))
	{
		var_00 = 4000 - gettime() - self.battlebuddyrespawntimestamp;
		if(var_00 < 2000)
		{
			var_00 = 2000;
		}
	}
	else
	{
		var_00 = 4000;
	}

	var_01 = checkbuddyspawn();
	if(var_01.status == -1 || var_01.status == -3)
	{
		self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_ERR_COMBAT");
	}
	else
	{
		self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_INCOMING");
	}

	updatetimer(&"MP_BUDDY_TIME_UNTIL_SPAWN",var_00);
	for(var_01 = checkbuddyspawn();var_01.status != 0;var_01 = checkbuddyspawn())
	{
		if(var_01.status == -1 || var_01.status == -3)
		{
			displaybuddystatusmessage(&"MP_BUDDY_WAITING_COMBAT");
			self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_ERR_COMBAT");
		}
		else if(var_01.status == -2)
		{
			displaybuddystatusmessage(&"MP_BUDDY_WAITING_POINT");
			self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_ERR_POINT");
		}

		wait(0.5);
	}

	self.isspawningonbattlebuddy = 1;
	thread displaybuddyspawnsuccessful();
	self playlocalsound("copycat_steal_class");
	self notify("teamSpawnPressed");
}

//Function Number: 11
clearbuddymessage()
{
	self.kc_randomspawntext.alpha = 0;
	self.kc_teamspawntext.alpha = 0;
	maps\mp\_utility::clearlowermessage("kc_info");
	maps\mp\_utility::clearlowermessage("waiting_info");
	if(isdefined(self.battlebuddy))
	{
		self.battlebuddy maps\mp\_utility::clearlowermessage("waiting_info");
	}
}

//Function Number: 12
displaybuddystatusmessage(param_00)
{
	maps\mp\_utility::setlowermessage("waiting_info",param_00,undefined,undefined,undefined,undefined,undefined,undefined,1);
}

//Function Number: 13
displaybuddyspawnsuccessful()
{
	clearbuddymessage();
	if(isdefined(self.battlebuddy))
	{
		self.battlebuddy displaybuddystatusmessage(&"MP_BUDDY_SPAWNED_ON_YOU");
		wait(1.5);
		self.battlebuddy maps\mp\_utility::clearlowermessage("waiting_info");
	}
}

//Function Number: 14
checkbuddyspawn()
{
	var_00 = spawnstruct();
	if(maps\mp\gametypes\_spawnscoring::isplayerincombat(self.battlebuddy))
	{
		var_00.status = -1;
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnscoring::findspawnlocationnearplayer(self.battlebuddy);
		if(isdefined(var_01))
		{
			var_02 = spawnstruct();
			var_02.maxtracecount = 18;
			var_02.currenttracecount = 0;
			if(!maps\mp\gametypes\_spawnscoring::issafetospawnon(self.battlebuddy,var_01,var_02))
			{
				var_00.status = -3;
			}
			else
			{
				var_00.status = 0;
				var_00.origin = var_01;
				var_00.angles = self.battlebuddy.angles;
			}
		}
		else
		{
			var_00.status = -2;
		}
	}

	return var_00;
}

//Function Number: 15
cleanupbuddyspawn()
{
	thread maps\mp\gametypes\_spectating::setspectatepermissions();
	self.forcespectatorclient = -1;
	maps\mp\_utility::updatesessionstate("dead");
	self disableforcethirdpersonwhenfollowing();
	self.isspawningonbattlebuddy = undefined;
	self notify("abort_battlebuddy_spawn");
}

//Function Number: 16
updatetimer(param_00,param_01)
{
	self endon("disconnect");
	self endon("abort_battlebuddy_spawn");
	self endon("teamSpawnPressed");
	var_02 = param_01 * 0.001;
	maps\mp\_utility::setlowermessage("kc_info",param_00,var_02,1,1);
	wait(var_02);
	maps\mp\_utility::clearlowermessage("kc_info");
}

//Function Number: 17
updateprogressbar(param_00,param_01)
{
	self endon("disconnect");
	self endon("abort_battlebuddy_spawn");
	self endon("teamSpawnPressed");
	var_02 = maps\mp\gametypes\_hud_util::createprimaryprogressbar(0,25);
	var_03 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,25);
	var_03 settext(param_00);
	var_04 = 1 / param_01;
	var_05 = gettime();
	var_06 = 1;
	var_02 maps\mp\gametypes\_hud_util::updatebar(var_06);
	var_02 maps\mp\gametypes\_hud_util::showelem();
	var_03 maps\mp\gametypes\_hud_util::showelem();
	while(!level.gameended && var_06 > 0)
	{
		var_07 = param_01 - gettime() - var_05;
		var_06 = var_07 * var_04;
		var_06 = clamp(var_06,0,1);
		var_02 maps\mp\gametypes\_hud_util::updatebar(var_06);
		wait(0.1);
	}

	var_02 maps\mp\gametypes\_hud_util::destroyelem();
	var_03 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 18
wantsbattlebuddy()
{
	return self getplayerdata("enableBattleBuddy");
}

//Function Number: 19
hasbattlebuddy()
{
	return isdefined(self.battlebuddy);
}

//Function Number: 20
needsbattlebuddy()
{
	return wantsbattlebuddy() && !hasbattlebuddy();
}

//Function Number: 21
isvalidbattlebuddy(param_00)
{
	return param_00 needsbattlebuddy() && self.team == param_00.team;
}

//Function Number: 22
pairbattlebuddy(param_00)
{
	if(self.team == param_00.team)
	{
		removefrombattlebuddywaitlist(param_00);
		self.battlebuddy = param_00;
		param_00.battlebuddy = self;
		self setclientdvar("ui_battle_buddy_entity_num",param_00 getentitynumber());
		param_00 setclientdvar("ui_battle_buddy_entity_num",self getentitynumber());
	}
}

//Function Number: 23
getwaitingbattlebuddy()
{
	return level.battlebuddywaitlist[self.team];
}

//Function Number: 24
addtobattlebuddywaitlist(param_00)
{
	level.battlebuddywaitlist[param_00.team] = param_00;
}

//Function Number: 25
removefrombattlebuddywaitlist(param_00)
{
	if(isdefined(level.battlebuddywaitlist[param_00.team]) && param_00 == level.battlebuddywaitlist[param_00.team])
	{
		level.battlebuddywaitlist[param_00.team] = undefined;
	}
}

//Function Number: 26
findbattlebuddy()
{
	if(level.onlinegame)
	{
		self.fireteammembers = self getfireteammembers();
		if(self.fireteammembers.size >= 1)
		{
			foreach(var_01 in self.fireteammembers)
			{
				if(isvalidbattlebuddy(var_01))
				{
					pairbattlebuddy(var_01);
				}
			}
		}
	}

	if(!isdefined(self.battlebuddy))
	{
		var_01 = getwaitingbattlebuddy();
		if(isdefined(var_01))
		{
			pairbattlebuddy(var_01);
			return;
		}

		addtobattlebuddywaitlist(self);
		self setclientdvar("ui_battle_buddy_entity_num",-1);
	}
}

//Function Number: 27
clearbattlebuddy()
{
	var_00 = self.battlebuddy;
	self setclientdvar("ui_battle_buddy_entity_num",-1);
	self.battlebuddy = undefined;
	var_00 setclientdvar("ui_battle_buddy_entity_num",-1);
	var_00.battlebuddy = undefined;
	self setplayerdata("enableBattleBuddy",0);
	var_00 findbattlebuddy();
}