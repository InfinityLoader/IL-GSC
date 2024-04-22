/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_laststand.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 1380 ms
 * Timestamp: 4/22/2024 2:14:37 AM
*******************************************************************/

//Function Number: 1
callback_playerlaststandzombies(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self notify("enter_last_stand");
	registerlaststandparameter(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	if(gameshouldend(self,param_03,1) && !isattackerhostzombie(param_01) && !isattackerbossozstage2(param_01) && !cananyplayertokenrevive())
	{
		self.uselaststandparams = 1;
		self.numberofbleedouts++;
		maps\mp\_utility::_suicide();
		zombieendgame(undefined,param_03);
		return;
	}

	if(!maydolaststandzombies(self))
	{
		var_09 = "ui_zm_character_" + self.characterindex + "_alive";
		setomnvar(var_09,0);
		self.uselaststandparams = 0;
		self.numberofbleedouts++;
		maps\mp\_utility::_suicide();
		if(level.players.size < 2)
		{
			zombieendgame(undefined,param_03);
		}

		return;
	}

	if(isattackerhostzombie(param_02))
	{
		thread hostzombielaststand();
		return;
	}

	if(isattackerbossozstage2(param_02))
	{
		thread hostzombielaststand(1);
		return;
	}

	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		maps\mp\_utility::_suicide();
		return;
	}

	self notify("begin_last_stand");
	self.inlaststand = 1;
	self.laststand = 1;
	maps\mp\zombies\_util::setallignoreme(1);
	self.health = 1;
	self.numberofdowns++;
	var_0A = zombieslaststandweapon();
	savelaststandweapons(var_0A);
	if(!haslaststandweapon(var_0A))
	{
		giveplayerweapon(var_0A,1);
	}
	else
	{
		self switchtoweaponimmediate(var_0A);
	}

	thread maps\mp\zombies\_util::zombieallowallboost(0,"laststand");
	thread zombieperkbleed();
	thread zombietokenrevive();
	common_scripts\utility::_disableusability();
	common_scripts\utility::_disableweaponswitch();
	self disableoffhandweapons();
	if(isdefined(param_04) && param_04 == "MOD_SUICIDE")
	{
		self deathdropgrenade();
	}

	thread laststandrevivezombie(param_01,param_02,param_05,param_08,param_04);
	if(isdefined(level.laststandinwaterfunc))
	{
		self thread [[ level.laststandinwaterfunc ]]();
	}

	if(maps\mp\agents\_agent_utility::getnumownedactiveagents(self) > 0)
	{
		thread tryendgameafteragentsdie(param_04);
		return;
	}
}

//Function Number: 2
tryendgameafteragentsdie(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	while(maps\mp\agents\_agent_utility::getnumownedactiveagents(self) > 0)
	{
		wait(0.05);
	}

	if(!areanyotherplayersalive(self) && !maps\mp\zombies\_util::is_true(self.selfreviveactive))
	{
		thread killplayerandendgameafteragentsdead(param_00);
	}
}

//Function Number: 3
killplayerandendgameafteragentsdead(param_00)
{
	level endon("game_ended");
	self.uselaststandparams = 1;
	self.numberofbleedouts++;
	maps\mp\_utility::_suicide();
	zombieendgame(undefined,param_00);
}

//Function Number: 4
zombietokenrevive()
{
	zombietokenrevivewait();
	if(isdefined(self))
	{
		maps\mp\zombies\_util::cleartokenuseomnvars();
	}
}

//Function Number: 5
zombietokenrevivewait()
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	var_00 = undefined;
	for(;;)
	{
		if(isdefined(self.tokenbuttonpressed) && self.tokenbuttonpressed && !isdefined(self playergetuseent(1)) && maps\mp\gametypes\zombies::hastoken(10))
		{
			if(!isdefined(var_00))
			{
				var_00 = gettime() + maps\mp\gametypes\zombies::gettokenusetime();
				maps\mp\zombies\_util::settokenuseomvars();
			}

			if(gettime() >= var_00)
			{
				maps\mp\gametypes\zombies::spendtoken(10);
				self notify("revive_trigger",0);
				return;
			}
		}
		else if(isdefined(var_00))
		{
			var_00 = undefined;
			maps\mp\zombies\_util::cleartokenuseomnvars();
		}

		wait 0.05;
	}
}

//Function Number: 6
savelaststandweapons(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = self getweaponslistprimaries();
	self.primaryweapons = [];
	foreach(var_04 in var_02)
	{
		if(!issubstr(var_04,"combatknife"))
		{
			self.primaryweapons[self.primaryweapons.size] = var_04;
		}
	}

	self.lastequippedweapon = self getcurrentprimaryweapon();
	if(self.lastequippedweapon == "search_dstry_bomb_defuse_mp" && isdefined(self.lastnonuseweapon) && isdefined(common_scripts\utility::array_find(self.primaryweapons,self.lastnonuseweapon)))
	{
		self.lastequippedweapon = self.lastnonuseweapon;
	}

	if(issubstr(self.lastequippedweapon,"killstreak"))
	{
		self.lastequippedweapon = self.primaryweapons[0];
	}

	if(self.lastequippedweapon == "airdrop_sentry_marker_mp")
	{
		self.lastequippedweapon = self.primaryweapons[0];
	}

	if(self.lastequippedweapon == "none")
	{
		self.lastequippedweapon = self.primaryweapons[0];
	}

	if(issubstr(self.lastequippedweapon,"exo_suit_"))
	{
		self.lastequippedweapon = self.primaryweapons[0];
	}

	foreach(var_04 in self.primaryweapons)
	{
		self.primaryweaponsammo[var_04]["ammoclip"] = self getweaponammoclip(var_04);
		if(common_scripts\utility::string_find(var_04,"akimbo"))
		{
			self.primaryweaponsammo[var_04]["ammoclipleft"] = self getweaponammoclip(var_04,"left");
		}

		self.primaryweaponsammo[var_04]["ammostock"] = self setweaponammostock(var_04);
	}

	self.tombstoneweapon = self.lastequippedweapon;
	self.tombstoneweaponlevel = maps\mp\zombies\_util::getzombieweaponlevel(self,self.tombstoneweapon);
	if(issubstr(self.tombstoneweapon,"titan"))
	{
		self.tombstoneweaponlevel = 0;
	}

	foreach(var_09 in self.primaryweapons)
	{
		if(!issubstr(var_09,"titan"))
		{
			if(param_01)
			{
				self takeweapon(var_09);
			}

			var_0A = maps\mp\zombies\_util::getzombieweaponlevel(self,var_09);
			if(var_0A > self.tombstoneweaponlevel)
			{
				self.tombstoneweapon = var_09;
				self.tombstoneweaponlevel = var_0A;
			}
		}
	}

	if(isdefined(self.scriptedtombstoneweapon) && isdefined(self.scriptedtombstoneweaponlevel))
	{
		self.tombstoneweapon = self.scriptedtombstoneweapon;
		self.tombstoneweaponlevel = self.scriptedtombstoneweaponlevel;
	}
}

//Function Number: 7
refillstoredweaponammo()
{
	foreach(var_01 in self.primaryweapons)
	{
		self.primaryweaponsammo[var_01]["fillMax"] = 1;
	}
}

//Function Number: 8
zombieslaststandweapon()
{
	var_00 = [];
	if(maps\mp\zombies\_util::getzombieslevelnum() >= 3)
	{
		var_00 = ["iw5_fusionzm_mp","iw5_dlcgun3zm_mp","iw5_rw1zm_mp","iw5_vbrzm_mp","iw5_titan45zm_mp"];
	}
	else
	{
		var_00 = ["iw5_fusionzm_mp","iw5_rw1zm_mp","iw5_vbrzm_mp","iw5_titan45zm_mp"];
	}

	var_01 = var_00[var_00.size - 1];
	var_02 = maps\mp\zombies\_wall_buys::getupgradeweaponname(self,var_01);
	var_03 = -1;
	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		var_05 = maps\mp\zombies\_wall_buys::getupgradeweaponname(self,var_00[var_04]);
		if(self hasweapon(var_05))
		{
			var_06 = maps\mp\zombies\_util::getzombieweaponlevel(self,var_00[var_04]);
			if(var_06 > var_03)
			{
				var_02 = var_05;
				var_03 = var_06;
			}
		}
	}

	return var_02;
}

//Function Number: 9
haslaststandweapon(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = zombieslaststandweapon();
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

//Function Number: 10
gameshouldend(param_00,param_01,param_02)
{
	if(level.players.size <= 1)
	{
		if(isdefined(param_01) && param_01 == "MOD_SUICIDE")
		{
			return 1;
		}

		if(param_00 hasexostim() && maydolaststandzombies(param_00))
		{
			return 0;
		}
	}

	if(areanyotherplayersalive(param_00))
	{
		return 0;
	}
	else if(isdefined(param_02) && param_02 && areanyalliedagentsalive(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
areanyalliedagentsalive(param_00)
{
	var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	foreach(var_03 in var_01)
	{
		if(!isalliedsentient(var_03,param_00))
		{
			continue;
		}

		if(maps\mp\zombies\_util::isplayerinlaststand(var_03))
		{
			continue;
		}

		if(maps\mp\zombies\_util::is_true(var_03.fakeplayer))
		{
			continue;
		}

		return 1;
	}

	return 0;
}

//Function Number: 12
areanyotherplayersalive(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(param_00 == var_03)
		{
			continue;
		}

		if(!maps\mp\zombies\_util::isonhumanteam(var_03))
		{
			continue;
		}

		if(maps\mp\zombies\_util::isplayerinlaststand(var_03))
		{
			if(maps\mp\agents\_agent_utility::getnumownedactiveagents(var_03) == 0)
			{
				continue;
			}
		}

		if(!isdefined(var_03.sessionstate) || var_03.sessionstate != "playing")
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return var_01;
}

//Function Number: 13
cananyplayertokenrevive()
{
	if(!level.tokensenabled)
	{
		return 0;
	}

	foreach(var_01 in level.players)
	{
		if(var_01 playercantokenrevive())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
playercantokenrevive()
{
	if(!level.tokensenabled)
	{
		return 0;
	}

	if(self.sessionstate != "playing")
	{
		return 0;
	}

	if(!maps\mp\gametypes\zombies::hastoken(10))
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
zombieendgame(param_00,param_01)
{
	if(!gameshouldend(self,param_01))
	{
		return 0;
	}

	if(game["state"] == "postgame" || level.gameended)
	{
		return;
	}

	maps\mp\zombies\_util::writezombiestats();
	level.finalkillcam_winner = level.enemyteam;
	if(!isdefined(param_00))
	{
		level thread maps\mp\gametypes\_gamelogic::endgame(level.enemyteam,game["end_reason"]["survivors_eliminated"]);
	}

	wait 0.05;
	maps\mp\zombies\_zombies_music::changezombiemusic("game_over");
}

//Function Number: 16
maydolaststandzombies(param_00)
{
	if(param_00 maps\mp\_utility::touchingbadtrigger())
	{
		return 0;
	}

	if(maps\mp\zombies\_util::is_true(param_00.outofbounds))
	{
		return 0;
	}

	if(maps\mp\zombies\_util::isplayerinfected(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
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

//Function Number: 18
hasexostim()
{
	return isdefined(self.isexostimactive) && self.isexostimactive;
}

//Function Number: 19
useexostim()
{
	self notify("take_exo_revive");
	thread laststandselfrevive();
	level thread selfrevivethinkloop(self);
}

//Function Number: 20
zombieperkbleed()
{
	zombieperkbleedwait();
	zombieperkbleedflashingstop();
}

//Function Number: 21
zombieperkbleedwait()
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	var_00 = [];
	for(var_01 = self.zm_perks.size - 1;var_01 >= 0;var_01--)
	{
		var_02 = self.zm_perks[var_01];
		if(var_02 != "exo_suit" && var_02 != "exo_revive" || level.players.size > 1)
		{
			var_00[var_00.size] = var_02;
		}
	}

	if(!var_00.size)
	{
		return;
	}

	var_03 = 8;
	foreach(var_02 in var_00)
	{
		zombieperkbleedflashing(var_02);
		wait(var_03);
		while(isdefined(self.beingrevived) && self.beingrevived)
		{
			wait 0.05;
		}

		self notify("take_" + var_02);
	}
}

//Function Number: 22
zombieperkbleedflashing(param_00)
{
	var_01 = maps\mp\zombies\_terminals::getitemomnvar(param_00);
	self.perkomnvarflash = var_01;
	self setclientomnvar(var_01,2);
}

//Function Number: 23
zombieperkbleedflashingstop()
{
	if(isdefined(self) && isdefined(self.perkomnvarflash))
	{
		self setclientomnvar(self.perkomnvarflash,1);
		self.perkomnvarflash = undefined;
	}
}

//Function Number: 24
laststandrevivezombie(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	level notify("player_last_stand");
	self notify("force_cancel_placement");
	thread maps\mp\zombies\_zombies_audio::playerlaststandvo();
	thread laststandwaittilldeathzombies();
	thread laststandammomonitor();
	thread laststandkeepoverlayzombies();
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
	var_05 thread deleteonreviveordeathordisconnect();
	self.reviveicon = createreviveicon("hint_health_zm",8,8,(0.5,1,0.99));
	thread laststandupdatereviveiconcolorzombies(var_05,30);
	thread laststandupdatereviveiconzombies(var_05);
	var_05 thread reviveentmonitor();
	var_05 thread laststandwaittilllifereceived();
	if(level.players.size <= 1 && hasexostim())
	{
		useexostim();
	}
	else
	{
		var_05 thread revivetriggerthinkzombies();
		applylaststandmoneypenalty(self);
		thread laststandtimerzombies(30,var_05);
	}

	var_05 endon("death");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(30);
	while(isdefined(var_05.inuse) && var_05.inuse)
	{
		wait 0.05;
	}

	self hudoutlinedisable();
	self disableweapons();
	self.movespeedscaler = 0.05;
	thread bleedout();
}

//Function Number: 25
deleteonreviveordeathordisconnect()
{
	if(!isdefined(self))
	{
		return;
	}

	self endon("death");
	self.owner common_scripts\utility::waittill_any("death","disconnect");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 26
createreviveicon(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.reviveicon))
	{
		self.reviveicon destroy();
	}

	var_04 = newteamhudelem(self.team);
	var_04 setshader(param_00,param_01,param_02);
	var_04 setwaypoint(1,1);
	var_04 settargetent(self);
	var_04.color = param_03;
	return var_04;
}

//Function Number: 27
applylaststandmoneypenalty(param_00)
{
	var_01 = maps\mp\gametypes\zombies::getcurrentmoney(param_00);
	var_02 = int(var_01 * 0.1);
	var_03 = common_scripts\utility::mod(var_02,10);
	var_02 = var_02 - var_03;
	param_00 maps\mp\gametypes\zombies::spendmoney(var_02);
	param_00.revivemoneyaward = var_02;
}

//Function Number: 28
bleedout()
{
	self notify("bleedout");
	level notify("bleedout");
	if(isdefined(self.reviveicon))
	{
		self.reviveicon destroy();
	}

	var_00 = "ui_zm_character_" + self.characterindex + "_alive";
	setomnvar(var_00,0);
	if(maps\mp\zombies\_util::playerhasem1ammoinfo())
	{
		maps\mp\zombies\_util::playerclearem1ammoinfo();
	}

	self.numberofbleedouts++;
	self suicide();
	if(!areanyotherplayersalive(self))
	{
		zombieendgame();
		return;
	}

	maps\mp\zombies\_zombies_music::changezombiemusic("player_died",self);
}

//Function Number: 29
laststandselfrevive()
{
	self endon("disconnect");
	self setclientomnvar("ui_use_bar_text",3);
	self setclientomnvar("ui_use_bar_start_time",int(gettime()));
	self.curprogress = 0;
	self.userate = 1;
	self.usetime = 8000;
	self.selfreviveactive = 1;
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

	self.selfreviveactive = 0;
	self setclientomnvar("ui_use_bar_end_time",0);
}

//Function Number: 30
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

//Function Number: 31
revivetriggerthinkzombies()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 2000;
	var_01 = 0.5;
	for(;;)
	{
		self makeusable();
		self waittill("trigger",var_02);
		self makeunusable();
		self.curprogress = 0;
		self.inuse = 1;
		self.owner.beingrevived = 1;
		var_02 freezecontrols(1);
		var_02 common_scripts\utility::_disableweaponswitch();
		var_02 maps\mp\zombies\_util::playerallowfire(0,"laststand");
		var_02.isreviving = 1;
		var_03 = var_00;
		if(var_02 hasexostim())
		{
			var_03 = var_03 * var_01;
		}

		thread revivetriggerthinkzombies_cleanup(var_02);
		var_04 = maps\mp\gametypes\_damage::reviveholdthink(var_02,var_03,0);
		self.inuse = 0;
		if(isdefined(self.owner))
		{
			self.owner.beingrevived = 0;
		}

		if(isdefined(var_02) && maps\mp\_utility::isreallyalive(var_02))
		{
			self notify("reviveTriggerThinkZombies_cleanup");
			if(!isdefined(var_04))
			{
				var_02 maps\mp\gametypes\_gameobjects::updateuiprogress(self,0);
			}
		}

		if(isdefined(var_04) && var_04)
		{
			self.owner notify("revive_trigger",var_02);
			var_05 = var_02;
			if(!isplayer(var_05) && isplayer(var_05.owner))
			{
				var_05 = var_05.owner;
			}

			var_05 maps\mp\gametypes\zombies::givemoney(self.owner.revivemoneyaward);
			break;
		}
	}
}

//Function Number: 32
revivetriggerthinkzombies_cleanup(param_00)
{
	common_scripts\utility::waittill_any_ents(self,"death",self,"reviveTriggerThinkZombies_cleanup");
	param_00 freezecontrols(0);
	param_00 maps\mp\zombies\_util::playerallowfire(1,"laststand");
	param_00 common_scripts\utility::_enableweaponswitch();
	param_00.isreviving = 0;
}

//Function Number: 33
waittill_any_in_array_return_no_endon_death_duplicate(param_00)
{
	var_01 = spawnstruct();
	foreach(var_03 in param_00)
	{
		childthread common_scripts\utility::waittill_string_no_endon_death(var_03,var_01);
	}

	var_01 waittill("returned",var_05);
	var_01 notify("die");
	return var_05;
}

//Function Number: 34
laststandcleanupomnvar(param_00)
{
	level endon("game_ended");
	self endon("revive_trigger");
	var_01 = self.characterindex;
	waittill_any_in_array_return_no_endon_death_duplicate(param_00);
	var_02 = "ui_zm_character_" + var_01 + "_bleedout_endtime";
	setomnvar(var_02,0);
	level notify(var_02 + "_cancel");
}

//Function Number: 35
laststandwaittilllifereceived()
{
	level endon("game_ended");
	var_00 = self.owner;
	var_00 endon("becameSpectator");
	var_00 endon("death");
	var_00 endon("disconnect");
	var_00 thread laststandcleanupomnvar(["becameSpectator","death","disconnect"]);
	var_00 waittill("revive_trigger",var_01);
	if(isdefined(var_01) && isplayer(var_01))
	{
		var_00 thread maps\mp\zombies\_zombies_audio::playerrevivevo(var_01);
	}

	if(isdefined(var_01) && isplayer(var_01) && var_01 != var_00)
	{
		var_00 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("revived",var_01);
		var_01 maps\mp\_utility::incplayerstat("assists",1);
		var_01 maps\mp\_utility::incpersstat("assists",1);
		var_01.assists = var_01 maps\mp\_utility::getpersstat("assists");
		var_01 maps\mp\gametypes\_persistence::statsetchild("round","assists",var_01.assists);
	}

	var_02 = "ui_zm_character_" + var_00.characterindex + "_bleedout_endtime";
	setomnvar(var_02,0);
	level notify(var_02 + "_cancel");
	if(var_00 isreloading())
	{
		while(var_00 isreloading())
		{
			wait 0.05;
		}

		wait 0.05;
	}

	var_00 respawnplayerzombies(1);
}

//Function Number: 36
reviveentwaittillconditions()
{
	self endon("death");
	self.owner common_scripts\utility::waittill_any("revive_trigger","disconnect","becameSpectator");
}

//Function Number: 37
reviveentmonitor()
{
	if(isdefined(self.owner.reviveicon))
	{
		var_00 = self.owner.reviveicon;
	}
	else
	{
		var_00 = undefined;
	}

	reviveentwaittillconditions();
	if(isdefined(self) && isdefined(self.owner) && isdefined(self.owner.reviveicon))
	{
		self.owner.reviveicon destroy();
	}
	else if(isdefined(var_00))
	{
		var_00 destroy();
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 38
givebackweaponsfromlaststand()
{
	if(!self.hadlaststandweapon)
	{
		var_00 = zombieslaststandweapon();
		self takeweapon(var_00);
		self loadweapons(var_00);
	}

	var_01 = undefined;
	if(issubstr(self.lastequippedweapon,"turrethead"))
	{
		var_02 = -1;
		for(var_03 = 0;var_03 < self.primaryweapons.size;var_03++)
		{
			var_04 = maps\mp\zombies\_wall_buys::getupgradeweaponname(self,self.primaryweapons[var_03]);
			var_05 = maps\mp\zombies\_util::getzombieweaponlevel(self,self.primaryweapons[var_03]);
			if(var_05 > var_02)
			{
				var_01 = var_04;
				var_02 = var_05;
			}
		}
	}

	if(!isdefined(var_01))
	{
		var_01 = self.lastequippedweapon;
	}

	foreach(var_07 in self.primaryweapons)
	{
		givestoredweapon(var_07,var_07 == var_01);
	}
}

//Function Number: 39
respawnplayerzombies(param_00)
{
	self notify("revive");
	self.laststand = undefined;
	self.inlaststand = 0;
	self.headicon = "";
	self.health = self.maxhealth;
	self.ignoreme = 0;
	self.ignoremecount = undefined;
	self.zombiesignoreme = 0;
	self.zombiesignoremecount = undefined;
	self.beingrevived = 0;
	self.lastrevivetime = gettime();
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		self.movespeedscaler = maps\mp\_utility::lightweightscalar();
	}

	self hudoutlinedisable();
	self laststandrevive();
	self setstance("crouch");
	if(param_00)
	{
		givebackweaponsfromlaststand();
	}

	if(param_00)
	{
		common_scripts\utility::_enableweaponswitch();
	}
	else
	{
		self enableweaponswitch();
	}

	thread maps\mp\zombies\_util::zombieallowallboost(1,"laststand");
	self enableweapons();
	common_scripts\utility::_enableusability();
	self enableoffhandweapons();
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	maps\mp\_utility::clearlowermessage("last_stand");
	maps\mp\_utility::giveperk("specialty_pistoldeath",0);
	self allowsprint(1);
	if(!canspawn(self.origin))
	{
		maps\mp\_movers::unresolved_collision_nearest_node(self,0);
	}
}

//Function Number: 40
revivefromspectatemode()
{
	self endon("disconnect");
	wait(1);
	maps\mp\gametypes\_playerlogic::incrementalivecount(self.team);
	self.alreadyaddedtoalivecount = 1;
	self.pers["lives"] = 1;
	thread maps\mp\gametypes\_playerlogic::spawnclient();
	thread maps\mp\zombies\_util::setcustomcharacter(self.characterindex,0);
	wait(0.1);
	respawnplayerzombies(0);
}

//Function Number: 41
givestoredweapon(param_00,param_01)
{
	giveplayerweapon(param_00,param_01);
	if(isdefined(self.primaryweaponsammo[param_00]["fillMax"]))
	{
		self givemaxammo(param_00);
		self.primaryweaponsammo[param_00]["fillMax"] = undefined;
		return;
	}

	self setweaponammoclip(param_00,self.primaryweaponsammo[param_00]["ammoclip"]);
	if(common_scripts\utility::string_find(param_00,"akimbo") && isdefined(self.primaryweaponsammo[param_00]["ammoclipleft"]))
	{
		self setweaponammoclip(param_00,self.primaryweaponsammo[param_00]["ammoclipleft"],"left");
	}

	self setweaponammostock(param_00,self.primaryweaponsammo[param_00]["ammostock"]);
}

//Function Number: 42
giveplayerweapon(param_00,param_01)
{
	while(!self loadweapons([param_00]))
	{
		wait 0.05;
	}

	maps\mp\_utility::_giveweapon(param_00);
	if(param_01)
	{
		self switchtoweaponimmediate(param_00);
	}
}

//Function Number: 43
laststandwaittilldeathzombies()
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	self waittill("death");
	self.laststand = undefined;
	self.inlaststand = 0;
	self.ignoreme = 0;
	self.ignoremecount = undefined;
	self.zombiesignoreme = 0;
	self.zombiesignoremecount = undefined;
}

//Function Number: 44
laststandkeepoverlayzombies()
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

//Function Number: 45
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
			self.numberofbleedouts++;
			maps\mp\_utility::_suicide();
			zombieendgame();
			return;
		}

		wait 0.05;
	}
}

//Function Number: 46
laststandupdatereviveiconzombies(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	param_00 endon("death");
	var_01 = (1,1,1);
	for(;;)
	{
		while(!param_00.inuse)
		{
			wait 0.05;
		}

		var_02 = self.reviveicon.color;
		self.reviveicon = createreviveicon("hint_health_zm",8,8,var_01);
		while(param_00.inuse)
		{
			wait 0.05;
		}

		if(self.reviveicon.color != var_01)
		{
			var_02 = self.reviveicon.color;
		}

		self.reviveicon = createreviveicon("hint_health_zm",8,8,var_02);
	}
}

//Function Number: 47
laststandupdatereviveiconcolorzombies(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	param_00 endon("death");
	maps\mp\_utility::playdeathsound();
	wait(param_01 / 3);
	while(param_00.inuse)
	{
		wait(0.05);
	}

	self.reviveicon.color = (1,0.5,0);
	maps\mp\_utility::playdeathsound();
	wait(param_01 / 3);
	while(param_00.inuse)
	{
		wait(0.05);
	}

	self.reviveicon.color = (0.99,0.19,0.22);
	maps\mp\_utility::playdeathsound();
}

//Function Number: 48
laststandtimerzombies(param_00,param_01)
{
	var_02 = gettime() + param_00 * 1000;
	var_03 = "ui_zm_character_" + self.characterindex + "_bleedout_endtime";
	level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration(var_03,var_02);
}

//Function Number: 49
laststandammomonitor()
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	var_00 = 1;
	for(;;)
	{
		wait(var_00);
		var_01 = self getcurrentweapon();
		var_02 = self getammocount(var_01);
		if(var_02 == 0)
		{
			var_03 = weaponclipsize(var_01);
			self setweaponammostock(var_01,var_03);
		}
	}
}

//Function Number: 50
isattackerhostzombie(param_00)
{
	if(!isdefined(param_00) || !isdefined(param_00.agent_type))
	{
		return 0;
	}

	return param_00.agent_type == "zombie_host";
}

//Function Number: 51
isattackerbossozstage2(param_00)
{
	if(!isdefined(param_00) || !isdefined(param_00.agent_type))
	{
		return 0;
	}

	return param_00.agent_type == "zombie_boss_oz_stage2";
}

//Function Number: 52
hostzombielaststand(param_00)
{
	self endon("disconnect");
	self endon("cured");
	level notify("player_infected",self);
	self notify("player_infected");
	var_01 = zombieslaststandweapon();
	savelaststandweapons(var_01,0);
	var_02 = 60;
	if(isdefined(self.isexotacticalarmoractive) && self.isexotacticalarmoractive)
	{
		var_02 = var_02 + 15;
	}

	maps\mp\zombies\_zombies_audio::player_infected();
	self laststandrevive();
	self.health = 100;
	self.infected = 1;
	self.infectedendtime = gettime() + var_02 * 1000;
	thread hostzombieupdateoutline();
	thread hostzombiehud(var_02);
	if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark")
	{
	}
	else
	{
		thread hostzombieheartbeat(var_02);
	}

	thread hostzombiewaitcured();
	thread hostzombietokencured();
	thread hostzombiewaitbleedout();
	thread hostzombieupdateendtime();
	thread hostzombiecuredsound();
	while(self.infectedendtime > gettime())
	{
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		wait 0.05;
	}

	self notify("stop_useHoldThinkLoop");
	self.isdefusing = 0;
	self.isplanting = 0;
	if(level.players.size <= 1 && hasexostim())
	{
		thread hostzombiesoloexostim();
		return;
	}

	level thread spawnplayerhostzombie(self);
	self.hideondeath = 1;
	bleedout();
}

//Function Number: 53
hostzombiesoloexostim()
{
	self notify("cured",0);
	wait 0.05;
	self dodamage(self.health,self.origin,undefined,undefined,"MOD_TRIGGER_HURT");
}

//Function Number: 54
hostzombieupdateoutline()
{
	var_00 = 0;
	var_01 = 1;
	var_02 = [];
	var_03 = [];
	foreach(var_05 in level.players)
	{
		if(maps\mp\zombies\_util::isplayerinfected(var_05))
		{
			var_05 hudoutlineenable(var_01,0);
			var_02[var_02.size] = var_05;
			continue;
		}

		var_05 hudoutlinedisable();
		var_03[var_03.size] = var_05;
	}

	wait 0.05;
	var_02 = common_scripts\utility::array_removeundefined(var_02);
	var_03 = common_scripts\utility::array_removeundefined(var_03);
	foreach(var_08 in level.hostcuremodels)
	{
		if(maps\mp\zombies\_util::is_true(var_08.terminal.terminaldeactivated))
		{
			continue;
		}

		if(var_02.size)
		{
			if(maps\mp\zombies\_terminals::perkterminalhostcureincooldown(var_08.terminal) || maps\mp\zombies\_util::is_true(var_08.terminal.terminaldisabled))
			{
				var_08 hudoutlineenableforclients(var_02,var_00,1);
			}
			else
			{
				var_08 hudoutlineenableforclients(var_02,var_01,1);
			}
		}

		if(var_03.size)
		{
			var_08 hudoutlinedisableforclients(var_03);
		}

		if(var_02.size)
		{
			var_08 maps\mp\zombies\_terminals::perkterminalcuremodellighton();
			continue;
		}

		var_08 maps\mp\zombies\_terminals::perkterminalcuremodellightoff();
	}
}

//Function Number: 55
hostzombieupdateendtime()
{
	self endon("disconnect");
	self endon("bleedout");
	self endon("cured");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		self.health = 100;
		if(isscriptedagent(var_01))
		{
			if(var_00 > 50)
			{
				var_05 = 5000;
			}
			else
			{
				var_05 = 3000;
			}
		}
		else
		{
			var_05 = var_00 * 100;
		}

		self.infectedendtime = self.infectedendtime - var_05;
		self notify("infectedEntTimeUpdate",var_05);
	}
}

//Function Number: 56
hostzombietokencured()
{
	hostzombietokencuredwait();
	if(isdefined(self))
	{
		maps\mp\zombies\_util::cleartokenuseomnvars();
	}
}

//Function Number: 57
hostzombietokencuredwait()
{
	self endon("hostZombieEnd");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	var_00 = 90000;
	var_01 = undefined;
	for(;;)
	{
		if(isdefined(self.tokenbuttonpressed) && self.tokenbuttonpressed && !isdefined(self playergetuseent(1)) && maps\mp\gametypes\zombies::hastoken(10))
		{
			if(!isdefined(var_01))
			{
				var_01 = gettime() + maps\mp\gametypes\zombies::gettokenusetime();
				maps\mp\zombies\_util::settokenuseomvars();
			}

			if(gettime() >= var_01)
			{
				maps\mp\gametypes\zombies::spendtoken(10);
				self setwatersheeting(1,0.5);
				var_02 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
				foreach(var_04 in var_02)
				{
					if(isdefined(var_04.agent_type) && var_04.agent_type == "zombie_host" && distance2dsquared(var_04.origin,self.origin) < var_00)
					{
						var_04 suicide();
					}
				}

				self notify("cured",1);
				return;
			}
		}
		else if(isdefined(var_05))
		{
			var_05 = undefined;
			maps\mp\zombies\_util::cleartokenuseomnvars();
		}

		wait 0.05;
	}
}

//Function Number: 58
hostzombiewaitcured()
{
	self endon("hostZombieEnd");
	self endon("disconnect");
	self waittill("cured",var_00);
	thread hostzombieend(var_00);
}

//Function Number: 59
hostzombiewaitbleedout()
{
	self endon("hostZombieEnd");
	self endon("disconnect");
	self waittill("bleedout");
	thread hostzombieend(0);
}

//Function Number: 60
hostzombieend(param_00)
{
	self notify("hostZombieEnd");
	self.infected = 0;
	if(param_00)
	{
		thread playercureignore();
	}

	level notify("player_cured",self);
	self stopshellshock();
	hostzombieupdateoutline();
}

//Function Number: 61
playercureignore()
{
	self notify("playerCureIgnore");
	self endon("playerCureIgnore");
	self endon("disconnect");
	var_00 = 5;
	if(level.players.size == 1)
	{
		var_00 = 8;
	}

	thread maps\mp\zombies\killstreaks\_zombie_camouflage::playercamouflagemode(var_00);
}

//Function Number: 62
spawnplayerhostzombie(param_00)
{
	var_01 = spawnstruct();
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	playfx(common_scripts\utility::getfx("gib_full_body"),var_01.origin,(1,0,0));
	wait 0.05;
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00.characterindex)
	{
		case 0:
			var_02 = "security_host";
			var_03 = "zombie_eye_host_security";
			break;

		case 1:
			var_02 = "exec_host";
			var_03 = "zombie_eye_host_exec";
			break;

		case 2:
			var_02 = "it_host";
			var_03 = "zombie_eye_host_it";
			break;

		case 3:
		default:
			if(maps\mp\zombies\_util::getzombieslevelnum() < 3)
			{
				var_02 = "janitor_host";
				var_03 = "zombie_eye_host_janitor";
			}
			else
			{
				var_02 = "pilot_host";
				var_03 = "zombie_eye_host_pilot";
			}
			break;
	}

	var_04 = maps\mp\zombies\_zombies::spawnzombie("zombie_host",var_01,var_03);
	var_04.hastraversed = 1;
	var_04 thread maps\mp\zombies\_util::setcharactermodel(var_02,1);
	var_05 = 4;
	var_04.maxhealth = var_04.maxhealth * var_05;
	var_04.health = var_04.health * var_05;
	maps\mp\zombies\_zombies_audio_announcer::announcerhostturndialog();
}

//Function Number: 63
hostzombieheartbeat(param_00)
{
	var_01 = [];
	var_01[var_01.size] = "zmb_infected_low";
	var_01[var_01.size] = "zmb_infected_med";
	var_01[var_01.size] = "zmb_infected_high";
	if(!var_01.size)
	{
		return;
	}

	var_02 = 0;
	while(isdefined(var_02) && var_02 < var_01.size)
	{
		var_03 = hostzobieheartbeatgetent();
		var_03 playsoundonmovingent(var_01[var_02]);
		var_03 scalevolume(1);
		var_03.inuse = 1;
		var_02 = hostzombieheartbeatnextstage(var_02,var_01.size,param_00);
		var_04 = 0.5;
		if(!isdefined(var_02))
		{
			var_04 = 0;
		}

		var_03 thread hostzombieheartbeatstop(var_04);
	}
}

//Function Number: 64
hostzobieheartbeatgetent()
{
	var_00 = undefined;
	var_01 = getentarray("infected_heart_beat","targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.inuse) || !var_03.inuse)
		{
			var_00 = var_03;
			if(!isdefined(var_03.owner) || var_03.owner == self)
			{
				break;
			}
		}
	}

	if(!isdefined(var_00))
	{
		var_00 = spawn("script_model",(0,0,0));
		var_00.targetname = "infected_heart_beat";
	}

	var_00.owner = self;
	var_00 hide();
	var_00 showtoplayer(self);
	return var_00;
}

//Function Number: 65
hostzombieheartbeatnextstage(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("bleedout");
	self endon("cured");
	for(;;)
	{
		var_03 = self.infectedendtime - gettime() / 1000;
		var_04 = int(1 - var_03 / param_02 * param_01);
		if(var_04 != param_00)
		{
			return var_04;
		}

		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		wait 0.05;
	}
}

//Function Number: 66
hostzombieheartbeatstop(param_00)
{
	if(isdefined(param_00) && param_00 > 0)
	{
		self scalevolume(0,0.5);
		wait(param_00);
	}

	self stopsounds();
	self.inuse = 0;
}

//Function Number: 67
hostzombiecuredsound()
{
	self endon("death");
	self endon("bleedout");
	self endon("disconnect");
	self waittill("cured");
	self playlocalsound("zmb_infected_cured");
}

//Function Number: 68
hostzombiehud(param_00)
{
	thread hostzombiehudvisionset(param_00);
	self shellshock("zm_infected_start",2);
	thread hostzombiehudfadetoblack(param_00);
	thread hostzombiehudcountdown(param_00);
	thread hostzombiehudcountdownhostmigration();
}

//Function Number: 69
hostzombiehudvisionset(param_00)
{
	self endon("disconnect");
	if(maps\mp\zombies\_util::iszombieshardmode() && isdefined(level.zombiehardmodeinfectedvisionset))
	{
		self.hostvisionset = level.zombiehardmodeinfectedvisionset;
		self visionsetpostapplyforplayer(level.zombiehardmodeinfectedvisionset,0.5);
	}
	else if(isdefined(level.zombieinfectedvisionset))
	{
		self.hostvisionset = level.zombieinfectedvisionset;
		self visionsetpostapplyforplayer(level.zombieinfectedvisionset,0.5);
		thread hostzombievisionset2(param_00 / 2);
	}

	if(isdefined(level.zombieinfectedlightset))
	{
		self lightsetoverrideenableforplayer(level.zombieinfectedlightset);
	}

	self clientaddsoundsubmix("infected");
	hostzombiehudvisionsetwait(param_00);
	self clientclearsoundsubmix("infected");
	var_01 = "";
	var_02 = 0;
	if(maps\mp\zombies\_util::iszombieshardmode() && isdefined(level.zombiehardmodevisionset))
	{
		var_01 = level.zombiehardmodevisionset;
		var_02 = 0.5;
	}

	if(isdefined(level.zombieinfectedvisionset))
	{
		self visionsetpostapplyforplayer(var_01,var_02);
	}

	if(isdefined(level.zombieinfectedlightset))
	{
		self lightsetoverrideenableforplayer();
	}
}

//Function Number: 70
hostzombiehudvisionsetwait(param_00)
{
	self endon("death");
	self endon("bleedout");
	self endon("cured");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
}

//Function Number: 71
hostzombievisionset2(param_00)
{
	self endon("death");
	self endon("bleedout");
	self endon("cured");
	self endon("disconnect");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	if(isdefined(level.zombieinfectedvisionset2))
	{
		self.hostvisionset = level.zombieinfectedvisionset2;
		self visionsetpostapplyforplayer(level.zombieinfectedvisionset2,0.5);
	}
}

//Function Number: 72
hostzombiehudfadetoblack(param_00)
{
	self endon("disconnect");
	self endon("bleedout");
	self endon("cured");
	if(isdefined(self.isexotacticalarmoractive) && self.isexotacticalarmoractive)
	{
		var_01 = self.infectedendtime - gettime() * 0.001 - 60;
		wait(var_01);
	}

	var_02 = 0;
	var_03 = 0.85;
	var_04 = hostzombiehudfullscreen("black");
	var_04.sort = 1;
	var_04 thread hostzombiehudcleanup(self);
	for(;;)
	{
		var_05 = self.infectedendtime - gettime() / 1000;
		if(var_05 <= 0)
		{
			return;
		}

		var_06 = 1 - var_05 / param_00;
		var_06 = clamp(var_06,0,1);
		var_04.alpha = var_02 + var_03 - var_02 * var_06;
		var_04 fadeovertime(var_05);
		var_04.alpha = var_03;
		self waittill("infectedEntTimeUpdate");
	}
}

//Function Number: 73
hostzombiehudcountdown(param_00)
{
	self endon("disconnect");
	self endon("bleedout");
	self endon("cured");
	var_01 = "ui_zm_character_" + self.characterindex + "_infected_endtime";
	setomnvar(var_01,self.infectedendtime);
	thread hostzombieomnvarcleanup();
	for(;;)
	{
		var_02 = self.infectedendtime - gettime() / 1000;
		var_02 = max(var_02,0.1);
		self waittill("infectedEntTimeUpdate",var_03);
		setomnvar(var_01,self.infectedendtime);
	}
}

//Function Number: 74
hostzombiehudcountdownhostmigration()
{
	self endon("disconnect");
	self endon("bleedout");
	self endon("cured");
	for(;;)
	{
		level waittill("host_migration_begin");
		var_00 = "ui_zm_character_" + self.characterindex + "_infected_endtime";
		setomnvar(var_00,0);
		var_01 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		self clientaddsoundsubmix("infected");
		if(isdefined(self.hostvisionset))
		{
			self visionsetpostapplyforplayer(self.hostvisionset,0);
		}

		if(isdefined(level.zombieinfectedlightset))
		{
			self lightsetoverrideenableforplayer(level.zombieinfectedlightset);
		}

		self.infectedendtime = self.infectedendtime + var_01;
		self notify("infectedEntTimeUpdate",var_01);
	}
}

//Function Number: 75
hostzombieomnvarcleanup()
{
	self endon("disconnect");
	var_00 = common_scripts\utility::waittill_any_return("cured","death","becameSpectator");
	var_01 = "ui_zm_character_" + self.characterindex + "_infected_endtime";
	setomnvar(var_01,0);
	if(isdefined(var_00) && var_00 != "cured")
	{
		var_01 = "ui_zm_character_" + self.characterindex + "_alive";
		setomnvar(var_01,0);
	}
}

//Function Number: 76
hostzombiehudcleanup(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 common_scripts\utility::waittill_any("cured","death","becameSpectator");
	self destroy();
}

//Function Number: 77
hostzombiehudfullscreen(param_00)
{
	var_01 = newclienthudelem(self);
	var_01.x = 0;
	var_01.y = 0;
	var_01 setshader(param_00,640,480);
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	return var_01;
}