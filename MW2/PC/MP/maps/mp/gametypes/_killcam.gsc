/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_killcam.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	precachestring(&"PLATFORM_PRESS_TO_SKIP");
	precachestring(&"PLATFORM_PRESS_TO_RESPAWN");
	precachestring(&"PLATFORM_PRESS_TO_COPYCAT");
	precacheshader("specialty_copycat");
	level.killcam = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "allowkillcam");
}

killcam(attackernum, killcamentityindex, killcamentitystarttime, sweapon, param_A5E, param_A5F, timeuntilrespawn, maxtime, attacker, victim)
{
	self endon("disconnect");
	self endon("spawned");
	level endon("game_ended");
	if(attackernum < 0)
	{
		return;
	}

	if(getdvar("scr_killcam_time") == "")
	{
		if(sweapon == "artillery_mp" || sweapon == "stealth_bomb_mp")
		{
			camtime = gettime() - killcamentitystarttime / 1000 - param_A5E - 0.1;
		}
		else if(level.showingfinalkillcam)
		{
			camtime = 4;
		}
		else if(sweapon == "javelin_mp")
		{
			camtime = 8;
		}
		else if(issubstr(sweapon, "remotemissile_"))
		{
			camtime = 5;
		}
		else if(!timeuntilrespawn || timeuntilrespawn > 5)
		{
			camtime = 5;
		}
		else if(sweapon == "frag_grenade_mp" || sweapon == "frag_grenade_short_mp" || sweapon == "semtex_mp")
		{
			camtime = 4.25;
		}
		else
		{
			camtime = 2.5;
		}
	}
	else
	{
		camtime = getdvarfloat("scr_killcam_time");
	}

	if(isdefined(maxtime))
	{
		if(camtime > maxtime)
		{
			camtime = maxtime;
		}

		if(camtime < 0.05)
		{
			camtime = 0.05;
		}
	}

	if(getdvar("scr_killcam_posttime") == "")
	{
		postdelay = 2;
	}
	else
	{
		postdelay = getdvarfloat("scr_killcam_posttime");
		if(postdelay < 0.05)
		{
			postdelay = 0.05;
		}
	}

	killcamlength = camtime + postdelay;
	if(isdefined(maxtime) && killcamlength > maxtime)
	{
		if(maxtime < 2)
		{
			return;
		}

		if(maxtime - camtime >= 1)
		{
			postdelay = maxtime - camtime;
		}
		else
		{
			postdelay = 1;
			camtime = maxtime - 1;
		}

		killcamlength = camtime + postdelay;
	}

	killcamoffset = camtime + param_A5E;
	starttime = gettime();
	self notify("begin_killcam", starttime);
	self.sessionstate = "spectator";
	self.forcespectatorclient = attackernum;
	self.killcamentity = -1;
	if(killcamentityindex >= 0)
	{
		thread setkillcamentity(killcamentityindex, killcamoffset, killcamentitystarttime);
	}

	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = param_A5F;
	self allowspectateteam("allies", 1);
	self allowspectateteam("axis", 1);
	self allowspectateteam("freelook", 1);
	self allowspectateteam("none", 1);
	if(isdefined(attacker) && level.showingfinalkillcam)
	{
		self openmenu("killedby_card_display");
		self setcarddisplayslot(attacker, 7);
	}

	thread endedkillcamcleanup();
	wait 0.05;
	if(self.archivetime < killcamoffset)
	{
	}

	camtime = self.archivetime - 0.05 - param_A5E;
	killcamlength = camtime + postdelay;
	self.killcamlength = killcamlength;
	if(camtime <= 0)
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
		thread dofinalkillcamfx(camtime);
	}

	self.killcam = 1;
	initkcelements();
	if(!level.splitscreen)
	{
		self.kc_timer.alpha = 1;
		self.kc_timer settenthstimer(camtime);
	}

	if(timeuntilrespawn && !level.gameended)
	{
		if(timeuntilrespawn > 0)
		{
			maps\mp\_utility::setlowermessage("kc_info", game["strings"]["waiting_to_spawn"], timeuntilrespawn);
		}
		else
		{
			maps\mp\_utility::setlowermessage("kc_info", &"PLATFORM_PRESS_TO_SKIP");
		}
	}
	else if(!level.gameended)
	{
		maps\mp\_utility::setlowermessage("kc_info", &"PLATFORM_PRESS_TO_RESPAWN");
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
	thread spawnedkillcamcleanup();
	if(self == victim && victim maps\mp\_utility::_hasperk("specialty_copycat") && isdefined(victim.pers["copyCatLoadout"]))
	{
		thread waitkccopycatbutton(attacker);
	}

	if(!level.showingfinalkillcam)
	{
		thread waitskipkillcambutton(timeuntilrespawn);
	}
	else
	{
		self notify("showing_final_killcam");
	}

	thread endkillcamifnothingtoshow();
	waittillkillcamover();
	if(level.showingfinalkillcam)
	{
		thread maps\mp\gametypes\_playerlogic::spawnendofgame();
		return;
	}

	thread calculatekillcamtime(starttime);
	thread killcamcleanup(1);
}

dofinalkillcamfx(camtime)
{
	if(isdefined(level.doingfinalkillcamfx))
	{
		return;
	}

	level.doingfinalkillcamfx = 1;
	intoslowmotime = camtime;
	if(intoslowmotime > 1)
	{
		intoslowmotime = 1;
		wait camtime - 1;
	}

	setslowmotion(1, 0.25, intoslowmotime);
	wait intoslowmotime + 0.5;
	setslowmotion(0.25, 1, 1);
	level.doingfinalkillcamfx = undefined;
}

calculatekillcamtime(starttime)
{
	watchedtime = int(gettime() - starttime);
	maps\mp\_utility::incplayerstat("killcamtimewatched", watchedtime);
}

waittillkillcamover()
{
	self endon("abort_killcam");
	wait self.killcamlength - 0.05;
}

setkillcamentity(killcamentityindex, killcamoffset, starttime)
{
	self endon("disconnect");
	self endon("killcam_ended");
	killcamtime = gettime() - killcamoffset * 1000;
	if(starttime > killcamtime)
	{
		wait 0.05;
		killcamoffset = self.archivetime;
		killcamtime = gettime() - killcamoffset * 1000;
		if(starttime > killcamtime)
		{
			wait starttime - killcamtime / 1000;
		}
	}

	self.killcamentity = killcamentityindex;
}

waitskipkillcambutton(timeuntilrespawn)
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
		maps\mp\_utility::incplayerstat("killcamskipped", 1);
	}

	if(timeuntilrespawn <= 0)
	{
		maps\mp\_utility::clearlowermessage("kc_info");
	}

	self notify("abort_killcam");
}

waitkccopycatbutton(attacker)
{
	self endon("disconnect");
	self endon("killcam_ended");
	waitcopycatbutton(attacker);
	self notify("abort_killcam");
}

waitdeathcopycatbutton(attacker)
{
	self endon("disconnect");
	initkcelements();
	usedcopycat = waitcopycatbutton(attacker);
	if(!isdefined(usedcopycat))
	{
		self.kc_icon.alpha = 0;
		self.kc_othertext.alpha = 0;
		return;
	}
}

waitcopycatbutton(attacker)
{
	self endon("spawned_player");
	self endon("death_delay_finished");
	self.kc_icon setshader("specialty_copycat", 48, 48);
	self.kc_othertext settext(&"PLATFORM_PRESS_TO_COPYCAT");
	self.kc_othertext.alpha = 1;
	self.kc_icon.alpha = 1;
	self notifyonplayercommand("use_copycat", "weapnext");
	self waittill("use_copycat");
	self.pers["copyCatLoadout"]["inUse"] = 1;
	self.pers["copyCatLoadout"]["owner"] = attacker;
	self.kc_othertext fadeovertime(0.5);
	self.kc_othertext.alpha = 0;
	self.kc_icon fadeovertime(0.25);
	self.kc_icon scaleovertime(0.25, 512, 512);
	self.kc_icon.alpha = 0;
	if(isdefined(attacker))
	{
		attacker thread maps\mp\gametypes\_hud_message::playercardsplashnotify("copied", self);
	}

	self playlocalsound("copycat_steal_class");
	return 1;
}

waitskipkillcamsafespawnbutton()
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

spawnedkillcamcleanup()
{
	self endon("disconnect");
	self endon("killcam_ended");
	self waittill("spawned");
	thread killcamcleanup(0);
}

endedkillcamcleanup()
{
	self endon("disconnect");
	self endon("killcam_ended");
	level waittill("game_ended");
	thread killcamcleanup(1);
}

killcamcleanup(clearstate)
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
	if(!clearstate)
	{
		return;
	}

	self.sessionstate = "dead";
	maps\mp\_utility::clearkillcamstate();
}

cancelkillcamonuse()
{
	self.cancelkillcam = 0;
	thread cancelkillcamonuse_specificbutton(::cancelkillcamusebutton, ::cancelkillcamcallback);
}

cancelkillcamusebutton()
{
	return self usebuttonpressed();
}

cancelkillcamsafespawnbutton()
{
	return self fragbuttonpressed();
}

cancelkillcamcallback()
{
	self.cancelkillcam = 1;
}

cancelkillcamsafespawncallback()
{
	self.cancelkillcam = 1;
	self.wantsafespawn = 1;
}

cancelkillcamonuse_specificbutton(param_A6F, param_A70)
{
	self endon("death_delay_finished");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(!self [[ param_A6F ]]())
		{
			wait 0.05;
			continue;
		}

		buttontime = 0;
		while(self [[ param_A6F ]]())
		{
			buttontime = buttontime + 0.05;
			wait 0.05;
		}

		if(buttontime >= 0.5)
		{
			continue;
		}

		buttontime = 0;
		while(!self [[ param_A6F ]]() && buttontime < 0.5)
		{
			buttontime = buttontime + 0.05;
			wait 0.05;
		}

		if(buttontime >= 0.5)
		{
			continue;
		}

		self [[ param_A70 ]]();
		return;
	}
}

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
		if(level.splitscreen)
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

	if(!level.splitscreen)
	{
		if(!isdefined(self.kc_timer))
		{
			self.kc_timer = maps\mp\gametypes\_hud_util::createfontstring("hudbig", 1);
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
			return;
		}

		return;
	}
}