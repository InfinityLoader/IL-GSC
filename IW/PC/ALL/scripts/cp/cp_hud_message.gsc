/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_hud_message.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 1324 ms
 * Timestamp: 10/27/2023 12:09:22 AM
*******************************************************************/

//Function Number: 1
init()
{
	level thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_901D();
		var_00 thread func_B0E1();
		var_00 thread func_10A40();
	}
}

//Function Number: 3
func_10134(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	var_03 = spawnstruct();
	if(isdefined(param_02))
	{
		param_00 = param_00 + "_" + param_02;
	}

	func_10151(param_00,param_01);
}

//Function Number: 4
func_10117(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = scripts\cp\_hud_util::func_BD6F(param_00) - 1;
	}

	var_03 = level.var_B684[param_00]["displayParam"];
	if(!isdefined(var_03))
	{
		var_03 = scripts\cp\_hud_util::func_BD70(param_00,var_02);
		if(var_03 == 0)
		{
			var_03 = 1;
		}

		var_04 = level.var_B684[param_00]["paramScale"];
		if(isdefined(var_04))
		{
			var_03 = int(var_03 / var_04);
		}
	}

	thread func_10151(param_00,var_03);
}

//Function Number: 5
func_10151(param_00,param_01,param_02)
{
	if(isdefined(self.var_DDCD) && self.var_DDCD >= 6)
	{
		func_DB99(param_00,param_01,param_02);
		return;
	}

	func_10152(param_00,param_01,param_02);
}

//Function Number: 6
func_10152(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	var_03 = tablelookuprownum(func_814B(),0,param_00);
	if(!isdefined(var_03) || var_03 < 0)
	{
		return;
	}

	if(!isdefined(self.var_BFAE))
	{
		self.var_BFAE = 0;
	}

	if(!isdefined(self.var_10A37))
	{
		self.var_10A37 = 1;
	}

	var_04 = var_03;
	if(self.var_10A37)
	{
		var_04 = var_04 | 2048;
	}

	if(isdefined(param_01))
	{
		self setclientomnvar("ui_player_splash_param_" + self.var_BFAE,param_01);
	}
	else
	{
		self setclientomnvar("ui_player_splash_param_" + self.var_BFAE,-1);
	}

	if(isdefined(param_02))
	{
		self setclientomnvar("ui_player_splash_cardClientId_" + self.var_BFAE,param_02 getentitynumber());
	}
	else
	{
		self setclientomnvar("ui_player_splash_cardClientId_" + self.var_BFAE,-1);
	}

	self setclientomnvar("ui_player_splash_id_" + self.var_BFAE,var_04);
	if(!isdefined(self.var_DDCD))
	{
		self.var_DDCD = 1;
	}
	else
	{
		self.var_DDCD++;
	}

	thread func_4103();
	self.var_BFAE++;
	if(self.var_BFAE >= 6)
	{
		self.var_BFAE = 0;
		self.var_10A37 = !self.var_10A37;
	}
}

//Function Number: 7
func_DB99(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_DE3F = param_00;
	var_03.var_C6BB = param_01;
	var_03.var_D390 = param_02;
	if(!isdefined(self.var_10A3E))
	{
		self.var_10A3E = var_03;
		self.var_10A3F = var_03;
		thread func_89E9();
		return;
	}

	var_04 = self.var_10A3F;
	var_04.var_BFAD = var_03;
	self.var_10A3F = var_03;
}

//Function Number: 8
func_89E9()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	while(isdefined(self.var_10A3E))
	{
		self waittill("splash_list_cleared");
		for(var_00 = 0;var_00 < 6;var_00++)
		{
			var_01 = self.var_10A3E;
			func_10152(var_01.var_DE3F,var_01.var_C6BB,var_01.var_D390);
			self.var_10A3E = var_01.var_BFAD;
			if(!isdefined(self.var_10A3E))
			{
				break;
			}
		}
	}

	self.var_10A3F = undefined;
}

//Function Number: 9
func_B0E1()
{
	self endon("disconnect");
	self.lowermessages = [];
	var_00 = "default";
	if(isdefined(level.var_B0DF))
	{
		var_00 = level.var_B0DF;
	}

	var_01 = level.var_B0E5;
	var_02 = level.var_B0E4;
	var_03 = 1.25;
	if(level.splitscreen || self issplitscreenplayer() && !isai(self))
	{
		var_01 = var_01 - 40;
		var_02 = level.var_B0E4 * 1.3;
		var_03 = var_03 * 1.5;
	}

	self.lowermessage = scripts\cp\_utility::createfontstring(var_00,var_02);
	self.lowermessage settext("");
	self.lowermessage.archived = 0;
	self.lowermessage.sort = 10;
	self.lowermessage.showinkillcam = 0;
	self.lowermessage scripts\cp\_utility::setpoint("CENTER",level.var_B0E6,0,var_01);
	self.lowertimer = scripts\cp\_utility::createfontstring("default",var_03);
	self.lowertimer scripts\cp\_utility::setparent(self.lowermessage);
	self.lowertimer scripts\cp\_utility::setpoint("TOP","BOTTOM",0,0);
	self.lowertimer settext("");
	self.lowertimer.archived = 0;
	self.lowertimer.sort = 10;
	self.lowertimer.showinkillcam = 0;
}

//Function Number: 10
func_9DC6()
{
	return 0;
}

//Function Number: 11
func_814B()
{
	return "cp/zombies/zombie_splashtable.csv";
}

//Function Number: 12
func_4103()
{
	self endon("disconnect");
	self notify("cleanupLocalPlayerSplashList()");
	self endon("cleanupLocalPlayerSplashList()");
	scripts\common\utility::waittill_notify_or_timeout("death",0.5);
	self.var_DDCD = undefined;
	self notify("splash_list_cleared");
}

//Function Number: 13
func_10A40()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 != "splash_shown")
		{
			continue;
		}

		var_02 = tablelookupbyrow(func_814B(),var_01,0);
		var_03 = tablelookupbyrow(func_814B(),var_01,5);
		switch(var_03)
		{
			case "killstreak_splash":
				break;
		}
	}
}

//Function Number: 14
func_C549(param_00)
{
}

//Function Number: 15
func_10122(param_00,param_01)
{
	var_02 = tablelookuprownum("mp/errorMessages.csv",0,param_00);
	if(isdefined(param_01))
	{
		self setclientomnvar("ui_mp_error_message_param",param_01);
	}
	else
	{
		self setclientomnvar("ui_mp_error_message_param",-1);
	}

	self setclientomnvar("ui_mp_error_message_id",var_02);
	if(!isdefined(self.var_66BF))
	{
		self.var_66BF = 0;
	}

	self.var_66BF = !self.var_66BF;
	self setclientomnvar("ui_mp_error_trigger",scripts\common\utility::func_116D7(self.var_66BF,2,1));
}

//Function Number: 16
func_10123(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		func_10122(param_00,param_01);
	}
}

//Function Number: 17
func_1013D(param_00)
{
	var_01 = tablelookuprownum("mp/miscMessages.csv",0,param_00);
	var_02 = tablelookupbyrow("mp/miscMessages.csv",var_01,3);
	if(isdefined(var_02) && var_02 != "")
	{
		self playlocalsound(var_02);
	}

	self setclientomnvar("ui_misc_message_id",var_01);
	if(!isdefined(self.var_B7D7))
	{
		self.var_B7D7 = 0;
	}

	self.var_B7D7 = !self.var_B7D7;
	self setclientomnvar("ui_misc_message_trigger",scripts\common\utility::func_116D7(self.var_B7D7,1,0));
}

//Function Number: 18
func_901D()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("death");
		if(isdefined(self.var_901C))
		{
			self.var_901C scripts\cp\_utility::destroyelem();
		}
	}
}

//Function Number: 19
func_978F()
{
	self setplayerdata("cp","zombiePlayerLoadout","tutorialOff",1);
	self.var_8EB0 = 1;
	thread check_for_more_players();
}

//Function Number: 20
check_for_more_players()
{
	level waittill("multiple_players");
	self.var_8EB0 = 0;
	if(!isdefined(level.tutorial_interaction_1) || !isdefined(level.tutorial_interaction_2))
	{
		return;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(level.tutorial_interaction_1);
	scripts\cp\_interaction::remove_from_current_interaction_list(level.tutorial_interaction_2);
}

//Function Number: 21
tutorial_interaction()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self waittill("luinotifyserver",var_00);
	if(var_00 == "tutorial_off")
	{
		self setplayerdata("cp","zombiePlayerLoadout","tutorialOff",1);
		self.var_8EB0 = 1;
	}

	if(var_00 == "tutorial_on")
	{
		self setplayerdata("cp","zombiePlayerLoadout","tutorialOff",0);
		self.var_8EB0 = 0;
	}
}

//Function Number: 22
func_12AAE(param_00)
{
	if(!scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		return;
	}

	var_01 = level.players[0];
	if(var_01.var_8EB0 == 1)
	{
		return;
	}

	if(!isdefined(level.tutorial_message_table))
	{
		return;
	}

	if(!func_1007B(param_00))
	{
		return;
	}

	if(var_01 func_79FC(param_00))
	{
		return;
	}

	if(param_00 != "null" && !scripts\common\utility::istrue(level.var_12AA3))
	{
		level.var_12AA3 = 1;
		var_02 = int(tablelookup(level.tutorial_message_table,1,param_00,0));
		var_01 setclientomnvar("zm_tutorial_num",var_02);
		var_01 func_F3F9(param_00,1);
		level.var_12AA3 = undefined;
	}
}

//Function Number: 23
func_F3F9(param_00,param_01)
{
	self setplayerdata("cp","tutorial",param_00,"saw_message",param_01);
}

//Function Number: 24
func_F3F8(param_00,param_01)
{
	self setplayerdata("cp","tutorialPerm",param_00,"saw_message",param_01);
}

//Function Number: 25
func_79FC(param_00)
{
	var_01 = self getplayerdata("cp","tutorial",param_00,"saw_message");
	return var_01;
}

//Function Number: 26
func_1363B()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("luinotifyserver",var_00);
	if(var_00 == "tutorial_unpause")
	{
		setslowmotion(1,1,0);
	}
}

//Function Number: 27
func_1007B(param_00)
{
	if(isdefined(level.should_show_tutorial_func))
	{
		return [[ level.should_show_tutorial_func ]](param_00);
	}

	return 1;
}

//Function Number: 28
wait_and_play_tutorial_message(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self notify("clear_message");
	self endon("clear_message");
	wait(param_01);
	func_12AAE(param_00);
}