/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_perkfunctions.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

blastshieldusetracker(perkname, param_373)
{
	self endon("death");
	self endon("disconnect");
	self endon("end_perkUseTracker");
	level endon("game_ended");
	for(;;)
	{
		self waittill("empty_offhand");
		if(!common_scripts\utility::isoffhandweaponenabled())
		{
			continue;
		}

		self [[ param_373 ]](maps\mp\_utility::_hasperk("_specialty_blastshield"));
	}
}

perkusedeathtracker()
{
	self endon("disconnect");
	self waittill("death");
	self._useperkenabled = undefined;
}

setrearview()
{
}

unsetrearview()
{
	self notify("end_perkUseTracker");
}

togglerearview(isenabled)
{
	if(isenabled)
	{
		maps\mp\_utility::_setperk("_specialty_rearview");
		self setrearviewrenderenabled(1);
		return;
	}

	maps\mp\_utility::_unsetperk("_specialty_rearview");
	self setrearviewrenderenabled(0);
}

setendgame()
{
	if(isdefined(self.endgame))
	{
		return;
	}

	self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue("player", "maxhealth") * 4;
	self.health = self.maxhealth;
	self.endgame = 1;
	self.attackertable[0] = "";
	self visionsetnakedforplayer("end_game", 5);
	thread endgamedeath(7);
	self.hasdonecombat = 1;
}

unsetendgame()
{
	self notify("stopEndGame");
	self.endgame = undefined;
	revertvisionset();
	if(!isdefined(self.endgametimer))
	{
		return;
	}

	self.endgametimer maps\mp\gametypes\_hud_util::destroyelem();
	self.endgameicon maps\mp\gametypes\_hud_util::destroyelem();
}

revertvisionset()
{
	self visionsetnakedforplayer(getdvar("mapname"), 1);
}

endgamedeath(duration)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self endon("stopEndGame");
	wait duration + 1;
	maps\mp\_utility::_suicide();
}

setcombathigh()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_combathigh");
	level endon("end_game");
	self.damageblockedtotal = 0;
	if(level.splitscreen)
	{
		yoffset = 56;
		iconsize = 21;
	}
	else
	{
		yoffset = 112;
		iconsize = 32;
	}

	self.combathighoverlay = newclienthudelem(self);
	self.combathighoverlay.x = 0;
	self.combathighoverlay.y = 0;
	self.combathighoverlay.alignx = "left";
	self.combathighoverlay.aligny = "top";
	self.combathighoverlay.horzalign = "fullscreen";
	self.combathighoverlay.vertalign = "fullscreen";
	self.combathighoverlay setshader("combathigh_overlay", 640, 480);
	self.combathighoverlay.sort = -10;
	self.combathighoverlay.archived = 1;
	self.combathightimer = maps\mp\gametypes\_hud_util::createtimer("hudsmall", 1);
	self.combathightimer maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, yoffset);
	self.combathightimer settimer(10);
	self.combathightimer.color = (0.8,0.8,0);
	self.combathightimer.archived = 0;
	self.combathightimer.foreground = 1;
	self.combathighicon = maps\mp\gametypes\_hud_util::createicon("specialty_painkiller", iconsize, iconsize);
	self.combathighicon.alpha = 0;
	self.combathighicon maps\mp\gametypes\_hud_util::setparent(self.combathightimer);
	self.combathighicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM", "TOP");
	self.combathighicon.archived = 1;
	self.combathighicon.sort = 1;
	self.combathighicon.foreground = 1;
	self.combathighoverlay.alpha = 0;
	self.combathighoverlay fadeovertime(1);
	self.combathighicon fadeovertime(1);
	self.combathighoverlay.alpha = 1;
	self.combathighicon.alpha = 0.85;
	thread unsetcombathighondeath();
	wait 8;
	self.combathighicon fadeovertime(2);
	self.combathighicon.alpha = 0;
	self.combathighoverlay fadeovertime(2);
	self.combathighoverlay.alpha = 0;
	self.combathightimer fadeovertime(2);
	self.combathightimer.alpha = 0;
	wait 2;
	self.damageblockedtotal = undefined;
	maps\mp\_utility::_unsetperk("specialty_combathigh");
}

unsetcombathighondeath()
{
	self endon("disconnect");
	self endon("unset_combathigh");
	self waittill("death");
	thread maps\mp\_utility::_unsetperk("specialty_combathigh");
}

unsetcombathigh()
{
	self notify("unset_combathigh");
	self.combathighoverlay destroy();
	self.combathighicon destroy();
	self.combathightimer destroy();
}

setsiege()
{
	thread tracksiegeenable();
	thread tracksiegedissable();
}

tracksiegeenable()
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_trackSiege");
	for(;;)
	{
		self waittill("gambit_on");
		self.movespeedscaler = 0;
		maps\mp\gametypes\_weapons::updatemovespeedscale("primary");
		class = weaponclass(self getcurrentweapon());
		if(class == "pistol" || class == "smg")
		{
			self setspreadoverride(1);
		}
		else
		{
			self setspreadoverride(2);
		}

		self player_recoilscaleon(0);
		self allowjump(0);
	}
}

tracksiegedissable()
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_trackSiege");
	for(;;)
	{
		self waittill("gambit_off");
		unsetsiege();
	}
}

stancestatelistener()
{
	self endon("death");
	self endon("disconnect");
	self notifyonplayercommand("adjustedStance", "+stance");
	for(;;)
	{
		self waittill("adjustedStance");
		if(self.movespeedscaler != 0)
		{
			continue;
		}

		unsetsiege();
	}
}

jumpstatelistener()
{
	self endon("death");
	self endon("disconnect");
	self notifyonplayercommand("jumped", "+goStand");
	for(;;)
	{
		self waittill("jumped");
		if(self.movespeedscaler != 0)
		{
			continue;
		}

		unsetsiege();
	}
}

unsetsiege()
{
	self.movespeedscaler = 1;
	self resetspreadoverride();
	maps\mp\gametypes\_weapons::updatemovespeedscale("primary");
	self player_recoilscaleoff();
	self allowjump(1);
}

setfinalstand()
{
	maps\mp\_utility::_setperk("specialty_pistoldeath");
}

unsetfinalstand()
{
	maps\mp\_utility::_unsetperk("specialty_pistoldeath");
}

setchallenger()
{
	if(!level.hardcoremode)
	{
		self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue("player", "maxhealth");
		if(isdefined(self.xpscaler) && self.xpscaler == 1 && self.maxhealth > 30)
		{
			self.xpscaler = 2;
			return;
		}

		return;
	}
}

unsetchallenger()
{
	self.xpscaler = 1;
}

setsaboteur()
{
	self.objectivescaler = 1.2;
}

unsetsaboteur()
{
	self.objectivescaler = 1;
}

setlightweight()
{
	self.movespeedscaler = 1.1;
	maps\mp\gametypes\_weapons::updatemovespeedscale("primary");
}

unsetlightweight()
{
	self.movespeedscaler = 1;
	maps\mp\gametypes\_weapons::updatemovespeedscale("primary");
}

setblackbox()
{
	self.killstreakscaler = 1.5;
}

unsetblackbox()
{
	self.killstreakscaler = 1;
}

setsteelnerves()
{
	maps\mp\_utility::_setperk("specialty_bulletaccuracy");
	maps\mp\_utility::_setperk("specialty_holdbreath");
}

unsetsteelnerves()
{
	maps\mp\_utility::_unsetperk("specialty_bulletaccuracy");
	maps\mp\_utility::_unsetperk("specialty_holdbreath");
}

setdelaymine()
{
}

unsetdelaymine()
{
}

setbackshield()
{
	self attachshieldmodel("weapon_riot_shield_mp", "tag_shield_back");
}

unsetbackshield()
{
	self detachshieldmodel("weapon_riot_shield_mp", "tag_shield_back");
}

setlocaljammer()
{
	if(!maps\mp\_utility::isemped())
	{
		self radarjamon();
		return;
	}
}

unsetlocaljammer()
{
	self radarjamoff();
}

setac130()
{
	thread killstreakthink("ac130", 7, "end_ac130Think");
}

unsetac130()
{
	self notify("end_ac130Think");
}

setsentryminigun()
{
	thread killstreakthink("airdrop_sentry_minigun", 2, "end_sentry_minigunThink");
}

unsetsentryminigun()
{
	self notify("end_sentry_minigunThink");
}

setcarepackage()
{
	thread killstreakthink("airdrop", 2, "endCarePackageThink");
}

unsetcarepackage()
{
	self notify("endCarePackageThink");
}

settank()
{
	thread killstreakthink("tank", 6, "end_tankThink");
}

unsettank()
{
	self notify("end_tankThink");
}

setprecision_airstrike()
{
	thread killstreakthink("precision_airstrike", 6, "end_precision_airstrike");
}

unsetprecision_airstrike()
{
	self notify("end_precision_airstrike");
}

setpredatormissile()
{
	thread killstreakthink("predator_missile", 4, "end_predator_missileThink");
}

unsetpredatormissile()
{
	self notify("end_predator_missileThink");
}

sethelicopterminigun()
{
	thread killstreakthink("helicopter_minigun", 5, "end_helicopter_minigunThink");
}

unsethelicopterminigun()
{
	self notify("end_helicopter_minigunThink");
}

killstreakthink(streakname, streakval, endonstring)
{
	self endon("death");
	self endon("disconnect");
	self endon(endonstring);
	for(;;)
	{
		self waittill("killed_enemy");
		if(self.pers["cur_kill_streak"] != streakval)
		{
			continue;
		}

		thread maps\mp\killstreaks\_killstreaks::givekillstreak(streakname);
		thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(streakname, streakval);
		return;
	}
}

setthermal()
{
	self thermalvisionon();
}

unsetthermal()
{
	self thermalvisionoff();
}

setonemanarmy()
{
	thread onemanarmyweaponchangetracker();
}

unsetonemanarmy()
{
	self notify("stop_oneManArmyTracker");
}

onemanarmyweaponchangetracker()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("stop_oneManArmyTracker");
	for(;;)
	{
		self waittill("weapon_change", newweapon);
		if(newweapon != "onemanarmy_mp")
		{
			continue;
		}

		thread selectonemanarmyclass();
	}
}

isonemanarmymenu(menu)
{
	if(menu == game["menu_onemanarmy"])
	{
		return 1;
	}

	if(isdefined(game["menu_onemanarmy_defaults_splitscreen"]) && menu == game["menu_onemanarmy_defaults_splitscreen"])
	{
		return 1;
	}

	if(isdefined(game["menu_onemanarmy_custom_splitscreen"]) && menu == game["menu_onemanarmy_custom_splitscreen"])
	{
		return 1;
	}

	return 0;
}

selectonemanarmyclass()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::_disableweaponswitch();
	common_scripts\utility::_disableoffhandweapons();
	common_scripts\utility::_disableusability();
	self openpopupmenu(game["menu_onemanarmy"]);
	thread closeomamenuondeath();
	self waittill("menuresponse", menu, classname);
	common_scripts\utility::_enableweaponswitch();
	common_scripts\utility::_enableoffhandweapons();
	common_scripts\utility::_enableusability();
	if(classname == "back" || !isonemanarmymenu(menu) || maps\mp\_utility::isusingremote())
	{
		if(self getcurrentweapon() == "onemanarmy_mp")
		{
			common_scripts\utility::_disableweaponswitch();
			common_scripts\utility::_disableoffhandweapons();
			common_scripts\utility::_disableusability();
			self switchtoweapon(common_scripts\utility::getlastweapon());
			self waittill("weapon_change");
			common_scripts\utility::_enableweaponswitch();
			common_scripts\utility::_enableoffhandweapons();
			common_scripts\utility::_enableusability();
		}

		return;
	}

	thread giveonemanarmyclass(classname);
}

closeomamenuondeath()
{
	self endon("menuresponse");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	common_scripts\utility::_enableweaponswitch();
	common_scripts\utility::_enableoffhandweapons();
	common_scripts\utility::_enableusability();
	self closepopupmenu();
}

giveonemanarmyclass(classname)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(maps\mp\_utility::_hasperk("specialty_omaquickchange"))
	{
		changeduration = 3;
		self playlocalsound("foly_onemanarmy_bag3_plr");
		self playsoundtoteam("foly_onemanarmy_bag3_npc", "allies", self);
		self playsoundtoteam("foly_onemanarmy_bag3_npc", "axis", self);
	}
	else
	{
		changeduration = 6;
		self playlocalsound("foly_onemanarmy_bag6_plr");
		self playsoundtoteam("foly_onemanarmy_bag6_npc", "allies", self);
		self playsoundtoteam("foly_onemanarmy_bag6_npc", "axis", self);
	}

	thread omausebar(changeduration);
	common_scripts\utility::_disableweapon();
	common_scripts\utility::_disableoffhandweapons();
	common_scripts\utility::_disableusability();
	wait changeduration;
	common_scripts\utility::_enableweapon();
	common_scripts\utility::_enableoffhandweapons();
	common_scripts\utility::_enableusability();
	self.omaclasschanged = 1;
	maps\mp\gametypes\_class::giveloadout(self.pers["team"], classname, 0);
	if(isdefined(self.carryflag))
	{
		self attach(self.carryflag, "J_spine4", 1);
	}

	self notify("changed_kit");
	level notify("changed_kit");
}

omausebar(duration)
{
	self endon("disconnect");
	usebar = maps\mp\gametypes\_hud_util::createprimaryprogressbar(25);
	usebartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(25);
	usebartext settext(&"MPUI_CHANGING_KIT");
	usebar maps\mp\gametypes\_hud_util::updatebar(0, 1 / duration);
	waitedtime = 0;
	while(waitedtime < duration && isalive(self) && !level.gameended)
	{
		wait 0.05;
		waitedtime = waitedtime + 0.05;
	}

	usebar maps\mp\gametypes\_hud_util::destroyelem();
	usebartext maps\mp\gametypes\_hud_util::destroyelem();
}

setblastshield()
{
	thread blastshieldusetracker("specialty_blastshield", ::toggleblastshield);
	self setweaponhudiconoverride("primaryoffhand", "specialty_blastshield");
}

unsetblastshield()
{
	self notify("end_perkUseTracker");
	self setweaponhudiconoverride("primaryoffhand", "none");
}

toggleblastshield(isenabled)
{
	if(!isenabled)
	{
		self visionsetnakedforplayer("black_bw", 0.15);
		wait 0.15;
		maps\mp\_utility::_setperk("_specialty_blastshield");
		self visionsetnakedforplayer(getdvar("mapname"), 0);
		self playsoundtoplayer("item_blast_shield_on", self);
		return;
	}

	self visionsetnakedforplayer("black_bw", 0.15);
	wait 0.15;
	maps\mp\_utility::_unsetperk("_specialty_blastshield");
	self visionsetnakedforplayer(getdvar("mapname"), 0);
	self playsoundtoplayer("item_blast_shield_off", self);
}

setfreefall()
{
}

unsetfreefall()
{
}

settacticalinsertion()
{
	maps\mp\_utility::_giveweapon("flare_mp", 0);
	self givestartammo("flare_mp");
	thread monitortiuse();
}

unsettacticalinsertion()
{
	self notify("end_monitorTIUse");
}

clearprevioustispawnpoint()
{
	common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
	if(isdefined(self.setspawnpoint))
	{
		deleteti(self.setspawnpoint);
		return;
	}
}

updatetispawnposition()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("end_monitorTIUse");
	while(maps\mp\_utility::isreallyalive(self))
	{
		if(isvalidtispawnposition())
		{
			self.tispawnposition = self.origin;
		}

		wait 0.05;
	}
}

isvalidtispawnposition()
{
	if(canspawn(self.origin) && self isonground())
	{
		return 1;
	}

	return 0;
}

monitortiuse()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("end_monitorTIUse");
	thread updatetispawnposition();
	thread clearprevioustispawnpoint();
	for(;;)
	{
		self waittill("grenade_fire", lightstick, weapname);
		if(weapname != "flare_mp")
		{
			continue;
		}

		if(isdefined(self.setspawnpoint))
		{
			deleteti(self.setspawnpoint);
		}

		if(!isdefined(self.tispawnposition))
		{
			continue;
		}

		if(maps\mp\_utility::touchingbadtrigger())
		{
			continue;
		}

		tigroundposition = playerphysicstrace(self.tispawnposition + (0,0,16), self.tispawnposition - (0,0,2048)) + (0,0,1);
		glowstick = spawn("script_model", tigroundposition);
		glowstick.angles = self.angles;
		glowstick.team = self.team;
		glowstick.enemytrigger = spawn("script_origin", tigroundposition);
		glowstick thread glowsticksetupandwaitfordeath(self);
		glowstick.playerspawnpos = self.tispawnposition;
		glowstick thread maps\mp\gametypes\_weapons::createbombsquadmodel("weapon_light_stick_tactical_bombsquad", "tag_fire_fx", level.otherteam[self.team], self);
		self.setspawnpoint = glowstick;
		return;
	}
}

glowsticksetupandwaitfordeath(owner)
{
	self setmodel(level.spawnglowmodel["enemy"]);
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(self.team, (0,0,20));
	}
	else
	{
		maps\mp\_entityheadicons::setplayerheadicon(owner, (0,0,20));
	}

	thread glowstickdamagelistener(owner);
	thread glowstickenemyuselistener(owner);
	thread glowstickuselistener(owner);
	thread glowstickteamupdater(level.otherteam[self.team], level.spawnglow["enemy"], owner);
	dummyglowstick = spawn("script_model", self.origin + (0,0,0));
	dummyglowstick.angles = self.angles;
	dummyglowstick setmodel(level.spawnglowmodel["friendly"]);
	dummyglowstick setcontents(0);
	dummyglowstick thread glowstickteamupdater(self.team, level.spawnglow["friendly"], owner);
	dummyglowstick playloopsound("emt_road_flare_burn");
	self waittill("death");
	dummyglowstick stoploopsound();
	dummyglowstick delete();
}

glowstickteamupdater(showforteam, param_390, owner)
{
	self endon("death");
	wait 0.05;
	angles = self gettagangles("tag_fire_fx");
	fxent = spawnfx(param_390, self gettagorigin("tag_fire_fx"), anglestoforward(angles), anglestoup(angles));
	triggerfx(fxent);
	thread deleteondeath(fxent);
	for(;;)
	{
		self hide();
		fxent hide();
		foreach(player in level.players)
		{
			if(player.team == showforteam && level.teambased)
			{
				self showtoplayer(player);
				fxent showtoplayer(player);
				continue;
			}

			if(!level.teambased && player == owner && param_390 == level.spawnglow["friendly"])
			{
				self showtoplayer(player);
				fxent showtoplayer(player);
				continue;
			}

			if(!level.teambased && player != owner && param_390 == level.spawnglow["enemy"])
			{
				self showtoplayer(player);
				fxent showtoplayer(player);
			}
		}

		level common_scripts\utility::waittill_either("joined_team", "player_spawned");
	}
}

deleteondeath(ent)
{
	self waittill("death");
	if(isdefined(ent))
	{
		ent delete();
		return;
	}
}

glowstickdamagelistener(owner)
{
	self endon("death");
	self setcandamage(1);
	self.health = 5000;
	for(;;)
	{
		self waittill("damage", amount, attacker);
		if(level.teambased && isdefined(owner) && attacker != owner && isdefined(attacker.team) && attacker.team == self.team)
		{
			self.health = self.health + amount;
			continue;
		}

		if(self.health < 4980)
		{
			if(isdefined(owner) && attacker != owner)
			{
				attacker notify("destroyed_insertion", owner);
				attacker notify("destroyed_explosive");
				owner thread maps\mp\_utility::leaderdialogonplayer("ti_destroyed");
			}

			attacker thread deleteti(self);
		}
	}
}

glowstickuselistener(owner)
{
	self endon("death");
	level endon("game_ended");
	owner endon("disconnect");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"MP_PICKUP_TI");
	thread updateenemyuse(owner);
	for(;;)
	{
		self waittill("trigger", player);
		player playsound("chemlight_pu");
		player thread settacticalinsertion();
		player thread deleteti(self);
	}
}

updateenemyuse(owner)
{
	self endon("death");
	for(;;)
	{
		maps\mp\_utility::setselfusable(owner);
		level common_scripts\utility::waittill_either("joined_team", "player_spawned");
	}
}

deleteti(ti)
{
	if(isdefined(ti.enemytrigger))
	{
		ti.enemytrigger delete();
	}

	spot = ti.origin;
	spotangles = ti.angles;
	ti delete();
	dummyglowstick = spawn("script_model", spot);
	dummyglowstick.angles = spotangles;
	dummyglowstick setmodel(level.spawnglowmodel["friendly"]);
	dummyglowstick setcontents(0);
	thread dummyglowstickdelete(dummyglowstick);
}

dummyglowstickdelete(stick)
{
	wait 2.5;
	stick delete();
}

glowstickenemyuselistener(owner)
{
	self endon("death");
	level endon("game_ended");
	owner endon("disconnect");
	self.enemytrigger setcursorhint("HINT_NOICON");
	self.enemytrigger sethintstring(&"MP_DESTROY_TI");
	self.enemytrigger maps\mp\_utility::makeenemyusable(owner);
	for(;;)
	{
		self.enemytrigger waittill("trigger", player);
		player notify("destroyed_insertion", owner);
		player notify("destroyed_explosive");
		if(isdefined(owner) && player != owner)
		{
			owner thread maps\mp\_utility::leaderdialogonplayer("ti_destroyed");
		}

		player thread deleteti(self);
	}
}

setlittlebirdsupport()
{
	thread killstreakthink("littlebird_support", 2, "end_littlebird_support_think");
}

unsetlittlebirdsupport()
{
	self notify("end_littlebird_support_think");
}

setc4death()
{
	if(!maps\mp\_utility::_hasperk("specialty_pistoldeath"))
	{
		maps\mp\_utility::_setperk("specialty_pistoldeath");
		return;
	}
}

unsetc4death()
{
}