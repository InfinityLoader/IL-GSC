/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_battlebuddy.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 28
 * Decompile Time: 449 ms
 * Timestamp: 10/27/2023 1:30:28 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	if(level.teambased && !isdefined(level.nobuddyspawns))
	{
		if(!isdefined(level.battlebuddywaitlist))
		{
			level.battlebuddywaitlist = [];
		}

		level thread onplayerspawned();
		level thread func_595D();
	}
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_58F9();
		var_00 thread func_5918();
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
			if(isdefined(var_00.isspawningonbattlebuddy))
			{
				var_00.isspawningonbattlebuddy = undefined;
				if(isdefined(var_00.battlebuddy) && isalive(var_00.battlebuddy))
				{
					if(var_00.battlebuddy getstance() != "stand")
					{
						var_00 setstance("crouch");
					}
				}
			}

			if(var_00 func_8C02())
			{
				if(!var_00 func_3FFF())
				{
					var_00.var_336E = 0;
					var_00 findbattlebuddy();
				}

				continue;
			}

			var_00 leavebattlebuddysystem();
		}
	}
}

//Function Number: 4
func_58F9()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "battlebuddy_update")
		{
			var_02 = !func_8C02();
			self setcommonplayerdata("enableBattleBuddy",var_02);
			if(var_02)
			{
				findbattlebuddy();
			}
			else
			{
				leavebattlebuddysystem();
			}

			continue;
		}

		if(var_00 == "team_select" && self.hasspawned)
		{
			var_03 = func_8C02();
			leavebattlebuddysystem();
			self setcommonplayerdata("enableBattleBuddy",var_03);
		}
	}
}

//Function Number: 5
func_5918()
{
	self waittill("disconnect");
	leavebattlebuddysystemdisconnect();
}

//Function Number: 6
func_8AED()
{
	maps\mp\_utility::func_8730("spectator");
	self.forcespectatorclient = self.battlebuddy getentitynumber();
	self forcethirdpersonwhenfollowing();
	self setclientomnvar("cam_scene_name","over_shoulder");
	self setclientomnvar("cam_scene_lead",self.battlebuddy getentitynumber());
	func_8ADA();
}

//Function Number: 7
func_8CED()
{
	self endon("disconnect");
	self endon("abort_battlebuddy_spawn");
	self endon("teamSpawnPressed");
	level endon("game_ended");
	self setclientomnvar("ui_battlebuddy_showButtonPrompt",1);
	self notifyonplayercommand("respawn_random","+usereload");
	self notifyonplayercommand("respawn_random","+activate");
	wait(0.5);
	self waittill("respawn_random");
	self setclientomnvar("ui_battlebuddy_timer_ms",0);
	self setclientomnvar("ui_battlebuddy_showButtonPrompt",0);
	setupforrandomspawn();
}

//Function Number: 8
setupforrandomspawn()
{
	clearbuddymessage();
	self.isspawningonbattlebuddy = undefined;
	self notify("randomSpawnPressed");
	func_1CEA();
}

//Function Number: 9
func_8ADA()
{
	self endon("randomSpawnPressed");
	level endon("game_ended");
	self.isspawningonbattlebuddy = undefined;
	thread func_8CED();
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

	var_01 = func_1B96();
	if(var_01.var_7B2A == 0)
	{
		self.battlebuddy setclientomnvar("ui_battlebuddy_status","incoming");
	}
	else if(var_01.var_7B2A == -1 || var_01.var_7B2A == -3)
	{
		self.battlebuddy setclientomnvar("ui_battlebuddy_status","err_combat");
	}
	else
	{
		self.battlebuddy setclientomnvar("ui_battlebuddy_status","err_pos");
	}

	func_8747(var_00);
	for(var_01 = func_1B96();var_01.var_7B2A != 0;var_01 = func_1B96())
	{
		if(var_01.var_7B2A == -1 || var_01.var_7B2A == -3)
		{
			self setclientomnvar("ui_battlebuddy_status","wait_combat");
			self.battlebuddy setclientomnvar("ui_battlebuddy_status","err_combat");
		}
		else if(var_01.var_7B2A == -2)
		{
			self setclientomnvar("ui_battlebuddy_status","wait_pos");
			self.battlebuddy setclientomnvar("ui_battlebuddy_status","err_pos");
		}
		else if(var_01.var_7B2A == -4)
		{
			func_1CEA();
		}

		wait(0.5);
	}

	self.isspawningonbattlebuddy = 1;
	thread func_27EC();
	self playlocalsound("copycat_steal_class");
	self notify("teamSpawnPressed");
}

//Function Number: 10
clearbuddymessage()
{
	self setclientomnvar("ui_battlebuddy_status","none");
	self setclientomnvar("ui_battlebuddy_showButtonPrompt",0);
	if(isdefined(self.battlebuddy))
	{
		self.battlebuddy setclientomnvar("ui_battlebuddy_status","none");
	}
}

//Function Number: 11
displaybuddystatusmessage(param_00)
{
	maps\mp\_utility::setlowermessage("waiting_info",param_00,undefined,undefined,undefined,undefined,undefined,undefined,1);
}

//Function Number: 12
func_27EC()
{
	clearbuddymessage();
	if(isdefined(self.battlebuddy))
	{
		self.battlebuddy setclientomnvar("ui_battlebuddy_status","on_you");
		wait(1.5);
		self.battlebuddy setclientomnvar("ui_battlebuddy_status","none");
	}
}

//Function Number: 13
func_1B96()
{
	var_00 = addstruct();
	if(!isdefined(self.battlebuddy) || !isalive(self.battlebuddy))
	{
		var_00.var_7B2A = -4;
		return var_00;
	}

	if(maps\mp\gametypes\_spawnscoring::func_4933(self.battlebuddy,1))
	{
		var_00.var_7B2A = -1;
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnscoring::findspawnlocationnearplayer(self.battlebuddy);
		if(isdefined(var_01))
		{
			var_02 = addstruct();
			var_02.maxtracecount = 18;
			var_02.currenttracecount = 0;
			if(!maps\mp\gametypes\_spawnscoring::func_4952(self.battlebuddy,var_01,var_02))
			{
				var_00.var_7B2A = -3;
			}
			else
			{
				var_00.var_7B2A = 0;
				var_00.origin = var_01;
				var_03 = self.battlebuddy.origin - var_01;
				var_00.angles = (0,self.battlebuddy.angles[1],0);
			}
		}
		else
		{
			var_00.var_7B2A = -2;
		}
	}

	return var_00;
}

//Function Number: 14
func_1CEA()
{
	thread maps\mp\gametypes\_spectating::func_70D0();
	self.forcespectatorclient = -1;
	maps\mp\_utility::func_8730("dead");
	self disableforcethirdpersonwhenfollowing();
	self setclientomnvar("cam_scene_name","unknown");
	clearbuddymessage();
	self notify("abort_battlebuddy_spawn");
}

//Function Number: 15
func_8747(param_00)
{
	self endon("disconnect");
	self endon("abort_battlebuddy_spawn");
	self endon("teamSpawnPressed");
	var_01 = param_00 * 0.001;
	self setclientomnvar("ui_battlebuddy_timer_ms",param_00 + gettime());
	wait(var_01);
	self setclientomnvar("ui_battlebuddy_timer_ms",0);
}

//Function Number: 16
func_8C02()
{
	return self getcommonplayerdata("enableBattleBuddy");
}

//Function Number: 17
func_3FFF()
{
	return isdefined(self.battlebuddy);
}

//Function Number: 18
func_5590()
{
	return func_8C02() && !func_3FFF();
}

//Function Number: 19
func_499A(param_00)
{
	return self != param_00 && self.team == param_00.team && param_00 func_5590();
}

//Function Number: 20
func_199B()
{
	return func_3FFF() && maps\mp\_utility::func_4945(self.battlebuddy);
}

//Function Number: 21
pairbattlebuddy(param_00)
{
	removefrombattlebuddywaitlist(param_00);
	self.battlebuddy = param_00;
	param_00.battlebuddy = self;
	self setclientomnvar("ui_battlebuddy_idx",param_00 getentitynumber());
	param_00 setclientomnvar("ui_battlebuddy_idx",self getentitynumber());
}

//Function Number: 22
func_3C6C()
{
	return level.battlebuddywaitlist[self.team];
}

//Function Number: 23
addtobattlebuddywaitlist(param_00)
{
	if(!isdefined(level.battlebuddywaitlist[param_00.team]))
	{
		level.battlebuddywaitlist[param_00.team] = param_00;
	}

	if(level.battlebuddywaitlist[param_00.team] != param_00)
	{
	}
}

//Function Number: 24
removefrombattlebuddywaitlist(param_00)
{
	if(isdefined(param_00.team) && isdefined(level.battlebuddywaitlist[param_00.team]) && param_00 == level.battlebuddywaitlist[param_00.team])
	{
		level.battlebuddywaitlist[param_00.team] = undefined;
	}
}

//Function Number: 25
findbattlebuddy()
{
	if(level.onlinegame)
	{
		self.fireteammembers = self getfireteammembers();
		if(self.fireteammembers.size >= 1)
		{
			foreach(var_01 in self.fireteammembers)
			{
				if(func_499A(var_01))
				{
					pairbattlebuddy(var_01);
				}
			}
		}
	}

	if(!func_3FFF())
	{
		var_01 = func_3C6C();
		if(isdefined(var_01) && func_499A(var_01))
		{
			pairbattlebuddy(var_01);
		}

		addtobattlebuddywaitlist(self);
		self setclientomnvar("ui_battlebuddy_idx",-1);
	}
}

//Function Number: 26
func_1D35()
{
	if(!isalive(self))
	{
		setupforrandomspawn();
	}

	self setclientomnvar("ui_battlebuddy_idx",-1);
	self.battlebuddy = undefined;
}

//Function Number: 27
leavebattlebuddysystem()
{
	if(func_3FFF())
	{
		var_00 = self.battlebuddy;
		func_1D35();
		self setcommonplayerdata("enableBattleBuddy",0);
		var_00 func_1D35();
		var_00 findbattlebuddy();
	}

	removefrombattlebuddywaitlist(self);
	self setclientomnvar("ui_battlebuddy_idx",-1);
}

//Function Number: 28
leavebattlebuddysystemdisconnect()
{
	if(func_3FFF())
	{
		var_00 = self.battlebuddy;
		var_00 func_1D35();
		var_00 findbattlebuddy();
		var_00 clearbuddymessage();
	}

	foreach(var_03, var_02 in level.battlebuddywaitlist)
	{
		if(var_02 == self)
		{
			level.battlebuddywaitlist[var_03] = undefined;
			break;
		}
	}
}