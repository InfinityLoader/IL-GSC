/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_battlebuddy.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 1380 ms
 * Timestamp: 10/27/2023 12:14:31 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(level.teambased && !isdefined(level.var_C024))
	{
		if(!isdefined(level.var_28CE))
		{
			level.var_28CE = [];
		}

		level thread func_C57B();
		level thread func_C56E();
	}
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C4C9();
		var_00 thread func_C4F5();
	}
}

//Function Number: 3
func_C57B()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(!isai(var_00))
		{
			if(isdefined(var_00.var_9F69))
			{
				var_00.var_9F69 = undefined;
				if(isdefined(var_00.var_28CC) && isalive(var_00.var_28CC))
				{
					if(var_00.var_28CC getstance() != "stand")
					{
						var_00 setstance("crouch");
					}
				}
			}

			if(var_00 func_138DE())
			{
				if(!var_00 func_8BD4())
				{
					var_00.var_6DED = 0;
					var_00 func_6CAE();
				}

				continue;
			}

			var_00 func_AB2B();
		}
	}
}

//Function Number: 4
func_C4C9()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "battlebuddy_update")
		{
			var_02 = !func_138DE();
			self setplayerdata("common","enableBattleBuddy",var_02);
			if(var_02)
			{
				func_6CAE();
			}
			else
			{
				func_AB2B();
			}

			continue;
		}

		if(var_00 == "team_select" && self.var_8C2A)
		{
			var_03 = func_138DE();
			func_AB2B();
			self setplayerdata("common","enableBattleBuddy",var_03);
		}
	}
}

//Function Number: 5
func_C4F5()
{
	self waittill("disconnect");
	func_AB2C();
}

//Function Number: 6
func_136D6()
{
	scripts\mp\_utility::func_12F19("spectator");
	self.var_140 = self.var_28CC getentitynumber();
	self method_80F2();
	self setclientomnvar("cam_scene_name","over_shoulder");
	self setclientomnvar("cam_scene_lead",self.var_28CC getentitynumber());
	func_136AE();
}

//Function Number: 7
func_13A5F()
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
	func_FAAF();
}

//Function Number: 8
func_FAAF()
{
	func_419E();
	self.var_9F69 = undefined;
	self notify("randomSpawnPressed");
	func_40E7();
}

//Function Number: 9
func_136AE()
{
	self endon("randomSpawnPressed");
	level endon("game_ended");
	self.var_9F69 = undefined;
	thread func_13A5F();
	if(isdefined(self.var_28CD))
	{
		var_00 = 4000 - gettime() - self.var_28CD;
		if(var_00 < 2000)
		{
			var_00 = 2000;
		}
	}
	else
	{
		var_00 = 4000;
	}

	var_01 = func_3DF5();
	if(var_01.var_10E5B == 0)
	{
		self.var_28CC setclientomnvar("ui_battlebuddy_status","incoming");
	}
	else if(var_01.var_10E5B == -1 || var_01.var_10E5B == -3)
	{
		self.var_28CC setclientomnvar("ui_battlebuddy_status","err_combat");
	}
	else
	{
		self.var_28CC setclientomnvar("ui_battlebuddy_status","err_pos");
	}

	func_12F43(var_00);
	for(var_01 = func_3DF5();var_01.var_10E5B != 0;var_01 = func_3DF5())
	{
		if(var_01.var_10E5B == -1 || var_01.var_10E5B == -3)
		{
			self setclientomnvar("ui_battlebuddy_status","wait_combat");
			self.var_28CC setclientomnvar("ui_battlebuddy_status","err_combat");
		}
		else if(var_01.var_10E5B == -2)
		{
			self setclientomnvar("ui_battlebuddy_status","wait_pos");
			self.var_28CC setclientomnvar("ui_battlebuddy_status","err_pos");
		}
		else if(var_01.var_10E5B == -4)
		{
			func_40E7();
			return;
		}

		wait(0.5);
	}

	self.var_9F69 = 1;
	thread func_56D5();
	self playlocalsound("copycat_steal_class");
	self notify("teamSpawnPressed");
}

//Function Number: 10
func_419E()
{
	self setclientomnvar("ui_battlebuddy_status","none");
	self setclientomnvar("ui_battlebuddy_showButtonPrompt",0);
	if(isdefined(self.var_28CC))
	{
		self.var_28CC setclientomnvar("ui_battlebuddy_status","none");
	}
}

//Function Number: 11
func_56D6(param_00)
{
	scripts\mp\_utility::setlowermessage("waiting_info",param_00,undefined,undefined,undefined,undefined,undefined,undefined,1);
}

//Function Number: 12
func_56D5()
{
	func_419E();
	if(isdefined(self.var_28CC))
	{
		self.var_28CC setclientomnvar("ui_battlebuddy_status","on_you");
		wait(1.5);
		self.var_28CC setclientomnvar("ui_battlebuddy_status","none");
	}
}

//Function Number: 13
func_3DF5()
{
	var_00 = spawnstruct();
	if(!isdefined(self.var_28CC) || !isalive(self.var_28CC))
	{
		var_00.var_10E5B = -4;
		return var_00;
	}

	return var_00;
}

//Function Number: 14
func_40E7()
{
	thread scripts\mp\_spectating::func_F857();
	self.var_140 = -1;
	scripts\mp\_utility::func_12F19("dead");
	self method_809E();
	self setclientomnvar("cam_scene_name","unknown");
	func_419E();
	self notify("abort_battlebuddy_spawn");
}

//Function Number: 15
func_12F43(param_00)
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
func_138DE()
{
	return self getplayerdata("common","enableBattleBuddy");
}

//Function Number: 17
func_8BD4()
{
	return isdefined(self.var_28CC);
}

//Function Number: 18
func_BE8E()
{
	return func_138DE() && !func_8BD4();
}

//Function Number: 19
func_9FD1(param_00)
{
	return self != param_00 && self.team == param_00.team && param_00 func_BE8E();
}

//Function Number: 20
func_3876()
{
	return func_8BD4() && scripts\mp\_utility::func_9F19(self.var_28CC);
}

//Function Number: 21
func_C88C(param_00)
{
	func_E103(param_00);
	self.var_28CC = param_00;
	param_00.var_28CC = self;
	self setclientomnvar("ui_battlebuddy_idx",param_00 getentitynumber());
	param_00 setclientomnvar("ui_battlebuddy_idx",self getentitynumber());
}

//Function Number: 22
func_8209()
{
	return level.var_28CE[self.team];
}

//Function Number: 23
func_1848(param_00)
{
	if(!isdefined(level.var_28CE[param_00.team]))
	{
		level.var_28CE[param_00.team] = param_00;
		return;
	}

	if(level.var_28CE[param_00.team] != param_00)
	{
	}
}

//Function Number: 24
func_E103(param_00)
{
	if(isdefined(param_00.team) && isdefined(level.var_28CE[param_00.team]) && param_00 == level.var_28CE[param_00.team])
	{
		level.var_28CE[param_00.team] = undefined;
	}
}

//Function Number: 25
func_6CAE()
{
	if(level.onlinegame)
	{
		self.var_6D95 = self method_8125();
		if(self.var_6D95.size >= 1)
		{
			foreach(var_01 in self.var_6D95)
			{
				if(func_9FD1(var_01))
				{
					func_C88C(var_01);
				}
			}
		}
	}

	if(!func_8BD4())
	{
		var_01 = func_8209();
		if(isdefined(var_01) && func_9FD1(var_01))
		{
			func_C88C(var_01);
			return;
		}

		func_1848(self);
		self setclientomnvar("ui_battlebuddy_idx",-1);
	}
}

//Function Number: 26
func_419D()
{
	if(!isalive(self))
	{
		func_FAAF();
	}

	self setclientomnvar("ui_battlebuddy_idx",-1);
	self.var_28CC = undefined;
}

//Function Number: 27
func_AB2B()
{
	if(func_8BD4())
	{
		var_00 = self.var_28CC;
		func_419D();
		self setplayerdata("common","enableBattleBuddy",0);
		var_00 func_419D();
		var_00 func_6CAE();
		return;
	}

	func_E103(self);
	self setclientomnvar("ui_battlebuddy_idx",-1);
}

//Function Number: 28
func_AB2C()
{
	if(func_8BD4())
	{
		var_00 = self.var_28CC;
		var_00 func_419D();
		var_00 func_6CAE();
		var_00 func_419E();
		return;
	}

	foreach(var_03, var_02 in level.var_28CE)
	{
		if(var_02 == self)
		{
			level.var_28CE[var_03] = undefined;
			break;
		}
	}
}