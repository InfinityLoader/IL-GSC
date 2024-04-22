/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_laststand.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 433 ms
 * Timestamp: 4/22/2024 2:09:40 AM
*******************************************************************/

//Function Number: 1
callback_playerlaststandhorde(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	while(self.isrunningarmorycommand || self.isrunningweapongive)
	{
		wait 0.05;
	}

	if(isdefined(self.iscarrying) && self.iscarrying)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	registerlaststandparameter(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	if(gameshouldend(self))
	{
		self.uselaststandparams = 1;
		maps\mp\_utility::_suicide();
		maps\mp\gametypes\_horde_util::hordeupdatescore(self,0);
		hordeendgame();
		return;
	}

	if(!maydolaststandhorde(self))
	{
		self.uselaststandparams = 0;
		if(level.players.size < 2)
		{
			maps\mp\_utility::_suicide();
			maps\mp\gametypes\_horde_util::hordeupdatescore(self,0);
			hordeendgame();
			return;
		}
		else
		{
			if(isdefined(level.hordedropandresetuplinkball))
			{
				self [[ level.hordedropandresetuplinkball ]]();
			}

			if(isdefined(self.underwater))
			{
				var_09 = self getcurrentprimaryweapon();
				self takeweapon(var_09);
			}

			thread laststandmonitorabandonment();
			startspectatemode(1,1,0);
			return;
		}
	}

	self.inlaststand = 1;
	self.laststand = 1;
	self.ignoreme = 1;
	self.health = 1;
	self allowmelee(0);
	thread leaveremotekillstreaks();
	thread laststandexoabilitymonitor();
	self waittill("last_stand_offhand_secondary_disabled");
	var_0A = self getweaponslistprimaries();
	self.primaryweapons = [];
	foreach(var_0C in var_0A)
	{
		if(!issubstr(var_0C,"combatknife"))
		{
			self.primaryweapons[self.primaryweapons.size] = var_0C;
		}
	}

	self.lastequippedweapon = self getcurrentprimaryweapon();
	if(self.lastequippedweapon == "iw5_carrydrone_mp" || self.lastequippedweapon == "search_dstry_bomb_defuse_mp" || issubstr(self.lastequippedweapon,"killstreak") || issubstr(self.lastequippedweapon,"turrethead") && !isdefined(self.pers["rippableSentry"]))
	{
		self.lastequippedweapon = self.primaryweapons[0];
	}

	foreach(var_0C in self.primaryweapons)
	{
		self.primaryweaponsammo[var_0C]["ammoclip"] = self getweaponammoclip(var_0C);
		self.primaryweaponsammo[var_0C]["ammostock"] = self setweaponammostock(var_0C);
		if((issubstr(var_0C,"exoxmg") && !issubstr(var_0C,"alt_")) || issubstr(var_0C,"sac3"))
		{
			self.primaryweaponsammo[var_0C]["ammoclipleft"] = self getweaponammoclip(var_0C,"left");
		}
	}

	foreach(var_11 in self.primaryweapons)
	{
		if(!issubstr(var_11,"titan"))
		{
			self takeweapon(var_11);
		}
	}

	var_13 = hordelaststandweapon();
	maps\mp\gametypes\_weapons::saveweapon("laststand",self.lastequippedweapon,var_13);
	if(!haslaststandweapon(var_13))
	{
		self giveweapon(var_13);
	}

	self.wasunderwater = isdefined(self.underwater);
	if(!isdefined(self.underwater))
	{
		if(!issubstr(self.lastequippedweapon,"titan"))
		{
			self switchtoweaponimmediate(var_13);
		}
	}

	thread maps\mp\gametypes\_horde_util::hordeallowallboost(0,"laststand");
	self setclientomnvar("ui_horde_show_armory",0);
	self setclientomnvar("ui_horde_laststand",1);
	self hudoutlineenable(1,0);
	common_scripts\utility::_disableusability();
	self disableweaponswitch();
	self disableoffhandweapons();
	thread laststandrevivehorde(param_00,param_01,param_04,param_07,param_03);
}

//Function Number: 2
leaveremotekillstreaks()
{
	if(maps\mp\_utility::isinremotetransition())
	{
		maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();
	}

	if(isdefined(self.usingremote))
	{
		if(self.usingremote == "warbird")
		{
			foreach(var_01 in level.spawnedwarbirds)
			{
				if(var_01.owner == self)
				{
					var_01 notify("death");
					var_01 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
					wait(1);
					break;
				}
			}

			return;
		}

		if(self.usingremote == "orbital_strike")
		{
			foreach(var_04 in level.orbital_lasers)
			{
				if(var_04.owner == self)
				{
					var_04 notify("death");
					wait(1);
					break;
				}
			}

			return;
		}

		if(isdefined(self.remoteturretlist))
		{
			self.remoteturretlist[0] notify("death");
			return;
		}

		return;
	}
}

//Function Number: 3
startspectatemode(param_00,param_01,param_02)
{
	if(maps\mp\killstreaks\_emp::issystemhacked() && !level.gameended)
	{
		maps\mp\killstreaks\_emp::removeemp();
		wait 0.05;
	}

	laststandsaveloadoutinfo(param_00,param_01,!param_02);
	self.lastperks = self.horde_perks;
	maps\mp\_utility::_clearperks();
	self.lastkillstreaks = [];
	var_03 = self getclientomnvar("ui_horde_player_class");
	var_04 = self.classsettings[var_03]["killstreak"];
	var_05 = 0;
	foreach(var_07 in self.pers["killstreaks"])
	{
		if(!var_05 && isdefined(var_07.streakname) && var_07.streakname == var_04)
		{
			var_05 = 1;
			continue;
		}

		if(var_07.available)
		{
			var_08 = self.lastkillstreaks.size;
			self.lastkillstreaks[var_08]["name"] = var_07.streakname;
			self.lastkillstreaks[var_08]["modules"] = var_07.modules;
		}
	}

	self notify("becameSpectator");
	self.pers["class"] = undefined;
	self.class = undefined;
	self.isspectator = 1;
	self.ignoreme = 1;
	if(param_02)
	{
		thread maps\mp\gametypes\_playerlogic::spawnspectator(self geteye() - (0,0,8),self getplayerangles());
	}
	else
	{
		thread maps\mp\gametypes\_playerlogic::spawnspectator();
	}

	self notify("revive");
}

//Function Number: 4
laststandsaveloadoutinfo(param_00,param_01,param_02)
{
	if(param_00)
	{
		self.lastequippedweapon = self getcurrentprimaryweapon();
		self.primaryweapons = self getweaponslistprimaries();
		self.wasunderwater = isdefined(self.underwater);
		foreach(var_04 in self.primaryweapons)
		{
			self.primaryweaponsammo[var_04]["ammoclip"] = self getweaponammoclip(var_04);
			self.primaryweaponsammo[var_04]["ammostock"] = self setweaponammostock(var_04);
			if((issubstr(var_04,"exoxmg") && !issubstr(var_04,"alt_")) || issubstr(var_04,"sac3"))
			{
				self.primaryweaponsammo[var_04]["ammoclipleft"] = self getweaponammoclip(var_04,"left");
			}
		}
	}

	if(param_02)
	{
		self.lastlethalweapon = self getlethalweapon();
		self.lastlethalweaponammoclip = self getweaponammoclip(self.lastlethalweapon);
	}

	if(param_01)
	{
		var_06 = self getclientomnvar("ui_horde_player_class");
		self.lasttacticalweapon = self gettacticalweapon();
		self.lasttacticalweaponammoclip = self batterygetcharge(self.lasttacticalweapon);
		self.classsettings[var_06]["battery"] = self.lasttacticalweaponammoclip;
	}
}

//Function Number: 5
hordelaststandweapon()
{
	return "iw5_titan45_mp_xmags";
}

//Function Number: 6
haslaststandweapon(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = hordelaststandweapon();
	}

	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			self.hadlaststandweapon = 1;
			return 1;
		}
	}

	self.hadlaststandweapon = 0;
	return 0;
}

//Function Number: 7
gameshouldend(param_00)
{
	if(level.players.size < 2)
	{
		if(isdefined(self.hasselfrevive) && self.hasselfrevive)
		{
			return 0;
		}
	}

	var_01 = 0;
	foreach(var_03 in level.participants)
	{
		if(param_00 == var_03 && !maps\mp\gametypes\_horde_util::hasagentsquadmember(param_00))
		{
			continue;
		}

		if(!maps\mp\gametypes\_horde_util::isonhumanteam(var_03))
		{
			continue;
		}

		if(maps\mp\gametypes\_horde_util::isplayerinlaststand(var_03) && !maps\mp\gametypes\_horde_util::hasagentsquadmember(var_03))
		{
			continue;
		}

		if((!isdefined(var_03.sessionstate) || var_03.sessionstate != "playing") && !isdefined(var_03.goliathdeath))
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return !var_01;
}

//Function Number: 8
hordeendgame(param_00)
{
	setomnvar("horde_game_ended",1);
	foreach(var_02 in level.players)
	{
		var_02 setclientomnvar("ui_horde_show_armory",0);
	}

	foreach(var_05 in level.carepackages)
	{
		var_05 maps\mp\killstreaks\_airdrop::deletecrate();
	}

	if(!level.zombiesstarted)
	{
		thread maps\mp\gametypes\_horde_armory::hordedisablearmories();
	}

	level notify("defend_cancel");
	wait(0.05);
	level.finalkillcam_winner = level.enemyteam;
	if(!isdefined(param_00))
	{
		level thread maps\mp\gametypes\_gamelogic::endgame(level.enemyteam,game["end_reason"]["survivors_eliminated"]);
	}
	else if(param_00 == "extraction_failed")
	{
		level thread maps\mp\gametypes\_gamelogic::endgame(level.enemyteam,game["end_reason"]["zombie_extraction_failed"]);
	}
	else if(param_00 == "zombies_completed")
	{
		level thread maps\mp\gametypes\_gamelogic::endgame(level.playerteam,game["end_reason"]["zombies_completed"]);
	}

	if(level.currentroundnumber > 4)
	{
		setnojipscore(0);
	}
}

//Function Number: 9
maydolaststandhorde(param_00)
{
	if(param_00 maps\mp\_utility::touchingbadtrigger())
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
registerlaststandparameter(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	var_07.einflictor = param_00;
	var_07.attacker = param_01;
	var_07.idamage = param_02;
	var_07.attackerposition = param_01.origin;
	var_07.smeansofdeath = param_03;
	var_07.sweapon = param_04;
	var_07.vdir = param_05;
	var_07.shitloc = param_06;
	var_07.laststandstarttime = gettime();
	if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		var_07.sprimaryweapon = param_01 getcurrentprimaryweapon();
	}
	else
	{
		var_07.sprimaryweapon = undefined;
	}

	self.laststandparams = var_07;
}

//Function Number: 11
laststandrevivehorde(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	level notify("player_last_stand");
	self notify("player_start_last_stand");
	self notify("force_cancel_placement");
	level thread maps\mp\gametypes\_horde_util::playsoundtoallplayers("mp_last_stand");
	level thread maps\mp\_utility::leaderdialog("ally_down",level.playerteam,"status");
	thread laststandwaittilldeathhorde();
	thread laststandammowacher();
	thread laststandkeepoverlayhorde();
	thread laststandmonitorabandonment();
	var_05 = spawn("script_model",self.origin);
	var_05 setmodel("tag_origin");
	var_05 setcursorhint("HINT_NOICON");
	var_05 sethintstring(&"PLATFORM_REVIVE");
	var_05 makeusable();
	var_05.inuse = 0;
	var_05.curprogress = 0;
	var_05.usetime = level.laststandusetime;
	var_05.userate = 1;
	var_05.id = "last_stand";
	var_05.targetname = "revive_trigger";
	var_05.owner = self;
	var_05 linkto(self,"tag_origin",(0,0,20),(0,0,0));
	var_05 thread maps\mp\gametypes\_damage::deleteonreviveordeathordisconnect();
	var_06 = newteamhudelem(self.team);
	var_06 setshader("waypoint_revive",8,8);
	var_06 setwaypoint(1,1);
	var_06 settargetent(self);
	var_06.color = (0.33,0.75,0.24);
	var_06 thread maps\mp\gametypes\_damage::destroyonreviveentdeath(var_05);
	thread laststandupdatereviveiconcolorhorde(var_05,var_06,25);
	var_05 thread reviveentmonitor();
	var_05 thread revivetriggerthinkhorde();
	var_05 thread laststandwaittillliferecived();
	self.hasselfrevive = 0;
	if(level.players.size < 2)
	{
		thread laststandselfrevive();
		level thread selfrevivethinkloop(self);
	}
	else
	{
		thread laststandtimerhorde(25,var_05);
	}

	var_05 endon("death");
	wait(25);
	while(isdefined(var_05.inuse) && var_05.inuse)
	{
		wait 0.05;
	}

	self hudoutlinedisable();
	self disableweapons();
	self.movespeedscaler = 0.05;
	if(level.players.size > 1)
	{
		startspectatemode(0,0,0);
	}
}

//Function Number: 12
laststandselfrevive()
{
	self endon("disconnect");
	self setclientomnvar("ui_use_bar_text",3);
	self setclientomnvar("ui_use_bar_start_time",int(gettime()));
	self.curprogress = 0;
	self.userate = 1;
	self.usetime = 8000;
	var_00 = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(self.laststand) && !level.gameended)
	{
		if(var_00 != self.userate)
		{
			if(self.curprogress > self.usetime)
			{
				self.curprogress = self.usetime;
			}

			if(self.userate > 0)
			{
				var_01 = gettime();
				var_02 = self.curprogress / self.usetime;
				var_03 = var_01 + 1 - var_02 * self.usetime / self.userate;
				self setclientomnvar("ui_use_bar_end_time",int(var_03));
			}

			var_00 = self.userate;
		}

		wait(0.05);
	}

	self setclientomnvar("ui_use_bar_end_time",0);
}

//Function Number: 13
selfrevivethinkloop(param_00)
{
	while(!level.gameended && maps\mp\_utility::isreallyalive(param_00) && param_00.curprogress < param_00.usetime)
	{
		param_00.curprogress = param_00.curprogress + 50 * param_00.userate;
		if(param_00.curprogress >= param_00.usetime)
		{
			param_00 notify("revive_trigger");
		}

		wait(0.05);
	}
}

//Function Number: 14
revivetriggerthinkhorde()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self makeusable();
		self waittill("trigger",var_00);
		self makeunusable();
		self.curprogress = 0;
		self.inuse = 1;
		self.owner.beingrevived = 1;
		var_00 freezecontrols(1);
		var_00 common_scripts\utility::_disableweaponswitch();
		var_00 allowfire(0);
		var_00.isreviving = 1;
		thread revivetriggerthinkhorde_cleanup(var_00);
		var_01 = maps\mp\gametypes\_damage::reviveholdthink(var_00,undefined,0);
		self.inuse = 0;
		if(isdefined(self.owner))
		{
			self.owner.beingrevived = 0;
		}

		if(isdefined(var_00) && maps\mp\_utility::isreallyalive(var_00))
		{
			self notify("reviveTriggerThinkHorde_cleanup");
			if(isdefined(var_01) && var_01)
			{
				var_00 thread maps\mp\gametypes\_hud_message::splashnotifydelayed("horde_reviver");
				maps\mp\gametypes\_horde_util::playsoundtoallplayers("mp_challenge_complete");
				if(isplayer(var_00))
				{
					maps\mp\gametypes\_horde_util::awardhorderevive(var_00);
				}
				else if(isdefined(var_00.owner) && isplayer(var_00.owner) && var_00.owner != self.owner)
				{
					maps\mp\gametypes\_horde_util::awardhorderevive(var_00.owner);
				}
			}

			if(!isdefined(var_01))
			{
				var_00 maps\mp\gametypes\_gameobjects::updateuiprogress(self,0);
			}
		}

		if(isdefined(var_01) && var_01)
		{
			self.owner notify("revive_trigger",var_00);
			break;
		}
	}
}

//Function Number: 15
revivetriggerthinkhorde_cleanup(param_00)
{
	common_scripts\utility::waittill_any_ents(self,"death",self,"reviveTriggerThinkHorde_cleanup");
	param_00 freezecontrols(0);
	param_00 allowfire(1);
	param_00 common_scripts\utility::_enableweaponswitch();
	param_00.isreviving = 0;
}

//Function Number: 16
laststandwaittillliferecived()
{
	level endon("game_ended");
	var_00 = self.owner;
	var_00 endon("becameSpectator");
	var_00 endon("death");
	var_00 endon("disconnect");
	var_00 waittill("revive_trigger",var_01);
	if(isdefined(var_01) && isplayer(var_01) && var_01 != var_00)
	{
		var_00 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("revived",var_01);
	}

	if(var_00 isreloading())
	{
		while(var_00 isreloading())
		{
			wait 0.05;
		}

		wait 0.05;
	}

	var_00 laststandrespawnplayerhorde();
}

//Function Number: 17
reviveentmonitor()
{
	self endon("death");
	self.owner common_scripts\utility::waittill_any("revive_trigger","disconnect","becameSpectator");
	self delete();
}

//Function Number: 18
laststandrespawnplayerhorde()
{
	self notify("revive");
	var_00 = self getclientomnvar("ui_horde_player_class");
	var_01 = level.classsettings[var_00]["speed"];
	self.laststand = undefined;
	self.inlaststand = 0;
	self.headicon = "";
	self.health = self.maxhealth;
	self.movespeedscaler = var_01;
	self.ignoreme = 0;
	self.beingrevived = 0;
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		self.movespeedscaler = maps\mp\_utility::lightweightscalar();
	}

	self hudoutlinedisable();
	self laststandrevive();
	if(!isdefined(self.underwater))
	{
		self setstance("crouch");
	}

	if(!self.hadlaststandweapon)
	{
		var_02 = hordelaststandweapon();
		self takeweapon(var_02);
		self loadweapons(var_02);
	}

	if(!self.wasunderwater && isdefined(self.underwater))
	{
		self.lastequippedweapon = level.shallow_water_weapon;
	}

	if(isdefined(self.underwater))
	{
		self giveweapon(level.shallow_water_weapon);
		self switchtoweaponimmediate(level.shallow_water_weapon);
	}

	thread maps\mp\gametypes\_horde_util::hordeallowallboost(1,"laststand");
	self allowmelee(1);
	self enableweapons();
	common_scripts\utility::_enableusability();
	self enableoffhandweapons();
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	maps\mp\_utility::clearlowermessage("last_stand");
	maps\mp\_utility::giveperk("specialty_pistoldeath",0);
	if(isdefined(self.underwater) || issubstr(self.lastequippedweapon,"turret"))
	{
		givebackstoredplayerweapons(var_00,0,self.lastequippedweapon);
		if(isdefined(self.underwater) || issubstr(self.lastequippedweapon,"turret"))
		{
			self giveweapon(self.lastequippedweapon);
			while(!self loadweapons([self.lastequippedweapon]))
			{
				wait 0.05;
			}
		}
	}
	else
	{
		givebackstoredplayerweapons(var_00,1);
	}

	maps\mp\gametypes\_weapons::restoreweapon("laststand");
	if(level.hordeweaponsjammed == 0 && !isdefined(self.underwater))
	{
		self enableweaponswitch();
	}

	if(!canspawn(self.origin))
	{
		maps\mp\_movers::unresolved_collision_nearest_node(self,0);
	}
}

//Function Number: 19
givestoredweapon(param_00,param_01,param_02)
{
	maps\mp\gametypes\_horde_util::trygivehordeweapon(self,param_00,1,param_02,undefined,param_01);
	self setweaponammoclip(param_00,self.primaryweaponsammo[param_00]["ammoclip"]);
	self setweaponammostock(param_00,self.primaryweaponsammo[param_00]["ammostock"]);
}

//Function Number: 20
givebackstoredplayerweapons(param_00,param_01,param_02)
{
	if(level.zombiesstarted)
	{
		foreach(var_04 in self.primaryweapons)
		{
			self giveweapon(var_04);
			self setweaponammostock(var_04,self.primaryweaponsammo[var_04]["ammostock"]);
			self setweaponammoclip(var_04,self.primaryweaponsammo[var_04]["ammoclip"]);
		}

		self switchtoweaponimmediate(self.lastequippedweapon);
		return;
	}

	var_06 = self.lastequippedweapon == self.hordeclassweapons[var_03]["secondary"];
	var_07 = var_04 && !var_06 && !level.hordeweaponsjammed;
	var_08 = var_04 && var_06 && !level.hordeweaponsjammed;
	givestoredweapon(self.hordeclassweapons[var_03]["primary"],"primary",var_07);
	givestoredweapon(self.hordeclassweapons[var_03]["secondary"],"secondary",var_08);
	foreach(var_09 in self.primaryweapons)
	{
		if((issubstr(var_09,"exoxmg") && !issubstr(var_09,"alt_")) || issubstr(var_09,"sac3"))
		{
			self setweaponammoclip(var_09,self.primaryweaponsammo[var_09]["ammoclipleft"],"left");
		}
	}

	var_0B = self getweaponslistprimaries();
	foreach(var_09 in var_0B)
	{
		if(isdefined(var_04) && var_09 == var_04)
		{
			continue;
		}

		if(var_09 != self.hordeclassweapons[param_02]["primary"] && var_09 != self.hordeclassweapons[param_02]["secondary"])
		{
			if(!issubstr(var_09,"alt_iw5_"))
			{
				self takeweapon(var_09);
			}
		}
	}

	if(level.hordeweaponsjammed)
	{
		if(isdefined(var_04))
		{
			var_0E = var_04;
		}
		else if(var_06)
		{
			var_0E = self.hordeclassweapons[var_03]["secondary"];
		}
		else
		{
			var_0E = self.hordeclassweapons[var_03]["primary"];
		}

		maps\mp\gametypes\horde::handlejammedpistols(var_0E);
	}
}

//Function Number: 21
laststandwaittilldeathhorde()
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	self waittill("death");
	self.laststand = undefined;
	self.inlaststand = 0;
	self.ignoreme = 0;
}

//Function Number: 22
laststandkeepoverlayhorde()
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	for(;;)
	{
		self.health = 2;
		wait 0.05;
		self.health = 1;
		wait 0.05;
	}
}

//Function Number: 23
laststandmonitorabandonment()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("revive_trigger");
	self endon("horde_end_spectate");
	for(;;)
	{
		level waittill("player_disconnected");
		if(gameshouldend(self))
		{
			self.uselaststandparams = 1;
			maps\mp\_utility::_suicide();
			maps\mp\gametypes\_horde_util::hordeupdatescore(self,0);
			if(getomnvar("horde_game_ended") == 0)
			{
				hordeendgame();
			}

			return;
		}

		wait 0.05;
	}
}

//Function Number: 24
laststandupdatereviveiconcolorhorde(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	param_00 endon("death");
	maps\mp\_utility::playdeathsound();
	wait(param_02 / 3);
	param_01.color = (1,0.64,0);
	while(param_00.inuse)
	{
		wait(0.05);
	}

	maps\mp\_utility::playdeathsound();
	wait(param_02 / 3);
	param_01.color = (1,0,0);
	while(param_00.inuse)
	{
		wait(0.05);
	}

	maps\mp\_utility::playdeathsound();
}

//Function Number: 25
laststandtimerhorde(param_00,param_01)
{
	self endon("disconnect");
	var_02 = 90;
	if(!issplitscreen())
	{
		var_02 = 120;
	}

	var_03 = maps\mp\gametypes\_hud_util::createtimer("hudsmall",1);
	var_03 maps\mp\gametypes\_hud_util::setpoint("CENTER",undefined,0,var_02);
	var_03.label = &"MP_HORDE_BLEED_OUT";
	var_03.color = (0.804,0.804,0.035);
	var_03.archived = 0;
	var_03.showinkillcam = 0;
	var_03 settimer(param_00 - 1);
	param_01 common_scripts\utility::waittill_any_timeout(param_00,"death");
	if(!isdefined(var_03))
	{
		return;
	}

	var_03 notify("destroying");
	var_03 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 26
laststandammowacher()
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	for(;;)
	{
		wait(1.5);
		var_00 = self getcurrentprimaryweapon();
		if(!maps\mp\gametypes\_weapons::isprimaryweapon(var_00))
		{
			continue;
		}

		var_01 = self setweaponammostock(var_00);
		var_02 = weaponclipsize(var_00);
		if(var_01 < var_02)
		{
			self setweaponammostock(var_00,var_02);
		}
	}
}

//Function Number: 27
laststandexoabilitymonitor()
{
	self endon("death");
	self endon("disconnect");
	self endon("becameSpectator");
	level endon("game_ended");
	var_00 = self getclientomnvar("ui_horde_player_class");
	self.lasttacticalweapon = self gettacticalweapon();
	self.lasttacticalweaponammoclip = self batterygetcharge(self.lasttacticalweapon);
	self.classsettings[var_00]["battery"] = self.lasttacticalweaponammoclip;
	switch(self.lasttacticalweapon)
	{
		case "exocloakhorde_equipment_mp":
			maps\mp\_exo_cloak::take_exo_cloak();
			break;

		case "exohoverhorde_equipment_mp":
			maps\mp\_exo_hover::take_exo_hover();
			break;

		case "exoshieldhorde_equipment_mp":
			if(isdefined(self.exo_shield_on) && self.exo_shield_on)
			{
				self batterysetcharge("exoshieldhorde_equipment_mp",0);
				self waittillmatch("battery_discharge_end");
			}
	
			maps\mp\_exo_shield::take_exo_shield();
			break;

		case "exoping_equipment_mp":
			maps\mp\_exo_ping::take_exo_ping();
			break;

		case "exorepulsor_equipment_mp":
			maps\mp\_exo_repulsor::take_exo_repulsor();
			break;

		case "extra_health_mp":
			maps\mp\_extrahealth::take_exo_health();
			break;
	}

	wait 0.05;
	self notify("last_stand_offhand_secondary_disabled");
	self disableoffhandsecondaryweapons();
	self waittill("revive");
	switch(self.lasttacticalweapon)
	{
		case "exocloakhorde_equipment_mp":
			maps\mp\_exo_cloak::give_exo_cloak();
			break;

		case "exohoverhorde_equipment_mp":
			maps\mp\_exo_hover::give_exo_hover();
			break;

		case "exoshieldhorde_equipment_mp":
			maps\mp\_exo_shield::give_exo_shield();
			break;

		case "exoping_equipment_mp":
			maps\mp\_exo_ping::give_exo_ping();
			break;

		case "exorepulsor_equipment_mp":
			maps\mp\_exo_repulsor::give_exo_repulsor();
			break;

		case "extra_health_mp":
			maps\mp\_extrahealth::give_exo_health();
			break;
	}

	self batterysetcharge(self.lasttacticalweapon,self.lasttacticalweaponammoclip);
	self setclientomnvar("ui_exo_battery_level0",self.lasttacticalweaponammoclip);
	self enableoffhandsecondaryweapons();
	level thread maps\mp\gametypes\_horde_armory::hordebatterylevel(self);
}

//Function Number: 28
hordehandlejuggdeath()
{
	level endon("game_ended");
	self endon("disconnect");
	self.goliathdeath = 1;
	self.inliveplayerkillstreak = undefined;
	self.mechhealth = undefined;
	self.markedformech = [];
	if(isdefined(self.barrel))
	{
		self.barrel hide();
	}

	self takeweapon("iw5_exominigun_mp");
	maps\mp\killstreaks\_juggernaut::playerreset(self.heavyexodata);
	self hudoutlinedisable();
	self playerhide();
	self notify("horde_cancel_goliath");
	waittillframeend;
	startspectatemode(0,0,1);
	self setmlgspectator(1);
	self freezecontrols(1);
	self setclientomnvar("ui_hide_hud",1);
	wait(2.5);
	self setmlgspectator(0);
	self freezecontrols(0);
	self setclientomnvar("ui_hide_hud",0);
	self detachall();
	self setcostumemodels(self.costume);
	self playershow();
	level thread maps\mp\gametypes\horde::respawnplayer(self);
	if(!level.zombiesstarted)
	{
		if(isdefined(self.hordeclassgoliathowner))
		{
			self.hordeclassgoliathowner.hordeclassgoliathcontroller = undefined;
			self.hordeclassgoliathowner notify("startJuggCooldown");
		}
		else
		{
			self notify("startJuggCooldown");
		}
	}

	if(isdefined(self.hordegoliathowner))
	{
		self.hordegoliathowner.hordegoliathcontroller = undefined;
	}

	self.hordeclassgoliathowner = undefined;
	self.hordegoliathowner = undefined;
}