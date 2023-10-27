/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_killcam.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 22
 * Decompile Time: 316 ms
 * Timestamp: 10/27/2023 2:25:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachestring(&"PLATFORM_PRESS_TO_SKIP");
	precachestring(&"PLATFORM_PRESS_TO_RESPAWN");
	precachestring(&"PLATFORM_PRESS_TO_COPYCAT");
	level.killcam = maps\mp\gametypes\_tweakables::func_270D("game","allowkillcam");
}

//Function Number: 2
killcam(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self endon("disconnect");
	self endon("spawned");
	level endon("game_ended");
	if(param_00 < 0)
	{
		return;
	}

	if(getdvar("scr_killcam_time") == "")
	{
		if(param_03 == "artillery_mp" || param_03 == "stealth_bomb_mp" || param_03 == "remote_mortar_missile_mp")
		{
			var_0A = gettime() - param_02 / 1000 - param_04 - 0.1;
		}
		else if(level.showingfinalkillcam)
		{
			var_0A = 4;
		}
		else if(param_04 == "apache_minigun_mp")
		{
			var_0A = 3;
		}
		else if(param_04 == "javelin_mp" || param_04 == "uav_strike_projectile_mp")
		{
			var_0A = 8;
		}
		else if(issubstr(param_04,"remotemissile_"))
		{
			var_0A = 5;
		}
		else if(!param_07 || param_07 > 5)
		{
			var_0A = 5;
		}
		else if(param_04 == "frag_grenade_mp" || param_04 == "frag_grenade_short_mp" || param_04 == "semtex_mp")
		{
			var_0A = 4.25;
		}
		else
		{
			var_0A = 2.5;
		}
	}
	else
	{
		var_0A = getdvarfloat("scr_killcam_time");
	}

	if(isdefined(param_07))
	{
		if(var_0A > param_07)
		{
			var_0A = param_07;
		}

		if(var_0A < 0.05)
		{
			var_0A = 0.05;
		}
	}

	if(getdvar("scr_killcam_posttime") == "")
	{
		var_0B = 2;
	}
	else
	{
		var_0B = getdvarfloat("scr_killcam_posttime");
		if(var_0B < 0.05)
		{
			var_0B = 0.05;
		}
	}

	var_0C = var_0A + var_0B;
	if(isdefined(param_07) && var_0C > param_07)
	{
		if(param_07 < 2)
		{
			return;
		}

		if(param_07 - var_0A >= 1)
		{
			var_0B = param_07 - var_0A;
		}
		else
		{
			var_0B = 1;
			var_0A = param_07 - 1;
		}

		var_0C = var_0A + var_0B;
	}

	var_0D = var_0A + param_04;
	var_0E = gettime();
	self notify("begin_killcam",var_0E);
	if(isdefined(param_08))
	{
		param_08 visionsyncwithplayer(param_09);
	}

	self.sessionstate = "spectator";
	self.forcespectatorclient = param_00;
	self.killcamentity = -1;
	if(param_01 >= 0)
	{
		thread func_2BA6(param_01,var_0D,param_02);
	}

	self.archivetime = var_0D;
	self.killcamlength = var_0C;
	self.psoffsettime = param_05;
	self allowspectateteam("allies",1);
	self allowspectateteam("axis",1);
	self allowspectateteam("freelook",1);
	self allowspectateteam("none",1);
	if(isdefined(param_08) && level.showingfinalkillcam)
	{
		self openmenu("killedby_card_display");
		self setcarddisplayslot(param_08,7);
	}

	thread func_2BAE();
	wait 0.05;
	if(self.archivetime < var_0D)
	{
	}

	var_0A = self.archivetime - 0.05 - param_04;
	var_0C = var_0A + var_0B;
	self.killcamlength = var_0C;
	if(var_0A <= 0)
	{
		self.sessionstate = "dead";
		self.forcespectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self notify("killcam_ended");
		return;
	}

	if(level.showingfinalkillcam)
	{
		thread func_2BA2(var_0A);
	}

	self.killcam = 1;
	initkcelements();
	if(!level.splitscreen || self issplitscreenplayer())
	{
		self.kc_timer.alpha = 1;
		self.kc_timer settenthstimer(var_0A);
	}

	if(param_06 && !level.gameended)
	{
		maps\mp\_utility::setlowermessage("kc_info",&"PLATFORM_PRESS_TO_SKIP",undefined,undefined,undefined,undefined,undefined,undefined,1);
	}
	else if(!level.gameended)
	{
		maps\mp\_utility::setlowermessage("kc_info",&"PLATFORM_PRESS_TO_RESPAWN",undefined,undefined,undefined,undefined,undefined,undefined,1);
	}

	if(!level.showingfinalkillcam)
	{
		self.kc_skiptext.alpha = 1;
	}
	else
	{
		self.kc_skiptext.alpha = 0;
	}

	self.kc_othertext.alpha = 0;
	self.kc_icon.alpha = 0;
	thread func_2BAD();
	if(self == param_09 && param_09 maps\mp\_utility::func_27AF("specialty_copycat") && isdefined(param_09.pers["copyCatLoadout"]) && !param_08 maps\mp\_utility::isjuggernaut())
	{
		thread func_2BA8(param_08);
	}

	if(!level.showingfinalkillcam)
	{
		thread func_2BA7(param_06);
	}
	else
	{
		self notify("showing_final_killcam");
	}

	thread endkillcamifnothingtoshow();
	func_2BA5();
	if(level.showingfinalkillcam)
	{
		thread maps\mp\gametypes\_playerlogic::spawnendofgame();
		return;
	}

	thread calculatekillcamtime(var_0E);
	thread func_2BAF(1);
}

//Function Number: 3
func_2BA2(param_00)
{
	if(isdefined(level.doingfinalkillcamfx))
	{
		return;
	}

	level.doingfinalkillcamfx = 1;
	var_01 = param_00;
	if(var_01 > 1)
	{
		var_01 = 1;
		wait param_00 - 1;
	}

	setslowmotion(1,0.25,var_01);
	wait var_01 + 0.5;
	setslowmotion(0.25,1,1);
	level.doingfinalkillcamfx = undefined;
}

//Function Number: 4
calculatekillcamtime(param_00)
{
	var_01 = int(gettime() - param_00);
	maps\mp\_utility::incplayerstat("killcamtimewatched",var_01);
}

//Function Number: 5
func_2BA5()
{
	self endon("abort_killcam");
	wait self.killcamlength - 0.05;
}

//Function Number: 6
func_2BA6(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("killcam_ended");
	var_03 = gettime() - param_01 * 1000;
	if(param_02 > var_03)
	{
		wait 0.05;
		param_01 = self.archivetime;
		var_03 = gettime() - param_01 * 1000;
		if(param_02 > var_03)
		{
			wait param_02 - var_03 / 1000;
		}
	}

	self.killcamentity = param_00;
}

//Function Number: 7
func_2BA7(param_00)
{
	self endon("disconnect");
	self endon("killcam_ended");
	while(self usebuttonpressed())
	{
		wait 0.05;
	}

	while(!self usebuttonpressed())
	{
		wait 0.05;
	}

	if(!maps\mp\_utility::matchmakinggame())
	{
		maps\mp\_utility::incplayerstat("killcamskipped",1);
	}

	if(param_00 <= 0)
	{
		maps\mp\_utility::clearlowermessage("kc_info");
	}

	self notify("abort_killcam");
}

//Function Number: 8
func_2BA8(param_00)
{
	self endon("disconnect");
	self endon("killcam_ended");
	waitcopycatbutton(param_00);
	self notify("abort_killcam");
}

//Function Number: 9
func_2BA9(param_00)
{
	self endon("disconnect");
	initkcelements();
	var_01 = waitcopycatbutton(param_00);
	if(!isdefined(var_01))
	{
		self.kc_icon.alpha = 0;
		self.kc_othertext.alpha = 0;
	}
}

//Function Number: 10
waitcopycatbutton(param_00)
{
	self endon("spawned_player");
	self endon("death_delay_finished");
	self.kc_icon setshader("specialty_copycat",48,48);
	self.kc_othertext settext(&"PLATFORM_PRESS_TO_COPYCAT");
	self.kc_othertext.alpha = 1;
	self.kc_icon.alpha = 1;
	self notifyonplayercommand("use_copycat","weapnext");
	self waittill("use_copycat");
	self.pers["copyCatLoadout"]["inUse"] = 1;
	self.pers["copyCatLoadout"]["owner"] = param_00;
	self.kc_othertext fadeovertime(0.5);
	self.kc_othertext.alpha = 0;
	self.kc_icon fadeovertime(0.25);
	self.kc_icon scaleovertime(0.25,512,512);
	self.kc_icon.alpha = 0;
	if(isdefined(param_00))
	{
		param_00 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("copied",self);
	}

	self playlocalsound("copycat_steal_class");
	return 1;
}

//Function Number: 11
func_2BAB()
{
	self endon("disconnect");
	self endon("killcam_ended");
	if(!maps\mp\gametypes\_playerlogic::mayspawn())
	{
		return;
	}

	while(self fragbuttonpressed())
	{
		wait 0.05;
	}

	while(!self fragbuttonpressed())
	{
		wait 0.05;
	}

	self.wantsafespawn = 1;
	self notify("abort_killcam");
}

//Function Number: 12
endkillcamifnothingtoshow()
{
	self endon("disconnect");
	self endon("killcam_ended");
	for(;;)
	{
		if(self.archivetime <= 0)
		{
			break;
		}

		wait 0.05;
	}

	self notify("abort_killcam");
}

//Function Number: 13
func_2BAD()
{
	self endon("disconnect");
	self endon("killcam_ended");
	self waittill("spawned");
	thread func_2BAF(0);
}

//Function Number: 14
func_2BAE()
{
	self endon("disconnect");
	self endon("killcam_ended");
	level waittill("game_ended");
	thread func_2BAF(1);
}

//Function Number: 15
func_2BAF(param_00)
{
	if(isdefined(self.kc_skiptext))
	{
		self.kc_skiptext.alpha = 0;
	}

	if(isdefined(self.kc_timer))
	{
		self.kc_timer.alpha = 0;
	}

	if(isdefined(self.kc_icon))
	{
		self.kc_icon.alpha = 0;
	}

	if(isdefined(self.kc_othertext))
	{
		self.kc_othertext.alpha = 0;
	}

	self.killcam = undefined;
	if(!level.gameended)
	{
		maps\mp\_utility::clearlowermessage("kc_info");
	}

	thread maps\mp\gametypes\_spectating::setspectatepermissions();
	self notify("killcam_ended");
	if(!param_00)
	{
		return;
	}

	self.sessionstate = "dead";
	maps\mp\_utility::func_2B28();
}

//Function Number: 16
cancelkillcamonuse()
{
	self.cancelkillcam = 0;
	thread func_2BB5(::func_2BB1,::func_2BB3);
}

//Function Number: 17
func_2BB1()
{
	return self usebuttonpressed();
}

//Function Number: 18
cancelkillcamsafespawnbutton()
{
	return self fragbuttonpressed();
}

//Function Number: 19
func_2BB3()
{
	self.cancelkillcam = 1;
}

//Function Number: 20
func_2BB4()
{
	self.cancelkillcam = 1;
	self.wantsafespawn = 1;
}

//Function Number: 21
func_2BB5(param_00,param_01)
{
	self endon("death_delay_finished");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(!self [[ param_00 ]]())
		{
			wait 0.05;
			continue;
		}

		var_02 = 0;
		while(self [[ param_00 ]]())
		{
			var_02 = var_02 + 0.05;
			wait 0.05;
		}

		if(var_02 >= 0.5)
		{
			continue;
		}

		var_02 = 0;
		while(!self [[ param_00 ]]() && var_02 < 0.5)
		{
			var_02 = var_02 + 0.05;
			wait 0.05;
		}

		if(var_02 >= 0.5)
		{
			continue;
		}

		self [[ param_01 ]]();
	}
}

//Function Number: 22
initkcelements()
{
	if(!isdefined(self.kc_skiptext))
	{
		self.kc_skiptext = newclienthudelem(self);
		self.kc_skiptext.archived = 0;
		self.kc_skiptext.x = 0;
		self.kc_skiptext.alignx = "center";
		self.kc_skiptext.aligny = "top";
		self.kc_skiptext.horzalign = "center_adjustable";
		self.kc_skiptext.vertalign = "top_adjustable";
		self.kc_skiptext.sort = 1;
		self.kc_skiptext.font = "default";
		self.kc_skiptext.foreground = 1;
		self.kc_skiptext.hidewheninmenu = 1;
		if(level.splitscreen || self issplitscreenplayer())
		{
			self.kc_skiptext.y = 20;
			self.kc_skiptext.fontscale = 1.2;
		}
		else
		{
			self.kc_skiptext.y = 32;
			self.kc_skiptext.fontscale = 1.8;
		}
	}

	if(!isdefined(self.kc_othertext))
	{
		self.kc_othertext = newclienthudelem(self);
		self.kc_othertext.archived = 0;
		self.kc_othertext.y = 18;
		self.kc_othertext.alignx = "left";
		self.kc_othertext.aligny = "top";
		self.kc_othertext.horzalign = "center";
		self.kc_othertext.vertalign = "middle";
		self.kc_othertext.sort = 10;
		self.kc_othertext.font = "small";
		self.kc_othertext.foreground = 1;
		self.kc_othertext.hidewheninmenu = 1;
		if(level.splitscreen)
		{
			self.kc_othertext.x = 16;
			self.kc_othertext.fontscale = 1.2;
		}
		else
		{
			self.kc_othertext.x = 62;
			self.kc_othertext.fontscale = 1.6;
		}
	}

	if(!isdefined(self.kc_icon))
	{
		self.kc_icon = newclienthudelem(self);
		self.kc_icon.archived = 0;
		self.kc_icon.x = 16;
		self.kc_icon.y = 16;
		self.kc_icon.alignx = "left";
		self.kc_icon.aligny = "top";
		self.kc_icon.horzalign = "center";
		self.kc_icon.vertalign = "middle";
		self.kc_icon.sort = 1;
		self.kc_icon.foreground = 1;
		self.kc_icon.hidewheninmenu = 1;
	}

	if(!level.splitscreen || self issplitscreenplayer())
	{
		if(!isdefined(self.kc_timer))
		{
			self.kc_timer = maps\mp\gametypes\_hud_util::createfontstring("hudbig",1);
			self.kc_timer.archived = 0;
			self.kc_timer.x = 0;
			self.kc_timer.alignx = "center";
			self.kc_timer.aligny = "middle";
			self.kc_timer.horzalign = "center_safearea";
			self.kc_timer.vertalign = "top_adjustable";
			self.kc_timer.y = 42;
			self.kc_timer.sort = 1;
			self.kc_timer.font = "hudbig";
			self.kc_timer.foreground = 1;
			self.kc_timer.color = (0.85,0.85,0.85);
			self.kc_timer.hidewheninmenu = 1;
		}
	}
}